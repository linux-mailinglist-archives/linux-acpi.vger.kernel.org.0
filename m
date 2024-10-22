Return-Path: <linux-acpi+bounces-8894-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C41149A9741
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 05:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E021F21384
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 03:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D658BE5;
	Tue, 22 Oct 2024 03:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qzmRjjK3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1622083;
	Tue, 22 Oct 2024 03:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568816; cv=fail; b=MbZlNYWEccxpFM0tydItI5VNxRzntJRBzm7wJov2W1Ora0zn7j1HuUBnUX/i12idlV8hdmUf9Eww6Ed7V/mlnTRu97OnCWnQXfWoub7c/q5qiN1bUqrNAliATunO3tfMDJxLsyLQcaR8gRzxV9/G/8FiZ0XckyGV+7U4x2Mlb0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568816; c=relaxed/simple;
	bh=REB58hOKyh7fDFvVeANX71MO9NXKoJuFtGfohz8Voug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFkOK4oUDRd/42R5yPxPlGT7xDPdGpYi10EcaEcXbObh3pQ8/o93Zg4l+JN89HLiwXnPR4Fs5b5bIky9SEQjzn3MzTYOzyp/m841NB/L4QbNchVaiiJ3m7FkDxmY6ZI61jsNCeWkj1sVdBOmhMdY4DfU1790Z3j5rdXFQcNA+Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qzmRjjK3; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ew0uqNA00E4N+QpK3Ta7/R6jWNiuxcdhYTLMihCufTJCXsm2CjPpBE/x3bkKu5rtzlCsX9p9dW1WyKe/fsDR3qu3T/LNYJLcN35xkQa1b5DSgJtMiHKRnI5r8ABPRsp9q+SMDS+uwIpZqDcIyjx3zDMidT3/XwxlPZguTG/toPpB9Xd5anXMDnzeBR9UK3pw6A4yQbB4dDGHtgwHRtfMSiOzOFDwyX1fq+oKbF9Us1WeMCwlkNM/bYittSvJy0/3lXahftJxdfTJu3yW2VeZZi+RCtu9COujh5aoktRap59qvGkmEHy45ifwxaAn0JnCxBL1n4H6bp0Xd0nLoqCPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/52ZQsp8XV9x/pV4X0hD1rqA9RC0NtMeG4YHn071exQ=;
 b=t/YPtyv5ccJC3JhWRPkNBMHtcsv/9ClZgLv6KfZKXWRI43uMgZbpmwPdZuk6pLCoRs/Y6abGxIQq3a8kHANRzth86dsQj2aT2RvdeP6rQKpevigKwlPYaHb7AB53dpdHSU+C6kuXoK7GcNsMwHXFJvlaal7aZQlkcDDjmdULrz58nGr/IDK3zfYItY4Echq5LbeHTpLnE7XHCowzYrv0iLdk04Uu0On3kRbrKXfj1VAAVwCj7lVIZp0/QMQ5x0Q5PjbRy8FQuZTZxHuwxb0vLrPHpCJ7sZcukNeFOKtwRKc0HzR+EB+yle4Q/qdKFCwHoISPZkxvX65886sZY+hDjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/52ZQsp8XV9x/pV4X0hD1rqA9RC0NtMeG4YHn071exQ=;
 b=qzmRjjK3+l1ugtKDcgaSzUVhPrUhCGcRL8DTzMvU5Ma5mq+O9ZZ2VN8kxWMrj5E3sTOpmDc0T7Z4Azzb+5CmUbElPGPSJL6Xf3L+mSSPl7uZdjRQEfvJBh8HbTIPDQjvGkZ5kA3Why6gPyq5CvWma7OGZruuRYyTk69P1SwIock=
Received: from BN7PR06CA0053.namprd06.prod.outlook.com (2603:10b6:408:34::30)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Tue, 22 Oct
 2024 03:46:51 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:34:cafe::d0) by BN7PR06CA0053.outlook.office365.com
 (2603:10b6:408:34::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 03:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 03:46:50 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 22:46:26 -0500
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
Subject: [PATCH v2 1/5] x86/cpufeatures: Rename X86_FEATURE_FAST_CPPC to have AMD prefix
Date: Mon, 21 Oct 2024 22:46:04 -0500
Message-ID: <20241022034608.32396-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: f91ee3ca-b04d-42aa-787d-08dcf24c2980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UTvsceMNVyKKVDqkcP7lP6twZnOyIosEhwoGhGgokGerqeNQPR3ag/Umnugg?=
 =?us-ascii?Q?2y0SeZ+NcQ0JevIcmxTWXXoxwMfZDbC0B+VHhu1b/ipUXofmNvFNj2cWt8u8?=
 =?us-ascii?Q?6C3YB5pIYmDyoDtPDYY7XYuVDyZKomFG4hbiHufZds2sD1zIDXUoBQno3vIz?=
 =?us-ascii?Q?xxQlE3wFtcm4xLit36m/aX0bf1kE4tUkbquAnqSB9gN+KZWTpvWCr1W/GTuA?=
 =?us-ascii?Q?+qLJM38cZf0fXmiF5XmCHnaqO8+S8+sdAPx0vrj+FbjAHtnKjqZmOIN/QJsX?=
 =?us-ascii?Q?h5qe01xFMcZO5ufaSJRB1kOb+leKihlRnZ7LSqnIMBDRaIoP6z6H3gkSpg1+?=
 =?us-ascii?Q?WrqgHW42nTR7idaV13Dbn5UvJdQYCjyCFmPhwryTjBLNMFwYuIFES5qL9+VH?=
 =?us-ascii?Q?P7OFELMznJ/QRhv3OKgMUgnN9PthdgGx0w+7CEuJBKf6lETRADDixQ0LNF+J?=
 =?us-ascii?Q?CfccQYlog61e6ru+phY5HV+47wPyeyHtwik/wUu39jukoORN2El2eqeczkL5?=
 =?us-ascii?Q?P46pUjAq1n/YCEDiuu/ZteqdUzxpj06qUn1bxv9eWheX5kbA2/MCdf9NZOex?=
 =?us-ascii?Q?ipImLRuUiHigDvb/rrxR97VrDlIiK+YF5+8VN0l+7fQJihTOR5bF6spgFS3d?=
 =?us-ascii?Q?H+coqQsy9/79K/Jogl9rLNZcM/nnSM1kYTjXRDDq4o+mo15e8oFO7+jZ8CkT?=
 =?us-ascii?Q?o3pG+rs4yNx8v8Ymt9jnpU6Fln8D814x6pr+DwsYPaORRbQ2JIRm6gQgO4pl?=
 =?us-ascii?Q?00OJeEL3rEw32vy7/ecDrrRAcc/wdT+F1pn/+uqTdNTKKO88cC8SHvc5jiqa?=
 =?us-ascii?Q?EW0rf8DxiUAIFiwgDMAmixl8BqxeWDGih2JoK83mKCLxf5DgzSNW16BSFi7b?=
 =?us-ascii?Q?+ZPeIiHZAVd01N5plU8ppdYE9YHJhQ0QMnUqWl1Adpw9gd0wbP6kV3fmuc2e?=
 =?us-ascii?Q?fdcxi0Kkw2FVQgdjVC0OjUnMhRQIszzJyfJ00J4NyuB5nXasL3gJtT9tpSn+?=
 =?us-ascii?Q?hfYcybCy4mILOd0uj9JKIxJPc4q6lHhWHoooMgXiggnr4EvMKKhYiqYzv/4I?=
 =?us-ascii?Q?w5TVJFpbeG9wBlj3i5ivj1rZNNmdX4ZN/05LcCZCXXeMsEY3qM7fTzLpPo+C?=
 =?us-ascii?Q?mmxx6Mzn3V8ayNcXfeEpzAJOahRR2vqmm4ctCz9Ovnx4+KEe0xsfZEzPQgDS?=
 =?us-ascii?Q?xNCU13Pgb1Goj4nQL5MDw0gK8P3+TmrTtlfvKctPsH9gCyV1P02P1R1klOjd?=
 =?us-ascii?Q?4cnr9jp/RfjdUyt4E4HLeuVXpO09VzGc76iWiX83eM0/MhcyvJx5Rt01Hniq?=
 =?us-ascii?Q?uEpuxU2xLW2zvBV1bH1CiIBcJ3sgfJfe1XWPJ48TmsB75f75R5NSVTBy7yUE?=
 =?us-ascii?Q?AZMtI7KEaNZOBSY6IgVWz8D+LX5WgMDN11upYR92xaTGj8gPpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 03:46:50.6708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f91ee3ca-b04d-42aa-787d-08dcf24c2980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989

This feature is an AMD unique feature of some processors, so put
AMD into the name.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/cpufeatures.h       | 2 +-
 arch/x86/kernel/cpu/scattered.c          | 2 +-
 drivers/cpufreq/amd-pstate.c             | 2 +-
 tools/arch/x86/include/asm/cpufeatures.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 913fd3a7bac65..aa63437a677c0 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -473,7 +473,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
-#define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
+#define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index c84c30188fdf2..1db2bb81a3847 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -45,7 +45,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
-	{ X86_FEATURE_FAST_CPPC, 	CPUID_EDX, 15, 0x80000007, 0 },
+	{ X86_FEATURE_AMD_FAST_CPPC,	CPUID_EDX, 15, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b63863f77c677..717b4cf4d9c4c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -847,7 +847,7 @@ static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
 
 	transition_delay_ns = cppc_get_transition_latency(cpu);
 	if (transition_delay_ns == CPUFREQ_ETERNAL) {
-		if (cpu_feature_enabled(X86_FEATURE_FAST_CPPC))
+		if (cpu_feature_enabled(X86_FEATURE_AMD_FAST_CPPC))
 			return AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
 		else
 			return AMD_PSTATE_TRANSITION_DELAY;
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index dd4682857c120..23698d0f4bb47 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -472,7 +472,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
-#define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
+#define X86_FEATURE_AMD_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
 
 /*
  * BUG word(s)
-- 
2.43.0


