Return-Path: <linux-acpi+bounces-8987-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3217B9B0B0E
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569561C25918
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 17:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A01321F4DB;
	Fri, 25 Oct 2024 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PCHJVmzb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1720D519;
	Fri, 25 Oct 2024 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876547; cv=fail; b=VRtXw/AN4XFoWscZmNORxin06dtmt/aghDPpSRHVczXpHzolhBUemm5neByID2WzM2VNqpnjgJA7pGd8Cnbfue3/MdX/cCDRmhi6XQuuIEQZYEJoLqcwYaQweLwy+e6/r5vp4HVgh/7MTzdTdlGCtmuZ7dx8UjsHi5lwZwNhrHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876547; c=relaxed/simple;
	bh=xLXhOXFwiZdODODdFucl+qVR53ccCY0OTthGpRJkTeo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDhs8jglAzy1WnyheFrjtdEUz85msH7jkDJSWF7piq7oQOVq41Y1OZCIxuVLxPAF8ZLihUj4YYG93SC+py829nyE6frczw3fNh/b6bqytzmKKDWVbz+NYKr3BMKCihoPSjkQXX3BDYXey7SXSVTVSEmESLsR0AwQ+Mt9mnV0/BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PCHJVmzb; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhHqhPf1M0OHNvMT75fULJZG7QT6MjPv43infl9Iu7AHwHN5zrYqM2jgCcnUa/mHiQAeodm5PSeNLMmLUe5tmBs/A3FWnzHT+F9qK81vAodr7PWx5hCx9OI7K5tXJUy2cat2lYb+dmdnnSpCjjrMiiBBexmogQv1TFp+Wmo+obBV8gQR5pDgu07yH6kJthYhj/AhMcRWVXrQH2yG0ovIVGHJEjdnSV0yyOOBw0GvyTUH4LRe/+zRmHNXbDmjESDB4TsVB9y0kHM/+8cRQwljj3PbWvnYDd33s4wI50crx68tGDZcom2nX+kSfdkDg4RiIFrunD537qch9+l2GBuL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHRltCZ5SLQ2seKqbyRXFY4YE0LQjCoHDlAIxLK5uP0=;
 b=U1NFW5bUOkbXEikYbxKfygeSG6wlRmpDKPO+hz8hV+t6O7lfW6+SmE5S5shFfF6dmkrFKUiJN3nceNZ0lqTZriDUJBjn0Zwiam6F6K10JoufqxzRIDk2l96d8vsgYUWxWy86mU/eEXTyhIPeJw987lBh0imDhFDJoSwwI2tb1lA9Oub/FkZmyniDxd5QLRuv076v2QvNbmYniLAfus5s5SmFPARS4r1f6blls/OzvK5rFK5A6JiK3MQD5Zv/9qoxRY3XNpU1NWCSljIDM8w85Agr6eOoCIHZZTqcAMPupdQFDl4rAGTxErF3dqVGjm3wKHFf0xfaalDpPH3qINVFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHRltCZ5SLQ2seKqbyRXFY4YE0LQjCoHDlAIxLK5uP0=;
 b=PCHJVmzbAyrdE9y/gnQOw0TuIJckOBeR5JY2eoHxH5Zyx0GAlmSPuFkWMO8bROb4HYbG3l8dBKjA6+IY9kILeEE/a8ZZZgbCEIkozPeO6PLDLuuSNFNJSLJJC1xpbUz/nfYT4VaKz3tMsMp3xWq3Ku2zLUorRwxlBZRUp4mlxV0=
Received: from BN8PR03CA0016.namprd03.prod.outlook.com (2603:10b6:408:94::29)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 17:15:36 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:94:cafe::7d) by BN8PR03CA0016.outlook.office365.com
 (2603:10b6:408:94::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22 via Frontend
 Transport; Fri, 25 Oct 2024 17:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 17:15:35 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 12:15:33 -0500
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
Subject: [PATCH v4 4/5] x86/cpu: Add CPU type to struct cpuinfo_topology
Date: Fri, 25 Oct 2024 12:14:58 -0500
Message-ID: <20241025171459.1093-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9d2cd3-ed5c-4fbc-205f-08dcf518a3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j1LI5AMMUrSVMvlLi0iYwGX+CPJbTZWJyfqSZXjLlz8M3dFpfxdD0s3bhwt4?=
 =?us-ascii?Q?jzEr+9XSREs+Nf8Yx5tHdCkqeFfKzmetDnJi70os5yn3v+MB17ckarLanDEz?=
 =?us-ascii?Q?RJK+tZTn4wKGCu16ouQilyzgTqsC07tU/jN36hAbGKb+seTgK+TrOzkEN+h+?=
 =?us-ascii?Q?tF3tiEGzpibRssN6SzKCY+EoyAJDP9NZtk9Rx9vqv9BRY1sII6skHV1//SNs?=
 =?us-ascii?Q?6JYbmFUGVhrEJ7MQ0IMWh/sVzlJbf4FKoD0KshCscO+VPdGGKk6TGg/6l+e+?=
 =?us-ascii?Q?bBOTc8+iLfYnXVQImb40t0rYfP+3ZzyJR08PX7i8FkpOF7SeZQkoZUs8BZVA?=
 =?us-ascii?Q?cIYlA8SEBzx0B4GogpkutAnygvJs3UYJxxl3mtzaSt/MrC9g8Q3GJB+nWelR?=
 =?us-ascii?Q?STLMSuxydRywFPBK9RI2lMxSoy74doW9Ua0PDQaLuEpR2xsve3hBzBKoK6QE?=
 =?us-ascii?Q?gFlhw7/n/tu22Wbvusy6n3r+1yN/RdKljUjwDpMuMKGhWPC1/h8V60kzTx66?=
 =?us-ascii?Q?xb4NC0iDnFYDkqUhMWGXjpkdb6wDPuGfurDnw2l7SLqrmvRAuVIXPvYkTfCv?=
 =?us-ascii?Q?InS74GGbQ3RwqDAZ8dhUpUWE4D1fnf8Pgn0EZ+MJO3bf5d7j9tJ6EAatAR5N?=
 =?us-ascii?Q?WForfT9lLijrWHKrgq3v5GqtnTlHal38wYTzi2IvsbYe4f3Au0IgyuAhANCs?=
 =?us-ascii?Q?I9hjP0tTR2Cc/qJczRlnOQ0UF1AYCRsc6ldv4FevLtkY8/hTUilw9VlluvSd?=
 =?us-ascii?Q?N+iXqL41dextk97rUV3G175cL/+ZgeulZp2BcF33bPMKNY9r8AcQ/ioGcpcX?=
 =?us-ascii?Q?mO3dYTDvCgDjGs46uReGuMW3zvqMkdLa12k1hAvKpxvFE1NQuOO3jkwIS+rt?=
 =?us-ascii?Q?g1wOc8isiYtpqPLgWDkRwW7dTmAoKusaHR6Djlhmfpcag9Z9ZKJNVdBxe0NZ?=
 =?us-ascii?Q?sYVJx8lXrQTmoTnOLDAOPEUyQWX7U8XYRoi/Gwfe8aj8STT0qSuTnQY73tPA?=
 =?us-ascii?Q?LF+hqwTpi0F6HlgS5c3a+5o+bJOJ4XLG3k2gRUqoa+YSLbGT+xiW1XpMEyn4?=
 =?us-ascii?Q?syx46f+n4VjjbM4/AKk/lscmJLIDOrD3Cigmv6mmGJA0Ldclj0KffAYozKn3?=
 =?us-ascii?Q?fyLtJ8k1/+UDLN5yyUM8lwYtQjkwS5WasGuROSPJ4z5kPDUL1jYR4774Yw9E?=
 =?us-ascii?Q?pPCBNle3BZmjPWifOjyzogpQdAdtLANhIDEEXBc3w/Fmsv3w6YG02Jfacnxs?=
 =?us-ascii?Q?TemGxkk5EUkggspUvRZ6S+3st0KiHudLExFT/ap2xp8AojyudpBZNcf7wJTp?=
 =?us-ascii?Q?W5iZ404q5txzD0Bbb9gqTf41OCPAThvE4glFRc/a9whe5epoEY2IlD3fS3UO?=
 =?us-ascii?Q?svIAN0xzubfCwmd+0PzfSz0m2gPDKMPMGko68BPW3hOXgKAZxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:15:35.7037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9d2cd3-ed5c-4fbc-205f-08dcf518a3ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981

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

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Drop generic from function name (Boris)
 * Pick up tag
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
index aef70336d6247..9f9376db64e32 100644
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
+enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
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
index 9a6069e7133c9..8277c64f88dbf 100644
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
 
+enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c)
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
+	switch (get_topology_cpu_type(c)) {
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


