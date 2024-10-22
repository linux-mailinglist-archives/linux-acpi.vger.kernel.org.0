Return-Path: <linux-acpi+bounces-8898-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB579A974F
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 05:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EC3283830
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 03:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB1D6D1B9;
	Tue, 22 Oct 2024 03:47:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E2C1F5FD;
	Tue, 22 Oct 2024 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568851; cv=fail; b=i+l0Y24XYvpNPkTtYIOChDrlqWI5yHhyMYbktQYJhFWSdFr3jEI34JDmYXpxFjKBXK2Aq7p74sPWzD+dkefL1rUXfN3nPPb6EYDlXTbDQKOF8JcaPm85sRPZqH4ZW3Q9ZLQyR5wFSfEisp7y4Cl59Mo/aKmy8YBIQx7eJt5XcjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568851; c=relaxed/simple;
	bh=+HohxY0fTvBt1dIu67fk4uWvFy9osNwDoFbIP2Pj8ZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctRKBHLE1eVQHd7zjb0SdSWTICL3CMUmOgQjdQtSZrzGBmqsquHv9KpX+R6CAlYDQD4F+71aWrL7Fr9Ve48HamxZuFua8mlqQNPJmZezXA4Em4sarPmTF9EziRr4cCDHBt5XXQBS88JFsPR3Legk/rY0y3gJ22BVR3cQbCVJHtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfiQ97g0aUtVryl8Q9x87/yK5c8CIzdCjqQXuM1LRnP3JXF6MViYggQwQ/Bw5IaSAOgEjIx7Qa30G744qAHxhpnR6iOigDPO1Q2RWwviEu/LA3qFoEejm+dKK7opRFjnHa29vzlFoJaHjHQEbzwpFyTMbfuZfTuDcs9qHR6xZ9085wYwIwu3SPtHszP6uekhdCZ2F0JR+p8XUEXmrlL+TMznpfE6IVT1A1ixaDE7WVOACYVrbWuz0D751UoxpYsoOhvYvfFapWv5FYHeOsEUFlyY3HMBwqTQ1/orW9ZFE4qlmexBvrWPDSzdEoVCCrBJRzzRoWlZlQLJ2na2t+WMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYS7auNHheJN+DbwD13YUN1UpOO0v2tgu4KfkPCpo5k=;
 b=OJHWyI7tPNwyasvYDof6YnHPM6zu1QkgNQNu91HL5kV0hY8Kp1MEj3BwFtlpTP65riM7GvR69raWJWewmnbglyTp1lm1cvtYVxo6gJ99uQnceO6Yi/jtOp8AEQIKm+vlWd3YVmBnkaEaO4QNflV0D3/cXyi4Erwtp/EoRqN1K/XVyMc0k0PvAb4mhvZaB+xwpGSXCH4+H7ar5pOaqYbZUhUvtFmzoT0Xn3jitBwmwgZMJPWSM+pfQd0hAsfoodBQI2pkllSlx0rolC9Bdsun1YhRYGVRoGoUJoZgR+L5sF+5mj2EFldboQg35MJs0w7RFNL4FymSNwhytvNYt59tRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
Received: from BL1PR13CA0192.namprd13.prod.outlook.com (2603:10b6:208:2be::17)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 03:46:55 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::2) by BL1PR13CA0192.outlook.office365.com
 (2603:10b6:208:2be::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 03:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 03:46:55 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 22:46:52 -0500
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
Subject: [PATCH v2 4/5] x86/cpu: Add CPU type to struct cpuinfo_topology
Date: Mon, 21 Oct 2024 22:46:07 -0500
Message-ID: <20241022034608.32396-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: bf977f1e-f876-4cbe-1082-08dcf24c2c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|30052699003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yOyan6tA9o577vbqmzfcCtdtYVHh9aSkaJU6hAZ8zkx7ON3Dqo0/7EgqSXJP?=
 =?us-ascii?Q?b7wCU3gITcSBZIQLU1Wl0uLxFPhiRA8i4jwVbOktRBIZZYnQ/N1VhZCO/7sA?=
 =?us-ascii?Q?5WEE02y30Qu5SPRhZCedhVsjFMO1nHkVKVPtaNRSnn+W8TussIr3+nYcJKaI?=
 =?us-ascii?Q?nwrABW4Hnvx1k3vR/Csu4gJz1+guQT/3zwLsOeBhcf7y7wD+hs0p4mrXZXIG?=
 =?us-ascii?Q?8p2PBCGM+sKKVLS2XTrJiO7Eka+PfqXp6eU94TcvKapdoga4YYatidWtDApY?=
 =?us-ascii?Q?Vye+pemcVMq17mpdHe4nXoy4pi2XELhg9LU9hHtODq+6GfnHE1/hSmB7VEsU?=
 =?us-ascii?Q?mH1I4fdzstNwynhU7PeECdEw3N8TgjMLkcZSOblstYw24qNdYRjexjn9ioaP?=
 =?us-ascii?Q?oe9pNih7IPHOlXahiHxWqS9EootRl7V2r4C6mTQ8lrR99AAvOzKnNfz0X5Pm?=
 =?us-ascii?Q?ShKmkyX0advdcXqdHfxTE7vAIU1zvupZueLKDCHaZuTjjhRjW6Tidq4lksR+?=
 =?us-ascii?Q?KyHAgtgr1kvnJCFHnqMjswW5eUYRM4JUORQCxm2nYJvBiU+tp/TgVokz1f9u?=
 =?us-ascii?Q?kDguW62i6VTfyk0CM/HapeKeUktptpvQbT47uQK8oPfC9GDczoORwAu7WVfd?=
 =?us-ascii?Q?QaLBKMH/Gdy8e7LQw81h90uJEWufEL7Ho7/Wu6voU1xfrIKFzMW03M9V7TqG?=
 =?us-ascii?Q?vrLt+r00LdnVCHdpAuDSFCNQmw/m5QHKRQJSKgSgkaGiuesRsWiO+B9+7FAs?=
 =?us-ascii?Q?i3tGEqeTOUA1Tzy5zdH0yAbKf55L1nIW9hAAOmwrR6C7vdDnZpIJbZlr/vN+?=
 =?us-ascii?Q?fbTznoyaYuZ4tcP4RfI4h6AzNa69/O24s+y39eJ+OUrw1o1O5D57HDXZn3IQ?=
 =?us-ascii?Q?X7IPPVsoWqCWV++0WFd7j7JIrVZDzumRyM0vLuolzliSGx0C11CBV5gc7Gcu?=
 =?us-ascii?Q?EdoAHf05M/qC5XOtzfo0R7Myn6k2xJfLebRkW+GzwtSgw5jKaXPupG0wqxwG?=
 =?us-ascii?Q?2xEhwgZvJDh1r9irW2lS4IJJfiqGjwIZ+YR6NgzSI1XUn9Nk9BQLZ//8YR0R?=
 =?us-ascii?Q?HDM2XP6MfRnIM5QhGc0rr1jOgOrCTAwsMCXS3MvtsspiBmNYs3NjJXtKybSF?=
 =?us-ascii?Q?q00ThC9DopeTQ3B/kO9Dfqgn7MX+7bbGxkgWU0tVso2j07SXiU8M37JSpJ/w?=
 =?us-ascii?Q?fw37RmNhpiT/N41FuflfjmeLjfR0BiSmMcpXHOC6Gv7pIyd/f2I2tVWn+QAw?=
 =?us-ascii?Q?q2Y3KxNqa7Zv6LoIDkxi1dOy48iOqIqeEmWmBlzN8fcEKIH967YPb7OsYSLg?=
 =?us-ascii?Q?1hZ32LFe3EgtKFVKui6vPbXEoWfyt2V3Chvh3tlN8VS/ooiKa1d2xrDb6M/l?=
 =?us-ascii?Q?HfQf3laAdIuFbmfdRL9Z+cvmZYuwS+/SbbQ0dXjFETfB/2zagA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(30052699003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 03:46:55.0484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf977f1e-f876-4cbe-1082-08dcf24c2c1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370

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
* Take this patch from Pawan's series and fix up for feedback left on it.
* Add in AMD case as well
---
 arch/x86/include/asm/cpu.h            | 19 +++++++++++++++++++
 arch/x86/include/asm/processor.h      | 18 ++++++++++++++++++
 arch/x86/include/asm/topology.h       |  8 ++++++++
 arch/x86/kernel/cpu/amd.c             | 14 ++++++++++++++
 arch/x86/kernel/cpu/debugfs.c         |  1 +
 arch/x86/kernel/cpu/intel.c           | 18 ++++++++++++++++++
 arch/x86/kernel/cpu/topology_amd.c    |  3 +++
 arch/x86/kernel/cpu/topology_common.c | 13 +++++++++++++
 8 files changed, 94 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 98eced5084ca7..28bb177241131 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -53,6 +53,8 @@ static inline void bus_lock_init(void) {}
 #ifdef CONFIG_CPU_SUP_INTEL
 u8 get_this_hybrid_cpu_type(void);
 u32 get_this_hybrid_cpu_native_id(void);
+u32 intel_native_model_id(struct cpuinfo_x86 *c);
+enum x86_topology_cpu_type intel_cpu_type(struct cpuinfo_x86 *c);
 #else
 static inline u8 get_this_hybrid_cpu_type(void)
 {
@@ -63,6 +65,23 @@ static inline u32 get_this_hybrid_cpu_native_id(void)
 {
 	return 0;
 }
+
+static u32 intel_native_model_id(struct cpuinfo_x86 *c)
+{
+	return 0;
+}
+static enum x86_topology_cpu_type intel_cpu_type(struct cpuinfo_x86 *c)
+{
+	return TOPO_CPU_TYPE_UNKNOWN;
+}
+#endif
+#ifdef CONFIG_CPU_SUP_AMD
+enum x86_topology_cpu_type amd_cpu_type(struct cpuinfo_x86 *c);
+#else
+static inline enum x86_topology_cpu_type amd_cpu_type(struct cpuinfo_x86 *c)
+{
+	return TOPO_CPU_TYPE_UNKNOWN;
+}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4a686f0e5dbf6..872e5a429d00d 100644
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
+			u32	intel_native_model_id:24;
+			// CPUID.1A.EAX[31-24]
+			u32	intel_type:8;
+		};
+		struct {
+			// CPUID 0x80000026.EBX
+			u32  amd_num_processors             :16,
+			     amd_power_efficiency_ranking   :8,
+			     amd_native_model_id            :4,
+			     amd_type                       :4;
+		};
+	};
 };
 
 struct cpuinfo_x86 {
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index aef70336d6247..5b344ff81219d 100644
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
@@ -149,6 +155,8 @@ extern unsigned int __max_threads_per_core;
 extern unsigned int __num_threads_per_package;
 extern unsigned int __num_cores_per_package;
 
+enum x86_topology_cpu_type topology_cpu_type(struct cpuinfo_x86 *c);
+
 static inline unsigned int topology_max_packages(void)
 {
 	return __max_logical_packages;
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index fab5caec0b72e..779073e5a6468 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -29,6 +29,9 @@
 
 #include "cpu.h"
 
+#define TOPO_HW_CPU_TYPE_AMD_PERFORMANCE 0
+#define TOPO_HW_CPU_TYPE_AMD_EFFICIENCY  1
+
 static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
 {
 	u32 gprs[8] = { 0 };
@@ -1205,3 +1208,14 @@ void amd_check_microcode(void)
 	if (cpu_feature_enabled(X86_FEATURE_ZEN2))
 		on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
+
+enum x86_topology_cpu_type amd_cpu_type(struct cpuinfo_x86 *c)
+{
+	switch (c->topo.amd_type) {
+	case TOPO_HW_CPU_TYPE_AMD_PERFORMANCE:
+		return TOPO_CPU_TYPE_PERFORMANCE;
+	case TOPO_HW_CPU_TYPE_AMD_EFFICIENCY:
+		return TOPO_CPU_TYPE_EFFICIENCY;
+	}
+	return TOPO_CPU_TYPE_UNKNOWN;
+}
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 3baf3e4358347..c3361e496df99 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -22,6 +22,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
 	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
 	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
+	seq_printf(m, "cpu_type:            %u\n", topology_cpu_type(c));
 	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
 	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
 	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index d1de300af1737..8887b5ed1fbca 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -878,6 +878,8 @@ static const struct cpu_dev intel_cpu_dev = {
 cpu_dev_register(intel_cpu_dev);
 
 #define X86_HYBRID_CPU_TYPE_ID_SHIFT	24
+#define TOPO_HW_CPU_TYPE_INTEL_ATOM	0x20
+#define TOPO_HW_CPU_TYPE_INTEL_CORE	0x40
 
 /**
  * get_this_hybrid_cpu_type() - Get the type of this hybrid CPU
@@ -907,3 +909,19 @@ u32 get_this_hybrid_cpu_native_id(void)
 	return cpuid_eax(0x0000001a) &
 	       (BIT_ULL(X86_HYBRID_CPU_TYPE_ID_SHIFT) - 1);
 }
+
+u32 intel_native_model_id(struct cpuinfo_x86 *c)
+{
+	return c->topo.intel_native_model_id;
+}
+
+enum x86_topology_cpu_type intel_cpu_type(struct cpuinfo_x86 *c)
+{
+	switch (c->topo.intel_type) {
+	case TOPO_HW_CPU_TYPE_INTEL_ATOM:
+		return TOPO_CPU_TYPE_EFFICIENCY;
+	case TOPO_HW_CPU_TYPE_INTEL_CORE:
+		return TOPO_CPU_TYPE_PERFORMANCE;
+	}
+	return TOPO_CPU_TYPE_UNKNOWN;
+}
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
index 9a6069e7133c9..04b012dffa473 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -27,6 +27,16 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 	}
 }
 
+enum x86_topology_cpu_type topology_cpu_type(struct cpuinfo_x86 *c)
+{
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		return intel_cpu_type(c);
+	if (c->x86_vendor == X86_VENDOR_AMD)
+		return amd_cpu_type(c);
+
+	return TOPO_CPU_TYPE_UNKNOWN;
+}
+
 static unsigned int __maybe_unused parse_num_cores_legacy(struct cpuinfo_x86 *c)
 {
 	struct {
@@ -87,6 +97,7 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 		.cu_id			= 0xff,
 		.llc_id			= BAD_APICID,
 		.l2c_id			= BAD_APICID,
+		.cpu_type		= TOPO_CPU_TYPE_UNKNOWN,
 	};
 	struct cpuinfo_x86 *c = tscan->c;
 	struct {
@@ -132,6 +143,8 @@ static void parse_topology(struct topo_scan *tscan, bool early)
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


