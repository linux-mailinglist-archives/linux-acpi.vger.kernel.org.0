Return-Path: <linux-acpi+bounces-8887-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CF69A7185
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 19:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9C31F234D8
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 17:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915251F943D;
	Mon, 21 Oct 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NwKBNAz0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A81F4FDA;
	Mon, 21 Oct 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533412; cv=fail; b=Y3IdLci50Bv0jAXUmMPmigtTqLwKOXpkTZL214R95y9C7jsxfhI+ZWfEurllFgErfZwEkxJN0ejSYu83kCgf63aNyG4KHqbrLEe3sgTietbEGipkoZhREkAK9b8FKuSiXRdAu/6XSZ1Xrmyp6Xb026W7S9FV9EKfCV5YBuwpezM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533412; c=relaxed/simple;
	bh=r3PEmNLKPEql0NWR7ArVrrPHRhYpZwQnGkTrzTrXSwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCcp/S/aQqYDQq02ctbP0aYGpASpCv6Qje774KuQBzOMK5DWQwuSmu9pgty798Bswsde+YvDxcG+Casx9FoXP0Xb7IpzNHqJjDrhuhJVw7gfyg4HJGsB8PIPzhrW4L6o8BW21Mfz4fS1YETw+sxUQWpiYSqrnnf/FbvqoFadOao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NwKBNAz0; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfw1CFgmu6e9AQsCj0K16D20TP6VYFm0cULT2Bd1GLqvsrtQ/GJM6EwkUUDRaKSTzlrExXNTH+tEJpyvWpk57AxDbS2UJ0Dnxq2NCLbtSDjyRgg101jSI56uIC+HQbIFddD5pIoGzNvCaF2fLMb8I3uOnbhrLBfhGezf59l/90I5ts4q/m0nfT5l8AjoZZPRgDtPLmF5rxoGePnd43e6/WMOuDyyA1bYESK+vUQEPsAvCJjtqnr8gdKMEb1ptOuIYnQztO1QoY6SeUQDjhZcrya+yI6K+BCj9RsSM5ztcKSn32vASCqRiCGbnOpWBc+e7MLJNRewxzn4dq49IKl90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myB7c7oo5B4U+KMcQwNALFB0ZB7w8rT0m5nRMD2atQw=;
 b=xCF9nNaBs3DcY8lbKninKPJEz6kG3dxYg+jUdHxMWqBRy+XYWplM4Rjg5bI7qbXKWlYQcwI+IfjI/4XX4ESJmA2zrul+jkEyhXxhC6v6qOpFu6Z1F1hSxtlNiWViqwkv7ofMtjeAEyA01GTJZWureh2PLAa/ZGN+MbM0TuZ/Ej/uG2UxSkDRD9h+vxBXT24YkVB/4+Ivsl7SghsPuRsKTjgCk1csyfIhiOm3WDi35Jw6ozhvlLojM4eJ8HGv4n0psRj0HSF20axEfeP4ISEivDBix42xnK+8otTqh0ILpzdU7ejAXfujKg6PfIOjda2Ty3sL9yM5foSDNrnmmZ2F0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myB7c7oo5B4U+KMcQwNALFB0ZB7w8rT0m5nRMD2atQw=;
 b=NwKBNAz0WlhPVHZuDVI4k6CCV7SZenKAXzUNmB18N8B+rwjlIweCWHI+gZeUfgR7LXqiduhNJPjVBPCddDuFVrh++yjuYLWeBUOh0ocCimc2/inP4Kafi46qA7WvfER083LlQXMyUC27aybJQnQoqK8jPfhZs54zigh/42qR3qU=
Received: from MW4PR04CA0388.namprd04.prod.outlook.com (2603:10b6:303:81::33)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 17:56:43 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::e1) by MW4PR04CA0388.outlook.office365.com
 (2603:10b6:303:81::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 17:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 17:56:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 12:56:41 -0500
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
Subject: [PATCH 1/4] x86/cpufeatures: Rename X86_FEATURE_FAST_CPPC to have AMD prefix
Date: Mon, 21 Oct 2024 12:55:06 -0500
Message-ID: <20241021175509.2079-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: dad8b7e6-163c-4f54-1a08-08dcf1f9b8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ks5VSURmadcxiflrDDiDChvs6+ahSjXp6ZF8fxVyOGCuciUFE+xvIUVhxdd?=
 =?us-ascii?Q?OaKF2hzNCf4mg6gsT2gvD9AUjs9EzxErEFe5MYyLPhmfGcUG/Jl4hGNPshZ+?=
 =?us-ascii?Q?ZyZ0H6NhALnQXl24Z0X0BKroV5BIEE2K3Ut7FVx2JmuJ64MWv3RyioFHbPx+?=
 =?us-ascii?Q?83MeBKALRHh67tFfDap2+pT85uytJpwIhWj/bq8tHmjGMLHxrU+AfStBX0O1?=
 =?us-ascii?Q?c+8i/7qYmM2B9Ya0m8HnvqVOFUdYzhBUVQJXc/aRxPbZZou0Q6fNFLhpu20+?=
 =?us-ascii?Q?AdEEE0GNVHi5l3COZ6TfMAPXZrlZhbZndfXTmBo1utAHfw8ppoI3rX7hG60T?=
 =?us-ascii?Q?juWaEm3iOxbBuub18P9hYYQbI37zWEXrVjMl1ylUFK8dNn6rQ48YUXpQYKAX?=
 =?us-ascii?Q?SxWJcC+cc21DbsrRNSrhmcOL6jwMEdkHG4LQ8plO4o9uaepYQOvNRw5O13Nr?=
 =?us-ascii?Q?mHxe6D762NQ5cAOgUmKpA9OiOG+5i30+5ExKYkZEQtWw0MzAxpmKS41OKS0p?=
 =?us-ascii?Q?tFAnkuquQIgEE0r/IC4tQFu7R9YoOHaoS+5gCp/KWslQWC8ymCmBNGThxTxO?=
 =?us-ascii?Q?hWHE9CBeCz3xN2BsnD1q0xRNnodktuO3tXf/Qnxa+SuwwKcag1HEfn/F1X7F?=
 =?us-ascii?Q?nF0uN2E3MIhssZnibxhGA6M8x9gXemFOhheiaPm5aZXyRgIy/9W8CYrcCLJD?=
 =?us-ascii?Q?G0W7+RLu39qfVjFPDAgLnLzoRXgAU0eiFi/9/Qy/OVT4WLBJ/qasasq8Tt9M?=
 =?us-ascii?Q?NtBsJBeV2DcfdFmSyOrurkxi4E2+DtduVmqRM9BOQxqkp0M4fsbwxMFr/BBz?=
 =?us-ascii?Q?s5F4lEbS60e2gbeQXWj6NmBk7LmYWfr6t5h0ygEvpoOm5q7GTfNLqjAyQhG2?=
 =?us-ascii?Q?6hZo8oBES45QPPmxD2znr+c9gq2d/E5Wyc2Od2N8bgr7ZfSX0d/2MsetRKEf?=
 =?us-ascii?Q?/BV9fL60YZZzQsqnZPeLwcmx9c1Th6IsEFL/hiGUjEyJUpJ4N8L/Pa4HHzrD?=
 =?us-ascii?Q?GgyUf1sTf1OrIsWwhXfeu8O+fAMbypzGo/W7VszIxGan/cRQC7aIDazV8PSB?=
 =?us-ascii?Q?W9yYaRWxI7Uq6Ef58+BNsQGwZfteX6e8y8FJTB1TG/7aSe3W+IM13fCGqXLz?=
 =?us-ascii?Q?7+y1X2UwI8yWrGX5bzogSKTeL9y14mEHUWOXUE1dBOadtJboa8nBa513gP4R?=
 =?us-ascii?Q?HONIluLzc2gNRqk19sZ1ZmeiQaLGNesEfR3KunIrAWzCn690prI5wrvtS+fe?=
 =?us-ascii?Q?gwaxbho8PTVE7m5uLWcmNlE9aYp40oAoQLGkM9HNXAL2pbJ3h/hbNwi6d1W9?=
 =?us-ascii?Q?479wfatKbWFC6b5zBZ+a1Ts+3DX3oantPrGR+CUhC2F2Vqo1xLLshQvOQwKx?=
 =?us-ascii?Q?PfoDkjA4i3U1dvqQnR9tcc68x/WGcHK4euE3hXnocLx20wTr5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:56:42.6907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad8b7e6-163c-4f54-1a08-08dcf1f9b8b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257

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
index cea1ed82aeb48..424bb7ae8914a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -472,7 +472,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
-#define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
+#define X86_FEATURE_AMD_FAST_CPPC		(21*32 + 5) /* Fast CPPC */
 #define X86_FEATURE_HETERO_CORE_TOPOLOGY	(21*32 + 6) /* Heterogeneous Core Topology */
 
 /*
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 3bba55323163b..d7f2c19abce33 100644
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
index 3c14962adeb22..2670bdcad6eda 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -844,7 +844,7 @@ static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
 
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


