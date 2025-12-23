Return-Path: <linux-acpi+bounces-19826-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94887CD9381
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 13:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DD483027585
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 12:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7BB3346B9;
	Tue, 23 Dec 2025 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UhQ7WzZ1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E632827D;
	Tue, 23 Dec 2025 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492125; cv=fail; b=qyEJG96LTfXNgK0VrO8Vi14RHM0QyyoFU/E4f9kB0oAa2k8p75sjhEdZanLJbISjo3RlS4gL5Fkynjr6W+pwkki5PscZc1C+7sYi2cDEPc912QqriE8u+ZqbBy4CNOrMjc2j/yUcB903t55nPFTyautVPoUUGq4R4RZlQqReJ4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492125; c=relaxed/simple;
	bh=DtJjOQ4nYqxkDJTvrGFeE+9ZOkBkpKo2cTbXRK4uSZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+B+ENwTXy31bd9disM1UOlpUD2RKlXxk15h3IFW3y+OhHMbA1vRzDTzNY58UO/fbHz+1T8I1USQIX0ik7aO7Sb9uRVcXbUKDk2LXoNcljFlQ+81xhWxroherYRYH2nH8ndCl/QVsYshy92seu6lT0p/NnV9VkH36wnJZPwEfoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UhQ7WzZ1; arc=fail smtp.client-ip=52.101.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXEHPlQNbbwqrvBRPUGvV97mZ+3Fv7x45WuA71V45lSqG0VVuDCjJJmpgH9Rg4HEwiFej1zY6REc1unniUvm6I6GqgSPlW/EMDbDJ2JhNFlhJ5MUrYaSnMfuYhVYfTpbPmtbIrilqKsHnSQQ1hoNAtrMmPiEqI9wt4vzVixbQ0wOdBpfcBBFMTfYpUe+RZ1Em6gvrMJDisVsXE1QOp0Adv8+sbeHoXwF7N+3wtSu3XjEcyoNnF2/A2mP5S9t+WOcvHC7HVKr4tqYFQqmCD6lFEf7eG3l8v5ub5U33k5gUoOcrF6RZSjWigt2pPwu6FHKUSO4NiREvbtrvWr8OlRVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc6pR+hLCr4FNbuTi0xCuzjZuNeWKYe560pw+1crU2w=;
 b=KqailBJNm/8fc87ehDGUq2dKmFtbhOgl6KJ9aeCYf8oI3pJAItoDbJm7J1pboQFAOD6TtttfcT58efj4NATlfCYHPfYWMKmQfsvgS+flDNnjTIpImo4ZmNeqwiHJYgYlmMMV6oKiWnr4UVH2sKldizkGqFuNgsHNaiM9cF7Pd0h5tWtBjD7ypFlDtD2H0sRtYvYu9rMMBNDbPoJasidkr50d6uWccwAgTPFmSbuUl7phyrylOb4Lhc0voNvEakvm8v1UrOvsIOdGaP5RPyQwedrMvLt9GsWDBtTFrcX8667dax9AVScMPF63FJaCnAW0cZj7a9L45smmXxoF6JVbgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc6pR+hLCr4FNbuTi0xCuzjZuNeWKYe560pw+1crU2w=;
 b=UhQ7WzZ1wVKOWyP0WNmW7Wm4H6CGyUPS7FcTzD5RzTYwym7k+Brkzn0ijvBs3pv/vbzcS18dPfdMsRCcV9EGlzpm/v+HWz4yIEV6EhBmG26pNJFFXCHQQmFEaHIKOQ/qXIEpB0rFrEFnTRXbv6re9hnG4lM4aeX/eF6SslqsWIkY3AZM/km/zs1IQbvbWMGh+zwyRO9yZf43FKHgvY5V2P675H0XyGSJSgQ1z/Fd56noGnYlqVRFCTZyYKsS3w/cWR1TvstSNcoDbT1moss1bWItWWyQ9sQbFrq5VnRmzv1DDZdWEjQ4NTDoNkXsNDgfT7CID+ge//Htmy1dg+XKKg==
Received: from DS7PR03CA0162.namprd03.prod.outlook.com (2603:10b6:5:3b2::17)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Tue, 23 Dec
 2025 12:15:19 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::e) by DS7PR03CA0162.outlook.office365.com
 (2603:10b6:5:3b2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Tue,
 23 Dec 2025 12:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 12:15:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:15:06 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:15:06 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 04:14:59 -0800
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
Subject: [PATCH v5 10/11] cpufreq: CPPC: make scaling_min/max_freq read-only when auto_sel enabled
Date: Tue, 23 Dec 2025 17:43:06 +0530
Message-ID: <20251223121307.711773-11-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: cf48e479-fd63-4c72-e46f-08de421cf057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SmxIot0XkDPZlzySF+8Y0YnN+Z+ryukxZe5/dLNWzBmhoOvshT+1l9fRhSW0?=
 =?us-ascii?Q?lG8JZJkyM20u6Uh0928Jid3VhsKELxGiNnHUC/luZRQbN6Gkq/qtxWLlGc3i?=
 =?us-ascii?Q?D5h4BU9xSNDQZT0+R7NEkCH0IhQ7mrhUKvEOTPZAidw5nU66+NyUjKGpjs6j?=
 =?us-ascii?Q?c6BN9Crd5lUt5JD+76xDkoAth3cT2Gynyl9yMrOK8fkhkdLTMuhk4FHdzWVi?=
 =?us-ascii?Q?Yexc60w2yH+V+XuBPZW5nuyOCmgaBpObUJFMvF25zFqDIs1H1KJgjNNwLqCU?=
 =?us-ascii?Q?FX0iP+cObJDcAGjLOlwF1H3vVbH+9nl+eMa15q09mqOJ+qChFigeWwS6vD2h?=
 =?us-ascii?Q?EF/errJM2V0clA5p4yu1DlBBOQOBxMpqbN1ZD2hCUUYn2wAuSzrSZAFsI7bm?=
 =?us-ascii?Q?hHweihb8gx2KIkGqv/ofGodl83D6/LcYH0uYYEobFjldJVakkwdu7NAxIQUa?=
 =?us-ascii?Q?zjyUb2ISUi6Uw/I2RRpdXDuI1NPutXRRXGFUDQljiAvD5RULFs2m3/XAVqWy?=
 =?us-ascii?Q?Zekdox9v23m6Kdbs+bpXw0P27OdCuMx8m3bTECB+ym1KFFh9ylueJSTPtUA5?=
 =?us-ascii?Q?IoAa1ObHsiMOr0yn+TZ8Z5dcRYJE9zKUPX5cljl8j7yEkVp+InTrdhXSjNRC?=
 =?us-ascii?Q?CwcifxFueiplH3mamrsigcEfVh1e5dfpgeQfkX4AU3DIYM/KlkHog/kTMnOe?=
 =?us-ascii?Q?L2mFGB5fSuFOtrw24DHgNfW4+nTbBZ/KilDRhtsGOlUpyMWGRKiG9DW5NBii?=
 =?us-ascii?Q?j/hOgf8bQklYP0AUM60dG/V0tgzf5dDKxvFYsnlVhr1Oqp7EFWZbvKHRYAG5?=
 =?us-ascii?Q?eMo0WmKh9K97bWrGsCG40hgvhDRS0ckL43KLMpvsRt7i0rBGtwqaoye0HOP8?=
 =?us-ascii?Q?PnOC30YZYUQUlXi1cOEcco6vm5+oT5Uxpk/rMOpRI5A5St3lfIIPQcUZ2Rgt?=
 =?us-ascii?Q?XPVQZxP1Cqrdh+WMOpNCsjsQSuMr42PZx6GxT3s/n1ZzsWoVOa+1oUJkliOk?=
 =?us-ascii?Q?Z+TyyT2YufW65edJ0El2q/jBB9H9AxE6JvTgB0dEp7NbxHRK8axHVAOrAveN?=
 =?us-ascii?Q?JPZ/mAtt996TLKqp7K4j5YZKkHLmngdGhd6uTz045SODi9ruMxuABvJKfvW5?=
 =?us-ascii?Q?2ztUHUdhb7MpANt/pZD6S/XCgHr+2KQittPiwAAT8duiTJgrN7cLlgOMhdER?=
 =?us-ascii?Q?TObB+KoAmUxR2QeHMDEGxxKUHU8ZPCgnp4aonsNgTv1VnVyqP2YYE3Tu8QVs?=
 =?us-ascii?Q?1L0//6LzxrVe2Io+EQoZFrtVQRFW6xkvPQedbR9855cI+eYI0p/J8r66Nrk3?=
 =?us-ascii?Q?LuuOflA+UDHn8sYlNuk1isyK6y8Dvrv1wmwHIL/k8LXnWNJnsXOPd3DREyBp?=
 =?us-ascii?Q?kKw/ALx2K4kV03pbfWz99CZuDUcg1J6ruPTJNlIYMv0lxNKV7VKfcxq87Xvq?=
 =?us-ascii?Q?1KXdmrDjzMepb7khixjJVfJ/kPbvcyX4SFTdh7eLSvi2O+OpqQEl7bDj+ijz?=
 =?us-ascii?Q?f35Vpt6xyJtpVlB/qSLmG1suIwAIY+smJgtYjyxylQrRddEnagoWZN40up5N?=
 =?us-ascii?Q?vETj30Ctd5NAOxKEQJKXQw1YssCh1xd5TH1i6+jT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 12:15:19.0934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf48e479-fd63-4c72-e46f-08de421cf057
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761

When autonomous selection (auto_sel) is enabled, the hardware controls
performance within min_perf/max_perf register bounds making the
scaling_min/max_freq effectively read-only.

Enforce this by setting policy limits to min/max_perf bounds in
cppc_verify_policy(). Users must use min_perf/max_perf sysfs interfaces
to change performance limits in autonomous mode.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b1f570d6de34..b3da263c18b0 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -305,7 +305,37 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
 
 static int cppc_verify_policy(struct cpufreq_policy_data *policy)
 {
-	cpufreq_verify_within_cpu_limits(policy);
+	unsigned int min_freq = policy->cpuinfo.min_freq;
+	unsigned int max_freq = policy->cpuinfo.max_freq;
+	struct cpufreq_policy *cpu_policy;
+	struct cppc_cpudata *cpu_data;
+	struct cppc_perf_caps *caps;
+
+	cpu_policy = cpufreq_cpu_get(policy->cpu);
+	if (!cpu_policy)
+		return -ENODEV;
+
+	cpu_data = cpu_policy->driver_data;
+	caps = &cpu_data->perf_caps;
+
+	if (cpu_data->perf_ctrls.auto_sel) {
+		u32 min_perf, max_perf;
+
+		/*
+		 * Set policy limits to HW min/max_perf bounds. In autonomous
+		 * mode, scaling_min/max_freq is effectively read-only.
+		 */
+		min_perf = cpu_data->perf_ctrls.min_perf ?:
+			   caps->lowest_nonlinear_perf;
+		max_perf = cpu_data->perf_ctrls.max_perf ?: caps->nominal_perf;
+
+		policy->min = cppc_perf_to_khz(caps, min_perf);
+		policy->max = cppc_perf_to_khz(caps, max_perf);
+	} else {
+		cpufreq_verify_within_limits(policy, min_freq, max_freq);
+	}
+
+	cpufreq_cpu_put(cpu_policy);
 	return 0;
 }
 
-- 
2.34.1


