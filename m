Return-Path: <linux-acpi+bounces-15997-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 589E5B32BE8
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 22:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E9E1BC7F34
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 20:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263B92EBB9A;
	Sat, 23 Aug 2025 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tvmAUZew"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65E2EB5CF;
	Sat, 23 Aug 2025 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755979382; cv=fail; b=SqsMbKpp0gPcjD3xeFJOIcbCmtW6WtBpg9bo/s1jXaYN8RpoW145uFgLCslHHA9O4vt42TzHaCEwwPyRCoHjv/+/pxOx2Z6a1+ko74X3lmdjUwmGfK0f4UOexxU4wZdu5JNOKSEedkFKh8XhmQeYVxDwxevFSBfkqczqv4DvPdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755979382; c=relaxed/simple;
	bh=yiDfua7Ew1rSPNnyTDbc0fsAU8u2FBkLVJIe+YtSExc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNH7nuaq8XasxsWel/VD7QPbxBOV7JM8JFhvhvV7wOvdHGNgIat8fAX+vN+ATNLTMWgrl64UA0ZBmesoeV5RTIMVaLkTpCQdFtdoyZs5uVFBYTfmeGew7XW2Px0H3WKX5cvtXWX1sWB8AsImLLZ8cJY8Di3byzj35uSeVyhWZ3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tvmAUZew; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8Q+kTsOKzDQKBaldNmkzlItFyUHletlXKDSRtv3dHwxqGLGrdNmK+GK+RLEPN4E/X/IlfMBRKT+chHEkq53iSU1lWpkLB3PSQE15TQr43VOm15gKl5RYpPgeScV4e5/oWPctf7eRfCNNOOL9q1wjEjsHSzco9002HG9NRoBe2THcmVHqx/yO+aMkq1fw7kJtYL8yP6ZKA04ciVWXpKyoJXeUpK0atkL75n150A/4jIbHL/VHS1/CkCn6ToLMDk2VUrzCjuglcqNf+VGuG5WVNVMDtd7/0LcpGbWPXSWLx2RB9NAWFQIWmolMLOUNM/OqPLjUfuiTsT8bT00aHSboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VBrfRT6iQBgvoXiW7QCL3sVooDbbOIumyaXtBRYSio=;
 b=cRIYDrtFaUiF1XCiotHTZcRnwQhbSK1o4vfU3Uaom363lYSZkKMDnHn/t8OrVD5XDjR/DIpZBQOC0HVpK4UCXWKib9MCCjn/jmaf7FjoEVJQtZFXe1Fmho8v1CPgKOMHmJvUBrAejJzxPKBsrVaSQ4GEEvyi7OSEw/Yc+i8QOCjrfYxfAAhtVdgFp6EypGL8ZX50I6b/8sboWRwKtDQIlUi2YqIXOgN266igNiUCEGxJ8YDG9ujITIbC9pihp/qR4z5ejFAW+4OaaUOc4I9VWHFU/SgJPeJIWAS29NVTiCOwAtbfEwAgSwfMFjYWubGW1raSWKWWGAj/H/o4Cw8MyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VBrfRT6iQBgvoXiW7QCL3sVooDbbOIumyaXtBRYSio=;
 b=tvmAUZew2BjkwFB3S/yqUpCQ7u6j8kmSqUA7lg0PzU3VlgO9SCdx5n23IMjnh4RI0xDq5nqBI2FOHJr2cnGhsv0QxMCLfbh87h8RFQc7q7N7yG2ORfHMZ1uQ9UhyrP5SAvru1G6ZZpDxMuP5M5kVDQyvC15y+pQqJm0sURAdX200Ieu2UPzh9YL//xaeMKobADr2mHlgmrg48TNDTFsztW3rkwSPfCWd+sy0cL9i5q734gg2rmfVxH0ofomO+/Pi2rtyI2Fr/15lCzpTC2XN/aIwrWNkPJ2JKh2/0QF42HmF39pHzhERB9rCKKQRaARv1r9ikH1/dF4OKqfyG7VUkA==
Received: from BN8PR16CA0013.namprd16.prod.outlook.com (2603:10b6:408:4c::26)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sat, 23 Aug
 2025 20:02:53 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:4c:cafe::8c) by BN8PR16CA0013.outlook.office365.com
 (2603:10b6:408:4c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Sat,
 23 Aug 2025 20:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sat, 23 Aug 2025 20:02:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:02:37 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:02:36 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 23 Aug 2025 13:02:30 -0700
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
Subject: [PATCH v2 7/7] cpufreq: CPPC: add autonomous mode boot parameter support
Date: Sun, 24 Aug 2025 01:31:20 +0530
Message-ID: <20250823200121.1320197-8-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ca3b96-6d77-4a26-297b-08dde2800b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9bqmNJct1E/K8E4yEID+1wzxP70FnDUAGWw3IAIcO2TmUvUUj2c2HDthjvZM?=
 =?us-ascii?Q?I1Nq3MowXSC2Yb2clgTjV+ieLo5fmCKuGQWQO+TEjFfwZrxgSndjFQkO1XUw?=
 =?us-ascii?Q?HfrwEfsxkn7OMfvhYLhs8cNibLrqqlNg/N+0hGi4hCYorrqZT8kMDBsLlpzC?=
 =?us-ascii?Q?us3XunJFKqlMMnL/kxFNePRqniTsbbJuP5fmSgV7wzjNt6WTKVH+FbhGMmpX?=
 =?us-ascii?Q?+cUY76VIQq1sdY3moe9mVIdigvsK5z+hpg7t5bacjwzYfua2ffnHtkXnNWKc?=
 =?us-ascii?Q?N2FwxMIDVtGWuUJe1W1jQNP4cf20HVueDNgtsZngD43xCQVMD4WYGlYHeNfY?=
 =?us-ascii?Q?uQrC/ffB4AObAdyzF2rAHNoCvyYDgXikr5XndcQzTsTtXz70kUdBpUlrxU9k?=
 =?us-ascii?Q?y2pfJqgbaC/Q68cag1jSn3f9YubhhrWS5EfHwgvv7jvObY1PsoOFxL8C1FCz?=
 =?us-ascii?Q?ryYcZpU+cyvEXpuszZg7LcSRRtnGqEKNoly97Q2eK/3sP8yrp43WmAmVTFyp?=
 =?us-ascii?Q?SjYiQEJE69E+/UwsuRWUOA0SIpdFJgOrHcjygBVU3ZftzhdasjKmgQVd1ABT?=
 =?us-ascii?Q?CmRY7M/UJmUVnbqD1GQG9XMwU3BaGz3HV2zin0XI/rs/T9gzkWy2vPSza5zI?=
 =?us-ascii?Q?pNby1RpvK5v9JeDTxNbpXipLS2uYljHLZZUO2qbS9Tg9TzDogwQq3TR0mfSc?=
 =?us-ascii?Q?N210JCTeBS39GfUmphlQscxcfLkxsWwY+XtJLaH+6JAYU1LhOP3hxb2ZM4wW?=
 =?us-ascii?Q?akN7lkIBqyjhQZhuoOdhiz1PWB4GwTHds3YRf6IO6jlY0m/BW2M6t+ZV1skg?=
 =?us-ascii?Q?C46m6NFNfDCOEijfaNkdFMC3cbjE+Z36QR2t6eIXojsSZPPiG5q+9I+Zox13?=
 =?us-ascii?Q?ORlZUi31SAkN31H8Igfs9xq/rdPf9bx9EagF4+9tpqgbVLdZCo8WaUCP+8b4?=
 =?us-ascii?Q?2Dzv1RwBgTotD3uPg3WkvqoboTv/D9J0ozsaUMguKzWKbLz4M1suCXKBIBxs?=
 =?us-ascii?Q?Eu0lKVi98qZ9WkTpWUp+V5GwB5IhJMBW7ZgVlMDeSftPxlhfesG8lRWFkT2B?=
 =?us-ascii?Q?A8/9upAajerMsf2rvwJVopYGrsUdMYzFYHqHvbtoSZxcAy0QhrKR0an7noTq?=
 =?us-ascii?Q?Qbhw3Wedmp76HcqkiP95OVycruFLMLTDYYIWRfJywso3OrS+p7vmk2s2+FxH?=
 =?us-ascii?Q?4410LR6gHiyFN2H5A+U+onNLhd1O2PA/kvtDowpfR2/jxCSNwJX5xTfkuvqu?=
 =?us-ascii?Q?6ddLhQwiziIN89q7r/WzK2CQLQkz3haTJ8EF4M3zkZBRp3Eq+n544ZkH4B9D?=
 =?us-ascii?Q?ltXj42agzhhkLXWcr8KSskJ9/s2MisKzlhVuzlOeJE2NSahs7w/FXLvJ+iS0?=
 =?us-ascii?Q?DU+XklQ/9Mpf2tHmSOr4am3MxXQeSf5UYh73/4ydxLYdi8fjrO1B9pWWqAx5?=
 =?us-ascii?Q?cOao4Mqi1lI1ifbQtmjR/I8d1Mlp1WGfkOMgfwdvBnhbuI3OhmvigYktzyhe?=
 =?us-ascii?Q?bbD3aMbwSfUyQc/XY2r9g6DCptVhC0HFrjbhEWqeXO4joIe4luXmsymG7g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 20:02:52.7670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ca3b96-6d77-4a26-297b-08dde2800b48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197

Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
autonomous performance selection at system startup. When autonomous mode
is enabled, the hardware automatically adjusts CPU performance based on
workload demands using Energy Performance Preference (EPP) hints from
the OS.

This parameter allows to configure the autonomous mode on all CPUs
without requiring runtime sysfs manipulation if the 'auto_sel' register
is present.

When auto_sel_mode=1:
- All CPUs are configured for autonomous operation during driver init
- EPP is set to performance preference (0x0) by default
- Min/max performance bounds use defaults
- CPU frequency scaling is handled by hardware rather than OS

Also ensure that when autonomous mode is active, the set_target callback
returns early since hardware controls frequency scaling directly.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         |  12 ++
 drivers/cpufreq/cppc_cpufreq.c                | 171 ++++++++++++++++--
 2 files changed, 168 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 86f395f2933b..ea58deb88c36 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -911,6 +911,18 @@
 			Format:
 			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
 
+	cppc_cpufreq.auto_sel_mode=
+			[CPU_FREQ] Autonomous Performance Level Selection.
+			When Autonomous selection is enabled, then the hardware is
+			allowed to autonomously select the CPU frequency.
+			In Autonomous mode, Energy Performance Preference(EPP)
+			provides input to the hardware to favour performance (0x0)
+			or energy efficiency (0xff).
+			Format: <bool>
+			Default: disabled.
+			0: force disabled
+			1: force enabled
+
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 5e1bbb5f67b8..bbf654c56ff9 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -27,6 +27,8 @@
 #include <acpi/cppc_acpi.h>
 
 static struct cpufreq_driver cppc_cpufreq_driver;
+/* Autonomous Selection */
+static bool auto_sel_mode;
 
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
@@ -272,6 +274,14 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
+	/*
+	 * In autonomous mode, hardware handles frequency scaling directly
+	 * based on workload demands and EPP hints, so OS frequency requests
+	 * are not needed.
+	 */
+	if (cpu_data->perf_caps.auto_sel)
+		return ret;
+
 	cpufreq_freq_transition_begin(policy, &freqs);
 	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
 	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
@@ -555,6 +565,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 		goto free_mask;
 	}
 
+	ret = cppc_get_perf_ctrls(cpu, &cpu_data->perf_ctrls);
+	if (ret) {
+		pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
+		goto free_mask;
+	}
+
 	return cpu_data;
 
 free_mask:
@@ -642,6 +658,79 @@ static int cppc_cpufreq_set_max_perf(struct cpufreq_policy *policy, u64 val,
 	return (ret == -EOPNOTSUPP) ? 0 : ret;
 }
 
+static int cppc_cpufreq_update_autosel_epp(struct cpufreq_policy *policy, int auto_sel, u32 epp)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	pr_debug("cpu%d: curr epp:%u, curr mode:%u, new epp:%u, new mode:%d\n", cpu,
+		 cpu_data->perf_ctrls.energy_perf, cpu_data->perf_caps.auto_sel, epp, auto_sel);
+
+	mutex_lock(&cppc_cpufreq_update_autosel_config_lock);
+
+	ret = cppc_set_epp(cpu, epp);
+	if (ret) {
+		pr_warn("failed to set energy_perf for cpu:%d (%d)\n", cpu, ret);
+		goto out;
+	}
+	cpu_data->perf_ctrls.energy_perf = epp;
+
+	ret = cppc_set_auto_sel(cpu, auto_sel);
+	if (ret) {
+		pr_warn("failed to set auto_sel for cpu:%d (%d)\n", cpu, ret);
+		return ret;
+	}
+	cpu_data->perf_caps.auto_sel = auto_sel;
+
+out:
+	mutex_unlock(&cppc_cpufreq_update_autosel_config_lock);
+	return ret;
+}
+
+static int cppc_cpufreq_update_autosel_mperf_ctrls(struct cpufreq_policy *policy, u32 min_p,
+						   u32 max_p, bool update_reg, bool update_policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	pr_debug("cpu%d: curr max_perf:%u, curr min_perf:%u, new max_perf:%u, new min_perf:%u\n",
+		 cpu, cpu_data->perf_ctrls.max_perf, cpu_data->perf_ctrls.min_perf, max_p, min_p);
+
+	ret = cppc_cpufreq_set_min_perf(policy, min_p, update_reg, update_policy);
+	if (ret) {
+		pr_debug("failed to set min_perf for cpu:%d (%d)\n", cpu, ret);
+		return ret;
+	}
+
+	ret = cppc_cpufreq_set_max_perf(policy, max_p, update_reg, update_policy);
+	if (ret) {
+		pr_debug("failed to set max_perf for cpu:%d (%d)\n", cpu, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int cppc_cpufreq_update_autosel_configs(struct cpufreq_policy *policy, int auto_sel,
+					       u32 epp, u32 min_perf, u32 max_perf,
+					       bool update_reg, bool update_policy)
+{
+	int ret;
+
+	ret = cppc_cpufreq_update_autosel_mperf_ctrls(policy, min_perf, max_perf,
+						      update_reg, update_policy);
+	if (ret)
+		return ret;
+
+	ret = cppc_cpufreq_update_autosel_epp(policy, auto_sel, epp);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
@@ -710,11 +799,28 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
-	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
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
+		ret = cppc_cpufreq_update_autosel_configs(policy, true,
+							  CPPC_EPP_PERFORMANCE_PREF,
+							  caps->lowest_nonlinear_perf,
+							  caps->nominal_perf, true, false);
+		if (ret) {
+			pr_debug("Failed to update autosel configs on CPU%d(%d)\n", cpu, ret);
+			goto out;
+		}
+	} else {
+		ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
+		if (ret) {
+			pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
+				 caps->highest_perf, cpu, ret);
+			goto out;
+		}
 	}
 
 	cppc_cpufreq_cpu_fie_init(policy);
@@ -736,6 +842,13 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 
 	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
 
+	if (cpu_data->perf_caps.auto_sel) {
+		ret = cppc_cpufreq_update_autosel_epp(policy, false,
+						      CPPC_EPP_ENERGY_EFFICIENCY_PREF);
+		if (ret)
+			return;
+	}
+
 	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
@@ -920,17 +1033,10 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	 * On enabling auto_select: set min/max_perf register and update policy.
 	 * On disabling auto_select: update only policy.
 	 */
-	ret = cppc_cpufreq_set_min_perf(policy, min_perf, update_reg, true);
-	if (ret) {
-		pr_warn("failed to %s update min policy for cpu:%d (%d)\n",
-			val > 0 ? "set min_perf and" : "", cpu, ret);
-		return ret;
-	}
-
-	ret = cppc_cpufreq_set_max_perf(policy, max_perf, update_reg, true);
+	ret = cppc_cpufreq_update_autosel_mperf_ctrls(policy, min_perf, max_perf, update_reg, true);
 	if (ret) {
-		pr_warn("failed to %s update max policy for cpu:%d (%d)\n",
-			val > 0 ? "set max_perf and" : "", cpu, ret);
+		pr_warn("failed to %s update policy for cpu:%d (%d)\n",
+			val > 0 ? "set min/max_perf and" : "", cpu, ret);
 		return ret;
 	}
 
@@ -1139,13 +1245,44 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.name = "cppc_cpufreq",
 };
 
+static void cppc_cpufreq_set_epp_autosel_allcpus(bool auto_sel, u64 epp)
+{
+	int cpu, ret;
+
+	for_each_present_cpu(cpu) {
+		ret = cppc_set_epp(cpu, epp);
+		if (ret)
+			pr_debug("failed to set energy_perf for cpu:%d (%d)\n", cpu, ret);
+
+		ret = cppc_set_auto_sel(cpu, auto_sel);
+		if (ret)
+			pr_debug("failed to set auto_sel for cpu:%d (%d)\n", cpu, ret);
+	}
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
+			pr_info("Enabling autonomous mode on all CPUs\n");
+			cppc_cpufreq_set_epp_autosel_allcpus(true, CPPC_EPP_PERFORMANCE_PREF);
+		} else {
+			pr_warn("Autonomous selection not supported, disabling auto_sel_mode\n");
+			auto_sel_mode = false;
+		}
+	}
+
 	cppc_freq_invariance_init();
 	populate_efficiency_class();
 
@@ -1160,8 +1297,12 @@ static void __exit cppc_cpufreq_exit(void)
 {
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 	cppc_freq_invariance_exit();
+	auto_sel_mode = 0;
 }
 
+module_param(auto_sel_mode, bool, 0000);
+MODULE_PARM_DESC(auto_sel_mode, "Enable Autonomous Performance Level Selection");
+
 module_exit(cppc_cpufreq_exit);
 MODULE_AUTHOR("Ashwin Chaugule");
 MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
-- 
2.34.1


