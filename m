Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A236C43F736
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 08:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhJ2Gfz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Oct 2021 02:35:55 -0400
Received: from mail-bn8nam08on2075.outbound.protection.outlook.com ([40.107.100.75]:21984
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232050AbhJ2Gfr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Oct 2021 02:35:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPuDWMLuJBLhnGEIHSylu69tyOzzgOd6dNDENsRc7fiF7ZGIRTAbclEq8dsnvVH0OXJvn9XVahd/0h8xAbUlGXi7b9OMaK/7MCtqfi+o0rw7/6tQpSJTt1TuRHFjAQBPx/fao/Lce6DgaXlyGQLF1FblEJyHuZH9I57FYU3lOwa4NaRULOj8zpeAuS+bcJXaaKeLH0kO59WDJ67U4LcNfYZK5cYPpaDlLkVAe/3W+Z7HfclYLfBgbNdq6xrh8ypf4iMQ1g2Ymmhm6rnxEkD3CNCA650Yb7lhV/0my5PrROLH6L/gDYDAmNiD4G0X6suCzV/NIow5GtrFsva1kCTNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXFa3Z4AxagLKvohaj5pp6xcSeeWL/caaeWK+OGMA6M=;
 b=BXHZ09/JseDYb7i/V2PwrMuADsP7AoWz5WLEuDwkpefGQhOXyS0QnprLi+mtO51NY3XStzrgv8kS3xSvqfPpCZXmJRlU0uONExPNKm5OqfJySlx6IYAIqWa2dxe6dTjBdbIIHvUdUrzAdVNJa9UOmsvolNoeXwhiUpgyRrdjCC5OqUNhua6BFa5Wity5UJMqy+kfZVsAaq/WifvebzhTEAIaVHSgVDUlTOSVSIaCp5hwHsOPfCuT8saIo9c0yn8pXoQCvjJA91uLv7iHT2dmeluzW2RFnoMsb15poxsmkeOCP4CLfYVQXNpR9156xTxtOfDJ32+JD7CKNZ6JSNukFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXFa3Z4AxagLKvohaj5pp6xcSeeWL/caaeWK+OGMA6M=;
 b=xdzVer3VOSBRr5hhKn70huQ4IuEE/u2Rjz2bfI2WJZl8OusxF91TPEToUhKa4qFtlWP8SYGDq8vpe/zGxp18arTyD76mMLE96FWDo6G0Gc5yCdUaq6zvNrk0qqRxkv/yiHI95HVbmFKI4B0XKmFy5ULa0NIG3PrslcJcpSNRyo4=
Received: from MWHPR08CA0040.namprd08.prod.outlook.com (2603:10b6:300:c0::14)
 by CY4PR12MB1672.namprd12.prod.outlook.com (2603:10b6:910:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 06:33:14 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::fc) by MWHPR08CA0040.outlook.office365.com
 (2603:10b6:300:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 06:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 06:33:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 01:33:13 -0500
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 01:33:10 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 RESEND 2/5] drivers: acpi: acpi_apd: Remove unused device property "is-rv"
Date:   Fri, 29 Oct 2021 12:02:25 +0530
Message-ID: <20211029063228.578909-3-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029063228.578909-1-AjitKumar.Pandey@amd.com>
References: <20211029063228.578909-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 838cea6f-d004-4052-9253-08d99aa5fc97
X-MS-TrafficTypeDiagnostic: CY4PR12MB1672:
X-Microsoft-Antispam-PRVS: <CY4PR12MB16723DACAF7E5B4652816F6382879@CY4PR12MB1672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWMTtIRO6V9bi7gypJe4vhvljdfMsIOdih39hYO3P8et3WskJ348iVhFHD5L/+ghP9L7d+2KqRcr0ZcEpngj/8XdhZ6iFyWFmhbX9KP5VjvDX3FGEdH04d5FBxvBGxpDK6JhcVUmO2VY7qAKm6Aoi3s4X0k9BhbfZcZlHnu0ZvqP16BOM/kejKq1rl5jBc3yW6Isw+N8yS4z1I7HxFpg4RTeaz5Dtj7LKSnKZ/JblcW2fn65361RxiMwVS11GwzbSBOfbjEzxF+cmiZT2bI8bOD401hKlA4IQnACitc1L1EEo5pxugmpsOokq3cLe3DdvIRjnfX+HSpCCQ+LgD5YMYWp6oBfyrVsIRfgw9TyrC7LjwGuHsGVxWRBRqmR5x6L16NeeTc27Cx9x+tng0S6WzXgOkSP7pJG3jPOm+gLun1Hivc67Tkdr26Cu8nrqngbveN6rmGkuZNTSLbxw+FK4/xcTmrNOxS7g5YTbyNgy0gvWVIVgcTVZXtaMUkie2ixtCTVe84zDJm5Py9GZZu5nd1cOJ+IxU/vhljrHJZwg7peDHkwO7AfHsXNtGrFhwg6GIOnPDJqM8BFw/VVHJ9/f9sSQOXcPyFh3zWRwx91jm3I+fAoI7t74Nuf5uQnbX2w9foLZLMVMPNpHPMq6zwe5CEJJvIonRyIUjSlx2ZNrGg/2mxkGsRwsDQ/ZSXVAW14AA6ThkERbKJWqdTFJ1fudo6E1AiQBQ3yb5O4xSHq/3U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(110136005)(356005)(2616005)(1076003)(316002)(47076005)(8676002)(5660300002)(82310400003)(186003)(83380400001)(26005)(70206006)(81166007)(86362001)(70586007)(54906003)(336012)(508600001)(4326008)(7696005)(426003)(2906002)(6666004)(8936002)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 06:33:14.6069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 838cea6f-d004-4052-9253-08d99aa5fc97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1672
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Initially "is-rv" device property is added for 48MHz fixed clock
support on Raven or RV architecture. It's unused now as we moved
to clock config based selection to extend such support on others
architecture. This change removed unused code from acpi driver.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 drivers/acpi/acpi_apd.c               | 3 ---
 include/linux/platform_data/clk-fch.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 6e02448d15d9..6913e9712852 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -87,9 +87,6 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 	if (ret < 0)
 		return -ENOENT;
 
-	if (!acpi_dev_get_property(adev, "is-rv", ACPI_TYPE_INTEGER, &obj))
-		clk_data->is_rv = obj->integer.value;
-
 	list_for_each_entry(rentry, &resource_list, node) {
 		clk_data->base = devm_ioremap(&adev->dev, rentry->res->start,
 					      resource_size(rentry->res));
diff --git a/include/linux/platform_data/clk-fch.h b/include/linux/platform_data/clk-fch.h
index b9f682459f08..850ca776156d 100644
--- a/include/linux/platform_data/clk-fch.h
+++ b/include/linux/platform_data/clk-fch.h
@@ -12,7 +12,6 @@
 
 struct fch_clk_data {
 	void __iomem *base;
-	u32 is_rv;
 };
 
 #endif /* __CLK_FCH_H */
-- 
2.25.1

