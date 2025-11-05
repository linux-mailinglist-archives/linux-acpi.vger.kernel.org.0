Return-Path: <linux-acpi+bounces-18537-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5B6C356FD
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 12:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6553C3B5A1E
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 11:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9A531196A;
	Wed,  5 Nov 2025 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ChAPrVGZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DE1310636;
	Wed,  5 Nov 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342823; cv=fail; b=d9UGmra6PH6qTu82qdu4f8H31DmXgCsdm2Cg5Wd75gmBti0x4g9GAWuHH24LYj04kpJECp492XB8qoUTrQDVMszRI5UXC+8Y0Ave58Iy2z03aItMjeoNWewEBIst6XUesLY4Sja7vmJ92b3Dlh/v+3Na8G+r84F4vuqDbYOXmj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342823; c=relaxed/simple;
	bh=1EHj5RfaQGuovMr7sQv7FVBm6BISdm+nE3hw+5NiiHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEuIvXobYxQDXNJBQG4SajoIosWRpT1Hre9a22utT7F9i7wAqb/wA0q8ygfS5QdX+fV46lX91D/7ZNAUmf19/fyNPChS5J5LZpaLG0yqAJWwiCudrcuFAVQHxTsl3m++1Z1NSuzKGFq9BMtXJf/R/uvPJhx4MRAgpRQjHAsSHR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ChAPrVGZ; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEoVOMs8X2LpdA5ywII4LDX9NlFvFNr6HacvN3QW6WyoNqu9mub907DQJ6gv+7uNK0X1UKKMGId2cfF8G8OusAms9ZtuZrATBzTfwVmaYD3ij3cTF3U4v+LniYt7CJWOLgDSoPEp9+6F6UrjzO0jPZ9ymFxRFqVMeUO+u4CjU20ElM1NGkVvHSvK7friAhOLiWRRnBY4zvDJ2b6hoqG8OG3nCiwyhw0+m/EeF1jvJSNGANCNfGFmaUvZWXMpJBx+QopgttVjKks/aqfLqdDCXQ8YEdDeEHhNcyTbnRpfpXgJinmwyFyEUh+dd5Am4vlDpiRiiLLoqG5ksdcDHHODvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KZoG7TnH77p92chjegSQtpyzMKo/cz+4u5Z/ZIzY2s=;
 b=pyEI5v4akgBbKle07Mky7Keu3ynynlL9o7rizJiAzKW3U6ct6ZLwhQ3g3qU2MuvJDYTwaK+eoBVfEpfm5I52aMcHxA97SY3mCpbxlUA1B9oaWKnF7e72l+FcKXbuKsCXi7B0SGgoTTsiGrhUozWiIc9oHLwte+slfE21FBAKc/c8FIUjP6xd0usajoU/2iDMcahUbppxsDymTxNNOf9nWUgpLjalNcdq+jOdo4ohdMyethqzwN1BxblvyxWryQ6vznCMhfa3TZmJPOT/UomVpez5iSX14KtPbXSKqJ01YpB4b0S7HwG2ghI2UPKCY10GhquGBH185EGYeek8JtyWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KZoG7TnH77p92chjegSQtpyzMKo/cz+4u5Z/ZIzY2s=;
 b=ChAPrVGZ5Hf04RAGGTPhqerSX9NJptbkTDqNUOY5UtVlULq+jeEXd7pt6PYqKtGBBvaxm2AenrazBhPr/Vyyal1SZvLr494mjwC9CgtIgyhte8f0V/blLzM/8nH4t3cOEEVgILCcQEAk6OHrPgMe6r6KCwuc4q6SjVVy/TafSpnqLaHHFQMngDoP1fT65327edL9BT4jtIFcgcnMa9vmw5C7jef4rvfksvbZImi18EheiBxepKwt+MrYb8LiaUOyZH9BK+lqZ5Yb5yZxX0dqQFFUzo4Viq/OYS9DUFRSt5Q7vZIcmomll480pWU4m34VQbBgCpsILD6uy1o2PTvJFA==
Received: from BLAPR03CA0117.namprd03.prod.outlook.com (2603:10b6:208:32a::32)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 11:40:15 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::91) by BLAPR03CA0117.outlook.office365.com
 (2603:10b6:208:32a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 11:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 11:40:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:40:00 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:40:00 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 03:39:53 -0800
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
Subject: [PATCH v4 4/8] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
Date: Wed, 5 Nov 2025 17:08:40 +0530
Message-ID: <20251105113844.4086250-5-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eae6988-9714-4f2c-161a-08de1c6015d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6WGnCOYU6/lNJJVdb+F/RsuBWxciNgOkI+mFsd77EIUFwZOLeSBe9yW68XbZ?=
 =?us-ascii?Q?KWGDQpzlc+JBQRvRpYqWFWY46KqAJkW69v/JfhV7QrCXJhP6aDQKQCdIDi75?=
 =?us-ascii?Q?vz+nOIXIeGham+KdeP2tFhIAUmKSA7/vcL5+VgCrbMMqDq0h5V0Yqbqv1TDi?=
 =?us-ascii?Q?Pd8C+cnPrMoUzKpPHJz6ZymhW0yLKWtEGeO4MRhIzDMnpU1jY+KFc8hKwXDl?=
 =?us-ascii?Q?NCNzSvrdfSI635IRurKQ3hHfIWsegWeb8CJdT+GFyKp/3scAkXNPRrdw+RqK?=
 =?us-ascii?Q?lZVuf+HBpp+zZYsOo95YKkdJK2BSXzldBZnhsBNAF36EInAwZVYrZbr6yy3c?=
 =?us-ascii?Q?JWqPwUS7tdjaT32lcLjxw07c3xJyhkU9PFrL2gAHregMz4J4Vt3r9Ak4fVNw?=
 =?us-ascii?Q?zWKD5DCWErPq94Wwz9CNaxFIwdB+jgfbuaPQbDRu56FBU3eWamnrF5Mjr6gX?=
 =?us-ascii?Q?Lk8tLf8K6F6ZyEQAptx1m5DJkPvEPTqL/ZoaDvPfoGqNQShyPMSzpxm7vZV/?=
 =?us-ascii?Q?v8Rk61Qu3HhLXfkEMaMgdb2p8pgMQ2fAKd/9lcTaifwth0h4pYqfvXpndnoA?=
 =?us-ascii?Q?h6lEp/3BJ5DnvaE+QpKgq0TzsPhqdWKDKSJLFIuSF3Z0+QP6LeEJBd7p+A7B?=
 =?us-ascii?Q?KoXKFkz7P34qigTP6vzfDSaOiKbuay26qRnH1IS0TSUnxFHVikaGDRQfHhOL?=
 =?us-ascii?Q?S+54JzeX3W8Du2Dngjr+Kg2Znasj6Eiw9ILZ59ENqylryCdfit/8YuduMcEH?=
 =?us-ascii?Q?1jj3xzCjbRaOgLVNI17RMieCbp3HqI8SLN3P7zhkHbPbdmj129PDc/7oCqwe?=
 =?us-ascii?Q?/B4wLoo9r561dl2Rr7vZw+eOibbcG8qpw1mJ5RmPuSMbUM4vlajviOK+M8Gu?=
 =?us-ascii?Q?qbpAT/QLv+xO+fJDIab56P5D25TaDRHVgR/vOXM7jNshYBRFhQhp3oymKxfZ?=
 =?us-ascii?Q?jpS22noNq1MOndGG5DWk6PMz94XO5Rodvc2q9RXlBEpHja+LQtIARJ2Qjya0?=
 =?us-ascii?Q?I9R0aZ9PcU5qXqmDx2H0uO9vSVdCsNeK4sd4B5WFhQwSmrabFEPJW105NQzD?=
 =?us-ascii?Q?DhY2GurEsBN6ehUkvqham7Mv0qmHqgYT43yprSiV6BP8gjbgMVG69PJLNgbw?=
 =?us-ascii?Q?HrcUZJUZ2wk4btWlW+jit/kzVSSdTq9/S00MvaJ5GZKKMy1/dZTxR39pzlRh?=
 =?us-ascii?Q?4YW/5yN62tvYRv5OV3/1Um7MKJuV0z99TeLuYhEJgB8LpkbMmmWUSb3N0jjE?=
 =?us-ascii?Q?h+CGTj4AEQq+GAsbA0rNaKTfj0QspUTFwyJTyLmcqnVjGg6XXHCL0ARlRYcn?=
 =?us-ascii?Q?ZNSpn/CnaaZUWx8di21xxhUHxNYxkPUUxWgIs9rTlP0pL27a89QXNdLt/Jwd?=
 =?us-ascii?Q?37QG/buYugXs4b8SFWODk8DTTUunC3exkTY+CxZcj5mtsL9iWthDoP1sCCdm?=
 =?us-ascii?Q?kacrNadbAs473vc3ofwAbrXZzWlga9AM+QYb7IWTsgJ6OybKn+/QscT7rwAH?=
 =?us-ascii?Q?gRbGImM9sLKK6tuN709l4knxbNuqwP30o4zVOngzww5SEmJLBLvUMDXX8ujV?=
 =?us-ascii?Q?xCWTtlBwLBFy+Bi8rY/58+bEDecS9DahG0sh3CMQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 11:40:13.9766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eae6988-9714-4f2c-161a-08de1c6015d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685

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

Expose these capabilities through cpufreq sysfs attributes that accept
frequency values in kHz (which are converted to/from performance values
internally):
- /sys/.../cpufreq/policy*/min_perf: Read/write min perf as freq (kHz)
- /sys/.../cpufreq/policy*/max_perf: Read/write max perf as freq (kHz)

The frequency-based interface provides a user-friendly abstraction which
is similar to other cpufreq sysfs interfaces, while the driver handles
conversion to hardware performance values.

Also update EPP constants for better clarity:
- Rename CPPC_ENERGY_PERF_MAX to CPPC_EPP_ENERGY_EFFICIENCY_PREF
- Add CPPC_EPP_PERFORMANCE_PREF for the performance-oriented setting

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       |  55 ++++++++++-
 drivers/cpufreq/cppc_cpufreq.c | 166 +++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h       |  23 ++++-
 3 files changed, 242 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 757e8ce87e9b..ef53eb8a1feb 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1634,7 +1634,7 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
  */
 int cppc_set_epp(int cpu, u64 epp_val)
 {
-	if (epp_val > CPPC_ENERGY_PERF_MAX)
+	if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
 		return -EINVAL;
 
 	return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
@@ -1757,6 +1757,59 @@ int cppc_set_enable(int cpu, bool enable)
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
  * cppc_get_perf - Get a CPU's performance controls.
  * @cpu: CPU for which to get performance controls.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index cf3ed6489a4f..cde6202e9c51 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -23,10 +23,12 @@
 #include <uapi/linux/sched/types.h>
 
 #include <linux/unaligned.h>
+#include <linux/cleanup.h>
 
 #include <acpi/cppc_acpi.h>
 
 static struct cpufreq_driver cppc_cpufreq_driver;
+static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
 
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
@@ -582,6 +584,68 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
 	policy->driver_data = NULL;
 }
 
+/**
+ * cppc_cpufreq_set_mperf_limit - Generic function to set min/max performance limit
+ * @policy: cpufreq policy
+ * @val: performance value to set
+ * @update_reg: whether to update hardware register
+ * @update_policy: whether to update policy constraints
+ * @is_min: true for min_perf, false for max_perf
+ */
+static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
+					bool update_reg, bool update_policy, bool is_min)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	unsigned int cpu = policy->cpu;
+	struct freq_qos_request *req;
+	unsigned int freq;
+	u32 perf;
+	int ret;
+
+	perf = clamp(val, caps->lowest_perf, caps->highest_perf);
+	freq = cppc_perf_to_khz(caps, perf);
+
+	pr_debug("cpu%d, %s_perf:%llu, update_reg:%d, update_policy:%d\n", cpu,
+		 is_min ? "min" : "max", (u64)perf, update_reg, update_policy);
+
+	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
+
+	if (update_reg) {
+		ret = is_min ? cppc_set_min_perf(cpu, perf) : cppc_set_max_perf(cpu, perf);
+		if (ret) {
+			if (ret != -EOPNOTSUPP)
+				pr_warn("Failed to set %s_perf (%llu) on CPU%d (%d)\n",
+					is_min ? "min" : "max", (u64)perf, cpu, ret);
+			return ret;
+		}
+
+		if (is_min)
+			cpu_data->perf_ctrls.min_perf = perf;
+		else
+			cpu_data->perf_ctrls.max_perf = perf;
+	}
+
+	if (update_policy) {
+		req = is_min ? policy->min_freq_req : policy->max_freq_req;
+
+		ret = freq_qos_update_request(req, freq);
+		if (ret < 0) {
+			pr_warn("Failed to update %s_freq constraint for CPU%d: %d\n",
+				is_min ? "min" : "max", cpu, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+#define cppc_cpufreq_set_min_perf(policy, val, update_reg, update_policy) \
+	cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy, true)
+
+#define cppc_cpufreq_set_max_perf(policy, val, update_reg, update_policy) \
+	cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy, false)
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
@@ -881,16 +945,118 @@ static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *po
 	return cppc_cpufreq_sysfs_store_u64(policy->cpu, cppc_set_epp, buf, count);
 }
 
+/**
+ * show_min_perf - Show minimum performance as frequency (kHz)
+ *
+ * Reads the MIN_PERF register and converts the performance value to
+ * frequency (kHz) for user-space consumption.
+ */
+static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 perf;
+	int ret;
+
+	ret = cppc_get_min_perf(policy->cpu, &perf);
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+	if (ret)
+		return ret;
+
+	/* Convert performance to frequency (kHz) for user */
+	return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(&cpu_data->perf_caps, perf));
+}
+
+/**
+ * store_min_perf - Set minimum performance from frequency (kHz)
+ *
+ * Converts the user-provided frequency (kHz) to a performance value
+ * and writes it to the MIN_PERF register.
+ */
+static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf, size_t count)
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
+	ret = cppc_cpufreq_set_min_perf(policy, perf, true, cpu_data->perf_caps.auto_sel);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+/**
+ * show_max_perf - Show maximum performance as frequency (kHz)
+ *
+ * Reads the MAX_PERF register and converts the performance value to
+ * frequency (kHz) for user-space consumption.
+ */
+static ssize_t show_max_perf(struct cpufreq_policy *policy, char *buf)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 perf;
+	int ret;
+
+	ret = cppc_get_max_perf(policy->cpu, &perf);
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+	if (ret)
+		return ret;
+
+	/* Convert performance to frequency (kHz) for user */
+	return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(&cpu_data->perf_caps, perf));
+}
+
+/**
+ * store_max_perf - Set maximum performance from frequency (kHz)
+ *
+ * Converts the user-provided frequency (kHz) to a performance value
+ * and writes it to the MAX_PERF register.
+ */
+static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf, size_t count)
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
+	ret = cppc_cpufreq_set_max_perf(policy, perf, true, cpu_data->perf_caps.auto_sel);
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
index 42e37a84cac9..be7de1222eee 100644
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


