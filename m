Return-Path: <linux-acpi+bounces-9804-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E4D9DF0B4
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27AE416362D
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C371A0704;
	Sat, 30 Nov 2024 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="flstuPZH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D4619F40B;
	Sat, 30 Nov 2024 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975536; cv=fail; b=WeS0v4h/Uk8pnvdAjK3kj0QNiSscy+5AwjgF3wo3SNJr/6v+8EJ+htRGB5QAFDj9XRvu5oqwO11/zlJ1oz8SXkQv/8bP5t6Z3acfGmvm+cVVxvlym8kzGXjWr/LMs+zTDj/Q/j0zLWrB/vY3MVqM3CrYUqakoWnDVNvj9z3u/ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975536; c=relaxed/simple;
	bh=X/qMGPGxaczfeyQYZqIbSekaoNFIghO+Qa3UeDEu/qw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1DlQ/SQFL1+ALiA7R62YKOI6lnfj7MgUhUnScMp+CpNeD7bot3vGGLZPxJpgZLfI62ln7/ezpRXL3ISfS19Lb0LWcE1F0f4lvP//VasSvGEvN4m26eAHjZCi9fCeolSm6/Bw/97InwWtjofUPzZ3s2yt/FVDL9nRIJkzKVUZ04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=flstuPZH; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9diL+7TPR7brELHwL6uI/QQUg5PzHgj+Y7yMD2pt41TmYKEsmKQFLWE+mKXn3/k9Hl4iAL9Dpx45rXXu5ad9zLXtfAHLnvT1A1dp63TLdk0vibKUhit2gzvfz6632pGIGFc3Mm771N7GfiJCv16ed5Ahe3MNgZjyJh4FhU/MuDk5Z5teQ+6/fyZIcV/hmIe4GHptipLWNOdtBt0xQiHWugDes/lXf8k/EIb/ybpefOte8odxh66T/tW/4BPDPLogRaMkBU3hMLqg19tSqjhRPDKAT/tfcWvzCwfpIi7KtuyLKGJzpRe7DDYR4j99aWVtgvUQ1L7hpf4VOBxUpO3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmlXKXUDmnHnEntQh6ap6iIrJjGGXd++LXeeuvAjzvY=;
 b=pYs64URS6yEA+vPO3JcFiMA48S+cerwM5tn1ftB1MjJmpk67jiPq6n1ZJegscsWIiDSztxl1E26JSxl5DyZazY2prhvHQZXyqrKe5qACwL8WHc0q/YCSiMUrpDpYpCNV3ybJoua1golHz458rIvYI3M6FfZ2G918Pfwa2TThndetA8kTIGtAq+HT7pgQJ2hBcmrhgln57M6fjSQS4YeeRz4UKntQm7VAISkIsPpaYfD5yL0V4wIH5XBGBOZhdaMBqaqN2NBnibRp9gvMyuvQSVmWIMmctHJrJBMqbhtFZgB4aLTTqTerpIvbwnk56Gs8fvlbcvZZdYef5m5ZSYw60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmlXKXUDmnHnEntQh6ap6iIrJjGGXd++LXeeuvAjzvY=;
 b=flstuPZHEzZDTcBabhmG0DaRqvhLUEYPT426OGgau8qL/RnxIqFSPCw26OsBKreHDc4Au4qkTXwNJZam9wS5OZuflchHBKBHSoHXnYU1/bBC7XFCEJzQ4UrG8KbrN0Zc13nks4pbX76OEd6tNkYZydmV2k3H9LsOeNpcz9SvEmg=
Received: from CY8PR10CA0025.namprd10.prod.outlook.com (2603:10b6:930:4b::17)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:05:28 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::80) by CY8PR10CA0025.outlook.office365.com
 (2603:10b6:930:4b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:27 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:25 -0600
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
Subject: [PATCH v8 04/22] ACPI: platform_profile: Add platform handler argument to platform_profile_remove()
Date: Sat, 30 Nov 2024 08:04:36 -0600
Message-ID: <20241130140454.455-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140454.455-1-mario.limonciello@amd.com>
References: <20241130140454.455-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 619b6a5c-d38c-4a96-7785-08dd11480b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWw3aDl1d2MzbTZ2SWs2dHE0ZGFWZ1NrNXBZNm00YTRMSCt5TTdkckNqMHlH?=
 =?utf-8?B?S2pWdlVUeVk1Q2RORUtDTjVzbzZlTjZ5V1F0aHozZWJzQlJRK0xyMVREMDlX?=
 =?utf-8?B?SjgxZ2RhVnlHL21IOFJtWU9NV1FHUmYvOHNoU3FraW5kOCtJeG9LeFpkUm03?=
 =?utf-8?B?RjRrU2xZNWxjNzd3WEdwWTBKdVFpRVNmWSthWDNxaGZaQzR1MjltMkxpeFRG?=
 =?utf-8?B?L3UvM3Q4SlRvRldTekFXbmgzbjRrS1lHVjdkcGJtRUl2T2FSU0JFN25PRThZ?=
 =?utf-8?B?OGNtY25kWmQvaGhuMitSVDNzTm9qNjI1VExvQlNDTWJqeHBlTnZHUkc1dGs2?=
 =?utf-8?B?TGpEMEIvUXJZOHA4b0pDTWd3WG5VYTc4cnRtV05aa1haaVp5Ti9OaytWMG95?=
 =?utf-8?B?dzlDTTRneEhzNzFSN0N4VXdMUjFaQ0RhS29ZbE1ia2RXT2hKQnlCL3FNWjIw?=
 =?utf-8?B?UURTeGFBdEtTS1JQdnU5VVpTRFdxSEdpTXdTazM1bUd6N0NGWjE0QThpNGtF?=
 =?utf-8?B?ZzhibE5RTkYzNU1TdWRPWmlybkxkUnlmeGFQbmxvUC9YcVZ6Sm4vc2daTHRU?=
 =?utf-8?B?bGdDY0ptU293bU9EY3B2MjA1TTgzSHk0QUlZUXR6Q09RRUJqNUhJM2pWNlJv?=
 =?utf-8?B?TGRxUUtYSGRId0FEanY4SUdGd0pzbWNwMnhaeU80NXk2OS9Oblllb0lMcTc2?=
 =?utf-8?B?ZU11eHhVcHB3cmUyRFVZN1RmWDJBLzNqQUVRcGNka3UvMnp6TXorOEhJMVk4?=
 =?utf-8?B?Z1BhVnBuUnNSOXdVRVBIcGRrd2hSR3Bkek9heGVRYTlDVklNZ2JZbWIrTTV1?=
 =?utf-8?B?NEwvcjlyQm5SbnBXQTl5SXFqNjBWMVcxS2d3ZEN3WERoekcwWkh5bGNCdUls?=
 =?utf-8?B?VmJpR243bDd1a01veUJiMHpCMWgwNlh2M0N2d3BMTjg1d3JVdTNLSGJOQnBv?=
 =?utf-8?B?Y3k3cEZsUmNlejRyZzV6ZmxqODA3azVvMnRwck0yMTZNWGd5OHNaRnhhNVZC?=
 =?utf-8?B?bHMxN2xwS3dyeWFwTzBQdVBpc0RIQkI3Y1UxaU5mcXN3eVpIKzlMa2EwaGxV?=
 =?utf-8?B?WENrZFhhUkZzUVBwVmRqWlFSbFRCYXdxWSt6M0JyUmFDS2VJK2oxVnJrUHp0?=
 =?utf-8?B?bTdrRVRDeGJEN2lBWlRxMGdQOGZScVpVZ05XMVBTV2pIRmdKTnJnenZha01K?=
 =?utf-8?B?OXg1T1lHejIxZWFQRTFaaG8zRjZYUEJqOVRTVHBVMXJ2VlYzcXFXa2NJeVJT?=
 =?utf-8?B?cUVxOUVkZXFYM3lNMEpFVW1wTk9CYm1OL09RTlFod1R0bUpSWVJPMjVxVGhq?=
 =?utf-8?B?SklwbDh6TlNnd2kvT3BzdjlGS3dYa2xrTWJ2WFpzSE8wZmFWSEJVcTVZMkNT?=
 =?utf-8?B?YVpobzkxL1pxS0svOWVoWWhZbm1JZkwxVkdkZ3FSOHRCOG5TRWptV2ZJTFZq?=
 =?utf-8?B?cUd3SjloYS9zVTNDQUdNMldLWjIzb1dCeUtYdnJtSTZCaGRvMzBGRVRIaytv?=
 =?utf-8?B?RXc4cEpYTUZYRUpJSTNLSElORUFQcUZyeW1OQm9TYW9nWm0wK3VXN1JwNVZs?=
 =?utf-8?B?WEZGVTNqK1E4UWNNLzFQUlI3OGhHRFFyM050ejYwSHRsdkVIdGwwbnlwRFFv?=
 =?utf-8?B?REhzV2ZaU1VSQ0VkOXdlc2lhOWdHV0VwMVZmYjEySjVPMkNmNGFYMVRBaVZF?=
 =?utf-8?B?VkUvMlZXV1RRc0ZkYjJKdTBwZTNPbitGT2t3WXdpekp0SFB0RDBwOTBUMCt4?=
 =?utf-8?B?Z09rZFJuaTliSDZXNDd6MkZLWkFhZGhmYnl3TVJRdTlZaWZPSUZZK29zNXFq?=
 =?utf-8?B?aHF4bGYxWnk2WkFoMUd0T2JZdnZFaDV2bzc1Wm1PbERFejZTQUZnb1RCM2Rl?=
 =?utf-8?B?bC9ZKzErSXg1V2pkSHUxcXhOek56YUZ6Y29EeVVDYzlmYnR6M2dtRnJLZUNH?=
 =?utf-8?Q?rgKqqXNoYFiZZLlZj7yaBukw6lx0VTwC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:27.5115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 619b6a5c-d38c-4a96-7785-08dd11480b07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978

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
index 398a454d1fdcb..011b5d1609b0d 100644
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


