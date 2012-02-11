#!/bin/sh

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

DEVICE=msm8660_surf
COMMON=c1-common
MANUFACTURER=qcom
DIR_DEVICE=../../../vendor/$MANUFACTURER/$DEVICE
DIR_COMMON=../../../vendor/$MANUFACTURER/$COMMON

mkdir -p $DIR_DEVICE/proprietary
mkdir -p $DIR_COMMON/proprietary
mkdir -p $DIR_COMMON/proprietary/audio
mkdir -p $DIR_COMMON/proprietary/cameradata
mkdir -p $DIR_COMMON/proprietary/egl
mkdir -p $DIR_COMMON/proprietary/firmware
mkdir -p $DIR_COMMON/proprietary/hw
mkdir -p $DIR_COMMON/proprietary/keychars
mkdir -p $DIR_COMMON/proprietary/wifi

# galaxys2


# c1-common
echo $DIR_COMMON/proprietary/libdiag.so
adb pull /system/lib/libdiag.so $DIR_COMMON/proprietary/libdiag.so
adb pull /system/lib/libaudio.so $DIR_COMMON/proprietary/audio/libaudio.so
adb pull /system/lib/libaudioalsa.so $DIR_COMMON/proprietary/audio/libaudioalsa.so
adb pull /system/lib/libaudioparsers.so $DIR_COMMON/proprietary/audio/libaudioparsers.so
adb pull /system/lib/libaudiopolicy.so $DIR_COMMON/proprietary/audio/libaudiopolicy.so
adb pull /system/lib/libacdbloader.so $DIR_COMMON/proprietary/libacdbloader.so
adb pull /system/lib/libacdbmapper.so $DIR_COMMON/proprietary/libacdbmapper.so
adb pull /system/lib/lib_iec_60958_61937.so $DIR_COMMON/proprietary/lib_iec_60958_61937.so
adb pull /system/lib/libcommondefs.so $DIR_COMMON/proprietary/libcommondefs.so
adb pull /system/lib/libaudcal.so $DIR_COMMON/proprietary
adb pull /system/lib/liba2dp.so $DIR_COMMON/proprietary
adb pull /system/lib/libsamsungSoundbooster.so $DIR_COMMON/proprietary
adb pull /system/lib/libsamsungSoundboosterLPA.so $DIR_COMMON/proprietary
adb pull /system/lib/lib_Samsung_SB_AM_Handset_LPA.so $DIR_COMMON/proprietary
adb pull /system/lib/libmvsechocanceler.so $DIR_COMMON/proprietary
adb pull /system/lib/lib_Samsung_Resampler.so $DIR_COMMON/proprietary

echo "Writing: $DIR_DEVICE/$DEVICE-vendor-blobs.mk"
(cat << EOF) | sed s/__DEVICE__/$DEVICE/g | sed s/__MANUFACTURER__/$MANUFACTURER/g > $DIR_DEVICE/$DEVICE-vendor-blobs.mk
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

# Prebuilt libraries that are needed to build open-source libraries
PRODUCT_COPY_FILES := \\

# All the blobs necessary for galaxys2 devices
PRODUCT_COPY_FILES += \\

EOF


echo "Writing: $DIR_COMMON/c1-vendor-blobs.mk"
(cat << EOF) | sed s/__COMMON__/$COMMON/g | sed s/__MANUFACTURER__/$MANUFACTURER/g > $DIR_COMMON/c1-vendor-blobs.mk
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

# Prebuilt libraries that are needed to build open-source libraries
PRODUCT_COPY_FILES := \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libdiag.so:obj/lib/libdiag.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/audio/libaudio.so:obj/lib/libaudio.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/audio/libaudioalsa.so:obj/lib/libaudioalsa.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/audio/libaudioparsers.so:obj/lib/libaudioparsers.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/audio/libaudiopolicy.so:obj/lib/libaudiopolicy.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libacdbloader.so:obj/lib/libacdbloader.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libacdbmapper.so:obj/lib/libacdbmapper.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/lib_iec_60958_61937.so:obj/lib/lib_iec_60958_61937.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libcommondefs.so:obj/lib/libcommondefs.so \\

# All the blobs necessary for galaxys2 devices
PRODUCT_COPY_FILES += \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libdiag.so:system/lib/libdiag.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/audio/libaudio.so:system/lib/libaudio.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/audio/libaudioalsa.so:system/lib/libaudioalsa.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/audio/libaudioparsers.so:system/lib/libaudioparsers.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/audio/libaudiopolicy.so:system/lib/libaudiopolicy.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libacdbloader.so:system/lib/libacdbloader.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libacdbmapper.so:system/lib/libacdbmapper.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/lib_iec_60958_61937.so:system/lib/lib_iec_60958_61937.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libcommondefs.so:system/lib/libcommondefs.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libaudcal.so:system/lib/libaudcal.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/liba2dp.so:system/lib/liba2dp.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libsamsungSoundbooster.so:system/lib/libsamsungSoundbooster.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libsamsungSoundboosterLPA.so:system/lib/libsamsungSoundboosterLPA.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/lib_Samsung_SB_AM_Handset_LPA.so:system/lib/lib_Samsung_SB_AM_Handset_LPA.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libmvsechocanceler.so:system/lib/libmvsechocanceler.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/lib_Samsung_Resampler.so:system/lib/lib_Samsung_Resampler.so \\

EOF

./setup-makefiles.sh
