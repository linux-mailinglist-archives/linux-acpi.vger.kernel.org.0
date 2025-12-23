Return-Path: <linux-acpi+bounces-19824-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C477CD9347
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 13:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC61E3029C33
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 12:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B0A336EEE;
	Tue, 23 Dec 2025 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OFp+1Opq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54EC3346B2;
	Tue, 23 Dec 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492103; cv=fail; b=pKrdA7kDZZrVHqVeG4sDVJpSKvFa4XLJEZXPye3HsWckO9+FAGEOtpTnlJ45swSFx1Tty+fAmM+zBcwyQENd83VZbw5UdqfDarezk9CmfMAkBJ8nV55GEDaGW+Y8SpI9P3NM12kwjmHH5EqZaqw9DNk1kgEHRNtDSQ4naeoo64c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492103; c=relaxed/simple;
	bh=WdODi1WmSm+IR+zLFmF2KeN7sKDOqRbMiZPmc1Uj6Ps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/73Gt25ZGzSj5mLg1Z9/3r6aAIyCBFY0D79BnFhK/udizRfHIew/5FoJkQYWQbkt/hk+ho+UoKJzRm/fPHAHglxAc+1T+zi03xs/af2RxY6MdICE9axRXEpsbiGFHb915alVsGrxS8jCvphxNAoWzbBV0W6MBjCi+OuHZNbh44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OFp+1Opq; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcakTAFiSbZ01Bc1L7ObNLWMfjzPias6gWQ695LLUlQ1gGNMXvLt/Kyu9QoaEpmCP1lxxGCo2avMaxYg9e63DQh5qzPewy8yJbuRmEEQAWbg9mCwBmUjhli6+xkZAMR+79KUuYLBubnSuLGeqquWHcL/JchAVY25Sw0LA7HN9bTzoxTNpe0MwMD7wT+/BB1KnwHLC3oXxaJ2iFkXhGHz8+UHhJATgPO8rwrILg7UwdednGpqTpMV3810zTdx7MA39ngX41G0guj1BaPvNCgAlp/e7SrQU+gKymp1V1cgjNyDdQeQ/8EhFR1G+qcx1l70x1D57OUOS9jetVO5zvn9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=032Lch60KVpKRCrGtT/1AV+RLGA1Ep7c9DfWPKoA40w=;
 b=vEoQ5dCsp/rrr2NPviC5/aBdcF+Er4GAF3TpjBrSxgv5JnzdToJO35ewvRoGEH7iN55tbuhn8asixAHAw6E3MMqHwA9MV5AFlnUN4PZWmm+lPYGswDdYophFkq6do/6KYvHZ9K3tQIidW27DvI4lt+tv1lsa/jRSTVulsjzEl24e2z7uwDj6UonZRw0YJwJ04WJIoCfHavl4cCiOKmyHnSfcmfvPJYp8OaLAa66V4pck22lh+zDiCZwV7rLlq3DLGc+Zfc8deGmBTk/62gVtu/mF55LAsp7Yuu0IHvlWiFrmuaAPQDd0d7T1N8JisDOYH9ALdpXqmE+UaO+i54Qslg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=032Lch60KVpKRCrGtT/1AV+RLGA1Ep7c9DfWPKoA40w=;
 b=OFp+1OpqdrKUFV+wqh0yHC055vVAtUZdJJh8E5k2R8DY2Ej82/7/Z+ni59TTHtDVBR0dijsJhFfFymf+Xjdam0MjJn+Xn4D1znF7U+lfKBw2VzAbWw/OOYGUKGhCTyaKX5sDli7z/cMpoaAt8D3BmeFEuzRrAR4mMefo+vR7/9g0UeQTxg4s4bOmB2ZOSRzprMpqXLkEAGXmKfDhofvTJGY1FR/gtSl1cjP31043rCOB+wlJQ6klKdVhzQzRyGB/tWueN+/t6i/Y5sFXlBkgRHhn+60ppAGsj8vQqX0jvlS+LaS3DF7GrgQ5PCpd9nqFYBP+TTztzRmbqQEpwy41uw==
Received: from BLAPR03CA0173.namprd03.prod.outlook.com (2603:10b6:208:32f::35)
 by DS0PR12MB8479.namprd12.prod.outlook.com (2603:10b6:8:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 12:14:55 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::44) by BLAPR03CA0173.outlook.office365.com
 (2603:10b6:208:32f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Tue,
 23 Dec 2025 12:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 12:14:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:14:41 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:14:40 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 04:14:33 -0800
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
Subject: [PATCH v5 08/11] cpufreq: CPPC: sync policy limits when updating min/max_perf
Date: Tue, 23 Dec 2025 17:43:04 +0530
Message-ID: <20251223121307.711773-9-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DS0PR12MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 767b4306-eac8-4113-db47-08de421ce251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jScBhSt/YFn0tweJ6l/Zyl31psjp/JXgNxOE00QJB/7zuMGnkjvaDAAS/A0g?=
 =?us-ascii?Q?DPlEJaSC5JNKkkuj0XEk6RuBcdTFSB58i7gFCpmOkc0Pb0Yx0dIsoEe/XsEX?=
 =?us-ascii?Q?ziMUUa2C1DIN3qXlzuuUGf+tn3h2G2c8eHZuV48lZjCprM2oYgWRxwotvA5S?=
 =?us-ascii?Q?+Krt/E5ZgzEIYUGAqrGzWQMOtP94h+Do4odzQbglX5J1D4+IOTCtC+e4BVcL?=
 =?us-ascii?Q?k8aPnZZT7Xif9Pa4be2IkTiRU84PDXPnft4ehvRPOA+l3ZtqBUmvDqDXeZDZ?=
 =?us-ascii?Q?OSXYjcIST2GFPNSP+gPR6EvZDJZDMUC5avMXL8YQNylNCxYhikhNmnQGmm2P?=
 =?us-ascii?Q?1q+c0tNnT8iF0nPpgvc6zavYUa3POdL7z8qxI1ZhuXXPCGUsTQpJy4gtmrSu?=
 =?us-ascii?Q?zqOretkNoK4SV4J+NiASe8tDLhLt9WdwSVQ93WK3xHvL+IGALb5nbNSPId/F?=
 =?us-ascii?Q?zkGS/toyeCJIIBZWI8gV6sFyZhQTfZ+MRQx1MSdmu1eGZBM/LgR7geWpXst9?=
 =?us-ascii?Q?ktkS1xKF4e2NLdSZ+5mfJ/y6/O2qnjQTnTBfhLGDsQMujH3mRzOANMmDFqpf?=
 =?us-ascii?Q?oEFEa/MzYFC+lsOvNHBPFWrphwfauWH58SwYzUkAv9/G+umPR5H6iMpgNJx3?=
 =?us-ascii?Q?yy8NSZ/Ni7bWI8INBE1d+eeJ51oWTFNyRnnPqfz9q+VeZD54/orpMncRDPcr?=
 =?us-ascii?Q?uXixu7UBW2n7N62889gKPMrZcTd7GIA91RIdkTpq4hjklsCe9Sbd/YZ1/xW3?=
 =?us-ascii?Q?1YCLPH3NeO026kJEex36ad5SttO8FLKZDLApSrzHgqzoEDpDbk/VjD6suNUz?=
 =?us-ascii?Q?SgIYTflyyvY5WVqTT/CWFSxJyL8KCJ9w10wH7q+70BGa/iiZKAvfngPEnkCi?=
 =?us-ascii?Q?lkgYt3OcfIOBCRT8cVFXrho3JHqEyipxOv4vf4MzZlgR9LKarwI+B48TT/CO?=
 =?us-ascii?Q?aYUGfKXTLNIxOjrmkXiHoByGZ8bhx+R8pxtoAvsSss6CyQxank0NyiFjX8pH?=
 =?us-ascii?Q?6tgtUdcDyhlx9hIiuMKWRVFE6DyQOHFCt5bnYK/GSrjlKN8qg8lepOcVvQIB?=
 =?us-ascii?Q?lm8om12eFoc9Wc8A4N1O0pAU7WKIXQK4Ssyjmka5FOwxS31Ok81Nf3G9RkOf?=
 =?us-ascii?Q?LC9Exm5OiPf4SvQk5otGQnh0Ta8VtABS6i/QWkgWtKZSp0CXLgtBPDNOsqpy?=
 =?us-ascii?Q?Fe0CW8hNg7E+jE0az0RkQI6OD4zXaq6CypBLNcSN8ecPTbpV49nGYgSP7p+t?=
 =?us-ascii?Q?i4VrAMoHqv0JJdDg/JJn0FxGXoL6ktqhI6kGCOQCurFwe74vtwiyAUWbaK/y?=
 =?us-ascii?Q?k/PgjiEjpOu1cEexBqylZA/W/GDkXGenzIwWZr+oqb+TdndTRUV8tWyjsTqz?=
 =?us-ascii?Q?ODU4GwcaG+QQ+rJOWOL318wdkwH4PuzhZYOqKfCBc8/+abafvomfPfqtTi6x?=
 =?us-ascii?Q?vbgQwG5jOvoTJJak3YClRsTXINtdRmyNCKgwmSu7yxbo9ziNS3IbgpA0pQ5O?=
 =?us-ascii?Q?5yBMOoD5YT1lBg/X42RzsmEOsoxWzZ46riYpBoFFViqRAr7+6sUy8rcaDIzm?=
 =?us-ascii?Q?3YOjiolDQuDRJnE12rH0e5+ZnTVc9JAR+pNrce/3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 12:14:55.4786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 767b4306-eac8-4113-db47-08de421ce251
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8479

When min_perf or max_perf is updated via sysfs in autonomous mode, the
policy frequency limits should also be updated to reflect the new
performance bounds.

Add @update_policy parameter to cppc_cpufreq_set_mperf_limit() to
control whether policy constraints are synced with HW registers.
The policy is updated only when autonomous selection is enabled to
keep SW limits in sync with HW.

This ensures that scaling_min_freq and scaling_max_freq values remain
consistent with the actual min/max_perf register values when operating
in autonomous mode.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 35 ++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 1f8825006940..0202c7b823e6 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -544,14 +544,20 @@ static void populate_efficiency_class(void)
  * cppc_cpufreq_set_mperf_limit - Set min/max performance limit
  * @policy: cpufreq policy
  * @val: performance value to set
+ * @update_policy: whether to update policy constraints
  * @is_min: true for min_perf, false for max_perf
+ *
+ * When @update_policy is true, updates cpufreq policy frequency limits.
+ * @update_policy is false during cpu_init when policy isn't fully set up.
  */
 static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
-					bool is_min)
+					bool update_policy, bool is_min)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	unsigned int cpu = policy->cpu;
+	struct freq_qos_request *req;
+	unsigned int freq;
 	u32 perf;
 	int ret;
 
@@ -571,15 +577,26 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
 	else
 		cpu_data->perf_ctrls.max_perf = perf;
 
+	if (update_policy) {
+		freq = cppc_perf_to_khz(caps, perf);
+		req = is_min ? policy->min_freq_req : policy->max_freq_req;
+
+		ret = freq_qos_update_request(req, freq);
+		if (ret < 0) {
+			pr_warn("Failed to update %s_freq constraint for CPU%d: %d\n",
+				is_min ? "min" : "max", cpu, ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
-#define cppc_cpufreq_set_min_perf(policy, val) \
-	cppc_cpufreq_set_mperf_limit(policy, val, true)
-
-#define cppc_cpufreq_set_max_perf(policy, val) \
-	cppc_cpufreq_set_mperf_limit(policy, val, false)
+#define cppc_cpufreq_set_min_perf(policy, val, update_policy) \
+	cppc_cpufreq_set_mperf_limit(policy, val, update_policy, true)
 
+#define cppc_cpufreq_set_max_perf(policy, val, update_policy) \
+	cppc_cpufreq_set_mperf_limit(policy, val, update_policy, false)
 static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 {
 	struct cppc_cpudata *cpu_data;
@@ -988,7 +1005,8 @@ static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf,
 	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
 
 	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
-	ret = cppc_cpufreq_set_min_perf(policy, perf);
+	ret = cppc_cpufreq_set_min_perf(policy, perf,
+					cpu_data->perf_ctrls.auto_sel);
 	if (ret)
 		return ret;
 
@@ -1045,7 +1063,8 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
 	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
 
 	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
-	ret = cppc_cpufreq_set_max_perf(policy, perf);
+	ret = cppc_cpufreq_set_max_perf(policy, perf,
+					cpu_data->perf_ctrls.auto_sel);
 	if (ret)
 		return ret;
 
-- 
2.34.1


