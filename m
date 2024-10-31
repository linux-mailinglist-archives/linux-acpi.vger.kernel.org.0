Return-Path: <linux-acpi+bounces-9182-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA629B73BE
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203EB1F245A8
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E711B194AFE;
	Thu, 31 Oct 2024 04:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v/+k21if"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7852D18FC7F;
	Thu, 31 Oct 2024 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347894; cv=fail; b=UuU++dQK2UzfM1RC3xm5a2e5GNdE3bLN96a/Bo2jqSpITJm0PKMAq15Q9D4p1QL8cRkbfssundCelv/7bb+FHjt1Vt180s6APWbnDAKC3VDbeecMU4WCiMxcllb87uY5hYPXh7+0MxVESGphxCw0jlvAXkYKqDjGqaAtjltqFIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347894; c=relaxed/simple;
	bh=5itRs+0Zj3QFTkypBZE0+Iy97f2zvJHrmQw71ikXEVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqm6ckY5GzMiw1IPpSxhTusmUSF1PGvdCz/ocUCYHmYCFXCzPEuIT6NNsEe6L39fP1sTUcqiSqt1le7ICqjRxdxgIefzjKXQJ4GYcOByJ97VTaoGzrr7YRMQvpX9GSTnK1Uz/rqK/pqjuzpkfc+TBkaC8ZMN4uq01d3EYTOEmu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v/+k21if; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sX8WZr8dM5/OE8jDKkJTh7f1/SsFA85M6zLAiTJBQosQfMaXFpT9/KC88ORaX+q2tlFrRxNQBrdCI3Pxv22Eikbc8lkG3/H2rI1Olv85nrZZQ/CiXbdSdG5tThLjBsFkerQcqn0xbZ4qnUvVhF3aRq79y65I5adH4qgs9iH62ovSu0Io0LxbOXGLpPomXVMG24T1D8ZNZUzR7fm8bNwtDNLiZOPAlWYayZeNtipbsUZf0FhYXNWvc1La0gRrK6N+p74qj2j0sZMDuFfSr6NAByAJGD5mtMvevTeuO6I8FzXm03HxVq6D9k3JCDF/lFLry1db2+iLwp/XOcLbZ9gEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ6Mds4UNrPu1FSi+YcGzN/5YmiE7gSWMRjCumN+XkY=;
 b=pXKUx5FJZg8PQYLJcRHk6v49hbtWyerFqbJZQ/DPOjCprc8oU9u81OAhewpw/3LFW0Qx2RbX+yo23GSJUDSLYJktzIINhjwdK1n0ZAppleGYfMHEC5ulusTPYR2J7lr1NnyyAGpJMoTx2wQFTtdk6g14siZ5f64vlqGGMOiaiPQkKJ6pFn4VBp0cxyGGiN5AntvcBQ9rHzsoaz7BH+/qh24yMpFknAIFHHnxwRe+gxfqS9pZinvplDvMjPTYeRn8Bv4nz0sryAxVdxbf6u3kvHRssUXchMt4voNWHFQb9kTyxdPmCPKGnP7twdr6r+vTEnFDTWnVnepdxZqW3ahi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ6Mds4UNrPu1FSi+YcGzN/5YmiE7gSWMRjCumN+XkY=;
 b=v/+k21ifIz/7bglHcqY3nihUX1pI4H2Ow604AZXGmaNAxxlhM+blP8pURZ5TAqHhsxZetPUlaIXFDmusSs0ym0StvDanjsvg+Z7+jSLBuIVerkTSJUJ3U1+nRLFCrGmApyE77CdMZWMczT78wVAmwBQBHuVJf7Cwnbff+wBZQUQ=
Received: from PH0PR07CA0036.namprd07.prod.outlook.com (2603:10b6:510:e::11)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 04:11:29 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::d3) by PH0PR07CA0036.outlook.office365.com
 (2603:10b6:510:e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Thu, 31 Oct 2024 04:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:11:28 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:11:24 -0500
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
Subject: [PATCH v3 22/22] platform/x86/amd: pmf: Drop all quirks
Date: Wed, 30 Oct 2024 23:09:52 -0500
Message-ID: <20241031040952.109057-23-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031040952.109057-1-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc927cd-9d00-458e-6b9b-08dcf9621853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0h93YJ2duLOsdai70cEdSt3bKVy0U8PysPcc407u8fAsYGi3NmHpTHUhCzRR?=
 =?us-ascii?Q?0I4wtXCeo0UuWn9bJQ5dYhlqmTr+s7fq6EmNVzabcMBwX4XqxXSFHNJghqCK?=
 =?us-ascii?Q?sU/Xs577ivsJD770VjruYMlsWYkQXBe8DZ02ClTU1sjLFiK5o69P9W+JMSEQ?=
 =?us-ascii?Q?qbDXQslq8uw7n/Fp9Pm2X4V7Q3tOhWhSFHv772DogsXt5FA5dkReOXYYodVp?=
 =?us-ascii?Q?GIS8ANCpuGnBrwsOvFGvGFSqmgCWscKU7oUqaYtBMism3DfgiuCi6cfQR57i?=
 =?us-ascii?Q?JudzCQsELQypty6hYry7z1PfHc3Q0V6dKt7S4jMhosqUnHW2b5g3bBLAgM+3?=
 =?us-ascii?Q?eFmGxb67FNEa0PNKxu6xCBGZBZhvC7HbBQqrK8Q4VMoZi9P93buT2mx5Y+6W?=
 =?us-ascii?Q?llI9jQPK5xJiPLo3QB29pcDt4nwzH0sKpKWUSd6AzpnqHflzNugNB/wKEKww?=
 =?us-ascii?Q?E4Lx2kk6oP+N8lwZMsn9Dn5Wq3soFuB7ak/Pl95niQ06w+OeCl8cUEl4MhLm?=
 =?us-ascii?Q?akDmKvBJQzLk4RAk7fcucS7v5hL6P9y0VymAEjpecJzYhLeT4YbYi52ZXOVU?=
 =?us-ascii?Q?eP9P9TioShaisDFLDswoCwFplwxy4KuSB8LyMXhnmQymoivtiIBnYd99jqat?=
 =?us-ascii?Q?wExPwyETTc5QCutjX6y1o66ekmzslmyjgN6WfshsBYwkJqvdmrAGC5AC6Okd?=
 =?us-ascii?Q?97/nvP2FfZSpgFG4N7nyYvzOd3RzkiPS6rs2zY8cNmjg1+6z1hUlG1sj3oGd?=
 =?us-ascii?Q?sOWh81zI7LDajUVziJCLFqDC641QXJh+bINjcQRQaqQPr5RsjFN+CHxPuZ36?=
 =?us-ascii?Q?0EOdsJ2BrHFso0W9yntVXbmNaCVaDMQeZGJlBRRoRcVqsOdbURaPXRAVU+5U?=
 =?us-ascii?Q?QY0NL1COTQ4SUyw/RhloWMIuVVEVoh6YK2TxzhzUj46r4BCjkb+tubZ+qIf0?=
 =?us-ascii?Q?5FzqaCDfNl+GJ/yHmdxrsMGX7b0J7KuY1f1sHYovnm8A68XM+pKq4xTsdmTU?=
 =?us-ascii?Q?KeB7P0SJIFSWTU+B9PJVMc4Q7YYg8uHnQ9i1kDzHP5aluIGaoFaviTkeCVDy?=
 =?us-ascii?Q?2pArL2V4JT1JhPpo0SSNK7hi58VaJ8Upr0XbFcRSLAESNgXGcUv9Ut17mRWD?=
 =?us-ascii?Q?L1gN8V+y07cpGvrkocyCF6XFKby3pUP+n5/uQ9i8T6Jp8KhK+NSLbfUEwl6f?=
 =?us-ascii?Q?DudngaqgofvPhQWO8KE5gtOOyoUSMAh9mLkwhutGZnLDCGKykR33JwSb8UF9?=
 =?us-ascii?Q?YBPkSUv68XHHlyxf4f0MSNMOwSoPS/pChb12hJO3U2EvphdtQI2Du7ABu2eC?=
 =?us-ascii?Q?1rzDB5ERBJDmrOEyoOPWOu4PUjiPkFWwWRRk0heJpY/CMHXxSzRb1yDMkRnx?=
 =?us-ascii?Q?2bmcOKCR7MIiNawmHXVdkAnZEwMSwOjPvz/iXZzOz/n6l7GnTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:11:28.4530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc927cd-9d00-458e-6b9b-08dcf9621853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025

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
index d6af0ca036f17..ffec0a64a82e9 100644
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


