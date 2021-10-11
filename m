Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC35B428604
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 06:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhJKEsL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 00:48:11 -0400
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:34112
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233778AbhJKEsK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Oct 2021 00:48:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKqKP5Io3XCUBm4U/PHWiIUwpJoOhwdRyt/JKrYBVXtftY9xK7qVMvj7FnI1dVslNygsLtbTA0cVp9xfEPIuSuyBsfQB3R5lJbOAqES/nzF8SlgAKWbNlu6KY93luBkaow+Ywn+3Fotlds6WJU428x5Z5yivEHLyMUzB7rVkbWG2S47B/Jw5NGz2CLFRasW7YxFixegyPW2KxHB2pmbD7dms/CXQlPeiIfanDV6fe1M6fyS2cYGiE0SzSfRAtXNIogurstki1rmdGJpOXdkHPmezR31s29a1afcJ9GW6I9IzUR+wybqEOYVY6R8AEct+rwo76eIXXjSokwPdWfmfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYnM5mG24DGTZEIpH26Sf/F+NFIfUiPney5r6GNsd+M=;
 b=ZAJWm71TWTwB7B3y7aZE+aaZ1zz8tsUjyXOqVsLeBh+tWkMihoo4G4oLUwTTDMJdIVC2hCDnmRmEVNOl6bcthdcFwq8WREvAXmzqJackwkLdgnNsV/v9B5BsYS8bLeKSJy0thau74bGJzo2QMuW3RMqa3ejpgzNAE08nBCA9WPrvWyItQr+DUBW3KGEyvTLMOtzu2rtdZGbthN2MTiKGoWuAzkxtZnfyKavZfWqeOqufOQ4iFDz7RVJj4anKOGwDSgSdNql4cX/VzOmQrrzYnwh/TLdiSWHlwzF2HKqKnAB0wkJSk6lslIbuAutZNugxZ960wdmOy7FY5SPGlRqyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=codeaurora.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYnM5mG24DGTZEIpH26Sf/F+NFIfUiPney5r6GNsd+M=;
 b=tp1s7IMXjv4JMIrjy6Up7BwCmHXlV1iUkB+UccgRalNZ3nqCrsL160T63d4MISpzToh6NNYZBWIjuOu5d5E/ZYbzx5NDoMngKERVW7mgysl9JvJojcROfnHYKDEmh5aVB+Q3YHhLRFl2YGQrBB2fqmEA7CWt2nk8PUyV/WtdBFA=
Received: from BN0PR04CA0165.namprd04.prod.outlook.com (2603:10b6:408:eb::20)
 by DM6PR12MB2651.namprd12.prod.outlook.com (2603:10b6:5:42::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 04:46:08 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::fb) by BN0PR04CA0165.outlook.office365.com
 (2603:10b6:408:eb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Mon, 11 Oct 2021 04:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 04:46:07 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 10 Oct
 2021 23:46:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 10 Oct
 2021 21:46:06 -0700
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Sun, 10 Oct 2021 23:46:02 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@codeaurora.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Alexander.Deucher@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] ACPI: APD: Add a fmw property clk-name
Date:   Mon, 11 Oct 2021 10:15:24 +0530
Message-ID: <20211011044528.66109-3-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011044528.66109-1-AjitKumar.Pandey@amd.com>
References: <20211011044528.66109-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38949b54-34dd-4e2a-8567-08d98c720a63
X-MS-TrafficTypeDiagnostic: DM6PR12MB2651:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2651FA61C3E364FF3F0C974882B59@DM6PR12MB2651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cxgajHi/Paa0GVsQElOtfEjne2mMsq1lWpII/yc5HaG2r6Ri82TcGdS2+LwHHsyYtVsRV/gZZSucTQ+rZBJ21bgJUWwnVn8vaDUdUc0Vnb5pJE4ALSBnRvMbcR+ArjSJMdz+5kROVFSYNufp5a9jP9iyeX3iO1CZQSr8zhM7sC/41tf+kgCNKWTRqdykKfcdj770PVChcnhNR+bLFp8Eveli5fmbtITyFbCCdnLjsO4tMY1L+WXaMphc2FAuIhSk8WGkcrx+iPJTVD09i5aZRg/aKnfKlctlCUTta3IJKp4xrLzOsZWNSfdNdZ9IpLXvDBaQtKlpDRyvtal7gHEs/xCTDfzKm7QFgbCyQOZeYXgQGr7Le+JVtYgFBeBhq2KbW1Mra/WYB5qH4B+sUK4oKyFlBYWawWB6CNKAvCQpmJJ00tE0EefTQmep3W3mDtAVm+MYN5sjU1GUtttRFGEVA9oCj9sMS9aclXWsBDrWL1BYs6RaiDN75JT7YVK08INuVg9UCPWmli1LQ4gVovswO8+TyhQD//Ps+H3Jgq9uEhhYSe3jPc8jLSMPrQmqru79G62HETtHfjdXbh3ym9ZLF7KlgjWDqVGAqxOYsbQRNUuYo9x3N3L+I6E+eG6Keh9fY4WiFuZScmpvZsJ2N6UXHXLMgOm1XBsykz+3zjlAqT5U5lgnUN7yLHJk/eZqSjnswYcP0mycnLuP+QOc/42Qj+GFesQCTn7VCx4Xcv/cuk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(1076003)(86362001)(336012)(36756003)(6666004)(2616005)(186003)(426003)(2906002)(82310400003)(81166007)(316002)(356005)(54906003)(26005)(7696005)(110136005)(70206006)(70586007)(8936002)(8676002)(47076005)(4326008)(36860700001)(5660300002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 04:46:07.7670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38949b54-34dd-4e2a-8567-08d98c720a63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2651
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

