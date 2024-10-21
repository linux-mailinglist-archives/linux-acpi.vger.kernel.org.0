Return-Path: <linux-acpi+bounces-8886-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62739A7183
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 19:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033701C22C14
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6477C1F9428;
	Mon, 21 Oct 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dcfCBvFn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1BC1F8936;
	Mon, 21 Oct 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533412; cv=fail; b=PGcW9R8aknhjOCURHCEWFpqlFFAmi0bt3AsAw0IAxAEFceE82eKEXyh6dJ+yfEhGbbnmjdKdnWzDRS6zUB4AXs3RSPUlp/MXJVpd9CXdRiX9PIG4VTRaeyux0VoXqDRXU5w5d+zM732hRgKDMmAjLdCmP3chz8vmHn1It4Q7k+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533412; c=relaxed/simple;
	bh=nDGIV0v7K/0AkiJ9BrBxmC21oPccnZwCWYK3DSuqpQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjE85UPEmVVlqTCUAlL1HI/0Olg5FE8JyZvbO9qsR66MdVMD7OeZlNR8Iuhd0n5rMdc2j2N9h+KmOyivLwWsZIPPkk9mGvFdDyH6oJebQMiCLWovJPxgy1m8NiVW4damVPzcEfLgMWLB6uHEj20tMi99f0Rj5ATMlTr4ij7PXfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dcfCBvFn; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOLD8kbtv/QmUHrr8212pHijS4eGxdFDUc9753+saQCAIVagFDLphr4lZhCsM6MrlGzeTmJZaA+EGJevGGZNezwRwv1OJQ9pN9N7dNc7UPO7/tBeli6ujR3byiRob38n1l0S3CtHI+7IItyP2u6Z5//h9OV4Ljq+JTOX25j3KfmwMlu8dHTk5AvKuCrPxFVN5V5aKye+spxGCrHA89R88HyRfe5B2CDUWJLxYWioTLi+rmws9xuma+CiNJ22B5UeDRQtqoUK2h31ARqePaCA6Fmh8VuFDK19a55/NVibz0SZUFwhyZlDsyxqC9oBne+fEjEc2vpMUFqwUtT/nv4iRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYLoUgLmRnlydaqi6hoIgYaqMLuAe+kuc9J3jYNTx6U=;
 b=lVrid1xT0xWmLwtVufMQ4MfAF8jEbR8taEd1gldZcOmVMc/DI+sdOIMK79A4yNwZzAImIInU4FsOvQPqHZzvx1zUqu3oW9F8qUO7/9YwxyU9uZGQ9i5n1v9Zac4SDaNksR55ir6ILwyoOBzWYy4SmxiUvQ/ygvblP2soYHH2W4VhesSyhKQH+MjJelw9xACmsum8sabAXxI8kxSacKZ50q8a4Zy2+rs1gP2hk5fIrP5C5YcUJVC5NhO/GcKLZrn7CsFih5kMdSQOnH/oYnBOK3cH767efOpqkr3ndx8Ry1F03O8z/eLz9TXzE0vkbopjlqMzbLsl59P7ICuLtJpXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYLoUgLmRnlydaqi6hoIgYaqMLuAe+kuc9J3jYNTx6U=;
 b=dcfCBvFnkj6zb5ajIETyzMbaDvNVgKp0ijvG3q+2cw3z+0yFzJGHQUznPMSOAHp/T/e+2IJ2mcQd8bgoYiVddbxF4t3Cjw8Iz0RYdL9p+58dxMO2CbLIj3U/2LEJ6AyLQxFV0iPa2TmRKUkJ2OLbc0YNDkKYdbfE794JsXam0gM=
Received: from MW4PR04CA0370.namprd04.prod.outlook.com (2603:10b6:303:81::15)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 17:56:45 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::94) by MW4PR04CA0370.outlook.office365.com
 (2603:10b6:303:81::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 17:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 17:56:44 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 12:56:42 -0500
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
	<linux-pm@vger.kernel.org>
Subject: [PATCH 2/4] x86/cpufeatures: Rename X86_FEATURE_HETERO_CORE_TOPOLOGY to X86_FEATURE_AMD_HETEROGENEOUS_CORES
Date: Mon, 21 Oct 2024 12:55:07 -0500
Message-ID: <20241021175509.2079-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021175509.2079-1-mario.limonciello@amd.com>
References: <20241021175509.2079-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e570c69-355d-4e0b-e875-08dcf1f9b9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sMFwpu5QArpROinCYJ5MA0NbahYVdrCAME6JMjVCuCB+ZE7WffFG+X5IUUtV?=
 =?us-ascii?Q?+K11w22qM8t07AKOVk6mVYIyCsgE52ZKC/ao4zicGfGbdapZbO0qI+0XCVLB?=
 =?us-ascii?Q?VxkuamADFCxSzRFdnpN0XAnO/sl91zQ2vpg1JZAiQAhd0MOdaFL4JGDXpq96?=
 =?us-ascii?Q?9pConQXrCOY1nqdGyN0QTH3AwTPPJLSOAvK+XzEmhZx14eMueJVzjGxWUK0m?=
 =?us-ascii?Q?qxPdS+r+EnupuK25bZmNFDrrDyfG2GpqwtFMgXaFxb9xelt+dDwN+nr3+bc+?=
 =?us-ascii?Q?MKxDm1nAaENPwzEDBFhoJTWnbdF8phaX5tz2lzrgsBTXtzDw22y+cuvja79F?=
 =?us-ascii?Q?zFhYBumL2f1MSvLafYPGJeb+phogcvrbyIQpIZrLjIvv1l/+94Mt9AwoAD6L?=
 =?us-ascii?Q?2J8lKIu5ikmdwV0RopONMDAFajKCoXQf1A+vlZtmu/lkKK07xSqCJbuXp24B?=
 =?us-ascii?Q?BKuc+qMp4LVcVkF4bCqs+zHC7wpc1OiMC8Ku4AgFGE2d0ARt3Tfx24Twf7JP?=
 =?us-ascii?Q?4DRhYC/tAgOC5H7Sxg/0+zpyKqFBrWWElcDTpoix72xDSNbs2x7cQOOKOw+i?=
 =?us-ascii?Q?o/zVrwPj5pFKuMdzc9mLAGwTxUNR3doZ96QAgphKaHa5Pjo4gb23pQeM2w4S?=
 =?us-ascii?Q?psmFOIPLJCe4czlGq1fK6EMpqhTxld0AnYH9j97q6m+jMWoMptvPA3aNk6Kd?=
 =?us-ascii?Q?MA/gKTdTtJwK5OccGFDpq9Pzr3fH67Q9D61L+mey6M5VAFbnfZ8yOpG7RCLc?=
 =?us-ascii?Q?Hf4VW8iCrp8PMDpuyOX7MiNUN1HMp6t51f/AhZhGMss/zs4A6YrRA4/aZYIS?=
 =?us-ascii?Q?/PWYFbCJ26fnmGMDxZCkk5trSKsz93b8cAhJ/8dZusvlfZezVc01P0xllu/i?=
 =?us-ascii?Q?LYV/pncKd95qoP0uxtjOwhBoJl7PI3mdh+2cQcjYqeH5W384WJoS9yuPQVD7?=
 =?us-ascii?Q?qz4QRqIi0xRl/Lr5/avp0muUw/cYIwOdNUP+pwOx/vq1ZcPtsYZDuBuh+RpX?=
 =?us-ascii?Q?9bLizXUOkRGpzXK0X2hMG1BtCbjG2NXUMKVn8noHomAryOxBvl4EY0O8AvPw?=
 =?us-ascii?Q?BeRwiourVCSbq+zM+e6fA9+iwLga4S43Z9NjaUmslee9KsIVNsCyykQeOw/t?=
 =?us-ascii?Q?hPrksQXyT/C3eLdDBAQY/mmVkdt9QV1iUMo0IkFQ1JfmL23hIInw5txuu2tA?=
 =?us-ascii?Q?MGVys9IZid3tilx0P8rmystbZkMDrsiMtmnlwTB/XlAzTggRTLyy3ZNpavtT?=
 =?us-ascii?Q?VpEB4tfi7e3lSvzDFDvvuyTcG7r7o2CQKd00CjAZ5pSkC6pbNAVBwsliL3YT?=
 =?us-ascii?Q?tJb2ia6FcAorEAhdE/nray1t6e/xB9N46xShmutg4jM5GyaCVJ+u1f1MlKs9?=
 =?us-ascii?Q?ruC0m0wI/np7s/i98uIXup1XF6W9IifpT7QBZ8guBOAIS1Ww+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:56:44.2220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e570c69-355d-4e0b-e875-08dcf1f9b9a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908

X86_FEATURE_AMD_HETEROGENEOUS_CORES makes it clear this is an AMD feature
and matches the APM value of HeterogeneousCores

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 arch/x86/kernel/cpu/amd.c          | 2 +-
 arch/x86/kernel/cpu/scattered.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 424bb7ae8914a..7f6c9fc465293 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -473,7 +473,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC		(21*32 + 5) /* Fast CPPC */
-#define X86_FEATURE_HETERO_CORE_TOPOLOGY	(21*32 + 6) /* Heterogeneous Core Topology */
+#define X86_FEATURE_AMD_HETEROGENEOUS_CORES	(21*32 + 6) /* Heterogeneous Core Topology */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8ad5f1385f0ec..0f533e6260d29 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1223,7 +1223,7 @@ enum amd_core_type amd_get_core_type(void)
 		     core_type                  :4;
 	} props;
 
-	if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
+	if (!cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
 		return CPU_CORE_TYPE_NO_HETERO_SUP;
 
 	cpuid_leaf_reg(0x80000026, CPUID_EBX, &props);
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index d7f2c19abce33..307a917415343 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -52,7 +52,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
-	{ X86_FEATURE_HETERO_CORE_TOPOLOGY,	CPUID_EAX,  30, 0x80000026, 0 },
+	{ X86_FEATURE_AMD_HETEROGENEOUS_CORES,	CPUID_EAX,  30, 0x80000026, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.43.0


