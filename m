Return-Path: <linux-acpi+bounces-9016-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AD09B222E
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DC31C20EE0
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B92F18734F;
	Mon, 28 Oct 2024 02:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PlGaKrnh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DB8174EF0;
	Mon, 28 Oct 2024 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080930; cv=fail; b=qOmCOh6fby/gUZRSwO+qmYdRDVl4FZyZoHl48F0XFJexufP55IBA6YAolzGAdp2b8Jc9V5fZ+yIRmbNw5/fVdbEhRuxXm5L3XXfff46dw7Tk+1wydt17MbTlVf1zKxNqqg72w1Bx5EMWLf2SurL2aUtGBfCJwIy/6vcfw8Zpp2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080930; c=relaxed/simple;
	bh=UKH3Cd3FdQ6hIy3Zj8VNJUSXixyrxzUlvgD4ttF988I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfhopl8xf2yBG0f+mesnMMVBWAZefKr3l4kI7EZUX+cSLFmJUTuWP+Ak5NsQaiLsGy0XCp7J54jM51R3C0XxCzw+hXZsBc2Rg2DOm/sEmA9YCnU7y7pBuae+ajZkQM2XeiTjiqgHka9J5qJiTUbKJxinQCztMRkSk05YAfR4PKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PlGaKrnh; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arj6b7CTnxuqfByEKBExUrPp1S2r14wWgh3Bf5ugRYZJrFVuoZEkMWQ56Qjd65YfYPlxRZlBeCN7HeGloR6DRFhVRB794qBTNfpHPDVHy1UVIowsViRUbEzXFLNriKCsOGNtJDsXIlwODvboQlfVBdvg0q6lKt4lrTDBaGWWjv2uQHRMzA/sRTdHXAxhVZStKHfEj/N3v6SbpS1JOm91MiTvoHXfVpiRO2Wq6//QGLl2/Ye0A20QmGkcdi0MpygZ163KAtKSOjrlToNP67fkdeYZ6JTX3ZrXtY0U+eQVwucHoqoM+4dSdu4qX+TOwvITpScfBIigbrJMAj1xwJ5OzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5TXgnY2L7xAtUurtNfnvETk/PhaZ23e7WGCm1sQZ6Q=;
 b=pSvVYqNxEtz7puzUrr+BCAbq6RoTq7RVTYwrXK4fFXygvZjNBbRcBH2YcU0MV8mChffR6LSwynGXScry28I9+Csh1PfE+yaU3VODE0JtariQ77jW6nJvH/mG3WKbCM1JnMuT0dAAqL3OPX1wbzWkEen4lEKg7Q/cFSJFV7dI69vVlsnOsCzRYUPW5QhPQjaQly1CEYHpBZ3iqrUKKKxVqovXS4JZKs1NRM0DXssXTYS4DxEZz6QN/yz742/OebuUgKBZfe3sPD4UEi7IOecB4Bu680l+oN/k7bH7Nq0T0Rj5SZYviYAeol64gdMUfaatqotzvpj0JycZVtL6c0IKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5TXgnY2L7xAtUurtNfnvETk/PhaZ23e7WGCm1sQZ6Q=;
 b=PlGaKrnhOyrwZHlnY2yrSm9s74AFo4qGq5EMM1LcWbNy1uLpUigcaD2A9D5qjdp0xN//ZpL3BnrofsdhSHp8hNB2o11qd8BibbughLPXppa3b9pZHkUYemRl1RjhSpJNCfjeODn3dSgo6cmOO+RSPEPvhH0XzSfdVXu7xX5N/Ug=
Received: from IA1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::7)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 02:01:57 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:461:cafe::29) by IA1P220CA0010.outlook.office365.com
 (2603:10b6:208:461::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 02:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 02:01:57 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:01:54 -0500
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
Subject: [PATCH v2 01/15] ACPI: platform-profile: Add a name member to handlers
Date: Sun, 27 Oct 2024 21:01:17 -0500
Message-ID: <20241028020131.8031-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020131.8031-1-mario.limonciello@amd.com>
References: <20241028020131.8031-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 91be84c9-bbe3-4ae6-f3c6-08dcf6f480f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HHojgvmMPnzEbIm+mvSouv+IPQVSL3x/SHtb0S4hOYXWcK4qBCuzLkZIvSoY?=
 =?us-ascii?Q?Yjl4DTeMg61pvENDaMt9MbIj590EAZZuQR7RtWHY2dfV/9R+9n+uFHaToCms?=
 =?us-ascii?Q?x0AzHUxs1fZ3n5eijdJ6+1pWi6cT9CRyJfoI5TJBJicRFqiJHOYzez0to0ag?=
 =?us-ascii?Q?jway38hEHj/4bW2SjsxQzYFWJfgGY0rYcxPOb8qjjtqKXrJH1RJmf4fyeDQF?=
 =?us-ascii?Q?9ihdmBiF7SOmxSkZIpl4c5WzLd4GyLLriEjHbrE9m/eiSlon1xkNJwtYuYfJ?=
 =?us-ascii?Q?R0K4BBfHXdbzykKJttFMRjoAIvFvFeF649wDI8S3ROAM0f/eNZgRLJJj2+cw?=
 =?us-ascii?Q?QljctlTu1fm/RBOuNdSKnTVV57tnl5wnnTrbHbWaywweySI6hDGjvtOgFt4U?=
 =?us-ascii?Q?awGvlF9OANGCMxnZ+3+pHk4imEbn3VbzzhCD58Ldazf/qu4PArtT8HV5vIP+?=
 =?us-ascii?Q?XsRAG3gqJXB9mrwnSgGQvKEezySFupUz//kkvuJqUiws0lCqZYbuABYcOD+c?=
 =?us-ascii?Q?dqNJxTDdBeG4gq0JJgPcDhsjbUCUf9PzqBLqtux+qFhcpVdRbf5fnL5Gm11Y?=
 =?us-ascii?Q?+hAdeAohvlGTQFLah4vtq+KBuQubNjq4kBvlJ+9hgLC0fThzLBHWGzangiZM?=
 =?us-ascii?Q?0I8WPquBJcxjWbXbNgYnOfypomgcn0KLk4BZ+7e4fJbtgQAGz2MDsmP1iQjR?=
 =?us-ascii?Q?NT8u2+nmlo62ryDMoDYEEzRbnoD8gg/pj/UiFHh6BfdxH18LtyFtSel7HJG1?=
 =?us-ascii?Q?FX+/sH62AMHb85RwxeF8fCzHxYoMm4KzFiuoXNK67dHl3jSpk2ne9ys/JFdG?=
 =?us-ascii?Q?FPNaqqKQYkvtVY96KxscCTcVZN0wMJCnD62YW1Q6jjHEXA348nlZOptqJJon?=
 =?us-ascii?Q?52bujzyKfL8eyOUAVM4IqqOfoNd4jydfYKe4NP+1dt9sFRbjyI/dCWUg+aPb?=
 =?us-ascii?Q?wtGXDJupLnN9y05wDEQJuAp79kP5Xo5H9Qow+aP56rbT/zT2Hrq9JnzUHnMy?=
 =?us-ascii?Q?brIa0jFnrn5us+P8ZseM+H/melOSJ8BmR59r/5X35vJqhY6Pp6NPz0E4Ifkt?=
 =?us-ascii?Q?dsG8Pz9aIpebsloF/j5Dey/0Aplk1fDbWj7uiVAIE7WRqo+sUyIulw2w69Mq?=
 =?us-ascii?Q?j6CyeobvRz6PIjHUi3emtv+n4FdJF0GXbIyKH8jugO56ln7Yn6hPo9Cj7dS1?=
 =?us-ascii?Q?+hNOY+hnnpUAwFSVFFanhontPjPfMw5+awXkLqrGUCqZ6SqOI2vP3xw8YvN8?=
 =?us-ascii?Q?uiX+UuuK7n5HCwxPM45VQByTYYMZRxQ91VKLzedc+sD3bCZbaBEVZ/84EcT3?=
 =?us-ascii?Q?J73YMpUOqu2KAC8WYvVajko1a0OKBuVJd4Q8/HRxAniCpiaEi4N2VjvuIOWj?=
 =?us-ascii?Q?qPEFCRyowOmC8JbUXUHR1xyjrfUei/bErJ6vzfBdxejBHH/EnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:01:57.5067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91be84c9-bbe3-4ae6-f3c6-08dcf6f480f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671

In order to prepare for allowing multiple handlers, introduce
a name field that can be used to distinguish between different
handlers.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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


