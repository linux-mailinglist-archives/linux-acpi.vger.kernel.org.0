Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD38D14B369
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 12:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgA1LSO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 06:18:14 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbgA1LSO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 06:18:14 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4F0272D8AA78D8510173;
        Tue, 28 Jan 2020 19:18:10 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 28 Jan 2020 19:18:02 +0800
From:   John Garry <john.garry@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <jeremy.linton@arm.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <guohanjun@huawei.com>, <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
Date:   Tue, 28 Jan 2020 19:14:19 +0800
Message-ID: <1580210059-199540-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a generic driver for platforms which populate their ACPI PPTT
processor package ID Type Structure according to suggestion in the ACPI
spec - see ACPI 6.2, section 5.2.29.3 ID structure Type 2.

The soc_id is from member LEVEL_2_ID.

For this, we need to use a whitelist of platforms which are known to
populate the structure as suggested.

For now, only the vendor and soc_id fields are exposed.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/soc/Makefile       |   1 +
 drivers/soc/acpi_generic.c | 102 +++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 drivers/soc/acpi_generic.c

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 8b49d782a1ab..2a59a30a22cd 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the Linux Kernel SOC specific device drivers.
 #
 
+obj-$(CONFIG_ACPI_PPTT)		+= acpi_generic.o
 obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
 obj-$(CONFIG_SOC_ASPEED)	+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
diff --git a/drivers/soc/acpi_generic.c b/drivers/soc/acpi_generic.c
new file mode 100644
index 000000000000..34a1f5f8e063
--- /dev/null
+++ b/drivers/soc/acpi_generic.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) John Garry, john.garry@huawei.com
+ */
+
+#define pr_fmt(fmt) "SOC ACPI GENERIC: " fmt
+
+#include <linux/acpi.h>
+#include <linux/sys_soc.h>
+
+/*
+ * Known platforms that fill in PPTT package ID structures according to
+ * ACPI spec examples, that being:
+ * - Custom driver attribute is in ID Type Structure VENDOR_ID member
+ * - SoC id is in ID Type Structure LEVEL_2_ID member
+ *    See ACPI SPEC 6.2 Table 5-154 for PPTT ID Type Structure
+ */
+static struct acpi_platform_list plat_list[] = {
+	{"HISI  ", "HIP08   ", 0, ACPI_SIG_PPTT, all_versions},
+	{ } /* End */
+};
+
+struct acpi_generic_soc_struct {
+	struct soc_device_attribute dev_attr;
+	u32 vendor;
+};
+
+static ssize_t vendor_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct acpi_generic_soc_struct *soc = dev_get_drvdata(dev);
+	u8 vendor_id[5] = {};
+
+	*(u32 *)vendor_id = soc->vendor;
+
+	return sprintf(buf, "%s\n", vendor_id);
+}
+
+static DEVICE_ATTR_RO(vendor);
+
+static __init int soc_acpi_generic_init(void)
+{
+	int index;
+
+	index = acpi_match_platform_list(plat_list);
+	if (index < 0)
+		return -ENOENT;
+
+	index = 0;
+	while (true) {
+		struct acpi_pptt_package_info info;
+
+		if (!acpi_pptt_get_package_info(index, &info)) {
+			struct soc_device_attribute *soc_dev_attr;
+			struct acpi_generic_soc_struct *soc;
+			struct soc_device *soc_dev;
+			u8 soc_id[9] = {};
+
+			*(u64 *)soc_id = info.LEVEL_2_ID;
+
+			soc = kzalloc(sizeof(*soc), GFP_KERNEL);
+			if (!soc)
+				return -ENOMEM;
+
+			soc_dev_attr = &soc->dev_attr;
+			soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s",
+							 soc_id);
+			if (!soc_dev_attr->soc_id) {
+				kfree(soc);
+				return -ENOMEM;
+			}
+			soc->vendor = info.vendor_id;
+
+			soc_dev = soc_device_register(soc_dev_attr);
+			if (IS_ERR(soc_dev)) {
+				int ret = PTR_ERR(soc_dev);
+
+				pr_info("could not register soc (%d) index=%d\n",
+					ret, index);
+				kfree(soc_dev_attr->soc_id);
+				kfree(soc);
+				return ret;
+			}
+			dev_set_drvdata(soc_device_to_device(soc_dev), soc);
+			device_create_file(soc_device_to_device(soc_dev),
+					   &dev_attr_vendor);
+		} else {
+			break;
+		}
+
+		index++;
+	}
+
+	return 0;
+}
+
+module_init(soc_acpi_generic_init);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("John Garry <john.garry@huawei.com>");
+MODULE_DESCRIPTION("Generic ACPI soc driver");
-- 
2.17.1

