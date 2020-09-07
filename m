Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D33F260343
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 19:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgIGRqt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 13:46:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729380AbgIGNFb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 09:05:31 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9556C89E6AA31CAB50C0;
        Mon,  7 Sep 2020 21:05:29 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 21:05:08 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, <lkp@intel.com>,
        Ken Xue <Ken.Xue@amd.com>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 4/5] ACPI / APD: Remove the unneeded APD_ADDR(desc) macro define
Date:   Mon, 7 Sep 2020 20:57:32 +0800
Message-ID: <1599483453-26635-5-git-send-email-guohanjun@huawei.com>
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

Since APD_ADDR(desc) is only used when CONFIG_X86_AMD_PLATFORM_DEVICE or
CONFIG_ARM64 is set, no need for the redundant
'#define APD_ADDR(desc) (0UL)', remove it.

Also update the comments for #endif.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_apd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 4dbf85b..561d9ba 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -62,7 +62,6 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
 }
 
 #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
-
 static int misc_check_res(struct acpi_resource *ares, void *data)
 {
 	struct resource res;
@@ -133,7 +132,7 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 static const struct apd_device_desc fch_misc_desc = {
 	.setup = fch_misc_setup,
 };
-#endif
+#endif /* CONFIG_X86_AMD_PLATFORM_DEVICE */
 
 #ifdef CONFIG_ARM64
 static const struct apd_device_desc xgene_i2c_desc = {
@@ -175,13 +174,9 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 250000000,
 };
-#endif
+#endif /* CONFIG_ARM64 */
 
-#else
-
-#define APD_ADDR(desc) (0UL)
-
-#endif /* CONFIG_X86_AMD_PLATFORM_DEVICE */
+#endif
 
 /**
 * Create platform device during acpi scan attach handle.
-- 
1.7.12.4

