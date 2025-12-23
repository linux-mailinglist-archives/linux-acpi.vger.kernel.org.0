Return-Path: <linux-acpi+bounces-19820-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CBECD935C
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 13:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBEDA305E71E
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 12:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC5E331A6E;
	Tue, 23 Dec 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NrM/x5y4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC1F330646;
	Tue, 23 Dec 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492060; cv=fail; b=HmVn6X8NGc7M0J6rqMUSti32LuNrMWBQ0VjBrkvDf+1NBliI+z8mCsR3MWUYSOaDwk0vPUhVLpg04EG5gD1wXjUs2yECue2ayEkr5y41d0HPAcJQLs2vjLvaSTMbzIFQhvyTjIDummckc8pN1nksrVvCwyywJuLlgTY0UeRsCEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492060; c=relaxed/simple;
	bh=shdKa5h2p18t6+JtyVP5tfIbvV3xxqQNgzynS2mRYEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8FkVvI2L9iOLSyjofiWNpMacb3cecuchRVnDjd//lsMZsxoiUYcBa2uEX1U/cn63G2m4AzFqGYFvgMbu05bFsFxkHOf7L9e6j9qRpmGVvHSAcl06ZazGTan8is5D0+XTNDWivaqT9WMdYAR+c5tEurKLPRSRw+14rAHK9ekQrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NrM/x5y4; arc=fail smtp.client-ip=52.101.53.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OapVgQLpofZRnPVmKLZYXgUqlKxKqyKE88PjSPh0IV572NYM+gc2GJuFT2LUjHEdREn6onw6U6P28pMCjMNkjSFqPognYZmJj8HL9ld/ZSwcwHzKWOHEVngiXmNCnFcRARCbJBGKX4Ids2TL2rKvDHgh2PiavHBn/UwVxLsxfcyJdJAP7re6Dr/Mb774ejbsoFV3O1C6Y8zRE5cZuxh/AdmN5YInNPTpRUH3g6YGGizuBO7frCbqbbkhpYwWybOaseX76ChW2aVxTE4UiNzoPM0zS4cfbSOpTNc8srt96kvIwubIiUIjnBVAe8PfGvGtG2aE3Fl/acxOjqTyarebLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83kf3fk6F8ypQOgtwJ2pzGIMfoyGA2hx1odEXex+gj4=;
 b=oUoqN67zhETO/+ErjBO1IYxXqZtkNMcUjIIWLZVhvzKzqDRYFub5KoRjUiVXTShYPLnmSLm+d9f9BstCk4x9Kuja19odnlbZeWSjSzoyOi9jZtDI43WQFhmvKooprqN5V39aGrNhAXT7M7JIaZIJmFA4eZIVpqvc+D2X9hc/wxxU+l6CPTwBa+twTme26tBDC7/GnEGXLYww4yA5LMaEFNGfyQcN2GsiCgtb3g85ciJY+BtUQLyP8rb9o4dT19D3YznKBo/MNTmgeMxvOMygdi+TCeRiRmByObEYuhmi6N6EyS85WJyKA4sFFLlUL2cevk9MxRIkmq5Ass3MZvRGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83kf3fk6F8ypQOgtwJ2pzGIMfoyGA2hx1odEXex+gj4=;
 b=NrM/x5y4w65qotulVgxbctJRgsrRlYID8NBzG+LndFj4foM+T0KCGRMJfJUck9xp2ySgyyQeyyqKJY7Mx/vGG3YslM49V+/e8f146gC8SQ0kHqKXhQk1SVU7/+HZUW+ombInh4DKBMa9eikC/Tekw4Zk5pcxMDjgDW/EbwKpNFfZUXHEpky/AQi9sSxltwkQO1ycJniwqI1UcO039T2t6sbB/6nZ1Qc5MLvb2DFIrDgVHcoglNCk3S4DDFiQf6i3IOAwg0tFAUdEJXNXeD/YcJds44S9hVEpHpQodTEywGoGgF+/FImsPqr3r1XNHpDp7xOmYsZaNosDaQU0/FpT+w==
Received: from PH8PR02CA0030.namprd02.prod.outlook.com (2603:10b6:510:2da::34)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 12:14:12 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::92) by PH8PR02CA0030.outlook.office365.com
 (2603:10b6:510:2da::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Tue,
 23 Dec 2025 12:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 12:14:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:13:58 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:13:57 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 04:13:50 -0800
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
Subject: [PATCH v5 04/11] ACPI: CPPC: Extend cppc_set_epp_perf() to support auto_sel and epp
Date: Tue, 23 Dec 2025 17:43:00 +0530
Message-ID: <20251223121307.711773-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223121307.711773-1-sumitg@nvidia.com>
References: <20251223121307.711773-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3d1d24-0c11-4514-2900-08de421cc871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UHkNIJMaHTlXEURG5e54IhMPNiRq1FD64MU1EO+Vi91NOiJpEaG2CWghUUT8?=
 =?us-ascii?Q?in1nvMs4IuzZu8qFXchLfHY7dV3fNy0fHFmmbOxVrMwsD7UqsBd0aeiXiDN7?=
 =?us-ascii?Q?whpiMvPLoEh/9NszHNdHj+ljzJRnEugK059xFPHClXE30gSGcI2DrPErfbR3?=
 =?us-ascii?Q?ZVxWL8qqm3/ZSMKkrRSB378oKn3BMhDb6aWUghtcqOZe5od/EtRaN0RX0OeI?=
 =?us-ascii?Q?yG6RZer7G8RAZvegdiqmpTL2okUZ10nq//o+g2YwcKf9DYAVGmPHMWVcyoOa?=
 =?us-ascii?Q?r93H+CiwwmaVEVHT+Q6Jj9B2byFNnC9zMo+MVkruZViFhw7SYThihBBJyIbW?=
 =?us-ascii?Q?gnD9OmR60h19FY6rVE+cygs3g0vOU63fug/W855NHyjWVhHZ59+LT9u25I41?=
 =?us-ascii?Q?EpFkJLb1YQPSvE6Vft7QKkBQQci2rawdyNfCVnzr833PZukcT7mNjdf4Kh7H?=
 =?us-ascii?Q?n40MeWgFeVh/TMzacF1dBzTq1OJo5HuYt6Fdy/TYnQoipbLXlb4jxUksATmb?=
 =?us-ascii?Q?e4Jt2KWeeHHGp84zWd3wMnblWh8E4gCGEG/zaj4RrsqF5g0rfYqaeVM4TegC?=
 =?us-ascii?Q?GAy9FFIRLQiInRC/la0V+j198Fm1zQw8NcsFI8ZDbws4dncQKHhN+iFty1CW?=
 =?us-ascii?Q?2wGFAz9Gfuju1sCu3XnwbHlCqTnjdLnRVPgKScbo+xAkah51asF8xYi5ksRR?=
 =?us-ascii?Q?1PKZs8sbEG1TKEa+WNTngDvO1E7E+CJE/W4OwJtJ2sUnOAX8IS66vr4v0qhD?=
 =?us-ascii?Q?kI/4xbNXh1sR0ngUvCGNNW2LvWFw55/zIi48YXk5rh24Z2i4uDHrtMs+UGfh?=
 =?us-ascii?Q?zhLr67ZFbGi0vLBdaTDy1Tvwahwu9cflkvcfjnqlTHHxQsE6myZn33wV/H5k?=
 =?us-ascii?Q?PNsSr+UDQqXnt1HE1Lgp3mjfOrwS+w+AjVQgo2jYVpgObMdD9SL5EOKektPl?=
 =?us-ascii?Q?Dl15NCRjQs/3LYQWeC6vgIaZ6TdbzCvaJ+ouY1Cet8Pm0MEqigYC5kdIX4J4?=
 =?us-ascii?Q?1hOeTTn0VaU9yk9OFFmCxcLUxdC6mcZqDglaQcfQ2Pzo/YCmuuSXqELjhVI2?=
 =?us-ascii?Q?7otH58bccVRkNrU4ecT2up48uC54Sk6SrCrB6E0vhnxNV2g0jitgdiRLwBXY?=
 =?us-ascii?Q?Mdm8gHkQPPMaaAiiRUKDULiHtv4ZOOgclX4JiDSXspfucN5yv7tgLZ8gCDzR?=
 =?us-ascii?Q?Aqmi6jhXBFqAFPqh7QJzRgzMOL2N2Cqa3V/HIxR4agYniyAszUwKI/OFWyh8?=
 =?us-ascii?Q?UYUiX4LCR0w9SIYTl/l95HxjBpaOaDN4vc8BjoaxPEb5iQDw7B+WmQIhtuSw?=
 =?us-ascii?Q?mwdKkEbztzUGJsmXpOT2bSGouC1Q+hIbk4ESuCTqf4RD7XSduIcXfisvkSHV?=
 =?us-ascii?Q?UGqupEzBEYiS0ty07VCnmLX3A8zpGdDE5EGmbNM79BzBVXAbaS8I9CftQKI6?=
 =?us-ascii?Q?dJHZZx/hmS0H3Yll96DyU7/OcyWPWwgm3qHtTY0Rf0qX1lKPvnnHz2m+6TPN?=
 =?us-ascii?Q?P4BQ/gX0/mB58HKKnAS6ohkOT4CSqLb85SfhnatNtj5lqdIO8HNeLWsz6J5F?=
 =?us-ascii?Q?g1wA+pz2jBHtJ+fgprqhj8k/HoO2l/GXtGZANM3m?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 12:14:12.1442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3d1d24-0c11-4514-2900-08de421cc871
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975

Extend cppc_set_epp_perf() to write both auto_sel and energy_perf
registers when they are in FFH or SystemMemory address space.

This keeps the behavior consistent with PCC case where both registers
are already updated together, but was missing for FFH/SystemMemory.

Also update EPP constants for better clarity:
- Add CPPC_EPP_PERFORMANCE_PREF (0x00) for performance preference
- Add CPPC_EPP_ENERGY_EFFICIENCY_PREF (0xFF) for energy efficiency

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 35 +++++++++++++++++++++++++++++------
 include/acpi/cppc_acpi.h |  3 ++-
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a4e89fe6aab5..403ee988a8c6 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1556,6 +1556,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 	struct cpc_register_resource *auto_sel_reg;
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
+	bool autosel_ffh_sysmem;
+	bool epp_ffh_sysmem;
 	int ret;
 
 	if (!cpc_desc) {
@@ -1566,6 +1568,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
 	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
 
+	epp_ffh_sysmem = CPC_SUPPORTED(epp_set_reg) &&
+		(CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
+	autosel_ffh_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
+		(CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
+
 	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
@@ -1590,14 +1597,30 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 		/* after writing CPC, transfer the ownership of PCC to platform */
 		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
 		up_write(&pcc_ss_data->pcc_lock);
-	} else if (osc_cpc_flexible_adr_space_confirmed &&
-		   CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
-		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
+	} else if (osc_cpc_flexible_adr_space_confirmed) {
+		if (!epp_ffh_sysmem && !autosel_ffh_sysmem) {
+			ret = -EOPNOTSUPP;
+		} else {
+			if (autosel_ffh_sysmem) {
+				ret = cpc_write(cpu, auto_sel_reg, enable);
+				if (ret)
+					return ret;
+			}
+
+			if (epp_ffh_sysmem) {
+				ret = cpc_write(cpu, epp_set_reg,
+						perf_ctrls->energy_perf);
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
+		pr_debug("CPU%d: _CPC not in PCC/FFH/SystemMemory\n", cpu);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
@@ -1609,7 +1632,7 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
  */
 int cppc_set_epp(int cpu, u64 epp_val)
 {
-	if (epp_val > CPPC_ENERGY_PERF_MAX)
+	if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
 		return -EINVAL;
 
 	return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 12a1dc31bf2a..2860a0252313 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -39,7 +39,8 @@
 /* CPPC_AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
 #define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
 
-#define CPPC_ENERGY_PERF_MAX	(0xFF)
+#define CPPC_EPP_PERFORMANCE_PREF		0x00
+#define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
 
 /* Each register has the folowing format. */
 struct cpc_reg {
-- 
2.34.1


