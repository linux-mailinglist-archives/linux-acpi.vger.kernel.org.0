Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0542045D8C7
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Nov 2021 12:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhKYLKe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Nov 2021 06:10:34 -0500
Received: from mail-co1nam11on2070.outbound.protection.outlook.com ([40.107.220.70]:47328
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231466AbhKYLJG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Nov 2021 06:09:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMzlWgZ11+SnGCWx/ZenzLQTXsgw6RiqnoQyiqH5qNGnQ1dL8xVeuQkDtUk3OyO/VpQ7aOY8B0CpJdjIv5aUuwdv6j+TmsbBq0nMoRsfWUJcB0Tbe6neJtn80wJbAIcJNJanHXPeQV0lXFyM5lat1BnoCKERGoEg6TSDnXZ+4x3Tr2SCXwDfv1LJK17S2ogQGTdvVql6J1QTkbEr9Dx4jtte0sG+2M7FOsSxWjanahNNLW/oZB+RDRb6tUOxQdywLZEvQK8CW/q+D9Q6kQ7w/jJH4m7sFJvVBruQRe5GJZiTEd1yQEFYcdqa1eLXy8gDWwj0XeE6FtgGGAkQLnw+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOU8C6Y7znkiFBHiwjZb0jtsjd1uW6pExmiRuMBLTIE=;
 b=Vue3iWXb0xkBCRJKoJnPnsxdme6LhSRah/LdNHr/hoNmKzBZNwY4UGEt9LkYOARuOHDQsRoU59NIQtqsV8dFID4lv1x314kNiUjwfBsVvoZcYQN44oNfP9FRJnF3UMelky8QoRNvLeYrJw9G8nEKn8BVZIB3xl4JqJ1v+5mvc41ztQOmd1cTeKsY5cdYaYqiTW2TFL5QJHFA8PWb92CNmQzeBkKD7CEQgEsQ9qib+67QeI0VVI2bTsk9eQ1ZqL5Y6LXMUst2OPRowEVJHwOMTj9ITD00CV5liBea5MWps7iofWEd1UrZ91CF1rJITACyPH7xIYAwV1pnwXGz0I6FTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOU8C6Y7znkiFBHiwjZb0jtsjd1uW6pExmiRuMBLTIE=;
 b=CFVDjI7zHgLAJZT02b7R8wKZ4E+CuDl9fhYL9e4LfE0OsOdGEjaiz7IopizrzTrrr7U3rsz7sVabiVaI5tXdg2MEboKZQ7Xdx6+Q+vqeckVEOh1WS3fH3oZWaN1BoCZSOc8kGQwib/vleMI/sjjrBU6xNT4RYA8LEOOFO2ATig0=
Received: from MW4PR03CA0266.namprd03.prod.outlook.com (2603:10b6:303:b4::31)
 by DM6PR12MB3386.namprd12.prod.outlook.com (2603:10b6:5:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 11:05:54 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::13) by MW4PR03CA0266.outlook.office365.com
 (2603:10b6:303:b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 11:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 11:05:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 05:05:50 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 05:05:47 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <rafael@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/7] drivers: acpi: acpi_apd: Remove unused device property "is-rv"
Date:   Thu, 25 Nov 2021 16:34:42 +0530
Message-ID: <20211125110447.1188073-3-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
References: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a8cd40e-a8a5-4049-8ca5-08d9b0038c74
X-MS-TrafficTypeDiagnostic: DM6PR12MB3386:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3386BDBD8DBBE73F41C57CE182629@DM6PR12MB3386.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4x1q3a+GSBywA2QN9zJFvAp75AEqGyN2J+2/PCyKMKPoPIDV/O5wukFnepF/AmnEKto0MoRXTJPvlmVAEmb0UUxobWQBwkmOyXYzpFazKw0nH9B24sz9EYSDH4A3BugKTOr7jcnHz0JJd3GRpEvbbeuCy1zqwjGdidLlt5Wv7g2QlPrmHCzRZFiovWnMxajzBnYUMR5D10d5KC/lhcpZVDZPDldHL/Da7MbbFFP+RKnHmA5zOXlQ4g9WBeO+Lr1z6cs/BJZjG4aqluzolIHVRQUA82tqhjBd52rBp8iwwwQXqFeIsgKL30sq97wXqjzNkybYWKiMIcFKrMEFiSoHZJp04ye7xyRhuaj7lczbdhuV3KaMq/xoqKECYU3lTlNsY/vnUP3FeP7sV4XiJJGzdO1VlnnX8swTC/8SBgNMYQTOxUfw3X8jr9kfKPQD+2WJDkHNwUP3fHTgrupzOzG0sHGVsDbTosvF7Zc+v1jdPXtDCucCvj3GBQyNtbLcMrMD5EHzXGr98RtVJ2aHFmshBlGQkbwmCavAvCmsbhVi9hyptD5VDm8StJB8H7mtrGCT5tI5pGiHiIf97Z7mJVRMkMb3SrjD6JEirNDebAS6DZvGEIzLk1CiAriz578ELUd5v2Xitcss+JpHKPMWIA5tDToSIIv/0j3EpKtQvpa8jhYzqgB+9Yg56lgvIGIlq6mB8/tJLD5/bmOUiDI/VM+t5VSrQc9hkhmmMVEO4OL/9A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8676002)(82310400004)(83380400001)(6666004)(36756003)(81166007)(26005)(2616005)(316002)(110136005)(8936002)(36860700001)(508600001)(5660300002)(426003)(186003)(356005)(86362001)(2906002)(47076005)(7696005)(70206006)(1076003)(54906003)(70586007)(336012)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 11:05:53.5885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8cd40e-a8a5-4049-8ca5-08d9b0038c74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3386
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Initially "is-rv" device property is added for 48MHz fixed clock
support on Raven or RV architecture. It's unused now as we moved
to pci device_id based selection to extend such support on other
architectures. This change removed unused code from acpi driver.

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

