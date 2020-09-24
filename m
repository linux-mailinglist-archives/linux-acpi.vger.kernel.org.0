Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899F72766B4
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 05:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgIXDFU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Sep 2020 23:05:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbgIXDFR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Sep 2020 23:05:17 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A41DE7418F1220EBC608;
        Thu, 24 Sep 2020 11:05:15 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 11:05:05 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 05/15] ACPI: container: Remove the leftover ACPICA debug functionality
Date:   Thu, 24 Sep 2020 10:56:57 +0800
Message-ID: <1600916227-21805-6-git-send-email-guohanjun@huawei.com>
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

After commit 737f1a9f8082 ("ACPI / scan: Make container driver use
struct acpi_scan_handler"), ACPICA debug print function calls were
removed, so the leftover ACPICA debug functionality is useless,
remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/container.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 9ea5f55..ccaa647 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -14,9 +14,6 @@
 
 #include "internal.h"
 
-#define _COMPONENT			ACPI_CONTAINER_COMPONENT
-ACPI_MODULE_NAME("container");
-
 static const struct acpi_device_id container_device_ids[] = {
 	{"ACPI0004", 0},
 	{"PNP0A05", 0},
-- 
1.7.12.4

