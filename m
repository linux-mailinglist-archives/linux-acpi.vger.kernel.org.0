Return-Path: <linux-acpi+bounces-9314-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BEC9BD0A9
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037F31F23186
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F081E47C5;
	Tue,  5 Nov 2024 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cMoYQs8Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F831E3761;
	Tue,  5 Nov 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820836; cv=fail; b=ijpVAuPHX+VJf2WjkTctqxAvcqlgylDpefLuGH9RcMKDc3RUPv13g20nViiCu9frCzw3DqjYj/1FRnMy6okoAQ4xU7h46LQOZnhOW1g/xBHvPOGGH/WZ5xUza8J8GFGhqR5ly3l7KedLoE3Be3dk674CgkEkhjsOoFLWEKtbFH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820836; c=relaxed/simple;
	bh=8265ZWL5VAjazKoIuoLkcoqO6KX5LFi0MhGnolPFVNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDgnVz/2jMaM0raakvUcSOhzs0e96ejFsyZj6h0aAApslvgGMTPsYuTiO0rXfpO+qRuYeDTv72Uyy30yzkP8QqWREeJitpr1hUBUC0UHcWruE4F9HK8zGR2JUPrnL5qFzD6qTQbq88z1y0uK9yzpsPCPxzP4DgOrRF7c6Hx+WPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cMoYQs8Y; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohFpJbRJ7Ua+OSgIc2WtuYqHPL4c2syfKBM+cZCwj6CCw2/Vl0pVD1jXru8Tb/F/3NLjuvv52QZGWMtZsMHS0LT5inCR5wRIN7b1eb9o0O2e6N7KSePb0dBp0yT4JCiWGa7vA+0rKMrmZNN2q49ZV2DgjbKjaq90o4nIGO5M6fdBS3QTHYZqK+vXxA72IJciP0ge+OFtvZ0dKhltmvRvqIqHt0Xg7PpchZDlp2OUZCYnOSq58NyZw+w+L5SaswrwQW7psdnqYx4hGcP+jIFjLxrkxCH9FAhXdvWn3nIEE5IK9RozILRUBduzqTQ0Tx5PbSqDiYa/F+a9ElBZ0AB/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2d2T7e6xMXa8Ho9y5c8HKcJjgMwsLu6CwC9jhZqoEl8=;
 b=c+F1J7WV4gf+MVMIsJCuZEa3gu9wxtE6otv6tT3CDoyrvPvWxCCytqFkq8e8wOYzihSi+Paj+ONR5eJpqqkrKtNUivtXIVww8pp07YJDdpA0Eew9LKRahqqA2pPAZKQRsajuU6HXWF5hA+TtNw/gfk5iuQbOXvFtIEc6YvZE2FY3wg4nGepu3HuC3bMQbd7AV3Eh3nM3JJsOee8b2DwleIxOSUPClpIGsq4XRXsdDCYUu3r6PrwoOHl+V8SR8oAUo/ae/qOs9IDN+nnVy9Y8guQXkTqkiJmoSFaSwOZa5YvFdNngV5xbkIYS9xhWIofiFWybKTFTSjU6aZ1pa+QzhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d2T7e6xMXa8Ho9y5c8HKcJjgMwsLu6CwC9jhZqoEl8=;
 b=cMoYQs8Y008AY7BoGlRTg++Pcn9pgWj5t2FzUZJin2QyiL9riITekcn1kc5QZNx9tOmlqkRJyp8CRyDqwOQTpS5Q/HLYrGcVskNxYq8ks/zBRvQ90HlEg8hiTIfA9U054KqStqfjA4AmMmTMqyhLMCelrCdEy4bko0em6QuEMGQ=
Received: from MN0PR04CA0014.namprd04.prod.outlook.com (2603:10b6:208:52d::20)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.32; Tue, 5 Nov
 2024 15:33:48 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::c3) by MN0PR04CA0014.outlook.office365.com
 (2603:10b6:208:52d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:48 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:46 -0600
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
Subject: [PATCH v4 18/20] ACPI: platform_profile: Allow multiple handlers
Date: Tue, 5 Nov 2024 09:33:14 -0600
Message-ID: <20241105153316.378-19-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105153316.378-1-mario.limonciello@amd.com>
References: <20241105153316.378-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e81b3e-6041-4849-9618-08dcfdaf3e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BB6OCEhVkEaAd04PrS1uDCvV6AnRZrcSq/zpzO3ips49Re7eahYEUoKVi6Qu?=
 =?us-ascii?Q?KfA8VgpGo9g/bZNhHK0LpnQwjS4+Yzn+9IEu94fk73jK9PerAe5/kzURS3EN?=
 =?us-ascii?Q?FZuBlHW2EuyXlJ5FTtsbfjy6ilnt3xfJD/NztfxRl99XB/BSb1A7f9knzt3A?=
 =?us-ascii?Q?0KZN8uNB++qxWdOIGkArH5K9wT9VS1uf3QiZuXYWHlWVjzTU4d13grogj3Y6?=
 =?us-ascii?Q?9mr2wx+ZDLT0A51BpT+eCcDQEvzrnfBxVUPc2GxI/+jIS6gtFxCBLmVQfzVe?=
 =?us-ascii?Q?+wmfE588vv72mUtSrgzXpVSPchKyfeP6/EG9A4bUElJPZshH5N4Dv4HSgyhs?=
 =?us-ascii?Q?Ihgs/mzJBETakmSLKi8m0AmzZiIxsPSaxG/u2/Lg0+L5R+GylPsFEqzERS6h?=
 =?us-ascii?Q?L5wIF9t0Bzp8K6WLWf5XEIxwOFQBMjYgiRSEghgyba1gPa7ysymgLWNbS/od?=
 =?us-ascii?Q?1MRlu1iSKtAsghr4Y7maEDSPfm2JoOVg9BeMvMJZjspRuJ5VPntGLTno09kY?=
 =?us-ascii?Q?H6gBe+nX25Dm+1xMFIUbMo7egw69JX7qWSqgliSDSJoGI0k0xE8dwRD8jDX6?=
 =?us-ascii?Q?aBHMy7KiIC7CcxRWCiZzClSdj5fzyXoFtEx4HgoiI8/o01J8ba82MT6+i2Kb?=
 =?us-ascii?Q?bxx5LhLBUT5CPYosltAM9ZkJWSfUbNdoKXdqJKlYkevSen0ZUkvPOobhDSs5?=
 =?us-ascii?Q?AYm0qAEQXaN4jhbND4hc0Br8bPNM+sG0PI7ViYmtusFSLIDxPYG0xXNfF35d?=
 =?us-ascii?Q?OMcG5RKjH98kFfyuvgA4VS2IHMkS/JEKA+faonyjWEsqWvTpi0XvmW8ADhoH?=
 =?us-ascii?Q?QKriYYQ2shod2LnVR+0AvWmZ9b9KUHG044h3SDHw37x4PEUQN4g4S6MFHJhf?=
 =?us-ascii?Q?U6Wa3uN0KOh9WhUJzG7uYbX0pa4x48pUNGMiLm1KQnYT5zqi8LdMUaPirERa?=
 =?us-ascii?Q?qwfgm+yAehci54FmOXGATmJkRGtRxib87u2zmTB4nuax4+9M7Dwf887n6Y1n?=
 =?us-ascii?Q?aOOpU7VwuyYAIe0dkexr8gJ8HlQTG/pf1TCotCUCRhg43c7KeHH9Yb2IoG+p?=
 =?us-ascii?Q?JfjzrpMEFZTH05D5Tviu9ePvTSAMDGLl+xMuKCvmQoglGDTBwYVXIaPVgS+H?=
 =?us-ascii?Q?8jYxrTyluWghh8RZnnyQl6klLrboKW2raF38+ewlJA5wKCeTNbDFnRIxipH+?=
 =?us-ascii?Q?S7fw8ZWzDHU/T8yMBpx/dKW9TCTtzgQzyUAmztDNngoiH3ZIbntpqm8QrDLS?=
 =?us-ascii?Q?dxtFmKsvn1fHp0kz8mgnR3OwfNqtOPjBV4j3UH2y+5qRTyx9IDZsuJnUvsSc?=
 =?us-ascii?Q?r9JfMMWt+5BkM2AyJ8SyQnWHdoDor+ddnPekTvgqoiST35qdUqrs8Ar94q5C?=
 =?us-ascii?Q?Hfz4lY68Ox3D5+1rAKSB7jyS7Quzd+r12behd8nz/APXXzEhkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:48.7485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e81b3e-6041-4849-9618-08dcfdaf3e6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699

Multiple drivers may attempt to register platform profile handlers,
but only one may be registered and the behavior is non-deterministic
for which one wins.  It's mostly controlled by probing order.

This can be problematic if one driver changes CPU settings and another
driver notifies the EC for changing fan curves.

Modify the ACPI platform profile handler to let multiple drivers
register platform profile handlers and abstract this detail from userspace.

To avoid undefined behaviors only offer profiles that are commonly
advertised across multiple handlers.

If any problems occur when changing profiles for any driver, then revert
back to the balanced profile, which is now required.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 568485e285061..b9eb25f58a2a2 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -10,7 +10,6 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-static struct platform_profile_handler *cur_profile;
 static DEFINE_MUTEX(profile_lock);
 
 static const char * const profile_names[] = {
@@ -368,8 +367,7 @@ static const struct attribute_group platform_profile_group = {
 
 void platform_profile_notify(void)
 {
-	if (!cur_profile)
-		return;
+	guard(mutex)(&profile_lock);
 	if (!class_is_registered(&platform_profile_class))
 		return;
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
@@ -428,9 +426,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	}
 
 	guard(mutex)(&profile_lock);
-	/* We can only have one active profile */
-	if (cur_profile)
-		return -EEXIST;
 
 	if (!class_is_registered(&platform_profile_class)) {
 		/* class for individual handlers */
@@ -451,9 +446,9 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	if (IS_ERR(pprof->class_dev))
 		return PTR_ERR(pprof->class_dev);
 	dev_set_drvdata(pprof->class_dev, pprof);
+
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
-	cur_profile = pprof;
 	return 0;
 
 cleanup_class:
@@ -467,13 +462,10 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 {
 	guard(mutex)(&profile_lock);
 
-	cur_profile = NULL;
-
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
 	device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
 
-	cur_profile = NULL;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
-- 
2.43.0


