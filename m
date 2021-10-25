Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1ABE438F74
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 08:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhJYG2Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 02:28:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:31162 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231173AbhJYG2Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Oct 2021 02:28:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="216744517"
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="216744517"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 23:25:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="496642285"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.186])
  by orsmga008.jf.intel.com with ESMTP; 24 Oct 2021 23:25:50 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] drivers/acpi: Introduce Platform Firmware Runtime Update device driver
Date:   Mon, 25 Oct 2021 14:25:16 +0800
Message-Id: <6d4a9bc38c1efd2b10955f64629d194c050fdae1.1635140590.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635140590.git.yu.c.chen@intel.com>
References: <cover.1635140590.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Introduce the pfru_update driver which can be used for Platform Firmware
Runtime code injection and driver update [1]. The user is expected to
provide the update firmware in the form of capsule file, and pass it to
the driver via ioctl. Then the driver would hand this capsule file to the
Platform Firmware Runtime Update via the ACPI device _DSM method. At last
the low level Management Mode would do the firmware update.

The corresponding userspace tool and man page will be introduced at
tools/power/acpi/pfru.

Link: https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf # [1]
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
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
 drivers/acpi/Kconfig                          |   1 +
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/pfru/Kconfig                     |  13 +
 drivers/acpi/pfru/Makefile                    |   2 +
 drivers/acpi/pfru/pfru_update.c               | 567 ++++++++++++++++++
 include/uapi/linux/pfru.h                     | 186 ++++++
 7 files changed, 771 insertions(+)
 create mode 100644 drivers/acpi/pfru/Kconfig
 create mode 100644 drivers/acpi/pfru/Makefile
 create mode 100644 drivers/acpi/pfru/pfru_update.c
 create mode 100644 include/uapi/linux/pfru.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 2e8134059c87..6f7c86b6deb7 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -365,6 +365,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:aherrman@de.ibm.com>
 0xE5  00-3F  linux/fuse.h
 0xEC  00-01  drivers/platform/chrome/cros_ec_dev.h                   ChromeOS EC driver
+0xEE  00-08  uapi/linux/pfru.h                                       Platform Firmware Runtime Update and Telemetry
 0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                     sisfb (in development)
                                                                      <mailto:thomas@winischhofer.net>
 0xF6  all                                                            LTTng Linux Trace Toolkit Next Generation
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1da360c51d66..1d8d2e2cefac 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -482,6 +482,7 @@ source "drivers/acpi/nfit/Kconfig"
 source "drivers/acpi/numa/Kconfig"
 source "drivers/acpi/apei/Kconfig"
 source "drivers/acpi/dptf/Kconfig"
+source "drivers/acpi/pfru/Kconfig"
 
 config ACPI_WATCHDOG
 	bool
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3018714e87d9..9c2c5ddff6ec 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
+obj-$(CONFIG_ACPI_PFRU)		+= pfru/
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
diff --git a/drivers/acpi/pfru/Kconfig b/drivers/acpi/pfru/Kconfig
new file mode 100644
index 000000000000..5b31675b173a
--- /dev/null
+++ b/drivers/acpi/pfru/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+config ACPI_PFRU
+	tristate "ACPI Platform Firmware Runtime Update (PFRU)"
+	depends on 64BIT
+	help
+	  In order to reduce the system reboot times and update the platform firmware
+	  in time, Platform Firmware Runtime Update is leveraged to patch the system
+	  without reboot. This driver supports Platform Firmware Runtime Update,
+	  which is composed of two parts: code injection and driver update. It also
+	  allows telemetry data to be retrieved from the platform firmware.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called pfru_update.
diff --git a/drivers/acpi/pfru/Makefile b/drivers/acpi/pfru/Makefile
new file mode 100644
index 000000000000..098cbe80cf3d
--- /dev/null
+++ b/drivers/acpi/pfru/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ACPI_PFRU) += pfru_update.o
diff --git a/drivers/acpi/pfru/pfru_update.c b/drivers/acpi/pfru/pfru_update.c
new file mode 100644
index 000000000000..99a95b2ddc57
--- /dev/null
+++ b/drivers/acpi/pfru/pfru_update.c
@@ -0,0 +1,567 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACPI Platform Firmware Runtime Update Device Driver
+ *
+ * Copyright (C) 2021 Intel Corporation
+ * Author: Chen Yu <yu.c.chen@intel.com>
+ */
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/efi.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/uio.h>
+#include <linux/uuid.h>
+#include <uapi/linux/pfru.h>
+
+enum cap_index {
+	CAP_STATUS_IDX,
+	CAP_UPDATE_IDX,
+	CAP_CODE_TYPE_IDX,
+	CAP_FW_VER_IDX,
+	CAP_CODE_RT_VER_IDX,
+	CAP_DRV_TYPE_IDX,
+	CAP_DRV_RT_VER_IDX,
+	CAP_DRV_SVN_IDX,
+	CAP_PLAT_ID_IDX,
+	CAP_OEM_ID_IDX,
+	CAP_OEM_INFO_IDX,
+	CAP_NR_IDX
+};
+
+enum buf_index {
+	BUF_STATUS_IDX,
+	BUF_EXT_STATUS_IDX,
+	BUF_ADDR_LOW_IDX,
+	BUF_ADDR_HI_IDX,
+	BUF_SIZE_IDX,
+	BUF_NR_IDX
+};
+
+enum update_index {
+	UPDATE_STATUS_IDX,
+	UPDATE_EXT_STATUS_IDX,
+	UPDATE_AUTH_TIME_LOW_IDX,
+	UPDATE_AUTH_TIME_HI_IDX,
+	UPDATE_EXEC_TIME_LOW_IDX,
+	UPDATE_EXEC_TIME_HI_IDX,
+	UPDATE_NR_IDX
+};
+
+struct pfru_device {
+	guid_t uuid, code_uuid, drv_uuid;
+	int rev_id;
+	struct device *dev;
+	struct miscdevice miscdev;
+};
+
+static inline struct pfru_device *to_pfru_dev(struct file *file)
+{
+	return container_of(file->private_data, struct pfru_device, miscdev);
+}
+
+static int query_capability(struct pfru_update_cap_info *cap,
+			    struct pfru_device *pfru_dev)
+{
+	union acpi_object *out_obj;
+	acpi_handle handle;
+	int ret = -EINVAL;
+
+	handle = ACPI_HANDLE(pfru_dev->dev);
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_dev->uuid,
+					  pfru_dev->rev_id,
+					  FUNC_QUERY_UPDATE_CAP,
+					  NULL, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return ret;
+
+	if (out_obj->package.count < CAP_NR_IDX)
+		goto free_acpi_buffer;
+
+	if (out_obj->package.elements[CAP_STATUS_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	cap->status = out_obj->package.elements[CAP_STATUS_IDX].integer.value;
+
+	if (out_obj->package.elements[CAP_UPDATE_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	cap->update_cap = out_obj->package.elements[CAP_UPDATE_IDX].integer.value;
+
+	if (out_obj->package.elements[CAP_CODE_TYPE_IDX].type != ACPI_TYPE_BUFFER)
+		goto free_acpi_buffer;
+
+	memcpy(&cap->code_type,
+	       out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.pointer,
+	       out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length);
+
+	if (out_obj->package.elements[CAP_FW_VER_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	cap->fw_version =
+		out_obj->package.elements[CAP_FW_VER_IDX].integer.value;
+
+	if (out_obj->package.elements[CAP_CODE_RT_VER_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	cap->code_rt_version =
+		out_obj->package.elements[CAP_CODE_RT_VER_IDX].integer.value;
+
+	if (out_obj->package.elements[CAP_DRV_TYPE_IDX].type != ACPI_TYPE_BUFFER)
+		goto free_acpi_buffer;
+
+	memcpy(&cap->drv_type,
+	       out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.pointer,
+	       out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length);
+
+	if (out_obj->package.elements[CAP_DRV_RT_VER_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	cap->drv_rt_version =
+		out_obj->package.elements[CAP_DRV_RT_VER_IDX].integer.value;
+
+	if (out_obj->package.elements[CAP_DRV_SVN_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	cap->drv_svn =
+		out_obj->package.elements[CAP_DRV_SVN_IDX].integer.value;
+
+	if (out_obj->package.elements[CAP_PLAT_ID_IDX].type != ACPI_TYPE_BUFFER)
+		goto free_acpi_buffer;
+
+	memcpy(&cap->platform_id,
+	       out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.pointer,
+	       out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length);
+
+	if (out_obj->package.elements[CAP_OEM_ID_IDX].type != ACPI_TYPE_BUFFER)
+		goto free_acpi_buffer;
+
+	memcpy(&cap->oem_id,
+	       out_obj->package.elements[CAP_OEM_ID_IDX].buffer.pointer,
+	       out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length);
+	ret = 0;
+free_acpi_buffer:
+	ACPI_FREE(out_obj);
+
+	return ret;
+}
+
+static int query_buffer(struct pfru_com_buf_info *info,
+			struct pfru_device *pfru_dev)
+{
+	union acpi_object *out_obj;
+	acpi_handle handle;
+	int ret = -EINVAL;
+
+	handle = ACPI_HANDLE(pfru_dev->dev);
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_dev->uuid,
+					  pfru_dev->rev_id, FUNC_QUERY_BUF,
+					  NULL, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return ret;
+
+	if (out_obj->package.count < BUF_NR_IDX)
+		goto free_acpi_buffer;
+
+	if (out_obj->package.elements[BUF_STATUS_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	info->status = out_obj->package.elements[BUF_STATUS_IDX].integer.value;
+
+	if (out_obj->package.elements[BUF_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	info->ext_status =
+		out_obj->package.elements[BUF_EXT_STATUS_IDX].integer.value;
+
+	if (out_obj->package.elements[BUF_ADDR_LOW_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	info->addr_lo =
+		out_obj->package.elements[BUF_ADDR_LOW_IDX].integer.value;
+
+	if (out_obj->package.elements[BUF_ADDR_HI_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	info->addr_hi =
+		out_obj->package.elements[BUF_ADDR_HI_IDX].integer.value;
+
+	if (out_obj->package.elements[BUF_SIZE_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	info->buf_size = out_obj->package.elements[BUF_SIZE_IDX].integer.value;
+
+	ret = 0;
+free_acpi_buffer:
+	ACPI_FREE(out_obj);
+
+	return ret;
+}
+
+static int get_image_type(efi_manage_capsule_image_header_t *img_hdr,
+			  struct pfru_device *pfru_dev)
+{
+	guid_t *image_type_id = &img_hdr->image_type_id;
+
+	/* check whether this is a code injection or driver update */
+	if (guid_equal(image_type_id, &pfru_dev->code_uuid))
+		return CODE_INJECT_TYPE;
+
+	if (guid_equal(image_type_id, &pfru_dev->drv_uuid))
+		return DRIVER_UPDATE_TYPE;
+
+	return -EINVAL;
+}
+
+static int adjust_efi_size(efi_manage_capsule_image_header_t *img_hdr,
+			   int size)
+{
+	/*
+	 * The (u64 hw_ins) was introduced in UEFI spec version 2,
+	 * and (u64 capsule_support) was introduced in version 3.
+	 * The size needs to be adjusted accordingly. That is to
+	 * say, version 1 should subtract the size of hw_ins+capsule_support,
+	 * and version 2 should sbstract the size of capsule_support.
+	 */
+	size += sizeof(efi_manage_capsule_image_header_t);
+	switch (img_hdr->ver) {
+	case 1:
+		return size - 2 * sizeof(u64);
+	case 2:
+		return size - sizeof(u64);
+	default:
+		/* only support version 1 and 2 */
+		return -EINVAL;
+	}
+}
+
+static bool valid_version(const void *data, struct pfru_update_cap_info *cap,
+			  struct pfru_device *pfru_dev)
+{
+	struct pfru_payload_hdr *payload_hdr;
+	efi_capsule_header_t *cap_hdr;
+	efi_manage_capsule_header_t *m_hdr;
+	efi_manage_capsule_image_header_t *m_img_hdr;
+	efi_image_auth_t *auth;
+	int type, size;
+
+	/*
+	 * Sanity check if the capsule image has a newer version
+	 * than current one.
+	 */
+	cap_hdr = (efi_capsule_header_t *)data;
+	size = cap_hdr->headersize;
+	m_hdr = (efi_manage_capsule_header_t *)(data + size);
+	/*
+	 * Current data structure size plus variable array indicated
+	 * by number of (emb_drv_cnt + payload_cnt)
+	 */
+	size += sizeof(efi_manage_capsule_header_t) +
+		      (m_hdr->emb_drv_cnt + m_hdr->payload_cnt) * sizeof(u64);
+	m_img_hdr = (efi_manage_capsule_image_header_t *)(data + size);
+
+	type = get_image_type(m_img_hdr, pfru_dev);
+	if (type < 0)
+		return false;
+
+	size = adjust_efi_size(m_img_hdr, size);
+	if (size < 0)
+		return false;
+
+	auth = (efi_image_auth_t *)(data + size);
+	size += sizeof(u64) + auth->auth_info.hdr.len;
+	payload_hdr = (struct pfru_payload_hdr *)(data + size);
+
+	/* finally compare the version */
+	if (type == CODE_INJECT_TYPE)
+		return payload_hdr->rt_ver >= cap->code_rt_version;
+	else
+		return payload_hdr->rt_ver >= cap->drv_rt_version;
+}
+
+static void dump_update_result(struct pfru_updated_result *result,
+			       struct pfru_device *pfru_dev)
+{
+	dev_dbg(pfru_dev->dev, "Update result:\n");
+	dev_dbg(pfru_dev->dev, "Status:%d\n", result->status);
+	dev_dbg(pfru_dev->dev, "Extended Status:%d\n", result->ext_status);
+	dev_dbg(pfru_dev->dev, "Authentication Time Low:%lld\n",
+		result->low_auth_time);
+	dev_dbg(pfru_dev->dev, "Authentication Time High:%lld\n",
+		result->high_auth_time);
+	dev_dbg(pfru_dev->dev, "Execution Time Low:%lld\n",
+		result->low_exec_time);
+	dev_dbg(pfru_dev->dev, "Execution Time High:%lld\n",
+		result->high_exec_time);
+}
+
+static int start_acpi_update(int action, struct pfru_device *pfru_dev)
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
+	handle = ACPI_HANDLE(pfru_dev->dev);
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_dev->uuid,
+					  pfru_dev->rev_id, FUNC_START,
+					  &in_obj, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return ret;
+
+	if (out_obj->package.count < UPDATE_NR_IDX)
+		goto free_acpi_buffer;
+
+	if (out_obj->package.elements[UPDATE_STATUS_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	update_result.status =
+		out_obj->package.elements[UPDATE_STATUS_IDX].integer.value;
+
+	if (out_obj->package.elements[UPDATE_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	update_result.ext_status =
+		out_obj->package.elements[UPDATE_EXT_STATUS_IDX].integer.value;
+
+	if (out_obj->package.elements[UPDATE_AUTH_TIME_LOW_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	update_result.low_auth_time =
+		out_obj->package.elements[UPDATE_AUTH_TIME_LOW_IDX].integer.value;
+
+	if (out_obj->package.elements[UPDATE_AUTH_TIME_HI_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	update_result.high_auth_time =
+		out_obj->package.elements[UPDATE_AUTH_TIME_HI_IDX].integer.value;
+
+	if (out_obj->package.elements[UPDATE_EXEC_TIME_LOW_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	update_result.low_exec_time =
+		out_obj->package.elements[UPDATE_EXEC_TIME_LOW_IDX].integer.value;
+
+	if (out_obj->package.elements[UPDATE_EXEC_TIME_HI_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	update_result.high_exec_time =
+		out_obj->package.elements[UPDATE_EXEC_TIME_HI_IDX].integer.value;
+
+	dump_update_result(&update_result, pfru_dev);
+	ret = 0;
+
+free_acpi_buffer:
+	ACPI_FREE(out_obj);
+
+	return ret;
+}
+
+static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct pfru_update_cap_info cap;
+	struct pfru_device *pfru_dev;
+	void __user *p;
+	int ret, rev;
+
+	pfru_dev = to_pfru_dev(file);
+	p = (void __user *)arg;
+
+	switch (cmd) {
+	case PFRU_IOC_QUERY_CAP:
+		ret = query_capability(&cap, pfru_dev);
+		if (ret)
+			return ret;
+
+		if (copy_to_user(p, &cap, sizeof(cap)))
+			return -EFAULT;
+
+		return 0;
+	case PFRU_IOC_SET_REV:
+		if (copy_from_user(&rev, p, sizeof(unsigned int)))
+			return -EFAULT;
+
+		if (!pfru_valid_revid(rev))
+			return -EINVAL;
+
+		pfru_dev->rev_id = rev;
+
+		return 0;
+	case PFRU_IOC_STAGE:
+		return start_acpi_update(START_STAGE, pfru_dev);
+	case PFRU_IOC_ACTIVATE:
+		return start_acpi_update(START_ACTIVATE, pfru_dev);
+	case PFRU_IOC_STAGE_ACTIVATE:
+		return start_acpi_update(START_STAGE_ACTIVATE, pfru_dev);
+	default:
+		return -ENOTTY;
+	}
+}
+
+static ssize_t pfru_write(struct file *file, const char __user *buf,
+			  size_t len, loff_t *ppos)
+{
+	struct pfru_update_cap_info cap;
+	struct pfru_com_buf_info info;
+	struct pfru_device *pfru_dev;
+	phys_addr_t phy_addr;
+	struct iov_iter iter;
+	struct iovec iov;
+	char *buf_ptr;
+	int ret;
+
+	pfru_dev = to_pfru_dev(file);
+
+	ret = query_buffer(&info, pfru_dev);
+	if (ret)
+		return ret;
+
+	if (len > info.buf_size)
+		return -EINVAL;
+
+	iov.iov_base = (void __user *)buf;
+	iov.iov_len = len;
+	iov_iter_init(&iter, WRITE, &iov, 1, len);
+
+	/* map the communication buffer */
+	phy_addr = (phys_addr_t)(info.addr_lo | (info.addr_hi << 32));
+	buf_ptr = memremap(phy_addr, info.buf_size, MEMREMAP_WB);
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
+	if (cap.status != DSM_SUCCEED)
+		ret = -EBUSY;
+	else if (!valid_version(buf_ptr, &cap, pfru_dev))
+		ret = -EINVAL;
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
+static int acpi_pfru_probe(struct platform_device *pdev)
+{
+	struct pfru_device *pfru_dev;
+	acpi_handle handle;
+	static int pfru_idx;
+	int ret;
+
+	pfru_dev = devm_kzalloc(&pdev->dev, sizeof(*pfru_dev), GFP_KERNEL);
+	if (!pfru_dev)
+		return -ENOMEM;
+
+	ret = guid_parse(PFRU_UUID, &pfru_dev->uuid);
+	if (ret)
+		return ret;
+
+	ret = guid_parse(PFRU_CODE_INJ_UUID, &pfru_dev->code_uuid);
+	if (ret)
+		return ret;
+
+	ret = guid_parse(PFRU_DRV_UPDATE_UUID, &pfru_dev->drv_uuid);
+	if (ret)
+		return ret;
+
+	/* default rev id is 1 */
+	pfru_dev->rev_id = 1;
+	pfru_dev->dev = &pdev->dev;
+	handle = ACPI_HANDLE(pfru_dev->dev);
+	if (!acpi_has_method(handle, "_DSM")) {
+		dev_dbg(&pdev->dev, "Missing _DSM\n");
+		return -ENODEV;
+	}
+
+	pfru_dev->miscdev.minor = MISC_DYNAMIC_MINOR;
+	pfru_dev->miscdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						"pfru%d", pfru_idx);
+	if (!pfru_dev->miscdev.name)
+		return -ENOMEM;
+
+	pfru_dev->miscdev.nodename = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						    "acpi_pfru%d", pfru_idx);
+	if (!pfru_dev->miscdev.nodename)
+		return -ENOMEM;
+
+	pfru_idx++;
+	pfru_dev->miscdev.fops = &acpi_pfru_fops;
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
+	{"INTC1080", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, acpi_pfru_ids);
+
+static struct platform_driver acpi_pfru_driver = {
+	.driver = {
+		.name = "pfru_update",
+		.acpi_match_table = acpi_pfru_ids,
+	},
+	.probe = acpi_pfru_probe,
+	.remove = acpi_pfru_remove,
+};
+
+static int __init pfru_init(void)
+{
+	return platform_driver_register(&acpi_pfru_driver);
+}
+
+static void __exit pfru_exit(void)
+{
+	platform_driver_unregister(&acpi_pfru_driver);
+}
+
+module_init(pfru_init);
+module_exit(pfru_exit);
+
+MODULE_DESCRIPTION("Platform Firmware Runtime Update device driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/pfru.h b/include/uapi/linux/pfru.h
new file mode 100644
index 000000000000..d6f57a75afd2
--- /dev/null
+++ b/include/uapi/linux/pfru.h
@@ -0,0 +1,186 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Platform Firmware Runtime Update header
+ *
+ * Copyright(c) 2021 Intel Corporation. All rights reserved.
+ */
+#ifndef __PFRU_H__
+#define __PFRU_H__
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define PFRU_UUID		"ECF9533B-4A3C-4E89-939E-C77112601C6D"
+#define PFRU_CODE_INJ_UUID		"B2F84B79-7B6E-4E45-885F-3FB9BB185402"
+#define PFRU_DRV_UPDATE_UUID		"4569DD8C-75F1-429A-A3D6-24DE8097A0DF"
+
+#define FUNC_STANDARD_QUERY	0
+#define FUNC_QUERY_UPDATE_CAP	1
+#define FUNC_QUERY_BUF		2
+#define FUNC_START		3
+
+#define CODE_INJECT_TYPE	1
+#define DRIVER_UPDATE_TYPE	2
+
+#define REVID_1		1
+#define REVID_2		2
+
+#define PFRU_MAGIC 0xEE
+
+#define UUID_SIZE 16
+
+/**
+ * PFRU_IOC_SET_REV - _IOW(PFRU_MAGIC, 0x01, unsigned int)
+ *
+ * Return: 0 on success, -errno on failure
+ *
+ * Set the Revision ID for PFRU Runtime Update. It could be either 1 or 2.
+ */
+#define PFRU_IOC_SET_REV _IOW(PFRU_MAGIC, 0x01, unsigned int)
+/**
+ * PFRU_IOC_STAGE - _IOW(PFRU_MAGIC, 0x02, unsigned int)
+ *
+ * Return: 0 on success, -errno on failure
+ *
+ * Stage a capsule image from communication buffer and perform authentication.
+ */
+#define PFRU_IOC_STAGE _IOW(PFRU_MAGIC, 0x02, unsigned int)
+/**
+ * PFRU_IOC_ACTIVATE - _IOW(PFRU_MAGIC, 0x03, unsigned int)
+ *
+ * Return: 0 on success, -errno on failure
+ *
+ * Activate a previous staged capsule image.
+ */
+#define PFRU_IOC_ACTIVATE _IOW(PFRU_MAGIC, 0x03, unsigned int)
+/**
+ * PFRU_IOC_STAGE_ACTIVATE - _IOW(PFRU_MAGIC, 0x04, unsigned int)
+ *
+ * Return: 0 on success, -errno on failure
+ *
+ * Perform both stage and activation actions.
+ */
+#define PFRU_IOC_STAGE_ACTIVATE _IOW(PFRU_MAGIC, 0x04, unsigned int)
+/**
+ * PFRU_IOC_QUERY_CAP - _IOR(PFRU_MAGIC, 0x05,
+ *			     struct pfru_update_cap_info)
+ *
+ * Return: 0 on success, -errno on failure.
+ *
+ * Retrieve information about the PFRU Runtime Update capability.
+ * The information is a struct pfru_update_cap_info.
+ */
+#define PFRU_IOC_QUERY_CAP _IOR(PFRU_MAGIC, 0x05, struct pfru_update_cap_info)
+
+static inline int pfru_valid_revid(int id)
+{
+	return id == REVID_1 || id == REVID_2;
+}
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
+	__u8 platform_id[UUID_SIZE];
+};
+
+enum pfru_start_action {
+	START_STAGE,
+	START_ACTIVATE,
+	START_STAGE_ACTIVATE,
+};
+
+enum pfru_dsm_status {
+	DSM_SUCCEED,
+	DSM_FUNC_NOT_SUPPORT,
+	DSM_INVAL_INPUT,
+	DSM_HARDWARE_ERR,
+	DSM_RETRY_SUGGESTED,
+	DSM_UNKNOWN,
+	DSM_FUNC_SPEC_ERR,
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
+ * @oem_info: A buffer containing the vendor specific information.
+ */
+struct pfru_update_cap_info {
+	__u32 status;
+	__u32 update_cap;
+
+	__u8 code_type[UUID_SIZE];
+	__u32 fw_version;
+	__u32 code_rt_version;
+
+	__u8 drv_type[UUID_SIZE];
+	__u32 drv_rt_version;
+	__u32 drv_svn;
+
+	__u8 platform_id[UUID_SIZE];
+	__u8 oem_id[UUID_SIZE];
+
+	char oem_info[];
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
+#endif /* __PFRU_H__ */
-- 
2.25.1

