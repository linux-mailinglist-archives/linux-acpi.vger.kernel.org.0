Return-Path: <linux-acpi+bounces-9298-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DCD9BD06D
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349102837D9
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B5913AA3E;
	Tue,  5 Nov 2024 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lCx5F5P0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543DA126C03;
	Tue,  5 Nov 2024 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820818; cv=fail; b=ueEJL53d7aYXVThGWSneNc/KoJ6JNCZTBxv/kq2fHtSFKbG0BLMakcE3bL72JqWEk56Q3qBB6kyLIhB0BcDaU0ywMEKJMBs4eBPwMYRlDsmw7bVtqy+JezFLESXE6e1+lT3oYXkoKZTvC+Wl3edQ3R8tu8T06kcIfo5a2NotdBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820818; c=relaxed/simple;
	bh=7AooLGyysGXoohZPXELnGeYztEfM8k/ZcIos1h3C2wg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwaztROY6FxIjsXCo2tvnj5GnCOfvYZEWu/EmHDEEUKqCislgxVcB0hRcx4S5e38+LJMWFueb9swYsPolY8sWiD3JsJLExhF9dP/wgtAkKNtUhvADj0u7bMPfvCjHj7yYyrgGsKvYgdeSc11SzT0CZAUU5WcJYWj8vkVolKWMgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lCx5F5P0; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7tTD0CG3LdBv2pVlsI5hqDLRWY1inwV30s5fsYib9hgDRSAXtch8NDbsAem/Q1ruYSrm3Q9o4v4m1E0QBF+XwUe+57wq9QEnjvWJjXO+RpTK3gIH2nhiEq6IpbNR6RygmN8ojwLPEPMvI4G2hTmAQF4gXc9deWWPUzQ2jz7CoAM2mdr8nrbf36Pan8w3m/a2lGbkyBel+XNnLnvD9jK6gvXR7W7ccV7nIr2FRtELBgq7jnBeE+s4Hog2vsu5A6E5ZdTSEd3G/2IMu7GzcqiG9Jm8olG0fMl2TLFfTZERCEX93rG/HnZbcEBz3E26wa+cllUf+M4GJ6yE0wtXOFQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDdDjN4psyY/0raDk4s+w7ZhQvmNm24C4BYgq9B0YJY=;
 b=f5ehrSeGCvxTlKZEX2YH//oFXOymgYYztM7pJTuwqrNiSLB0HrcaIj3MDi/0eEmKHGWScnXE8Bchn5G6375NW5BQOmsLv8KKFygjPrhK2slfHBuwqX7uUM+6W71WwJRpuv6+K72OE0+1cXfs2AaH+VlIUqXbAu0uT4i3yFCgXQwO7uozIt9aLk+ZyKDxOrhj6JoHsqV+dpe91pdZaLngyNjEUpditecL72KU+xGlTkVsAg0kAoDI0StwXzps7Jy3aYZty8G9FaA/ltwg4ngFARVXVDz9Vof6jD4hyJ+SQFXQXHlencS1SMxVDca3xr5lyMzVoulisXNOM5Vh4RYBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDdDjN4psyY/0raDk4s+w7ZhQvmNm24C4BYgq9B0YJY=;
 b=lCx5F5P0F2+Du/c3/sTHp4CxmWuyzR+gM1BFumEToUbeGX9zQ0f2A8aLvO1mbllIMriMq/tJIaxcSjtLTOIH11x/wHvsVxaiFthupf1ncgZcvCmzKoMMSdlWXXJKH0mWY1b49I0bgROzhP3umDiVv883AZK9gEVmPEssHPDiRuw=
Received: from MN0PR04CA0001.namprd04.prod.outlook.com (2603:10b6:208:52d::35)
 by SJ2PR12MB9189.namprd12.prod.outlook.com (2603:10b6:a03:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 15:33:33 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::a1) by MN0PR04CA0001.outlook.office365.com
 (2603:10b6:208:52d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:31 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:29 -0600
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
Subject: [PATCH v4 01/20] ACPI: platform-profile: Add a name member to handlers
Date: Tue, 5 Nov 2024 09:32:57 -0600
Message-ID: <20241105153316.378-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105153316.378-1-mario.limonciello@amd.com>
References: <20241105153316.378-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SJ2PR12MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c99e3f-bb23-45fe-d426-08dcfdaf3425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE8zM1owRjQ0dzRDWFVINkpnT3lNa2JIbmhZdmJOMGNFT2N4QmlXc21SWXRG?=
 =?utf-8?B?aUZPYUJ3MVdabmFsNDlQNUpIb0NUTi82ZUZpMjFEWWRSSFRIb01OaHJ3V3RV?=
 =?utf-8?B?ajBWeWtXbHdkbkgrLzc5S2tEYXNDdnQ2eXo5dWc0bTByNHF6bURYN1lpcTcv?=
 =?utf-8?B?MGdpRThGbG9hVWZUaGJPSFN4Zk9pUERzcGJPNjVwWHc2cStSd04waWNEYzVs?=
 =?utf-8?B?cWhKUnN2ZDJGU2toOUFTaWhMclFvcWtuUmd5ZUxwT01raHc5cGlmajRkOHg1?=
 =?utf-8?B?eWlIa1RuR01nWVRkU0s1TDUraDBBVCtJbmlxYy9OaHExRzhXQTgrUTJ0TG1k?=
 =?utf-8?B?aFd3NXhlSGRUajRMZUE3VGlqOWVQTWdNZGp4RVgrcnNWZHdqUXloM3B1MkVQ?=
 =?utf-8?B?VWFVb2xWQjJKSGNsTi85cW5vSnBQamJ5Rmt1ZFF1eENjMnpoT0Z6TnpjOE1y?=
 =?utf-8?B?aWZRZTJKblY1M2FpVW5yNVgrUzBYUVRNd3RxVjhYQVlpS3VFRUtnVzVYVWw5?=
 =?utf-8?B?VCtHb3NMODhqUDdzMEJWdUhKSzBESDRyMHdTSkh3dlNxUVVSaDcxSUgySVFH?=
 =?utf-8?B?YzNXeWJvMnpKQ2w5Z3RYbW1lL1lENHRMQStuZ1hkQWJqNTZKaHpkLzFmdXBP?=
 =?utf-8?B?bkRqVHNmU3kvVnd4bDVHSFZOVGQwWTBvSjY5aVhIOXIzdWJUd3h1d1NCb0I3?=
 =?utf-8?B?TXZLRVlOWGg3MU5xSW9GRitiMzI0MWtQK1ZQMmdqYjdtV2ZzdVJUc2dXODNG?=
 =?utf-8?B?M0twcGJTYkswNVlVYWxZYXI0azRac2JFdlcxVHdMa1l5UVU4cU1Nc2l3TzZm?=
 =?utf-8?B?OGFQVUx1Nm44L0Fid0oxaEN5SkVLNkhhaXFoNktLWWVTRFcxVjRWcGlBQ3FH?=
 =?utf-8?B?RXIrcE9mOThPdHVWSDBzVXlYN1YzY2RPdXpuaFhJb3lnbnM1aGFsOFlCL2p0?=
 =?utf-8?B?Q25LL2QxSWVlYzBsQmZlWW5kbFVlUlVMZ2I0bWU0SHNlYUxOdXp5RnlCblZu?=
 =?utf-8?B?TmIyZXRKOVFsZVlCdWROTkdnaWJYODZ3SFZCMTBOcnAyS3Ftd0JkOXlidkNK?=
 =?utf-8?B?Q0dZTkNnOXMvTnlBcmFNZDZZeVdKeGJKZlJDUGJXenlMaG5VOHVnTi8wTGFT?=
 =?utf-8?B?QzYwOC9pNGgyZFBlbTZTOEE3M1BBV1NBYnJUeXpUR0VqZnd2WXNvV3lBWGZR?=
 =?utf-8?B?R0FybEROM09OTlVFdTFrQTZqV2RMV2ZFSE9Qb1JHemxYV0dzd2hSYmQ4TG85?=
 =?utf-8?B?TU9KZEljUEhJbXd0elBRcHY3VFVvek81bnlyWUdKcWkvaUxDWEUxdmpnR1lB?=
 =?utf-8?B?NW04QytOaWpVdVJIRENuZjR1K0JNNEQrTEpvdEs2WHR2d05RSjMwQm9BQ29a?=
 =?utf-8?B?WVN5eXhNVmVVekJabEtCbVFuemttc0t5VldXdEtDZVNJN1J1Vk1BRGZIQlZV?=
 =?utf-8?B?REhwYitoaHYwbmY0bEpreEczcHQ1eUpLUGs2bHY0dUkvd2tQTmxKb2lOMjBN?=
 =?utf-8?B?bEdONUZQM0NxNlZLNEdoWW92RHJ5dzlITmIyTk02YVNpdzN2cm1TUkVOdzRF?=
 =?utf-8?B?SmRTaUxhR3dJV29oblc5NnFmTG84c1Z4RTd6WWU3b3phME1hWkNTVGYvNkdX?=
 =?utf-8?B?QnB1cGJrWXkyaklScGwrc0tmZThWZjFPOSt0em55UTBGNldiS0pLSEk1cEs4?=
 =?utf-8?B?anNxci9yVC9JUFRGelBmeU5KWDNiTkYrWUM5S3ppVnRFSHdPVWUyUEpUbzhm?=
 =?utf-8?B?VVBodk53cTVpeGQwcnllTnB2RXZxYkxTS3hodjVZYlEvTkR1K0pHTWR5VGkv?=
 =?utf-8?B?RXYxcFUvY0VNSWVpQm1mV21QRTlCTXdBYnYzQUd4aDRUV25NbkF1SXNBVHVR?=
 =?utf-8?B?QjcySVFURUNPMG92Tm0rWUhtYWlzZFFwUnRuNDNPUEVaalE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:31.5141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c99e3f-bb23-45fe-d426-08dcfdaf3425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189

In order to prepare for allowing multiple handlers, introduce
a name field that can be used to distinguish between different
handlers.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4:
 * add alienware-wmi too
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


