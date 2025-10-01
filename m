Return-Path: <linux-acpi+bounces-17478-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F57BB0F31
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 17:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFFB160303
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D0C303C8B;
	Wed,  1 Oct 2025 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dAry4pFD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CED2765EA;
	Wed,  1 Oct 2025 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330950; cv=fail; b=ppDeUEA75PBLSJT7yyQ1r1aWHUnQW0VIp724oMqfop6FUdk+2exnfe/q0yTOGbaNTZGfX8RRGR1tdluiXOgAWyRT685uXo+MqytALYhRKoa69NAFlUVN7e7NUI9O+cVzAP52mFdncwuuOwVf+P9b1ckz0XkBCNTlLrArlO83bT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330950; c=relaxed/simple;
	bh=kyb94L8u2/ZLMgXVCeBDYv2Yqhtb9TLGwOzPwSl2ejg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMWWGyuiq7GPgZzPj4Zm49bnhe0LgK5+czD1DIoVakf8/MHuB59GpBivcRRJJJx5ojRrDZ67F+m4N/cD8BUYiryBMVqz06pHdz/gZm0UJjR9jTATQOE5aETAh76a6AcD9/OhN3Oy5NzyAEbAitNGir0ZcqUTDuUbkH+fpOxwyzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dAry4pFD; arc=fail smtp.client-ip=52.101.85.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCbbR5DTbd5w7nkNVfwR94HoUL8k6RuD8WBTIwrQ3hRc2M+GRJbXt+wrZo8zb5/HqentxITdBbeR/Y5+mLsWLNTJLT8GbI9vuWT+tglTwUnY2gkZB5Q7VGbiPYlpqphIWwdftu5OZFx/6C7rcyqabZ/xwxw5sYDEK3qJVEMJ4nBLoERZbAaVtiWSCWWhLf39Xp6gKE+2EME1WGNkZWgn/Q1+smRb7R4OcgpTpwMH0lHag13xow91SLfeCdjakuX6dpF1CbyTLCbfw0Y8Y9DpjEK2qVRrFEhUme2uBhbv952l7glxHMuKgnLFTkjEoNUd92fQ2voYExh5FRlvE445mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k10XumIXl8XGtEvPU8QcvMiIzkrvFhG18hLdNilnd8M=;
 b=Fsg7DkJhefo6WqMQUOKj6Sawxf5Sqh6vFCfbJS8Z40fWiXJo6d/bNDtP8ERztewXbEbRgfXXM18brTudFC9uhqq0F7WRkQawlQGl6Kvm45SXOA69GnCpY5lWfsVvpDZEZdOKV3+qlRHVC+sXLHPMiz3uotqNbyqcFoI0sqW+l9kPT3XXRPO7b5bfAN7HwGWFh644FWs6zmHtg+MhC8AxycfaVYOej+kKprqqvLQv2kQ+8g8YnsIcBq4wlkWi4gAg3BEXdfihZFs4t0kGFVynYdHIQz3KkQyz6421Mfn9r0VX4ERlGbt4nx6uMD1mbVZY68ZRNkWWsUb+xudJ9GRshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k10XumIXl8XGtEvPU8QcvMiIzkrvFhG18hLdNilnd8M=;
 b=dAry4pFDJBXdaX9zR9fiNys8GGPKxes5Jg6xj1yuNOxHBzJ6L2Y1y2qKJUoWZDo9DiI5yMJatVVk0F4CrK43rBzSHpR5dsNq01f4mgUMZJcTtcQLfjEINne1/qrxjiYqzfjFp5n0zJf7pkgyHsGgC5b6NVRO3C6wEPiQS6HsTqfOMouvWDR2gIL/pGKpB4CHb6rVv/prrZ0tc0h//9lU1wpX7DI1f2u6mWIftADeafL6cTSbATp1O1mgn4etHCS8WHa5zUfQrVMDeCHSt75pTZ1Z4kXr+wrANS8Sg/I7ZpLyEKdsIPp8NJxEghuTr8kYyjhZRW7Syu+75P6UfsToaQ==
Received: from BL1PR13CA0233.namprd13.prod.outlook.com (2603:10b6:208:2bf::28)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Wed, 1 Oct
 2025 15:02:24 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::5b) by BL1PR13CA0233.outlook.office365.com
 (2603:10b6:208:2bf::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 15:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:02:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 1 Oct
 2025 08:02:00 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Oct
 2025 08:01:49 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Oct 2025 08:01:42 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <rdunlap@infradead.org>, <ray.huang@amd.com>,
	<gautham.shenoy@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 3/8] ACPI: CPPC: extend APIs to support auto_sel and epp
Date: Wed, 1 Oct 2025 20:30:59 +0530
Message-ID: <20251001150104.1275188-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001150104.1275188-1-sumitg@nvidia.com>
References: <20251001150104.1275188-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: a6bddc3f-c7fc-49cf-bb18-08de00fb877e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XQpZU2qbFMjlgS6QKozgjXA/cdiz5x7oHsSjuY60A9c6VUW0t2AEaV3wVNQs?=
 =?us-ascii?Q?RatxpPC0RV5Z7/oE/7RvdFL/qhzhvPZtlc12PCWVj+3apAFih91U7nWlxd5t?=
 =?us-ascii?Q?9jZcUVxoSpyd/QMiQrhblCfku6O1ey14oFVbRXoIslE+ky/i53IH9xl2T2fw?=
 =?us-ascii?Q?BrjcS3iBll04qqPru11V71KLMW8/RiJ3mxNCO+paalqKCzLslIUJ3+dN17AO?=
 =?us-ascii?Q?P+GxzY3uctBfJIVIRBXqsqT2kAWFUCFAUYo7jfuurWy6Akn8wFwf74Luzn5p?=
 =?us-ascii?Q?4DvnvBbXu0P5QgP/ZVox0ubB973ECBf4QtJ6dPAGe02rberOXXHKLLBrd09c?=
 =?us-ascii?Q?hcs0LV+wpp7gi9dtCCZbb8+Wsq/kZ0RUQ6I9uoqWht6Q3IxWwRMWHJdCEXwr?=
 =?us-ascii?Q?iSM7Z5/dQIuHecGNvxNUkNu8Gs0jgLP8z9wqYn5/5VFeSH5tXb7xhjJMNBt2?=
 =?us-ascii?Q?Qzd9/dQsVmfSaQNdEOiOMYIeZ1DyLkCl+1yNG3CCdUCHXa9OD///Mw+QfRSX?=
 =?us-ascii?Q?ZbxSsTywNHnkpsmfp+M2xOPlVZG23ABObztvPBwHApvNMFLPjTum/ZJwXVMR?=
 =?us-ascii?Q?srEki0GBl+OuXUuIVah4Gz6suF9WimdkFFTPMUec5TP68nGI7lJwkKtD0TBc?=
 =?us-ascii?Q?usVTsesSOPOFNc2LYZ5zHs3s4otY6LkTXi8xzhEr5gKCHpSZ7QJ+mgeyVES5?=
 =?us-ascii?Q?aDLLs2cHeCAHOzk6OVDyx4cVgVBZMG7Gzvm395JannibXTLAaLs9lhQCUCda?=
 =?us-ascii?Q?AnkTF4EKug/9OeOyvfrLMqq+YxzCL5ST4P9K1bUb4s2/y5XotEs8JV+NABjV?=
 =?us-ascii?Q?CJWzPcNLqJ/A5PY3vGQZeTsWRSxm6qphBjtPytKLEHNLL22jfTmS4WCz7JlR?=
 =?us-ascii?Q?I0uRwJnxI4Y1VSDLNkYwkrrEL5oRLpCgJuJuoc3l4inOxno5mSsnDl/TwwPb?=
 =?us-ascii?Q?V9ULEr6q+dfwFkzmJAVIDFCIHPCmO5timdKrjDZOkpVa0PeNXXOKEUAcSJHw?=
 =?us-ascii?Q?oWxKm1CouUPb30tSsgkTdjk9NDCCJ87w6ufQ/DDYjW2PCCw/Jfam1Tmb2sAY?=
 =?us-ascii?Q?I3F1sfx/WnrNa6Y0ZKdDYgrqd4cRspuvyZdeY+9JeB67vy7SlI4sqoyLjbT8?=
 =?us-ascii?Q?9qJdohjqrVQK+OaFR9MvCyfVctZUWJj2QVqQoIcU0kRkTGls4RwclaGxh/hI?=
 =?us-ascii?Q?xNcdLQHjBrGY39tPR76S9kniycWMa5qrrKF1EMxYVSX/wHG9tRtLd9H88+ny?=
 =?us-ascii?Q?+6CPRdv6WBMbDiKz7E7sox+C96+wdC8WiCk1LninFuvuhdj1j+5pQ2KbiU9+?=
 =?us-ascii?Q?oJHYv7Kaz32JewYSyIoQup+6B7ls2z9K+9JU7uBMpgJhYL/CMiSR74o0E6rg?=
 =?us-ascii?Q?irqJyzrgPiTpYLzfS+LLagCp8uGOAPOgsFJPqIXW0KfImYHuAdpL3LrlXGql?=
 =?us-ascii?Q?JEULcohG/xww4yJqqkAAVLeLzWiguRYHVjckuleIezmtqXIys3CGksi/wjhI?=
 =?us-ascii?Q?b4lXJo6gtVhGlNFJk2zRwDh1I1GmewMlSVE0RIJT74bsvFZ0ZTLBTK+lq62E?=
 =?us-ascii?Q?I/fc7M3tUR2xtZ8KHGZ5MfzGzLfw7qmw/HC1T0h/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:02:24.1286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bddc3f-c7fc-49cf-bb18-08de00fb877e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176

- Add auto_sel read support in cppc_get_perf_caps().
- Add write of both auto_sel and energy_perf in cppc_set_epp_perf().
- Remove redundant energy_perf field from 'struct cppc_perf_caps' as
  the same is available in 'struct cppc_perf_ctrls' which is used.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 30 ++++++++++++++++++++++++++----
 include/acpi/cppc_acpi.h |  1 -
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ab8dd5cdb13b..12b2516b971c 100644
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
@@ -1590,8 +1601,19 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
 		up_write(&pcc_ss_data->pcc_lock);
 	} else if (osc_cpc_flexible_adr_space_confirmed &&
-		   CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
+		   epp_support_in_ffh_or_sysmem && autosel_support_in_ffh_or_sysmem) {
+		ret = cpc_write(cpu, auto_sel_reg, enable);
+		if (ret) {
+			pr_debug("Failed to write auto_sel=%d for CPU:%d\n", enable, cpu);
+			return ret;
+		}
+
 		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
+		if (ret) {
+			pr_debug("Failed to write energy_perf=%u for CPU:%d\n",
+				 perf_ctrls->energy_perf, cpu);
+			return ret;
+		}
 	} else {
 		ret = -ENOTSUPP;
 		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 213bd389ec57..3babc6d6e70a 100644
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


