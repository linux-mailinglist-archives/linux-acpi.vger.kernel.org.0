Return-Path: <linux-acpi+bounces-9986-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22889E64C1
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5FB282B33
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40161891B2;
	Fri,  6 Dec 2024 03:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TZBFGIlX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149CA1865E2;
	Fri,  6 Dec 2024 03:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455346; cv=fail; b=sizvDSVn5HkbvcqFTRTxp4nyySr3UXHmbV33kI0ejoUC1jFwDRmYr3R7XqsnsVEv3A7Q0n1kvdBeLTGMjgkx2R/4dDDrSSKeskGmhPDCxIra8pS1yAxOcz/hVeIwZ4bMSlC3aqXnLK5vlRPS8vYd4m1lvlMVGbI9Ta5DSSBtbus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455346; c=relaxed/simple;
	bh=EpBLXuqVtx8vhBhviCCJcSbHzG0FzrqJkf8El0ijwqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWfu4uuUFDCM/9TMIoOB4c5FffARE22eFWkMg47qqD1dky5nB8ashfPAhQa+47BhT5k3JacQBTipNQmD8U0NXxRZZfWSFZkLLXg1qWk/8eHe6zISG/kQklpIRTOvSPsnWljVcQBH4WtlGY6tPLU0Z/N7i4Lv/n6M61oUAHXJSbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TZBFGIlX; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqQKy2751wvhiZazDzFUfAvtJgEz2rteU4bTH8IJaOHawYG86KIlx9VaB0unMZRTb1SD9ffyB35WgdWc1JKs15tfN/qyJQIEaERyHPGQozy5FDhqN3SmYpWuvWtE6TXr6Z7vu3DsebeshB4Sq3Wa25MEJ3H7HDn4CPBHlQomVu2xYHmq5cjzxfOsipq1eCNO1B1Xp23D7sK/QchQlZ0vIFnDg0hcZm5nRxvJ5Xq/v6HRnR9EngOn9PaglnWRWEOGlOYf21CjeU/fhb8dB9EjDnwsSMfYlSQG8C9kUn9A83m7CHUBnha497jRhvi8rqEOuyzwHL3EtizuN/+IsiQHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLN3wK+RpjaYWFJyskt2+vP6DlyrdcUDBhvHh/FG3y4=;
 b=aok3f/YrPff8/p/YeetdubMK8DALVduxViMLscf87GlNEEIsdZRiMMB4bQdKjLA/vsOtrP/sRZLgfkT6bf8c4v4grjHdpWn6Z4JoIsHCNnkuY1F2fX9ZoMH0nshFOi0g9jqF517hb9h+jAlwRbQvRmWhCsCTaziRFw8kI14aUq1dTBu71Sghrxa0MZH9rP2g78gcQZhRY/C5OtQtqdoojnECBtMWOjXim4SBrKQJ7YvinBwnDcyOPI9ik5Y02dzNxKBuE9gKQk6MR+7SSUXqopm2B/do+jDLdJtpyT2grpzZ0FsqgulrH+K9nIHwVituFhXt8gNGnBsDcM/XP+7p7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLN3wK+RpjaYWFJyskt2+vP6DlyrdcUDBhvHh/FG3y4=;
 b=TZBFGIlXh/C4geHpTmCq6niSHni/ZQ1gbjgUZ+bYaIfRAQam7EWjnAh8phHOYsedSbPBcBe+TJlXmAFkaoi96Ch9QT1yqkGpmM4RV/kLXtCU1gW7sVj0g7NCoHykVQMVb13qzwo2i0aFkOqPJtg44I720X+h3YR59qTivMy2Tns=
Received: from PH7P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::12)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 03:22:20 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::f9) by PH7P223CA0004.outlook.office365.com
 (2603:10b6:510:338::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 03:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:22:19 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:20:43 -0600
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
Subject: [PATCH v10 02/22] platform/x86/dell: dell-pc: Create platform device
Date: Thu, 5 Dec 2024 21:18:58 -0600
Message-ID: <20241206031918.1537-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: be8e1358-533b-4c1a-47ca-08dd15a5316b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RURxTTBDMG5Zbm9EU3UzaDBFRmloN2lkZEdGeTJ2Q3dDS3dQR3BCN2F4TEpF?=
 =?utf-8?B?WlZLb0xzbVVOdGxicFZJR2ZrU0FvbTFpbVRkNzVESmN5dm9zRFdIR21jL2I0?=
 =?utf-8?B?eDRjMW8zZmFuelFiYVgxTFN5Z3E4U1JvaWl2KzQzR05LRURmR1JoVklnRDFW?=
 =?utf-8?B?ampRYUVrcFRVSnMvQXlka1cxeVcxbzFXSlVVbUk2Y0lRUjVZVkllZWRka2Rw?=
 =?utf-8?B?TWRITHd2NEJ4T1c2SFVleDFaS0VTcDMyRWhpSFZYOEMvTDlRbGd2TENiWjB6?=
 =?utf-8?B?SUpqOXVtSEoxbi9jQ2RCd1k1bzY2RDQvZTkyV1lLS29tejcxWjFJZGVkMjBN?=
 =?utf-8?B?djZ1RW8zZk5Tb2o0YXRNbjh1VHJWV216WWJKRW5KVVgra3JGRVlBcktYYkpH?=
 =?utf-8?B?TDlkQllzWnNENHJtVHB3cld2VFNhc01qbXROS3U5SXZRVDg2dGFBVTlHYXRT?=
 =?utf-8?B?NDlXeGFUZ3g4Q2xTdkd6c0wxR1NPcUo1ZVZGS2orMzJ2TjhIKytUWnIvZlNR?=
 =?utf-8?B?czhlZzVkU29teGNEQnRxQjNUc0EzSDlJbWJ0SUIxcm5mTHlOQVFidjM0VHVC?=
 =?utf-8?B?Tk43QmpZdFJVU01kS1JubytYc0ZnOXgwVEFDdFF1amEzRVpXOVFnOXhNQ1pk?=
 =?utf-8?B?Yk5iN3VVcjRrT1RLUzU2bzRuQUlLTmlqUDlIcVZpZEdYWVpwVWZWSmQ5Zm4r?=
 =?utf-8?B?d0tHRHlxN0dMOVpSWjR6R1UzSnFtYVVLb1M2SzN5NWZOUU1aNVVuOGl0ejhj?=
 =?utf-8?B?UkxXdWJwTFhKYVkwQjdBUWJPeVRrcklYMUMxVmRhWkRtWGp4TzFNTEVzZVZP?=
 =?utf-8?B?T1NNTFNPcnRkNzdsZUVJMzNua2ZqN0Z2VTZUVEIxOFB0SFErNGgvRlAzMEdI?=
 =?utf-8?B?aU45dXRiRGEzc1N5WjR5MFNndHJwb2VISE1VUU5pZE9kK1B0RmR6aHd3VjVt?=
 =?utf-8?B?a1daaGp6clpPSlY4OTdWZG5YWHJUZEJzTW5hU05vZ1A3SDhoN2wwbGY1ZWND?=
 =?utf-8?B?bHRsdGRrOUpGMVFrY1pZd1kvNG9uM1hOL3lFTzFteFA3RjVVQ2lGemQ2SG9C?=
 =?utf-8?B?VW1JWnpVa0xSUVMrUkl5b1c4WE1jNnk5RDZ1VlVTYjhxdjF5ZlNsV2w4SDJR?=
 =?utf-8?B?MFBIQko2WElUM1JYbkdvaXV0ZTVvSTBkZE5iWTZxWjV5bDNwYTBnYk15T2kv?=
 =?utf-8?B?OVFSVDc5YWkxNzR6dGlxUG85UFJud1cvTmRjVS9uYkd4V2RnWHNyZlFZODdZ?=
 =?utf-8?B?N0pOekFaK0dMaFBkYWRzWjdhRFNMSnpET2N1T0hPY0dCOTZwU2xNelBVSGFw?=
 =?utf-8?B?SlNYTDVnbXRhd0lhWCtFNUFqL2JNYUFMV00wblYyQ2t1a0UwdnBzWTNVYmZI?=
 =?utf-8?B?ZTNVWGhHd205QTd6UGttL0M3bzdzMVRzTEYwdytjaVp6MDVPejFrQnRIY2lj?=
 =?utf-8?B?NFFMdU5KcmhqM3BpRUdScEVXSUNCOXJpRU1QVmRXZFRScFFndE5icFhaR3dK?=
 =?utf-8?B?eTMwci9LZkl2Um05dlJvWmFOdEY1bENpMVIwQ1grOUNuZ3ZNdG1BMHJrdklu?=
 =?utf-8?B?YkMzVGVWKzE5b2JZc1VZT29UeWFaS0d0UzZCckR3a3BXcWpjVU1hbDdRc3pt?=
 =?utf-8?B?RTJURTJ6dHhuUmFhb2dUdjZMbmtFMi8wVyt3SkJGVVZqWnk5ckFyNFZWWCtF?=
 =?utf-8?B?SEVPb1oxeStmUmc5cGhnV1ZwWHZVR3pwd3N1Uk9RemEzNGd6QUs2OGJzZGxn?=
 =?utf-8?B?ZVdZV09kRGFUQzZGL0V4bk1XRGRLcS83YnFXWHBrVElwM0lnU2ZhdDFyU3ZE?=
 =?utf-8?B?dnB1ZUlxcUFSZ1AxUXJzVVVWZ2F4NXloOVR4dW5ZeXBraEdLVDg3SjJrdnd1?=
 =?utf-8?B?NXhrM01vSmpjQ1BLVEhVK0wrbWJxbGtBRmtNSE5GOE1DblhJOTkwQkd4czJv?=
 =?utf-8?Q?C/Vk6Xf5d6d+iprO2SaFt3jspliuyL8B?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:22:19.8442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be8e1358-533b-4c1a-47ca-08dd15a5316b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908

In order to have a device for the platform profile core to reference
create a platform device for dell-pc.

While doing this change the memory allocation for the thermal handler
to be device managed to follow the lifecycle of that device.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/dell/dell-pc.c | 34 ++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 3cf79e55e3129..c0dbbd3b23065 100644
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
-		return -ENOMEM;
+	platform_device = platform_device_register_simple("dell-pc", PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(platform_device))
+		return PTR_ERR(platform_device);
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


