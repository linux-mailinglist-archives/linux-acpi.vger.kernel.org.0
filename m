Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CC8260341
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 19:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgIGNGC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 09:06:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729233AbgIGNFb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 09:05:31 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A47082F6D9D99B302CF1;
        Mon,  7 Sep 2020 21:05:29 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 21:05:06 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, <lkp@intel.com>,
        Ken Xue <Ken.Xue@amd.com>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 1/5] ACPI / APD: Add kernel doc for the properties in struct apd_device_desc
Date:   Mon, 7 Sep 2020 20:57:29 +0800
Message-ID: <1599483453-26635-2-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1599483453-26635-1-git-send-email-guohanjun@huawei.com>
References: <1599483453-26635-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

commit 7ff55d174cbf ("ACPI / APD: Provide build-in properties of the
UART") add the 'struct property_entry *properties' in struct
apd_device_desc but didn't add the kernel doc, add it now.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_apd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 4c34837..6f39289 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -34,6 +34,7 @@
  * @flags: device flags like %ACPI_APD_SYSFS, %ACPI_APD_PM
  * @fixed_clk_rate: fixed rate input clock source for acpi device;
  *			0 means no fixed rate input clock source
+ * @properties: build-in properties of the device such as UART
  * @setup: a hook routine to set device resource during create platform device
  *
  * Device description defined as acpi_device_id.driver_data
-- 
1.7.12.4

