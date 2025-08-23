Return-Path: <linux-acpi+bounces-15991-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E71FB32BCD
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 22:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFE41B63902
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 20:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1C2E9ED9;
	Sat, 23 Aug 2025 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aTVjRZJy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECFB1EF36B;
	Sat, 23 Aug 2025 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755979322; cv=fail; b=gygqoDKlYw9dapXpfbl4i5rfCsKFNp1mtrKDsXNQkPbybAQ66KkvA/X0jRzSGvyHzPyGU+QqMrJI/yG7jUlR+tC90ekubN8EsEWIZ/3jeptfbiPRBTMa2ScIZgsQDjB3pvCDmIBlh+l8LWHiUC5QGALjLwKTH+DKxiOkhaxutDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755979322; c=relaxed/simple;
	bh=XfxUg/yi2JEbUyavNj+cbV9nZ+X/7tvx7QuwKYPjCoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpjcScHE/n7c39s169p68T8+WewS6pXwdffAj/JWDsfEeNpQv/4cQxldMYTUmR7NbvYlIFLe1VhtfYVzlLdG+VTQ4P77VnfbP53hdRzq4vw9CQ5M04pGifx7FggNQCfSSMPZxjJZD5Nb665lUeibeS8r9T9QHxGXxU6H931Aizs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aTVjRZJy; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRrjUVFdqS5M8jMG8Fi8pO3jZzck6bcQTsUuHcF7IDpzGs71eKPljxJ4wpzewhqQFbZjISE9JqdQjM4TFqS0djsesIkwVraZya0oEi6yrysLQoKg3nwj6O3IubJMmpiCjSCeitd8oseUHODujHL7MzFdRfniEwU8W08zJL9qhdp5ee6rNM65RasBOXqBfGQGuzniDvTNIzAKvsI10BUTH58UKdErv8vKXsrltlj+4yVyciwvOwD5E1U5RN/T2kygKRWxAN4dLPh1Qv6EdPS1xUzC2mgELbZPpvjuziPBh7UeiBJi3PWBZgw+mxWkVHRsf2gGWiexQB5KYlXBjDH9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZD9KeqmZb9WS6UMqiZlnKTFewgxNNvvZkihMw+Q1cFA=;
 b=rG4eN+1q1jtsSwgvm1ocAgXhXmSMrGoKG3nejPmaEsPxm9cH9TzARcX27wwTKxlKqY4FbdLtlSsRWcrVCMZzECSxbN+JYmDI3CdoZBotV9ppRuI/76+G6bHgIdtGnFNLe/K3Gx+g3ibAv97uDrQZDNIDsPhQbhH+S6OcDPTcfeFyA4O7xQ7yuKzsgXHBimVsuMpnF6htm3LhHj2Ye9vjRnJk4wg726zzTz/kEabs+4rduep6CyDsR4Dlbm6s25K0DHWcSzMj9iFw66JPpERXHaxnQVr3K/il0v+oB/CetXssrsWSrwPe3sFOijehoY8QSiEqwkyKt7Mw4LbFGtPgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZD9KeqmZb9WS6UMqiZlnKTFewgxNNvvZkihMw+Q1cFA=;
 b=aTVjRZJyqPcbPnzx9P0c+OGu8KXKPLrsCqoEEt70ChLMfdYA7j8PzOmGduSUI2epL+Q7D4eyCP86j9m6dZVfORfsNTkh2rREA+jOgik9ka5xm14OhxHJ1kAmmJHEqSEQdJSFmq9FjNB/kAZqWtaIQq1qLtW8vwuBR66WaQpxC6mWHrt9Kq+DeW+iR7mfOrBI4rLursQmzgMpi9TpAJEHh+laqFa5fHcfXSfrWwUbYx5Ip6KgFZ7C2lQtzxxjMvIbGFJZLBZs+kAU2vRN3GXIqg1QYttAAEYOa96Df0s3SxKIgntYjYEQUq+HChnSCTJEk+RwZkNChoPOHNjOTi/hhQ==
Received: from SA1PR02CA0007.namprd02.prod.outlook.com (2603:10b6:806:2cf::18)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Sat, 23 Aug
 2025 20:01:52 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::3e) by SA1PR02CA0007.outlook.office365.com
 (2603:10b6:806:2cf::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 20:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 20:01:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:01:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:01:38 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 23 Aug 2025 13:01:32 -0700
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
Subject: [PATCH v2 1/7] ACPI: CPPC: add perf control read API and clarify naming
Date: Sun, 24 Aug 2025 01:31:14 +0530
Message-ID: <20250823200121.1320197-2-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c37024-0c51-4ae0-788a-08dde27fe756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ybZX3Vi9Z7ovRfDujFMNdsVOF6J97sH0sU9qUUwPW/PPXMxsK/FG6NFrGxby?=
 =?us-ascii?Q?eGezbpu0SKgEHkc63ydTasWOuAzN5LPU1Np7Zgxm/XrON323RNA2miSuBe/0?=
 =?us-ascii?Q?MmBU39K9FFLwu/hQiF7ucr5NIMK+/GUimkqWPmBx9vFX2B31fe2ekSV0JkZG?=
 =?us-ascii?Q?HzHn8+wmSCgLuZDXHjE2c/zH/2gNrbtLOIqHpLVlF96/5Aaa5CLchcSjoSW1?=
 =?us-ascii?Q?VfwwpVwc+Pr7jphx7KxnoCBX74cOa8NwK9oPG/8xTeiT7OdmdPBSe87uuRd0?=
 =?us-ascii?Q?wAtQlK7Ojil5GjXSVWdxakBvw9pCwKeKHBcrgVuClCj1rfcDnL2lP3oXoTei?=
 =?us-ascii?Q?FgolMU66xf6nvCYsY7YQUAIVqJO1CE6DyfbCEahYhd3Dmmv8n7/E/q5x3cgV?=
 =?us-ascii?Q?9aotezVz5BolKjYN6VMg/IzD3p9JbIoXhVyvfjWVGIneg+8oulNJee7t4wJI?=
 =?us-ascii?Q?378c+8Pknm9QfSEouqBoxpR3YoFJVdaPllRSvopY+e6mSDB4r8Hx1ehLLoty?=
 =?us-ascii?Q?oR/QOx+nCOwoXvRou+QL77HAycv4/PZcLraiFIYkI2YvrjQMUXPU2/J4VIsp?=
 =?us-ascii?Q?+SarPfvarOe/e+fmb1MFIjzm4jfpCuBFlpuJ24YR+AMm4vkZF3T4onz0UrzF?=
 =?us-ascii?Q?Nh38oEPoNIi06S76yPtb0AU5l9tt3FXcR1L0L/Ld7rdkf2NBwhpGhPPosDc8?=
 =?us-ascii?Q?iexsyOIxkbVdqhzCtRfBnBr4iuQ3p3nFE6Jvhp0mLNMfoerVCUtsuioFRZUX?=
 =?us-ascii?Q?jBMxqPwAUF39h8G80qvxX2jmZ+IYZjYmwPVuWNU6b9/lIo5VbV5qXMuBN74Z?=
 =?us-ascii?Q?plovWJtBC8msiH8uxt5AMgQHYstNbpUH5pkFH/XUNAhm+3uPBzZlNfkxcNT8?=
 =?us-ascii?Q?cOyFqzh/jyyiqRJRP/LVufb5MRJih/aREiOkN+ROSc9K8e+EhvJP8znCkETZ?=
 =?us-ascii?Q?ofWX89SMDyiYoqmmaCGtgPR1gY+WW8eoKdw3VXqRhV4Q0doxeubRG3bO7x08?=
 =?us-ascii?Q?14Q0rIvLcyWXCI9IsZ4rL1Tpak19APSR0thB85UhlHetUX3Mzg2ClvZ/20dY?=
 =?us-ascii?Q?AQQxe9OuyLcWIB7ZIc/s1aHYVUfVwB3i9LO5Wd2btjiLfbTVI5VagBc+PBRl?=
 =?us-ascii?Q?EpEo3X/O9w0tgkwy5KeZWfnl8XRu2Ccjtr752M1LwSA/EiZ0bGWYFN4oYnlQ?=
 =?us-ascii?Q?K2SgjPIlCUXbj+fMh2XhliOxp1+Yn3R1fmAFs8kL+/8LcgVQMY/F7g3ZY9Zx?=
 =?us-ascii?Q?ZmP+5mc40laSIRGGa4LuEPdyEs35HXgqj6d72S/9wlBB2kCUvfhxyKAjfBm0?=
 =?us-ascii?Q?KzdK8q2Avcvbj4UG6akM3gr/lEhtsArNvp/nnO3/AEBoif2DoIRIujHE2Qa4?=
 =?us-ascii?Q?6KH08WKu0kAfnlu71mQRWuxbhEbspnri0lUNvHA4jtQS1QMqUn4PEyrl4bT2?=
 =?us-ascii?Q?zr2yEHs4EoK7DfN81A7aY8wgYQC+EcnSv4eB5K01jerSIhG8084B1QOTiaTw?=
 =?us-ascii?Q?hTJnrPuCf00VrPvplW8jWzj8DlpfgNsJDr9sZOJ2k90l7vHW4lhdQ5G9HA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 20:01:52.2671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c37024-0c51-4ae0-788a-08dde27fe756
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758

Add cppc_get_perf_ctrls() to read performance control register values.
Rename existing APIs for clarity as:
- To distinguish between:
  - Feedback counters (fb_ctrs): Read-only performance monitoring data.
  - Performance controls (perf_ctrls): Read-write config registers.
- cppc_set_epp_perf() updates both EPP and Autonomous Selection.

API's renamed:
- cppc_set_perf() to cppc_set_perf_ctrls().
- cppc_get_perf_ctrs() to cppc_get_perf_fb_ctrs().
- cppc_get_perf_ctrs_sample() to cppc_get_perf_fb_ctrs_sample().
- cppc_set_epp_perf() to cppc_set_epp_and_autosel().

Remove redundant energy_perf field from 'struct cppc_perf_caps' since
the same information is available in 'struct cppc_perf_ctrls' which is
actively used.

All existing callers are updated to maintain compatibility.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 95 +++++++++++++++++++++++++++++-----
 drivers/cpufreq/amd-pstate.c   |  2 +-
 drivers/cpufreq/cppc_cpufreq.c | 26 +++++-----
 include/acpi/cppc_acpi.h       | 18 ++++---
 4 files changed, 106 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 6b649031808f..24baaa298af3 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -58,7 +58,7 @@ struct cppc_pcc_data {
 	/*
 	 * Lock to provide controlled access to the PCC channel.
 	 *
-	 * For performance critical usecases(currently cppc_set_perf)
+	 * For performance critical usecases(currently cppc_set_perf_ctrls)
 	 *	We need to take read_lock and check if channel belongs to OSPM
 	 * before reading or writing to PCC subspace
 	 *	We need to take write_lock before transferring the channel
@@ -182,8 +182,8 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
 
-show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
-show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
+show_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, reference_perf);
+show_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
 /* Check for valid access_width, otherwise, fallback to using bit_width */
 #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
@@ -202,7 +202,7 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj,
 	struct cppc_perf_fb_ctrs fb_ctrs = {0};
 	int ret;
 
-	ret = cppc_get_perf_ctrs(cpc_ptr->cpu_id, &fb_ctrs);
+	ret = cppc_get_perf_fb_ctrs(cpc_ptr->cpu_id, &fb_ctrs);
 	if (ret)
 		return ret;
 
@@ -1427,7 +1427,7 @@ EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
  *
  * CPPC has flexibility about how CPU performance counters are accessed.
  * One of the choices is PCC regions, which can have a high access latency. This
- * routine allows callers of cppc_get_perf_ctrs() to know this ahead of time.
+ * routine allows callers of cppc_get_perf_fb_ctrs() to know this ahead of time.
  *
  * Return: true if any of the counters are in PCC regions, false otherwise
  */
@@ -1465,13 +1465,13 @@ bool cppc_perf_ctrs_in_pcc(void)
 EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
 
 /**
- * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
+ * cppc_get_perf_fb_ctrs - Read a CPU's performance feedback counters.
  * @cpunum: CPU from which to read counters.
  * @perf_fb_ctrs: ptr to cppc_perf_fb_ctrs. See cppc_acpi.h
  *
  * Return: 0 for success with perf_fb_ctrs populated else -ERRNO.
  */
-int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
+int cppc_get_perf_fb_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
 	struct cpc_register_resource *delivered_reg, *reference_reg,
@@ -1542,13 +1542,13 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 		up_write(&pcc_ss_data->pcc_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
+EXPORT_SYMBOL_GPL(cppc_get_perf_fb_ctrs);
 
 /*
  * Set Energy Performance Preference Register value through
  * Performance Controls Interface
  */
-int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
+int cppc_set_epp_and_autosel(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 {
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_register_resource *epp_set_reg;
@@ -1599,7 +1599,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
+EXPORT_SYMBOL_GPL(cppc_set_epp_and_autosel);
 
 /**
  * cppc_set_epp() - Write the EPP register.
@@ -1731,15 +1731,82 @@ int cppc_set_enable(int cpu, bool enable)
 	return cppc_set_reg_val(cpu, ENABLE, enable);
 }
 EXPORT_SYMBOL_GPL(cppc_set_enable);
+/**
+ * cppc_get_perf_ctrls - Get a CPU's performance controls.
+ * @cpu: CPU for which to get performance controls.
+ * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
+ *
+ * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
+ */
+int cppc_get_perf_ctrls(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *desired_perf_reg, *min_perf_reg, *max_perf_reg,
+				     *energy_perf_reg;
+	u64 max, min, desired_perf, energy_perf;
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int ret = 0, regs_in_pcc = 0;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -ENODEV;
+	}
+
+	desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
+	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
+	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
+	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
+
+	/* Are any of the regs PCC ?*/
+	if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
+	    CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg)) {
+		if (pcc_ss_id < 0) {
+			pr_debug("Invalid pcc_ss_id\n");
+			return -ENODEV;
+		}
+		pcc_ss_data = pcc_data[pcc_ss_id];
+		regs_in_pcc = 1;
+		down_write(&pcc_ss_data->pcc_lock);
+		/* Ring doorbell once to update PCC subspace */
+		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
+			ret = -EIO;
+			goto out_err;
+		}
+	}
+
+	/* Read optional elements if present */
+	if (CPC_SUPPORTED(max_perf_reg))
+		cpc_read(cpu, max_perf_reg, &max);
+	perf_ctrls->max_perf = max;
+
+	if (CPC_SUPPORTED(min_perf_reg))
+		cpc_read(cpu, min_perf_reg, &min);
+	perf_ctrls->min_perf = min;
+
+	if (CPC_SUPPORTED(desired_perf_reg))
+		cpc_read(cpu, desired_perf_reg, &desired_perf);
+	perf_ctrls->desired_perf = desired_perf;
+
+	if (CPC_SUPPORTED(energy_perf_reg))
+		cpc_read(cpu, energy_perf_reg, &energy_perf);
+	perf_ctrls->energy_perf = energy_perf;
+
+out_err:
+	if (regs_in_pcc)
+		up_write(&pcc_ss_data->pcc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf_ctrls);
 
 /**
- * cppc_set_perf - Set a CPU's performance controls.
+ * cppc_set_perf_ctrls - Set a CPU's performance controls.
  * @cpu: CPU for which to set performance controls.
  * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
  *
  * Return: 0 for success, -ERRNO otherwise.
  */
-int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+int cppc_set_perf_ctrls(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
 	struct cpc_register_resource *desired_reg, *min_perf_reg, *max_perf_reg;
@@ -1803,7 +1870,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	/*
 	 * This is Phase-II where we transfer the ownership of PCC to Platform
 	 *
-	 * Short Summary: Basically if we think of a group of cppc_set_perf
+	 * Short Summary: Basically if we think of a group of cppc_set_perf_ctrls
 	 * requests that happened in short overlapping interval. The last CPU to
 	 * come out of Phase-I will enter Phase-II and ring the doorbell.
 	 *
@@ -1862,7 +1929,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cppc_set_perf);
+EXPORT_SYMBOL_GPL(cppc_set_perf_ctrls);
 
 /**
  * cppc_get_transition_latency - returns frequency transition latency in ns
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index bbc27ef9edf7..b98539d1a6aa 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -355,7 +355,7 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 		return 0;
 
 	perf_ctrls.energy_perf = epp;
-	ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
+	ret = cppc_set_epp_and_autosel(cpudata->cpu, &perf_ctrls, 1);
 	if (ret) {
 		pr_debug("failed to set energy perf value (%d)\n", ret);
 		return ret;
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index ecbeb12f46e6..e4666836306d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -81,7 +81,7 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
 	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
 	cpu_data = cppc_fi->cpu_data;
 
-	if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
+	if (cppc_get_perf_fb_ctrs(cppc_fi->cpu, &fb_ctrs)) {
 		pr_warn("%s: failed to read perf counters\n", __func__);
 		return;
 	}
@@ -115,7 +115,7 @@ static void cppc_scale_freq_tick(void)
 	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, smp_processor_id());
 
 	/*
-	 * cppc_get_perf_ctrs() can potentially sleep, call that from the right
+	 * cppc_get_perf_fb_ctrs() can potentially sleep, call that from the right
 	 * context.
 	 */
 	irq_work_queue(&cppc_fi->irq_work);
@@ -141,7 +141,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
 		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
 
-		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
+		ret = cppc_get_perf_fb_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
 		if (ret) {
 			pr_warn("%s: failed to read perf counters for cpu:%d: %d\n",
 				__func__, cpu, ret);
@@ -271,7 +271,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 	freqs.new = target_freq;
 
 	cpufreq_freq_transition_begin(policy, &freqs);
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
 	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
 
 	if (ret)
@@ -291,7 +291,7 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
 
 	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
 
 	if (ret) {
 		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
@@ -640,7 +640,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
 	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 			 caps->highest_perf, cpu, ret);
@@ -666,7 +666,7 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 
 	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
 
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 			 caps->lowest_perf, cpu, ret);
@@ -705,19 +705,19 @@ static int cppc_perf_from_fbctrs(struct cppc_perf_fb_ctrs *fb_ctrs_t0,
 	return (reference_perf * delta_delivered) / delta_reference;
 }
 
-static int cppc_get_perf_ctrs_sample(int cpu,
-				     struct cppc_perf_fb_ctrs *fb_ctrs_t0,
-				     struct cppc_perf_fb_ctrs *fb_ctrs_t1)
+static int cppc_get_perf_fb_ctrs_sample(int cpu,
+					struct cppc_perf_fb_ctrs *fb_ctrs_t0,
+					struct cppc_perf_fb_ctrs *fb_ctrs_t1)
 {
 	int ret;
 
-	ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t0);
+	ret = cppc_get_perf_fb_ctrs(cpu, fb_ctrs_t0);
 	if (ret)
 		return ret;
 
 	udelay(2); /* 2usec delay between sampling */
 
-	return cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
+	return cppc_get_perf_fb_ctrs(cpu, fb_ctrs_t1);
 }
 
 static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
@@ -735,7 +735,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 
 	cpufreq_cpu_put(policy);
 
-	ret = cppc_get_perf_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
+	ret = cppc_get_perf_fb_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
 	if (ret) {
 		if (ret == -EFAULT)
 			/* Any of the associated CPPC regs is 0. */
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 20f3d62e7a16..2f2dbeeced65 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -119,7 +119,6 @@ struct cppc_perf_caps {
 	u32 lowest_nonlinear_perf;
 	u32 lowest_freq;
 	u32 nominal_freq;
-	u32 energy_perf;
 	bool auto_sel;
 };
 
@@ -150,8 +149,9 @@ struct cppc_cpudata {
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
 extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
-extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
-extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
+extern int cppc_get_perf_fb_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
+extern int cppc_get_perf_ctrls(int cpu, struct cppc_perf_ctrls *perf_ctrls);
+extern int cppc_set_perf_ctrls(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern bool cppc_perf_ctrs_in_pcc(void);
@@ -166,7 +166,7 @@ extern bool cpc_supported_by_cpu(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
-extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
+extern int cppc_set_epp_and_autosel(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
 extern int cppc_set_epp(int cpu, u64 epp_val);
 extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
@@ -188,11 +188,15 @@ static inline int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
 {
 	return -EOPNOTSUPP;
 }
-static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
+static inline int cppc_get_perf_fb_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_get_perf_ctrls(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 {
 	return -EOPNOTSUPP;
 }
-static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+static inline int cppc_set_perf_ctrls(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 {
 	return -EOPNOTSUPP;
 }
@@ -232,7 +236,7 @@ static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 {
 	return -EOPNOTSUPP;
 }
-static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
+static inline int cppc_set_epp_and_autosel(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.34.1


