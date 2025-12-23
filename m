Return-Path: <linux-acpi+bounces-19822-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0D4CD9329
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 13:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC745302219D
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329FC33375A;
	Tue, 23 Dec 2025 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RT6ySCbF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449C0332EAC;
	Tue, 23 Dec 2025 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492084; cv=fail; b=Anu4OMIXaXRLmilGovnjytlqszC9bNoxACRESP3FrUS84RWBrQmwk/UiR4+o222HKzoD1wS4KD+sQq8Yf2Pcemw/tcS6C5HIvt0RIQBiKcGBWxKqWz0sUQ5pOHjB+I9O4wKiW16J1PkYqqv64yUmGK3ilh8Pjf+Ezcfkvy024os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492084; c=relaxed/simple;
	bh=JRZ68RueAFuQnYFf6E3XDll2T/neYGf+7ny+bg7YGdU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hH+Ft2w4sxUpYknBUSMZfUS0QciYvweRNCL+T9c9bjwCFfECwcxj6JiMHU3ANRN8aOllIKVv2jU5QqeUaLrRElspuhzKSdRw/oKX6qd86K5bnepj+w574cjdOVtHPKOMXufyK+mSq+1LScCLRes7sRSRXhHtFQMypBOXwXk1Ob4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RT6ySCbF; arc=fail smtp.client-ip=52.101.56.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEC2PFCAxBZVE19IXjzEVnhvPW+JA5kH6iLCyWeP/t46iF48tH6RQTPOQGAoMbGFTgx4oKPkLiJ+JfVyYXLMMFHsheeAmDfuS8velqMJiVE78bgfvZPYEzKCHXJ4LDm4E4JAVZEbYE4tgax0JWCK+NkghZgVDCuSc3IUUQTGXz9xeDCBnNpEE0pqzYCXu0RXj0XRsSMKvZc5fwNb80jEk/EEya32sfCJnw9WvI2/cVCJ0DdQ5AtMhYXg88/ZYOaUCEG33Z0Xel+3seNKZfPYyFua8fVpnSq+PnhxHjElQzCxm159qpliXtpGEduKVtr4DBnUc83L3mcGNU55FsuO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWpb7LQDzZCahscKXLyG+T/7DjUUqVakzKDNS2RWF20=;
 b=YalpOK0tBVBkM3wil0SzeCuzabSzrgtL+Z01rbOFwKwwWgQoItnVJG+7UJ+uyljrSi8Qac9d825vb7JNaSmE1FqNzcP0W0uGgWIWC3dPA7ALy6nZGNu3PUfvF7X91+k00VuwzTiYD3yvCGYWspzhEattukQXL7ZTwJkpC9wjfVjDBr1WAH43EliioL6H7VcWxyfW7YedQYrQPkDN2I0J2WG1BcjDTzsiV1HtihvwQjTqVfeywPL0OvofcojMjSiU2DfO526QQAlKrygHixEFABCjv3tIJWrzS03Ie0Jzokh/8MlM82DEumSlme7kSBCN6Zfjn13AQVbn79Vs4FQMLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWpb7LQDzZCahscKXLyG+T/7DjUUqVakzKDNS2RWF20=;
 b=RT6ySCbFQE+0pKtjPjur0EmzZfIWcUnVcotKLPNbIn8skjaBctKElyMzmZnkVTmNb/23gScOIhB3WAeobZKeZQcIfOToU79iTGPlUVOe/pv2A0qHFtILRDtg5qXWJlRI0h4XiWp1pHWzUkaqgtbRwBKKDqCFQoSZ2SMqR3obi7cYCt1wSnjfBFwP83uvh5+OqUhTVbPDl1sVoHZ5Ms8fkbJfhCdi4A84CEsgV7Erhj5rNTJ9rctY6MZnckuNAL6HyzixvUc4NIj20p816835aZBNquOKCzKDyvdOliJxJY604rZD0OVkRu7Rb/MCRoSIrEf/4pUhtGzWPQ2h8dD0zQ==
Received: from CYXP220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::17)
 by IA0PPFA19DE7612.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 12:14:34 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:ee:cafe::44) by CYXP220CA0009.outlook.office365.com
 (2603:10b6:930:ee::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Tue,
 23 Dec 2025 12:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 12:14:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:14:23 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:14:22 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 04:14:15 -0800
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
Subject: [PATCH v5 06/11] ACPI: CPPC: add APIs and sysfs interface for perf_limited
Date: Tue, 23 Dec 2025 17:43:02 +0530
Message-ID: <20251223121307.711773-7-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA0PPFA19DE7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f81dfc7-5ac5-4208-40cc-08de421cd598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2e1qzUwN1HUA6VcK+a6YoNdfTaPnpllgz2hT/zMrDnrscFt9SWrqMjDVRDkW?=
 =?us-ascii?Q?sraQhdjZvKK+xFHvLa/jjWAqz4ejR2azRof5jeaRbHVwS5MI06JXRtJJbAZ8?=
 =?us-ascii?Q?3SJTsMgSQVWKeFeXZ9y0SWUBtBz7wLQl6I6kUjz7/9/zcld345IJtamWSlQ9?=
 =?us-ascii?Q?KOU4CGQhwBiG324DtzjqJtAIGf9iLKa6J/aSp0nwyNd1Hj9UPj3PpeipEv8B?=
 =?us-ascii?Q?7z0bGkR9G3CPtCW81WAJAo/t0JRFtZ6VGMmTo+y/qunYCU1CHbPvEYapWSc8?=
 =?us-ascii?Q?ihm6YttQE8lgtfXWJt8axr/mHLloioqAo99HdKTdo1jmapPGOJBPGhX64kkd?=
 =?us-ascii?Q?HsG7dOw2sBxE1yfc6HmHIJM3x2Oofz7M103D1LMj2oD9Ggwo1Og6osOvJXSF?=
 =?us-ascii?Q?h40psVA93dNEUfEhifCpZPhiRwvYv8RegEiS3btRhOCO0SCRYW4bmPkT3BVR?=
 =?us-ascii?Q?J1noDp0NsumbsN/Z8NP69nzKfXn+VtG+cW19G1LmACSOLNAGx4/l+0ZAKMWv?=
 =?us-ascii?Q?EagwdP4ssXpKX0bbQ2+UtGTi+fmTJeCQmDjsVGF4eqafSQjV31AYMSuhq8xo?=
 =?us-ascii?Q?RZ+8QV+8tnim43576ta/Sb1FcpDs95QlmO5bbJpX3Jc6Rq6BKT7XyuIbC+LI?=
 =?us-ascii?Q?cbwLR0J8RNCDxdCraUdSLDHiXwLTQnFU22x9J3BRf9eWGPGI0nKfQEFRYqlS?=
 =?us-ascii?Q?41ADI6LEJDyAG9eP09+Z/Xt+TqpvkxvLtonvrLrHbvi17vDwog+A8ZJogVyM?=
 =?us-ascii?Q?ereQ0ok0rwLjy8pbMuPJcMx7kgn6x98RGfR/0zvqRcmyFWi8D47/YhmecVXp?=
 =?us-ascii?Q?1dGbeoketplb8NQROlycDPD3emHGZVcnHfGZZ3osdVYNWk7+SS13vmQosQci?=
 =?us-ascii?Q?017wxzhluO/GkZ+M8N4mA3RtJ83MTIGY43MsXlCe7NfFeJDFlv1A2g04+ToM?=
 =?us-ascii?Q?gQ9U7wFT4bJK7wHgKlWYHd3CK9AGXqoRP0J/nx1gt4y7ESkUsL7P4WKBMGbT?=
 =?us-ascii?Q?OWM72A1m9cB6MOAgBH3C1tG72rU7XuBGxxlBF8jrc7h9Nksw3XM3q9n4ZK2s?=
 =?us-ascii?Q?vIdhvFGmvJA78QcMxAVcIucQ1VIv51nUAsh1DNdo5SJEhfufEGnYUtmK+17i?=
 =?us-ascii?Q?qEehIBElRU8DMnmVylJjdIrmH54Xpk0VwzGFrhIJIbdWZoHknTwnFvxxQKJ5?=
 =?us-ascii?Q?1d8JM8/+2y6yl+4IQzcoM5UwIQb+qf2CEpEebuuEIdi6UCA8uRwksEKOQciI?=
 =?us-ascii?Q?/HYqyYy8xGiyA7lpVhsTDzYDzb87C7PrCEUdc7PeyuukBFQkbdvc/4GDtRDv?=
 =?us-ascii?Q?LFLXchMywoH70mKTnMRxDp7N29GQlofsVIqYNam2quHWlMT0/vdr/WJqGXu3?=
 =?us-ascii?Q?i4d6ZGadbFhPgZVP0DDoFgLbxvAeUcM+JRIhCIKu6GJkH1iIAXCGMxapK99t?=
 =?us-ascii?Q?RdWUZdF1wAvYR81MGekBoLfWqa+3yFZQ/MjTijNa12QctlfVDc8Pc2hH+6yL?=
 =?us-ascii?Q?qwnpgJpWebG8Ut56ZmyC485RnDxlNuN4C8bLpnNTqtlaSsO5lkDFAMTK1WjL?=
 =?us-ascii?Q?fxvaStSeaxtFFiGjPSOp/jQEUwuA1vRheApVef+y?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 12:14:34.2048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f81dfc7-5ac5-4208-40cc-08de421cd598
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA19DE7612

Add sysfs interface to read/write the Performance Limited register.

The Performance Limited register indicates to the OS that an
unpredictable event (like thermal throttling) has limited processor
performance. It contains two sticky bits set by the platform:
  - Bit 0 (Desired_Excursion): Set when delivered performance is
    constrained below desired performance. Not used when Autonomous
    Selection is enabled.
  - Bit 1 (Minimum_Excursion): Set when delivered performance is
    constrained below minimum performance.

These bits remain set until OSPM explicitly clears them. The write
operation accepts a bitmask of bits to clear:
  - Write 1 to clear bit 0
  - Write 2 to clear bit 1
  - Write 3 to clear both bits

This enables users to detect if platform throttling impacted a workload.
Users clear the register before execution, run the workload, then check
afterward - if set, hardware throttling occurred during that time window.

The interface is exposed as:
  /sys/devices/system/cpu/cpuX/cpufreq/perf_limited

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 56 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 31 +++++++++++++++++++
 include/acpi/cppc_acpi.h       | 15 +++++++++
 3 files changed, 102 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9f28c20d902d..ffd866c1c00d 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1786,6 +1786,62 @@ int cppc_set_max_perf(int cpu, u32 max_perf)
 }
 EXPORT_SYMBOL_GPL(cppc_set_max_perf);
 
+/**
+ * cppc_get_perf_limited - Get the Performance Limited register value.
+ * @cpu: CPU from which to get Performance Limited register.
+ * @perf_limited: Pointer to store the Performance Limited value.
+ *
+ * The returned value contains sticky status bits indicating platform-imposed
+ * performance limitations.
+ *
+ * Return: 0 for success, -EIO on failure, -EOPNOTSUPP if not supported.
+ */
+int cppc_get_perf_limited(int cpu, u64 *perf_limited)
+{
+	return cppc_get_reg_val(cpu, PERF_LIMITED, perf_limited);
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
+
+/**
+ * cppc_set_perf_limited() - Clear bits in the Performance Limited register.
+ * @cpu: CPU on which to write register.
+ * @bits_to_clear: Bitmask of bits to clear in the perf_limited register.
+ *
+ * The Performance Limited register contains two sticky bits set by platform:
+ *   - Bit 0 (Desired_Excursion): Set when delivered performance is constrained
+ *     below desired performance. Not used when Autonomous Selection is enabled.
+ *   - Bit 1 (Minimum_Excursion): Set when delivered performance is constrained
+ *     below minimum performance.
+ *
+ * These bits are sticky and remain set until OSPM explicitly clears them.
+ * This function only allows clearing bits (the platform sets them).
+ *
+ * Return: 0 for success, -EINVAL for invalid bits, -EIO on register
+ *         access failure, -EOPNOTSUPP if not supported.
+ */
+int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
+{
+	u64 current_val, new_val;
+	int ret;
+
+	/* Only bits 0 and 1 are valid */
+	if (bits_to_clear & ~CPPC_PERF_LIMITED_MASK)
+		return -EINVAL;
+
+	if (!bits_to_clear)
+		return 0;
+
+	ret = cppc_get_perf_limited(cpu, &current_val);
+	if (ret)
+		return ret;
+
+	/* Clear the specified bits */
+	new_val = current_val & ~bits_to_clear;
+
+	return cppc_set_reg_val(cpu, PERF_LIMITED, new_val);
+}
+EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
+
 /**
  * cppc_set_enable - Set to enable CPPC on the processor by writing the
  * Continuous Performance Control package EnableRegister field.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 1e282dfabc76..1f8825006940 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1052,12 +1052,42 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
 	return count;
 }
 
+/**
+ * show_perf_limited - Show Performance Limited register status
+ * @policy: cpufreq policy
+ * @buf: buffer to write the value to
+ *
+ * Read the Performance Limited register to check if platform throttling
+ * (thermal/power/current limits) occurred.
+ */
+static ssize_t show_perf_limited(struct cpufreq_policy *policy, char *buf)
+{
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu,
+					   cppc_get_perf_limited, buf);
+}
+
+/**
+ * store_perf_limited - Clear Performance Limited register bits
+ * @policy: cpufreq policy
+ * @buf: buffer containing the bitmask of bits to clear
+ * @count: number of bytes in buf
+ *
+ * Write 1 to clear bit 0, 2 to clear bit 1, or 3 to clear both.
+ */
+static ssize_t store_perf_limited(struct cpufreq_policy *policy,
+				  const char *buf, size_t count)
+{
+	return cppc_cpufreq_sysfs_store_u64(policy->cpu,
+					    cppc_set_perf_limited, buf, count);
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
@@ -1066,6 +1096,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 	&energy_performance_preference_val,
 	&min_perf,
 	&max_perf,
+	&perf_limited,
 	NULL,
 };
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index a49b50bddaf9..57e04326a4b6 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -42,6 +42,11 @@
 #define CPPC_EPP_PERFORMANCE_PREF		0x00
 #define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
 
+#define CPPC_PERF_LIMITED_DESIRED_EXCURSION	BIT(0)
+#define CPPC_PERF_LIMITED_MINIMUM_EXCURSION	BIT(1)
+#define CPPC_PERF_LIMITED_MASK		(CPPC_PERF_LIMITED_DESIRED_EXCURSION | \
+					 CPPC_PERF_LIMITED_MINIMUM_EXCURSION)
+
 /* Each register has the folowing format. */
 struct cpc_reg {
 	u8 descriptor;
@@ -177,6 +182,8 @@ extern int cppc_get_min_perf(int cpu, u64 *min_perf);
 extern int cppc_set_min_perf(int cpu, u32 min_perf);
 extern int cppc_get_max_perf(int cpu, u64 *max_perf);
 extern int cppc_set_max_perf(int cpu, u32 max_perf);
+extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
+extern int cppc_set_perf_limited(int cpu, u64 perf_limited);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 extern int amd_detect_prefcore(bool *detected);
@@ -285,6 +292,14 @@ static inline int cppc_set_max_perf(int cpu, u32 max_perf)
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


