Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43479230564
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jul 2020 10:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgG1I36 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jul 2020 04:29:58 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:8118
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727808AbgG1I36 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jul 2020 04:29:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n027egEwmP22aMKEpngza1VPUkEV/TxItiMSpNNPdDaCXKcjr9RoPzd8NLux1wZ34CTIO0Nc+6LWKRjSQgNqwdRgboeuVlDmr8OVDXdZ6Kuolkq+fFEsUWxzDrKJOtu2/R1FjQYItuwqUvrLPUfdS4BTjly3vDyVnxKGE4fKXu8JqLn5+TBl17B9OBUauCesB+lt43FOGk3AeisfRPlUG1W/t7TBN0AVfK4FDaah7AZ+25U4o3bk2orVcomBZRs5FOzWgpz0TNsC4GPdymOifiOU8lJl8zXk9csSqCpfAvm6xivByEX+Sxwh13ldLgvSoytLxMTmtV8ilC+ohjRSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gerId6zYYsgGdvC3Xj70QYeu6uZXRQSjuwpeKNiV02I=;
 b=OAONg+PfMeYG+HxrAKO/iMbCvZwV1QxmLvbo+I0DH7xyJwrMIjWhwESEPftVkRFvujoN0bdx8etOVtUAMA/LtjQCRYMWaJ0PymuT0f/smx9jtHsUk3OcPWrtn6rTQtFigdWQnqowXwUyZqlvvmPibKkBt2APWRQZp/EyXvLb5x2IN7v7RmR/phAuEJtvjrEkQbMOpOh2ImAZFwGA/38UvXhupaY9YbzZE7N06rZzNpCHqNhOheG1MmwKykuUSKMsAdkRRliCTflFizhYfWuX+ezgL1+Jo45niO2FbYCm6gKxvWlevHiAbwjBIbG1MrBnU1/LasGhXvQI+LCNYnuZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gerId6zYYsgGdvC3Xj70QYeu6uZXRQSjuwpeKNiV02I=;
 b=kAusXYrFiXn44pV8OzETJg0XyR9ayT1EdIpjz3bpwRBrcJ4xsbTUcBiGk2ge4xyol1aoeD2ZVXu9WBkxs6JOxlgxv6pXRsMP1bCH27Vn1Gc0B5fy1VcmzFGVrUpeOqWhBpUsM3lxsZpKSvqVOIBaKlsVvrn6w2r4TVXqpne1fkg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM5PR12MB1468.namprd12.prod.outlook.com (2603:10b6:4:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Tue, 28 Jul
 2020 08:29:54 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e%10]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 08:29:54 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, rafael@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list),
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK)
Subject: [v2 1/4] ACPI: APD: Change name from ST to FCH
Date:   Tue, 28 Jul 2020 13:58:53 +0530
Message-Id: <20200728082857.10829-2-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200728082857.10829-1-akshu.agrawal@amd.com>
References: <20200728082857.10829-1-akshu.agrawal@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::30) To DM5PR1201MB0188.namprd12.prod.outlook.com
 (2603:10b6:4:56::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.171.179.172) by MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 08:29:51 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7d80102-af8e-44ba-ccc4-08d832d0678d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1468FD58CDB4773C50036059F8730@DM5PR12MB1468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkWhDqz1DpgyzGvQh2P/A7WoV7AB/Dp5KTKZ6/ODunxD/QRZf/xtGbx9jZmuN2uJKAgjU9JgRG+79b/fcJZzD7eOdzUvmcy/qIBkeml4BVfbw9SVCiJrx1DZ1zDWp8fwKcWkQWImxg41uiqRZ4QmK4IUjAMeso0AjWIdLYlTSk6etY2e16E0wHkiyjSnqSMr+rNWi0d3SuYs3YzMCJGuu2muVi1RXROlDmGscGLkQ/rcumHX8dlMYqLUuOiFbWDZ3caClWdgUDBydtosbtN78N4IT3JafbRgjvEuZQnjbA5ejuxvRCrhhpz8t1lTEIn3iIll/IeJJ5U1+7RmaXqSOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(956004)(2616005)(8936002)(44832011)(5660300002)(36756003)(316002)(6512007)(54906003)(66476007)(478600001)(34206002)(37006003)(6486002)(66946007)(86362001)(66556008)(26005)(186003)(2906002)(8676002)(16526019)(52116002)(4326008)(83380400001)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: z9xkkENLNdqbdWpSKGe9zDP0sXttlzEtDmWabcNtY5OLAiGnSqa/3rosEufcHVgqFYzAHEU9j2vnACL2VqINxinCD4HXhZz5FJ2wWl9ChhmCkYgl8J9zqdQcczx0RjfPie4gdeA7afvxw+onuwNhj+YPklC9dQlA7W5PpDAzv/B7rZCUtmsmr+1qFUGJNDsUidYFmZ2ccdMV6rUTQyWjxM9HsStV77jMnDEVNM/1dxnpDF2Y92TTnl53mXbxUptASNDbldKnzM4uownjy2NuO5Hom5PUks+bTBReFb6EmY88vpE5D7bzAyxyc2rSpSKJiq2w752dP2JLt7oGf7Vv16id6QjAl5flg79FKWPhp/CT3fuip5BGTze3xFugG+GKJShZO6y7G8lLdDuVPlkBYI+AQGwLF6DKUOH+haV91BXTcPY3bzo+eeqjY3G7UsR0YXqzZLY5nXWmZObBydbr7XsVzMxae/A9rt+PsyZCjS1zJXmsYoj7M4HDP2aWQSp0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d80102-af8e-44ba-ccc4-08d832d0678d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 08:29:54.7186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0X94GK4YDVYrYU/bFpfGYiw5QhKgs5LPf0bSn07fM+GN9cve2H1D1sgfrv2Dtujqa7WINafxXP/POxajFdcnQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1468
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

AMD SoC general pupose clk is present in new platforms with
same MMIO mappings. We can reuse the same clk handler support
for other platforms. Hence, changing name from ST(SoC) to FCH(IP)

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: pulled in clk changes so that patch compiles individually

 drivers/acpi/acpi_apd.c                            | 14 +++++++-------
 drivers/clk/x86/clk-st.c                           |  4 ++--
 .../linux/platform_data/{clk-st.h => clk-fch.h}    | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)
 rename include/linux/platform_data/{clk-st.h => clk-fch.h} (53%)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index ba2612e9a0eb..2d99e46add1a 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/platform_data/clk-st.h>
+#include <linux/platform_data/clk-fch.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/clkdev.h>
@@ -79,11 +79,11 @@ static int misc_check_res(struct acpi_resource *ares, void *data)
 	return !acpi_dev_resource_memory(ares, &res);
 }
 
-static int st_misc_setup(struct apd_private_data *pdata)
+static int fch_misc_setup(struct apd_private_data *pdata)
 {
 	struct acpi_device *adev = pdata->adev;
 	struct platform_device *clkdev;
-	struct st_clk_data *clk_data;
+	struct fch_clk_data *clk_data;
 	struct resource_entry *rentry;
 	struct list_head resource_list;
 	int ret;
@@ -106,7 +106,7 @@ static int st_misc_setup(struct apd_private_data *pdata)
 
 	acpi_dev_free_resource_list(&resource_list);
 
-	clkdev = platform_device_register_data(&adev->dev, "clk-st",
+	clkdev = platform_device_register_data(&adev->dev, "clk-fch",
 					       PLATFORM_DEVID_NONE, clk_data,
 					       sizeof(*clk_data));
 	return PTR_ERR_OR_ZERO(clkdev);
@@ -135,8 +135,8 @@ static const struct apd_device_desc cz_uart_desc = {
 	.properties = uart_properties,
 };
 
-static const struct apd_device_desc st_misc_desc = {
-	.setup = st_misc_setup,
+static const struct apd_device_desc fch_misc_desc = {
+	.setup = fch_misc_setup,
 };
 #endif
 
@@ -239,7 +239,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	{ "AMD0020", APD_ADDR(cz_uart_desc) },
 	{ "AMDI0020", APD_ADDR(cz_uart_desc) },
 	{ "AMD0030", },
-	{ "AMD0040", APD_ADDR(st_misc_desc)},
+	{ "AMD0040", APD_ADDR(fch_misc_desc)},
 #endif
 #ifdef CONFIG_ARM64
 	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
index 25d4b97aff9b..c2438874d9f2 100644
--- a/drivers/clk/x86/clk-st.c
+++ b/drivers/clk/x86/clk-st.c
@@ -8,7 +8,7 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
-#include <linux/platform_data/clk-st.h>
+#include <linux/platform_data/clk-fch.h>
 #include <linux/platform_device.h>
 
 /* Clock Driving Strength 2 register */
@@ -31,7 +31,7 @@ static struct clk_hw *hws[ST_MAX_CLKS];
 
 static int st_clk_probe(struct platform_device *pdev)
 {
-	struct st_clk_data *st_data;
+	struct fch_clk_data *st_data;
 
 	st_data = dev_get_platdata(&pdev->dev);
 	if (!st_data || !st_data->base)
diff --git a/include/linux/platform_data/clk-st.h b/include/linux/platform_data/clk-fch.h
similarity index 53%
rename from include/linux/platform_data/clk-st.h
rename to include/linux/platform_data/clk-fch.h
index 7cdb6a402b35..850ca776156d 100644
--- a/include/linux/platform_data/clk-st.h
+++ b/include/linux/platform_data/clk-fch.h
@@ -1,17 +1,17 @@
 /* SPDX-License-Identifier: MIT */
 /*
- * clock framework for AMD Stoney based clock
+ * clock framework for AMD misc clocks
  *
  * Copyright 2018 Advanced Micro Devices, Inc.
  */
 
-#ifndef __CLK_ST_H
-#define __CLK_ST_H
+#ifndef __CLK_FCH_H
+#define __CLK_FCH_H
 
 #include <linux/compiler.h>
 
-struct st_clk_data {
+struct fch_clk_data {
 	void __iomem *base;
 };
 
-#endif /* __CLK_ST_H */
+#endif /* __CLK_FCH_H */
-- 
2.20.1

