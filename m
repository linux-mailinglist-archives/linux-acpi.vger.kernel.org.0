Return-Path: <linux-acpi+bounces-8996-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE1E9B0F09
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 21:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8017528328B
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A2B21442B;
	Fri, 25 Oct 2024 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v0tZ1mBW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD50D214422;
	Fri, 25 Oct 2024 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884691; cv=fail; b=W+Fd2EqmXtbwf94bsq7F3IHbOjC5B00SpTA6qcIc1BWG2kGMSXkEcO83Wi4IajMPbpsuiok1t5dlXAGu6olHjRdoxZkhiGNgcPKv9hrHdboF9cLYq5zFj1TEE2Bnx2PQ7XIlTLMcoKzXIDvTyLpro1D4CBK+3rQf1cciHkHY2U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884691; c=relaxed/simple;
	bh=spV1oWSxaiP0iUMve5lU/g7LPNUjsrqoRF2gYjL4k7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWpUBoK8Wbp9AmSFY6LccXuWHfYddiHuckLHSvXEnQhzKRmOyi3u7sBYtr3cfvrsYN97Wi62D0YB61mn+sP+JIogs6O/U9axJjujlnoJ39Ro1f0PyWtYA2zb4x22UcM9cKHId2egAAt21mippUT3i18pFLWkOUYcFHHiIaZYYgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v0tZ1mBW; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIsC88F6b9ITFFQpE8UIjJk9HJs4AJuTgBcmSpWctQ9HGm223z2hv7i5YDpXiN1VmeQrPn0bijApifgruj66fdqmxSQ1oAU6T36aV0LuUcAH6A8P1JgXM3jccFp+Wfnd7koLhZEeaS8C4TWI0gZQX5q9D4SHk93Ci49TAvgjQuKXJ+pSKk5K7FrSIq6gv8817IjoIquwXlaQ6u9IgpeDYzj1AnC/ieJ6U8Yt6dCMaI50RDdApD7ban+PfGR39VzpOJtfp5CJWi6ot8OKVMbwIrOF8a/m2Be9lwrJ7XPSMGGjdJiyJGW8nbgBbnhlPQ8xUFmf/tZnJh3ncR1/J6/0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3c+zXUlBJmPUTl8NDGPU+lL5c162ZcPznfGyvRoHpRs=;
 b=FsUaRUI/fHkNPiRFTkVnb9wy0r90S4PeYXArnew/14f+B3xby+htUNdKDqhhHap/96u0gmi0HztzcB+0T7k+djmKbSR0AvvsCVKtGqrRVgW8tCMbH1CrZuayJfujH0SZcrNkkYgIsifeE9AT9X2GjBH2tKD161A2zEdRR187//1OqpOYjVN1FEjKjPHR5oy1Z5xZZJZSG0WjgzxrJUpmAcJO+wFuT3w5XqF7bFgnFE4QT8QTmWUhaIzwmGddgLc7oZYgNaUV5vcEGcmUjQqHe2BwNccIkhGClZuxuYBICl1GQfrA/6xzrPwcstiVPAywco3wu1Y0IYwFTT8oW/MrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3c+zXUlBJmPUTl8NDGPU+lL5c162ZcPznfGyvRoHpRs=;
 b=v0tZ1mBWZeROccxGynmy2F7GfwRDxdG9horu+E9Bzgnt0tTRb6FrabhHh6ahyHpXf5AhrT/Kd2bGpWgr+SaEwnhRSrRrutca8OnFZ6+2pi7U6Xij32KTODm+6yBdLrB8rXPMFzCqHAUb10D69CWX3tpenxq1XR+GRWo7+7HT5O8=
Received: from BL0PR02CA0094.namprd02.prod.outlook.com (2603:10b6:208:51::35)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 19:31:23 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:51:cafe::3f) by BL0PR02CA0094.outlook.office365.com
 (2603:10b6:208:51::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 19:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 19:31:22 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 14:31:19 -0500
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
Subject: [PATCH 5/8] ACPI: platform_profile: Use guard(mutex) for register/unregister
Date: Fri, 25 Oct 2024 14:30:52 -0500
Message-ID: <20241025193055.2235-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af54f72-5c31-4739-670f-08dcf52b9bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OLSds4KUzU672NLEslTlQiM/rP3ak+jzbf6OBENgsqqe9nS5KLMqGaNxYHp/?=
 =?us-ascii?Q?1BSiS33gzc+MDcxDvk3EDuDymqFZaHS5F/wVJZLvQ7esunim7UY0BfnwLtNj?=
 =?us-ascii?Q?OwBD/RRJrueSoImoC1pZDiuYf1r5OoR+5Dx7qSDZoXKXwJsc2Mp2m1ZOej9H?=
 =?us-ascii?Q?doML8vZ0GLk2PemIqvub2FG/vTRQymW7wQbe1peZV9LHG++64Shp/tuhYug/?=
 =?us-ascii?Q?MVtZfP5HBFXWmvKcHNwzi0axsPQNLEi8jQO4tVIZ6kVfVwKY5fTCrv5t6BgM?=
 =?us-ascii?Q?vMuEmtqGAH/t4eFgYumC5Cias+j1XQMFsBBInd4jkiQKb7PyZOkXpu0z+yiV?=
 =?us-ascii?Q?esAXqfFn+npeBDtR8M4vLesty85w5EKxsSbZFY62DzHgNVXk+r3IWTigDQom?=
 =?us-ascii?Q?NR3qCxUMa0lL9WsAUBG/Ebw0VJDE6C5tGrBKuZGT034AeDKerYEa153PyHkA?=
 =?us-ascii?Q?ncRH7cVzImTeCb88lpm6vdiqrJaHc82ba3ZEu/0K91lUSCb82gvuF5WojuVR?=
 =?us-ascii?Q?0gPKc4OH3xwH+ewpdt1REwc3zlseRBl6i3zHe5IJl/Pvl2gSENgRYcvoA9i1?=
 =?us-ascii?Q?zzb+1yKWJo6nDJvAfcp7/K8sIAvY6ZhHah9JU0B1ZGoSU4kJ2GH02/Upk9/U?=
 =?us-ascii?Q?OzE2+56Y31pXd3wCBtHOkP3bulfK0pttzDIM4KkPo/iiU2s+4EC3eQUgqnX2?=
 =?us-ascii?Q?wpwl9BC2u18n88OEG4rYmo3xtrg59x3CU5KXcLeyraAjOBm1gr9tk/rHHlhP?=
 =?us-ascii?Q?Cf4S5CeLGTlz2Sh92JeX4marZiNE6kIvesokU7J5R18Dlp0p4Not9PViwxf4?=
 =?us-ascii?Q?ZVMFWZaXP7Y31kvFoOlyTVDWA1rrUD1ogp+AqqDhgpDv/h+npe4T+jPw2BMX?=
 =?us-ascii?Q?EdNh7ikTpVuAxsRxLA/XE21T8iKyOcRLH26ynhBllE834+xwe81+yjeeSDod?=
 =?us-ascii?Q?YCrhqGRw7xHC4dxgm4mKc3gbKcPXxF3SyiSYW4xxK7eWkOSPKCbJy/TAn1YR?=
 =?us-ascii?Q?/i7N15Y78JGdBEFQuN/pjQnX/USfb49hY4Fbr73xPItcnrivaFBn06FjA664?=
 =?us-ascii?Q?v8qMbHVscOljEQEdscr1QJDf3io3prpZw74Abpc3h8PoyIPbXoGO549o4mjr?=
 =?us-ascii?Q?gSUO0DQnmIckWMmDlEKExOHXjk0J1SHq3eHFyJHEJ6j13PKwUHe8oeM/mmp1?=
 =?us-ascii?Q?ZXMnSSjtaII6z0Trqw1oE4IwSB8x5ARJDWnO+zRsfqKF1ivyr57DxyRnyBfS?=
 =?us-ascii?Q?ALlx5Qt05JW2OfKgDHwOV6wgVqme4rM8/IUh2OGk0b0oi9xkzx/fGD895xZv?=
 =?us-ascii?Q?QFT9SQyFsA9swprGnXknTDK9wNaBiV04I+s9rwgu/i/Q1dJg8Xv3IgVke0xn?=
 =?us-ascii?Q?Chs/9cRmNMCYPE+2geHYti3EG9woN0ANxxR1W8Q9wD3lPlGYRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 19:31:22.6388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af54f72-5c31-4739-670f-08dcf52b9bdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930

guard(mutex) can be used to automatically release mutexes when going
out of scope.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 0c60fc970b6e8..81928adccfade 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -180,41 +180,34 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 {
 	int err;
 
-	mutex_lock(&profile_lock);
+	guard(mutex)(&profile_lock);
 	/* We can only have one active profile */
-	if (cur_profile) {
-		mutex_unlock(&profile_lock);
+	if (cur_profile)
 		return -EEXIST;
-	}
 
 	/* Sanity check the profile handler field are set */
 	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
-		!pprof->profile_set || !pprof->profile_get) {
-		mutex_unlock(&profile_lock);
+		!pprof->profile_set || !pprof->profile_get)
 		return -EINVAL;
-	}
 
 	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
-	if (err) {
-		mutex_unlock(&profile_lock);
+	if (err)
 		return err;
-	}
 	list_add_tail(&pprof->list, &platform_profile_handler_list);
 
 	cur_profile = pprof;
-	mutex_unlock(&profile_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
 int platform_profile_remove(struct platform_profile_handler *pprof)
 {
+	guard(mutex)(&profile_lock);
+
 	list_del(&pprof->list);
 
 	sysfs_remove_group(acpi_kobj, &platform_profile_group);
-	mutex_lock(&profile_lock);
 	cur_profile = NULL;
-	mutex_unlock(&profile_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
-- 
2.43.0


