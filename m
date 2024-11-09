Return-Path: <linux-acpi+bounces-9460-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA459C29DD
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06CE1F2286B
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C556813D503;
	Sat,  9 Nov 2024 04:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gxhR+9EE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8F13B58F;
	Sat,  9 Nov 2024 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127347; cv=fail; b=OU4vPXbF1t/c/6KK3k09O90QY8WmAwrdSqCBSjgWg8awSfYWQgSPFIlQcJqwvcKkTXaESf3kjwHKBW8P2JkG+W8kO2SRRExaFzsddIcRkH28eBBPWfZEd35jygA5/c/5fGp1V5SndsPRTL8J8EgjxenpDk3JmpqT6q91t7Soa74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127347; c=relaxed/simple;
	bh=gVOFZQ1NkY8btPf86/D8ZFqsha0+GCMWANbhEBwFGl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqjMfeAbJtiEof8fKWdwN7Li8BiT97OKO/E4P0bntBjOt5Es4Bt2lYGF3AOMfLPefdiDTOUWZ/xQ3exu9QkZEKNLjlSJKz8o+WG9gjwQoI25mnaV3fxgvW7d9fhjevAeYb/upJSAnXo11Y9AWP+OcTYeXdF2SEbIU++Ny87Q6uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gxhR+9EE; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msLyqs/qwJ+t67xCTooBZTO0i1Dj2mNUtFhCphlhcpymURlyCg/5NGdf/cjpQygMoV69hZv6o7B74eAd2J5QzQ1U4izZa+JrBq1q3ajM/vDpY6SLvYVvhODstAujfaTf1m/h7lgW9y2kaXcDfls4gNKqueLvI4sHU9kHot0iO45Y0FtaSvoC85tDdN80aPAB1PdOQad0uMPCqDSEwp38Q+nB93Ua5L7VvM2TlXI8rEe7GiV+IdQMQud3rP2VPOVjVpOh3Y0GmX29WxoMLGnoA06n+rVzXcpM9cNobuG22CyXX6Mj/MnkXm3uj+sv/Z6PXnsuLls0fUz3UkYxnPzw9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rcake+aW7InzlrriCA9veWw0Iv9E+pdMZvM9w0hzudg=;
 b=Kjn8nX075WczG/ajkATFpyA2YrfBC/rgVYgf7/8auehgG196cnsfqlR6CotHTeJNS1RUTdnjulFG3ZBVJ6+BnXuve7/KW8YJ1DvK+MdHDsiKBJregOk7rjfnbdKR4lSNQCLNnbBcaEmxjO1z7ctpP7pXVUiLHVcgr6HyTs9JJmkd9n2De4mbhxYUw2cChZxCKKxvVOBNwb4/x2JEeuA1ztWi+ch0ZV1H7K8NoHeJ4orc9JwIM9GrPXIJRiNPTb8phk9R9xWqF6FKaX9yVt12jwSasp0ikcL4PfwVrdDfGCtuXsGG9hWKEY+yJ0dbQeXvXMoD/kCQVqpOqTSnteAnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rcake+aW7InzlrriCA9veWw0Iv9E+pdMZvM9w0hzudg=;
 b=gxhR+9EE/24lXBODQeRVvoRJHYhjNi1iwY3YtQq89qmH/hh2VvQ6npfUKlKnL3SzjWVvs+VNeEd6tJi86CxlL8WmTbXVBzCDP2njjrR9ngpbPpzMcD5qXv1rcCZfGTtMpQuDldrds7GyjNObmqGJj5REehwM1sGb74RwD9FnU4E=
Received: from SN6PR04CA0079.namprd04.prod.outlook.com (2603:10b6:805:f2::20)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Sat, 9 Nov
 2024 04:42:21 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::ea) by SN6PR04CA0079.outlook.office365.com
 (2603:10b6:805:f2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:19 -0600
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
Subject: [PATCH v6 02/22] platform/x86/dell: dell-pc: Create platform device
Date: Fri, 8 Nov 2024 22:41:31 -0600
Message-ID: <20241109044151.29804-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a8936d-63ad-4755-721b-08dd0078e60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG9iZUxrdDh6bWRFSDhqdytEVVc5bU9PT2tGbUI5Qmg3UmFEQjZPWFRTbzZZ?=
 =?utf-8?B?UWs0WmR2djllQkdHZ005UXJzYWFKWXlpNHphRmZFSXFHeGQ4MG9CZHYvc2wr?=
 =?utf-8?B?QzlEbW1abHBNd2pJdGJvb2NOWjVRdGdiQWNud1cyS2k5aEFrbzh2dTZ3a2R5?=
 =?utf-8?B?YWV6WDBEcmV5QndQckIvZlQ2cS9NTlpvcUN4SzZENE1vKzZtckhBQlJrRHhV?=
 =?utf-8?B?Ryt0TE9HcWlqRjNyb2xvVEw4ZUJUQ3J5QmZFQVJxbzkvV3VXTWVteWQ3OGR3?=
 =?utf-8?B?OUJHZDk5K0phNFIxbUlNZGJaTXlwM3Z1V2taNVd0VXk5RHNGL1hJemJyNHZI?=
 =?utf-8?B?Y1IwYndBK2NaUW1CTlVYbm5DcGV5REJZcHZBOUFRUThKcVlwR1pqMGxTdVVp?=
 =?utf-8?B?bWhrUnhkVkZxbkVGQm5YalhNWFJIejZxbldqVDFCcUtQVWhjZURtQ3d5bjh5?=
 =?utf-8?B?MWJDdHlvNytWQjNGTnFHbm8zUHg4cDc1ckFZQk81SmxSY2pxSkVjU213ZnNS?=
 =?utf-8?B?YmNMa2kwaFJJamFIaVhlbWJNVTFXbGUxU2JRNzRZdUQ4aElhYlBFcXV4UWNz?=
 =?utf-8?B?ZjZ5ZjJ2U0VDaitsYk5PS0FJRW10VDc5dHYzeERsWm15aHJHZ0NEUndUMkEw?=
 =?utf-8?B?S1p2SW1MSVhGQlNjSlpUSGZMQXZMNGpURm5rUUYxWTVHV1V4eko1WmIxVWdP?=
 =?utf-8?B?VjFFTVM2MFlvaDdTSkNyN2xJR3Q3VG8zcUdxSnZuelF5UmdKcVAzMEhQK3FB?=
 =?utf-8?B?RjgxZFNwYURZNHVGczdaeDZJVjlCRmNLYlBJZE8yYlVhSkJBSEJVUmI5eG5O?=
 =?utf-8?B?di85TmhxMVVoQ0tpY2hQd1NaMWdkZzNxejdaVk1nNDNidHAva1FpVnBXdHpK?=
 =?utf-8?B?aC80RHdCS1RRemYzSkRkc2hsYzVhUDhDaEtDdmFOaVUxZWRVWmdYSlo1Z29m?=
 =?utf-8?B?aENOOHhpTk1vYnNXdDVzRmlpY1NlRWE5OXJFM05PNEJQYkpBUTRxaUtmRkIr?=
 =?utf-8?B?KzlYY3BQYUUwUlhrR2MyQ01JZ1BLRFZXSlQzeVBOU3dvUmJFTWtjVW1UanF2?=
 =?utf-8?B?UVVaOVl5aDZ6MnVSQjJ4YTkycU5hMTd0SHVGa1l5YXdnUEM2RXJUSTVrK0lG?=
 =?utf-8?B?ZzlYaEgyL1Fwd3hINmR5ZnhJSG4vUko0M09CRytsQ1B4NEM1SlA4cHZTNUsv?=
 =?utf-8?B?VHcyUFdWTWlLc1F4M1NHUHpVUUdzT1JJR1hFR29kbnVON2gyTkkxMGZVSHE3?=
 =?utf-8?B?L294OFdpNFBhUWFnV3VaNm1nWVdmOFBiWEVZOGlnb3JOWmkveXZNRVhGQWpt?=
 =?utf-8?B?NFBNcDFSZmxvZ1lhZytQMzdGZmxPbjBmb0J3Z3Q2WU5TSGxTeXg5Nnlick4v?=
 =?utf-8?B?d3NBS0lyalcvTFIzY3R1TEZSeUxJL0YxV2cvT2J3aEZIQlI2bkcwSWdyV2J2?=
 =?utf-8?B?SDRlNUd1L29ySGwzcE9PdWVEMXI5d1V6eXowcy9kQ0dLaksvT0NrNFlGYnIv?=
 =?utf-8?B?WEV6NzBQeTRxd0Fwc0M2S2V5Qk9rdHhZUjN6dkRIS0lWUWJDWVVjSTBPSU03?=
 =?utf-8?B?K05ZTjBFVkV1cUZSL1pGWG1TU0xUckd0Wnl2N0E2QThaWDZBK1BhNGd2Q0N2?=
 =?utf-8?B?S0xoU3lDMENBcnNvRnFZOGkxbXVCU0RCRXlyMkI3Nnc0RGZsVVFFaDZGT1Ex?=
 =?utf-8?B?QzhqZmtyWm1HSzB0THlMcm8zVG5xUEdtV0prYzQxSnJPRWhIcVdqcFlDMEty?=
 =?utf-8?B?cEdmd1RqQU9yWXhwRDVmamVLbEtQa0xHRG80ZHFMSExPRnN5V0hBVTdqS1hy?=
 =?utf-8?B?bE9FZkFzYm9MSi9sUEhEcXNvTlJyU2lLejU3cW8wT0FoekFYQnZsRk1sa3lV?=
 =?utf-8?B?RytWOWpSY1BRdmNsMEtRZ3NROENuY2RRODhWblB1K1V1Wnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:21.1257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a8936d-63ad-4755-721b-08dd0078e60d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723

In order to have a device for the platform profile core to reference
create a platform device for dell-pc.

While doing this change the memory allocation for the thermal handler
to be device managed to follow the lifecycle of that device.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v6:
 * Use PLATFORM_DEVID_NONE (Armin)
v5:
 * use platform_device_register_simple()
---
 drivers/platform/x86/dell/dell-pc.c | 32 +++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 3cf79e55e3129..805497e44b3a5 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -18,10 +18,13 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_profile.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include "dell-smbios.h"
 
+static struct platform_device *platform_device;
+
 static const struct dmi_system_id dell_device_table[] __initconst = {
 	{
 		.ident = "Dell Inc.",
@@ -244,9 +247,15 @@ static int thermal_init(void)
 	if (!supported_modes)
 		return 0;
 
-	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
-	if (!thermal_handler)
+	platform_device = platform_device_register_simple("dell-pc", PLATFORM_DEVID_NONE, NULL, 0);
+	if (!platform_device)
 		return -ENOMEM;
+
+	thermal_handler = devm_kzalloc(&platform_device->dev, sizeof(*thermal_handler), GFP_KERNEL);
+	if (!thermal_handler) {
+		ret = -ENOMEM;
+		goto cleanup_platform_device;
+	}
 	thermal_handler->name = "dell-pc";
 	thermal_handler->profile_get = thermal_platform_profile_get;
 	thermal_handler->profile_set = thermal_platform_profile_set;
@@ -262,20 +271,25 @@ static int thermal_init(void)
 
 	/* Clean up if failed */
 	ret = platform_profile_register(thermal_handler);
-	if (ret) {
-		kfree(thermal_handler);
-		thermal_handler = NULL;
-	}
+	if (ret)
+		goto cleanup_thermal_handler;
+
+	return 0;
+
+cleanup_thermal_handler:
+	thermal_handler = NULL;
+
+cleanup_platform_device:
+	platform_device_unregister(platform_device);
 
 	return ret;
 }
 
 static void thermal_cleanup(void)
 {
-	if (thermal_handler) {
+	if (thermal_handler)
 		platform_profile_remove();
-		kfree(thermal_handler);
-	}
+	platform_device_unregister(platform_device);
 }
 
 static int __init dell_init(void)
-- 
2.43.0


