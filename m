Return-Path: <linux-acpi+bounces-18536-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B0C3568C
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 12:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEE8D4F72D4
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 11:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE55E3101D2;
	Wed,  5 Nov 2025 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="axATF5NT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0E1309F18;
	Wed,  5 Nov 2025 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342812; cv=fail; b=jz9/ro+vDwRghYk9PO1JEtFAO27Iwc4rtQPCJj5EEt/wCbGZj7G+x17vHXqlbZ6IbDr+4cfh+iAzk4ZIbgjlqyBxKVQXNBd0gwuVOwilkj26z/TTei+zUh+SfF7OLV5xmhLRJ1AAXOtlbOpbBerZBOB8Bl4qdgcW/McSlSodF5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342812; c=relaxed/simple;
	bh=AkZ3zQWcxeErcvFTSL9kTptHaJX3jntu9cjnPnRPPRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z76ZLQD64XyMEg32hJvGbBUlUq38W92ZHNaPaWqxsFSyJ/XMj6OM0vYX/BLidCHT5gF44/Ap/CwOtK0niXnEiBbFKt/MOv+eYsJ4Mbjy/5L/pQvn6zdMuSh4ZiFjAlp9jMuVIM1fqk3B30JjVMVeGDNANkZ31iOxOJ/yk6czvqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=axATF5NT; arc=fail smtp.client-ip=52.101.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfjqNcp8V5/0CNfIdVkvDEUtCEZjl/DEw6jLbGiJQ4U8eefjoUTCWm0ADpdYSiARkqcFH35jHjmWyg7U4f/QWeae4x3l+8nCkuNft2ksALoZzou7Q54Z4wja4LaA9g0ZuIFzRPSFcY9bGWJteADxviqHHhrnmbJOrMEbr07jQrZBM+d+zS+bWwkhYLlz0i0YLzAoihJnSlLDhDnJhS45uh/F3emGrsXJ9XMJAbHkVxwAB6d9wmrAsGCLikSpu1COz92mfqaVdCHoNyGzizp3UJuCmwmOzKWafleU9TtDp2V3UmeLalsmkX1FsOr2swPgj4CV3PaG3GpktCoItZNN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAiKQi/JDAH3gjjqogrfEkz54DkC7Ljbdkil5oJr/lo=;
 b=fMtFhXJ5p0svF4xqlK/QsTN4vU08sRiSgsu1yjveg50+Fo0U3bLPewaGjdakyJmK+FyZjeoMNTJhlCqbLQxI2P5MXLh9iI0TIM5emTpUrPtxgSO6a3zLyejen4lQ57z4YrzDDg8LBe1DmFlVhQ37HKDBEr2Kng6FGsb6psIFfZGC+SFfpMyETO/VdnuTwj9BE8IPZBosZWxOP7RWVbdpd7dwcz2jWtrAcV3jtQOv5fYHBDA6Dn+/P0CZ4Vrd15AKv39v+RjCxKMmqR6hIrm/0nzsMpy43CduP/rldtB+9ieD9RFvcaigyS3l65t9VvJ4AxqTxKRx+LWgScC0xN5BcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAiKQi/JDAH3gjjqogrfEkz54DkC7Ljbdkil5oJr/lo=;
 b=axATF5NTsFan66QjO2rg1V1oVYt2yAe5FY5g/+kfYK56vdAKvaFgFzrIr2SXQwWBk7ovarPi9w/SpYeopZaSAf6ebPXWO8f+B0miXB+Ma0ykHwY3FZvUIqlNNVtJZKCuFNf39znP/QaPb9sWX0ls/eGSxZrptWDK2jDGWZCkAh3+/QMFq/a6FdFdgaGdhGrY2tKRzq/i79iCYHGKBxUwJTxTN+W+jQ3U8nSZ8X7z/9o0eI33gypMpkLAaQ4jK7IlBkjinqcpNKs88Gq5JjXm83zS68RDEzD17ouGzQ2D88fU4zi7GEXesRkGSRJ76K46e39DBWd2KJGpdoERYkeLAw==
Received: from BLAPR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:32b::13)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 11:40:05 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::b0) by BLAPR03CA0008.outlook.office365.com
 (2603:10b6:208:32b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 11:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 11:40:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:39:51 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:39:50 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 03:39:43 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <rdunlap@infradead.org>, <ray.huang@amd.com>,
	<gautham.shenoy@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<ionela.voinescu@arm.com>, <zhanjie9@hisilicon.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <nhartman@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v4 3/8] ACPI: CPPC: extend APIs to support auto_sel and epp
Date: Wed, 5 Nov 2025 17:08:39 +0530
Message-ID: <20251105113844.4086250-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105113844.4086250-1-sumitg@nvidia.com>
References: <20251105113844.4086250-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 1473ad46-4590-4ca0-fa42-08de1c60108a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DDQNiUKKUzdWycUnTapiRspdawnnLmHWJ3wQPnN9Bz7i3sxFMXUGJz7VeN5D?=
 =?us-ascii?Q?dHeXkXlw+V6/tXmY3yRkLWLTiptYSt0MxBlnO/nBm5s/eJba39aF0MHIxgSO?=
 =?us-ascii?Q?RkeE+PVCUX6ztYw0OPIAKVJ7pXXA/M5wCL+kjFzYbl880L5q6ooVR5AWUIfH?=
 =?us-ascii?Q?OufMep1ekYdzUIa/jnYlpmNKr/Gy/DGRuUqsSWoYzxan168PvxZ0by0GgaN4?=
 =?us-ascii?Q?+VeB3HK27VkWdEQDBoY2Dc5qaiqcQw79gyvdy+Ktuu8wbEqu4WlnRz9GrrPw?=
 =?us-ascii?Q?j+Opb7DvFPsCEyDPr9D7TD0QTeEJlXEhtcWOR6KfsjIB/YsndT9Mw0qs7cE9?=
 =?us-ascii?Q?2bZ58xRc+suijjLxEpw8mwNfjFEFYJIotZiHLm7oxxzrYMC8qN/LURL5p5MI?=
 =?us-ascii?Q?oC7/+14oC0bEBaQP7cVBOEeqB+xaV0TZ4ZrtmsJF+Kz5zpxZvuiE8lKMrtfr?=
 =?us-ascii?Q?sl1lbLmpqxUthP636pEsji6qUWyLAj34D0Lq0fPCREcp1wq14KBVY+xEKqdS?=
 =?us-ascii?Q?BJfmUduM0Ecb1IeAzhbIO2AxlwfeoRVWWo8wIpntcE2UNlZl/6JOXCA/+Wbv?=
 =?us-ascii?Q?hLqJj/FfvErqYXti2d5vIafy/Z6Q/wpr0z0OagY/aB0Fh4ZF1ec9gQdqlxgB?=
 =?us-ascii?Q?ZIMB9QOtBAnumhJADrXzcq9H1DgdvF5bqA57EoiSb/KLrFoCGAv+T236vsMi?=
 =?us-ascii?Q?L8sv4XFQX8zhKI79YKdF4kbbzB4Rl6zsovN8R/8p8oxxR+bX+evjZxbyN0YY?=
 =?us-ascii?Q?PdhBeoN7Fteq76dxfvQA8iCYY7TZ1VR2FWJvJNVuMwM7Qw2SJ4I6Wk/fVAic?=
 =?us-ascii?Q?6Iyii3IcBjtqQ6Tfm9PsTwcoXJ1JzD5tp2QejiGIfTJId3L3nlzPVVFHXBaF?=
 =?us-ascii?Q?o1lHpeCHzJBWxe1NuYbz3JwF6i3i83r2RmX7aPY54WOp4WnfRi1A48yBVZAh?=
 =?us-ascii?Q?QXXttYwaixGq6GEoWMRXPnVWRmBDEL30b66GmpgewS4cIza5dIN6ERL7S8Lr?=
 =?us-ascii?Q?gZq0jMXtmMSjLGy2s/81qqeJkjq+LZ09Nz7gPWVu3ipXoYdGb4WLVooE4o9B?=
 =?us-ascii?Q?NOSVG4apqOweFX53nG9W9t9EoPvkQTkFaWjcq7v4xVjGfjmaKNzVo+br3x5S?=
 =?us-ascii?Q?heYmzqx6aYVDHs+aUV/durBKBl8Pw+S9F7Hs6B4NMT8/3EFvOCozyMA1DVg0?=
 =?us-ascii?Q?oRUQjXcBzACO3z2j2Xn2Vvs6IdvYPP2Y3jVkiTanyN3eQAJ6p6Sq+bL7rL5k?=
 =?us-ascii?Q?F46CqanhYB45LVh/XG5ypCyNv4aXr1s8qIwquFeFpN2lUgM0ZwX9oEoAykTp?=
 =?us-ascii?Q?4CScwCmERVnNKkYdxk/FewHRplT98lrERcuA/KSwO9YqBJaFktXL5ExDjXT1?=
 =?us-ascii?Q?tAsOb99Vw+tjPwHX04AEln4yGgGj5PIsdvNyolOfy9xCgXuDljV0649b9Pju?=
 =?us-ascii?Q?Eg1m9Op4eR5ihWbImKUTEDzYIwIqNUmdIn6aGNjQqyXl72XhM3Hwr/BK/Hlt?=
 =?us-ascii?Q?uKbh0DHiqUjjJpL8S/PGDJ6nZ30wed8Vr9cp4YQjGLnFrKsoLFjTOgLH/A05?=
 =?us-ascii?Q?RLSyk1ipTcxAfmOilomJSXczfAKcmM2GvalI5+2A?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 11:40:05.1281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1473ad46-4590-4ca0-fa42-08de1c60108a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536

- Add auto_sel read support in cppc_get_perf_caps().
- Add write of both auto_sel and energy_perf in cppc_set_epp_perf().
- Remove redundant energy_perf field from 'struct cppc_perf_caps' as
  the same is available in 'struct cppc_perf_ctrls' which is used.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 42 ++++++++++++++++++++++++++++++++--------
 include/acpi/cppc_acpi.h |  1 -
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 05672c30187c..757e8ce87e9b 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1344,8 +1344,8 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
 	struct cpc_register_resource *highest_reg, *lowest_reg,
 		*lowest_non_linear_reg, *nominal_reg, *guaranteed_reg,
-		*low_freq_reg = NULL, *nom_freq_reg = NULL;
-	u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0;
+		*low_freq_reg = NULL, *nom_freq_reg = NULL, *auto_sel_reg = NULL;
+	u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0, auto_sel = 0;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
 	int ret = 0, regs_in_pcc = 0;
@@ -1362,11 +1362,12 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
 	nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
 	guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
+	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
 
 	/* Are any of the regs PCC ?*/
 	if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
 		CPC_IN_PCC(lowest_non_linear_reg) || CPC_IN_PCC(nominal_reg) ||
-		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg)) {
+		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg) || CPC_IN_PCC(auto_sel_reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
@@ -1414,6 +1415,9 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	perf_caps->lowest_freq = low_f;
 	perf_caps->nominal_freq = nom_f;
 
+	if (CPC_SUPPORTED(auto_sel_reg))
+		cpc_read(cpunum, auto_sel_reg, &auto_sel);
+	perf_caps->auto_sel = (bool)auto_sel;
 
 out_err:
 	if (regs_in_pcc)
@@ -1555,6 +1559,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 	struct cpc_register_resource *auto_sel_reg;
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
+	bool autosel_support_in_ffh_or_sysmem;
+	bool epp_support_in_ffh_or_sysmem;
 	int ret;
 
 	if (!cpc_desc) {
@@ -1565,6 +1571,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
 	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
 
+	epp_support_in_ffh_or_sysmem = CPC_SUPPORTED(epp_set_reg) &&
+				(CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
+	autosel_support_in_ffh_or_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
+				(CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
+
 	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
@@ -1589,14 +1600,29 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 		/* after writing CPC, transfer the ownership of PCC to platform */
 		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
 		up_write(&pcc_ss_data->pcc_lock);
-	} else if (osc_cpc_flexible_adr_space_confirmed &&
-		   CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
-		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
+	} else if (osc_cpc_flexible_adr_space_confirmed) {
+		if (!epp_support_in_ffh_or_sysmem && !autosel_support_in_ffh_or_sysmem) {
+			ret = -EOPNOTSUPP;
+		} else {
+			if (autosel_support_in_ffh_or_sysmem) {
+				ret = cpc_write(cpu, auto_sel_reg, enable);
+				if (ret)
+					return ret;
+			}
+
+			if (epp_support_in_ffh_or_sysmem) {
+				ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
+				if (ret)
+					return ret;
+			}
+		}
 	} else {
-		ret = -ENOTSUPP;
-		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
+		ret = -EOPNOTSUPP;
 	}
 
+	if (ret == -EOPNOTSUPP)
+		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 7190afeead8b..42e37a84cac9 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -119,7 +119,6 @@ struct cppc_perf_caps {
 	u32 lowest_nonlinear_perf;
 	u32 lowest_freq;
 	u32 nominal_freq;
-	u32 energy_perf;
 	bool auto_sel;
 };
 
-- 
2.34.1


