Return-Path: <linux-acpi+bounces-9803-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355239DF0B2
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89832826F2
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5401A00D6;
	Sat, 30 Nov 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bw68iHDI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E3519EED7;
	Sat, 30 Nov 2024 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975535; cv=fail; b=hWGhQmY0W9AYgUB7gl1qy6W989cFU/k80fQNCXwrqbFWlPX9VgpINF7BlQqswie7eEQ4GHKJZH7jrkXcPBDCoqnUISse8SD99nmXAjSGOSsmTms0f1zTIty8rqSaVMLn067S+xnvr6XRs3xRWrghn5rujHEiYzJvo0iiLPVoi6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975535; c=relaxed/simple;
	bh=DJ7yecRfFdjZ6h4DsR/Q0ETjDidYjDcuSCiQNrFW6tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYbE9hlDMRCY0OKxKJEI4izNW5uBqucji03f70zjDBJ/ySsqzP8FsT0cMxqaWHc9yJt3ShRf+2AMsdkF9OWlnj3Wyy0zWX76pKSoXNisweSLNHd5yPruPBcLo5x/T6J/qyUOKZ1A8dJlPzzTDtPdF2xAA5rJRlyQGakCHTDP5NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bw68iHDI; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Js26h+H2TNLULl3QV1yA5ukZ/xRwNTEEedbATM1R8JUL4auWqx5QBzPwCGu+7Kf+YXlwYd6VEbT4PaZYW8Z+/0+V0RlnpqrJGyMNqlqn7V0R0A3LYxuUU1iHGcyGsvSljy3uPob4oZqhi9QxLFTkuXNBTYqGdVELcClfZ57a78ZSS8n/v8KxE0Rbxyo6F/c0aeVUynAGIwApRhfpxBkykFYDYlNwQEciDDDbYyojsSo9SGHtaG6rSrt85HiN1tbhWZfZYAcHGfW58XtGWs3CpEefDplCL386Bpu49lKn0WGjli2FlyIE++Ckb8mUzgRbTEHjhUSfc8vNONtlTSEYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARvH4Vt/K8c944FfThFOJb4Ly2SmZHct8fdk8/8lZ4U=;
 b=aeoT8zyvBee6BjA5gyKbC5ZS4rfPMQrX5h7zhXdqAsTd6sp49XpZpCxxejcQjiGGf1O/km+jJn9KSKkPf5UEQo2An6maNPASS5hxvKXOFl4H+xGJHJdZz44MIrnyg/FkxtODjEr3DHrbBXBwwJdQrHcHybio7uki9TbrOV3NQOewiEfUzv7iGOSFpl/QrtyAArKW5ckPXTD4PXSHlq5tw5du5XHYeEwxyVSEhigX7CMdwlkGjidITaHtsVBOkXQf0Cym5QmL+EwwHInurTHiIXnm4g5ZBLjK0itSS1axSaKtBbpKx4wYJpS+wMjlJHvMC4rYyH9nzaRyAtV1yAxvHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARvH4Vt/K8c944FfThFOJb4Ly2SmZHct8fdk8/8lZ4U=;
 b=bw68iHDI28AnqCIedAJOYE8M+0NsROoHXJ24eg+yKWlG02kFrr33jRH8koP0QRIiNvxEQLcmGyFHKbmXmLUTO5b1Q1EvK3eBjpZ7eGndCJIDPl1EHU6DyRZz+pzML056viUMKPGbbiXeVINF+iQMD9LvX+lDjpX2lLO2UgDQZbw=
Received: from PH7PR10CA0004.namprd10.prod.outlook.com (2603:10b6:510:23d::22)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 14:05:24 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::51) by PH7PR10CA0004.outlook.office365.com
 (2603:10b6:510:23d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Sat,
 30 Nov 2024 14:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:23 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:20 -0600
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
Subject: [PATCH v8 02/22] platform/x86/dell: dell-pc: Create platform device
Date: Sat, 30 Nov 2024 08:04:34 -0600
Message-ID: <20241130140454.455-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: d8dc0dd3-393c-440c-c280-08dd11480867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk5ocjdVNW40aitrbnRKREF6M3NWTFNSa1UrVXRYV3lrQmRlOFlhNVBVRmFh?=
 =?utf-8?B?eGp6dExacGRXc05RUU1XYmE4emtBUmNaTEMzc0JySzh4RnJMcGJWWlY5YkJM?=
 =?utf-8?B?dFlUdDVwVEFTcXozMnBocGtadkRxOXY1ZEFDRDIrSHM5b2svS1VmUjNscnVG?=
 =?utf-8?B?YWtHN0JNSjZVanBBSm5oVGdMUkErb25PL1pvWnNjaW9IMzFPV2ZBMUVYWDlF?=
 =?utf-8?B?UGdUelZmSDcrMUZzZDFHWVJCKzJwMjlKSzBQdTdUWVl6LytZbXloeUlOYk9k?=
 =?utf-8?B?T21KTE5Xd293TS9tUzVQa1V6bFNoRVExMFN2aktDTXBjZWthU3JxY0FLeHA5?=
 =?utf-8?B?N1dZSGtlTTZUK0drcWxzYXJtK1pRNW00TEZTRzByaEJXdld3OGpsTStNY2tj?=
 =?utf-8?B?ckl2T0txK21FTU10T2F0ZFpHeDEwQU9wckJTakxXb2Zja0t1Q0k0THdkeUEv?=
 =?utf-8?B?YlpHVHV1WWhJYUttZVVReFdIc3lINE90RGYxa0sxMm1RU0x1Q0kzQXdRYXZm?=
 =?utf-8?B?MFA5ZStQKzhtYVNkcmE2MjZQOVY4TDFhWDFNSkpYNUxhUG52MWxVUkNlMVdB?=
 =?utf-8?B?bmdSZ3pNek90dTRoOEJIb0lrSlJYVCtBR2ZmNDdEaU1qaXRUYlJyajM3MXRZ?=
 =?utf-8?B?VU5NRGxOakJJWFQzbDVsK1AvREptVlVTaWZJMGlVbVhKRkpQMWpMRHNlRnJC?=
 =?utf-8?B?ekxpVkpnZVRpYldxN2ZpaXhQZVp2Tm1RWXNQWEptSFhPSmtVcGVQdlNqalJY?=
 =?utf-8?B?NkZKc29DcVlvR1RsTkxuZnNuNEVmL1hrSzNPQzVnM2xTeWRuRWpCVHVFYXlo?=
 =?utf-8?B?c2pYTUI2azI4dkczdkxqVndTSHBkbFEvZ3pHaVFRT2d5dWNySTlmOEkxbUpB?=
 =?utf-8?B?aUpkZHRKZElSdnc3cnlyZmJKT2xlWmNkY2NDbU9oeTRmb0NEMHJhR0crNS9I?=
 =?utf-8?B?eGtoaTRaYmg4RnUrZHFRd1pmMy8xYjBaQUFtdUw3MFI2N0QvaUJoT3NodGtz?=
 =?utf-8?B?Y1o1Ukc1aWRsUjBwTUQxMzRkb1FlYzA4WmRxbkJPeWdHYVJFdDhnZS9UM0U2?=
 =?utf-8?B?ck9QSlpXbmE0aUErTkJOcUorZ0RrRm96SldIWk9xYnlqMEg5bFZ4ajhOM2NR?=
 =?utf-8?B?WHRrSzZDdlNjMnova095NVAxVHl4UzQrTEZwSFg0MmNVRlJUTXRIM3U3cUpT?=
 =?utf-8?B?MFNTZFRLdkV4L0g2cjNRenZxQUkvNStHWnAyUXFHNzltTlNoTlJxWXN0b3Fl?=
 =?utf-8?B?cUYwOU5KYmJWbTdNSEVBcEpObklLdVZCRUI2WFpDVE9ZRmFvU2p0UVN0YzFs?=
 =?utf-8?B?c3BpamhRenEycTZPUGxGQnozQ1J2N2hDdlU2RDV3dGNwa1BVOVFrdFZOOUlo?=
 =?utf-8?B?WmplcE1HbVBFNFhlZ21LWmovbWJzSkRNYWI3UlZDQkUwVWx2blFEQTBVSW1z?=
 =?utf-8?B?bkhxS1luS1dvM3NISTVid1JYSjJNdFcvZ0MvNTJnd2pjY2Frc1MveFBFcnJw?=
 =?utf-8?B?YUdZamx4RW1QMWlHbGY4RDFhYllCaWxxZzE5cGpQMnF1RnlaQ3U1cHBoT3Y2?=
 =?utf-8?B?UktXRmt2Tk1lVVVCRUZXWEIxZjJMb1JzUm9hLzZaSEpBbm9DYUJjUVZWNXEz?=
 =?utf-8?B?MWZ2UnlBUEdocG0xQ2xjYjNSQnMrMm1zTGxiZmZIUE1wVUlBRFE1TXNpVGN1?=
 =?utf-8?B?MXhqUUtFQ0JRRFprODMrK3RxN3pZQktHVzZtUnJ2L09lbWJWMU1iYk42a3po?=
 =?utf-8?B?enh2RU1vQUk5QjVpYXAxSmNRS0g2c01nQ0pRWnpnbkFJZnJydlJtWDNoZnRG?=
 =?utf-8?B?Q0dvZWtvQzFZZ2tSRWMyNWhtc3Y4VlZEdGNSTVZmemxCUWF0N1RQdE1qbzZ4?=
 =?utf-8?B?RExralBIbmk5cXJURGdHaFBCZjlKYk1tQlJobEVDY2tzT2ZGcGhWUTNiMzRB?=
 =?utf-8?Q?ZpOIFBH+vL9Zsi+TQ+EVE7UqaKN2cpP5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:23.1094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dc0dd3-393c-440c-c280-08dd11480867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711

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
v8:
 * Use IS_ERR()/ERR_PTR()
---
 drivers/platform/x86/dell/dell-pc.c | 34 ++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 3cf79e55e3129..8bacbde0f0506 100644
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
+		return ERR_PTR(platform_device);
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


