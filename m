Return-Path: <linux-acpi+bounces-9668-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E4D9D2D16
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DDD1B3001E
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CB21D2238;
	Tue, 19 Nov 2024 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E59xm3d6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA7C1D1E79;
	Tue, 19 Nov 2024 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036870; cv=fail; b=RCF4FGeFQxwgj+wUM0j0vPLxbZpDoH+2qhllsl3fhEILY8O4v58PwJ8wTyHBqUOUriiS0AuC4/1kzC4ppor/+mdClBsMFGcsZ1wrAgWwDNHnRK2VFmXUSrtfQdbOzJFq2fMvk1KcbxyyHDKe+u+Q8RQ4oKdfyRz0A1UkvNLGWAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036870; c=relaxed/simple;
	bh=gVOFZQ1NkY8btPf86/D8ZFqsha0+GCMWANbhEBwFGl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fL3RYe3DJUVxoC2fSDUtyWru39jqZgVc+RS4XGXY8bsrQrArPTLNigCEnNqcbcHhiFdMeZ6WRvHUyFmfm3pI5zbJt6GkjRucy3vCm7JXFYUxN96NLIC8w/N4h/tC5l7V8lS7jzM3vrWbFTc3WeodsZ7DRV+qSoOsZZxL+ObIDXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E59xm3d6; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRaE5fEaI5G8Uf4IOPcJP33HFq6+6Mtt1RkK5UWLfiOA3nNO80SAYKjEdwBqu71IQjF9tqc1gjE9TekpcE1Jb12Ybz6Gbq3W9bVM4AeqBg18hty3XAPhK9ElGqNjyMWgNg70i92CXmqLK+TjHBfCBkcXRusnbacWFIZ0fNVg8qGNQcu+OUowfNSkBAInwH1uiQ294LmuKy9FJp4pSCluNJbfVIKi+mZ1L366u7dX+r0vXG18o5nCsncBD77qW7BBZ8uTE54sXwkkFs4wVMNo9v8dmDXi9OJjEDgvtM7iM6N13lwCJ2IeAOP7ev8DBQjIBLUOJ+0je5u96e+mtsRcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rcake+aW7InzlrriCA9veWw0Iv9E+pdMZvM9w0hzudg=;
 b=kkqipRyXGiCgLdcAQTvutvs2K5Wb52weCnsGqsOektUs6B7d4DWyhfohQHTZUppz0uQnppd890gJzdJP6eWTmq1/3UU264BeLZROhO8wI5OjIgsFxyXps8VZLA4zcyvnGOClKjLYIwCAreLcuuvz0E8TnIHJAu4EB/QOPZGTeWIhcBdTOq3N5xLPqu9QOF/iKie98Q7ACgdHZRDNj00O/+OmjwXPPEsPGi2+B556hINgZQPWUZw5F+btomsuOvFc99qukIsgGbmjEvki+bvt/KXfT1kI2tK84aGRfo+qnycPcDgB/TpRCAVgJQl492bPkfcA9vmB026607een5oIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rcake+aW7InzlrriCA9veWw0Iv9E+pdMZvM9w0hzudg=;
 b=E59xm3d6xDoyojZQCFMUfz8/heJvf1H26odjeB4IwT6zq4LQy5uzQuVNGm7ul9AA+ujDjDdUW5LvbkRBoj9j6sv1749yV+nhRKC2i8h9ZqlyRHy5UasIuKt4cTlO7cKTt8d4RrbeakUHN8iOnnCK12YqNGkmS7XzdD/j6GIS/Kg=
Received: from SJ2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:a03:505::8)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 17:21:02 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::69) by SJ2PR07CA0008.outlook.office365.com
 (2603:10b6:a03:505::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:02 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:20:59 -0600
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
Subject: [PATCH v7 02/22] platform/x86/dell: dell-pc: Create platform device
Date: Tue, 19 Nov 2024 11:17:19 -0600
Message-ID: <20241119171739.77028-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119171739.77028-1-mario.limonciello@amd.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: fafd6b68-d250-4506-3513-08dd08be8af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmhQYmIwZVN1Ym1sR05NeW40dis3WlFQMHp5WEozWW1VTko2RU1UWkhWeDdX?=
 =?utf-8?B?VEVGWjI3dEJTQTR3MmU0RVdZWEdwWkU0eUpqRXhxOS9Od1Y1QW9QazdMUmdq?=
 =?utf-8?B?bWRkZk02SUJxdms2dUp6bmM4TVVQeVNnNk1oRFhhV2JLVUNoMHB0SjN4MHdE?=
 =?utf-8?B?SnZrVWd2S2t3V0xuOGRpZFpwOW4xMG1RRHQ2UUsyVmJEYXE3NE5DSWYrZ3pY?=
 =?utf-8?B?TU9UV0o1TWx5UFJqUWJWZG82ZmRac052bmVMUjQ1NWViRWdYbXdOWWlvZ0NG?=
 =?utf-8?B?eVp3clBBd1pFeWNKMlo2UFVYY0lrWWhPaVQwWHNzUnAyY1pUelQzOWlwUzlY?=
 =?utf-8?B?VkU4eTBiaGR6VmhsUE9ESnp3cHhiYlgzK1VZcHZ6dG1YZWdjV2hMdFlPRGlE?=
 =?utf-8?B?eGh3L0pqK3hkSWdmd1hVZmJMZjJrODdSZ0RwWXA3WFRRS3FCR0I4VHl6bGVk?=
 =?utf-8?B?M2FCcXFQUnk5czB4VTlFbnZRMDY5djBwOXI2UjFOWW9hNFVuL3RDTjA0QXdN?=
 =?utf-8?B?djU0VFFySGJGYkNyZG90cUJjQ1ZhRkY2NzBGd2FZdnNrOGFMelpVdTl4eTNx?=
 =?utf-8?B?QThqWFVtcHZwSXBCOUVyZXYwSTBNdlREK1NwY1ZTMWlrdGYzdkthZ211bHk4?=
 =?utf-8?B?dGNGSnlhaE1VazRLb2hYUlI3djVFbStIT1RrMSthN1I5UmJydVR5YVY3MkR6?=
 =?utf-8?B?ZC84MmxnWUwxbWVnMlhNZmNsWElRNlBQWGlHUTBpcFE3S1pGdDBTbFl1cUUx?=
 =?utf-8?B?eFZ3MFpkYzk3T0NDLy8rRFJIcG0weDhWSUM3TDZad21CZ3BESnRvWHlpUDZB?=
 =?utf-8?B?dlAvRDdWdUxNNDcrY3BvUTdlbGQ1dnJhK1pBR0t0MWJ3RXRYZXl6YWVFVzhk?=
 =?utf-8?B?SHIvcGpxNm93eXpoOTVlOFBKdTZ0ZW92OWZMejBSVlgzYTIzdmIyaldNek0x?=
 =?utf-8?B?OGcyYjZrNzJEUkNiWVZoOGwxcjYrWkRPa2dmMkVFZFRDTzZJWTB4bEhabDJu?=
 =?utf-8?B?ZStnN3cxemhYaXBzQzQ0c0g0VmdhZ2JPRUpSanpCT0pxcHNuVVNXVm51TXk1?=
 =?utf-8?B?T25FUDBtMGFxaUR2b1F2L29sWUdFMThrOUhuOWNuYStjOWJXZFdsNEF1dUYx?=
 =?utf-8?B?clQrQlFSb2g4Z1lBUUJKWlR1RmZzeHVPVzNPZzFyL1p5ZEk5Mi85TDcrRzBQ?=
 =?utf-8?B?d1EveEdpT1lHcTZ2NG8xRW9VNEV3QlhwQzRhR3NPWjVBUEFwRHUzZDVaOFlX?=
 =?utf-8?B?MzVaaTVFZ2s2QkpoMFAvRXpiVkZtelVPVHFadHp3ZjhTNmJxWHU2WVR4K2Z2?=
 =?utf-8?B?SGVhSVNpSTBQV3VFb3FYWGZTaUxNZkpaSWF5T1BOaFNXOUlHMlJaQVp2NjZO?=
 =?utf-8?B?Q09hM1RVL2M5a2dsckwrY0VMNlY2Z0dWVkFOeDlUSXlIbHd0dWVFVVZJTDIz?=
 =?utf-8?B?Y3JOdWxNTG5oRjVsNUJPbllxdkI3S0RJZXFOVjlEeTJTa3VPZVNWYXQ2UFFi?=
 =?utf-8?B?RjNhL1l1VXhmNzRDOWlRdjh0WThDVGlndEx4OXJreVJ4VXB6V1Y4SnR4QTZl?=
 =?utf-8?B?VVllSEpOM1k5TXUvNXZRYXNyREVBNWFkb1BEaXNQQUlZdEQxeExDOEdWdEZp?=
 =?utf-8?B?MEk2cnJsM00zdW9hR3hDWFlJeUs4bkdLaU9KU1Yxek5RSU16eEU2ekNLNHFG?=
 =?utf-8?B?V1ozZWRxMGx5NDU2dFNESDlRSWttdEs4b21VVlRRRkQ1NnRQYVFFVGZ1OUFi?=
 =?utf-8?B?WjdTUGc4Sm8xaTN0R3A2T2tsMUdLMEo0eFByTHZGd2ZYVElBWDdYOFFJWlMw?=
 =?utf-8?B?c2tJVnZ0MUtUam95L0J2SWNpTVdOTXBMaVpQQ0Z5bUdkUjA2cUJ3ekppeTNX?=
 =?utf-8?B?VDZvMHhDVlRNdkhxeXN6QldXekxWQ3ZBaG1ZeXVGWTN2L3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:02.3156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fafd6b68-d250-4506-3513-08dd08be8af9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239

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


