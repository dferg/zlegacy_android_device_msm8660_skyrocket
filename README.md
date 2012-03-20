What the heck is this?
----------------------
This repository is an attempt to collaboratively build up an Android device tree for the AT&T Samsung Galaxy S II Skyrocket.

It is derived from the Code Aurora project's msm8660_surf device tree.  See: https://www.codeaurora.org/xwiki/bin/QAEP

Use the gingerbread_house branch with the M8260AAABQNLZA307007.xml manifest.

Discussion is on XDA in this thread: http://forum.xda-developers.com/showthread.php?t=1484408

Instructions for use
--------------------
Set up your environment according to Google's instructions here:
http://source.android.com/source/initializing.html

Check out the Code Aurora repo.  I used the following command:
<pre>
mkdir android-skyrocket
cd android-skyrocket
repo init -u  git://codeaurora.org/platform/manifest.git -b gingerbread_house -m M8260AAABQNLZA307007.xml --repo-url=git://codeaurora.org/tools/repo.git
</pre>

Then remove (don't just rename! It'll break the build) the device/qcom/msm8660_surf directory.
<pre>
rm -rf device/qcom/msm8660_surf
</pre>

Then check out this repository in place of the msm8660_surf directory.
<pre>
git clone git://github.com/dferg/android_device_msm8660_skyrocket.git device/qcom/msm8660_surf
</pre>


Building without proprietary blobs
----------------------------------
This results in a build that boots but most hardware does not work.  (Jerky
framebuffer, no wifi, no cel, no gps, no bluetooth, no sound, etc..)

At the suggestion of romracer on XDA, we are using the msm8660_defconfig.  Use these commands to build:
<pre>
source build/envsetup.sh
choosecombo 1 2 msm8660_surf eng
make -j4 KERNEL_DEFCONFIG=msm8660_defconfig
</pre>

Install the resulting zip to your Skyrocket using CWM. Then, install Da_G's 0.41 kernel.

Building with proprietary blobs
-------------------------------
This build does not complete without other hacks to the tree.  The apply_patches.sh script will perform the necessary patches.

Use these commands to build:
<pre>
cd device/qcom/msm8660_surf
./extract-files.pl
./apply_patches.sh
cd ../../..
source build/envsetup.sh
QC_PROP=true choosecombo 1 2 msm8660_surf eng
QC_PROP=true make -j4 KERNEL_DEFCONFIG=msm8660_defconfig
</pre>

Install the resulting zip to your Skyrocket using CWM. Then, install Da_G's 0.41 kernel.

