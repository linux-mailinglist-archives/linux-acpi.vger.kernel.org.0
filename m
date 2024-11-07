Return-Path: <linux-acpi+bounces-9386-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422DF9BFDF0
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA141C21762
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796D819408C;
	Thu,  7 Nov 2024 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uwAepv1V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1170192D7E;
	Thu,  7 Nov 2024 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959414; cv=fail; b=cUfGM3KdpL2efT2AhRh36I23YH/1WcHy8C/c8ERcGONy5IVKrh+CkQQZtV6bUR9A4jSGEYHGjr2zwcn+UC3Z9TsJ3bhenzZV2s3MpG8VIkVZaNqJFrTmLMzJDqguftiF1BpkXLyjxRHgDnhuFHhUk3gkG5nYngSOvQVg/Mf7whI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959414; c=relaxed/simple;
	bh=YrvhKUBrmKASOjRrsD4+2FutuCJZ/+C9KrTb2y2zj1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okvfKpP0lgY/RtalaGXMNPjMb99wYywAJ1OWPLF9EwTnnYr7l5T0/xpsKnL152ljIbvfaSK1msu2xp/vEDVjEL2r+vE/ZWrqWgWD3xMcWg2NP0LDt9yevto9YY0Ehi13SoID8HVNmOqjqbPgx2bEYX2IEWeEYH8WQShm6XlAwxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uwAepv1V; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVnaV0d72dPj5RqWaJapTngmFB9LRPPDAaqePNNNIYGK6PbS/YZs+dtwWGF4zQv6Rw5RwIR3Sfe9Cnma9iNeJvblOpb7RMkkuJadm8T3TN1koO7m1Qi+oWv/JrSGKeNhNSFonpP6wDxLK8CAhnLVBFBaFbtJd0nSC8XbzW44y71MKZdIhnfzOIb73ZQ50NVo0pFNDBf3HM4+3K54lumu2ilP5z9sOrG0mjALKfXVAKynP9d1c9yOqzj2+etCXIdRhbsv18+XggjteDiGruye4P1LngrAU6rCTkOhC0ipYDWYcBq7i1tmE56uEQ91QkGLff6dlIxpQA6hcarVLplxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JnTbbFF5wE4ooCniMJuEfRSre9huJa0rS/D8f+fLP0=;
 b=CRXNEEBhuTZFyWtOcvYVdXbPpZ1BrzKCKufJWxexwB4PEaREyTDVf+cx6V9V8TZf4WFZ4GAxSofotWDCsRDVCg1tGN/FCAVuo9dy/Z0ozCCANwPlkREPrX3r76CI4v23n+yTPVHgZbBPTv3E4gSOa0uwTt/ACb/zWgDzVWtkmFNLMZGIOukrcL3MgMSAD4KXSVSYMVMwCREj7nTd3vNupm67DhL9JdVrYScCJV4GpBgTGkq/clFFBkzgqHtu6InWC9bWRXZmr38hvvrmuvp3OWTDY0OxP/6cfy4ofkOZhgW2+tqIl7zmEuu2PMpt/A6GEKW00fKpXVIX/Cj3M6bdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JnTbbFF5wE4ooCniMJuEfRSre9huJa0rS/D8f+fLP0=;
 b=uwAepv1VceZcCqqZ/Cfufy8RHoU/8dDuk7PVEAjoBLTh/tKHQ9Jt57AORFTIqjGGLLu8gQlZh949Al7QLZJlf64VXfnCNnSPFXVXR9hCtxNLEObcJKVr/D8IJ8dpmnI8XF968owDHALIGHMl1QwN34VmuHcklwFPTWDPWtXLxx8=
Received: from CH2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:610:20::20)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Thu, 7 Nov
 2024 06:03:29 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::8) by CH2PR07CA0007.outlook.office365.com
 (2603:10b6:610:20::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:29 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:27 -0600
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
Subject: [PATCH v5 02/20] platform/x86/dell: dell-pc: Create platform device
Date: Thu, 7 Nov 2024 00:02:36 -0600
Message-ID: <20241107060254.17615-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 5805d461-7537-4b58-ee5c-08dcfef1e70a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE92UkxwWmFXdUtaK2VIWEh0NklXSEhuWDNKeG1Vcjdlc3hMZ0hCMWdpRFF6?=
 =?utf-8?B?OEIzbjF6ZWJXUW5xNFkvdlc5dlNzaFdueUl5cWRtR0xWMW5JNWpYYXNsdnBD?=
 =?utf-8?B?S2F6dnFDR3llR3hFaTdiWVQ2a3hjejRjMGdlWGFJaWlFd2cyaWl0azhQZnVP?=
 =?utf-8?B?SnRkM3M4M3gyb3djUExlREFLOWdob3orZ0QxWUJlSDJKamRFaVkzMzFSdzNP?=
 =?utf-8?B?TnBnWXk1NnZ6SmZ4NWJLY3ZWcWh2aU1qY0JRUTY3L095eFQyN1g4a0xjVDJH?=
 =?utf-8?B?VXN5NG9qLzJQK2M1M21HUWJZZVpZbkp1RDZ6bXdHOXJKUTNycmtQMlNFSFdE?=
 =?utf-8?B?SUxXOWNLSVdJaGpuQVp2ZFN4V3Z1ejIwK28yMUFsSFBVYmNudnRncE83T0Yx?=
 =?utf-8?B?SXEvd2l4cUxnL2Q0S05tKzYzb2tjemFwaStmK0JHa3U0VUxXN0h1ZWs4ZzZO?=
 =?utf-8?B?Rm15dFIxdTJlVHE0TlAxVW1zWEJQTzNVaXROSm9zU2RjNW41TnRMVWVYSm5W?=
 =?utf-8?B?TEh4YldsSmxmOXE0NlQrOW0wS05QM0ZJS3hNcyt4OE0wRWxoQU5uVmVuYnpq?=
 =?utf-8?B?MlRUVHJrZTZzdkVoR0xkQUs1aUliNVZNYmxnczBtV3lzL0pJZFcybTF0WDEr?=
 =?utf-8?B?UEZ4RXduN0NuMmJzaXZuaUw0MFdHWDBvckd1Ylh1N2tsWWx2d3U3UllOZHR2?=
 =?utf-8?B?a3ljTkl2NkVwTTBOWm5RZElQSUNPV25EVTI3UkdCd0d3alJFOTBJVzBuTFR6?=
 =?utf-8?B?aUxHc2huazAvTVNCRkZDazhmVEhvOXJNc3MyaWNDbmZBYm0xbEZqMFhybm82?=
 =?utf-8?B?MjN3KzJjNjdtQmpFTit0ZXBXL21Sb25zMlcyWm15dkhkNmxQOHpXak9xZ09Z?=
 =?utf-8?B?UW5XRmlPT1ZnTmQxbjk2NGFTdkFHRnpFQjJkKzJYNi9ONjhuLzlHa2J3elVn?=
 =?utf-8?B?M25Nb1hpWm5WTmppcGtEVEVPK3Z1b3dDYklwNWJ1MUEyWEMyeDNvMEJtZS9i?=
 =?utf-8?B?K1pxaEdkRGp4Ykd5cEhwdmRSN3Nmdi9BKy8xdnRUV1p0UTR2ZWNEWmx2ZGtw?=
 =?utf-8?B?a083bXE2ajVyckVwWm0ybmlXTzF5MUtXL2gzK21JVGlpZzE2dzd3elZNRCtq?=
 =?utf-8?B?MFp0LzdoVENFWFJ1WG95MlVhY2ZtTGxtTDRQTjF1ZTNJb1lEeHIwWnQ2SzZT?=
 =?utf-8?B?MmNBS0Z5amE5VFczNmVPeVNqSG1BZTVPY3RsNkJnaEZUU2Nia280MjdTcERq?=
 =?utf-8?B?QXFkanVPbDlOcDkvVzNVWklJdTU4ZDlzazNLY1EvSmRSL3BBK3QrRWxHVFFk?=
 =?utf-8?B?SGhxdytYZm4vS1BXZllJNE1MK2pSZURFMDRsZGlLdnAwTzhCV3JjaGZ1dmRT?=
 =?utf-8?B?dlozMmtnL1I2eVZpMmhQa0h0a292ZHMvUDhSNjZDQWNLeUZOTXU0NS8vaWd4?=
 =?utf-8?B?MHNmTUx0ZjBsUDNSUUZtZURlNHh6Q0g0N3psRlVUYWIzWWw4alkwU0MxMThW?=
 =?utf-8?B?aWFDWThvOTdsUk9SUURoVnpGdmFuWjlWN1FyWmdhQnl2UmUyL0I4MlBrZWxL?=
 =?utf-8?B?dDNxcHJxU0Vuajg4TXAwZ0dzbjlmRmpCRk1UT0VOaERIMVdlaHNMUTNVV1Ey?=
 =?utf-8?B?RTBqNDdqUi9UcythVVpkT2xDNU9vWXBBbllqdmQxZ0ZUVGx1cTZ4cFptWU85?=
 =?utf-8?B?c21TdE5KcDFBMFIwU3VjQko0VjlaVXBrMkROendRTkZnUG4xL1pnd29LWXJj?=
 =?utf-8?B?bzVLSEFLZDR1cVd1RnA3UWppUGk1bnRqbnBPOThsWERySGR6Sm5yK0QyQ0xR?=
 =?utf-8?B?eEMzSWVsdFVVd2YzU0tQS2ZtS0hCREJVM3FxSEZBNytHQ2g2dUt5dUxBckdH?=
 =?utf-8?B?OUhrUEtyaTIwRGFDbzR6Q1YvUklLbGYySXRweTNHRHRBMXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:29.4563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5805d461-7537-4b58-ee5c-08dcfef1e70a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331

In order to have a device for the platform profile core to reference
create a platform device for dell-pc.

While doing this change the memory allocation for the thermal handler
to be device managed to follow the lifecycle of that device.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * use platform_device_register_simple()
---
 drivers/platform/x86/dell/dell-pc.c | 32 +++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 3cf79e55e3129..0cd9b26572b61 100644
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
+	platform_device = platform_device_register_simple("dell-pc", -1, NULL, 0);
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


