Return-Path: <linux-acpi+bounces-9163-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBCF9B7384
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500C61F2517B
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74275143C63;
	Thu, 31 Oct 2024 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LyEc4zuN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC54D13D502;
	Thu, 31 Oct 2024 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347835; cv=fail; b=m820QSpFtvYCSrKNMMHLY6ylDkBtAt4OvT0AxfTBi3LKtMqpBki/OugZpuIHIH85KGwTK66bt30pynT9n7tNAMeuoP5oK3NNJ+YoiDdhQf5GHjOcCPy7zdy90qRCjHEZDVSICs51hcskKVl7jf+7/Nj8/2AXC4Xam4Y8j5WAYa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347835; c=relaxed/simple;
	bh=Pi8a/vJuw+WnaI/I+TEEffa4Bpy42bLAbqsc9USwYpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xkslp7+acPP/HPyX2ulp+DOLKrH3uYVoC+p7/8k2jLLOzkLeJ5mjddEjUAiTUGLaXOrecMdmUd4Wl1DZ7ZNR/NDQiChxYvrxFh5P0lZ6X4N074sLIk3tiltC/hK5K2EJdzlFt2w9MS+KZk3EsnpL90kWYGqtTmGwWTKC7sOB4sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LyEc4zuN; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjA5xnGCkBg5Aegp1EmcgyHnk8qTorhXGMAhtxmimaornVk/67huZMi//44N27376qImjehd1YXsXiYz9mQnMYzcn4MK971Ea9WG2o4q2YNhqhAmr9K1kM1CoVG2TpFPZLxy9jCF7i8OinKpGySKGlETS1p4BwdrCS+yydc67q3KfAFyOZX4jHawfpHZhzck4mNTNPTtNhV60SXLYUWwBx6BdjN7BhNBa7Ad+3POuXlGxdzQh5I9U7z0pCWIyZAHjcdIP0qyrkqAlqeSutY25ihTkUP+ZBvYHJpL5Y9t4YzSAKboFm9bumGOlhb1J268hRMMcsIYeXqUYM0vs2folw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhvVpL5s8sr72BvRS6yZGodBn0fZHl5FV/9LqwVd0aE=;
 b=TMaDn27h66jtrBcGSrJZ203XbzChT/DGC7xxILB7Toya9ZdIWZFjVrTw5nDqMcaB+qe9L7LFRqJ2CEaIZ9FEhFhvZ3xjTSO/0rjX9gNJeIDCbu8R+BkhWhGwg28aTRmSLcg+O8qfWO8xQX2+PiMk/Pleuyx1Zc40HOBsezATUn1HhpjfKoDBjQrfk/f02m/bYB+KAbynQcWZ5ArCQEcHvSpsklwQIRfLs3urdHcxnNl4jzAe5s00RcrcFhT/sYBPvO3F4N3iKFzjWHqneaREGLx2HO+H+5FugqFd1aPubHcghclmtF9wdXySnA39m45KvQQKi3ROsYRhvy5ucCugSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhvVpL5s8sr72BvRS6yZGodBn0fZHl5FV/9LqwVd0aE=;
 b=LyEc4zuN1CBUjIgu0efoOOMJApxvFcp3nbmJTE4j8Hs5AJnG0L+VuGkIGCRHxmLRu5+nyATEuxMCRQk1nffvVk9w/jCcllzVeodrspcFVgwLeLG9mU3FvMqhvwhqPNiki0CBr/p5rzdqwRMWWi7D79y6hZ7wY0/4BYEDYGdT+bk=
Received: from PH7P220CA0083.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::19)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 04:10:27 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::e4) by PH7P220CA0083.outlook.office365.com
 (2603:10b6:510:32c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Thu, 31 Oct 2024 04:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:10:26 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:24 -0500
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
Subject: [PATCH v3 03/22] ACPI: platform_profile: Add device pointer into platform profile handler
Date: Wed, 30 Oct 2024 23:09:33 -0500
Message-ID: <20241031040952.109057-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 06dc93f0-af49-4773-8fce-08dcf961f395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DkCMAQL/9VT6TMqvWCpjL4QFYFcch7YJ/4o2s1du+cs3R8U11UonKaJsCphw?=
 =?us-ascii?Q?evIuS9njMjRJJ/BgXPVRFhM25ya+eq79sz+pMwptsDwYI+TPhpqRCYSnVQoD?=
 =?us-ascii?Q?a6afGE9ocQ2143G1XmlXe9OFtuVgUGUXbzDR8bcH+aRhDUQwKJFbxqyv4KG+?=
 =?us-ascii?Q?/N4ujO7Wb6bgA/A/z4zRFDOahOc4PFLF+ug4kSo6WQhixi20k6jEIFsr1v1e?=
 =?us-ascii?Q?0429lBI1196/X4bkgjBMXqN6uWtFbuz6qIV1iFyjzS/Y20T8QD6qsr2Yx6Fn?=
 =?us-ascii?Q?q+RAOnWvqvCMGW5fArgR9SX4XzqvOFawbpw9wtTy1wk+KJNcbkS3CkceV7a2?=
 =?us-ascii?Q?pDcRP0LG8AnT/7sg4vIPcjzFUEE2DXzBMczLeyKvOEjQNjqDChfLwa1rudpO?=
 =?us-ascii?Q?DbFNi0Chfd4hlV8XTP7xtc0D2FBv0jrQZoFKutB90FqgXXzeGY6HsZ35+0Bn?=
 =?us-ascii?Q?DRRowiQYzL+tW0w2QXkXSPjQ8yziu4alP7yaPiGDYlFG7l6/Q0fcyihqP8Hf?=
 =?us-ascii?Q?Cjsa43wmVxD67AgFJi3HkOgw9kPsRb/AXWOhIZFRtrHZf5D/dbNfRgHppZMl?=
 =?us-ascii?Q?YEfxw/g2t/qTQcrqsyQ5Fs/HzHlpSh9wEWQKXg/RBgokDb+4KIi2FIvqlQSW?=
 =?us-ascii?Q?TI35f3XYda/6E/3njWTmut7jwqkxuqckqDiQnjufDVucVEkwbXbB3aomq6DE?=
 =?us-ascii?Q?aKFvFozPIerkux3YW1QWe+DgAnOJ64ekyHaXIYKCt4h/CBEee0KPDv2vQfT8?=
 =?us-ascii?Q?qaiV+mxySbLOv/VbHkfIkEhs0v/kALgRr2YXU+7knF/K0brZM0vKRFCTprsY?=
 =?us-ascii?Q?INh11Sxm4wajoNTFxQV6RbvrekF2vmLkTblpItOkoL1GHaxFMQr5MOvIdxhJ?=
 =?us-ascii?Q?CzvepeOh/dakiuCoJYHanQBrLub/Aw4BUoLwREa8G20POQN6SoWi0t0rLBbu?=
 =?us-ascii?Q?A3ibeD3pmc8tHhE7MfNbAzQZlcNy+dJL8EMabNf306YJ3sDP0SMnTXLZRFpr?=
 =?us-ascii?Q?ZJYkDvfZGNhJDDyWPYTpIKGiJqeOGt7v/vZJ3iYj7QcYQAxZV9zU/mlzmPRY?=
 =?us-ascii?Q?X1XVr1+413xaJwzbdoY0safS8tplL5R3hFy/+pulvxj7VcS84lARR6fiVNfU?=
 =?us-ascii?Q?TUxoScW8Sq9HoxdJQorFq/XJelZ1k/+FdhsPkBnGqmqwLG8RaUJ8aU8fpOk6?=
 =?us-ascii?Q?fW1Uic1sznFTYaHIIgEJI0T+AqArqLaZlN8foAOot7da7cTuDqpl9Gd3D9ZB?=
 =?us-ascii?Q?l2GAysK2T1bHi2+orLRa8ruZwjD15yn9rfb0AJmDBVyqJDx6qUfkQ1g/6JW9?=
 =?us-ascii?Q?cGmAaEaqgPLXLXKHW4w4KKqx9Y7HVSOdpqpI6BsZdQ3cGWJLOGQHyruy7tWT?=
 =?us-ascii?Q?cdAiKeS56SJezhhfA1brEOtppIHmammRV3jEMC8w1yRv3Lj5VA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:10:26.6545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dc93f0-af49-4773-8fce-08dcf961f395
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765

In order to let platform profile handlers manage platform profile
for their driver the core code will need a pointer to the device.

Add this to the structure and use it in the trivial driver cases.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c                     | 5 +++++
 drivers/platform/surface/surface_platform_profile.c | 1 +
 drivers/platform/x86/acer-wmi.c                     | 5 +++--
 drivers/platform/x86/amd/pmf/sps.c                  | 1 +
 drivers/platform/x86/asus-wmi.c                     | 1 +
 drivers/platform/x86/dell/dell-pc.c                 | 1 +
 drivers/platform/x86/hp/hp-wmi.c                    | 5 +++--
 drivers/platform/x86/ideapad-laptop.c               | 1 +
 drivers/platform/x86/inspur_platform_profile.c      | 1 +
 drivers/platform/x86/thinkpad_acpi.c                | 1 +
 include/linux/platform_profile.h                    | 1 +
 11 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d2f7fd7743a13..5d9f3f7ba71c5 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -179,6 +179,11 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 {
 	int err;
 
+	if (!pprof->dev) {
+		pr_err("platform_profile: handler device is not set\n");
+		return -EINVAL;
+	}
+
 	mutex_lock(&profile_lock);
 	/* We can only have one active profile */
 	if (cur_profile) {
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
index 13a97afe0112d..a5caa529351ea 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1878,12 +1878,13 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
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
@@ -2536,7 +2537,7 @@ static int acer_platform_probe(struct platform_device *device)
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
index 6177fbee60573..1a8c29aafe892 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3921,6 +3921,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
 
 	asus->platform_profile_handler.name = "asus-wmi";
+	asus->platform_profile_handler.dev = dev;
 	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
 	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
 
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index b145fedb6b710..730f97aab70cd 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -260,6 +260,7 @@ static int thermal_init(void)
 		goto cleanup_platform_device;
 	}
 	thermal_handler->name = "dell-pc";
+	thermal_handler->dev = &platform_device->dev;
 	thermal_handler->profile_get = thermal_platform_profile_get;
 	thermal_handler->profile_set = thermal_platform_profile_set;
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 10a853b6b0514..1b6677e176769 100644
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
index 6c72d1b6a2aff..feaf98819dc82 100644
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
index c8c316b8507a5..222fba97d79a7 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10616,6 +10616,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
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


