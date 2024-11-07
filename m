Return-Path: <linux-acpi+bounces-9402-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1669BFE22
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10DAD1F21D45
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7401DFE11;
	Thu,  7 Nov 2024 06:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0zrZ9x+i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CE81DF26E;
	Thu,  7 Nov 2024 06:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959440; cv=fail; b=DZMpMP7YW1rVueQ1z3diNFLlZ465v3RL/tXt5BtpjX4LdkTZH0t4x54deJkhN7nVczvDFZW2n5wXUifKSOEb/PeZUB16D3oa/5hB/tGkX+I0bbAYN6VT645tElr42SOcuFT4Amnawq84eupPbS5J9c7yzNdGG63/CX+MuRSvVbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959440; c=relaxed/simple;
	bh=hGdIbfS/+jpLYOwWMj/K6zfSfnaWUEf30H2z688aza0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWFqSkS2JXOd7bJ2wLHCxlEbRFpvWvlgm/3pN77UIdgg5OiJKz+2ZAJg+IQKZCU6vu401k/w9seOXCtIdCM1GE2GWONvHZiQWbHS1K2ByDVsg830+GcoLYjadRcq3iak75GT3SPC1m2qnkHxCicye6kZuGpnLLDPhQjg6Bh9Rfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0zrZ9x+i; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYH2wlSho/dC8s+Q/jB+qHaq+G4F/LGs+XFekCSuk620xKzDQOfMjzZEfJMEOSqmcDAhN6a4+n21olc6Svo5RcjFDlo6YcUHUOty7IkTNSIz3psak62x3Ou1aImTOsnWC6ak5Rn2bgdtPIf4IIwKLwf8YUlRen/B/+GQob9EpoaSBAFpLZiZVJo77AVN4BdDzngLrfs5xzLfeuUKvQ7XaETelnl6mfpDKEoMxS2+kpKNUNfddvmkxV2rsloUHXxzKrOJ6m/HPqbTxqkxVeg3JUw19ELmpgl5J5jIGo2x95cMZpHVvtp+OZjYffoNzg5YjV20kiv5PrJeAi8vvvT+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDo+HrkIo28732Z0/g/cJF5z1/K/WaqMVyyvI+DMEr4=;
 b=LA2Cb6nLcqVElifeBjjtBd3auMIr67nx6mWogxJ8/FEIroc9jOq0MOUC5VX/oA+Y2LDqw5Ni5kJphgDXgBo0M7eky9eIouNJmXVpXGVo62Pkl2XFtDhRrIvtuWwwFkGCBGCnybSA9VPqAzp+ed0Ijnm+xCMeiXK9kvGyS+Gm9Hlt0iK+rfEqi7W5vlcU/OQttpfuNKDITnOGjccBReWg4e2hxLMK9Tz3/bMZFfVZIgy3HyhLMfbJbMHGlj6xGkFN4SUBBBKRsGF4gIadpB4fzYrL1GoBUcFTumoEOYUbZDizOrC0w49+4xSv2MTO66er+6b/IrMmlX5CBfFTI7+ZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDo+HrkIo28732Z0/g/cJF5z1/K/WaqMVyyvI+DMEr4=;
 b=0zrZ9x+iitDiM4oilagIPM8pA8kDEak80jreioEG/yboL0ILCQyL1swwmbQHxPMXCilHI+emMNCd3x/RGbBjz4VKKEaSBndlZzbSVHkHI137MrholcHLGWCsrVZq13qKdHuG0/YPXN+TavkZpbAOnsC9x06Otl2qcOvx2tuv58I=
Received: from CH0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:610:74::26)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 06:03:56 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::2a) by CH0PR04CA0081.outlook.office365.com
 (2603:10b6:610:74::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:55 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:53 -0600
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
Subject: [PATCH v5 17/20] ACPI: platform_profile: Check all profile handler to calculate next
Date: Thu, 7 Nov 2024 00:02:51 -0600
Message-ID: <20241107060254.17615-18-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107060254.17615-1-mario.limonciello@amd.com>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 90db55b4-00d5-4e26-86a0-08dcfef1f6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9X+vzBhmZHnq08DAjsIJw0ncFzDtwNXLR6+Z0Z6xnl2d6zZ4xqIuZrBgvTmp?=
 =?us-ascii?Q?s6zmnK5c/dArvNPstuHdLhBnmOGeFj+L45JoMSwHAQKtFwDcQs469DYC1YJn?=
 =?us-ascii?Q?QNGa3Y2ToopfXaOJRzW5RQB+/+C5xY6ZeZ7MBN+uaIApc0tSdsjbG0K957G6?=
 =?us-ascii?Q?K9spb4FSJ5gzgStwvp8vVS7aNF2KZA7Gqn3IuXgYNim8LAvfnesbPxKQ44CZ?=
 =?us-ascii?Q?dZhOOpukuRhVr0Bnhxu1f9VFq8VVnMZ8dpoXMS+6YNtwrlws0eIrv+sBEURO?=
 =?us-ascii?Q?U0nqK77zOcArOhr3VXsx1mhZq+0qhFov8obgPettwPKQhrwqYQnxAtj1Msi6?=
 =?us-ascii?Q?yJNPxCEQ4FmNdtLSMjEag0GeS3nP06a5k/pornUuDmRw5pCcff2kOqEKpvTb?=
 =?us-ascii?Q?JHE04S42PSGZm0Qh1BTXJCEUJv5dkNPChUXqlsL3SojxTvVSRhWg6j3K5Wgy?=
 =?us-ascii?Q?i8mvUy/Zbg2dL8jqi0+Jdqe4AVbnsp6/CI8oA5dLvYW631+uFzSUcaFxhzkn?=
 =?us-ascii?Q?iI03Ne+ItvS08gcLaxEV8SBbrlg/rNW1uDok9KQm/erB+d9pRz8EJo9lk2Ag?=
 =?us-ascii?Q?j7XIFTqd4lBLEmFOW11Bi0ri4Z+tyTax69Md7bo04TucDgZr6viIE2Fdm0qW?=
 =?us-ascii?Q?VWpRe40d2oJJlRYhUMHCEslfMZrmCrApUwMcenCHB+3oZTzq+R6GZY79WMgt?=
 =?us-ascii?Q?hsWq7Kjlz4BrZ6J3XYM5GBYLmIDfUmbau62OJmbZjs2jaCjfT4WRy4mw+DEa?=
 =?us-ascii?Q?vgW3Om55cUstckiLOstfQ7KYE+T4BZI2Rysf0LlUkYXICFxHos1GmD5f0V0m?=
 =?us-ascii?Q?PKHWGUW4DPPVvA59fH13hx8J1W78JS/u6V46ISKFcoKOIPzIptMxa5yUgZiw?=
 =?us-ascii?Q?difvMcb48ctGCQIM5LQx077w8+MijVscI89AVi4ZyqZmKgT8+519VOFt3IN/?=
 =?us-ascii?Q?6ShObnyHXi9HI0UFkGpX2DwCWW1s12/Cjt6o9fKoAZVv9Wx55Evb+V/Pmz0c?=
 =?us-ascii?Q?b9eKt0pcNDgUoY+QCCpzFr4tZ+Etr1X3t1HAw8gzI/U7u1yR5yszXHt+nT1W?=
 =?us-ascii?Q?pUqrRVXNDqj72rzwA7NDj2S1bv3KJNabHnakfH/abvTpPfji7kw9o7ok2Y7t?=
 =?us-ascii?Q?jZwfur7tE/NPDx3I4YBotzZXGDSL0DicBiFxZL2jA4ARU82J6dSbe8ywM7vT?=
 =?us-ascii?Q?Hj03SWjQgGWkIRqnJtEk4WvKGmM5qOHkFMVyglIpHup9jyP5+EpiInebNdDZ?=
 =?us-ascii?Q?HGkAik57DB93jLCZc9NcujmGAKeBpRxxa6lrdEvHtOsRTgpq7Hju1UwU0+Qz?=
 =?us-ascii?Q?SkRFUadkcB2WQXdFroN4jtJu0IEulfq6+gLXAYe2ogGezP+9XZ446ZDut4sJ?=
 =?us-ascii?Q?6oU9dXVq4SYdzEkUYOLda29HZV5qSp70rBmg+ny7jUdjMrseUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:55.6836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90db55b4-00d5-4e26-86a0-08dcfef1f6aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184

As multiple platform profile handlers might not all support the same
profile, cycling to the next profile could have a different result
depending on what handler are registered.

Check what is active and supported by all handlers to decide what
to do.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Adjust mutex use
---
 drivers/acpi/platform_profile.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 7f302ac4d3779..2c466f2d16b42 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -411,34 +411,39 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
 
 int platform_profile_cycle(void)
 {
+	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
 	enum platform_profile_option profile;
-	enum platform_profile_option next;
+	unsigned long choices;
 	int err;
 
 	if (!class_is_registered(&platform_profile_class))
 		return -ENODEV;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
+		err = class_for_each_device(&platform_profile_class, NULL,
+					    &profile, _aggregate_profiles);
+		if (err)
+			return err;
 
-		err = cur_profile->profile_get(cur_profile, &profile);
+		err = class_for_each_device(&platform_profile_class, NULL,
+					    &choices, _aggregate_choices);
 		if (err)
 			return err;
 
-		next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
+		next = find_next_bit_wrap(&choices,
+					  PLATFORM_PROFILE_LAST,
 					  profile + 1);
 
-		if (WARN_ON(next == PLATFORM_PROFILE_LAST))
-			return -EINVAL;
+		err = class_for_each_device(&platform_profile_class, NULL, &next,
+					    _store_class_profile);
 
-		err = cur_profile->profile_set(cur_profile, next);
 		if (err)
 			return err;
 	}
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
-	return 0;
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(platform_profile_cycle);
 
-- 
2.43.0


