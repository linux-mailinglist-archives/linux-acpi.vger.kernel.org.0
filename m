Return-Path: <linux-acpi+bounces-19819-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7741CCD934A
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 13:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98C81304FB87
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8469C3321DC;
	Tue, 23 Dec 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W1XVCRmz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD193331A77;
	Tue, 23 Dec 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492049; cv=fail; b=bSEk3Te64bZLsLaoT0rBvh7dqxMQJGnDg7CZmwocZcPCARy4f1BbzuE6iCNYzEt/cEeRYs00z4q/VWhgAv5BhPelGWQkWnvFPi7GH3IxO5yIzCyRlmB7Brv2CRw0Y1h9bC4ru4QHI5kJzGkRy9Riblo1ozgaXTL48tQT178UlgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492049; c=relaxed/simple;
	bh=eikuNNWZCmRL/5A/z+zcw2F0CuizEaJFL8vzA7A0pj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxFoWWpH+0HZA5RvJsG76aI1AMXA2VO+edmQguF+HrCFbI7QK98F/HquSL8reCrzH9Kb87cHmAsRjUa2lCNs7pGI8nJYQZ43iiIAjEmsPaTOwJqCdJBgZXV55cDgNJakgRhTWeXMxt54EZdrjmJQycsCVFF0PMEPNXYEqsLsY4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W1XVCRmz; arc=fail smtp.client-ip=52.101.61.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyV/fMg9EOXsvJ/F3EMw0x/rvWcTFinZxZ+Gvcig75iGXoPVkbWKKSlo7aX0o80U71SwdMBsHwDT5TKV1P7M+PUNbnCEFWfqQsFg+El8/k2jW0es+zIkwpHG54h74EOqK3MPNKpLXu30JeGGtxbMxauXxEEFTWfibwUi2c/q0nJBfzrMQgNDRnJTW4WcsrQiV6b7xCC6Ab8UMQUklLyi/RKkIqaEDg2eeo6QbcrNDxJtWo0kqubSBmqouYKKsTwdhMBX+GbRD7H9mwXFcg3WQUqIObOazEZjddwOQiCd97p3k6lyv/e81nsDoFvX+hQv7jCoFUnXHtJieQsOwEdWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kT//9ChpBu5xs99TSYBBq4OmHngQKlF95xpQI+Ke6MU=;
 b=CiwDVEJsI8wZpPEXKcR5fK3R1WBJxHxQlL31jHB86HpVEp7wy2ci2Pk7zTQIGDYRK4ZWCXo8zfWioqXfZivtYEqiPU8xTGgrZRGThePul5gHMItZL3eBuKZhvvJW3IroYFsbek/NucYTZwUGK/6fHWkqfZUinRExmOt/29H6LYOBF/U5m2Bc4h5KllOJ4lvs3CiJNQbHuZncpPMIqBSG3amPzJv66jgbr116JyXHs0a14RxPVa2QPXSr+xZTxdQtG5DTmTqzq/a+BE7rs//CRT2uTPTY13+BOA4XPU8d/1/pzrI9/pZEJZOml4hj7+6EJVJnjNAKGdCSgk0yHOwwMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT//9ChpBu5xs99TSYBBq4OmHngQKlF95xpQI+Ke6MU=;
 b=W1XVCRmz/xJpQgkWfApMtqlEPgRq44Cb5Zqr8z9udjicNWoB+Jcfe6csjaxPFnMqNnrgzjRMXVL23TnXwjsD0YwOMPUU8+iM7mDDaRw1ycZCb8Xv5MToygDUt+HM+imPypkzq9qPM6KjMr1lr9QBuvVHMBpk33wl32L6Jsw5ySC7L9x7noTVgTEMvSs6WE7ytjr0UMD6TubqJOZZvCqGUesN8TuBDhLEyfwzmiAR19Q4O8uTVIWqsnWE1XHkkw88HEaSV9NivhBBI04pNtjjZFm+ziQcNPlpibsfXDbjmLmELUhSB4YK062zfib2xhFmWdJFeFr6RzHlzM4/yp6PtQ==
Received: from DS7PR03CA0168.namprd03.prod.outlook.com (2603:10b6:5:3b2::23)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 12:14:02 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::2e) by DS7PR03CA0168.outlook.office365.com
 (2603:10b6:5:3b2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Tue,
 23 Dec 2025 12:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 12:14:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:13:48 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:13:47 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 04:13:40 -0800
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
Subject: [PATCH v5 03/11] ACPI: CPPC: Add cppc_get_perf() API to read performance controls
Date: Tue, 23 Dec 2025 17:42:59 +0530
Message-ID: <20251223121307.711773-4-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 446f90a2-1aaa-4164-7d3e-08de421cc21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oedexfdQrjndmFfR9HY3oIMhf/I6uu7qLbGNR7vKptAh4KGLuy1yOc69qYPM?=
 =?us-ascii?Q?II9Fo06WShqqR7Y8jUIv4jPn6sVrYablRk0hK8/3kpVPq8DEcgoCWVNSXu2W?=
 =?us-ascii?Q?zmu0qpkz8YMO/2lzSdPBwBP3yzNSM336mxU0zk6h5qBDBx/fOddzXcPoaiMt?=
 =?us-ascii?Q?RN4HUPXcXTlgNmRAEF5PXPENg3xsYdUbNscpVABmFMeeDA63uMW9iWG/s9jr?=
 =?us-ascii?Q?vrWrh2HNQgSQcOcf+vi73Clxyka0XKcjCwrZ6VU/UWQhkkl0GYjLjq6GA7lI?=
 =?us-ascii?Q?iIv/FT0wmlPPYHtr+ZLIj6nvHfb2L1dZpu4hMX+tX+pNOU1Uw8/DOvxFBFdj?=
 =?us-ascii?Q?gmYZuaKeVW2ApUZZU3insTJMiSbgruASinPoWhX/0LeAiUNCaJxlv42DE1Po?=
 =?us-ascii?Q?x4MxaaVSMzp/7eRteLq9N3HuIN5cXjxIAPm4Txe+z8n5/3Ilus1vFflkDHOL?=
 =?us-ascii?Q?Zdl5rfj4ey4ArUvBaQNhA3bGXdrvMsFWUrZ+p1c+16eUkUhXvRUC/lSVZGFV?=
 =?us-ascii?Q?WE/3gVgve8vSh7JrDK2MK+rGydmk/B3lxVWUtlzVK0sou8qxlktlw+hasMu8?=
 =?us-ascii?Q?YMwa1mRYRzBP3UcFmqZfydW+3lpKoj6UbLvVaisiJd0c2CUc7aNG+HID7D9r?=
 =?us-ascii?Q?GSGMwYIxMzTThgzGDEACqQjjrfR2/WAVSIK9v0iGfbukxprTfi5YYH8yoNTv?=
 =?us-ascii?Q?3MaUrLxSwTYG2dRQbgcMGN9MKfWQARaQxU43iHq0suMSILcVOAlztAImfRN5?=
 =?us-ascii?Q?Rru6935WbtuitPVrBFfURumumYps1+oggEoM/fbLPNLlO3rrmXFfPXhod6RL?=
 =?us-ascii?Q?4V5ahCdiQ0tgb6YJYqX4li8UAzRx4DBpAsebxSTnUbYiAcT/H/lUU60IPsmS?=
 =?us-ascii?Q?OJ99I3aft449/NttEEt4mu0Ie/eDDhJk5rS82oUoqpWt7pcdxBqv9qla2hZt?=
 =?us-ascii?Q?GQlVQ6sMjMBypsDXLVdTW6wo+AH0Oh8OyBmyb9NRJ65uzllI81Qkf4QIr2rY?=
 =?us-ascii?Q?puuT6oKYrKZQ3eT/yFDV+qhAyCiZevMFqkgXEsqUFxblEeLWkqZv5belv2jL?=
 =?us-ascii?Q?+g3yn8spRlLYaekvr+rJ7ublNedrIOuX6nl8/YBTHtqTGjV7pebqbSFOxNkX?=
 =?us-ascii?Q?0VOzvTt2FnGv5D4ErHq38c9UIHEFW0c/hweU8m/VahmrpA5t+FTHA8BUk2tl?=
 =?us-ascii?Q?eBgQvZkkWqNsQ5GxKqt9bL3sgDmSeBPqNRK8GpK/E4hZC+adMwwIV/oOPIqk?=
 =?us-ascii?Q?uDTAsr412rxfmObx2Zhws7BJfQEDuG7Gj0csa0pAPGxHQW9041QwBFOZw07b?=
 =?us-ascii?Q?4ZBj5qW/o307y8EN69KPWgcRc3ONfZoxtC26S5dCgxHa+UOQon1hNJMJjsIO?=
 =?us-ascii?Q?7ayIwsCRTl2fZ0xPDzmCIMB6Hck6b5Apk/+w+h+AXvTLUD57yW17FmB1qe1V?=
 =?us-ascii?Q?P0AbPJbwwC5REDUszcfzb0wKCm0p5VjtlzmT8Heuu+RkVUVoEmdyDWd1z7SZ?=
 =?us-ascii?Q?6X1ovZheuR1MGDsuk3yijp7mhgrWJPVqCcfTZij5sD7yVjp+NNAnluOQySnf?=
 =?us-ascii?Q?v7XOQIo5bBzYF8AXYZPiaA6RX1PYZ9Rds/fv5MjI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 12:14:01.5239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 446f90a2-1aaa-4164-7d3e-08de421cc21b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476

Add cppc_get_perf() function to read values of performance control
registers including desired_perf, min_perf, max_perf, energy_perf,
and auto_sel.

This provides a read interface to complement the existing
cppc_set_perf() write interface for performance control registers.

Note that auto_sel is read by cppc_get_perf() but not written by
cppc_set_perf() to avoid unintended mode changes during performance
updates. It can be updated with existing dedicated cppc_set_auto_sel()
API.

Also call cppc_get_perf() in cppc_cpufreq_get_cpu_data() to initialize
perf_ctrls with current hardware register values during cpufreq
initialization for each CPU policy.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 79 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c |  6 +++
 include/acpi/cppc_acpi.h       |  5 +++
 3 files changed, 90 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index e66e20d1f31b..a4e89fe6aab5 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1732,6 +1732,85 @@ int cppc_set_enable(int cpu, bool enable)
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
+	struct cpc_register_resource *desired_perf_reg,
+				     *min_perf_reg, *max_perf_reg,
+				     *energy_perf_reg, *auto_sel_reg;
+	u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, auto_sel = 0;
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
+	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
+
+	/* Are any of the regs PCC ?*/
+	if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
+	    CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
+	    CPC_IN_PCC(auto_sel_reg)) {
+		if (pcc_ss_id < 0) {
+			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
+			return -ENODEV;
+		}
+		pcc_ss_data = pcc_data[pcc_ss_id];
+		regs_in_pcc = 1;
+		down_write(&pcc_ss_data->pcc_lock);
+		/* Ring doorbell once to update PCC subspace */
+		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
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
+	if (CPC_SUPPORTED(auto_sel_reg))
+		cpc_read(cpu, auto_sel_reg, &auto_sel);
+	perf_ctrls->auto_sel = (bool)auto_sel;
+
+out_err:
+	if (regs_in_pcc)
+		up_write(&pcc_ss_data->pcc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf);
 
 /**
  * cppc_set_perf - Set a CPU's performance controls.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7c26ce554e29..a87e7bb2e2f1 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -562,6 +562,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 		goto free_mask;
 	}
 
+	ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
+	if (ret) {
+		pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
+		goto free_mask;
+	}
+
 	return cpu_data;
 
 free_mask:
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index a090b010f5f1..12a1dc31bf2a 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -150,6 +150,7 @@ extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
 extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
+extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
@@ -191,6 +192,10 @@ static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_
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


