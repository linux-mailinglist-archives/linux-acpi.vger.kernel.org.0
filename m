Return-Path: <linux-acpi+bounces-9866-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397949DFA86
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9279B23453
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46B01FC7F4;
	Mon,  2 Dec 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qjW/wtUI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F51F943E;
	Mon,  2 Dec 2024 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118734; cv=fail; b=M6s34OI5F3exhqlFWj5P+B8wNT9Ffg/EiGJTs9NdE3T0OW6tkB2WYPg3FVjZ1MMzn/HpD/jCCgMvCI4s4mstR0NwS8Oc+0+50wl3ZlNKMrvHEZe97774qSAeAt1z8cSGEv2N19ycUO90+jBltupM7snmJ1WfUx7W0OB1LY9IdLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118734; c=relaxed/simple;
	bh=gnBSoFNrP8JY9HMIGKwmf6pitl5xXDFNXwZjpg8UPDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUuTByN3quMUi9rW44DiHwC2YpRWfY+nNnnTDoE61mrQ4prrOKjmh7Xf6uIDoNh27zHSAnw28Cq6ViRh0wyABGoisLqAG5H1m2bgcHcRKrkS+5n+GKLsCMqOrl6VcKbJeQ79IrutTp+mGj+pg7iZ+akqdFmG9Le4Gd5KMgmDGdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qjW/wtUI; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PChU1GdA+vTc5+XXUQxoA/WYp7Kg+fLOfhxinqja3Ird8RyT9S1ofGVUQyQ9hXBzaGMIiqPezGjGkqvznvRKHBbZ/E9um8OdA55b3JcgpAmcHnJbc/gSxm9Vdb/4Z0k6fNcxGUPhPBsM7fkR2DbPrMeX6ptJRWItslk4B2Jv9grjoPyWOs+2opSyMiEVa03LJ5Kw7BSUAruhoZTOn3GvoiHGvIPAsGKhsekGrHsomWw0OBjLPfZjEfUGhfRZEelu71cbwfActQgMoIkDNg5FR5ednmuBdbYzEv8mLzARcpAvYn7URZ/BVYD0evhBTv1t3tY+3bufKimijeakcEmGzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvGa/ULj0+7xI0tTFN6XDMWS1c3ltWrpsoEcLfQvXj8=;
 b=vVlTO6JO/uatGTdkJOwhCFbQGFiRrc1NrIpn+vd/W3bL6jnS3yhE461AJMs39wjHe7ev6X3akkLADygfqdGyLP1fw/ZyoG/KaKQ06HuGwWuu2jIWjXQZsERTOeiHilwZ0HJat68cK88TXl6wGC4PxPc90XPi7n6e2bLkXHwvX6QfrG7TLH9VWm/UDHiUicgIbousrSBI24Y9cLMJX6/RB6ZzI/uJrFjDAAJai9uHBjmfjef03maQEy4FcbtpUIsHpkLsunQFcj4kp4tLQob4gNvegXQu/XV/wrX+rBt7PsRv9tK8JZ7Q8vqXf7yHs1MXjN5Nd1dgqpXc8Z+NbKnDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvGa/ULj0+7xI0tTFN6XDMWS1c3ltWrpsoEcLfQvXj8=;
 b=qjW/wtUIH0mOYSgfkz4n+jdCdw3r9Uczl9MaD+kqZ/Shn1drY236ivUXZX9CJYfCanSynINqYAQY3TF9x1pqXZoPCgRz9oP1ahAdX8jor/hK5Og3mnIUrTruGPhjMXLk26LDORktyrVXaPOuUOPWDqhsSqZ5fBsFAFRwPZUmgwQ=
Received: from CH2PR17CA0009.namprd17.prod.outlook.com (2603:10b6:610:53::19)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 05:52:08 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::38) by CH2PR17CA0009.outlook.office365.com
 (2603:10b6:610:53::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 05:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:52:07 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:52:05 -0600
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
Subject: [PATCH v9 21/22] platform/x86/amd: pmf: Drop all quirks
Date: Sun, 1 Dec 2024 23:50:30 -0600
Message-ID: <20241202055031.8038-22-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 91294c0f-f2ca-42ee-4958-08dd1295751d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z9MWRT6LmYb3wLKvLwWnUIiEFoHEVTgkq2ETcf/L1pSO8vFx6htO7plqAqA6?=
 =?us-ascii?Q?iETFDHU0Wu3rFysmYBECHDvqYfYs62xTYzcdc0CI/WXl2J/eooWLMcRWgO+p?=
 =?us-ascii?Q?ZzgGtzghfigu3wmdDbEArVL7Q4B1SskVqsCtl8pDb/vEGYKsTnqjJKVb1bAN?=
 =?us-ascii?Q?8gVLNmeTh+0SXpvtwgHzcZvlz7lpqEEr1QSfg7OBk8UbufJOrzqaGPMV1yTX?=
 =?us-ascii?Q?bQ6Rlnk14XU5Cdz8M9F+QSEGE9tuTGAOJp9O6jQkSKfx6L0miKqsEGEdvLuv?=
 =?us-ascii?Q?5GSu5k0BXcbPUD9jE9okQX6GrdM9Ozd9wYdT+1RJsog10OsqfKk/7HaZ8KF+?=
 =?us-ascii?Q?YfioNh//iYM6mpepIevcsmWInt/SUHFzMEY9rokvB3UYpoAYj9OT/S8O8dgo?=
 =?us-ascii?Q?ZKdPBv51poo/rnzOYzG5i/QGq22OLlLcjcVQxI69Dp8RkN5qXAy667QG/vlA?=
 =?us-ascii?Q?/lDEeh/Fj2MRg025taOGPXYK/q/ohAv8M/NmwY2tVckbUdZokvOvpBNhDuAj?=
 =?us-ascii?Q?K9o8bwR9Y07K8uFcdPIS/hgE1qLLJ56GaY9VzGTMYBaOgGSMxiVfvIaKBghA?=
 =?us-ascii?Q?jNqkcln5paMhb9Ke3x5MZV3apWFJAGmikuC88IAmgndInhg8vKjj3Xv/8A7V?=
 =?us-ascii?Q?VqyGz/RYJY4ujBlwz0aYrLPsD5O6JsQAuJo1tS6qyfmWF4h89xFUF/uJEpQD?=
 =?us-ascii?Q?iAII0TDR8VV5J19FmlD/l+Xv3MeqJUXxmdbHkr1Bt6IYXxbB/GleO468b6Nt?=
 =?us-ascii?Q?ixdsLH5rDoCZSiUm8yNr6Kv5p8Rau/cIlYNlP7NM/FXifGNkPWlDimel+DpW?=
 =?us-ascii?Q?oPnW+j2Gh7KSY2VKhe9/Tx9lvt+WhKFkbQc4b9Yhngvj9D1KRsEc1bOUDie0?=
 =?us-ascii?Q?zW0tBVwBQJmDadxppNWhKehyHlji5/cGyU7YDjPkxng3N7byeMyTG+3h6qLl?=
 =?us-ascii?Q?jfvdmoFD9V7jdlatSShdh6droCweLoi2qvcKsOmPRle3TgEeZ9ZDMzRCpXYg?=
 =?us-ascii?Q?lYjyJJprbcTJ55Ha36Lgc76Y2SA0PW6dPyrvhgHDR7rJmbM/Mhf1U0F+fC5+?=
 =?us-ascii?Q?BaPDEkT3KhJmk5c6ZGZnpJFa8XjFj0nalZCr/jtvSJ9E6ElvHhUu5/fOr8zA?=
 =?us-ascii?Q?bSwQ7igNxqHaBNuyNNJWe5QXxIMtgN9g62rcAtmx8vDpXwrL886SSzSilZSJ?=
 =?us-ascii?Q?3mZ/7XOEX5kd+bLbARpC0et0cSzAXlrySp5Dwh82HWeiCCKuHULXmH0Rm4fv?=
 =?us-ascii?Q?+Q7RZCzg8uTloPoN2c+WLNRIz8nvwQSlud9P5D7qmJRtdw4CxxwJ82XvafGz?=
 =?us-ascii?Q?aF1s8HhVvqSdoMV+aSVaHUH7pq+7AKRPqsK3mXd9YqfO/CaH9ZNsrJ37ugcB?=
 =?us-ascii?Q?5ke3cddFDpn1oVqHRTyo9llcZWxHpMyuOph678o8HfGpY5gg7FtzBbCMjEK4?=
 =?us-ascii?Q?lHLwW7rZcIsY9J2NXaT/ruhT501rjtkF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:52:07.9977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91294c0f-f2ca-42ee-4958-08dd1295751d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659

As multiple platform profile handlers can now be registered, the quirks
to avoid registering amd-pmf as a handler are no longer necessary.
Drop them.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
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


