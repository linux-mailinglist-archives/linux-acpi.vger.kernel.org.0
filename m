Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2CD43F739
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 08:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhJ2GgE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Oct 2021 02:36:04 -0400
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:17376
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232058AbhJ2GgD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Oct 2021 02:36:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DksFL4UAvBXDN6fWmNH5prxwOTQxOHSD+XO+3QDmkqDJCOHCyzQmKzUWPS8fI7hF+pWMwODueznRm+wsCJFxZqn4LSC3AxNfJEEqcprU17hj1bbex5aYE8FUttwBC9xTqAf8+PrdrAtcwFVzXgo6Apye+FD9dL8a8r6aEwadDdXw3JakFBJn6FmT2V9tDSxyF9yG1lnHbivdBMsh5coO3XWeJ0+5zstC69dnGq8VNgN/Dya5OKHnPN1AUvyetG0YAJ/UAwAMvOgbaNU2RUqZVydG3Xf34rT3krWhqwO9RuAtsO0GS/rwrvBwW4hcB3QsyGfwlY1Z9O2vxZ5R5Xl5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYnM5mG24DGTZEIpH26Sf/F+NFIfUiPney5r6GNsd+M=;
 b=PlIIH7RnyLNeFz9gV90Y2/G/r1BDt7Alx9n+F8Ldm41Rlu/1YU934h3fJmftC9wFMOjoeEZ3C+GkUux3+bt87fTr6Lqfv3wFEhph8oElLjScS/XCJHNjVy0FBxdWxCTwSHbh10pAR3zz2S4WqhuP9NgTcIhpKKewcG0xFtBZnmMkdjmngT61rT2VhgLP9xN7gr0woPhvFI9bpuFCA05Q37JFO1leXR2RJrzXslOLK8NcRl8y0D2JQIDgJSpltXmqg6wuAy5cOMh/B0dKM1G53zo/hg8WKQxd30Zdsw3u5xoOlHdBd88olyRMWMM1ojWQz6Ef5JP1r4SPXEutkWJ9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYnM5mG24DGTZEIpH26Sf/F+NFIfUiPney5r6GNsd+M=;
 b=R6WG/soI3IsDBN5QA9K5rsVn8sp8Io9EdH0kG/41hqh7Ibut9+XwfB/skqYq+gh464rIW49apqWV3qjdSO8vTjDY6KIvlR+KhbebbHhJcMwgYqSpfCZu11WDHzUdGAEHr7ldCn5xrPm1Nvw0fszvZl4uMe7Pn1BVGUTrqT+DZN8=
Received: from MWHPR14CA0034.namprd14.prod.outlook.com (2603:10b6:300:12b::20)
 by SA0PR12MB4560.namprd12.prod.outlook.com (2603:10b6:806:97::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 06:33:33 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::d5) by MWHPR14CA0034.outlook.office365.com
 (2603:10b6:300:12b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 06:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 06:33:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 01:33:24 -0500
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 01:33:20 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 RESEND 3/5] ACPI: APD: Add a fmw property clk-name
Date:   Fri, 29 Oct 2021 12:02:26 +0530
Message-ID: <20211029063228.578909-4-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029063228.578909-1-AjitKumar.Pandey@amd.com>
References: <20211029063228.578909-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4a2d512-7db8-41b4-e780-08d99aa6075f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4560:
X-Microsoft-Antispam-PRVS: <SA0PR12MB45608E459090017BB0F5538C82879@SA0PR12MB4560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wCtG5ExQWZjIwURtrzixWDSA81eAMRmhVrPmqJb8AvxYf9ovldYMozJMpxUjgHdpwZz0axYkYq+GWRbjFO0TTBfQOZ3hNtw9EmAkNVTNUkzBNRwBiwGm7ElkqWEeXbxqoznFvZwrZlzi0vUEg4Z/8Cx3v2hVjnl+jzT9gfYUeyTw6R3DDJkLKMk1QSc9NHh3qHt1BiUBKNTCu7DTlF+cQl2ekjIE4Q8g5aDtKFRE0WXDxYkkTOwbLl0eF1BKHNtCRzmnhe+YqenER2o4F0Ktddopgh3uJPCRAm1oN1W6omh1FTSV28rl+jg9FVwbGhz6ae0znWLf53V2ZPx0Ofbb61rVjNcfgJgGVYfP5Q7zIf7e+lrs6oer+D1cgLHws0DIyEZURTJ4qW2Pa708wnE7Mu0t3YaRRC71r7sxF0aQ3blC6MksbLODOrLOKmLaaU7Ow55j/tXqX1Yj29E5fkjP4N/hbFP6XAtOWYwda9fRlk6eK60N0qD0exmvX23ojBfWtN2Ym4PETk3/dsQc4/zdg+GrB/kpGVw6xq0vK5615f6Jp4g4tzSyJjEt5vOGgTgfeN2RZ260XO+NVGjh7OXFcIDsxVaUrwy4usGc3iLY03BJUMDDk8e3SOl53N5tyXi8t4n5em33/vtttc9VUdPkUFoUPJP69WJ5xeQHQllmcBI0qQHs3GOVJK69GGmztfqsc6eqvaW/igXhko9g/iYh6u4XA7OTXyDsfdXnztKIbFE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(86362001)(356005)(82310400003)(36860700001)(426003)(81166007)(26005)(2616005)(508600001)(1076003)(336012)(186003)(36756003)(316002)(8676002)(54906003)(47076005)(2906002)(8936002)(5660300002)(110136005)(70586007)(7696005)(70206006)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 06:33:32.7031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a2d512-7db8-41b4-e780-08d99aa6075f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4560
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

