Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6903226D6B8
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 10:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIQIee (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 04:34:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726309AbgIQIe2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:34:28 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AB4AFB4D60F344B7E445;
        Thu, 17 Sep 2020 15:47:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:51 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 16/25] ACPI: processor: Remove the dead ACPICA debug code
Date:   Thu, 17 Sep 2020 15:38:56 +0800
Message-ID: <1600328345-27627-17-git-send-email-guohanjun@huawei.com>
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

