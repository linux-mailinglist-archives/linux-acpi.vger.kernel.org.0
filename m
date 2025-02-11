Return-Path: <linux-acpi+bounces-11005-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEED4A308BC
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 11:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63353188A94C
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 10:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0951F5435;
	Tue, 11 Feb 2025 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AmtvBm3A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019141F542A;
	Tue, 11 Feb 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270305; cv=fail; b=TBQF5XCmuVuMdQvE0+hrMgvHcwhvrY03K8FNjSYVGZlY+bxgR0PKm5+9rL+oiT+LqAhh3DWts3IfEx+NGQV6vGiefLKYRoqti5s4+DV8YKZ/CvV1pkhmZFaQVkWo3gIx9MoSSJ/g97dmdseSa3Yf+F4bFOH8ZRP+pCICYmWyRdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270305; c=relaxed/simple;
	bh=0+A5CWWgRBEBOu3M/BJzEfQHUZNZnEpTHVcLycJhA2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlY1Gh4NN7PWovwUcDhsgK5iE6iqk4P4y5YsZPGnSEAtqJQHxUmwFQNBmWaLKIcYUsWJyc9DcG0fs+Ht0BM+a/Q5YDKpyTav6dTNo8PjYK7n5+ZwW6XDaIRIiHa/TDAXn2ngPDxAPsnYFpBGDDCeTJ3yz/8rY24BtdCv0senDAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AmtvBm3A; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdJjAi8XJls0rx+dH0or058giLC/YDp7S9By41wL9EIgkBrPT+CVvBkusP1iwNtoVl4jlFHopuO51X7EgBnkRgYoFQwjfFX+9TCmd9f9NISxsRbaYPmEuA1EezDWj3sk3hGAdnUxTAGpqOrWgItJaHjB28ohaX9kHi0MUDEYuVjr+v/W0sBsRbqNINRQW995IqA4VkarjpJ+UliJbZHTI97bI0qrk7mIVJc/pZSP/5URMvDlRpkr3pHBfHPuIF4E5GuKjpjIPa1nNxC2PbKYmAWDlEYja+TwpNwrsxmF3of7tYfKLepzpLMHNTo49CFTZ0vWiWdCx81TcjYGTD1enA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LN4SP5NHXjRsd5w5NYkDuNb5wiIilyL1EyYRqFw6Y1M=;
 b=YJU4lx3EFwSZ1IiB4YVzfPoRtmb56moUG6ViB5Yvd8fh1toXcd2eyzRyTfYXjSlRUkMAeB39fHZ9iLcEDiLXUtWnFxM+GbNUhhHfPm03AwWSJPlKksakJfb1Wvfy00ReApPGU7BbWdoQXvFXdPFLYjIuXNwxqF3Ml6AZS7dh4+Iosrr0j80bmmg6B+wrDpPYs5N9gTBZGWiLh5KTiUAhH3LoCqoz+Gt1RVUXMN8kNs6d76Y+j6vEe8IkWkqP3mDlFlQziSnDa7UTuUDsz0uUWUrtQm4aD4e2jIXTrK5QCfMOat1GPeRzNi0GeoeSabFDiB16WT/+oqg3eC0hiuJOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN4SP5NHXjRsd5w5NYkDuNb5wiIilyL1EyYRqFw6Y1M=;
 b=AmtvBm3AyrApD2+1CBHgMxjkQIYu9nT5TDSGkhb+cMlHLUBGVMrGvcnzoHh/mDLpQaTz0edWOjKaPQ0pAtun2ltM0gJjjjT3JVCJOv6KcEfY8GZ1/MTRLjmSjEGI2Sm8NKd2CRGfYMqgfW2QdPu0bc4zPfmNuV4c7OggOSK5IgX0vlJZK+jvvqrR4Rv0JtkGvKcHW5XCcBiE3y03HP2qHszY/ZvGKUPJ6Eh5KWYGPXQrizoy8HUG9S5ys5AeXkNuspSzNBXxAHU1VDVbpBqpFAn5sfB6xdvOSSy1yns7dvibrC1JZqlV/nWbYDDZ10su3Z6WrV5vM756O59EHVkyCg==
Received: from SN6PR05CA0021.namprd05.prod.outlook.com (2603:10b6:805:de::34)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 10:38:18 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::f1) by SN6PR05CA0021.outlook.office365.com
 (2603:10b6:805:de::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.13 via Frontend Transport; Tue,
 11 Feb 2025 10:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 10:38:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Feb
 2025 02:38:07 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Feb
 2025 02:38:06 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Feb 2025 02:38:02 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <sashal@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [Patch 3/5] ACPI: CPPC: support updating epp, auto_sel and {min|max_perf} from sysfs
Date: Tue, 11 Feb 2025 16:07:35 +0530
Message-ID: <20250211103737.447704-4-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3d0a05-8541-4c76-a4cd-08dd4a8832e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kd1RQBOJ/FUy3GMGpQrPb3kmzmPnR1Qy6Qo4eCuuw+4bVuZjpfp33UGuzoEO?=
 =?us-ascii?Q?dTUQZfn8QJ2XAXl+JZ0Zwtn0BDG7CqgaxZKqMzmsLcvmIJpndbNlLCC2SzEN?=
 =?us-ascii?Q?UkAINvTJ0DcTzcv/limoyq3idJxsuod5PlboHrHq4c51DeyrVouXE2yUbLG6?=
 =?us-ascii?Q?FM2d09y4iXyMUws1LiMPKGknyyZgp7bWw1EOR8fMlE7jw691k53f6BKTeqj5?=
 =?us-ascii?Q?x7+kh4sX9Y/PbFndRbErdqEkPkRPIZ+UjkRu4U3WvcbWWnJ/wPOqENzaXHaa?=
 =?us-ascii?Q?SO8LEyxRxsZhr9WkraV7PoO2vK2dZOLGr0OCT7lD+IkIWTMqavzlH/BxG+ea?=
 =?us-ascii?Q?fQmm5DEgpUqE1GP+EA6wC5Lt8UBvasTTmZWFnA2i2UNDL+60bOMpa5k3BcrQ?=
 =?us-ascii?Q?G0iOJ0M1r9kSCIQFaXsaFfUoRpQXJEg3T0I2QB1IwVPKb0bTgrbRCFwlapH5?=
 =?us-ascii?Q?ZZMzQkYYBEwCqdIpuSSsFvegBPYmiTSxHVeEjvUbFeZLxWh9yOHwA5shD0H8?=
 =?us-ascii?Q?6sgQEoRuipmVC7jsl7S2CWMHiPFoIjpbU84AYuOOUtTZ9lWAP/51hnw3SPAr?=
 =?us-ascii?Q?xi5dKCYWFtGkqaPp+b/HuckTgpEQgJ+3m9hTVO+FQnuMFqi9zkHL5ZfY5ej/?=
 =?us-ascii?Q?8tYabhw/kyKGyUGHKxcwhzNAcL3Y9A54oWP0m/2iDOPCfOXjYvt4orSF3eBE?=
 =?us-ascii?Q?6pu625eMpua1OZcGApw1BI/hJDnKcMem4K/Odx7oWhX35IQJv/gI7w6Axpe1?=
 =?us-ascii?Q?VDp+KbgtJYnLBOULca8vWplGl4c2FNgllRMT5KJ4j7OXyRd+gDSC7hB1xzKP?=
 =?us-ascii?Q?I9TjAoWozTAchiQA6sw1+IntbwILdgKwFas3MoMJiZCUkw3eL4VjCl/PhOUv?=
 =?us-ascii?Q?lF7L4Tfq5qxJJ+wwCHS68+jjSjENzi5Tovf691eHVC7mvXya5X2pbS79f5j1?=
 =?us-ascii?Q?lkfUkw9n8YeK3ahzQvVCgKciOZxut+212UY8rzPWV0MwWbMrpQZv8EBGRrHK?=
 =?us-ascii?Q?qYwsHSKFtT58M+b8jbJYATapwbcTCV52ltiqPYL0HLc34OGyIDbLTEOXymZQ?=
 =?us-ascii?Q?nuLjUKcMO/s93XZF7r8FEQXfS+OajowXZx1bRKWzE0c1n3R50MEKSWGjeUmR?=
 =?us-ascii?Q?l4HlxFdjDKIjqau68okQEHmao+O0HSGCrTh5uUS+A46TXpRGGax3u88BnXXf?=
 =?us-ascii?Q?bOCYjxj/kEv8Spiv82YdsD8t8EZRMvYUPFQ+UEIitc3LBccvdThfE4BLuHPl?=
 =?us-ascii?Q?q9jFtxQFpcKkFdBMB4PZhbweygLNPrzvO/J+AgdVaWAFAYPeTTBiAub7vHEW?=
 =?us-ascii?Q?TCEx8VeQiEmVv+oON8wfwbdvTB4IgoK6AIsJZHwG7hIAWffcTqG504Avn8V1?=
 =?us-ascii?Q?rribJa4xpocZyBp6jVqMVUPFVZYZBy+bLcBwHpqXLJ9oTr2qM/Y6Gqfo69pB?=
 =?us-ascii?Q?lSZEx+5AjU3Hz6uPFXxqjyV6iXgOPntELdoyHAww3AOyYts8E8HdKEg0fCwB?=
 =?us-ascii?Q?vPulryQK9fzazs3B46Ax/CU5/rYVJEyj1JUS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 10:38:18.4899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3d0a05-8541-4c76-a4cd-08dd4a8832e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223

Add support to update the CPC registers used for Autonomous
Performance Level Selection from acpi_cppc sysfs store nodes.
Registers supported for updation are:
- Engergy Performance Preference (EPP): energy_perf
- Autonomous Selection: auto_sel
- Maximum Performance: max_perf
- Minimum Performance: min_perf

Also, enable show nodes to read of the following CPC registers:
- Performance Limited: perf_limited
- Autonomous Activity Window: auto_activity_window

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 191 ++++++++++++++++++++++++++++++++++++---
 include/acpi/cppc_acpi.h |   5 +
 2 files changed, 183 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index cc2bf958e84f..c60ad66ece85 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -170,6 +170,133 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
 	}								\
 	define_one_cppc(member_name, mode)
 
+static ssize_t store_min_perf(struct kobject *kobj, struct kobj_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
+	struct cpufreq_policy *policy;
+	struct cppc_cpudata *cpu_data;
+	u32 min_perf, input;
+	int ret;
+
+	policy = cpufreq_cpu_get(cpc_ptr->cpu_id);
+	cpu_data = policy->driver_data;
+
+	if (kstrtouint(buf, 10, &input))
+		return -EINVAL;
+
+	if (input > cpu_data->perf_ctrls.max_perf)
+		return -EINVAL;
+
+	input = clamp(input, cpu_data->perf_caps.lowest_perf, cpu_data->perf_caps.highest_perf);
+
+	min_perf = cpu_data->perf_ctrls.min_perf;
+	cpu_data->perf_ctrls.min_perf = input;
+
+	ret = cppc_set_perf_ctrls(cpc_ptr->cpu_id, &cpu_data->perf_ctrls);
+	if (ret) {
+		pr_debug("Err writing CPU%d perf ctrls: ret:%d\n", cpc_ptr->cpu_id, ret);
+		cpu_data->perf_ctrls.min_perf = min_perf;
+		return ret;
+	}
+	cpufreq_cpu_put(policy);
+
+	return count;
+}
+
+static ssize_t store_max_perf(struct kobject *kobj, struct kobj_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
+	struct cpufreq_policy *policy;
+	struct cppc_cpudata *cpu_data;
+	u32 max_perf, input;
+	int ret;
+
+	policy = cpufreq_cpu_get(cpc_ptr->cpu_id);
+	cpu_data = policy->driver_data;
+
+	if (kstrtouint(buf, 10, &input))
+		return -EINVAL;
+
+	if (input < cpu_data->perf_ctrls.min_perf)
+		return -EINVAL;
+
+	input = clamp(input, cpu_data->perf_caps.lowest_perf, cpu_data->perf_caps.highest_perf);
+
+	max_perf = cpu_data->perf_ctrls.max_perf;
+	cpu_data->perf_ctrls.max_perf = input;
+
+	ret = cppc_set_perf_ctrls(cpc_ptr->cpu_id, &cpu_data->perf_ctrls);
+	if (ret) {
+		pr_debug("Err writing CPU%d perf ctrls: ret:%d\n", cpc_ptr->cpu_id, ret);
+		cpu_data->perf_ctrls.max_perf = max_perf;
+		return ret;
+	}
+	cpufreq_cpu_put(policy);
+
+	return count;
+}
+
+static ssize_t store_energy_perf(struct kobject *kobj, struct kobj_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
+	struct cpufreq_policy *policy;
+	struct cppc_cpudata *cpu_data;
+	u64 epp, input;
+	int ret;
+
+	policy = cpufreq_cpu_get(cpc_ptr->cpu_id);
+	cpu_data = policy->driver_data;
+
+	if (kstrtou64(buf, 10, &input))
+		return -EINVAL;
+
+	input = clamp(input, CPPC_EPP_PERFORMANCE_PREF, CPPC_EPP_ENERGY_EFFICIENCY_PREF);
+
+	epp = cpu_data->perf_ctrls.energy_perf;
+	cpu_data->perf_ctrls.energy_perf = input;
+
+	ret = cppc_set_epp_perf(cpc_ptr->cpu_id, &cpu_data->perf_ctrls,
+				cpu_data->perf_caps.auto_sel);
+	if (ret) {
+		pr_debug("failed to set energy perf value (%d)\n", ret);
+		cpu_data->perf_ctrls.energy_perf = epp;
+		return ret;
+	}
+	cpufreq_cpu_put(policy);
+
+	return count;
+}
+
+static ssize_t store_auto_sel(struct kobject *kobj, struct kobj_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
+	struct cpufreq_policy *policy;
+	struct cppc_cpudata *cpu_data;
+	bool input = false;
+	int ret;
+
+	policy = cpufreq_cpu_get(cpc_ptr->cpu_id);
+	cpu_data = policy->driver_data;
+
+	if (kstrtobool(buf, &input))
+		return -EINVAL;
+
+	ret = cppc_set_auto_sel(cpc_ptr->cpu_id, input);
+	if (ret) {
+		pr_info("failed to set autonomous selection (%d)\n", ret);
+		return ret;
+	}
+	cpu_data->perf_caps.auto_sel = input;
+
+	cpufreq_cpu_put(policy);
+
+	return count;
+}
+
 sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_perf, ro);
 sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_perf, ro);
 sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_perf, ro);
@@ -177,9 +304,16 @@ sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_nonlinear_perf, ro);
 sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf, ro);
 sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq, ro);
 sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq, ro);
+sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, auto_sel, rw);
 
 sysfs_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, reference_perf, ro);
 sysfs_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, wraparound_time, ro);
+sysfs_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, perf_limited, ro);
+
+sysfs_cppc_data(cppc_get_perf_ctrls, cppc_perf_ctrls, min_perf, rw);
+sysfs_cppc_data(cppc_get_perf_ctrls, cppc_perf_ctrls, max_perf, rw);
+sysfs_cppc_data(cppc_get_perf_ctrls, cppc_perf_ctrls, energy_perf, rw);
+sysfs_cppc_data(cppc_get_perf_ctrls, cppc_perf_ctrls, auto_activity_window, ro);
 
 /* Check for valid access_width, otherwise, fallback to using bit_width */
 #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
@@ -218,6 +352,12 @@ static struct attribute *cppc_attrs[] = {
 	&nominal_perf.attr,
 	&nominal_freq.attr,
 	&lowest_freq.attr,
+	&auto_sel.attr,
+	&max_perf.attr,
+	&min_perf.attr,
+	&perf_limited.attr,
+	&auto_activity_window.attr,
+	&energy_perf.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(cppc);
@@ -1286,8 +1426,8 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
 	struct cpc_register_resource *highest_reg, *lowest_reg,
 		*lowest_non_linear_reg, *nominal_reg, *guaranteed_reg,
-		*low_freq_reg = NULL, *nom_freq_reg = NULL;
-	u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0;
+		*low_freq_reg = NULL, *nom_freq_reg = NULL, *auto_sel_reg = NULL;
+	u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0, auto_sel = 0;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
 	int ret = 0, regs_in_pcc = 0;
@@ -1304,11 +1444,12 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
 	nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
 	guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
+	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
 
 	/* Are any of the regs PCC ?*/
 	if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
 		CPC_IN_PCC(lowest_non_linear_reg) || CPC_IN_PCC(nominal_reg) ||
-		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg)) {
+		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg) || CPC_IN_PCC(auto_sel_reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
@@ -1356,6 +1497,9 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	perf_caps->lowest_freq = low_f;
 	perf_caps->nominal_freq = nom_f;
 
+	if (CPC_SUPPORTED(auto_sel_reg))
+		cpc_read(cpunum, auto_sel_reg, &auto_sel);
+	perf_caps->auto_sel = (bool)auto_sel;
 
 out_err:
 	if (regs_in_pcc)
@@ -1535,8 +1679,22 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 		   CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
 		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
 	} else {
-		ret = -ENOTSUPP;
-		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
+		if (CPC_SUPPORTED(auto_sel_reg) && CPC_SUPPORTED(epp_set_reg)) {
+			ret = cpc_write(cpu, auto_sel_reg, enable);
+			if (ret) {
+				pr_debug("Error in writing auto_sel for CPU:%d\n", cpu);
+				return ret;
+			}
+
+			ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
+			if (ret) {
+				pr_debug("Error in writing energy_perf for CPU:%d\n", cpu);
+				return ret;
+			}
+		} else {
+			ret = -EOPNOTSUPP;
+			pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
+		}
 	}
 
 	return ret;
@@ -1553,6 +1711,7 @@ int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
 	struct cpc_register_resource *auto_sel_reg;
 	u64  auto_sel;
+	int ret = 0;
 
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
@@ -1561,13 +1720,9 @@ int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 
 	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
 
-	if (!CPC_SUPPORTED(auto_sel_reg))
-		pr_warn_once("Autonomous mode is not unsupported!\n");
-
 	if (CPC_IN_PCC(auto_sel_reg)) {
 		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 		struct cppc_pcc_data *pcc_ss_data = NULL;
-		int ret = 0;
 
 		if (pcc_ss_id < 0)
 			return -ENODEV;
@@ -1588,7 +1743,15 @@ int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 		return ret;
 	}
 
-	return 0;
+	if (CPC_SUPPORTED(auto_sel_reg)) {
+		cpc_read(cpunum, auto_sel_reg, &auto_sel);
+	} else {
+		pr_debug("Autonomous mode is not unsupported!\n");
+		ret = -EOPNOTSUPP;
+	}
+	perf_caps->auto_sel = (bool)auto_sel;
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
 
@@ -1630,11 +1793,13 @@ int cppc_set_auto_sel(int cpu, bool enable)
 		/* after writing CPC, transfer the ownership of PCC to platform */
 		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
 		up_write(&pcc_ss_data->pcc_lock);
-	} else {
-		ret = -ENOTSUPP;
-		pr_debug("_CPC in PCC is not supported\n");
+
+		return ret;
 	}
 
+	if (CPC_SUPPORTED(auto_sel_reg))
+		ret = cpc_write(cpu, auto_sel_reg, enable);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 31f4fd288b65..b072ef11f128 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -32,6 +32,9 @@
 #define	CMD_READ 0
 #define	CMD_WRITE 1
 
+#define CPPC_EPP_PERFORMANCE_PREF			0x00
+#define CPPC_EPP_ENERGY_EFFICIENCY_PREF			0xFF
+
 /* Each register has the folowing format. */
 struct cpc_reg {
 	u8 descriptor;
@@ -118,6 +121,7 @@ struct cppc_perf_ctrls {
 	u32 min_perf;
 	u32 desired_perf;
 	u32 energy_perf;
+	u32 auto_activity_window;
 };
 
 struct cppc_perf_fb_ctrs {
@@ -125,6 +129,7 @@ struct cppc_perf_fb_ctrs {
 	u64 delivered;
 	u64 reference_perf;
 	u64 wraparound_time;
+	u32 perf_limited;
 };
 
 /* Per CPU container for runtime CPPC management. */
-- 
2.25.1


