Return-Path: <linux-acpi+bounces-8985-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93389B0B09
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4EB1F23FA5
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F40521F4B4;
	Fri, 25 Oct 2024 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l8/gmoc1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1C21F4B7;
	Fri, 25 Oct 2024 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876545; cv=fail; b=U8g8Kbz2a7wT/uVk+e15hh3uMqJfriTZcu7dqWN/wdAifXd1PJiDnlOUEWsfUTj6Brnq6H9nJcNCjGMdNweu1AVKmlipBLYHDfZnQFfrVO4hrJr4Rav1kygB/wdNpymKyq4Lg4imAw6bxuXeNNLRKCV17fnTKU0ZCtpVPfb1GaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876545; c=relaxed/simple;
	bh=HqOMIGxdcmnUObKEcq0BqU6f3N++DdZHQfiedXOeP9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipg5hVMyFw1mnwQpA8XaXa2Gc8PWCINN4AtaqPjbpNTf9txXKLeZWPORBpa99hdgJdtujQDlV6gbIHKLU6a8JWL9hqf6O03T1zou7f2ffruQGmUd37Imumxdgg/LY2BHeT6E4Z6kycjSeZtJPFpFFWBf7Qaiqy+z/yMcMNdk+Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l8/gmoc1; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNIyBN9F1B/qSZ7tKOmNsWhVwxMEXqjXQt+0/0q1Bh5dUSrUu1gRplwVl2R91Sih6zca1KiGfZEnKdTMT2cKO3qfy+oq1d0hFba3rOHmORkhM8pYHwhekdWYBJ+NWJgyT9/M3D88za9LsO3F4NaSlt+NKqHw6I/c2Tlskt54wsTTG5iMvt/B2AckH/xxo08O+Mfo5+CvlPQyfBbwXGhavqvGKCP67+SWU1E5Ss1k2mWAT/KxEfd0TBQymy5XQWQEZrFFQkOz1PsXLGaOO97+Z6PzcCB0QSnuwXwkbUl+JWiry4jWfDsZIZTXr9XQ3p770jJI2KO0DOa8cqTd927bug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oPT1wDjaPCzp3IXZUhsV8ghi6JTITj/MUyI6FqVPt4=;
 b=vC5Cy9MpU69W1IATEl9JKVG/5Vww3qLENfjxZm4FvvqN+6FaEVWhKx0KQ5vzDz44NszglhTQwcIMQN/5ajwfG6x1l5V+En1pnIVBjpnpMvR0y5mN8/9nceTAUcHOoawisxgZqm1v8ZQuiLtQRxKu8JlRO5xQUkfu7h6f1fKz0I6C9OAuuuNg9JMT7HhoD7did7RNuZRr/UH7OC4wOshOA0Bh/CSRenCbLnwHIOETd4fxduXYPVNPtWZAizZlDxaTxp3MFVIIqVoGpeCmypMqxQgckmAVIUFoYBmGPabS7u6/EmybVpMcAmsPHGP++4exsvI3WWVMsozzFd2bJISQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oPT1wDjaPCzp3IXZUhsV8ghi6JTITj/MUyI6FqVPt4=;
 b=l8/gmoc1sX1EvI866bXhX9DHcxVLjgSBl4Tgs5OeOFvkfq7BXyG1E9Y71JJEtItzgRPNilz+fSee/iNS4PQs6Rv5rgCvVyhaq3rcr1vRl4c8Ac2hUA5FXY3rcWpAIna+D3alSy3dgEU02UgQLfPfYRCfeNoiZF6aCgNYI+dOGiU=
Received: from BN8PR03CA0020.namprd03.prod.outlook.com (2603:10b6:408:94::33)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 17:15:38 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:94:cafe::81) by BN8PR03CA0020.outlook.office365.com
 (2603:10b6:408:94::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 17:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 17:15:38 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 12:15:35 -0500
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
	<linux-pm@vger.kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Eric Naim <dnaim@cachyos.org>, Peter Jung <ptr1337@cachyos.org>
Subject: [PATCH v4 5/5] x86/amd: Use heterogeneous core topology for identifying boost numerator
Date: Fri, 25 Oct 2024 12:14:59 -0500
Message-ID: <20241025171459.1093-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: d29b2044-9045-4a65-245f-08dcf518a552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S4nEfaduS0sc1bPMPbK4IZt4E53ogdkkttYGDgohzVc60jBvhBv2SLTcYkd3?=
 =?us-ascii?Q?4QFJpPyCYSWDr2JDsros/WCNO7a/Fm0ZEDlQwebbkrq93BQbsHnME0ZCJQsx?=
 =?us-ascii?Q?MB0VhFihIxwZtpQuL6r4jIm7+Z3e4bBw1XbyBrE3jyaadar141WA6wRRfzC0?=
 =?us-ascii?Q?81m+LP3NE/DQzm7NZQXpfPFFEKtkTAP2pDMLm1fnaRWaMQsRldM+Dg7GZ3Db?=
 =?us-ascii?Q?7eVEexp68HSVq7YjBBu+o2dkFtc3grxFxdWG8EU1bDnr2Ygdo4wdp3nbmues?=
 =?us-ascii?Q?eYuYqrhdBIoxuwMtFjJ4BavvCJU+AxP1pCLOvf6FutvoMh0wLHawq/NxK7Vp?=
 =?us-ascii?Q?80OVw4MpCsrRsGNSuaV7tH0SMoTaYAj9A2NDsBJlknFQLdq1NEeBq7YjmuLp?=
 =?us-ascii?Q?2UUVO7hX+bgpLGfrm5vGDCDSQutozlS0u9W7tTOzUTuaLMEfbuWm45326VGD?=
 =?us-ascii?Q?TRq/X2FiSd8PwOzWfSZyHehpZ/7WbHTh8uI9h9gufZSmN44fTphI6JMvjfX5?=
 =?us-ascii?Q?QSynkINPWOZrt4AVjXBHaOHIEdzSMWq4+P8lZawx2VbB/X+2Z1iliKUVj/L2?=
 =?us-ascii?Q?aFg+QCg5f+2BrQYKLPkuYxJe5H+PEEaFYQ+tAs6LJzZkDs3n7faq2Ma0uk7t?=
 =?us-ascii?Q?eYjBLERuiW3Ao5bN1/REpq+rUipPQ6gOsStHPAKlN11umKCNJ+IaJRQn6huy?=
 =?us-ascii?Q?j6OizDC9G6J63SkFs7/QBg/ioWA4mDJmfh9C8Bif+GFSuZ6mzJmH9m6+w3Fg?=
 =?us-ascii?Q?4wdnEggEQpjFPuuUATMV226IeLwYbJjvUkFlFsZJNpTBytpb4xPkxgZWwANB?=
 =?us-ascii?Q?5pNYvdhbiOyX4pBHgg4tc70OyNqdf7Ncyn55X5fNAjptdCzCq5229ahVBvJk?=
 =?us-ascii?Q?36lV+u8PbtXou2t+K+SsN9dhKzubMHj6rodjl+UFE3R4T34byme0jtIoVrTs?=
 =?us-ascii?Q?x4BIgaAoFpAwugKgB9jwZnmookXSRcX5zIWpQyGQh7+vFuNz/64GNDogS6vK?=
 =?us-ascii?Q?vfS/Uza6MN2s7llvJMafioL8vQ1S7Xo2KxOhGwYqKMS//XSDXDdBDR9S0qoq?=
 =?us-ascii?Q?LzEAzzv7S3aYxmJUl90JhTsOgpy6cIhkidiO/LZTrOamKXjaLZ0Ugq6ls2KN?=
 =?us-ascii?Q?Sw/a5YQRI1th70ZT8PaGB6P+lI3zufaO0crxg/m9aZ6ftIIowkiCITZdAAP1?=
 =?us-ascii?Q?VWwQeBdQ4k0zJQg1KzbANL6ZLmKVfP6oqOzNoqKO2nwsWXfrNxu5775RuSrH?=
 =?us-ascii?Q?TzagifZcFgUqz5FWsgHwP2nkbvsjtZwKvy5GeBT8F3i2yIvH5rcdPFf/OF0i?=
 =?us-ascii?Q?Toi/tw6qfME0HCScKNaZdD/z21VDxd3nnb5bHAkUbKlZthHJo8JvjO2bvNKo?=
 =?us-ascii?Q?KrtxwNFXch8i+Xo3a972y8ahFip8K/Xe+Ys21S99g0HH9U2qMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:15:38.0630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d29b2044-9045-4a65-245f-08dcf518a552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029

AMD heterogeneous designs include two types of cores:
 * Performance
 * Efficiency

Each core type has different highest performance values configured by the
platform.  Drivers such as `amd_pstate` need to identify the type of
core to correctly set an appropriate boost numerator to calculate the
maximum frequency.

X86_FEATURE_AMD_HETEROGENEOUS_CORES is used to identify whether the SoC
supports heterogeneous core type by reading CPUID leaf Fn_0x80000026.

On performance cores the scaling factor of 196 is used.  On efficiency
cores the scaling factor is the value reported as the highest perf.
Efficiency cores have the same preferred core rankings.

Tested-by: Eric Naim <dnaim@cachyos.org>
Tested-by: Peter Jung <ptr1337@cachyos.org>
Suggested-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Drop default case and show warning in unknown case if hetero cores
   were detected (Boris)
 * Change get_topology_generic_cpu_type to get_topology_cpu_type (Mario)
 * Only performance boost numerator to hetero designs.  This fixes
   an issue on Zen5 9950X which supports the CPUID for identifying core
   types but only has performance cores (Peter Jung)
---
 arch/x86/kernel/acpi/cppc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 956984054bf30..59edf64ad9edc 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -234,8 +234,10 @@ EXPORT_SYMBOL_GPL(amd_detect_prefcore);
  */
 int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 {
+	enum x86_topology_cpu_type core_type = get_topology_cpu_type(&cpu_data(cpu));
 	bool prefcore;
 	int ret;
+	u32 tmp;
 
 	ret = amd_detect_prefcore(&prefcore);
 	if (ret)
@@ -261,6 +263,27 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 			break;
 		}
 	}
+
+	/* detect if running on heterogeneous design */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES)) {
+		switch (core_type) {
+		case TOPO_CPU_TYPE_UNKNOWN:
+			pr_warn("Undefined core type found for cpu %d\n", cpu);
+			break;
+		case TOPO_CPU_TYPE_PERFORMANCE:
+			/* use the max scale for performance cores */
+			*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
+			return 0;
+		case TOPO_CPU_TYPE_EFFICIENCY:
+			/* use the highest perf value for efficiency cores */
+			ret = amd_get_highest_perf(cpu, &tmp);
+			if (ret)
+				return ret;
+			*numerator = tmp;
+			return 0;
+		}
+	}
+
 	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
 
 	return 0;
-- 
2.43.0


