Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644F93FDDBD
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Sep 2021 16:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhIAOWT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Sep 2021 10:22:19 -0400
Received: from mail-dm6nam11on2065.outbound.protection.outlook.com ([40.107.223.65]:13536
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232449AbhIAOWT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Sep 2021 10:22:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fg3TxzeD7WghtX2KTBWwY2oW827iqXkwQ2GvSegB0y8E1ChZrazD/YRS6fcN3BiPnctyCxXuGIcyHKco6P00uaGuocuWgK4+x0rEA1/0ZavJadTU6F0mTWvXQHfvuJ8+C/VVBTtk+jM6q3lwrluodspVShaA0sfCOfFbnC088JnFY0OQi5PvFlOVhDFoU8gA9PyyafDzgPGdMz+yB1Z0lhVqmRZ/o0vtTkM29IfvwKB7JX9ivTsQkLjGvEB/rLUh7ATS1VXyFNBIg8bH/j4bN/Uku0KTOd5HkswXi17++B3OvtnVh0jP3vYKPBb8/FJWfQl1wS7orfZjf7Z+LYOjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9ZWHYpfNTa5+GzY9hWgnS+Hro+pnDgRzJSoqx234BA=;
 b=bxPr8pQvvn2eAdUMX9R3g5ekxaFALY5xg3UchkAV4PhFAJktM/mGObMZvet6XEyMIYDwxiFljqxSQw5yh86Htn4ClD2IsePfDe/ZNs1iFkGLHA16CCDVGYyY9CDLecli9NZ4qdJ/QB2UhOSlXQF6al1ecQSeYi4u2geBeUktBFM/JW5FN8P2V0ewhXiUS92ecCgMm+BkQoe7gCv6K9L2bNehw2Dr8W4197sLrpO1CSpHxsDvICRdyQNLUH5OZcHXduJ/pcI++2eT0AagVcZUZT3q2nEeLKVdNlurtAeIoxjXfAMY3uSUVkjDC4qQJMsnc0AK4M0YuegM5kO20K7XCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9ZWHYpfNTa5+GzY9hWgnS+Hro+pnDgRzJSoqx234BA=;
 b=uCoyvrsU+DeF11G9J8HIv4gLRMoIwhUuejZVZqb7qAca2zr7dqhTuazgVpzyFGFGDv3jQ9aprkQ9YkpKLJS/21BEAOk0q156Z9wfFlf8i6fYlgfITjNRH1g+fw6pQMI/QaV9sOyDDI5oRnXK7dT36EWglzwJKZ9Gyxpq74vwEJM=
Received: from BN8PR04CA0014.namprd04.prod.outlook.com (2603:10b6:408:70::27)
 by MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 14:21:20 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::6b) by BN8PR04CA0014.outlook.office365.com
 (2603:10b6:408:70::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend
 Transport; Wed, 1 Sep 2021 14:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 14:21:19 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 1 Sep
 2021 09:21:18 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <liaoyuan@gmail.com>, Maxwell Beck <max@ryt.one>
Subject: [PATCH] ACPI: PM: s2idle: Run both AMD and Microsoft methods if both are supported
Date:   Wed, 1 Sep 2021 09:21:11 -0500
Message-ID: <20210901142111.16891-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d33fa7d8-bc22-4267-ca4e-08d96d53c4a5
X-MS-TrafficTypeDiagnostic: MW2PR12MB2586:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2586662D68AC8115C917A604E2CD9@MW2PR12MB2586.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81QfQPP3o7lusHdfNprR4BUPiu31QUNAcAGnSRJscvJwDQUlEp6lYJMMhLDRlJ734VTBDpJsZcAo1xXeYaxTo6HbptSqa1dEBceDP3yDQ0uTiY0i39aYBTTqptsYLJZYC0ugxjmKHY6l/zdv3rsUi4/Shy5e+gJBK95Bi0DW7+EVjM7t8L3RKaliFe40l8/7fCkDAkNNSv9CEh6/Lph6GLohPFfNR7Ebpedre0cbEKTtz26d64XGpHxpwjecxCQWq4FIWyYWrnl2In+s5PJI1J6CmJs+qhQr3pup56GOnunXQbChocn99sbw09kbiuKlVZPyCaxnKZJ8QSVpjOiRDSdWlolaJucTwEOIEoM2goGGQCiTR5rfH/X8nJtt3iOmC/jpnRZWPibc+mEk92FDjAZKZaDE7nYGmfnxn3K9fJWR+4xdbEU0ksEl0ddSgwpV9Kkh2FJMjUiWY/WteLXlrczmDu3aXa+kHuBOAOctwy0fYzw2wG7v9DzfinvJcPBCJ1r3hw6aOE9EdYA6CoUIroaKJnDxW+v1Gk5e5u5Xm+WC7qu8NAl1cNj3EQT0+KduHINlOoJ8CYtih9PDeh53FhNQ5R/ZYYApMzP/ehHJ5nUn0IRU8r4xHFunZUKG7MyroqkmZLFpapYkVA5MMjY+spYXeX1oj4gnuFLqdXDtUBKZUcsZgPWJJIXO8GFR6ZQcQsNUVTF9whedM1AnZrPH1PWSYRCWuwrDuUddHfiHOxw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(47530400004)(36840700001)(46966006)(16526019)(44832011)(186003)(82740400003)(54906003)(7696005)(478600001)(70206006)(45080400002)(8676002)(70586007)(86362001)(47076005)(426003)(8936002)(316002)(36860700001)(81166007)(2616005)(36756003)(356005)(336012)(5660300002)(6666004)(4326008)(52230400001)(1076003)(26005)(966005)(82310400003)(2906002)(110136005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 14:21:19.8118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d33fa7d8-bc22-4267-ca4e-08d96d53c4a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2586
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It was reported that on "HP ENVY x360" that power LED does not come back,
certain keys like brightness controls do not work, and the fan never
spins up, even under load on 5.14 final.

In analysis of the SSDT it's clear that the Microsoft UUID doesn't provide
functional support, but rather the AMD UUID should be supporting this
system.

Because this is a gap in the expected logic, we checked back with internal
team.  The conclusion was that on Windows AMD uPEP *does* run even when
Microsoft UUID present, but most OEM systems have adopted value of "0x3"
for supported functions and hence nothing runs.

Henceforth add support for running both Microsoft and AMD methods.  This
approach will also allow the same logic on Intel systems if desired at a
future time as well by pulling the evaluation of
`lps0_dsm_func_mask_microsoft` out of the `if` block for
`acpi_s2idle_vendor_amd`.

Cc: liaoyuan@gmail.com
Link: https://gitlab.freedesktop.org/drm/amd/uploads/9fbcd7ec3a385cc6949c9bacf45dc41b/acpi-f.20.bin
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1691
Reported-by: Maxwell Beck <max@ryt.one>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 67 +++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 3a308461246a..7d1976e5dd8b 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -449,25 +449,30 @@ int acpi_s2idle_prepare_late(void)
 	if (pm_debug_messages_on)
 		lpi_check_constraints();
 
-	if (lps0_dsm_func_mask_microsoft > 0) {
+	/* screen off */
+	if (lps0_dsm_func_mask > 0)
+		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
+					ACPI_LPS0_SCREEN_OFF_AMD :
+					ACPI_LPS0_SCREEN_OFF,
+					lps0_dsm_func_mask, lps0_dsm_guid);
+
+	if (lps0_dsm_func_mask_microsoft > 0)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+
+	/* lps0 entry */
+	if (lps0_dsm_func_mask > 0)
+		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
+					ACPI_LPS0_ENTRY_AMD :
+					ACPI_LPS0_ENTRY,
+					lps0_dsm_func_mask, lps0_dsm_guid);
+	if (lps0_dsm_func_mask_microsoft > 0) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-	} else if (acpi_s2idle_vendor_amd()) {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD,
-				lps0_dsm_func_mask, lps0_dsm_guid);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
-				lps0_dsm_func_mask, lps0_dsm_guid);
-	} else {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
-				lps0_dsm_func_mask, lps0_dsm_guid);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
-				lps0_dsm_func_mask, lps0_dsm_guid);
+		/* modern standby entry */
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 	}
-
 	return 0;
 }
 
@@ -476,24 +481,30 @@ void acpi_s2idle_restore_early(void)
 	if (!lps0_device_handle || sleep_no_lps0)
 		return;
 
-	if (lps0_dsm_func_mask_microsoft > 0) {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+	/* mdoern standby exit */
+	if (lps0_dsm_func_mask_microsoft > 0)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-	} else if (acpi_s2idle_vendor_amd()) {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD,
-				lps0_dsm_func_mask, lps0_dsm_guid);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD,
-				lps0_dsm_func_mask, lps0_dsm_guid);
-	} else {
+
+	/* lps0 exit */
+	if (lps0_dsm_func_mask > 0)
+		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
+					ACPI_LPS0_EXIT_AMD :
+					ACPI_LPS0_EXIT,
+					lps0_dsm_func_mask, lps0_dsm_guid);
+	if (lps0_dsm_func_mask_microsoft > 0)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
-				lps0_dsm_func_mask, lps0_dsm_guid);
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+
+	/* screen on */
+	if (lps0_dsm_func_mask_microsoft > 0)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
-				lps0_dsm_func_mask, lps0_dsm_guid);
-	}
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+	if (lps0_dsm_func_mask > 0)
+		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
+					ACPI_LPS0_SCREEN_ON_AMD :
+					ACPI_LPS0_SCREEN_ON,
+					lps0_dsm_func_mask, lps0_dsm_guid);
 }
 
 static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
-- 
2.25.1

