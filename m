Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1351437B89
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 19:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhJVRNp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 13:13:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:14665 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233851AbhJVRNP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Oct 2021 13:13:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="210131918"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="210131918"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 10:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="633393215"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.176])
  by fmsmga001.fm.intel.com with ESMTP; 22 Oct 2021 10:10:53 -0700
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
Subject: [PATCH v5 3/4] drivers/acpi: Introduce Platform Firmware Runtime Update Telemetry
Date:   Sat, 23 Oct 2021 01:10:19 +0800
Message-Id: <066c428ef56f6c268d1180eb7e51643f21416f70.1634899519.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634899519.git.yu.c.chen@intel.com>
References: <cover.1634899519.git.yu.c.chen@intel.com>
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

The corresponding userspace tool and man page will be introduced at
tools/power/acpi/pfru.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
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
 drivers/acpi/pfru/pfru_update.c | 428 +++++++++++++++++++++++++++++++-
 include/uapi/linux/pfru.h       |  94 +++++++
 2 files changed, 521 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pfru/pfru_update.c b/drivers/acpi/pfru/pfru_update.c
index 5f7b27486255..97931e0668fc 100644
--- a/drivers/acpi/pfru/pfru_update.c
+++ b/drivers/acpi/pfru/pfru_update.c
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/mm.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
@@ -55,6 +56,28 @@ enum update_index {
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
+	struct miscdevice miscdev;
+};
+
 struct pfru_device {
 	guid_t uuid, code_uuid, drv_uuid;
 	int rev_id;
@@ -67,6 +90,397 @@ static inline struct pfru_device *to_pfru_dev(struct file *file)
 	return container_of(file->private_data, struct pfru_device, miscdev);
 }
 
+/************************** telemetry begin ************************/
+
+static inline struct pfru_log_device *to_pfru_log_dev(struct file *file)
+{
+	return container_of(file->private_data, struct pfru_log_device, miscdev);
+}
+
+static int get_pfru_log_data_info(struct pfru_log_data_info *data_info,
+				  struct pfru_log_device *pfru_log_dev)
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
+	in_buf.integer.value = pfru_log_dev->info.log_type;
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
+static int set_pfru_log_level(int level, struct pfru_log_device *pfru_log_dev)
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
+static int get_pfru_log_level(struct pfru_log_device *pfru_log_dev)
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
+	ret = obj->integer.value;
+
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
+static long pfru_log_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct pfru_log_device *pfru_log_dev;
+	struct pfru_log_data_info data_info;
+	struct pfru_log_info info;
+	void __user *p;
+	int ret = 0;
+
+	pfru_log_dev = to_pfru_log_dev(file);
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
+		break;
+	case PFRU_LOG_IOC_GET_INFO:
+		info.log_level = get_pfru_log_level(pfru_log_dev);
+		if (ret < 0)
+			return ret;
+
+		info.log_type = pfru_log_dev->info.log_type;
+		info.log_revid = pfru_log_dev->info.log_revid;
+		if (copy_to_user(p, &info, sizeof(info)))
+			ret = -EFAULT;
+
+		break;
+	case PFRU_LOG_IOC_GET_DATA_INFO:
+		ret = get_pfru_log_data_info(&data_info, pfru_log_dev);
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
+	/* Changing from read to write with mprotect is not allowed. */
+	vma->vm_flags &= ~VM_MAYWRITE;
+
+	pfru_log_dev = to_pfru_log_dev(file);
+
+	ret = get_pfru_log_data_info(&info, pfru_log_dev);
+	if (ret)
+		return ret;
+
+	base_addr = (phys_addr_t)(info.chunk2_addr_lo | (info.chunk2_addr_hi << 32));
+	/* pfru update has not been launched yet.*/
+	if (!base_addr)
+		return -EBUSY;
+
+	psize = info.max_data_size;
+	/* Base address and total buffer size must be page aligned. */
+	if (!PAGE_ALIGNED(base_addr) || !PAGE_ALIGNED(psize))
+		return -EINVAL;
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
+static int acpi_pfru_log_probe(struct platform_device *pdev)
+{
+	struct pfru_log_device *pfru_log_dev;
+	acpi_handle handle;
+	static int pfru_log_idx;
+	int ret;
+
+	pfru_log_dev = devm_kzalloc(&pdev->dev, sizeof(*pfru_log_dev), GFP_KERNEL);
+	if (!pfru_log_dev)
+		return -ENOMEM;
+
+	ret = guid_parse(PFRU_LOG_UUID, &pfru_log_dev->uuid);
+	if (ret)
+		goto out;
+
+	/* default rev id is 1 */
+	pfru_log_dev->info.log_revid = 1;
+	pfru_log_dev->dev = &pdev->dev;
+	handle = ACPI_HANDLE(pfru_log_dev->dev);
+	if (!acpi_has_method(handle, "_DSM")) {
+		dev_dbg(&pdev->dev, "Missing _DSM\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	pfru_log_dev->miscdev.minor = MISC_DYNAMIC_MINOR;
+	pfru_log_dev->miscdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						    "pfru_telemetry%d",
+						    pfru_log_idx);
+	if (!pfru_log_dev->miscdev.name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pfru_log_dev->miscdev.nodename = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+							"acpi_pfru_telemetry%d",
+							pfru_log_idx);
+	if (!pfru_log_dev->miscdev.nodename) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pfru_log_idx++;
+	pfru_log_dev->miscdev.fops = &acpi_pfru_log_fops;
+
+	ret = misc_register(&pfru_log_dev->miscdev);
+	if (ret)
+		goto out;
+
+	platform_set_drvdata(pdev, pfru_log_dev);
+
+	return 0;
+out:
+	devm_kfree(&pdev->dev, pfru_log_dev);
+
+	return ret;
+}
+
+static const struct acpi_device_id acpi_pfru_log_ids[] = {
+	{"INTC1081", 0},
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
+
+/************************** telemetry end   *************************/
+
 static int query_capability(struct pfru_update_cap_info *cap,
 			    struct pfru_device *pfru_dev)
 {
@@ -569,11 +983,23 @@ static struct platform_driver acpi_pfru_driver = {
 
 static int __init pfru_init(void)
 {
-	return platform_driver_register(&acpi_pfru_driver);
+	int ret = platform_driver_register(&acpi_pfru_driver);
+
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&acpi_pfru_log_driver);
+	if (ret) {
+		platform_driver_unregister(&acpi_pfru_driver);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void __exit pfru_exit(void)
 {
+	platform_driver_unregister(&acpi_pfru_log_driver);
 	platform_driver_unregister(&acpi_pfru_driver);
 }
 
diff --git a/include/uapi/linux/pfru.h b/include/uapi/linux/pfru.h
index 8c6df9f8764c..01f0224f3d0a 100644
--- a/include/uapi/linux/pfru.h
+++ b/include/uapi/linux/pfru.h
@@ -181,4 +181,98 @@ struct pfru_updated_result {
 	__u64 high_exec_time;
 };
 
+#define PFRU_LOG_UUID	"75191659-8178-4D9D-B88F-AC5E5E93E8BF"
+
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
+/**
+ * PFRU_LOG_IOC_SET_INFO - _IOW(PFRU_MAGIC, 0x06,
+ *				struct pfru_log_info)
+ *
+ * Return: 0 on success, -errno on failure.
+ *
+ * Set the PFRU log level and log type. The input information is
+ * a struct pfru_log_info.
+ */
+#define PFRU_LOG_IOC_SET_INFO _IOW(PFRU_MAGIC, 0x06, struct pfru_log_info)
+/**
+ * PFRU_LOG_IOC_GET_INFO - _IOR(PFRU_MAGIC, 0x07,
+ *				struct pfru_log_info)
+ *
+ * Return: 0 on success, -errno on failure.
+ *
+ * Retrieve log level and log type of the PFRU telemetry. The information is
+ * a struct pfru_log_info.
+ */
+#define PFRU_LOG_IOC_GET_INFO _IOR(PFRU_MAGIC, 0x07, struct pfru_log_info)
+/**
+ * PFRU_LOG_IOC_GET_DATA_INFO - _IOR(PFRU_MAGIC, 0x08,
+ *				     struct pfru_log_data_info)
+ *
+ * Return: 0 on success, -errno on failure.
+ *
+ * Retrieve data information about the PFRU telemetry. The information
+ * is a struct pfru_log_data_info.
+ */
+#define PFRU_LOG_IOC_GET_DATA_INFO _IOR(PFRU_MAGIC, 0x08, struct pfru_log_data_info)
+
 #endif /* __PFRU_H__ */
-- 
2.25.1

