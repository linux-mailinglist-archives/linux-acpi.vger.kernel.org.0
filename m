Return-Path: <linux-acpi+bounces-9164-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D269B7389
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA413B23AFB
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C59145B1D;
	Thu, 31 Oct 2024 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iqYU643J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F2D1422A2;
	Thu, 31 Oct 2024 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347837; cv=fail; b=VQRFvKQEiF0RTiE6XeYUyXG+5GCB7Ymti0+5sqTpM2KJEbC+77cwDyAbCUwS2n9oc3XRaAVernHkw1D3J8M5I3xW2YoZlJoX/z4rcdcVRib7w8cX+j+74qT0PC+oZ8jFyDihgc3KQ1buK9y0W9zMCpv8QfowS/VMbsdpWey1hsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347837; c=relaxed/simple;
	bh=dB/p5is31qIeG25xbZm/v3EQsv85jK4gOHnlTJJd0WU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9vUkzC+sHQHvqHFk6Ci4CvLTStp3xXQfHJgrhq/0URFtAmjUJpgKExIw44U9rn2P4XrXWX9bwO61K87qlgNIP0d1H5f+ZsdKxiz4wm7+zEnWA/XRc78+KaLQoVY6ITOgeHevSYQSFLBnInkCBVzS4lcMkZLcYvdyzabt2YXAjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iqYU643J; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbc/aYnJUrexWB7TDvDwNTqputAw0iDn8eJ/x7G0AHF1D9nfV4JFZocqrbrBpptg0YkU4eGUsSVeLACOnZaTyckKqRNBbLVazB7qRD8oq64PburHgNu3ZI48fPwKcdwCDUtEILXrd7LyU02yE85Ih+hmuDXQ1KrdMDEg/mnS8mVY/etJXJk6ulbI/FiUkugaCk28neQHN/FKZEEkSQn/fZwCjoMv3zdQYq4rz5S/gFHRJBflAxl7nqWBZFtAGHO6+R3p5QLT3n8W/baW0zlzZUZ+x94mMMj8HGTgq9s1zPEm5Phwd8eGISxzM3+bxJ0cCOuTS6lE329SBsUBqCP4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQav9+5aq1tZTigIRlc0h8HY9zHbD6WOzLNTqDVgPhU=;
 b=p3we7sFpFJe+MUR7i4Ijp+NMw4p0VC+8DezQMMU90SH5/SJ1IvOm7tADVKMmBW+IVQCss+ZCHuUiGIgoPCKVYDzirwFIF2mHk0ajFQGE2ONHl/nMjcmgoskHdMZysj4ZibENcvnxCm4Pka1G7G6RGf3Y5TWeccH2oKtlw4kTbQAtEL8aqLl1vhTPiA5h532H+FNoPkhkcbz34sNHNakg8EVOjkTp/Uh2GdyAKh32dp9oEO5anZYKEeKJlYvy53GzMOPYnQBSz3iEPxwQG0mrLZIsZCLXrOA//gAtxJwhIz5SR+I8y+PnD8ibFOXU8EVO/fPfSWCUXOD/zXCbmlPOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQav9+5aq1tZTigIRlc0h8HY9zHbD6WOzLNTqDVgPhU=;
 b=iqYU643J5fqXrvyrT73vvJ8o0P7m48Q8vacfu7/L64xzGAXMnHMXifXFC+o4Fg/QBauqVxJEiGHKBL1X+TUSd04xXw6VVmOvJSLVJtTymlMAX2bY1PVn4QN6OOamDcPz8jF8Ca82/ojCmFXsaaRA26hbtxwFFNrRBHyeF9v4mMc=
Received: from PH7P220CA0075.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::11)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.34; Thu, 31 Oct
 2024 04:10:30 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::6b) by PH7P220CA0075.outlook.office365.com
 (2603:10b6:510:32c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Thu, 31 Oct 2024 04:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:10:29 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:25 -0500
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
Subject: [PATCH v3 04/22] ACPI: platform_profile: Add platform handler argument to platform_profile_remove()
Date: Wed, 30 Oct 2024 23:09:34 -0500
Message-ID: <20241031040952.109057-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5e63ad-8741-4106-55af-08dcf961f521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xg+Fc5mTssk/06s/An3xrkZgsl8v6ksDhg1qC05ZloZv/7blD1kpDUF0Drsb?=
 =?us-ascii?Q?X/O+K0sd+kqG13DBh/dxcxLCIILltu4n0wJl4bOawdjti0ZyWONDORUOPJ8s?=
 =?us-ascii?Q?uvDHSr37ahDuAwZDEKBuGRoHsauYEHlNeI1Y4YreLikKMWKpoMymXWGXcpoy?=
 =?us-ascii?Q?X1ih63mmFy+ZO6z9jc2OmIAINqOdrMxMUFLY5k7+PJ7cOh0r+MZc2Ab6l8U4?=
 =?us-ascii?Q?kJw2m5vq4JoTreJSv8uIO43+jEuvM8Sx39OtCy7F5oJ5wtSznbC2IHzDe+z+?=
 =?us-ascii?Q?h15AxFxkwTB3xWRpyz6BfgGQy9mERFS7QjkSFsUwRjPDJYgg1NFUeW2U6Fbj?=
 =?us-ascii?Q?8x6M9c1/PMVxCt4vOSAtnVqIcWmPpda2uabYzA6ajQNKogcXjnPMwJdIC+mG?=
 =?us-ascii?Q?RrhYeYobX8tuJzwwvJmKFWDLqfENQnmB6LifYCmjfVW2B9xo2jDDHN6HiPzZ?=
 =?us-ascii?Q?4eQJ5zUCUQ1FaWkNwbvCSyTBcCEOhhnxH+FvMIOslEXHl8RrUbFuSTy6HEgZ?=
 =?us-ascii?Q?EHBhEqvA80pUSn5zD8E0bMYjAXBuP+oCE97sQ5OkmiJKKQd3hVKOOGAYeuVK?=
 =?us-ascii?Q?Rll2g+GNJAPeMmTcxh1qMLa8Y9mjDaHpxNln1HGgPWoMDOEXgBHW71YoJxjW?=
 =?us-ascii?Q?o6P8q+cFWAUFP2R6zgdyMNOiJ0ORYS/Z1IL8uI1MY06FeT68g/QzKKwfQIO/?=
 =?us-ascii?Q?qZ1QSMg0jr5/tTmteIjh4akY4u28duV4eMJQc6XQwb7XN42bUJsPgZeQ+oUS?=
 =?us-ascii?Q?JdGH6DGmD36h9yppL3KBXrTefD9DPYt5rII9Bh8R+E8SJ38vnAkl/eOTWK2O?=
 =?us-ascii?Q?4iPY8bvekuqzZCEirvQUq80JskQu80aw6CNA6pyWiJLVdpHsBbDkWqh3HulR?=
 =?us-ascii?Q?vfam0CuORbJaoucGEjxJrdbMnWZCQC5xwpoDH++pjTyW8cOUj7XGdmlQAqCF?=
 =?us-ascii?Q?ERc38Crae4YPUTSzZrOFdQLkwe1BgVgeAUIkPjC8vFnNLi0IKCQ0mXkdGOUO?=
 =?us-ascii?Q?GntYtiI+hZy9Ls1CNzZ3YGQiw608P2R5IpEfeFHhQ6GNM4LeZZlhIw7avkFQ?=
 =?us-ascii?Q?2VfwDWhVgupSFFrpmtFNpwmejc8Mxmz1aL57WdjDxlIYasWdDTUPTaTn0Ns2?=
 =?us-ascii?Q?B5o3AUTDtZmjvoA/uM5Bv3YSaa+VR6p4CQWAgsBIp2krHTHMPDUlhjWx+1cV?=
 =?us-ascii?Q?o8unfG+wmdU9nclqrWQXhCtTk3YPFyoo6zd9LKHcNU8Aukb6tV4wT5hKiEVI?=
 =?us-ascii?Q?DPzGszPNrX/X76ZBvXHF089DCw+j35E4waEVFd72w7iSbl2I6jzrBgHaVKaU?=
 =?us-ascii?Q?xB73MzEJ0pbTyKChMv7w+HMP93R8TKqdeYz+vWZRn6NKBFFryVlkYxLKJPKl?=
 =?us-ascii?Q?TAZTKxE/Cc+yScddK1SIyr9eWZEo3bl+EgkTZvnHp1ZdAnMQMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:10:29.7014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5e63ad-8741-4106-55af-08dcf961f521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415

To allow registering and unregistering multiple platform handlers calls
to platform_profile_remove() will need to know which handler is to be
removed.  Add an argument for this.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c                     | 2 +-
 drivers/platform/surface/surface_platform_profile.c | 6 +++++-
 drivers/platform/x86/acer-wmi.c                     | 4 ++--
 drivers/platform/x86/amd/pmf/sps.c                  | 2 +-
 drivers/platform/x86/asus-wmi.c                     | 4 ++--
 drivers/platform/x86/dell/dell-pc.c                 | 2 +-
 drivers/platform/x86/hp/hp-wmi.c                    | 2 +-
 drivers/platform/x86/ideapad-laptop.c               | 2 +-
 drivers/platform/x86/inspur_platform_profile.c      | 5 ++++-
 drivers/platform/x86/thinkpad_acpi.c                | 2 +-
 include/linux/platform_profile.h                    | 2 +-
 11 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 5d9f3f7ba71c5..c76b8e3fdcde6 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -210,7 +210,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
-int platform_profile_remove(void)
+int platform_profile_remove(struct platform_profile_handler *pprof)
 {
 	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index b73cfdd920c66..6c87e982bfc8f 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -210,6 +210,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 		return -ENOMEM;
 
 	tpd->sdev = sdev;
+	ssam_device_set_drvdata(sdev, tpd);
 
 	tpd->handler.name = "Surface Platform Profile";
 	tpd->handler.dev = &sdev->dev;
@@ -228,7 +229,10 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 static void surface_platform_profile_remove(struct ssam_device *sdev)
 {
-	platform_profile_remove();
+	struct ssam_platform_profile_device *tpd;
+
+	tpd = ssam_device_get_drvdata(sdev);
+	platform_profile_remove(&tpd->handler);
 }
 
 static const struct ssam_device_id ssam_platform_profile_match[] = {
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index a5caa529351ea..44992d5da4768 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2552,7 +2552,7 @@ static int acer_platform_probe(struct platform_device *device)
 
 error_hwmon:
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 error_platform_profile:
 	acer_rfkill_exit();
 error_rfkill:
@@ -2575,7 +2575,7 @@ static void acer_platform_remove(struct platform_device *device)
 	acer_rfkill_exit();
 
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 1b94af7c0e0c4..bd2bd6cfc39a0 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -426,5 +426,5 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 
 void amd_pmf_deinit_sps(struct amd_pmf_dev *dev)
 {
-	platform_profile_remove();
+	platform_profile_remove(&dev->pprof);
 }
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 1a8c29aafe892..90c20d02e1638 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -4896,7 +4896,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_custom_fan_curve:
 fail_platform_profile_setup:
 	if (asus->platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&asus->platform_profile_handler);
 fail_fan_boost_mode:
 fail_platform:
 	kfree(asus);
@@ -4923,7 +4923,7 @@ static void asus_wmi_remove(struct platform_device *device)
 	asus_wmi_battery_exit(asus);
 
 	if (asus->platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&asus->platform_profile_handler);
 
 	kfree(asus);
 }
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 730f97aab70cd..65989af2e4196 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -292,7 +292,7 @@ static int thermal_init(void)
 static void thermal_cleanup(void)
 {
 	if (thermal_handler)
-		platform_profile_remove();
+		platform_profile_remove(thermal_handler);
 	platform_device_unregister(platform_device);
 }
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 1b6677e176769..22a7fc64d230a 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1693,7 +1693,7 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
 	}
 
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 }
 
 static int hp_wmi_resume_handler(struct device *device)
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index feaf98819dc82..73030dc6b579b 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1136,7 +1136,7 @@ static void ideapad_dytc_profile_exit(struct ideapad_private *priv)
 	if (!priv->dytc)
 		return;
 
-	platform_profile_remove();
+	platform_profile_remove(&priv->dytc->pprof);
 	mutex_destroy(&priv->dytc->mutex);
 	kfree(priv->dytc);
 
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 5a53949bbbf5f..53af73a7fbf7b 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -191,7 +191,10 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 
 static void inspur_wmi_remove(struct wmi_device *wdev)
 {
-	platform_profile_remove();
+	struct inspur_wmi_priv *priv;
+
+	priv = dev_get_drvdata(&wdev->dev);
+	platform_profile_remove(&priv->handler);
 }
 
 static const struct wmi_device_id inspur_wmi_id_table[] = {
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 222fba97d79a7..13798c6d5fcf3 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10638,7 +10638,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 
 static void dytc_profile_exit(void)
 {
-	platform_profile_remove();
+	platform_profile_remove(&dytc_profile);
 }
 
 static struct ibm_struct  dytc_profile_driver_data = {
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index daec6b9bad81f..bcaf3aa39160f 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -37,7 +37,7 @@ struct platform_profile_handler {
 };
 
 int platform_profile_register(struct platform_profile_handler *pprof);
-int platform_profile_remove(void);
+int platform_profile_remove(struct platform_profile_handler *pprof);
 int platform_profile_cycle(void);
 void platform_profile_notify(void);
 
-- 
2.43.0


