Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBE62766AE
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 05:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgIXDFT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Sep 2020 23:05:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726466AbgIXDFS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Sep 2020 23:05:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C4D6A8E01C395CBC3094;
        Thu, 24 Sep 2020 11:05:15 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 11:05:09 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 12/15] ACPI: processor: Remove the dead ACPICA debug code
Date:   Thu, 24 Sep 2020 10:57:04 +0800
Message-ID: <1600916227-21805-13-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1600916227-21805-1-git-send-email-guohanjun@huawei.com>
References: <1600916227-21805-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPICA debug code is not used anywhere in processor_core.c
and processor_thermal.c, remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/processor_core.c    | 3 ---
 drivers/acpi/processor_thermal.c | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index f32beb7d..2ac48cd 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -14,9 +14,6 @@
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 
-#define _COMPONENT		ACPI_PROCESSOR_COMPONENT
-ACPI_MODULE_NAME("processor_core");
-
 static struct acpi_table_madt *get_madt_table(void)
 {
 	static struct acpi_table_madt *madt;
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 41feb88..6c7d05b 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -20,8 +20,6 @@
 #define PREFIX "ACPI: "
 
 #define ACPI_PROCESSOR_CLASS            "processor"
-#define _COMPONENT              ACPI_PROCESSOR_COMPONENT
-ACPI_MODULE_NAME("processor_thermal");
 
 #ifdef CONFIG_CPU_FREQ
 
-- 
1.7.12.4

