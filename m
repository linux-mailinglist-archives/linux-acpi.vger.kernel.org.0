Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E8221CCAC
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jul 2020 03:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGMBBM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 12 Jul 2020 21:01:12 -0400
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com ([40.107.92.54]:13281
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbgGMBBK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 12 Jul 2020 21:01:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuqbzZWw5eB/3bm1VLIx9hK77ylbfYOKTdQ5m77uydfJfv9nk7TJyBnMsr5w5Qz2EwC3TPBmcZ/bt9/HeKdOX2CqOdNPy1zimjyBACRbceaVhdLqTWpqtiLIRDmXHlKbYVy+J2HmyvxzzarwDtG7xZiLg0dHYpf8PPw48y2NaGt+ckV0ly6OxLEhXaAbkIcgNIeDhPesmSBwzlB5Zt1Q9YzGOmqHp8mk3Rb6EXSzocuIibj+exjBvOOYy6RpVJk8BdQii9eOzcj2TpHW28ylrzVIrey6kF0WO9Ycu6yvEQO19aN2r69huWvWh5MpmV6YVa8UeTEsWWPS5HB13o7UeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg23GWQxOXVPN9lG8c190hSKuu6xf2gHNLBKYE7EQyU=;
 b=DzXazzNf2cBzKsmwbZRkPx5egQ26EMcj6BF527wPXtFyPvSLI/VmlPJLHPLmZiXyjVK9jDnAzeQtoSPD3LH/ubfONbm+LIQohmXpEHVIJIiIlO7gql1bdPpEEvgEND/AJFJebJ8vbdau/IG/xnb+jkIZ3t/rqEgap9oNaLXwoNtiRr4k/YWgcUi/NUwDUM3ncUaVraz7yKIHkIAs1OaA7E9bSyuJOgAy3ickuYi+xN9BuVi2Mcggm0KSG5LrQF+BGYj6sVfXFsj2IoSlPVunHqbpHula4LLK7fIsPCUuW+/Rz26virin+xyLyvjXVl7rnpBbyW7YTeCDrDAMgzjChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg23GWQxOXVPN9lG8c190hSKuu6xf2gHNLBKYE7EQyU=;
 b=jmNcGWe+v1+xKweaDNft5LXdn5smyS+GUh3cat8kBALvoRnKgTW672+TJhxECk/33HeOi96tK8AChLji9F5nxCgMSNjTlZ0PStPUhHPBI0bJrl3eW5of3AGVToQli5Fk87Fn1V76e+H3gKNYeGqFQMbVh8zr8nob7ofPitt+PNk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1600.namprd12.prod.outlook.com (2603:10b6:301:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 01:01:03 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3174.025; Mon, 13 Jul
 2020 01:01:03 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] ACPI: APD: Change name from ST to FCH
Date:   Mon, 13 Jul 2020 06:29:49 +0530
Message-Id: <20200713010001.18976-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::18) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.167.38.75) by MAXPR0101CA0056.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Mon, 13 Jul 2020 01:01:00 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.167.38.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76dde9fe-1276-4d6f-eb2b-08d826c83703
X-MS-TrafficTypeDiagnostic: MWHPR12MB1600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB160073108A94A6BA56909976F8600@MWHPR12MB1600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hc/rTk8V9EkAOKpTpg7vfGfWzwpoSvYdvdwgzZQsIiLXSkTqT8DEza2BpcErGEzvScnTglt6t8CExowHg2wPviK/AT6OjnNLDG4O2/EtWkLz4Er9Zczlspijm4zqFFZbNoeRfeOn6cuwjhn6aVip4ZmLkJv7JkBFHWwMo2LgoaoEzxA0hM+61WcpWc+5PPy84TBf7Ct9D3Z5IyZI4jNGxAk5crqG7mDfiYsSrrike2h/sJ2MY8JNXGmlyKBcIlbuP6Bzla1bEvfYg68Qdq0z0NMi4AeNdwYUY2lfVh4qjWa5c8dnRzoqD3UoTLHjJVv9HXniIVzUlv6uSHFGi3DiLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(52116002)(478600001)(2906002)(1076003)(54906003)(316002)(6666004)(34206002)(4326008)(8936002)(6506007)(37006003)(5660300002)(186003)(956004)(83380400001)(2616005)(16526019)(44832011)(6512007)(36756003)(26005)(66556008)(66476007)(86362001)(66946007)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WbPyfZ6nEtsRAvTKW0SwOFgjU9AcOvNkuWrPBJj6h48gCvBb3SGEiOEWDdxfWSt2zTCmWdQUVClI+2betExRNbTduTTMQPEehAfpaID1N+pgaDlIQdNUl/HEA/CRZ2+p0YidN5eEyPSdlt2SW/nXKGCx+voLR1lGUm5S8YHIvhrq6FxOIpDtvpla0GlLEO689ZrYWfdtPfSv38AnOgHBw61ILqq+CZ1ok2ImJN5esIBVmsZ1XMEGZXtfx3HKKAKs0CQqW5Ig0SPzHP+dXePcYMFic17u3J6fPCn+y7RCzzJPVXWCK3+VAPNfhOQIUWCP7UFUAf4oOEqV0clYzcz2xSfKkycAj+EUSgLN7g3DYiFcr0tPcAK7YZj0Bhhzwl8mcsQhu5uiTIaL9tPny3DIHpIBLc4+yOP/qj0+ASs+rN0i+XBdi8efXfQLbhq3aJV2/Fpp/fsAgcW8dH9NVuNZbYiGuvtigc1PRfsTOgpymBs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dde9fe-1276-4d6f-eb2b-08d826c83703
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 01:01:03.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrqTtGu/BvI3lRODtKf9+juM6boeBGZvH2EC3DLJW+pa5xO0Kk+9l4Hw55fJUvshZ8vsIYTkYKZPH9V2qAgl/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1600
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

