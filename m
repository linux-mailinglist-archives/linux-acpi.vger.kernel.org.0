Return-Path: <linux-acpi+bounces-19817-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBA2CD92FF
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 13:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A915301E5A0
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 12:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9AB331A40;
	Tue, 23 Dec 2025 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G4RVMQmz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE7E32ED4A;
	Tue, 23 Dec 2025 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492032; cv=fail; b=UD60H3dlYy940y3OOjdfd8SwL2AoK/ISagbtOZofkeNmROs7QXuSJa/ZzOlkWfoqyCZMbmZ2H4vnisk0IRhoPe2ygIG4YO++9Nkj5UaNzHmO6LftJm7PPXszawgTXx0bROQBsTfGhjDvGOuWWUoBNF/T0/k8YXnv6M64/M2uIok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492032; c=relaxed/simple;
	bh=SRYgLFoCnfWZmQxsfBMu0k+wYxbr39i8aU/BugfCsy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9M9mgFwWa8RXXsQ5tOEVq3gMR+ftznthclOKIFcT/yMRcvZmpkczMEx6xEKtw3ZgnROIhkPY+x+8TquhkVAlDd0H2qsLTfulwD1kL6hLyGXQAhNVDS37mPAdVh0cZli4145DreknEBE8k2h1vSQwkfrlp5trqkGKeEQ+2t3rDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G4RVMQmz; arc=fail smtp.client-ip=52.101.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeOJ+oMlS1zKo62Gj1TTj7xvk5Ry9n3FyeVxzprJLm/Ty3uMsw9U9kCf7OerescJDB9j7nhgLpyS1/7upek7FHLoltpGS/vyOCo0f9zTCRnCYCnvNw01SfRyHmoiU6v5pgfvi085IE1Ii+XfNF2pcCWUtJWgZ9qIfhH5FEq1rZFH+gqG6pmgi5AGELaSqbT0Lrlb9DMDPBSgf17cGl2q8KKzgT1hOq9fWTngzM+7WjdEuK2hQi6hdO2HWBhlBHhNmh5QHbYepWVeTzxD9eap+jKIGh9vdRLXcow1BsSps9xR5PsAEU3OnUXxz1qbiCfiuag00MkGk+HXsv58g3Zcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc4ivu+0y2mVMdduDtnz/2tNx0zq2Muw6kWpVOPPqss=;
 b=R9dZTYfZX2v6mvIveMybDF+SxtZeM5oX/Wi/e8UWcU3mXFpAztMLGnsdm8hRUZzID3IRe17hLo5yEB4U8gVa0zlSVYJZ4nilVb19euv+TlDWhiww7P4D3dAXDcgUtP0/pq1Pwi3m2b/cdzs5cbgdpB1A4fTdl9RWvcE0QpPJ12flolz/yTg8LjQ8ewlhGi1P7EsQbXLoXV4GwoOZYpng6DiftnlIhO+Jvqo9O1ku74KDiTPz7jWJOhXlJuGNOuoz6L4YbSrYsKkxj904WQmt8C6cryd3ZbQme/eIHLqtvKkVFEvdu5Hx1lxbawlHWQ7oMho+oO4sgJpPfrdQCT2PbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bc4ivu+0y2mVMdduDtnz/2tNx0zq2Muw6kWpVOPPqss=;
 b=G4RVMQmzKXxdZ6N0bc01XDoozm0c0k7JfRJErCM/dtf8i/YhE27YXpC+2m9/Z2YSqaU3kel9K27dujZUC4fEXpY8Id0RoVpHwIdjLc4hmHsWmu1IRQE7SFZJL+n22zl27MsnLBW20KaGQICIwtWALqHZlvuQxIE1bF7O/Nw4VZpZNzBGYupF2COsaiOQtjGOQk/kl1BvxYxAhb2T74dU5h7oYF3asgQMvZV5f+TMnvxgr7Np1Ad+ChJSPPSrAVmqK4XZMC6v13Rc5NWhTK++WaMzTLw2DYQ2sxdOHRsDwVf30BPUio9qRAQN3/AHztH4eB9mn875EA/xsNNNmy8UJA==
Received: from MN2PR16CA0063.namprd16.prod.outlook.com (2603:10b6:208:234::32)
 by IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 12:13:47 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::f0) by MN2PR16CA0063.outlook.office365.com
 (2603:10b6:208:234::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.10 via Frontend Transport; Tue,
 23 Dec 2025 12:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 12:13:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:13:28 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:13:27 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 04:13:20 -0800
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
Subject: [PATCH v5 01/11] cpufreq: CPPC: Add generic helpers for sysfs show/store
Date: Tue, 23 Dec 2025 17:42:57 +0530
Message-ID: <20251223121307.711773-2-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbfc1da-fd6c-412e-699e-08de421cb91c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GRFhkBwZkcvugumZgBPdsOnAI/k/DEZLCejbDfdmrt+o2ukJWmTIs8xIes/X?=
 =?us-ascii?Q?ub4OSQiJSr7VK+f6NrDKfIY1eQrXGfiUONiRPnt8m6fqcQDpsuBm1TmDt47V?=
 =?us-ascii?Q?je29sEzZz2pwMzanH35aiuzLze/1ZCUKS8vF17utkq19zoc/Jblm6szcGNm+?=
 =?us-ascii?Q?VRF6o0/k5hGPfIYmVagXIYerhmW+IDzeD126cM1b0PgWulRBckQraAfgpEBp?=
 =?us-ascii?Q?bg2QJy0nWZIYM/jPKDxI9x1wim3vfBvagvJDCk2/vZF3D9mmuNWkFrRywSfR?=
 =?us-ascii?Q?gC2lze74vGgyGQKN4Fj0bFgl6ZPtwW98efXqIcS2AjlOW/0Ou99guz8KGUmk?=
 =?us-ascii?Q?4Hqi9ET4TFY5EGffNB9IgZnE5dc3j0AAZ7hbAEgcwIJkXw99IY0cDF6FbWI5?=
 =?us-ascii?Q?4qqkNDvGu+snNMEIy5H3omoZsXvKEHcS7GDT6gVLafAPcULxU2QKjAYYyAcc?=
 =?us-ascii?Q?zypwmb5ry0usxi3Rwgal4N0Nl449KghI13Z/SXxTWDj0t46E334hwyQZwxTW?=
 =?us-ascii?Q?cKJ0rTMW/ZZQN7TD6769nEW32jxkiQBY4J0zJqo+qBpoZj+iiNnbUluQ/FM2?=
 =?us-ascii?Q?kti5w1JmMy75LxbS27MQuYkNzKxa/As8Yq4i34zlhanElnUKAgYBq8KjpCEW?=
 =?us-ascii?Q?iImMLJgzJQb7hxTLdlKQTedeXIEp6LObCyqiWbAbFW71EbxV6N2CD0dhQUKH?=
 =?us-ascii?Q?LwPHI1YOwkrmtMFPiqn+siCiCglfzhXbUYD39tOHaWZtYPhUf8LnCpnYKmCa?=
 =?us-ascii?Q?QSc21vYQ5X2t97yqbamqSdKKBrSvsOeG4zaco8laiI306/38g9EUe5+d88U1?=
 =?us-ascii?Q?wO2Audl5PPkIZimQKS6NC/Ljj0iyg7t4rZiTMpGTeipj/gyzicFct3OGDYam?=
 =?us-ascii?Q?InFpBmyhcYB61S1SNNBJdp8DCEm+hGycrgobAM0xFCOzRdKJUeM2ujHCeF/1?=
 =?us-ascii?Q?FBAjmAqBjkR/xjPwjIo3pHRBZh0umTa9pe3y0hUPY/aPd2OX5CsZTybkM8VR?=
 =?us-ascii?Q?5k7HZRMzX7GUdrz+cMveFYRVE6lqzShixG2gsKZ4S0n1qG0d4ezuboEEnFLW?=
 =?us-ascii?Q?kgugt8+e832bvkIzY8YkIQp7xrGWDoPmA8nwYjd5bWWAEJLmcW3Oo/g3dmvO?=
 =?us-ascii?Q?MfCLLnT3NT2OHwNkmHN0KPAKHyT/N7lqEgbeb0Sy9jhCfWcwcfTCN3Wja8zx?=
 =?us-ascii?Q?RGV5fBUzjo9KKdQYnT1ztzVYvk4bhPI975snCCdR1iqBtyBrHGnjB/qh/nlU?=
 =?us-ascii?Q?/p6/hmJHr+oXuKY0cyLcrqtJlObOiTM5ltgFFhaiDuCMVQABeeXKjcPopyNn?=
 =?us-ascii?Q?YqfoqeZ/LpM4fcY5jtwJSeDq5AqpqXe6UNjgrk1jtBM06Gi5XCjBIJdAinsZ?=
 =?us-ascii?Q?PdIKBvbz5fSKjJhCFvZwAxsUd5o7kizPMmOcIptpnnfTvuyvZA0vbnsVHV4L?=
 =?us-ascii?Q?FVxGgzR+1GaypgWnm636Gip/LppyPhyhxxfN5ZcI3S3o4eeUxc9BNar60yPv?=
 =?us-ascii?Q?xjGcmJ37+4KZFalwvJBIMevGSHeggO9xqVy+iAiaJrSotsljbCc852ZyPTg9?=
 =?us-ascii?Q?tHy23GLUuP0/HDYWq8HqAYPQ0tuCjdNTWFTZ/qPa?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 12:13:46.3576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbfc1da-fd6c-412e-699e-08de421cb91c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585

Add generic show/store helper functions for u64 sysfs attributes:
- cppc_cpufreq_sysfs_show_u64()
- cppc_cpufreq_sysfs_store_u64()

Refactor auto_act_window and energy_performance_preference_val
attributes to use these helpers, eliminating code duplication.

No functional changes.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 71 +++++++++++++++-------------------
 1 file changed, 31 insertions(+), 40 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 9eac77c4f294..7c26ce554e29 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -831,72 +831,63 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	return count;
 }
 
-static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
+static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu,
+					   int (*get_func)(int, u64 *),
+					   char *buf)
 {
 	u64 val;
-	int ret;
-
-	ret = cppc_get_auto_act_window(policy->cpu, &val);
+	int ret = get_func((int)cpu, &val);
 
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
+static ssize_t cppc_cpufreq_sysfs_store_u64(unsigned int cpu,
+					    int (*set_func)(int, u64),
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
-
-	if (ret)
-		return ret;
-
-	return sysfs_emit(buf, "%llu\n", val);
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu,
+					   cppc_get_auto_act_window, buf);
 }
 
-static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *policy,
-						       const char *buf, size_t count)
+static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
+				     const char *buf, size_t count)
 {
-	u64 val;
-	int ret;
-
-	ret = kstrtou64(buf, 0, &val);
-	if (ret)
-		return ret;
+	return cppc_cpufreq_sysfs_store_u64(policy->cpu,
+					    cppc_set_auto_act_window,
+					    buf, count);
+}
 
-	ret = cppc_set_epp(policy->cpu, val);
-	if (ret)
-		return ret;
+static ssize_t
+show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
+{
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_epp_perf, buf);
+}
 
-	return count;
+static ssize_t
+store_energy_performance_preference_val(struct cpufreq_policy *policy,
+					const char *buf, size_t count)
+{
+	return cppc_cpufreq_sysfs_store_u64(policy->cpu, cppc_set_epp,
+					    buf, count);
 }
 
 cpufreq_freq_attr_ro(freqdomain_cpus);
-- 
2.34.1


