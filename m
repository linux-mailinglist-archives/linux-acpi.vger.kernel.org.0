Return-Path: <linux-acpi+bounces-8888-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493959A7188
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 19:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1C11C22D08
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C095A1F9A9C;
	Mon, 21 Oct 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mSsosy8V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA05E1F893D;
	Mon, 21 Oct 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533412; cv=fail; b=Z6SJZOg8Ypg7lRNIlVTlAw3BhiVmH3EpXGTKfjtmSjaFwMpDJUaNELvPZB6xrqLFwamZuKnGrP0WJnQHYU9yoZ71Hr1NOr1r8/ptq1fks7fJHMhGTCP1yK3+TRQdChgwG1UnB4OtiewzVtI/BH+1A/iTVeABePoWKV4TPzZjQao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533412; c=relaxed/simple;
	bh=9ZNwRkgnVPDvBfpMjjWjDa1rp3P8rW9lCzYbEWwjzHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HylKX4xwNJ1SDHgmITMg8jOyn9RZDsDSqWDJAhGtUCUKXljXSkySx8uEIJNZfua1EiISjdD8sjSh9A4B/mx+dL/MmiEqrZ1Y7K+MJ1k2LG8mfMa3z6I9Qnu3lYpPCuDaiOyl/W3svTbSbcNWDLGyyDBtlifgiwjfBoQ51I6uga0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mSsosy8V; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiaapM1oMWiDqG/bHFlA8p4QselTr6Ajk4jjU6lVxGRyjxXq8qeeBwejE70FVawgT+/VSW3TQS1Lhr7TF9OZPhKQ+73/nc/w3X6ZjneT2XWQY2EpD/eEx/cg2ePjsL34zX91lSylFV7alcfLxzUVAzsFLc1X598ydjU1AYl2XrVKvN0pzjfMMamxJeiqOh+Go9IjRzdKgRiF5lBJH8fnS8uJX0H5giRTmDvpg5v2aW4GIJuT1w/cBbIoY+z5rv9QIJz8KQ2E1RKt6V0sBEG2cSmgMvbA/QQCIfxlsoL9rXEbxCPPLgMRW+r7YyoWeCnesx1/7sczz5BOGSttAM6qww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dEPNPj1REky0DUHnc5vOmsfFrXJ7emWcYWHsykmZ7A=;
 b=BXfpc7Hy5InHQDTA/cf4YYCeySFm10W5igNEs1vc66tv+ZJt+xehCzCCul85gUBulMXPXYztZ5ik/O30Xct1Aqqm3HjTtWTksK3aPTU+Yo5i7BbYc/yrMHeeAzDkxDjgu8b0esJ+MIKzzLcI2YQ1aWSDcrdkCBqnBgHJaY49R3mTFCeus9hkcfZW/9rQiUNHqKaxYtBw3/8TbtJw+iVXi6iqF/W1BATx+CX4lEeN5CGobSOHdT/JM1+iSQJBTvsl2chCVId2Lju6LPbZZ80FyrOhM7MkajuxAMkW7Oj9CpS9otmLstWSepn5zc7vAsGosHWIBTJ4NdLuxe43w3/qMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dEPNPj1REky0DUHnc5vOmsfFrXJ7emWcYWHsykmZ7A=;
 b=mSsosy8V85HMzeXuorMIumFZNadXqNMFBh0/x15sEDe6Jzxh+ftg+T64eMDa+B+dq+7h2sHFrAVCy2c6Qgng2zUa2D1Em8xMurKh0c2m9mFGQp95t/k4vvKcnH7H70gcQEMoJhW4ytSCF7Wqdjg795ndJCDwyWm7D13XewhKygk=
Received: from MW4PR04CA0361.namprd04.prod.outlook.com (2603:10b6:303:81::6)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 17:56:47 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::43) by MW4PR04CA0361.outlook.office365.com
 (2603:10b6:303:81::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 17:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 17:56:46 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 12:56:43 -0500
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
Subject: [PATCH 4/4] x86/amd: Move AMD core type identification code
Date: Mon, 21 Oct 2024 12:55:09 -0500
Message-ID: <20241021175509.2079-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 56044947-3120-4ca8-76a1-08dcf1f9baf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d5LazVxW/yNiCt6tsHr6KuDIdsPRiKtooMsyoZKKCbaTqD8DbiRHeqjtQtjS?=
 =?us-ascii?Q?wV/DASZH6ZR7cOpnrxfFHnynp5ZcswXiq+imNR1I0Ek8a6Bfytss71kiXBmv?=
 =?us-ascii?Q?ltNdyl3aMC70UAczuK1rId88QH1rWuJ/Q+8qY3b2T2obdASncdG4gecojHHy?=
 =?us-ascii?Q?SakHxC8g1q+06xG35QtHVRYZIqR81gHIjd8T+uHBe9FSfVPLO2v3yXJmzPAY?=
 =?us-ascii?Q?q31qfj1n/whnG3amC6Mah/r+0soB4jgICzKCTOFjqtCW0nqjP2st4YDPEYMQ?=
 =?us-ascii?Q?4xtOuFaatAhR1ByPBek02NIaFx78BtagyPJuy0CLndlYoWqDCUmImCTzUEPI?=
 =?us-ascii?Q?KyS46GZa1g6Xq8WWMJsJUrNtvNkxb4sMLtLtpJjoEpR6mwy+Ax2H2ynS3w76?=
 =?us-ascii?Q?UUtn7m41VxqbAnVdfl0IBWZNGuo/eQ+xmZCFEGUR3RH6z9NvAE4it02CXwXi?=
 =?us-ascii?Q?3wdn8vUDhDrgW3ozwBRwBjGqlKgcAi33AIhZJzP9AFOqAEeRy//GUob2F7E8?=
 =?us-ascii?Q?QqpIKCmhSIvL+0CUio5PJRMVEljavqRyNYU7A0WIhuCBHKDXv9SQkUwZgkfd?=
 =?us-ascii?Q?3c/ZXmZltw3CaLo7q46ucwVeTjik4bjVaKggnnFwymQ2F8t6ZwOAQliAU1Wo?=
 =?us-ascii?Q?yeM+Vgfl8kEd9/wqPc2IPSj0hE+PJo3mMAY6j/JBvqzTHcQE8JdqfJWtodQS?=
 =?us-ascii?Q?DMTXxgHIajW5ZmuZBmnSzkGxvlXRbMjbNsEdxq+jGQfj3DlRaSlaiyIUmR+7?=
 =?us-ascii?Q?H1tg5A/b3Yv0PVPfNsy31oXpmDtPdOlgcDtA6+NuW9Vbz3SVIY/TWoAG/8XE?=
 =?us-ascii?Q?WQJZBZKfcPcwPAcz4rfkY/Fltc3Tjdurt6iplP4+J1sUNUxMwDvKrcpbQjKU?=
 =?us-ascii?Q?QhHxHSdfpHasCqlu92qhuq2vy4WO1MgLdMHIA5pkGLZYTHCf6YMGrOnbTzfM?=
 =?us-ascii?Q?rDgGkdTrPGjt1ktsa+kBrb63dZA9RNlJTNX4fHKj0idNEVSrvjXosUHjak2S?=
 =?us-ascii?Q?eRGXekhaiZrWB2pIesB1/e2pT0pKK0lKHt7BxXAn9X1f1wgkoW2GsS++tTX+?=
 =?us-ascii?Q?ZxH/mbu6BnqPITseufUc54kvvwQec2FYT5f7IYndu9KLxDH7TPUtLQpxf4Pi?=
 =?us-ascii?Q?NBVyHcd6F3h9VsShwB7M4QZ9YzhuoMYYonz174AIcGqy5owxW/lv0saqX3W7?=
 =?us-ascii?Q?5RMAH/cvwpXZcW8DM4LK8DoI+dReAf1TE0hy1ZwKTdLI/jhrhcIXwoe5UsmE?=
 =?us-ascii?Q?f9rHEwCpniEfVds1AwzQ4MV175AdRyTWbYIddT3sowqwJ6e/QuWobUyhtp8/?=
 =?us-ascii?Q?5GpWZ+7h+bYMGNZBFLNLep4i3YHdghBiS5BWdG1p3A67WcGf9WZ7xhR+9EaX?=
 =?us-ascii?Q?9AA9+3Ri/hFTMk3poUhvZsMsbygaroG7JXGhAoJQrVPN17QSUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:56:46.4876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56044947-3120-4ca8-76a1-08dcf1f9baf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076

The enum used for AMD core type identification is AMD specific so
it should only be in the definition for CONFIG_CPU_SUP_AMD.

Move the enum into this scope and adjust function return types since
enum amd_core_type won't be available in the non CONFIG_CPU_SUP_AMD
case.  Instead of a dedicated enum definition of no hetero support
use -EINVAL.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/processor.h | 15 +++++++--------
 arch/x86/kernel/acpi/cppc.c      |  2 +-
 arch/x86/kernel/cpu/amd.c        |  7 +++----
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d81a6efa81bb0..5b772036f6e83 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -691,15 +691,14 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
 	return per_cpu(cpu_info.topo.l2c_id, cpu);
 }
 
+#ifdef CONFIG_CPU_SUP_AMD
 /* defined by CPUID_Fn80000026_EBX BIT [31:28] */
 enum amd_core_type {
-	CPU_CORE_TYPE_NO_HETERO_SUP = -1,
-	CPU_CORE_TYPE_PERFORMANCE = 0,
-	CPU_CORE_TYPE_EFFICIENCY = 1,
-	CPU_CORE_TYPE_UNDEFINED = 2,
+	CPU_CORE_TYPE_PERFORMANCE,
+	CPU_CORE_TYPE_EFFICIENCY,
+	CPU_CORE_TYPE_UNDEFINED,
 };
 
-#ifdef CONFIG_CPU_SUP_AMD
 /*
  * Issue a DIV 0/1 insn to clear any division data from previous DIV
  * operations.
@@ -711,13 +710,13 @@ static __always_inline void amd_clear_divider(void)
 }
 
 extern void amd_check_microcode(void);
-extern enum amd_core_type amd_get_core_type(void);
+extern int amd_get_core_type(void);
 #else
 static inline void amd_clear_divider(void)		{ }
 static inline void amd_check_microcode(void)		{ }
-static inline enum amd_core_type amd_get_core_type(void)
+static inline int amd_get_core_type(void)
 {
-	return CPU_CORE_TYPE_NO_HETERO_SUP;
+	return -EINVAL;
 }
 #endif
 
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index ca289e6ec82c9..e25494212d964 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -273,7 +273,7 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 	/* detect if running on heterogeneous design */
 	smp_call_function_single(cpu, amd_do_get_core_type, &core_type, 1);
 	switch (core_type) {
-	case CPU_CORE_TYPE_NO_HETERO_SUP:
+	case -EINVAL:
 		break;
 	case CPU_CORE_TYPE_PERFORMANCE:
 		/* use the max scale for performance cores */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 0f533e6260d29..a0d17993d52ce 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1211,10 +1211,9 @@ void amd_check_microcode(void)
  * Returns the CPU type [31:28] (i.e., performance or efficient) of
  * a CPU in the processor.
  *
- * If the processor has no core type support, returns
- * CPU_CORE_TYPE_NO_HETERO_SUP.
+ * If the processor has no core type support, returns -EINVAL.
  */
-enum amd_core_type amd_get_core_type(void)
+int amd_get_core_type(void)
 {
 	struct {
 		u32  num_processors             :16,
@@ -1224,7 +1223,7 @@ enum amd_core_type amd_get_core_type(void)
 	} props;
 
 	if (!cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
-		return CPU_CORE_TYPE_NO_HETERO_SUP;
+		return -EINVAL;
 
 	cpuid_leaf_reg(0x80000026, CPUID_EBX, &props);
 	if (props.core_type >= CPU_CORE_TYPE_UNDEFINED)
-- 
2.43.0


