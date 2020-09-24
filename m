Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEE82766AC
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 05:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgIXDFN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Sep 2020 23:05:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbgIXDFM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Sep 2020 23:05:12 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 963C722ED23BC1309E79;
        Thu, 24 Sep 2020 11:05:10 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 11:05:03 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 01/15] ACPI: cmos_rtc: Remove the leftover ACPICA code ACPI_MODULE_NAME()
Date:   Thu, 24 Sep 2020 10:56:53 +0800
Message-ID: <1600916227-21805-2-git-send-email-guohanjun@huawei.com>
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

ACPI_MODULE_NAME() is only needed for ACPICA debug functionality
such as ACPI_DEBUG_PRINT() which is not used in acpi_cmos_rtc.c,
remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_cmos_rtc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/acpi_cmos_rtc.c b/drivers/acpi/acpi_cmos_rtc.c
index 33ac6cb..67f1d33 100644
--- a/drivers/acpi/acpi_cmos_rtc.c
+++ b/drivers/acpi/acpi_cmos_rtc.c
@@ -15,8 +15,6 @@
 
 #include "internal.h"
 
-ACPI_MODULE_NAME("cmos rtc");
-
 static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
 	{ "PNP0B00" },
 	{ "PNP0B01" },
-- 
1.7.12.4

