Return-Path: <linux-acpi+bounces-9990-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E16D9E64D1
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A057188018E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CB718FC75;
	Fri,  6 Dec 2024 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fBdJ2tom"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD32187FF4;
	Fri,  6 Dec 2024 03:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455457; cv=fail; b=SofQp9Y6DVRmb4Myth15DSUWFCj7SO7ksHW3oj4ioW24cKye0cPEZB3qLIwhWqblftNsjXYRBlg2gkqdjf5Do1++Bbe3X0xFA5nvQK9rwv8y5JpBKwOgEfi6Ggh4BBQE4WYO2RcWloNkbeSMXRSraYbAMCN8wGk6fSMxed2szaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455457; c=relaxed/simple;
	bh=2sGp8nsceMSqqbGFXAGu40PROo274ncRCGZ1RbgNNlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hS9RGueC9ceCCeFdXghgam5fuFW4JWUnYbBfaqxJg16jgmBXW53Y1zJfeE12pLzoGXJa9JrQ/WPUtkj1Jpb4HF029Gz1djF89RzVN4XA52leO2F8mpXtIl7wWA7fCNNIlFc5KoQtT0norrEeEsq+ADeh5EcBb/Llt3ezXSJenic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fBdJ2tom; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAsKf+y9hW4gdoPjHga4QfNDopP0ajnjQh/mdJ2ecbWFbfZZYAKrkfEgx0PauzxUd64XLT+WW4iQWCm7JD416AI9gPqW2UF/L52lYOB6jQahPNJsbiJM4ckJquILeZ1r6XQbgo/LrGVVqPH/GUxBv4qrYTOLFkZHQTvCRyNoJsyQ7XevB48GfypaH3w/8/ViMhIE+EFj5XHelwleUVV9v1N63EWXqnRG0/c/DAahtQfPGpj8Zy4CytW1qf7tgdJ+3fMPOHvXoO9FkonflqtezVJ8c5TGnye4mF9dwdco8wtHjJnCr7Os4FX+/6XNCgd+rFFCfOb/vET5Hfbt67pbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtJpblUh8MBOEucV5B3TNCycXxWvmJz0+rzIT5JUVPU=;
 b=eKLSPSt5J5Ar5Lj9VQUyBAP+ok20LybicIwnU6H7GGfvxun5+nSXll0nS3Kuek6R+YOpGozSXmatzrlEdXYS6nIdYdwJsDTb6s+Si9DnvuRS003hbqmr+lUPPDHjTTNnPwxIrKPjWadsdcNkvP03WwmB9mdezoJ1+EU8aRafKgGS05Wa76/pspMdQWLPbMgEu8X5UEa3ovUdrFM2/mlPa2oQYxTJMT2VN9qkSWhXuMx92cayl4I9SBV+sXRVXjsdWQ2d4fywz0euPHikaKKihZeOnKqhXBo4vM526N5woSQeghdT4FAe2q4++o79J2QLdm+KYTgm9XODgvmZGHriBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtJpblUh8MBOEucV5B3TNCycXxWvmJz0+rzIT5JUVPU=;
 b=fBdJ2tomi6GFpsX5/frmu4WnsD2klP2shBGoUCvE7zxBJAsT9nhs6K6J1C3nVyAQMkSPmYKJCrARXJKaGrO7fftPM4483pL46Nu8rQpcSYktzn2On3dtFsetR0DM/ePAvprQpNPRZBzALNLiaOxBywj86GQRWRafEea6R+HpI7Q=
Received: from BN9PR03CA0611.namprd03.prod.outlook.com (2603:10b6:408:106::16)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Fri, 6 Dec
 2024 03:24:10 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::d7) by BN9PR03CA0611.outlook.office365.com
 (2603:10b6:408:106::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 03:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:24:09 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:22:51 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Corentin Chary
	<corentin.chary@gmail.com>, "Luke D . Jones" <luke@ljones.dev>, Ike Panhc
	<ike.pan@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	"Alexis Belmonte" <alexbelm48@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Ai Chao <aichao@kylinos.cn>, Gergo Koteles
	<soyer@irl.hu>, open list <linux-kernel@vger.kernel.org>, "open list:ACPI"
	<linux-acpi@vger.kernel.org>, "open list:MICROSOFT SURFACE PLATFORM PROFILE
 DRIVER" <platform-driver-x86@vger.kernel.org>, "open list:THINKPAD ACPI
 EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, Matthew Schwartz <matthew.schwartz@linux.dev>,
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH v10 05/22] ACPI: platform_profile: Pass the profile handler into platform_profile_notify()
Date: Thu, 5 Dec 2024 21:19:01 -0600
Message-ID: <20241206031918.1537-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206031918.1537-1-mario.limonciello@amd.com>
References: <20241206031918.1537-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3d0dd1-aadc-4e07-1315-08dd15a5730c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SuMiioMf8wmmjleNSx4efxG14qLsd6lR+ietkZYI+PHpF4YRWTYekuDiii6X?=
 =?us-ascii?Q?poiaKSqUwClJ5dshEg+RNfytESXQ+ZPNfxtYji1Z3h2b/KsRAT5TROCZuKm0?=
 =?us-ascii?Q?kLHTfwoUkujP7LP3VEUV1Dx+scgPUQynC/qLjp8sbsdziWXhGT7tswxKXKd7?=
 =?us-ascii?Q?j5MQiHgzULuf6BeYNngfTpTZol7hmAHl5SkRPnrkJp3UtRcsX0KAjZdHISDM?=
 =?us-ascii?Q?FQTgTWZPtBQ7Lcp61WA5jj4oLPfxOv84XInArbLyZuL5emcCTb/R5E33sbn1?=
 =?us-ascii?Q?Cajt3t7B3cbky8LkXfheZwUWL2D44j9+VuFtq69Mv7tUZeM4gbj+8WbqfhlC?=
 =?us-ascii?Q?7LdRyn/R3x45VhsLsdA/n+YmhuFtpmBIdaglpyM+mWxEcwDWh9qQbgXeq9ux?=
 =?us-ascii?Q?EY5wR78ZZFW2RScn2GHQb1y1JK/UXR3ek0oHSjKQzg6EbRQTb1isCmcGSQ8A?=
 =?us-ascii?Q?rTstqLENJTzQIa+qsNxmn4r25M6ZzJdfzCjfxG/Je10pe41fEBm3/NFrNhP7?=
 =?us-ascii?Q?ArVes6KCO3RsfopksLuP17dCZ7bivn1o2eF46DBahnLHTNUGCi7a0lAnb6n2?=
 =?us-ascii?Q?zk04HtuQLEEgTC9tYCtkV/45vLhCm2wBUHIg93EdpWBSguwjWpSKNwLLZOc5?=
 =?us-ascii?Q?BamLiwDzam8nTtb3nCMM8X8EkuVsOMhqkaFOj17oW2/KWVLwVAVhHndbbw37?=
 =?us-ascii?Q?bVTKjutyC6KxbId/T4eeUYsWrN2iU7ir4Kk2TBZczAiu1uTrIshB4WqEvMym?=
 =?us-ascii?Q?uUIb3jEiJLZ5HxjNCtHlY4mAGBe99OXad4aVU6FQEf69ovmZIrQALg5jj+5x?=
 =?us-ascii?Q?lwmQD81vJqD3ow8ZUUWGGnQjJGOj3kh9tVwOVtgwKbMq57kh3aNdoc3iq28w?=
 =?us-ascii?Q?v6OGAS5c+MvxI3pzMmzKNxy33j+3m0valIlHjIUv3UOL8QzfzwBGXpGFzqiB?=
 =?us-ascii?Q?pQkPSpZGgEaz6MaTxmugGxQ+2CpxwKAIGfc3VYFuF11m+kvWHUj5cyBv6xNp?=
 =?us-ascii?Q?QGv14c/stNLVhN7CqbUo6+cHmcFVKFQPWaoGlhlKUpr5pQKcqj8K0EzWzRhZ?=
 =?us-ascii?Q?wCnmZCOME5xzY0nheiowupnKjcbzIbucaY3I+3UPq3Z5yoPUFaUEThC2ERT+?=
 =?us-ascii?Q?c5qYw/Bwhy9liwgeANhQjw878eoWzcXdDlLF2tbaTZV+bIuLVep0q2rR120c?=
 =?us-ascii?Q?IppqeBTKgnPkSue8Zu0onqfnunHaESlUSrqPzlIN5hlFq4l8MKz8edGx0NbK?=
 =?us-ascii?Q?HGDyL//AgGTC372FrxB8Na2ZVZFhQEe6PMtaOtcSrXkfTF+A+pCf4hh+ysVD?=
 =?us-ascii?Q?nZ+Q/KcsM02gfzuyTCkDHt9aiWL9jWi9QZBy2w857bBvwagKzQKndRHtupFK?=
 =?us-ascii?Q?Ll7UtCO4wPgdw5RKkriaTvqHhjFYm0UIRRrCM2gQeSPqkJQLYQBarDl4/Yxt?=
 =?us-ascii?Q?NuERmi1XvbjmfFWllfh5BfrV46GkFQZO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:24:09.9499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3d0dd1-aadc-4e07-1315-08dd15a5730c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040

The profile handler will be used to notify the appropriate class
devices.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c       |  2 +-
 drivers/platform/x86/acer-wmi.c       |  2 +-
 drivers/platform/x86/asus-wmi.c       |  2 +-
 drivers/platform/x86/ideapad-laptop.c |  2 +-
 drivers/platform/x86/thinkpad_acpi.c  | 14 +++++++-------
 include/linux/platform_profile.h      |  2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index c24744da20916..927a2f7456c9a 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -128,7 +128,7 @@ static const struct attribute_group platform_profile_group = {
 	.attrs = platform_profile_attrs
 };
 
-void platform_profile_notify(void)
+void platform_profile_notify(struct platform_profile_handler *pprof)
 {
 	if (!cur_profile)
 		return;
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index b12965d9fcdb7..0018818258070 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1988,7 +1988,7 @@ static int acer_thermal_profile_change(void)
 		if (tp != ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO_WMI)
 			last_non_turbo_profile = tp;
 
-		platform_profile_notify();
+		platform_profile_notify(&platform_profile_handler);
 	}
 
 	return 0;
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 805bce80beef2..fdeebab96fc00 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3789,7 +3789,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	 * Ensure that platform_profile updates userspace with the change to ensure
 	 * that platform_profile and throttle_thermal_policy_mode are in sync.
 	 */
-	platform_profile_notify();
+	platform_profile_notify(&asus->platform_profile_handler);
 
 	return count;
 }
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 95b66ac3ea1d6..00b9c0c32239c 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1041,7 +1041,7 @@ static void dytc_profile_refresh(struct ideapad_private *priv)
 
 	if (profile != priv->dytc->current_profile) {
 		priv->dytc->current_profile = profile;
-		platform_profile_notify();
+		platform_profile_notify(&priv->dytc->pprof);
 	}
 }
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 298100d5c535c..f516628617384 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10538,6 +10538,12 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
 	return err;
 }
 
+static struct platform_profile_handler dytc_profile = {
+	.name = "thinkpad-acpi",
+	.profile_get = dytc_profile_get,
+	.profile_set = dytc_profile_set,
+};
+
 static void dytc_profile_refresh(void)
 {
 	enum platform_profile_option profile;
@@ -10566,16 +10572,10 @@ static void dytc_profile_refresh(void)
 	err = convert_dytc_to_profile(funcmode, perfmode, &profile);
 	if (!err && profile != dytc_current_profile) {
 		dytc_current_profile = profile;
-		platform_profile_notify();
+		platform_profile_notify(&dytc_profile);
 	}
 }
 
-static struct platform_profile_handler dytc_profile = {
-	.name = "thinkpad-acpi",
-	.profile_get = dytc_profile_get,
-	.profile_set = dytc_profile_set,
-};
-
 static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 {
 	int err, output;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index bcaf3aa39160f..8ec0b8da56db5 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -39,6 +39,6 @@ struct platform_profile_handler {
 int platform_profile_register(struct platform_profile_handler *pprof);
 int platform_profile_remove(struct platform_profile_handler *pprof);
 int platform_profile_cycle(void);
-void platform_profile_notify(void);
+void platform_profile_notify(struct platform_profile_handler *pprof);
 
 #endif  /*_PLATFORM_PROFILE_H_*/
-- 
2.43.0


