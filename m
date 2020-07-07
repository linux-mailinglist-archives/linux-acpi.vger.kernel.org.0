Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46B72169A9
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 12:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGGKDy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jul 2020 06:03:54 -0400
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:19168
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726946AbgGGKDy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Jul 2020 06:03:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ2uV/bIcpAqSernXpNe97kPmYLM8eCLB9hgk4a42z33ibKCHlVt5YbL9fgzPwL/gu0ory0GcmZEEKZ0Umoe3WX1jC30+gvtNaMre8LNp9lcwN2nVxbhdFxknmKOrx8w9nxbgIH9IICPR3MKR46W2R093K9mHEUX2xR5ABi9fsI17PqbbiLevwrfEHZtx1ZufeWCB6y2Wp3xgpWibDe02JiyP/temuAYxdnFGGLY/X0mZn0cXyDgVlolbYpQwvfSK7r0mGh5zObKlFbSI/AzJgliGwP+A/1Z8rkGpZF/NjT628EabB/GgQ+Q2A0rPkHmTLOwJKMdz3X/liB8PziaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg23GWQxOXVPN9lG8c190hSKuu6xf2gHNLBKYE7EQyU=;
 b=GS9ao7TrpGNM8TmMlUR/rMANwAqsbKNU3cmnbf7hsxYPaaqmdqOR0yQxR3MOEB21Pxzgl3pSbij3X7n3vrjpdwXWxp92IBj+WGSOaHRuFT8K4hR3bi7ZiOb1pOjswtTduAh4X41Q+Yt4X1JglZ3UFMfgF0AwcXwsXPGTn2UVIJUp+V7E7rbVouMfW4/YawwPjR7fJz3I/BZCJccK2paDdRv5wxywFEVZvhhDwmnpPxF/lV5IShZ+fH1R506RVRiznezNE2ZKEdi8IgTNc4loZ3XFTlN2+Mm0YHVJ6jfKeaXS/VsIjs25fATP1NDZ/6AV56CTz9rjUzWvAAy4XpRwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg23GWQxOXVPN9lG8c190hSKuu6xf2gHNLBKYE7EQyU=;
 b=himXqS3u+gYw0CUVusAW42/cdsLbKOF31rvB0yrSdGkd5DKqMPBZUX7/bsLR6lwMp8mnwDflxaDBitaMV1nZ/BJJcHvjKPeLTx753fi7MXWuYzA/Xukok3BkruGJfmXUaCWrnNRIuuZ76+s2o2ibG9VL56yPXzvapoDAPfn+kR0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1440.namprd12.prod.outlook.com (2603:10b6:300:13::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Tue, 7 Jul
 2020 10:03:50 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 10:03:50 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] ACPI: APD: Change name from ST to FCH
Date:   Tue,  7 Jul 2020 15:32:59 +0530
Message-Id: <20200707100320.24625-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::13) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from akshu-HP-EliteBook-745-G2.mshome.net (122.167.38.75) by MAXPR0101CA0027.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Tue, 7 Jul 2020 10:03:48 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.167.38.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd219bf1-d272-422a-9037-08d8225d0bf3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB14402B69EEB6272EDCD2B584F8660@MWHPR12MB1440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSzIj85Bn8DFT+wN0WOa+n8Oi1NszKH1bAReGt7OZ0QWazCBfVyQfTsWiTogKL6OAbqAT8ucxRYxARWju9ZXUuNkdFxqnH/WDgXFh+C2mxrGC0GIbccoBkeJ3p1BrZ69WskQteJKfqvLbN4KkPZwkTnAdOuS/3Yy09BkpG++6xmMJvgGuw8KjmJdNmhw6nKFzZDUYn8F+NgbmCLnJB8dvTSjIgoHnjb3exkrduDsAZFZeObA1DrsVlKQvlDlJPnHYi/KwNbN3fRxeg+hmoAIthDiiAFzanYYS8EZVncSNjwXnvBKgAua0pEqZnkyJc9hvjoT8IyZu/WS9rCNZMK1n8hpuL6mjdcl2CKp70qdLb4xwPKZdvy84b/zI6Mtcm8H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(6666004)(5660300002)(8676002)(186003)(16526019)(44832011)(52116002)(36756003)(4326008)(316002)(66476007)(66556008)(6486002)(86362001)(26005)(54906003)(6506007)(956004)(2616005)(8936002)(83380400001)(66946007)(2906002)(6512007)(1076003)(478600001)(109986005)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xJCA7HL3ELrGbc6t5rVdGgWRpGPC7xk38XdpoW6Z2c7PFC8IuELSW6ASOR7mIjz599/yFHLTUfkCuoEUZXrVOBFcEhF2wCz5idPCpkDXqviiDM6BcZqgWgpoGVuJOzIoJoCWLTcqfqX/L4XxYHV4BNVSZOuItM+p36KMCh6iZStOXGH2BjiX8NAUbj/1LPBzWxr/80FixkAHklVCY0G2MUV5Exd28Gk5myZ7IJys/6Qehas5bSPBpsCJM2RgN+EIxZ6cK1nuwRPk2ptG8NCJPebvHkOO22llYJ1w0h/g9RKqTPcUpU7vIzG1olmpqr03h2L3/Z8G3d0Ha8qrcMvDSucAAaKmTHWz3EtAdOZ2nHIYR8yaShm19ErybZH0A7L698YqaylNA6bEGhNMHsofw+DqzvQVQOguytd/XWUc2/Vc9lSzG+tNRBO+sLgBEcz0gGHbkjPnPeHTOqOpQDqkkFPFZYrImoyuawfhu+cZKaY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd219bf1-d272-422a-9037-08d8225d0bf3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 10:03:50.4198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zukPoF8TRo79+orHJrxuaQe1wHq/GKMFP9EBtsMGeHpt17pnuMLMwDRl7U83CWhex3D5cmtXSRmTZz/0BEdPGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1440
To:     unlisted-recipients:; (no To-header on input)
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

