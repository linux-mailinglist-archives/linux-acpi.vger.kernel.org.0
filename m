Return-Path: <linux-acpi+bounces-9387-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D869BFDF2
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71091F23A37
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7921946AA;
	Thu,  7 Nov 2024 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eO0i+Qqg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D937E192D8F;
	Thu,  7 Nov 2024 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959414; cv=fail; b=iN6xYYw6jhmwmTc8gylRlV0z5TKCsntMVIE7+wi90ebxVfukiIUCyuAQ5e3bnBFE3xkEjTqtE0xThK+EUPrBkspm/w99q4FyT3tiVzc29l67jqJNw2LeIF5M/C78DI3+ONndCWPQJ6JL16Ki5CYzbkhPsY24W0xpnbczkcDLbWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959414; c=relaxed/simple;
	bh=tgk8RY+Xh2BX2mN66fKFdmqhl/F4m7qqrrEeV1tpv8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Goh1SFBilukoTWHrAfUUVLlwB/NMS2FU9tnmKMsHjjJ+iuZ4I0XJSTgzlFWlKZ6GGYlr3pE/6jVxt2FyJWKjP7dVX5PbZSL8eW1GCBv+lczzv9iUWyvp3eypxk8wrFNLhOrUb3O6rsIR58EEcVrnLDBs6Jv875hkDMdTSYrl07k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eO0i+Qqg; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGgFRa/yO62l1j11ZvtSA977fsurE+67qPAG7zGCpx3PKAQQPu2vH9MDhUz5dMB7wfdQh6bw3x1VJOpmVIpvLGHPdGBVJkEm6EbGIzZTGE+x+vJ+axQTNypECEculAwQSJ08AVBltzR+2xcUJ7OnVwIT55zZrYf3l5SCL1yolymIMNGsCsIVVYUMIwzUloCXKyE8t8J6CUw1egWMRq3U4Ca4i8zAqZB8Bsw2/7gUsVvFFagCiflzJ6GYDzX3BCdUn8KP7DmdMM+A/CvvlEcQJWqKJv2ygKFykzPu1d3sNFVCt/Uwoz/acZ4A8rRYvl1KpcHHL+SgM3ZYRRxtWApsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZpVGhxUqKsw5ae2nfZGIdmBElV9ZiVBff5oYJnU5X4=;
 b=O3woC8eNmTq252fDx7SMeeIKSuSY/XHlsacNWspbxkRAzpY5AIZ+LtKkV80k01z8Wtn4kmN4ikvv9XmBkhFy9ajIxPWGpMCWb660kBe3BNKfvJnSaulUs8cFBgT3yXf3U+3NoRbWjFeRMrHcvRIT4d0363014Zg17iBV6yKdTOYn48mRfkzqeRdlY3EEvAgqRSrsA9Hsni6oRas0JLJ9wdX6/ElObZEEZDCSIBmoflOvjMZ/Z7vZpHV3HpPJFMG1lqRyU4zmwL7U8n69Xzn8LtUG/0fB6MsT1CopSDrV3CE1XxidyJh+nB4bojjImSHsSYHTKr+20N5uKMMYd9POIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZpVGhxUqKsw5ae2nfZGIdmBElV9ZiVBff5oYJnU5X4=;
 b=eO0i+Qqgx7MjeI6KkslYeImdvhfqRORanMfBfuvsGEnGDr5xiWPMmiVEp0IHq9++clcEooZUH/DH2qBqOOE35/2im2j1CCgXx9I2JwxObpWHgxImxRevNbJ+MPjrNKzGClbM87LH7LWFB1luGBDeTWpRfukKRUbHwh0AX6f1jUk=
Received: from CH0PR03CA0292.namprd03.prod.outlook.com (2603:10b6:610:e6::27)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Thu, 7 Nov
 2024 06:03:27 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::d3) by CH0PR03CA0292.outlook.office365.com
 (2603:10b6:610:e6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:27 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:25 -0600
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
Subject: [PATCH v5 01/20] ACPI: platform-profile: Add a name member to handlers
Date: Thu, 7 Nov 2024 00:02:35 -0600
Message-ID: <20241107060254.17615-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107060254.17615-1-mario.limonciello@amd.com>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: a431c8ed-32b5-4e98-7495-08dcfef1e5c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFpTczlISy9LUXV3Y0NkR3lxdy8yODZmKzVJb3hoaHFnSjRQZVJhQXFKdldY?=
 =?utf-8?B?YTRUbWt3Q1MrU08vVE9vbFhDZGFKd2F2b2F5Y214alZaNVF3VDVuL2tzbzVx?=
 =?utf-8?B?c3NNanV3dVZPSDJ3bVZpeDRxWGZBTlAvSjR4NVprOUdOUWVIOU10c3pNZU5z?=
 =?utf-8?B?TXZBR0RVdHBLU1B5aHVLNzVpY21pc1k1anpuT3B0ZHVPYlNBSUdPNnROc2Q1?=
 =?utf-8?B?Z1NtdFZ0VUhKZnZGbnBBRXZleGJueGx0N3hGZUh3a2hHbnd0R0pIblBkcVpx?=
 =?utf-8?B?bjlvdEY0S2pqaDdMOTloZnFPVjdYMzBXczJ0NzQ1Z0JyeXRwdzl0RFRESmQv?=
 =?utf-8?B?Y3dlM1MvcmFVeStRWVRlNnhYZElxTE4wUVFySTJrbE54MkdZY0JvNHZxUFBV?=
 =?utf-8?B?Y2xhb29MZE1UblF2SDNHK1FlUmZrZHQwZUtNUGVZRHpGeGgxN2YrY2ZLbEdr?=
 =?utf-8?B?YkJjZlZzSUdCSU9QZU85aW5QR0hBbXcrY0dlZG4vc0UzM1h0RE9OdllPNm9w?=
 =?utf-8?B?cmJBZ2ZhME9ScDdBQkNDR00rbWNtVGs1N2JHZUxFR2x3dGVnL2dOUktPc2lL?=
 =?utf-8?B?QVc3WDZ4MDFwcVZOcGkrK2VkSDlmbVA1aFBYMEJiOWlBT2FYVFlCb1lOVGp6?=
 =?utf-8?B?Ynp5NVBIZmdoQXdJR1JwTFM3TUtQZS9FdEQ3RlU1eDFSZU5GNFpPT0prVFFn?=
 =?utf-8?B?MXNzRVdXZmkzTlNWN0FCc0tIa1NEckYzeGU3UWxmcnVxOHRESmVqcDJWTm4y?=
 =?utf-8?B?Ri8wNVV6dkZpR25SRldYcW52OUJiU3lRZjVEeTFERGZpcmJ1dDNKdG9MaHVr?=
 =?utf-8?B?cUtEQU56dWU3SzFyQ3dUeFQzTGcrMzgyMERWUjVhVUJGRkpvaHVzeGdtSWts?=
 =?utf-8?B?Z2MvbGg1c1VNNDVHK3U2a1R5bVZQWGJmc0RPeWZzdzljM1Z2bSt5QTdUZ2x4?=
 =?utf-8?B?K21meVBxeHRoVnhVQjBQT2NZRHY4dlNqOTk0V3RzRFo4ZDRoRFBLaW9ob3p0?=
 =?utf-8?B?bHBvOTg1NXhpVUQ0d1hDdHJMUHRuZkhqRDhUR3FHWEdvQVlHU010YTZzVExI?=
 =?utf-8?B?RUFja3hYNnRWOTR1ZEFTTzFESWF1R3FVMkpNUGl4U1UvKzlHQlkzM3U4Mjha?=
 =?utf-8?B?alVaQ09JNVFKczBBRkF5aGUwd1d0UmtxTyt0YlVMZWZrdkdtTjVENnBxRE9z?=
 =?utf-8?B?V24rcHZKQUtQY3dsMkRWY3VtR3ViSFJNbmFpVitmek9McjZLSzJoTlIzNkM1?=
 =?utf-8?B?NlBFbGhGdDQzNXJkdGQ3c01lZWZwZW9yelQ4QU9pNFJCUXJxMHlIcFdjVjBh?=
 =?utf-8?B?T2ZsT3FKQW4zWHJWemgvTWpjL1VNY0J5Q1gvSXFBTmFEQ1lZaEEvdU53Wjlk?=
 =?utf-8?B?ZlhSY05WbFEyQktNenhVVXdObWp4d2l2ZE1jYWM5b3dVNG1ITEhmTUZQTlJN?=
 =?utf-8?B?bjkwWkxjM3p2elIvVkN0UGpzckVOc01mSWsza0RCZVhWMURqVUdCSDhyalI3?=
 =?utf-8?B?Rm1LRm5iRkd1U1JKUWdaZWZjOHpQZGNoOVp4ZFUrUlVIMEduNStKSFN3T3NY?=
 =?utf-8?B?TVdIL3RpOHU3eG9NMWsxV2dNbVZNSkdqVXNBOHErWnl2NkZmUFhxYUhmcHYx?=
 =?utf-8?B?TnBBd09oK3BESlNHWG9sM0VqcVFsRDRsYjJsRlFaOHd0ZGM0a3NyRHlNQjUz?=
 =?utf-8?B?S0Vsa2E0Sk9BaGUyZ09hNDhUSGo1MUJqWWxEcG1Rckxka0kvSldUU2xxeVFU?=
 =?utf-8?B?eGhHUEp3OVNNVnNNeTZadjlNKzIrYVZGdUhsOEdvNDNQLzVIY3RleDU4eDBW?=
 =?utf-8?B?anJkdkkxVDJFb01weE4za3UvNW1TNmZ4S25hZm9DVlJ1L0h0bHJ6Mm5JaFQ2?=
 =?utf-8?B?WTJMMXN4UHpoUW4rejh0dVpWQnJTU1hWK0RZWWRlUDlkYmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:27.4417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a431c8ed-32b5-4e98-7495-08dcfef1e5c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776

In order to prepare for allowing multiple handlers, introduce
a name field that can be used to distinguish between different
handlers.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * pick up tag
---
 drivers/platform/surface/surface_platform_profile.c | 1 +
 drivers/platform/x86/acer-wmi.c                     | 1 +
 drivers/platform/x86/amd/pmf/sps.c                  | 1 +
 drivers/platform/x86/asus-wmi.c                     | 1 +
 drivers/platform/x86/dell/alienware-wmi.c           | 1 +
 drivers/platform/x86/dell/dell-pc.c                 | 1 +
 drivers/platform/x86/hp/hp-wmi.c                    | 1 +
 drivers/platform/x86/ideapad-laptop.c               | 1 +
 drivers/platform/x86/inspur_platform_profile.c      | 1 +
 drivers/platform/x86/thinkpad_acpi.c                | 1 +
 include/linux/platform_profile.h                    | 1 +
 11 files changed, 11 insertions(+)

diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 3de864bc66108..61aa488a80eb5 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -211,6 +211,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 	tpd->sdev = sdev;
 
+	tpd->handler.name = "Surface Platform Profile";
 	tpd->handler.profile_get = ssam_platform_profile_get;
 	tpd->handler.profile_set = ssam_platform_profile_set;
 
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index d09baa3d3d902..53fbc9b4d3df7 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1878,6 +1878,7 @@ static int acer_platform_profile_setup(void)
 	if (quirks->predator_v4) {
 		int err;
 
+		platform_profile_handler.name = "acer-wmi";
 		platform_profile_handler.profile_get =
 			acer_predator_v4_platform_profile_get;
 		platform_profile_handler.profile_set =
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 92f7fb22277dc..e2d0cc92c4396 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -405,6 +405,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 		amd_pmf_set_sps_power_limits(dev);
 	}
 
+	dev->pprof.name = "amd-pmf";
 	dev->pprof.profile_get = amd_pmf_profile_get;
 	dev->pprof.profile_set = amd_pmf_profile_set;
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 2ccc23b259d3e..c7c104c65a85a 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3910,6 +3910,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
 
+	asus->platform_profile_handler.name = "asus-wmi";
 	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
 	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
 
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index a800c28bb4d51..ac0038afd98fa 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1056,6 +1056,7 @@ static int create_thermal_profile(void)
 
 	pp_handler.profile_get = thermal_profile_get;
 	pp_handler.profile_set = thermal_profile_set;
+	pp_handler.name = "alienware-wmi";
 
 	return platform_profile_register(&pp_handler);
 }
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 972385ca1990b..3cf79e55e3129 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -247,6 +247,7 @@ static int thermal_init(void)
 	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
 	if (!thermal_handler)
 		return -ENOMEM;
+	thermal_handler->name = "dell-pc";
 	thermal_handler->profile_get = thermal_platform_profile_get;
 	thermal_handler->profile_set = thermal_platform_profile_set;
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 81ccc96ffe40a..26cac73caf2b9 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1624,6 +1624,7 @@ static int thermal_profile_setup(void)
 		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
 	}
 
+	platform_profile_handler.name = "hp-wmi";
 	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
 
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 9d8c3f064050e..1f94c14c3b832 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1102,6 +1102,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 
 	mutex_init(&priv->dytc->mutex);
 
+	priv->dytc->pprof.name = "ideapad-laptop";
 	priv->dytc->priv = priv;
 	priv->dytc->pprof.profile_get = dytc_profile_get;
 	priv->dytc->pprof.profile_set = dytc_profile_set;
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 8440defa67886..03da2c8cf6789 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -177,6 +177,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	priv->wdev = wdev;
 	dev_set_drvdata(&wdev->dev, priv);
 
+	priv->handler.name = "inspur-wmi";
 	priv->handler.profile_get = inspur_platform_profile_get;
 	priv->handler.profile_set = inspur_platform_profile_set;
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 4c1b0553f8720..c8c316b8507a5 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10549,6 +10549,7 @@ static void dytc_profile_refresh(void)
 }
 
 static struct platform_profile_handler dytc_profile = {
+	.name = "thinkpad-acpi",
 	.profile_get = dytc_profile_get,
 	.profile_set = dytc_profile_set,
 };
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index f5492ed413f36..6fa988e417428 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -27,6 +27,7 @@ enum platform_profile_option {
 };
 
 struct platform_profile_handler {
+	const char *name;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int (*profile_get)(struct platform_profile_handler *pprof,
 				enum platform_profile_option *profile);
-- 
2.43.0


