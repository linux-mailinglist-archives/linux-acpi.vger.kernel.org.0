Return-Path: <linux-acpi+bounces-17479-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF373BB0F19
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 17:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1C11892AE1
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 15:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9765E304BB3;
	Wed,  1 Oct 2025 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ciK9xGGs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C85304BB2;
	Wed,  1 Oct 2025 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330964; cv=fail; b=PyOnZg8Lw3lZ8cAcJLcDNuVnEQS8DR5pT9t9GXkERlazb4kM1jAzvsOjch5XWhtVGNgJYQqjFmxD/PmcmlQ6q0gmfSBFf9xAZW71F/x+WY+KE7vQruWkmzF3QwwYqQo1AUzXgHJrZPSgBYLWyppEpeDtIMTm+5zxq2VXqVlze/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330964; c=relaxed/simple;
	bh=YNETxuSbbGlJHC8WVMv5YrEGu1yI5Y1+aZgXjXgeqoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8dXYx+n/Y0hGxuXGgCAjiD/Q537KPbizoyiQjrlWueEDAnp2JOMJjD+5d7s/hVIb+X4Og9f/hrFrSL7QlV9b6XCbb06N6wc/7D0laq+bECmsLjYsacZ12xImB0igUA+zikyHMRMUP9WXUYTuCv0lgH04ZAaU9YFczftga0aurk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ciK9xGGs; arc=fail smtp.client-ip=52.101.56.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNJJZVrryKghfvOGM9Qgnt/gtJoUmwltUeR5Q7lK1+6HYF1Hv5O/mZyxDY7tTfLiC/xt1GzEEUklQ038gsy9DkOk+TDru/jN8kJY9l8U8Js2jQ4/6Am9e7vWx4heQ9KIRlDCy+w2S4D7iOt3/EYKrtgJWLgr+V0mtT5EZMm/jXczmP6/dqmMTCG6hLvGYH/SGnMG9gQigbgmhA7YxQgX6mKQrZDji9DIURorKKbGUFt/Boy6qiVsP+zqVDSybwPuCvXLB+gwDSk5uKm83nMxrmco1vTCynlZF9Vz6EWCUZCITCa5jgCavORYBs/bCiA813M7kG3PlCiZ1v/WPV5E0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpOpbH3erulXBksZv9dDNnoOh5tyiZ88/zhwRPq74sY=;
 b=w+RYwcC9iuuabEat68ydCQ/K/hrRzPzvfu80m37YaFP2Xk4lyoyHUccLUm24dze/m1nbKJMtrZv5GE/l7r/BOTyA+ovEkMbDeL87yo41aoIhNJn/4DJtffcfnolwyOsDEXn9WHEv2alnXyv6PLU5V9LfBjowm/V3JMZ66+MmF5O+Pk090F9qYJAhL7Y2jVz1BOhYE4d6aiWHl/Uu0GOHcRDDs0xG7PTeiW1NR/tt1XnlJAsAw2eBG0FSz9kEB2pEh4jNX9eELSTkUKiCt2NaFXLqJdGtd6Nh9lYPlGDmMv6Nzzu9HYDUYM6ZLftVZO1QEa4NWT3DTvYQxp5yWPA/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpOpbH3erulXBksZv9dDNnoOh5tyiZ88/zhwRPq74sY=;
 b=ciK9xGGsNT2gF57MdtNNEJNTiP8b2jCCbN4bwbKs5cg8ABnFVkBymTJ6YuFnOwoTIqH11pXwnhV82KKLG06zIOOWpowdYOVoPn+ZEU8oNUIQMsPqVuPqpdyKBMJmsp2nnL/k9CCKW0hX9H/GhvLer0ayYxsZRpCOMMt9OAcM4Ye3TQ8h8CgoSHHPziJ03I8IkAMUWhtH59fGVnk1kvhz8ftaegU6Y/PY6W391VmZcYRfJux0Z2G84uV7D8G1eiV9fEZ97Fec7G3Xdlx7ihubdvK/yKPbom+VTYqUmfEPRPtbasO1PUdk2cjQmCsc3iYfPwWjz42TqXMaK+Dr4ddbSg==
Received: from MN2PR20CA0066.namprd20.prod.outlook.com (2603:10b6:208:235::35)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Wed, 1 Oct
 2025 15:02:27 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::98) by MN2PR20CA0066.outlook.office365.com
 (2603:10b6:208:235::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.18 via Frontend Transport; Wed,
 1 Oct 2025 15:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:02:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 1 Oct
 2025 08:01:59 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Oct
 2025 08:01:59 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Oct 2025 08:01:52 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <rdunlap@infradead.org>, <ray.huang@amd.com>,
	<gautham.shenoy@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 4/8] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
Date: Wed, 1 Oct 2025 20:31:00 +0530
Message-ID: <20251001150104.1275188-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001150104.1275188-1-sumitg@nvidia.com>
References: <20251001150104.1275188-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: adc3413c-82c0-41a9-9e11-08de00fb8823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?meWcb29jOXGUnDQvYOwiU+PYBLw0s7VoPwkzOKRkesF2Tb8eCwYnF0Qau+dr?=
 =?us-ascii?Q?0f+o+DlZNdEi7O2YZ7Em38rFKCyRz6pfajS1rpOIayW/nedN+j/NaRK4GZye?=
 =?us-ascii?Q?veWUApAv8uLqK/dSTps1+FGZqrTLzsjL165vmALcM9J2PckZgt6z0fPdAIgB?=
 =?us-ascii?Q?AxUQVpGmnEbOMIpnJTLv0metRWovnNDfwxXCs8MVjurKrmBH+wNHHgIEBCEk?=
 =?us-ascii?Q?qM9IjKEevB3HuDMJywfrkjf2n/ozCkgaKc/7q7JHekrWdf3NAo7hYmyTWT9O?=
 =?us-ascii?Q?jXDlNFArLmGcq2WoLSCJfW+81tjTVxSat8x6kOWrihRBQMgBzEq+AyYIxyu3?=
 =?us-ascii?Q?DLM0ykyVdg/GO4htGXw9BabDq3nuwqKMadzLqQD+Mn33M5vvlF4QAWZOvzH3?=
 =?us-ascii?Q?emAB1+YtKVStSVFSQkN0Ft26qUtUsKwixyJBt9BrXT2tfCt0le0GY16Z2gNK?=
 =?us-ascii?Q?6kmg8qblGFbHoZpE3F9KumD3+tI6RIQJKC6qOppmW4sb3SFPKciqJSQuyLH9?=
 =?us-ascii?Q?MV1k+TrbUred8EjidLOWr4wrw7jXjcPTU4S64FqXYQhEPNGSkngnY+EH6xLG?=
 =?us-ascii?Q?KyHzMcOV7vSRe+LDHdc64wq8rBaCOOGBVSqlVTnBPEwu7SXdOOEoxwN7BsMW?=
 =?us-ascii?Q?uenbsFn86FTkagxjr1jGy4MKWwX7Nf4JxWK0VRFheMGs+cMB4g+t9h+GOpSK?=
 =?us-ascii?Q?MjMuPNKj28o3wDn0mC0jGq8yJHW56OA9tLuot4h5gWiAz7SJMONINLPtm0pM?=
 =?us-ascii?Q?y53hQYHzIxchA0m+9pqQu1S+jlpYY5S7xbehmbcK09kFHXTdWMyG1WH1WUMd?=
 =?us-ascii?Q?p63+R2pnC0FIe9lQnvE2OJ7eCyyZVLQu+HwVICXHLt5iHb9mTGNkbVyffGnv?=
 =?us-ascii?Q?BLR73pBEUKvzBsSFUPsDWqStqzzu8qmOOpzZlxAhaTgaYQkGckjm1+5caLDD?=
 =?us-ascii?Q?PLTAK3FWJms3oVHCDezn12rtaazzmoCodKEbD0U6+taNeq0+Gw9u43llzjYD?=
 =?us-ascii?Q?S/rjMQIuh5iAT9PW11rq3KtfIh/Qs/rXylLMxmUQmyDAlXotxb3lC0ZIPLq+?=
 =?us-ascii?Q?OeXkQDcqhmJkWPksYPRFsQGROfIYWOSCe3/iI/MxFsFdC0XuEUIwvmkdr+6q?=
 =?us-ascii?Q?+ereMMEH+uAdbr4lifq+kf/5sTXprnzKg7N3zyhttGSnBdrFdWawWrrFvCCV?=
 =?us-ascii?Q?0kOX4yYwX9ZQnBNk05HvNgyR/AbeC1nuIWwUoSyPnJM2bPCNjKzB8pGMTGPQ?=
 =?us-ascii?Q?YByi00MIVJCoCYJFRTkGCP69HBcaT/tBBejNAYvVy9G69r4qpr5O80kGMJwN?=
 =?us-ascii?Q?50vmwktXe0NwBpgNSeG1+56O1x9xljHJJGPJbQE7OuPwwQGWetujmlfB2zpw?=
 =?us-ascii?Q?naPOXokoCHCWrIsBKq6kJ1NaapnU5JcWp8cghA7Hmtak/wiWHKNbvp2c3O9l?=
 =?us-ascii?Q?pt+k3EQHfbYzzGzKdipjEi1Ku3BGQ3yJgsVHlsvLJELt6DJ3INwlJn/rP5U8?=
 =?us-ascii?Q?r921Fa7vMHJt+QB5IrQCP82j7i4tV7p2gvqogUuIsSy21m946Dv9nSTpm04o?=
 =?us-ascii?Q?2QPCDbNR5/Z7qOY0j5M7YsTctQTm/u7j3flVRfaJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:02:25.2055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adc3413c-82c0-41a9-9e11-08de00fb8823
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

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
 drivers/acpi/cppc_acpi.c       |  55 +++++++++++++++-
 drivers/cpufreq/cppc_cpufreq.c | 115 +++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h       |  23 ++++++-
 3 files changed, 191 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 12b2516b971c..d47aec2aed13 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1630,7 +1630,7 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
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
  * cppc_get_perf - Get a CPU's performance controls.
  * @cpu: CPU for which to get performance controls.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 732f35096991..864978674efc 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -23,6 +23,7 @@
 #include <uapi/linux/sched/types.h>
 
 #include <linux/unaligned.h>
+#include <linux/cleanup.h>
 
 #include <acpi/cppc_acpi.h>
 
@@ -38,6 +39,8 @@ static enum {
 module_param(fie_disabled, int, 0444);
 MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");
 
+static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
+
 /* Frequency invariance support */
 struct cppc_freq_invariance {
 	int cpu;
@@ -572,6 +575,70 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
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
+		if (ret == -EOPNOTSUPP)
+			return 0;
+		if (ret) {
+			pr_warn("Failed to set %s_perf (%llu) on CPU%d (%d)\n",
+				is_min ? "min" : "max", (u64)perf, cpu, ret);
+			return ret;
+		}
+
+		/* Update cached value only on success */
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
@@ -873,16 +940,64 @@ static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *po
 	return cppc_cpufreq_sysfs_store_u64(buf, count, cppc_set_epp, policy->cpu);
 }
 
+static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
+{
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_min_perf, buf);
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
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_max_perf, buf);
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
index 3babc6d6e70a..fc7614eb9dcb 100644
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


