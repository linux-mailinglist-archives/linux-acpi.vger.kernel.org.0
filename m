Return-Path: <linux-acpi+bounces-9835-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000FD9DF10C
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B396D281210
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC41C4605;
	Sat, 30 Nov 2024 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ktI7c5TN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CF71C2DA4;
	Sat, 30 Nov 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975687; cv=fail; b=eWcvETDHgiIA1Meqy40i4ACwZhncJEv0n70F9gLWNWUFKEOUDH3pykCB4om5bJ6BGeyliQ2PAaa6vZPLApj3zhAWPczB2VK1zq/kDFmXBgZz2MhQaLfbJeJwv/bztu4qoijQoc4avydpHZy7yHGhUW3kXHgIWPMCEaNwphD4Z3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975687; c=relaxed/simple;
	bh=Q7DY709JgBs+QNd6i5wQZjcCds4ZMiJT05soWR23iNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ix5yWrHbd7CKQnJoXpgq5QCIdoPeBCVjqj15ldTkddMWU2Wg2o/fuxweDTMwu2UEq/sz1qo2cacmSu6MBKSXjUz98FkNQF1lxU2wiuCZ/pExd5R/1LAqNNCr8ozSZ//ZK5t9UGnk+FOweV/heh3qXYwFdLerTdL1uKHgjSsIQek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ktI7c5TN; arc=fail smtp.client-ip=40.107.96.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a45NVC0RNr38UC8lE2egntnetA42SHO2PKwzlnbwq49KjagfLTlfBIpl3UlYcquGpbUJJRdtW41ktJSecUqgYxm1hVK9Y3wyYsLNzlWrtFaAFFLhpYId0pr7BT9Wc505YeACsOwoLJoFmbT2jxw173dotZ1UEgCJw5ow4iB/ZSy/1SyArpdcfCmq0NRULRV+jikjusF2pf4r5HLfVn+3LLgbEvBssjf7/i2X7Ea92Z10DNCvLQ0bir7TyXSOYsT+40PpE2GS67Uoq0Uzi2gkaymc7kReyhalAXj1CwTHrQAGaAudL5UqHPe8PqAfhXYKE4DEiE/3tlezZ45O7IPVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbsR33tA3QUueZBtjGdlP0wv8lbAXeI77bNgCXHd8C8=;
 b=xpffOyo7b8gd8v9p4vjMoKARaqODq0W9kK3xT9gCcBGkgapQksy08Vvy+uYEB9s4TKWyggwWX6vCSMNy/P+K4WmoSt/nZb//7zCx9I/KhQhtKSjE6RmUc6Vl/cItjGcz7Bxu3XiVyFShFrx2kfKh0r2gPPSy9OxXng6CcAB6IXNG+9kXusdAnPz/enra9uAI2zRjGCHLBrLUhOsbDdu/xrvns5Xtdru4fs35F972t0Z7axnyxeNNnKajHfhxcJxmgY+1n0a384UkWsIhgqU2m5Lu9ziV1US9RIVDSo39U0X9NparlxC0XKlz5Wo2Cosu4sKriTmlkL0NL6EAaS0eEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbsR33tA3QUueZBtjGdlP0wv8lbAXeI77bNgCXHd8C8=;
 b=ktI7c5TNkgAu0oee3kL3dF6hrdux+AaqE8uXB1GaxuTa11FHyCEfZLy8vGAutNyZCu5h07FW5voiDkkQYYY77eTnHgGxoG7yHHKf9LZUcNxHt1AvblBbCKsUY1T/xMZKiDuSXe9Wr+HoP5UuBLx4+dFk7SDwf32M/U0wa9toln4=
Received: from PH7P220CA0142.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::12)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 14:08:01 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::87) by PH7P220CA0142.outlook.office365.com
 (2603:10b6:510:327::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Sat,
 30 Nov 2024 14:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:08:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:07:58 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE
 (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, Peter
 Zijlstra <peterz@infradead.org>, Li RongQing <lirongqing@baidu.com>, "open
 list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:AMD PSTATE DRIVER"
	<linux-pm@vger.kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v7 12/12] platform/x86/amd: hfi: Add debugfs support
Date: Sat, 30 Nov 2024 08:07:03 -0600
Message-ID: <20241130140703.557-13-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140703.557-1-mario.limonciello@amd.com>
References: <20241130140703.557-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: e61f3559-b313-4743-a780-08dd1148667d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kn69cWulKFmtHeJE634Z7am8bfBwKBYpV05ESRiZB82eTlmGX/m33b6xevi8?=
 =?us-ascii?Q?iCFZwcPKKPZEwXms6caL/AKOdvzojGC38lWEE1kqVEhLXeiXSFkOHxt0R4EK?=
 =?us-ascii?Q?/QSnM+lNU/55fE3q7ngSKWIz/5FrBXT0p5XF/7Tev5ZUn8EGMtkk/ja+rmqQ?=
 =?us-ascii?Q?vqlScqy1h9FlsAtu+qOqOm+aLFruHWYDil+KXsZEc7QLGa8oZPAj/i5IJxjl?=
 =?us-ascii?Q?4AK886rMbuD5sth0x1nK/7WO/tOibpTXQFUJ3Jin1eswQHe26LNuAPqDdD9Q?=
 =?us-ascii?Q?yb0HkAyJ7p13ziTtPZzbvE0ht1NsJ43NrPqS1/BjmjoulJlA0oQIh3Jqx2Ix?=
 =?us-ascii?Q?QLxRgMXmKqi2Ic/thPn20fO5gizfs2PsvtMsCMXM3ycT/AsTA/bFrCXJIJfG?=
 =?us-ascii?Q?QuPxhTcHyUFnMTCtyGuz67DVPap6Na1ENY6hLbu9aB9udg9uv2U4tFi4a7aX?=
 =?us-ascii?Q?612YyqjRnj+ct5CIH3Cag43UJrumNQevrR/4vD0Y7nwDY8+zS6xRClUKQAJN?=
 =?us-ascii?Q?+44Rpzj+Fc9L6RVgP2FggMh8DJufljcyOxnEn9FnZcl0pmuYFTf/ypJUipNB?=
 =?us-ascii?Q?vm5+ScuRjRI75z8dD59ixjmDDfJ89+wYTMVzSBH+DjFxK5XVkfWxrUiDs/Iy?=
 =?us-ascii?Q?/KnFTSI5aVsPRniAPIY6JWJp2n4do9UfXCvvPMLho7I/J8te676rLN3K0SMb?=
 =?us-ascii?Q?+InfLUg9IZ0mJZZJiTCv9nUi+Ui8Qs+TSscQa8u3AS4dzu3xZofZRQisCO91?=
 =?us-ascii?Q?bJ8mmekZluVXVOB+NgThMNRwqkE6ehEJpjA4bJ5RxFU2BpiFONKG5Nc2HCgH?=
 =?us-ascii?Q?5dzFPY+gOfxmrSkZSsUduSUaZ8h4uk1J6rxujqqKCq/6gh09VKl9iviV+8uj?=
 =?us-ascii?Q?tUgRbWTtP9OQXLsamfTp+328P+z2BlWexgEo/nUvD0JKf3ddTvyMxbiqn8SP?=
 =?us-ascii?Q?/uGiFydz9+bbes1PjHcsw2k1Cexn8PKqWrK+/GwmdjB5b2XDXpPUnB6o0E81?=
 =?us-ascii?Q?GuuTOE007F0gpXkxz+Ir9yTnf00qq7v2eU/I63KYwUV1Wy2RRrWj1sF0UIH5?=
 =?us-ascii?Q?/I8yuvFG+h3DoW5K2+u96mGjg7lJ42IB/Nee9nCo+7ZqdbIui2txQBdpDP4C?=
 =?us-ascii?Q?DdJzOe9jTfC9G+Cr0zymhGt9TIzekD1bhx6Bjx0RKKl8m+y6JAq0/d5xPy8m?=
 =?us-ascii?Q?TCp30DT0C+nn1uSWjTObcMHzjJx9j0eAB5AEClvqwejHBjQtsIJnl3IsbS/V?=
 =?us-ascii?Q?5haXa7ebIl5nIygcSNQ9RTCNZbfF+Ucot1CuRqgJiEQh82Yv9Al86PnzdVsm?=
 =?us-ascii?Q?Xo4WB3FRa28h5iNtUo8GD3l+utNSJSV3M6HMSTiOIj2X8YruRMZOJLpJ26Vd?=
 =?us-ascii?Q?0unfn/fOnHp4DdWl6BTsKZwkzz59q2lvO7Z2fl23JMUNKtdJh5heVffUSqsr?=
 =?us-ascii?Q?MoDFNFtxVRQCk36nHd//7TKNCivyZXsR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:08:01.0525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e61f3559-b313-4743-a780-08dd1148667d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182

Add a dump of the class and capabilities table to debugfs to assist
with debugging scheduler issues.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 0940950dd7adc..b6dc379bfd546 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -13,6 +13,7 @@
 #include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
+#include <linux/debugfs.h>
 #include <linux/gfp.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -74,6 +75,8 @@ struct amd_hfi_data {
 	void __iomem		*pcc_comm_addr;
 	struct acpi_subtable_header	*pcct_entry;
 	struct amd_shmem_info	*shmem;
+
+	struct dentry *dbgfs_dir;
 };
 
 /**
@@ -234,6 +237,13 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 	return 0;
 }
 
+static void amd_hfi_remove(struct platform_device *pdev)
+{
+	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
+
+	debugfs_remove_recursive(dev->dbgfs_dir);
+}
+
 static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 {
 	for (int i = 0; i < hfi_cpuinfo->nr_class; i++)
@@ -388,6 +398,27 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
 	return ret;
 }
 
+static int class_capabilities_show(struct seq_file *s, void *unused)
+{
+	int cpu, idx;
+
+	seq_puts(s, "CPU #\tWLC\tPerf\tEff\n");
+	for_each_present_cpu(cpu) {
+		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+
+		seq_printf(s, "%d", cpu);
+		for (idx = 0; idx < hfi_cpuinfo->nr_class; idx++) {
+			seq_printf(s, "\t%d\t%d\t%d\n",
+				   idx,
+				   hfi_cpuinfo->amd_hfi_classes[idx].perf,
+				   hfi_cpuinfo->amd_hfi_classes[idx].eff);
+		}
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(class_capabilities);
+
 static int amd_hfi_pm_resume(struct device *dev)
 {
 	int ret, cpu;
@@ -463,6 +494,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 
 	schedule_work(&sched_amd_hfi_itmt_work);
 
+	amd_hfi_data->dbgfs_dir = debugfs_create_dir("amd_hfi", arch_debugfs_dir);
+	debugfs_create_file("class_capabilities", 0644, amd_hfi_data->dbgfs_dir, pdev,
+			    &class_capabilities_fops);
+
 	return 0;
 }
 
@@ -474,6 +509,7 @@ static struct platform_driver amd_hfi_driver = {
 		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
 	},
 	.probe = amd_hfi_probe,
+	.remove = amd_hfi_remove,
 };
 
 static int __init amd_hfi_init(void)
-- 
2.43.0


