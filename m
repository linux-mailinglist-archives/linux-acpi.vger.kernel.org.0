Return-Path: <linux-acpi+bounces-11003-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0DAA308AC
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 11:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D52188924A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1438D1F4736;
	Tue, 11 Feb 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NO+ZGt3h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7081F4701;
	Tue, 11 Feb 2025 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270293; cv=fail; b=u2L2oRxc26B62NVt7x1bn9DUG+LbJH1WNJPqjXxthNAai0XFASXONeTLkGmISaWhch9HlcJg5vIWvwCJVm31MhXAFFiqBC8jOPSh7rJlZIZUaiBv8Lw8+eHG/nD1Z15zZZ5iSDsEEsl/doY8RXXTB+RxH8+P5N2NlR8/bpw+c+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270293; c=relaxed/simple;
	bh=bNYf7+rIyD5gV6BurU8lObURYDVCn0SbgjKkLmGPjeo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plGixJ4kLGQAqA2KU509qX8fspomQw2iHlM8JfxAAM9denczgQIpVRFmwgYccmrt65nyHLoeeERsYNvj54l1dGmhg/jcyux+/TzOOQoj2awRMO0/ngh/rq0sBx4srpbtNiaaT8m+cSQt5u5OoNWqzhQAkKDZQJdBdHHbTCEaWPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NO+ZGt3h; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouIyTQcRbY/uRk1oG0IO9PUymEGvHwo58kS1Cc3AFRFg232ORB9qLIROm/Xm9LVYKXK+lUMEdFLqkPMDPoIzooXewGdS986MukPQTXFo8dMHBon1cG8PcA96xSKQJTfHYWip9Dycz6zm06JSLJU9i1EmTdnObvI7VbUbZyRja/5ineL519kDv0iDhoXXtCoihAk64lgCEiWD9M9Vg9kbRBu2f1g/uKd4BT4NftyEHIlgW+fS1wDOOctPuF1dxW+2ueVeN0TB6LEHQTaQrVr42ka+obJf/PHXdZ9hPypg0TbKEWUirE91O0yWIFiqyOZWk8E3RizM6hycESq4pxvjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnkattIxB06Zs6sAKabY2ditXXQ+n6j7kvk/18CskPM=;
 b=qUjy2Ae8tImsycnZvymAVCrKJhZCZSgB4gXrSiFYj6SM99U1KQ4GMRE7quPeaQ4d/hH1orNPw+d9xTQtGG30NNPqN3j4KMogR6uPsjTHbOCPK8PsMj09UcowlmEZ5kTEvnCn2qiMbBp+cDv1IWSlM+kq+lQaLh33oYAVGy79FVDIi/IKekg6o5foXfs+hV3NtPqMgxfimlbln3UJy4YivIM54idv+SZiYuZzM0rcgYSLU9UUwoBRdCBkyBWOeNvhSsJTXqoQFUsyijZK50YXvU0zUuUbMC4cmu/n+Hmiwal56T4RDEiALxIk5suXyKOPGBrqATGITwMiZc6DFW0+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnkattIxB06Zs6sAKabY2ditXXQ+n6j7kvk/18CskPM=;
 b=NO+ZGt3h4LRuxJb6oHSiFlWUq+Z4gDxT1Oglzqvggnj8vaYNjYw3ouje23yHBV0+X/tcQwBHeog6apA6F+b3zXWG7f5hgQ5RpGifUDEKKusQFdAtR55OxQrfxOnOU9whLF3ly4o8Q6czijjwXeoKg8tVfiHyoYmuz63L9587S/+hZcyE0datZNO3iqYeOnLQGdOccu1yGAEjdeMcYButTtWqB/GkU2fP6uM1xmzVbNjOE8a9sHDhHbjvToLYAPSTH2J7OKOooN7jiC0VsNqFcpruKfijATEBh2jRyE4/d0r109a0dCeKLdBtg8Tr84YC1ixZKfLhnFhLhWLqI0du6g==
Received: from MN2PR11CA0015.namprd11.prod.outlook.com (2603:10b6:208:23b::20)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Tue, 11 Feb
 2025 10:38:06 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::f6) by MN2PR11CA0015.outlook.office365.com
 (2603:10b6:208:23b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Tue,
 11 Feb 2025 10:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 10:38:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Feb
 2025 02:37:53 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Feb
 2025 02:37:52 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Feb 2025 02:37:47 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <sashal@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [Patch 1/5] ACPI: CPPC: add read perf ctrls api and rename few existing
Date: Tue, 11 Feb 2025 16:07:33 +0530
Message-ID: <20250211103737.447704-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250211103737.447704-1-sumitg@nvidia.com>
References: <20250211103737.447704-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: e2280d21-b61a-4749-9810-08dd4a882b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q1BYjg1P9u7EbDK4bw3s9TsB6zI8GPho4Sq/miRaIpM2IxfZUuiPTbZudKhb?=
 =?us-ascii?Q?TrybTHxwd8JPX8V3e8I5Zb5wQTDG1a1UVwovd2EyCNJMiOpT9U4VnhCRFaW5?=
 =?us-ascii?Q?5IG4Y+V1TBNbcwBLQ/x9rOSbZNubS3H7Z+Yj4D5NyOwNOryV1auliVM4LyWp?=
 =?us-ascii?Q?no6zH1hiUP0lmioIDPK+qee3T8Lzon7010YzeiQAOVwLATJzA/IbwcFeFYAe?=
 =?us-ascii?Q?1T2bJRm4PeWHCz1fGQPivNo6eg4xpSvHvah9DXTPm4b6OhwrDEKhEh/Ir6bI?=
 =?us-ascii?Q?a/PMQ5zLqCdoOpTZfRko5Zs6BuVSPgcHJt8LmXPZif3Jj7GwBEWGbgpKk7al?=
 =?us-ascii?Q?pIE1cXcTWXD97SQoH/0vDCNpdzfLjwcIzvHKSNn+THjm8K5UTbEId98jEnxF?=
 =?us-ascii?Q?Re/9VGUPlYhOvaKjsNDYMDVGovQcoc1kDc6tBvfBS8mdOk1X6foaSz3C75GN?=
 =?us-ascii?Q?ibNeafCtTP8cv9fss7Gygc/IRWWejnq+9iv1is8ohrOTCIOeJWjR/+gzG5Nf?=
 =?us-ascii?Q?6YobSrkgMrsfxvBSm+KZO9CzOR2aFUS54/LSl+zJLPtYK0JgVqnedZuS44X3?=
 =?us-ascii?Q?aVW40oyUMsu+KmBP59kmvmXQ3oiDDCQ6CeHf9pD7BZ08RHPEDiVisIhMdzMZ?=
 =?us-ascii?Q?HRkRZdRDPt39dIr4sRVeG3RsppjUq3J556cn3VEFzxc1AHVqQi5GwD4UAUX4?=
 =?us-ascii?Q?Ig3dMiK2Cq8u9zB+P/Daac5yZtaSu8HTWfd9k7AnXxZJmLNp2Mqe2y0OEfUZ?=
 =?us-ascii?Q?prmvqNLmEnvn4lxBnId4YQpYh5E0Uc90e0UtpPUBvtPr38bFeRnkisYbzePU?=
 =?us-ascii?Q?HRLwjzmg1IH75s+tyWrsPfx9XrXpjkaKpirz9RHI2cWlNGuFZKZBng+0e748?=
 =?us-ascii?Q?E5Ekmnq8krGJ0i5KLLCq8AXq7JGVlxbDvjYVa42PVXlmTgP2/hVGSRWp54sU?=
 =?us-ascii?Q?tu/u5IoZWzKfKKabA/npnmVqa9kydiu6TEwiD/ETIhXjXyrUKDINY+H20eLP?=
 =?us-ascii?Q?xc4VNYmxwvofSRKDFsmYFth4djaAXFNixzu/OhV+66/pqyrsVGSTvGrda+rF?=
 =?us-ascii?Q?xlf9+N8hjrP3AhVjtEJWHou9EG9JnvvFi3Hvmr1TRMctWjDVh2rdPOvjLADF?=
 =?us-ascii?Q?qJGKYNNYWgI8cMAugjcujedX4hT5yFXIFXrtzQ1gv/DRojoYEw7zcBGCgQNV?=
 =?us-ascii?Q?++CEWkQ5da7o0tNnBMLYe6lqohpufw4Cg2XMNUmo1AlF8Y56S2/vry680k9p?=
 =?us-ascii?Q?z3qSFo+r3AY0iHVT+wKdUOuulup4QH1oyqrg9DMtQlfFBAK5V/vbKEwZJycA?=
 =?us-ascii?Q?tdGQq2eRLlHhCCp9iJMt6MbTE46GvgnKbUMZCfPrT1XoSg4KpzHJqK7W/SHi?=
 =?us-ascii?Q?GXmRvEktQn4bWE7bFyhARbpFD3zKubFEHYc9IusthBTIRLHSpYvdWUynyQOP?=
 =?us-ascii?Q?tuCpTZgqXJDkEvYBsPP6Qs3t8S8jXB1iYkjid8MlJzFBGTNY5UCDb55yNg/m?=
 =?us-ascii?Q?Q+kzZJF5luSucSoZ8gLzcMZ1nRah0V5xVjxf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 10:38:06.0630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2280d21-b61a-4749-9810-08dd4a882b85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786

Add new API cppc_get_perf_ctrls() to read the performance controls.
Rename the following existing API's for more clarity.
- cppc_set_perf() to cppc_set_perf_ctrls().
- cppc_get_perf_ctrs() to cppc_get_perf_fb_ctrs().
- cppc_get_perf_ctrs_sample() to cppc_get_perf_fb_ctrs_sample().

Also, remove redundant energy_perf field from 'struct cppc_perf_caps'.
It is also present in 'struct cppc_perf_ctrls' which is being used.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 91 +++++++++++++++++++++++++++++-----
 drivers/cpufreq/cppc_cpufreq.c | 26 +++++-----
 include/acpi/cppc_acpi.h       | 14 ++++--
 3 files changed, 101 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f193e713825a..297e689f8214 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -59,7 +59,7 @@ struct cppc_pcc_data {
 	/*
 	 * Lock to provide controlled access to the PCC channel.
 	 *
-	 * For performance critical usecases(currently cppc_set_perf)
+	 * For performance critical usecases(currently cppc_set_perf_ctrls)
 	 *	We need to take read_lock and check if channel belongs to OSPM
 	 * before reading or writing to PCC subspace
 	 *	We need to take write_lock before transferring the channel
@@ -169,8 +169,8 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
 
-show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
-show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
+show_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, reference_perf);
+show_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
 /* Check for valid access_width, otherwise, fallback to using bit_width */
 #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
@@ -189,7 +189,7 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj,
 	struct cppc_perf_fb_ctrs fb_ctrs = {0};
 	int ret;
 
-	ret = cppc_get_perf_ctrs(cpc_ptr->cpu_id, &fb_ctrs);
+	ret = cppc_get_perf_fb_ctrs(cpc_ptr->cpu_id, &fb_ctrs);
 	if (ret)
 		return ret;
 
@@ -1360,7 +1360,7 @@ EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
  *
  * CPPC has flexibility about how CPU performance counters are accessed.
  * One of the choices is PCC regions, which can have a high access latency. This
- * routine allows callers of cppc_get_perf_ctrs() to know this ahead of time.
+ * routine allows callers of cppc_get_perf_fb_ctrs() to know this ahead of time.
  *
  * Return: true if any of the counters are in PCC regions, false otherwise
  */
@@ -1398,13 +1398,13 @@ bool cppc_perf_ctrs_in_pcc(void)
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
@@ -1475,7 +1475,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 		up_write(&pcc_ss_data->pcc_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
+EXPORT_SYMBOL_GPL(cppc_get_perf_fb_ctrs);
 
 /*
  * Set Energy Performance Preference Register value through
@@ -1674,15 +1674,82 @@ int cppc_set_enable(int cpu, bool enable)
 	return cpc_write(cpu, enable_reg, enable);
 }
 EXPORT_SYMBOL_GPL(cppc_set_enable);
+/**
+ * cppc_get_perf - Get a CPU's performance controls.
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
@@ -1746,7 +1813,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	/*
 	 * This is Phase-II where we transfer the ownership of PCC to Platform
 	 *
-	 * Short Summary: Basically if we think of a group of cppc_set_perf
+	 * Short Summary: Basically if we think of a group of cppc_set_perf_ctrls
 	 * requests that happened in short overlapping interval. The last CPU to
 	 * come out of Phase-I will enter Phase-II and ring the doorbell.
 	 *
@@ -1805,7 +1872,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cppc_set_perf);
+EXPORT_SYMBOL_GPL(cppc_set_perf_ctrls);
 
 /**
  * cppc_get_transition_latency - returns frequency transition latency in ns
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b3d74f9adcf0..17c49653a3c4 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -90,7 +90,7 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
 	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
 	cpu_data = cppc_fi->cpu_data;
 
-	if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
+	if (cppc_get_perf_fb_ctrs(cppc_fi->cpu, &fb_ctrs)) {
 		pr_warn("%s: failed to read perf counters\n", __func__);
 		return;
 	}
@@ -125,7 +125,7 @@ static void cppc_scale_freq_tick(void)
 	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, smp_processor_id());
 
 	/*
-	 * cppc_get_perf_ctrs() can potentially sleep, call that from the right
+	 * cppc_get_perf_fb_ctrs() can potentially sleep, call that from the right
 	 * context.
 	 */
 	irq_work_queue(&cppc_fi->irq_work);
@@ -151,7 +151,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
 		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
 
-		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
+		ret = cppc_get_perf_fb_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
 		if (ret) {
 			pr_warn("%s: failed to read perf counters for cpu:%d: %d\n",
 				__func__, cpu, ret);
@@ -281,7 +281,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 	freqs.new = target_freq;
 
 	cpufreq_freq_transition_begin(policy, &freqs);
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
 	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
 
 	if (ret)
@@ -301,7 +301,7 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
 
 	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
 
 	if (ret) {
 		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
@@ -657,7 +657,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
 	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 			 caps->highest_perf, cpu, ret);
@@ -683,7 +683,7 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 
 	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
 
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 			 caps->lowest_perf, cpu, ret);
@@ -723,19 +723,19 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
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
@@ -753,7 +753,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 
 	cpufreq_cpu_put(policy);
 
-	ret = cppc_get_perf_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
+	ret = cppc_get_perf_fb_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
 	if (ret) {
 		if (ret == -EFAULT)
 			/* Any of the associated CPPC regs is 0. */
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 62d368bcd9ec..31f4fd288b65 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -110,7 +110,6 @@ struct cppc_perf_caps {
 	u32 lowest_nonlinear_perf;
 	u32 lowest_freq;
 	u32 nominal_freq;
-	u32 energy_perf;
 	bool auto_sel;
 };
 
@@ -142,8 +141,9 @@ struct cppc_cpudata {
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
@@ -177,11 +177,15 @@ static inline int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
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
-- 
2.25.1


