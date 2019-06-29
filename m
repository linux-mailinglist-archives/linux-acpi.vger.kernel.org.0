Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D74E85A89C
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jun 2019 04:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfF2CpB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jun 2019 22:45:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726766AbfF2Coy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Jun 2019 22:44:54 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3471AF8A73B0CB831ABA;
        Sat, 29 Jun 2019 10:44:51 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Sat, 29 Jun 2019 10:44:42 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH v2 1/3] ACPI / scan: evaluate _STA for processors declared via ASL Device statement
Date:   Sat, 29 Jun 2019 10:42:33 +0800
Message-ID: <1561776155-38975-2-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1561776155-38975-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1561776155-38975-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When we scan all the acpi namespace node in
acpi_scan_init()->acpi_bus_scan(), we evaluate '_STA' method for processor
type node to determine whether the device is present. But processors can
also be declared via ASL Device statement. ACPI 6.3 spec specifically
says that the Processor statement is deprecated and a Device statement
should be used for processors. In that case, acpi_object_type is
ACPI_TYPE_DEVICE rather than ACPI_TYPE_PROCESSOR.

Current code doesn't evaluate '_STA' for nodes with ACPI_TYPE_DEVICE, and
the device status is set to 'present' as default. This patch get the
device status from '_STA' method for processors declared via ASL Device
statement if it does have a '_STA' method.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

---
I am not sure if I should set 'type' as ACPI_BUS_TYPE_PROCESSOR rather
than ACPI_BUS_TYPE_DEVICE for processors declared via ASL Device
statement.
---
 drivers/acpi/scan.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0e28270..cec43f6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -16,6 +16,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/x86/apple.h>
 
+#include <acpi/processor.h>
 #include <asm/pgtable.h>
 
 #include "internal.h"
@@ -1687,6 +1688,7 @@ static int acpi_bus_type_and_status(acpi_handle handle, int *type,
 {
 	acpi_status status;
 	acpi_object_type acpi_type;
+	struct acpi_device_info *info;
 
 	status = acpi_get_type(handle, &acpi_type);
 	if (ACPI_FAILURE(status))
@@ -1699,6 +1701,16 @@ static int acpi_bus_type_and_status(acpi_handle handle, int *type,
 			return -ENODEV;
 
 		*type = ACPI_BUS_TYPE_DEVICE;
+
+		status = acpi_get_object_info(handle, &info);
+		if (ACPI_SUCCESS(status) && info->valid & ACPI_VALID_HID &&
+		    !strcmp(info->hardware_id.string,
+					ACPI_PROCESSOR_DEVICE_HID)) {
+			status = acpi_bus_get_status_handle(handle, sta);
+			if (ACPI_SUCCESS(status))
+				break;
+		}
+
 		/*
 		 * acpi_add_single_object updates this once we've an acpi_device
 		 * so that acpi_bus_get_status' quirk handling can be used.
-- 
1.7.12.4

