Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168CD25F5F9
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 11:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgIGJEi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 05:04:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728183AbgIGJEf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 05:04:35 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 72F71BF5C3AF71B17CE4;
        Mon,  7 Sep 2020 17:04:34 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 17:04:15 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, Ken Xue <Ken.Xue@amd.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/5] ACPI / APD: Remove the flags in struct apd_device_desc
Date:   Mon, 7 Sep 2020 16:56:18 +0800
Message-ID: <1599468981-17301-3-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1599468981-17301-1-git-send-email-guohanjun@huawei.com>
References: <1599468981-17301-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The flags is not used in anywhere, remove it and its related
code.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_apd.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 6f39289..c4bc4ab 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -23,15 +23,7 @@
 struct apd_private_data;
 
 /**
- * ACPI_APD_SYSFS : add device attributes in sysfs
- * ACPI_APD_PM : attach power domain to device
- */
-#define ACPI_APD_SYSFS	BIT(0)
-#define ACPI_APD_PM	BIT(1)
-
-/**
  * struct apd_device_desc - a descriptor for apd device
- * @flags: device flags like %ACPI_APD_SYSFS, %ACPI_APD_PM
  * @fixed_clk_rate: fixed rate input clock source for acpi device;
  *			0 means no fixed rate input clock source
  * @properties: build-in properties of the device such as UART
@@ -40,7 +32,6 @@
  * Device description defined as acpi_device_id.driver_data
  */
 struct apd_device_desc {
-	unsigned int flags;
 	unsigned int fixed_clk_rate;
 	struct property_entry *properties;
 	int (*setup)(struct apd_private_data *pdata);
-- 
1.7.12.4

