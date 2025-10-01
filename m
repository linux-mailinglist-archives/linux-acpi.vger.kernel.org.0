Return-Path: <linux-acpi+bounces-17482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7013FBB0FBE
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 17:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5393BBFFF
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01B13074A6;
	Wed,  1 Oct 2025 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RLm0DxKB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26112306D54;
	Wed,  1 Oct 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330982; cv=fail; b=EPiwsP7/j3zrcA+PzHglnZcwfxyQ7DEcEwDXfmT+lNNjptG9PC1OLPFsRfUPnVBDfprdA9l8Vl382QRCNRCJAhpxnRlSX2a4rJ7pEnCtNTgc8fTQPxvB/9BMbM9liFusWof1nmE4yvohlVPm8jpJFAu3PePbx6Ih2XOEUeOgGAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330982; c=relaxed/simple;
	bh=LRTyGRKYlbLZ+OMrfMzOP7otqb/W/Ovf1/IdK+XdNXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwvHuH1mxovHyxsisx/Nu0G1qr6yTviTc+GzwYiYKsOYK5o9vmPPQVTbCN+jN58bkCVWdbGjQLPLskBDX6O5kcx1cJZ0wBBxiyeIwdzr1PkS85V4dHL1UMDkJ0rSMpItbed64+6ZYURrwpb3TzWFVXK355KIAdOLBAn7MZ3/wzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RLm0DxKB; arc=fail smtp.client-ip=52.101.48.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfUQJnc65r5wJn2K70kjHlmRr8WkDlIKY6RXANUQ7x38kh5W4/a/4aHbFp1tERIc6qzHpW/HeVO4bntIYpcEAHRDBQNp9X30kPf0Ad3afsDxSWmYA98oc/OUPQNyKFbHQchqNry6/fcSWXgFVFfGnF1aotUHgz5QqITI0UCFBf4y7xEGexLbXfQa+O3ErZJSwVIZ/JRUWPzbC/6UHwfleImcj0tCT7s5PhDslMsNVVGMG034lWK9poZk+lTeU5ObanB2RUJY3KOGj0+rfzmQtAVntTJvH3aqM5NpNmi/i1SAuFhsmQ7BZOnrlGoIVTcyskrE8fAhlznkYBFCN5fo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG9NZRBBs7Wou3cFVnB2ubD8+FHVk0nwEykCqTRz+e0=;
 b=U3KcfUyTMEvGF4w45+sBqXtBULcuZmcxruoHENI2W11A1Ykgji6t8r3/fNGWlDjg/C+U9wgvu8HuIyF/6WkotmwSfI9XAN8rbSiR4MPwhpvqs4bLd/lvqI68ULYmS+bd8nZOZqWLAn+fthU5tua1yrmPKPtrJIYgPRf0zknICgZTToYNaXfXxtjUGSr2qLyBBdvz/f05luVP7U7rDPvx5eI7GCTG6lrhQVOsEkQx0QvpZttu8nYDHQNMqt/Jk0Gak/6YXC7pcaibGs71067QmgkXwuRIH6S6+v6UuOwjQxu5VJWQ5RDfXtpA3/wmpRgIU8oOTCRtTEXIpzUfnlD6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cG9NZRBBs7Wou3cFVnB2ubD8+FHVk0nwEykCqTRz+e0=;
 b=RLm0DxKBqMiZu6wIHGJRAgEvwrHJ/MZEZ4Yrd+zyM9jtO+vKBXzGsRC3DPca/HhBRdWIEgwoK6FPB0NfDbUE+NsHT0dFdhEwov/RgGgvxF1+LzPUkkpsQaXJ04iTnScgxPp8y4JsO3mBvvii7RgTQPlOh3CXRxwl3q1bp6C0bZXACIE2T3d9QK4Iwen4ZoFec32M4Eqcc30ToX/PomysKNJjEM8bzvRKtr8N5bcxvfz42CtrEgd1WrdtvvA7KZk5NqAGi9YU9cIWdciW4tE0KSSqCumI7m5yf86y0+uqYoCx+PgAu/8isVW4x7au8IQGxdJnmbNW9O5uDS+5s6u6Uw==
Received: from BN9PR03CA0871.namprd03.prod.outlook.com (2603:10b6:408:13c::6)
 by CH1PPF2C6B99E0C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::609) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 1 Oct
 2025 15:02:36 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::d0) by BN9PR03CA0871.outlook.office365.com
 (2603:10b6:408:13c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Wed,
 1 Oct 2025 15:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:02:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 1 Oct
 2025 08:02:10 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Oct
 2025 08:02:09 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Oct 2025 08:02:03 -0700
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
Subject: [PATCH v3 5/8] ACPI: CPPC: add APIs and sysfs interface for perf_limited register
Date: Wed, 1 Oct 2025 20:31:01 +0530
Message-ID: <20251001150104.1275188-6-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CH1PPF2C6B99E0C:EE_
X-MS-Office365-Filtering-Correlation-Id: ce839b5e-6588-4654-72d1-08de00fb8d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FEPydzuiUFD7k/gyjXXnQb3s4Xt6yEIdcgpacfWpqlUFgFDtxSPhDDdFvyTy?=
 =?us-ascii?Q?MpPEn+oYJKUrHqwgZLKzxMcg1kAt7GQlv1FTlNWIRPen9DQkh/fhUWil7FjL?=
 =?us-ascii?Q?zmeZ8J6lgc3XioFc3873E8VNcYrKoEwMMrC4k9yrqz92nhYz05vfuE5k0YRZ?=
 =?us-ascii?Q?nJUBcpXUvtn8CiaaILXYNCbsz1fzu6RYjGcOwNoxTH2W7gTMVJ3Ioasbp2mt?=
 =?us-ascii?Q?3kY4CDmRyvPt9qgXMgjSMnmCxSqJZXfy+HEgjQG58QEBeb+VFjN5saJAtJBP?=
 =?us-ascii?Q?aiOG87PVzOGMND73NnzSoIEMCIAv/fUMm28BS/N+SIDZtJXUWfjcZsillbWw?=
 =?us-ascii?Q?Crn3FI58WC5D5+LZJ7r0Li4yt5JJ+pdIDDumIRy0yqiIbyPEUW72oFgNvIKQ?=
 =?us-ascii?Q?XJX2F+xzgSeUjwZnRLgAt3D8F5xrWWGDmEtkgu5iw9riepddZSdth+IKpEQI?=
 =?us-ascii?Q?DZeJOb5GU2tMrczJelkTPgvLvfrUjhi/b9X93pITOZCnm+U5mO6rY/fTNMOV?=
 =?us-ascii?Q?fO72xEjD/P6qN1YKssHSSp++LhlDJ9IGH9QhI0msRdBrYstzZeJ9lCVGIDjy?=
 =?us-ascii?Q?2gnPXcpTEXN9l4kTWDXo2nCjYKiYE830iBxyCJApgs61VsimvplAgfkX8Uco?=
 =?us-ascii?Q?MMwm7G8AU6s5WLFK31n89x3kY8FEtm4Tz2NRaQE3UlyhG4O2P1qVNJGW+WkV?=
 =?us-ascii?Q?bFuh1RZEUTLSV/+j1OHFVS26ntsmDhL8EJAjgGOWWAxXXCyDy1EBWdLiQksN?=
 =?us-ascii?Q?gGKHZTbwaCc9KIAbgzq78XX8hFOnY4xdxb5/jnNiFJ0BdEx7DSIzCa2n9EJ6?=
 =?us-ascii?Q?hmFlaP/HRfXKO/Eo2U0FXz3t8anHZCzQBVby9EWPbqI95OZaY3/n/zvYqq+O?=
 =?us-ascii?Q?3IQHljQKRX8RYrFtKDfFzD5eDclQD/e5OdT7rA+h58O/ppPa6NxbBd0fnQ7L?=
 =?us-ascii?Q?r+34dlvtd+yV6S+T33qR5+deQpMptrQSgPpT1hHGlpAPL/rihVLEq4bouhvH?=
 =?us-ascii?Q?rzxaxF4xhnHAiFYuSLjDYuGPWQTOz+WX8SPreAnKF4+BCKumR9vPUW1rI9xh?=
 =?us-ascii?Q?cgbN9VUmquVst1QblpSK5CGPjzinFpi6xhKRBTeieJq8Y+JvX7zi9dy+CnhQ?=
 =?us-ascii?Q?o2Ohzcb4L9b4HK9oojYDpdhlXq+ZV0YG6RkZRolEAw/N4OplmvgCfGDy+nit?=
 =?us-ascii?Q?gcHW4mTfZEY4NP/BffTHqOwSEJO4q/+ONXRekaSaiWmJlEx+ygYvL0mn2usx?=
 =?us-ascii?Q?MHbwa06iiDoR4K945FpjB4fLcZJcnDOHDIlttI9Bix3MiTulURsHK36WBHJH?=
 =?us-ascii?Q?xMDQKLGZm6F8YKkFfrE8YkQtL9SUH8rHNCzvRcOzplAFqApmSaK7aFIKHQjW?=
 =?us-ascii?Q?pQKdWaNmnI1vgUmhU6G1hDWHizx1Yla4S4Ccre5eKe8J2kiYmKoEWNyZZgDj?=
 =?us-ascii?Q?13ThE6VXqZ2akcbU6enbxNd/Ys8SKz/tGZMl4Tp/OfZfROX3ix6+dfHS6LaN?=
 =?us-ascii?Q?6ldkD1DxJ7WVcCJUTA4SR1xZ/1uvRLclur0cEvDOQhDTcEPNCnAFBrnuZidI?=
 =?us-ascii?Q?++YcSYsrbJ/9i1L12DiyasQCjeysRVLusyGwWOnC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:02:33.9474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce839b5e-6588-4654-72d1-08de00fb8d5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2C6B99E0C

Add sysfs interface to read/write the Performance Limited register.

The Performance Limited register indicates to the OS that an
unpredictable event (like thermal throttling) has limited processor
performance. This register is sticky and remains set until reset or
OS clears it by writing 0.

The interface is exposed as:
 /sys/devices/system/cpu/cpuX/cpufreq/perf_limited

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 26 ++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 12 ++++++++++++
 include/acpi/cppc_acpi.h       | 10 ++++++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index d47aec2aed13..ce99c3f3ae85 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1806,6 +1806,32 @@ int cppc_set_max_perf(int cpu, u64 max_perf)
 }
 EXPORT_SYMBOL_GPL(cppc_set_max_perf);
 
+/**
+ * cppc_get_perf_limited - Get the Performance Limited register value.
+ * @cpu: CPU from which to get Performance Limited register.
+ * @perf_limited: Pointer to store the Performance Limited value.
+ *
+ * Return: 0 for success, -EIO on register access failure, -EOPNOTSUPP if not supported.
+ */
+int cppc_get_perf_limited(int cpu, u64 *perf_limited)
+{
+	return cppc_get_reg_val(cpu, PERF_LIMITED, perf_limited);
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
+
+/**
+ * cppc_set_perf_limited() - Write the Performance Limited register.
+ * @cpu: CPU on which to write register.
+ * @perf_limited: Value to write to the perf_limited register.
+ *
+ * Return: 0 for success, -EIO on register access failure, -EOPNOTSUPP if not supported.
+ */
+int cppc_set_perf_limited(int cpu, u64 perf_limited)
+{
+	return cppc_set_reg_val(cpu, PERF_LIMITED, perf_limited);
+}
+EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
+
 /**
  * cppc_get_perf - Get a CPU's performance controls.
  * @cpu: CPU for which to get performance controls.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 864978674efc..9946adfeeee4 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -984,12 +984,23 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf, si
 	return count;
 }
 
+static ssize_t show_perf_limited(struct cpufreq_policy *policy, char *buf)
+{
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_perf_limited, buf);
+}
+
+static ssize_t store_perf_limited(struct cpufreq_policy *policy, const char *buf, size_t count)
+{
+	return cppc_cpufreq_sysfs_store_u64(buf, count, cppc_set_perf_limited, policy->cpu);
+}
+
 cpufreq_freq_attr_ro(freqdomain_cpus);
 cpufreq_freq_attr_rw(auto_select);
 cpufreq_freq_attr_rw(auto_act_window);
 cpufreq_freq_attr_rw(energy_performance_preference_val);
 cpufreq_freq_attr_rw(min_perf);
 cpufreq_freq_attr_rw(max_perf);
+cpufreq_freq_attr_rw(perf_limited);
 
 static struct freq_attr *cppc_cpufreq_attr[] = {
 	&freqdomain_cpus,
@@ -998,6 +1009,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 	&energy_performance_preference_val,
 	&min_perf,
 	&max_perf,
+	&perf_limited,
 	NULL,
 };
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index fc7614eb9dcb..9fc28fb1890b 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -177,6 +177,8 @@ extern int cppc_get_min_perf(int cpu, u64 *min_perf);
 extern int cppc_set_min_perf(int cpu, u64 min_perf);
 extern int cppc_get_max_perf(int cpu, u64 *max_perf);
 extern int cppc_set_max_perf(int cpu, u64 max_perf);
+extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
+extern int cppc_set_perf_limited(int cpu, u64 perf_limited);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 extern int amd_detect_prefcore(bool *detected);
@@ -285,6 +287,14 @@ static inline int cppc_set_max_perf(int cpu, u64 max_perf)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_perf_limited(int cpu, u64 *perf_limited)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_perf_limited(int cpu, u64 perf_limited)
+{
+	return -EOPNOTSUPP;
+}
 static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 {
 	return -ENODEV;
-- 
2.34.1


