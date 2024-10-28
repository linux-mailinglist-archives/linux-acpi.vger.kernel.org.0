Return-Path: <linux-acpi+bounces-9029-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D259B2258
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 778A5B2188C
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C919004D;
	Mon, 28 Oct 2024 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wPP0NMi8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968E18F2DB;
	Mon, 28 Oct 2024 02:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080956; cv=fail; b=kNdnwis7SDGEIzZsBb0PnQU1BV0NYKaMPchfCPtVpVlnWn3sHrKi8jucXwdj111UfEihnvh5AF34EQITulWqDAxNcoFjLkdTiTGraVzAHkHt3CBwLggx0dAkjoZbEMvd6CRDhRfiHAofcTMz6/1Enr6jEtfRp/uzl7GktiBPfqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080956; c=relaxed/simple;
	bh=l1NpPYbI1izrOBXlWSw8t//ZEymsa2FMxrONvbtd7M0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VS1+RGHFsUUyz01KBy6kjAudK3VrkIfJx9ubobQZF/0Gy+91RfqWgRtRfBV78170YBdxE5Dg1bMCzaa9FBAz/gJdX2i6oISMmyyEhd1wz08VD35h/76h7PmbxdukXj0ufxXzvb39PUcRYG1Tqc3HWZJOoDwzJ0hVY8Efun3rjDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wPP0NMi8; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0qnn14ul8J32WgWruz2ypJxaRIVd9FhKJIc4uf6jd+pHyBAXlEY27rjy06+RpAI5BrwbnP8yj3FyzrXMNJMHp9VDB5o9CKhIhrvdpNAYgzVqwGjH1kf0QuSZQzgaNtRLapKA93SIyugpfGPbgY2o76AbUcAJEkXDQ6sf5v4yWuFmvFeZ8luKw5387L1iG9qSHnDFHxTnY9KQjdiYYVvGJwqYtHOxz6AozpQcVgZHsDB46/pwficttcfSwOQQZWqYv9EPuHKirJQpMYlMV43Ze8iCob7b6SvN40OyjQTbdde7xVawMi8yyYcYA/Jtmvrx9iftFkA8LHeoq1IZgbzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wULtWbk/f8Xi0zwfoBxp2g6NVV/1PuBYHNNKAVq3ltM=;
 b=V1jilFHj/JGG4pZoEYSiENInOeZgKiqDg3bTLfampiPwKTkWeOopbCxBavvpoUJPu/N4SNvx58YeZRbXlp1bswkCfwrlnYPSYQUDWK3Ui3k9loPolmL8zsFd9dOUjWHBGAd3cYd3G13Y8HPcijaSn4f3342N+HB8ZjuZ2ahs86nOXduPwUkmyxw1yvZHXCJZAq6CtQC+Kw6RQNFKnPkd/VSDqDdc+mqUZnHni4BsdVOWshO2JUyI+x87ibPAW6/4zOtsRwJFANx6grAGopTG0xO00QMcRYHXD0KDCBsT6x6JYOIWMGjytJkSvgBavNFvvatLPRFB84MtVhzA0/gnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wULtWbk/f8Xi0zwfoBxp2g6NVV/1PuBYHNNKAVq3ltM=;
 b=wPP0NMi8Ib0ce+mLK04tpQPmBmM2xpTOEMXza8wPzq+3Z8+dhxtGcb4mvFqCwuqqy7JKKSk+6ITJiqN2xrHZKna1qDkC8UtOyOOTHEDDLt5VpefQwm3j59B4WcXP2f8MJmu0MF4PcIdgk2qIJ1EhDZyfOYiE1ou7Fpre89+K/OU=
Received: from BL1P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::25)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:02:28 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::cc) by BL1P223CA0020.outlook.office365.com
 (2603:10b6:208:2c4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 02:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 02:02:28 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:02:24 -0500
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
Subject: [PATCH v2 15/15] platform/x86/amd: pmf: Drop all quirks
Date: Sun, 27 Oct 2024 21:01:31 -0500
Message-ID: <20241028020131.8031-16-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020131.8031-1-mario.limonciello@amd.com>
References: <20241028020131.8031-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2de315-8ffc-4813-be7f-08dcf6f4938a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/QqFh49Hw54u4drJVFxIPflE0xX/QMJ2n/7avV+iY38U31bsMK+daBvfP4T5?=
 =?us-ascii?Q?+0mpSsvCwcsT9qYHDL8AhvnjyjgJA3F3q1SPI9lBXge71azoRydj5twZ+ViC?=
 =?us-ascii?Q?u0Gt1oZBlKNSiEjQrBG8O1RjEoO6rdZmoCT6zMmSoYv+5DPMHyQntlD2uLTY?=
 =?us-ascii?Q?s9O752NYo/7pCgTHgZ8N8kNCPAWEt7wmdcbmSDg1957SJSVxSzGToXDIVrka?=
 =?us-ascii?Q?PNOtRge8kImQGGTtUraxgF9V+BRmxAaKjYVAAiRHuXsLNk9mNOZrxi6zE7z+?=
 =?us-ascii?Q?cFPODNM1gu9QllbhARnVZGldSvWTcARSw3mqZ+MOsFR/gl22y/QnIla9K/Dm?=
 =?us-ascii?Q?4Mu2E9lJylsXzNA9rYD776KKwq8MRmXOe5lYQa2rQYZMiOxfhGLQCP/YCfhq?=
 =?us-ascii?Q?+4oqMxj8y4ka5I7By5PmFbJVhQqUmLjvO/puoP4h7/S3V8va/cfLhAS7BDn9?=
 =?us-ascii?Q?eC2uL01y5An1Pjc2EP9Nfh/M2Z08fqUp3blr2t5sOiSA42z7R0XgoF4Z+NbR?=
 =?us-ascii?Q?5j3IHkgClVk5BgcrRo3VFWebn3w1oSOifT+HlS2yYk/TqGzThQo9RmyJbQ8C?=
 =?us-ascii?Q?QNBT8kL3yHKCxqcQ6YlSdXhqUQ/P+tZvrk52XR6DBE+uRWzBL6KvylZLS5oQ?=
 =?us-ascii?Q?vBTMtNLF9ME+hHI3iAvP6UPPiTIuImzuX/+/mqKYuKDuenlCNt4u1C6nYEEk?=
 =?us-ascii?Q?tW+qAqFYjRBe7uJY9TzfIz0i0/r2leuB8qkrcGoCsG3VncjfYIB9tFhnxgaE?=
 =?us-ascii?Q?orOyCZMg1xcAUeZxvJZ2a9FgqLqFd5hS1ZEDH1CWjJFrjP6X1AnAm0vne7E/?=
 =?us-ascii?Q?sWef8P29TgoWavsbKimtaxhYgW1lXmMaCWVuHZLbaSaFpCJ8dgqt9YwPubeo?=
 =?us-ascii?Q?HkwRLJEcKWW4oFAbsTJuCM51Wi+Cp2REiAHp8NMMk03aET35QiwdzGDWglrO?=
 =?us-ascii?Q?XUtbEjlJy1Xzc97f5YXHl348H97Kep1a1bEd/7QuHlrrD1d4dAUPi6o+HpFf?=
 =?us-ascii?Q?qjriyxjLT5KvIMLrA1fBAYxP4lmB1LRC5m30uiVQCTvw3o2tkP+XkMzPoWfx?=
 =?us-ascii?Q?CMwVPEROPrTJh9NFw/9DOdE2csgULwqi6pfgW0ctYlIRxD6sDyKlL8Afg3+H?=
 =?us-ascii?Q?wnUJMVLlwmrUOeISrYJjRPkQOq21z72cJfg8QQgnEaSnfGhFYQabjIPwm+sM?=
 =?us-ascii?Q?ImpihDk3uYOIMNGdXgJf7uGwMcXac7zUZTzX/+V9GqU2bOyiYeDp6lczh/Sd?=
 =?us-ascii?Q?qck8Wiu7yISVA2MDYeY8ZyDVyavnU0Kh/sq1nyWoFj0UGuksCoPzMhUPLQyd?=
 =?us-ascii?Q?AEgPuX86iwNnnmArS3XRt+c0AAAH7jDdoJJoy6TYQWJr3pR5PlNMDwE7NyUt?=
 =?us-ascii?Q?WyDOhiwnaR/JDc8rP8+BoSa0qiP63B0ce+Ov8gpFSRTVHMU5Ew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:02:28.6939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2de315-8ffc-4813-be7f-08dcf6f4938a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555

As multiple platform profile handlers can now be registered, the quirks
to avoid registering amd-pmf as a handler are no longer necessary.
Drop them.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
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


