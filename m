Return-Path: <linux-acpi+bounces-18538-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F66C356B0
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 12:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF92C4F59BC
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 11:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E916E312815;
	Wed,  5 Nov 2025 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VcFcYF4V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013008.outbound.protection.outlook.com [40.93.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF071312800;
	Wed,  5 Nov 2025 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342836; cv=fail; b=Mw+4DbgskUQacvwa79XKqzqVJFASjOwaBut6n+QhXwhEbWNc6n5u1nP92BEbpP0zX84KLHyE5nsEVASpuJ6E/2HNOY39Cj3ffJ5qzorRDvmHQqGJh4NEZBmzFBFoT00LyzMu1fV6btGEk3yuxfEJ4isRf3q+bV9Q6flYBtHU/2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342836; c=relaxed/simple;
	bh=EpiQytv+g0LOsBuMiiPv15ldpRua3dEQTCtNxjUU3u0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=un3f9eNsDB7rax0OGaTQxenkwgVhTgY9uVNii1kQLocJwntHMsmw5gkNJfpIVkFHcriGea+b//rauGcDupj7JVY53EN9f0P5BovdVQV8JW8fmiGEki6IJWk/esHMikdsn7TWxZxR4I8SqtgImksJgsl3sU0wL13M0NBcHn1Y+Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VcFcYF4V; arc=fail smtp.client-ip=40.93.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDUDc50DoM87CAKKjCgigTWwNLgJw99pN2+fLecLsDiLmVUH51DsNWdm2vlXLEf/cqaoXYIkewTALCNhjXds5jOm2Wp9rahuAq1WG96mqHl5xuf6gfX/Ot9FrsYFnuhYQag535LPWno7lWeIV76cWz0ZE3kTDeKSiiYdcsehGhS71oRJAqmmBax5iZjYNRFtUFZiBDYcBFwap8Aw96vUAMIT8mLHQ58f9i4X9q5IKjqOpR7Uqx9xliuKuYx//NSqB36cVZmkd5IqQwat11ziXjf6rtPOEYvTE2SrTVt7O4mH+QnXiHJL5nwDgu1qznrtgVgppDUP/tCkqoU42OPYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuxtpy3RqKlzVocwFv4y0csducYI3J6WaUUEZReXMks=;
 b=Q5ZsWqkSmaX10ADHUfqMN404wrHMlcCp6gh8LuevfrKLZhaVs8d5rLqkM4BKzgSoO47GKNzEAK+42hUMrDDnlW+v7m1NNcd42ZQbaGESbNYWeGCBdgOmMmoJIEMwTWNoKmibkf3JX2SmDPzvIA1ozt6jSxyBBBg+3JD3IDgj2FraJ0UYjA/q81V36ScX0tqTq7t/QCDZSJPOfE5+ZL+zs6VNEh3Nl3IOllds6y0sCRDgmOBYPO/VjdicuV27a6TbWlvlhZemDdKpvztVlRd814ax0du8EhB+qkIg4/VX/jV22nbbvbUcYIu0/nO4IiIpUpfl9r4AvFpW96nU1U89pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuxtpy3RqKlzVocwFv4y0csducYI3J6WaUUEZReXMks=;
 b=VcFcYF4V3cPkwUY2B6DQDyR+HAKpFSY8v+INuw+E+0cm+vOplKAluAtQJBQpzk0T/43A8SoP4ewjH4XkSYfCyMcjlkKpcxlyVNpXUbqop4QgCFsbauSGoNWdR5vR9AGNFCBQi+Z2xNikDconjbzgd54iiugSPCbIofZqMUuiiv1oJCQm//F834Z4C90LR7omzOZLYhdiM20L/U4gcgRDGq3IPwkRKtaGboXcTQg2PcahtJAp5SMxXrBBFmj2Qw2+Iqti62EgVBsfB26kzQhZ1NOWT9KlTKXDGXgBWSoc2qpzeUQsx1Suc7gM6JVYckOgW4WeY26z8Zl6FAvyWfvjBg==
Received: from BLAPR03CA0106.namprd03.prod.outlook.com (2603:10b6:208:32a::21)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 11:40:31 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::b0) by BLAPR03CA0106.outlook.office365.com
 (2603:10b6:208:32a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 11:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 11:40:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:40:11 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:40:11 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 03:40:04 -0800
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
Subject: [PATCH v4 5/8] ACPI: CPPC: add APIs and sysfs interface for perf_limited register
Date: Wed, 5 Nov 2025 17:08:41 +0530
Message-ID: <20251105113844.4086250-6-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: 59917347-9fa7-4d9a-49b5-08de1c60200b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gbPrJnjDEp8C8Ezwwr9ng/CM0iQ/ihjNHDahEafLxCBJqQl/1lJME3ujS+jj?=
 =?us-ascii?Q?RtPprW4yzkbHoTcO/TdSN0vrQc1YFiueydqIm04dG5+ARr7mt9+kYZWJCAmY?=
 =?us-ascii?Q?BY70bJKT2Ngl96aaPKQ0H9JlPPIIxHimKWDACGE1hUaWNs36QPOmkf9AZfem?=
 =?us-ascii?Q?MRDu/KVYFlWqPSa8G9JWf3fkOel1q/6oW9zVwYu5IIzkmIDmmwKXJT2tBfbA?=
 =?us-ascii?Q?nsuT4nxi0YOxTH6xCEEQvF9Q9canEmJOpquF4nAeS87LTeovRZQapuBLw44d?=
 =?us-ascii?Q?mBGFtdBSBNAyIPrhPcze0pz5xbGZ+JHNi3g38XJVMEu8YghadWeGVM3M4N9W?=
 =?us-ascii?Q?qKeTmfibthmGVg7ao4kpXcY92wMhcDZ7I3FQLd/A2g95VcBHyi4Xqet+0A9t?=
 =?us-ascii?Q?j5xHERdIwi+lBOMtuTKfy11EE1TXWugqONLV4qZ+zv8gP8ny2s24t4v8Guq6?=
 =?us-ascii?Q?2sLs75a6GayA7Tw/QgfJJb/ivLUNFvLVSyif+3QqCdAHGVYDnr0l8zrJ0v9c?=
 =?us-ascii?Q?O2zILaFmPhQjHGMvEt1BnVvKlxAweJEgcHGfCKbJuxm6pPIs6gqIJe1hTLvV?=
 =?us-ascii?Q?nQ5tlFDFFqmFsSupQji25f/oZIXTGKwpAFdFnMXAqW90b+BSYEbmGO1/Nd/j?=
 =?us-ascii?Q?0rqiz0lbDaEMlQCvR8r1v0jlBNhcQRf0NPemgv/lMCFRVehb1YiaKlzz+pok?=
 =?us-ascii?Q?/gzxnYdFlTKJ7zh/3rI5e2pZj6/mjAWCArDvwTxmpwyNi0msJtpDtmWUJ+7s?=
 =?us-ascii?Q?+o88jXPRC0SuVbqPS611FrtbIg0MUzugEB0CmYT5ymtIK/BohPhNh8dogRNx?=
 =?us-ascii?Q?S4hecuibrMnIEJnJCc0kDTWRV8SE5Lt9zt6nbp5L1F8oBq1HPi8jhh5IREXV?=
 =?us-ascii?Q?LYWTrtkLRCE0DnDEqntrAcqE/6KlWvH1+12EYXx5Ys6bYDdM/q1iUuWMCfWw?=
 =?us-ascii?Q?zM5LwalnFNiBXWVuRoBLZNtdul/Gc4J2QXxvF4W4+LVfd3eChE3Kawl9PFdb?=
 =?us-ascii?Q?NpGPhjjChDv060sIkrYQ1e2Iu5Q/fyieM1V9AkSyguJnw4ZIbVj6Vw80i6SP?=
 =?us-ascii?Q?/Wo1nm1EKaNvnOzEzgI+xq81a8wv6kW+CZATR0cGsWzs8NQC2Muz4sENqBCN?=
 =?us-ascii?Q?XXQtBDS8dc5Kngxn2+cZ+HKrM3yYQ//6GKFewl7pfNZMXluDHlIJQdiuTlwt?=
 =?us-ascii?Q?T2FepfjpUqwgymsalE0GIwIRPOG6ca1V7UG/8tZtEsAUUatxTQH3UC6ZT9eA?=
 =?us-ascii?Q?pNCXG2u1IRnN4Qi7JVmh2rgx/ZgdDPTOQdUCZMQrNHs0Vz4VJYvwVylOTDt7?=
 =?us-ascii?Q?Czf27a09YWoOtayR9Uv91eb3IVpgWOiEHi7Rlp6g027hpqf/0ovvJq9dA6qr?=
 =?us-ascii?Q?HM/3M951H2oM6SzbM52Npg3DnXMLhzEAzfbhl7QvwcZLrvv2l1B2qKufDGBv?=
 =?us-ascii?Q?0FszLIv8ufGdDdfcjzxMyPkTmIkIB4L5J63ejaMLX7k24T1cwgVN27hiJSnW?=
 =?us-ascii?Q?8vOWLmh3+K9sGMvQ7RXGxCYUZ4V9lCf1Nx9F5IjZg/A3rnlssUqKlOtoK9CA?=
 =?us-ascii?Q?ABZTzDthIH4cTtOlo+hABXka9clcNl6MJntlE9ud?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 11:40:31.1483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59917347-9fa7-4d9a-49b5-08de1c60200b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225

Add sysfs interface to read/write the Performance Limited register.

The Performance Limited register indicates to the OS that an
unpredictable event (like thermal throttling) has limited processor
performance. This register is sticky and remains set until reset or
OS clears it by writing 0.

The interface is exposed as:
 /sys/devices/system/cpu/cpuX/cpufreq/perf_limited

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 26 ++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 12 ++++++++++++
 include/acpi/cppc_acpi.h       | 10 ++++++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ef53eb8a1feb..9b8da3ef06db 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1810,6 +1810,32 @@ int cppc_set_max_perf(int cpu, u64 max_perf)
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
  * cppc_get_perf - Get a CPU's performance controls.
  * @cpu: CPU for which to get performance controls.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index cde6202e9c51..a425ad575aa6 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1043,12 +1043,23 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf, si
 	return count;
 }
 
+static ssize_t show_perf_limited(struct cpufreq_policy *policy, char *buf)
+{
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_perf_limited, buf);
+}
+
+static ssize_t store_perf_limited(struct cpufreq_policy *policy, const char *buf, size_t count)
+{
+	return cppc_cpufreq_sysfs_store_u64(policy->cpu, cppc_set_perf_limited, buf, count);
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
@@ -1057,6 +1068,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 	&energy_performance_preference_val,
 	&min_perf,
 	&max_perf,
+	&perf_limited,
 	NULL,
 };
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index be7de1222eee..8baff46f2ac7 100644
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


