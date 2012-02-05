$(call inherit-product, device/qcom/common/common.mk)
$(call inherit-product-if-exists, vendor/qcom/proprietary/tools/google/gingerbread/products/gms.mk)

PRODUCT_NAME := msm8660_surf
PRODUCT_DEVICE := msm8660_surf

PRODUCT_PROPERTY_OVERRIDES += \
 ro.com.google.clientidbase=android-qualcomm

# See comment at the top of this file. This is where the other
# half of the device-specific product definition file takes care
# of the aspects that require proprietary drivers that aren't
# commonly available
$(call inherit-product-if-exists, vendor/qcom/msm8660_surf/msm8660_surf-vendor.mk)

