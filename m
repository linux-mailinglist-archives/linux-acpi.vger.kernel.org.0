Return-Path: <linux-acpi+bounces-9404-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4AC9BFE27
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6F528295C
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271761E1326;
	Thu,  7 Nov 2024 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ImkGRgb6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F51E0DDF;
	Thu,  7 Nov 2024 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959445; cv=fail; b=lB1pTFrmAo+HKRH2/lir7ZINrMLzbYbuy49bnF1l63kD0nFSUFzSrqivMCq4mESoWm7ku8Cern28gXU7sg6YjMw7wBdCHAEJgBPwt5ECKCeMjmKrrlNk/5j00DPYHntJULsoUHPweRDc4ZzFV/MFCvOj+CUNtmYMgfkM7TT4wA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959445; c=relaxed/simple;
	bh=wydFZq9b9U47n3suMunKX8B3Vmy1X7R/gKQy89bbhQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/CyCRbZBu5C09Q+edu5wzZ41DloNZbfkKEdQynVQWnRNkbAgZm/VvAp3/rkH4eMi5k547ENliXs9TEUDbv2Q1thpUlrwSk9Cus6iZqLZUAQ/7hdWXLNK+MBAKM1GAmkVDa9AUq4TnZG26vQ8mRwrCblr0v544FVcHQ15SBmZOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ImkGRgb6; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4Zk3lZFS2Q2Z7vyCLeZhy2z8abmu9tZZ059nl+bZRrVmhaUh/+GDFQ2ZEc5HXWoQcK9U3+OeqNbPJOztpxz0LleWvaPVjaTd5N+9YuPIg59X/l3+R8uwEQ7n3Ch+hnEBDfUYMnqb6Gml52ZAVTeoXezLHu+61fdsxYi01ARtTVUHGNEftqwIr0asahj0ap8pX/lfyb9OaK3nILOEqkeMp3c2s1oaGykpCkPRVNy3AW6x1BOfLIDEy11dOM8R16ZYW9RXkSAAEY1zn9W+eyHZx3Qe8ZRta32G7eEthuijgJcJBiFJdOpInsKRNh/dcgswlXud7fl95N15y7MYdA3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGd4uyuf3IiVcajgihcX5MqVnqZNO56nHUgYLRj4468=;
 b=R2lo35xBl5BqoiiziYDkCeQf3KHOMGfYvyKwrmoQH7RU8wx5R0H1VOtj1jrn8SlZzlUSxGpbNOaWOOcDrQsYZA6OE1YJK+35dgSXVhfRPM8k/mlwqNz4L9Lhgyk8jwAXprnv0+lXr/+JtmFC7FVxVgoMH9xkcVYTqqM0Bv/5+bUzgJhRZe24RX26t58V5BdN02FJDkHSzDHKlnEMjdJMGmKh2Ke1ztLNlDRbBXBKRfSlEIR/1VQmRJmruibDPrkh0Ms+ExWPnP2kdXhcqxBE8I4nutRRRLqmrmTPxjnzwOfhzuQDzvMXGqra5xsiaU432IUyO0MUwdaenu4gkakK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGd4uyuf3IiVcajgihcX5MqVnqZNO56nHUgYLRj4468=;
 b=ImkGRgb6KNtHLm9KD0kKr9eDLwib3YmOtAqJvzCZHjtvKYqFPkBDmUcOqsz23Yw/JxeSmd9ZLialayxUVGvAYykj9I0bV9zWPOYsie595M/vQC1ulypm1mYRjlXZo6LPkzBinkcSF1BcR/EJpAA2F18fN7oPPqZcCvmsuyo2J8Y=
Received: from CH0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:610:e5::10)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 06:04:00 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::51) by CH0PR03CA0245.outlook.office365.com
 (2603:10b6:610:e5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:57 -0600
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
Subject: [PATCH v5 19/20] platform/x86/amd: pmf: Drop all quirks
Date: Thu, 7 Nov 2024 00:02:53 -0600
Message-ID: <20241107060254.17615-20-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107060254.17615-1-mario.limonciello@amd.com>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: fbdc959c-eb9c-45d5-8049-08dcfef1f8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JLbd9yiqNmOW+v9PMuIwCZd5ybjqmlSTMbaKDVDkgUoyAHMXc01sxS8JyU5q?=
 =?us-ascii?Q?o8zk9x+JAH/5A295syI1sunBjKocDI21n80HA5tio/4o/RDiQyCQoEpIfrIG?=
 =?us-ascii?Q?kPPeGCAIVFTHk+6lCZTJdqZLNqg8LVrDAjBXnwxlxLdJ/f6T43ZJ4YEA/SZv?=
 =?us-ascii?Q?TEyILWT9lhCFXWp65amPOqlJnun3PYnWTQvfANYgvqTACcUhV8XzFi8p5NjQ?=
 =?us-ascii?Q?uM/kY6mznsGqYrwDFCt61WUxYlrVK4mjn0+DQmpRmowwYCagW28fHULSmjw5?=
 =?us-ascii?Q?mUWL0wMJ3Td7gFLIfcg/EClUtjqmHF2kBOHrLdQYOaAudwghBv461BbjCnj+?=
 =?us-ascii?Q?RDTtuFnrk1Izan9qCAP1BGvTqS6+vhgW2VTVoBlIpf03i/ouDB7np5E3tNJU?=
 =?us-ascii?Q?yapstRD2giBgbuzTdo2HcECz0s8BOqXVQqcB+J11EmGB6WnroGHUI8DKdoKo?=
 =?us-ascii?Q?rx5RuJytFlbZKI0HfwTYKkF3+it5oY9daTp6Bg3rbpu+1ENCdqNzoU7yzu2u?=
 =?us-ascii?Q?7TTyHCMR86yli2ZFLqO2UagI6eWRsRXTgRFnZkfY/4/hXJKraBz+X6gumPHL?=
 =?us-ascii?Q?IkRMBR0mPG46Tg1e37q8idLeJLkOgeQuP/fwJreAW8GvnPDjJEB2ESL/TZrV?=
 =?us-ascii?Q?Bg4fid3vjF6vZ7foOD2alTQqTEwxZoJddhxeLlhpOXLq8I8rHf1UPFjqLyZX?=
 =?us-ascii?Q?DOcc5JjVCVwx60galdNdkCjWknAxb7619DgRYcUik2kGbnF/cNMSpmCHL4Hz?=
 =?us-ascii?Q?TeiYYq6fRyzVWIoE5vk71BQAsM80fzNw/FxcDcj0ps+Q6nkIo/y8M7vGQoAS?=
 =?us-ascii?Q?c+xgPCuPwAxThgH+GKht6vUr9r+X0DXSZsgPiXi0bcXhT3qgnrB2FAg/zS+t?=
 =?us-ascii?Q?jHTx/3/Wjc2qhDd18hC4YcPH2l94/eQBe0071+hiAwR+QR5ZW7ZB4NT5660s?=
 =?us-ascii?Q?qtnB8KbbEXVELwwTRvPvWDOoYw/yd4vOPoat21F+V8VJnyzNlWdbZzWWEqre?=
 =?us-ascii?Q?id2zkTsSF5LpBeJyVsgnD2yA7LR0/EhiwBjv9RuCJ7EpN8/NeucliLEcY1/+?=
 =?us-ascii?Q?efph/7pWZ2e2secgSX/V0QU7kJ4a6Xbi0CIxMCFy3WxTGaVB6ah0lcyrxd/B?=
 =?us-ascii?Q?CFqoUebJKuTOO8aJrGhdul3jVS02+sGLU6r3abeHssGUVSTrh/8cY7lSQm+r?=
 =?us-ascii?Q?V207IlEvC5CXlt0ov+x6FI8MoBaSF4JIE16cJc0cDOP343hOAFTLFkKW+u/t?=
 =?us-ascii?Q?89OlmQFtMp3r+Ewdnt2rigOiLC9DgcO6iJs4t8vsrkApj1VDsA40GxsrGLeP?=
 =?us-ascii?Q?nylN/X9A2G80dJzDTh3XdSQxN4lHTCsDchNqA9tJPHf9SlVEdcCP62BEEQs1?=
 =?us-ascii?Q?Tk4HhR0N1SM8eL0fi9ZSXCLWSW3DHMt9qD9vWXcnMZJxUa1llg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:59.3495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdc959c-eb9c-45d5-8049-08dcfef1f8d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930

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


