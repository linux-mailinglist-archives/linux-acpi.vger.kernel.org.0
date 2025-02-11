Return-Path: <linux-acpi+bounces-11007-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFEBA308C5
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 11:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558431887693
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885691F8672;
	Tue, 11 Feb 2025 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cst8iV3e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E621F4E3B;
	Tue, 11 Feb 2025 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270325; cv=fail; b=Ms26OipwMfXO+zSkexTHOpp3T0KrSNuT5oyiYLzTLLMem9RituJg3V96ONZsH1zt5KO7RtZLh0qyEO24xH749/ELq1HfcQJehl9ufyBXXsAZJ/JGdVsllxlLf8gVxRUr54ofiN2NLZhb9L5ffWZxgkrfwGzcoIFwXmozU1bBJhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270325; c=relaxed/simple;
	bh=EXWf8B6tJ+T6u1ROcz287hsTdW1GxFokAd5ZjrpnYgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zze5Lnie+zQguUSdtxyvrl/34MY9ztv7Qwcyo4veKnEBU4Ih/Fi94iguww2e/EVAgHQxExbNN1b9Vw4O1stbbZ2dPM8B0r/g+CxmkYiUp4WCrXeceOBsf8ie+TNTYir0V8R9KWzLWeElr1JOBI2SLDeOPSLiCLL6FlmrMDGLTh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cst8iV3e; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ix0BAokoQNdI/dEQspE1rQdnkREER4B91WRVKP+RF3Zrby+5g5OzA7ZDZ3Pfpm29Nqh1tP9jGkjfwYZmRKakIAqZdg++BXLF1DwwDvGweZ+KaLKHY0y8xLshSIM53exuU1vsrioUBIfNrQ+4zM6p2dkLhw1JMt5GyknUJWkeiGNIrSVHN/ui3YQMxODUgIPtTfs+55zWjghNqF/9a6D0bpS+Szryb8nEu9JOEtoMFeC9JotWTF7cUHEcuE8CEafREfekfetpMOpX3+i3T82RGm/at2DZgBSGG7O0XgPKhEBXFFFtFX/BdovdYuSAi1Iwl3vaYNiVOlhg1VI7e41Btg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnUuf7SehEfhVQIBXOaRT/pW9PHDCJlw2IJl3xtBEr0=;
 b=vdDRu50CGTT1uG0cQHMcqWOL2SqH5vcWiXT3wlMhgIzR103nE0XqIxM8N+ST5Z/f/54Y+sJk8HpbhVOZXRsROcsnzGBYlc3dm5LtYe0ZlpyKABW3qWqRSl/Uk6QWdNR9z1iysIToYJVfFas5npnov+Ms61DvNLGNtM1FF+y2E/vk3lEvoaGywQG8GdcfZfoCMuT/x6o3yl3c2n+NwN9qYrlS7WsrFXI1R7B8nG/cxQdvrDSL1vR9SKxbAhbZn//e2NDajsxAsdw2KinQDjrS00aVEN4241VvFbnN1MCTzDJCpnO74uZ0EMfN9u0b5wQwbr4fKJJQK1y2iAPs1/fXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnUuf7SehEfhVQIBXOaRT/pW9PHDCJlw2IJl3xtBEr0=;
 b=Cst8iV3exioxRyrmEwyhGmsQObF7NtaPxjj79Y1AMzT3d12PC6qBUrla5YXApr8zi+QQOd01kFIfqXB4pg3tOQADf/wmr+c40B2cr5VqWyRJ4uGPhd71i7ZCu0nqOQbeZ7vVMiK5CnsqY9k7h7zlU3f/SSOoUOW5664DMMm/UXI8exsmLTkIrJSGu6WzapvNycv9YJ+UpF3fv+DqE3VwhhPVBMbM5Hcu8jLfuYZc/45IjebDvOJ9Sh/lYIIBR+7NT+UwWvL9bWWPtj4W05y2a5PLLoS6vekD5h7gpDopVi0wbrSD2Aij6nl6f3vUFJ5MXjTpkflThLnced645tbtow==
Received: from BL1PR13CA0071.namprd13.prod.outlook.com (2603:10b6:208:2b8::16)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 10:38:37 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::11) by BL1PR13CA0071.outlook.office365.com
 (2603:10b6:208:2b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.11 via Frontend Transport; Tue,
 11 Feb 2025 10:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 10:38:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Feb
 2025 02:38:22 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Feb
 2025 02:38:22 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Feb 2025 02:38:17 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <sashal@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [Patch 5/5] cpufreq: CPPC: Add cppc_cpufreq_epp instance for Autonomous mode
Date: Tue, 11 Feb 2025 16:07:37 +0530
Message-ID: <20250211103737.447704-6-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: c4bf04b6-3274-438c-bf71-08dd4a883db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+lwverIXwSQlWR1Lt2zXelA9gmFTiYU2KS2Vcbu90iQcvjLWdOKzL3bfhc3m?=
 =?us-ascii?Q?/KPQ6PFCq8O89F8UCot4BGomcW8C7aAFLHx3bEjQPrg2Lra9ziTvIW1NaAvQ?=
 =?us-ascii?Q?2qZioqQEuK+JT6Ha6rO/LtX+2BcVvcsVtAS+TeWJMkTvX4JfZMW8Wiy8hpU6?=
 =?us-ascii?Q?EDfMkoUuseP9JgzaqqM+0Zy2cy/N2Eq08hoRBBwXKqRuoIQ5SQ8jC3gF15B0?=
 =?us-ascii?Q?ULt2L2vIPV/kkUJv+OyXjcmBsRk3HekQaU+gSwhSH8Q3LbXPUeJkYKQWRyHR?=
 =?us-ascii?Q?nTs02UBkAt8sGyM2BISie8e1jzI3xgHMziYRAkrR3dtQutcSTmpeuMIRJdLE?=
 =?us-ascii?Q?9GQ4+hmm/07f5xze7Vh3wgV+qz9QSmUvvr1IR2W+QhjLrmCIjMvksfx+b0d7?=
 =?us-ascii?Q?91zgw8uMqrqZ1ejiI1VGkXkeVpRpd/rIH7u1wTrcnqYLYdTc2uE9XO8qvnvo?=
 =?us-ascii?Q?Lgg0z0npYRgGd44Ou64ScQxv171y/3GP+S/opLwzhrQQs2uWwh/CyLJ0tMEV?=
 =?us-ascii?Q?V8jACGoOsikYaHCFT7LRMSvzLzilu8MqM2zsp3k6QVaZxXGItr0kgHYadPda?=
 =?us-ascii?Q?X4HoP98Jowt5flkJHrCxdNRB97LOqNu+4Coxmm/TN4dlIY8Inr4iE/fa0eVk?=
 =?us-ascii?Q?4Iz+F/v/Bb5r6svDKBl65lnexIF2yz8zsM3088GSCUAo0agH+5mfSPdpX15Y?=
 =?us-ascii?Q?5CH1ntPcPJ84AH0FJX/8kd7wWZf19OUb8GEI5iOtlG+A1alM17eB4QEHdqai?=
 =?us-ascii?Q?jbP+M7fGS6xZ/Dtl1Z1FASv9iLZFxckAODvXxETgE9mhpLnxx0fKgbqiNlUR?=
 =?us-ascii?Q?UCY7tkN1nQZzNZFxfOFo1xX+ZeUyxh/WRDEfgMjHSHsOJwV1U8PtwMqyveB9?=
 =?us-ascii?Q?olikGGqXbPe03sxxbJ97ciQOiQDHoKKWIiX5nTfw02R+iRthd7+dzBAEEexf?=
 =?us-ascii?Q?7/6GMWbxehUaA2xtAJbEbfsdiceOZxRh8UO5PSaZ7xs7FJk0W52EU2ovB9Yv?=
 =?us-ascii?Q?kSkiC6hd0yhCiE9QnGi4w2Z1k1lGKjXzikzrZj5bXQNRhTHckTS79aopNUhz?=
 =?us-ascii?Q?8qyqiSb5wNSdL//YAMJjRTOORTN4BtJZTmQW7qhtViMZqrTqO/Sga2BFbV6d?=
 =?us-ascii?Q?3iF4C2YmUdP3HwVT4gClYfwDNi7yXu6NmSbabMB+huFGeH6dLrcjHQbGWXAT?=
 =?us-ascii?Q?Ybz8iyEkGD+oY09S/EiXSdolbTAgycMxxExeDFg3lJuLyyVwWAyI5e5vzrXz?=
 =?us-ascii?Q?dQHEZfTlniEpV0ZP1atQHKcitOmYLJXgsYSHqIoq65xNc74TRMid2eOrUWJt?=
 =?us-ascii?Q?VFgCL3Vm+6Iq/LkyAQt7hW9eER/A7i1jymG/X0XtJzNzuyUWFDCdYlvApURP?=
 =?us-ascii?Q?DjtqTv4P2Xb6Vc1rwinxPL6ZtXqc+AIiJIe0p4bLXdmI496NCYpasX10vaTN?=
 =?us-ascii?Q?LX4w0bueNTwXKlFL5iDtUwafv9RAdSFx4BKTKB++hobapeSm1LI8PEpJGYiv?=
 =?us-ascii?Q?LlpjFgzxd7/Py8yhhcuWBceKB42wQm5Ojeby?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 10:38:36.5735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bf04b6-3274-438c-bf71-08dd4a883db2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429

Add new 'cppc_cpufreq_epp' instance of the 'cppc_cpufreq' driver for
supporting the Autonomous Performance Level Selection and Engergy
Performance Preference (EPP) as per the ACPI specification.
Autonomous selection will get enabled during boot if 'cppc_auto_sel'
bootarg is present or the 'Autonomous Selection Enable' register is
set before kernel boot.

When Autonomous selection capability is enabled, then the hardware is
allowed to autonomously select the CPU frequency within the min and
max perf boundaries according to EPP hints.

EPP values range from '0x0'(performance preference) to '0xFF'(energy
efficiency preference). It influences the rate of performance
increase/decrease and the result of the hardware's energy efficiency
and performance optimization policies.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         |  11 +
 drivers/cpufreq/cppc_cpufreq.c                | 234 +++++++++++++++++-
 2 files changed, 241 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index aa7447f8837c..8777970e6e35 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -904,6 +904,17 @@
 			Format:
 			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
 
+	cppc_auto_sel=  [CPU_FREQ] Autonomous Performance Level Selection.
+			When Autonomous selection is enabled, then the hardware is
+			allowed to autonomously select the CPU frequency.
+			In Autonomous mode, Engergy Performance Preference(EPP)
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
index 17c49653a3c4..a4fa46cc2a6f 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -34,7 +34,10 @@
  */
 static LIST_HEAD(cpu_data_list);
 
-static struct cpufreq_driver cppc_cpufreq_driver;
+/* Autonomous Selection */
+static bool auto_sel_mode;
+
+static struct cpufreq_driver *current_cppc_cpufreq_driver;
 
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
@@ -519,7 +522,7 @@ static int populate_efficiency_class(void)
 		}
 		index++;
 	}
-	cppc_cpufreq_driver.register_em = cppc_cpufreq_register_em;
+	current_cppc_cpufreq_driver->register_em = cppc_cpufreq_register_em;
 
 	return 0;
 }
@@ -567,6 +570,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 		goto free_mask;
 	}
 
+	ret = cppc_get_perf_ctrls(cpu, &cpu_data->perf_ctrls);
+	if (ret) {
+		pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
+		goto free_mask;
+	}
+
 	list_add(&cpu_data->node, &cpu_data_list);
 
 	return cpu_data;
@@ -672,6 +681,171 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static int cppc_cpufreq_epp_cpu_init(struct cpufreq_policy *policy)
+{
+	unsigned int cpu = policy->cpu;
+	struct cppc_cpudata *cpu_data;
+	struct cppc_perf_ctrls *ctrls;
+	struct cppc_perf_caps *caps;
+	int ret;
+
+	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
+	if (!cpu_data) {
+		pr_err("Error in acquiring _CPC/_PSD data for CPU%d.\n", cpu);
+		return -ENODEV;
+	}
+	caps = &cpu_data->perf_caps;
+	ctrls = &cpu_data->perf_ctrls;
+	policy->driver_data = cpu_data;
+
+	policy->min = cppc_perf_to_khz(caps, ctrls->min_perf);
+	policy->max = cppc_perf_to_khz(caps, ctrls->max_perf);
+
+	/*
+	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
+	 * available if userspace wants to use any perf between lowest & minimum perf
+	 */
+	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
+	policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
+
+	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
+	policy->shared_type = cpu_data->shared_type;
+
+	switch (policy->shared_type) {
+	case CPUFREQ_SHARED_TYPE_HW:
+	case CPUFREQ_SHARED_TYPE_NONE:
+		/* Nothing to be done - we'll have a policy for each CPU */
+		break;
+	case CPUFREQ_SHARED_TYPE_ANY:
+		/*
+		 * All CPUs in the domain will share a policy and all cpufreq
+		 * operations will use a single cppc_cpudata structure stored
+		 * in policy->driver_data.
+		 */
+		cpumask_copy(policy->cpus, cpu_data->shared_cpu_map);
+		break;
+	default:
+		pr_debug("Unsupported CPU co-ord type: %d\n",
+			 policy->shared_type);
+		ret = -EFAULT;
+		goto out;
+	}
+
+	/* Set policy->cur to max now. The governors will adjust later. */
+	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
+
+	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
+	if (ret) {
+		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
+			 caps->highest_perf, cpu, ret);
+		goto out;
+	}
+
+	cppc_cpufreq_cpu_fie_init(policy);
+	return 0;
+
+out:
+	cppc_cpufreq_put_cpu_data(policy);
+	return ret;
+}
+
+static int cppc_cpufreq_epp_update_perf_ctrls(struct cpufreq_policy *policy,
+					      u32 highest_perf, u32 lowest_perf)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	int ret;
+
+	pr_debug("cpu%d, curr max_perf:%u, curr min_perf:%u, highest_perf:%u, lowest_perf:%u\n",
+		 policy->cpu, cpu_data->perf_ctrls.max_perf, cpu_data->perf_ctrls.min_perf,
+		 highest_perf, lowest_perf);
+
+	cpu_data->perf_ctrls.max_perf = highest_perf;
+	cpu_data->perf_ctrls.min_perf = lowest_perf;
+
+	ret = cppc_set_perf_ctrls(policy->cpu, &cpu_data->perf_ctrls);
+	if (ret) {
+		pr_debug("Failed to set perf_ctrls on CPU:%d. ret:%d\n", policy->cpu, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int cppc_cpufreq_epp_update_auto_mode(struct cpufreq_policy *policy, int auto_sel, u32 epp)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	int ret, curr_epp;
+
+	curr_epp = cpu_data->perf_ctrls.energy_perf;
+	pr_debug("cpu%d, curr epp:%u, new epp:%u, curr mode:%u, new mode:%u\n",
+		 curr_epp, epp, cpu_data->perf_caps.auto_sel, auto_sel);
+
+	/* set Performance preference as default */
+	cpu_data->perf_ctrls.energy_perf = epp;
+	ret = cppc_set_epp_perf(policy->cpu, &cpu_data->perf_ctrls, auto_sel);
+	if (ret < 0) {
+		pr_err("failed to set energy perf value (%d)\n", ret);
+		cpu_data->perf_ctrls.energy_perf = curr_epp;
+		return ret;
+	}
+	cpu_data->perf_caps.auto_sel = auto_sel;
+
+	return ret;
+}
+
+static int cppc_cpufreq_epp_update_perf(struct cpufreq_policy *policy, int auto_sel, u32 epp,
+					u32 highest_perf, u32 lowest_perf)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	int ret;
+
+	ret = cppc_cpufreq_epp_update_perf_ctrls(policy, highest_perf, lowest_perf);
+	if (ret)
+		return ret;
+
+	ret = cppc_cpufreq_epp_update_auto_mode(policy, auto_sel, epp);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int cppc_cpufreq_epp_set_policy(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	int ret;
+
+	if (!cpu_data)
+		return -ENODEV;
+
+	ret = cppc_cpufreq_epp_update_perf(policy, true, CPPC_EPP_PERFORMANCE_PREF,
+					   cpu_data->perf_caps.highest_perf,
+					   cpu_data->perf_caps.lowest_perf);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static void cppc_cpufreq_epp_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	int ret;
+
+	cppc_cpufreq_cpu_fie_exit(policy);
+
+	cpu_data->perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
+
+	cppc_cpufreq_epp_update_perf_ctrls(policy, cpu_data->perf_caps.highest_perf,
+					   cpu_data->perf_caps.lowest_perf);
+
+	ret = cppc_set_auto_sel(policy->cpu, false);
+	if (ret)
+		pr_debug("failed to disable autonomous selection (%d)\n", ret);
+
+	cppc_cpufreq_put_cpu_data(policy);
+}
+
 static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
@@ -828,17 +1002,57 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.name = "cppc_cpufreq",
 };
 
+static struct cpufreq_driver cppc_cpufreq_epp_driver = {
+	.flags = CPUFREQ_CONST_LOOPS,
+	.verify = cppc_verify_policy,
+	.setpolicy = cppc_cpufreq_epp_set_policy,
+	.get = cppc_cpufreq_get_rate,
+	.init = cppc_cpufreq_epp_cpu_init,
+	.exit = cppc_cpufreq_epp_cpu_exit,
+	.attr = cppc_cpufreq_attr,
+	.name = "cppc_cpufreq_epp",
+};
+
+static int cppc_cpufreq_auto_sel_enable(bool auto_sel_mode)
+{
+	struct cppc_cpudata *cpu_data;
+	int cpu, pref, ret = 0;
+
+	if (auto_sel_mode) {
+		for_each_present_cpu(cpu) {
+			/* Enable autonomous mode */
+			ret = cppc_set_auto_sel(cpu, true);
+			if (ret)
+				pr_debug("failed to enable autonomous selection (%d)\n", ret);
+		}
+	}
+
+	return ret;
+}
+
 static int __init cppc_cpufreq_init(void)
 {
+	struct cppc_perf_caps caps;
 	int ret;
 
 	if (!acpi_cpc_valid())
 		return -ENODEV;
 
+	cppc_get_auto_sel_caps(0, &caps);
+	if (auto_sel_mode || caps.auto_sel) {
+		ret = cppc_cpufreq_auto_sel_enable(true);
+		if (ret)
+			return ret;
+
+		current_cppc_cpufreq_driver = &cppc_cpufreq_epp_driver;
+	} else {
+		current_cppc_cpufreq_driver = &cppc_cpufreq_driver;
+	}
+
 	cppc_freq_invariance_init();
 	populate_efficiency_class();
 
-	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
+	ret = cpufreq_register_driver(current_cppc_cpufreq_driver);
 	if (ret)
 		cppc_freq_invariance_exit();
 
@@ -859,12 +1073,24 @@ static inline void free_cpu_data(void)
 
 static void __exit cppc_cpufreq_exit(void)
 {
-	cpufreq_unregister_driver(&cppc_cpufreq_driver);
+	cpufreq_unregister_driver(current_cppc_cpufreq_driver);
 	cppc_freq_invariance_exit();
 
 	free_cpu_data();
 }
 
+static int __init cppc_auto_sel_setup(char *buf)
+{
+	int ret = 0;
+
+	ret = kstrtobool(buf, &auto_sel_mode);
+	if (!ret)
+		pr_err("Wrong autonomous selection param\n");
+
+	return ret;
+}
+__setup("cppc_auto_sel=", cppc_auto_sel_setup);
+
 module_exit(cppc_cpufreq_exit);
 MODULE_AUTHOR("Ashwin Chaugule");
 MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
-- 
2.25.1


