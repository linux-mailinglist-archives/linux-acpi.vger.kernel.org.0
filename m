Return-Path: <linux-acpi+bounces-15994-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D462B32BD8
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 22:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5230BA23474
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 20:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE82EB876;
	Sat, 23 Aug 2025 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WcmCOmHi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32622EBBAF;
	Sat, 23 Aug 2025 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755979351; cv=fail; b=ilKO7nCEpqeS8iUXic7jufZa9j1cJ+eTcB27uzKk5HcKrU6M6WC/TIUC8W5JjcvmNLHfnAyKHZqSzp7htZAEiBGvmCOh3MwQECpO5ypMsQVhapCIu+wc1+tZXKz6Ltnfv4pTHxQqQwqZybi8DwaPR98qfbgEIj8FWO6VaGrzZTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755979351; c=relaxed/simple;
	bh=pUA67DlfwviXknnJvAjzCwzxggjg1/cgKI7IJzoy8QY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFEOiXjFWzvKKQBVg8xvfmxcHc5DOpkRkNphABJbHs4Ak8jzo71msPiQwdzEdfOBAaFEHatF72b4Ktq5VPFuYDM4U2N8nXxUcTMs1jIAlMyqed2IIjFl+dAFs+sdyirAYFFJj5ToblurQGV2gAt/sCZEIQ47WnehSWIbxBuBnaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WcmCOmHi; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1HmbllBiX9DEjbH3HuiGecSSUMei0yHLecPQxJzeScF3ORzbUnzfqd7oz8c1q6TmBzijn0iaMbBLuIgi616CZfxyQ9prlimy0rSxrGwAgwNaYeeBPPdsZpgNOoaJehrHbQF6San12f4b+8G96kqzBXP/DLcyeFfgdtOngKoWT8LPkZ+y2glbywfOQVOd7Eys3V/hl4zL9hGYus6QTH17dL9TIJFeNUp5EedXLLvNZmrI1KvoigNQPQRZqj8AUQnm/k5/GY9csSAtHNQBvVVEhvAf4l1y43jJSUs9e4YWH5KwCFuMjn0mh5D/dJ+FkdLivhuDKIG6ImdT4v/ytf0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3p5VFUoUhRNjnOsFAw51WGOaKW3AgQ9JENJJVxBwQ8w=;
 b=BT9mmsnqR6Qm/iq4+hAOYJ4j7RJpInmXiPnSTvAS1leiOK1qcdBRDeCmICu6Kpi+PvZUdbWD8K/TvJHxY022q+FYpA3obNhRKIVe6jzRXu3VZ4tCS6ymkhdLSJ5Q7YkAws5wSJd83zEZqfLz1jT53iFCG6sEP/LVHlSSdZQHAgLbDvRXyWPdRz2fuOeinew77nN2rrm3Vlrf216ubHFonbXALIfqPhfyOPps3ZcnG+73+jo9dr5cRsMsfBeV5UPggQQNNhHMIEcc2D1m6q//otcq72zvfiaC6GLbwsfZ/BbpN7LBfs5Qa1oHW9u3B4JJ3vz2OKxzutf5O+xmb+fD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p5VFUoUhRNjnOsFAw51WGOaKW3AgQ9JENJJVxBwQ8w=;
 b=WcmCOmHiGhSRJ79XvBor8NLVgDK81ZjCy0CkgHXy2EXpud7/WBGRPYnnE2DENwypRX0XCGwqWA4ek/cNj/77LWv2fDY/DD+ikbExnaHh4HZ5S2DqYfyi7w3YeMpiXrigThZr+3a+487zCDrMfs3SmXtRe/t9mbJQTFkSq2f7d+Debub0OQR5vlpDDlAx0alFwoJZQ3aHPTfhtjkAYsnAoPwOVEw7Jz8VoBRFMUFH+L8yNF18ESDXNE0lyxN9XkEerfsk1UR6B2LfD0Hu9zOzFNWsTR86yz8n+tyVguf94gh6Kt7sc27q3iqfgJPhS1V6KIMSg0cJthdDn+t4hdi3NQ==
Received: from SA0PR13CA0023.namprd13.prod.outlook.com (2603:10b6:806:130::28)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sat, 23 Aug
 2025 20:02:27 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::9) by SA0PR13CA0023.outlook.office365.com
 (2603:10b6:806:130::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11 via Frontend Transport; Sat,
 23 Aug 2025 20:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 20:02:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:02:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:02:10 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 23 Aug 2025 13:02:04 -0700
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
Subject: [PATCH v2 4/7] ACPI: CPPC: add APIs and sysfs interface for perf_limited register
Date: Sun, 24 Aug 2025 01:31:17 +0530
Message-ID: <20250823200121.1320197-5-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ece3634-3f39-45c1-4141-08dde27ffbc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GWl9rMmQNvBCeExsZt+1wrzNyndQZO+/Q+iQ7k0rDrdLyVN2wtoZlsWkYgub?=
 =?us-ascii?Q?S3B74NMc9+Cb06Qt7FHcJaj/aCyb7sgl4d/hv1pzX7hTIaFLborIuzeXB/Si?=
 =?us-ascii?Q?1hgXZMb4yfYJmbP5maX98W2eLqgLsXWiFG4RSKM+wUSkjwkv156APeX3xHqM?=
 =?us-ascii?Q?MN8s1ARHIPrLeCJ15eCPhMAycdod/bz0Ih5Td2r26KbbSNOiCCi5XASNXN99?=
 =?us-ascii?Q?J313pwLLg02AofSkEMYRpV1AuozGCShv6xBYcn+2RkuNhPGpHXnAwxdsirJn?=
 =?us-ascii?Q?XTpgvdaHAl2H3Vo8hRsQcgmuxrH7cxGU9f5VfFEYC0b2Tu1YYx0GA8FIrST/?=
 =?us-ascii?Q?tx91dWt9tpo2SGHOapUysWixUXs8FbBIFYIrAiWZiBG1cAj1SPMqwL5xiqoZ?=
 =?us-ascii?Q?gxCZDInPe8PoBXg1RXr5BC9lQe2A7YYODcRQK3OnVCU7EiKc2SDKzKsWkV2g?=
 =?us-ascii?Q?vzPIpbZNOlWTZH35RRPc7Iw6/nFC4vsK0MAvuO8RKl37ys+Fhywaaribbj0n?=
 =?us-ascii?Q?5CItA3PRDCQ5nBfAJyrH6PK9RAnk66uHVv/snby0RxCF3VdmQ3gj/Q5dJpHy?=
 =?us-ascii?Q?2LSe63o2fdhVPLc5np/G8LRl3kh/UArXsqNDfK3ujEGr4+xeg8IgCOZBRFS3?=
 =?us-ascii?Q?8tsN61BgFcBmVFk+gRJLbsVjJtFzxDsflD0ET3Jk9LtfoDF2VW3wuRBRwuDN?=
 =?us-ascii?Q?oPb12L5OW5JsVXmaMsf71g58yQvZky94ifJiCTE0VIaF/Ik5d6MH5jYgK7y2?=
 =?us-ascii?Q?WHTBAyBkzpbuSrL6jaurZvq7pnoGHvIqyhZbcLGJ0C78EJ20FySVKMJTXpfi?=
 =?us-ascii?Q?2TgF0yL1ck+UNIjR29Jc+ev5qv05YkcsJIRNWpoqZwFXB+DoihzZCa7twxJc?=
 =?us-ascii?Q?Hz9anyb1iPO2GT15Jh/5tYehf+fykYH5o2R0sSHs97p+sVdzSzR4hO94P65R?=
 =?us-ascii?Q?iGFldq0FhP3YTBW9DEbppjGnVx+o3A/BTSCbout6fximNQr7DCtBME4x6K6f?=
 =?us-ascii?Q?hdIOJuAYJ65iGU6ruyP7/UVH+9uWOm+BTnLp6U2/3BWDZkegeCcq/2A5cKcz?=
 =?us-ascii?Q?Gd5pFWPIlXRk+tSqmfido4/IvC7Rk+SUMcoN/9ZKYAMZlfn6CKy/STsjkYi/?=
 =?us-ascii?Q?FacxWv8KAOXH/PpMAP6/L61/uaJ77uo12OZx4cRHS3Z1YxQCiWxYrIahpuvF?=
 =?us-ascii?Q?FKZd+1gJ1iC1nuSW7hj++18auEZcFpwXcyfX0ADaEIHAM1W5zUHiUACcBpmR?=
 =?us-ascii?Q?9pvg8zM5pNK/V6679WAL920glLxTh4U6sH2RrHLOPCW1+Uep5JGz/wRK7Cg8?=
 =?us-ascii?Q?XQwfQ88nNwSmYoVnCCgcsMPM9mAtS10fH/shgjTQMEhhfWrqtrGfluZXMgfB?=
 =?us-ascii?Q?LCwsSXf0urN4GTGe7bcJpHoN6h5OBDQgHjxvLJXQV5L4MOSZH4HZhqTvw9Pt?=
 =?us-ascii?Q?Y1tkBTXomQulJ0scThGdLQAp4FX8v3jMSuL53RIlaNxjEGXzDFv5X7M6IdPe?=
 =?us-ascii?Q?MutecpWrqpnCs+mCb7OrXP9z0EqbBMmKW+MP/fslUPn3bEWQhWu1r6bb5g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 20:02:26.7472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ece3634-3f39-45c1-4141-08dde27ffbc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291

Add sysfs interface to read/write the Performance Limited register.

The Performance Limited register indicates to the OS that an
unpredictable event (like thermal throttling) has limited processor
performance. This register is sticky and remains set until reset or
OS clears it by writing 0.

The interface is exposed as:
 /sys/devices/system/cpu/cpuX/cpufreq/perf_limited

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 26 ++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 36 ++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h       | 10 ++++++++++
 3 files changed, 72 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index dd06bad26670..8cfed2d786ef 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1806,6 +1806,32 @@ int cppc_set_max_perf(int cpu, u64 max_perf)
 }
 EXPORT_SYMBOL_GPL(cppc_set_max_perf);
 
+/**
+ * cppc_get_perf_limited - Get the Performance Limited register value.
+ * @cpu: CPU from which to get Performance Limited register.
+ * @perf_limited: Pointer to store the Performance Limited value.
+ *
+ * Return: 0 for success, -EIO on register access failure, -EOPNOTSUPP if not supported.
+ */
+int cppc_get_perf_limited(int cpu, u64 *perf_limited)
+{
+	return cppc_get_reg_val(cpu, PERF_LIMITED, perf_limited);
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
+
+/**
+ * cppc_set_perf_limited() - Write the Performance Limited register.
+ * @cpu: CPU on which to write register.
+ * @perf_limited: Value to write to the perf_limited register.
+ *
+ * Return: 0 for success, -EIO on register access failure, -EOPNOTSUPP if not supported.
+ */
+int cppc_set_perf_limited(int cpu, u64 perf_limited)
+{
+	return cppc_set_reg_val(cpu, PERF_LIMITED, perf_limited);
+}
+EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
+
 /**
  * cppc_get_perf_ctrls - Get a CPU's performance controls.
  * @cpu: CPU for which to get performance controls.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 0d3cfede5915..d9aae1ec26e1 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1030,12 +1030,47 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf, si
 	return count;
 }
 
+static ssize_t show_perf_limited(struct cpufreq_policy *policy, char *buf)
+{
+	u64 val;
+	int ret;
+
+	ret = cppc_get_perf_limited(policy->cpu, &val);
+
+	/* show "<unsupported>" when this register is not supported by cpc */
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", val);
+}
+
+static ssize_t store_perf_limited(struct cpufreq_policy *policy,
+				  const char *buf, size_t count)
+{
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = cppc_set_perf_limited(policy->cpu, val);
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
 cpufreq_freq_attr_rw(min_perf);
 cpufreq_freq_attr_rw(max_perf);
+cpufreq_freq_attr_rw(perf_limited);
 
 static struct freq_attr *cppc_cpufreq_attr[] = {
 	&freqdomain_cpus,
@@ -1044,6 +1079,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 	&energy_performance_preference_val,
 	&min_perf,
 	&max_perf,
+	&perf_limited,
 	NULL,
 };
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 494cb3bd8eba..bdf8ce62338c 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -177,6 +177,8 @@ extern int cppc_get_min_perf(int cpu, u64 *min_perf);
 extern int cppc_set_min_perf(int cpu, u64 min_perf);
 extern int cppc_get_max_perf(int cpu, u64 *max_perf);
 extern int cppc_set_max_perf(int cpu, u64 max_perf);
+extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
+extern int cppc_set_perf_limited(int cpu, u64 perf_limited);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 extern int amd_detect_prefcore(bool *detected);
@@ -285,6 +287,14 @@ static inline int cppc_set_max_perf(int cpu, u64 max_perf)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_perf_limited(int cpu, u64 *perf_limited)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_perf_limited(int cpu, u64 perf_limited)
+{
+	return -EOPNOTSUPP;
+}
 static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 {
 	return -ENODEV;
-- 
2.34.1


