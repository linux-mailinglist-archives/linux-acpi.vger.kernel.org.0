Return-Path: <linux-acpi+bounces-15995-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F7CB32BE3
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 22:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61FA1B6844B
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE26D2ECD32;
	Sat, 23 Aug 2025 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZfWY78iE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BB82ECD13;
	Sat, 23 Aug 2025 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755979358; cv=fail; b=ntQjBpZTwD6RUVZzULLC3w+NshhdCf0sHepwKE72WnW9Cm4j0h7GhyUKXDWspIyNPsNFOHKy4gyqNBXUktXn6aSnrOsY0CqGbNPuWuqdWsd1DUbnTZZ59L9lPRbul2bPUrOWWsenGf2D5PlcK1Z0F35KUqAxmoMf7vj+uoP0J6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755979358; c=relaxed/simple;
	bh=bys7jP9kBNQ/Xl33WM+e09Wm5qArKv/zTcGXg3i+25M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpMhTHg4xnfdOHIUdWIV78zDlVUxlCdO9J8F1pnPmzq+hrF2JKCqQQK/HOGKiTckrfANxTNk6BY4FX1lZSuB+HrhvTZnq9/rtBusAF3GOLg5ZvCl3cLOQsy6phFoTC1oZaSLcQR6+UJhg0UMzLsqiRLaqb8lRGu+41DSkz5K2PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZfWY78iE; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEXBRMb8ss4j94rSs2uEzyo0o+AajZ826b0i4K7zrJgboWQZ3Mtyka9L+xYF/E/XylTIc24CRi7QVhkednezQXzQ84G2U4iswdt63DVIk8Hg5mtUUZf7l/C6MnqYUUAmVHKGh7KjAl8TjhkuxZ3AlqocAoinFUsOQNxf5XlVnYEYXLa9YT/FOOU0XOUTgDDVr5g+w409UgfDrkcMEmju4VjuSnVxpNvR+vpjIA6cl1ZInmK5zOTIVR7d9iC/znGuolJwQxHuOnJYRZY831eJkyRclAABavs6wfUq1T6oyZsj8zeZdp2DHUHhOF0nASINFvyfTeA39/q7lmEF51DcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvyM2/XY7tDrZepM5TZNgihqYtDCnnQ1vmkKX6xtC3s=;
 b=Fx09k8lss9rX1GYNL7+NrHrBm+xfMSkhCDuuomwdHesqdkUMQ05Vzeby6CU8jka+8FLrtmk7nhM9J4HsFyEv+5n5u8IXpRT0e3IXt3fC/MMOWIh8GKRsi4NoAG6CDD2PuX+OBqQ6uYy7Ygbqyx632d2HhATS16Ctb/eelS2WeCZvrOXPyC8WGfvq7LDQa+iKP4HWUbke/m3tzzBgsFSrBdo+I2k6saJf9xU6ACbE7KQyb+YYOuNOlxl56w1Tk/VzGce6omyNXdvUDpn0g7FPRt72zjXfMGMNEyECA5DaqT25kEOeyCW26XmDGzkM1WtF8uMFgaju2IweQxwxSK7E3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvyM2/XY7tDrZepM5TZNgihqYtDCnnQ1vmkKX6xtC3s=;
 b=ZfWY78iEqh3QIF7r0jTV5dyjK4QFVDGu4GkgdsUGUShZBtbjWM3eWIxs/pjkVFf8ncFlMMNxCSNYXf6L6NPT/L+6UiwyiLlPDILnOhLDcHnAP61oKI3gYKje1NCgrHC2CqY2Jng5WVgAMtDcSV0Lt6SIJwvZMxdNutjNhR8SLCpEFAKfPwGSPgN+LuXByvDFpVWpPaZhDMCd6MAQasOSXwT/3Eu3rOMw3LchMJEJQ8uH9LBUxGCjuVRMJMMqM0r8QeBbuwkZfTH2JoyzoRyAASg/i1rwKZH6ZsIQ8VMeFaM6qPoB1I4bHp2llA+4kdGTWZifCT8bsMu3x8CYHLIoPA==
Received: from SA1PR03CA0010.namprd03.prod.outlook.com (2603:10b6:806:2d3::26)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Sat, 23 Aug 2025 20:02:32 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::b1) by SA1PR03CA0010.outlook.office365.com
 (2603:10b6:806:2d3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 20:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 20:02:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:02:19 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:02:19 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 23 Aug 2025 13:02:13 -0700
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
Subject: [PATCH v2 5/7] cpufreq: CPPC: update policy min/max when toggling auto_select
Date: Sun, 24 Aug 2025 01:31:18 +0530
Message-ID: <20250823200121.1320197-6-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f59c1cf-18ca-4a48-ce35-08dde27fff22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SqgvuSq3gERFF8KxvYuzBcE2u5ZaSamLuQvYcDjt6ckxfrGnLxkmlNHrTavQ?=
 =?us-ascii?Q?MobkMppvKkIqR7OyKEyQHXocNls+Qz59Cgu8nUGE2vl70K1/fMczanF5VSJl?=
 =?us-ascii?Q?JEQ3OLvOaOqvyONaxwK9lNGt291sDszj9HzBiovQGnvAh7xfrTZkTPYTEFg8?=
 =?us-ascii?Q?r+SWBAj0vNwMnLO2cTcT1mm95huOz9/TBcTeTe69s6akII/OmoxxnlPNbUR7?=
 =?us-ascii?Q?HGd3F60NPCYAy6GeOswED9W/hd8Ynt/J1a9GOu1nPBE2jL8Yj7HAk9GCYz1Z?=
 =?us-ascii?Q?/Q18fDr74u86imWFKFMuIO6wzfsN8TtEP18Wluc5SKvgnq8TYqEnkdeUhTgI?=
 =?us-ascii?Q?Fr59pcWCnwQWgyBuzjxayBWakmwYluHoFc4Sdb/VTIuN5uWFzIyuwxWnrRYS?=
 =?us-ascii?Q?IMkDeAQHfg1x2FtM6E3uMMVnnA9pUTPYOsK1bdM+FYpCYmHG2ZSvGORo4O27?=
 =?us-ascii?Q?cMaskqzb2gUrVogotZYT2NAa8CSByn7rdCgfBp+oEOQBLOFSIZ1s3ia/ib2l?=
 =?us-ascii?Q?+JZD2HE35QdOLTpv+X9iG+phwFy3k0uBBa35T0VhaJp2+2RUiq8gNgE1eurW?=
 =?us-ascii?Q?i2SSLzEGnUmn0T7Z9O15SqCgffQf+8S7TbbPE1VJJ50YfIZdBKDTk3D7E7Hz?=
 =?us-ascii?Q?9hzyI72bkNjh6eM1IOCgnCcDV5nXsXm35O2+5DftYslFBoqq9mAPfWTmB4zD?=
 =?us-ascii?Q?CG64AZHo5GaqdVRGXcI+lj5Nlsr8QiJpoHrZujl/QWIa7xzqgcXzon3YaShF?=
 =?us-ascii?Q?B7GjYENudjV5traWTKpMwFQxkE00Z16zuQcpgCX5m9pck16VOMW4qWQCobES?=
 =?us-ascii?Q?S/rInENUlPTHenrCW0Hvs3PJsWVNiiRhLrQsG64QeWvnbALFo9bhceq5WDVn?=
 =?us-ascii?Q?/qXZGXom87iqM7icktIr7vzdb9XC+WXJyvoqt6KWYieJ2gavITPjGBmneO+q?=
 =?us-ascii?Q?GtIPzjJPUNzsgnFK9VbBeD6Sozn+VoVpbl2RsPU0HSE4rR09hLN924GhjoJq?=
 =?us-ascii?Q?T6x6BQn94nvJaCDQ/Z2DjXtQ/dEq0/MjjW/a2ZjGy7iH/yEd2oZViCbJDWJn?=
 =?us-ascii?Q?gazTlV8PNVPSxoUe+l0ca2aBgw8BrRhIGA819N+J/rxSr0v8psVzod1JXfzl?=
 =?us-ascii?Q?y8D3HpOhU7HRJeRip4ZXudEOyk/KO81Z3Ps6XDRkbxNl8G+qm6mo8VvyOF2W?=
 =?us-ascii?Q?+4CkL5qJvFywxWnBKi5qy3qURvtEcXa/x4TMyFWS+N0RMF3fZtMfCPS0If5q?=
 =?us-ascii?Q?KGi+rJM41FTQM7ndGa2JVBU3WZF0pEtjc24NHfd8PcGmI3wWpCO1myD/F1mo?=
 =?us-ascii?Q?HcZw4jpuIRVW+ZhtL6irju8orL4hfOkebz1YEcui7JUAW4axNEloYXX44azk?=
 =?us-ascii?Q?Cyg8kMwCw2/lxsUtXJowqVLo4/2CMliKGmobedDE/pWYHYAvk8aImy70Dnqv?=
 =?us-ascii?Q?71JW16RgnwQLuQKL6DXAd74lpA1pDfWyOQhonYg9+yItWYnFRuz0I4aVmW+0?=
 =?us-ascii?Q?h3hPFmTryUmxD2yVmCNBXTLG+j4sjKmBZkvkeR77hkFJj00uLqGF1jpthQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 20:02:32.4060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f59c1cf-18ca-4a48-ce35-08dde27fff22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012

When CPPC autonomous selection (auto_select) is enabled or disabled,
the policy min/max frequency limits should be updated appropriately to
reflect the new operating mode.

Currently, toggling auto_select only changes the hardware register but
doesn't update the cpufreq policy constraints, which can lead to
inconsistent behavior between the hardware state and the policy limits
visible to userspace and other kernel components.

When auto_select is enabled, preserve the current min/max performance
values to maintain user-configured limits. When disabled, the hardware
operates in a default mode where the OS directly controls performance,
so update the policy limits accordingly.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 47 ++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index d9aae1ec26e1..5e1bbb5f67b8 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -880,6 +880,10 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 static ssize_t store_auto_select(struct cpufreq_policy *policy,
 				 const char *buf, size_t count)
 {
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int cpu = policy->cpu;
+	bool update_reg = false;
+	u32 min_perf, max_perf;
 	bool val;
 	int ret;
 
@@ -887,9 +891,48 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
-	ret = cppc_set_auto_sel(policy->cpu, val);
-	if (ret)
+	mutex_lock(&cppc_cpufreq_update_autosel_config_lock);
+	if (val) {
+		/* Enabling auto_select: set current user-configured limits */
+		min_perf = cpu_data->perf_ctrls.min_perf;
+		max_perf = cpu_data->perf_ctrls.max_perf;
+		update_reg = true;
+	} else {
+		/*
+		 * Disabling auto_select: set defaults for OS control.
+		 * Use lowest_nonlinear_perf as minimum to avoid very low frequencies
+		 * and nominal_perf as maximum for balanced operation.
+		 */
+		min_perf = cpu_data->perf_caps.lowest_nonlinear_perf;
+		max_perf = cpu_data->perf_caps.nominal_perf;
+	}
+
+	ret = cppc_set_auto_sel(cpu, val);
+	if (ret) {
+		pr_warn("failed to set auto_sel for cpu:%d (%d)\n", cpu, ret);
+		mutex_unlock(&cppc_cpufreq_update_autosel_config_lock);
+		return ret;
+	}
+	cpu_data->perf_caps.auto_sel = val;
+	mutex_unlock(&cppc_cpufreq_update_autosel_config_lock);
+
+	/*
+	 * On enabling auto_select: set min/max_perf register and update policy.
+	 * On disabling auto_select: update only policy.
+	 */
+	ret = cppc_cpufreq_set_min_perf(policy, min_perf, update_reg, true);
+	if (ret) {
+		pr_warn("failed to %s update min policy for cpu:%d (%d)\n",
+			val > 0 ? "set min_perf and" : "", cpu, ret);
 		return ret;
+	}
+
+	ret = cppc_cpufreq_set_max_perf(policy, max_perf, update_reg, true);
+	if (ret) {
+		pr_warn("failed to %s update max policy for cpu:%d (%d)\n",
+			val > 0 ? "set max_perf and" : "", cpu, ret);
+		return ret;
+	}
 
 	return count;
 }
-- 
2.34.1


