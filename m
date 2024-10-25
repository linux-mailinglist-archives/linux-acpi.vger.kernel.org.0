Return-Path: <linux-acpi+bounces-8999-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0246F9B0F14
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 21:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201D01C22B47
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548E21621B;
	Fri, 25 Oct 2024 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HJEPTPnh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6CC216208;
	Fri, 25 Oct 2024 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884698; cv=fail; b=BUOfGx1so9StLgi7Byb5KmzsJJjV3VG6gwvY4sP7fRJNRD9U0OSoc9Tq6W3Aa1rL8y/dNuJa7Q91WR67BAI7+9uaG10MILSniOfSW9u3xq8AliBWn/cDBoYWl3JP1eYvxTx9mLTWdTv1hJ2EepX5r3y4vdHCsrDvyGGnAgDID/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884698; c=relaxed/simple;
	bh=l1NpPYbI1izrOBXlWSw8t//ZEymsa2FMxrONvbtd7M0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBE42vn5HOTlaibU9lx+eEUINM81OMSaftP7mIyuifCcZUajycEmJExHZwfHdF7H1XN8zOXkPYJnJxB7gW1NuARiGWgkGfOqRj8MpNEGdAulkcU6rW0ZDrziMk790apZ5eEFlp8O++/Mr8SZyL6umYX2PVcNXqUnHCKBs5GC9vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HJEPTPnh; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkRbcbdaJthgXssKDJQdZx7Fu4CkRtyVIity4UPWteW56JG7VU8SoQXh7qs0hEChraxsfdEgUWBQBh714Ymq/Tv2M9N7G0CDuJpUj8jIhWaiWbLKEccHxS6x+8nhcHQCtSIPDFecicKd9scuhd/NixzZn9Z0cpjT/wmXp0U8ms/52oQKShDY97nPWIqga4Szv9iRljp+6VWYjXmL2+7d01/GJEZNtWxaTMyeNRqV79dk8c0O382V49/2KebCO/JMTWc9Ux3L/Kmi+RkuSXYl2E+hqeK1zg6eAUP6+bTDXSTSrWBFlQKXj52bgX8HL6na3LmJxt+qFjjt5v8QHXvFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wULtWbk/f8Xi0zwfoBxp2g6NVV/1PuBYHNNKAVq3ltM=;
 b=AkKi/wdsPr+1Ysrv4OHiA2caO2mPaL0Df+c6dAIQUiumJ+YNOtwRL8SrKv8L2EEoRBZGXIPAP3TwvB9wetkeLQJgzJ8X19aW1JCWQMFEvMYP3bvxhcOANe03ETCxk+Jl5DVHvnCNoYjV6kn3/HzsW050UeXIxIwEPPLWLpIXyqR4T65dqdhM8NQVqV5KKwqAOVLT62dz0ldGx4oCoLiFoQO4WtOOfgqLl7NkZwbBe7jc6hfZeIXck+w5i1OnYMUH3UHs7Uu+z4GAr01srwl+HhXVgWiZQNSu2WMcf9VWD9naGnrGEdOgXfy1FqW5I9yqgWkE149kdOtETWX9zAk8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wULtWbk/f8Xi0zwfoBxp2g6NVV/1PuBYHNNKAVq3ltM=;
 b=HJEPTPnhVg/UoCi3gOA72M9SBkRzTs7MnP13C/O0W/Oox+vvKA8Nk/uNkn5BP3NPYG2kmQsa0Fpk2e5iWoUHPhPD+B/rAIcHBSiuhFPYIPgMNjBT9F4Dv0PBJZdKVNTxfG+Z6EYtnbhaN6OqUtsdva9jsvMeWwPQneu3Bb18dTg=
Received: from BN9PR03CA0366.namprd03.prod.outlook.com (2603:10b6:408:f7::11)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 19:31:29 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::58) by BN9PR03CA0366.outlook.office365.com
 (2603:10b6:408:f7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Fri, 25 Oct 2024 19:31:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 19:31:29 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 14:31:26 -0500
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
Subject: [PATCH 8/8] platform/x86/amd: pmf: Drop all quirks
Date: Fri, 25 Oct 2024 14:30:55 -0500
Message-ID: <20241025193055.2235-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025193055.2235-1-mario.limonciello@amd.com>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b68d2d1-4953-450d-83ee-08dcf52b9fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eZ/6MGAOJYd0ASO8IaGkZH98vEEjY8KHeFXYJjuqgyHTXJzGUPERA3LYPwzg?=
 =?us-ascii?Q?xuoDNa/5FgrMQRT/mlGkMUtj9MyoOJJFCm0IDhIJSY/lJf4FoqP5b0OkgFRA?=
 =?us-ascii?Q?Et503PqzqtG/iQ1Wyeo0Mh4xuiYqgV4RqwGNcTZClZbmlVwUNbPvel8sRRvW?=
 =?us-ascii?Q?owMbWwx7rOrIEP5ULNbeJF5IbW7TWBZXWHnVccLkJyFMcfgHcZMetQOYVq+l?=
 =?us-ascii?Q?vnoHE/Oh5mlksyVfJaXL7m7E7mnoJoteaviiI+OzRJSdD0RPe5A30bWIS8xC?=
 =?us-ascii?Q?LOMOZ9X2b5NZJZcQvX7TTDAEwhYw5ZsyiFWJ+jVqEbaEYzK/BdZ/QdiEWroU?=
 =?us-ascii?Q?DdpY+vvjCx7Y+dm8KOsSnIOra1faIATe3/9KIGwJja8gJGKrm5oxeo2MFxYv?=
 =?us-ascii?Q?v7R/XorBlLAU/0OkfQcQY0Ne/2dOkYZHddwjQU+35NZb/phO4cUzPn7lk25j?=
 =?us-ascii?Q?UESzqbMZowNsLoofQT4nKs/NtgOXEnwGn2eXA9Q/MMTpLvOpZOWtLzHOpIZB?=
 =?us-ascii?Q?hd+1WQItF5m+zvJ61GRPnL/gxm4wg9iptl2TH7qIQ3H/V+nFyA/inEYyiGmO?=
 =?us-ascii?Q?3HXMegeTf26tC4cw6VgM1WsvCFc/np75DE6AHXshvXLYZbCNDyCBWAiKizVm?=
 =?us-ascii?Q?bFwGNdKKIfNtBZZmucepn6fxFXCXo22oKwUzlO7MB+9GxlQV+gz9mmh8H6Vx?=
 =?us-ascii?Q?RulkvwYLodzjUcohIghdfdje6gBnmxmAAO6QP0UzeOwaM0MHYGS5jRoLIb1K?=
 =?us-ascii?Q?CZEuXlfmJLscSpZwyV6+FkXGTkrdXO26jLLBXzBkUIFZMoz0V/EZLcXfnhpy?=
 =?us-ascii?Q?lPg+RbSKLkXfb47SOPbIPmSQ7QKFNw7lSKI9gq2JlhIy6Ak7hrNOqCWDB1p6?=
 =?us-ascii?Q?T9YTT7TJbSh1Ia7UkfFsSI8NfRI7mSjkeS/68vYtleh7EvNHPepoNtpTfleU?=
 =?us-ascii?Q?b6T854VZE5o3l9W1OhA/ZJQO1spXR8B83LrWOuHunCVyPInpZHhFmnTtDkJE?=
 =?us-ascii?Q?KTYFEX0W/kJbsY6DRqsXT0WlkKmxuZmCnjDpKjbzc1Vntg1pLkAm4PDDab1O?=
 =?us-ascii?Q?cPFo4lw02xkDE3OSDo2Qljsh8SVplo0/JFgyhN2uYQayn7YaO4g+WJ4HJXZT?=
 =?us-ascii?Q?HrIZU6jjLI7axJGUz58YtFoLMj0EKx8ZcjMhjrQpjp12m2UgWSRKwuqAqNsz?=
 =?us-ascii?Q?pHGG3zA+rwTwaKjjBpt9VwVvWc3J3tVTrJHP4xifyLcExCHaVfff/kJwN4bV?=
 =?us-ascii?Q?uo7/U0y/lw2tQTKRV7YAXPMdMKSzD3Bdag2i401dw1OBBizLgS/5llHpe+Ce?=
 =?us-ascii?Q?Ysy+xphWeAvkkp49pNcPUR7RX0Ck1X66LzaOVhaSiJTOnkpk/uJ8GyV4nWWD?=
 =?us-ascii?Q?SKQAxpgDXePOCrNKilrHoSpr/0E4jL9KUgcyohFNv8A8nJtE5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 19:31:29.4422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b68d2d1-4953-450d-83ee-08dcf52b9fe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331

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


