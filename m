Return-Path: <linux-acpi+bounces-9802-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B199DF0B0
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9FA16361D
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB019F13B;
	Sat, 30 Nov 2024 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MrhESAUx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F36199244;
	Sat, 30 Nov 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975534; cv=fail; b=YO2pDzcGMidC7IHNad891gqnK3AznKDFCyXRodZzwQ0JhnRgDAFh9HEiJBDCN5c30hISWqdJHLO62WTLuOcURj6qTJPMZLKnfCbJEfTcT+mm1Yh5GEH4sDaToJhJ0aIKlYuIDzu6ZjcBgG8n7bUQiLXReGnFEnct24v+C/bDjEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975534; c=relaxed/simple;
	bh=KAmzADGxJcKaLoK6Fox40IFyK6MzX7KbT757o8ri+xk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QB2XOOFNePPCoz3k5xk1Q2sAyo9PeiZpDPnw/g7UnPF7Fk/7oZhdWqbFcPJ82QyA1igkHy7EScYFB/n0l0mlu/JnC02D9X7KI50iYrhqHTCBmoJ9Mr9REJO3e4zIq6RMiBb+nntargF9yW+3ONvIrLj2gaWcSQ03lcARwQwivbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MrhESAUx; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVNYmOFTrMzNom/1ZctyqLfqYW0Kakg+u7CNzaCmeYMYFHnBGDp1Ybgbc0awCk4EUPmQk/ismTMYliJua+gdnb8WhjbrX2mDqfWFXzDD3YZSsG+uL8pIwqQaiBhuqkOIXC0gDQ7Em68arhK1EzyS3I4v7yCmUXMLpi2aA7ENTLAmmSrFgsbz01IwPY8cuPrSjo3PFNyNJhv72n5DicZoRT1zTP07+3Jjr9rjaY+RUCVGX0lUg4qlFltYAd8QYXeCSYClDKwxVv3RXnextfKwNOTRq/yaA+cojEnSFSRM0eI9fxo7y8YMeepCE2u9RRz3NeEwN9MYGNLYde1JFeEiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NrUQsRvirxCQhPmkPFs67B2eZRv9FTrzqwvVJHiK4o=;
 b=ZZTLlr5eXR36Mhyqc/iAIr5SjBPMA3g8cwV2drrWUiB/vNut0pBHr3QeTllBx+Gka78/pSRIQGeBZcVUSXBH//0SuN0VpjpLtQpve9HN8sEZMgoHdw5D85o1nR+Pw9e0vHqijrXZBwsZaakSGkkL9QR++aYAOvMXSMMtLzosdNc07ZeOowg883vCq3kYXvkVhaL+B4nvzhJleHMq1tqgMRVkKiLEbLxpxEiJGJzdwbEXzYV2lDYEzI0wPJBKG+mtTNc34YdDSeQ1t8Hgt3HVHSteuM1vCOCouFsch0T4iormjj4R/arsHhvq+qe2CufHWR/x757flKIwrXsvQlufVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NrUQsRvirxCQhPmkPFs67B2eZRv9FTrzqwvVJHiK4o=;
 b=MrhESAUxo4eXBRP9blXEUI/XkJlHo7uXWOWqPaJnERZo23CJaH+a2ljdtDZzz+BxV+NnXMhiRV95iRPemuU0BOc9XpgogaBZe8fpLEwjPUfwQkWcat4ZilDPd7libt54aUjKitYepphfcK7oYEbZqIYyG2N0fiDIJxyci0NpaTs=
Received: from PH7PR10CA0011.namprd10.prod.outlook.com (2603:10b6:510:23d::12)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:05:26 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::88) by PH7PR10CA0011.outlook.office365.com
 (2603:10b6:510:23d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:25 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:22 -0600
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
Subject: [PATCH v8 03/22] ACPI: platform_profile: Add device pointer into platform profile handler
Date: Sat, 30 Nov 2024 08:04:35 -0600
Message-ID: <20241130140454.455-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: b3db0e60-311a-47fe-3b1b-08dd114809e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGZXRWJLSldTVk1CSE54bzJxYytkZERJT21nQXA0M0tkM1FvZ3lSYjMyODMw?=
 =?utf-8?B?dVh5NDZHSFE5eEVYQ2hxWkdwa1M0YjNnZC8wNnFmNndHNVN4c1k2T2dlUHRy?=
 =?utf-8?B?OGpzUk9iTFJOTHpkRjhBc0hlTFEzdVVpdHNGakFLWGZBcTlFaDQxMFpOeXR0?=
 =?utf-8?B?dXVTSDExOU5GNXFBZFc3TVkwWVdBTitKNVJsSHJaUnZ3Q3JoczdFZDNTQ0Fv?=
 =?utf-8?B?enZ5M2w3TnNCdVd3U0g5cDRSYzh4NVZ4ajcvZHd3Nk9EZmpMRlhqTkkyellt?=
 =?utf-8?B?Mko2ZG9SUzBTVllwUE1ZbDM3US9EUUVtME1LalBLZUxrVjFMZFFlbXY1VWcy?=
 =?utf-8?B?Z3F4a1RKeXFOSUFiTEFtcmZlcVFzV2dnVjhSd1lOTHBKZkVLcXZ1RDZCdGx1?=
 =?utf-8?B?MUFxTzN0QkpaK3ZVd2FhbC9MWXN3UEgwTUZTekVjVTNVY0ZMVTdqQWxNbm1D?=
 =?utf-8?B?TTFnUSt3a3BuQTBPeGJXV2RnZzVIY2VlV2ZQOTFobmJ1T1hzZU1CcnMrQ3Vy?=
 =?utf-8?B?b0VOWDc5V2JVNDEraFQyazlKM2djc2ljbXgxTkdpT2ZTZUl5RmlmRlBRNENF?=
 =?utf-8?B?STZ3Y1BlelduWnNWR2NxWEcyNXloWExPMnlTYUxZMy9FOFZra1dJNFFWalEz?=
 =?utf-8?B?aHgzQUltbC93UUMxYTR6ZzFUSGJiTkhZNGZJZUo5dDRvcnBGWlJVV2VMVytu?=
 =?utf-8?B?OTd4bll2Z1U4TDV6UWdKV2VGSnExNHE0aklaZkxUSjNYTXAxR25oZ1JrTXU2?=
 =?utf-8?B?ZnozdFEvM2JMN1NVQ1Z1cFg2QStHLzBOUFAzMitaTzFvUkxCMG5xaHRKUDEr?=
 =?utf-8?B?Vk94aE5Fd3RCUVdzWmFueGtFUUQ5VXY5ZVdpK0lOTkRGeFRVZVhhcStBRTZh?=
 =?utf-8?B?OEE5am5VMk1Ub0dpOWJJQm1NU3g2bXRGNzJJdUJ2Sjg1ZDVOSkxsdXdadTcz?=
 =?utf-8?B?Q01McXBxcllKQW9qenozTFVyd2s4WnI4QTgzVHJUSXNNR0hBa1k1QXg5MEZN?=
 =?utf-8?B?d3RIOGh5aWl6bWFSZHFzd3FHcTlNc1hVeWQrSHVUdTZVaGFVcnUrei9HQUN4?=
 =?utf-8?B?MDI3ejA2eGxnSkNxQmc3YVhMbFBxdUN6MWhOdmtmRUlabXZaT1Y1N0dubXhH?=
 =?utf-8?B?TDhyNENRc2FpcDFJWnNDZzBxdDI4VVl0WUdKUnhGNXFqbXdheUloV0tNcE9q?=
 =?utf-8?B?VklCSGZhWml4dUhoSkYrRDRCcFR5eHd4WC80VFpvdU9UL1BsZ3h3eFY0UWpM?=
 =?utf-8?B?VTZoeDB6YUNIVmJhTWo0Q1BSVUpWK3NOSE1VUjBLdEM3QURwRUpTRmMxcUNs?=
 =?utf-8?B?ZnlEaUdJTjVLQkpBbjNwQXdGMERiMXRjei8ySjRjWDhLZDk1OWhEb3RJMzZC?=
 =?utf-8?B?VlpWaFZmdFp1clhWT3k4eXFveW43Y1dJVTNqV1dhYWZnQTJRMlgrMXRXb2xs?=
 =?utf-8?B?N3V4V3Y0SVBSRld0dk9MNnhGaElYZmxQZ1BzM0hWM0xaZG9iOGtwUkxnWjkr?=
 =?utf-8?B?Vm9FKzFNQ0JaL1dsOGVKQ2MwbEtZTlRGWmdXT3A4eUJyeGNPYUlBbE9VNmtY?=
 =?utf-8?B?VTRybzl0dnlBYWpNa3NUMW91elRwcy9ka2t0RVphMGx1eGhiV1dScW9ESWcy?=
 =?utf-8?B?cDZwaFR3THowOStrMy9kRW5VVS9Fc0xCeHJVUnMrOWR4RWZBVFBmdHFWbzZ5?=
 =?utf-8?B?QnN0SGJVc3R6dmRpVFNzWXVnYTVIUUlBbmI1YkozS3BuZGZlOVVtdzVkeWZ0?=
 =?utf-8?B?WGdlNWF3dEd0UHpNYVdUSWcyVU9haEQrUjY0citTN3FsUlB2ZmFMY2h5NEZz?=
 =?utf-8?B?M2dTZWxYbkwwUmxmclFCR0hpc2M5SXpFVHJUZmlSQThrbjhkTVNxRTVPRHp1?=
 =?utf-8?B?cWxWZzZQZnNBSExJZWh5UEkra2xZblg3Tk1GVmdlWUdHZnFxTEZDWlE4TWQ4?=
 =?utf-8?Q?SxAUMQjQDPx2JA+IrkJi1FHZ6be62aha?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:25.6095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3db0e60-311a-47fe-3b1b-08dd114809e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257

In order to let platform profile handlers manage platform profile
for their driver the core code will need a pointer to the device.

Add this to the structure and use it in the trivial driver cases.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/surface/surface_platform_profile.c | 1 +
 drivers/platform/x86/acer-wmi.c                     | 5 +++--
 drivers/platform/x86/amd/pmf/sps.c                  | 1 +
 drivers/platform/x86/asus-wmi.c                     | 1 +
 drivers/platform/x86/dell/alienware-wmi.c           | 5 +++--
 drivers/platform/x86/dell/dell-pc.c                 | 1 +
 drivers/platform/x86/hp/hp-wmi.c                    | 5 +++--
 drivers/platform/x86/ideapad-laptop.c               | 1 +
 drivers/platform/x86/inspur_platform_profile.c      | 1 +
 drivers/platform/x86/thinkpad_acpi.c                | 1 +
 include/linux/platform_profile.h                    | 1 +
 11 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 9d3e3f9458186..b73cfdd920c66 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -212,6 +212,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 	tpd->sdev = sdev;
 
 	tpd->handler.name = "Surface Platform Profile";
+	tpd->handler.dev = &sdev->dev;
 	tpd->handler.profile_get = ssam_platform_profile_get;
 	tpd->handler.profile_set = ssam_platform_profile_set;
 
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 53fbc9b4d3df7..aca4a5746bee1 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1873,12 +1873,13 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int acer_platform_profile_setup(void)
+static int acer_platform_profile_setup(struct platform_device *device)
 {
 	if (quirks->predator_v4) {
 		int err;
 
 		platform_profile_handler.name = "acer-wmi";
+		platform_profile_handler.dev = &device->dev;
 		platform_profile_handler.profile_get =
 			acer_predator_v4_platform_profile_get;
 		platform_profile_handler.profile_set =
@@ -2531,7 +2532,7 @@ static int acer_platform_probe(struct platform_device *device)
 		goto error_rfkill;
 
 	if (has_cap(ACER_CAP_PLATFORM_PROFILE)) {
-		err = acer_platform_profile_setup();
+		err = acer_platform_profile_setup(device);
 		if (err)
 			goto error_platform_profile;
 	}
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index e2d0cc92c4396..1b94af7c0e0c4 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -406,6 +406,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 	}
 
 	dev->pprof.name = "amd-pmf";
+	dev->pprof.dev = dev->dev;
 	dev->pprof.profile_get = amd_pmf_profile_get;
 	dev->pprof.profile_set = amd_pmf_profile_set;
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a08dc936276b9..14d84cad01b49 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3877,6 +3877,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
 
 	asus->platform_profile_handler.name = "asus-wmi";
+	asus->platform_profile_handler.dev = dev;
 	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
 	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
 
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index f88d898447511..78aac76132788 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1108,7 +1108,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 	return wmax_thermal_control(supported_thermal_profiles[profile]);
 }
 
-static int create_thermal_profile(void)
+static int create_thermal_profile(struct platform_device *platform_device)
 {
 	u32 out_data;
 	u8 sys_desc[4];
@@ -1157,6 +1157,7 @@ static int create_thermal_profile(void)
 	pp_handler.profile_get = thermal_profile_get;
 	pp_handler.profile_set = thermal_profile_set;
 	pp_handler.name = "alienware-wmi";
+	pp_handler.dev = &platform_device->dev;
 
 	return platform_profile_register(&pp_handler);
 }
@@ -1225,7 +1226,7 @@ static int __init alienware_wmi_init(void)
 	}
 
 	if (quirks->thermal) {
-		ret = create_thermal_profile();
+		ret = create_thermal_profile(platform_device);
 		if (ret)
 			goto fail_prep_thermal_profile;
 	}
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 8bacbde0f0506..398a454d1fdcb 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -257,6 +257,7 @@ static int thermal_init(void)
 		goto cleanup_platform_device;
 	}
 	thermal_handler->name = "dell-pc";
+	thermal_handler->dev = &platform_device->dev;
 	thermal_handler->profile_get = thermal_platform_profile_get;
 	thermal_handler->profile_set = thermal_platform_profile_set;
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 26cac73caf2b9..ffb09799142bc 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1565,7 +1565,7 @@ static inline void omen_unregister_powersource_event_handler(void)
 	unregister_acpi_notifier(&platform_power_source_nb);
 }
 
-static int thermal_profile_setup(void)
+static int thermal_profile_setup(struct platform_device *device)
 {
 	int err, tp;
 
@@ -1625,6 +1625,7 @@ static int thermal_profile_setup(void)
 	}
 
 	platform_profile_handler.name = "hp-wmi";
+	platform_profile_handler.dev = &device->dev;
 	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
 
@@ -1664,7 +1665,7 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 	if (err < 0)
 		return err;
 
-	thermal_profile_setup();
+	thermal_profile_setup(device);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index cbdc965eeb248..b6586c473ba91 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1103,6 +1103,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 	mutex_init(&priv->dytc->mutex);
 
 	priv->dytc->pprof.name = "ideapad-laptop";
+	priv->dytc->pprof.dev = &priv->platform_device->dev;
 	priv->dytc->priv = priv;
 	priv->dytc->pprof.profile_get = dytc_profile_get;
 	priv->dytc->pprof.profile_set = dytc_profile_set;
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 03da2c8cf6789..5a53949bbbf5f 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -178,6 +178,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	dev_set_drvdata(&wdev->dev, priv);
 
 	priv->handler.name = "inspur-wmi";
+	priv->handler.dev = &wdev->dev;
 	priv->handler.profile_get = inspur_platform_profile_get;
 	priv->handler.profile_set = inspur_platform_profile_set;
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 0e03c41e028d4..58af9020382c1 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10638,6 +10638,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	dbg_printk(TPACPI_DBG_INIT,
 			"DYTC version %d: thermal mode available\n", dytc_version);
 
+	dytc_profile.dev = &tpacpi_pdev->dev;
 	/* Create platform_profile structure and register */
 	err = platform_profile_register(&dytc_profile);
 	/*
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 6fa988e417428..daec6b9bad81f 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -28,6 +28,7 @@ enum platform_profile_option {
 
 struct platform_profile_handler {
 	const char *name;
+	struct device *dev;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int (*profile_get)(struct platform_profile_handler *pprof,
 				enum platform_profile_option *profile);
-- 
2.43.0


