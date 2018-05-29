#
#  Copyright (c) 2018 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# 
# Author  : Jeong Han Lee
# email   : han.lee@esss.se
# Date    : Tuesday, May 29 17:12:06 CEST 2018
# version : 0.0.1
#

where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include $(E3_REQUIRE_TOOLS)/driver.makefile

ifneq ($(strip $(ASYN_DEP_VERSION)),)
asyn_VERSION=$(ASYN_DEP_VERSION)
endif

ifneq ($(strip $(ADCORE_DEP_VERSION)),)
ADCore_VERSION=$(ADCORE_DEP_VERSION)
endif


# Exclude linux-ppc64e6500
EXCLUDE_ARCHS = linux-ppc64e6500


APP:=SIS8300App
APPDB:=$(APP)/Db
APPSRC:=$(APP)/src


TEMPLATES += $(APPDB)/SIS8300.template
TEMPLATES += $(APPDB)/SIS8300N.template


USR_INCLUDES += -I$(where_am_I)$(APPSRC)


HEADERS += $(APPSRC)/SIS8300.h
SOURCES += $(APPSRC)/SIS8300.cpp
DBDS    += $(APPSRC)/SIS8300Support.dbd


USR_LIBS += udev
USR_LIBS += rt


SIS8300VENDOR_SRC:=vendor/ess
SIS8300DRV:=$(SIS8300VENDOR_SRC)/lib

USR_INCLUDES += -I$(where_am_I)$(SIS8300DRV)

HEADERS += $(SIS8300DRV)/sis8300drv.h
HEADERS += $(SIS8300DRV)/sis8300_defs.h
HEADERS += $(SIS8300DRV)/sis8300_reg.h
HEADERS += $(SIS8300DRV)/sis8300drv_utils.h
HEADERS += $(SIS8300DRV)/sis8300drv_list.h


SOURCES += $(SIS8300DRV)/sis8300drv.c
SOURCES += $(SIS8300DRV)/sis8300drv_ad9510.c
SOURCES += $(SIS8300DRV)/sis8300drv_flash.c
SOURCES += $(SIS8300DRV)/sis8300drv_rtm.c
SOURCES += $(SIS8300DRV)/sis8300drv_utils.c



BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/sis8300drv_acq
BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/sis8300drv_flashfw
BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/sis8300drv_i2c_rtm
BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/sis8300drv_irq
BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/sis8300drv_mem
BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/sis8300drv_mmap
BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/sis8300drv_out
BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/sis8300drv_perf
BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/sis8300drv_reg
BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/sis8300drv_rem
BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/sis8300drv_speed
BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/sis8300drv_i2c_temp
BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/tools/utils/sis8300_rescan
BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/tools/utils/sis8300_remove
BINS += $(where_am_I)$(SIS8300VENDOR_SRC)/tools/utils/sis8300_reload

## This RULE should be used in case of inflating DB files 
## db rule is the default in RULES_DB, so add the empty one
## Please look at e3-mrfioc2 for example.

db: 


.PHONY: db 
