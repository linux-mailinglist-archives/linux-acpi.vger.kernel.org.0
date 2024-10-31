Return-Path: <linux-acpi+bounces-9160-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9399B737B
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856D71F24F46
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4C312D1FA;
	Thu, 31 Oct 2024 04:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e5XdRNFL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3C26AD0;
	Thu, 31 Oct 2024 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347830; cv=fail; b=g5qlJfXmzgktqmCeOkZFD+TKGcuvO78sXBPDFDMJynfn77Ll2qdtj8Uv+5m6Sx4mutJP6fIoW7/1VJmNbsQ0PN82Xd1pB8GkOWwoEU8O+q4xexUVlJZLt8BaF7k3hD1baKu39JTtVuxB04tY3q5H/n+5LBqTi8A7uHvQJXDSL9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347830; c=relaxed/simple;
	bh=LT207b0D2cujNgfZlGy/3GMB9YtgAVWVYuGVhHvtPc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zcpb4NxF8qhqXj0ByNzSC0UU2lIiwdrEHqZTqqVSYcPDtQ1fPdgW1wE0+Vd5cmStTM+ymLsE2M1UwdeMEhhb8tZ5T909bOrjNBQB6I0rMVM52YX502r/YoMn9J9izRmswtDDoKQI88h6x85yzd9MXHoi/AhQDLhmoct1oAL2pAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e5XdRNFL; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4IZ2MBh9LVA5nzB33kTQr11Er2vp4pbB9BmYCIVaTyUgH7hOW5g3yr+vNuZq9K+T11ttTIXF3c5f7/1AgehXLusL5Ddo9XRMO1iSKBoB8Nnf2hV3ltjpBCmBSMCw4Oo+A71mgKHw0G+nZ0hEq9D7Sr/4a0cP/N+vAHqZ3E55Z2Mqfr+rJIHOGwMTJehggGQ+FzZjTKgDV/67oq5uONSjpbseeleWZGCrHChY4ZlXGiqrOGIZBTZ6Dm3RbW6ccvoaZL9jNsd5U5+zAvA+Ewc63XAXlD3s+fE23OkxaOv+7GkgN87Nu+Eb4TxKXudMrXioQck59MQ+LuLQhPrP7ts0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEaqHAtFNbzbSffeGrvACYzTZMNrQiHOw2ZiVs6GbLU=;
 b=JcnBpfZNCHiixlS2I+w39oqTt3RWkX8s0LNQ4EzDWvvBHFt94XVXCDdkKKZzmezB22yT0n4Tme9B7tDeYhMG2LWQboDKLaWVUxGzwc6EsOBnpH/Va7OnAWHJ2cGOH3bT/AnlQgcesqbD/wu3gb8XqWlhhgUvdI9yU9tfSYsJTTCbV4CquEhCquJTlRXYzR3n79LYbxl5vsY8zuwjudtEzBpUXrgAZFBl2+3Jf9mkTosTqGEcAC+sc0r8l/b2n00SWEENlJgmpPCWOFgcHjRc4XNyvNj1YqUFnqP/W89EPlHDvsLXqyyh1phM+akld4kQz3Z6snfMOhd6BO0WlpZ6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEaqHAtFNbzbSffeGrvACYzTZMNrQiHOw2ZiVs6GbLU=;
 b=e5XdRNFLrKm5laqngo8YqCwR9VDvO9rIP9m8mlq1+wUcNL6J1t+Ln5lXbsF3+fIpTiNIl8Pu+ty8WMTv4bSzLY2hGyuCcQPhXMMCV57oXMJ2ykDbFc48L2hG/sqDIMSIz4+xz61NC6j9wjReAKoXFlr6zS0yA2Qn0oouJM8zAXA=
Received: from DM5PR07CA0117.namprd07.prod.outlook.com (2603:10b6:4:ae::46) by
 BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 04:10:22 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::5d) by DM5PR07CA0117.outlook.office365.com
 (2603:10b6:4:ae::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 04:10:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:10:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:20 -0500
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
	Mario Limonciello <mario.limonciello@amd.com>, Lyndon Sanche
	<lsanche@lyndeno.ca>
Subject: [PATCH v3 01/22] ACPI: platform-profile: Add a name member to handlers
Date: Wed, 30 Oct 2024 23:09:31 -0500
Message-ID: <20241031040952.109057-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031040952.109057-1-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: d010ef96-e0cb-49eb-03c8-08dcf961f0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?swqYY3a1kIz4LR0qWlgP3g6/2VtiDGC1edqwCMkxuIunI7iIHOs/JAQFkulP?=
 =?us-ascii?Q?C7F/rjYb3tXXtb/lbVguRB3ANGNgliN9o+WqJczCXe3+Mv+CSX/LYAagCQJ+?=
 =?us-ascii?Q?bxZ+qB9lCXMMxfDpeA2O44HPP7OjhGWKTaFzl5vNzkkwMkrhWxVFG2mwcJAs?=
 =?us-ascii?Q?v5jUUQk7gewv+7f9jwqcjBKHn3TBHUUGozJDoCXOh1saPeHLjEaDcznAZ6jh?=
 =?us-ascii?Q?SUcmZOVJjlU+E16ZQoKAroXKpq0mBFelbUbHdUZp2CFBR4BylmrZruVA6aoT?=
 =?us-ascii?Q?f+yKhcuqaT/Zjld/V2PmpS7CxeWaJetJX1Jb6h+lkF0tBko5xii01/xAWaHV?=
 =?us-ascii?Q?JAUv5v4hu5CZ/1dB/tNs5pb32QRuN9aI8g0TSqtjWgr333Y9l1EYGmecDMVR?=
 =?us-ascii?Q?SQMqUvD+5GjdjuTgLmj2bylem43VzrkXOTcpkpBKCf/7JATXveTBim3kR0+b?=
 =?us-ascii?Q?k9ZjkthWJTiaGKea15/5NZaXohQ4ljwPKwOxg33aDir157+qzX72+RnHDa2h?=
 =?us-ascii?Q?D1xwJoS1L0u27+4q4YRMbeIvZ2z9+mRweRizTFRTo2hQROpAyd4Podu+2itR?=
 =?us-ascii?Q?eBIGvcLIKiN8MPZqdizf2J6ySPqIjsyzB3ATZSLPq4grjES6Hhdif1+qx80M?=
 =?us-ascii?Q?omBBoFEDByy+OLaPz8XKFPPn8uD4itoNkr47uizT5EaRXpegk1y5F2HzM/s0?=
 =?us-ascii?Q?DCJVafZmlKO+so/hdrMws484GR5tluE+d38VJ2/Jags1KHHJouMLZZwD/uB5?=
 =?us-ascii?Q?VKo+7e7c3NtI8BvRck98u0ufqyBKKGMc9dIJV/ADidArsaNFdlzczFjMFfSM?=
 =?us-ascii?Q?U/ico4ytLIyLFL3wyG504AMAwk4ZYWmcQYLV2aWz5t8+spYAcUeLrn1Rb7u/?=
 =?us-ascii?Q?WMk7gOniCsU2nmzYqhO0CwM9agY5VyHMJ5WHGF3I3iMF/BSN6nj9tC7JaL2P?=
 =?us-ascii?Q?0xc4g8Fcj8OkqAGFHeCBwbh9Viq9dtjwRdcDqOmLyC5SptqF2r0TztrOkoUV?=
 =?us-ascii?Q?f6I4uR5V5yTTaLOQszecUdYYyuImRjtlQZY3eLYMHVT+jGXavvepKp4TDqDA?=
 =?us-ascii?Q?JFljmFX+TZr1kZPqEH1TaK+jzIXpVeyTKfoc5K3FiGQDVsWaC955kbivBkfu?=
 =?us-ascii?Q?/gIUjFQ3HUpioKA4Nu3t+jR3rIbWg6KmcNMAi8owIoFStc2E0ykMLfL/Hcp7?=
 =?us-ascii?Q?qMnyYK7Yx9l/GtiKwPp2I1pIr/Cf3teJu1pxN0m1x1hJ9ZU7+POT89OIk7y6?=
 =?us-ascii?Q?nw6rljSkO1TIpu2zmaUQ9E5cYNyjYGui9gWWzh1bfeJIX+yFY9KtnszYXfMO?=
 =?us-ascii?Q?oTE+/BVR6N8xV+fsnvAGa3BoxgLffDrF/EqPX9o4/i0kdPo+vJdBKqIWCiuG?=
 =?us-ascii?Q?bZSoMdB+41/ltMdMNkLHEowTpGj1TYcHrwQyahBUJdR1Fvm20w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:10:22.2871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d010ef96-e0cb-49eb-03c8-08dcf961f0b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428

In order to prepare for allowing multiple handlers, introduce
a name field that can be used to distinguish between different
handlers.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Lyndon Sanche <lsanche@lyndeno.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/surface/surface_platform_profile.c | 1 +
 drivers/platform/x86/acer-wmi.c                     | 1 +
 drivers/platform/x86/amd/pmf/sps.c                  | 1 +
 drivers/platform/x86/asus-wmi.c                     | 1 +
 drivers/platform/x86/dell/dell-pc.c                 | 1 +
 drivers/platform/x86/hp/hp-wmi.c                    | 1 +
 drivers/platform/x86/ideapad-laptop.c               | 1 +
 drivers/platform/x86/inspur_platform_profile.c      | 1 +
 drivers/platform/x86/thinkpad_acpi.c                | 1 +
 include/linux/platform_profile.h                    | 1 +
 10 files changed, 10 insertions(+)

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
index 7169b84ccdb6e..13a97afe0112d 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1883,6 +1883,7 @@ static int acer_platform_profile_setup(void)
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
index abdca3f05c5c1..6177fbee60573 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3920,6 +3920,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
 
+	asus->platform_profile_handler.name = "asus-wmi";
 	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
 	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
 
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
index 8c05e0dd2a218..10a853b6b0514 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1624,6 +1624,7 @@ static int thermal_profile_setup(void)
 		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
 	}
 
+	platform_profile_handler.name = "hp-wmi";
 	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
 
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index c64dfc56651d3..6c72d1b6a2aff 100644
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
index 4c1b0553f8720..c8c316b8507a5 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10549,6 +10549,7 @@ static void dytc_profile_refresh(void)
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


