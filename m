Return-Path: <linux-acpi+bounces-9801-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A3B9DF0AD
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB436B2116F
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA57919D8A3;
	Sat, 30 Nov 2024 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c6/ZXA8F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDFF18CC15;
	Sat, 30 Nov 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975528; cv=fail; b=UiPVBK3ZnWceJ/WNwKMMZjJpLmzaz/awocfZxxKhiStYrGezWD9Zq8Yv2pJW2j9kC4fV23FF0dsxnoPQVYZAJYhw2AGcmNy2UfbLdYCoIf3vWArDXLJpEt4hWqnYkzS4xQ9+65qO17b1cyGg4azuFW6G1WJvcnSEngcPABJqsBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975528; c=relaxed/simple;
	bh=2GfJ/SjUIoNaiwHOnGXTGKoy8oQY1NZVgcne1nh591o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWuhCEuEpzac8NlNqZjFMuYtv3Viu+XZqScvwjzDHlpxR4zI8SiBxmtJPdZHAJAlFHRslEm+/AUj6orNGiywKc9flD5A0VF/5D49A7Nn4u3BjL6ZzUqHkjF3vb2jcDThVvdsayG32PHU3bWaIDEaia7h5N+OOsQneC36UlJ0inU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c6/ZXA8F; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7mk9czPL774JeeoAyu+v/8myXo2/yw3zqtBxVsk+xhH167hQ2f8N0UuBAiuKUOL2m2H1AQEP6f838c6Zc2yFYVd4Mie6NeQA3REU7UJFzpfkRUqksPFSocrH4nwxNnu7TFdzxhSwD9Nk9HOTyFBnKYJ4mpij5Jnlwt97+eVaYZaX7S6ChCvPVtcg3oCRaxS+NqJlVyRNOynwkR+2W6vfiinyUnlbnUZ1hG49BH+GfS2sSkHcw+h61u57ynMOgfPJs1pOUm1EhFCKrywVgUYn5+9NcqG8z4XESmqiIXzmbTpz9lKNB2+DEi39pKKSm9xZT1RTQ5TTuJ/1/T8MLVQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoQnBgUUl7eonCm8N3+8uE69DCAavYY1OE4Xsjy+5YI=;
 b=ICOCCdrMeGVTMAZEQ5e+/50johT61zFoPMMBSCpneVMlq7rrd88Xes5/KjLg6yJUBbBQKV9LsUqzIWtXSvRWSE5m+JJoBQyF+dckb2jvfeCZTDA/Re4SV6NUiTzYA8X//5KRgcGuK4sdqzoxSy2eOhonCCx9j+r56FJ+KfIXPZDu8gxEC2ESL5p1bGAKM2wL8NDtyxtcUC/hxwnVTopFEjJ1XnOkTeirTrMptKDLf5WpIwjIFB2XbaZDVcz9o5wAHqpWoo/auBstm5IvobCsTWwvBcxMNpNidU5aPHlHPeKdzedkA/qnwHenIhvUTaHd27FyyG1/qimglIQaydb0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoQnBgUUl7eonCm8N3+8uE69DCAavYY1OE4Xsjy+5YI=;
 b=c6/ZXA8F9c8yi4vfjJMDWCaLjzPyBI+3/gzsk3GsO1TVjHQ8uMOqMK+wHBjaMB+r1IuK7I65Se5HjMN4o13hj26Rrsqb1dozk2hRPhc0CdKhJE0Bcwnfu41QVN9zu65M3QE7xVQylFaEuMzE+RUSKDdvtmWbDzUnhbzTwrwS6tM=
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:05:22 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::13) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.5 via Frontend Transport; Sat,
 30 Nov 2024 14:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:18 -0600
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
Subject: [PATCH v8 01/22] ACPI: platform-profile: Add a name member to handlers
Date: Sat, 30 Nov 2024 08:04:33 -0600
Message-ID: <20241130140454.455-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140454.455-1-mario.limonciello@amd.com>
References: <20241130140454.455-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: b34e8e3d-8b36-434b-1d9b-08dd11480779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alFLalk4UzVBeks1QnlzVW56NlZqSFhlZG1CSTlRTmlRQ0h3aE04Z0tWSmJP?=
 =?utf-8?B?cGlwS1dSd1F4VnNtVmxhOXh3YjlycGIyQ0ZVUER1K1dKR3Yza2x5ZE8zRHlj?=
 =?utf-8?B?Nzl6ekJvVy8zcjJETWRqN0VpS1pBUmswTCtCYitsR3ZMTDlFUWYwMzk2L3lY?=
 =?utf-8?B?ei9kUHJKWXFNY3BGWi9HOXdXY2x0Z2dnN2czL2VmZlBrRTZNRlVidVRMVGdH?=
 =?utf-8?B?N0hKWkVpRG1URE93cGh1bmY1aERUalVMTGczMjZCcjYzc0pDckJEZnRyS1Zu?=
 =?utf-8?B?WlpEL0lHdnJmd2VWZU5DdTFzRWsvVWpIRXhNaWM5MTIyWm9uNkhnbzBjTDgv?=
 =?utf-8?B?dFg0UzRGTHhtOFJ6a0JRM0lSWnQ3dEJPN0tOSTV5U3VXMHRqT2c1eTRHL2o0?=
 =?utf-8?B?cmRLcU1mMHpwVG81UURUdEJjaVdiOTdKclAxWlZPYzlwK2lOQkpwK0diSW1J?=
 =?utf-8?B?TTZPRUhrN0VaVU00bXFoU3lBTkZXaUkzODFjemhidnFXMUlTQkFtY3Q5VThC?=
 =?utf-8?B?Q3R5ZGZqVGxKUlZKUU9wblAzZm5GT1pxUFNvSVhBeEpnS3ZOS0FVSGEvR01o?=
 =?utf-8?B?eW5UNU82MjRSVWFrdjBQQ2dYeER6N2NkM05FbStLbnEyb3l0UDcvSXhIMjBh?=
 =?utf-8?B?SDhhY2l0NUIvdnRPSDcwREJNNDBQaUZCSC9UYzg0N2tXWTBLMjU3VHFMRGlk?=
 =?utf-8?B?M3JCZGZ4Tjh0R0pqZENlMGVUTzJac0xuLzZNZUFodlRoRG01bHlGdTBmOXFW?=
 =?utf-8?B?ek5zNk1vMVZTZHBpSGViUlB6Rnk0T0JqQ3Z1NmlMa0loR2R0Vi9UTk5xUFJy?=
 =?utf-8?B?aHk2QnpobUluM2tTMFJZV2VDS1lnZnNuZ0dNYVplUjFSNmZtNUFlaE9tY1pS?=
 =?utf-8?B?bkJ4K0FWZStXS25uYkZSdHFqTjFlNmpmVXJ4WDdRa3crUGVsaEtSOFgxQWxv?=
 =?utf-8?B?UHNIcXlsT1ZOZnJmRkY4ZU16ZzNEU2ozOTM2VUJqNWRuRG9vTEFhYXFhUElm?=
 =?utf-8?B?dlUvOC9selljYm41RUpRZytxYmt5aWxxdXNtV0NHb0diUktnTDQrMHQ3Nysz?=
 =?utf-8?B?KzE0d09rOVlHdjllTzJyYks3aEh6aTZGbDViYlVqRWhlRHlVOWdrV1g1OGQy?=
 =?utf-8?B?UjFuVm9FWkFUVWR6NVZtUC9iWFpCSEN2V3I3bkZ2Z3FMNndvdDloQnNZTkZS?=
 =?utf-8?B?bkZmZTM1amk5NU1lN0hKZlROQ1Z4T0JGVi9leGJ2MDJIdmUxRXlPUDMybzAv?=
 =?utf-8?B?dTBtNWFPVlpXTStHTlo0OHFmVjJEdHZmTFl6bkFja2hrM0cvK05ybkNjNyt4?=
 =?utf-8?B?cEhwaFZnaFQ3QUprbXJITEpmZThBL3pQOWxNVXhyYnJERHZlMyt2bytzVXk1?=
 =?utf-8?B?NTVST1FHdFN4WlNNVXNwNFdEemJ4SVF0WHBhVnFNSnQwWHBuM29kTWZDSGVG?=
 =?utf-8?B?OXZBVDV2QlhBV0ZUOGI5cWVra0wvR0VZR1UrUkRIRlZnT3A1Znk5dHZKZG9h?=
 =?utf-8?B?SS9SOTlKL1RSS3NyVnRTQkpzemZ0Y0dNQm85cXAvSFQxUmozTVB5Q0t4ZDM4?=
 =?utf-8?B?UmJod0hqTllLOTRjMndJYVdyRUxGU2xxRHVRZFl1Y09oaW13VkpFbFVFMzhM?=
 =?utf-8?B?aExMTWN5TmJJVWNCb2E2eC9LTVpYMnlRNDlWcTlQMU9mbzB0OWRmb3hmNXVL?=
 =?utf-8?B?a2Z6U2k1dmFoNWZGalBJMTd4bmVPQS9jZGRyS0lzQXNCRTdzMUVrVk9RZ1o5?=
 =?utf-8?B?SmRjMkdJTjIrYnpYemoxQURxMlZtajJHMVFDcEMyZ3Fla095ZmVzZ1FrdXln?=
 =?utf-8?B?em42ekw1dDBnU245UmFxUzBUaEgrMzdVUGw1b0xwRGJubU95NFRZRW92aDdl?=
 =?utf-8?B?MndxbDE2WTZLaEtBa1BOWHRUL2MvYlpiR3duUEE1eUU1VEozL2NvSjZRODUz?=
 =?utf-8?Q?vt1l8J4bZyK4eWqXomJ2BAdP/SJBx1Qh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:21.5455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b34e8e3d-8b36-434b-1d9b-08dd11480779
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515

In order to prepare for allowing multiple handlers, introduce
a name field that can be used to distinguish between different
handlers.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/surface/surface_platform_profile.c | 1 +
 drivers/platform/x86/acer-wmi.c                     | 1 +
 drivers/platform/x86/amd/pmf/sps.c                  | 1 +
 drivers/platform/x86/asus-wmi.c                     | 1 +
 drivers/platform/x86/dell/alienware-wmi.c           | 1 +
 drivers/platform/x86/dell/dell-pc.c                 | 1 +
 drivers/platform/x86/hp/hp-wmi.c                    | 1 +
 drivers/platform/x86/ideapad-laptop.c               | 1 +
 drivers/platform/x86/inspur_platform_profile.c      | 1 +
 drivers/platform/x86/thinkpad_acpi.c                | 1 +
 include/linux/platform_profile.h                    | 1 +
 11 files changed, 11 insertions(+)

diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 08db878f1d7d4..9d3e3f9458186 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -211,6 +211,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 	tpd->sdev = sdev;
 
+	tpd->handler.name = "Surface Platform Profile";
 	tpd->handler.profile_get = ssam_platform_profile_get;
 	tpd->handler.profile_set = ssam_platform_profile_set;
 
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index d09baa3d3d902..53fbc9b4d3df7 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1878,6 +1878,7 @@ static int acer_platform_profile_setup(void)
 	if (quirks->predator_v4) {
 		int err;
 
+		platform_profile_handler.name = "acer-wmi";
 		platform_profile_handler.profile_get =
 			acer_predator_v4_platform_profile_get;
 		platform_profile_handler.profile_set =
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 92f7fb22277dc..e2d0cc92c4396 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -405,6 +405,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 		amd_pmf_set_sps_power_limits(dev);
 	}
 
+	dev->pprof.name = "amd-pmf";
 	dev->pprof.profile_get = amd_pmf_profile_get;
 	dev->pprof.profile_set = amd_pmf_profile_set;
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ba8b6d028f9fe..a08dc936276b9 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3876,6 +3876,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
 
+	asus->platform_profile_handler.name = "asus-wmi";
 	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
 	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
 
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 77465ed9b449b..f88d898447511 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1156,6 +1156,7 @@ static int create_thermal_profile(void)
 
 	pp_handler.profile_get = thermal_profile_get;
 	pp_handler.profile_set = thermal_profile_set;
+	pp_handler.name = "alienware-wmi";
 
 	return platform_profile_register(&pp_handler);
 }
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 972385ca1990b..3cf79e55e3129 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -247,6 +247,7 @@ static int thermal_init(void)
 	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
 	if (!thermal_handler)
 		return -ENOMEM;
+	thermal_handler->name = "dell-pc";
 	thermal_handler->profile_get = thermal_platform_profile_get;
 	thermal_handler->profile_set = thermal_platform_profile_set;
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 81ccc96ffe40a..26cac73caf2b9 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1624,6 +1624,7 @@ static int thermal_profile_setup(void)
 		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
 	}
 
+	platform_profile_handler.name = "hp-wmi";
 	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
 
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 5d2c1f0d1e9fb..cbdc965eeb248 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1102,6 +1102,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 
 	mutex_init(&priv->dytc->mutex);
 
+	priv->dytc->pprof.name = "ideapad-laptop";
 	priv->dytc->priv = priv;
 	priv->dytc->pprof.profile_get = dytc_profile_get;
 	priv->dytc->pprof.profile_set = dytc_profile_set;
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 8440defa67886..03da2c8cf6789 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -177,6 +177,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	priv->wdev = wdev;
 	dev_set_drvdata(&wdev->dev, priv);
 
+	priv->handler.name = "inspur-wmi";
 	priv->handler.profile_get = inspur_platform_profile_get;
 	priv->handler.profile_set = inspur_platform_profile_set;
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 6371a9f765c13..0e03c41e028d4 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10571,6 +10571,7 @@ static void dytc_profile_refresh(void)
 }
 
 static struct platform_profile_handler dytc_profile = {
+	.name = "thinkpad-acpi",
 	.profile_get = dytc_profile_get,
 	.profile_set = dytc_profile_set,
 };
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index f5492ed413f36..6fa988e417428 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -27,6 +27,7 @@ enum platform_profile_option {
 };
 
 struct platform_profile_handler {
+	const char *name;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int (*profile_get)(struct platform_profile_handler *pprof,
 				enum platform_profile_option *profile);
-- 
2.43.0


