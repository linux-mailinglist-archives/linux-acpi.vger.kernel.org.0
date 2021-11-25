Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16CB45D4B6
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Nov 2021 07:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348021AbhKYG1K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Nov 2021 01:27:10 -0500
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:31520
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346900AbhKYGZK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Nov 2021 01:25:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4ro4lI7wrLuitdHedLZUzlqoU00oz7yuNGPEjFnSS0b+v51Di9z+9UOt+LEYvyPnKc4r0MKsK8t348gMMOw18x+0a81C/gHBf30+SVngydTnl0pI98RMPtvTZzEXTEAvt2F7j+oaCBwAtPuiVyCj1Hp9akyiGNPxuU2B/DMVhriRdVRpfmJzvaqtnCDf9pPentxfrdLIfzH3gbEdQVUTf7gtRK+8LrvpfL8o0FXgyX7UctU5+Hw7/yfvf0kPKh2mglkhFeIUJtGlgsfB9fUCkGo41QFHD677GQX/CPu9eP1XsNter5eYARPW5fUSqOE0eXfmWGhjH3/FTWbEkvK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYnM5mG24DGTZEIpH26Sf/F+NFIfUiPney5r6GNsd+M=;
 b=ZqbsWhxMc2vOW/D4A1pO34AEtbmJt+eObpcjmyGTQZ5W0lI/09q6wAdXC97V2031vvL/b/ilOTlHPuMs7+LMhqUcHxO0K+T2aZ1gRrz0JFcOit4Q0wvlL2MCGoXxLIA0AFAR0FfFxv25xwOB5z0vuY1EMM+i/hQB+y7KjhALB1Cvgzl90AAbtZDo+bN+5Q+tQZE/5RXZlXlXuHdOBmO0fHNPxgZZhsSYJkv6hn7BBG+aQnJaHMhdvNSC1cs2MCA+qHWDEJOFDMP+py5yW8dTSiRx323mBZPAPDb8fO7cJDK2U/CfdH7w1kowlxBVRuMHSb/lOMpdUluHuEVwXhaV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYnM5mG24DGTZEIpH26Sf/F+NFIfUiPney5r6GNsd+M=;
 b=zQlNxwYQ1w+BzrvRdLB/x2ReqbAxkIKUJXqibflPFiIXKleByEFmEpJx1l8vVWe3qzYxnleuFDgx5TPLIlHV1Jo4G7i9HbXtJkg9u0q002rNZWwgFsYS8YSqFfB7eDd2snAXwE35juthsNqtvS1UA3sEqJgGrv/aSa0R/upLRdc=
Received: from MW4PR04CA0120.namprd04.prod.outlook.com (2603:10b6:303:83::35)
 by CY4PR12MB1941.namprd12.prod.outlook.com (2603:10b6:903:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Thu, 25 Nov
 2021 06:21:55 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::1d) by MW4PR04CA0120.outlook.office365.com
 (2603:10b6:303:83::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19 via Frontend
 Transport; Thu, 25 Nov 2021 06:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 06:21:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 00:21:54 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 00:21:53 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 00:21:50 -0600
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
Subject: [PATCH v3 3/7] ACPI: APD: Add a fmw property clk-name
Date:   Thu, 25 Nov 2021 11:50:32 +0530
Message-ID: <20211125062036.1185994-4-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125062036.1185994-1-AjitKumar.Pandey@amd.com>
References: <20211125062036.1185994-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b6cb3be-f3b5-434e-ca8f-08d9afdbe0ae
X-MS-TrafficTypeDiagnostic: CY4PR12MB1941:
X-Microsoft-Antispam-PRVS: <CY4PR12MB194124C9FAA32F43092A45C482629@CY4PR12MB1941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WM8WP3uMT/f6Q3nvqwLJzc3jkdiDViN/xet4MDkxLM6LwjJp9OMwOE5ln30Q5LYsi+cRLrrErA9PkPMRN6PWDBsbPwfo22SKLg4G/eCOHU2l3eeIIJWiJf9O4NTR3VYh0Kls/qD0nC7mXBZDyAjFjx9z/BSymtKR0Xqqw9Nl0sNStapxj5vFX+phthCpIPViVMXGDiLHsIM16sQ22jFu8GP3/NFASK290uSlQsgdC97/ZyL7S7u63kga+/9KFNIZARKypoJ7Vb18oFqo0YxUGQ8j9uJLoBbWRSCy9/lvpNw5GFMHUCblYleBukUfEZ4wtzubYMAD1M9MU/Qaxc8Ql3jMZNyBxlnBFILTngaPBjadgiM9/x2ZqXvE0mICiC/irrIvPh4/KMi5XCswbkpL3HYoWFM5ZIAu5magDW1SWyK63+as2jgdV+a1HIYzxhKhrnotqqKmKMOccR15Kra5oaV956ug0j5ZL1DSpFQD37QMVyuZziEBqxyTtToUCkWpdRuc5XrBkUoB3YrZ7tpSBu4zNR71INmvWa4O9x34Uxwd3MtwgvNynn/MTMc1/hKECNh1MxiWs2ozKKhrKFJn5SYHPsGiF+SCsYqS09n8TW4r/Zpe90Kd29Cld7Cgi32M4IolFudpuFrh2Dm3RgpwbdPyO+fiqM0L8UGq3u4MuxmXi471WhZ3Eq/fCfhSh1Pz8CRfQTgYVC2I/zgFQpbgAQ+ZU/CZ8mzbD3PnnmxJMd4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(82310400004)(5660300002)(8676002)(2616005)(54906003)(70206006)(81166007)(36860700001)(2906002)(1076003)(336012)(426003)(186003)(508600001)(110136005)(356005)(47076005)(36756003)(26005)(4326008)(6666004)(8936002)(7696005)(316002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 06:21:55.0286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6cb3be-f3b5-434e-ca8f-08d9afdbe0ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1941
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a new device property to fetch clk-name from firmware.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 drivers/acpi/acpi_apd.c               | 10 ++++++++++
 include/linux/platform_data/clk-fch.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 6913e9712852..2b958b426b03 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -87,6 +87,16 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 	if (ret < 0)
 		return -ENOENT;
 
+	if (!acpi_dev_get_property(adev, "clk-name", ACPI_TYPE_STRING, &obj)) {
+		clk_data->name = devm_kzalloc(&adev->dev, obj->string.length,
+					      GFP_KERNEL);
+
+		strcpy(clk_data->name, obj->string.pointer);
+	} else {
+		/* Set default name to mclk if entry missing in firmware */
+		clk_data->name = "mclk";
+	}
+
 	list_for_each_entry(rentry, &resource_list, node) {
 		clk_data->base = devm_ioremap(&adev->dev, rentry->res->start,
 					      resource_size(rentry->res));
diff --git a/include/linux/platform_data/clk-fch.h b/include/linux/platform_data/clk-fch.h
index 850ca776156d..11a2a23fd9b2 100644
--- a/include/linux/platform_data/clk-fch.h
+++ b/include/linux/platform_data/clk-fch.h
@@ -12,6 +12,7 @@
 
 struct fch_clk_data {
 	void __iomem *base;
+	char *name;
 };
 
 #endif /* __CLK_FCH_H */
-- 
2.25.1

