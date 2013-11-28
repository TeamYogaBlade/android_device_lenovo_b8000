## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := b8000

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/lenovo/b8000/device_b8000.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := b8000
PRODUCT_NAME := cm_b8000
PRODUCT_BRAND := lenovo
PRODUCT_MODEL := b8000
PRODUCT_MANUFACTURER := lenovo
