Return-Path: <linux-acpi+bounces-20762-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPFuHcc7e2n0CgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20762-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:51:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF98AF2A6
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6121D30301E9
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF5D385EC6;
	Thu, 29 Jan 2026 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E0/Ric2J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A1381716;
	Thu, 29 Jan 2026 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683803; cv=fail; b=N+RxEU9FwWbqTX87xabFzUurQgP4995uYGIdiPXEZnT/7Bgu9Qm9iFzTJ919bFUnax4lyBg7172aID835YmPdrxJITsraop13c8NiKtON6SCX+TbBKV0m/5QeGruWX8V1jljysmDhXJLFkAw03yDr99p+ruhHx4dai5mfZ7tNJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683803; c=relaxed/simple;
	bh=f4PeCbXPuZADxYvX4LaSiGIZXstreMrfIbkZu7ZUw1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCDbZ91Eold2n7lRsxxjSrktnNB3y8RyKVsWBZWb3+7dFmV9XkfvYEsGEuMA0VK/q2M2G5wqNLSMLnkQjZCa6I2qcXMVD/4NvXsVvwRuO86reHIXOl8lqjaZMHee7J2+YkiuBg5Owb0sgbl0k4/7z0ssLCE1qwySAsysfx70yz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E0/Ric2J; arc=fail smtp.client-ip=52.101.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4RJoVvgBDoJtmkbg+u7KAhACPDJ5NCfFxOEpS02n3lLc8rPGDtj/0RkBhRB2rdi10GwvbQYY/zTTYSdw4JjriHoHu2iD/aM4Ks4ZNGAQmxfy5By6/QWzclUlHnzxNLfsgXNwU5YRSZevl79H84oAgIDatjB3TcZcc/yJp5VHNUHCOO8DoDJkvvuFU6oxIQgMKSb4bpIdZDVkKjTR2pcynUQxXgVgiGCqcavP3HHe35PcGGujXqRSZkwb+PgZPM5OQyUn9TdselAjrTdTFO5tXaFDRjDpPn7OQeYZ5YMWcWX0XuxgwQrbtMvXCJFJPZO7WVq+LO27Jf5MDjYp5eH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eU2DblhssRM3xSVX0lZgFSi+LYQd6J6LbFLFiH4bSU=;
 b=TcBm/5EHgZo7M10bwypFQ1YhoDa6WJ3/S/050kz//w+tdS7bHZdEtNKlx1L0O4ku28pS9xjbzHV9fO1oXrnuyV8Fo7Ag3llYkHyQmA0E1Ono3nAZoO6c34h+XTecud85MQixuuLcd2UPau+bPn1JyGODVWpzMK36kkem/MVFP4n2Fhcd06EHAArkS8uxCKJsMo9EpZV0S75+j4TLjSKVo2XXgw3LXRYAQt6MNqJJ3P5fl+Hx32p59fvTs7/WSPEIxstrSxulk+3lJzT73L4CWFfoi/FYoGNIOKOUNhSGvyQN39rbG0kKgc/ElZ0+be+OXtg6lAR+yRgHUSt+1p9joQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eU2DblhssRM3xSVX0lZgFSi+LYQd6J6LbFLFiH4bSU=;
 b=E0/Ric2JKBgEq5WVGjhMfSR8OInHr2H76UXQJiq4kq95+7i6fdoKiOwHlu6jak2vI8eB5n0dTC/StBqWV6ufWJcCGUp7waRAEbjGilrE6xsnMGQCkpCYCD7Zt5O/Zq+KQuYjnBf8p67l59Jxe9aYxF0fYSVHyFLQ8mPbrveRK0kxO5+ikNBNqwFjj7JmBtDWImoRG/YTaih1DD639zZhry7jU5aqP3U7mmVzThr+Au+rYHETVmlN1NeIYJZ3ZkhD74ZP8PqN5H52YxLlhPNxDAMPyKW+/a90nNTuePCaf9IpCGz13WRT+QzFCJ+LFi+783r+jMtXYU4Mr/mGu4SPlA==
Received: from SN7PR04CA0055.namprd04.prod.outlook.com (2603:10b6:806:120::30)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Thu, 29 Jan
 2026 10:49:55 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::d8) by SN7PR04CA0055.outlook.office365.com
 (2603:10b6:806:120::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 10:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 10:49:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 02:49:48 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 29 Jan 2026 02:49:47 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 02:49:40 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <ionela.voinescu@arm.com>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <rdunlap@infradead.org>,
	<ray.huang@amd.com>, <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <zhanjie9@hisilicon.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <nhartman@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v7 7/7] cpufreq: CPPC: Update cached perf_ctrls on sysfs write
Date: Thu, 29 Jan 2026 16:18:17 +0530
Message-ID: <20260129104817.3752340-8-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129104817.3752340-1-sumitg@nvidia.com>
References: <20260129104817.3752340-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 42fdd028-cee9-49a8-61fc-08de5f24238e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0cWpVpn1uZbewexyxzPQs8aIwmTKyVS2pgze4nWkzcuxjJWEpusB3v3Bc8HF?=
 =?us-ascii?Q?TwSK1pGP+f3K/qUv5wXighpDXiJN0C4FSdnPSaJ6f4hO1o/9tSoEftANKDzt?=
 =?us-ascii?Q?nW5pdgyEU2HayyZdsgWjV+db2JIjAh+riyQVfczl6a4k9TeCTV1hRhI81Uzj?=
 =?us-ascii?Q?ER7nAxxP6XDb432Q4noswfm9EvwSvoKCLktK7dMwKB1QpskM+ygrglFEnVS2?=
 =?us-ascii?Q?J/PKs+QjSqq+1+fX0K0NTo8jEwp3k16yUVBtVJsE5ZaiYgaeehXt6Cam6lOo?=
 =?us-ascii?Q?VICr5PSovCjQ5eg+kf43zE3Csh9KyOVr2Mv75PUX1c7LNvpGZ9AfxF1cDgVe?=
 =?us-ascii?Q?M68JS1epMa/nCqdnvogFci707kmYwTlJnuRHoYr5QRhgO3Uk/Ft8qYiFTiFy?=
 =?us-ascii?Q?Du7TAggZICdUxwfUd2Y27fLI4rKRq6aLSi2EujjrXV1Xp/qgs5m5Wc6loC2W?=
 =?us-ascii?Q?1lrRMBf9ikdchKeaR5Po0rZSQ5lW1zuIvM30wgfNmH1iM3MhEWXVatIRlDjO?=
 =?us-ascii?Q?IQrxHLS0iO+32Tl8BhePLqufPRqNLeLJqIcu58mxirfuHFibaoARZ7QELqam?=
 =?us-ascii?Q?s6piRiQ3+52TZjW6DiXqMsFJ8i2T5J618cUPquGg66BumgaCk7XGr17PZ/O/?=
 =?us-ascii?Q?7pec7sXrxYQbiZ2oarsGvQBSJRm9ipLq8t5RF+HHnggXalK1YGmKtU82m4NV?=
 =?us-ascii?Q?FqEHwelRmADDjSXiWTn7bM1ePQPYrCviT2QRjomUOTeS/8mKquc/pjy0nOt4?=
 =?us-ascii?Q?vH4/lD66OYs1jbxa6Sr2yUYjA3qBGJR7qiPl1lqxRs2eOVAjfzVDl/2T1b5w?=
 =?us-ascii?Q?dWc19nbGViJOueO573vg7UHpq3gDuPbYI8RmeZsVWaZln2LQ0Su6qlMzmXxu?=
 =?us-ascii?Q?z3zPke4NrEWHCAm/X1FpQGmsMBm1CORmLm2h4uRE2Lle9IAxuxx3pWCord+T?=
 =?us-ascii?Q?f4OuD2KaX5Dw4p3I+uVrT1trM85IIG8NQgw7WNSYPXxCCNjl1C3k8tN3S9pH?=
 =?us-ascii?Q?cVtyFArBbxaFKeVXZfFKZZ+vmTWjVFdgeo2SOeBzURO+kLGWrSdgWGRo3l8t?=
 =?us-ascii?Q?uKQhglYO6ObdNb1sR3iC93R71vi82s4lJNE7kwtRRiLUWopNAHXnLkmKuCXN?=
 =?us-ascii?Q?B0aIybWUWBk1skFlGrK2/Prgalhy+09YfqnEiA7i/z/xx0Qm2ZfbdBNk5gUO?=
 =?us-ascii?Q?8hKlq5AVscglSHL08X15CEr2ed8noqp3iKcoX0ocSno0LS3TzgULfBv6gZsv?=
 =?us-ascii?Q?l5jHhmEWS3mMPJk7czvNI/n7Aag1vt4pyw/mOxaN/uQ0DMe2t4NV8if5fbgm?=
 =?us-ascii?Q?kqEy5OyK6FbzYUtSj/VIzhNTI2r4G1hJxwRioM7hEvjHI38qH8gyftOI9kNQ?=
 =?us-ascii?Q?drgFb4Ns6yK6KixMc2zgrNxFvNBQwDjQJo48QQdkkCq0RyH3M6/vOPIm2Qv+?=
 =?us-ascii?Q?4hXFWC2OdlCfIBMmqNDe9OUxBxsv9pyf9hd8DSei/fsSgt/i9OR+56cl/R4o?=
 =?us-ascii?Q?RaHRqdJ0rP2MiEHC5mdy9p8/RGPIkhnB1CFLZyEL88tWJtxO3OTxEoRl4QvI?=
 =?us-ascii?Q?rJwRSYJM2H/iA5E8q+OH+Oed3wdBV4Q7SVx83sFOaSUtyNJzOnMXzyNlML7V?=
 =?us-ascii?Q?woLgEbAeWd0iUZ146NrYk5BXre32RzI9MYrd22GRFRqaiX+MDWv4AlISbPQj?=
 =?us-ascii?Q?A17vJmv2Y7lZH3vnB7GFrqJppDc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:49:55.1935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fdd028-cee9-49a8-61fc-08de5f24238e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20762-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3BF98AF2A6
X-Rspamd-Action: no action

Update the cached perf_ctrls values when writing via sysfs to keep
them in sync with hardware registers:
- store_auto_select(): update perf_ctrls.auto_sel
- store_energy_performance_preference_val(): update perf_ctrls.energy_perf

This ensures consistent cached values after sysfs writes, which
complements the cppc_get_perf() initialization during policy setup.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index ca49e25aba5d..cc04d91bb795 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -884,6 +884,7 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 static ssize_t store_auto_select(struct cpufreq_policy *policy,
 				 const char *buf, size_t count)
 {
+	struct cppc_cpudata *cpu_data = policy->driver_data;
 	bool val;
 	int ret;
 
@@ -895,6 +896,8 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
+	cpu_data->perf_ctrls.auto_sel = val;
+
 	return count;
 }
 
@@ -945,8 +948,32 @@ static ssize_t store_##_name(struct cpufreq_policy *policy,		\
 CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
 			 cppc_set_auto_act_window)
 
-CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
-			 cppc_get_epp_perf, cppc_set_epp)
+static ssize_t
+show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
+{
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_epp_perf, buf);
+}
+
+static ssize_t
+store_energy_performance_preference_val(struct cpufreq_policy *policy,
+					const char *buf, size_t count)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = cppc_set_epp(policy->cpu, val);
+	if (ret)
+		return ret;
+
+	cpu_data->perf_ctrls.energy_perf = val;
+
+	return count;
+}
 
 /**
  * show_min_perf - Show minimum performance as frequency (kHz)
-- 
2.34.1


