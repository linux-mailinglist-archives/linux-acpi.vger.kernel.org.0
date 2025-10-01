Return-Path: <linux-acpi+bounces-17477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EFFBB0F2B
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 17:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A12162EAC
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 15:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885D530275A;
	Wed,  1 Oct 2025 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aUoukFYs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5325DB1A;
	Wed,  1 Oct 2025 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330920; cv=fail; b=o4zbzPjpk/Yp5ZkFDqxmx9aWM56akxU9snR43bpzieScKsJ+20zysGH+rpYe9ES6zard/FtHJ6nd8IZHS/6GmXdJR2Cnx4zVFPoFSqhRPVpPpcIlUdSYkdM+ATbe+8Y73Wj8Bcu/zBt2jRRy1mh16cXS1r/HotQ0CbhdxxBmYFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330920; c=relaxed/simple;
	bh=byEGQgda3vlPLeFJBc1dLmn7pJsL1vRoBQ1b+AGcWbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLai1LM4qdXgx56lxy7XLHpX7AQ+URqYGrlhLM7Jg7bw1hnf2u/yIj8q7Qtch8uZYlbDQmczOhLNBblREtECiERTzBM9evMZ4g5Zy1P2zl5+X5azhdaTGYJoZi5uyZgsFFsMiWDEmY+uhumQKrSXoLLHOIW2g9bIVHQcIngBlqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aUoukFYs; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xV6gMbf5XB6PoYJKXDrIFLlHvok9GWZBnP37M3NCKP2w98Nuo2zZTkyfCYGETuY4fnaNVwb/ADIz2fleq7fGgqeSxzCfM3x8lRGgTRED7+ps4uAzBXEpbmaI+q9USVo+6nQMacMjYGnyGQ9oo9mNFlfp7sPZuMPYeGgHsHNB306yfKZwS8t1VaVWvY9Whx0UycPUK/73TThDNbPgeq4Mp/afQ8IL8mprbfxnt9cJKE8doblDm+yeZ+7zeaSthOg+Kzs0IXlyOuBZrWUONMyuxgxMcbDlg4897c1RM9qbPJ5rv5VhMt6CNfvjtGl8EglDEacEj6+9H4SrZgkSCtLi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKiQlfKM1MsvrfoqoIXi5g9aTUfyXaP70QlfWL0N9Yw=;
 b=U1AaavOBHN4dnTUAVJzI2oRAerqf81HQdHNriPxEjKtCE45iBRUpy4ciYam169dhUVGeKybxpaDy2NIH2Sp3UPbFucuwQVd5FKnily3JDiWNrIZcyMhHrF5zN+BqaLKOn1KOoxedOiqDkgHDVW4zHRCHP8AN78t7fkU0XckymOCP2U1vVREhiDNcVDl8OEXoWxbis3Yr3yFjCWlQN2vihAlPzmkzQO4uGpyQwd6wbSkYOI4tgn6SH6VQHd/N36wI8qdzHwox4YgX+irCaKGdDWndT1wYzCKAcbW4Vu7DLogx9ZzMfzvfiK9jRm9/OuUV4+eYm7J+H8CSdwJQS87VhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKiQlfKM1MsvrfoqoIXi5g9aTUfyXaP70QlfWL0N9Yw=;
 b=aUoukFYs2fIIkmtYX4jMk4WKZpYbwqUWCk0zP9Ul/8oN8aFwsTSgMd80cyunS+duvvZRBUEFG1cldUfM85LkIAJrxjsocyD1Y6DbI4u7WP23z+so6m4H5zYpfgMgYAxEbihMiVoRLz66quuKlg+gJq7qEdg1PULi0Q+wlIv177t8Vk8dkZKNpLRpPOrc2YPefmwGkmkR70p7vH8Yz+7B3n/lMdspCthJ5gqDjhopLXvcZmCSY/nMvmQ3LPzJyV8+e0OlYw5LgmMKxo2c4rsgdhdLY0fwdouxdJrPavNZ5zbSp2sQU4Af5pcNNlr2/JwhyoTi1Et86wvuBS1onOF4ZA==
Received: from BL1P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::20)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 15:01:56 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::ef) by BL1P221CA0019.outlook.office365.com
 (2603:10b6:208:2c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:01:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 1 Oct
 2025 08:01:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Oct
 2025 08:01:25 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Oct 2025 08:01:18 -0700
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
Subject: [PATCH v3 1/8] cpufreq: CPPC: Add generic helpers for sysfs show/store
Date: Wed, 1 Oct 2025 20:30:57 +0530
Message-ID: <20251001150104.1275188-2-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: e71b0798-d20e-49c8-489c-08de00fb7692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ToXHLcwDotVCtVVTk5SG9Gi8sgzip49FEp72cMt1gUncvj8gOSXDCpPOC7LQ?=
 =?us-ascii?Q?Pm1VYAgNRc0WQyb5B3pGDsxwsTcqn+BD+IFAIpNiDdd01gnZHfsI9OAYUfb3?=
 =?us-ascii?Q?z+Whcn5xEhXcFyGM+ZxmUl3yuHXpAhxlVp2gq8lcA6libEGDQmjZo5xXkjdH?=
 =?us-ascii?Q?IEIyB1ZT1dVN7lqbw+iy7s/IxQ4h07oaYJS0JbwOA9oE73X89hWI/1+bzzV+?=
 =?us-ascii?Q?LGxuGY+DBX8gnQXd+87VRsZ1q5x7a9VopYZVDTHjNqFEl6YpOaH5CbOKHcNE?=
 =?us-ascii?Q?+LKQHOlEx+DiLSPzzPNOT854uv4sxXKqF4uxUofsNo8UIAhv51BMzkUTZehj?=
 =?us-ascii?Q?G39rdvOxpSvUM+4v3SzK/2peMs2PUTSbvUk5qHpTuPgyPhWKUX5x37NHMaHD?=
 =?us-ascii?Q?ZhAeXtQapAeZwh3Fq70VvhDc+Jd7OicJplB/sCaRiyLQDSD/92eEIbWZ4fZJ?=
 =?us-ascii?Q?KF4GvX0bY1NTClrp89amfvQyiwTzf71snoWnzzVu9fQowwTbLEQzbhplryMq?=
 =?us-ascii?Q?oR6xo4eV0RtzaAYtUIs6c4Gt3xO4rG++b8uMcwXib3tnoiZPBuAki2qJAxWQ?=
 =?us-ascii?Q?ePNTk9r762kqgFwYQ8gklJcwUX8/bqRg7vl0eCFzUDuNgNoleKTJaZkxANNI?=
 =?us-ascii?Q?cm8BwOjaXVRbGwMOppEKvdPDYWiV7WaBp5N8EbhQBTrbEKvtjhYoQoW85u/B?=
 =?us-ascii?Q?mP8ih89x/Bg+s9u3SDdtAwI+E4pru+5TIGre1ZmiIqJttCgWziJhfxJXaW54?=
 =?us-ascii?Q?ZSTNCuIIvXbM9ehpZ++Bhnz5RXp00mmtH5ohFtodBES2pQlpQQznBSA3Bgtn?=
 =?us-ascii?Q?G2KZg7t7/GP+BhughsNocFzK8bty0x/pnEn9kwc1MmFYfzgOniipfMA0zp+5?=
 =?us-ascii?Q?ATxZlbYoFaSvoW/cDqG+ZIKjU5QUu+psJ6Y6L/R7V+/8KOXC6IYeK0BwBaEX?=
 =?us-ascii?Q?ZD5+w8MuLXlEL0YHY06W6BKK04HeoZSQmY33+kdbKEsrVAR6OhP5U246QsfY?=
 =?us-ascii?Q?kq5ZX1Odgwumd+cBZcdcGSBNuqpKDE/tFd+ISDAK6S9xUHjhxPjJauArtnRb?=
 =?us-ascii?Q?a0170yFKvPy1tIdSIqj5AA/WB2vD8dtgIrGMWmcKmWrPIaWs6LlJgOvFxjzb?=
 =?us-ascii?Q?ZEnc87A0Yuf2WyXgdaM67iCxE272XmgXRQvin3RU5VkbqmR/NqF4tP8w0zca?=
 =?us-ascii?Q?KdZwHrqavM+IvflqXI+0hKC29p3uxO2PYSFDLl5nxU7hZXsLh/qk7Y1Y3G8Y?=
 =?us-ascii?Q?YAFPjh86OSw5U43TP7gwDEFSAlaQTEnCHavgdZpOdZRxfzkPg8dlqH3F8KnH?=
 =?us-ascii?Q?+Oi67F9Yq7NNfihld5YxfUONrjPfzJOfkoMGxLbha6p4BN2FruF5F1r9Pheb?=
 =?us-ascii?Q?Bj2ZLvoWQY0LwEK9fI2mAliX/oSx8Ah7xVPMriHU/XOrcNDxcbFCjTWGr5XR?=
 =?us-ascii?Q?lij5P1RNQa1M82B3C6Eezxv8EQ0/LfiGReOC5eahCMDlyiMIcUklnwCuzQ+E?=
 =?us-ascii?Q?sMFlVsE42DQNA13qF9wlkO+YnfBiDnGvn6eLi2r1rIlMTwcyxlb2LbKe0U2l?=
 =?us-ascii?Q?l0tO0c2B92vLHuo1URMXTyB/SNsZqXOPbvimMZr/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:01:55.7376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e71b0798-d20e-49c8-489c-08de00fb7692
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509

Add generic show/store helper functions for u64 sysfs attributes:
- cppc_cpufreq_sysfs_show_u64()
- cppc_cpufreq_sysfs_store_u64()

Refactor auto_act_window and energy_performance_preference_val
attributes to use these helpers, eliminating code duplication.

No functional changes.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 87 ++++++++++++++--------------------
 1 file changed, 35 insertions(+), 52 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 12de0ac7bbaf..732f35096991 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -781,6 +781,36 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
+static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu, int (*get_func)(int, u64 *), char *buf)
+{
+	u64 val;
+	int ret = get_func(cpu, &val);
+
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", val);
+}
+
+static ssize_t cppc_cpufreq_sysfs_store_u64(const char *buf, size_t count,
+					    int (*set_func)(int, u64), unsigned int cpu)
+{
+	u64 val;
+	int ret;
+
+	if (!buf || !set_func)
+		return -EINVAL;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = set_func((int)cpu, val);
+	return ret ? ret : count;
+}
+
 static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
@@ -824,70 +854,23 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 
 static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
 {
-	u64 val;
-	int ret;
-
-	ret = cppc_get_auto_act_window(policy->cpu, &val);
-
-	/* show "<unsupported>" when this register is not supported by cpc */
-	if (ret == -EOPNOTSUPP)
-		return sysfs_emit(buf, "<unsupported>\n");
-
-	if (ret)
-		return ret;
-
-	return sysfs_emit(buf, "%llu\n", val);
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_auto_act_window, buf);
 }
 
-static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
-				     const char *buf, size_t count)
+static ssize_t store_auto_act_window(struct cpufreq_policy *policy, const char *buf, size_t count)
 {
-	u64 usec;
-	int ret;
-
-	ret = kstrtou64(buf, 0, &usec);
-	if (ret)
-		return ret;
-
-	ret = cppc_set_auto_act_window(policy->cpu, usec);
-	if (ret)
-		return ret;
-
-	return count;
+	return cppc_cpufreq_sysfs_store_u64(buf, count, cppc_set_auto_act_window, policy->cpu);
 }
 
 static ssize_t show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
 {
-	u64 val;
-	int ret;
-
-	ret = cppc_get_epp_perf(policy->cpu, &val);
-
-	/* show "<unsupported>" when this register is not supported by cpc */
-	if (ret == -EOPNOTSUPP)
-		return sysfs_emit(buf, "<unsupported>\n");
-
-	if (ret)
-		return ret;
-
-	return sysfs_emit(buf, "%llu\n", val);
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_epp_perf, buf);
 }
 
 static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *policy,
 						       const char *buf, size_t count)
 {
-	u64 val;
-	int ret;
-
-	ret = kstrtou64(buf, 0, &val);
-	if (ret)
-		return ret;
-
-	ret = cppc_set_epp(policy->cpu, val);
-	if (ret)
-		return ret;
-
-	return count;
+	return cppc_cpufreq_sysfs_store_u64(buf, count, cppc_set_epp, policy->cpu);
 }
 
 cpufreq_freq_attr_ro(freqdomain_cpus);
-- 
2.34.1


