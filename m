Return-Path: <linux-acpi+bounces-20464-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEj8Iranb2ndEgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20464-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:05:10 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5257D47095
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB03C7AC70F
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D001D4611C6;
	Tue, 20 Jan 2026 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UzHCXsoP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D8A45BD5F;
	Tue, 20 Jan 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921111; cv=fail; b=YdIfLoSEsBm94AwCJPMJJGF9vCRoujd0YJnte9RmS9yJRDdFRc9POfS1fCfjMHGH0g6lGuFDB8eOnZ8UYgMAvDz56kKHClyA9uPVMSuTEuFpaBoEyNSIZGgHItFe2wsrKhAY2m8vyeyum1gHvhqDrYkhbufPQjt3ERXno+iGQBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921111; c=relaxed/simple;
	bh=mT/h+BhARbnb0XLGXvxJAnGs8tY0s6+qOtIbheT/MeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKWbVcfKjU9izG8LS+M9d5SnwBNLMfTY7B9xZft/A2gWO4psFGBXvmTB2YU2q1PhEsAhR/k5XC4EIw9pbYrfkb7HxBXLnVBRdjohLBmH3QZ4jOEGlE7sRMhDJsMDz9n5ZgrqzPhlWvRqGXoB97NcL/8eIHnMnT4V6Wjvli0XJFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UzHCXsoP; arc=fail smtp.client-ip=40.93.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7SisfxwkuLDqBiO7IJ4f51EL+hPYFjzX3KUuj64+GSESatB5XMFIzD+gSd8KE7bsaByu/wHjH65Zk0h9630CmZSmFFiQIbUXJ9hMfDmi4XJ673Rf7nZjKtgu5S7zPKenRVB3gADXPhN/6+qceS9c2AphSqVGLi6YQen50fmrUJmhcGSD/c7qHEhupRQALl9XZRwyDR70MpS6sFkwzqQ7omu3QXvYQ80qhQeDSEYdVfCIWUwnjHsmSn34s+aKO2S8SJX/CLE+PL4w7r7Nx9ZXYblV5gv7Wafl6iC2LHW+eYsKqsZ8tWEdwnTMLe3C0ZQe8rvJB54MB7VpYaoGOih5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKcHk12QPZ6KrrB3doM09+kmyHviu1P/S+X2/ZkWMro=;
 b=NRwiPuSRv0XhmmrswMvZ5fjFhHIqjReDWNzwziqMCPuDQsand7x/BoehHYsSkifUzAL2tT+JtDVuG6gM7HHS9LlTaHkGKXafxtvyw0b4ipAa9u8MAItx2y0SIIij0tsLn0sSt+bukuqZYQ90j5/iD0GFJl1wW5pbaKBSBO0Lr5kN9J1KKTj3GwZw/Ar9x1iCYljDctXXnwtLB4QmjSaivw/MDk5obktkGqmgRN2Mmkdzow2RC6XRTYQxwVI7Jtq1fsB8+nIwnZYIvJZs9Bv7r1eQfuVATfRDc+96sNZ4wqyaB+d2bYLnLzgUA4d4aIbFHQAENzVK7srTcsLmMIAn3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKcHk12QPZ6KrrB3doM09+kmyHviu1P/S+X2/ZkWMro=;
 b=UzHCXsoPfy0zF5Ps4e1I9momiQp5w+D7WlunCPgEi/icwMvv4vWyF1i5179sP23rhjNXWHno+XxFMjIvIGXj07SJPvKTkda2Rs30Z8/NBiL8bRK/CBgLmCPC12yTB+J3vsiKMDsZld1jFISaue7ueSv2sQnp7gGu4PXWJIHeRMl+07YbrDVeLATrQOspaJQswwDDW4scNdveegeOMKY6WGCaU0mDk0c2W2AWoWNxYcwkb55+rRuoTwcVZcMVQZH9dOH1w6PSM3tporn3qc3333Le1qtSKXsj5L8KAN48JMqee0z5zY0Tj5JB7rEO6iu2ULubbrqTYmufkwQcKyqXWQ==
Received: from PH7PR13CA0006.namprd13.prod.outlook.com (2603:10b6:510:174::19)
 by BN7PPF9507C739C.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 14:58:19 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::11) by PH7PR13CA0006.outlook.office365.com
 (2603:10b6:510:174::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 14:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 14:58:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:57:49 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:57:49 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 06:57:41 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <ionela.voinescu@arm.com>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <rdunlap@infradead.org>,
	<ray.huang@amd.com>, <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <zhanjie9@hisilicon.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <nhartman@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v6 6/9] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
Date: Tue, 20 Jan 2026 20:26:20 +0530
Message-ID: <20260120145623.2959636-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120145623.2959636-1-sumitg@nvidia.com>
References: <20260120145623.2959636-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|BN7PPF9507C739C:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f5c705-cab0-43af-567c-08de58345832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2l6X/Z/3N0crZghFWh+Hl1iLiHlg91sgPz1DDMFSUElsGjrb+3bjeP9BPrFQ?=
 =?us-ascii?Q?WMKvTOUsWSZ/S+R5JZf7HZ3SSEyR1L1983dG6htwPdatFvHoBGo9XhjB5jMR?=
 =?us-ascii?Q?cpbyuPSDU39M6qO13uVRaTvUfEJnQjSoURtVPYZCVPVdumXhD4KHJaD8/8P/?=
 =?us-ascii?Q?isSubyP5lXeIGswJA70r6+lP3/ozhtBD4T5+4HJcJOmWi+V0tGIb3MU8IC8P?=
 =?us-ascii?Q?PTwhrTwEgkINSlnDwky74dkEhcJvSEImww9c6CZP81qfHml8bQxJ0O6mvlg+?=
 =?us-ascii?Q?hRlZKqmLJ9mUttDKoROwvp7JrUcsZvcoJkiHKVfvvtHe/0LTm5791Mh92dPB?=
 =?us-ascii?Q?HSMXq17hgLI4apxsytSI0w280xreWCxx59CuMWHivhHfPik2eMZR/P5psXqY?=
 =?us-ascii?Q?gXXV6QsqSfoVx1ALfx3z5ep1XWoNeYR+rdxnUm9yG0WvmBBcNqeCQB4+8vmK?=
 =?us-ascii?Q?zSl2XWbv7qd7FDLQBbeY7WBk6ffIabG90SdYyESCYk9ToRI8CB1jG3bU36K5?=
 =?us-ascii?Q?TgGeOyS38QDrdPT65QqKa3TlCtBf7yXU5+Usff0q1QWbZq22ckJEwFdkPsnr?=
 =?us-ascii?Q?059NfGIfbgajY70CmV7+4bhla94eP/Ysau47ycG+MirmmYGhLXixwuxtRCj8?=
 =?us-ascii?Q?J0Dk5ff/e1xwT/RR2PXdd1vagNiJzqaOvEYZLN1KdMh0tp/wksQlx+axfCZ9?=
 =?us-ascii?Q?ASvhMftECUL8ym3+YwCqX+w3tQ2ZaeHsJi9YB5yhUo00RWE1f9fz2NTrxTHP?=
 =?us-ascii?Q?5gaartnzsZBF0E4MZYM6I20kO01xsxJeg6Em8Uc228wTCMmZ9HXDM8yMyvV2?=
 =?us-ascii?Q?gjNt0+Rt9zWjudIe1Ko54DQtH6+1R8ufVcTR/UZUaQKLZjpe3g6Ee1w505Rt?=
 =?us-ascii?Q?8YImxDy88nhvruedJIckmQw78s2F369KaBmr+CWxh5hz5R/AeqGoxlkxusql?=
 =?us-ascii?Q?4++MX2XGiyrkog/H2vQ0xFSk2+JpW0q74azLZ3fGzb0BmICS2+bt4K1+0MG4?=
 =?us-ascii?Q?bK/PCSajxWO7AzXLuMMt2Ta8KRBgfc1kVJY6zQGSsnBbKwozIbZ3Ubi7x8db?=
 =?us-ascii?Q?2Vx+nASEQbkNw0lsbFhA7OjSCbShOiUp1RC6kXh82O/IJhOygsQSSDU8mPF6?=
 =?us-ascii?Q?ax6OFg8yYOlprwaTeQbe45ntEHg2HT9BPOPCnFoUC4KExdvxIb2zhMyELDIu?=
 =?us-ascii?Q?zqCfz8iK4mIvEVjtB/38cKiEuKXIIVNYtTWX/tVSLIRaSVz+BTElQ+yB++jj?=
 =?us-ascii?Q?9AR6xf9jAahsmoeuxtfySFR92eJSeur2KziQjHOP+2pBHHthcK8FDT/oPuoN?=
 =?us-ascii?Q?xmYTSv2pftYUR6QAUvPjPyanff9PRsMMkKmzrsnJL4DEwje/8nWqygyBe0+U?=
 =?us-ascii?Q?0CTC5i8UK5lhOFOeI2HDGJlitNYn5qfdRU7XTEdcbqzgL91eP3NFN0Z7l3Am?=
 =?us-ascii?Q?B8xP1JE9bi3l0r73AeKxSVK1+Ks4gmrTq/nBlOxDu2fH8rMQ88kyy2p6sA6U?=
 =?us-ascii?Q?7fwLSJOCVY1vJV+DtWshWQMIeFKPiNOB/eR422OxamFlpp4OrG+6CDswfhJr?=
 =?us-ascii?Q?usAbX34/qJ7etJ6cTx0q6y7Utf1Uba9jFx/RgFmEQst2hvq3GtGpvKg0uglC?=
 =?us-ascii?Q?yG0mOQBLoeCLD1rpBV3d3EQtROb3ZeTEWG9/hOvoFB9JJH1oTICnKpeE8Hrf?=
 =?us-ascii?Q?UkCThjRaOz2NOtIAZUp90DXZJ+g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:58:17.3087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f5c705-cab0-43af-567c-08de58345832
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9507C739C
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20464-lists,linux-acpi=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_TWELVE(0.00)[28];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5257D47095
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add cppc_get/set_min_perf() and cppc_get/set_max_perf() APIs to read and
write the MIN_PERF and MAX_PERF registers.

Also add sysfs interfaces (min_perf, max_perf) in cppc_cpufreq driver
to expose these controls to userspace. The sysfs values are in frequency
(kHz) for consistency with other cpufreq sysfs files.

A mutex is used to serialize sysfs store operations to ensure hardware
register writes and perf_ctrls updates are atomic.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       |  44 +++++++++
 drivers/cpufreq/cppc_cpufreq.c | 157 +++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h       |  20 +++++
 3 files changed, 221 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 45c6bd6ec24b..46bf45f8b0f3 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1743,6 +1743,50 @@ int cppc_set_auto_sel(int cpu, bool enable)
 }
 EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
 
+/**
+ * cppc_get_min_perf - Read minimum performance register.
+ * @cpu: CPU from which to read register.
+ * @min_perf: Return address.
+ */
+int cppc_get_min_perf(int cpu, u64 *min_perf)
+{
+	return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_get_min_perf);
+
+/**
+ * cppc_set_min_perf - Write minimum performance register.
+ * @cpu: CPU to which to write register.
+ * @min_perf: the desired minimum performance value to be updated.
+ */
+int cppc_set_min_perf(int cpu, u32 min_perf)
+{
+	return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_set_min_perf);
+
+/**
+ * cppc_get_max_perf - Read maximum performance register.
+ * @cpu: CPU from which to read register.
+ * @max_perf: Return address.
+ */
+int cppc_get_max_perf(int cpu, u64 *max_perf)
+{
+	return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_get_max_perf);
+
+/**
+ * cppc_set_max_perf - Write maximum performance register.
+ * @cpu: CPU to which to write register.
+ * @max_perf: the desired maximum performance value to be updated.
+ */
+int cppc_set_max_perf(int cpu, u32 max_perf)
+{
+	return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_set_max_perf);
+
 /**
  * cppc_set_enable - Set to enable CPPC on the processor by writing the
  * Continuous Performance Control package EnableRegister field.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 229880c4eedb..66e183b45fb0 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -28,6 +28,8 @@
 
 static struct cpufreq_driver cppc_cpufreq_driver;
 
+static DEFINE_MUTEX(cppc_cpufreq_autonomous_lock);
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
 	FIE_UNSET = -1,
@@ -570,6 +572,35 @@ static void populate_efficiency_class(void)
 }
 #endif
 
+/* Set min/max performance HW register and cache the value */
+static int cppc_cpufreq_set_mperf_reg(struct cpufreq_policy *policy,
+				      u64 val, bool is_min)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	unsigned int cpu = policy->cpu;
+	u32 perf;
+	int ret;
+
+	perf = clamp(val, caps->lowest_perf, caps->highest_perf);
+
+	ret = is_min ? cppc_set_min_perf(cpu, perf) :
+		       cppc_set_max_perf(cpu, perf);
+	if (ret) {
+		if (ret != -EOPNOTSUPP)
+			pr_warn("CPU%d: set %s_perf=%u failed (%d)\n",
+				cpu, is_min ? "min" : "max", perf, ret);
+		return ret;
+	}
+
+	if (is_min)
+		cpu_data->perf_ctrls.min_perf = perf;
+	else
+		cpu_data->perf_ctrls.max_perf = perf;
+
+	return 0;
+}
+
 static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 {
 	struct cppc_cpudata *cpu_data;
@@ -918,16 +949,142 @@ CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
 CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
 			 cppc_get_epp_perf, cppc_set_epp)
 
+/**
+ * show_min_perf - Show minimum performance as frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer to write the frequency value to
+ *
+ * Reads the MIN_PERF register and converts the performance value to
+ * frequency (kHz).
+ */
+static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u64 perf;
+	int ret;
+
+	ret = cppc_get_min_perf(policy->cpu, &perf);
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+	if (ret)
+		return ret;
+
+	/* Use lowest_perf if register is uninitialized (0) */
+	if (perf == 0)
+		perf = caps->lowest_perf;
+
+	/* Convert performance to frequency (kHz) for user */
+	return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(caps, perf));
+}
+
+/**
+ * store_min_perf - Set minimum performance from frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer containing the frequency value
+ * @count: size of @buf
+ *
+ * Converts the user-provided frequency (kHz) to a performance value
+ * and writes it to the MIN_PERF register.
+ */
+static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf,
+			      size_t count)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int freq_khz;
+	u64 perf;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &freq_khz);
+	if (ret)
+		return ret;
+
+	/* Convert frequency (kHz) to performance value */
+	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
+
+	guard(mutex)(&cppc_cpufreq_autonomous_lock);
+	ret = cppc_cpufreq_set_mperf_reg(policy, perf, true);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+/**
+ * show_max_perf - Show maximum performance as frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer to write the frequency value to
+ *
+ * Reads the MAX_PERF register and converts the performance value to
+ * frequency (kHz).
+ */
+static ssize_t show_max_perf(struct cpufreq_policy *policy, char *buf)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u64 perf;
+	int ret;
+
+	ret = cppc_get_max_perf(policy->cpu, &perf);
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+	if (ret)
+		return ret;
+
+	/* Use highest_perf if register is uninitialized or out of range */
+	if (perf == 0 || perf > caps->highest_perf)
+		perf = caps->highest_perf;
+
+	/* Convert performance to frequency (kHz) for user */
+	return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(caps, perf));
+}
+
+/**
+ * store_max_perf - Set maximum performance from frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer containing the frequency value
+ * @count: size of @buf
+ *
+ * Converts the user-provided frequency (kHz) to a performance value
+ * and writes it to the MAX_PERF register.
+ */
+static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
+			      size_t count)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int freq_khz;
+	u64 perf;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &freq_khz);
+	if (ret)
+		return ret;
+
+	/* Convert frequency (kHz) to performance value */
+	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
+
+	guard(mutex)(&cppc_cpufreq_autonomous_lock);
+	ret = cppc_cpufreq_set_mperf_reg(policy, perf, false);
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
index 3fc796c0d902..b358440cd0e2 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -174,6 +174,10 @@ extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, bool *enable);
 extern int cppc_set_auto_sel(int cpu, bool enable);
+extern int cppc_get_min_perf(int cpu, u64 *min_perf);
+extern int cppc_set_min_perf(int cpu, u32 min_perf);
+extern int cppc_get_max_perf(int cpu, u64 *max_perf);
+extern int cppc_set_max_perf(int cpu, u32 max_perf);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 extern int amd_detect_prefcore(bool *detected);
@@ -270,6 +274,22 @@ static inline int cppc_set_auto_sel(int cpu, bool enable)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_min_perf(int cpu, u64 *min_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_min_perf(int cpu, u32 min_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_get_max_perf(int cpu, u64 *max_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_max_perf(int cpu, u32 max_perf)
+{
+	return -EOPNOTSUPP;
+}
 static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 {
 	return -ENODEV;
-- 
2.34.1


