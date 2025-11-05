Return-Path: <linux-acpi+bounces-18535-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A24DC35662
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 12:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68EEC4E75EF
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 11:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9F3112DB;
	Wed,  5 Nov 2025 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c422Xdhe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE23101DC;
	Wed,  5 Nov 2025 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342789; cv=fail; b=LM/BSw5XzcW2nOdPioLoqMzIo1C/X6doqAKJdcxs8hOJsvMkWs2ZDSOnDqROo81fbmUBzChpp4f+qFKkxHI/Nb6NwATOpufobzvrCv4e5mCbMVd4/6GneMAlWEzhWROn9a9hIl554oQB3fSu406x431PK+EnM3BrskVWEWu6aAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342789; c=relaxed/simple;
	bh=EOxpe2xiG/b60y30FFaOH+dp+7ldInpu5fnLSOSwnVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5179wlDgCUzaPBJBDMGXUlI6oD4tZh4KzLlFtZPDcB8YiK8ODQWLKWF6dhtkolyzDjI0jokBHq/BREU0vstajS5hWebnW+xtX6i1vmOtbD24BpRSnynXV4jITLQikMbSdn01rbyb+MDViprTeeYQiDV7Rdfu0eKvMJT5aGQafI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c422Xdhe; arc=fail smtp.client-ip=52.101.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAfIu0cnz7B43Mdhb2chcFLJYANGDMKu8AhEMeOfFkSivmOISMKbxhaikYhxWrRL6WhqXwsNJM0NiocCZznFqu79L/8btljJwu9NhvBtjgnbxpegwoqIyAKCMTsbxNkrfValmOaoBd2JASHUOZohcUbPy+YB8zZPu2fYY+TTekIfFbpNQIKld7Rr45T03uQl+NbooRyV9kg7ZVuv7ooF6mB93lNXqMPGcwKHznh6Mp91kuUOIyI0kN9VjvxSnToIFf3tpW1BVgYPr1G9/5W5Xx/HHVuUigqdgIoPy/wgExxy0EvPsuMYOxZVO6qxze3WtrrRNf1gUAXTXQzyMkYfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cyDigDngr9ATGvhRUddVCSgqlh7AeX/G22+2WPU4Go=;
 b=w87JKZVQLF0zsA0a7deg4cAgtYpAPo9AkQExtffMdXpLabQgVDRQT6/AZDSSwq+FIIfjkHDFaq3QUnpv+W3MwlRCBr4MZ56nsTf2pPjac1mhVGpDAqHE4l57iLQs/yV1BQe8t2wFNQaZikRlK8W//WCpSp1YY0BPQIC7WPzXn8B2NlIeoeyYOzjGFySbGtGipmUaxNa51tu1BzQBnDbipHMi+79c3ZRJedkQK0YKKf6ln+qmgFy2mBEDnfnMv9mudpx1cP0z9pOpxiQDJFU2JWeX//QVnK0IqoH1q5yZ6YBWMKJN4SMXQ4+/q82ea9qRRkhAmqjJb9YIbPXvpauEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cyDigDngr9ATGvhRUddVCSgqlh7AeX/G22+2WPU4Go=;
 b=c422Xdhes/FxaE2nKAowS/MQgsz4I8ghj69leaZrzGLe+ejQnFSknac14teeXlEb1DYcjwvJRtR2n1US6IWMwnyqvxlg4cpr/7Jo3moJiAnzba+jf2+IWVKZBc2Mbo6wW5UqkAitL7WX+7LyITetk1RlX90UNegRxQNHiGt+HbCcbxZRkonmZ+2ptnCFZr3N+alOD3E3yLh/gEkrGxJcA+dwpUa1KRaat0ReL07QOfOMqJ3OjwppgUZTm/rxX/eXubWEwN72AdQYBWUC8Bsf3RkUxfIHYyJ7rXQMRwo1KYivgM0Sz9AEuA+8VNOj+yr/1cMvb07zY8j5raENnv/e9Q==
Received: from BLAPR03CA0119.namprd03.prod.outlook.com (2603:10b6:208:32a::34)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 11:39:43 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::b0) by BLAPR03CA0119.outlook.office365.com
 (2603:10b6:208:32a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 11:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 11:39:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:39:29 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:39:29 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 03:39:22 -0800
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
Subject: [PATCH v4 2/8] ACPI: CPPC: Add cppc_get_perf() API to read performance controls
Date: Wed, 5 Nov 2025 17:08:38 +0530
Message-ID: <20251105113844.4086250-3-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: c96fdb0a-0604-41e7-64e3-08de1c600374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uVhsJ3KgyyS/oTKwCyncKn3c3YlMZ3bf0QAH6S7FwRCWafuX5GYAT2QgMevm?=
 =?us-ascii?Q?nywOrcA1cY4+cyfe/TnUvONWjyYMt4CiP1WElFBCutB30LH+IAmJ1R1RYE3X?=
 =?us-ascii?Q?nRPlpN3E+EjdOze6Zfw2qTPGhlBtty5zj3QkCUOZY3WHGNa3t+YmL+GQlarU?=
 =?us-ascii?Q?/PZ8+4d3UTzFy+ONVumqxDDJbjmE8/rJ7p+/zWkVVPhuRdxlsmb4KpP7WCQh?=
 =?us-ascii?Q?YKQuZisoGDvYLtk30AN5tbf4UlNzyk2y8ZDJE2QAFohA/lK1QNROQRFG/Lz8?=
 =?us-ascii?Q?N7vex4BGKQOs6R683e/e1sXaE2sLOjw57uuZUW1yw+0+wr3HvrnHKMqBKoQu?=
 =?us-ascii?Q?Jzp+Pp/WuzKPsOw2+qPVlVL/eEFafLeQWKb8NditX8qJuEP56U59sO6n1C/P?=
 =?us-ascii?Q?xPdygfjYD6EeHtV24BR6Ce+5JEdH7lTKkmVnlglgeXAecHcBryiZMKLo16p8?=
 =?us-ascii?Q?Q24Te/s2gCLYQejpnYQtZVFy6vOqTkRmfBNPoDRPq7vHiapnGuebss8c7Cuk?=
 =?us-ascii?Q?jbR2a7aXzysBAW7y8i+At0YqnJ2/KUQsGSJZADdAFQRnfuF5djWIWU44KDWg?=
 =?us-ascii?Q?tJRYlu8xD7XMJpzWwBO2imI+VM/j5hqxzNEvi6pBwPrE8XwJF7tY3lh8I3TS?=
 =?us-ascii?Q?OnXxjSIPQBep0ce02qwy8mvfrC6DBQRfeNXjBJm4TiwYzwpDhhP0aLdUjXZh?=
 =?us-ascii?Q?R01c2GVjblm/aMc3q3K8Jw1o8jKtyyrQVyD0hfBVsFSlhmPD7AUYbPj7jTmE?=
 =?us-ascii?Q?PonM/1DGcWpsAzr3jX5eiPRlXPRgcr4nkH2b8MZ2KppUe7ih9kLDitkEihQG?=
 =?us-ascii?Q?L4psESuMFt50pdNOgY5AVFkAGpuxEqryRIf5xvZLM7pf3SCrHltIGWfWiQLG?=
 =?us-ascii?Q?F8zUjG4gJeHFRTLhwtCCwNFlW7KLDi0o5Dq7ZGyjtUv+C9M3WODoeDcQ/N3h?=
 =?us-ascii?Q?62sQUr21UEKtjRWCxELxg61QAzuiGiFocGeP/8paaB4Ijz6TVl4OI/WxFfJ6?=
 =?us-ascii?Q?FL2I6qnOQF0fcC75NDg1DFpkpQi94SPscsuOEgx8PImEL3q25dMftiKcWI77?=
 =?us-ascii?Q?7+MRgmbAzIfJufBSNwEBl7H1lGjKTcxOytSgXnaYXQDjAnf0ODdwOh5es2l1?=
 =?us-ascii?Q?lPtZ+3iDENuTLhT3SR61TYedVcQBlFkRDHi9t5PIllMmh1pA7FxO4HZICYfe?=
 =?us-ascii?Q?L2ch2wYMd6P6XxMX6u5YT0C1I6ukA/DHVBPtGO+EIa4JX6ux49/kQTMw+rh+?=
 =?us-ascii?Q?TxoO8kp9RiNDRSIiR4yGIPYGg7vRL96nZHYrusoEKyOqhCecuvOzLLLTHBuV?=
 =?us-ascii?Q?OvmfPbY24hoZ9q3U3YX9vPgYkZx5ZYUaQ2sVumiZRbA4n2sIQSo9wX/QIGYC?=
 =?us-ascii?Q?eqEo7sAHf9p885BNEVni3EPsIXMhxyT8bcmneFePjZHz31tN23b33aAY0Xtb?=
 =?us-ascii?Q?h1xLscJJT476yD1qculi9pM1Y/1Rf5qIv0lB/fgeGv465NMK9LBIBk3yDeIH?=
 =?us-ascii?Q?pomLnAM1fhZK1LYc46uule9islERkFBdITSE9jPhWfpT34/GxSA09lK30Q8L?=
 =?us-ascii?Q?UJweA2f0koMppLkID3YPfTSXpVb5L6pB37GnfRQo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 11:39:43.1640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96fdb0a-0604-41e7-64e3-08de1c600374
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

Add cppc_get_perf() function to read values of performance control
registers including desired_perf, min_perf, max_perf, and energy_perf.

This provides a read interface to complement the existing cppc_set_perf()
write interface for performance control registers.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 73 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h |  5 +++
 2 files changed, 78 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ab4651205e8a..05672c30187c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1731,6 +1731,79 @@ int cppc_set_enable(int cpu, bool enable)
 	return cppc_set_reg_val(cpu, ENABLE, enable);
 }
 EXPORT_SYMBOL_GPL(cppc_set_enable);
+/**
+ * cppc_get_perf - Get a CPU's performance controls.
+ * @cpu: CPU for which to get performance controls.
+ * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
+ *
+ * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
+ */
+int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *desired_perf_reg, *min_perf_reg, *max_perf_reg,
+				     *energy_perf_reg;
+	u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0;
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int ret = 0, regs_in_pcc = 0;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -ENODEV;
+	}
+
+	if (!perf_ctrls) {
+		pr_debug("Invalid perf_ctrls pointer\n");
+		return -EINVAL;
+	}
+
+	desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
+	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
+	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
+	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
+
+	/* Are any of the regs PCC ?*/
+	if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
+	    CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg)) {
+		if (pcc_ss_id < 0) {
+			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
+			return -ENODEV;
+		}
+		pcc_ss_data = pcc_data[pcc_ss_id];
+		regs_in_pcc = 1;
+		down_write(&pcc_ss_data->pcc_lock);
+		/* Ring doorbell once to update PCC subspace */
+		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
+			pr_debug("Failed to send PCC command for CPU:%d, ret:%d\n", cpu, ret);
+			ret = -EIO;
+			goto out_err;
+		}
+	}
+
+	/* Read optional elements if present */
+	if (CPC_SUPPORTED(max_perf_reg))
+		cpc_read(cpu, max_perf_reg, &max);
+	perf_ctrls->max_perf = max;
+
+	if (CPC_SUPPORTED(min_perf_reg))
+		cpc_read(cpu, min_perf_reg, &min);
+	perf_ctrls->min_perf = min;
+
+	if (CPC_SUPPORTED(desired_perf_reg))
+		cpc_read(cpu, desired_perf_reg, &desired_perf);
+	perf_ctrls->desired_perf = desired_perf;
+
+	if (CPC_SUPPORTED(energy_perf_reg))
+		cpc_read(cpu, energy_perf_reg, &energy_perf);
+	perf_ctrls->energy_perf = energy_perf;
+
+out_err:
+	if (regs_in_pcc)
+		up_write(&pcc_ss_data->pcc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf);
 
 /**
  * cppc_set_perf - Set a CPU's performance controls.
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 13fa81504844..7190afeead8b 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -151,6 +151,7 @@ extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
 extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
+extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
@@ -192,6 +193,10 @@ static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+{
+	return -EOPNOTSUPP;
+}
 static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1


