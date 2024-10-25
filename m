Return-Path: <linux-acpi+bounces-8983-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30BF9B0AFE
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622B9287A95
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58A20D508;
	Fri, 25 Oct 2024 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IsEgB728"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7F20D4E1;
	Fri, 25 Oct 2024 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876535; cv=fail; b=MOlg46M2LkjxBRmCbmS5Lp6pEYxb25XI7SdNKWFz/vJyiZ2XUDfMpRV4ids3y0sa6fbd1XykKyY7HiKU1CsQDJTUY7ut07Y86FfdlQ5dkoZLb0bsWKrspCi5vUIWWs+Q1QcyR1WxRod6An1bYuJfMacdRvtSePG4U2vVmQxpKsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876535; c=relaxed/simple;
	bh=REB58hOKyh7fDFvVeANX71MO9NXKoJuFtGfohz8Voug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnqWtahZnvNHs+2hbmuuXAI4XvyGR2mCKB48wXFgXAgcVnObL2V8cZ/aT5H5/z5i60XljvFXGG8+hTy0QqLALm2A4RXmXDelghiLVAlQOy/vJIx6MuFTYKi2qTjKq5Bg3AF2r8Mj7bAMKMbIT2a7IlDuurvCF3gnJcXhZuFR+mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IsEgB728; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vn4K28E1OIXuXalmA66AFf9eCvLc5hxbp48CEf3UyMW570W8Y/7fUfrqHwFOaPRWcCCq4TdhwpgkMIoZMV5/Y9HKMK+z2AATLSKSwTQWkyQldaLPWWzeBpvrXMq7Mzqwx0vM87TW1XtrogoqhA5oRvityhus/2/CWBCwQW5ZjXoHhgU7PTvnZ2Er3sA127Pk+cSW0Ocf1qek+Lw5fKlHhpv+g6hge0sAdIBV9yD53LK8svoxlhg4jbl1Rf8OUr557zuy6NWXoLNWGsXl87H74E1fsKB9fX55ek3m7drN7zS9fNyzpVpxgsz2RYswIFTzhSTwVbn1VZ7L1dv2OGrgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/52ZQsp8XV9x/pV4X0hD1rqA9RC0NtMeG4YHn071exQ=;
 b=eh3SiXwH+HFjTYuNOCtm9SS08KEcym4RMfQ6Qy/mt4k5zt2iKrSbAMLXgVh4kRb7BKOLmUcLuC3V3lOYx8k6yXRYSXJNss5G+ubjBNq2OOOs9i4NeKfAII4JUKn9dyS4a8aorixrUADPyoXJLeKEp3kqrqVUvtT16TewZ5PzF02HnmFFtbqO4QPoBtX1sEZQ4ziA6+E5xSqJgLLsgYUes4QY+rWH1V7RfQ1fhkyEyrNwEUM12F7QIMlepkm3Vv4XTqsQW/ZdJqDOg3gdsvCN9PK6aMkgThiiERblsBzW9iQ0L83OGOrzev3NeplunRItMIT7hcDdzEBCN/2sn51yYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/52ZQsp8XV9x/pV4X0hD1rqA9RC0NtMeG4YHn071exQ=;
 b=IsEgB728JW/CXCLexEFFT+tcZyVTJqzpe9yEWDEt2pUkI/Vm6Dv69qD1EhQ8FKRneC0I4V9+iRxvUjJWnjG0KjDZz3HN27Lor+L9LaEN44lPhUB5ZlK5LpsCAHRr3RvaQs1HuGq6z9qocC7eEts6zGr6NfCr4iv6QgLRaN1S3t0=
Received: from BN8PR04CA0059.namprd04.prod.outlook.com (2603:10b6:408:d4::33)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Fri, 25 Oct
 2024 17:15:29 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::99) by BN8PR04CA0059.outlook.office365.com
 (2603:10b6:408:d4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 17:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 17:15:29 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 12:15:27 -0500
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
Subject: [PATCH v4 1/5] x86/cpufeatures: Rename X86_FEATURE_FAST_CPPC to have AMD prefix
Date: Fri, 25 Oct 2024 12:14:55 -0500
Message-ID: <20241025171459.1093-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025171459.1093-1-mario.limonciello@amd.com>
References: <20241025171459.1093-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|BY5PR12MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 60108424-24b2-49a4-1160-08dcf518a019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xkAKak146xPTLQYYdN8+eJ89NCJy+43aiafisIEpjQV94GxV6scuWRfwMDK8?=
 =?us-ascii?Q?eL3HlVUNlChUknjQF21pVgcP4MTQb3hnGjGAaUGGPkZfJQOG1zoTzbZ1UNoy?=
 =?us-ascii?Q?e73OkdZ8VSHKS/8FbimU1hke8qQPt14SkV7qBUx6sh+VqHYcl8GYO7o2CZwu?=
 =?us-ascii?Q?QB7Vz3uQJ4KvLUpF2fUmxCHi2xBEQHeG2AqQpsaR4YgoRras9JD/w+OC/v0y?=
 =?us-ascii?Q?FF65mpce7l1yxNUEIULObA0d9oDPwGRjk5COgbxkoLbg4P+8afK95u/yJLeZ?=
 =?us-ascii?Q?jLdl6ticpyo4rAXvDjkI+ccK91G4H9pQ4aEi96bnzxyHBiVONRkS7Z6RpUXv?=
 =?us-ascii?Q?h7VKqxOm4U6k/pbCyDaQ7WdvhkLEkq0QoLFuQc89oOlIjAaaTocG278LiQat?=
 =?us-ascii?Q?ot29s3cs9wuDdLb82aRBe0RvMrIALnQeHYyxUqQEDNS1U7Qd1fqgWJYG49fi?=
 =?us-ascii?Q?dZRZFy0hTdlaSi84/C2Ms/XxF84FnUC89HPXU2Qf/dYG8iAhZ3MKeqJWc0Yr?=
 =?us-ascii?Q?tQo8g3wn1XtVR4psAmD0313i0If9Ysj4VF+7E5QRQ4cmHckN+cbQp621dKe8?=
 =?us-ascii?Q?EVRikQZBFRC6Qrdz366Kx+AVjVsa6VYAqamfEbticDdyhlODz04gNmtHGBH0?=
 =?us-ascii?Q?eT6FipVSzKKTsMN5uGCulTc5tJCtmsGrvNf0WwWu8pY5xZHVEqSTS9Mj9tSw?=
 =?us-ascii?Q?6Rw1gN+u6TfkpZd+E6MFG/PdtVi5hoYZ8qdV3HdJgNgcNDa89KopD6FCuotk?=
 =?us-ascii?Q?JNaLVVcAobZzmAe7Yn35NbkuOHA8vbDP1R3QQ7A8IKkEECDQAOZ484chMIVt?=
 =?us-ascii?Q?xtrI/6uLlyr6hRZ6eeeHiCPh46ZTmYYka5jk3zJp0gCxgkloEUvOx0L3ZX5S?=
 =?us-ascii?Q?5YC1vdYFZ4DDJwe/Zt0UoASYSTsWNIMb+GW2h/86VmlE6PPbVuDUPHH1gvKs?=
 =?us-ascii?Q?S0e5hG9AS1QM+foGAkRlcOuZyxKgvP6NtIufuGm08vMslLjccLGVsibVNuRh?=
 =?us-ascii?Q?2nuDzXuX/J7JdBagLF6wuuIhfzq5qUb/bW5TUTMvwuDKmW1dafgUAO9yVSIO?=
 =?us-ascii?Q?9TqV+dhji8QCPjPk+jd8l8fS7egwSzAbtcBo9P5t0v56cWbRYLD4xdVlcm/S?=
 =?us-ascii?Q?2sDzUMrCIJw6+Ofunc/K84hNX1Qoh0CdE/ViEpcpBslYgFcZ4nbUv+NFEr0H?=
 =?us-ascii?Q?MZY7nPxntsfvupGybpyVDZiQQ9frVdeK1IXKvKoLgUGBO/NJMVicuJk+uVUk?=
 =?us-ascii?Q?DOXlWvxYzGYIvATWQCsAJvc1fAxpXfvIV0BUSt0M9dw3BjUiM3yXwVkcmggI?=
 =?us-ascii?Q?07VMwfh4EzsYnECpMXlY/u6SfBKCFol+qe29E1ddMXnp2gzRoE10Ac3E6z+y?=
 =?us-ascii?Q?EWQkC2zbELtc1rRGHcotakpniNaU021k9FWcFxo190PZZ0jObw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:15:29.3160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60108424-24b2-49a4-1160-08dcf518a019
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274

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


