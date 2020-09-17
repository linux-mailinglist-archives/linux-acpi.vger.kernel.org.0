Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7326D6B3
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 10:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgIQIe1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 04:34:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12825 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbgIQIeY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:34:24 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D20AF9B431121E084A54;
        Thu, 17 Sep 2020 15:47:05 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:55 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH RFC 24/25] ACPI: sysfs: Remove the dead debug interfaces
Date:   Thu, 17 Sep 2020 15:39:04 +0800
Message-ID: <1600328345-27627-25-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
References: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After the cleanup of the ACPICA debug functionality, some of the
ACPICA debug interfaces for ACPI drivers are not unsed anymore,
remove those interfaces.

While we are at it, update the wrong kernel doc as well.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/sysfs.c        | 18 +++++++-----------
 include/acpi/acpi_drivers.h |  8 ++------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a5cc4f3..4237256 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -18,12 +18,12 @@
 #ifdef CONFIG_ACPI_DEBUG
 /*
  * ACPI debug sysfs I/F, including:
- * /sys/modules/acpi/parameters/debug_layer
- * /sys/modules/acpi/parameters/debug_level
- * /sys/modules/acpi/parameters/trace_method_name
- * /sys/modules/acpi/parameters/trace_state
- * /sys/modules/acpi/parameters/trace_debug_layer
- * /sys/modules/acpi/parameters/trace_debug_level
+ * /sys/module/acpi/parameters/debug_layer
+ * /sys/module/acpi/parameters/debug_level
+ * /sys/module/acpi/parameters/trace_method_name
+ * /sys/module/acpi/parameters/trace_state
+ * /sys/module/acpi/parameters/trace_debug_layer
+ * /sys/module/acpi/parameters/trace_debug_level
  */
 
 struct acpi_dlayer {
@@ -56,14 +56,10 @@ struct acpi_dlevel {
 	ACPI_DEBUG_INIT(ACPI_AC_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_BATTERY_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_BUTTON_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_FAN_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_PCI_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_POWER_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_CONTAINER_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_SYSTEM_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_THERMAL_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_MEMORY_DEVICE_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_VIDEO_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_PROCESSOR_COMPONENT),
 };
@@ -289,7 +285,7 @@ static int param_get_trace_state(char *buffer, const struct kernel_param *kp)
 #endif /* CONFIG_ACPI_DEBUG */
 
 
-/* /sys/modules/acpi/parameters/aml_debug_output */
+/* /sys/module/acpi/parameters/aml_debug_output */
 
 module_param_named(aml_debug_output, acpi_gbl_enable_aml_debug_object,
 		   byte, 0644);
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 5eb1759..614d0a9 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -12,21 +12,17 @@
 #define ACPI_MAX_STRING			80
 
 /*
- * Please update drivers/acpi/debug.c and Documentation/firmware-guide/acpi/debug.rst
- * if you add to this list.
+ * Please update drivers/acpi/sysfs.c and Documentation/firmware-guide/acpi/debug.rst
+ * if you add to or remove from this list.
  */
 #define ACPI_BUS_COMPONENT		0x00010000
 #define ACPI_AC_COMPONENT		0x00020000
 #define ACPI_BATTERY_COMPONENT		0x00040000
 #define ACPI_BUTTON_COMPONENT		0x00080000
-#define ACPI_SBS_COMPONENT		0x00100000
-#define ACPI_FAN_COMPONENT		0x00200000
 #define ACPI_PCI_COMPONENT		0x00400000
 #define ACPI_POWER_COMPONENT		0x00800000
-#define ACPI_CONTAINER_COMPONENT	0x01000000
 #define ACPI_SYSTEM_COMPONENT		0x02000000
 #define ACPI_THERMAL_COMPONENT		0x04000000
-#define ACPI_MEMORY_DEVICE_COMPONENT	0x08000000
 #define ACPI_VIDEO_COMPONENT		0x10000000
 #define ACPI_PROCESSOR_COMPONENT	0x20000000
 
-- 
1.7.12.4

