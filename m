Return-Path: <linux-acpi+bounces-9985-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CA39E64BF
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A259018854C2
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F08186E2E;
	Fri,  6 Dec 2024 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WrMsYvCW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678434CDE;
	Fri,  6 Dec 2024 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455317; cv=fail; b=T2iuVzOALL1cePe46c6QXPkeDtRqMHvFt+bokpPkmVojYt3tbdiCmunfQDch7ns6RWNTIKQwVibQ3PG5XmsVeD14ahKuP8vftV020vnt+DGztdlTEHNDrRcsdFikKMqYJiIBjg4wXbdpZTsvarOm/ch5LA2wsfBdfiCgJABDHoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455317; c=relaxed/simple;
	bh=2GfJ/SjUIoNaiwHOnGXTGKoy8oQY1NZVgcne1nh591o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+qXTMu528Pmj7raetFRgnSAZpo3V2BgCCv3PrvoBXswTAPaMXFQnohvnS9ZaAjv8J5G77zOu2FCBGhc9hVZsp0Ylu7PIT0m2xi62fcsYsQDGEfcnQ86h3w794uYRwcBpz4bXF8aX3F2U1oNs7dU0vrhN9vnSJTjUA32J3ZmhHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WrMsYvCW; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6hp2EyvxQVQtkcIt48fcbJcxRXLY01Do1xWUeTZetWMKwukc0fEJ2HdSDdiiJLhRGdsETInQYniCoA9YRsrbH+VzcePBmotNrzA9QEVnQ2L70igYBjbRHfnugnrzU2bpcQ8kPmQMwaMrvBp4IJFDazTIrH/ztVPC0TziWgzOv1yRFl57kpKIV6ClfV7WPNT5iOsHqWcYnYXGiLh3P5hGIp8b/BLhPjV9BLC6Ukntn+1aNXhmYGh306nkg7G2CNvYBQ9i6o87IprNl/dg2LoD6qq1InXI/vN/elJWVnl6trN+XN6xT0MBG980+bcwGrD/+KtgKdwow93hEageJ9KQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoQnBgUUl7eonCm8N3+8uE69DCAavYY1OE4Xsjy+5YI=;
 b=f6ERln2rqYpjJRhcwI+96zi15Z/tcd0+nFUa4zV2frxNBdjyqdkcDS5xKLFtIOh/3CwBelHUnjlOE9h9gqDtPO1bwfXaiouolYER4fSOiBrF2KrRknh7xVaU54nRGSO17g3AWx2Pivd0SbqLtuSU3tqCsMgGiwfvYG/zejI3MkjIip7mA0uIfX/Kg2Zi7HZgGkdrbwpf8FJc+brsPv0Jn25C4lXyJMySOBJnFQCkSInPPO4/3sCWoWfGcK3ogBBJnukuI13PNoA0qLlilcjLswCSztFAgVGOsMzC5vM4Je8LdeNGgNkC32lBCpWUGoTFSVXYaPjeScS+3dgqbWSawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoQnBgUUl7eonCm8N3+8uE69DCAavYY1OE4Xsjy+5YI=;
 b=WrMsYvCW0BQt6BDGyB4pk7xyHHUgNde5qBI+jl8a4vya7w2bjyt6Ccyv6Z+MCQGT7pQncdk3+A3aJYu4nak0XP+qGrtVmevzumAN9rpv6wOM4yKrXt9KGTKQ8ZdFJzhvPH7w2H1cSB6mXxV+DlgDiQOiDsrNgHHKlv0w6ya+O7E=
Received: from PH7P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::17)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 03:21:50 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::9f) by PH7P223CA0011.outlook.office365.com
 (2603:10b6:510:338::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Fri,
 6 Dec 2024 03:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:21:50 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:20:36 -0600
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
Subject: [PATCH v10 01/22] ACPI: platform-profile: Add a name member to handlers
Date: Thu, 5 Dec 2024 21:18:57 -0600
Message-ID: <20241206031918.1537-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206031918.1537-1-mario.limonciello@amd.com>
References: <20241206031918.1537-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa6d9bd-a096-4a47-19c0-08dd15a51fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU53SEJ3Qi9vam8xaUpLTGpFREdaSzQ5S21JL0FUYnJnKysyM1RhalhrOUVQ?=
 =?utf-8?B?NC9lM1FWN2FsL0xqTXIyeUJJZksyQWdtbkVJSk1CMFYyUTZXaFVzT3ZFdkF1?=
 =?utf-8?B?dnBBMzFkNXI5Z05HRU9uMnUvWDZyUTgyMkdxSHBxamx4VThBd0RyK3BYNmhz?=
 =?utf-8?B?THdkZHI0L3lUajJZd0ZRTVRyR2FKSDZiZ3pibktIbWFobDR6Q0lhYzBUVHE2?=
 =?utf-8?B?d2NUWUFBWURzeWRIMWFrVHpoNUl3NUM0TG1Va1ArcitnVWZuaS9wQytOWm44?=
 =?utf-8?B?YXFaZjJmdXphZXhuZXlRZkZIR0tBeW1kcXJwc2NtNGdWR2lEM0trVHV4SjVM?=
 =?utf-8?B?T0tnRmpXVHc4RWw5cENKZUlzUWRINWRtdTVqRDdWM1NKQ0lwYWN5QUxqdUkx?=
 =?utf-8?B?VXo5MG54OVdhbHV5aW9SdFBZYTdWcmwvRFBiL1l3Nm9WMzB1dFVvZWhvSXFC?=
 =?utf-8?B?eVR4RzNTSFU4QUliMWcxMjVlQmhuVS9LdHAxVzN4dkoyZzdCWjkwSGtmKzlp?=
 =?utf-8?B?NHFncXg1dkIzQ0loSHM0bkpFUHNrZEM2Z3VhdXdtYkFlQVFtQnd2T2RWNGR2?=
 =?utf-8?B?R1BtR0JwcC85MVFzclgzNEFhR1JxUGpIVXN2WFUyRmpNTGFHa3JVb1JOenM5?=
 =?utf-8?B?WWdGZW5jUUV5OG83SFdLRlBQKzVGWmxDd0YyV2hidTNBZlozSWlSNjZneGhv?=
 =?utf-8?B?dzM4WWFjbUgzV081NEZvWjJGN2pKSlZ5dE01ZGl6TEtMOG1JV0U1Nm5aYjBL?=
 =?utf-8?B?QksrdHJ3MTVPVXRGNytlakJSNHpOaDJRd0VEb3Y3dVVScjBsZmZQWFk4bndI?=
 =?utf-8?B?bzhWcENpT2wvZklNS2JsMVVGQkRoWmdKa3pMVkV2QTlmYi9UbVNTRnVvQ3h6?=
 =?utf-8?B?YlF0KzJOWE5UamdWU2NjdDRhZzlGSlJpS01XK21nbHBqcEpQckxRQ2ppOE5T?=
 =?utf-8?B?eGNSWjRNaXBzR0NaUzV1VU15M2MwdVJtQ01COVJGR1ZQYVljMkF2ejNKb251?=
 =?utf-8?B?T1FqQUpmZlFSalMzWEtTWlEvVTFFcTJ2b1VzQ05abjJSSjdsamtzZld6S1Z5?=
 =?utf-8?B?TWdSRUpJYmlGUldtaW5vVGsvcVREazFCZitEbkJYQ3VvdWlvaXpHbzZNdHdF?=
 =?utf-8?B?ZnJmc3dMajlPbUlER1RPdGhOVkliVmttaUdJRlRUWDVTVzN6VnQ2WjhUdkVN?=
 =?utf-8?B?VjNSVytCb1VBWFN3UGI1c0pXSmpPUHlUdFdycDhTUnAveTVGRWJPMWlOVWEv?=
 =?utf-8?B?TVZCbDBlRjRKOVZnWmZMT1M5SFFXUVpBSlA4T3IveTVrM1VLd3ZEbTM5TGxQ?=
 =?utf-8?B?YjFhMGtCNUZNcjhMTlRrTkpuOExHdDQyb21qOTNZQTNSeUVhT3JFZ01RbVYx?=
 =?utf-8?B?QzlSdXppSVJVMFU3MTh3TituWk1qNkNkbXZFazN2Y3N5WkFUQ24wRkFPcWN5?=
 =?utf-8?B?ZEZ2ZXo1TG41K0V3VzYzbGZKMk1EU0VDZDN0eUpLbGJCOFBRZWh1OXlBS3Zq?=
 =?utf-8?B?ZkFzdUN6REkyZ0NaT212RGhQREcvTjVtaXVhQXh6eVVpenllNUo4WC9OcExZ?=
 =?utf-8?B?dklLNUx2RTRmUzhNWHlBMDRQUnlsN2lPdU1oY2NWang2aVh2bnBkU2dYQUZo?=
 =?utf-8?B?NnFORk5BOUd4aGtXcU5GbGViS3B6ditsbFJyL013VWowc2J1ZFVXV0VtVUIx?=
 =?utf-8?B?RmNKZU1zVEJwV2pNUi93Ym9DcWpmYTBPVlR5U1R5VjU2ZGJxSWJJczJ4Zk9J?=
 =?utf-8?B?aERzMXF5OXpVYlVBZ3hHdUc3SE1UVzg3ak8rODJwclF4STJLaHprTVE5MXYz?=
 =?utf-8?B?Y0twMUdsRFU5YmZMNzJRSm4xVlRyRlZmMENlUFZPQlJMMHkrQ3F4STlVbGc1?=
 =?utf-8?B?b1E2RXpNaVFNOFE1VnpWSm9MRUpFVW5nNmRMS0tPbE4waURPVkUwZ1cxbC8z?=
 =?utf-8?Q?SlxpzVUUGbRynlZLytHtBgXb7T6ALcDF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:21:50.3755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa6d9bd-a096-4a47-19c0-08dd15a51fdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871

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


