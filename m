Return-Path: <linux-acpi+bounces-9849-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7C99DFA50
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E54163119
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381FE1F942D;
	Mon,  2 Dec 2024 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0zk1b12o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700C1F9416;
	Mon,  2 Dec 2024 05:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118702; cv=fail; b=tIpXzvcrwBTbF0Q1M1/OeA5YcwN3O2PJxYZnVEWuEjQ3xEjLYnTpTW0rt1n+dLr3o54zUcuIhoGJtFRUfb7k+ixg4vMLqjP/dMqq1JrFoK/Yu4hahlj1p1kGj/S28X2nmAxwxp1u4ffzrtgELw7eWhHgcNoRnGuyKraoULPKdCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118702; c=relaxed/simple;
	bh=ADHAYEGQIN8PMTT+q5E6Wnjocrm/ZEi+CMd0CtE3+mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxrQMDyOh/y5/Hk4hgmcZmqiOSjgN8YfB34tOqN4dqwOSJgTkbrh6oYsHANAF475wlXyiYzNyBu2bY9vjJ9jJN5eyETDrWhEs5l0TxjZhsR0cXQXIHOjLO6BShq5b4Epj9iV56npXTZt38qWjSTxGXlovubjhuUb7q1OzGlG/6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0zk1b12o; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWvk92Q+4bZlbNBe8DDWir8qFGPTvI9Nke3I2TMJRDtXnMXXnCGd/chStnIft7kDqRlo28RCHU/XsOKq+wC1js446bFeFf/GhYrfZDDvN0EqtLeBLnu1opU70+O6SGYxFMar5YKkBQRhoR8Jf2sEFIvVao1WmXgBTbgBCbuWC9eQbQaFLz19areYoiEjrwblZewKa0X6JH0H4//reNMF20XCEORLaG9qe3kpmHZeeIXc0Wl7Y4rX5TaeABRf7IbWlkt78Yc5WTBm5WnGRDkr8YUsPJIRUFom81CMko0ClBTH6o9AIovm+gffTr8FVX1ErOrTiCcxXDcMtPJv4Qh6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vqpumrmwwskxuax8IdkPneF/w2aPuFMAKFy2VR8gjso=;
 b=nq5K7/8ZCKJLX64edc6+q5qgM4Cap1qFpU/s5w/k1VKE34LAkdGPaleYZhF02DJ9RfzW74vcj9bycilS+faLTGnFbY4bWDaj1uP1fYyIPiv6T/y9I0QN/iqdQfTEgLwSjg2b9vxVWN9GiRQbUefs3LudaM7kaCQx1+vti+xOETZrN35lZlPq/7Zwy1bBJxQVwicu8FXEciUwqGNKeKFZ8pnxlH8U3f1amg/CJ6LPRonRoDlCul6IilSRWHgpRM/UFqcGVG3jThXEcv/Eof73c0h4I5gZwkbbq+S09bKuafH6JSulJuyHXVXk8Bb0jMkUxNneYE2FSnjKhgC9hpgKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vqpumrmwwskxuax8IdkPneF/w2aPuFMAKFy2VR8gjso=;
 b=0zk1b12oJ+j0pkeFvVeOwBiveupkR6GA/7fnbMvarrXqOOZXP2936ZL424xAfTvLjJKZheRoAeHIvRMNuHQHLpAONp/lC+PmyHrqvtfJ5lvrjjdXWmx40s0hFd9hkHVCOxXqST1F4egigRwdhg0VR/Jz+VzuMDBJEBhtPrZGohM=
Received: from CH2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:610:50::18)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 05:51:34 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::a8) by CH2PR16CA0008.outlook.office365.com
 (2603:10b6:610:50::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Mon,
 2 Dec 2024 05:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:33 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:31 -0600
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
Subject: [PATCH v9 04/22] ACPI: platform_profile: Add platform handler argument to platform_profile_remove()
Date: Sun, 1 Dec 2024 23:50:13 -0600
Message-ID: <20241202055031.8038-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: e41e1bb2-2486-46f4-04e3-08dd129560ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGJPTVAycVdBbUlnK1JmblJTa1FrK1BaTGE3RkZpemVEQmpjZmJQY3p1Z2Ir?=
 =?utf-8?B?dXh2RzBrcUVabVgyaWh3NkwwSGx0TWIycDBXRE1ucW5HYm1vMHp3alRJR2gv?=
 =?utf-8?B?cEZQWTBXVkVCVmhvYm1BTmE4cWxPQm8rUzZhOFU2d25saWd0b3RSbXJQSG9Q?=
 =?utf-8?B?NEIzQ0U5RDNZZWRqUWJOTGVRbE4xMlQ1dW5KTnpXUFpZVERoY0VMNE1zSTJX?=
 =?utf-8?B?MnZnWWsxby9iYnFZakU3aXpiL1RPbW5HbFRZYVdYUk9KL2VnOEJWYm16RkZx?=
 =?utf-8?B?YVU4QXNrUXVMMitGRU15eE0xYUxDbFNDVFFYWjBTM0d2S0xiY3NNbDdiS0N5?=
 =?utf-8?B?VGUxcEM2L3NxWWNaQWdWcGhGOHRHUXdoa3NGMWNNSXorNWJZVEZheFlMTzRl?=
 =?utf-8?B?MlJaNHhrdTNoOWVXQWhuZlM1REo4WVhJQk1VZEhJZTZXWjlpWUc2SHVxUzY2?=
 =?utf-8?B?dXNIZDd3SGN2OWZJVWZ3aHg0enJLVXpuYmFCaWVydUFINmJnbWY1R05mTTI3?=
 =?utf-8?B?WEpmRHVpUkFPSlh2anBIU3ZmVFh6SUZJd2h1d2RYL05qTitaYXpmSEV5VVFK?=
 =?utf-8?B?UXdOVElIS3BvdTBVeHdTaVhmLzA2cmJQK3BpeHNXb2czWGZKZmZuWG81TmZr?=
 =?utf-8?B?eTNlRHJKZlozUEpxUnZBR3RaVFlMU1pwVG0vNWNhNmVJOXFCNjVIcmYyZTEr?=
 =?utf-8?B?dkxZQ0pjeG96eE1wazRVYW9iNktKQXR0V3lITERBRFpxTHFPbmxwRGYwL3pZ?=
 =?utf-8?B?TTRoUjZEMWl2eTgvTkdzWk1BUkUyRGZ5R2pUcGkxdE9lY2J4ekVmU0VYOXhw?=
 =?utf-8?B?ck1EaHpTektLb0FmTlV1QWZJcnpnaHlwNnlMVzM5QTVvazBJUTBSTEEwZHlF?=
 =?utf-8?B?blVjTU9FanRyS093SDBwc0JTZENrTjdZRU1mS1paOUN1TGVjZ0JGcmZxeWQr?=
 =?utf-8?B?OWgzUXlZbktiQzhTU2gzVEdCdU92dzErcDhBc2xuc0I1b2ZqQ3pCNWs3b0pX?=
 =?utf-8?B?M0xZNURzVFBHYWtKaytYZGx4NWFKb3VENE1jNkcxSzU3bVYyRVlKTTYwQWcr?=
 =?utf-8?B?Wkp1YS9HS1BldGgyQVlZdnhWQzErU1pnTWU3c3RITlIzd1RMVFU0MUF3bjc4?=
 =?utf-8?B?TkpvY2w0dCsrcENtenpCSGxOMFg3Z05GZExOMTRFcm1WSXozZ09vQ0pmc2cz?=
 =?utf-8?B?S0xkUEVkMTQrdjFicFhLUjlHVzNiTDRaQ3g3ekN3VlhNUlZhUXArbGRUeUxW?=
 =?utf-8?B?STYvOFdkV3RFYVFHakpZNlIvLytpdENYbExrOUUwbHJWaFZvYmtUUXV2WjBk?=
 =?utf-8?B?a1g0eGw2eW1YKzdDMHRQS3pCNDJJKytZR0dWZWJ2L1ozVzlac21nczRXNEEw?=
 =?utf-8?B?YWlhZjJOalJreVR6TXJZTCt4VHZwU0xQTHg1SVFlQi9zMGhVd0FFVy95eU1n?=
 =?utf-8?B?dGcxNFFVNjNWbjcvRXRwT3U3NzJtTTZkSUxpblhGOUZDZW1KZ3Y1KzJuQ3Q0?=
 =?utf-8?B?dU9JZkx3Z3pVdE9hRWtlZHlPZW5sdWRaSUpzNFAwTlpzU0RoZi9XdHFwVGVq?=
 =?utf-8?B?RE1nZGdaMmYxcUx0NFgreExPZnc3WUxUTDkxcUlsYVpXZXhDeVd0RmV3QWh0?=
 =?utf-8?B?ZWxZN3I2ZVRxZ0o1Q21TN0pGSjRIZnV3d0hDNlhHOWljVFNnMmZWSVBYNWdT?=
 =?utf-8?B?NytXWndzZytXQzZjRGZCK040OWp3MGJPRUlmM0l5MGkzY3BMTmtycTZlL2tt?=
 =?utf-8?B?aTZHYXNMYTI0TFkyaGY5aDc3eUNpamNsM2tvUldPbVZmMWFrYXZIWFJFOUlh?=
 =?utf-8?B?bURWVjRJZXpIMEdoRHlVSFlGdmozbkpic00xSTlwOVpxeFVjVlFtY3poMDVt?=
 =?utf-8?B?TTB4STFWOWdGTW9jZUpmM2k4MjdhWnVQck52WHVVMnExT2I4dllrTmFUS3ZG?=
 =?utf-8?Q?hn1DV5wYoTXfRTYEIfTDl/7+8eAJnLsD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:33.7141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e41e1bb2-2486-46f4-04e3-08dd129560ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496

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


