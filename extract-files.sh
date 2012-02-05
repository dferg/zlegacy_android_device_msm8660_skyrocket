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
adb pull /system/lib/libdiag.so $DIR_COMMON/proprietary/libdiag.so

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

# All the blobs necessary for galaxys2 devices
PRODUCT_COPY_FILES += \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libdiag.so:system/lib/libdiag.so \\

EOF

./setup-makefiles.sh
