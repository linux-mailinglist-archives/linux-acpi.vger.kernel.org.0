Return-Path: <linux-acpi+bounces-8992-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D82F59B0EFD
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 21:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079C51C23ECD
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F1E20EA47;
	Fri, 25 Oct 2024 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D+IFjqnx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB81865FC;
	Fri, 25 Oct 2024 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884682; cv=fail; b=mt005x7pZjCZqugqiXLJ+CzggFFZZTZBxQY/SX3g+9nvE5Qfj6NzuLhiM/ZONFhDo7kfK46oWM9yU3DV3dOkSK8ifUg+66tqbOYNmxBJ9iyEO92ZSBCJNkrbdT4ukOmAyCr1SyDsqMQCYOpFUqx5xGCCwfCMtcSpeeRasfmN+F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884682; c=relaxed/simple;
	bh=bxJZQQH5u37wsrdZxWT59ikCwcRP1zRdbJjm1wvomuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CC3guemhoyQMTRxxWM5HdgWdGjyWmrZ0zkOTrzccdKRCMyQwSX/0mMbP5reVKLKy7vGIFwVzmFTB5LqSSFq4827hgGyB3LhCCsgChgmeBbZ5eTsjSYBEFa8ajQxVMb3SjgSDS0PV84JlR4ldlubDNo5ZB9PxIbdyVVXwxSo1Nbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D+IFjqnx; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYA/ywPEAfX8/lYj7GFxyOPVUsow3+BHsfsy0tQorqEU79uaP9SEwgJVSBzPrKzlALgUL85mptEuR+QVWu8WxIXdcUXC0c2fEtLYgX3NoenzJsbx3N4OB4VrzjeAlkUlCwlskO03+Y13Rm137DLWgB26HS0GFIpYmE5F7ex3kkfjF909yhcmpE1CIRVaOTINpuKTdfZpfQTzf8/4uk6zQmzFhXko2hEGPxid6r7NCEstp1fR5VVmeKIVNiCydFZsd4T1QogL0BPJ+PLw8KmspBSv8rvZzrHiLiPgdElgKttcAxUQ45ajHgH0PE/sMQE+Co2j33lq99m6MXVhw/MNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEIYs8yjfKQCobKxq64NDBeI6kyImPvWvB8magPOI6Q=;
 b=KScsjUn8/Yrp9H2VqnWBGHE4bd7kEK7opz7YlpaQIaa3sAnz4ebyItecHwsf23s4D1Y35pVMwE2l3NzT+R4QnhYFXiXRvVhODXGxeqFyqxpdmP9JYc/i9L32QWKO83yzJLN7WeyttpILHXXeN6m/BrznhJfp9FPkv69i+qtwPeMptvZIlUjNGR4NhUHpnliO8akUOoTtVAqG4obxbVgE0O45+3bH2Os6HANgRkTEohZ0y0/z059ervai7XOLZfjr11w3OZCrqdZtXLxzH1DZEDYLWaWj8Wv434Dj28z2tPY9pkDpFhDgZogmyQDOxm3Q+VxHCBYKpxpiN+Z+YJEErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEIYs8yjfKQCobKxq64NDBeI6kyImPvWvB8magPOI6Q=;
 b=D+IFjqnxi14EgRA1xJ1iN/GNR/G3TSk0t6+yzR4qjnekWtX26VquI2Ibh8oRuo/S88RzczNcRIPDzLzB0jnMZ7UY/UTNFQYo/L0Wl9uHOGGne7zuX7og+aynW0b4tiCxRWEQtEtMIMsYAFhkD0V9PQmWO/1Kj27uNLPAoRXuurw=
Received: from BN9PR03CA0164.namprd03.prod.outlook.com (2603:10b6:408:f4::19)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 19:31:14 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:f4:cafe::fd) by BN9PR03CA0164.outlook.office365.com
 (2603:10b6:408:f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 19:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 19:31:13 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 14:31:10 -0500
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
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/8] ACPI: platform-profile: Add a name member to handlers
Date: Fri, 25 Oct 2024 14:30:48 -0500
Message-ID: <20241025193055.2235-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025193055.2235-1-mario.limonciello@amd.com>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: cc629b13-2ce6-4ad0-3a67-08dcf52b9660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JpFq4Ol2mOKt6MQ9aV7snUcmxngxVkP8Rvpo+f2rJN9BLf2hUKh/v0mzdI1V?=
 =?us-ascii?Q?lpXOqBGmiu5nB9qQGlx3/kcQHdXNAl5TpaTfOpZ9BUkyIoyN8T2g5Zreh4rl?=
 =?us-ascii?Q?n3dS1jF9fjbgMj7+covgE6vI3fws8Og0ZVJUruCn7Uxg1MalKSaELOaJB0BO?=
 =?us-ascii?Q?nw1SA28hs1RSTGiD0QcZnULpTg5ZP2x3ZkG+qmEVEFiiuVmXiuJVZZha7HyY?=
 =?us-ascii?Q?aVmd41VF09Layu4ZNZr/aLGpsO+1U/4mmKH4v42o4NlwBfa98aNVrB/hMctg?=
 =?us-ascii?Q?dINxtZp3Bn6OQASSxzXZ2LfkXgwkD/2KG2xRyBt/+61vTXjgpRdWUyDp+Z52?=
 =?us-ascii?Q?FavFFfY5jvCHEfk4FifSn3rBmyt3+T4pjVafRIJ2Jj68C0UC0Te+/r9+K2Zb?=
 =?us-ascii?Q?bdzwrUC+S1aDeU74GwSJlJEUnDfzc4q2Td8GUh/Ow9KSS3nkYEHyhAYk92E9?=
 =?us-ascii?Q?tmryiA1Zm5A3+CVnrRgfcNPUDWcZImOgNRRTKotU2/z7hKDSKZHvXVhfJ/J1?=
 =?us-ascii?Q?7EG09Q5t48ePnDZXPSvhRGL+MuwCRDYJ+UFSLg3ZvXIBc7Hf9mY7rEdgIZeL?=
 =?us-ascii?Q?kfd3XMOKLYnY5qejkECKBJbmt55DToPLyrGaMQKMVnKAAcZPiy5avDnZZfB4?=
 =?us-ascii?Q?RU4xlT2d4vNtRRkPg6VrUhz4K5oj5awXNJk+Gaj6pSubkRiAQ5LJqg9RiACW?=
 =?us-ascii?Q?hpQ3XLxIMFmcQTBJiyVATdrgFcfW7Qdn2reCZ3tyupwgBEIbu4fN4YzVcTJh?=
 =?us-ascii?Q?xqWZ7QHx7dEwMWx3q6yPbSVBt8THEkwikSZuudy0/w0MEclr41QPTK3tTty1?=
 =?us-ascii?Q?u0BJSO87qdPTah8ITndFTJXwMAH6dZruU2rVIknsAVOn7A95mw7/JgcfB8Az?=
 =?us-ascii?Q?EIWOn0SkYwUn9aDyPUVTuLEyWKbeSbVEJBHQ4Yely24NbgVTY97UEy5XUdyu?=
 =?us-ascii?Q?MBMziC2pGHd7G4jlNw65TxAdzuXO+AXBRQcg4ra5wE94g4F3+l5+qHah08Ef?=
 =?us-ascii?Q?OtOicVYfWRjMZbHQc0tETbFM/3pl1GhTQVNTcbTe8jVPtEhOz5PKSDgFFkMt?=
 =?us-ascii?Q?rfmoZe5IlbC9FFNwEgXQanL1nFv0/4Zlhc+9A2Lp54NHu6d+8cpy9MPU/jS6?=
 =?us-ascii?Q?kadlAfuDC4qZvsE+3F2X05rEUN0qZR7RjExc3WQ4nQDTTGDnSuR9nq+kJsiG?=
 =?us-ascii?Q?LNAtFSaXxkdPoVczr/bc57iL9Ch6KRpoIJNin6Fw8unnet901U+lLXTeBASL?=
 =?us-ascii?Q?xyB0PeDCMV/BrnzAWn89VZcMjqyiL9kobKNRtA7+6iI1ws0FynBwAM1/qA7L?=
 =?us-ascii?Q?sRdoRK9KTfiZQwxwL0VLnQDGciqgQGeF1KkTlxwTynYQhSpKdddf6vzJiHl4?=
 =?us-ascii?Q?FMS1+wUvrXhQJNGXoOIeAC6EGZyYtH9fXm5lw+AIINyjhI9bAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 19:31:13.4274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc629b13-2ce6-4ad0-3a67-08dcf52b9660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753

In order to prepare for allowing multiple handlers, introduce
a name field that can be used to distinguish between different
handlers.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
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
index 3de864bc66108..61aa488a80eb5 100644
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
index 2ccc23b259d3e..c7c104c65a85a 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3910,6 +3910,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 
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
index 9d8c3f064050e..1f94c14c3b832 100644
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


