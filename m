Return-Path: <linux-acpi+bounces-17483-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA3EBB0FC7
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 17:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3C33C0FA8
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECED0308F01;
	Wed,  1 Oct 2025 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fLn6TB+d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB33B3081D0;
	Wed,  1 Oct 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331004; cv=fail; b=cxrfunVhNrokeyzrKSzaCBP1tsjig99fXlLJdktZPn6PL/hGAVdzupiAX0UQBk3ZB2rVwGedxBUTnyP6hA3CkZm1PI9n5IBQh3qM1hjttj/zdhqVi3j9VBiSpjSFTD+vGEsthbkLIYQtwdj4zFqsmrdA4XF1K0DpWkj1zTULMv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331004; c=relaxed/simple;
	bh=lufpOUJXWvaXbvydJhhn0TdF/nF0R8B4S1qupX8CDXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dr9sTmV7SFg+YhCWJC5LcKRltnq/S1swvwHtuznI23Ewl58uEQ69u3g6MSs8lG/jF8ATQu0cZ/PZOG0w0Kdc/85uOhGDxIoUTqf+5Ywj0e8T20b0CLaI26y9E6WE1t/RtDlRq3tC6NE+XHfJ2gO89t9k4Diu93gKX36/PKLoiW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fLn6TB+d; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilSTgY3YfwJCfTl+2jQ8ywK5gu1f+JL680o3nUdoyEiYNMcROAaUki0LJ0t/QLsC6Pc+HZFlYK5cq20Gii6Te5gO5Gb7WZkIivgbpTjBFei94PEuA0wCoevojmAxrRvxQcxPwMU5wS9VLLelEvza6Jp/C21+6yvxvgJs7vkiwy0RS2xsbzyK5wY6ZcKRf4b9v+a4RyPvc4dXnPqUPPeJLkw5U729hGTOZveMqC2FIammvIcSZu4gyftGvGlD2TxYNDxnet9hOdd294sOP9hf4cb85A62/NPxdERgX4EOOmi+ld4XwLIF2y+lJs15ibxaGkSskzY8sT/SpkKWEfFamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svO4lhV5TCA2tVmRgEKBzTMP58G5wZUue61MV76cVzw=;
 b=JG/xY+Su+xIBwwkyrZCkNvcSiWMvRGMnymZmMT8sdYVxUef8r39jT+47Dr6JbmzGHbMcdXopuemoWyq8oYc09Ucv1bdeQjf8mrZa92ALIc3rHy6flK0uuIAqt6BoPo9Yq+7LTqiqVliwFLLLNEGBusuW7fK3lVse7g8oueD1BuUOMi2bR7zn3RC+D7Q68rrMUVwFVPy3bQ9AgBelSH+wCJ9B/QmBGQ0jadU7OBlvbM5pYzPkh7Glkf60BuJxMiO0Fg1iI5C9U2i/W4TvKLpEohFKjMRAjTY9CD/NsQL7yqKCOVfDa0rE3eKGnvkk4ookGzdpFOfAlVB/IW0vOFXMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svO4lhV5TCA2tVmRgEKBzTMP58G5wZUue61MV76cVzw=;
 b=fLn6TB+dGnGtJ+rjcrkZBf6wjsclUb82Xj4xZAHu4jY5gYSvsvWeMMJBZpNaHTEkA/hKY00J28M1Vs5MGgMEfRxDtZ4JhqJX1BZpObnpov7HVnEzrp8lUtBs75GCXh3MT0BAboF6R5YLzj+hz11ykTRvbsPAC9p1C+6WIrkUPUk9G/dYAysjjzCAvepESg9xYJRjwweU/RSo4hheVpJQ4Tm29Ssj8Lw+nlsnxXDE+Sy7e+jNiGpgG9npguecNDupJxjyvH8xX0+sejf4cwstVbiccJQfflEoOVmJjsWJD3fDUilwHBz3xJ38ILWdK8/NLh/F9Akidhp/1P8/ke/nyg==
Received: from BN8PR15CA0024.namprd15.prod.outlook.com (2603:10b6:408:c0::37)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 1 Oct
 2025 15:02:00 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:c0:cafe::91) by BN8PR15CA0024.outlook.office365.com
 (2603:10b6:408:c0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Wed,
 1 Oct 2025 15:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:01:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 1 Oct
 2025 08:01:35 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Oct
 2025 08:01:35 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Oct 2025 08:01:28 -0700
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
Subject: [PATCH v3 2/8] ACPI: CPPC: Add cppc_get_perf() API to read performance controls
Date: Wed, 1 Oct 2025 20:30:58 +0530
Message-ID: <20251001150104.1275188-3-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d495fa-ba96-4070-51bc-08de00fb78d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mysiRG7T5LWck6a1ndomuvZeHHoMN/q9auz409rjCAAIItz+T1QUhQWY7cUa?=
 =?us-ascii?Q?uxkDvSqpn5wEiE2ZpiEZW4Bu60gi/AWHqNcVGhBpOzZtWbn1JqugFsK8L4UI?=
 =?us-ascii?Q?nho8JfWydR9qU6pizEruoska0Zo7GNw0AAUQ9zaTtRuOk//wpFssfxDPlGHp?=
 =?us-ascii?Q?ALV2SOdl5/5/bC+7qvZIdQYFlo+3w5PpFdWa+Pm3H6sOJh3efY7xHMFvyWMC?=
 =?us-ascii?Q?G/gcT3z5fXyu8J/6hG1g+6wsmGRViLGSmIxfyQIi/1PJFYeh7hJ6PbQclxoc?=
 =?us-ascii?Q?/5xY0Oe6DXAQrgfbVxzQKWREbSudgHMgcUuKOdHRxfrWi40bHXubnKhlGd0c?=
 =?us-ascii?Q?qnrWprFZlUk1+fb1cXr3WzqGNrpRA6EIhKD8yqOyZWrCiVXyiGMmHYS0hVcA?=
 =?us-ascii?Q?LBamyM+OlewVqJbLrapjdy15qUJUlAcyOXsU/K43OXnGnSfd4gKjW5ev2xqz?=
 =?us-ascii?Q?pZOhlK0DlQ8YllsJuWxVu6uuFTveWseyhMOMrbJyWlPEiAyDRYhi85IE1r2N?=
 =?us-ascii?Q?uNUikpO7qvXjBdB5VUnbgKZCFSy4tXauBSos5dZon0JFHYthINe21qAIDyus?=
 =?us-ascii?Q?DDrbFaYap+lEzan5+XpIpNcPyz54ZMPpKmxQv1jPhA8TGDPCpjb5NS3j2FVn?=
 =?us-ascii?Q?TjMULca5ESQOXqYTVMHVJST4pngrvgc5TMLoJsDrbgRe4/v1ay23fVC6tIQ6?=
 =?us-ascii?Q?AgpwMh4NGI19pFsD/CsklOGF0ft8tS967nOAnekEi4maZlKleEWcjvQWgbNx?=
 =?us-ascii?Q?At4UiN7NCS0VHeLgCg7hiMF0sxb46SFbuRzV9oprwULDAhiQpYcgXV6uwKND?=
 =?us-ascii?Q?aEOv3nDPw+Hjdfyg2QteC/U+IFupKL9bfQuYuAV52ALyDDJmLMyJfkdIIDa0?=
 =?us-ascii?Q?1CKSYrCSWDy58QT4YE4xAsXaB6lbJqloSBJU/4n25szMZgh+wjvkgGT7VJeK?=
 =?us-ascii?Q?Wa1t+Xiw7hcdTR080O4dJEu+Y9TXBWLkpwcrbgW3FgarS83sNNqB+ZfmxmKC?=
 =?us-ascii?Q?PLxgXF+MoB7rVHoIUIFaszRaXUtK2z71Y4FSn8RkeIM2mCGt/H7+YFFGnJpe?=
 =?us-ascii?Q?n2Niqm4iyGycuF+NyTDm6YTq4g4gvECQItHRndTGHpu6HyHTHY1h5Fkdzols?=
 =?us-ascii?Q?ZAsiXGX2aXW4gLPoajBmu4o9WqtM0g44hzhpfFVtm3brOK+ThGFG2sJcnsk5?=
 =?us-ascii?Q?YJpWHf2EfGoVBsdCL/iinVzM8ZxKHd5tflAYmM/tZrsgh/IKF2YOn5xQEsRP?=
 =?us-ascii?Q?mDa6VdM2tJAbF4eKqlqFaBu4JoGM0K4y747DqsUVGnAZ0Q2zEATrEKjTPVjc?=
 =?us-ascii?Q?al8V2ts2VHPCWWR5tMb46iizimoIVIKoxuHM8oTvOO5cD2Xn0rFIxKOxyc8d?=
 =?us-ascii?Q?jTxWjv1H7qnQpsWJsKGYDqN7Lta7MBl1nuI9lUHP2xvaIQC6jcyZEer43vvq?=
 =?us-ascii?Q?KWG9CE8CIf+I26S/Dyg/QI+jyPbvXrUdUtTMAQwDVwiA6VwDy/OweKLz6KpF?=
 =?us-ascii?Q?MqxbwAhCG2hNjHViJOLf0rb8zBgGbmf+nd9agNUZarqLz0zgTXWLrFP9sdya?=
 =?us-ascii?Q?9SwVtaqSPgWWnS0Gp2lf1y1SOCiGEbLPIl6r1pCM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:01:59.5548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d495fa-ba96-4070-51bc-08de00fb78d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF

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
index 6b649031808f..ab8dd5cdb13b 100644
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
index 20f3d62e7a16..213bd389ec57 100644
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


