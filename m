Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE832B1432
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 03:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgKMCRN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 21:17:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7493 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgKMCRN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 21:17:13 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CXMYB71CTzhkym;
        Fri, 13 Nov 2020 10:17:02 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 10:16:59 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI: processor: Remove the duplicated ACPI_PROCESSOR_CLASS macro
Date:   Fri, 13 Nov 2020 10:08:44 +0800
Message-ID: <1605233324-19524-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI_PROCESSOR_CLASS macro is defined in <acpi/processor.h>,
and ACPI drivers for processor already included <acpi/processor.h>,
so we can remove those duplicated ACPI_PROCESSOR_CLASS macros.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/processor_idle.c       | 1 -
 drivers/acpi/processor_perflib.c    | 1 -
 drivers/acpi/processor_thermal.c    | 2 --
 drivers/acpi/processor_throttling.c | 1 -
 4 files changed, 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f66236c..d93e400 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -31,7 +31,6 @@
 #include <asm/apic.h>
 #endif
 
-#define ACPI_PROCESSOR_CLASS            "processor"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_idle");
 
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index b04a689..3b5a964 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -22,7 +22,6 @@
 
 #define PREFIX "ACPI: "
 
-#define ACPI_PROCESSOR_CLASS		"processor"
 #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_perflib");
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 6c7d05b..677a132 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -19,8 +19,6 @@
 
 #define PREFIX "ACPI: "
 
-#define ACPI_PROCESSOR_CLASS            "processor"
-
 #ifdef CONFIG_CPU_FREQ
 
 /* If a passive cooling situation is detected, primarily CPUfreq is used, as it
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index a0bd56e..b187653 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -22,7 +22,6 @@
 
 #define PREFIX "ACPI: "
 
-#define ACPI_PROCESSOR_CLASS            "processor"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_throttling");
 
-- 
1.7.12.4

