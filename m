Return-Path: <linux-acpi+bounces-19827-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FABCD939C
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 13:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 136EF302AE22
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 12:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BED23254A2;
	Tue, 23 Dec 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ej/++Vha"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5045302773;
	Tue, 23 Dec 2025 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492215; cv=fail; b=rFe/Vmz2inO1MCfVQ20INcaGDzNrcv+JHpVWcybfs//rjykiqBR5/NNPpl54kTQ4farEY/YmBwq0rBD1vOEEWvkv1LTE91g+2TrVrzVFbhhaMpLNNo/s34a2Tc1Vm3+KlPXS0tdt/Ht8ax36psMCdTust8Xt5bWMz5YrfwKQ8Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492215; c=relaxed/simple;
	bh=Lg/QBkJm1scDfbw3S/fN2MPWMfybznUBGCviT6jddFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijDzaMTiEYv9cGTz2nUA1gNp/pu3cq/mHExzEVPEJN/Gi8XKXQm/JJTUpwuYVOdDiRPm6pKa6gFvd5tG3h0fbltVPWXF8D3yaJP/3eVai6Z5nFY40EGtuyS5FhCoh1soJvXVJpw4fjSd1Sbg9POQ5y+Fq+jqIIuaqJ9ok3QucEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ej/++Vha; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IC1DZM68lSVnoWkClFYjUgdttfQHw5XyIbCILalkUELiihX2XOuoKTGotjGWsdAAw8QjWewzntU5a9crOyZOaUd3EsdIf6J5HsPQBlT02DEnse1f5ZEC7ipLSxlepJHJy+bWyvgLbSVNcct+kSQGdF9885GMdw7PtsHA6b9ZR5zWD/smhh3SXeHX/3uczrjtgn+9i5XqY+8+dX5iJwhi2VGYOYSKqJGThSWXdWcUuesp8GJoxP9LfYwu7q1LTZeg4XZDnRPxXCcHbZO3QKFGu32s5gD9tkuF9mc82zWcVjM3yxcDSAYegOnlj/NFt5Lg5FnegPoNpfeFOxm92KZskw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/nMe4z0VlqCnjLYQsMkKM+KdQn7+ClDI32HmHVvV4k=;
 b=AhoA7UfEq+cHaRTrVorxKKICQ8mA2FyViUpmmNF/8caCX+MPKHZBO+IDcVZZ/Ol0Qb9BPEG0+UgXqBcK0nXcCpyzlSOt64eaZAsnGzNCyBYE9uCxXwonG+mI8ME75ONXBHCqiVzRwaUKkfGPFFVwE5pAat1b8AniQU0+VBju1c9Nukn7Q958u8MZx4AymPyUb9zI/FjYDX8QJ1/0UK2XNbdlpBlWrE4cpyyZem8Zsb2Zulof2zf4oaNE2SnsE0abk6F3tg61BuvVdIhoZlsuy2G66l3jdncRfFTIN/XB/x62PxLv3tfHE1NDZXyixAT8l40lm1ktzCmn80BfrDpKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/nMe4z0VlqCnjLYQsMkKM+KdQn7+ClDI32HmHVvV4k=;
 b=Ej/++VhaAzz/rnbYsY5D+qkoxyiTUcqjtPE0an5nn/8r2XA5YBHNFiGZ1wbshzzv4qR+/JqszWxUj3i/XkCBIb8RdZxvhMHn5nfQyRpDYuBVg16LHa1ccDBtg7u0uXjAI6vWfrY2rGabVVvd7OYWfgcML5ztiJX7TDpxwEI7FkQl2Q8cOt2KuC9iV3DOez/RqMxSVicbszOXcA9soheYijfg6XQGO0McxaXeR1Nz5ZE7JnlM8YZz075XbOajFG8jVDcmeqO8fUI9lRe9MX0AQvSrpeXDocOB0sQStQWyzpa3ql3pn9gpkLhI7g30si5fG2F7unlEmOx+aYotECb94w==
Received: from MN0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:52c::17)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 12:15:34 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::e8) by MN0PR05CA0011.outlook.office365.com
 (2603:10b6:208:52c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Tue,
 23 Dec 2025 12:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 12:15:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:15:16 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:15:15 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 04:15:08 -0800
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
Subject: [PATCH v5 11/11] cpufreq: CPPC: add autonomous mode boot parameter support
Date: Tue, 23 Dec 2025 17:43:07 +0530
Message-ID: <20251223121307.711773-12-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223121307.711773-1-sumitg@nvidia.com>
References: <20251223121307.711773-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0263d8-089a-444d-656a-08de421cf8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IONdS240Wyf9hAqQ8+g/04EZ+98edV9OPeY/aCoMOd7rHv1WaIv+uRjyplN9?=
 =?us-ascii?Q?o0K+SUvzcUBkFM1ga/9FuJoZkLyvDxRvq0cNnWquCN7Yjr1UVHVbyr9RPBeH?=
 =?us-ascii?Q?o1JcZbTo9kBSB2Wucswae9K8Nh9bfp0SEi9VbTNrW9dEv7GOGtOJX7gOaMA+?=
 =?us-ascii?Q?Tu1abeRSTnr85x5tPg4xRJplEacpB48j+Ib7Q/5h9AQa6lptIP08qLV4L8gK?=
 =?us-ascii?Q?oBWIWHsaYGgYPe1R7xJE4npQ54Mftc2JSwwOy03+Th4P+4meZS+4RZdkvROS?=
 =?us-ascii?Q?jjiPoGFZnSsH9EOd83t43GYXy8D3ZGpTE14qRjTLuO8ewfCsq+GUalZDQoeu?=
 =?us-ascii?Q?Y/kg69l6o7w6dKFuIE5T0/2XZDBkzynFhWlM1lGt8jq7jL6zSYt2/s2RVUU5?=
 =?us-ascii?Q?KBpNWcM3HNczbIfZaj9p1nwOzBZcQLwikGiIHKETZlB1deD1cOcc8CN9SD+X?=
 =?us-ascii?Q?WxE8H7vQezuplTHYtiLSzDB6T5uP9oSSWXeAJ5CUAWE9B9Nc72WuK6Leq4qT?=
 =?us-ascii?Q?UXdmfCxwa0m3oO98XI9MEeYV+hzHcujZpTKJKMrGYzI9bGIvljnXOyypxUDB?=
 =?us-ascii?Q?Ext5dNmn/2cXDZ4AhKUlKFKTxlOpdSi+SPs6ydauymsLF3TLXsq8cEI1xqEd?=
 =?us-ascii?Q?5ULVaOgVFrSRNNhPD30RXKwkITXUQ5PDRmGq0imnWDKXfxXw2BjTZEdMiD+3?=
 =?us-ascii?Q?8sLKCRUGNCtHyTUDyqW32fPJjuS186TWgFXQPy0OIKPU4tintUafBV/YWDze?=
 =?us-ascii?Q?0a4xkfXHFj/oD6CPWm6fb0/seF2l7N0Rwx/5VjjUUEjX5zQ8cox+G1QR4+z3?=
 =?us-ascii?Q?JPXhkw9fRePez9vjY9lvKag9+xyHdQfwQWo6d5pI6M8AUXrZjS6NLcZhmVqI?=
 =?us-ascii?Q?leDahEgl3mWpbi62/tbbCkqQ8JSkbjlw5mdi8mDJYfT+E0AdKkvEyS7CqvLe?=
 =?us-ascii?Q?cuZR959R053YgSzBsMPhctOQVrGS5sufoqxRpVJh6sR8Y/cgvSFAucgFS/bV?=
 =?us-ascii?Q?vXR//9XtzkBCAPl/9s0DhfmIusk42FopiBCCrsJemiz2LtNa3B25jmVB41B/?=
 =?us-ascii?Q?X2sL8DkUxLxDjp8OPboMLpZ8cnmYSqxRZSEuj5wvWGIvQ/C3cXs1bc8ooJSq?=
 =?us-ascii?Q?mKdPET3LtzP1/qYSk3NFGfq3uyhJ8da04485D4mTRSz8PHTadfF8Fz8PvMpW?=
 =?us-ascii?Q?lX5FL2tZXQUB9G7lQJ5GqWZNgs+myYqHqjSxVGGzc5QYHBN5pOrFv1NCc2Gw?=
 =?us-ascii?Q?jKSQjztY5oTJrB/itAtCcYVVs2hecrEFfwq8PahmMhP+gWmlMU2EXNgOZ4oc?=
 =?us-ascii?Q?hhAWGkA21/04KyTg8KPy8qczy8At1nqC908lWD4SLmwyglJRrICYsFjAcsyf?=
 =?us-ascii?Q?fF/iXmHGn/EwBjLHefd8g/DkziwGkVGiqvc3VmcLVxcqAhOZSZx7FGJ02++F?=
 =?us-ascii?Q?RKSzaFAB2UfejxfC5DfGVgtpO/FeDi7+Qr8nJEYPMjHQMqOLl71z9Mlt3Xo+?=
 =?us-ascii?Q?fSRbm6HbDqT02iJkR33ldqIkL1QUhHYey++7YMdDKBsKfZbFNy92S9KRWA3v?=
 =?us-ascii?Q?ZF+uTqNLxZaeesKY6hF1jXKF33+Bur2y3syR76HP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 12:15:33.2402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0263d8-089a-444d-656a-08de421cf8d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA

Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
autonomous performance selection on all CPUs at system startup without
requiring runtime sysfs manipulation. When autonomous mode is enabled,
the hardware automatically adjusts CPU performance based on workload
demands using Energy Performance Preference (EPP) hints.

When auto_sel_mode=1:
- All CPUs are configured for autonomous operation during init
- EPP is set to performance preference (0x0) by default
- Min/max performance bounds use defaults or already set values
- CPU frequency scaling is handled by hardware instead of OS governor

The boot parameter is applied only during first policy initialization.
User's runtime sysfs configuration is preserved across hotplug.

For Documentation/:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         | 13 +++
 drivers/cpufreq/cppc_cpufreq.c                | 85 +++++++++++++++++--
 2 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index aab72efa1acd..450f0b0225dc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1035,6 +1035,19 @@ Kernel parameters
 			Format:
 			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
 
+	cppc_cpufreq.auto_sel_mode=
+			[CPU_FREQ] Enable ACPI CPPC autonomous performance
+			selection. When enabled, hardware automatically adjusts
+			CPU frequency on all CPUs based on workload demands.
+			In Autonomous mode, Energy Performance Preference (EPP)
+			hints guide hardware toward performance (0x0) or energy
+			efficiency (0xff).
+			Requires ACPI CPPC autonomous selection register support.
+			Format: <bool>
+			Default: 0 (disabled)
+			0: use cpufreq governors
+			1: enable if supported by hardware
+
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b3da263c18b0..8c6869e68504 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -30,6 +30,9 @@ static struct cpufreq_driver cppc_cpufreq_driver;
 
 static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
 
+/* Autonomous Selection boot parameter */
+static bool auto_sel_mode;
+
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
 static enum {
 	FIE_UNSET = -1,
@@ -643,11 +646,16 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
  * cppc_cpufreq_update_autosel_config - Update autonomous selection config
  * @policy: cpufreq policy
  * @is_auto_sel: enable/disable autonomous selection
+ * @epp_val: EPP value (used only if update_epp true)
+ * @update_epp: whether to update EPP register
+ * @update_policy: whether to update policy constraints
  *
  * Return: 0 on success, negative error code on failure
  */
 static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
-					      bool is_auto_sel)
+					      bool is_auto_sel, u32 epp_val,
+					      bool update_epp,
+					      bool update_policy)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
@@ -655,7 +663,6 @@ static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
 	u64 max_perf = caps->nominal_perf;
 	unsigned int cpu = policy->cpu;
 	bool update_reg = is_auto_sel;
-	bool update_policy = true;
 	int ret;
 
 	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
@@ -685,6 +692,17 @@ static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
 	if (ret && ret != -EOPNOTSUPP)
 		return ret;
 
+	/* Update EPP register */
+	if (update_epp) {
+		ret = cppc_set_epp(cpu, epp_val);
+		if (ret && ret != -EOPNOTSUPP) {
+			pr_warn("Failed to set EPP for CPU%d (%d)\n", cpu, ret);
+			return ret;
+		}
+		if (!ret)
+			cpu_data->perf_ctrls.energy_perf = epp_val;
+	}
+
 	/* Update auto_sel register */
 	ret = cppc_set_auto_sel(cpu, is_auto_sel);
 	if (ret && ret != -EOPNOTSUPP) {
@@ -816,11 +834,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
-	if (ret) {
-		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 caps->highest_perf, cpu, ret);
-		goto out;
+	/*
+	 * Enable autonomous mode on first init if boot param is set.
+	 * Check last_governor to detect first init and skip if auto_sel
+	 * is already enabled.
+	 */
+	if (auto_sel_mode && policy->last_governor[0] == '\0' &&
+	    !cpu_data->perf_ctrls.auto_sel) {
+		/* Enable CPPC - optional register, some platforms need it */
+		ret = cppc_set_enable(cpu, true);
+		if (ret) {
+			if (ret == -EOPNOTSUPP)
+				pr_debug("CPPC enable not supported CPU%d\n",
+					 cpu);
+			else
+				pr_warn("Failed enable CPPC CPU%d (%d)\n",
+					cpu, ret);
+		}
+
+		/*
+		 * Enable autonomous mode; Pass false for update_policy to avoid
+		 * updating policy limits prematurely as they are not yet fully setup.
+		 */
+		ret = cppc_cpufreq_update_autosel_config(policy,
+							 true,  /* is_auto_sel */
+							 CPPC_EPP_PERFORMANCE_PREF,
+							 true,  /* update_epp */
+							 false); /* update_policy */
+		if (ret)
+			pr_warn("Failed autonomous config CPU%d (%d)\n",
+				cpu, ret);
+	}
+
+	/* If auto mode is enabled, sync policy limits with HW registers */
+	if (cpu_data->perf_ctrls.auto_sel) {
+		policy->min = cppc_perf_to_khz(caps,
+					       cpu_data->perf_ctrls.min_perf ?:
+					       caps->lowest_nonlinear_perf);
+		policy->max = cppc_perf_to_khz(caps,
+					       cpu_data->perf_ctrls.max_perf ?:
+					       caps->nominal_perf);
+	} else {
+		/* Standard mode: governors control frequency */
+		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+		if (ret) {
+			pr_debug("Err setting perf value:%d CPU:%d ret:%d\n",
+				 caps->highest_perf, cpu, ret);
+			goto out;
+		}
 	}
 
 	cppc_cpufreq_cpu_fie_init(policy);
@@ -991,7 +1052,7 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
-	ret = cppc_cpufreq_update_autosel_config(policy, val);
+	ret = cppc_cpufreq_update_autosel_config(policy, val, 0, false, true);
 	if (ret)
 		return ret;
 
@@ -1253,10 +1314,18 @@ static int __init cppc_cpufreq_init(void)
 
 static void __exit cppc_cpufreq_exit(void)
 {
+	unsigned int cpu;
+
+	for_each_present_cpu(cpu)
+		cppc_set_auto_sel(cpu, false);
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


