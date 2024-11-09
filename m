Return-Path: <linux-acpi+bounces-9479-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9399C2A18
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E263281741
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038919884B;
	Sat,  9 Nov 2024 04:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RwWPN6Bl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958C71442E8;
	Sat,  9 Nov 2024 04:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127386; cv=fail; b=BT4zjrxztRwvFWo/7V+uhva3mtD0tjMNSkFJE0p/PndiBEuiwyyNEFquQkCM1nrT/1Iqbxr7Uy86SXINqAUhRY1jK1CFz3OmZ2VEEL0eA16TLPMR2yUBE3Iap48SpOfEd8NGb8ycV+dKKnlnMdnYEtClaH4dGIYB3qZfQhYIkrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127386; c=relaxed/simple;
	bh=wydFZq9b9U47n3suMunKX8B3Vmy1X7R/gKQy89bbhQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfSMeJFH0p5KyjAgElMmVom4szWohoVnCmF+BuQ7Uz0j/Kh2yHIBWE6tijn4udseKDJzFbQasl31x9ceBXg4jbv5nt58MPxK4BSas5qizjgAVlOaNVlVQHVdsj4fHOoY3u4oEMlAXt7j57oZ4xEGtgUKQJJcUHne++mh55T7drw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RwWPN6Bl; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhUAV/aEeojzSSCSlGPE1Bi0xnSFRFQnaDyKkG30G5cO10tUQQNwY8FzjS8Bb8ISFp8MiyDFWBZ9goeLqkhSRiSnFQgMH/4C7xH7toj/5m7AOekgmkZd08AngeVuQ9V/i9PoAtizj/eF2lJ4Sgb5Ku6HT61p1HeAAGAr/S7QP8DhCpukPxVdHLnKdRInCmd6XETKfyRoAnqmTIQMlWUkrajKVxh2LpVlCldsuQ5AAsmwcYujXXQXnwWsni5c4ZK/ikPRDMrGRDGCP3J3GZXCBj/3bef6ODXTWWtsAsWiluf3HAoIMA5bdUdiJNUM748sj70eYzNTKfIR7oEw9QMaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGd4uyuf3IiVcajgihcX5MqVnqZNO56nHUgYLRj4468=;
 b=cKHL8QUwPLmQbXZTvlLQE4Ru6fBz6C26Aw1v2igp9kr0chO3/d+yVJXXciOncwetUqiOVq7GLhd22dq1+mgwR3auV78oh4/jlSRLQJRXulnae1D88E5WgVeO7Pvk/QTG95BbF9ilzfLcF2dSSbWVlRvC66lR+1Q5A3PUG9PR+t5Lp0JQmgVWpTA/RfWLRq2KM25U8VNbnxOCsfsJ5Kp0FBTkBcICRG43cbjjvliZC65Vj+tjSQXYyMFJjfxhvtNCL7Ap0lJaGz7dfG75harXWhld4I6/GpDWsy94KteOyyKMyYjMmpiaFsiRHIRRB49SkDmDAPq59ZUb4fILXr3U1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGd4uyuf3IiVcajgihcX5MqVnqZNO56nHUgYLRj4468=;
 b=RwWPN6BlFnSVQQ4WY2MOLgJ4ux8kDcgN+rzXRa9BpnFdwhkBHWpT1YB28Beq06/2Ka6xMovBBAXX0uvIuXaqy4e8LFS82U59E9TICk+fTZN+Fxmv1/kiMe6QrLq0tHDcG6b+rz5TlzLWiZyanL0SPAQQxMr4dKqwQ0sK3EZdze4=
Received: from SA1PR05CA0017.namprd05.prod.outlook.com (2603:10b6:806:2d2::20)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Sat, 9 Nov
 2024 04:42:59 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::b7) by SA1PR05CA0017.outlook.office365.com
 (2603:10b6:806:2d2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Sat, 9 Nov 2024 04:42:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:57 -0600
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
Subject: [PATCH v6 21/22] platform/x86/amd: pmf: Drop all quirks
Date: Fri, 8 Nov 2024 22:41:50 -0600
Message-ID: <20241109044151.29804-22-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109044151.29804-1-mario.limonciello@amd.com>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 761fe3fd-1243-4767-5a49-08dd0078fced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JrWY8W6V6+36p61bp6YW//t56zovNHUnNGikgVxEoRThgj8iaOaUP2b6Bs1V?=
 =?us-ascii?Q?9olNzuWmh5ZFJXpIMWmIFVaIPz111UY1sPfblx8dxhqsfIK2KLMxLGyu32H4?=
 =?us-ascii?Q?GTODDAr+Y93T6ho22SMITGUnVKL+cwMpjzsuXneFzNnZ8sQYiUiSqnFna99B?=
 =?us-ascii?Q?UZwVPpiWMUXRaC1Vdu1sau9eZ59WI2VYxtRBQqS9cP/mz8lmcfoSaQU05tUR?=
 =?us-ascii?Q?JCCJT1g+Aa7LaaKjM92wgzFoeiA5v02bQo7RZ5l+JUV9JJLQ8bjT+z2dwUZh?=
 =?us-ascii?Q?FxGbouoTqw23yUfGihOUmgECeuV84MXW6MIICM9IVni39cwy2VeAs6qFRhte?=
 =?us-ascii?Q?kVQlRB0Zzoiod0SbcmBig8xwi1JHRkjEClZB1kANs7XnIuLpmIXE5lWf4S3O?=
 =?us-ascii?Q?MUSr94AO+A+Djl7ljJBD3Nosf9c4V5RRQk1lY6Snuo/3EdWjkT2atWbgiaK4?=
 =?us-ascii?Q?m+8Z8UiazhQ6rscDRmI2mB55rbg2e2Ht7b9b0RKD+WuB7gt8ZERr27l2BxKh?=
 =?us-ascii?Q?MS1NVRNa9bGjwpkKnXFeudrxx6F4UwN6lLxfHX0Lz2+cR1lOJ96blMNo/BSR?=
 =?us-ascii?Q?KyRHAJ4OA7/dIRBPZ4PPcitGZ0l5eUr5sYzW0GprYUcdJMfA6uiP24qK43au?=
 =?us-ascii?Q?ygRs+vLsvzk1WeHbuos4uMOBUa7USD2rvlYwL6d5/uTMpJMhjJCQR3dY91z6?=
 =?us-ascii?Q?M7WAsF3IZxGzPv34m0h7mDuU8rDfzWYtf/mYZQd0GMlAw1J5KwJ+mgPR7Svo?=
 =?us-ascii?Q?q29NKvN0ZaATKFilUBezI3nmNilagQZ3PA0LoEeVXVH4vVSxo7bqHj6HPtFr?=
 =?us-ascii?Q?aZJ9ihgaien/5VvkASgqseKZKN2uVhNGYCtAJ6ChZU0/lDMH3WgOq8YOa5tG?=
 =?us-ascii?Q?+qr2ytafudQUE5ofCJdCcLXI3+EuitQDHD+NFfvsOhhr4Xc0EaORUGu56Fuf?=
 =?us-ascii?Q?KS4/YoJpLLBHPm5xTcnDsKpCxMLhOKoRBSkDf0ooPZXgT/x0OGQupGJXV6vo?=
 =?us-ascii?Q?anVdtjp/9sxNdmchViJsOXptTEeCk2wrgO8GawGOgfI5EIRd+vrPtYDtQOeX?=
 =?us-ascii?Q?irYyUT+T4qwcHLsP4YHbQ1qupL577iTcEf5efvOs2se4Yh7ktKnfG/02i2VE?=
 =?us-ascii?Q?FYsXyFSTrYO44FFd+I/Ugz2lMiJsTf/5oM2WpxQmNJ5XF+H7TCGImHtRX6Xz?=
 =?us-ascii?Q?fzwxm/ztbivySd9d66UDSMA2fQLBT+JrugYoC9JHj/9L9cbBkPqku+h28fFj?=
 =?us-ascii?Q?38kD5nNeFBJ/YCQSoiQp4XtR5JRy1dx2LJSNqQeWutezng8/rQZ48is7ZF7A?=
 =?us-ascii?Q?rQHqBh2mm71J9PR5qvrIoDWLv1H55ZUMpfx0SQYqEXcrYHd2YdZxAp1Y3/G1?=
 =?us-ascii?Q?tVInl+s2EEnUeiIZv0m371mBGu7/BHRT7rWOPRbQzFwPKx08lg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:59.5186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 761fe3fd-1243-4767-5a49-08dd0078fced
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903

As multiple platform profile handlers can now be registered, the quirks
to avoid registering amd-pmf as a handler are no longer necessary.
Drop them.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
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
index 47126abd13ca0..6ad00b3d472fe 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -455,7 +455,6 @@ static int amd_pmf_probe(struct platform_device *pdev)
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
index 8ce8816da9c16..b89aa38434faa 100644
--- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -795,7 +795,4 @@ int amd_pmf_smartpc_apply_bios_output(struct amd_pmf_dev *dev, u32 val, u32 preq
 void amd_pmf_populate_ta_inputs(struct amd_pmf_dev *dev, struct ta_pmf_enact_table *in);
 void amd_pmf_dump_ta_inputs(struct amd_pmf_dev *dev, struct ta_pmf_enact_table *in);
 
-/* Quirk infrastructure */
-void amd_pmf_quirks_init(struct amd_pmf_dev *dev);
-
 #endif /* PMF_H */
-- 
2.43.0


