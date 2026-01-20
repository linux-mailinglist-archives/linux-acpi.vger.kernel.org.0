Return-Path: <linux-acpi+bounces-20465-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNKqF/TAb2lsMQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20465-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 18:52:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA30B48E43
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 18:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E145A9A9AA9
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFA247279E;
	Tue, 20 Jan 2026 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pwlzGW2G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB8472795;
	Tue, 20 Jan 2026 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921117; cv=fail; b=b5YFLSxMtr7gI62/tdASrK8Hzb2PGg+QkVFYE9nPRtM4IuiTEVETxlTtleczHgFnLbmgCNHM162kDn2ljB7RFx1tvbv3up/bDCRL4HlMdR6iTGH4o/a5SRjtQHoWspYwSxN3V50fyPtSxS/aKgIrLC+iuS4hDUsiuJJ72zqOZU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921117; c=relaxed/simple;
	bh=37PwC5sDJBFH2LuAIPL6Z9FzC4Id2EtYQ9pibycQRFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLQiIea0KnItP88GVP8O12WoB/slbWZPIASwzJ669MepGqJZqP/9lf4AhR/JR+JHfdmPwYwaarBBGk7C0d7LHTTgTBqWUbCcVo3qgBuXPEmrk4iFy+e81ECFZwlGXQMNfpSO189m5YOSYvfCimhE0OKe80/1whhcdhHcUheXp50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pwlzGW2G; arc=fail smtp.client-ip=40.107.200.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evxSIL6kxEeXPMjItVdzDB+TIeI+EuY6wFeRlO1HIbhYeDFTsq7eJBEAiyHklfR1ny03CrxSDs8vqPvJ+vRabm7QsX5Kt3EIQnIEYe2Zq3HtU66ZU27M2S1BoIcEtc+F49fAblUDFDNHkAbFTALjTqBmMVrOjwidMYjfa3H1FqhV9aB96Nsh8sMVoXRLt6YqPWDzLG1Kp5T3xj+I9CDCAnq6cj+Z0i8Ba01Y54wmYer0gs728nDTeRTj3H34A4Him3nbKe2qFT8bf04lBsBZHfR7zD4JH/eI1Zj9hvupeSVDnOXLQ5/x27b9jpQN6DdZTeQ/FvFxsn/xx94DaWiyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhlCLkmgEAzheLtL7tNHBT/Dd6YdlRgiNt9Ek2T38Ko=;
 b=kjFXNBAXJuTi/RevN3SbUi60YAGP4KLq9jCfi+K3exCTWhra8kwS3Ssvx46We2Sp6EH/iMFrzp+lcE3WfNCH9YEq8e+c06MoYtYSkrEZYAvPdw1mcjogdcRnKon/1+MgamI32aLXTirgML15w5ArYMApGycB1HPt7AV59cth2SbZPW12uJzqK7ooTG4+fcYmmFU1c8qG3xgO1RFVDvw8Kg/Tm0utYMtThV21YRKb1wWVBIQWgR+RceCy9oA1JVdPLWrXuBhCFY1Y3Mh4xttFfqExc9g+GClnmQJIoVIRoYwh/2kBh4mYYvnQeaYdM8sT6hRKu3OkW6BbOgRCpVSQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhlCLkmgEAzheLtL7tNHBT/Dd6YdlRgiNt9Ek2T38Ko=;
 b=pwlzGW2GEa+VVjcCcnOXb7ksD3bKSa1ywsPsJq+VMQl3xsyyvPKLTv+ACHKu1PsUcUKLjA/jNF/eDTnQ4Wrdi6GnnInBf2aeV2JrfTGQa8tnZOexwdCkns7s9bqSSLXRgyJ9ZXrjJ7BG4wy9aBvDC0dcBRQECRiM5SItD/1m/RGb05mzxEDMLXL81eUe4ZU1UmqwXi6tMXMm5Tcc6iPMHvIWFXSYtnKP9LRcEm4B6tPUa+RaP9mvl2FWuW+0aaseHhIJO9DgAM8ml3slOHkbYFjroUNEc5aYMSyPFnAE7iV0u5KB90HZxLWlSvsle0g158TnB+q6jwS412atfUfqRQ==
Received: from PH7P220CA0114.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::8)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Tue, 20 Jan 2026 14:58:31 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::8d) by PH7P220CA0114.outlook.office365.com
 (2603:10b6:510:32d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 14:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 14:58:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:58:02 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:58:01 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 06:57:54 -0800
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
Subject: [PATCH v6 7/9] ACPI: CPPC: add APIs and sysfs interface for perf_limited
Date: Tue, 20 Jan 2026 20:26:21 +0530
Message-ID: <20260120145623.2959636-8-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 3502bd1d-014b-4653-23c7-08de58345ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lCrzMV01ecarOJGr916gXrfizkNXz//lp85LAxJFEopxw7l6zt5kqjar1+iW?=
 =?us-ascii?Q?GGENyvNUqvVSdVEyLBNoZPBtecZCw/RIDlDv3HvYkhlUEBP/Ouprl7NCBm3N?=
 =?us-ascii?Q?RMF9ABT/7VwFFSFx4/ROKCRQ0z4c2gKGWzL/3NfkB5ebuSztV2sVE5Xx1/WM?=
 =?us-ascii?Q?ScfajSeTAKGFCwZ5+HOw8Sz5hz3KvnoUtZVSeBSgI4++5DYTjYWJMrvnwH7Y?=
 =?us-ascii?Q?pXDzS2TWtr/YKSe7O0nwLLrgb0UIeXpWbUoHBsmCElkWWbddW/qFrefSsZye?=
 =?us-ascii?Q?X9OdICJ/4tivK4xQYfkQpb7yA357ZvZPaTF07slw0sm3ftdIg/7AnSg/elNE?=
 =?us-ascii?Q?JipZezGk6x7/Zy856WNl7K3rfPAueRRD4uWHtqjtL07cSMEBMlEFtIGjX8/V?=
 =?us-ascii?Q?bVcv1jzF4ZaSHPact4iCV+4FU7jOr3R2qvaKQCYcdWGuq7mr3Iv3GHg7DV0Y?=
 =?us-ascii?Q?BRN9L0VCI0v0XH8zGj255axnmyUdbAd3agdM0zUQk3ngwI2U3Ku6WT8JPf2Z?=
 =?us-ascii?Q?+aHH2IH4+oZWGnOdNI5b800RtJNksUrR8h1HXilBqXGxuVWSDANv6HOXa5K4?=
 =?us-ascii?Q?s0ikvj7b6xnX8AOmyTesQ/5aVRn/zDvNyX476ls+yYJcqILdlfkXHzKt/JEZ?=
 =?us-ascii?Q?oOzHOUBiGUGDi2QLWXqe1unafhrDDjTRP2YePY5nviC75+4Xvbc2eXpLrpfT?=
 =?us-ascii?Q?6kNPFAmMy2NVqv27GA1SWalxUsOp2WAfLjRAuG9gE368/PCTGF1WQUrOz/p5?=
 =?us-ascii?Q?0OjYioD11EvxHQAgNBzUN9sUj1uoHSD3H3DMaGg3wFGWJ9gDKiON5xo5a7T4?=
 =?us-ascii?Q?19PjuTECc2Mcj2PsEMh+qcoyLzs1RSj5tf70o7F4OJE/qvm53HYqaa2QFuks?=
 =?us-ascii?Q?kGPgQX41V7iII/3GakLpVj9NjJz+hPwNIgkI6t+QVa/f1XqByGKalg5GB+hV?=
 =?us-ascii?Q?or5Gb+pgB1aaz3opq+rVUE5NNpc7G5Q3TEjGkkIfas7o1X/M+ZHQbFHM+qEi?=
 =?us-ascii?Q?gWFZg5ZiTdH+T4pRWeUzsqVnVNOimV0NSmrNNrFR9usJ6o88mAjePvWzRhg5?=
 =?us-ascii?Q?6zr3hsUWKHkNzGNVVAPLAdun0c+6U6mhWJRrX5hWqHEF3gito0A54fWVG5nm?=
 =?us-ascii?Q?SvoGSP1h2CjiM6pVOw/d0WLtEIOERktmmsx0uH6Hqbh4tiQl4kM4VUGy6480?=
 =?us-ascii?Q?7cXF3VH8fQZV5pNMYc1bp6DHPSY5ZMqV3P6JY/72iPuBi9vb9RzXBeP77uWd?=
 =?us-ascii?Q?O1gJmANfF5Hh5Ly+gQ7tXOqBizlFP42Kv4PFCBS5uq5Tu2mIOsilqCejSYmy?=
 =?us-ascii?Q?R7B9DJThybLHkpRL6jCc0AoLCdfzeaNHeMRCK32bw6PDqINl+oEl1ZHABuNR?=
 =?us-ascii?Q?OZxgBjeazyhlxM3h1yQNK7n7+mMz6Lk+5dYStpgSeGnxQlRq9DNGUKXM0leD?=
 =?us-ascii?Q?z2NVlYBJrD9FwTnRc0maloljWfwJA/fiiKGo2GFkMI+LBvQePcHnnBR9CWry?=
 =?us-ascii?Q?UCGUNoQpmb64iRU0jfjW8y/Fi2h7tPy1fg6s+melqJgMmVYEgbBIF9/KGHiI?=
 =?us-ascii?Q?+5AWoukhkF2QElU9GZNpyy//LoOYDaZc4o0nnPRs6yfwm/wz5mFAFdHk0l9u?=
 =?us-ascii?Q?kdq4PqW4W7lNTgyEeYUi1aMe6OhOn2/JEcEaRsaoeBmNgGDIIjJZ8HlbXaxU?=
 =?us-ascii?Q?szeQDXs95I+RzLVnVfWxtyTq7kE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:58:30.3440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3502bd1d-014b-4653-23c7-08de58345ff7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293
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
	TAGGED_FROM(0.00)[bounces-20465-lists,linux-acpi=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,Nvidia.com:dkim];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_TWELVE(0.00)[28];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BA30B48E43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add sysfs interface to read/write the Performance Limited register.

The Performance Limited register indicates to the OS that an
unpredictable event (like thermal throttling) has limited processor
performance. It contains two sticky bits set by the platform:
  - Bit 0 (Desired_Excursion): Set when delivered performance is
    constrained below desired performance. Not used when Autonomous
    Selection is enabled.
  - Bit 1 (Minimum_Excursion): Set when delivered performance is
    constrained below minimum performance.

These bits remain set until OSPM explicitly clears them. The write
operation accepts a bitmask of bits to clear:
  - Write 0x1 to clear bit 0
  - Write 0x2 to clear bit 1
  - Write 0x3 to clear both bits

This enables users to detect if platform throttling impacted a workload.
Users clear the register before execution, run the workload, then check
afterward - if set, hardware throttling occurred during that time window.

The interface is exposed as:
  /sys/devices/system/cpu/cpuX/cpufreq/perf_limited

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 56 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c |  5 +++
 include/acpi/cppc_acpi.h       | 15 +++++++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 46bf45f8b0f3..b46f22f58f56 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1787,6 +1787,62 @@ int cppc_set_max_perf(int cpu, u32 max_perf)
 }
 EXPORT_SYMBOL_GPL(cppc_set_max_perf);
 
+/**
+ * cppc_get_perf_limited - Get the Performance Limited register value.
+ * @cpu: CPU from which to get Performance Limited register.
+ * @perf_limited: Pointer to store the Performance Limited value.
+ *
+ * The returned value contains sticky status bits indicating platform-imposed
+ * performance limitations.
+ *
+ * Return: 0 for success, -EIO on failure, -EOPNOTSUPP if not supported.
+ */
+int cppc_get_perf_limited(int cpu, u64 *perf_limited)
+{
+	return cppc_get_reg_val(cpu, PERF_LIMITED, perf_limited);
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
+
+/**
+ * cppc_set_perf_limited() - Clear bits in the Performance Limited register.
+ * @cpu: CPU on which to write register.
+ * @bits_to_clear: Bitmask of bits to clear in the perf_limited register.
+ *
+ * The Performance Limited register contains two sticky bits set by platform:
+ *   - Bit 0 (Desired_Excursion): Set when delivered performance is constrained
+ *     below desired performance. Not used when Autonomous Selection is enabled.
+ *   - Bit 1 (Minimum_Excursion): Set when delivered performance is constrained
+ *     below minimum performance.
+ *
+ * These bits are sticky and remain set until OSPM explicitly clears them.
+ * This function only allows clearing bits (the platform sets them).
+ *
+ * Return: 0 for success, -EINVAL for invalid bits, -EIO on register
+ *         access failure, -EOPNOTSUPP if not supported.
+ */
+int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
+{
+	u64 current_val, new_val;
+	int ret;
+
+	/* Only bits 0 and 1 are valid */
+	if (bits_to_clear & ~CPPC_PERF_LIMITED_MASK)
+		return -EINVAL;
+
+	if (!bits_to_clear)
+		return 0;
+
+	ret = cppc_get_perf_limited(cpu, &current_val);
+	if (ret)
+		return ret;
+
+	/* Clear the specified bits */
+	new_val = current_val & ~bits_to_clear;
+
+	return cppc_set_reg_val(cpu, PERF_LIMITED, new_val);
+}
+EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
+
 /**
  * cppc_set_enable - Set to enable CPPC on the processor by writing the
  * Continuous Performance Control package EnableRegister field.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 66e183b45fb0..afb2cdb67a2f 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1071,12 +1071,16 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
 	return count;
 }
 
+CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
+			 cppc_set_perf_limited)
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
@@ -1085,6 +1089,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 	&energy_performance_preference_val,
 	&min_perf,
 	&max_perf,
+	&perf_limited,
 	NULL,
 };
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index b358440cd0e2..f3a04ccd10b7 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -42,6 +42,11 @@
 #define CPPC_EPP_PERFORMANCE_PREF		0x00
 #define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
 
+#define CPPC_PERF_LIMITED_DESIRED_EXCURSION	BIT(0)
+#define CPPC_PERF_LIMITED_MINIMUM_EXCURSION	BIT(1)
+#define CPPC_PERF_LIMITED_MASK		(CPPC_PERF_LIMITED_DESIRED_EXCURSION | \
+					 CPPC_PERF_LIMITED_MINIMUM_EXCURSION)
+
 /* Each register has the folowing format. */
 struct cpc_reg {
 	u8 descriptor;
@@ -178,6 +183,8 @@ extern int cppc_get_min_perf(int cpu, u64 *min_perf);
 extern int cppc_set_min_perf(int cpu, u32 min_perf);
 extern int cppc_get_max_perf(int cpu, u64 *max_perf);
 extern int cppc_set_max_perf(int cpu, u32 max_perf);
+extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
+extern int cppc_set_perf_limited(int cpu, u64 perf_limited);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 extern int amd_detect_prefcore(bool *detected);
@@ -290,6 +297,14 @@ static inline int cppc_set_max_perf(int cpu, u32 max_perf)
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


