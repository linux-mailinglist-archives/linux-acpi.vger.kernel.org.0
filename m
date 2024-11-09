Return-Path: <linux-acpi+bounces-9458-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC12A9C29D8
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495E61F22A55
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B66813AA35;
	Sat,  9 Nov 2024 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E0XsaV8c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442611E505;
	Sat,  9 Nov 2024 04:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127344; cv=fail; b=pLlEx5jniFInUeajF9BlGeeTcgDgO+rj3HtTtMRfPMA7Lh4rHp1is/4Ag7iYFoQD/DJoqU/3CfuBb31+M8rpA1HWs3ucMjRF9dMDKiwJ1vAHojBATgzb0VWF1LgYTv+UuU+trYQ51KB8JnSk7/WhdBrmER2w2o6lfgWnVFpfmiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127344; c=relaxed/simple;
	bh=AYvJHrr1DuzvBxnCLI2rzsMN92SzriWbCF0hjGw1VGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feIkFxpaHPo7VEMa5/NjswQCa95oTQN7OdYUksYiEUvYmyzSTUQpl9cI6mxnpyuyXLvcSp/Q7G+tnKOZg5TYXzHkdeTdgjiNT3Qp0PPKiMgcmoXjX/Yyfhk+pYr0GWZz+qHvySOcrlymdqVT5g3A3MaRfatea/y1vBwIU9mbXIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E0XsaV8c; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVFdsPw5NWnRC5+AZLUY/rgzegqjypMVHdcxP5OX2157v6st3ngqBcHXWE3e4jmRko1PUNyAHqE80VvppqenEuP2ftoTo6k/RNVGhj9UGPKghD2gTAeBYXhiFxuko+OEsN8tUJ5FmZQ+zd+TnOw7PheXdyEPE5UAsG69dk+4dZl6Sg70NUN8OEGTyYFXgtSACeLISVMo72jUR6q9Gdb/fX35Rfi+2lJtQWK8pHCRJ9i35a0HXxPM5b7j2JV10VQh+0fAaCmiLWiLj9NrfrJjw200YpbkNVofoVXt2L9FSqEFQigdI9jMFdbOv2c8F2LDayJXTny8wflxoYgxe9OMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wny8nbFzMuwNBi9IwJhOKNvnnz1x4iA/E1KTavC0zNo=;
 b=pd1IsmROQZmSdpEvsEECfLw7xjyfL64aA/IftHR1HI9suuVN7yn8hALcrZVe8FQW4Dse41bW8yQd1NLFMI2nIuu0cVJfWSsVk7BIDt685kZFyGoNgfIEqLEHKfZoyV7gHCgPItaAo867rIPB8LJ5SDfDb3Bs0Gol9EdCjgAg07W+Epsa0gMWH83sJdG9ehEa3kLESCWv4JYjHQhd2hCVE3WhUff9QBQt5WJQKFN8ws7VOqaz7AhUdY0HCuGIY2ADXMZjJmz575ulObXXxBNdxh+Kaa5XKoM6I05uJZkK7dzGWR/KyN+FheZyMilspq8wZzrIOdMi7B9p1jh0DkU6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wny8nbFzMuwNBi9IwJhOKNvnnz1x4iA/E1KTavC0zNo=;
 b=E0XsaV8c8Qg3AL0fDSVHwxXIhZW5u3ISPMiE6k4vrOg08D/ZAGl2VrL7AXQA98xm247mj7Ijtx4v9IoMukK03guAoN33mfYKQ/v00LwHgNUlVaba2eBz68LUv3KlHcySbtK6yWXIub6HF12eoyqqPcPuePAuE5ZP3lruiHWTP6w=
Received: from SN6PR04CA0085.namprd04.prod.outlook.com (2603:10b6:805:f2::26)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Sat, 9 Nov
 2024 04:42:19 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::5d) by SN6PR04CA0085.outlook.office365.com
 (2603:10b6:805:f2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:19 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:17 -0600
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
Subject: [PATCH v6 01/22] ACPI: platform-profile: Add a name member to handlers
Date: Fri, 8 Nov 2024 22:41:30 -0600
Message-ID: <20241109044151.29804-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109044151.29804-1-mario.limonciello@amd.com>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a4f915-34dc-41a1-b7f0-08dd0078e510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlJlLzJESzluZTJHK3ozdE5DOEMwTUM4eGdmbjB1YVhYd1J5eUpac203Wjhk?=
 =?utf-8?B?cVFvZE1WZjM5TUxRSUE4ZlRFZ0dFOW9EQXR0UW12OGgwNDhMZEZsZVhJTndW?=
 =?utf-8?B?REFYQ0RTSlBhcG44YXBpYmRpcUZwSVJyb2x3K3FZaFBYcXRlY3hLQkxJcjNi?=
 =?utf-8?B?VWNNdGhSVHNJd2l4dlJJZlBseGNNVUVwWWZKazh1VUF2RkdLQjFZQW85SjVE?=
 =?utf-8?B?Rng1RXZOK1VsMkdyMzBtTXlMdWFJK1gwSm1kYnowVVo5NGt0TWNUUFRzeGFX?=
 =?utf-8?B?V2RhbXVkQlZuak4ybUVoRG5PUGZaeEZEcE9WeW10WUlOWTFHbC9FaytuUEIz?=
 =?utf-8?B?cW44VitTaXNuTWQ5L0Y1d0grY2s0WGJwV3UvMjFPU1E3L25HSjNETjN5N21P?=
 =?utf-8?B?T1Z2c0prRjR6QUxRK1pMK0ZLV1hlYTdacjAvdmtPRWxIS0gyMzFnMUhXUHV6?=
 =?utf-8?B?NDdqOTNVYklxcjZIdU4xTS9WOXBiSHl2WVVGd0dBbTFsa3VFM1JFOENVYzF3?=
 =?utf-8?B?Y3p6Tk95VFNCZU9WR3RGYWphY25sMmM5aUNUc2RmbTk2SVVONUNxTTNlUVdz?=
 =?utf-8?B?L1Y0aXlTRWFrb3J5YWprdi9hdDZBVTFEWDZJbU5JWTdyMG9aS3JPeHREU2ly?=
 =?utf-8?B?NUR3TEcxZUFrc2xEVkEySWtIRU1mc2tQQlBuamVSQkN0V1k5cjZNa09EdUJp?=
 =?utf-8?B?YktFWWhVU1phS2FIbVFiOThWd042emkySkY0bEVINHAzcTlZUU5ZcEhVU3Az?=
 =?utf-8?B?NjY0aFpRZTFuSmo3eFFkWmdSUDNsYWFmQ3JSMmhJU1g0bzNJNWFRV3FhaU1F?=
 =?utf-8?B?SVRWWFZCZkUzdEtQZVlWM1NreTVXeWppbEd6dVBBdXl3elNDZTFzaEw4dlFB?=
 =?utf-8?B?SjRmd09KOXZhTkIxK0ZZMzZScmNieDZzdHNWSDZHRnVQV3M3Q3JzR29QSEJn?=
 =?utf-8?B?S0N0UlpFREduY1J6a3NQVnR4SitrcFRtY0JkSXpaM0hWRU9pSEg4cnVNaGIx?=
 =?utf-8?B?ODk1bVFwaEE3QmJlSVF6S29MMXRYcmo3aVJiNXNXSnZiaUZnLzZqM3c5a0NZ?=
 =?utf-8?B?Vyt1bk52SXNEajljSitHUEdkOXdGc1BCWHFWR25GSXNPbUZWV1NRS2tYY1RM?=
 =?utf-8?B?NzFHcmhlbElMMU00Zk82bDAzYnhHT1JJcUlVUHA1Z2x5YkIxVDV4V2I4K2xk?=
 =?utf-8?B?dnB2YXhDczQzZjRzMzk3SDNXMEVYZDJicndGenV1T1hxU09xemJOTXlQMVF6?=
 =?utf-8?B?T2x1bU9LZ1FRNG05TUdSeUFIWUdid0xNNHU2UGp2R3l5Z3hJaUpkdWt6Tm1N?=
 =?utf-8?B?MWxsUE9oc1NvWmlPbUMzeWF2VDVXOVJVakc3a2lzcS9HM0ovTFAxeGtxeFgw?=
 =?utf-8?B?U3FoYWo3WjYyNXZZSWpWUjBOUVdZblh0RzNURTlXT0xtVDVaY1E0eFU0WE9a?=
 =?utf-8?B?Z1VjbGhCOCtDQ0krVjh6aGZLU0JWQW5tRjZua09USFp1MWgvd0dXUUgzRnMx?=
 =?utf-8?B?bXNzd3JmeGFpRlkxUFh4dEZTcmFEWnZzQ1hOellQd2ZBWkFwa1YyRStRQVdz?=
 =?utf-8?B?SldNOEg2MzZSd0tlRnlPdUNlWmZITi91RW1WMWlTWTlTbW5NWkVzVnJHRVZw?=
 =?utf-8?B?VjVSYStObDRGQ2U4VnZSL0NsWmdIVGpLeExBQWNZQkpTcGhVWmJPS1FxM0tv?=
 =?utf-8?B?RXNNMG5wdXZVQm50K3JqZFc4ajRRWUxlUVlvRmVRQmNXRkN5SkxRVTVvNlVG?=
 =?utf-8?B?ZDg4U2RYRmxyK2dZN08vZWJISGF0Y0orMnlhMnJXWVlGZEJsdzNIT2xobFpP?=
 =?utf-8?B?dXEvbC9TRUdVbU5FbGxBNFA0SFlNbzZtdG5EUmtIVGxJQklWdFRaT052UTEx?=
 =?utf-8?B?NVZMS3ZpNk5GYUJuUWYzTzZXM0dUZmtzZUhwWmdyZlFKb3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:19.4694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a4f915-34dc-41a1-b7f0-08dd0078e510
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773

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

base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2
-- 
2.43.0


