Return-Path: <linux-acpi+bounces-19821-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2179FCD9372
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 13:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E7EE3024E4D
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 12:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E434F3321D4;
	Tue, 23 Dec 2025 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qcFAfepa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26744330646;
	Tue, 23 Dec 2025 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492075; cv=fail; b=r8+QkKE3UIVWQ7nOajZHkQsui7NwszV8fUj9nDLM3iaahZuQTzSsA+bopSM6keqIuiBs+lxllt2o0e/NrPTGOIyFwR7AMPB0u/3pbeWhjM0X1QxJRfbHxb4qKZcZ8W6c6pJUkvDr/qNIZB8pWGAzHLYrGpZLOttlNeXah67ANOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492075; c=relaxed/simple;
	bh=jqVoojmB2FuGX+NjrxKdcXJAEWKwh7Ioa/di9BL0dNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lyw/TZMjlX0aBN+UmWcM1bQgPGYn+W4+HtkO5w4YE+Uaim5uSThiFsl3oCzppM7YRPIB9HFGQra/MbLtIa7t71dVLVwOzKC9/x5afbfZADaF68fmaIEgYQOdrDdP7ZakpuGhv1ORTDNuQQMF1/mvi9YlQx9fqySV2yHDz41PFdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qcFAfepa; arc=fail smtp.client-ip=52.101.85.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMBhzaAO0s+KunTN0bpKlxHroT4eD+rCIJU88FY+RL0cDzr7Qb2K6UUvOu75M7i+fYMJufNqH19FVnk5xIxtUEBFh6aQ6JZ+9XMVyyx1ScTh1cFMX5i6TPzJ1Smr43WWfX3pImvpPVB0/3UuzyofnS8naHQYxyndDErEQ8c69vzc1hLTvkdcJILVCKNC/vSBXUtm8ob3P7V/crPcO5QMLfL1UHpcnGxAMbM85akc2e2PCuXcWENqflDvtxVVw1xTnnqG/iWJUnXajgyXP7S9s4b7+ARLN9vTKEbAIihhwhHBO/rI5MW0zBqCUNyxybPW/6aUst7QV6vwZQH0cGC9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVdeNsGG/txkSwOfF+JHPgUGK4izmGc700A2tS6XRlY=;
 b=HKEPydLs3mO1KmX8BJicwcdz44Vgv9y7fvSvvErZfBfDTsfQ8yf0SBWe/e/EukDRfFcmYpt5A9bzmDn53SvKz2a5z6tTOc1CZ1QSrw52CiYLiEm8amJ3dFaOqBvvW2SKifsOqI8SZ3fHJ9ePjcSPaI6aKXtPSjFDjZb7SKReUV1OziZ0lciquzhhgcmnOk+zqnzCGKKEN4beEDsziIV+jPcVCE57yPoQvcWxRhrSq11gXoSWWntnt2Z663E7fYyKDReDCgPw8RwiQGdze44ISXcY5E7KivFqF6OjvNoqaTOx6dSX1zwP3MX4L6o2pUXg9wwFSs31e5BRc4/msnMWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVdeNsGG/txkSwOfF+JHPgUGK4izmGc700A2tS6XRlY=;
 b=qcFAfepa1xj//mpmrkikjy9U3WXoUpiQmKsgRFC39QhOSr0Bu2z52xw6okl89dPBUpgLdRMcnwTWJjCmc54C1qkJ0OntHna5w+pVWDwNbB9tnY9coXFPuE2h7Vpy+N61wqah8nfdC+a7ak1tz/iqPLBf7UU4nn18KdJ7IaS3s3EWNK2Tzq9vCnf6WANYo0qKuAoOmVE3EfwX9LI3953mi0DQSIPYlSTCz7XWYXB54QCXweup8SahIRuLB0Et9ojXTPQw1ZnxTvgc0TELssdZahnK5eW2N/2zrsYTHK1PQJttnIirArBhKgqglD6F5NFHUbTsc4Ypu9FjiNevqudsYQ==
Received: from PH8PR02CA0042.namprd02.prod.outlook.com (2603:10b6:510:2da::31)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 12:14:29 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::15) by PH8PR02CA0042.outlook.office365.com
 (2603:10b6:510:2da::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Tue,
 23 Dec 2025 12:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 12:14:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:14:14 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:14:13 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 04:14:06 -0800
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
Subject: [PATCH v5 05/11] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
Date: Tue, 23 Dec 2025 17:43:01 +0530
Message-ID: <20251223121307.711773-6-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: bc236c0f-5d28-4997-16e2-08de421cd24f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rEwZEoMxbcAEUx6qBcxqEpjZ2Y+wuLASSADihnIXmuDUJfhsIK4cOnYsSzCP?=
 =?us-ascii?Q?KIvK6yKeVmjTzvb2/9xI40bo6aJ6IXtwUWHb9adf2C6r3V3UMDl3ucWT/7PZ?=
 =?us-ascii?Q?9jDwq1unW7SQVlVQ3RDtq4PmnAeKOP1jw6oQseG7OPSB466RyRSx9/eeOX6D?=
 =?us-ascii?Q?KogVW4O2dRg9W8OU4oplDpRe6kF+8kowohRc8VOSywvVVCfSuCI+LOSAFJK9?=
 =?us-ascii?Q?7VZXZdgQJOE7g3j3/sJYVKfKqMlbQzR+zsv9zKUz22c5BR9OeEW6AWfyzdqU?=
 =?us-ascii?Q?3ZRNTSQcgqTLLn9vFV63Z7fvJM37QiT4lLLdWn2nra2u0nNf1pcevw7GEuXL?=
 =?us-ascii?Q?V0AvAkDkY+F4TWGjMyj1XNzIz/lTlPSYrI91BhjpYE/DVsxSAW2x6vF6YpxB?=
 =?us-ascii?Q?86DzgHWEL7a1HWizprxmA/NpKUB059+AERCOMDVe6myoD5QqT/4Jip+18jvb?=
 =?us-ascii?Q?3b5nt/q75pblL3xiOWrXJx/wPuhKLKcws/d6GYicqNvyypXc6Z61sx9Q2AXT?=
 =?us-ascii?Q?opzYQdA9EPRHTN7d0JxelcpJSVoX949Fcfpkw8tPKj1Ox3BeJKKwZQv3iTF9?=
 =?us-ascii?Q?iQKfqSwafW4cMB7B0vWJLq84pXQSNaKZ1o89DedjzdeFQSHT5G/ppxKFnsx9?=
 =?us-ascii?Q?Jeb4Lb9cMOm93RJtenVc735UtD1nY/gFKVWH0bSA1XG5LFfKflwRY0yeszkN?=
 =?us-ascii?Q?coOr6EA2KGRAgZfVRMUDKicqlW0hRqXuJ7fHR2tN12iS4NAWCuCjBWYSX3ky?=
 =?us-ascii?Q?/vvfz+sT6z6e7bzwV/tdp2FKPkz1Hf7EDz6zASddONboHI9iw+Qx9BWXhVRl?=
 =?us-ascii?Q?SegnNvJNqnCUK09bDJZdwpM94Io6M9jFPDXbBMR5Tuc8/+cmrxtzZ8Gn0kXO?=
 =?us-ascii?Q?lv2MSRtIBVfi6GKIHjwidOq+fnh3meOH2MfEQAbXWMoPOk9HbfDTAUBDcqy0?=
 =?us-ascii?Q?KpjIGd4mx/jmO0Z5zQ2h1ReJlBDJ9p9Bp1PpdIhitUlewLzze1OB8HUhJYpR?=
 =?us-ascii?Q?9DKAT6JZapcSIijbz4oGDmItzpYTUn9yvrPQi5FaEoGEq5XbBZpchCzM+C8l?=
 =?us-ascii?Q?xrQWxlWzJLERQA8yu0Z+lL2Dil0IU+DdCwOQjAOoTJrm07bxPvMub9TaSy7L?=
 =?us-ascii?Q?oEJ54/claPrk3ciGALh4xD95Ev+qP0OVPOdZm5wkJc9Tog0BSPjQo25+W6Dn?=
 =?us-ascii?Q?C93wj7nmfrdfAQa3rGOKJyBTrp7U6ttLKZacQKoxQrtuEqchq88EwjbS3Qjy?=
 =?us-ascii?Q?s4lwqyhhzfFAKNeHGoYf+eiPIYd39dPNuTnUxI1JoJf3BjfgNDP+YfmJRZKz?=
 =?us-ascii?Q?DvcnWgBFbcv6EcsxRUqjuH5b+Vy7xnfkewpl8awkwwsulRLrhrkX4/SS1g0i?=
 =?us-ascii?Q?dfb8jKBjwpaYdR+agZLMW8M28OKD4t3c5yMFZmexVfMHFP98m5NxF3TFEU4w?=
 =?us-ascii?Q?9UyDw1YhQz8nuDvyuJAo7o23OucP/mPE3f3WceZpmmEh7dFXWoGYoFMwCFhZ?=
 =?us-ascii?Q?/kysN8X9RDDoQXkgZtDcyLwetC9tw0aEP6Z4yKxGYbQuAPXCc3ni+G2VoTIg?=
 =?us-ascii?Q?op6SwXcIFALpMz9aDZyi64/o3Ceu5SM39wuETVRv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 12:14:28.7048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc236c0f-5d28-4997-16e2-08de421cd24f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235

Add cppc_get/set_min_perf() and cppc_get/set_max_perf() APIs to read and
write the MIN_PERF and MAX_PERF registers.

Also add sysfs interfaces (min_perf, max_perf) in cppc_cpufreq driver
to expose these controls to userspace. The sysfs values are in frequency
(kHz) for consistency with other cpufreq sysfs files.

A mutex is used to serialize sysfs store operations to ensure hardware
register writes and perf_ctrls updates are atomic.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       |  44 +++++++++
 drivers/cpufreq/cppc_cpufreq.c | 160 +++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h       |  20 +++++
 3 files changed, 224 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 403ee988a8c6..9f28c20d902d 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1742,6 +1742,50 @@ int cppc_set_auto_sel(int cpu, bool enable)
 }
 EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
 
+/**
+ * cppc_get_min_perf - Read minimum performance register.
+ * @cpu: CPU from which to read register.
+ * @min_perf: Return address.
+ */
+int cppc_get_min_perf(int cpu, u64 *min_perf)
+{
+	return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_get_min_perf);
+
+/**
+ * cppc_set_min_perf - Write minimum performance register.
+ * @cpu: CPU to which to write register.
+ * @min_perf: the desired minimum performance value to be updated.
+ */
+int cppc_set_min_perf(int cpu, u32 min_perf)
+{
+	return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_set_min_perf);
+
+/**
+ * cppc_get_max_perf - Read maximum performance register.
+ * @cpu: CPU from which to read register.
+ * @max_perf: Return address.
+ */
+int cppc_get_max_perf(int cpu, u64 *max_perf)
+{
+	return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_get_max_perf);
+
+/**
+ * cppc_set_max_perf - Write maximum performance register.
+ * @cpu: CPU to which to write register.
+ * @max_perf: the desired maximum performance value to be updated.
+ */
+int cppc_set_max_perf(int cpu, u32 max_perf)
+{
+	return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_set_max_perf);
+
 /**
  * cppc_set_enable - Set to enable CPPC on the processor by writing the
  * Continuous Performance Control package EnableRegister field.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index a87e7bb2e2f1..1e282dfabc76 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -28,6 +28,8 @@
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 
+static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
 	FIE_UNSET = -1,
@@ -538,6 +540,46 @@ static void populate_efficiency_class(void)
 }
 #endif
 
+/**
+ * cppc_cpufreq_set_mperf_limit - Set min/max performance limit
+ * @policy: cpufreq policy
+ * @val: performance value to set
+ * @is_min: true for min_perf, false for max_perf
+ */
+static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
+					bool is_min)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	unsigned int cpu = policy->cpu;
+	u32 perf;
+	int ret;
+
+	perf = clamp(val, caps->lowest_perf, caps->highest_perf);
+
+	ret = is_min ? cppc_set_min_perf(cpu, perf) :
+		       cppc_set_max_perf(cpu, perf);
+	if (ret) {
+		if (ret != -EOPNOTSUPP)
+			pr_warn("Failed to set %s_perf (%llu) on CPU%d (%d)\n",
+				is_min ? "min" : "max", (u64)perf, cpu, ret);
+		return ret;
+	}
+
+	if (is_min)
+		cpu_data->perf_ctrls.min_perf = perf;
+	else
+		cpu_data->perf_ctrls.max_perf = perf;
+
+	return 0;
+}
+
+#define cppc_cpufreq_set_min_perf(policy, val) \
+	cppc_cpufreq_set_mperf_limit(policy, val, true)
+
+#define cppc_cpufreq_set_max_perf(policy, val) \
+	cppc_cpufreq_set_mperf_limit(policy, val, false)
+
 static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 {
 	struct cppc_cpudata *cpu_data;
@@ -896,16 +938,134 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
 					    buf, count);
 }
 
+/**
+ * show_min_perf - Show minimum performance as frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer to write the frequency value to
+ *
+ * Reads the MIN_PERF register and converts the performance value to
+ * frequency (kHz).
+ */
+static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 perf;
+	int ret;
+
+	ret = cppc_get_min_perf(policy->cpu, &perf);
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+	if (ret)
+		return ret;
+
+	/* Convert performance to frequency (kHz) for user */
+	return sysfs_emit(buf, "%u\n",
+			  cppc_perf_to_khz(&cpu_data->perf_caps, perf));
+}
+
+/**
+ * store_min_perf - Set minimum performance from frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer containing the frequency value
+ * @count: size of @buf
+ *
+ * Converts the user-provided frequency (kHz) to a performance value
+ * and writes it to the MIN_PERF register.
+ */
+static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf,
+			      size_t count)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int freq_khz;
+	u64 perf;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &freq_khz);
+	if (ret)
+		return ret;
+
+	/* Convert frequency (kHz) to performance value */
+	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
+
+	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
+	ret = cppc_cpufreq_set_min_perf(policy, perf);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+/**
+ * show_max_perf - Show maximum performance as frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer to write the frequency value to
+ *
+ * Reads the MAX_PERF register and converts the performance value to
+ * frequency (kHz).
+ */
+static ssize_t show_max_perf(struct cpufreq_policy *policy, char *buf)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 perf;
+	int ret;
+
+	ret = cppc_get_max_perf(policy->cpu, &perf);
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+	if (ret)
+		return ret;
+
+	/* Convert performance to frequency (kHz) for user */
+	return sysfs_emit(buf, "%u\n",
+			  cppc_perf_to_khz(&cpu_data->perf_caps, perf));
+}
+
+/**
+ * store_max_perf - Set maximum performance from frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer containing the frequency value
+ * @count: size of @buf
+ *
+ * Converts the user-provided frequency (kHz) to a performance value
+ * and writes it to the MAX_PERF register.
+ */
+static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
+			      size_t count)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int freq_khz;
+	u64 perf;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &freq_khz);
+	if (ret)
+		return ret;
+
+	/* Convert frequency (kHz) to performance value */
+	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
+
+	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
+	ret = cppc_cpufreq_set_max_perf(policy, perf);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 cpufreq_freq_attr_ro(freqdomain_cpus);
 cpufreq_freq_attr_rw(auto_select);
 cpufreq_freq_attr_rw(auto_act_window);
 cpufreq_freq_attr_rw(energy_performance_preference_val);
+cpufreq_freq_attr_rw(min_perf);
+cpufreq_freq_attr_rw(max_perf);
 
 static struct freq_attr *cppc_cpufreq_attr[] = {
 	&freqdomain_cpus,
 	&auto_select,
 	&auto_act_window,
 	&energy_performance_preference_val,
+	&min_perf,
+	&max_perf,
 	NULL,
 };
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 2860a0252313..a49b50bddaf9 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -173,6 +173,10 @@ extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, bool *enable);
 extern int cppc_set_auto_sel(int cpu, bool enable);
+extern int cppc_get_min_perf(int cpu, u64 *min_perf);
+extern int cppc_set_min_perf(int cpu, u32 min_perf);
+extern int cppc_get_max_perf(int cpu, u64 *max_perf);
+extern int cppc_set_max_perf(int cpu, u32 max_perf);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 extern int amd_detect_prefcore(bool *detected);
@@ -265,6 +269,22 @@ static inline int cppc_set_auto_sel(int cpu, bool enable)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_min_perf(int cpu, u64 *min_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_min_perf(int cpu, u32 min_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_get_max_perf(int cpu, u64 *max_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_max_perf(int cpu, u32 max_perf)
+{
+	return -EOPNOTSUPP;
+}
 static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 {
 	return -ENODEV;
-- 
2.34.1


