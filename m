Return-Path: <linux-acpi+bounces-9389-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906B59BFDFA
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E3D2846C4
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEAA195FEA;
	Thu,  7 Nov 2024 06:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DJYKoq05"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E39194C6E;
	Thu,  7 Nov 2024 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959418; cv=fail; b=JVgRQsTzWcWdJaKMeu0MkOBP+RCur9uyhIJh0AAlUBSt7ZkZSQhj5FICT4KDhQ2Ok5lOBclLk5G2m8TROmuzuc8QgrIHVOQmSjAwT0i8W32V2SWXcuKIfv7CfOFE7EInSRo2KTHKIYeu4ayXzX33URaNGNQaOw9fBLHH6zSFmII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959418; c=relaxed/simple;
	bh=IZ1HlMQ/Xt3xeFZFd0KcV+Z8RNZRAWxNsipJcv2/foM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzqUU+wZ1zGXoKEINSvT4Ba4aQV+lS3Z2xzXZ1/x9MMh8J3Zxfw4xezjtJ3P8UXChlZfUChcxXb7jG/hKzpfDLa03X/E/hztk2mMaxQQw2gVYcTwQvqAVBZz8Z+cxsrD4ZDMGXFfT5oojvihvueazZcJ94TsWObs57NVYFrdXAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DJYKoq05; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWM1g+kWSAbRsaDnOI6XJu4IlLZJF1hv4xUeooTJGK+4+i+c/LOklyeHyjwbu53ZXf3RGlhqv7sXmmmmdOOHBWmalWK6G9XWzsJlWp5fCtdFqDSIIqGGOW1yO9LcaYEr+5BEio5vU36c8SZpDquOonYnApWV8HPoZS1tk6LGs4BAeCB7XsAr8p7glt6/HQU8BWSHpxwPPsH+6ZquJaSCo0Ki921QM8O6WmxZhZ6D8FC9fn6KkmFbj3liX0sPbAUAZoklGWHQlbU+GSghGlKlSuF54mZ0jBWrxpezUc7OogVI7VMxrjt9JaclnVXSNDVaWcgEgHyaN+Q/RRLpQ5nYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rcEA9VFt43X5+VIMws0c2U3e7AuxufNdvwsPe43s08=;
 b=JHFCffAFUJ+NT2nwUCs31+yLCc2fVV+dje6TTM2phPkcg5Ao9IZTikIjlfwWfTEx32v7e/XIPJbeIOiW9pJU8YVrubnKk5OjtArNw2IJbzD63u4QGD5TnCPwe/R1t+cy/Dy6ATJdfs37Lp+ukBqTHuz0dardXrxQpnyNRpYAL6vmvk5C71xV4VSUfrR1aonnXU3duZbbZ5F7nASNS4oaVzGc304TqjbL37LAJt3LnA8FaiHZKubvZfm9VRKQdZe9OqQ9ghn4oIjLDkyJI1sgpr1vxmh/tpir33Wz9sVXsHnoCFek1fp7jQOb6yK4ZxnkP8oPsvgnh+iVmz2zojqVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rcEA9VFt43X5+VIMws0c2U3e7AuxufNdvwsPe43s08=;
 b=DJYKoq0560kHVNJzThHFhIFqVuR8PWxLZfWDLGUAa/XZ5jTZUSktqkiDA52r96mnHw1FLGoGJCWtzAPyvYBuOo/KBRAMrqo9E+VolfQpG66sLVyMDbVuicTriQpqh27NtWF4qBpivj2k6SRawAmH9/nGRrF+Z88rW0MlO+d0Owk=
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 06:03:31 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::e6) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:31 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:28 -0600
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
Subject: [PATCH v5 03/20] ACPI: platform_profile: Add platform handler argument to platform_profile_remove()
Date: Thu, 7 Nov 2024 00:02:37 -0600
Message-ID: <20241107060254.17615-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107060254.17615-1-mario.limonciello@amd.com>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: d619c148-b22b-43df-8481-08dcfef1e823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1BiTEtudDRhSkRzbmlwZGJwKzFVUlVJZjlpaHZidkY1Um1MS3IrUVlKVUhM?=
 =?utf-8?B?SFg1R2ZJVTE3TDRDaGE2SGs5RlBZVG1SdDIrNklORFlYQUUxM28zbFNBcFMz?=
 =?utf-8?B?ZU80T1c1V2o5MXlGamphdHBJK3FuN1lQbm0yaXZCc1RYamQ0MEg1Vi9ndDEw?=
 =?utf-8?B?V3ZFd1l5MTA2SmdpcVNralVDOWpmNWNlaHhobHZhZm9mTlFEaVhERHNYZzZV?=
 =?utf-8?B?VDNCM1ZWVlZsbzRna05KWU82cEJJS0t3S3ArN3ltUmgwZWpRWVdXczFCMTRF?=
 =?utf-8?B?Skp0SFRUT2Y1aDlHV0FyS3JlYmpHZlc1bUt2VFR2Q0dWNHZMYTN5eUgyQVNX?=
 =?utf-8?B?bm43cWIrZllwQWZkYTVYeVpxMWFCZWdvUzNWcFdaeUI2T3BJeGhaTTVTbXgx?=
 =?utf-8?B?L0d3R2txUHE2UlVSY2o2aDF3djZBaXZvNG5CRVFQOFBidGxLelhnd282UEpk?=
 =?utf-8?B?TEg5aXZhMjBLTGhqcVhWMU15NkxaVE9vVmE3eldOeEtERjNIRC9zczNodzg1?=
 =?utf-8?B?NklmTG4vMVhMNkRIVTg5SCt0aHBSRFhTWTlFVXVHR3JFMnFjZDRwNERsQURH?=
 =?utf-8?B?QTBpOVJqd1BvSGVwSkhQdzJ6Nyt5WGxaUlFoVW0rUC9aRnFyZFZFWHFkRWt6?=
 =?utf-8?B?bEltUGJObjdjMGU1cXcyYUc3TERaNlAveU5JdDdtOFFaL0tOZzVOeWNiNkpW?=
 =?utf-8?B?Nk0zeFZTdk85ak1VQjQ1cmVFR3R0cG1HRU5BNTNCY3ZaOGh6VmRtdTVJb253?=
 =?utf-8?B?NklFa2I4Wm9ZUG9qUHl1eU9nK29kdWVON3M5a3BjVDJxcUpnVEZnelRqdS90?=
 =?utf-8?B?TWlJSTJwdTdsOVJtTTQ3RENwMjcyWW9Vd0xROUtxVFNoczNLUVJLUVVrcytW?=
 =?utf-8?B?STBRMGNnV0dBZFhyV0tsSXJpUDFwUk1TL0I2cnY4dUd6ejRlVmRDbUc5blRJ?=
 =?utf-8?B?UXM4cmh4U3JwcWhTR3MrMVU1dHltTWZWSzhLZlA3ZnRWc3JUUDk1TTVhTElh?=
 =?utf-8?B?MjFHVWFrNWRiTzVUK1ZsR2RTb0Q1NVFBb0lmUHRGRFA1TnpRUzhSUm5Xd2ZM?=
 =?utf-8?B?bzV0eitFRG5LYW5hK2NkL2RwWTM2dUhHZDlFNjNoR24za2RaN203eGNYai96?=
 =?utf-8?B?SG13ZndyVkE2bXRLTXZJd2ZpN0xvc3BSZ1pMeEhJa2hFcVlaY3hpaGdvVlpv?=
 =?utf-8?B?aUoweVJ1VUc1ek00cGtlaVZ6djl5RmZueHJTMXdYYm1zbXJSSWRyMGEvS2s2?=
 =?utf-8?B?SWZQZVdsdFFTV0JYQmszWHNkWDdrdDdBVWRLZVNyMmxmSldEU3hNaUE3SmJC?=
 =?utf-8?B?WjUyK28zUWo2bVhqVEtmRVFMYzgrZUErcGdKTllzZkVUQnMxVnhMVFdqQ1dt?=
 =?utf-8?B?ZzkwckErbmMvVmhGVlpYa2FDTXdWazh2NEJ0cGczQkMrK2JJSGx6ZXU1MVMr?=
 =?utf-8?B?USt2R0FXOXZHbkZmdCtpQjllcC9nOE9XRjFGWk9SK1MvU1FpLytzNk92Z1lB?=
 =?utf-8?B?czlXV2NGOWlnVFEwSjN2bFRySkJUdnY1OEV0Y1RYTDR2U0ZlTlJKTWJqRXBK?=
 =?utf-8?B?Ymg1ZW1nYVUxcWk4THFjNytKRnhIZVhVVUJTdTFnRjlIWUNBc1UzU0pGVXA5?=
 =?utf-8?B?Q3RYMmtZaENLNWw4dllrYW9EaXdWMTdtcmxZeGdNQTU3RHJnWG5NdTN3WGIw?=
 =?utf-8?B?cW93cEg2SEFjM1Bxd0Ura1hKVmQvVDdQbjF6Tm94b3c0ejYzcE9mQWZaSS9B?=
 =?utf-8?B?a3N4WEQwTGJ6OGdVQ2JVVzlvY2FPZzUrREppVjRrMmRyYjByM1Q5R3Zjd0pi?=
 =?utf-8?B?ZkdNd3pncnNJTHF4dUVGM3dnajRRVnBYUXRydDRIUDc1SVExQzBvN2dlRXgv?=
 =?utf-8?B?S0k0T0JJTDVubWxUdHI4eGlUTUUwMnJWenZXQzFUVTVoeXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:31.3108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d619c148-b22b-43df-8481-08dcfef1e823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686

To allow registering and unregistering multiple platform handlers calls
to platform_profile_remove() will need to know which handler is to be
removed.  Add an argument for this.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Add tag
v4:
 * Add alienware-wmi too
---
 drivers/acpi/platform_profile.c                     | 2 +-
 drivers/platform/surface/surface_platform_profile.c | 6 +++++-
 drivers/platform/x86/acer-wmi.c                     | 4 ++--
 drivers/platform/x86/amd/pmf/sps.c                  | 2 +-
 drivers/platform/x86/asus-wmi.c                     | 4 ++--
 drivers/platform/x86/dell/alienware-wmi.c           | 2 +-
 drivers/platform/x86/dell/dell-pc.c                 | 2 +-
 drivers/platform/x86/hp/hp-wmi.c                    | 2 +-
 drivers/platform/x86/ideapad-laptop.c               | 2 +-
 drivers/platform/x86/inspur_platform_profile.c      | 5 ++++-
 drivers/platform/x86/thinkpad_acpi.c                | 2 +-
 include/linux/platform_profile.h                    | 2 +-
 12 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d2f7fd7743a13..c24744da20916 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -205,7 +205,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
-int platform_profile_remove(void)
+int platform_profile_remove(struct platform_profile_handler *pprof)
 {
 	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 61aa488a80eb5..1c9e37b1f4761 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -210,6 +210,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 		return -ENOMEM;
 
 	tpd->sdev = sdev;
+	ssam_device_set_drvdata(sdev, tpd);
 
 	tpd->handler.name = "Surface Platform Profile";
 	tpd->handler.profile_get = ssam_platform_profile_get;
@@ -227,7 +228,10 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 static void surface_platform_profile_remove(struct ssam_device *sdev)
 {
-	platform_profile_remove();
+	struct ssam_platform_profile_device *tpd;
+
+	tpd = ssam_device_get_drvdata(sdev);
+	platform_profile_remove(&tpd->handler);
 }
 
 static const struct ssam_device_id ssam_platform_profile_match[] = {
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 53fbc9b4d3df7..71761d4220c26 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2546,7 +2546,7 @@ static int acer_platform_probe(struct platform_device *device)
 
 error_hwmon:
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 error_platform_profile:
 	acer_rfkill_exit();
 error_rfkill:
@@ -2569,7 +2569,7 @@ static void acer_platform_remove(struct platform_device *device)
 	acer_rfkill_exit();
 
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index e2d0cc92c4396..cfa88c0c9e594 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -425,5 +425,5 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 
 void amd_pmf_deinit_sps(struct amd_pmf_dev *dev)
 {
-	platform_profile_remove();
+	platform_profile_remove(&dev->pprof);
 }
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index c7c104c65a85a..f5f8cda7fd19c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -4885,7 +4885,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_custom_fan_curve:
 fail_platform_profile_setup:
 	if (asus->platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&asus->platform_profile_handler);
 fail_fan_boost_mode:
 fail_platform:
 	kfree(asus);
@@ -4912,7 +4912,7 @@ static void asus_wmi_remove(struct platform_device *device)
 	asus_wmi_battery_exit(asus);
 
 	if (asus->platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&asus->platform_profile_handler);
 
 	kfree(asus);
 }
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index ac0038afd98fa..e7f97eb24a014 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1064,7 +1064,7 @@ static int create_thermal_profile(void)
 static void remove_thermal_profile(void)
 {
 	if (quirks->thermal)
-		platform_profile_remove();
+		platform_profile_remove(&pp_handler);
 }
 
 static int __init alienware_wmi_init(void)
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 0cd9b26572b61..b1ada199e7978 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -288,7 +288,7 @@ static int thermal_init(void)
 static void thermal_cleanup(void)
 {
 	if (thermal_handler)
-		platform_profile_remove();
+		platform_profile_remove(thermal_handler);
 	platform_device_unregister(platform_device);
 }
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 26cac73caf2b9..bb8771d8b5cd8 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1692,7 +1692,7 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
 	}
 
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 }
 
 static int hp_wmi_resume_handler(struct device *device)
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 1f94c14c3b832..50819ac919e87 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1135,7 +1135,7 @@ static void ideapad_dytc_profile_exit(struct ideapad_private *priv)
 	if (!priv->dytc)
 		return;
 
-	platform_profile_remove();
+	platform_profile_remove(&priv->dytc->pprof);
 	mutex_destroy(&priv->dytc->mutex);
 	kfree(priv->dytc);
 
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 03da2c8cf6789..d8fd59b826f3a 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -190,7 +190,10 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 
 static void inspur_wmi_remove(struct wmi_device *wdev)
 {
-	platform_profile_remove();
+	struct inspur_wmi_priv *priv;
+
+	priv = dev_get_drvdata(&wdev->dev);
+	platform_profile_remove(&priv->handler);
 }
 
 static const struct wmi_device_id inspur_wmi_id_table[] = {
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c8c316b8507a5..619a4db74e5f3 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10637,7 +10637,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 
 static void dytc_profile_exit(void)
 {
-	platform_profile_remove();
+	platform_profile_remove(&dytc_profile);
 }
 
 static struct ibm_struct  dytc_profile_driver_data = {
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 6fa988e417428..58279b76d740e 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -36,7 +36,7 @@ struct platform_profile_handler {
 };
 
 int platform_profile_register(struct platform_profile_handler *pprof);
-int platform_profile_remove(void);
+int platform_profile_remove(struct platform_profile_handler *pprof);
 int platform_profile_cycle(void);
 void platform_profile_notify(void);
 
-- 
2.43.0


