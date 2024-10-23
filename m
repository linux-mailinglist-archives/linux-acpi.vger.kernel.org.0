Return-Path: <linux-acpi+bounces-8940-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC6A9AD31E
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 19:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8825228379C
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 17:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402671D5AB6;
	Wed, 23 Oct 2024 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DAYyrXJb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF51D14EA;
	Wed, 23 Oct 2024 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705492; cv=fail; b=JjIrl9QmPzupEDmK9m6Hhpu3QUHUwA2hqk+D1i1mttmK+Xu1lPmEJdNtQDEKYkNpM7X0paU6o5ovpdHJVLLU2/xxId4/jsHbrOCuwEaVubiYt7EZ+Hf8fyLmJEvZMG8iAyka1zh53QFXLoD6Cn+oToiK9XnDsw/g+OQ/uRd+V8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705492; c=relaxed/simple;
	bh=eJaTVdW77eGIqdwfuEd4E2GHWhpXb/HNJgQlDzpkZ9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCsLT9ayPwCvYh0zEoUVeDHBHkI9rz9kkF5V/a4nGc8G4HmllEsCVWAjCnCfgGFHQbvYbfBYLqCOar4eZoNV5WfdRsRa49j+HX247BcaVuCn4jziGYH/E904DS8gSrAhHxgNxz1nnp9qh+EI65T0JcDHt7QsBgWCUUlBz3ZWpWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DAYyrXJb; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQ042hRRBO+DIVRqXtPt/A3JBm52UOFd0tU4UjYvgIOPh3wHCQqF8QSD9H5pE4PCZBUPQZ+WV45iMIU9dh+3VG/Zi5anZ2GLGRRRH+cMWQpRWgP8fII0Aw9spRdsKNpSfEbIAj5DRideQyF4Wuv99zlB+WUidFnQQycDTh/Hi9nCkVaT1nN7f6n9CoTJlbhE/iYVMmBX2I3zJ1rwAuWV8jgrReXjDHpPjlk4/n8M3ww0196kf4CfXdhEfbIc4+Wa6Rr4vRIhQOFjldO32kpTGTvnpGIgCF1ZEft4H9DsvRCeAisqicDRBm/vQKim4x0Sya2Fam5CwN4sfm0E02ggxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vG5lDm0MPtPN4IayuoXr1hgZQ7nqDbpxJslmYEjVznc=;
 b=gOnKzxVOXZ0R3floPerVpmp36RJuhmBY5fdQCZ86IxbsC8hX9+qd3PaDR73YvfsmH5FfJ7bBdboUKqPdM6SwkSD8y/aLO7KTPgOfWZIsOX2hUilpzlbbbCWPUvgl7T0h9UBdCHVg7/XNscsqks6gbIyC+chYdR7nB1dfp0Vf28xeu9PHjaa9t9Kyql5/EvkSOS/NCt8WLzs3doMjqW3+n7BN6tMcLU4smbjXA5w74rbnRm5JIz4VhKFLl9lmR4yWviahiBiuVxiyjvURl63GsZGzHo7hewVC0W0PQtuItFR1TOa7pDHbWzbV0OE+wp9tKr7Io/wMJrMADq8pMUiadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vG5lDm0MPtPN4IayuoXr1hgZQ7nqDbpxJslmYEjVznc=;
 b=DAYyrXJbJo4K7nLsbetX0Vw1/VTIfbtvYllmH2f4yC/uLna7Yeni/DI9z1GAPI7Tz11/SvS2k6udNqr0HP6jJSUVG4wXOufbntc8fLBgQhJBnvALlC8KHQh/bfb7RMEAeg8Cy+yvQkCwwre3RFfnYrVIq05ls5RJG3uROkgkx6g=
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 17:44:44 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::41) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Wed, 23 Oct 2024 17:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:44:44 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:44:41 -0500
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
Subject: [PATCH v3 5/5] x86/amd: Use heterogeneous core topology for identifying boost numerator
Date: Wed, 23 Oct 2024 12:43:57 -0500
Message-ID: <20241023174357.34338-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 972544a5-42ab-4bd0-a555-08dcf38a615e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MsIQymDLo3U7hjHcrAso1uy/yUQICFGqa3PPbJTTnmwAOjdpt5Hn0F/Q2CDU?=
 =?us-ascii?Q?6gMStnSmZh9NEIHtrbGicMs6zNHzCOJgyrw0pLAZ+b50PauJqn59xgY4gX2P?=
 =?us-ascii?Q?ND7snfQih9dlKXxVisVTj75QrgHFSRB7Z76AWOnPn3T/JnrapLHZ9/htyVcQ?=
 =?us-ascii?Q?YKKy5hm8fcxsB0V0lxzXUxo2ofIXAysnOPV5t3H2wNzj2u/G7t1/yRotsHhC?=
 =?us-ascii?Q?C64UjR6qqoKBwuk+e0S4WMjxpcCdcuk1ISqbDDscxKtfenMH7VI4BcY67hZ8?=
 =?us-ascii?Q?xQu9YaI9mpMO2mohWh4RDWqbXVOblnrjF6JjPL8fAxFVjlW25gzuxCWOuD9k?=
 =?us-ascii?Q?oJXatLm174oKmztp1bmESRKHy2AdtzzQbePzpIcO79RCwP384x/RQdlMyllI?=
 =?us-ascii?Q?AkPlTqaRejJGbZeBDZUBBgblI86lmxSfOjgZ6o5jSKW/MQ/qy5pPQqfLJA1Z?=
 =?us-ascii?Q?1cxhcqc8YPk+NHIvnQtXg4pHHfyfi8dQsOLFuUtwmRMpaKGO/KQPExQDmySq?=
 =?us-ascii?Q?1ov0eQ6cjBuMNFxeUqsSgO0CUcVe2TrXjMUKOlDRmD6rAXuZ6hof/ILCG25O?=
 =?us-ascii?Q?mk6nt3rA7v2iG60aLyvT/Cjr6pVt27IWm3JElC+dK92/49tFb/4Vc83M1Oth?=
 =?us-ascii?Q?oH0JpDFVAL7ZLMi6/0inUDadA6fX0Vgx34W+o/qC/5D6aXPEHMlKe+fCBpFz?=
 =?us-ascii?Q?j7IyVHMO6gqczCzz/2AH/85erIvSXsNQqg8jGPyknHyreLIQZpJ7rNkV83rt?=
 =?us-ascii?Q?xPQtHf7dNGxBCHsO5wn7Y712S8UNud8a3/2gkG5Kr0KBpS8Q9hhGwg7vAOK9?=
 =?us-ascii?Q?ot8kdk51mAEHfuYZ8HZXYmpdNcNnKqhpaKtXCEAs7s6IJvmHYd2uf5q6wQCO?=
 =?us-ascii?Q?k2+fGKizXSDhHURPYMyqI0GErbQNMPlSXSqs2Ne8mwuBLRYlwQXF0wNwZcAA?=
 =?us-ascii?Q?cWn/M2iQU+KXgC6sThrbtrrGiIKI9rYmGPC4y46Hov3zRtMxS/PsXoGZ/rNz?=
 =?us-ascii?Q?wO2T2IVw4X09KaLu365qDBb6MUKW/XPBbB7bDuEge6yopJveQu6sEGa3VDTL?=
 =?us-ascii?Q?Qo60kZ/6FIVwKEN9EubQB+jnkDKYIpaJ9rR51d2sVE3zdADAp5Kv6ugovuLB?=
 =?us-ascii?Q?86/BfHZPk4qoMEw5k/z/EPCvxNcE/wfJMBDzJewRR1m14Q6EEeI7tQSoNOPF?=
 =?us-ascii?Q?f4QBeLMUqfD8i5evgsb6+GiWzKFNEmiskm5nYHGLK+zuvHqDuDlmx8gRmUFT?=
 =?us-ascii?Q?4eDt7VctWKCMI2OBSPAXzp3usypw2gtMOW75WeaZMiRzxpst3IimvQ1M159v?=
 =?us-ascii?Q?PZOTByQByD3JtwsUPCx8ZXXpdRN+OJVwxIzqVxE2uEzA1Z+NuvJ1bDHwbfRw?=
 =?us-ascii?Q?Lrv57qjNpoomDDTmVhSJ0W86o7/wK2lKGQGEOuCj+M/hC8DXzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:44:44.2678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 972544a5-42ab-4bd0-a555-08dcf38a615e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222

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

Suggested-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/cppc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 956984054bf30..9983d4537968f 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -234,8 +234,10 @@ EXPORT_SYMBOL_GPL(amd_detect_prefcore);
  */
 int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 {
+	enum x86_topology_cpu_type core_type = get_topology_generic_cpu_type(&cpu_data(cpu));
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
+	switch (core_type) {
+	case TOPO_CPU_TYPE_UNKNOWN:
+		break;
+	case TOPO_CPU_TYPE_PERFORMANCE:
+		/* use the max scale for performance cores */
+		*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
+		return 0;
+	case TOPO_CPU_TYPE_EFFICIENCY:
+		/* use the highest perf value for efficiency cores */
+		ret = amd_get_highest_perf(cpu, &tmp);
+		if (ret)
+			return ret;
+		*numerator = tmp;
+		return 0;
+	default:
+		pr_warn("WARNING: Undefined core type %d found\n", core_type);
+		break;
+	}
+
 	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
 
 	return 0;
-- 
2.43.0


