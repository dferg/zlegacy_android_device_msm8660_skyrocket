#!/usr/bin/perl

# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Perl libraries
use File::Path     qw(make_path);
use File::Basename qw(dirname basename);
use Data::Dumper;

# Variable setup
$cfgfile                                   = "extract-files.cfg";
@required_variables                        = qw/DEVICE COMMON MANUFACTURER/;
@default_variables = (
  {DIR_COMMON              => "../../../vendor/\$MANUFACTURER/\$COMMON/proprietary"},
  {DEVICE_VENDOR_BLOBS_MK  => "../../../vendor/\$MANUFACTURER/\$DEVICE/\$DEVICE-vendor-blobs.mk"},
  {C1_VENDOR_BLOBS_MK      => "../../../vendor/\$MANUFACTURER/\$COMMON/c1-vendor-blobs.mk"},
  {ADB_BIN                 => "adb"},
);
$copyright_notice = <<EOF;
# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

EOF

# Read the config and verify defined variables
&read_config($cfgfile);
&verify_variables(\@required_variables, \@default_variables);

print "\nFiles needed for the open source build:\n";
foreach(@files_needed_for_build) {
	print "  $_\n";
};

print "\nFiles to extract and copy to final zip:\n";
foreach(@source_files) {
	print "  $_\n";
};

# Get all the files from the phone
print "\nExtracting files from device...\n";
foreach (@source_files) {
	# Build up the file name and directory
	$dest_file = "$variables{DIR_COMMON}$_";
	$dest_dir  = dirname($dest_file);

	# Create the parent directory
	if (!-e $dest_dir) {
		$num = make_path($dest_dir);
		if ($num eq 0) {
			print STDERR "Could not create directory '$dest_dir'\n";
			exit 1;
		}
	}

	# Execute the command
	$cmd = "$variables{ADB_BIN} pull $_ $variables{DIR_COMMON}$_";
	print "\n$cmd\n";
	$rc = system($cmd);
	if ($rc & 127) {
		print STDERR "Aborted.\n";
		exit 1;
	}
	$rc = $rc >> 8;
	if ($rc) {
		print STDERR "Command failed: '$cmd'\n";
		exit 1;
	}
}

# Create the device vendor blobs mk fragment
print "\nCreating make fragment: $variables{DEVICE_VENDOR_BLOBS_MK}\n";
open FOUT, ">$variables{DEVICE_VENDOR_BLOBS_MK}" or die "Can't open $variables{DEVICE_VENDOR_BLOBS_MK} for writing.";
print FOUT $copyright_notice;
print FOUT <<EOF;
# Prebuilt libraries that are needed to build open-source libraries
PRODUCT_COPY_FILES := \\

# All the blobs necessary for msm8660 devices
PRODUCT_COPY_FILES += \\

EOF
close FOUT;

# Create the common vendor blobs mk fragment
print "Creating make fragment: $variables{C1_VENDOR_BLOBS_MK}\n";
open FOUT, ">$variables{C1_VENDOR_BLOBS_MK}" or die "Can't open $variables{C1_VENDOR_BLOBS_MK} for writing.";
print FOUT $copyright_notice;
print FOUT <<EOF;
# Prebuilt libraries that are needed to build the open source libraries
PRODUCT_COPY_FILES := \\
EOF

# Print the copies needed to build the open source libraries
foreach(@files_needed_for_build) {
	$basename = basename($_);
	print FOUT "	vendor/$variables{MANUFACTURER}/$variables{COMMON}/proprietary$_:obj/lib/$basename \\\n";
}

# Print the copies needed for the blobs
print FOUT <<EOF;

# All the blobs necessary for msm8660 device
PRODUCT_COPY_FILES += \\
EOF

foreach(@source_files) {
	# Build up the file name and directory
	$source_path = "vendor/$variables{MANUFACTURER}/$variables{COMMON}/proprietary$_";
	$dest_path   = $_;
	$dest_path   =~ s/^\///;
	print FOUT "	$source_path:$dest_path \\\n";
}
print FOUT "\n";
close FOUT;

#system("./setup-makefiles.sh");

sub trim_whitespace {
	my($s) = @_;
	$s =~ s/^\s+//;
	$s =~ s/\s+$//;
	return $s;
}

sub dereference_string {
	my($string) = @_;
	while( $string =~ /\$([\w\d_]+)/ ) {
		$varname = $1;
		if (not exists $variables{$varname}) {
			print STDERR "ERROR: Variable \$$varname is not defined on line $lineno\n";
			exit 1;
		}
		$string =~ s/\$$varname/$variables{$varname}/;
	}
	return $string;
}

sub read_config {
	my($cfgfile) = @_;
	open FIN, $cfgfile or die "Can't open $cfgfile for reading";
	while(<FIN>) {
		$lineno++;
		chomp;               # remove newlines
		s/#.*//;             # remove comments
		next if ( /^\s*$/ ); # skip blank lines
		if ( /^(.*)=(.*)$/ ) {
			my $varname = &trim_whitespace($1);
			my $value   = &trim_whitespace($2);
			$value =~ s/^["']//; $value =~ s/["']$//;  # remove quotes
			$variables{$varname} = &dereference_string($value);
		} else {
			my @fields = split /:/, $_;
			push(@source_files, $fields[0]);
			if ( $fields[1] eq "requiredForBuild" ) {
				push(@files_needed_for_build, $fields[0]);
			}
		}
	}
	close FIN;
}

sub verify_variables {
	my($required_variables, $default_variables) = @_;

	foreach(@$required_variables) {
		if (not exists $variables{$_}) {
			print STDERR "ERROR: The required variable $_ was not specified in the config file.\n";
			exit 1;
		}
	}

	foreach(@$default_variables) {
		my($name) = keys %$_;
		if (not exists $variables{$name}) {
			$variables{$name} = &dereference_string($_->{$name});
		}
	}
}

