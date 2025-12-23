Return-Path: <linux-acpi+bounces-19825-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68102CD9356
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 13:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56B0430329E8
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 12:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5363333B6E5;
	Tue, 23 Dec 2025 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cFOD2kpS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8D338925;
	Tue, 23 Dec 2025 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492114; cv=fail; b=F7XiQ1acTxNYIGwN5eqmVZTmCr5MDRrcz1l6xqtjCmIl3RMiU57o0QPf7puC3avYO2ERRlRm+ZO7k2vGtIRrYZzuGomD/YhR+XgZG6J++nT3jU3AfnQgvsYeZQA1+PBgbvGaNqgqMHkxKe17GFN9ZSjUPHhuEDolw16oMrzNyss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492114; c=relaxed/simple;
	bh=Mq0090VypYrNCoveLUnonXSbgQBzkp6V2UypJ7GAPtg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEH4pL5n8xYM3cvEauLbzPlm6qg2XijGTTp+6ZqSEv99sGCq21uWpHq8uF0MTsMtIutLpRJhP88kROkev4olng2t/2zj5fyAcXCS35a1Vv8k4/JmiYfelJc4U13n7Ri3SuxJloUrVuMjrQgeV3V2Tz8qt56X8vAFOBPCKIkOnCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cFOD2kpS; arc=fail smtp.client-ip=52.101.56.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8SwITT3ZuSVJjq9MWTW8nsPZCle7U6Efby1wZ5wowYExVWS+m2tm/cI4gBKig3o2K7T/+osZ0ZmYq4Q3l6O0s+KEsfRqUeZCweG5O8cG1JBr6V32mFQ4iLbwbROz2g7DkoPck68KEVTS5g4RIF4PVvnBJhV5nJHLgbis2Va83NgNcpVKuRV6JBzd5w9aTE5/47aJZ6iWxJ2xjRgCQcv4zeQkHdkPlXzr0olcvM2dFUvFTkXi9NA/RxTSk9fGkgrLwqDFryV9I7h/2mMobIDO3EJtYiELicB0Bi+7+bnW3nhl8J0x/F/6JeHOgMXJxMn26dprF/XZDSANrQx67d7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZt1BFpFuKzS++SiUMz9Xsp97XlHfnnqGxV31r5Rbf4=;
 b=FzL/uovk3lpNDIZ9mUjM01XqUvchB8QIKyIMx0IHQY2fcjY3qaCIUg8mKkvqINAtNjA1wAKFXZg12hPFwqwDUVLNZO/g3IeIzuXjNhCBQrt3+1Zm+3iyU2oT08dCQ74jbIyCjC0P0XK9R/LFJRJpljQD3gDeyD9wIEAW9LDLKetXC0dCZ5bqLnGOhtXZ9t28eX1zMWRfUFftX3glEP1YbCjFDeYHLC7yYMzX0rycAITb0Qr6mNvi6ntJelQpz3y4S7n7jj90K4diPa3YAD7Js8NKbDJ2tpUEHv3hzxMAe1wnH5xS3d/2z659Kt5Du6ZpeRpnAbm/sqhAGLl/ZabM2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZt1BFpFuKzS++SiUMz9Xsp97XlHfnnqGxV31r5Rbf4=;
 b=cFOD2kpSs9Y3KT51+ZZbUW3I5GxTPAUSRFNqWtuJ6mQEaT3MOqCYpLdg0F7EqsXJTlk8+2FHcnx6Yof4WdZJHWDNd2P7jluyp/ciJhgEad4qXakP34ZHISOvbA2maEsXRbRnk+UPk2X0y/aMKOB4eg3COI6Ww6hYzAJDAR+FVwUH4kGDsQvmm+pGnz9aakwWFTbdVDtcBimYyOhTMObDG1N50BplOqEUlU8HNLllZ2afy4/70qpOCmEz68Ba2m4NyWryGsualQyZtrF8x+KYE6Xt579rN0yq8htw867RupfYmoJDEUaExW4JHWFBoRMfo4sgqup4mTMmD2SP6K5QqQ==
Received: from CY5PR15CA0172.namprd15.prod.outlook.com (2603:10b6:930:81::15)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 12:15:02 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::95) by CY5PR15CA0172.outlook.office365.com
 (2603:10b6:930:81::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.10 via Frontend Transport; Tue,
 23 Dec 2025 12:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 12:15:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:14:51 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:14:50 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 04:14:43 -0800
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
Subject: [PATCH v5 09/11] cpufreq: CPPC: sync policy limits when toggling auto_select
Date: Tue, 23 Dec 2025 17:43:05 +0530
Message-ID: <20251223121307.711773-10-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e26f29-eff5-4ddf-b65c-08de421ce628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+GnMo7nsp7pGfWMOOTdKUGfKHVYwhLjKFz7msjYuj1N5zS8Wn0XnxpSkLV++?=
 =?us-ascii?Q?ECpqImUUG4Srka5HuLOZK3pSJ7/n7Ryysqf15m8ZjG59KFYvfZEVhbRLQAYi?=
 =?us-ascii?Q?zx3PXfeHeD24tOYH32NQxjryS50IC7l9hPRzFL3Ha7VfIcl/gg/e6y/Z3621?=
 =?us-ascii?Q?2RvzEuWguwgiS+MmTC4gS4FwFUFdt6cNQPQILi9JAGa0C/8DDG+0pjROPjQN?=
 =?us-ascii?Q?xyz9Wel2arYQVhg/Gw9echQNxnF2udRRn2mQaIMMnGA/PN8GU+bf3AHhUfoY?=
 =?us-ascii?Q?+nNWP3duVnKQ5uYmklFmMQXV6cEO7KPxM59SjEATcyyr73lAoEnl29p1a8Rt?=
 =?us-ascii?Q?PhahU5BZ3Cx8YJ3rQ57jeFFKDEZ2AlY0m/zCypNt0mceJ7X1cS6zPc6QlAoY?=
 =?us-ascii?Q?uNWpwkyQWlsnEKY6psgXlt58wLGVIxDpp9cxJbxA9OLTjFD0v8XRSa15AVBm?=
 =?us-ascii?Q?RZvaqvKqokKFkrpdADhLqofxbNG89paDtjbsjKSihtETUszfB3vPZiA7xyc7?=
 =?us-ascii?Q?Mf7VREe07aCX2RDSt8AbUpzDCEM3HgO/A7gVkc7aiaPLKiv7HaYdXKOeVVha?=
 =?us-ascii?Q?9z4hH8/mNm0rvTGibr70tSYrczMptE42CPrkBtKSYhtAahyaeTI3In/tt+j3?=
 =?us-ascii?Q?fhqM1quWhwsWyQuqDJ83ywdvrjfgzGMOqiOjlFxYezLzcQfVZeznFCFoq/6l?=
 =?us-ascii?Q?mZA09hKb9tCi+oC2rF8DuForPW3j/scWM2LbOkRn7+w+QusbV+unoxE8z3pQ?=
 =?us-ascii?Q?wBG4yUNjdQvZC5yvPoVBQZykGmypmTECoiDvUOpkjlc3EDwyeH2wD6oWnfXn?=
 =?us-ascii?Q?A0Eqx/dxNHBbWjVkJbMlwpTnU8LHiy969C/J1qiM4leovrCOT51DYWCahLfq?=
 =?us-ascii?Q?ra4kdbY2H/yIpjF3L9vOg9Q1QUe2RrhZwfQDwzup+gqe50eB7i4rrHpI71yu?=
 =?us-ascii?Q?prSNto9eUegKWwzWnq47aLOKws7kOEVpJ+Yj0BetKFsh5zhhPseekIjOskYL?=
 =?us-ascii?Q?fmB0DYthsRBhHz2K62+7++Z3EYTUs5bFkmJd14PHMFQvSvNegzR4UP9y61pZ?=
 =?us-ascii?Q?upd4E6tpGpUUih2sfxVzIrxsel1Zt8awB+9lwAW3v1iqpiWD+8EHABcj/0XT?=
 =?us-ascii?Q?7wFJTiwmdGIcljHCAh/5g6wpNet/weBTqlr8mk3jABn41zX/9Bq8Xa7fAAjw?=
 =?us-ascii?Q?y94osSwun5Bdx017Xc03X+1kNo9gelpIJWRGNdOVXhQK3U8uR1nho7L6PiaE?=
 =?us-ascii?Q?Cd6brRtXcLXmklYJFwWDxJFcjco6vUXTvvVS1QCJPxi2OF2/G9HyOPEKvkcP?=
 =?us-ascii?Q?TgGmvMgkFooQwyrtO2UBB8ivGZhgH7UKZAvrH8LDbP2KtGmx82YuTotvn8w1?=
 =?us-ascii?Q?//yodXwAuYclg88x5f07FHl7BQJ5IrjJig874x9KTCYAwZWoHnAq2eVQx9dx?=
 =?us-ascii?Q?8VW5vLXoRTq6ha/bYweN+3PGaO+RRYj2Gq6z1udcU4dZb49S9VcFG2HdPBn8?=
 =?us-ascii?Q?Mi3Cn5x9sWOOex/sCvkfDPc689nOp/GD2zg3/vHR7CnNFys/QhB3N3oBRWXa?=
 =?us-ascii?Q?KPCWiG1a0mvSSP7Z5xI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 12:15:02.0070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e26f29-eff5-4ddf-b65c-08de421ce628
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097

When CPPC autonomous selection (auto_select) is enabled or disabled,
the policy min/max frequency limits should be updated appropriately to
reflect the new operating mode.

Currently, toggling auto_select only changes the hardware register but
doesn't update the cpufreq policy constraints, which can lead to
inconsistent behavior between the hardware state and the policy limits
visible to userspace.

Add cppc_cpufreq_update_autosel_config() function to handle the
auto_select toggle by syncing min/max_perf values with policy
constraints. When enabling auto_sel, restore preserved min/max_perf
values to policy limits. When disabling, reset policy to defaults
while preserving hardware register values for later use.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 112 +++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 0202c7b823e6..b1f570d6de34 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -544,14 +544,20 @@ static void populate_efficiency_class(void)
  * cppc_cpufreq_set_mperf_limit - Set min/max performance limit
  * @policy: cpufreq policy
  * @val: performance value to set
+ * @update_reg: whether to update hardware register
  * @update_policy: whether to update policy constraints
  * @is_min: true for min_perf, false for max_perf
  *
+ * When @update_reg is true, writes to HW registers and preserves values.
  * When @update_policy is true, updates cpufreq policy frequency limits.
+ *
+ * @update_reg is false when disabling auto_sel to preserve HW values.
+ * The preserved value is used on next enabling of the autonomous mode.
  * @update_policy is false during cpu_init when policy isn't fully set up.
  */
 static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
-					bool update_policy, bool is_min)
+					bool update_reg, bool update_policy,
+					bool is_min)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
@@ -563,19 +569,22 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
 
 	perf = clamp(val, caps->lowest_perf, caps->highest_perf);
 
-	ret = is_min ? cppc_set_min_perf(cpu, perf) :
-		       cppc_set_max_perf(cpu, perf);
-	if (ret) {
-		if (ret != -EOPNOTSUPP)
-			pr_warn("Failed to set %s_perf (%llu) on CPU%d (%d)\n",
-				is_min ? "min" : "max", (u64)perf, cpu, ret);
-		return ret;
-	}
+	if (update_reg) {
+		ret = is_min ? cppc_set_min_perf(cpu, perf) :
+			       cppc_set_max_perf(cpu, perf);
+		if (ret) {
+			if (ret != -EOPNOTSUPP)
+				pr_warn("CPU%d: set %s_perf=%llu failed (%d)\n",
+					cpu, is_min ? "min" : "max",
+					(u64)perf, ret);
+			return ret;
+		}
 
-	if (is_min)
-		cpu_data->perf_ctrls.min_perf = perf;
-	else
-		cpu_data->perf_ctrls.max_perf = perf;
+		if (is_min)
+			cpu_data->perf_ctrls.min_perf = perf;
+		else
+			cpu_data->perf_ctrls.max_perf = perf;
+	}
 
 	if (update_policy) {
 		freq = cppc_perf_to_khz(caps, perf);
@@ -592,11 +601,74 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
 	return 0;
 }
 
-#define cppc_cpufreq_set_min_perf(policy, val, update_policy) \
-	cppc_cpufreq_set_mperf_limit(policy, val, update_policy, true)
+#define cppc_cpufreq_set_min_perf(policy, val, update_reg, update_policy)     \
+	cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy,  \
+				     true)
+
+#define cppc_cpufreq_set_max_perf(policy, val, update_reg, update_policy)     \
+	cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy,  \
+				     false)
+
+/**
+ * cppc_cpufreq_update_autosel_config - Update autonomous selection config
+ * @policy: cpufreq policy
+ * @is_auto_sel: enable/disable autonomous selection
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
+					      bool is_auto_sel)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u64 min_perf = caps->lowest_nonlinear_perf;
+	u64 max_perf = caps->nominal_perf;
+	unsigned int cpu = policy->cpu;
+	bool update_reg = is_auto_sel;
+	bool update_policy = true;
+	int ret;
+
+	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
+
+	if (is_auto_sel) {
+		/* Use preserved values if available, else use defaults */
+		if (cpu_data->perf_ctrls.min_perf)
+			min_perf = cpu_data->perf_ctrls.min_perf;
+		if (cpu_data->perf_ctrls.max_perf)
+			max_perf = cpu_data->perf_ctrls.max_perf;
+	}
+
+	/*
+	 * Set min/max performance and update policy constraints.
+	 *   When enabling: update both HW registers and policy.
+	 *   When disabling: update policy only, preserve HW registers.
+	 * Continue even if min/max are not supported, as EPP and autosel
+	 * might still be supported.
+	 */
+	ret = cppc_cpufreq_set_min_perf(policy, min_perf, update_reg,
+					update_policy);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
+	ret = cppc_cpufreq_set_max_perf(policy, max_perf, update_reg,
+					update_policy);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
+	/* Update auto_sel register */
+	ret = cppc_set_auto_sel(cpu, is_auto_sel);
+	if (ret && ret != -EOPNOTSUPP) {
+		pr_warn("Failed to set auto_sel=%d for CPU%d (%d)\n",
+			is_auto_sel, cpu, ret);
+		return ret;
+	}
+	if (!ret)
+		cpu_data->perf_ctrls.auto_sel = is_auto_sel;
+
+	return 0;
+}
+
 
-#define cppc_cpufreq_set_max_perf(policy, val, update_policy) \
-	cppc_cpufreq_set_mperf_limit(policy, val, update_policy, false)
 static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 {
 	struct cppc_cpudata *cpu_data;
@@ -889,7 +961,7 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
-	ret = cppc_set_auto_sel(policy->cpu, val);
+	ret = cppc_cpufreq_update_autosel_config(policy, val);
 	if (ret)
 		return ret;
 
@@ -1005,7 +1077,7 @@ static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf,
 	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
 
 	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
-	ret = cppc_cpufreq_set_min_perf(policy, perf,
+	ret = cppc_cpufreq_set_min_perf(policy, perf, true,
 					cpu_data->perf_ctrls.auto_sel);
 	if (ret)
 		return ret;
@@ -1063,7 +1135,7 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
 	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
 
 	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
-	ret = cppc_cpufreq_set_max_perf(policy, perf,
+	ret = cppc_cpufreq_set_max_perf(policy, perf, true,
 					cpu_data->perf_ctrls.auto_sel);
 	if (ret)
 		return ret;
-- 
2.34.1


