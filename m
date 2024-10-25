Return-Path: <linux-acpi+bounces-8994-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E1B9B0F04
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 21:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 882F9B23F0D
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AE7214402;
	Fri, 25 Oct 2024 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YV3aM4o5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5519020F3D2;
	Fri, 25 Oct 2024 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884685; cv=fail; b=u7NgxTawHiD8vhUZ5+NNcU4hDZ07fjl5DsXb4nDAuLG5aFIK8plnYCQi0RC7tzhUzarAALBQlBbF48YcK/lrIxlO+bgFYaZcWIYhxxFNP0nmfHzP+xKliekAOpyESlGh2sn0E1TcmVakEk2ppH8aCRkGGL34PXBYzoa+1oE+vlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884685; c=relaxed/simple;
	bh=hMw6zIo/223jL3dQCUPUm0MdGVoOJfFBye6dEyeROQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHj0ahS1M2gXy2zoqdOU7jVqo9ML8MCBP3f+LRj7B/ZbNBMtybAT2yiRieQMNGwjcv5iLh40TLM7pNeLpc4FZgUZnYNOKQLecdo5TRPbB1IMTG8zdkQfWTbU0U9z7YJ+gV5CcIUWMc8VlhUd+xHPoz3KjlhqRzIlwEjHHredV2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YV3aM4o5; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogJL0RADQIFPuqDif6VbiPlup6pt8GyWE+xfaFwpOa3Og5FQoVq6tu3Q9r0VvIGn2LNWMd31RljM1qVFZg7nQtmnpTWgflGNo5kuoodTxBijYV+WI0uUBVLrSHb/yVFCW1+o1P5OMTNK9rcgRiqDWoaatR+IGqshx3Fig+RQqvdTn096MHEUn7+ndywegpbFpSvVOMGodVTJRXETUF0YdNOQ89asLkzqd/J/E4ruEBSKLQVW12TtSzYRv7VHQvma3Up3g5ZqfYFwU9ILd0q59wAPGuXhWiU9IOxCOyQuGILk3vGS1ei1W1v4jm00vh3cTqgG+90TnGvFAPrT8JGFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUoN55vWEQwotmnObzjKYDkpY0b2UXDFMHUves5KrIQ=;
 b=BB6GKt6aM9T1/OqbAr/J6g6klpOtavfe22MDvdFz/SCToyBFKGcAQ2Ee8OvEHEJHcY9sx3+0rk6md9zqimLyC+KSBupYmTJV+r2RkFNF67kYAyMa371vSBijIFBNesSC0BJDyqWHUrtlD9F/9ap7915D5FjQ/BqxU42iVWdIYkOBSastsTQX/3TM/iU5IiAh1Igfr1t5qqKk5ElJQgMy3ag6hbHohuAPryZxnLQBwHLl+hbWL5xfTwbqTXbESDi7oll0u/35nRqV7M8+bhpaYrjJTfn1LhA+uv8d4zDo3YFGkEbeMP8GzoFmfrAUUYKerjkBzzgNqRks0xlwHcfI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUoN55vWEQwotmnObzjKYDkpY0b2UXDFMHUves5KrIQ=;
 b=YV3aM4o5VrdC/tB9J9S3y9uUOSGfpncWM5e8QekyrwI7q32bYUhyHbKq6rrg3R9xr77+GUK2meU5FSFwEGEiOQuU+tHa4XsFpRAX0UCPpiaj2jBjZXbhG3OGOJTxvAjITIDMK+QFHXd3xvP0Z/1vUXqNecPdhvugvxkOJwqwog8=
Received: from BN9PR03CA0152.namprd03.prod.outlook.com (2603:10b6:408:f4::7)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 19:31:18 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:f4:cafe::6c) by BN9PR03CA0152.outlook.office365.com
 (2603:10b6:408:f4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 19:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 19:31:18 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 14:31:15 -0500
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
Subject: [PATCH 3/8] ACPI: platform_profile: Add platform handler argument to platform_profile_remove()
Date: Fri, 25 Oct 2024 14:30:50 -0500
Message-ID: <20241025193055.2235-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 745ae89e-dedb-46fd-42b3-08dcf52b9930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wEPLHtbewqi9F3FRQzaiZbKUPKPMfInISxnrOfjt6Wn+h0bihuyIsXdDYigd?=
 =?us-ascii?Q?v08/yBD3UWClKORdQHLdf6H6I2bLLrrykN34Htn4qfqIBHVVknfp6VHC4+jE?=
 =?us-ascii?Q?eC79hqhx4Zup7bfNeCvM6ZCbWUztJdfCKRmaaw9lbJZScJo0sPA7mRPei1Z6?=
 =?us-ascii?Q?chyy2pUNrMrbGeFj8JRNM/Au4VTSHKVjqQvgHf9qqfnIVlwNYb8hCs0oKzPI?=
 =?us-ascii?Q?OTVGEARfdjrpaNHsZA+aUXZfKCHPMjLFt3mJckF0p8jF1KMmSku5bV8FgcFy?=
 =?us-ascii?Q?+4tAeQbmMt/UybdnLfAQ2SuP3FkCywgMmiWk+8m+S38hCMfGPuCoYh/SRxgz?=
 =?us-ascii?Q?x26Z0dj3286z77hoRyw41IMeP57Pa3jgoYi27vM3Uui5WEppkYJQJpVE3XT6?=
 =?us-ascii?Q?6BoANl4ZOH+wukmAEau1jdnFtqJ+xatTgdum6rje6a31mmuznbZlm+b+JBQC?=
 =?us-ascii?Q?lU3uBi3TbGhNajgr3djpIfKkFjEFSLnEK4phEqLoaofSjFi7xbWnZVOLp7JZ?=
 =?us-ascii?Q?PedxEpsp53lX7BNkwAXQ2qKrmtbWX2DCMd5/dwBIwfi6Le2ztv7mtfLekCq6?=
 =?us-ascii?Q?ohZ4gzSbVPfe141nj8qc9CZzYmCYaTi0Qbhunj8IEYwrH8PvOhiCRkD6DE23?=
 =?us-ascii?Q?aZ6muRBeMX52AvJ/VPGVJ5p5xj8yVtZBu41ecX7lmlkzWJvbxuS7KQdE4UEw?=
 =?us-ascii?Q?e3xBviq317RT+GLHFVi3rXQYZxjtW1B5XnKhITiAYGV0N1z5hClnnnU7JH39?=
 =?us-ascii?Q?uE5HS6RDxjnK3UPPJarkMggoRVC5IGzLCIUWVVM3JVrOK/AfaFEyDaYDgWmj?=
 =?us-ascii?Q?R7XyqYmROMJRU/YhczUoFobl42CT6ikJBJFmWZrYyfLi0tKykwmmfNKqwyYv?=
 =?us-ascii?Q?1HN6b+b25EHvrzaINZkQxBcgVE2Oe5z2Laq1HN3KBsBgXGpwMbm1W3zH9PWu?=
 =?us-ascii?Q?L5dlfCGcJzOcoNhsFl/CR7gc5t7GuomKqsZx6fUXQU5+Nej+9YQRi0883LZc?=
 =?us-ascii?Q?YqaoBbJe/vD9TubjbLDoeQicTm+8Q3CmFlzRbg+UmvOpW5TuxMmXN+mFm8TM?=
 =?us-ascii?Q?RfZRGupjt/fIw+QcrpqR5PhTKhIRbTzUnu6arrI3uSYXaaY++AqsKO3utABd?=
 =?us-ascii?Q?bIuuw3JFhHL6TAI0XIU+8NMd1cE4OwohkI/Nq4EQM2qAh6mlPn0r1Fn/2Ayg?=
 =?us-ascii?Q?jLCD/L/99Ce88D2ratVXVbtWaFcA48oXSVSgDVUL07awkdL684iqfaVm26PR?=
 =?us-ascii?Q?Jb5O02eycV5IYrBiVXRsGqXrpQTvcdhMzsn4TCNPPbSmF6eGJIX4hCM424C/?=
 =?us-ascii?Q?LG92tDQLR7AikgOwckrXkxiFIzSgtwZqINBwgEUd9HY5KoKB58dwmMIIPB9a?=
 =?us-ascii?Q?iLWT8qB38ud2VbUhW6uYFAPFJD7cmiMQ8sPKdfOBZthMaPpCfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 19:31:18.1618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 745ae89e-dedb-46fd-42b3-08dcf52b9930
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686

To allow registering and unregistering multiple platform handlers calls
to platform_profile_remove() will need to know which handler is to be
removed.  Add an argument for this.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c                     | 2 +-
 drivers/platform/surface/surface_platform_profile.c | 2 +-
 drivers/platform/x86/acer-wmi.c                     | 4 ++--
 drivers/platform/x86/amd/pmf/sps.c                  | 2 +-
 drivers/platform/x86/asus-wmi.c                     | 4 ++--
 drivers/platform/x86/dell/dell-pc.c                 | 2 +-
 drivers/platform/x86/hp/hp-wmi.c                    | 2 +-
 drivers/platform/x86/ideapad-laptop.c               | 2 +-
 drivers/platform/x86/inspur_platform_profile.c      | 4 +++-
 drivers/platform/x86/thinkpad_acpi.c                | 2 +-
 include/linux/platform_profile.h                    | 2 +-
 11 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d2f7fd7743a13..c24744da20916 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -205,7 +205,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
-int platform_profile_remove(void)
+int platform_profile_remove(struct platform_profile_handler *pprof)
 {
 	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 958afd7bce223..0879b739c5e8b 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -228,7 +228,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 static void surface_platform_profile_remove(struct ssam_device *sdev)
 {
-	platform_profile_remove();
+	platform_profile_remove(&sdev->tpd->handler);
 }
 
 static const struct ssam_device_id ssam_platform_profile_match[] = {
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 53fbc9b4d3df7..71761d4220c26 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2546,7 +2546,7 @@ static int acer_platform_probe(struct platform_device *device)
 
 error_hwmon:
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 error_platform_profile:
 	acer_rfkill_exit();
 error_rfkill:
@@ -2569,7 +2569,7 @@ static void acer_platform_remove(struct platform_device *device)
 	acer_rfkill_exit();
 
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index e2d0cc92c4396..cfa88c0c9e594 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -425,5 +425,5 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 
 void amd_pmf_deinit_sps(struct amd_pmf_dev *dev)
 {
-	platform_profile_remove();
+	platform_profile_remove(&dev->pprof);
 }
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index c7c104c65a85a..f5f8cda7fd19c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -4885,7 +4885,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_custom_fan_curve:
 fail_platform_profile_setup:
 	if (asus->platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&asus->platform_profile_handler);
 fail_fan_boost_mode:
 fail_platform:
 	kfree(asus);
@@ -4912,7 +4912,7 @@ static void asus_wmi_remove(struct platform_device *device)
 	asus_wmi_battery_exit(asus);
 
 	if (asus->platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&asus->platform_profile_handler);
 
 	kfree(asus);
 }
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 3cf79e55e3129..4196154cc37d9 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -273,7 +273,7 @@ static int thermal_init(void)
 static void thermal_cleanup(void)
 {
 	if (thermal_handler) {
-		platform_profile_remove();
+		platform_profile_remove(thermal_handler);
 		kfree(thermal_handler);
 	}
 }
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 26cac73caf2b9..bb8771d8b5cd8 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1692,7 +1692,7 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
 	}
 
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 }
 
 static int hp_wmi_resume_handler(struct device *device)
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 1f94c14c3b832..50819ac919e87 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1135,7 +1135,7 @@ static void ideapad_dytc_profile_exit(struct ideapad_private *priv)
 	if (!priv->dytc)
 		return;
 
-	platform_profile_remove();
+	platform_profile_remove(&priv->dytc->pprof);
 	mutex_destroy(&priv->dytc->mutex);
 	kfree(priv->dytc);
 
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 03da2c8cf6789..f6bc5ca9da91d 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -190,7 +190,9 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 
 static void inspur_wmi_remove(struct wmi_device *wdev)
 {
-	platform_profile_remove();
+	struct inspur_wmi_priv *priv;
+	priv = dev_get_drvdata(&wdev->dev);
+	platform_profile_remove(&priv->handler);
 }
 
 static const struct wmi_device_id inspur_wmi_id_table[] = {
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c8c316b8507a5..619a4db74e5f3 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10637,7 +10637,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 
 static void dytc_profile_exit(void)
 {
-	platform_profile_remove();
+	platform_profile_remove(&dytc_profile);
 }
 
 static struct ibm_struct  dytc_profile_driver_data = {
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 6fa988e417428..58279b76d740e 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -36,7 +36,7 @@ struct platform_profile_handler {
 };
 
 int platform_profile_register(struct platform_profile_handler *pprof);
-int platform_profile_remove(void);
+int platform_profile_remove(struct platform_profile_handler *pprof);
 int platform_profile_cycle(void);
 void platform_profile_notify(void);
 
-- 
2.43.0


