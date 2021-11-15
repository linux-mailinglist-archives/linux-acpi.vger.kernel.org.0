Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585224507F1
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Nov 2021 16:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhKOPOD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Nov 2021 10:14:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:5754 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236495AbhKOPNr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Nov 2021 10:13:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="213490416"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="213490416"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 07:10:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="644861435"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.186])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2021 07:10:48 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 3/4] drivers/acpi: Introduce Platform Firmware Runtime Update Telemetry
Date:   Mon, 15 Nov 2021 23:09:57 +0800
Message-Id: <b9c6fdead455dbbe68e99c1bc0f7a4d21e5e67e1.1636987638.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1636987638.git.yu.c.chen@intel.com>
References: <cover.1636987638.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Platform Firmware Runtime Update(PFRU) Telemetry Service is part of RoT
(Root of Trust), which allows PFRU handler and other PFRU drivers to
produce telemetry data to upper layer OS consumer at runtime.

The Linux kernel provides interfaces for the user to query the parameters
of telemetry data, and the user could read out the telemetry data
accordingly.

PFRU and PFRU Telemetry both invoke _DSM to trigger the low level actions.
However the input parameters and ACPI package result as well as the
functions are different from each other. It is hard to extract the common
code between them, so introduce separated files for them.

The corresponding userspace tool and man page will be introduced at
tools/power/acpi/tools/pfru.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v10:Remove the explicit assignment of the last item of enum.
    (Andy Shevchenko)
v9: Use GUID_INIT() instead of guid_parse() during boot up.
    (Andy Shevchenko)
    Drop uuid from struct pfru_log_device.(Andy Shevchenko)
    Use kfree() instead of ACPI_FREE() in non-ACPICA usage.
    (Andy Shevchenko)
    Use devm_add_action_or_reset() to add ida release into dev resource
    management. (Andy Shevchenko)
    Use devm_kasprintf() instead of kasprintf() to format the
    pfru_log_dev name.(Andy Shevchenko)
    Remove redundant 0 in acpi_pfru_log_ids. (Andy Shevchenko)
v8: Add blank line between generic include header and uapi header.
    (Andy Shevchenko)
    Arrange the order between devm_kzalloc() and normal allocation in
    acpi_pfru_log_probe() that, the former should always be ahead of the
    latter. (Andy Shevchenko)
    Amend commit message to elaborate the reason why PFRU and PRFU_Telemetry
    drivers look the same. (Andy Shevchenko)
v7: Use ida_alloc() to allocate a ID, and release the ID when
    device is removed. (Greg Kroah-Hartman)
    Check the _DSM method at early stage, before allocate or parse
    anything in acpi_pfru_log_probe(). (Greg Kroah-Hartman)
    Set the parent of the misc device. (Greg Kroah-Hartman)
    Use module_platform_driver() instead of platform_driver_register()
    in module_init(). Separate pfru driver and pfru_telemetry driver
    to two files. (Greg Kroah-Hartman) 
v6: Remove linux/uuid.h and use raw buffers to contain uuid.
    (Andy Shevchenko)
    Include types.h in pfru.h. (Andy Shevchenko)
    Use __u8[16] instead of uuid_t. (Andy Shevchenko)
    Replace enum in pfru.h with __u32 as enum size is not the
    same on all possible architectures.
    (Andy Shevchenko)
    Directly return results from the switch cases in pfru_log_ioctl().
    (Andy Shevchenko)
v5: Remove the log output sample in commit log. (Greg Kroah-Hartman)
    Add link for corresponding userspace tool in the commit log.
    (Greg Kroah-Hartman)
    Replace the telemetry .read() with .mmap() so that the userspace
    could mmap once, and read multiple times. (Greg Kroah-Hartman)
    Fix the compile warning by declaring the pfru_log_ioctl() as
    static. (kernel test robot LKP)
v4: Change the write() to be the code injection/update, the read() to
    be telemetry retrieval and all of the rest to be ioctl()s under
    one special device file.(Rafael J. Wysocki)
    Remove redundant parens. (Rafael J. Wysocki)
    Putting empty code lines after an if () statement that is not
    followed by a block. (Rafael J. Wysocki)
    Remove "goto" tags to make the code more readable. (Rafael J. Wysocki)
v3: Use __u32 instead of int and __64 instead of unsigned long
    in include/uapi/linux/pfru.h (Greg Kroah-Hartman)
    Rename the structure in uapi to start with a prefix pfru so as
    to avoid confusing in the global namespace. (Greg Kroah-Hartman)
v2: Do similar clean up as pfru_update driver:
    Add sanity check for duplicated instance of ACPI device.
    Update the driver to work with allocated telem_device objects.
    (Mike Rapoport)
    For each switch case pair, get rid of the magic case numbers
    and add a default clause with the error handling.
    (Mike Rapoport)
---
 drivers/acpi/pfru/Makefile         |   2 +-
 drivers/acpi/pfru/pfru_telemetry.c | 457 +++++++++++++++++++++++++++++
 include/uapi/linux/pfru.h          |  88 ++++++
 3 files changed, 546 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/pfru/pfru_telemetry.c

diff --git a/drivers/acpi/pfru/Makefile b/drivers/acpi/pfru/Makefile
index 098cbe80cf3d..9ba11efe10b3 100644
--- a/drivers/acpi/pfru/Makefile
+++ b/drivers/acpi/pfru/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_ACPI_PFRU) += pfru_update.o
+obj-$(CONFIG_ACPI_PFRU) += pfru_update.o pfru_telemetry.o
diff --git a/drivers/acpi/pfru/pfru_telemetry.c b/drivers/acpi/pfru/pfru_telemetry.c
new file mode 100644
index 000000000000..5140a4591c9e
--- /dev/null
+++ b/drivers/acpi/pfru/pfru_telemetry.c
@@ -0,0 +1,457 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACPI Platform Firmware Runtime Update Telemetry Driver
+ *
+ * Copyright (C) 2021 Intel Corporation
+ * Author: Chen Yu <yu.c.chen@intel.com>
+ */
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/uio.h>
+#include <linux/uuid.h>
+
+#include <uapi/linux/pfru.h>
+
+#define PFRU_LOG_EXEC_IDX	0
+#define PFRU_LOG_HISTORY_IDX	1
+
+#define PFRU_LOG_ERR		0
+#define PFRU_LOG_WARN	1
+#define PFRU_LOG_INFO	2
+#define PFRU_LOG_VERB	4
+
+#define PFRU_FUNC_SET_LEV		1
+#define PFRU_FUNC_GET_LEV		2
+#define PFRU_FUNC_GET_DATA		3
+
+#define PFRU_REVID_1		1
+#define PFRU_REVID_2		2
+#define PFRU_DEFAULT_REV_ID	PFRU_REVID_1
+
+enum log_index {
+	LOG_STATUS_IDX = 0,
+	LOG_EXT_STATUS_IDX = 1,
+	LOG_MAX_SZ_IDX = 2,
+	LOG_CHUNK1_LO_IDX = 3,
+	LOG_CHUNK1_HI_IDX = 4,
+	LOG_CHUNK1_SZ_IDX = 5,
+	LOG_CHUNK2_LO_IDX = 6,
+	LOG_CHUNK2_HI_IDX = 7,
+	LOG_CHUNK2_SZ_IDX = 8,
+	LOG_ROLLOVER_CNT_IDX = 9,
+	LOG_RESET_CNT_IDX = 10,
+	LOG_NR_IDX
+};
+
+struct pfru_log_device {
+	int index;
+	struct pfru_log_info info;
+	struct device *parent_dev;
+	struct miscdevice miscdev;
+};
+
+static const guid_t pfru_log_guid =
+	GUID_INIT(0x75191659, 0x8178, 0x4D9D, 0xB8, 0x8F, 0xAC, 0x5E,
+		  0x5E, 0x93, 0xE8, 0xBF);
+
+static DEFINE_IDA(pfru_log_ida);
+
+static inline struct pfru_log_device *to_pfru_log_dev(struct file *file)
+{
+	return container_of(file->private_data, struct pfru_log_device, miscdev);
+}
+
+static int get_pfru_log_data_info(struct pfru_log_data_info *data_info,
+				  struct pfru_log_device *pfru_log_dev)
+{
+	acpi_handle handle = ACPI_HANDLE(pfru_log_dev->parent_dev);
+	union acpi_object *out_obj, in_obj, in_buf;
+	int ret = -EINVAL;
+
+	memset(&in_obj, 0, sizeof(in_obj));
+	memset(&in_buf, 0, sizeof(in_buf));
+	in_obj.type = ACPI_TYPE_PACKAGE;
+	in_obj.package.count = 1;
+	in_obj.package.elements = &in_buf;
+	in_buf.type = ACPI_TYPE_INTEGER;
+	in_buf.integer.value = pfru_log_dev->info.log_type;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_log_guid,
+					  pfru_log_dev->info.log_revid, PFRU_FUNC_GET_DATA,
+					  &in_obj, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return ret;
+
+	if (out_obj->package.count < LOG_NR_IDX)
+		goto free_acpi_buffer;
+
+	if (out_obj->package.elements[LOG_STATUS_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	data_info->status = out_obj->package.elements[LOG_STATUS_IDX].integer.value;
+
+	if (out_obj->package.elements[LOG_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	data_info->ext_status =
+		out_obj->package.elements[LOG_EXT_STATUS_IDX].integer.value;
+
+	if (out_obj->package.elements[LOG_MAX_SZ_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	data_info->max_data_size =
+		out_obj->package.elements[LOG_MAX_SZ_IDX].integer.value;
+
+	if (out_obj->package.elements[LOG_CHUNK1_LO_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	data_info->chunk1_addr_lo =
+		out_obj->package.elements[LOG_CHUNK1_LO_IDX].integer.value;
+
+	if (out_obj->package.elements[LOG_CHUNK1_HI_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	data_info->chunk1_addr_hi =
+		out_obj->package.elements[LOG_CHUNK1_HI_IDX].integer.value;
+
+	if (out_obj->package.elements[LOG_CHUNK1_SZ_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	data_info->chunk1_size =
+		out_obj->package.elements[LOG_CHUNK1_SZ_IDX].integer.value;
+
+	if (out_obj->package.elements[LOG_CHUNK2_LO_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	data_info->chunk2_addr_lo =
+		out_obj->package.elements[LOG_CHUNK2_LO_IDX].integer.value;
+
+	if (out_obj->package.elements[LOG_CHUNK2_HI_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	data_info->chunk2_addr_hi =
+		out_obj->package.elements[LOG_CHUNK2_HI_IDX].integer.value;
+
+	if (out_obj->package.elements[LOG_CHUNK2_SZ_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	data_info->chunk2_size =
+		out_obj->package.elements[LOG_CHUNK2_SZ_IDX].integer.value;
+
+	if (out_obj->package.elements[LOG_ROLLOVER_CNT_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	data_info->rollover_cnt =
+		out_obj->package.elements[LOG_ROLLOVER_CNT_IDX].integer.value;
+
+	if (out_obj->package.elements[LOG_RESET_CNT_IDX].type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	data_info->reset_cnt =
+		out_obj->package.elements[LOG_RESET_CNT_IDX].integer.value;
+
+	ret = 0;
+
+free_acpi_buffer:
+	kfree(out_obj);
+
+	return ret;
+}
+
+static int set_pfru_log_level(int level, struct pfru_log_device *pfru_log_dev)
+{
+	acpi_handle handle = ACPI_HANDLE(pfru_log_dev->parent_dev);
+	union acpi_object *out_obj, *obj, in_obj, in_buf;
+	enum pfru_dsm_status status;
+	int ret = -EINVAL;
+
+	memset(&in_obj, 0, sizeof(in_obj));
+	memset(&in_buf, 0, sizeof(in_buf));
+	in_obj.type = ACPI_TYPE_PACKAGE;
+	in_obj.package.count = 1;
+	in_obj.package.elements = &in_buf;
+	in_buf.type = ACPI_TYPE_INTEGER;
+	in_buf.integer.value = level;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_log_guid,
+					  pfru_log_dev->info.log_revid, PFRU_FUNC_SET_LEV,
+					  &in_obj, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return -EINVAL;
+
+	obj = &out_obj->package.elements[0];
+	status = obj->integer.value;
+	if (status)
+		goto free_acpi_buffer;
+
+	obj = &out_obj->package.elements[1];
+	status = obj->integer.value;
+	if (status)
+		goto free_acpi_buffer;
+
+	ret = 0;
+
+free_acpi_buffer:
+	kfree(out_obj);
+
+	return ret;
+}
+
+static int get_pfru_log_level(struct pfru_log_device *pfru_log_dev)
+{
+	acpi_handle handle = ACPI_HANDLE(pfru_log_dev->parent_dev);
+	union acpi_object *out_obj, *obj;
+	enum pfru_dsm_status status;
+	int ret = -EINVAL;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_log_guid,
+					  pfru_log_dev->info.log_revid, PFRU_FUNC_GET_LEV,
+					  NULL, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return -EINVAL;
+
+	obj = &out_obj->package.elements[0];
+	if (obj->type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	status = obj->integer.value;
+	if (status)
+		goto free_acpi_buffer;
+
+	obj = &out_obj->package.elements[1];
+	if (obj->type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	status = obj->integer.value;
+	if (status)
+		goto free_acpi_buffer;
+
+	obj = &out_obj->package.elements[2];
+	if (obj->type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+
+	ret = obj->integer.value;
+
+free_acpi_buffer:
+	kfree(out_obj);
+
+	return ret;
+}
+
+static int valid_log_level(u32 level)
+{
+	return level == PFRU_LOG_ERR || level == PFRU_LOG_WARN ||
+	       level == PFRU_LOG_INFO || level == PFRU_LOG_VERB;
+}
+
+static int valid_log_type(u32 type)
+{
+	return type == PFRU_LOG_EXEC_IDX || type == PFRU_LOG_HISTORY_IDX;
+}
+
+static inline int valid_log_revid(u32 id)
+{
+	return id == PFRU_REVID_1 || id == PFRU_REVID_2;
+}
+
+static long pfru_log_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct pfru_log_device *pfru_log_dev = to_pfru_log_dev(file);
+	struct pfru_log_data_info data_info;
+	struct pfru_log_info info;
+	void __user *p;
+	int ret = 0;
+
+	p = (void __user *)arg;
+
+	switch (cmd) {
+	case PFRU_LOG_IOC_SET_INFO:
+		if (copy_from_user(&info, p, sizeof(info)))
+			return -EFAULT;
+
+		if (valid_log_revid(info.log_revid))
+			pfru_log_dev->info.log_revid = info.log_revid;
+
+		if (valid_log_level(info.log_level)) {
+			ret = set_pfru_log_level(info.log_level, pfru_log_dev);
+			if (ret < 0)
+				return ret;
+
+			pfru_log_dev->info.log_level = info.log_level;
+		}
+
+		if (valid_log_type(info.log_type))
+			pfru_log_dev->info.log_type = info.log_type;
+
+		return 0;
+	case PFRU_LOG_IOC_GET_INFO:
+		info.log_level = get_pfru_log_level(pfru_log_dev);
+		if (ret < 0)
+			return ret;
+
+		info.log_type = pfru_log_dev->info.log_type;
+		info.log_revid = pfru_log_dev->info.log_revid;
+		if (copy_to_user(p, &info, sizeof(info)))
+			return -EFAULT;
+
+		return 0;
+	case PFRU_LOG_IOC_GET_DATA_INFO:
+		ret = get_pfru_log_data_info(&data_info, pfru_log_dev);
+		if (ret)
+			return ret;
+
+		if (copy_to_user(p, &data_info, sizeof(struct pfru_log_data_info)))
+			return -EFAULT;
+
+		return 0;
+	default:
+		return -ENOTTY;
+	}
+}
+
+static int
+pfru_log_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct pfru_log_device *pfru_log_dev;
+	struct pfru_log_data_info info;
+	unsigned long psize, vsize;
+	phys_addr_t base_addr;
+	int ret;
+
+	if (vma->vm_flags & VM_WRITE)
+		return -EROFS;
+
+	/* changing from read to write with mprotect is not allowed */
+	vma->vm_flags &= ~VM_MAYWRITE;
+
+	pfru_log_dev = to_pfru_log_dev(file);
+
+	ret = get_pfru_log_data_info(&info, pfru_log_dev);
+	if (ret)
+		return ret;
+
+	base_addr = (phys_addr_t)((info.chunk2_addr_hi << 32) | info.chunk2_addr_lo);
+	/* pfru update has not been launched yet */
+	if (!base_addr)
+		return -ENODEV;
+
+	psize = info.max_data_size;
+	/* base address and total buffer size must be page aligned */
+	if (!PAGE_ALIGNED(base_addr) || !PAGE_ALIGNED(psize))
+		return -ENODEV;
+
+	vsize = vma->vm_end - vma->vm_start;
+	if (vsize > psize)
+		return -EINVAL;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	if (io_remap_pfn_range(vma, vma->vm_start, PFN_DOWN(base_addr),
+			       vsize, vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static const struct file_operations acpi_pfru_log_fops = {
+	.owner		= THIS_MODULE,
+	.mmap		= pfru_log_mmap,
+	.unlocked_ioctl = pfru_log_ioctl,
+	.llseek		= noop_llseek,
+};
+
+static int acpi_pfru_log_remove(struct platform_device *pdev)
+{
+	struct pfru_log_device *pfru_log_dev = platform_get_drvdata(pdev);
+
+	misc_deregister(&pfru_log_dev->miscdev);
+
+	return 0;
+}
+
+static void pfru_log_put_idx(void *data)
+{
+	struct pfru_log_device *pfru_log_dev = data;
+
+	ida_free(&pfru_log_ida, pfru_log_dev->index);
+}
+
+static int acpi_pfru_log_probe(struct platform_device *pdev)
+{
+	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
+	struct pfru_log_device *pfru_log_dev;
+	int ret;
+
+	if (!acpi_has_method(handle, "_DSM")) {
+		dev_dbg(&pdev->dev, "Missing _DSM\n");
+		return -ENODEV;
+	}
+
+	pfru_log_dev = devm_kzalloc(&pdev->dev, sizeof(*pfru_log_dev), GFP_KERNEL);
+	if (!pfru_log_dev)
+		return -ENOMEM;
+
+	ret = ida_alloc(&pfru_log_ida, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	pfru_log_dev->index = ret;
+	ret = devm_add_action_or_reset(&pdev->dev, pfru_log_put_idx, pfru_log_dev);
+	if (ret)
+		return ret;
+
+	pfru_log_dev->info.log_revid = PFRU_DEFAULT_REV_ID;
+	pfru_log_dev->parent_dev = &pdev->dev;
+
+	pfru_log_dev->miscdev.minor = MISC_DYNAMIC_MINOR;
+	pfru_log_dev->miscdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						    "pfru_telemetry%d",
+						    pfru_log_dev->index);
+	if (!pfru_log_dev->miscdev.name)
+		return -ENOMEM;
+
+	pfru_log_dev->miscdev.nodename = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+							"acpi_pfru_telemetry%d",
+							pfru_log_dev->index);
+	if (!pfru_log_dev->miscdev.nodename)
+		return -ENOMEM;
+
+	pfru_log_dev->miscdev.fops = &acpi_pfru_log_fops;
+	pfru_log_dev->miscdev.parent = &pdev->dev;
+
+	ret = misc_register(&pfru_log_dev->miscdev);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, pfru_log_dev);
+
+	return 0;
+}
+
+static const struct acpi_device_id acpi_pfru_log_ids[] = {
+	{"INTC1081"},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, acpi_pfru_log_ids);
+
+static struct platform_driver acpi_pfru_log_driver = {
+	.driver = {
+		.name = "pfru_telemetry",
+		.acpi_match_table = acpi_pfru_log_ids,
+	},
+	.probe = acpi_pfru_log_probe,
+	.remove = acpi_pfru_log_remove,
+};
+module_platform_driver(acpi_pfru_log_driver);
+
+MODULE_DESCRIPTION("Platform Firmware Runtime Update Telemetry driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/pfru.h b/include/uapi/linux/pfru.h
index fed50cb01309..2f17714e05b7 100644
--- a/include/uapi/linux/pfru.h
+++ b/include/uapi/linux/pfru.h
@@ -171,4 +171,92 @@ struct pfru_updated_result {
 	__u64 high_exec_time;
 };
 
+/**
+ * struct pfru_log_data_info - Log Data from telemetry service.
+ * @status: Indicator of whether this update succeed.
+ * @ext_status: Implementation specific update result.
+ * @chunk1_addr_lo: Low 32bit physical address of the telemetry data chunk1
+ *                  starting address.
+ * @chunk1_addr_hi: High 32bit physical address of the telemetry data chunk1
+ *                  starting address.
+ * @chunk2_addr_lo: Low 32bit physical address of the telemetry data chunk2
+ *                  starting address.
+ * @chunk2_addr_hi: High 32bit physical address of the telemetry data chunk2
+ *                  starting address.
+ * @max_data_size: Maximum supported size of data of all data chunks combined.
+ * @chunk1_size: Data size in bytes of the telemetry data chunk1 buffer.
+ * @chunk2_size: Data size in bytes of the telemetry data chunk2 buffer.
+ * @rollover_cnt: Number of times telemetry data buffer is overwritten
+ *                since telemetry buffer reset.
+ * @reset_cnt: Number of times telemetry services resets that results in
+ *             rollover count and data chunk buffers are reset.
+ */
+struct pfru_log_data_info {
+	__u32 status;
+	__u32 ext_status;
+	__u64 chunk1_addr_lo;
+	__u64 chunk1_addr_hi;
+	__u64 chunk2_addr_lo;
+	__u64 chunk2_addr_hi;
+	__u32 max_data_size;
+	__u32 chunk1_size;
+	__u32 chunk2_size;
+	__u32 rollover_cnt;
+	__u32 reset_cnt;
+};
+
+/**
+ * struct pfru_log_info - Telemetry log information.
+ * @log_level: The telemetry log level.
+ * @log_type: The telemetry log type(history and execution).
+ * @log_revid: The telemetry log revision id.
+ */
+struct pfru_log_info {
+	__u32 log_level;
+	__u32 log_type;
+	__u32 log_revid;
+};
+
+/**
+ * PFRU_LOG_IOC_SET_INFO - _IOW(PFRU_MAGIC_FOR_IOCTL, 0x06,
+ *				struct pfru_log_info)
+ *
+ * Return:
+ * * 0			- success
+ * * -EFAULT		- fail to get the setting parameter
+ * * -EINVAL		- fail to set the log level
+ *
+ * Set the PFRU log level and log type. The input information is
+ * a struct pfru_log_info.
+ */
+#define PFRU_LOG_IOC_SET_INFO _IOW(PFRU_MAGIC_FOR_IOCTL, 0x06, struct pfru_log_info)
+
+/**
+ * PFRU_LOG_IOC_GET_INFO - _IOR(PFRU_MAGIC_FOR_IOCTL, 0x07,
+ *				struct pfru_log_info)
+ *
+ * Return:
+ * * 0			- success
+ * * -EINVAL		- fail to get the log level
+ * * -EFAULT		- fail to copy the result back to userspace
+ *
+ * Retrieve log level and log type of the PFRU telemetry. The information is
+ * a struct pfru_log_info.
+ */
+#define PFRU_LOG_IOC_GET_INFO _IOR(PFRU_MAGIC_FOR_IOCTL, 0x07, struct pfru_log_info)
+
+/**
+ * PFRU_LOG_IOC_GET_DATA_INFO - _IOR(PFRU_MAGIC_FOR_IOCTL, 0x08,
+ *				     struct pfru_log_data_info)
+ *
+ * Return:
+ * * 0			- success
+ * * -EINVAL		- fail to get the log buffer information
+ * * -EFAULT		- fail to copy the log buffer information to userspace
+ *
+ * Retrieve data information about the PFRU telemetry. The information
+ * is a struct pfru_log_data_info.
+ */
+#define PFRU_LOG_IOC_GET_DATA_INFO _IOR(PFRU_MAGIC_FOR_IOCTL, 0x08, struct pfru_log_data_info)
+
 #endif /* __PFRU_H__ */
-- 
2.25.1

