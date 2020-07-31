Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386CC234705
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jul 2020 15:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgGaNgy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 09:36:54 -0400
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com ([40.107.236.45]:9312
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730813AbgGaNgx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jul 2020 09:36:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDq85AUT9w50a4m0kwgw/u8un0anub7Iv5naMJzEdu23/aC69mcvnt7rpLJKl6RrzwZCsviPXF9AvNOodlCU4vI8gxIj3lSjur8ch56eh5MM25gbtW9i03vlMw9+CRokJdiHD0mOdElNeIhIQtHG83sAWj0FSJGlzSCQip08yEmrZ62HF9QwKgWwdu/yU3Kv9EWeSj21iddyDwuIRd7+w4ZAuCYyc+fTWEVINitpzuMxQZezTvIhIUeCvaQJWw30iMpm4Clnse6vwpoj6RSDa+A/PzKEj1f7wnqHveFv6oWwk8whfV4Yj9WIzII/eFLTsDYsbpgZ6mf07ByZdDFKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnuoHU51xAjQLYJR40DSwaV9lNK8v+NXJXNfmGodU1I=;
 b=ca+JXFfoyj2jmVkv3NppdhY+vUTddGDwQ7rT+LzgP9IUTZsPIujeNzIXPqYzBPSyoDGftBeJRNSTdJUDV6Q5UPE4pHOIpiG1ELqhjzTzDWZw/dF501/JM5v9nOOvhJ2WPzMokf5ihjERaow6HQ01fQB1nP2F5qXc21fpAmnlo0yj0RUj2r+7IXR6tcC9wsOI8pGhLGuNpS19752BL34iZu8IU6psjnUwUFGcFxmxTQLSLAMdKcn04hMoawDMJ8B+AOBgRd18JpuuHwyi5ymnPY1ZSNya7NU0HKShvd3QDeXSnXJjEFSprlM1+6IohqoFyanx0bzScTkIbkQnf7WCXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnuoHU51xAjQLYJR40DSwaV9lNK8v+NXJXNfmGodU1I=;
 b=Ti2cu2G+e2ys/xUgzIpF3H9kI6CkUU7iWgf2r98+mwP9PgGGbFYemlOGlweGqUT28Ij7gZWDp0g8GYbnuPM7j9Vdr+WINlRuJuP39R7HptXFpIW4lxGcSNQJC3vP4XuN0AfzXjFXn3utqwr4RG0wspBNd0v6+YjOMpmeMYN6N8A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM6PR12MB3257.namprd12.prod.outlook.com (2603:10b6:5:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 13:36:50 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::4df1:4ad8:38cd:128c]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::4df1:4ad8:38cd:128c%7]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 13:36:50 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, rafael@kernel.org, rjw@rjwysocki.net,
        lenb@kernel.org, mturquette@baylibre.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rahul.tanwar@linux.intel.com
Subject: [v2 1/4] ACPI: APD: Change name from ST to FCH
Date:   Fri, 31 Jul 2020 19:06:01 +0530
Message-Id: <20200731133604.12512-2-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200731133604.12512-1-akshu.agrawal@amd.com>
References: <20200731133604.12512-1-akshu.agrawal@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To DM5PR1201MB0188.namprd12.prod.outlook.com
 (2603:10b6:4:56::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.179.42.211) by MAXPR01CA0072.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 13:36:47 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.179.42.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb8aa7a7-f2f7-4120-bd8d-08d83556c78f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3257:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB325771D2200B1D1637DDEF51F84E0@DM6PR12MB3257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQHrbkl6i+oHBAx2vvy9skPd+99DMji9B1CRkFvaBm+6f+9bWvOVm12/Ui5Be56q2hdzlH8qzptCpKEqoKMfioqa+Lnt1mwXUAtVmjgQXQRtbe65zylTvWyr5QLUjo1uYHLrk5hD6JjM12Hciub2dhy1iN6Z4Go4umbfYW94CMgcrQXpA6VOpmiSwE1UFZh2Tb0rfq5jF1Rp50BGcSULVI79H+TwKa5KkU4IkMPu/+qVLZAE3hZ/Ji+O8wOr+hX9+GeTZaqnEaHJv7AcueJMEuqcQYu98jd1ZRc+rcoI5UQZeUWGtwWNPONNo98MgiFrBzJOYHnTb6hOFcBJ2w632A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(66476007)(66556008)(66946007)(4326008)(44832011)(52116002)(36756003)(6506007)(34206002)(2616005)(316002)(956004)(186003)(26005)(16526019)(37006003)(1076003)(6486002)(478600001)(6666004)(2906002)(8676002)(83380400001)(5660300002)(8936002)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bpqvIYW8V9PyJ7gJz+XlWhv4qSO24421nlFem425N0AjQix9FARDWquiEv6Flb2GJkyWHp2SjiVMWAH+JVjvE+7NKCdUJrLMJ+u23N0hzSHYGJ3seuQ5t+kBZmHADWqIzyMg0/uPKnd2EPNgp48Ci79itVkbCq+JJkYO/EeEHd/4sO3r8Hzwet4pCd6uDSZN2dc+XMZq3hrbS1oewG69y5CYeIMCYBYVxcP7LeFA+QiMhF8vFp2rDuh+HJuZoUhF2Z/mUBjScDQ/2TMj96RarNjbNuVrWG2GJpztDvvKW9elAWEgKOZRhbiGChbixja71MBA+xoPryhEVvTHHoIx2L7MPjsDhbomAilXY9Xklzu1hZy0sZqR4u9ERuN4JmDxKCa1tnyzQLv9iYIRKjxcyuNp0QrmwQsv4DAsNfyqZaRdwtTpvy349eEq5Qa06vdbV25BZ86ryhFtefx8tlb5P5gMvZZ8jvSt2P1WfNjuydO+ong+AVEfxrs+cDD/AlRNt2FIqNgMeg1Z3P459qFPvzbhKhHjqK5BBkxfZovy+wJb6c+KGdq79z2arU6fbVwF4NcvB81NnP3hVaHRo7y1aK0sx4s5TLY92Y33R0zmV7lfBkop1v3dc51e8GU6mS30nBb3oLrBbUuz+t779RZ1EQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8aa7a7-f2f7-4120-bd8d-08d83556c78f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 13:36:50.7409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gAd35MVCtCTJ0Mc4gK5h546jBl7HdD5awz761oDJyeSxMTiM43Em5enKUn0Zmy3s1ceA1ZP2V1vw709I5BBQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

AMD SoC general pupose clk is present in new platforms with
same MMIO mappings. We can reuse the same clk handler support
for other platforms. Hence, changing name from ST(SoC) to FCH(IP)

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
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

