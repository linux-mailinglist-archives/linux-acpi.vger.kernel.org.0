Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C152747CC23
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Dec 2021 05:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242425AbhLVEcd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Dec 2021 23:32:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:2229 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242405AbhLVEcQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Dec 2021 23:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640147536; x=1671683536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nH1ITATxuXQ6bn3ewDOSl618RQTiT2dXec6sw7E3k/4=;
  b=L/NIRsyUcUIaDpljCW+VH1QuD0EqC+pJinM9t115oW4TSoZlyOsvcrqe
   IEVd9/0r8HmKffuGeC90pzrWdc6AivT2HuUaCkIkCeaLlPlVFGZuUm0wm
   aPMsp3X1PzmOsw6RMITtraV9ccVDKP6uUnhi4J64onSqnHOIPcjYcuyvd
   ibG2WO/nPek1LX7kCEvgDKq43cVEnIhO4JMOVCWCz6LVnjdYLjgER0Ea1
   e3dpnCHGFn/neYbEaVrYaTNSVcEaUOgdquy3CIGS3LmyZu/7avVg1JZFA
   6qT3OzlbDbNn1Llojzb2WGPHMpb48QNHJL3HpckxgGifJU0VPWnrH2JF4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240768247"
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="240768247"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 20:32:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="617004895"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.186])
  by orsmga004.jf.intel.com with ESMTP; 21 Dec 2021 20:32:11 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        Hongyu Ning <hongyu.ning@intel.com>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v13 2/4] drivers/acpi: Introduce Platform Firmware Runtime Update device driver
Date:   Wed, 22 Dec 2021 12:31:41 +0800
Message-Id: <11fcad31b0589b35754f4a33ab16a9c07f417d70.1640007183.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1640007183.git.yu.c.chen@intel.com>
References: <cover.1640007183.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Introduce the pfr_update driver which can be used for Platform Firmware
Runtime code injection and driver update [1]. The user is expected to
provide the EFI capsule, and pass it to the driver by writing the capsule
to a device special file. The capsule is transferred by the driver to the
platform firmware with the help of an ACPI _DSM method under the special
ACPI Platform Firmware Runtime Update device (INTC1080), and the actual
firmware update is carried out by the low-level Management Mode code in
the platform firmware.

This patch allows certain pieces of the platform firmware to be
updated on the fly while the system is running (runtime) without the
need to restart it, which is key in the cases when the system needs to
be available 100% of the time and it cannot afford the downtime related
to restarting it, or when the work carried out by the system is
particularly important, so it cannot be interrupted, and it is not
practical to wait until it is complete.

Link: https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf # [1]
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Tested-by: Hongyu Ning <hongyu.ning@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v13:Print the _DSM failure result if invalid EFI capsule is provided.
    (Hongyu Ning)
v12:Rename the driver from pfru_update to pfr_update, and the
    telemetry parr to pfr_telementry for symmetry.
    (Rafael J. Wysocki)
    Rename the "capsule file" to "EFI capsule".
    (Rafael J. Wysocki)
    Revise the commit log. (Rafael J. Wysocki)
    Add the reason in the commit log that explains why it is
    a good idea to add this driver to the kernel.
    (Rafael J. Wysocki)
    Rename pfru.h to pfrut.h (Rafael J. Wysocki)
    Rename the CONFIG_ACPI_PFRU to CONFIG_ACPI_PFRUT
    (Rafael J. Wysocki)
    Rename the Kconfig name to "ACPI Platform Firmware Runtime
    Update and Telemetry"
    (Rafael J. Wysocki)
    Revise the Kconfig help message (Rafael J. Wysocki)
    Describe what the driver is for briefly in the beginning of
    the source code file.
    (Rafael J. Wysocki)
    Ddd a comment pointing to the definitions of the GUIDs and
    explain briefly what they are for.
    (Rafael J. Wysocki)
    Reduce redundant memory updates by doing all of the checks
    upfront. (Rafael J. Wysocki)
    Rename valid_version() to applicable_image(), and revise the
    comment.(Rafael J. Wysocki)
    Remove Redundant else in applicable_image().(Rafael J. Wysocki)
    Rename dump_update_result() to print_ipdate_debug_info().
    (Rafael J. Wysocki)
    Rename start_acpi_update() to start_update()(Rafael J. Wysocki)
    Add a blank line before each "case xxx:"(Rafael J. Wysocki)
    Move status check into query_capability() and returns -EBUSY if
    fails(Rafael J. Wysocki)
    Rename the device node name from "acpi_pfru%d" to "acpi_pfr_update%d"
    (Rafael J. Wysocki)
    Rename the drive name from "pfru_update" to "pfr_update"
    (Rafael J. Wysocki)
    Rename PFRU_MAGIC_FOR_IOCTL to PFRUT_IOCTL_MAGIC(Rafael J. Wysocki)
    Fix grammar errors in the comments.(Rafael J. Wysocki)
v11:Revise the comment to explain why version check is introduced
    in kernel rather than letting Management Mode to do it.
    (Rafael J. Wysocki)
v10:Remove the explicit assignment of the last item of enum.
    (Andy Shevchenko)
v9: Use GUID_INIT() instead of guid_parse() during boot up.
    (Andy Shevchenko)
    Drop uuid, code_uuid, drv_uuid in struct pfru_device as they
    are not needed. (Andy Shevchenko)
    Drop type casting from void * in valid_version().
    (Andy Shevchenko)
    Use kfree() instead of ACPI_FREE() in non-ACPICA usage.
    (Andy Shevchenko)
    Use sizeof(rev) instead of sizeof(u32) in copy_from_user().
    (Andy Shevchenko)
    Generate physical address from MSB part to LSB.
    (Andy Shevchenko)
    Use devm_add_action_or_reset() to add ida release into dev resource
    management. (Andy Shevchenko)
    Use devm_kasprintf() instead of kasprintf() to format the
    pfru_dev name.(Andy Shevchenko)
    Remove redundant 0 in acpi_pfru_ids. (Andy Shevchenko)
    Adjust the order of included headers in pfru.h.
    (Andy Shevchenko)
    Replace PFRU_MAGIC with PFRU_MAGIC_FOR_IOCTL in uapi file.
    (Andy Shevchenko)
v8: Remove the variable-length array in struct pfru_update_cap_info, and
    copy the non-variable-length struct pfru_update_cap_info to userspace
    directly. (Greg Kroah-Hartman)
    Change the type of rev_id from int to u32, because this data will
    be copied between kernel and userspace. (Greg Kroah-Hartman)
    Add a prefix for dev in struct pfru_device to parent_dev, so as
    to indicate that this filed is the parent of the created miscdev.
    (Greg Kroah-Hartman)
    Use blank lines between different macro sections. (Greg Kroah-Hartman)
    Illusatrate the possible errno for each ioctl interface.
    (Greg Kroah-Hartman)
    Remove pfru_valid_revid() from uapi header to avoid poluting the global
    namespace.(Greg Kroah-Hartman)
    Assign the value to the enum type explicitly.(Greg Kroah-Hartman)
    Change the guid_t to efi_guid_t when parsing image header in get_image_type()
    (Greg Kroah-Hartman)
    Remove the void * to other type casting in valid_version(). (Andy Shevchenko)
    Combined the assignment of variables with definitions. (Andy Shevchenko)
    Define this magic for revision ID. (Andy Shevchenko)
    Make the labeling consistent for error handling. (Andy Shevchenko)
    Replace the UUID_SIZE in uapi with 16 directly. (Andy Shevchenko)
    Add blank line between generic include header and uapi header.
    (Andy Shevchenko)
    Arrange the order between devm_kzalloc() and normal allocation in
    acpi_pfru_probe() that, the former should always be ahead of the
    latter. (Andy Shevchenko)
    Move the UUID from uapi header to the c file. (Andy Shevchenko)
v7: Use ida_alloc() to allocate a ID, and release the ID when
    device is removed. (Greg Kroah-Hartman)
    Check the _DSM method at early stage, before allocate or parse
    anything in acpi_pfru_probe(). (Greg Kroah-Hartman)
    Set the parent of the misc device. (Greg Kroah-Hartman)
    Use module_platform_driver() instead of platform_driver_register()
    in module_init(). Separate pfru driver and pfru_telemetry driver
    to two files. (Greg Kroah-Hartman) 
v6: Use Link: tag to add the specification download address.
    (Andy Shevchenko)
    Remove linux/uuid.h and use raw buffers to contain uuid.
    (Andy Shevchenko)
    Drop comma for each terminator entry in the enum structure.
    (Andy Shevchenko)
    Remove redundant 'else' in get_image_type().
    (Andy Shevchenko)
    Directly return results from the switch cases in adjust_efi_size()
    and pfru_ioctl().(Andy Shevchenko)
    Keep comment style consistent by removing the period for
    one line comment.
    (Andy Shevchenko)
    Remove devm_kfree() if .probe() failed. 
    (Andy Shevchenko)
v5: Remove Documentation/ABI/pfru, and move the content to kernel doc
    in include/uapi/linux/pfru.h (Greg Kroah-Hartman)
    Shrink the range of ioctl numbers declared in
    Documentation/userspace-api/ioctl/ioctl-number.rst
    from 16 to 8. (Greg Kroah-Hartman)
    Change global variable struct pfru_device *pfru_dev to
    per ACPI device. (Greg Kroah-Hartman)
    Unregister the misc device in acpi_pfru_remove().
    (Greg Kroah-Hartman)
    Convert the kzalloc() to devm_kzalloc() in the driver so
    as to avoid freeing the memory. (Greg Kroah-Hartman)
    Fix the compile error by declaring the pfru_log_ioctl() as
    static. (kernel test robot LKP)
    Change to global variable misc_device to per ACPI device.
    (Greg Kroah-Hartman)
v4: Replace all pr_err() with dev_dbg() (Greg Kroah-Hartman,
    Rafael J. Wysocki)
    Returns ENOTTY rather than ENOIOCTLCMD if invalid ioctl command
    is provided. (Greg Kroah-Hartman)
    Remove compat ioctl. (Greg Kroah-Hartman)
    Rename /dev/pfru/pfru_update to /dev/acpi_pfru (Greg Kroah-Hartman)
    Simplify the check for element of the package in query_capability()
    (Rafael J. Wysocki)
    Remove the loop in query_capability(), query_buffer() and query
    the package elemenet directly. (Rafael J. Wysocki)
    Check the the number of elements in case the number of package
    elements is too small. (Rafael J. Wysocki)
    Doing the assignment as initialization in get_image_type().
    Meanwhile, returns the type or a negative error code in
    get_image_type(). (Rafael J. Wysocki)
    Put the comments inside the function. (Rafael J. Wysocki)
    Returns the size or a negative error code in adjust_efi_size()
    (Rafael J. Wysocki)
    Fix the return value from EFAULT to EINVAL if pfru_valid_revid()
    does not pass. (Rafael J. Wysocki)
    Change the write() to be the code injection/update, the read() to
    be telemetry retrieval and all of the rest to be ioctl()s under
    one special device file.(Rafael J. Wysocki)
    Putting empty code lines after an if () statement that is not
    followed by a block. (Rafael J. Wysocki)
    Remove "goto" tags to make the code more readable. (Rafael J. Wysocki)
v3: Use __u32 instead of int and __64 instead of unsigned long
    in include/uapi/linux/pfru.h (Greg Kroah-Hartman)
    Rename the structure in uapi to start with a prefix pfru so as
    to avoid confusing in the global namespace. (Greg Kroah-Hartman)
v2: Add sanity check for duplicated instance of ACPI device.
    Update the driver to work with allocated pfru_device objects.
    (Mike Rapoport)
    For each switch case pair, get rid of the magic case numbers
    and add a default clause with the error handling.
    (Mike Rapoport)
    Move the obj->type checks outside the switch to reduce redundancy.
    (Mike Rapoport)
    Parse the code_inj_id and drv_update_id at driver initialization time
    to reduce the re-parsing at runtime.(Mike Rapoport)
    Explain in detail how the size needs to be adjusted when doing
    version check.(Mike Rapoport)
    Rename parse_update_result() to dump_update_result()(Mike Rapoport)
    Remove redundant return.(Mike Rapoport)
    Do not expose struct capsulate_buf_info to uapi, since it is
    not needed in userspace.(Mike Rapoport)
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/acpi/Kconfig                          |  18 +
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/pfr_update.c                     | 575 ++++++++++++++++++
 include/uapi/linux/pfrut.h                    | 174 ++++++
 5 files changed, 769 insertions(+)
 create mode 100644 drivers/acpi/pfr_update.c
 create mode 100644 include/uapi/linux/pfrut.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index cfe6cccf0f44..687efcf245c1 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -367,6 +367,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:aherrman@de.ibm.com>
 0xE5  00-3F  linux/fuse.h
 0xEC  00-01  drivers/platform/chrome/cros_ec_dev.h                   ChromeOS EC driver
+0xEE  00-09  uapi/linux/pfrut.h                                      Platform Firmware Runtime Update and Telemetry
 0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                     sisfb (in development)
                                                                      <mailto:thomas@winischhofer.net>
 0xF6  all                                                            LTTng Linux Trace Toolkit Next Generation
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index cdbdf68bd98f..d0b3ca9d4a97 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -517,6 +517,24 @@ config ACPI_CONFIGFS
 	  userspace. The configurable ACPI groups will be visible under
 	  /config/acpi, assuming configfs is mounted under /config.
 
+config ACPI_PFRUT
+	tristate "ACPI Platform Firmware Runtime Update and Telemetry"
+	depends on 64BIT
+	help
+	  This mechanism allows certain pieces of the platform firmware
+	  to be updated on the fly while the system is running (runtime)
+	  without the need to restart it, which is key in the cases when
+	  the system needs to be available 100% of the time and it cannot
+	  afford the downtime related to restarting it, or when the work
+	  carried out by the system is particularly important, so it cannot
+	  be interrupted, and it is not practical to wait until it is complete.
+
+	  The existing firmware code can be modified (driver update) or
+	  extended by adding new code to the firmware (code injection).
+
+	  To compile this driver as module, choose M here:
+	  the module will be called pfr_update.
+
 if ARM64
 source "drivers/acpi/arm64/Kconfig"
 
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3018714e87d9..2ad2e821cc08 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
+obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
new file mode 100644
index 000000000000..149b5b2530b9
--- /dev/null
+++ b/drivers/acpi/pfr_update.c
@@ -0,0 +1,575 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACPI Platform Firmware Runtime Update Device driver
+ *
+ * Copyright (C) 2021 Intel Corporation
+ * Author: Chen Yu <yu.c.chen@intel.com>
+ *
+ * pfr_update driver is used for Platform Firmware Runtime
+ * Update, which includes the code injection and driver update.
+ */
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/efi.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/idr.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/uio.h>
+#include <linux/uuid.h>
+
+#include <uapi/linux/pfrut.h>
+
+#define PFRU_FUNC_STANDARD_QUERY	0
+#define PFRU_FUNC_QUERY_UPDATE_CAP	1
+#define PFRU_FUNC_QUERY_BUF		2
+#define PFRU_FUNC_START		3
+
+#define PFRU_CODE_INJECT_TYPE	1
+#define PFRU_DRIVER_UPDATE_TYPE	2
+
+#define PFRU_REVID_1		1
+#define PFRU_REVID_2		2
+#define PFRU_DEFAULT_REV_ID	PFRU_REVID_1
+
+enum cap_index {
+	CAP_STATUS_IDX = 0,
+	CAP_UPDATE_IDX = 1,
+	CAP_CODE_TYPE_IDX = 2,
+	CAP_FW_VER_IDX = 3,
+	CAP_CODE_RT_VER_IDX = 4,
+	CAP_DRV_TYPE_IDX = 5,
+	CAP_DRV_RT_VER_IDX = 6,
+	CAP_DRV_SVN_IDX = 7,
+	CAP_PLAT_ID_IDX = 8,
+	CAP_OEM_ID_IDX = 9,
+	CAP_OEM_INFO_IDX = 10,
+	CAP_NR_IDX
+};
+
+enum buf_index {
+	BUF_STATUS_IDX = 0,
+	BUF_EXT_STATUS_IDX = 1,
+	BUF_ADDR_LOW_IDX = 2,
+	BUF_ADDR_HI_IDX = 3,
+	BUF_SIZE_IDX = 4,
+	BUF_NR_IDX
+};
+
+enum update_index {
+	UPDATE_STATUS_IDX = 0,
+	UPDATE_EXT_STATUS_IDX = 1,
+	UPDATE_AUTH_TIME_LOW_IDX = 2,
+	UPDATE_AUTH_TIME_HI_IDX = 3,
+	UPDATE_EXEC_TIME_LOW_IDX = 4,
+	UPDATE_EXEC_TIME_HI_IDX = 5,
+	UPDATE_NR_IDX
+};
+
+enum pfru_start_action {
+	START_STAGE = 0,
+	START_ACTIVATE = 1,
+	START_STAGE_ACTIVATE = 2,
+};
+
+struct pfru_device {
+	u32 rev_id, index;
+	struct device *parent_dev;
+	struct miscdevice miscdev;
+};
+
+static DEFINE_IDA(pfru_ida);
+
+/*
+ * Manual reference:
+ * https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf
+ *
+ * pfru_guid is the parameter for _DSM method
+ */
+static const guid_t pfru_guid =
+	GUID_INIT(0xECF9533B, 0x4A3C, 0x4E89, 0x93, 0x9E, 0xC7, 0x71,
+		  0x12, 0x60, 0x1C, 0x6D);
+
+/* pfru_code_inj_guid is the UUID to identify code injection EFI capsule file */
+static const guid_t pfru_code_inj_guid =
+	GUID_INIT(0xB2F84B79, 0x7B6E, 0x4E45, 0x88, 0x5F, 0x3F, 0xB9,
+		  0xBB, 0x18, 0x54, 0x02);
+
+/* pfru_drv_update_guid is the UUID to identify driver update EFI capsule file */
+static const guid_t pfru_drv_update_guid =
+	GUID_INIT(0x4569DD8C, 0x75F1, 0x429A, 0xA3, 0xD6, 0x24, 0xDE,
+		  0x80, 0x97, 0xA0, 0xDF);
+
+static inline int pfru_valid_revid(u32 id)
+{
+	return id == PFRU_REVID_1 || id == PFRU_REVID_2;
+}
+
+static inline struct pfru_device *to_pfru_dev(struct file *file)
+{
+	return container_of(file->private_data, struct pfru_device, miscdev);
+}
+
+static int query_capability(struct pfru_update_cap_info *cap_hdr,
+			    struct pfru_device *pfru_dev)
+{
+	acpi_handle handle = ACPI_HANDLE(pfru_dev->parent_dev);
+	union acpi_object *out_obj;
+	int ret = -EINVAL;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_guid,
+					  pfru_dev->rev_id,
+					  PFRU_FUNC_QUERY_UPDATE_CAP,
+					  NULL, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return ret;
+
+	if (out_obj->package.count < CAP_NR_IDX ||
+	    out_obj->package.elements[CAP_STATUS_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[CAP_UPDATE_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[CAP_CODE_TYPE_IDX].type != ACPI_TYPE_BUFFER ||
+	    out_obj->package.elements[CAP_FW_VER_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[CAP_CODE_RT_VER_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[CAP_DRV_TYPE_IDX].type != ACPI_TYPE_BUFFER ||
+	    out_obj->package.elements[CAP_DRV_RT_VER_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[CAP_DRV_SVN_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[CAP_PLAT_ID_IDX].type != ACPI_TYPE_BUFFER ||
+	    out_obj->package.elements[CAP_OEM_ID_IDX].type != ACPI_TYPE_BUFFER ||
+	    out_obj->package.elements[CAP_OEM_INFO_IDX].type != ACPI_TYPE_BUFFER)
+		goto free_acpi_buffer;
+
+	cap_hdr->status = out_obj->package.elements[CAP_STATUS_IDX].integer.value;
+	if (cap_hdr->status != DSM_SUCCEED) {
+		ret = -EBUSY;
+		dev_dbg(pfru_dev->parent_dev, "Error Status:%d\n", cap_hdr->status);
+		goto free_acpi_buffer;
+	}
+
+	cap_hdr->update_cap = out_obj->package.elements[CAP_UPDATE_IDX].integer.value;
+	memcpy(&cap_hdr->code_type,
+	       out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.pointer,
+	       out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length);
+	cap_hdr->fw_version =
+		out_obj->package.elements[CAP_FW_VER_IDX].integer.value;
+	cap_hdr->code_rt_version =
+		out_obj->package.elements[CAP_CODE_RT_VER_IDX].integer.value;
+	memcpy(&cap_hdr->drv_type,
+	       out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.pointer,
+	       out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length);
+	cap_hdr->drv_rt_version =
+		out_obj->package.elements[CAP_DRV_RT_VER_IDX].integer.value;
+	cap_hdr->drv_svn =
+		out_obj->package.elements[CAP_DRV_SVN_IDX].integer.value;
+	memcpy(&cap_hdr->platform_id,
+	       out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.pointer,
+	       out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length);
+	memcpy(&cap_hdr->oem_id,
+	       out_obj->package.elements[CAP_OEM_ID_IDX].buffer.pointer,
+	       out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length);
+	cap_hdr->oem_info_len =
+		out_obj->package.elements[CAP_OEM_INFO_IDX].buffer.length;
+
+	ret = 0;
+
+free_acpi_buffer:
+	kfree(out_obj);
+
+	return ret;
+}
+
+static int query_buffer(struct pfru_com_buf_info *info,
+			struct pfru_device *pfru_dev)
+{
+	acpi_handle handle = ACPI_HANDLE(pfru_dev->parent_dev);
+	union acpi_object *out_obj;
+	int ret = -EINVAL;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_guid,
+					  pfru_dev->rev_id, PFRU_FUNC_QUERY_BUF,
+					  NULL, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return ret;
+
+	if (out_obj->package.count < BUF_NR_IDX ||
+	    out_obj->package.elements[BUF_STATUS_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[BUF_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[BUF_ADDR_LOW_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[BUF_ADDR_HI_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[BUF_SIZE_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	info->status = out_obj->package.elements[BUF_STATUS_IDX].integer.value;
+	info->ext_status =
+		out_obj->package.elements[BUF_EXT_STATUS_IDX].integer.value;
+	if (info->status != DSM_SUCCEED) {
+		ret = -EBUSY;
+		dev_dbg(pfru_dev->parent_dev, "Error Status:%d\n", info->status);
+		dev_dbg(pfru_dev->parent_dev, "Error Extended Status:%d\n", info->ext_status);
+
+		goto free_acpi_buffer;
+	}
+
+	info->addr_lo =
+		out_obj->package.elements[BUF_ADDR_LOW_IDX].integer.value;
+	info->addr_hi =
+		out_obj->package.elements[BUF_ADDR_HI_IDX].integer.value;
+	info->buf_size = out_obj->package.elements[BUF_SIZE_IDX].integer.value;
+
+	ret = 0;
+
+free_acpi_buffer:
+	kfree(out_obj);
+
+	return ret;
+}
+
+static int get_image_type(const struct efi_manage_capsule_image_header *img_hdr,
+			  struct pfru_device *pfru_dev)
+{
+	const efi_guid_t *image_type_id = &img_hdr->image_type_id;
+
+	/* check whether this is a code injection or driver update */
+	if (guid_equal(image_type_id, &pfru_code_inj_guid))
+		return PFRU_CODE_INJECT_TYPE;
+
+	if (guid_equal(image_type_id, &pfru_drv_update_guid))
+		return PFRU_DRIVER_UPDATE_TYPE;
+
+	return -EINVAL;
+}
+
+static int adjust_efi_size(const struct efi_manage_capsule_image_header *img_hdr,
+			   int size)
+{
+	/*
+	 * The (u64 hw_ins) was introduced in UEFI spec version 2,
+	 * and (u64 capsule_support) was introduced in version 3.
+	 * The size needs to be adjusted accordingly. That is to
+	 * say, version 1 should subtract the size of hw_ins+capsule_support,
+	 * and version 2 should sbstract the size of capsule_support.
+	 */
+	size += sizeof(struct efi_manage_capsule_image_header);
+	switch (img_hdr->ver) {
+	case 1:
+		return size - 2 * sizeof(u64);
+
+	case 2:
+		return size - sizeof(u64);
+
+	default:
+		/* only support version 1 and 2 */
+		return -EINVAL;
+	}
+}
+
+static bool applicable_image(const void *data, struct pfru_update_cap_info *cap,
+			     struct pfru_device *pfru_dev)
+{
+	struct pfru_payload_hdr *payload_hdr;
+	const efi_capsule_header_t *cap_hdr = data;
+	const struct efi_manage_capsule_header *m_hdr;
+	const struct efi_manage_capsule_image_header *m_img_hdr;
+	const struct efi_image_auth *auth;
+	int type, size;
+
+	/*
+	 * If the code in the capsule is older than the current
+	 * firmware code, the update will be rejected by the firmware,
+	 * so check the version of it upfront without engaging the
+	 * Management Mode update mechanism which may be costly.
+	 */
+	size = cap_hdr->headersize;
+	m_hdr = data + size;
+	/*
+	 * Current data structure size plus variable array indicated
+	 * by number of (emb_drv_cnt + payload_cnt)
+	 */
+	size += offsetof(struct efi_manage_capsule_header, offset_list) +
+		(m_hdr->emb_drv_cnt + m_hdr->payload_cnt) * sizeof(u64);
+	m_img_hdr = data + size;
+
+	type = get_image_type(m_img_hdr, pfru_dev);
+	if (type < 0)
+		return false;
+
+	size = adjust_efi_size(m_img_hdr, size);
+	if (size < 0)
+		return false;
+
+	auth = data + size;
+	size += sizeof(u64) + auth->auth_info.hdr.len;
+	payload_hdr = (struct pfru_payload_hdr *)(data + size);
+
+	/* finally compare the version */
+	if (type == PFRU_CODE_INJECT_TYPE)
+		return payload_hdr->rt_ver >= cap->code_rt_version;
+
+	return payload_hdr->rt_ver >= cap->drv_rt_version;
+}
+
+static void print_update_debug_info(struct pfru_updated_result *result,
+				    struct pfru_device *pfru_dev)
+{
+	dev_dbg(pfru_dev->parent_dev, "Update result:\n");
+	dev_dbg(pfru_dev->parent_dev, "Authentication Time Low:%lld\n",
+		result->low_auth_time);
+	dev_dbg(pfru_dev->parent_dev, "Authentication Time High:%lld\n",
+		result->high_auth_time);
+	dev_dbg(pfru_dev->parent_dev, "Execution Time Low:%lld\n",
+		result->low_exec_time);
+	dev_dbg(pfru_dev->parent_dev, "Execution Time High:%lld\n",
+		result->high_exec_time);
+}
+
+static int start_update(int action, struct pfru_device *pfru_dev)
+{
+	union acpi_object *out_obj, in_obj, in_buf;
+	struct pfru_updated_result update_result;
+	acpi_handle handle;
+	int ret = -EINVAL;
+
+	memset(&in_obj, 0, sizeof(in_obj));
+	memset(&in_buf, 0, sizeof(in_buf));
+	in_obj.type = ACPI_TYPE_PACKAGE;
+	in_obj.package.count = 1;
+	in_obj.package.elements = &in_buf;
+	in_buf.type = ACPI_TYPE_INTEGER;
+	in_buf.integer.value = action;
+
+	handle = ACPI_HANDLE(pfru_dev->parent_dev);
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_guid,
+					  pfru_dev->rev_id, PFRU_FUNC_START,
+					  &in_obj, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return ret;
+
+	if (out_obj->package.count < UPDATE_NR_IDX ||
+	    out_obj->package.elements[UPDATE_STATUS_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[UPDATE_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[UPDATE_AUTH_TIME_LOW_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[UPDATE_AUTH_TIME_HI_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[UPDATE_EXEC_TIME_LOW_IDX].type != ACPI_TYPE_INTEGER ||
+	    out_obj->package.elements[UPDATE_EXEC_TIME_HI_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	update_result.status =
+		out_obj->package.elements[UPDATE_STATUS_IDX].integer.value;
+	update_result.ext_status =
+		out_obj->package.elements[UPDATE_EXT_STATUS_IDX].integer.value;
+
+	if (update_result.status != DSM_SUCCEED) {
+		ret = -EBUSY;
+		dev_dbg(pfru_dev->parent_dev, "Error Status:%d\n", update_result.status);
+		dev_dbg(pfru_dev->parent_dev, "Error Extended Status:%d\n",
+			update_result.ext_status);
+
+		goto free_acpi_buffer;
+	}
+
+	update_result.low_auth_time =
+		out_obj->package.elements[UPDATE_AUTH_TIME_LOW_IDX].integer.value;
+	update_result.high_auth_time =
+		out_obj->package.elements[UPDATE_AUTH_TIME_HI_IDX].integer.value;
+	update_result.low_exec_time =
+		out_obj->package.elements[UPDATE_EXEC_TIME_LOW_IDX].integer.value;
+	update_result.high_exec_time =
+		out_obj->package.elements[UPDATE_EXEC_TIME_HI_IDX].integer.value;
+
+	print_update_debug_info(&update_result, pfru_dev);
+	ret = 0;
+
+free_acpi_buffer:
+	kfree(out_obj);
+
+	return ret;
+}
+
+static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct pfru_update_cap_info cap_hdr;
+	struct pfru_device *pfru_dev = to_pfru_dev(file);
+	void __user *p = (void __user *)arg;
+	u32 rev;
+	int ret;
+
+	switch (cmd) {
+	case PFRU_IOC_QUERY_CAP:
+		ret = query_capability(&cap_hdr, pfru_dev);
+		if (ret)
+			return ret;
+
+		if (copy_to_user(p, &cap_hdr, sizeof(cap_hdr)))
+			return -EFAULT;
+
+		return 0;
+
+	case PFRU_IOC_SET_REV:
+		if (copy_from_user(&rev, p, sizeof(rev)))
+			return -EFAULT;
+
+		if (!pfru_valid_revid(rev))
+			return -EINVAL;
+
+		pfru_dev->rev_id = rev;
+
+		return 0;
+
+	case PFRU_IOC_STAGE:
+		return start_update(START_STAGE, pfru_dev);
+
+	case PFRU_IOC_ACTIVATE:
+		return start_update(START_ACTIVATE, pfru_dev);
+
+	case PFRU_IOC_STAGE_ACTIVATE:
+		return start_update(START_STAGE_ACTIVATE, pfru_dev);
+
+	default:
+		return -ENOTTY;
+	}
+}
+
+static ssize_t pfru_write(struct file *file, const char __user *buf,
+			  size_t len, loff_t *ppos)
+{
+	struct pfru_device *pfru_dev = to_pfru_dev(file);
+	struct pfru_update_cap_info cap;
+	struct pfru_com_buf_info buf_info;
+	phys_addr_t phy_addr;
+	struct iov_iter iter;
+	struct iovec iov;
+	char *buf_ptr;
+	int ret;
+
+	ret = query_buffer(&buf_info, pfru_dev);
+	if (ret)
+		return ret;
+
+	if (len > buf_info.buf_size)
+		return -EINVAL;
+
+	iov.iov_base = (void __user *)buf;
+	iov.iov_len = len;
+	iov_iter_init(&iter, WRITE, &iov, 1, len);
+
+	/* map the communication buffer */
+	phy_addr = (phys_addr_t)((buf_info.addr_hi << 32) | buf_info.addr_lo);
+	buf_ptr = memremap(phy_addr, buf_info.buf_size, MEMREMAP_WB);
+	if (IS_ERR(buf_ptr))
+		return PTR_ERR(buf_ptr);
+
+	if (!copy_from_iter_full(buf_ptr, len, &iter)) {
+		ret = -EINVAL;
+		goto unmap;
+	}
+
+	/* check if the capsule header has a valid version number */
+	ret = query_capability(&cap, pfru_dev);
+	if (ret)
+		goto unmap;
+
+	if (!applicable_image(buf_ptr, &cap, pfru_dev))
+		ret = -EINVAL;
+
+unmap:
+	memunmap(buf_ptr);
+
+	return ret ?: len;
+}
+
+static const struct file_operations acpi_pfru_fops = {
+	.owner		= THIS_MODULE,
+	.write		= pfru_write,
+	.unlocked_ioctl = pfru_ioctl,
+	.llseek		= noop_llseek,
+};
+
+static int acpi_pfru_remove(struct platform_device *pdev)
+{
+	struct pfru_device *pfru_dev = platform_get_drvdata(pdev);
+
+	misc_deregister(&pfru_dev->miscdev);
+
+	return 0;
+}
+
+static void pfru_put_idx(void *data)
+{
+	struct pfru_device *pfru_dev = data;
+
+	ida_free(&pfru_ida, pfru_dev->index);
+}
+
+static int acpi_pfru_probe(struct platform_device *pdev)
+{
+	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
+	struct pfru_device *pfru_dev;
+	int ret;
+
+	if (!acpi_has_method(handle, "_DSM")) {
+		dev_dbg(&pdev->dev, "Missing _DSM\n");
+		return -ENODEV;
+	}
+
+	pfru_dev = devm_kzalloc(&pdev->dev, sizeof(*pfru_dev), GFP_KERNEL);
+	if (!pfru_dev)
+		return -ENOMEM;
+
+	ret = ida_alloc(&pfru_ida, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	pfru_dev->index = ret;
+	ret = devm_add_action_or_reset(&pdev->dev, pfru_put_idx, pfru_dev);
+	if (ret)
+		return ret;
+
+	pfru_dev->rev_id = PFRU_DEFAULT_REV_ID;
+	pfru_dev->parent_dev = &pdev->dev;
+
+	pfru_dev->miscdev.minor = MISC_DYNAMIC_MINOR;
+	pfru_dev->miscdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						"pfru%d", pfru_dev->index);
+	if (!pfru_dev->miscdev.name)
+		return -ENOMEM;
+
+	pfru_dev->miscdev.nodename = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						    "acpi_pfr_update%d", pfru_dev->index);
+	if (!pfru_dev->miscdev.nodename)
+		return -ENOMEM;
+
+	pfru_dev->miscdev.fops = &acpi_pfru_fops;
+	pfru_dev->miscdev.parent = &pdev->dev;
+
+	ret = misc_register(&pfru_dev->miscdev);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, pfru_dev);
+
+	return 0;
+}
+
+static const struct acpi_device_id acpi_pfru_ids[] = {
+	{"INTC1080"},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, acpi_pfru_ids);
+
+static struct platform_driver acpi_pfru_driver = {
+	.driver = {
+		.name = "pfr_update",
+		.acpi_match_table = acpi_pfru_ids,
+	},
+	.probe = acpi_pfru_probe,
+	.remove = acpi_pfru_remove,
+};
+module_platform_driver(acpi_pfru_driver);
+
+MODULE_DESCRIPTION("Platform Firmware Runtime Update device driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/pfrut.h b/include/uapi/linux/pfrut.h
new file mode 100644
index 000000000000..fa97e80a93b7
--- /dev/null
+++ b/include/uapi/linux/pfrut.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Platform Firmware Runtime Update header
+ *
+ * Copyright(c) 2021 Intel Corporation. All rights reserved.
+ */
+#ifndef __PFRUT_H__
+#define __PFRUT_H__
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define PFRUT_IOCTL_MAGIC 0xEE
+
+/**
+ * PFRU_IOC_SET_REV - _IOW(PFRUT_IOCTL_MAGIC, 0x01, unsigned int)
+ *
+ * Return:
+ * * 0			- success
+ * * -EFAULT		- fail to read the revision id
+ * * -EINVAL		- user provides an invalid revision id
+ *
+ * Set the Revision ID for Platform Firmware Runtime Update.
+ */
+#define PFRU_IOC_SET_REV _IOW(PFRUT_IOCTL_MAGIC, 0x01, unsigned int)
+
+/**
+ * PFRU_IOC_STAGE - _IOW(PFRUT_IOCTL_MAGIC, 0x02, unsigned int)
+ *
+ * Return:
+ * * 0			- success
+ * * -EINVAL		- stage phase returns invalid result
+ *
+ * Stage a capsule image from communication buffer and perform authentication.
+ */
+#define PFRU_IOC_STAGE _IOW(PFRUT_IOCTL_MAGIC, 0x02, unsigned int)
+
+/**
+ * PFRU_IOC_ACTIVATE - _IOW(PFRUT_IOCTL_MAGIC, 0x03, unsigned int)
+ *
+ * Return:
+ * * 0			- success
+ * * -EINVAL		- activate phase returns invalid result
+ *
+ * Activate a previously staged capsule image.
+ */
+#define PFRU_IOC_ACTIVATE _IOW(PFRUT_IOCTL_MAGIC, 0x03, unsigned int)
+
+/**
+ * PFRU_IOC_STAGE_ACTIVATE - _IOW(PFRUT_IOCTL_MAGIC, 0x04, unsigned int)
+ *
+ * Return:
+ * * 0			- success
+ * * -EINVAL		- stage/activate phase returns invalid result.
+ *
+ * Perform both stage and activation action.
+ */
+#define PFRU_IOC_STAGE_ACTIVATE _IOW(PFRUT_IOCTL_MAGIC, 0x04, unsigned int)
+
+/**
+ * PFRU_IOC_QUERY_CAP - _IOR(PFRUT_IOCTL_MAGIC, 0x05,
+ *			     struct pfru_update_cap_info)
+ *
+ * Return:
+ * * 0			- success
+ * * -EINVAL		- query phase returns invalid result
+ * * -EFAULT		- the result fails to be copied to userspace
+ *
+ * Retrieve information on the Platform Firmware Runtime Update capability.
+ * The information is a struct pfru_update_cap_info.
+ */
+#define PFRU_IOC_QUERY_CAP _IOR(PFRUT_IOCTL_MAGIC, 0x05, struct pfru_update_cap_info)
+
+/**
+ * struct pfru_payload_hdr - Capsule file payload header.
+ *
+ * @sig: Signature of this capsule file.
+ * @hdr_version: Revision of this header structure.
+ * @hdr_size: Size of this header, including the OemHeader bytes.
+ * @hw_ver: The supported firmware version.
+ * @rt_ver: Version of the code injection image.
+ * @platform_id: A platform specific GUID to specify the platform what
+ *               this capsule image support.
+ */
+struct pfru_payload_hdr {
+	__u32 sig;
+	__u32 hdr_version;
+	__u32 hdr_size;
+	__u32 hw_ver;
+	__u32 rt_ver;
+	__u8 platform_id[16];
+};
+
+enum pfru_dsm_status {
+	DSM_SUCCEED = 0,
+	DSM_FUNC_NOT_SUPPORT = 1,
+	DSM_INVAL_INPUT = 2,
+	DSM_HARDWARE_ERR = 3,
+	DSM_RETRY_SUGGESTED = 4,
+	DSM_UNKNOWN = 5,
+	DSM_FUNC_SPEC_ERR = 6,
+};
+
+/**
+ * struct pfru_update_cap_info - Runtime update capability information.
+ *
+ * @status: Indicator of whether this query succeed.
+ * @update_cap: Bitmap to indicate whether the feature is supported.
+ * @code_type: A buffer containing an image type GUID.
+ * @fw_version: Platform firmware version.
+ * @code_rt_version: Code injection runtime version for anti-rollback.
+ * @drv_type: A buffer containing an image type GUID.
+ * @drv_rt_version: The version of the driver update runtime code.
+ * @drv_svn: The secure version number(SVN) of the driver update runtime code.
+ * @platform_id: A buffer containing a platform ID GUID.
+ * @oem_id: A buffer containing an OEM ID GUID.
+ * @oem_info_len: Length of the buffer containing the vendor specific information.
+ */
+struct pfru_update_cap_info {
+	__u32 status;
+	__u32 update_cap;
+
+	__u8 code_type[16];
+	__u32 fw_version;
+	__u32 code_rt_version;
+
+	__u8 drv_type[16];
+	__u32 drv_rt_version;
+	__u32 drv_svn;
+
+	__u8 platform_id[16];
+	__u8 oem_id[16];
+
+	__u32 oem_info_len;
+};
+
+/**
+ * struct pfru_com_buf_info - Communication buffer information.
+ *
+ * @status: Indicator of whether this query succeed.
+ * @ext_status: Implementation specific query result.
+ * @addr_lo: Low 32bit physical address of the communication buffer to hold
+ *           a runtime update package.
+ * @addr_hi: High 32bit physical address of the communication buffer to hold
+ *           a runtime update package.
+ * @buf_size: Maximum size in bytes of the communication buffer.
+ */
+struct pfru_com_buf_info {
+	__u32 status;
+	__u32 ext_status;
+	__u64 addr_lo;
+	__u64 addr_hi;
+	__u32 buf_size;
+};
+
+/**
+ * struct pfru_updated_result - Platform firmware runtime update result information.
+ * @status: Indicator of whether this update succeed.
+ * @ext_status: Implementation specific update result.
+ * @low_auth_time: Low 32bit value of image authentication time in nanosecond.
+ * @high_auth_time: High 32bit value of image authentication time in nanosecond.
+ * @low_exec_time: Low 32bit value of image execution time in nanosecond.
+ * @high_exec_time: High 32bit value of image execution time in nanosecond.
+ */
+struct pfru_updated_result {
+	__u32 status;
+	__u32 ext_status;
+	__u64 low_auth_time;
+	__u64 high_auth_time;
+	__u64 low_exec_time;
+	__u64 high_exec_time;
+};
+
+#endif /* __PFRUT_H__ */
-- 
2.25.1

