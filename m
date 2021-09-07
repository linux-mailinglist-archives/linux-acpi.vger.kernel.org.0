Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1DA402BE1
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 17:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345287AbhIGPfA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 11:35:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:7060 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345316AbhIGPe4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Sep 2021 11:34:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="207346636"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="207346636"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 08:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="469239597"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.176])
  by orsmga007.jf.intel.com with ESMTP; 07 Sep 2021 08:33:44 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 4/5][RFC] drivers/acpi: Introduce Platform Firmware Runtime Update Telemetry
Date:   Tue,  7 Sep 2021 23:39:40 +0800
Message-Id: <a4cfe0d616a9f42b19c2e599d3b86462e28767d5.1631025237.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631025237.git.yu.c.chen@intel.com>
References: <cover.1631025237.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Platform Firmware Runtime Update(PFRU) Telemetry Service is part of RoT
(Root of Trust), which allows PFRU handler and other PFRU drivers to produce
telemetry data to upper layer OS consumer at runtime.

The linux provides interfaces for the user to query the parameters of
telemetry data, and the user could read out the telemetry data accordingly.

Typical log looks like:

[SmmRuntimeUpdateHandler.ProcessSmmRuntimeUpdate] ProcessSmmRuntimeUpdate = START, Action = 2
[SmmRuntimeUpdateHandler.ProcessSmmRuntimeUpdate] FwVersion = 0, CodeInjectionVersion = 1
[ShadowSmmRuntimeUpdateImage] Image = 0x74D9B000, ImageSize = 0x1172
[ProcessSmmRuntimeUpdate] ShadowSmmRuntimeUpdateImage.Status = Success
[ValidateSmmRuntimeUpdateImage] CapsuleHeader.CapsuleGuid = 6DCBD5ED-E82D-4C44-BDA1-7194199AD92A
[ValidateSmmRuntimeUpdateImage] FmpCapHeader.Version = 1
[ValidateSmmRuntimeUpdateImage] FmpCapImageHeader.UpdateImageTypeId = B2F84B79-7B6E-4E45-885F-3FB9BB185402
[ValidateSmmRuntimeUpdateImage] SmmRuntimeUpdateVerifyImageWithDenylist.Status = Success
[ValidateSmmRuntimeUpdateImage] SmmRuntimeUpdateVerifyImageWithAllowlist.Status = Success
[SmmCodeInjectionVerifyPayloadHeader] PayloadHeader.Signature = 0x31494353
[SmmCodeInjectionVerifyPayloadHeader] PayloadHeader.PlatformId = 63462139-A8B1-AA4E-9024-F2BB53EA4723
[SmmCodeInjectionVerifyPayloadHeader] PayloadHeader.SupportedSmmFirmwareVersion = 0, PayloadHeader.SmmCodeInjectionRuntimeVersion = 1
[ProcessSmmRuntimeUpdate] ValidateSmmRuntimeUpdateImage.Status = Success
CPU CSR[0B102D28] Before = 7FBF830E
CPU CSR[0B102D28] After = 7FBF8310
[ProcessSmmRuntimeUpdate] ProcessSmmCodeInjection.Status = Success
[SmmRuntimeUpdateHandler.ProcessSmmRuntimeUpdate] ProcessSmmRuntimeUpdate = End, Status = Success

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/pfru/Kconfig          |  14 +
 drivers/acpi/pfru/Makefile         |   1 +
 drivers/acpi/pfru/pfru_telemetry.c | 412 +++++++++++++++++++++++++++++
 include/uapi/linux/pfru.h          |  46 ++++
 4 files changed, 473 insertions(+)
 create mode 100644 drivers/acpi/pfru/pfru_telemetry.c

diff --git a/drivers/acpi/pfru/Kconfig b/drivers/acpi/pfru/Kconfig
index 3f31b7d95f3b..e2934058884e 100644
--- a/drivers/acpi/pfru/Kconfig
+++ b/drivers/acpi/pfru/Kconfig
@@ -13,3 +13,17 @@ config ACPI_PFRU
 
 	  To compile this driver as a module, choose M here:
 	  the module will be called pfru_update.
+
+config ACPI_PFRU_TELEMETRY
+	tristate "ACPI Platform Firmware Runtime Update Telemetry Service"
+	depends on ACPI_PFRU
+	help
+	  PFRU(Platform Firmware Runtime Update) Telemetry Service is part of
+	  RoT(Root of Trust), which allows Platform Firmware Runtime Update handler
+	  and other PFRU drivers to produce telemetry data to upper layer OS consumer
+	  at runtime.
+
+	  For more information, see:
+	  <file:Documentation/x86/pfru_update.rst>
+
+	  If unsure, please say N.
diff --git a/drivers/acpi/pfru/Makefile b/drivers/acpi/pfru/Makefile
index 098cbe80cf3d..30060ba320ea 100644
--- a/drivers/acpi/pfru/Makefile
+++ b/drivers/acpi/pfru/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_ACPI_PFRU) += pfru_update.o
+obj-$(CONFIG_ACPI_PFRU_TELEMETRY) += pfru_telemetry.o
diff --git a/drivers/acpi/pfru/pfru_telemetry.c b/drivers/acpi/pfru/pfru_telemetry.c
new file mode 100644
index 000000000000..0873eb8bb69e
--- /dev/null
+++ b/drivers/acpi/pfru/pfru_telemetry.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACPI Platform Firmware Runtime Update
+ * Telemetry Service Device Driver
+ *
+ * Copyright (C) 2021 Intel Corporation
+ * Author: Chen Yu <yu.c.chen@intel.com>
+ */
+#include <linux/acpi.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/minmax.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/platform_device.h>
+#include <linux/uuid.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/pfru.h>
+
+struct pfru_telem_device {
+	struct device *dev;
+	guid_t uuid;
+	struct telem_info info;
+};
+
+static struct pfru_telem_device telem_dev;
+static struct pfru_telem_device *get_pfru_telem_dev(void)
+{
+	return &telem_dev;
+}
+
+static int get_pfru_data_info(struct telem_data_info *data_info,
+			      int log_type)
+{
+	struct pfru_telem_device *pf_telem_dev;
+	union acpi_object *out_obj, in_obj, in_buf;
+	acpi_handle handle;
+	int i, ret = -EINVAL;
+
+	pf_telem_dev = get_pfru_telem_dev();
+	handle = ACPI_HANDLE(pf_telem_dev->dev);
+
+	memset(&in_obj, 0, sizeof(in_obj));
+	memset(&in_buf, 0, sizeof(in_buf));
+	in_obj.type = ACPI_TYPE_PACKAGE;
+	in_obj.package.count = 1;
+	in_obj.package.elements = &in_buf;
+	in_buf.type = ACPI_TYPE_INTEGER;
+	in_buf.integer.value = log_type;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pf_telem_dev->uuid,
+					  pf_telem_dev->info.log_revid, FUNC_GET_DATA,
+					  &in_obj, ACPI_TYPE_PACKAGE);
+	if (!out_obj) {
+		pr_err("Failed to invoke _DSM\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < out_obj->package.count; i++) {
+		union acpi_object *obj = &out_obj->package.elements[i];
+
+		switch (i) {
+		case 0:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			data_info->status = obj->integer.value;
+			break;
+		case 1:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			data_info->ext_status = obj->integer.value;
+			break;
+		case 2:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			data_info->max_data_size = obj->integer.value;
+			break;
+		case 3:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			data_info->chunk1_addr_lo = obj->integer.value;
+			break;
+		case 4:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			data_info->chunk1_addr_hi = obj->integer.value;
+			break;
+		case 5:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			data_info->chunk1_size = obj->integer.value;
+			break;
+		case 6:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			data_info->chunk2_addr_lo = obj->integer.value;
+			break;
+		case 7:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			data_info->chunk2_addr_hi = obj->integer.value;
+			break;
+		case 8:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			data_info->chunk2_size = obj->integer.value;
+			break;
+		case 9:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			data_info->rollover_cnt = obj->integer.value;
+			break;
+		case 10:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			data_info->reset_cnt = obj->integer.value;
+			break;
+		}
+	}
+	ret = 0;
+
+free_acpi_buffer:
+	ACPI_FREE(out_obj);
+
+	return ret;
+}
+
+static int set_pfru_log_level(int level)
+{
+	union acpi_object *out_obj, *obj, in_obj, in_buf;
+	struct pfru_telem_device *pf_telem_dev;
+	enum dsm_status status;
+	acpi_handle handle;
+	int ret = -EINVAL;
+
+	pf_telem_dev = get_pfru_telem_dev();
+	handle = ACPI_HANDLE(pf_telem_dev->dev);
+
+	memset(&in_obj, 0, sizeof(in_obj));
+	memset(&in_buf, 0, sizeof(in_buf));
+	in_obj.type = ACPI_TYPE_PACKAGE;
+	in_obj.package.count = 1;
+	in_obj.package.elements = &in_buf;
+	in_buf.type = ACPI_TYPE_INTEGER;
+	in_buf.integer.value = level;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pf_telem_dev->uuid,
+					  pf_telem_dev->info.log_revid, FUNC_SET_LEV,
+					  &in_obj, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return -EINVAL;
+
+	obj = &out_obj->package.elements[0];
+	status = obj->integer.value;
+	if (status) {
+		pr_err("get MM telemetry level error status %d\n",
+		       status);
+		goto free_acpi_buffer;
+	}
+
+	obj = &out_obj->package.elements[1];
+	status = obj->integer.value;
+	if (status) {
+		pr_err("get MM telemetry level error extend status %d\n",
+		       status);
+		goto free_acpi_buffer;
+	}
+	ret = 0;
+
+free_acpi_buffer:
+	ACPI_FREE(out_obj);
+
+	return ret;
+}
+
+static int get_pfru_log_level(int *level)
+{
+	struct pfru_telem_device *pf_telem_dev;
+	union acpi_object *out_obj, *obj;
+	enum dsm_status status;
+	acpi_handle handle;
+	int ret = -EINVAL;
+
+	pf_telem_dev = get_pfru_telem_dev();
+	handle = ACPI_HANDLE(pf_telem_dev->dev);
+	out_obj = acpi_evaluate_dsm_typed(handle, &pf_telem_dev->uuid,
+					  pf_telem_dev->info.log_revid, FUNC_GET_LEV,
+					  NULL, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return -EINVAL;
+
+	obj = &out_obj->package.elements[0];
+	if (obj->type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+	status = obj->integer.value;
+	if (status) {
+		pr_err("get MM telemetry level error status %d\n",
+		       status);
+		goto free_acpi_buffer;
+	}
+
+	obj = &out_obj->package.elements[1];
+	if (obj->type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+	status = obj->integer.value;
+	if (status) {
+		pr_err("get MM telemetry level error status %d\n",
+		       status);
+		goto free_acpi_buffer;
+	}
+
+	obj = &out_obj->package.elements[2];
+	if (obj->type != ACPI_TYPE_INTEGER)
+		goto free_acpi_buffer;
+	*level = obj->integer.value;
+
+	ret = 0;
+
+free_acpi_buffer:
+	ACPI_FREE(out_obj);
+
+	return ret;
+}
+
+static int valid_log_level(int level)
+{
+	return (level == LOG_ERR) || (level == LOG_WARN) ||
+		(level == LOG_INFO) || (level == LOG_VERB);
+}
+
+static int valid_log_type(int type)
+{
+	return (type == LOG_EXEC_IDX) || (type == LOG_HISTORY_IDX);
+}
+
+static long pfru_telemetry_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+
+{
+	struct pfru_telem_device *pf_telem_dev;
+	struct telem_data_info data_info;
+	struct telem_info info;
+	void __user *p;
+	int ret = 0;
+
+	pf_telem_dev = get_pfru_telem_dev();
+	p = (void __user *)arg;
+
+	switch (cmd) {
+	case PFRU_LOG_IOC_SET_INFO:
+		if (copy_from_user(&info, p, sizeof(info)))
+			return -EFAULT;
+		if (valid_revid(info.log_revid))
+			pf_telem_dev->info.log_revid = info.log_revid;
+
+		if (valid_log_level(info.log_level)) {
+			ret = set_pfru_log_level(info.log_level);
+			if (ret)
+				return ret;
+			pf_telem_dev->info.log_level = info.log_level;
+		}
+		if (valid_log_type(info.log_type))
+			pf_telem_dev->info.log_type = info.log_type;
+		break;
+	case PFRU_LOG_IOC_GET_INFO:
+		ret = get_pfru_log_level(&info.log_level);
+		if (ret)
+			return ret;
+		info.log_type = pf_telem_dev->info.log_type;
+		info.log_revid = pf_telem_dev->info.log_revid;
+		if (copy_to_user(p, &info, sizeof(info)))
+			ret = -EFAULT;
+		break;
+	case PFRU_LOG_IOC_GET_DATA_INFO:
+		ret = get_pfru_data_info(&data_info, pf_telem_dev->info.log_type);
+		if (ret)
+			return ret;
+		if (copy_to_user(p, &data_info, sizeof(struct telem_data_info)))
+			ret = -EFAULT;
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+	return ret;
+}
+
+static ssize_t pfru_telemetry_read(struct file *filp, char __user *ubuf,
+				   size_t size, loff_t *off)
+{
+	struct pfru_telem_device *pf_telem_dev;
+	struct telem_data_info info;
+	phys_addr_t base_addr;
+	int buf_size, ret;
+	char *buf_ptr;
+
+	if (*off < 0)
+		return -EINVAL;
+
+	pf_telem_dev = get_pfru_telem_dev();
+
+	ret = get_pfru_data_info(&info, pf_telem_dev->info.log_type);
+	if (ret) {
+		pr_err("Could not get telemetry data info %d\n", ret);
+		return ret;
+	}
+
+	base_addr = (phys_addr_t)(info.chunk2_addr_lo |
+			(info.chunk2_addr_hi << 32));
+	if (!base_addr) {
+		pr_err("Telemetry data not ready\n");
+		return -EBUSY;
+	}
+
+	buf_size = info.max_data_size;
+	if (*off >= buf_size)
+		return 0;
+
+	buf_ptr = memremap(base_addr, buf_size, MEMREMAP_WB);
+	if (IS_ERR(buf_ptr))
+		return PTR_ERR(buf_ptr);
+
+	size = min_t(size_t, size, buf_size - *off);
+
+	ret = -EFAULT;
+	if (copy_to_user(ubuf, buf_ptr + *off, size))
+		goto out;
+	ret = 0;
+out:
+	memunmap(buf_ptr);
+
+	return ret ? ret : size;
+}
+
+#ifdef CONFIG_COMPAT
+static long compat_pfru_telemetry_ioctl(struct file *filep, unsigned int cmd,
+					unsigned long arg)
+{
+	return pfru_telemetry_ioctl(filep, cmd, arg);
+}
+#endif
+
+static const struct file_operations acpi_pfru_telemetry_fops = {
+	.owner		= THIS_MODULE,
+	.read		= pfru_telemetry_read,
+	.unlocked_ioctl = pfru_telemetry_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= compat_pfru_telemetry_ioctl,
+#endif
+	.llseek		= noop_llseek,
+};
+
+static struct miscdevice pfru_telemetry_misc_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "pfru_telemetry",
+	.nodename = "pfru/telemetry",
+	.fops = &acpi_pfru_telemetry_fops,
+};
+
+static int acpi_pfru_telemetry_remove(struct platform_device *pdev)
+{
+	misc_deregister(&pfru_telemetry_misc_dev);
+
+	return 0;
+}
+
+static int acpi_pfru_telemetry_probe(struct platform_device *pdev)
+{
+	struct pfru_telem_device *pf_telem_dev;
+	acpi_handle handle;
+	int ret;
+
+	pf_telem_dev = get_pfru_telem_dev();
+
+	ret = guid_parse(PFRU_TELEMETRY_UUID, &pf_telem_dev->uuid);
+	if (ret)
+		return ret;
+
+	pf_telem_dev->info.log_revid = 1;
+	pf_telem_dev->dev = &pdev->dev;
+	handle = ACPI_HANDLE(pf_telem_dev->dev);
+	if (!acpi_has_method(handle, "_DSM")) {
+		pr_err("Missing _DSM\n");
+		return -ENODEV;
+	}
+
+	ret = misc_register(&pfru_telemetry_misc_dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct acpi_device_id acpi_pfru_telemetry_ids[] = {
+	{"INTC1081", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, acpi_pfru_telemetry_ids);
+
+static struct platform_driver acpi_pfru_telemetry_driver = {
+	.driver = {
+		.name = "pfru_telemetry",
+		.acpi_match_table = acpi_pfru_telemetry_ids,
+	},
+	.probe = acpi_pfru_telemetry_probe,
+	.remove = acpi_pfru_telemetry_remove,
+};
+module_platform_driver(acpi_pfru_telemetry_driver);
+
+MODULE_DESCRIPTION("Platform Firmware Runtime Update Telemetry Service device driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/pfru.h b/include/uapi/linux/pfru.h
index 81eb8ad5a57e..b4d5c0078cfb 100644
--- a/include/uapi/linux/pfru.h
+++ b/include/uapi/linux/pfru.h
@@ -103,4 +103,50 @@ struct updated_result {
 	unsigned long high_exec_time;
 };
 
+#define PFRU_TELEMETRY_UUID	"75191659-8178-4D9D-B88F-AC5E5E93E8BF"
+
+/* Telemetry structures. */
+struct telem_data_info {
+	enum dsm_status status;
+	enum dsm_status ext_status;
+	/* Maximum supported size of data of
+	 * all Data Chunks combined.
+	 */
+	unsigned long chunk1_addr_lo;
+	unsigned long chunk1_addr_hi;
+	unsigned long chunk2_addr_lo;
+	unsigned long chunk2_addr_hi;
+	int max_data_size;
+	int chunk1_size;
+	int chunk2_size;
+	int rollover_cnt;
+	int reset_cnt;
+};
+
+struct telem_info {
+	int log_level;
+	int log_type;
+	int log_revid;
+};
+
+/* Two logs: history and execution log */
+#define LOG_EXEC_IDX	0
+#define LOG_HISTORY_IDX	1
+#define NR_LOG_TYPE	2
+
+#define LOG_ERR		0
+#define LOG_WARN	1
+#define LOG_INFO	2
+#define LOG_VERB	4
+
+#define FUNC_SET_LEV		1
+#define FUNC_GET_LEV		2
+#define FUNC_GET_DATA		3
+
+#define LOG_NAME_SIZE		10
+
+#define PFRU_LOG_IOC_SET_INFO _IOW(PFRU_MAGIC, 0x05, struct telem_info)
+#define PFRU_LOG_IOC_GET_INFO _IOR(PFRU_MAGIC, 0x06, struct telem_info)
+#define PFRU_LOG_IOC_GET_DATA_INFO _IOR(PFRU_MAGIC, 0x07, struct telem_data_info)
+
 #endif /* __PFRU_H__ */
-- 
2.25.1

