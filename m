Return-Path: <linux-acpi+bounces-15992-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DDEB32BCA
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 22:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CF556818C
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 20:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB842EB87F;
	Sat, 23 Aug 2025 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JDZq4jCC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376CB2EACEE;
	Sat, 23 Aug 2025 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755979332; cv=fail; b=Fvd7X0WGld9nGidk0ZJr7Az+Rt0veeC9dHgVcqJeBMfjqlg+HtoxWB1T7zUtL0JlVep5pX9p9auRYqGD4i6WxPrWU3puigbBkIrefvpT5pZZtR36hQFEF05PDH+B3S8OtSqYxR9jar5Y0+IbiOE3Ehcxnm3flifbSgeT4bNKYpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755979332; c=relaxed/simple;
	bh=uS3ISOtPuHFosCPO54pYXPN8Xdnv4fS1nLpvBrSgl2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qeukSiS0HuCnJY7PYHXMr+u10z6oU4AWj4YdPrTdYNO6rco6GTirKmXr+BDRr30TqKQp7+1kpl25gj/D8AX0DZclNmF/vOjrcMQS0jbg87zN/w7KoKufyBmmZiNxS70GDy48fJlEllkpyAxqlv6LDMv9BP1hGvlJUCm5pCone9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JDZq4jCC; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+rhS6JURRoVqjyTFic64lQkNm6rPrYpKOCayxjYmGPwe6cVnkcJWfmitGZTaNUAbRr1NRKfe3DYbrtFq+AqJYEgVwdnmRA4uMRApQngZRcPdG49aXVksRuaKf3a5zFVt2PcmMiaVjmQ6mEOXBHRMTyjKfAQhtfx1D2DRGKWiaieR5X0qETLkQNHtg9+RdpvkA1JV50E13N0lKjWw4NXXGiYOx1BMmoqX8YL7kB4CbwwoyV60Bp6nnB2297TWpZDHWxZmw0/x+wh+gc/V2vteovJsYOmBtorRjZNYME3LwNqu0cQyx25SjhnabG1dpdcXZPnJQqJ0NP1zFi0Pu19og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR50csAyIMuxBnaSJy+7Lb03Mm215GwH2bljAIlMbro=;
 b=XOaui3uldrj45aKcDpV2SOfxD+QMgsDGplZN54IWofyJ+mO0yzpkaYUaBEQ9eOo9qtqvEcygSGRak1HSJkYChXkqsm7qh7HobZZRf0NIQlTc5qJ+VnnVMv0NukQ/7CuYPdRihS/YYgFAHXn/FbbYe31aehchzRDGJHSU5fRuSWR0etzUu9ICvRI0qytlN/9A23REoVOnQaGFBRK2UvcNZy8BF4Efv9T2Q0ZWXpRR8dBnziIAcxZxMKEMKkXo+OPoEePT++06EF5i6J8qrEd3WpXSAFmFK3JTrLWxgAEzeUAnZKyxWZSQDWB9fK5y+ESSdvR8WnYkGSLQgp8tZTXF+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR50csAyIMuxBnaSJy+7Lb03Mm215GwH2bljAIlMbro=;
 b=JDZq4jCCPfUI0kuzlmEjtPtj/moaPyqKqVP2aIYmCKC8C2Jhlw4Eg+l5E/7uWlK5QN6sEDM3qinGekwX5WHC6ATLIFzBFoLbpG6vpPoJ5aBh46AzZ/02IH5jq81TZesLBPT7PcdMiKW5HQPGxbkFIROrh1MR2dyUk/pjzZaG563SFKjFkSTzZ3+8fZT2LSGvnWGfZe+3ydP93S0smKDwaubYZtLAWkwcbyhCILTUe9uAyjc4kKM9TnkzoARMOQoMw83uvSajMoKLiTKrzlLFkrDh5bOb/3cXUIftdHnkhHzoupCHmwWUa3WGCd4VwILHjWrgH9hK+G+HzBAGqKDqZw==
Received: from SA0PR13CA0003.namprd13.prod.outlook.com (2603:10b6:806:130::8)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sat, 23 Aug
 2025 20:02:02 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::ce) by SA0PR13CA0003.outlook.office365.com
 (2603:10b6:806:130::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11 via Frontend Transport; Sat,
 23 Aug 2025 20:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 20:02:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:01:52 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:01:51 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 23 Aug 2025 13:01:45 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <ray.huang@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 2/7] ACPI: CPPC: extend APIs to support auto_sel and epp
Date: Sun, 24 Aug 2025 01:31:15 +0530
Message-ID: <20250823200121.1320197-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823200121.1320197-1-sumitg@nvidia.com>
References: <20250823200121.1320197-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ea3f9b-e727-4a09-0542-08dde27fecfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h02OFyJiwKDSWLxn5qER/6p50skRN7EC9auqAWcKBPY9A5fHJEM8wSXPn7UV?=
 =?us-ascii?Q?7uizExautsLO36NRF95B4mO4sPaSEMdNciqwiGPeeUIm8Mhu6ueTxpOLQYuI?=
 =?us-ascii?Q?bV4aVJ/qPufFzxf7jIklmN1B0UImnM7a0xP9n3ZFLPKmD0WPcw3I3Id/iC+t?=
 =?us-ascii?Q?fEgYg+QB6HprE/nlr0Zw3U9HJ0FsoMA2rTmuxFNV08L0oFPfocNBGJwTD5K3?=
 =?us-ascii?Q?CjOMiyA8gcQcWTPvhw8Da7MJ6KEXzFbdXXV0PwYXd8Vqk6v8k+STPxcrPzim?=
 =?us-ascii?Q?/oPbgepwgry2ofjVSqPQuoJli42T0C+k/lcJUHJ1ZpZSGRX61rvlKe0zs7YU?=
 =?us-ascii?Q?Lx6GAGcSlVjeCA338uEBAcFsFu+DkqSZT6ROXBunPJPG99ATD6+uJeJ5GcNo?=
 =?us-ascii?Q?nnCSP/ErZjVPVlJD9dwl3kQIsqvMkSZ7yQxvnAZtvD800vjMXloiSBJxeIJy?=
 =?us-ascii?Q?UwrmxYPAErAzfLpA/vRVIEwoIm0roUgNtLPt3n/LM03F6rSoxofheZC7lRDO?=
 =?us-ascii?Q?Xwun8rrBZJd44NKWearJjOQSL3vW8VbAsaT6tb2Qo7tpwAwlHaNe8eIoPefO?=
 =?us-ascii?Q?dFRpq+S6JrOarA/bdcxqSisRfUqmbXqxaxKblLrpp1wE3z26ng5J9V3PAeQ3?=
 =?us-ascii?Q?GgQBITjyn5vgFnzLtngE2qGP5p+usHhhcdYpS0RoUiTp//twkpQwNSQkN8Ai?=
 =?us-ascii?Q?cisQmrKrtDM+0+OvkmTltq5i1Z0us9f3waO1EZX4TMy8xxW05RYHTrgvVbbk?=
 =?us-ascii?Q?D3tzWuvI4z2GVTbBjCSc0mPpaH/Que7GMmtO+woPvdR+2H+dGkdOkddXZ2oh?=
 =?us-ascii?Q?m0i80S0kTSX0EIqtel/OCmBQbFOY59Gouk79uK/lgEHNvQ6BTHkRdZ6enXzv?=
 =?us-ascii?Q?hS3K3fUePxd4wImjg4A7xl43E9k4CoYkvaOjH3NktlzSNOfYqRm4cMKPNotm?=
 =?us-ascii?Q?gdf9H3JH3skkEJmfLYcEyMMz1TLIoaEqIIbGlR+seEMHHkmg0w23IfcoY+v4?=
 =?us-ascii?Q?uQXVktee+XxMsueNhcUdQa2Y5HfQ1tYD3Z29jK9MfmInXlk+Wzv6ygLd3pIy?=
 =?us-ascii?Q?npyoGPerwvy9G8xLwJj7S1GQE2xpu1fsmvlrMkIm3tN74gvoimAMfqpUZl8R?=
 =?us-ascii?Q?YmGiua8kEBnTfO2d8UqKO7+uAfgd3cZy8TnivwqfN19nxG7/IzWaBneYhnT0?=
 =?us-ascii?Q?5eIPEUSnc15xY9gKhxKuPYomftl1ISll5WozNJutrgOA+6uQeZpEOjBDojr4?=
 =?us-ascii?Q?1bFP4cUP2Xb9zG0T9LlJm/pLkeAm5XyyRY9Ri9/TIi4hzUz2CwEhcv/FF33/?=
 =?us-ascii?Q?Z/1mQ7tG48Nq2/9qx+R/4pm5L6k4hXq3SM8k0sK5THTmD7X6lzmmiQUyYf/0?=
 =?us-ascii?Q?bsHLCcSK/kYyv6wQCk1E/mN/xaDg/2M9iPz0Emu43g3bsue3pc+AytBb4L5t?=
 =?us-ascii?Q?0OMKR2HZWI8h7NdqrcHHL/l76WWyP7Kn+EMvDPS6+LtC+BHnRrBymnpLCzjG?=
 =?us-ascii?Q?sCkuiKuQJkPc/flwtfMIQ0WyFADquqP1uEd8n1ikzDEjZedqG/5ZM7wpIQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 20:02:01.9579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ea3f9b-e727-4a09-0542-08dde27fecfc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296

Add read of auto_sel in cppc_get_perf_caps().
Add write of auto_sel and epp in cppc_set_epp_and_autosel().

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 24baaa298af3..fbcfbe4bcbf0 100644
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
@@ -1555,6 +1559,8 @@ int cppc_set_epp_and_autosel(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool e
 	struct cpc_register_resource *auto_sel_reg;
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
+	bool autosel_support_in_ffh_or_sysmem;
+	bool epp_support_in_ffh_or_sysmem;
 	int ret;
 
 	if (!cpc_desc) {
@@ -1565,6 +1571,11 @@ int cppc_set_epp_and_autosel(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool e
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
@@ -1590,8 +1601,19 @@ int cppc_set_epp_and_autosel(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool e
 		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
 		up_write(&pcc_ss_data->pcc_lock);
 	} else if (osc_cpc_flexible_adr_space_confirmed &&
-		   CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
-		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
+		   epp_support_in_ffh_or_sysmem && autosel_support_in_ffh_or_sysmem) {
+			ret = cpc_write(cpu, auto_sel_reg, enable);
+			if (ret) {
+				pr_debug("Failed to write auto_sel=%d for CPU:%d\n", enable, cpu);
+				return ret;
+			}
+
+			ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
+			if (ret) {
+				pr_debug("Failed to write energy_perf=%u for CPU:%d\n",
+					 perf_ctrls->energy_perf, cpu);
+				return ret;
+			}
 	} else {
 		ret = -ENOTSUPP;
 		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
-- 
2.34.1


