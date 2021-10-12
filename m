Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF9142A24A
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 12:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbhJLKi6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 06:38:58 -0400
Received: from mail-co1nam11on2060.outbound.protection.outlook.com ([40.107.220.60]:50528
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235961AbhJLKi5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Oct 2021 06:38:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFSMd4vN59lrNy1OXq44s9/sCmnxoYtXJFQjjMCbveF4PelkbwaPhpIuGTCKKnuCYoP4OhvWHniWIDJ/lyCTHLpPu0f8gZ2g8nsl0Rf6ycp0pXAneJ1Oslh/gNVs/53IMTjvguPSh6SGKQvlnWcGJDPXjVvGl/KTd6C8gfsOe482Ftw327/ZAg7R5STlJjdz5d7OHajAfTSlcdW3jrppsqluxSklOgA8Q0mEppYpahww/3X638q+JB4wCWsQwOAcKfXoV79FXpS7IGrFCwNR9UUhML1FsCSRaZoRnJlF90Nnke0dq1Op4Q8KCBWrkTd53uOBcdyr9cXMKd4eGfjMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYnM5mG24DGTZEIpH26Sf/F+NFIfUiPney5r6GNsd+M=;
 b=VM/tgcOFcuzAkLE37Vv0de85X7hBg7IfpGCSaD61WnQ/vuNFCQHEIehHsGcz6oYsp+wKm8zWF420bKfpmgGCFvRn+pV2X1NhZQVfGI6SLu3pDciY/+9OlBgDg1gmDR8jyGv4SyCr4McX2vaU1pBzTU/jUu57iUd44LN7T9qJ/WPafskDlDVzBkwkZ1bH+ChZhUUr6YhgP4dB0OhPZdRFxrHMYQNS0uSNAuggUYCtbhmxucBxo7KsYgMsWvPWEL+o08eQtJSis3EEfphgTQ0ROPy+vQBWYsQQ6dIXKBElPGDqFf8+y3mIYE7m9ZYRXSDxq8Siq9LYjjZ5LKIsyTL6MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYnM5mG24DGTZEIpH26Sf/F+NFIfUiPney5r6GNsd+M=;
 b=f8tDvtXPZTwj9mK92fXW5GnF3ZMuqVWmwww7VBgy0xNVCrBM8KapJ8uXwwoURxqUE2bDsvwT3vkR0s+5vdM7wt/uy73c9d01sapcC0aYkdolPvHikYLBeYIfUdB6GQMAOhzhrUKokgFPFPRJj178xlt8n/mUcGeOGB8U78kJu2A=
Received: from BN6PR22CA0045.namprd22.prod.outlook.com (2603:10b6:404:37::31)
 by DM6PR12MB3291.namprd12.prod.outlook.com (2603:10b6:5:186::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Tue, 12 Oct
 2021 10:36:52 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::26) by BN6PR22CA0045.outlook.office365.com
 (2603:10b6:404:37::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Tue, 12 Oct 2021 10:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 10:36:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 05:36:51 -0500
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Tue, 12 Oct 2021 05:36:47 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Alexander.Deucher@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] ACPI: APD: Add a fmw property clk-name
Date:   Tue, 12 Oct 2021 16:06:10 +0530
Message-ID: <20211012103612.101859-4-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012103612.101859-1-AjitKumar.Pandey@amd.com>
References: <20211012103612.101859-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 897b6067-f0d0-4966-8665-08d98d6c3450
X-MS-TrafficTypeDiagnostic: DM6PR12MB3291:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3291FEF87EB8BF18D58DA8AC82B69@DM6PR12MB3291.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkkJ4z9dAuY9MfdcXLZZVOK53JKQgpMSnn9q5L1buLaqyqTgex48UlKNB/W53piSRubXSIHV6tnRldug/e4kk8fyNVoWv5M3gBO4dtWYWiruT/83nRyuq66bk0E2xVClSXmT1TTNxm3DfcsAs5ZJX0AEJGd7gRmKGlQ6JqyBXVwUZUr4bIbfERe83umduJN/wBzpzRVs/w3GQ957sebPwTSuT+0TE3+w37yNcpMdEUJyFPQZDv0Z0+jExNEBwfuUsYHwpwoX/QDtA26IM5HyS05dzwc4Z9v8czBM4qToTTc/BzDI/3KkOWsqpitrQhHEpJv6mMtEbIpUsv+HU7amYhVPXqn8UGIFBoESLCcTbW3lrzY07qxUpDay9iyrFoO00wzaQIgn3zrb5XsknZYs3TyzdEA87BZytsMjEr3Wvwl4apsRRArhvsDTz6yCt0juPzSzeqlfZoYXrtdRK9Jbbma/H5VnjF4QiJVN3uyVroo+w6QiofnSV5ATa5ORV3P/+EYm4XaZP7Uv4gkD8AgHUmyeJEsYjftmbZtpJfuzA8PCzIPEw5Gm6xvH2tSyjny2IgvKbVBurCiVZ8gzKFl8qMGwi0ODRfqBgnwWBWp4MPsBd7ITeOJhn5NlQz9mUmNue5jXvmCymHhTLR79ezBwW0UEX5l4kGR9Dv75wg9CxMIlanOSJ+PkwcfK4bZIRJAK+GgM9MWWXFlsnEHdLal77RJoju9P7OkicjMxlYhHGFY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(36756003)(5660300002)(316002)(36860700001)(47076005)(110136005)(54906003)(26005)(6666004)(70586007)(70206006)(7696005)(508600001)(86362001)(81166007)(336012)(4326008)(186003)(8676002)(8936002)(1076003)(356005)(426003)(82310400003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 10:36:52.2892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 897b6067-f0d0-4966-8665-08d98d6c3450
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3291
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

