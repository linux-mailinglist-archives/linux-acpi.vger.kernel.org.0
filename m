Return-Path: <linux-acpi+bounces-18541-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7972DC35745
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 12:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E506234A0
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 11:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA01313E0C;
	Wed,  5 Nov 2025 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XYvAJnQk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C43112DB;
	Wed,  5 Nov 2025 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342865; cv=fail; b=lZJlFyMaORsBdfTOV3v05h8fPNKTUI5WCLeiIhvWfXdq3Oid1jeyyx2HuRYRsGoMyJVxFtkH4YZ+fZkyzeN/CqKhOnBS4wJyxBW1bh5LoLsFd1loEMByF6UB8ArRIw+GK0gbAy75Deulv1JMMO5p8TPc+jj8EnWFeJ1rA+tuqok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342865; c=relaxed/simple;
	bh=MqTDxvy5gIPj1VgjE7XnnXvYvJwehOPLcG/2r+81ddk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBKIendtetBMERC0qxazpudmlP5K764ix3eXi3EOUCne+m3MAvxmbHmvHYFvafS+72cz6Y8sNNsnUKtpoHHw0jSC6R+CBcC8VTH08xX76zdV7LZRIbuQmZdHMX/w2TeUxKz5RJfYVYvBiV26q9WydetuiNNYUs3Wyr5ocCIpk58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XYvAJnQk; arc=fail smtp.client-ip=52.101.52.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENigtsa6OjA0nYFiw00Ae/DerPinpbUkld47SW5izt7tEv/OwfoWDMPf1edICQ2+MTIANICVO/ZuVbF/OInxzCeEn8L0vMi27AsvUzqH1RQCohPtcXqWxkvNCdzmt3xLwZ82+WswxN4R8RbFRG5Pc4TdFBk328e3ksxseVWlpemFPSVPwQ7hESubFWMbKQqKOMrMBBEZxhF5JtRqo4FiF0az7ARmOHllpgfrHXYM5lxMQVn3eURXTYzr/FI7K9oawBKXzSBih0qX09pmNngH0w3bxi3L1zzqYAlun91VviNBBBvLahw8ZJNWmPBMkhE0Lyr+neTgD2cvG/tSVyCcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChX2jcGFuU6Q8gjuGEc6Ey+Q0m1kUv4XNgPPsjEw8L4=;
 b=N0bwAQsMlSnnxm1f+CVX+jgB+r85qyNZfsOTiuOeAPqAD4ZMotwxqypW/LOH1f6dMIYOJgbH1Kk1zbmubc7+ctNg6RBp2c1H/e8M/nONFPZj9tTHCzUulBIbK9o0FcZa3E+FbMocSGYZBNJj2gg0J2sEw8weURJlFEGxGyEWC+o4J2U2lnuJJ5HIyyWxHBQry7YqZfmgth6skNN39uhDjjVc3FbhMZwdoiHvy3NW5qIHKqszSK9WdAhXUZqdfFZhMnq4mJ9pTobyqDKZfZII9KbkAik9VeeIZfd8n21uEDWbtVtE+QGWHHlsO9W0iXzGGRJyJ/lsnULOeIRmHCO1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChX2jcGFuU6Q8gjuGEc6Ey+Q0m1kUv4XNgPPsjEw8L4=;
 b=XYvAJnQkn6a1YInOujcj/08fDWG0qZZOUcvGDbm7KZEWZFxj4Qje8l6eDyepZez+QcPhTir41T0BuZtFGkiZJHhRa8Qcepii8DOohQ0dVpBiZu1htD9fgskSxTxbAywhZxwDqIE2+fPknw2qUhoH/anRJI3gnfjJLZOZsBsoo28OG0VgPBTtriKH2xpbeJCbInRYXd071ywzx3+S6LRU3pQVxlulWXW+9pY4rMIVzYAYLLrClj5MKoylHAoyDXlW/vozKeAjNSG8fthPOlhKWwKZAswtnNxex4zMjJIkdSeWJT88as/flmHGrmikNSBn1oJJGnCPqp+i7wcVYUTMew==
Received: from BL1PR13CA0187.namprd13.prod.outlook.com (2603:10b6:208:2be::12)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 11:40:57 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::2) by BL1PR13CA0187.outlook.office365.com
 (2603:10b6:208:2be::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 11:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 11:40:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:40:40 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:40:40 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 03:40:33 -0800
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
Subject: [PATCH v4 8/8] cpufreq: CPPC: add autonomous mode boot parameter support
Date: Wed, 5 Nov 2025 17:08:44 +0530
Message-ID: <20251105113844.4086250-9-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: b95c9eff-769a-4395-ab34-08de1c602f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vtkv2xOCfYhGYmJmubox53nCmZCKf7xxRiS7AafXfqwT8vM0fodPx5kDXeoW?=
 =?us-ascii?Q?mn24TovtsO8h6EideeA6XxpBYR8ElY6jBxs6kbiCifq4dv//0jt1hQ4cbIzU?=
 =?us-ascii?Q?up6jNcBeXYZ9exIanvM/NGLoKcUs4kYJrGnv5Vqc9VIIo82LdRs34l0PwNEX?=
 =?us-ascii?Q?yuAqB1SgslKWOGafc1FzOGERrnGKUxz/oerdspg4dt9p6WPxgNYeqQYTiheF?=
 =?us-ascii?Q?3LBf0g49l9qaptzDhecdqja+9M9J31TZXnE5BzQI3RHc1mFtyaQc+O0/xvCP?=
 =?us-ascii?Q?9xws2lujQSlf9bMuNKYbTWubGRQDV5LTQVCNwHUlLPNXfMhKQmdRCOwcNgfF?=
 =?us-ascii?Q?6KWA4ops/RD9iosK1MGUielRAQ6F/HiTrCDlbECXtHBzuHoNaHBSTrayBW4D?=
 =?us-ascii?Q?SAZ2RADAzPZ31VpUWMekzHpABUNQEmUlY2uJUB1VAWqa+mi/zaqsW3Dl6cqf?=
 =?us-ascii?Q?+oIh89p0XxEmbGG59PJDPMqokdnxoKKEaFZUq/40/fNi6Mn8hvmtrik2tImP?=
 =?us-ascii?Q?gZyGSYl5R8cVfX/PS1W4Vmo6X9QpYVTkwS49c1RoaIQD5b91G/EUiKz2dh57?=
 =?us-ascii?Q?Jqvbusiy1yXChUmnn0nvu1m1oRnAWsf6k/VJzerkT274hwWOBzmasgUXNXHs?=
 =?us-ascii?Q?1Ah5+E9j1eOn/6H7k11S4IagiHJRRYUYfvsYeBTJ5sHxcjXheqCMQeVS1waH?=
 =?us-ascii?Q?KCsWD6vWGoqIiuHK+17S1gv7Fqq0TyMGiAE2G310Nep+Iflbz8qYetCxvjtj?=
 =?us-ascii?Q?7/tyoZRVRFRkN142StB9s3vhcjFTPWtk1DXfN/hv1RVOWPX9SMGBfXAnAO+B?=
 =?us-ascii?Q?WNezzp/5DKqdgHhOUmuDlocbZZtuYkobMbVGsUD9vNKpU/z3AMlJg35n2HAU?=
 =?us-ascii?Q?umRVVfd/WTDTPhNkZUr+ZKbXANhXlg68ewMoV8HVgNjxKZgtw3qo7O4QooVQ?=
 =?us-ascii?Q?tzZaZoCL9+ZS0ocpuXKU+Hb2hhf9GDB3Qc+JNK0nx+yx4SYDnqY6xYsf4lkq?=
 =?us-ascii?Q?J/SoyfT7/3t64lTPQ8W/z6GFyGTAAarT6XrEB/Q7uTQDgcavXplL/Jo3aJsu?=
 =?us-ascii?Q?yzTqlyYrW+AWZ0idqyG7dZOfSmAp6cIoKfU9+Qf0N341QMvZEh9uA/12GcqP?=
 =?us-ascii?Q?YYhn9d/aT2sr9f3CP7rf9DmW2Qsu8/aycwjPKuNPtu/p2bGCom2k1CZtNO4t?=
 =?us-ascii?Q?4RbKv5PNB+5oNT/XNYmeIDPuz2h4bPQQ8wUl71g2SoUWFjhd1WeAg6VjqLEe?=
 =?us-ascii?Q?ErYZkkTP3YapC/870dKDy1emq5FJJNa7gHrEBZkaCXTVZzOeL4uQcq2ZBXH6?=
 =?us-ascii?Q?c5EfKaaIN4Ra75iN0mjgTRSC96TB6/jTodNBfWscGEJVoFc8UAvBfZemlJSb?=
 =?us-ascii?Q?DKfmFV4td18r+tPsUnMFpa3MS5OXFMImAdlPXlXSG/IaqQJ5v9VEhdVTpRnm?=
 =?us-ascii?Q?69TM0stQucbjbQLXb4u74kJqIoDf1fxEA/srn8IYS8N7p6+zAWips4m1U42V?=
 =?us-ascii?Q?g/hh4YrkxcWQZRDQfROcqikPq5e/sYpiEAsdZaw9FbTGEjRI1nLu4KlE0TMc?=
 =?us-ascii?Q?+t+rj0hglEuH6CIDfvMX1xsiudF3Ql9m2wMLoWod?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 11:40:56.7974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b95c9eff-769a-4395-ab34-08de1c602f5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933

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
 .../admin-guide/kernel-parameters.txt         |  12 ++
 drivers/cpufreq/cppc_cpufreq.c                | 197 +++++++++++++++---
 2 files changed, 182 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b8f8f5d74093..048f84008a7e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -929,6 +929,18 @@
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
index d1b44beaddda..0a55ab011317 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -28,8 +28,12 @@
 #include <acpi/cppc_acpi.h>
 
 static struct cpufreq_driver cppc_cpufreq_driver;
+
 static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
 
+/* Autonomous Selection */
+static bool auto_sel_mode;
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
 	FIE_UNSET = -1,
@@ -272,8 +276,13 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
+	/*
+	 * In autonomous selection mode, hardware handles frequency scaling directly
+	 * based on workload and EPP hints. So, skip the OS frequency set requests.
+	 */
 	cpufreq_freq_transition_begin(policy, &freqs);
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	if (!cpu_data->perf_caps.auto_sel)
+		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
 
 	if (ret)
@@ -565,6 +574,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
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
@@ -666,11 +681,81 @@ static int cppc_cpufreq_update_autosel_val(struct cpufreq_policy *policy, bool a
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
+	 *   When enabling: update both registers and policy.
+	 *   When disabling: update policy only.
+	 * Continue even if min/max are not supported, as EPP and autosel
+	 * might still be supported.
+	 */
+	ret = cppc_cpufreq_set_min_perf(policy, min_perf, auto_sel, update_policy);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
+	ret = cppc_cpufreq_set_max_perf(policy, max_perf, auto_sel, update_policy);
+	if (ret && ret != -EOPNOTSUPP)
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
@@ -734,11 +819,31 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
@@ -910,7 +1015,6 @@ static int cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	u64 min_perf = caps->lowest_nonlinear_perf;
 	u64 max_perf = caps->nominal_perf;
-	int ret;
 
 	if (enable) {
 		if (cpu_data->perf_ctrls.min_perf)
@@ -919,26 +1023,8 @@ static int cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
 			max_perf = cpu_data->perf_ctrls.max_perf;
 	}
 
-	/*
-	 * Set min/max performance registers and update policy constraints.
-	 *   When enabling: update both registers and policy.
-	 *   When disabling: update policy only.
-	 * Continue even if min/max are not supported, as EPP and autosel
-	 * might still be supported.
-	 */
-	ret = cppc_cpufreq_set_min_perf(policy, min_perf, enable, true);
-	if (ret && ret != -EOPNOTSUPP)
-		return ret;
-
-	ret = cppc_cpufreq_set_max_perf(policy, max_perf, enable, true);
-	if (ret && ret != -EOPNOTSUPP)
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
@@ -1146,13 +1232,61 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
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
 
@@ -1165,10 +1299,19 @@ static int __init cppc_cpufreq_init(void)
 
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


