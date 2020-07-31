Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25471234709
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jul 2020 15:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbgGaNhD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 09:37:03 -0400
Received: from mail-dm6nam12on2058.outbound.protection.outlook.com ([40.107.243.58]:45665
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730217AbgGaNhC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jul 2020 09:37:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSB3zchcrAjIjy0JpDH4k7mGkyl6GGNTVCX1crXQKOhIIOdDDcMWx9qXafAXdvbaCr31N0/067ZqudPavUZcJMMaI8excI1AW11r2Y2fuJbrAwrfTla6PCYbaFhpSEBwlWYY2z0yIOAWI42py/sz+4ZVOZasW2hYS+6CqKSnaUAZHOdZYo5V57VBImjOglC/An60Bz7kvXq1xQccw00gLUgAEPgY+58WcKTCfoMx3Pba6QgwHh4TeyUAz3+qvDPi7Fd8Eq55dY8VjG5A0enS6+4MWtkVxmdrq62QCIFOcokoW3yn+qZonUOa3aCPVJDl06Dj3yxIku3+AZsxlEBvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBaD3iHZZPWwO0VoGKbQTkFJK9ABMhMBpljlvkTVTj8=;
 b=JZDwJNaFHU1vMZxhVio6La9l60MPsa+AlztiZWf7IWU9hcVyqH0MxLTl69AC5PenUtq7KcsGB4OGk8641ANg5P/6HIkl4Hs/ZYeFyRM6mYV+wRz6nsIztcxNxaI4SQexx0Bazi6eCPpW7maM4W7W4uObVK4qxAv/cn7bi6wM1eFnVGBvFV98lVQCyK6SsS/28soXl4MgyijCknjdf623Kcj7pZQTkp0XTXeCF9uNFAIdCbD+ItTdGngifsJRSijHS13cEtFiRzxxLcggIPXda0FGbpHxgxAlf74hJbj6sImPw0MkUjRirr9Y8/NyyIGyMwD+qFh6j75863NqexoA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBaD3iHZZPWwO0VoGKbQTkFJK9ABMhMBpljlvkTVTj8=;
 b=tmCK6XBMU7zf6Gta+hXqIDMWxx1Fu4VyNrVayVuTMqG/yGGnx1Tl5NVAY7r86XHhE69rqmzFyfLNWqtC7nyY3ZTB49IrRtywmY86OD6sQu90sSeYid3wm37oVmTXQ25/i6XOoyImviOex6FQTIFF5M7vY4hGj3PB+gxcaKt/1Q8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM6PR12MB3257.namprd12.prod.outlook.com (2603:10b6:5:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 13:36:59 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::4df1:4ad8:38cd:128c]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::4df1:4ad8:38cd:128c%7]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 13:36:59 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, rafael@kernel.org, rjw@rjwysocki.net,
        lenb@kernel.org, mturquette@baylibre.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rahul.tanwar@linux.intel.com
Subject: [v2 2/4] clk: x86: Change name from ST to FCH
Date:   Fri, 31 Jul 2020 19:06:02 +0530
Message-Id: <20200731133604.12512-3-akshu.agrawal@amd.com>
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
Received: from local.mshome.net (122.179.42.211) by MAXPR01CA0072.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 13:36:56 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.179.42.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b9fb0bb-e495-4f56-6871-08d83556cca6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3257:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3257EB2AFB703B6FABE1EBE2F84E0@DM6PR12MB3257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wCTJ1M2QzsePhXkBYrO6caObwsB9W2aJLl7C0mPUfCtIyfpgiWkBdA/Wm9tro4ZlUkSMzV0inqoJ/g0gKMfePk/KZwwJMn+B1ot9RiLHyiEDPaME7T3F5Hcst0CsolkurYN+l+L6eh6eNbAFHZAsP/Rk6y5O2cPvNyisMXI5JuV4wIvE8le/0tDBArie6u62mOx7MOM60Ak2OXIOi/cwzB/tEYuXUxTq+hK3vaQBS0aJqfhKFWDmqvZCC44XIrJGG1AWjROo5J0YO+TWPEi8JzYXVcb6OoYbkW1nUbJCpGnWZzOnHb0p1xvsbK1htKgFrP1j1Ul8m80aDGIjI/oeuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(66476007)(66556008)(66946007)(4326008)(44832011)(52116002)(36756003)(6506007)(34206002)(2616005)(316002)(956004)(186003)(26005)(16526019)(37006003)(1076003)(6486002)(478600001)(6666004)(2906002)(8676002)(83380400001)(5660300002)(8936002)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QFgvD8TaQH8SMQqW27QsggXrJ7+kXy4Pn1ZIRufqHgh92/pF3GCYbmV4miEINbCWe6cFQzRsjunGDux+VvlYMJqYuF6kRYebkVM5FUN4gKOz6IbDZYOwGym6rjhfItHsEGQIkfH15Q9S2su2AfS345AsS84SLfahQGNjVXAUQKYpZ9c9kJpkVkxm2ZrlE7AOQNi6lkwrmTp919gyGK5gn7MWFvmY+3cpD8b8uxbr+l4rkpwLvGw6f0BG49NvVp/aS8RlcJ5XPdJp29b1sIlFMPpJz267ZUQdDP3s6i56uzgb6h6FpAYc0QS+OIZfuV+6UhEhMoaQVmu9qO3UEDzU+68z8dlEdN2HltV57YvLUqbKUKKoxrOsu1Oz1PO1FvOChXrpVZqa5vlGa1scaaiMei79XNAGdIK1s0z9qlJIzY0NpgK+CmbwzL+rvFzncbdNGx1KRRia+LgRMDz/lpaVHLJYyWzfrixsED6YDHesqmNaxk/DP92/YOG7sBT4VfM6Eo7ziyBnwdzvMEIdaXQtcZ7sqqW/5i24wwyJH49cnLD0cxOg65ZAfSTs/J3w46E0lR9G/BLFbnrK9nEx3vSagnzF882k3L2Lt6YnttgdTX1rX5LMD3zAxEj3T0ws/tnPcL06xa7ZX7005tYxFcVyTQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9fb0bb-e495-4f56-6871-08d83556cca6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 13:36:59.2101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvMSlpWNAJqo8Daz2OlyUgEvYu7fst34WBg1icgWv29SkhqMYNW6HKvIRU+gjNBdzuSWVDAqk1dw5v3HvA5W6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

AMD SoC general pupose clk is present in new platforms with
minor differences. We can reuse the same clk driver for other
platforms. Hence, changing name from ST(SoC) to FCH(IP)

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
v2: Moved some changes to acp:apd patch so that individual patches
compile

 drivers/clk/x86/Makefile                |  2 +-
 drivers/clk/x86/{clk-st.c => clk-fch.c} | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)
 rename drivers/clk/x86/{clk-st.c => clk-fch.c} (75%)

diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
index 7c774ea7ddeb..18564efdc651 100644
--- a/drivers/clk/x86/Makefile
+++ b/drivers/clk/x86/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
-obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-st.o
+obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-fch.o
 clk-x86-lpss-objs		:= clk-lpt.o
 obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
 obj-$(CONFIG_CLK_LGM_CGU)	+= clk-cgu.o clk-cgu-pll.o clk-lgm.o
diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-fch.c
similarity index 75%
rename from drivers/clk/x86/clk-st.c
rename to drivers/clk/x86/clk-fch.c
index c2438874d9f2..b252f0cf0628 100644
--- a/drivers/clk/x86/clk-st.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -29,12 +29,12 @@
 static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
 static struct clk_hw *hws[ST_MAX_CLKS];
 
-static int st_clk_probe(struct platform_device *pdev)
+static int fch_clk_probe(struct platform_device *pdev)
 {
-	struct fch_clk_data *st_data;
+	struct fch_clk_data *fch_data;
 
-	st_data = dev_get_platdata(&pdev->dev);
-	if (!st_data || !st_data->base)
+	fch_data = dev_get_platdata(&pdev->dev);
+	if (!fch_data || !fch_data->base)
 		return -EINVAL;
 
 	hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz", NULL, 0,
@@ -44,12 +44,12 @@ static int st_clk_probe(struct platform_device *pdev)
 
 	hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
 		clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
-		0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
+		0, fch_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
 
 	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
 
 	hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
-		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
+		0, fch_data->base + MISCCLKCNTL1, OSCCLKENB,
 		CLK_GATE_SET_TO_DISABLE, NULL);
 
 	devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE], "oscout1",
@@ -58,7 +58,7 @@ static int st_clk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int st_clk_remove(struct platform_device *pdev)
+static int fch_clk_remove(struct platform_device *pdev)
 {
 	int i;
 
@@ -67,12 +67,12 @@ static int st_clk_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver st_clk_driver = {
+static struct platform_driver fch_clk_driver = {
 	.driver = {
-		.name = "clk-st",
+		.name = "clk-fch",
 		.suppress_bind_attrs = true,
 	},
-	.probe = st_clk_probe,
-	.remove = st_clk_remove,
+	.probe = fch_clk_probe,
+	.remove = fch_clk_remove,
 };
-builtin_platform_driver(st_clk_driver);
+builtin_platform_driver(fch_clk_driver);
-- 
2.20.1

