Return-Path: <linux-acpi+bounces-9672-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF26F9D2C65
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAB82843D5
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140141D2F66;
	Tue, 19 Nov 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nkpUuvU3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203941CF7C1;
	Tue, 19 Nov 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036877; cv=fail; b=p57k7rWzxMjSURn5PRcCLTBwma3g0dNqYb/+OZVpXXWmvMVZM815KxNFKolLSwaJ1P4AO1HY4qgfILsFliONXP6miWh4QWdILThdHTVadYWhFflGgKLTIdgEaC3EAzfQFe4ut3nWwah11RzP7poCslhgsoQXNUUcv5ncnH5+He0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036877; c=relaxed/simple;
	bh=vwvkuCF6TUIm5sAd8pAAU03EmVf6teWL+lnPU/6KHg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+uiwIyuYzDaNMaWGDos1xTEQ2isuP10/pKo9+1JjQQXx2fuoEkqTFYCodalFW0+P75/n336ADnsXxZjsHq+Ch9k1do92iJOpHlacjB5IeD2pOdkUnuhWdeENeHA6kwNtdecizyNVkEe0yViUOOdOAaKV1oRv4VVYZ2qljZXgc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nkpUuvU3; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srrFMrOqPaeVWp5glqZ8kBNr+VFg2UhF/XvvxacZlERVySrJuUSzegr439rREJbUOy0bqtznGb3qBc8e/DUdScarEjqQ+NHvAp+jCu30foPNUHa2Muccuf4PXnWMd8hPXVHl4xUihsLxetQQTnk3UokF4ajy+G1QDSccn0cxOWOpC/pO5Tuq0Rksodcv5QMWNEWz7qaHGMO+AdSi09Jmm4+NfEU/yATN1wLLAiyPleiRdLAVkgPmO4KrrzyiMPcWSObym0lfZk1bZ8v02r8rXpKVhQOuExkzM4DyViC7mhwU4QKx5Pfl3yMy/7G3QLijQIR5cC//sUmyNOEGGggnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OehAyRoZjLR3a5hc5eWpv7UNPEKV6B1j4xI56uoKf0c=;
 b=X5zHp3W7IpzCuse6CP165r99P81n9YtFn60+3oQ5WNDg3E/Taoq9jT25FrpluXPN31fLt1Xa/8uefHdabzpxdpccaStSKbEogOxEVS3BSj03T0jzu//Fu1dPrBMHpuuji/OkjnZ+s+FEZuDvt+tlQGivowJg24Ilz8l/9Hbh++ZEySlitLZr54hOaApVDM5gCVZiT6j+fAbothLprSWV7SztvBH6lcei7NK1kjvh/5X3tXDK5h6tF0JaLkL1TC5sGZrqgOIbkhRtT6TFKAJ9AVX+PkJJ1Juy+cRDv33FqO0z+MIYjH2fKAU2dpCBwskCgKlMqk8MpJSdEJFYZratzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OehAyRoZjLR3a5hc5eWpv7UNPEKV6B1j4xI56uoKf0c=;
 b=nkpUuvU3seWwlgItY85QqU7dZrwI8yixAUI5flcm4zLKYUOP8//nacz7Xgv8R6z/GNGJ530OOn7IRv0EE9vKEGVhorYRkbOIh6LeGIk7V8J7/eZu71aaFN4JGt1j4Xoidq8VJ1pgj0I7sqfQhkmw2B9CxxfUWQa1em0lRoXFTi4=
Received: from SJ2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:a03:505::24)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 17:21:08 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::40) by SJ2PR07CA0022.outlook.office365.com
 (2603:10b6:a03:505::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:07 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:03 -0600
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
Subject: [PATCH v7 04/22] ACPI: platform_profile: Add platform handler argument to platform_profile_remove()
Date: Tue, 19 Nov 2024 11:17:21 -0600
Message-ID: <20241119171739.77028-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119171739.77028-1-mario.limonciello@amd.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2ba382-6e14-4de4-2329-08dd08be8e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGRBcWxBMEE0U21QOW9IbkZ5V09takREb1IvcVJHSE5mZnIyS1VNa2tJL2ww?=
 =?utf-8?B?Mi9UL2VETmRuc01kT0oyTnlpYmU5RmpOaHVyR0pnWmpyd3lKSklaa0lmRkxy?=
 =?utf-8?B?NXZac3oxZ1IwVlZ1dmc2eDlMWVdrMlZrc0pVSFByRjBHNy8vc2lXU3RybkpT?=
 =?utf-8?B?ZHI0Ymd0b09MT3VaMS9hWFJycjREejFmRklaOFF4bEEzV3BCYzh4YUU0L1pF?=
 =?utf-8?B?bXRCekRSaThvTCt4Y2xuNFlzcDZ2czkrSkErYWhDS0tERXlHY21kRncxSVUz?=
 =?utf-8?B?TEd5VjdyZ001YjhWWmlkbGtUQlg3aCs4NnJFRHF0V2ttZU92M2RJUjdTSlJD?=
 =?utf-8?B?R085NTVHcjFLSEdFMnhMTGZKaTFybWJJcEpOamgraGtFZUNPN2V3ZmlEd0lP?=
 =?utf-8?B?bHNkZkVhaUc1azFXS2h1ckMyYi90NkpiaDBDcnRBS3JxZzQwaDlxbmtxU29E?=
 =?utf-8?B?TlNhZVh4WUdYaThxRmFJdmFXOUdJYnByTkZIU0xwS1g4OUZGeWFpY1JDMThi?=
 =?utf-8?B?N0xaQVNPOVVhbk9YbjErYm1hT3MydWFBNjl2K1ZzSGk2WVk2d1pQckZzU1lD?=
 =?utf-8?B?ZjJXam03bGxzTnFDNDgxNEpZTHc0RUNjVDVTZEd2TjVNYm9YRVZNejZjOHFq?=
 =?utf-8?B?L1R3ajlYZEhLL2pkYUJVbHlWb2VTWlJUYVZabHpZWGU3QWQ5NFJUc1I2ZmlD?=
 =?utf-8?B?bjM1U2E4S0pBNnFmMjlNM3d3ejlFSmZyRlRlMUZsZGFGUU5vNWtEOWlielJQ?=
 =?utf-8?B?aWsvcUFwYlg0cyt4d1JQTWZjRlpCU05KRFFEWU9pblpNVWxQK2R1OTIyc3dG?=
 =?utf-8?B?Q3ZJKzVDbjM0dEZHd3JPeHN4ZUFwbmp6UW5pY2JLWGhtOFRPK0JVTVRSblo5?=
 =?utf-8?B?OVo5Rm5XekRnSDZXL3p1Z0xLN1ZLKzRlUkRrQ2FtenYydUt6UGpCTzdxM3Yv?=
 =?utf-8?B?TmFKVThWT2RHaDRKVWZWMU0ya3B0WVE4VTFrSExOL2NTeXpiQVczVDZDWFZJ?=
 =?utf-8?B?UGZyc2lxWit1QlMvQXVGVEdLQU01SWJvT0oyb0NmeEdldjdpS094VzkzMnpp?=
 =?utf-8?B?S3N2eHhLRDcweWF5My96bkQrWDhsSGJ6enR1WU1mRkQ1dFVMSklFWHdKMTAz?=
 =?utf-8?B?QWRqanRPa0hKYmlVaWVmRGw5Z0RaT00xZFB2QXZzdmhBTFFSaExILzNTcVV3?=
 =?utf-8?B?NTJjTWtXWGV5UzVTNEp1Z09DVHh0YU8zSXRJZnc3SU52SjdGbmR6MFllMGJ0?=
 =?utf-8?B?WUx6QjdBcExqVllLNXd5a2phVkVaMnVUTStOOXdQQW54WWw4RmcyR2JWb2d0?=
 =?utf-8?B?RUx6S084RlRVNjA3ckZ5WFRWT2dPOGZBbHF4dGh5YVVPKzIxT3JiOVYrU0NL?=
 =?utf-8?B?OUxTelRCOUxmRlZIY3EvMW04dzI1b0IwbDFUMWhER2MvdlVLeUNncjVZWk9y?=
 =?utf-8?B?U3BDSEZCc3d4Ty9Vb0l2bjdha0s4NVRlbFN1RHJid29pdEw5bHZ2RGhOSGh5?=
 =?utf-8?B?ZVpxeTY4d3ZCQko0WVUwUG1rSHRnM1ZFOGxRV3VPWHBSdEllbUNuUElpL2dk?=
 =?utf-8?B?Q1JhNHlQL3Uxa3p5Y2ZRMTlBNjR6czAyWVZRVTVoUGllTEpVUWN2RHpkdzhw?=
 =?utf-8?B?ZlNQRnZESFFyWXgxeXUrZ1dreXRxdWdQbGxzSTdXejhubmQzc1NRMVdwTDhk?=
 =?utf-8?B?bXBnU09EcDU5WUZuVmZSdVpNSnNWKzh2TDJRTlBzZmdaYkViamx0OW5tN0VB?=
 =?utf-8?B?VlBOWngzUzhldWJaTHJuanhYb04ydW5sNUZwU3RwZmwvaWFlbEVNY09ia3Ns?=
 =?utf-8?B?a2tTUXRMM1dpc09WdXRjWURIY0tvSjFySUhGTTBiZGlSMklYdVBTcDc1VWFV?=
 =?utf-8?B?a20ydk9zTDRxQ3ZoY0RUaGQzeFp0ZS83N3lXRE5EYlAwdHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:07.7062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2ba382-6e14-4de4-2329-08dd08be8e32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719

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
index 5f45f8e8cd69b..b449c4c8b883c 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -210,6 +210,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 		return -ENOMEM;
 
 	tpd->sdev = sdev;
+	ssam_device_set_drvdata(sdev, tpd);
 
 	tpd->handler.name = "Surface Platform Profile";
 	tpd->handler.dev = &sdev->dev;
@@ -228,7 +229,10 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
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
index aca4a5746bee1..b12965d9fcdb7 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2547,7 +2547,7 @@ static int acer_platform_probe(struct platform_device *device)
 
 error_hwmon:
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 error_platform_profile:
 	acer_rfkill_exit();
 error_rfkill:
@@ -2570,7 +2570,7 @@ static void acer_platform_remove(struct platform_device *device)
 	acer_rfkill_exit();
 
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 1b94af7c0e0c4..bd2bd6cfc39a0 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -426,5 +426,5 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 
 void amd_pmf_deinit_sps(struct amd_pmf_dev *dev)
 {
-	platform_profile_remove();
+	platform_profile_remove(&dev->pprof);
 }
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index c15fccf5131af..9105b456eab1f 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -4842,7 +4842,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_custom_fan_curve:
 fail_platform_profile_setup:
 	if (asus->platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&asus->platform_profile_handler);
 fail_fan_boost_mode:
 fail_platform:
 	kfree(asus);
@@ -4869,7 +4869,7 @@ static void asus_wmi_remove(struct platform_device *device)
 	asus_wmi_battery_exit(asus);
 
 	if (asus->platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&asus->platform_profile_handler);
 
 	kfree(asus);
 }
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 78aac76132788..e95d22c7b60cd 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1165,7 +1165,7 @@ static int create_thermal_profile(struct platform_device *platform_device)
 static void remove_thermal_profile(void)
 {
 	if (quirks->thermal)
-		platform_profile_remove();
+		platform_profile_remove(&pp_handler);
 }
 
 static int __init alienware_wmi_init(void)
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index e5724e76a2082..5c4d48e4b667a 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -289,7 +289,7 @@ static int thermal_init(void)
 static void thermal_cleanup(void)
 {
 	if (thermal_handler)
-		platform_profile_remove();
+		platform_profile_remove(thermal_handler);
 	platform_device_unregister(platform_device);
 }
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index ffb09799142bc..6d6e13a0c6e2d 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1693,7 +1693,7 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
 	}
 
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 }
 
 static int hp_wmi_resume_handler(struct device *device)
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 24367c3590c99..80797c6ae8b0b 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1136,7 +1136,7 @@ static void ideapad_dytc_profile_exit(struct ideapad_private *priv)
 	if (!priv->dytc)
 		return;
 
-	platform_profile_remove();
+	platform_profile_remove(&priv->dytc->pprof);
 	mutex_destroy(&priv->dytc->mutex);
 	kfree(priv->dytc);
 
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 5a53949bbbf5f..53af73a7fbf7b 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -191,7 +191,10 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 
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
index 222fba97d79a7..13798c6d5fcf3 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10638,7 +10638,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 
 static void dytc_profile_exit(void)
 {
-	platform_profile_remove();
+	platform_profile_remove(&dytc_profile);
 }
 
 static struct ibm_struct  dytc_profile_driver_data = {
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index daec6b9bad81f..bcaf3aa39160f 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -37,7 +37,7 @@ struct platform_profile_handler {
 };
 
 int platform_profile_register(struct platform_profile_handler *pprof);
-int platform_profile_remove(void);
+int platform_profile_remove(struct platform_profile_handler *pprof);
 int platform_profile_cycle(void);
 void platform_profile_notify(void);
 
-- 
2.43.0


