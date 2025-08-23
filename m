Return-Path: <linux-acpi+bounces-15993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19369B32BDC
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 22:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954641BC8403
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 20:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8252EBBA2;
	Sat, 23 Aug 2025 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jHWyDldZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46462E972E;
	Sat, 23 Aug 2025 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755979343; cv=fail; b=g5M2cypN1iKDSlDh/pyMu8AdAUCL5FXmvHRGnIxcg02a2+0VVT2xZy3WvfXcbcOqjA/YYpYUVNCU5YEAsNdr81FOTa9rRxXkFA0If0a/B6Uy51EXRkjRcseSWB2/eOqs0NW1o08+vXAJnseFnN1Eyq5ONtHUoWlumVF9Fl7J29Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755979343; c=relaxed/simple;
	bh=o59yLV6I2TDaocEt6wD6CpWsnCSUWUfwKLIGhjYCQeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iczE7s7nVnRaumd4/rL+3XWl1aIajFcCDUd2plyKCCNna/XDBwBuoQ5AoZfRCEVvXMORmcUh4BeETYLel+1NAxZsOD49PZHErC5Eb2bwI9pMXzHPdIeFkNEt8vbbjLUCS68kPsS1p8Lck430dIGhBF5+7unAK+kbexMN+2KQB/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jHWyDldZ; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs6gG/xIamrDYbdh/9zmpv8P2L/0ssvGI53Y28b2kruCSSmvRlGNYK3Bqq9sgvEq8UDmRr6v3Q2HIRZazcL3/pRAa5BioqntvqZi5hlIk8E3hAJfHag/kLslEMNfK9ykA8Dsed4B+U5QaKzr325CNYXd9iTkcJ61I3NZN05Fq+pGsZWjDVBhsqRWTwc0x5LKNpRb6XeW8xd+Ew7zxSfeGqtohpPzTu7DEi7LjFSdaNL/2+rDoczYcV5FMepu6YTyuS8xipcg9SHNenZ4p52E1VC/tH38TgtguJeOmsUaqVdUNvpRo7GqRlgeS+Fis2pxbtspJcx3QMsc/2b6/3BAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gh55Wd8JohmRxj3sd1YSX3vrIyx3VaJxOQud9shr7w4=;
 b=eyqf+8rhfcwo1/ZaEXW4hUdOdWYbeKzXsWlFL+wBjK/PAAOR2CEy2sUhPDtNbohZ3loa4W8jJiKJ/i/qq84iltRMG4S9PcXFQGn2xdfAEYDaA7qDpgPdSVhrD4KqvKXIvZYjOAgPR9VStgIttTnUqsgDQ6NTTLVkKrQcSHjxiLPfrOiAKz/q8HPn2v9VzUmYILj4bRrqs4W2nPPGO5t+hdtqVla+FTNo+p6xIHNMhKyGJYifxj5w9C/ze0xyJd4DfFM6/mFEKmJnWN7EI8Iqg0BCibHzLYwk8oupt8kyhQjnbewssu92MGLBua0zELYtSZwfTWDnxYChsZ+t98gMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gh55Wd8JohmRxj3sd1YSX3vrIyx3VaJxOQud9shr7w4=;
 b=jHWyDldZNPLhZXqCyxeYO9jXh1yYDKEXxtL+bQqvMvBx8d2BmGGn9FK7mbHuWJ7UcqQBTmGfZAMlKR4rQJ+/S+QhRouoJhCS7AxEOzlYUeH3D+Hxm+s7wuBLlSUL4yPQcPrWAFOpKbMt5WNjpzMW4RMA243FCGhZeebEI2xv4jUYngGNQcvwJAkGhG6zsd3q7FjsZ/357kIUJsU7CWfP4bgXflUyRB8ew0KSzVCTFOX4iq53oebKEVGEm/Xa5ZjDG/NLeBSwxffjnBGDM2D5DyREvjwvByc47PuYjps7fQgRrmIXo/t3NPaQgjWyf0e+opbuocr3hX19m5dJdB+cZg==
Received: from BL1PR13CA0221.namprd13.prod.outlook.com (2603:10b6:208:2bf::16)
 by IA1PR12MB8224.namprd12.prod.outlook.com (2603:10b6:208:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sat, 23 Aug
 2025 20:02:15 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::85) by BL1PR13CA0221.outlook.office365.com
 (2603:10b6:208:2bf::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.10 via Frontend Transport; Sat,
 23 Aug 2025 20:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 20:02:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:02:03 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:02:02 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 23 Aug 2025 13:01:56 -0700
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
Subject: [PATCH v2 3/7] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
Date: Sun, 24 Aug 2025 01:31:16 +0530
Message-ID: <20250823200121.1320197-4-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|IA1PR12MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d8ddef-6aca-4ea6-3df0-08dde27ff419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+3fhYTTUPyeh7D2ltghZTCSN6TEigBpADU3n7ZnJXjYioRWeJOEi09AT8YPd?=
 =?us-ascii?Q?JhwHtKcE6JVvdeUZJYXtVfDwMFvrCvoXkYsytHtpqYQKAd8Cd878WY6J90Z2?=
 =?us-ascii?Q?I+tSYEZ6ydKZ/7RcB7rSYWt5v2NyZRMz42WMV4y9IvLjQIVXQyPtjXCLuFoz?=
 =?us-ascii?Q?E4QqhZcLeV2wM5Awk+/yjMozSeMUirsq4j/9kKcvM8Xb258z9AiYspDE7Rjv?=
 =?us-ascii?Q?vrR/h2bv7GjmnLXzDNP09BhVnYYIsSGFo5lF8M55/Yanhgmp/HI0jfXaERod?=
 =?us-ascii?Q?iIyAzdRfBnsaEwKR1dQbIyuw9JrRnFp4qRERUZtDdE8nqcW7DDpl9aKfzVGy?=
 =?us-ascii?Q?Rg2OHr2YGqWz209eLFS6CNRX3UztN/LXxsDiLteHr85rUDqjiHbhBFbPHKwx?=
 =?us-ascii?Q?tbqHN90smjwXEEHIZyeC36oye4rGzoLnjopaGhltgG+fUPGIYYvsDsrp0UEE?=
 =?us-ascii?Q?w6f4q1sgExsuCPc/hf/6HBEobTzRihLsADYe8nR9ZJmUTqToBafHDE1Y82QB?=
 =?us-ascii?Q?5bhFw1M/he/YHnrtdH8DG88gGY+uwgOLj4/pAFkBB78QYaie/w1Sx0cQ59jK?=
 =?us-ascii?Q?NM9XArMRzzXJ5K2d/Xl1xA1TEgIfcxDyrNXzMBWx5snqyzASVXa3npv/nAym?=
 =?us-ascii?Q?vS2m4TG2z+tsjo3NhlCR7zhtrXpKxn/i56gSJoQkhs9f5HU+5qIUkGMvWNtq?=
 =?us-ascii?Q?pCkmI1x/K+lWKWalI+xF1VIP21S4Uo7meYPXOdxiLQ9XdLQh4Eq7NMHOK7bZ?=
 =?us-ascii?Q?/QsVubOWnUd3N3rAtwYCEn8HCuMrRazZf7f6XpLUC2VfoS9+vD/JL9LWXCxa?=
 =?us-ascii?Q?IHcq9eGhMbB62q8XOzh5MtFX+3XCIu8tTNWA6P80qV8gEshYywBZWtaBf79R?=
 =?us-ascii?Q?0oK800Ygl/UitLtUREJPeGTxPzw0jvOs5OrUVN9Nvp20eL0bkFV2CAZltCK0?=
 =?us-ascii?Q?PI+70t+E+Pl5fCvGjgM6gigtbeWWDs75aXje4oYZ4tsP1Manwops8u8VDATY?=
 =?us-ascii?Q?SuxpQr6XN7O2C2cQBoct7SVc4XICDKCST6i7Vl7rbLjejlvB5TUbCd/kcm7T?=
 =?us-ascii?Q?EtqN7dwjE1TWgd5/5bdDzYDL3am1b11IlowgVMVV/toirDUfb/afAbxyc/KA?=
 =?us-ascii?Q?MBq+09d3cUv8dlwA1G2t3fVpVKWNp0bG7uSX41mDQTmRv7+vHNxazku+4967?=
 =?us-ascii?Q?Fbx9MYWfk97L8C4dTmAtGJs9ZCk8e/mGt/fmXzzJ8DkE6X1GPwIUalfTasW+?=
 =?us-ascii?Q?9GkXQlfxEO3kpaBfzxEy+yFH6xvuX5H8CRp9yc4DVMH4pHC0jFpB8KNoQ07d?=
 =?us-ascii?Q?DO4HnlqRA+LrGeYuVLLpssN6NQGCs8Z3w4jAluUKUJPlOCPJnx2CdfBQKPfk?=
 =?us-ascii?Q?CBF/n3USfimE+4No9JzmvSJd2faodi08CnXg4vcpv9VQ9qLNR4cioNVYzr4P?=
 =?us-ascii?Q?DFq5avlobX23jWT6ip90azJtvXyf0MsG6PcDLpDb0zgIP1SZHtx3yBGbp1rE?=
 =?us-ascii?Q?h2oOBZUT0NCi2kCPFt8ygrRhKZttWMU4qb9NKsdb02LyCWQu1AOLjpgPHg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 20:02:13.8153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d8ddef-6aca-4ea6-3df0-08dde27ff419
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8224

CPPC allows platforms to specify minimum and maximum performance
limits that constrain the operating range for CPU performance scaling
when Autonomous Selection is enabled. These limits can be dynamically
adjusted to implement power management policies or workload-specific
optimizations.

Add cppc_get_min_perf() and cppc_set_min_perf() functions to read and
write the MIN_PERF register, allowing dynamic adjustment of the minimum
performance floor.

Add cppc_get_max_perf() and cppc_set_max_perf() functions to read and
write the MAX_PERF register, enabling dynamic ceiling control for
maximum performance.

Expose these capabilities through cpufreq sysfs attributes:
- /sys/.../cpufreq/policy*/min_perf: Read/write min performance limit
- /sys/.../cpufreq/policy*/max_perf: Read/write max performance limit

Also update EPP constants for better clarity:
- Rename CPPC_ENERGY_PERF_MAX to CPPC_EPP_ENERGY_EFFICIENCY_PREF
- Add CPPC_EPP_PERFORMANCE_PREF for the performance-oriented setting

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       |  55 ++++++++++++-
 drivers/cpufreq/cppc_cpufreq.c | 142 +++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h       |  23 +++++-
 3 files changed, 218 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index fbcfbe4bcbf0..dd06bad26670 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1630,7 +1630,7 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_and_autosel);
  */
 int cppc_set_epp(int cpu, u64 epp_val)
 {
-	if (epp_val > CPPC_ENERGY_PERF_MAX)
+	if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
 		return -EINVAL;
 
 	return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
@@ -1753,6 +1753,59 @@ int cppc_set_enable(int cpu, bool enable)
 	return cppc_set_reg_val(cpu, ENABLE, enable);
 }
 EXPORT_SYMBOL_GPL(cppc_set_enable);
+
+/**
+ * cppc_get_min_perf - Get the min performance register value.
+ * @cpu: CPU from which to get min performance.
+ * @min_perf: Return address.
+ *
+ * Return: 0 for success, -EIO on register access failure, -EOPNOTSUPP if not supported.
+ */
+int cppc_get_min_perf(int cpu, u64 *min_perf)
+{
+	return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_get_min_perf);
+
+/**
+ * cppc_set_min_perf() - Write the min performance register.
+ * @cpu: CPU on which to write register.
+ * @min_perf: Value to write to the MIN_PERF register.
+ *
+ * Return: 0 for success, -EIO otherwise.
+ */
+int cppc_set_min_perf(int cpu, u64 min_perf)
+{
+	return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_set_min_perf);
+
+/**
+ * cppc_get_max_perf - Get the max performance register value.
+ * @cpu: CPU from which to get max performance.
+ * @max_perf: Return address.
+ *
+ * Return: 0 for success, -EIO on register access failure, -EOPNOTSUPP if not supported.
+ */
+int cppc_get_max_perf(int cpu, u64 *max_perf)
+{
+	return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_get_max_perf);
+
+/**
+ * cppc_set_max_perf() - Write the max performance register.
+ * @cpu: CPU on which to write register.
+ * @max_perf: Value to write to the MAX_PERF register.
+ *
+ * Return: 0 for success, -EIO otherwise.
+ */
+int cppc_set_max_perf(int cpu, u64 max_perf)
+{
+	return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_set_max_perf);
+
 /**
  * cppc_get_perf_ctrls - Get a CPU's performance controls.
  * @cpu: CPU for which to get performance controls.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index e4666836306d..0d3cfede5915 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -38,6 +38,8 @@ static enum {
 module_param(fie_disabled, int, 0444);
 MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");
 
+static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
+
 /* Frequency invariance support */
 struct cppc_freq_invariance {
 	int cpu;
@@ -572,6 +574,74 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
 	policy->driver_data = NULL;
 }
 
+static int cppc_cpufreq_set_min_perf(struct cpufreq_policy *policy, u64 val,
+				     bool update_reg, bool update_policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	unsigned int cpu = policy->cpu;
+	unsigned int min_freq;
+	u32 min_perf;
+	int ret;
+
+	mutex_lock(&cppc_cpufreq_update_autosel_config_lock);
+
+	min_perf = clamp(val, cpu_data->perf_caps.lowest_perf, cpu_data->perf_caps.highest_perf);
+	if (update_reg) {
+		ret = cppc_set_min_perf(policy->cpu, min_perf);
+		if (ret)
+			goto out;
+		cpu_data->perf_ctrls.min_perf = min_perf;
+	}
+
+	if (update_policy) {
+		min_freq = cppc_perf_to_khz(caps, min_perf);
+		ret = freq_qos_update_request(policy->min_freq_req, min_freq);
+		if (ret < 0)
+			pr_warn("Failed to update min freq constraint for CPU%d: %d\n", cpu, ret);
+		else
+			ret = 0;
+	}
+
+out:
+	mutex_unlock(&cppc_cpufreq_update_autosel_config_lock);
+	return (ret == -EOPNOTSUPP) ? 0 : ret;
+}
+
+static int cppc_cpufreq_set_max_perf(struct cpufreq_policy *policy, u64 val,
+				     bool update_reg, bool update_policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	unsigned int cpu = policy->cpu;
+	unsigned int max_freq;
+	u32 max_perf;
+	int ret;
+
+	mutex_lock(&cppc_cpufreq_update_autosel_config_lock);
+
+	max_perf = clamp(val, cpu_data->perf_caps.lowest_perf, cpu_data->perf_caps.highest_perf);
+	if (update_reg) {
+		ret = cppc_set_max_perf(policy->cpu, max_perf);
+		if (ret)
+			goto out;
+		cpu_data->perf_ctrls.max_perf = max_perf;
+	}
+
+	if (update_policy) {
+		max_freq = cppc_perf_to_khz(caps, max_perf);
+		ret = freq_qos_update_request(policy->max_freq_req, max_freq);
+		if (ret < 0)
+			pr_warn("Failed to update max freq constraint for CPU%d: %d\n", cpu, ret);
+		else
+			ret = 0;
+	}
+
+out:
+	mutex_unlock(&cppc_cpufreq_update_autosel_config_lock);
+	return (ret == -EOPNOTSUPP) ? 0 : ret;
+}
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
@@ -892,16 +962,88 @@ static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *po
 	return count;
 }
 
+static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
+{
+	u64 val;
+	int ret;
+
+	ret = cppc_get_min_perf(policy->cpu, &val);
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
+static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf, size_t count)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = cppc_cpufreq_set_min_perf(policy, val, true, cpu_data->perf_caps.auto_sel);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t show_max_perf(struct cpufreq_policy *policy, char *buf)
+{
+	u64 val;
+	int ret;
+
+	ret = cppc_get_max_perf(policy->cpu, &val);
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
+static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf, size_t count)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = cppc_cpufreq_set_max_perf(policy, val, true, cpu_data->perf_caps.auto_sel);
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
index 2f2dbeeced65..494cb3bd8eba 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -39,7 +39,8 @@
 /* CPPC_AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
 #define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
 
-#define CPPC_ENERGY_PERF_MAX	(0xFF)
+#define CPPC_EPP_PERFORMANCE_PREF		0x00
+#define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
 
 /* Each register has the folowing format. */
 struct cpc_reg {
@@ -172,6 +173,10 @@ extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, bool *enable);
 extern int cppc_set_auto_sel(int cpu, bool enable);
+extern int cppc_get_min_perf(int cpu, u64 *min_perf);
+extern int cppc_set_min_perf(int cpu, u64 min_perf);
+extern int cppc_get_max_perf(int cpu, u64 *max_perf);
+extern int cppc_set_max_perf(int cpu, u64 max_perf);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 extern int amd_detect_prefcore(bool *detected);
@@ -264,6 +269,22 @@ static inline int cppc_set_auto_sel(int cpu, bool enable)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_min_perf(int cpu, u64 *min_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_min_perf(int cpu, u64 min_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_get_max_perf(int cpu, u64 *max_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_max_perf(int cpu, u64 max_perf)
+{
+	return -EOPNOTSUPP;
+}
 static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 {
 	return -ENODEV;
-- 
2.34.1


