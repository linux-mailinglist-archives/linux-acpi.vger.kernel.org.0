Return-Path: <linux-acpi+bounces-9821-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960AF9DF0E9
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540B4280A7A
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87DA1BC9F3;
	Sat, 30 Nov 2024 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0OX3PPQE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E680D1BAEF8;
	Sat, 30 Nov 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975572; cv=fail; b=qet8OpOufF78+V+2RwmZ6iYGYdta/Y5G3EwK3MM0K+ociyJaOhQ7E0sduzY8xZVyPZZYCSSBppRKLhSoE7H6AFg0K5ct2I/ajatR2qn+viqMtLCCS12MgWbl9bLWMoFMz877BD5W7uQzrspfiF7gOmvGSA82bnW7Bk3GQrF84tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975572; c=relaxed/simple;
	bh=gnBSoFNrP8JY9HMIGKwmf6pitl5xXDFNXwZjpg8UPDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bmrxcyh7cYWmzvlSGQ4d33c/yUCYQhD2qT8T6aBpKHDEEwQDonsmf/Vnx/eKit46lBJw3QB4UCCD4gB8GtUcel8l2zT6xNwVxYUnlfncnpPEecoyH1BardaVpQI+JjbJsEaF+C4/2QzBfit9SG2qLRZD0heLZXxj9ANOPNL1fvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0OX3PPQE; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JR3XFxbuKj9nNF2IKJoE/eLjA/t2adjxAI+lK1+zHIEr736ZvpzFbJEYHpnrLuIr3J2JqTmV2XCnN+2L/JBOHxPlYR+QMxwDFCZxQKRtiuCiFT4fwwKj6keMK/kQduuGcOneN6KEfKN3KCrhyq+/6gpLKyXtEeY1KamUVBT+jjlKENLu9aOU6t1N3bdTaX2DBHsGcq0/I5tzMAjbVKK7yB9c0iqGdIXk9oWqsO6c4Ez8RfyStO7ufADduVgnLs8eAHcLRzorwWEcLlbgmXvrsBEzZnaJtLqj8/EKUxI8G3yaMrMX2EeiS4JfWHQa8o2E2xqW548MpE75+3Lb7VYxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvGa/ULj0+7xI0tTFN6XDMWS1c3ltWrpsoEcLfQvXj8=;
 b=OH8cyUkrX+e57itP+Yvxr4fFr/3QoHvlR8BzyIIAay8tJ+rs6IpYEzKWmO/gl2oF4LrM4PNa5Bnuh0OkrvDuKj4dkXubkgoqEMCLV5m7yWllAlRNWzFc1abbvPnL0W5SLcuerG1EUHZTaY0qjFvrYc3OwiXPMMWu5gdN8/a6H5ngAlO23j5Qz6jiNDdLAc3Cw2AgzHlVfyfHETHxsKvkR4JeKyR54m74LM/8iBWB7H56B8WtV400OfJDJU1GFbRWQWVXR42SZLQeWu4K36b10bXQRR7e6gfJK6iD1Smwhj8dIV+b2p/Ce4NZy8kRkc2QK1UiyeyRvm3YK0B3T/3EfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvGa/ULj0+7xI0tTFN6XDMWS1c3ltWrpsoEcLfQvXj8=;
 b=0OX3PPQEZjJcxqBLLnPxD++7Fc2aqJX6EiD8uWsClIfmYJiwuVtJ15ECizEAxWa5b7E+2jOw0gmJUmfoQ/0m5rrSf22xqKcydDzP3Xp5i8enZmHiyMvZbG5jTrT/nbyoA7jovnjFtw1R30/Z/UiwVpIE4pKFK3NCqD2E3LeziFg=
Received: from PH7PR10CA0009.namprd10.prod.outlook.com (2603:10b6:510:23d::29)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Sat, 30 Nov
 2024 14:06:06 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::85) by PH7PR10CA0009.outlook.office365.com
 (2603:10b6:510:23d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:06:06 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:06:02 -0600
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
Subject: [PATCH v8 21/22] platform/x86/amd: pmf: Drop all quirks
Date: Sat, 30 Nov 2024 08:04:53 -0600
Message-ID: <20241130140454.455-22-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140454.455-1-mario.limonciello@amd.com>
References: <20241130140454.455-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a348cb-bc23-4878-fd12-08dd11482233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6mkup2rIGSXkMhPnr06D1UdbSg1bX7K1HOFMgcNnWN//8NziSiAyBRCrdDQv?=
 =?us-ascii?Q?GqxpX+G0RL8WAus2vE8tVR/dQTt9MZ1rdvQnKRGEIYJGAOp2rGyHe9JUlbnn?=
 =?us-ascii?Q?HLysDdGxcilOUeS2Wnanx2hvH6zSN3Ky/EOAgWSsMATqmMGiHoiQa55l8Yxj?=
 =?us-ascii?Q?Ohbd8Yo6rpkUSyCXZAi1KDCgPXID9PtXdu4x+RWyXzBoK4Mpcr/GAoFuLyaI?=
 =?us-ascii?Q?TVNQrqrCc0pf9rHTZehsQM96OG4ONusVeGvhHP5RWW40oJLlF0u+IxmKIrp+?=
 =?us-ascii?Q?JIoL4DRw0vzIdtzSS8RNsnmigor8vJNfvXBuvRgalNFh/xofl7p74o9urxot?=
 =?us-ascii?Q?Dl1kUE03cWHecs9Kz75qIWSfwHj6fw6QIf6YaH/4fVLxZUxyyuc+eD8IxObO?=
 =?us-ascii?Q?aDJU7eM3izdjlPgy7O6qwdKQ88b9DXV12EaBs+wVQyumi3jMroLnc9lFNa+Z?=
 =?us-ascii?Q?eWFjQ09ai9/P99yEY0jqo6BqJ94qBbiZ/TZQP251z2tD7Q5jpLZv6Ig+ikHf?=
 =?us-ascii?Q?V6+F/OAsbl5DinDQLjPW/n7vuDflPw2w3hPhzXHzpksen0x6lpRisRYzeq8x?=
 =?us-ascii?Q?34noJd6jUIBkrL8q8cot4jzJkyXFeNnwZG+3JdjmIwQ8+1MOqfG9qCKeOZ/o?=
 =?us-ascii?Q?O6OWJJDAAJRrMYB8u0mVYac+QhYkKjUUXmfsnH37Gt0SIwfmaonE8v/CBnPO?=
 =?us-ascii?Q?A5BrW+qHMScE3mbNr+xZxr2yYVnKIRJHyA4G2lUYuDLpyhPKlUtlFMlsXq1b?=
 =?us-ascii?Q?CKqxnO8ej7+q5E99vZJ73Wk26f9z3Si+3BPTuiBDWlDKnKEamH7uq5pUXly7?=
 =?us-ascii?Q?CSmFyPa/NJ1q/CxqR34kuCQQQJ5mpIgBtHpHsWSuI36mREMHipuu6MepQKB8?=
 =?us-ascii?Q?o2fbhWWTfsD6rt1HMTUrP3I0ibYfQU3Uo0FTspr/f9km4b2aLud0WVWebrg2?=
 =?us-ascii?Q?1FN6AZqLMQTaNAfGDpNxsfUmOhEL+KcEvQziA4bKJOeG9SsqGwT18cr4yb/z?=
 =?us-ascii?Q?2he2bW908YqQq8igLQCN43DWR7wSExLX5XDRzMbYaCxhMLXrDegP6YNhVDpx?=
 =?us-ascii?Q?zbwNjV6Jr4W7df5tsRiJ/mUhWhJXYwd1axJia27p+RFMvc7Ds/lmzJC3cMj7?=
 =?us-ascii?Q?QIV7GAQKlIbJdGbBAavpCUhsHP/hyGFj/4RUv+hz6Mt0whinxh8IAst07Ovf?=
 =?us-ascii?Q?9qek+K1BCgjZKpIglZEU2ElisbnKOxtOJY2cFw6rLLPomUCFqL5WhKE7nZFo?=
 =?us-ascii?Q?mP7c16+XuS3rIaRBJQm9DpRrf2MaOqI4d09pMaKaqhxGYGvMvjoibxXaEtaw?=
 =?us-ascii?Q?HHInnVOoBhut+kbCgi+IRsXyy96wY/EIfaqQ3tRkOmBQxFpQJxL6N7Lej1a4?=
 =?us-ascii?Q?gX3tTerN+mwm+UHFQPR8aEX5C7+buev05iUG8xHXBeZ9DjgEJoYFHYUxC3xw?=
 =?us-ascii?Q?t8fTR/lvjWfOdHZaniLIa61u4R5nlN7Q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:06:06.3909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a348cb-bc23-4878-fd12-08dd11482233
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153

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


