Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF5E430227
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Oct 2021 12:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbhJPKlh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Oct 2021 06:41:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:31396 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231331AbhJPKlg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 16 Oct 2021 06:41:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="226814724"
X-IronPort-AV: E=Sophos;i="5.85,378,1624345200"; 
   d="scan'208";a="226814724"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2021 03:39:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,378,1624345200"; 
   d="scan'208";a="628046375"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.176])
  by fmsmga001.fm.intel.com with ESMTP; 16 Oct 2021 03:39:25 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v4 3/4] drivers/acpi: Introduce Platform Firmware Runtime Update Telemetry
Date:   Sat, 16 Oct 2021 18:44:31 +0800
Message-Id: <838245e376c7e6fd0fe1ef55d004ed53763846a2.1634310710.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634310710.git.yu.c.chen@intel.com>
References: <cover.1634310710.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Platform Firmware Runtime Update(PFRU) Telemetry Service is part of RoT
(Root of Trust), which allows PFRU handler and other PFRU drivers to
produce telemetry data to upper layer OS consumer at runtime.

The linux provides interfaces for the user to query the parameters of
telemetry data, and the user could read out the telemetry data
accordingly.

Also add the ABI documentation.

Typical log looks like:
[SmmRuntimeUpdateHandler.ProcessSmmRuntimeUpdate]
ProcessSmmRuntimeUpdate = START, Action = 2
[SmmRuntimeUpdateHandler.ProcessSmmRuntimeUpdate]
FwVersion = 0, CodeInjectionVersion = 1
[ShadowSmmRuntimeUpdateImage]
Image = 0x74D9B000, ImageSize = 0x1172
[ProcessSmmRuntimeUpdate]
ShadowSmmRuntimeUpdateImage.Status = Success
[ValidateSmmRuntimeUpdateImage]
CapsuleHeader.CapsuleGuid = 6DCBD5ED-E82D-4C44-BDA1-7194199AD92A
[ValidateSmmRuntimeUpdateImage]
FmpCapHeader.Version = 1
[ValidateSmmRuntimeUpdateImage]
FmpCapImageHeader.UpdateImageTypeId = B2F84B79-7B6E-4E45-885F-3FB9BB185402
[ValidateSmmRuntimeUpdateImage]
SmmRuntimeUpdateVerifyImageWithDenylist.Status = Success
[ValidateSmmRuntimeUpdateImage]
SmmRuntimeUpdateVerifyImageWithAllowlist.Status = Success
[SmmCodeInjectionVerifyPayloadHeader]
PayloadHeader.Signature = 0x31494353
[SmmCodeInjectionVerifyPayloadHeader]
PayloadHeader.PlatformId = 63462139-A8B1-AA4E-9024-F2BB53EA4723
[SmmCodeInjectionVerifyPayloadHeader]
PayloadHeader.SupportedSmmFirmwareVersion = 0,
PayloadHeader.SmmCodeInjectionRuntimeVersion = 1
[ProcessSmmRuntimeUpdate]
ValidateSmmRuntimeUpdateImage.Status = Success
CPU CSR[0B102D28] Before = 7FBF830E
CPU CSR[0B102D28] After = 7FBF8310
[ProcessSmmRuntimeUpdate] ProcessSmmCodeInjection.Status = Success
[SmmRuntimeUpdateHandler.ProcessSmmRuntimeUpdate]
ProcessSmmRuntimeUpdate = End, Status = Success

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v4: Remove the telemetry kernel Kconfig and combine it with pfru
    (Rafael J. Wysocki)
    Remove redundant parens. (Rafael J. Wysocki)
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
 drivers/acpi/pfru/pfru_update.c | 380 +++++++++++++++++++++++++++++++-
 include/uapi/linux/pfru.h       |  43 ++++
 2 files changed, 421 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pfru/pfru_update.c b/drivers/acpi/pfru/pfru_update.c
index f57a39e79808..fe5b1bf0aeb3 100644
--- a/drivers/acpi/pfru/pfru_update.c
+++ b/drivers/acpi/pfru/pfru_update.c
@@ -55,6 +55,27 @@ enum update_index {
 	UPDATE_NR_IDX,
 };
 
+enum log_index {
+	LOG_STATUS_IDX,
+	LOG_EXT_STATUS_IDX,
+	LOG_MAX_SZ_IDX,
+	LOG_CHUNK1_LO_IDX,
+	LOG_CHUNK1_HI_IDX,
+	LOG_CHUNK1_SZ_IDX,
+	LOG_CHUNK2_LO_IDX,
+	LOG_CHUNK2_HI_IDX,
+	LOG_CHUNK2_SZ_IDX,
+	LOG_ROLLOVER_CNT_IDX,
+	LOG_RESET_CNT_IDX,
+	LOG_NR_IDX,
+};
+
+struct pfru_log_device {
+	struct device *dev;
+	guid_t uuid;
+	struct pfru_log_info info;
+};
+
 struct pfru_device {
 	guid_t uuid, code_uuid, drv_uuid;
 	int rev_id;
@@ -62,6 +83,299 @@ struct pfru_device {
 };
 
 static struct pfru_device *pfru_dev;
+static struct pfru_log_device *pfru_log_dev;
+
+static int get_pfru_log_data_info(struct pfru_log_data_info *data_info,
+				  int log_type)
+{
+	union acpi_object *out_obj, in_obj, in_buf;
+	acpi_handle handle;
+	int ret = -EINVAL;
+
+	handle = ACPI_HANDLE(pfru_log_dev->dev);
+
+	memset(&in_obj, 0, sizeof(in_obj));
+	memset(&in_buf, 0, sizeof(in_buf));
+	in_obj.type = ACPI_TYPE_PACKAGE;
+	in_obj.package.count = 1;
+	in_obj.package.elements = &in_buf;
+	in_buf.type = ACPI_TYPE_INTEGER;
+	in_buf.integer.value = log_type;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_log_dev->uuid,
+					  pfru_log_dev->info.log_revid, FUNC_GET_DATA,
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
+free_acpi_buffer:
+	ACPI_FREE(out_obj);
+
+	return ret;
+}
+
+static int set_pfru_log_level(int level)
+{
+	union acpi_object *out_obj, *obj, in_obj, in_buf;
+	enum pfru_dsm_status status;
+	acpi_handle handle;
+	int ret = -EINVAL;
+
+	handle = ACPI_HANDLE(pfru_log_dev->dev);
+
+	memset(&in_obj, 0, sizeof(in_obj));
+	memset(&in_buf, 0, sizeof(in_buf));
+	in_obj.type = ACPI_TYPE_PACKAGE;
+	in_obj.package.count = 1;
+	in_obj.package.elements = &in_buf;
+	in_buf.type = ACPI_TYPE_INTEGER;
+	in_buf.integer.value = level;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_log_dev->uuid,
+					  pfru_log_dev->info.log_revid, FUNC_SET_LEV,
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
+	ACPI_FREE(out_obj);
+
+	return ret;
+}
+
+static int get_pfru_log_level(int *level)
+{
+	union acpi_object *out_obj, *obj;
+	enum pfru_dsm_status status;
+	acpi_handle handle;
+	int ret = -EINVAL;
+
+	handle = ACPI_HANDLE(pfru_log_dev->dev);
+	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_log_dev->uuid,
+					  pfru_log_dev->info.log_revid, FUNC_GET_LEV,
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
+	*level = obj->integer.value;
+	ret = 0;
+free_acpi_buffer:
+	ACPI_FREE(out_obj);
+
+	return ret;
+}
+
+static int valid_log_level(int level)
+{
+	return level == LOG_ERR || level == LOG_WARN ||
+		level == LOG_INFO || level == LOG_VERB;
+}
+
+static int valid_log_type(int type)
+{
+	return type == LOG_EXEC_IDX || type == LOG_HISTORY_IDX;
+}
+
+long pfru_log_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct pfru_log_data_info data_info;
+	struct pfru_log_info info;
+	void __user *p;
+	int ret = 0;
+
+	if (!pfru_log_dev)
+		return -ENODEV;
+
+	p = (void __user *)arg;
+
+	switch (cmd) {
+	case PFRU_LOG_IOC_SET_INFO:
+		if (copy_from_user(&info, p, sizeof(info)))
+			return -EFAULT;
+
+		if (pfru_valid_revid(info.log_revid))
+			pfru_log_dev->info.log_revid = info.log_revid;
+
+		if (valid_log_level(info.log_level)) {
+			ret = set_pfru_log_level(info.log_level);
+			if (ret)
+				return ret;
+			pfru_log_dev->info.log_level = info.log_level;
+		}
+
+		if (valid_log_type(info.log_type))
+			pfru_log_dev->info.log_type = info.log_type;
+
+		break;
+	case PFRU_LOG_IOC_GET_INFO:
+		ret = get_pfru_log_level(&info.log_level);
+		if (ret)
+			return ret;
+
+		info.log_type = pfru_log_dev->info.log_type;
+		info.log_revid = pfru_log_dev->info.log_revid;
+		if (copy_to_user(p, &info, sizeof(info)))
+			ret = -EFAULT;
+
+		break;
+	case PFRU_LOG_IOC_GET_DATA_INFO:
+		ret = get_pfru_log_data_info(&data_info, pfru_log_dev->info.log_type);
+		if (ret)
+			return ret;
+
+		if (copy_to_user(p, &data_info, sizeof(struct pfru_log_data_info)))
+			ret = -EFAULT;
+
+		break;
+	default:
+		ret = -ENOTTY;
+		break;
+	}
+	return ret;
+}
+
+ssize_t pfru_log_read(struct file *filp, char __user *ubuf,
+		      size_t size, loff_t *off)
+{
+	struct pfru_log_data_info info;
+	phys_addr_t base_addr;
+	int buf_size, ret;
+	char *buf_ptr;
+
+	if (!pfru_log_dev)
+		return -ENODEV;
+
+	if (*off < 0)
+		return -EINVAL;
+
+	ret = get_pfru_log_data_info(&info, pfru_log_dev->info.log_type);
+	if (ret)
+		return ret;
+
+	base_addr = (phys_addr_t)(info.chunk2_addr_lo | (info.chunk2_addr_hi << 32));
+	/* pfru update has not been launched yet.*/
+	if (!base_addr)
+		return -EBUSY;
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
+	if (copy_to_user(ubuf, buf_ptr + *off, size))
+		ret = -EFAULT;
+	else
+		ret = 0;
+
+	memunmap(buf_ptr);
+
+	return ret ? ret : size;
+}
 
 static int query_capability(struct pfru_update_cap_info *cap)
 {
@@ -406,7 +720,7 @@ static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		ret = start_acpi_update(START_STAGE_ACTIVATE);
 		break;
 	default:
-		ret = -ENOTTY;
+		ret = pfru_log_ioctl(file, cmd, arg);
 		break;
 	}
 
@@ -467,6 +781,7 @@ static ssize_t pfru_write(struct file *file, const char __user *buf,
 static const struct file_operations acpi_pfru_fops = {
 	.owner		= THIS_MODULE,
 	.write		= pfru_write,
+	.read		= pfru_log_read,
 	.unlocked_ioctl = pfru_ioctl,
 	.llseek		= noop_llseek,
 };
@@ -478,6 +793,44 @@ static struct miscdevice pfru_misc_dev = {
 	.fops = &acpi_pfru_fops,
 };
 
+static int acpi_pfru_log_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int acpi_pfru_log_probe(struct platform_device *pdev)
+{
+	acpi_handle handle;
+	int ret;
+
+	/* One instance is expected. */
+	if (pfru_log_dev)
+		return 0;
+
+	pfru_log_dev = kzalloc(sizeof(*pfru_log_dev), GFP_KERNEL);
+	if (!pfru_log_dev)
+		return -ENOMEM;
+
+	ret = guid_parse(PFRU_LOG_UUID, &pfru_log_dev->uuid);
+	if (ret)
+		goto out;
+
+	pfru_log_dev->info.log_revid = 1;
+	pfru_log_dev->dev = &pdev->dev;
+	handle = ACPI_HANDLE(pfru_log_dev->dev);
+	if (!acpi_has_method(handle, "_DSM")) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	return 0;
+out:
+	kfree(pfru_log_dev);
+	pfru_log_dev = NULL;
+
+	return ret;
+}
+
 static int acpi_pfru_remove(struct platform_device *pdev)
 {
 	return 0;
@@ -526,6 +879,21 @@ static int acpi_pfru_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct acpi_device_id acpi_pfru_log_ids[] = {
+	{"INTC1081", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, acpi_pfru_log_ids);
+
+static struct platform_driver acpi_pfru_log_driver = {
+	.driver = {
+		.name = "pfru_log",
+		.acpi_match_table = acpi_pfru_log_ids,
+	},
+	.probe = acpi_pfru_log_probe,
+	.remove = acpi_pfru_log_remove,
+};
+
 static const struct acpi_device_id acpi_pfru_ids[] = {
 	{"INTC1080", 0},
 	{}
@@ -549,7 +917,11 @@ static int __init pfru_init(void)
 	if (ret)
 		return ret;
 
-	return platform_driver_register(&acpi_pfru_driver);
+	ret = platform_driver_register(&acpi_pfru_driver);
+	if (ret)
+		misc_deregister(&pfru_misc_dev);
+
+	return platform_driver_register(&acpi_pfru_log_driver);
 }
 
 static void __exit pfru_exit(void)
@@ -558,6 +930,10 @@ static void __exit pfru_exit(void)
 	misc_deregister(&pfru_misc_dev);
 	kfree(pfru_dev);
 	pfru_dev = NULL;
+
+	platform_driver_unregister(&acpi_pfru_log_driver);
+	kfree(pfru_log_dev);
+	pfru_log_dev = NULL;
 }
 
 module_init(pfru_init);
diff --git a/include/uapi/linux/pfru.h b/include/uapi/linux/pfru.h
index 127fc38638cb..9ab74d9cd21a 100644
--- a/include/uapi/linux/pfru.h
+++ b/include/uapi/linux/pfru.h
@@ -99,4 +99,47 @@ struct pfru_updated_result {
 	__u64 high_exec_time;
 };
 
+#define PFRU_LOG_UUID	"75191659-8178-4D9D-B88F-AC5E5E93E8BF"
+
+/* Telemetry structures. */
+struct pfru_log_data_info {
+	enum pfru_dsm_status status;
+	enum pfru_dsm_status ext_status;
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
+struct pfru_log_info {
+	__u32 log_level;
+	__u32 log_type;
+	__u32 log_revid;
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
+#define PFRU_LOG_IOC_SET_INFO _IOW(PFRU_MAGIC, 0x05, struct pfru_log_info)
+#define PFRU_LOG_IOC_GET_INFO _IOR(PFRU_MAGIC, 0x06, struct pfru_log_info)
+#define PFRU_LOG_IOC_GET_DATA_INFO _IOR(PFRU_MAGIC, 0x07, struct pfru_log_data_info)
+
 #endif /* __PFRU_H__ */
-- 
2.25.1

