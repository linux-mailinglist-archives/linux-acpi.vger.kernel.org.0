Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D052256ED
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jul 2020 07:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgGTFGS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jul 2020 01:06:18 -0400
Received: from mail-dm6nam10on2072.outbound.protection.outlook.com ([40.107.93.72]:62400
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbgGTFGS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Jul 2020 01:06:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8zCLHxR/ouRx9QwyfPA9ArPsN7c7/fVglxeNxYifl5fdSPn3S6gH738w+Bu+miV0xeya6Jvq9z4ytlp3wP65U/U64qwcEzQ7z4x3QPhlvHLIvmVfGXaPBZqX6Xi3OFYjgKsd/TxxzWywhLxuYw69LlhLltJ1aj0z6E1Z8tboLzamIo1R99DfC6s58D/e2hf5rJW5L6nAJZQE8nhKGNdbXJbV8RhX0pS3tQVWJQ9H8x/Nn7d3xOr2+o1thSeels49zHI6mkhCrkRU9o/CWovfQV0bwD4qDkoQ/+9Rl3kgFNIPRzRzdhsfkQXz1Go4RSsugC6bfRh3n8+mXShMVUNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg23GWQxOXVPN9lG8c190hSKuu6xf2gHNLBKYE7EQyU=;
 b=A4ZtNRbKXOvAguja+OIoRH2KjqjFh7jjTN9/qXhMU+JtWU7TdW88kreIxGaaYUFb37jQXEam+zmM6WeFbQwo6ESQOSY9Ftj6PIqXLcPuCrFGiEhMM+BwA7TsYpA24+jld9i9QbK7SJNjo1R75E2uAyPqRpaLkziuy3wuEc06qpS2W6G9XalEgrRzy3Z5uzgOmqichGELzGVtGTuuSfWds19rd0Zs+qufmoKB8gLCa6wMSaM/N+1Tpc3gxC53ZxX2dQVXLnZl1UqPR2JYx/wwtRiV1yZQ6Okgc6GVbPLJ4upx9BnVD++CSwsYsoHVOw1FOSQzGN91Sl1DxJYGrEip6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg23GWQxOXVPN9lG8c190hSKuu6xf2gHNLBKYE7EQyU=;
 b=fcnVYmajhK+2UipUoFl86mI5f/AO9DkZEBeQRbkMcNMR9vyXElqFBZXxsitP3ri78DPOiEWrpmf2hxBsHu452FPDUWEFn58YvyZvG+IZf5c2A9h5UokoyK5/kV4MYsjgjAYqDpJQhGmov+kZfhQSLAzU13tTGnl/mcSLwDF1Pjc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1853.namprd12.prod.outlook.com (2603:10b6:300:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 05:06:14 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 05:06:14 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] ACPI: APD: Change name from ST to FCH
Date:   Mon, 20 Jul 2020 10:34:56 +0530
Message-Id: <20200720050500.23357-2-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720050500.23357-1-akshu.agrawal@amd.com>
References: <20200720050500.23357-1-akshu.agrawal@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::16) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.171.179.172) by MAXPR0101CA0054.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 05:06:12 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 245f3f24-2611-4340-6d56-08d82c6aa04e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1853420C6CBF5FD234A9A985F87B0@MWHPR12MB1853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUfqBxXqSveHGgab2BTi0eWA1DqqPE6uyBzhIP2i9nBAmC1XUaXjllb03dZitaDUNsdwcg4UpdUEJZPGPXJg0KQVW3Fu5/aS+nO9mxnif46jxm2Y7zK9iL2/xwkrKSxTY821WRv09H0KxvuP8U/9Hdo5sY2CLEYcw2Ij57VjvzGMtJ4NVC3+c5v3aKuPTygRO1LUh4rC1qNI1azcui3d9p33WKF9nSBSQKDhiWpjAlZtLkXha2fxu/3nY6gJqaglWQ8rSjoBz3JqQEuD8/9lpNJE//5nDugAgmhzp703aW79faG+Ttem78FpOfE2oAHrgDO+bJ8m//DDIoxUKrG/pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(6486002)(26005)(36756003)(478600001)(2906002)(8936002)(5660300002)(66946007)(66556008)(66476007)(6512007)(6506007)(86362001)(6666004)(37006003)(186003)(83380400001)(52116002)(316002)(1076003)(956004)(2616005)(8676002)(34206002)(4326008)(16526019)(44832011)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ae9QNz8SVsLx1l3J3kBW+9ttgFkcFM5+Krh2anJl1+9+Q5WaHLXmcsZyvmpK1maUNZHPjK4DnRVwV8CdSKqLvBVMxx1jNIm6inY9oUj1Eiw8qrROWNg70plX7rF+R45isNJLcxTode6KlfOeF/wz1PKo1ixCWaC7NMML1KK6q85ohNXOPocfl6/Bit5K3LvJWYsqUJ642yRZiSHNawE4BhHRy8vd3QhyxEqGXbYLFjKEF5cWczZR5iRLWqGuggqIaWZbIPG++l6QQULYDjdbCeXw2lhdpI7Y2cwwcLwfRiyETQeXzp9I1NyGKq1lA2X667JcXbJQcIOMqYxwJtdJn26CeNCyB45WqVUrMlsASLZRO2BMNJiKyj+iBmo+XR32/5QPL9e8EqIs3xw5OMPMS7xS6cBqsyxmSGeUYH7zJFm1rUj1vvk3Ja1yvCMWPlXDyWCrvebOzCWB8WrgH+7cpKbTpF/KvvVrHUgkJ5nbj08=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245f3f24-2611-4340-6d56-08d82c6aa04e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 05:06:14.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItC5zvlr4rY+DddFAHKjmfahdXe9MMRx3uB6FsglLEsBCfz/E0HWE2RxzFhxzeC1gume4DjDtcRe6iUrINroLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1853
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

AMD SoC general pupose clk is present in new platforms with
same MMIO mappings. We can reuse the same clk handler support
for other platforms. Hence, changing name from ST(SoC) to FCH(IP)

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 drivers/acpi/acpi_apd.c                            | 14 +++++++-------
 .../linux/platform_data/{clk-st.h => clk-fch.h}    | 10 +++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)
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

