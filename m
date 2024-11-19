Return-Path: <linux-acpi+bounces-9688-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F439D2C8D
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920481F21383
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB711DDC1D;
	Tue, 19 Nov 2024 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1/69Iamr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F31DD88B;
	Tue, 19 Nov 2024 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036901; cv=fail; b=qzB96egYEfCxLn3UM1EqnS3hVYiB5gux0obooEd0ZddEQl5cJJguI4uQoZS1XcXO2nkWJUMb+Hdc5po85aWYvfBrn2XPwdxVllTl/qS6DVK8j/1r8tQqEyQn7l/NWCE9rHo1qJsqbh/A+sxsdXNUNBEoZTiyd83shD2aL4Osqio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036901; c=relaxed/simple;
	bh=+bdiJ1Eyfn9MTcWLW4JH4T1uWT0phudmlVUuiFZMgKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MoLgyFPP6mHiOKm9OAqBvN2bEKYBSeqakdEJ5rpX7LMZAMGAevmVbwrKVjgRpLKU0ZuGMVXHgO56w8K5C389ADAEScWaTk79+fjOD//qCLxffnqWQjIg2TlRCQISY+57CpAjrrrwLJqnUMtFljN+ZYEl8Gs7gnhyy3pCcN5InLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1/69Iamr; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdq5/xnYLbfbQaI7k+12aoRogOn719rY3OqWAlAxObP5dORDVWF3mY+xK0sqagoyl31DJ6k25MObw5BYutPlcvGA8/3KpIq3zwuGWOlJ3mnshDz6W41E4tmJd/wcOPxeJHJxseN9WgdBksLMUQPTz3iQogUCd3FPMJJRJLyEZo9gUsipQ4EHVY+FpphQkgdf/q7ydQjjbLQFKKK3DLHQ231B4z79tQR0yVDHK0LOUxa5wCkqpAn9eVtSIprErI6DXkqWRLE1wFcU/D8V/gFSkpfKBLW3ZDBbKrzVoN6GeGi8LwsTvCoi9z0w1s42K0s32grC6WNs1KHtYdiHkAWb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mE5xib2maNaIrlY03QYSAc2xN6cAxJyeeTXImIzPjlg=;
 b=quLt7Flxk6aoHRLkqVSSq5oGUL7Q566d6cV6eCwxC84ftcpBSfD8ymodn67J7HglUEhGNuqRc5Hkgs29/bNitWLha+BcmrGH3RK4iQb+oVelJPy7AQS9ACjrTDUKra7bwjwnf3lxWJGl66p1Nx3Itd5ihHLWO9VSRmYu6eO4SnXfsL5WLoVFwqDALNuHmccs7MNb4uGwntSo5h7ODzKxrEfOK+R/rYbmeQwslo9fPDMYd2Us/GjwtMGuV4JR4sDRUBiLjdzu+kCC/RUXnFmR2KEKB0fk2F349ER9xMhoaIHKGMxHUrrTvyBS7Hl/7eLNW64csZFvWbGc4vvxlWluVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mE5xib2maNaIrlY03QYSAc2xN6cAxJyeeTXImIzPjlg=;
 b=1/69Iamr5wxi8wf7I7e9tw24EldmH6hHFZ7QWY9y+yEr5YtX+Xlh8ZOJ9v1X0Vp7f2LEGtYUr8I2+12NXizF842eDFCRuCzlia+v2STbkWyrek8dwj/F+Rbe/7arGZsmqkEtR4OIZPen7PpN7zN1Ll/NKrvcTFkZ4ou4E5Xi7tA=
Received: from SJ2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:a03:505::27)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Tue, 19 Nov
 2024 17:21:34 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::20) by SJ2PR07CA0010.outlook.office365.com
 (2603:10b6:a03:505::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:34 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:31 -0600
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
Subject: [PATCH v7 21/22] platform/x86/amd: pmf: Drop all quirks
Date: Tue, 19 Nov 2024 11:17:38 -0600
Message-ID: <20241119171739.77028-22-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119171739.77028-1-mario.limonciello@amd.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: dec3c9b0-0bac-4afc-0781-08dd08be9e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?efuexn/vu9BtnldNg8eCRyNn4GMhv8vMjy/6FqgscQn4/nJ5Xgq6/5QNm2CO?=
 =?us-ascii?Q?QtfqOrnqAGPnyZRHWazMkI3Qimo8AlYIXZduW/DFOI2NQaDkPdloqACd1eYS?=
 =?us-ascii?Q?FYxtWp4ZMUiyN3P5mBQatJnHxVSZoNrIDl9dWc0O2rpJbOhEHDn3t67966TK?=
 =?us-ascii?Q?qIDCHx1JVuNcccJeh03bJLKcofKP3M0sJG/pAWGxgU9SK+jP9bEGQEGQPu8J?=
 =?us-ascii?Q?0uQCQTd4x/jdIEG4umGR/unb+buUt2P69jQtQ3O4s90BfDxNYzSpSfxCPYqa?=
 =?us-ascii?Q?eTyANja1R/opDGhEMsV+eP2EzGw3cTjvuNs+KuOw/VRz6ciUWWdUHKSNxULO?=
 =?us-ascii?Q?FQMVpYwHisxWW2kaqhbx17SRfkJJLrGmtLa7tv2Tn9BwMe/aAtuxb1TnBe3l?=
 =?us-ascii?Q?ze2kHr3uXKUJeT2iyo8WngFh4CWthQDFxrzNPIv7hPPleG2PuXWs2GgtKRfH?=
 =?us-ascii?Q?SB5Dq7iG5YDw1W54DwV25wxlWWcgrRTT+2+62EnRF2kH4fXv7eqWmqeF+8ZP?=
 =?us-ascii?Q?Cqb0v5YmrgY81sB997lQNeg4dEQzy/uXnvtZVD7QvjvzuQ9ZsKkwcLOMwUBG?=
 =?us-ascii?Q?XVk5K78N5mJjy85ONAzpZ++rr9x8CjkebmukzJYqFbEaWYX3ChKH6ZCZFkLi?=
 =?us-ascii?Q?a533UeiAkW0DXvTnT5GS2TJfK8ljKVhY50iNom29Ehm7PM4Oj+FgOCticzUB?=
 =?us-ascii?Q?0G7Hfewi6uYlb7kkxVndXPAKILfrZ5/f0VXeNKWN7Lh+hhj4+nueQV+V65vn?=
 =?us-ascii?Q?ypwFF8jWe7ICqsLJPxsjMYpl4ZooDpw3RecGACcPjl1YprxGL2FalbAI9rEK?=
 =?us-ascii?Q?NImyJJcqEYAqMj7dnd6rBQN5H5pakgVsSb1lI0uKFyLIC3Dya36lysMvLvXe?=
 =?us-ascii?Q?LjzOh6NfcF2yL8lUdgo5Wyni/XpKbO6RUoM8mdQLEWIuf11IPPouwfPXZpkY?=
 =?us-ascii?Q?5kVFyE80YBfFA3zQEll+n+X7X97I13Xs8BqqMH4tn/3SzQ/wgLBqLS6JdwsA?=
 =?us-ascii?Q?Etj/wbF6KM9Di/efRfJqGDq1tBZ4zMNthPiI9erdMUZbK3MWnLjZzEF16zew?=
 =?us-ascii?Q?pqTmhNHk+04hiBJoHwXe9AHuEfdsWGlkdCYb+6kLIHM4KmbnHK8fhNJHah1d?=
 =?us-ascii?Q?80mO+DmehvnC3nx9phS9bz5CsV0LTcskVmvZ7fnffF/+1sprrAiXyoADAtuH?=
 =?us-ascii?Q?Su5JTDWCv4CH5kEXZ7h+NAuisy8f8m3I487XFVWW/kHpVs9xvGzn343byKdX?=
 =?us-ascii?Q?DKiRv6eHwiIjMq77KmPoryCzY4nvNWVdRQveDCHOdRHDdxDnSSzumbKP6V+e?=
 =?us-ascii?Q?iE/qpMiVxXm+o1We4SyzhMPdfA6lZuJGiJqnnT0ixEqO0nJePSEHUMlcnz50?=
 =?us-ascii?Q?VJjBMrUTWS5DPVa4eO0+aGUscHGXha2bC3VhIyDtrEURGLEL+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:34.3000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec3c9b0-0bac-4afc-0781-08dd08be9e0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035

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
index 745d0e013a330..44461f2f35e82 100644
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


