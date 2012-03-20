#!/bin/bash

reverse_merge_arg="-N"

for arg in "$@"
do
	if [ "$arg" = "-R" ]
	then
		reverse_merge_arg="-R"
	fi
done

for file in `dir -d patches/*`; do
	echo "**"
	echo "** ****** Applying patch: patches/$file *******"
	echo "**"
	patch -d $ANDROID_BUILD_TOP -i $PWD/$file -p0 $reverse_merge_arg -r -
	echo ""
	echo ""
	echo ""
done

