Return-Path: <linux-acpi+bounces-20466-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC7LIkexb2nMKgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20466-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:45:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFE847E15
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03B8D9AA2C8
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934E34611D5;
	Tue, 20 Jan 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tbSzs1Ik"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87FD438FED;
	Tue, 20 Jan 2026 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921133; cv=fail; b=pEI0Yp1MO6vPBJrtVDE8rhO2btzDy/fL1mnL7Nl6HYqmYRAaAfbP2RZnczR20baWvsnaaeqksxyUXCNGeoUTz3vuhjG8r8mvBDsoK6Qbh4eYr0FAh5b3iwL/MVHbQ0LGgAZqQKuhkCWzmdbY5rAOEmvNwVpjQa7rUPeIz1UfNYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921133; c=relaxed/simple;
	bh=84mvYh1SXpB1oh2Q9wA0U5pBrTYBDlj2HDFzWrjQylc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWh3/zK/pkDGmiO3PdTKNpC5vobbjECOhQoEYG9tjZyJxzxuT9MnE81Mx4ekQw1E0Y9uM1RVoTjcHGpxG5a/VkogElCTqQG24/ZD7V4WwT3kMEWFv1uZ+T8LAjen4fFfmWNoFyz/u/dPioi7WqgqoW3f8bAoF0AhaVPUeb4UcUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tbSzs1Ik; arc=fail smtp.client-ip=40.93.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdkS/mArPdAsDtG6ptLlHBXvEjptdVPzd5Tlg9Dnxo4o9vM2EUiNTNhZLkc8tV3rfzKWyO7PX/FTkcwqVIaP8aY+pss2IU1YAC1cVkFNpMy9CYlkfJVQ2TLweqQCL4cO436MGYPsnrucWII+Xy/yqHSyfjVbRAwYR22HjXDiZaZXNBrOzytbEkT4QEdrKUrc/RAyrvHc1WfQGYBG3AcRraG8Iqkx0a/fIbQThiMZkaaHf2RT4WqT8zSF5FOK4TOFXwMfmATXTkW/0tvxFEuPZqDG3Ao9pjsJL9tbEc4HU/0ZM5aAP2dJRcCVqsni9JeOZDSCmEXacupkZnvfnb/KRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hqrrdCJwqABcjLtpUyYItscknQzNs4FzJVgVR+GIio=;
 b=EPKnclJa6XF/Clh6lOyeU+9YClMCwStlxNdoKA5EBoxy3N0jAm3r8NtNBtlmN0CtFuggaNJfqP/jT9uo9M+pO9UPwMzbW4jY18xZ8sF6Rvz3gLzcqDauL5EDxsIF0hJ6un8QmzhqG5Pj722EN12p06MTn7DpQEKU65h9BLuPUlynbTgUe+kJKAbyxFNYk/ZP5KDHAPn6eeERuNK3ydRnqFKoAoNbZWz9fYsGlixUX1bqAij05PN5gvDR/ZH0sLLekzY0PGcFIRkTkfsH3qEiYXbQjURuG6hNyVV9dOMrYjFo6UfhTjMT/oXl1wJT66jqOCxdqy3VMyHBIHlv4DUYPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hqrrdCJwqABcjLtpUyYItscknQzNs4FzJVgVR+GIio=;
 b=tbSzs1IkmQ5TaK18fPw5EK/683/vNqDXKENmDVN3I2a6mMVLTsC4b8VsdKNAWrtk5EsRlvahV+mePbpaFrPBqd+NoBdNjJZBsOSNwHfvmAPXxS1yf/1B0vqZt/3tRWqWB/qTxq7Hi6EgL/MhBos5JKM8nQU29jVk/HyzpPvLz8ek27ohl7Wd++PuQ3nB7/dB5qCuBzqp/+WqADQFdAwM9lV33z2tseDE0g81GHrDEg0x3OKxjk4JnvkWVWpYFn8EaRr2cedf3eeqKTzHt7XtQVzs2fTYi+2PPFr0NwGAt8SKZDoWWI+c39Eyj0KiIy6El4srOeibo4i87rtfQ+PJ2A==
Received: from CH5P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::24)
 by DS5PPFB8FBD73EA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 20 Jan
 2026 14:58:45 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::f2) by CH5P222CA0003.outlook.office365.com
 (2603:10b6:610:1ee::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 14:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 20 Jan 2026 14:58:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:58:28 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:58:27 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 06:58:20 -0800
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
Subject: [PATCH v6 9/9] cpufreq: CPPC: Update cached perf_ctrls on sysfs write
Date: Tue, 20 Jan 2026 20:26:23 +0530
Message-ID: <20260120145623.2959636-10-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120145623.2959636-1-sumitg@nvidia.com>
References: <20260120145623.2959636-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DS5PPFB8FBD73EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 71956172-93b4-428f-648e-08de583468c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VTKNStWjITNSSj6lNmKyl4o959slffcC0TOUdMNuWJq7LEb65QQ+2plgYuum?=
 =?us-ascii?Q?EckJVlG5FdFPNdMlJrmGlCV0NYoTAg+bWw9Bb2WswGThiOW3YtJjpEQy8gc8?=
 =?us-ascii?Q?wTAeWdeWmlDucyFTEu1zxYC0gQYUZsT8ZGktPOu3aHCgex7i4PtKIogEPsRK?=
 =?us-ascii?Q?7Ln3OCLrKIdNzzHJdch/ip65Zr45RlrYIJLGRou8V3Wm4uXTxQHc0BSrC8+3?=
 =?us-ascii?Q?wqW5kZaJCN2LDfqDEH5dnwJ6BfYd8W+wdQFMc08G8SIwWbUL/n7HXze4vT9H?=
 =?us-ascii?Q?xUmHGNKQDpTPUm8F79QOLxY7p5HBfC12en1AeAFKh2glzL/vhDje+oO8itrz?=
 =?us-ascii?Q?t3Dh4orDJmFg/TN8AYn8RIreuZdK3zJmDnPEEuQWfMgf3AhPvQaFWFnNlKsf?=
 =?us-ascii?Q?NZLx6zor+BabdQRlu6D6NKnSOmhDDAYXVGZsalXx8ej5w/g2gwKHxDgp5yf4?=
 =?us-ascii?Q?W8kknfAZCGc8aqqb1V6KjXnpQfQAEk9z7T/oxjXa1r+CzO+ZXltdl6/ocht3?=
 =?us-ascii?Q?tSIXNL6EW3xMqfPY8H/qp66esBGOn8i1UmAksNMbKTsurOn1SFgqjBnYyp3V?=
 =?us-ascii?Q?yk6QjjJzmWA1jx1pHbke81J6LkzbO7avSoY376SP9rk9W9Gn87xaeU5Lh0dk?=
 =?us-ascii?Q?jqsMWYgfvwEu448L3Fls0+ksYGik0f/wAvEEJlrestqbWwBo+GQEdMX4nfHO?=
 =?us-ascii?Q?jxWGYVMCvrQNfBPwpGGp6etAwuz3veKO5fPSQ57xHr23vuw2mbieMN4IZHaz?=
 =?us-ascii?Q?vNdNpvcAwFYift4KyZSFFiBPtYgifNTklb/2/+KiM5GTpWW9H8VDRE7Tv+H1?=
 =?us-ascii?Q?xgQgk/uanc5nsAQR9T1beYbSHdH47wecHcsfGDOglyshVCUewMJZrKbbe27Y?=
 =?us-ascii?Q?u8o7YwvVf9NM/X+rjon2fgB39bnz1KWIgzlnpaD1lQUvyjMbTUy0sdYJ/G3i?=
 =?us-ascii?Q?UuP4iQb3v4uLLnz8DJKyAHpR2Gt5tfRBoCV7H81Vj6CaqwiLcMlsukqWuvkv?=
 =?us-ascii?Q?jG2yW+HexzJMRMRYEk9UWQBgoU5FxnpfrmuCVheUq8ZOSIUTtwc05UUNZX1Z?=
 =?us-ascii?Q?Qm+NAjH6NyeCYyk+HY0ojxRm/pHcGXA39x1HmeXRM1rLWh1PLORGmhuF+qJI?=
 =?us-ascii?Q?5Z9nHLRyFaga35O9dSoYnUUODB4LCtuaH2NTLfX3/+H59rj++OFh8xljeDv1?=
 =?us-ascii?Q?Wf71L2ZXwRsPak7fb9+q1zUjOi0FcAHsYEEU2aZNHkSHtFzA28HP9JoAtv9c?=
 =?us-ascii?Q?Q18Y/CrDdoPBHuhxdxFt2JN4JiJJ6Jbd2ISK4LWFsyz83IIq96pQTZS2ex6B?=
 =?us-ascii?Q?1/Uba+FgEVQ8xPV9fTvDmMO+kWTiHlHCr4e0lNon6QwNbcZIKV65MoJRrL6R?=
 =?us-ascii?Q?aG1ZihcSLgFGl7YyFfHwVbn6Fja7wME8Nxcpq3LWRM/Z8pXaI9MsXJrMU0gb?=
 =?us-ascii?Q?A8nekTCuE+9hzhD/4ABtrzidww75rh3xTtkGyLP6wTNpsCSd4PEnvKP6xWHr?=
 =?us-ascii?Q?d4PzPkgmn17hSZowOgy82UxvSvy5oY0Ar5NfXjch/Y9jzfkZG/2I9LKtwCJN?=
 =?us-ascii?Q?u9PKH7kdBet6Mk8VYXBK3bUOGSA+Nc+iIqyY9eGDggPSN6H3O+bh7vFemGKd?=
 =?us-ascii?Q?evbQXi7iSxA+bVBW+ZNf1kZjO1jNEOhsrNCFdB1M08xwpi7s404KCr7LZaC/?=
 =?us-ascii?Q?Sccqrb2Hh66/g0GmymtoySD88o0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:58:45.1568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71956172-93b4-428f-648e-08de583468c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFB8FBD73EA
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20466-lists,linux-acpi=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_TWELVE(0.00)[28];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EAFE847E15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the cached perf_ctrls values when writing via sysfs to keep
them in sync with hardware registers:
- store_auto_select(): update perf_ctrls.auto_sel
- store_energy_performance_preference_val(): update perf_ctrls.energy_perf

Add mutex protection to these functions to ensure hardware register
writes and cache updates are atomic.

This ensures consistent cached values after sysfs writes, which
complements the cppc_get_perf() initialization during policy setup.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 35 ++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index afb2cdb67a2f..946fb93179d7 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -886,6 +886,7 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 static ssize_t store_auto_select(struct cpufreq_policy *policy,
 				 const char *buf, size_t count)
 {
+	struct cppc_cpudata *cpu_data = policy->driver_data;
 	bool val;
 	int ret;
 
@@ -893,10 +894,14 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
+	guard(mutex)(&cppc_cpufreq_autonomous_lock);
+
 	ret = cppc_set_auto_sel(policy->cpu, val);
 	if (ret)
 		return ret;
 
+	cpu_data->perf_ctrls.auto_sel = val;
+
 	return count;
 }
 
@@ -946,8 +951,34 @@ static ssize_t store_##_name(struct cpufreq_policy *policy,		\
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
+	guard(mutex)(&cppc_cpufreq_autonomous_lock);
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


