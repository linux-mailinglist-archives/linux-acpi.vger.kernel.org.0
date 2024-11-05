Return-Path: <linux-acpi+bounces-9315-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 020D89BD0AD
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FDB1F23346
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61C11E5735;
	Tue,  5 Nov 2024 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mD9TRaqV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE11E412A;
	Tue,  5 Nov 2024 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820837; cv=fail; b=tWaxZD6kWfjdlX45qV9e3+7cULMJxREGo+nap8vEvd9yYnKgLi2yUxom4xPcbuB/iDgdNUMtV109m39HJFcUrmoqOH/Kq0MGqmhm9fhToYkF3bxmQGw2zdsPxEo8+rzwk0baGlQYubfINBnwimpl3HppXYTfWXluz7tdpAzth2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820837; c=relaxed/simple;
	bh=Yr2DwGP3stibvV5kDEhUIRooOkkRhrchVHVPrM0URJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDPFIwj3uPrjkbPwAYxGsofnVxJTe7Tj5jremf8iezLAHPT9OG4sc6ySYyydJqSSBbjsY4oiowE5hg6S3kaEwATOBwNVSlRBMGrPlHgJmHZHym3Rsv3BgYY5s4Kv9hkpvGIA2Mq/bDIp0mT/fZvVJyVVDF0/V29883VKd6FnNLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mD9TRaqV; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqWM5SehKn9BYuhbGHfHJ9HbmJ+vhqIx4qZWM1AZYGCbnfAOY0JsrnD1JLQA8DylnIDhc7WeO6MQhtzUrQx6AM0uwUOeETeDh4g10P4Rjlz2fwG5YrO/Q0BDSoFf7uIrUQXjVInGsEnCx7yRUnSAG5r1YPFJ74WEUY8eZ28ZynhZ0posbK47/dQW9+RgY1RxhiHDW51A1b4TvpFFcnW7aQRH5r3IwZcw9cLx80NIHbAWaeKXyhggsPuwhmIrTV5ucQMYFdHH/uL4JlpzlKS6x3Lo8jO1C8Gn9y0Pgk0nko4Z7lAsHJVIDeZ0yIgzJHRFsxgmQOsj2IsdU+kE/oDYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/3tLlKeu+mu2+ZvcCVORU2kQj6qVksAflAgnmkPtrU=;
 b=p67nPGg+QEpjki7Up/ozdBk0U3WdjoYQt80Ti/0bQJTInEmj8aES8tTK7RYhETc2LS23rTjDhUsWMNoTgkpgjDK1ppH07L491x1WRotGYVMgai9Kaf3NMh134c5IV+uzQhIGDtYnMlnn80FRhCvBecI6B4cCoCbsTEvqV6rpMMTZYcHY1MAbuXxa2XqCYm6G+5maVDZBONZVQdX28ImvcruWPTkGp9qA2DOu9VgOLQPQ5JekvERONa1pvPMq8ZJSPZigsfWkkh4vNuFyEViYAaOEToTNUfYn3wj/ZogTjLedh6iiXDVOqwhi+Se9kloViHkXOdP7Xajpglzqb90SsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/3tLlKeu+mu2+ZvcCVORU2kQj6qVksAflAgnmkPtrU=;
 b=mD9TRaqVdrQIUBcC5i3L5S+NzJQK/vD+TvKdfOjycYIh2MbUOiD61Kg/xWPxgPOui16H5/+9ghFzgKAj/L/N/cIItMbXI0WhY6MABSyyYlA8ktks7QVPX8hcjDi5rCb2JgtLNlDdv8PD3OmUS5BWe8vmy1532fNe7D9uFdb3AEY=
Received: from MN0PR04CA0028.namprd04.prod.outlook.com (2603:10b6:208:52d::27)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 15:33:49 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::e2) by MN0PR04CA0028.outlook.office365.com
 (2603:10b6:208:52d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:49 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:47 -0600
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
Subject: [PATCH v4 19/20] platform/x86/amd: pmf: Drop all quirks
Date: Tue, 5 Nov 2024 09:33:15 -0600
Message-ID: <20241105153316.378-20-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105153316.378-1-mario.limonciello@amd.com>
References: <20241105153316.378-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a9210b-7e9a-4e52-6ad3-08dcfdaf3ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RmLjdV+zvhXv2OFox4hPVs7phVw34ieHAWFNfPk8Le6rI7cbu7zK/ov158k8?=
 =?us-ascii?Q?CnCRGqxb45m2c/o/NII/EmDAkg275JJJe8tUsx+6XkUxupvt69ZDVAJZPfQj?=
 =?us-ascii?Q?c7E4xxRRvCIMQIh2cLmEuxoTms2fE05vSFeuKjJlEsC2ts+gyNoXXPyfuJS2?=
 =?us-ascii?Q?Xa0GBmHiiRsEfclbY+9AHhN9cUa/gpPie5a1FQng1T1lpkwwnr2OECx3W203?=
 =?us-ascii?Q?6HUG68eh6tw4d8rJzrSrrNnMNsNOBYILcqnLWiEuSy7YJxYY4lW6/TShPre8?=
 =?us-ascii?Q?ToS8aG5Qa6Yn3gjprD2nEhH9J5JPI/lOB9gFEhDKhTUI7BmhrgzUehhhioLX?=
 =?us-ascii?Q?mPZaLoWjPIeMoWmEsAzhTl+GJxRdLRV62nmDtVGf6CciW9Ez5/bDLtXkFOII?=
 =?us-ascii?Q?pH/OZD73xirjlMigMX4z4ARPAugQzv7cB52dN915hToBEOQumYrhjuwFKVOC?=
 =?us-ascii?Q?1YaJGwSCqWpgoWq46zi6Ni4X4psl5/j3ZzRJ+t4rm2YJhI70PMt/kaWafDkz?=
 =?us-ascii?Q?8sWH+PLFmgBTvKup3OoAb6tX4V8BaAiRlovJ9Kv/UWuKNgPRtbn+5Yc92ybR?=
 =?us-ascii?Q?cMuKNkysScqV8jwx4vHUjs7+H6DO/po+g5fJUwLLiSedQ1dCucJg8Rx3X/Dd?=
 =?us-ascii?Q?2QW410PIlO3CGEpYJgcZGpBxLN52Vfqp6Oc2DgoIbOSVfByG2zG1MjD7J5dF?=
 =?us-ascii?Q?9nkSndKchGs71oGVrgq6l9vX/RbJQjm1sdUg6c70db2tAC5G6VhGXBU6ishd?=
 =?us-ascii?Q?IratUJ40jkHYX1IcVHLNuJcnJ29J+AZStcu3QlrFgFoshb0Z2romOFU6kfW+?=
 =?us-ascii?Q?Pu/hzLYN7oQNh4j+V75glMr96fQbQWrIASEB4DHH8WRTesr+RSWVd0SAsLOO?=
 =?us-ascii?Q?PwCvgpTkx+I6Ci0U6+Rr2FR8dA5rLEDd8lZExhkuMZAwUVFYSUIDynW5ySYd?=
 =?us-ascii?Q?reUcpH6ZXVxc9VeiKMiIgTmspKcYDkvUfDvcj91kwNumpOjFpL3NzWQtkpCn?=
 =?us-ascii?Q?aaD3Zllk+IWR3G1DBWHI/KLDZiaYCXWBUxYu3dQ2UXrYLcWelxpYiGEK6fPn?=
 =?us-ascii?Q?Zk+SOS/c1k6YSL/gtZEaZ3B/g4vO7oYbscJjzWABTH38ArLno9IMgpZROwxv?=
 =?us-ascii?Q?Xo70lBOeKVI4CzG7nPvdOptiE5RQ02tFRt8IVl9hZYbeKrJ6bMDiTg4K2nj5?=
 =?us-ascii?Q?mcxze2aD1B3Osx1pBAzhEnh4t0iLWClTLpcnmYUB3N/ZghYFdqPn7eHeJp9B?=
 =?us-ascii?Q?Pm22t4FM6Uk0SLmFl69vaxTpW+lSO8yTFUtokb/bOJM7TT1CvtozDqWhML/z?=
 =?us-ascii?Q?gqbY7f+aveimxCNE1JkQDmbtYiCVG8U4JIUrrQ9Tivbn5G1I4G9ClMOl2iRE?=
 =?us-ascii?Q?GJWCKAaXjMcXNh4QnYQDnYQ/twu9o23N1PW/ouzvNQHq66aMzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:49.3110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a9210b-7e9a-4e52-6ad3-08dcfdaf3ec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900

As multiple platform profile handlers can now be registered, the quirks
to avoid registering amd-pmf as a handler are no longer necessary.
Drop them.

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


