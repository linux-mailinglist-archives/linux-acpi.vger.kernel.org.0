Return-Path: <linux-acpi+bounces-9989-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00869E64CD
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAC71880608
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892CF18A92D;
	Fri,  6 Dec 2024 03:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h2jbHlb/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52581865FA;
	Fri,  6 Dec 2024 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455425; cv=fail; b=kY+kvlx56qfMj4PmcwqqqzQJfe+2Vysl+ZAiWgUff9nG0xv0m3yO/3sn7XceFt9oHr/9PcArXIpnGoeEFE9M9P8xuhn+9L0YNwQ9BnjUE1NX5V46iyEeWMtMJ/NyZTbt51BofwY4a7zb2UvGNjiLZTR50krDAayG4uVa2BvlIrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455425; c=relaxed/simple;
	bh=ADHAYEGQIN8PMTT+q5E6Wnjocrm/ZEi+CMd0CtE3+mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRI46Wc/CgV+Ct9VKXL4TlFqJoEBda9ogABZ087TNK1ScTMtkSwFlDu+PFcOTtWEhCetsujyyC7WcrxAPra2VbARxaqrjyDlfXVp1Uf1U08CdyhqB91ZaLWvRIgfl2wp54685KwPI1+jHKih+4U6+DLC+QSvk38dZU3/FJo4Z8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h2jbHlb/; arc=fail smtp.client-ip=40.107.96.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9TPdQRBvcWd2C+s4/FU+L3Gnt6QkQ/PZhNtDCeBaxvnWurPBsHMQD5sj8eMuHR7ikiWgpIrfcDqnvURKSJPBCh+dqVVcdlJd332T5l2ex6/rthFdQkt+X7uG4Bn8HapAsczlysdGJRdOmE/kDqWM8P8lOCIkvDCfjm/zDc0SNoMOqiSYJ34BC1YZZuJo4Lo85YTu7Na64WdPpMnZtKlFFSOgVfrkwZKTVAZ70nzvCAZzt+0v6W3Iig0ta5/P7pXvMABJ27DSzxKpBJtVULdMDbaEAeu2CzkAjW+HEAOhApAqsPvu+Yf5zKVED29qRLxoMmhOIx3E6yzIxBulevVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vqpumrmwwskxuax8IdkPneF/w2aPuFMAKFy2VR8gjso=;
 b=YtbWwAtfxYJtXpnTwFNXuaCKXIdS+kMTz15naVX+lg5oaxnXnn6T9+EBO4sXL5plwfrfvcfHZEKjyGozYPnprrX/yVL0s3fmTsVtPqHNLgo8rl6jsHMZvg1ctvXb5NO1CwCMzum3gQTUvbrFiaZQIAR2Y97nj1B7IBR8CAvqJnhhaepmMzfei6fbXYO8sWFu67INS4zEx+yLbij3LSsbcTeuM/0FDs76LNGqWNwNKSvg4WVLMcT8rTh/0GOXmMBHyoYEad+QlRTqNXwFDsRS+qipaNcsEjj2U5CuXxhF4VJkPFy5H7wKaqycyEN5AKrEyVD+ZCMDxad6BYpu7qqDVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vqpumrmwwskxuax8IdkPneF/w2aPuFMAKFy2VR8gjso=;
 b=h2jbHlb/O69CIQ9lNtcrZeSBqRLoy5uv+RkrEXNaMY63D2LqGE4+bu+qIBrmI6ec0xfMfotzEFyhEw8kpwSkrmVn1f9OVm9blE2aRMftxmQN2syJrVxwQfbuugMycrr46MzWHDSNH9rrB+1RYGu/REuroAfmEBFofeudNB6N9G4=
Received: from MN2PR11CA0011.namprd11.prod.outlook.com (2603:10b6:208:23b::16)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 03:23:38 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::9c) by MN2PR11CA0011.outlook.office365.com
 (2603:10b6:208:23b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 03:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:23:37 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:22:19 -0600
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
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH v10 04/22] ACPI: platform_profile: Add platform handler argument to platform_profile_remove()
Date: Thu, 5 Dec 2024 21:19:00 -0600
Message-ID: <20241206031918.1537-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206031918.1537-1-mario.limonciello@amd.com>
References: <20241206031918.1537-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 75885412-84a0-47e4-b062-08dd15a55fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEg4WHg4SExxRlV5MU80WkpKakRrY0MrUU5LTEUyNGVNeWJ2QVhvaytXdmsw?=
 =?utf-8?B?Z2ozT2NhZHhVUnYzRVY1ZFEwQlZ3bFU0SThjWVh6Rmwrb2tUYkRmK0JLREh5?=
 =?utf-8?B?ZnB2N2dCMFg4alNpM1k4d2VGTVkyOHJZcVFsTENraTM4WXRMUnFDeXZtR2NY?=
 =?utf-8?B?bHQ0aExoTHQ0alpMYWs5dG92UmpOMjdYZExqYndYeGNpS0Q4Y1Y4VDZZS1ZJ?=
 =?utf-8?B?ZDBHUm1BYlg5K1F5MVZuQmFEZDh2YTFKMVdLNDZ2SlpIQzVYdXJCQm1oQzEv?=
 =?utf-8?B?VW8yNW8rUEw1bnBBKzM4cFpLK2FXSUQzc0puYlphVjdNZ1RrYWJMVmVXSllh?=
 =?utf-8?B?a09ob0NISVlCdTV2OVc4eWk1b2MwVGpwdFM4QmxEdmVQK3E4UWhuRmhaRW1t?=
 =?utf-8?B?eFdaS25FeVFYb250SVMvNjdNcVF3UGo0dDM2ckVZTkZHUXR2Z0hBNU9PcHZ4?=
 =?utf-8?B?VnQxVzhhS2xGWktOL3hTVENvUSs5dHk2MmNHV3BienlHblR3VEd5Y1JuOFli?=
 =?utf-8?B?b0pXU0U3VmgyNFBDTktUWG5VZ0RVd05zOGNZTUxKeWc4Uy9WOHI0bzB3TjZo?=
 =?utf-8?B?T0RFdFJzalpsR2VoTUFxaGpHOHdMZEFiZUtoMG5IelZmS2paenBkTWJZZU1W?=
 =?utf-8?B?aVNzbFZuZ3NkdlNSdDlDOXU4cmxncjN3WEdvVFZLdHQ4Ti8zR1dRS2hmdXdv?=
 =?utf-8?B?QmdETHZxMGdZUkdSUjg4TWlva0RzVzhBRTNNWk1wYkd2NS9hazAveWdSZUxB?=
 =?utf-8?B?by95ejV6TUVkbXNuVjNCQUdLYXZleWRoTFZuYTYrdGdwWTFaOXFIZEQ5S21R?=
 =?utf-8?B?bTFDcXozLytqVlI2SkE3UUFPeTZPSGJ1UHVKQXJtcUVvTjVTUDQwZzNrMUJP?=
 =?utf-8?B?ai9zZ3F1dlV3RVUxSnR4bGJIam9BTERDbVppK0tiQ0lFMmNpZktYVjAxVyt1?=
 =?utf-8?B?MWxpTmtwWGNlbXZFUWhIaFVYS21Od1FrSTZGdlA2aDJiUUZiVUN4bWlkVElP?=
 =?utf-8?B?ejNvaDdza0kvbCtQSnFlRldvcjFuTjV3KzY0K3FPaUNOaGdya0dUbC9tUFJ3?=
 =?utf-8?B?UXp0eWkvSVlaekV6ejZJcklZWTYvK09UMGI2OFVTREp6NzZpcWtrcjdQOHFS?=
 =?utf-8?B?RGduaS9QWW4rd0I1S3NqMDRpV1dVaitNK3Q0Rkoyek4xd1pwVDJQYTZDUS91?=
 =?utf-8?B?K3I1ejlJQmlCdloyN2N0SVh0d29FczYxVFJqTjVwZTFETUt5bWE1bTdhTDZT?=
 =?utf-8?B?allPb3J0UXFRN2U2eDBlZ0M0N0hHaHNQR24wdHp1TnhPRHM5RGgvN1VoVjRv?=
 =?utf-8?B?UjUxRllkZDRuS29HUVh2M00rc2NISE96VFc4YjhFZkhCdXc1Q3JhcFBpcHJ0?=
 =?utf-8?B?RTkyQ1pIRHlqMEc1MzJhMWJTdUw3Zi9XNnAza1Yyb3lISUdmRUhsTlJpcDJ4?=
 =?utf-8?B?Rzl2NjVWbUNhYUluVEJpdWd6NFVRdUJQUWZWcWFOVXJWMWhMZHd3YXR2V2RF?=
 =?utf-8?B?d2xxSzVpKzJXV01UZFdkczZDK2I3c1VIb2pHUVdPMFVDdTY1aTRHOXJISnN0?=
 =?utf-8?B?OWtQV0I4d28wcU4zWkV4cC8xWDI1M1BLOWlTZGZtZzM5clFuTjViS2VQL1JL?=
 =?utf-8?B?UU1udDZCZjQyYUVBYXpIL3lPU0JRa0hYelpuUE9XY25maElCaERuYTNoUU5G?=
 =?utf-8?B?V0hWdGQvQjM4eXYxSEZJMTdJT3doRlgzSzBmRVJKcUFSWXpmVXBoSDNWUlZB?=
 =?utf-8?B?OVBzKzJGdFR5dmlZNDRudFZ3Vm1BZlZWNWhHZnRCT2hUV1pHdDFPaTlGUnV0?=
 =?utf-8?B?dmFPMzY5OTRBN0hwelA3OG13ODBJU0R0aDRtdU9uQ0w3UC9oZURqSjBETVky?=
 =?utf-8?B?U2xWWGQza3VMaU5GYXNjOWtMYVdwT2d5ZjY2cHBaRkZ3d3NVbUhubjZHei9p?=
 =?utf-8?Q?kcZ2/cDDaOI5S8XvJCWATXhNdj9freXi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:23:37.8463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75885412-84a0-47e4-b062-08dd15a55fe4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132

To allow registering and unregistering multiple platform handlers calls
to platform_profile_remove() will need to know which handler is to be
removed.  Add an argument for this.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c                     | 2 +-
 drivers/platform/surface/surface_platform_profile.c | 6 +++++-
 drivers/platform/x86/acer-wmi.c                     | 4 ++--
 drivers/platform/x86/amd/pmf/sps.c                  | 2 +-
 drivers/platform/x86/asus-wmi.c                     | 4 ++--
 drivers/platform/x86/dell/alienware-wmi.c           | 2 +-
 drivers/platform/x86/dell/dell-pc.c                 | 2 +-
 drivers/platform/x86/hp/hp-wmi.c                    | 2 +-
 drivers/platform/x86/ideapad-laptop.c               | 2 +-
 drivers/platform/x86/inspur_platform_profile.c      | 5 ++++-
 drivers/platform/x86/thinkpad_acpi.c                | 2 +-
 include/linux/platform_profile.h                    | 2 +-
 12 files changed, 21 insertions(+), 14 deletions(-)

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
index aca4a5746bee1..b12965d9fcdb7 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2547,7 +2547,7 @@ static int acer_platform_probe(struct platform_device *device)
 
 error_hwmon:
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 error_platform_profile:
 	acer_rfkill_exit();
 error_rfkill:
@@ -2570,7 +2570,7 @@ static void acer_platform_remove(struct platform_device *device)
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
index 14d84cad01b49..805bce80beef2 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -4852,7 +4852,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_custom_fan_curve:
 fail_platform_profile_setup:
 	if (asus->platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&asus->platform_profile_handler);
 fail_fan_boost_mode:
 fail_platform:
 	kfree(asus);
@@ -4879,7 +4879,7 @@ static void asus_wmi_remove(struct platform_device *device)
 	asus_wmi_battery_exit(asus);
 
 	if (asus->platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&asus->platform_profile_handler);
 
 	kfree(asus);
 }
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 78aac76132788..e95d22c7b60cd 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1165,7 +1165,7 @@ static int create_thermal_profile(struct platform_device *platform_device)
 static void remove_thermal_profile(void)
 {
 	if (quirks->thermal)
-		platform_profile_remove();
+		platform_profile_remove(&pp_handler);
 }
 
 static int __init alienware_wmi_init(void)
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index b9a6dd7b321d9..3797a5721dbde 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -289,7 +289,7 @@ static int thermal_init(void)
 static void thermal_cleanup(void)
 {
 	if (thermal_handler)
-		platform_profile_remove();
+		platform_profile_remove(thermal_handler);
 	platform_device_unregister(platform_device);
 }
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index ffb09799142bc..6d6e13a0c6e2d 100644
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
index b6586c473ba91..95b66ac3ea1d6 100644
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
index 58af9020382c1..298100d5c535c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10660,7 +10660,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 
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


