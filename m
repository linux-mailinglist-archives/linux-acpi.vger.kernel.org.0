Return-Path: <linux-acpi+bounces-8939-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E972C9AD31A
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 19:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A9B1C21CED
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C411D1E72;
	Wed, 23 Oct 2024 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wS7h1nbF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696211D0797;
	Wed, 23 Oct 2024 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705491; cv=fail; b=LitH24zPe2lXZWvudS/BuhNuk9B8mH+bvwXL0kqPEStSnI8bxe1iSkGoaelMy/toOOF4lX+TeOjGd+mpmWcPL8CKWh+IIDzk59VRQePZd3OyG+JnuPpP2O0iPxKy6BoBdrMDrEH4SA+cJVa8vzZ62CD9Mue5vvjqaG+g5CMpvzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705491; c=relaxed/simple;
	bh=jJOLSzkvfP7p+b855UfbCFJoiHhCs8fMRL0tZBRLgZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ke59hbRykGqs7nbYaT4XcTiP13j6pJDQLg20vXHl45dO2itWl+tmTQ7EaDXSsMfBOK1gxlf00+KlFBRsmDIKCLHSX5Ubjp665q+CprZVuNgZaOsbq0gmxb/H8OfmfqomfVfy9KZcRJM10bNGWr+kXx71Fvd6vvRWH0FiCWVA/X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wS7h1nbF; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOfVAfhAJ8LMErZ6TatimREU+K1iGVsM2tTB76aL3PIUQGDXAaWdzmzOgyZVd4GTgGAVxSHWIByfoR9zqEEIoKt0wDif5oWYVffuPON79qpLAYdxKjSYW7vrU6BQp7mFMWnAHiyQk/L5l+f2ZjP8aAsKLwNc42N14d33ShcE2+lGrc2P65IC2+eS7WwDTChZ41fjL6qMeTWcmtWkna7IBlEE4Y+BjVvrpGW1hXCrbgf0Hoy+/qA/aoQCgmfBcCEiuE7eJhLxDqdquh+gSHWgj3ifQLuXyMy7+6UDOoOcZeyw6DYaOoePuWh+7/yI5lBfWue2p9LahQeN5G3UyCEWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDBw8le5kBLx+UpjItK4zlvcDmURMDII5ktiQNH5RNs=;
 b=XZwzeEVcpxIt3HtmRjbZd7WvFWkvAEAJv8nZ4HU19Cih7AZbrq2eEZFiSsSY/taLn+tUzkoLRy0wPX73s/exMjU8+VORQVjshJf0nhNzMKgi7prt0kb8f4jMMebHbgr4iYlUdPMwCxvC/EVdlZwQZSy5EB2fnfICNsJPnFPNY51zBbHwzjtafjJatgTH5lkucBIWE2GUmmC0lanEmiY/PbpI1beg47dqGO5Jc5hUmm3yEiZ/O4hRwY7QKgr8pwu6obrqpV/HISOVHBh8pd9GdKbHf/OMYWcXz0SPs3GvA8vxRw3fxt9CZ4dD+S9k5lVyMQQzgnu6eKyhWmu5v1Zw1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDBw8le5kBLx+UpjItK4zlvcDmURMDII5ktiQNH5RNs=;
 b=wS7h1nbFKjHCJZniNn0XHDMmKxO2XqfZy6o14ZcQtPMcR5C6KiMwqLIHq4+xRhTa2+nTqCMk7L/ZRopWju6uFGceAfmDkoRD6TOAdjcPt8jVK+ZFPgFTERYPRt8WlCWneXCDPSr4IeWnuYRCtLODTHiuN0BbDRWrx6Rdlmr/qk8=
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 17:44:42 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::3c) by DS7PR06CA0006.outlook.office365.com
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
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:44:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:44:37 -0500
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
Subject: [PATCH v3 2/5] x86/cpufeatures: Add feature bits for AMD heterogeneous processor
Date: Wed, 23 Oct 2024 12:43:54 -0500
Message-ID: <20241023174357.34338-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 781efb4d-efd0-4052-06dd-08dcf38a5fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L/BNP3VvHTl6Jt6bkGH8lJX5vQxhppkPyfa6yMOIsyTFrfqBeywOBuMUwtQY?=
 =?us-ascii?Q?S35Sw5JtZRMKMgTfMOJCLzF/AwEfNMiDwLdHy/k3r0bJVeH/BA8H1EkuXt95?=
 =?us-ascii?Q?6hqGLHlM+ZP0LhbtpBZ/bkZNWdC/14nGkEJi4bqRbIdo19jVsd/fIGwrfXO7?=
 =?us-ascii?Q?oTRFl9dpQbUJrJs9lnI30qG3/ik3iOAgfyg5KZDq0n+vOrwviM/+TIf131Yb?=
 =?us-ascii?Q?2A1HqQGC94ySEg1aDRoLqH90WnaOD19UwCix5jAgldJl6zSEH8+yfoy4tFto?=
 =?us-ascii?Q?xVa8Hp4zN5g53UmZIfD+AtX1NHYzdDWmZYd0rosCQzOiEWv1m7yD3q0RMoi5?=
 =?us-ascii?Q?3tVUsWmdO3k78KwKTvScNdRz6PNwclgl28f3SvzfCt39xbssoSFCp/FVE5Tw?=
 =?us-ascii?Q?5joKD3L5k915J5J7HPQyGRSi+s4qV4Mqk1db6pldYyy77U02X/zaBfEmz0hO?=
 =?us-ascii?Q?k33Enm5gVPTjBG2FcrxR2BTvubrWXVssqPofU2paH4ToNJkh4ErJqHgAlUTX?=
 =?us-ascii?Q?rtMpk08FX3nksHbuEE2hSMMn3wNP8cHJNqdCkraNJwwB2TLufVDPVQ5gT0Rh?=
 =?us-ascii?Q?WeD8ZDEV+oL2+Dxx1NLBEMpToKS+EK9PG+2ICAiiER+OfKRGSP6a94oV9czX?=
 =?us-ascii?Q?8YkRwB/932iNPvsqatwDPTNwNP8ECe2+uPr0GqAvQ0FGm0NcnZAGzTCADdPF?=
 =?us-ascii?Q?dtbDkrA91biZ6RKvfNslvUtLUE793UZC+sJno14PmSM2N2A5jWKDcr/CncCe?=
 =?us-ascii?Q?pxDUZF8hfeUA+4+nqsIVpfz3W5TJ+D5XqyzcUOzTFVNy8j5jd+fWJvv7FIJT?=
 =?us-ascii?Q?VUYEYHrO323I9n2icUXFpdTdg3ftkt/7CkU7uOibFZTVJDBpDl0wRcUIx+vf?=
 =?us-ascii?Q?TZDKEEkN9W+mS4JFvWDRa4nSXy848cY/gJm08o8L4Mbf/LFLmY1HRy64pPBC?=
 =?us-ascii?Q?DQbn9oaUUkCDHSIKUBRGEwT/8+SNd3B/qOcaFNfd8+lGppdgngSorkw3EN3z?=
 =?us-ascii?Q?lCxIJJLfFiF6/wwxsymi+Z1lk+uJB3aEjTAk8buGa4FqS33El1qNPmQJl24T?=
 =?us-ascii?Q?xKpqsNM3Z61SPkiOJ1B1AdqsdgAkdtl14DIaieT7y4dGHkrrSw66eY2Bb5Lq?=
 =?us-ascii?Q?U6lvTGQQeJeT0mh71ippS6bbZrmBuhgXx8msKIrwAVY4eXZXqpjZCZ4LIhvH?=
 =?us-ascii?Q?M4agKxGSQY4GZ15mrA9gtQMxkkAO6KvBvArp2Euph1H7tPO8MwwSlQztcXmb?=
 =?us-ascii?Q?zswvJJETYK4wyP153j01CPr9qfsM24EgSXd2AzqdcWfsfue424CuisgNPdLm?=
 =?us-ascii?Q?un3SJbD3KyvEts9H7lXV+lLqzoPpdoaUSlO0x+Ln17KXuNsX8OBVDlGk5dkV?=
 =?us-ascii?Q?jN8AoQIR7r+zCpBJ7R8ZLogPNsGBJTSJNpy/k1WcnZq8WliJOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:44:41.5646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 781efb4d-efd0-4052-06dd-08dcf38a5fbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785

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


