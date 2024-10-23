Return-Path: <linux-acpi+bounces-8938-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFDA9AD316
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 19:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2FB1C20C03
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C9D1D0946;
	Wed, 23 Oct 2024 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EgSuisx7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117F1C9DF0;
	Wed, 23 Oct 2024 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705489; cv=fail; b=TCre1yGNXK6GmunazQqkBg28Co7FGfNrt6MhEKqf/ryioQwNPRywq0e/sM2kp3la5sY7P+uaEt/qKdeiQOCketJZmuBfCjQMKDiReIdp5lzmF37T601V+HrsY2hW4wLu6jZpZC79McofLEY2zMEmXhs/hOHz1q2x9tlITbXzSks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705489; c=relaxed/simple;
	bh=/D63Q25KjY8gAZqJzmI82Fx6EC4b55e0Fwxdsbyqn8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEPOI16Y3gUM/nRTjhm4UU/SwGrvo+NAMNYefGJG7cP++MqrAOS9AWj8mRWjhoMW3QLIiHPhh0Dw7c53VaE6a7oPrd7bWrlJMrnj1cWn+HTCRq36wnCcdiw+IPLWuABGAJ9AtEDaysHdLPfkxZ95EcOilcjQBLe+h8LUUZ5MANU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EgSuisx7; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPoI50RFdtyiOh7ha6FQlFWzHx98Hhmv/tkmYQJDGIhOqBSmeYnvqSgb+rfbQA9WN2ag98Ctk6+4ActM2vw91TlrqiZcaHsgIKa/4zCITzcBdowGSVXioJmXzTaTUlzri9oedhT8n9q+4m95eODxjeRirhFCEJ1DTKEpH37v6QTxD1uix5/tD1jR573HdaxsLQ96aEvohxlqUDHp1sFGi+ulNQvmSD4h0TPdcW1SDj79WYyc3DC/Sjo8I1yg8nI8rZ9Lq7LM+zed0cRrTfijXDaIqtdNoGv5V/1JNWLHtopnPmYt5AgPdNSoh3H/NEY39NLVAmjA8MEIZrCZo+8KdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vi23DQjRuosKmxswA1gpCBi8BwBcnoPIVfbl2NWRQ2A=;
 b=t4uYxkj2NhVYwm9ES+70Kr5U/lFT8PZi8O2287M3zPNctYV2zmh7FbOYVbxu/01ozjY6a20t3TvlUxU2ytYi8zlm/M9WnzBi03Vr0fB24lux6ZsXvq7rLdsApJx9H89U5F+kUO8vZEqDOxC6EM3/7XZJUdMB82R40Ny2BippuTFp59kR0Fb3PYEz/ez0xRVcfiUK5RiBnnFUa7JGf5KiKg/KddfIcGmbKhQIihgnnlYdrRhFFVA/wzKNzlNXSX3niEUSk1FkyY5kjQ56cjLkZ+VEertzPI6tydY7toMivsw+rXfOR7Kta9ZfIsjgp+PFA8SCqpGsmHZSz8Fo2tpfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vi23DQjRuosKmxswA1gpCBi8BwBcnoPIVfbl2NWRQ2A=;
 b=EgSuisx7kH+Cnw1vQzFDH328DBhWkUWy9HUEhVjsZPSdJYQCcD5r0zJztdJh/Jzi1yuuqzCyQzUdn6FrdRqSLNCPxfWmbAyjSWgytzFcUJSGm3RCfl5cuw0fQdLLI1jStWCftiT7JaZJVtl6CASc4oIGbxl5YInBxpSdnq1iZDo=
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 17:44:43 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::9f) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 17:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:44:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:44:40 -0500
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
Subject: [PATCH v3 4/5] x86/cpu: Add CPU type to struct cpuinfo_topology
Date: Wed, 23 Oct 2024 12:43:56 -0500
Message-ID: <20241023174357.34338-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 49bcdb5f-a964-47c2-8533-08dcf38a60bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VCTEEN8OXFj+wubX+2AfM5o+1Vr0hsfRBnhska8h5TRaKhho9O6j/WttTQ3C?=
 =?us-ascii?Q?lLV6Bl61+iM9en4zuFaFQxVvKTnoxw/FMPpRjGHxyrkjd6fVX9VP9rrRQj7P?=
 =?us-ascii?Q?ygLf/atasbgBddGD8/tEENVuuJRjdGFzvHg7uSFyDw0lP07bQrXZXD6/DCxX?=
 =?us-ascii?Q?jU9gvyKPAb4ch+iY9AbVeWI5MQmZZylrsfKlM5DW7rWvOisg96dqynjeQusa?=
 =?us-ascii?Q?b43FejykngDh8KjMrlM6SMIXgLFkSO2wIYFwQZw4+YMeGktnj0XUwfqd4VC3?=
 =?us-ascii?Q?H3XzBs+//MY27h/cp+rcSkAdYo6NZtSvC/OeCXyZV4TA5QDVYW2QrhihT5pO?=
 =?us-ascii?Q?0Vc7B8N+r37NH51SLRW/pOc8lr7I2wNP8dyTD18dB5SzzlnOpMZOPaI/xOkG?=
 =?us-ascii?Q?0jQ2Iep78FTcIoaiuxCPvf6VENbsS7Sh9Cl1L3QBeiclAWmdOOT0Q2I/w+Mm?=
 =?us-ascii?Q?CnE36hnmmJXLeA+vwXyvGSUgUW/yUJk4nL1IZz0Tm2cpn3ER50tEitcFJYsy?=
 =?us-ascii?Q?Y/M30wzW3f0Lq2qoQ1huxUx+pUmvesNUA7LRK9l51eF61/hf6Jkm4QDdz6Jq?=
 =?us-ascii?Q?/y0gcMOJWJ64Z86oKstouVSNvSycE75GSJx5/KVZ6svmkUYzZWEToX+WMpf7?=
 =?us-ascii?Q?CvEhrmBdtukjGWE2tmIW3SQeZAA4eYaSQrMOcqnw85pY+fojqV+5lMJD1IIN?=
 =?us-ascii?Q?JvnmJ3PDDSNBZ/+1JJ06axDdoDrysTV8qEkgnj1+7fRelzDh2zw/1vlZPUOp?=
 =?us-ascii?Q?HRnh27tHE2DVSTl0kyR2qmTDEv4WU+v1DvO7Kqm2s80rsGFou6MC25JLnO36?=
 =?us-ascii?Q?Ob/tkwZvgtVozoDVBvI9XtTyXC4Cs5wf5dE1xMojjdNBCPQWtU9KnnBgIX+f?=
 =?us-ascii?Q?vvbJy6b6vGPYAcl35pKfK7sa261duWwHbskcGvsQd5lbTVz2/Vx5p+++NSaW?=
 =?us-ascii?Q?pqG9EAPW3dgipfvyH5/YZasU4Vwvn3zMdv62VaurfqaMNGIl2xsOdn2Sgf++?=
 =?us-ascii?Q?xAMqOmDvYYqc5D6aXbs770SBPiGlbpLsk7ONlvshhh6NaT7eY0IWvvctgI2d?=
 =?us-ascii?Q?xvgnqAIbaoMi5WIn21fnduh2aYNgYvlPi/AVa2FLwTRaQ4ncQ5j00YDGkwEN?=
 =?us-ascii?Q?6UdTYmNB2g4yHG3Vjv7v97IOtmxVH8NUxC4lNi6AIVkX74m75rbegQkrPs1w?=
 =?us-ascii?Q?w22+40uo6CVzISq44G+TBmxSqzeMe+rJSFQx+atf4Yna6NsNsl1iuw4/+FIq?=
 =?us-ascii?Q?N6lWM+TZcT+VbguUp6m/5qTqBGUPO6STY5Dei85QJJc/jsQKRlYVQCVLo04v?=
 =?us-ascii?Q?m5WE3dvYtCtC0qOXQPDd+XuY5PlE5943GxaQRq8wm+OZVOTBaAe08npLgcyT?=
 =?us-ascii?Q?a11Ejc5j6SHd9ZTc8RweHawZnY6qFFerIWifgTGFSkK4BZSg8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:44:43.2209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bcdb5f-a964-47c2-8533-08dcf38a60bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Sometimes it is required to take actions based on if a CPU is a performance
or efficiency core. As an example, intel_pstate driver uses the Intel
core-type to determine CPU scaling. Also, some CPU vulnerabilities only
affect a specific CPU type, like RFDS only affects Intel Atom. Hybrid
systems that have variants P+E, P-only(Core) and E-only(Atom), it is not
straightforward to identify which variant is affected by a type specific
vulnerability.

Such processors do have CPUID field that can uniquely identify them. Like,
P+E, P-only and E-only enumerates CPUID.1A.CORE_TYPE identification, while
P+E additionally enumerates CPUID.7.HYBRID. Based on this information, it
is possible for boot CPU to identify if a system has mixed CPU types.

Add a new field hw_cpu_type to struct cpuinfo_topology that stores the
hardware specific CPU type. This saves the overhead of IPIs to get the CPU
type of a different CPU. CPU type is populated early in the boot process,
before vulnerabilities are enumerated.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Remove a bunch of boilerplate code
 * Convert to showing string in debugfs
 * Rename to get_topology_generic_cpu_type/get_topology_cpu_type_name
 * Add Intel definitions to intel-family.h
---
 arch/x86/include/asm/intel-family.h   |  6 +++++
 arch/x86/include/asm/processor.h      | 18 ++++++++++++++
 arch/x86/include/asm/topology.h       |  9 +++++++
 arch/x86/kernel/cpu/debugfs.c         |  1 +
 arch/x86/kernel/cpu/topology_amd.c    |  3 +++
 arch/x86/kernel/cpu/topology_common.c | 34 +++++++++++++++++++++++++++
 6 files changed, 71 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 1a42f829667a3..7367644720484 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -183,4 +183,10 @@
 /* Family 19 */
 #define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
 
+/* CPU core types */
+enum intel_cpu_type {
+	INTEL_CPU_TYPE_ATOM = 0x20,
+	INTEL_CPU_TYPE_CORE = 0x40,
+};
+
 #endif /* _ASM_X86_INTEL_FAMILY_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4a686f0e5dbf6..c0975815980c8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -105,6 +105,24 @@ struct cpuinfo_topology {
 	// Cache level topology IDs
 	u32			llc_id;
 	u32			l2c_id;
+
+	// Hardware defined CPU-type
+	union {
+		u32		cpu_type;
+		struct {
+			// CPUID.1A.EAX[23-0]
+			u32	intel_native_model_id	:24;
+			// CPUID.1A.EAX[31-24]
+			u32	intel_type		:8;
+		};
+		struct {
+			// CPUID 0x80000026.EBX
+			u32	amd_num_processors	:16,
+				amd_power_eff_ranking	:8,
+				amd_native_model_id	:4,
+				amd_type		:4;
+		};
+	};
 };
 
 struct cpuinfo_x86 {
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index aef70336d6247..795619ea13346 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -114,6 +114,12 @@ enum x86_topology_domains {
 	TOPO_MAX_DOMAIN,
 };
 
+enum x86_topology_cpu_type {
+	TOPO_CPU_TYPE_PERFORMANCE,
+	TOPO_CPU_TYPE_EFFICIENCY,
+	TOPO_CPU_TYPE_UNKNOWN,
+};
+
 struct x86_topology_system {
 	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
 	unsigned int	dom_size[TOPO_MAX_DOMAIN];
@@ -149,6 +155,9 @@ extern unsigned int __max_threads_per_core;
 extern unsigned int __num_threads_per_package;
 extern unsigned int __num_cores_per_package;
 
+const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c);
+enum x86_topology_cpu_type get_topology_generic_cpu_type(struct cpuinfo_x86 *c);
+
 static inline unsigned int topology_max_packages(void)
 {
 	return __max_logical_packages;
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 3baf3e4358347..10719aba62768 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -22,6 +22,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
 	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
 	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
+	seq_printf(m, "cpu_type:            %s\n", get_topology_cpu_type_name(c));
 	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
 	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
 	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 7d476fa697ca5..03b3c9c3a45e2 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -182,6 +182,9 @@ static void parse_topology_amd(struct topo_scan *tscan)
 	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT))
 		has_topoext = cpu_parse_topology_ext(tscan);
 
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
+		tscan->c->topo.cpu_type = cpuid_ebx(0x80000026);
+
 	if (!has_topoext && !parse_8000_0008(tscan))
 		return;
 
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 9a6069e7133c9..60d5d74189a30 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -3,6 +3,7 @@
 
 #include <xen/xen.h>
 
+#include <asm/intel-family.h>
 #include <asm/apic.h>
 #include <asm/processor.h>
 #include <asm/smp.h>
@@ -27,6 +28,36 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 	}
 }
 
+enum x86_topology_cpu_type get_topology_generic_cpu_type(struct cpuinfo_x86 *c)
+{
+	if (c->x86_vendor == X86_VENDOR_INTEL) {
+		switch (c->topo.intel_type) {
+		case INTEL_CPU_TYPE_ATOM: return TOPO_CPU_TYPE_EFFICIENCY;
+		case INTEL_CPU_TYPE_CORE: return TOPO_CPU_TYPE_PERFORMANCE;
+		}
+	}
+	if (c->x86_vendor == X86_VENDOR_AMD) {
+		switch (c->topo.amd_type) {
+		case 0:	return TOPO_CPU_TYPE_PERFORMANCE;
+		case 1:	return TOPO_CPU_TYPE_EFFICIENCY;
+		}
+	}
+
+	return TOPO_CPU_TYPE_UNKNOWN;
+}
+
+const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c)
+{
+	switch (get_topology_generic_cpu_type(c)) {
+	case TOPO_CPU_TYPE_PERFORMANCE:
+		return "performance";
+	case TOPO_CPU_TYPE_EFFICIENCY:
+		return "efficiency";
+	default:
+		return "unknown";
+	}
+}
+
 static unsigned int __maybe_unused parse_num_cores_legacy(struct cpuinfo_x86 *c)
 {
 	struct {
@@ -87,6 +118,7 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 		.cu_id			= 0xff,
 		.llc_id			= BAD_APICID,
 		.l2c_id			= BAD_APICID,
+		.cpu_type		= TOPO_CPU_TYPE_UNKNOWN,
 	};
 	struct cpuinfo_x86 *c = tscan->c;
 	struct {
@@ -132,6 +164,8 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	case X86_VENDOR_INTEL:
 		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
 			parse_legacy(tscan);
+		if (c->cpuid_level >= 0x1a)
+			c->topo.cpu_type = cpuid_eax(0x1a);
 		break;
 	case X86_VENDOR_HYGON:
 		if (IS_ENABLED(CONFIG_CPU_SUP_HYGON))
-- 
2.43.0


