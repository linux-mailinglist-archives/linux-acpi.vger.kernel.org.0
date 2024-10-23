Return-Path: <linux-acpi+bounces-8935-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5E79AD30D
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 19:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEB71C20F78
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0591CF299;
	Wed, 23 Oct 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LWtyaJd6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD50A4087C;
	Wed, 23 Oct 2024 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705487; cv=fail; b=EE9mEHJQp6TBKDoCTWrZWWoeWRog5MNhlWCMqT+xuZBthMLt3fNm3dV5ipsd/t+TwDntxIkIOparnRQwqvBF0H938BjYiN9t+5Ax15MO022ajKm7zn9SRjp/Z+FbPSrY5j3TFqdoutEuMDlEwIfyGtk95ljdIArWtgknBZIIlTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705487; c=relaxed/simple;
	bh=REB58hOKyh7fDFvVeANX71MO9NXKoJuFtGfohz8Voug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvg1vtT59oOp7afhC3teCJZNHSHWVn5x+eyHV0KIat+284OR66qmopA1BPQxTjaYE8zoeG8rSHk7mEjr+W0Jpk5YvQxYmvOXlSwhY0/q3pNNxkz8i/cKVPbuRAE7GerOzrZ7nCpny8kjRY73/ZuTRb+HBVUHNDX9en1Rbbwx28w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LWtyaJd6; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1XXLosJUo/j6u8H0ynIJchnUTH3GbMXEpvHuYkYO4nSIg3XWuicu0wKqSZTpBRUDkYzo0HQye8r9xfRTn4MZT8anYNX2wsU2W6BwRgqgK27nDWYXQ/TEQCsEVI5nRLdsS3+IJ7WcaBGl+v9ZpOECDHKuEtVSo5JXudUPQVnursGNNStkfOy+KFLF13qZiq3O7B4v0/9sXqe7vuU+QtBYr/Vmn1H3OpqFYVNj8ba+lLrr9QhfoB3mX97QBBYXE9ysSj8GcvUp+7RsfG31h40Y1q3puVuJXadKm6FpBTZzAMCckfxGVtY8+S+foe7tKUKvXg/1jLxIUF/gZdReZnVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/52ZQsp8XV9x/pV4X0hD1rqA9RC0NtMeG4YHn071exQ=;
 b=zEYfKP8zO8akJw7KNWzmHOclxumyLOjrumODSRtWHnECss7Vf095EvWIzBhnW+iM3U6mC3dnmZwP9RKjMDSErEIsA1/F9px42B+79zt9MIdrYAiId21dlK0K2wDUtHCzZOW8Pu9/m4yEyPL9+5qHcxEYmcGhGTi4bX8DPpHOM6QcclIg+jANMVltKcY8kk1oQdD2lzkxH/ieMqBsRKhcTPoJCC7sC1uaSFqzAfC5y7O11+gftD34pQuRriAH/axjpNWxoHQW1LSAH3Fp0qX4glC4TzSdU6sseuwwVrxAXZJRnAf+LxGiUrdmGxg/yGHUVstTQiho2Y2j2pCbZeXaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/52ZQsp8XV9x/pV4X0hD1rqA9RC0NtMeG4YHn071exQ=;
 b=LWtyaJd60+FsQkhH5msyeNasPeaERgLASHymC1O1q+MWJ3QkQiBxadzfHbP8F8ToWNk68T0taYDobalCygr/v/KeFpwcI1B/YvHnaJPU0eS41o0gbXytiuXXv3bfjJ+VcHgLXIXhrhhAN5OsFKo5oExEZuFDj120fCh8K550PLk=
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.18; Wed, 23 Oct 2024 17:44:41 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::9f) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 17:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:44:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:44:36 -0500
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
Subject: [PATCH v3 1/5] x86/cpufeatures: Rename X86_FEATURE_FAST_CPPC to have AMD prefix
Date: Wed, 23 Oct 2024 12:43:53 -0500
Message-ID: <20241023174357.34338-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023174357.34338-1-mario.limonciello@amd.com>
References: <20241023174357.34338-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DS0PR12MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6951b2-e04d-490b-bccb-08dcf38a5f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PiBO8dxAtbVEs95BYz+4D2OfwOKmPXbPMXDCATSetxwY0p43XU6NBdrX8Ab9?=
 =?us-ascii?Q?S8i8FlL/5C5yTvBRCn0j/IK8E/HKmfmYnLx0S0FEBBlaYO2U7Dq0Se+OD5M/?=
 =?us-ascii?Q?HGs0mhMiEQbDJSjN1U2bErpE0LhLJCObqm0hJRYM7KsO0282GuF3aCwdEM5c?=
 =?us-ascii?Q?1A16NndbZCpkgZuyHOHlDhiqQRK1KTywmFeioPK30WyQLoXGa/vdCFOwmvOc?=
 =?us-ascii?Q?0oXBQGBrUMCDzS6Jz0GhP6qsmWaWchtuDafv8rFNsO/SnaEJy+tFeZ68pXnG?=
 =?us-ascii?Q?trDzeW5DE/zRD9L1IpCHTresDWqbJsO3fs2kS6T+YXdoEmW7ur+l+0Mv+/jY?=
 =?us-ascii?Q?qAtxSREKv0++bWxMoxvuZK6b33CsuuIOuiu512yklyakMhS806nxwCs0BVhU?=
 =?us-ascii?Q?j9MXv66Rv79SJjncOqCyhLTfyq/36XHoLrtFMGNMTftpKw894hMh3amfZMwZ?=
 =?us-ascii?Q?QKu7ZSBr1TuotKwqBG0lQamQrC1Q+xLunH/GysqRIBtKWycEu4h11SqQSUKO?=
 =?us-ascii?Q?R0Eqnei+4Tl7aVmX84Bdm8hs7Lk+2rrRAamXY5tXEh9Z6IRI6prQQbRi1Utk?=
 =?us-ascii?Q?k8EUGe/auTefhiRCmLjkh/49+UW1JeRMpmZyH3ZJbmhzHW89K1AXn8IKf4ya?=
 =?us-ascii?Q?XyZ0HHQ/HyNp0jkR9dzMUZsCqAQsOO352N4kxh6FItPMw4G+Xcio8a4aL0yJ?=
 =?us-ascii?Q?CbvP7MSNzQus8K2e+TsqoC3S8fAhTgbgnHJ+13Ul+NQsvdCtFWnVdEMQv7lN?=
 =?us-ascii?Q?VQmPt/bLMBRmY2UzeL+ycUxhoC7A6qoZkwM5rbQFI4oWta8z2AnzdVFHPeXJ?=
 =?us-ascii?Q?+mbalSps/cH81DqBs+h6FPcXrIZFEY2KxOjhsYm02BlFvEreeDjI8kS75xmM?=
 =?us-ascii?Q?Dy3IPHKWUPv1yUBl5wcp+5vrCX3EAVPH6Om8+QiQipO4KQ4E7lT6JEsHqI1x?=
 =?us-ascii?Q?cmiIBttDKCl77NC0QMg47Kl/i5FVVj6Ats5Kr/aPWCqRvCu1gUr6nQkrp3Rg?=
 =?us-ascii?Q?a4a0WW3iUd7w6DhHU+ns0FCVydXZCMU6CyFsBhJ3a6CV1fqC/VpnW5UKGRhr?=
 =?us-ascii?Q?aYdFsSLk3Dl6o7rEJv6jbvY/NFzw3/p09sBIzCFqcDBap7b4PvgUIB1xwIqd?=
 =?us-ascii?Q?d5FAnkVmnhuWmBHEG6HtE+dAjLP/mBxW86pRL88WOK0PLJ/vOYXB/i8C83mX?=
 =?us-ascii?Q?rRLJBWomVjg3MfE0e9TKloEM88V+0TbR/ag64ZxRCZri2GoeCtusvIFBqzBr?=
 =?us-ascii?Q?sshspyjTnoiTUI5fxCSAqypiEK5SKzlN5fljG01jp58KM7vmq17RomJyO54E?=
 =?us-ascii?Q?fbprEr1CqKoO++VxB3MeOKQN9n4vtjpeAcb8+UH4zDXndol2sd1kv5+E//Nm?=
 =?us-ascii?Q?gxuuSQo3SZKWzTxel2++eJKfcLTGXI5IbaLVGnbrnljxWNhc+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:44:40.8146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6951b2-e04d-490b-bccb-08dcf38a5f4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653

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


