Return-Path: <linux-acpi+bounces-17484-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2266CBB0F6D
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 17:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0735516549F
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40437308F31;
	Wed,  1 Oct 2025 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p/VMc1TX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333723081BF;
	Wed,  1 Oct 2025 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331005; cv=fail; b=SGAMWZBFXB9d4ENSHjvLhU1D0B+AsgMpPkyV45iK+ceW/ENPSZ1amu752VTd55QAj2PcXiNLqkVU6eTI1XflZ0DzR57AdxdzLpyE2H8LApYVsJB76EF/mXxrq0q37Uk9964HTEmBfNrU6kpsJDFqBgI/MkF8jgm7m7obo7F8BJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331005; c=relaxed/simple;
	bh=RZBfNAP5PxpzsjhNd6Vo3+74uKc0LhOW5yhmKbmp+Ps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRkX3x9Cg32YmKIH+jm/gc6u0UlRp2xatDwwV5IrNqhrsgRmIxp0wwzql5mtYx/4tmYJwDQSqfqQj3mN+sbEx63spW9yK8Fb4RG17m0tCW9a7c7h0k11wGHpKk0ec7grAkvT8z7c0f0cvHvd8L1enYBRzecsD1vQkoMSyWWkELw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p/VMc1TX; arc=fail smtp.client-ip=52.101.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYA+0Dyv/O8oTEf6zY5UEyb0Do5/dS+GpWPJ1pL5Mo/dtU/ZNRw57y2NAHEMehDrwxTe/HeKZb+RP7nz/0Swt+xmCnTEK1a0QJS3AphAG53fC+KXnAcF6VCB7UIclxwXyQmUnLYiHf2gIBe1AtORuUIUmzlKWnykk3o/yupVBzeMjRQGODnXao28sllmQ/j7Ay5sFd8jB3g5kD0o56YM/axRzuDMYoHXCokrLLZvUi9xnFTQ8E7eXOrjyrtsTS6TINmWbQjyh2CRN4OxgeYJ8lTVMfloTFE8gxY/zdD7q5I3Zfvxg4KT1D9TQIXW5ADaiISy6eGYSI42UEUa/JKWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY7/zH9uaici0RmxLrCLn4hHMhc22Jp3a9xHvklFHFY=;
 b=A1iWRR+ryum/KS70QkbmpmPjh6ThKNVxE8bDu4ny879L17AazzkcAI2QVOrGz++hGS/AszJ6UOFzVsqwBZK/IzY9386CHVeClblCKdY+FhsQfVY29fROKcl9bjtA+eL0FphcMYRq75/xGDVkC32hlokjWSvLHtNtQyeBO7s4yadA30oHwtOer6NVK/TSXb8Fe0SvQqQAjXkOEFa3gWGi9dugCHssOxczoMLWBOstc6JlBqWcAB5cxjzVPmkG5COH2SdsWt7qQFJghyeDx2ba19SRscZfUALgXA5iqHuCRpX9zcZ6fXb/uzNWAgDk/q+IlSvol7HyhjWG/MBvsocZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY7/zH9uaici0RmxLrCLn4hHMhc22Jp3a9xHvklFHFY=;
 b=p/VMc1TXdYSErfoOK2t2PnHYmeFR610yStl5G8HZCagI8Znic7dHrPvfPtsrH0iOn5ofXDLg51UUVn8iJJc408pE1NdPDr3NjqSBREmfYsH9xCvIIVgQYlGcc30KeplHiKD10v+rxSUwZY7Sh5ANqCAf1bhqk2gbFsxV1lcziJvGjdvEE9k41JiexQwyqby9JzvDNV33DE9wZBr01E797tQ766ZgpUuWfAxC66nfVdAm/vXOmawiyU3dyVxOZ/sFqBkGqiZr6jSU+JnOY8GwJPRGLgm67K7XA8Dvx8aoTirxzjiaP2s4NDodLlB7rsqmr+WLc68MkhpjOpRKznMg+A==
Received: from MN2PR15CA0005.namprd15.prod.outlook.com (2603:10b6:208:1b4::18)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 15:03:15 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:1b4:cafe::f6) by MN2PR15CA0005.outlook.office365.com
 (2603:10b6:208:1b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:03:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 1 Oct
 2025 08:02:52 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Oct
 2025 08:02:51 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Oct 2025 08:02:44 -0700
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
Subject: [PATCH v3 8/8] cpufreq: CPPC: add autonomous mode boot parameter support
Date: Wed, 1 Oct 2025 20:31:04 +0530
Message-ID: <20251001150104.1275188-9-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 04df0b47-98bd-4a7e-2866-08de00fba5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gj/kRK9JLN6KfmhtiHr0cuiJxSUDUaak1/nU+rk9xyNIcD3EyZQmnq0CaZfp?=
 =?us-ascii?Q?P9G0UNOudYSXul7q/yUO1kMvS0QqVLDzkToPLz4MRiixmZWr6XHXW81lCanC?=
 =?us-ascii?Q?G+nX06qSpn5Wvwraz2kNsluMBPVwSuywLl2EsOIjbsMl6rhplLussDWsr3Js?=
 =?us-ascii?Q?EMEZAYxMJCrhG6Wc8BgRe9oj+7BlXOaUuuSVtykG4mNeGW8gsznxclbkM3Ke?=
 =?us-ascii?Q?46D+ccAbT7x10s6zf6cbzuAnpSKiSC0KhqARHlNUXUsb7CuZ0yoqwUAh6cKq?=
 =?us-ascii?Q?7EY3UWGRdfBoeOinCNms72ozSRsRHywwdYtOvWxyA0f81pX5y3T01zs0s+H2?=
 =?us-ascii?Q?CWF4m3iusEmquiLDaGdOxOyEaz6ivK4BpNF/xCaV3cja1R0Tmo/vd6C/9iGW?=
 =?us-ascii?Q?JI41IK2dLT0Nq2Y6d/csH9GPzJ8hq/JCfoR8YDnOl8nuOo96DqIoI0GDtL3h?=
 =?us-ascii?Q?DlhfGinljb7ififcnAxv7zpCxWoeeeIqxyn8HHpx0rsuj8S+cNUPvvLe8YPg?=
 =?us-ascii?Q?WuGvZqYqyYicULreUKsVrt/sJwufaSHpz+ta/CsR5UfNFCl5cU9OeT9mJruR?=
 =?us-ascii?Q?ncHRHSCqVigOQKxF9x97g46Ung4vTTWrtDvSUHPSgC31VYKBumtpuR9GvOpX?=
 =?us-ascii?Q?7FdRGQXP8EVWR6YFNk5bZsqSqRELmMha9GQmklmCnGZKOa8h7ATUkBSxM8q3?=
 =?us-ascii?Q?/Qc/G6twgO28RRUCGfCJ6zzX9Hx7ATSQCnebdt7CG6NY3Au6ueF0kUrzyNdv?=
 =?us-ascii?Q?JaNmeyo6CRwsYptVK+wOvIcfs7V+pAeQkPviYkdZlc0W3eAiuE4eSW1H6Ee6?=
 =?us-ascii?Q?j+FYmbamGu+rsR0km5KjkzP1MFGsxwdp35jHbVgKCioXSBUnmfupvSiZYCjP?=
 =?us-ascii?Q?eLPfeG9SPb3puiwgA8TP9n6BfilMslsm1AVo6dHX6PEMu1mgzjLl7gyF9uFn?=
 =?us-ascii?Q?Ez8puD/LmZj6euSqq7MbXi6N6/QYYEwCoO8OFZOQUzvd9SiB0AQaxWfHpDd2?=
 =?us-ascii?Q?yUc4xk0seMfhSmG4/dgPRBKbmq4YEBa5tWGY0YQichp/CauJ5OKcfHvlusOH?=
 =?us-ascii?Q?hXPiRYUgv5txS0tI+onMhEj1yUc2oLLnFuxhARF8yVYU6YX/ueKLDUh80amS?=
 =?us-ascii?Q?606R8C1ItjMlmWx4EkmeXkg8N3A9gNCzkIiHCdpKgS452O8RtHUY/OpS0FWQ?=
 =?us-ascii?Q?n/3uC0r89vC/g4lwGxd1FWn4E+lsp+jWLgk5UNllEcJ1r30WpLFkp72tC5sH?=
 =?us-ascii?Q?L7A7a68zvd1yuTODe+vU/GIe7aknT+lU92C7jJQgEzezMyT/Ut4BqvfbC83z?=
 =?us-ascii?Q?dfYgenAOT4aEKPkhryJQHPyWhRzl9C3TiwAokH1/n0RqvDxXMo7Bo4sbX4ZU?=
 =?us-ascii?Q?m+ah0hXvVo/8Sj+miJEXItsxMNHrEdSiqdKkDH/vvLg5TZBVFDl+a2ZjrfPk?=
 =?us-ascii?Q?NGCzjIW3lt+AXNjuc9Er8PDSppPq2gIHHu0XffGoLQORBYwy3uG/AWyNVmqY?=
 =?us-ascii?Q?tilPX9PPIDpTeGJkVkKW57AtsRgB3O0swz3uS44UWGo4yJaL2FF45w6Kjji+?=
 =?us-ascii?Q?ez8YBydUgRsKNVPCauW6/W5L/nkGBp7iPhcL1IUj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:03:15.2450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04df0b47-98bd-4a7e-2866-08de00fba5f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404

Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
autonomous performance selection at system startup. When autonomous mode
is enabled, the hardware automatically adjusts CPU performance based on
workload demands using Energy Performance Preference (EPP) hints.

This parameter allows to configure the autonomous mode on all CPUs
without requiring runtime sysfs manipulation if the 'auto_sel' register
is present.

When auto_sel_mode=1:
- All CPUs are configured for autonomous operation during module init
- EPP is set to performance preference (0x0) by default
- Min/max performance bounds use defaults
- CPU frequency scaling is handled by hardware instead of OS governor

For Documentation/:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         |  12 +
 drivers/cpufreq/cppc_cpufreq.c                | 205 +++++++++++++++---
 2 files changed, 192 insertions(+), 25 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1b2131d003ce..94950340851e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -911,6 +911,18 @@
 			Format:
 			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
 
+	cppc_cpufreq.auto_sel_mode=
+			[CPU_FREQ] Enable ACPI CPPC autonomous performance selection.
+			When enabled, hardware automatically adjusts CPU frequency
+			on all CPUs based on workload demands. In Autonomous mode,
+			Energy Performance Preference(EPP) hints guide hardware
+			toward performance(0x0) or energy efficiency (0xff).
+			Requires ACPI CPPC autonomous selection register support.
+			Format: <bool>
+			Default: 0 (disabled)
+			0: use cpufreq governors
+			1: enable if supoorted by hardware
+
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index c888733ce5da..8deb51d6bc2c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -28,6 +28,8 @@
 #include <acpi/cppc_acpi.h>
 
 static struct cpufreq_driver cppc_cpufreq_driver;
+/* Autonomous Selection */
+static bool auto_sel_mode;
 
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
@@ -273,6 +275,14 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
+	/*
+	 * In autonomous mode, hardware handles frequency scaling directly
+	 * based on workload demands and EPP hints, so OS frequency requests
+	 * are not needed.
+	 */
+	if (cpu_data->perf_caps.auto_sel)
+		return 0;
+
 	cpufreq_freq_transition_begin(policy, &freqs);
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
@@ -556,6 +566,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 		goto free_mask;
 	}
 
+	ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
+	if (ret) {
+		pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
+		goto free_mask;
+	}
+
 	return cpu_data;
 
 free_mask:
@@ -659,11 +675,79 @@ static int cppc_cpufreq_update_autosel_val(struct cpufreq_policy *policy, bool a
 	return 0;
 }
 
+static int cppc_cpufreq_update_epp_val(struct cpufreq_policy *policy, u32 epp)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	pr_debug("cpu%d, epp curr:%u, new:%u\n", cpu, cpu_data->perf_ctrls.energy_perf, epp);
+
+	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
+
+	ret = cppc_set_epp(cpu, epp);
+	if (ret) {
+		pr_warn("failed to set energy_perf for cpu:%d (%d)\n", cpu, ret);
+		return ret;
+	}
+	cpu_data->perf_ctrls.energy_perf = epp;
+
+	return 0;
+}
+
+/**
+ * cppc_cpufreq_update_autosel_config - Update Autonomous selection configuration
+ * @policy: cpufreq policy for the CPU
+ * @min_perf: minimum performance value to set
+ * @max_perf: maximum performance value to set
+ * @auto_sel: autonomous selection mode enable/disable (also controls min/max perf reg updates)
+ * @epp_val: energy performance preference value
+ * @update_epp: whether to update EPP register
+ * @update_policy: whether to update policy constraints
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
+					      u64 min_perf, u64 max_perf, bool auto_sel,
+					      u32 epp_val, bool update_epp, bool update_policy)
+{
+	const unsigned int cpu = policy->cpu;
+	int ret;
+
+	/*
+	 * Set min/max performance registers and update policy constraints.
+	 * When enabling: update both registers and policy.
+	 * When disabling: update policy only.
+	 */
+	ret = cppc_cpufreq_set_min_perf(policy, min_perf, auto_sel, update_policy);
+	if (ret)
+		return ret;
+
+	ret = cppc_cpufreq_set_max_perf(policy, max_perf, auto_sel, update_policy);
+	if (ret)
+		return ret;
+
+	if (update_epp) {
+		ret = cppc_cpufreq_update_epp_val(policy, epp_val);
+		if (ret)
+			return ret;
+	}
+
+	ret = cppc_cpufreq_update_autosel_val(policy, auto_sel);
+	if (ret)
+		return ret;
+
+	pr_debug("Updated autonomous config [%llu-%llu] for CPU%d\n", min_perf, max_perf, cpu);
+
+	return 0;
+}
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
 	struct cppc_cpudata *cpu_data;
 	struct cppc_perf_caps *caps;
+	u64 min_perf, max_perf;
 	int ret;
 
 	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
@@ -727,11 +811,31 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
-	if (ret) {
-		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 caps->highest_perf, cpu, ret);
-		goto out;
+	if (cpu_data->perf_caps.auto_sel) {
+		ret = cppc_set_enable(cpu, true);
+		if (ret) {
+			pr_err("Failed to enable CPPC on cpu%d (%d)\n", cpu, ret);
+			goto out;
+		}
+
+		min_perf = cpu_data->perf_ctrls.min_perf ?
+			   cpu_data->perf_ctrls.min_perf : caps->lowest_nonlinear_perf;
+		max_perf = cpu_data->perf_ctrls.max_perf ?
+			   cpu_data->perf_ctrls.max_perf : caps->nominal_perf;
+
+		ret = cppc_cpufreq_update_autosel_config(policy, min_perf, max_perf, true,
+							 CPPC_EPP_PERFORMANCE_PREF, true, false);
+		if (ret) {
+			cppc_set_enable(cpu, false);
+			goto out;
+		}
+	} else {
+		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+		if (ret) {
+			pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
+				 caps->highest_perf, cpu, ret);
+			goto out;
+		}
 	}
 
 	cppc_cpufreq_cpu_fie_init(policy);
@@ -933,7 +1037,6 @@ static int cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	u64 min_perf = caps->lowest_nonlinear_perf;
 	u64 max_perf = caps->nominal_perf;
-	int ret;
 
 	if (enable) {
 		if (cpu_data->perf_ctrls.min_perf)
@@ -942,24 +1045,8 @@ static int cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
 			max_perf = cpu_data->perf_ctrls.max_perf;
 	}
 
-	/*
-	 * Set min/max performance registers and update policy constraints.
-	 * When enabling: update both registers and policy.
-	 * When disabling: update policy only.
-	 */
-	ret = cppc_cpufreq_set_min_perf(policy, min_perf, enable, true);
-	if (ret)
-		return ret;
-
-	ret = cppc_cpufreq_set_max_perf(policy, max_perf, enable, true);
-	if (ret)
-		return ret;
-
-	ret = cppc_cpufreq_update_autosel_val(policy, enable);
-	if (ret)
-		return ret;
-
-	return 0;
+	return cppc_cpufreq_update_autosel_config(policy, min_perf, max_perf, enable,
+						  0, false, true);
 }
 
 static ssize_t store_auto_select(struct cpufreq_policy *policy, const char *buf, size_t count)
@@ -996,7 +1083,18 @@ static ssize_t show_energy_performance_preference_val(struct cpufreq_policy *pol
 static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *policy,
 						       const char *buf, size_t count)
 {
-	return cppc_cpufreq_sysfs_store_u64(buf, count, cppc_set_epp, policy->cpu);
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = cppc_cpufreq_update_epp_val(policy, (u32)val);
+	if (ret)
+		return ret;
+
+	return count;
 }
 
 static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
@@ -1085,13 +1183,61 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.name = "cppc_cpufreq",
 };
 
+static int cppc_cpufreq_set_epp_autosel_allcpus(bool auto_sel, u64 epp)
+{
+	int cpu, ret;
+
+	for_each_present_cpu(cpu) {
+		ret = cppc_set_epp(cpu, epp);
+		if (ret) {
+			pr_warn("Failed to set EPP on CPU%d (%d)\n", cpu, ret);
+			goto disable_all;
+		}
+
+		ret = cppc_set_auto_sel(cpu, auto_sel);
+		if (ret) {
+			pr_warn("Failed to set auto_sel on CPU%d (%d)\n", cpu, ret);
+			goto disable_all;
+		}
+	}
+
+	return 0;
+
+disable_all:
+	pr_warn("Disabling auto_sel for all CPUs\n");
+	for_each_present_cpu(cpu)
+		cppc_set_auto_sel(cpu, false);
+
+	return -EIO;
+}
+
 static int __init cppc_cpufreq_init(void)
 {
+	bool auto_sel;
 	int ret;
 
 	if (!acpi_cpc_valid())
 		return -ENODEV;
 
+	if (auto_sel_mode) {
+		/*
+		 * Check if autonomous selection is supported by testing CPU 0.
+		 * If supported, enable autonomous mode on all CPUs.
+		 */
+		ret = cppc_get_auto_sel(0, &auto_sel);
+		if (!ret) {
+			pr_info("Enabling auto_sel_mode (autonomous selection mode)\n");
+			ret = cppc_cpufreq_set_epp_autosel_allcpus(true, CPPC_EPP_PERFORMANCE_PREF);
+			if (ret) {
+				pr_warn("Disabling auto_sel_mode, fallback to standard\n");
+				auto_sel_mode = false;
+			}
+		} else {
+			pr_warn("Disabling auto_sel_mode as not supported by hardware\n");
+			auto_sel_mode = false;
+		}
+	}
+
 	cppc_freq_invariance_init();
 	populate_efficiency_class();
 
@@ -1104,10 +1250,19 @@ static int __init cppc_cpufreq_init(void)
 
 static void __exit cppc_cpufreq_exit(void)
 {
+	int cpu;
+
+	for_each_present_cpu(cpu)
+		cppc_set_auto_sel(cpu, false);
+	auto_sel_mode = false;
+
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 	cppc_freq_invariance_exit();
 }
 
+module_param(auto_sel_mode, bool, 0000);
+MODULE_PARM_DESC(auto_sel_mode, "Enable Autonomous Performance Level Selection");
+
 module_exit(cppc_cpufreq_exit);
 MODULE_AUTHOR("Ashwin Chaugule");
 MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
-- 
2.34.1


