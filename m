Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE6B42A244
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 12:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhJLKix (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 06:38:53 -0400
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com ([40.107.236.63]:32257
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236052AbhJLKin (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Oct 2021 06:38:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsxaDbXHAZXqpbPboJYIaaTu0jjOXD/Qs6konirg+OABl0CKdhzJoFND/mtvBduOfCh/cLkIIbTBoZ+MSlrzFm0bPvl735EKKrdrjY9RUd336La53oAVLM6jQKmfQcyDPXeO1XfGRpCDzcgREO6+DueTJ//aAf455DSp9hXyGYMuR/0ao610+dMWJtgPFJEz0rAkIe+M9iw9NkVtRdcQP9VuqrDIZ4PZ4Vrnu4sVzCjY6Rznl5XMipTJzoRU3CrATtbQSwFksPVKQcEQeaJ99M5Yy1iVvvowj3IS5tn7/58n7LSqR9EQ+QHeHlW7mxKVfcN7q8v9Y0NNZmCJZcApbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXFa3Z4AxagLKvohaj5pp6xcSeeWL/caaeWK+OGMA6M=;
 b=OO5htt7ZrERx2ndi/02S2Pfzu6dXRcY8MBYjubEuA6GaRChOWANah/Uzm7sC4JdPWU77kH39D++fM+/nHl9siZsUMwNJ7Tybq59hZd4F94kYmTsJXZ7FCt6+FzQL2uCi6lEYQZByfRN0Dk5BTTJiWC6j4fc6CmM4aUfeRxTzof5aRbwzhIjq3wkRMqikteXf/ySyCMwU7kv01QEfPlS6KyhIrqJzmqNbDkYJFz+Wdt0qAbQJ6RYy8X1Cynf7FU3eIIbDf/gkG48e+6cITqoeDPzHoW61olIrQqB3J66Cr6wiZLJpAffm6/3/uY9yfBHkmpxybUIFehNLKtt50fp3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXFa3Z4AxagLKvohaj5pp6xcSeeWL/caaeWK+OGMA6M=;
 b=xMFrZJBGp+VkGf4uiowNl2L94IjPvCyqNuChFHm61HC1Fhx0ScNQSJF/gRGvv62eRrA+C8Fc1p9+MN+U2VlxHdmuOcoi/19p7mIQq+fqJbr9elyyZI5iU42YqmIAI0j9/HBA2R25mG2LOE2WaZLuqEyEk9N4ZTKbP12C2bmW/5Y=
Received: from BN1PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:e0::26)
 by DM4PR12MB5358.namprd12.prod.outlook.com (2603:10b6:5:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 10:36:40 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::61) by BN1PR10CA0021.outlook.office365.com
 (2603:10b6:408:e0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24 via Frontend
 Transport; Tue, 12 Oct 2021 10:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 10:36:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 05:36:39 -0500
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Tue, 12 Oct 2021 05:36:35 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Alexander.Deucher@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] drivers: acpi: acpi_apd: Remove unused device property "is-rv"
Date:   Tue, 12 Oct 2021 16:06:09 +0530
Message-ID: <20211012103612.101859-3-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012103612.101859-1-AjitKumar.Pandey@amd.com>
References: <20211012103612.101859-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f8bceba-3a66-459f-940f-08d98d6c2d03
X-MS-TrafficTypeDiagnostic: DM4PR12MB5358:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5358081B192183D9CA25B2A582B69@DM4PR12MB5358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usVgtEffJ7L99phebiB3Fw6aO1IPWoAsxqeoxzwKHcapr0a3s67mAJtgmSDRtyKYQunN0x+40tClUnTHDpnIlsXuzVaYZlnp9ff1ebAXHuqm4ww4MWUSKV4TJrBg3hDBMdSQ57MmIRpQ+W+15lH+Vn4bpCyRyBXLf6lsDiC9CHFL78lLAgbfhSl+NsMNanLtmP7jVezCezSdxFcNf8COcLCsDyfxH9K0t/Ahe3krhDOUZNuMqLux02SfV9MosQ3+LauKEFSXmUarI3S5hG44rtUakfPXXFmkbbQqXkxgQP6Wc09idH/YnqySzTyjyuO8MZZNJ4MaYlaMFoNkI/KQgc/ohlRFwnrMv/1CAbMRbFLyoc/iADOvhYr4VVr6h//+5fAGsYdjVQi8giYR6HHAUgyXa58KBkzpiU+5HS4tFQKe6MI1hbeqPMhXJ7sGhq2khDbk1TpaptcvikNDHemYsNrS0LfRIE4JfVHsCO+Jko+XpNM7J29/ExW9ioYaurmn8kSF+CYjhNy2sKHykudWkvuUl1g4L28JUyKyl62rD5EqnxtNZ51My/a0EApNgsuK+KXAAMjeruhlD7vOgQT0/i3sFoqu6yxvQtcwZJynidOLpuCoRNnPr3DhvbHLd8D0xRJWxNS+gWHLBuG7b0rOdcZtOMCxbb50sN3mvjHnccPn1U9zUF0OrIe65y+VEGDzA9rV9PNiA2bD1fcLIOzoZckagw7XWA/l0obhCGZ4kw4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(316002)(336012)(508600001)(8936002)(5660300002)(110136005)(83380400001)(54906003)(47076005)(2616005)(426003)(26005)(1076003)(186003)(36860700001)(4326008)(81166007)(70206006)(86362001)(8676002)(7696005)(82310400003)(2906002)(356005)(70586007)(36756003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 10:36:40.0399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8bceba-3a66-459f-940f-08d98d6c2d03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5358
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

