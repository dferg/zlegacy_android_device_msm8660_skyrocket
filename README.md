What the heck is this?
----------------------
This repository is an attempt to collaboratively build up an Android device tree for the AT&T Samsung Galaxy S II Skyrocket.

It is derived from the Code Aurora project's msm8660_surf device tree.  See: https://www.codeaurora.org/xwiki/bin/QAEP

Use the gingerbread_house branch with the M8260AAABQNLZA307007.xml manifest.

Discussion is on XDA in this thread: http://forum.xda-developers.com/showthread.php?t=1484408

Instructions for use
--------------------
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


Building
--------
At the suggestion of romracer on XDA, we are using the msm8660_defconfig.  Use these commands to build:
<pre>
choosecombo 1 2 msm8660_surf eng
make -j4 KERNEL_DEFCONFIG=msm8660_defconfig
</pre>
