Return-Path: <linux-acpi+bounces-9165-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 609879B738A
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7D8B23A53
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83D1145B27;
	Thu, 31 Oct 2024 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pJZF0HYK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9081448E4;
	Thu, 31 Oct 2024 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347837; cv=fail; b=IMsuWruGYmpsus9uYgnPAenzNJ1ALGvcQAXIk0rO2QVag4UF/Ef76ndoYIaMDOpNYD/7gffU9c13/PCOg8URy0F4xtJtTGD8f7gpWwzyvxbz/k4D7pBogjSL/K1Kce9vzVnIeRZs5+eHxxM2uDLOhuSsZ8WWbB0EZEsgfhsalUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347837; c=relaxed/simple;
	bh=3+yolz3CqVaVknInHwF6eh5BNFawW6KdLcAksK32EyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MB+wFJOGoeNgDCvhiNLiUus97mtr4R1YSg4yWZezBsSsIFD5OYCW77kd224hF1YYJBH27ZvIZ3PtnPAHduRwfavWINkvqiAO9uzKtgldv9ukULFX7zBNPZG5tbEYZAB1ta/1Nh0jaQRheuOE0Bwg3LyFyvFu25+JnEBlYBTcV30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pJZF0HYK; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/yIbt3uN4O9Sq6UyrwEvLH+OBoN7w66Qj7coOfPGrmO6x2cvz/85cnx1ftqgA5h48kTd7n1tH6/wkByZFmWjC4iiXULTt+3mbPFjvx/UYxvu23pPcS9w+SJKBfZ9x5RfhsRy09hw8+mnpx5d2nscUv8Itxu6GzREeu5939l0Q7tUe0w8ikrpBOPY9Un+C82aM10ch7mR+sWhC7Jau00PCxF4NABWfqvn1ei8E/V7x8DzVsUtYeKmmDwPMSeWn17d2xMvL9QXRemR9HBPX4hXnwpoWyfI7WFV0b7UKDK/M8pnNlwvJvaRnk/KCvp4DvZbyiLchjfxMe9bz74X9N+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEt3L4xHA0kK5K+bkOWuGumS5UXZV2HyiCh2P6m2MgM=;
 b=XSaTwDUeOjCk5qQzKLvQijCRI0nELpenAxi4uHLkgAOpwKB5g8T6hFy6wrxguhNaHBNnHkXXaken3kF4FUK2rvXPwPu57C52TGSYWjqxYNj3uNIfpbX9oL4CVObiAozLvMGmH0OX5B8hW7t1P0e+nBAItWXfs1UNDKRFzbD866nnO3hlQlZUnITu4o6SEHZc8d2duasfBs+x1zLgmui/eYPlPHdzSzEqOU4PcYJEhhjZzeLwfySEJ+nC7bQD7Vd9yWqzPNBwViSOgiGCpr53BsbIJFt7RGjKo+EEMd4rZDolrv8WF4HvAB14+w78imlC0PAUBJt1cJtycn0RlYj1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEt3L4xHA0kK5K+bkOWuGumS5UXZV2HyiCh2P6m2MgM=;
 b=pJZF0HYKQs4C+HdJYoZSTIqrY5aDClZjTcJtUcsEhEyxvsfAxM0ARkjBoas0GKciwa5lmFcMHEOnXhRgLhhaKmA08NTtAQibWWY/u1UVylPzhVJT0asF/v7+fiapituddz/ekoFzx1Q2e05Tcn2lmd8gG2s1hLL9T356iA6S2z8=
Received: from PH7P220CA0072.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::31)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 04:10:31 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::1f) by PH7P220CA0072.outlook.office365.com
 (2603:10b6:510:32c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 04:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:10:30 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:27 -0500
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
Subject: [PATCH v3 05/22] ACPI: platform_profile: Add a list to platform profile handler
Date: Wed, 30 Oct 2024 23:09:35 -0500
Message-ID: <20241031040952.109057-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 698754d6-39ac-4433-4d0e-08dcf961f5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hrkKcBUMQRtT6outp0szF9AL2iETAW7gYE2eN66HOzrbjym3qMr5flKVYLLT?=
 =?us-ascii?Q?Ld5U7h73LjWGH7PLb1caLTYVlAuib3mMIk2hc+XU21jJ4WgpcVoFqfep7sCs?=
 =?us-ascii?Q?hgMniL2SEBXEZHGXgTTXgAj+Er+dDX5H2YW0QcbvBMF7PK1C0MdqRO1Fv8iy?=
 =?us-ascii?Q?AhwbJkiyelFk32iC6nJrVSj8GwqZc12a/R0VqVlrqtGEomidUihMNBHIe3vp?=
 =?us-ascii?Q?YvjTWduBp+JQ9zLvLTAb24991NTBLN8zp74E1ZOUOcri0oIjwHnvOQlMkKW0?=
 =?us-ascii?Q?0rqjJnGhTLPl8z3nddO6NCzyViESYF6njmxqdGOlH92ZnxoZ9CvwHnkffqOw?=
 =?us-ascii?Q?vdc6ILZfnF5JXOtKGVcukbaPrKqh8SF0fVp6QSFQbbIE/3+IjEs4UtJvVsNO?=
 =?us-ascii?Q?S+9zX8TUitOvCamrzsARpDuCWQjKifd792nDUA9l5yo23EflOvJZWcUQdC3Z?=
 =?us-ascii?Q?WGFH9ys/l490+oVibwX+sWtwgQ5P/zsWqSDpoivN9c2z9BgdQNZEcMRV0x9T?=
 =?us-ascii?Q?gw2PaDgO/1cSEUBRiSPRbpk7VISekoMAhEAIG3By5izVKhr/2GXzGzEPbTog?=
 =?us-ascii?Q?RNN3z34GeOJgcsXedV10IX35rZxWJ92S1UyVPJNExFjIL4JnWhqUjy/GalNH?=
 =?us-ascii?Q?cF7MTSV7JF925EHrgoHMMEDcoR9QexSxUk7GnVHnIYsaAQJrDZdNcOs19dCO?=
 =?us-ascii?Q?4HnlkxNSZZnKDAYfxI+ydibYd0Duz5kJMWhmFeUKR8nUt4HV0wr31PBxW0Nt?=
 =?us-ascii?Q?ZBsQ8uznDmr72Qm8/BdcmiYfhISci2RXqn2R2PjD49E0HP4JMAcW0+Im+n3c?=
 =?us-ascii?Q?7QSMs1YNMVIVRaVPf6PGMIZkEaxPYCWRSkBIXf+RwwXPERRiEhmfTvnAWQpX?=
 =?us-ascii?Q?k44DRmiA9kgkR62QYtoTaKp9rlePuwo2A2slXOQMZ7kTXXf+vSJaOw1hzxOD?=
 =?us-ascii?Q?b2+jIKOCfFa735nDVhAHiepVMP/9B9cuY0upQll8vsYIo7gZeOADpj/7w0t1?=
 =?us-ascii?Q?7D2jtXq34WIngIlZLXH0pvqu+5c4Hg2RN0tmtkjGtMtUtZiiv59aXti4mAbj?=
 =?us-ascii?Q?/bv3hYsDb75CUQeuTpIrXlvwhceiLzOU2IO2GoWCW5FTgFK19z0gm2Q5iAUk?=
 =?us-ascii?Q?EDoblrpKzGBbjqn/nee0cUFMRvmxdYr8a4TIaTUUAoCVDnBxXjSs6vGXMV7o?=
 =?us-ascii?Q?zN3IZvADj9qFeUH7G2yJbVXwIfp1fRw+m/z8HejGgdtjMlEAG9MX3x6cgoR+?=
 =?us-ascii?Q?WNvsdRmN1MbznDDR9NkbiZwFl0mHss/6GhGOCkXLdcdSaVmDJJeydnKnn6Za?=
 =?us-ascii?Q?9uMnsCxqeIUNDAgABABEBBldCF3bqrwuXvBOCU+jqfgw9JWtYVV7LKas/BN6?=
 =?us-ascii?Q?BPt6hxs2qsxXmz37k5c91kw8kfttUggXJxbu4Jewc38L4bDcgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:10:30.9983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 698754d6-39ac-4433-4d0e-08dcf961f5db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851

In order to prepare for having support for multiple platform handlers
a list will be needed to iterate over them for various platform
profile handler calls.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c  | 5 ++++-
 include/linux/platform_profile.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index c76b8e3fdcde6..d0198d2ccb551 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -10,6 +10,7 @@
 #include <linux/sysfs.h>
 
 static struct platform_profile_handler *cur_profile;
+static LIST_HEAD(platform_profile_handler_list);
 static DEFINE_MUTEX(profile_lock);
 
 static const char * const profile_names[] = {
@@ -203,6 +204,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		mutex_unlock(&profile_lock);
 		return err;
 	}
+	list_add_tail(&pprof->list, &platform_profile_handler_list);
 
 	cur_profile = pprof;
 	mutex_unlock(&profile_lock);
@@ -212,8 +214,9 @@ EXPORT_SYMBOL_GPL(platform_profile_register);
 
 int platform_profile_remove(struct platform_profile_handler *pprof)
 {
-	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	list_del(&pprof->list);
 
+	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 	mutex_lock(&profile_lock);
 	cur_profile = NULL;
 	mutex_unlock(&profile_lock);
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index bcaf3aa39160f..6aad98f4abaf4 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -30,6 +30,7 @@ struct platform_profile_handler {
 	const char *name;
 	struct device *dev;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	struct list_head list;
 	int (*profile_get)(struct platform_profile_handler *pprof,
 				enum platform_profile_option *profile);
 	int (*profile_set)(struct platform_profile_handler *pprof,
-- 
2.43.0


