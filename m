Return-Path: <linux-acpi+bounces-10006-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D479E6509
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC3F161006
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7EE1922F8;
	Fri,  6 Dec 2024 03:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jh6dTeeu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC01917C2;
	Fri,  6 Dec 2024 03:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455664; cv=fail; b=qvuRG7KzbD73w5poiOSe7Ss/DuVPP+mXa032rJ68Jlr0MwaeFa9+TQ8rbnisvMsAfVVNPJyLoWCYt1NYsB+JMoicfVfH8sGsn7IQ+W/8XXj97zro/IOOLH+8Vn+hVGMsvYKE2QNHoXCymVoDBHiZ1KUT6x28Ks13F/cu7/QR6cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455664; c=relaxed/simple;
	bh=T1bYGn0KpwhUd6ZGujBEzj+/hkw4qrWYZL3oi2BdodI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgB7GMFwGhuTWBSaXxaAZqy1NcZOpNwyw7qtqOI4IWNj2G+51g1Lxg13yQcoihdDcRufrzeTwzqSlUJpixVvsWISgm8shJup7Ad9ie9ofAaerLHgc4dLdhRqisAJCUiPasJnj69AZg7JVXvj3+LiOcUkCY6lI7ZdjfJxO3LP9DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jh6dTeeu; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aycj2zTL8vcPOwfvCn21xE9OGJ2xnH2+2ASWmEdLb35Uls7Lyhwblacg9MuGL2uLMF9f42tmcyKbws09GXeuL2Jb6rLo4ZGBuo9sIBhPUen9MtASpq++KUwkU83PJkdxZjNNRmDG9MJ6Yauqe79kRb42jDCeLTOFO2L0/1+//HQmzKjD6U4c6GFQU7HO49lUqWRus2k/hvZxJwfAcaEpITPaOoWbv3UhrFnIbFahHHrIE+2gq6nS42pY2oFshP+b8dlUuVvP1JJ7GuYnXhK/d99B6IsEUhjvV8/DFNe5pJD1AE7Eugr9QwC6BBcmDM1wtp7v3AzeIjeCZ5Kg0ek/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb6FvQepg1AVZdVCMCErgELk27WlH2wG4cscML7kY5k=;
 b=PUzLZYRDA0RZwdeYOlqgxwz/AG6EaO1AkVjB9zu8OE/yGHgMjeA3tPKqiWyytIwK/rmpP3CgU1fiYvUHkQ5de304Uqlg95ZHPYB9efXkqpkFlxe0ZPVfXIMmDrkEET7DVSbAiPRBrUdAmyOOfh0qM7rI23TGTFxdm1iLnT9LRzOQmkmTxiAR9aZBKjqWMQM4uwAGAkHj6Z4izDrAy+AX/blWNewEQGpyaOyKvwTxWPcefbo/Yr4su1kwVm2EcOK0wm64wRq8AhS0kGk2V8FLLTbGJ1vjxrXFaxYD4U4p3iO++0GdWu7gyl+w0fHlJEkmpi4xJGEB4tlyqX+gFPiZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb6FvQepg1AVZdVCMCErgELk27WlH2wG4cscML7kY5k=;
 b=Jh6dTeeuvnnWrdCIh8eBARh/bUTkHM9Xs1MgiMF1cpg4+ePNcpJ/XyFJ6/puYD5f7Hijq09VhJlmcxYIzoUTsQUl+4nQpd8YnD2WnHuAaxktCVJMHsBdUcPBQmHvKlUnnSnhsRD89PpuIIrHcBFaoqiKnWhAYHdgPblN0AaI/HE=
Received: from SJ0PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:33f::22)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 03:27:39 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::90) by SJ0PR05CA0047.outlook.office365.com
 (2603:10b6:a03:33f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Fri,
 6 Dec 2024 03:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:27:38 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:26:26 -0600
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
Subject: [PATCH v10 21/22] platform/x86/amd: pmf: Drop all quirks
Date: Thu, 5 Dec 2024 21:19:17 -0600
Message-ID: <20241206031918.1537-22-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 28084663-3a16-401a-335a-08dd15a5efa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjNBd3RSeEtmeXJneWVsUmdTaUJzR25pUHlpQm5aQmlaalZ6OERxWnhISC9J?=
 =?utf-8?B?SDZyL2xMQTQ4OWg4bjJZNDZNWHBmenJVak9zUzRJKzJKRUhrUTl4M0FiZ2pK?=
 =?utf-8?B?aFdBYk01ajFkeStpaXRBS0daeGgzUGdGMVh6VlB3ZkpMS0lFY25CRk5VY2J3?=
 =?utf-8?B?QitFeGdtS1lLVVgyWFBuZ0JPMStxV2ZvaTVmUVcrYnZvNnRBbVIrM0VxQXps?=
 =?utf-8?B?NWZVU1RQL2t4WlZKQkRHVU1DZ2FBRVZWSTJsS3IydjEyMFlBRWt0a210UDZN?=
 =?utf-8?B?dDc5RTJvMnJLdU1IZThBTzFyQnZRN3M3N3FVM1M3THVjQWl6dFJhLzlEaXY4?=
 =?utf-8?B?cVh3MmVybzlEdEJQdTBkVzNjYlFXSXBWZVlhV1pDMHBCS2ZmZEFENzdTQVdK?=
 =?utf-8?B?U1k2QTBrUFBPdTFxcDdIdGR6ZU1jYUNqbVZTMTdreFJGTmNmSllucUJyQW5z?=
 =?utf-8?B?YkJ6d2xDakFJWkJwK0M3V1JpSlUwaHRkd3lXSzJqSGd6WURIZi9sRGl6RURH?=
 =?utf-8?B?a2hmZEI2ZjZJeTBXV2tRVHR4OU9FbUgwNk9FNjQ4SVM2VERrVTd5NFAzQUlD?=
 =?utf-8?B?SkNZTVo2ODNoU1pRRW5mTjFBRUhVQUk0Z2tWL0ZxeDhtMnRZOGplUXNpdWpv?=
 =?utf-8?B?a295Yzc5aDlBMmN5cnFpR1B3bW15QkphQ2cwSE5UMlNxck14OVl2bjJqNXVr?=
 =?utf-8?B?blBUQ0Rad2lsMkJ3Z2Z3anludTVCMGFIMmdRRVllWHkvWXBTQjBVZWtvL21o?=
 =?utf-8?B?R2ZVWXh6YXhXWlhHNEJReHRwVXJzVHBQZ3UrR3lIOTIxWnJzRVJVUzBLZGwy?=
 =?utf-8?B?Y0E0VnJWaTdhcW5YSkdzN2pmalFkckExN0FkOCtadGhVcjhwKy92U1NWakY4?=
 =?utf-8?B?b29VZWhEUXUyNGRHSUxnNGlPVjdQMVo1b2hTUTlDRzVnU25aZkpVemtnWlhB?=
 =?utf-8?B?SWFpU2hGTVA2SHhKVElIUDJUbEFSSU40UUUvcXBkUHJ4NXZzZTJiVWE1UkJL?=
 =?utf-8?B?L1lnZnJMY09WN1ZML25ZVWRRenBhRnhuNm9vWGx0MFdEL2xLd2FKNnRadSt4?=
 =?utf-8?B?ZG1ETmpnUW9raFA5aEMraU5DM2pQR0VwUjRUSzdBak0yQ09yZDVwdWMzcEQv?=
 =?utf-8?B?VlZZRTVndUpodTdWblJJNkFxUEh5b2tKQlBrWk9WVCs5Rks1S1pzUURSWWlR?=
 =?utf-8?B?MVZPWlU4ZzVHYkRRdmcxOEt5ZHAyT0ord0thY2VwT2dpK1liTFBxZFRwSnAy?=
 =?utf-8?B?V1hGWUtvOHFmZXhtd3oxLzJ1R24yMzd2Rm5ud0tBamxaQ2JJWm1aL0lrMkF6?=
 =?utf-8?B?ZkNpbFZDRi9vaC9JTkRhM3pRTmRKdGtUb3R1Z1RWQlZCYVQrR0NhRklTclU4?=
 =?utf-8?B?djNJK1Vqbm8yWnc4NjNQazVKMFJUVkpwYXN3Mmh3SE1zc2pMUU1Zb2hJaE9C?=
 =?utf-8?B?MnBEV1JjZTk2dmdBY1VDOTI0WExXS0V1VXFZUVhtMnJ3Q3NDM3puT2hJbVlz?=
 =?utf-8?B?QjJmRG5ZSGVManpJRERnV3k2Zmh0QnIyVUNaL1dUK3Z1SHpHTlR0NUVnRHpV?=
 =?utf-8?B?UVoyZ3lOWUsyNlpNQ2xMWDV2aWl6dmlTcHlWeWxjaVJ6QUV4VlhLK3BzMkx6?=
 =?utf-8?B?QUhzSmlkRUVjK1graGRvUUI5OGQ4RVZuVTlxSnVTMjJFQ282MU9heEozdnFM?=
 =?utf-8?B?NjhEeVFtd2l1UlNFc0F3Rk5teS9mUC9RMmp5UXpjcmx5Z0k3L3JGNjJGUzFr?=
 =?utf-8?B?M3ZrcGQyRnovRlhuR2VZYXJhQUNvQXcvTDZkQVdrbmxRRm1oYVAyTGs0b3dH?=
 =?utf-8?B?eStPVmE2WFVLSnhUdWZGbFRTL0pzK01ZRGs5ck1sT0tDZzYyUTcxaEdYYjl3?=
 =?utf-8?B?WTFVbWVUNTZheW51MERZUDJwamdVQTdDaUNrWGZhanNCNldrTGY0NjdBZG1W?=
 =?utf-8?Q?VzYZOHd/k1OfCdL+KRfx3GViardlTJl7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:27:38.9153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28084663-3a16-401a-335a-08dd15a5efa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338

As multiple platform profile handlers can now be registered, the quirks
to avoid registering amd-pmf as a handler are no longer necessary.
Drop them.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmf/Makefile     |  2 +-
 drivers/platform/x86/amd/pmf/core.c       |  1 -
 drivers/platform/x86/amd/pmf/pmf-quirks.c | 66 -----------------------
 drivers/platform/x86/amd/pmf/pmf.h        |  3 --
 4 files changed, 1 insertion(+), 71 deletions(-)
 delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c

diff --git a/drivers/platform/x86/amd/pmf/Makefile b/drivers/platform/x86/amd/pmf/Makefile
index 7d6079b02589c..6b26e48ce8ad2 100644
--- a/drivers/platform/x86/amd/pmf/Makefile
+++ b/drivers/platform/x86/amd/pmf/Makefile
@@ -7,4 +7,4 @@
 obj-$(CONFIG_AMD_PMF) += amd-pmf.o
 amd-pmf-objs := core.o acpi.o sps.o \
 		auto-mode.o cnqf.o \
-		tee-if.o spc.o pmf-quirks.o
+		tee-if.o spc.o
diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index 06a97c533cb85..01eb9ee1eccd9 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -456,7 +456,6 @@ static int amd_pmf_probe(struct platform_device *pdev)
 	mutex_init(&dev->lock);
 	mutex_init(&dev->update_mutex);
 
-	amd_pmf_quirks_init(dev);
 	apmf_acpi_init(dev);
 	platform_set_drvdata(pdev, dev);
 	amd_pmf_dbgfs_register(dev);
diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
deleted file mode 100644
index 7cde5733b9cac..0000000000000
--- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
+++ /dev/null
@@ -1,66 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * AMD Platform Management Framework Driver Quirks
- *
- * Copyright (c) 2024, Advanced Micro Devices, Inc.
- * All Rights Reserved.
- *
- * Author: Mario Limonciello <mario.limonciello@amd.com>
- */
-
-#include <linux/dmi.h>
-
-#include "pmf.h"
-
-struct quirk_entry {
-	u32 supported_func;
-};
-
-static struct quirk_entry quirk_no_sps_bug = {
-	.supported_func = 0x4003,
-};
-
-static const struct dmi_system_id fwbug_list[] = {
-	{
-		.ident = "ROG Zephyrus G14",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "GA403U"),
-		},
-		.driver_data = &quirk_no_sps_bug,
-	},
-	{
-		.ident = "ROG Ally X",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "RC72LA"),
-		},
-		.driver_data = &quirk_no_sps_bug,
-	},
-	{
-		.ident = "ASUS TUF Gaming A14",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "FA401W"),
-		},
-		.driver_data = &quirk_no_sps_bug,
-	},
-	{}
-};
-
-void amd_pmf_quirks_init(struct amd_pmf_dev *dev)
-{
-	const struct dmi_system_id *dmi_id;
-	struct quirk_entry *quirks;
-
-	dmi_id = dmi_first_match(fwbug_list);
-	if (!dmi_id)
-		return;
-
-	quirks = dmi_id->driver_data;
-	if (quirks->supported_func) {
-		dev->supported_func = quirks->supported_func;
-		pr_info("Using supported funcs quirk to avoid %s platform firmware bug\n",
-			dmi_id->ident);
-	}
-}
diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
index a79808fda1d89..64ab532550ac3 100644
--- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -797,7 +797,4 @@ int amd_pmf_smartpc_apply_bios_output(struct amd_pmf_dev *dev, u32 val, u32 preq
 void amd_pmf_populate_ta_inputs(struct amd_pmf_dev *dev, struct ta_pmf_enact_table *in);
 void amd_pmf_dump_ta_inputs(struct amd_pmf_dev *dev, struct ta_pmf_enact_table *in);
 
-/* Quirk infrastructure */
-void amd_pmf_quirks_init(struct amd_pmf_dev *dev);
-
 #endif /* PMF_H */
-- 
2.43.0


