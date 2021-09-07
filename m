Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3084402BAD
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 17:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345133AbhIGPYy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 11:24:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:28928 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345088AbhIGPYy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Sep 2021 11:24:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="220279636"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="220279636"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 08:23:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="538018383"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.176])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2021 08:23:41 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alexander Graf <graf@amazon.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH 3/5][RFC] drivers/acpi: Introduce Platform Firmware Runtime Update device driver
Date:   Tue,  7 Sep 2021 23:27:42 +0800
Message-Id: <9b2bd7d1e40633ce6f4845fb5c9e30a3faad5e7a.1631025237.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631025237.git.yu.c.chen@intel.com>
References: <cover.1631025237.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Introduce the pfru_update driver which can be used for Platform Firmware
Runtime code injection and driver update. The user is expected to provide
the update firmware in the form of capsule file, and pass it to the driver
via ioctl. Then the driver would hand this capsule file to the Platform
Firmware Runtime Update via the ACPI device _DSM method. At last the low
level Management Mode would do the firmware update.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/acpi/Kconfig                          |   1 +
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/pfru/Kconfig                     |  15 +
 drivers/acpi/pfru/Makefile                    |   2 +
 drivers/acpi/pfru/pfru_update.c               | 544 ++++++++++++++++++
 include/uapi/linux/pfru.h                     | 106 ++++
 7 files changed, 670 insertions(+)
 create mode 100644 drivers/acpi/pfru/Kconfig
 create mode 100644 drivers/acpi/pfru/Makefile
 create mode 100644 drivers/acpi/pfru/pfru_update.c
 create mode 100644 include/uapi/linux/pfru.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 1409e40e6345..976920c404dc 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -365,6 +365,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:aherrman@de.ibm.com>
 0xE5  00-3F  linux/fuse.h
 0xEC  00-01  drivers/platform/chrome/cros_ec_dev.h                   ChromeOS EC driver
+0xEE  00-1F  uapi/linux/pfru.h                                       Platform Firmware Runtime Update and Telemetry
 0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                     sisfb (in development)
                                                                      <mailto:thomas@winischhofer.net>
 0xF6  all                                                            LTTng Linux Trace Toolkit Next Generation
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 8f9940f40baa..e7f721bed20d 100644
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
index 000000000000..3f31b7d95f3b
--- /dev/null
+++ b/drivers/acpi/pfru/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+config ACPI_PFRU
+	tristate "ACPI Platform Firmware Runtime Update (PFRU)"
+	depends on 64BIT
+	help
+	  In order to reduce the system reboot times and update the platform firmware
+	  in time, Platform Firmware Runtime Update is leveraged to patch the system
+	  without reboot. This driver supports Platform Firmware Runtime Update,
+	  which is composed of two parts: code injection and driver update.
+
+	  For more information, see:
+	  <file:Documentation/x86/pfru_update.rst>
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
index 000000000000..3ddf42e6d355
--- /dev/null
+++ b/drivers/acpi/pfru/pfru_update.c
@@ -0,0 +1,544 @@
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
+struct pfru_device {
+	guid_t uuid;
+	int rev_id;
+	struct device *dev;
+};
+
+static struct pfru_device pfru_dev;
+static struct pfru_device *get_pfru_dev(void)
+{
+	return &pfru_dev;
+}
+
+static int query_capability(struct update_cap_info *cap)
+{
+	union acpi_object *out_obj;
+	struct pfru_device *pf_dev;
+	acpi_handle handle;
+	int i, ret = -EINVAL;
+
+	pf_dev = get_pfru_dev();
+	handle = ACPI_HANDLE(pf_dev->dev);
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pf_dev->uuid,
+					  pf_dev->rev_id, FUNC_QUERY_UPDATE_CAP,
+					  NULL, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return -EINVAL;
+
+	for (i = 0; i < out_obj->package.count; i++) {
+		union acpi_object *obj = &out_obj->package.elements[i];
+
+		switch (i) {
+		case 0:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			cap->status = obj->integer.value;
+			break;
+		case 1:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			cap->update_cap = obj->integer.value;
+			break;
+		case 2:
+			if (obj->type != ACPI_TYPE_BUFFER)
+				goto free_acpi_buffer;
+			memcpy(&cap->code_type, obj->buffer.pointer,
+			       obj->buffer.length);
+			break;
+		case 3:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			cap->fw_version = obj->integer.value;
+			break;
+		case 4:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			cap->code_rt_version = obj->integer.value;
+			break;
+		case 5:
+			if (obj->type != ACPI_TYPE_BUFFER)
+				goto free_acpi_buffer;
+			memcpy(&cap->drv_type, obj->buffer.pointer,
+			       obj->buffer.length);
+			break;
+		case 6:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			cap->drv_rt_version = obj->integer.value;
+			break;
+		case 7:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			cap->drv_svn = obj->integer.value;
+			break;
+		case 8:
+			if (obj->type != ACPI_TYPE_BUFFER)
+				goto free_acpi_buffer;
+			memcpy(&cap->platform_id, obj->buffer.pointer,
+			       obj->buffer.length);
+			break;
+		case 9:
+			if (obj->type != ACPI_TYPE_BUFFER)
+				goto free_acpi_buffer;
+			memcpy(&cap->oem_id, obj->buffer.pointer,
+			       obj->buffer.length);
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
+static int query_buffer(struct com_buf_info *info)
+{
+	union acpi_object *out_obj;
+	struct pfru_device *pf_dev;
+	acpi_handle handle;
+	int i, ret = -EINVAL;
+
+	pf_dev = get_pfru_dev();
+	handle = ACPI_HANDLE(pf_dev->dev);
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pf_dev->uuid,
+					  pf_dev->rev_id, FUNC_QUERY_BUF,
+					  NULL, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return -EINVAL;
+
+	for (i = 0; i < out_obj->package.count; i++) {
+		union acpi_object *obj = &out_obj->package.elements[i];
+
+		switch (i) {
+		case 0:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			info->status = obj->integer.value;
+			break;
+		case 1:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			info->ext_status = obj->integer.value;
+			break;
+		case 2:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			info->addr_lo = obj->integer.value;
+			break;
+		case 3:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			info->addr_hi = obj->integer.value;
+			break;
+		case 4:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			info->buf_size = obj->integer.value;
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
+static int get_image_type(efi_manage_capsule_image_header_t *img_hdr,
+			  int *type)
+{
+	int ret;
+	guid_t code_inj_id, drv_update_id, *image_type_id;
+
+	ret = guid_parse(PFRU_CODE_INJ_UUID, &code_inj_id);
+	if (ret)
+		return ret;
+	ret = guid_parse(PFRU_DRV_UPDATE_UUID, &drv_update_id);
+	if (ret)
+		return ret;
+	/* check whether this is a code injection or driver update */
+	image_type_id = &img_hdr->image_type_id;
+	if (guid_equal(image_type_id, &code_inj_id))
+		*type = CODE_INJECT_TYPE;
+	else if (guid_equal(image_type_id, &drv_update_id))
+		*type = DRIVER_UPDATE_TYPE;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * The (u64 hw_ins) was introduced in UEFI spec version 2,
+ * and (u64 capsule_support) was introduced in version 3.
+ * The size needs to be adjusted accordingly.
+ */
+static int adjust_efi_size(efi_manage_capsule_image_header_t *img_hdr,
+			   int *size)
+{
+	int tmp_size = *size;
+
+	tmp_size += sizeof(efi_manage_capsule_image_header_t);
+	switch (img_hdr->ver) {
+	case 1:
+		tmp_size -= 2 * sizeof(u64);
+		break;
+	case 2:
+		tmp_size -= sizeof(u64);
+		break;
+	default:
+		/* only support version 1 and 2 */
+		return -EINVAL;
+	}
+	*size = tmp_size;
+
+	return 0;
+}
+
+/*
+ * Sanity check if the capsule image has a newer version than current one.
+ * Return: true if it is valid, false otherwise.
+ */
+static bool valid_version(const void *data, struct update_cap_info *cap)
+{
+	struct payload_hdr *payload_hdr;
+	efi_capsule_header_t *cap_hdr;
+	efi_manage_capsule_header_t *m_hdr;
+	efi_manage_capsule_image_header_t *m_img_hdr;
+	efi_image_auth_t *auth;
+	int type, size, ret;
+
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
+	ret = get_image_type(m_img_hdr, &type);
+	if (ret)
+		return false;
+
+	ret = adjust_efi_size(m_img_hdr, &size);
+	if (ret)
+		return false;
+
+	auth = (efi_image_auth_t *)(data + size);
+	size += sizeof(u64) + auth->auth_info.hdr.len;
+	payload_hdr = (struct payload_hdr *)(data + size);
+
+	/* Finally, compare the version. */
+	if (type == CODE_INJECT_TYPE)
+		return payload_hdr->rt_ver >= cap->code_rt_version;
+	else
+		return payload_hdr->rt_ver >= cap->drv_rt_version;
+}
+
+static void parse_update_result(struct updated_result *result)
+{
+	pr_debug("Update result:\n");
+	pr_debug("Status:%d\n", result->status);
+	pr_debug("Extended Status:%d\n", result->ext_status);
+	pr_debug("Authentication Time Low:%ld\n", result->low_auth_time);
+	pr_debug("Authentication Time High:%ld\n", result->high_auth_time);
+	pr_debug("Execution Time Low:%ld\n", result->low_exec_time);
+	pr_debug("Execution Time High:%ld\n", result->high_exec_time);
+}
+
+static int start_acpi_update(int action)
+{
+	union acpi_object *out_obj, in_obj, in_buf;
+	struct updated_result update_result;
+	acpi_handle handle;
+	struct pfru_device *pf_dev;
+	int i, ret = -EINVAL;
+
+	pf_dev = get_pfru_dev();
+	memset(&in_obj, 0, sizeof(in_obj));
+	memset(&in_buf, 0, sizeof(in_buf));
+	in_obj.type = ACPI_TYPE_PACKAGE;
+	in_obj.package.count = 1;
+	in_obj.package.elements = &in_buf;
+	in_buf.type = ACPI_TYPE_INTEGER;
+	in_buf.integer.value = action;
+
+	handle = ACPI_HANDLE(pf_dev->dev);
+	out_obj = acpi_evaluate_dsm_typed(handle, &pf_dev->uuid,
+					  pf_dev->rev_id, FUNC_START,
+					  &in_obj, ACPI_TYPE_PACKAGE);
+	if (!out_obj)
+		return -EINVAL;
+
+	for (i = 0; i < out_obj->package.count; i++) {
+		union acpi_object *obj = &out_obj->package.elements[i];
+
+		switch (i) {
+		case 0:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			update_result.status = obj->integer.value;
+			break;
+		case 1:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			update_result.ext_status = obj->integer.value;
+			break;
+		case 2:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			update_result.low_auth_time = obj->integer.value;
+			break;
+		case 3:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			update_result.high_auth_time = obj->integer.value;
+			break;
+		case 4:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			update_result.low_exec_time = obj->integer.value;
+			break;
+		case 5:
+			if (obj->type != ACPI_TYPE_INTEGER)
+				goto free_acpi_buffer;
+			update_result.high_exec_time = obj->integer.value;
+			break;
+		}
+	}
+	parse_update_result(&update_result);
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
+	void __user *p;
+	int ret = 0, rev;
+	struct pfru_device *pf_dev;
+
+	pf_dev = get_pfru_dev();
+
+	p = (void __user *)arg;
+
+	switch (cmd) {
+	case PFRU_IOC_SET_REV:
+		if (copy_from_user(&rev, p, sizeof(unsigned int)))
+			return -EFAULT;
+		if (!valid_revid(rev))
+			return -EFAULT;
+		pf_dev->rev_id = rev;
+		break;
+	case PFRU_IOC_STAGE:
+		ret = start_acpi_update(START_STAGE);
+		if (ret)
+			return ret;
+		break;
+	case PFRU_IOC_ACTIVATE:
+		ret = start_acpi_update(START_ACTIVATE);
+		if (ret)
+			return ret;
+		break;
+	case PFRU_IOC_STAGE_ACTIVATE:
+		ret = start_acpi_update(START_STAGE_ACTIVATE);
+		if (ret)
+			return ret;
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_COMPAT
+static long compat_pfru_ioctl(struct file *filep, unsigned int cmd,
+			      unsigned long arg)
+{
+	return pfru_ioctl(filep, cmd, arg);
+}
+#endif
+
+static int pfru_open(struct inode *inode, struct file *file)
+{
+	return capable(CAP_SYS_RAWIO) ? stream_open(inode, file) : -EPERM;
+}
+
+static ssize_t pfru_write(struct file *file, const char __user *buf,
+			  size_t len, loff_t *ppos)
+{
+	struct update_cap_info cap;
+	struct com_buf_info info;
+	phys_addr_t phy_addr;
+	struct iov_iter iter;
+	struct iovec iov;
+	char *buf_ptr;
+	int ret;
+
+	ret = query_buffer(&info);
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
+	if (!copy_from_iter_full(buf_ptr, len, &iter)) {
+		pr_err("error! could not read capsule file\n");
+		ret = -EINVAL;
+		goto unmap;
+	}
+
+	/* Check if the capsule header has a valid version number. */
+	ret = query_capability(&cap);
+	if (ret)
+		goto unmap;
+
+	if (cap.status != DSM_SUCCEED) {
+		ret = -EBUSY;
+		goto unmap;
+	}
+	if (!valid_version(buf_ptr, &cap)) {
+		ret = -EINVAL;
+		goto unmap;
+	}
+	ret = 0;
+unmap:
+	memunmap(buf_ptr);
+
+	return ret ?: len;
+}
+
+static ssize_t pfru_read(struct file *filp, char __user *ubuf,
+			 size_t size, loff_t *off)
+{
+	struct update_cap_info cap;
+	int ret;
+
+	ret = query_capability(&cap);
+	if (ret)
+		return ret;
+
+	size = min_t(size_t, size, sizeof(cap));
+
+	if (copy_to_user(ubuf, &cap, size))
+		return -EFAULT;
+
+	return size;
+}
+
+static const struct file_operations acpi_pfru_fops = {
+	.owner		= THIS_MODULE,
+	.write		= pfru_write,
+	.read		= pfru_read,
+	.open		= pfru_open,
+	.unlocked_ioctl = pfru_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= compat_pfru_ioctl,
+#endif
+	.llseek		= noop_llseek,
+};
+
+static struct miscdevice pfru_misc_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "pfru_update",
+	.nodename = "pfru/update",
+	.fops = &acpi_pfru_fops,
+};
+
+static int acpi_pfru_remove(struct platform_device *pdev)
+{
+	misc_deregister(&pfru_misc_dev);
+
+	return 0;
+}
+
+static int acpi_pfru_probe(struct platform_device *pdev)
+{
+	acpi_handle handle;
+	struct pfru_device *pf_dev;
+	int ret;
+
+	pf_dev = get_pfru_dev();
+
+	ret = guid_parse(PFRU_UUID, &pf_dev->uuid);
+	if (ret)
+		return ret;
+	/* default rev id is 1 */
+	pf_dev->rev_id = 1;
+	pf_dev->dev = &pdev->dev;
+	handle = ACPI_HANDLE(pf_dev->dev);
+	if (!acpi_has_method(handle, "_DSM")) {
+		pr_err("Missing _DSM\n");
+		return -ENODEV;
+	}
+
+	ret = misc_register(&pfru_misc_dev);
+	if (ret)
+		return ret;
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
+module_platform_driver(acpi_pfru_driver);
+
+MODULE_DESCRIPTION("Platform Firmware Runtime Update device driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/pfru.h b/include/uapi/linux/pfru.h
new file mode 100644
index 000000000000..81eb8ad5a57e
--- /dev/null
+++ b/include/uapi/linux/pfru.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Platform Firmware Runtime Update header
+ *
+ * Copyright(c) 2021 Intel Corporation. All rights reserved.
+ */
+#ifndef __PFRU_H__
+#define __PFRU_H__
+
+#include <linux/ioctl.h>
+#include <linux/uuid.h>
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
+#define PFRU_IOC_SET_REV _IOW(PFRU_MAGIC, 0x01, unsigned int)
+#define PFRU_IOC_STAGE _IOW(PFRU_MAGIC, 0x02, unsigned int)
+#define PFRU_IOC_ACTIVATE _IOW(PFRU_MAGIC, 0x03, unsigned int)
+#define PFRU_IOC_STAGE_ACTIVATE _IOW(PFRU_MAGIC, 0x04, unsigned int)
+
+static inline int valid_revid(int id)
+{
+	return (id == REVID_1) || (id == REVID_2);
+}
+
+/* Capsule file payload header */
+struct payload_hdr {
+	__u32	sig;
+	__u32	hdr_version;
+	__u32	hdr_size;
+	__u32	hw_ver;
+	__u32	rt_ver;
+	guid_t	platform_id;
+};
+
+enum start_action {
+	START_STAGE,
+	START_ACTIVATE,
+	START_STAGE_ACTIVATE,
+};
+
+enum dsm_status {
+	DSM_SUCCEED,
+	DSM_FUNC_NOT_SUPPORT,
+	DSM_INVAL_INPUT,
+	DSM_HARDWARE_ERR,
+	DSM_RETRY_SUGGESTED,
+	DSM_UNKNOWN,
+	DSM_FUNC_SPEC_ERR,
+};
+
+struct update_cap_info {
+	enum dsm_status status;
+	int update_cap;
+
+	guid_t code_type;
+	int fw_version;
+	int code_rt_version;
+
+	guid_t drv_type;
+	int drv_rt_version;
+	int drv_svn;
+
+	guid_t platform_id;
+	guid_t oem_id;
+
+	char oem_info[];
+};
+
+struct com_buf_info {
+	enum dsm_status status;
+	enum dsm_status ext_status;
+	unsigned long addr_lo;
+	unsigned long addr_hi;
+	int buf_size;
+};
+
+struct capsulate_buf_info {
+	unsigned long src;
+	int size;
+};
+
+struct updated_result {
+	enum dsm_status status;
+	enum dsm_status ext_status;
+	unsigned long low_auth_time;
+	unsigned long high_auth_time;
+	unsigned long low_exec_time;
+	unsigned long high_exec_time;
+};
+
+#endif /* __PFRU_H__ */
-- 
2.25.1

