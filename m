Return-Path: <linux-acpi+bounces-18540-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBE3C356E0
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 12:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 536494FC603
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 11:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70AC3128C3;
	Wed,  5 Nov 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="azNAkXSF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B2310625;
	Wed,  5 Nov 2025 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342858; cv=fail; b=GHWM+Si4qjx6vX7pQVO9r4VMsy8Im9oli5pWGW+XptGxiw2l2lO1IHCpSm8wFQsagXAzZOQi/IqdZbpJs6j/Oah0oCcyHENKT+rhr5GTy18tKpIRo0rHTuwszNoilo/r3JenZb9roSrrrHZe7uBe+ZmGpjpfRZfCO66OrH/NXaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342858; c=relaxed/simple;
	bh=Ah2cIBXZ7TSkG7xVrswcbkITbG1KYr+13nhQsKunUQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXAbqkyfnSqx/zvD1zkh4GPcwYknptvN/xojZTthfSpxJNUHwe6jJKHxfNaTkXJ/dqCTUB+3IDlJ+1kJOfZCuKFoeb0puzheKQ2TOLAuI+bjy0MBSyEpV82KvpAm1dbZWMHx0U+1LDMuCV4Ab4Hdp0fiia6n/MGbEhyK5WI2dhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=azNAkXSF; arc=fail smtp.client-ip=40.107.209.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvevqPRnltmPoTgjX4wDzFjFvKx4z84RoG0kpWf1UgnhgG01fcWNIpw1AhxW7u88UY4qe6OuFrvVkkLQhqAswY/CyH2RvpUFlxVqt54DwcFN/rWHux7XhFmVzfxrdhW2ZUGw8R5NAkiXQdebdwYJXdUeVoNWSZ9r1wa7p8moS8bjdrBgZfcTYuX6IkEIn5dJDCfRs4mvhw4BuVk64PeZD09wgWJCvOTqhhmSeJeK07/W34VRnSRJfpD2NuAJ8rIYropUzDh0E33RZRU7Na9vVhuaGHQ/ZK7S1g5pk6asxstGinvSXia1WLOwXsywvaQxQWo95W82+kxuo5j08Isjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WKIVaSiOm18cjbn0+5HggKGhjCVSgpSTWGQCfV7l/Q=;
 b=fotyOAK9PKH1c6svjs3DCLBV1IouG26/lpUXZprl2m/SM0NmS5wg3ZqcE16Yxnt/gpi9btR18fHnS2xuxJhVTKrqf3OnPSFv0i4gY15mobeLrpaQppbVjxjQQai6wi4LcPCVSr5iJUolylyVrOAhXHR1IsfjZIslGDQilmmbCKw8+r79aP0mZOpEntxqbuJ5zorPa3x/1mbdd3H7Gn0AKo4DvyRlvFqdmTJA7KQ3F5q87IwujOmfkPTlW+twUIGQDLC9VYMqxRbabYREBV/EsqFs4t1ub6AaB7PwqMjWLS0VURverHOVS+yKETwXKcgiRNWaHzR+eQpyR7vKQIjsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WKIVaSiOm18cjbn0+5HggKGhjCVSgpSTWGQCfV7l/Q=;
 b=azNAkXSFJWTPqxes0ypBcxjuJRaSEipR60uVbmPzqMdFjHtzRD99vOIqKWZL3xWQLaXuu4K3xkM/eTWcOKMdrSh+x0gdxygWAPCjPtUiTGtv0mIrWhIYV8R8ClM4mTXbmLgiOGDUlqe7ewi9Oxp84MIT6n98efTlv/Vg+HAnxx4PoxAyvEm4PB2GZeF0fL0lYiY8CSHAdSOY3NzZ8FJIQFsCjJHW/cf0rFPzaAdShp2GS0NO1PT9Q82+ezuuZqy2S1ZfMtEdbd30NW7pyMoTGLF0Vcf32Sd21/LHu5pchEbiTQ0QVKaxJnryLtRbbHw/bDyoDSWNsf9H3tujRldSpw==
Received: from IA4P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::15)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Wed, 5 Nov
 2025 11:40:52 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::44) by IA4P220CA0010.outlook.office365.com
 (2603:10b6:208:558::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Wed,
 5 Nov 2025 11:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 11:40:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:40:30 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:40:29 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 03:40:22 -0800
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
Subject: [PATCH v4 7/8] cpufreq: CPPC: update policy min/max when toggling auto_select
Date: Wed, 5 Nov 2025 17:08:43 +0530
Message-ID: <20251105113844.4086250-8-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 86904117-0aff-4744-8b66-08de1c602cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4c3uZXSVBxvc3cYl0YCvYHVRZq4YFMNBuhNGJVCRZ0n1mEpBgslz5QRCaTUD?=
 =?us-ascii?Q?vd7Tapp8eBbRK8f0ndGEbhMWaxnXVnqKsWxEhoo0xSM0cM+tcLdqAVLhAZ1X?=
 =?us-ascii?Q?bL3JA2JJdBfrtUgWyLBVydvMIIFQRbY78h/J2Ms7r9N+oh7Oq2eHnMq8ePfc?=
 =?us-ascii?Q?tf7UQ5cI7ahyC/44NCsfG2C/9Fvs5s6geHP7Jnb6QGJkrCgOhm10HNzF1QcN?=
 =?us-ascii?Q?G/nVCVAVPUHoEHDGn0U6IeEiKe0xpg6dQaEBWZAjbeJyVKEYCfDNGVSyTbWP?=
 =?us-ascii?Q?KrkRJtxnStTz9fEi44vZ93cwBFRRAcv4Ki9XkPFOjRdroSj8lm6PQxkanil7?=
 =?us-ascii?Q?N2ILGXKLSweJWLGNcx0Zz33tOHisC+DIJMoHfFILb9ebcsvwmY3I++ceruJO?=
 =?us-ascii?Q?hZONZAtVsAfrHaXuQTwhRMRESYSauhVILadaKm9R508olEbDjSd++aiZNeOR?=
 =?us-ascii?Q?zjy2tst0A1MS1jA5x9Cq8MR73myWLYZdkKb7e3LNXWIb/08AXiGkaW3KfElm?=
 =?us-ascii?Q?K2noNO7/jk3FXSfH4jWp1/5j11SInNgaWJfEhoo30nA0e6bfqP4GKigfQIUe?=
 =?us-ascii?Q?7sR+2jig4VV1fXviVF9uorlfRQBCXKiyEyty3FGYdJG2j6tZUoHQNmSwBaRM?=
 =?us-ascii?Q?HHJrT6Z08Ogb7tE6HPUz1fh2V7hoIJGwFpTNSLtZGVeT+sz25XKEav4yT4AY?=
 =?us-ascii?Q?MQ/KlzsA0G+EI67Uv4Cs6kk21FR1fGFDfHUav+iZSGomqObuLIz5RLnskVE+?=
 =?us-ascii?Q?3G5d7tfEEmbtM/FmaxRjqsjzT4IdOekz7UQkwk5V69l07yRK9aAop85coyaB?=
 =?us-ascii?Q?R9MmfV5YRJfHzBsbpXQwVMy4lftWIScJZm4dZWKX1wl178YSO4TW68PYEFrN?=
 =?us-ascii?Q?IrVAUEGH4sdkpDX4LqHC9+qQ9PPJ0qX8LFLk3LBtzqtVuDPejlxWIwk0ZtNK?=
 =?us-ascii?Q?aNHG/LPEhKH9lpN8qn4jWDXomvTYEYS08sIJsEkoDo84zRi7Q+Yv+Z0IBijb?=
 =?us-ascii?Q?wjOeqOCK9nHsFWgPVVkD4grekzoY7ynJZ/TQwMi8004kEJW7zdMfStsevYjJ?=
 =?us-ascii?Q?tbJ6m1j92vAH/MrdpnJwG1o19s+H0Wct7MrHHoK0jfViRxC9uAmR/5eneDs1?=
 =?us-ascii?Q?BFiQCJY1kLbIvQuXuv6Wzmr/83RZ+srIDGYTi1c/MNub+nU8YCycK0j3vPkz?=
 =?us-ascii?Q?iNZbc47+sTCGZubc+tM4PrjXjWmugYR+dZIJcYY77qFECiImbxWH7yhKBYEe?=
 =?us-ascii?Q?axUxkxVUVlzVR7nOSjfY7yw2zPE94IL89Dolf+JrG1IbUEJvyAPzOSFToCW2?=
 =?us-ascii?Q?pLlabIJUoYmBHPqf0xx9zaZ1RmzrgyNs17PJXbG4hHV8s1qTDuwkFKupsIfg?=
 =?us-ascii?Q?FYDFN03HFptHUOZZYfLlw3EuC2Js3R85dFkXoQx4XGo3gdsjV3UcQedkQxlh?=
 =?us-ascii?Q?lcPfjk5uh+hEjvT8Qyi2R2nizLxyTv7YcoI10NJQdCudmKGVVrlzdmYO/X18?=
 =?us-ascii?Q?d31fSBOykZFBoJLRo0j9Fomv3XoMQtzCilYOxUcDJMBitzHaN8X7liPFGXwA?=
 =?us-ascii?Q?J1xQHuHCgVUmT+lDkBqUvQegoZ+IkqTgFANuBsbC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 11:40:52.3911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86904117-0aff-4744-8b66-08de1c602cbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454

When CPPC autonomous selection (auto_select) is enabled or disabled,
the policy min/max frequency limits should be updated appropriately to
reflect the new operating mode.

Currently, toggling auto_select only changes the hardware register but
doesn't update the cpufreq policy constraints, which can lead to
inconsistent behavior between the hardware state and the policy limits
visible to userspace and other kernel components.

When auto_select is enabled, preserve the current min/max performance
values to maintain user-configured limits. When disabled, the hardware
operates in a default mode where the OS directly controls performance,
so update the policy limits accordingly.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 67 ++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index a425ad575aa6..d1b44beaddda 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -646,6 +646,26 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
 #define cppc_cpufreq_set_max_perf(policy, val, update_reg, update_policy) \
 	cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy, false)
 
+static int cppc_cpufreq_update_autosel_val(struct cpufreq_policy *policy, bool auto_sel)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	pr_debug("cpu%d, auto_sel curr:%u, new:%d\n", cpu, cpu_data->perf_caps.auto_sel, auto_sel);
+
+	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
+
+	ret = cppc_set_auto_sel(cpu, auto_sel);
+	if (ret) {
+		pr_warn("Failed to set auto_sel=%d for CPU%d (%d)\n", auto_sel, cpu, ret);
+		return ret;
+	}
+	cpu_data->perf_caps.auto_sel = auto_sel;
+
+	return 0;
+}
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
@@ -879,8 +899,49 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 	return sysfs_emit(buf, "%d\n", val);
 }
 
-static ssize_t store_auto_select(struct cpufreq_policy *policy,
-				 const char *buf, size_t count)
+/**
+ * cppc_cpufreq_update_auto_select - Update autonomous selection config for policy->cpu
+ * @policy: cpufreq policy
+ * @enable: enable/disable autonomous selection
+ */
+static int cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool enable)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u64 min_perf = caps->lowest_nonlinear_perf;
+	u64 max_perf = caps->nominal_perf;
+	int ret;
+
+	if (enable) {
+		if (cpu_data->perf_ctrls.min_perf)
+			min_perf = cpu_data->perf_ctrls.min_perf;
+		if (cpu_data->perf_ctrls.max_perf)
+			max_perf = cpu_data->perf_ctrls.max_perf;
+	}
+
+	/*
+	 * Set min/max performance registers and update policy constraints.
+	 *   When enabling: update both registers and policy.
+	 *   When disabling: update policy only.
+	 * Continue even if min/max are not supported, as EPP and autosel
+	 * might still be supported.
+	 */
+	ret = cppc_cpufreq_set_min_perf(policy, min_perf, enable, true);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
+	ret = cppc_cpufreq_set_max_perf(policy, max_perf, enable, true);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
+	ret = cppc_cpufreq_update_autosel_val(policy, enable);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static ssize_t store_auto_select(struct cpufreq_policy *policy, const char *buf, size_t count)
 {
 	bool val;
 	int ret;
@@ -889,7 +950,7 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
-	ret = cppc_set_auto_sel(policy->cpu, val);
+	ret = cppc_cpufreq_update_auto_select(policy, val);
 	if (ret)
 		return ret;
 
-- 
2.34.1


