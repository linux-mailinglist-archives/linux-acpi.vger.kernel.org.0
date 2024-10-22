Return-Path: <linux-acpi+bounces-8895-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE4E9A9746
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 05:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95C7B219DE
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 03:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A7B3BBE2;
	Tue, 22 Oct 2024 03:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tbSDS2vB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292F9463;
	Tue, 22 Oct 2024 03:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568817; cv=fail; b=Ci+GvuDETwBXqa1ZkvXCEgkRuyMbhNsMq7LeCOuagmnyiDqESPMKcQ2CRiNgFugdmLux01KQs66WF+KzawSATnRnyb65nO8oAs3UoNV3wLi3kgQHP+TF5pTmoJ6uIQneySuIYPsfl0comV0ZqLbj9BQu52IS+4RbAiacE92q7+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568817; c=relaxed/simple;
	bh=jJOLSzkvfP7p+b855UfbCFJoiHhCs8fMRL0tZBRLgZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnxJMU8L+gQ81cdQsXT2Q15MgCqGYREahBz9ulnAQd5V9Me3t2118R8F/QqzdSVetNGJj5OnaFFXKAYkE8Yv/c9S3aroPezGXlFIpQINbHYVelC4vh0KWMuvGCx7eQTMnXYplNYak2DoyfI11rewf5vH9vNdyjgrsljmX5HSmp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tbSDS2vB; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcJmRXOlXnvqW2T05StiQOGkURXRw9porCfGrsGE4s/f+X6rA+3WNSFX3S210xY30DzwOGwQquI/Ru5Gy9ULVGVjKS+gjoZ4giHy/PdFMl7JH5Wf4nPFdu+D2W0mhUphARVD7DLPXdtk+7AYtWU2JNZo17ucymsqQyMMsY5axxddGIGmaWRCN43vuxqlLt8mZ70s2cyk2Keaatooct90BX388G504cN6v7GQlwXELESi2GWQ22CITpxHA0NmTq3vQtEIaxJ+Wi4VcebeYNRgR0CGlo8s49VnH5AlxWTtWBhI+iOQ/Er4t2V+wMnR2hF6rA/E2rFlEesNGgqYnYCrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDBw8le5kBLx+UpjItK4zlvcDmURMDII5ktiQNH5RNs=;
 b=J8sTLv2ow26lm5VO+Y5AE7emTWRNrKIBx07chHKk9+i2mim+p3vfNax7v+mUI18UfH0JTTKUD5DEDS8gUxd473V7r1Tn0OShasfwC8ncht0talHJSkiA3ZWr3hKA6xKdYf5ERAzxhGzY7PCiMXBiSLK5wkDfYHgN8ercc8+kcxDbyVyRxtOv1n9TIkNtIVDEWnTvhBtgiacuFOviL6a5RmhxNAegXSCI2/Kup75qpxNhWo5IaJeUlL7zGdYWldi4RYA5+6gYucSBaTgXhFiaq3KYcit0e1yb87pPSmPeIRmQiimFND87wx6g8ZiiPYiGc5wfdSBAcK5NTShdaI3FpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDBw8le5kBLx+UpjItK4zlvcDmURMDII5ktiQNH5RNs=;
 b=tbSDS2vB+YgFxXNEViWDnxyZHE/FWhPB/M29/8iSeqnQoCp+vpD3KqCZAFnI8Cv/bnx0RsF/cbdX5vUiI5VCX03xufuYIfh4xjjOaWccT5AUKnuYV2qJytVVfbpe3KJ41A3OumCuPiqh2+nWQHSwdKavURXhhkbRhpI+JU6tao8=
Received: from BN7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:408:34::19)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 03:46:52 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:34:cafe::d4) by BN7PR06CA0042.outlook.office365.com
 (2603:10b6:408:34::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 03:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 03:46:52 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 22:46:50 -0500
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
Subject: [PATCH v2 2/5] x86/cpufeatures: Add feature bits for AMD heterogeneous processor
Date: Mon, 21 Oct 2024 22:46:05 -0500
Message-ID: <20241022034608.32396-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022034608.32396-1-mario.limonciello@amd.com>
References: <20241022034608.32396-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 491395ec-7a2b-4449-0af6-08dcf24c2a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DSCLDAO/rOTw+oEwLd2QjrvY/YLtL6yIKsZXIU9p/r72C98i2pyfLegZqKNz?=
 =?us-ascii?Q?DNd3hhB/PJJSKW6mTEO6Wx0IZXr8XqqrZ/uJwdAh+2JHQyiQO2on1+z2npaW?=
 =?us-ascii?Q?QsPtuPQGjS9AtpsNPHReU4obwl5vyKx6q070Z6+9SIF6C8ElCFxjBBza52n2?=
 =?us-ascii?Q?8YcZHRB7bHdI8KvajEn/3Yiso8k3Xi9luOzpAJegvUFr+T2LpFwG4ei7UYiH?=
 =?us-ascii?Q?owU5I0hEO6KiQOOOCACCnux2TumThgkwC08v3x5QCx4WhDhE//tMxtO0Wxpi?=
 =?us-ascii?Q?qKkql9G0YHbjSdITwSXHyGUupZAJRfcuYmlnuSmXUq8kqaJm0GnDq8VrcNqB?=
 =?us-ascii?Q?l7Z1NPqVnU+lsXdvqNvFj7FrHTGe1jdtbgB52LKNkOC/BMBEmWiAyw4CUTf6?=
 =?us-ascii?Q?XvNrIwaCyo2sceu0On60GPYt5ERgoa0XRz6kaRhuy9te+68MXzZnfFGB6aL+?=
 =?us-ascii?Q?ACOzHknoem9EbyKmnsrIlmuMvib8KD8+HUnh3UECTQVuVQIbUnw/XEt7dO9f?=
 =?us-ascii?Q?Fc5UOdU73eAv236emQCfKPzQ7OJ6/+cMEeqzkuEplGY7Tb1w8oEDlTaXd4tU?=
 =?us-ascii?Q?p69ZFAKLccKiEQnjGQTikqRJ2G1hG5yXj4JZUex7ikts9X/DpojV6JefwrnY?=
 =?us-ascii?Q?b76ktvNBY5Gey8JSR0ouvOblYdymTosjmG2IDPPA0/ZYHye8OwuaV7LAMvMn?=
 =?us-ascii?Q?phxSgwWFSuLQ4J2TM+TSjwGA9oQU9P6bBy1KiSIi17VfIjxjINAV/slhcSfL?=
 =?us-ascii?Q?GERRzJWeomuU2J8mPWIzoqlsiceHm47/Ta1pYCoy5Xe6irB0x6O6LX964G05?=
 =?us-ascii?Q?Q9ap8kezdcOHKW8OWniasklzcUEPR2Kc3mlvwHzSpTyPboCWPSXKRR82o/Hb?=
 =?us-ascii?Q?0ssU7KA3UaPIWGpBTz5oQDy6jBOd9WJlOSR/8pVcRVsFFThvcdzBQMNYwWEr?=
 =?us-ascii?Q?e53kjNBO1aNLQcZu7jadMHNLYhK93eDrc1UZk9wiIbRfYPH/l9prva307aig?=
 =?us-ascii?Q?/WnhY3VjpSSB0U18kO7AW/K/mcgQjvXh5etOT6m3Z+Fb/cdBGBIA46ttPwIr?=
 =?us-ascii?Q?X1fubk3KOllE4r2kn5DnxHeMZFGwGrEO9pEDU1+gLhyDCZdGZ3idPnkXrXCx?=
 =?us-ascii?Q?REKT75R7ioQ4bxN1kK5RCyp2HBWkSUNDzxVj1/pQfxpAJHbCbDG7Fr6XIBqk?=
 =?us-ascii?Q?L88KEI8Wgr7jINSX9L9e3IEV/qlttJxDEUAxmK0ZLSW78kpqd98n5Go7bE4i?=
 =?us-ascii?Q?ZS5CRDrHhljdgkWsaTZdVizG9o/FRl3qoL17Oq6/KbdNv007/REOcKmXRHh5?=
 =?us-ascii?Q?c0ppAGBI6gTMQy1scXeRQ+OIGYtnpxS/JJ5dNhSGhKimXHvT1khwyLZ6+tqZ?=
 =?us-ascii?Q?YMhn5dc38Vl+ascQUPMdKIbiCW3OkCictAlqhVs1+P8R5IvV0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 03:46:52.2958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491395ec-7a2b-4449-0af6-08dcf24c2a76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732

From: Perry Yuan <perry.yuan@amd.com>

CPUID leaf 0x80000026 advertises core types with different efficiency
rankings.

Bit 30 indicates the heterogeneous core topology feature, if the bit
set, it means not all instances at the current hierarchical level have
the same core topology.

This is described in the AMD64 Architecture Programmers Manual Volume
2 and 3, doc ID #25493 and #25494.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Drop tags
 * Squash original attempt and new changes with feedback together
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index aa63437a677c0..51b38bc667960 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -474,6 +474,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
+#define X86_FEATURE_AMD_HETEROGENEOUS_CORES	(21*32 + 6) /* Heterogeneous Core Topology */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 1db2bb81a3847..307a917415343 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -52,6 +52,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
+	{ X86_FEATURE_AMD_HETEROGENEOUS_CORES,	CPUID_EAX,  30, 0x80000026, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.43.0


