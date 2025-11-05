Return-Path: <linux-acpi+bounces-18534-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D888C3565C
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 12:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EC8F4E11DC
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 11:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD6E310655;
	Wed,  5 Nov 2025 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eXoFdmDR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0313101AA;
	Wed,  5 Nov 2025 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342770; cv=fail; b=LSFbeESI7fOTOqghGjVhKywO2LCS9e+b4fsw6o3WjNA1YXM1rQdJrRAkKzCHLHbEDpi2nZw22aBe3oupUVav+BinAsfPV8LT9aDD9C4rt4PJhCgbcq4g+GsGuTMoLdCL+JzFbfcF4jaKGcc+nH/oFw9FI8/f/2MucjYpmYB1dCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342770; c=relaxed/simple;
	bh=+Tsm2cqUkUWRAPpC3PltALPXg6d3xJulsQCFund548A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4Q5Y6/Gfj02OHOva9bBCnavhP/azBkjLI/bk2lo/gQd9NESd4xYFdVRS5M5tzkAdoPWNcxXJaZjCofmkJZwdzsYy3X84J6qQu3yNu9elGgcOg67yrJoFN20/CTsQYTonexnYfu9Vz9+t8y6fF4giVXhc6a/1YeGqtYCCeoPDnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eXoFdmDR; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZByYeh4Rcj4Q9AK1MK259xOaDsC4UUD90cbVGIVmn23cZ+hytKpvQuQ9wYsQp0PMyVNUu7TU+3DYEAOvJl6cKnQqIpWFtq3Q70SsYV1x+frjAC5tdLYtfPE1eTuU3gYyHucle9jsSSSoCtmBLzETOgxWdathKUzhrhYRMJsJ3nvEs+PbQ45TrEYM7WjVUutinGNB1pLFCEj20onvsQeMwaLsfUOmsyM2jyp0BwEACljXC7atYtv6UVLmL5+AHfUs2dRUMRAckY2vA8byBs+KXSBr6WxArS8SCjcGdV86lIWwiMiabxflAejg4aECjx9feMOTd7iYQToshVLHqEDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AapsYuLtKjEA0dHyOwTWePsa3JKggILje8etQhzld70=;
 b=aSygnyKf1jLolx/dQrScuBp+vAN0pVS6hCRD/qMXpplmONDZjHXnFSuyGPmdK/LsEgwalPjfYBZeV7UVfafsN6His5pUHW/VrGAsXPwCfXror5rG9yyKXOq7Zt+zGPeZNJ0IJUKUcFzfhi3aZOoTxLSSW2Un0h6zxSWuX4fWccwYKt2vAGGfx/h5FDBjeXlR7Jgi0QIl2+g7EwUfzjD0RvelbBOAm1AX3n/P5rHAeLdvWUGpT9MS1ip7Y6To/5xYtTTa69ottt+RNSDrwCA6GSbtue7veFqcspiD2PURI9vy/99D9y/Vo90vJ7eABQP2y+3997ABDSTL4+TIWiZlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AapsYuLtKjEA0dHyOwTWePsa3JKggILje8etQhzld70=;
 b=eXoFdmDRBthSEn9Qcj1+LqGN6QLN7pdLURXxzyWS7XeZAhAa7ndc64Kee0SjknFlmkddjNnUfucFRAhDmWE90UqtIr1N13jeKG6W6evm70xb5BDGTjTmtN9c6suEN6SrnQUswI/tbib/sgXph38WLmXkXfJpOgpkcPX1ryp3o3IBotLNz1sXnhHmLL+tueUtDx2SqzEhY8kczQz2hD9Toud3SSqxhkbONMpsJJ4ErC0Y4eP+7s3Eo5aK87T1497fAWjO+ZsdFtFkmvZlrs9nkPprtf3JExQ+HI/nWgaxHKslxnQ52+rkpdb42g+4nTCxkt+oCdyqH8UD6qwVE0U8qQ==
Received: from BL6PEPF00013E11.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:17) by LV2PR12MB5920.namprd12.prod.outlook.com
 (2603:10b6:408:172::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 11:39:24 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2a01:111:f403:f901::5) by BL6PEPF00013E11.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 11:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 11:39:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:39:09 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:39:08 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 03:39:01 -0800
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
Subject: [PATCH v4 1/8] cpufreq: CPPC: Add generic helpers for sysfs show/store
Date: Wed, 5 Nov 2025 17:08:37 +0530
Message-ID: <20251105113844.4086250-2-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ad3138-4de3-4461-e6c0-08de1c5ff841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DY6OLlozP9Sn8esMkxvre83xYTSRPd3aeCrEC7VVH4eDOQTdugaYj69DdApO?=
 =?us-ascii?Q?U9g29vAKeImVPVt2EXlwhLtSj4SiBw4vd4p7nmsQ9PCczp/6ikj5qaMeb7P+?=
 =?us-ascii?Q?7c5rQi5aeQ0bS4H9kWjqpHES2ZeQDTlmpXn45uvGP3zLJI6J0bTtBq2JmmYf?=
 =?us-ascii?Q?r46jDYG1cq9Pawv8tRcQ0avSAnGzF5bkWI1ywh6LCrUTP2I3JWcY3x48ZJ1h?=
 =?us-ascii?Q?O1f4UJWMu/TjQQZXjgD0RPgFo87lQzqjXCjtl+kT+ZjRKwE0uKjFw4gBrqyg?=
 =?us-ascii?Q?E7VQ73fL2YtscOk127iMHNXn145WwZgdJx5ECaL2BMmMZ1FRYGShOe5DkOwO?=
 =?us-ascii?Q?87R1UZuAYU8dsnJfZomoJgJKJHlZ0LImDzAY7Tz8LZm5l45BXJap83NhHBz5?=
 =?us-ascii?Q?dygDfddpvs3hTPwPAGlrYrXMtGwHcybeEobeMHwcKG/OOLQZmHsnwVyWfS4j?=
 =?us-ascii?Q?fsmVbJaexGwqAAH0v+Qxq5ZuJAx4Y7O8NQiRwaTjdccteiSuYtYK6l93euqb?=
 =?us-ascii?Q?D69BIFL5NLbZxPdA7izMQz9zPDiI5DH3Lkx8jpZ6F1+KT/VgQ2J90xVm74mv?=
 =?us-ascii?Q?LeoaeRFw2KkHsnPgnYEj4v5LcFqkZw+IWwuhrCq1Fn6lathpW9zGmR255uw/?=
 =?us-ascii?Q?Qe56HVsJ5w/4DcF/uwmZl9HHzXncKPscWrsfTrcKR6Z8304q7YCs1LPj5rYv?=
 =?us-ascii?Q?89OLDwVLVx/qaVAnpux0KbB5GKnPSYB6UX25npX+C9Jc15TnZLY1Lj7+gxlw?=
 =?us-ascii?Q?Izk7wvP+/aAgHkO7u7Jdi9gzcpqUFg00OsoQIzeTH0XI8ab8X8DX3GZ7pzDz?=
 =?us-ascii?Q?23IgfcFYvwYqsJq9mQnfSZF8q0WxVyNJi1Q9SHjJARQJRDasHoNECVu/ld7D?=
 =?us-ascii?Q?U0ZyleDY69TjdjaJg7bTbwNAC4fcn75FtIOGEe2goDFv9Icm6EbDq0eJvMKV?=
 =?us-ascii?Q?Ms5Vfk3uftVe64EEIIsMZfVnSEzEnCbH4/nleYetgsoz4Ph59aAW+mC+JtGw?=
 =?us-ascii?Q?8LFc6cJesnXSas6pIPVxyOUAMNPxCd5u86ShbxQ38ZmTUW1ujpwj0DVux1x9?=
 =?us-ascii?Q?Kkwa6lXQNUQGig1W6EAlyd4PmcekXp45BXhWO4Nap2Gy+waW9Qm8Hajt6Nbp?=
 =?us-ascii?Q?5j7q4Wl4WeT9IWbVWXuajpYT4imsUNB07D/OzyIicds7UUS8pJjQ1vPLBiVA?=
 =?us-ascii?Q?rQ6zIoN1ZdNFulfmMpUhk8CIct10RcpOVIgW6OIOWe8G7iOWS0UUED3KKS/z?=
 =?us-ascii?Q?2M11uYCZ01qZfKJiw47Lhc6GE3sWcCnIaFZF1YWBfYwZOAPrH1Wi5sLMrGDD?=
 =?us-ascii?Q?24XN/8eFyz2vPf/u3SDUQQ1sA/nJm8E8BRhM7X/3BVpD6vr0JESUb4zig13U?=
 =?us-ascii?Q?GNsKrXLdqDsfHl+FxHW4yYIFwDeTFtbP2HCLdz1d04PjGxa1mWUo1R/5e1By?=
 =?us-ascii?Q?CYxd6cwmZg69JKb6WnRP8uQWsZEykqxPy9p1ZfsN/VSnuFqg+TtuJRaYO50Q?=
 =?us-ascii?Q?toWdk/+MTjAwkFD+7MBnKQ2LOpg5+DxAmrsOkHcMDcRGhHVDu8m5ibUpLI21?=
 =?us-ascii?Q?3RHrgLpDTqudKBTDOP26WT43uh3h5vx+F8IPbYTI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 11:39:24.3777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ad3138-4de3-4461-e6c0-08de1c5ff841
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920

Add generic show/store helper functions for u64 sysfs attributes:
- cppc_cpufreq_sysfs_show_u64()
- cppc_cpufreq_sysfs_store_u64()

Refactor auto_act_window and energy_performance_preference_val
attributes to use these helpers, eliminating code duplication.

No functional changes.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 57 ++++++++++++----------------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index e23d9abea135..cf3ed6489a4f 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -832,72 +832,53 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	return count;
 }
 
-static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
+static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu, int (*get_func)(int, u64 *), char *buf)
 {
 	u64 val;
-	int ret;
-
-	ret = cppc_get_auto_act_window(policy->cpu, &val);
+	int ret = get_func(cpu, &val);
 
-	/* show "<unsupported>" when this register is not supported by cpc */
 	if (ret == -EOPNOTSUPP)
 		return sysfs_emit(buf, "<unsupported>\n");
-
 	if (ret)
 		return ret;
 
 	return sysfs_emit(buf, "%llu\n", val);
 }
 
-static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
-				     const char *buf, size_t count)
+static ssize_t cppc_cpufreq_sysfs_store_u64(unsigned int cpu, int (*set_func)(int, u64),
+					    const char *buf, size_t count)
 {
-	u64 usec;
+	u64 val;
 	int ret;
 
-	ret = kstrtou64(buf, 0, &usec);
+	ret = kstrtou64(buf, 0, &val);
 	if (ret)
 		return ret;
 
-	ret = cppc_set_auto_act_window(policy->cpu, usec);
-	if (ret)
-		return ret;
+	ret = set_func((int)cpu, val);
 
-	return count;
+	return ret ? ret : count;
 }
 
-static ssize_t show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
+static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
 {
-	u64 val;
-	int ret;
-
-	ret = cppc_get_epp_perf(policy->cpu, &val);
-
-	/* show "<unsupported>" when this register is not supported by cpc */
-	if (ret == -EOPNOTSUPP)
-		return sysfs_emit(buf, "<unsupported>\n");
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_auto_act_window, buf);
+}
 
-	if (ret)
-		return ret;
+static ssize_t store_auto_act_window(struct cpufreq_policy *policy, const char *buf, size_t count)
+{
+	return cppc_cpufreq_sysfs_store_u64(policy->cpu, cppc_set_auto_act_window, buf, count);
+}
 
-	return sysfs_emit(buf, "%llu\n", val);
+static ssize_t show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
+{
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_epp_perf, buf);
 }
 
 static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *policy,
 						       const char *buf, size_t count)
 {
-	u64 val;
-	int ret;
-
-	ret = kstrtou64(buf, 0, &val);
-	if (ret)
-		return ret;
-
-	ret = cppc_set_epp(policy->cpu, val);
-	if (ret)
-		return ret;
-
-	return count;
+	return cppc_cpufreq_sysfs_store_u64(policy->cpu, cppc_set_epp, buf, count);
 }
 
 cpufreq_freq_attr_ro(freqdomain_cpus);
-- 
2.34.1


