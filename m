Return-Path: <linux-acpi+bounces-11006-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ECEA308BD
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 11:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67213A3397
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 10:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3C21F9AB6;
	Tue, 11 Feb 2025 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ln/eaND7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F11A1F9A90;
	Tue, 11 Feb 2025 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270313; cv=fail; b=qOeSKzCJSGKiEI1JJRyGtkuHNTLxrENeWIE5CUjUzokjddQz/QKsKM5cZRt5B1t5Pf98fwAzPdxtqBL7V8WAwv6zbwoSgaeWbEEoMe6VkI4TEIGjZ0b6ix93ltvzAIm+b88y/SvoqJxbsoHYy2z13zJGXLHZMDrM7e4CgogZfOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270313; c=relaxed/simple;
	bh=jrTH220miCagOrvt00QOeZrvit/buZDiqG5jj+MkunE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deC052liPgtMXXvgedMPz3+7KBG8fVbBxfsmDR8wGMAhOxmO4vfvr+RHJwj0nR+FZyvBnNa41Y/LUv+Q4HaXbch/B8evFHBxV+C67mDHuuUO2Xx7b5sPEN4xHgpsh2wT3DzG0K/UQuu5X8caOcm1UiKcg8ZHkdmLoC9fMV4MFak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ln/eaND7; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2tCklzL6LshYajhLjvmiBL3ATUWh3Yzn0x/yzYM4lajfEZO88Gxca43qi9F2t51S/rn84lAs4QDCjYXYYZQp/uf/E/PBClcWCYBCCefnDVNNGyWc4vT5GhxK1oeUym7d2jHpoqXCE/++mbT1+EWYDZ8MbENcLdq9Nad5oVh+VbH9J1KDIkc0FCN/ajXxY+xYUcXhVlZ3O9CEploxzkBTEVssB46Ve2yhCMDVgXZV9bmqmTpUjjNByHiF4S3AfWIV0VFuSERKGk0eheohr3YjS+Q2cZA1YEuLe1mrKE9cEHtznD5XmqZdorJhNlbivCWU4zDu4QBj5tcP6+vhBRD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgBk4Wy2p/FGj5el0mEtydwJp9Ydeq4Zo6khOP+V1l8=;
 b=lfVcu4F22y7ywrmMpHdoFlnq1jSANYA2t7Ehk5ttI+d5tWg5Xb034zaSWaByBVZWjc3q3WfQzkgK1LBiflE+DbP+DpgKnXKiB5nT6fTkcW/iguWS/bbQ+97YzpNxzcC5H7MJVFovWd220YouoDHUExeO8aW+ntu1VUfdCF6xSzr7Tk0aD46BEMvJ+TY1HqfAMS2TfVNUW1/VdTeGGgPpO67TqfwyqddwL/ybIrJl/4v80WBigotARRt7z5+YpTQLAAL9/1ohgr+M+qp22ALxrwsEVeJSB8Ih+o7KiOMjJquSRJFN0I2Fw63ohZtd6p6QHN9nq0uPVsKBQmTbfONN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgBk4Wy2p/FGj5el0mEtydwJp9Ydeq4Zo6khOP+V1l8=;
 b=Ln/eaND7hdOQCnl7DImtjWVndrI1I8hX4wcaebXTsH65UA8wlXyELl2OHWvTZdjzFC1Fz+Ui4izPtKiEcHK9GzmEg4N8T+exbBWf+Z8GPDCAPqOVAKc91SZkTOv3wLu4uhmUc3v5AVkzXq99eSnUlBAXnqQEqMhv/2KNDxmJaWDeAMRYz9yphXatkYWlfX8sCDW7ogLWGE0iM0cA6xdeHd7ruwt1E9yWhm+pMEb6xl39kObQfYtBXY3WIRcYrMGcDmXvagcx6TbII+96Dphxf82g9CRQaWnFb7D/E+oGiPXTPYGljyCCZ9zHoBU/8jGTzR6YaWvj/yOe8slYhzrSPA==
Received: from SN4PR0501CA0029.namprd05.prod.outlook.com
 (2603:10b6:803:40::42) by CH2PR12MB4215.namprd12.prod.outlook.com
 (2603:10b6:610:ab::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Tue, 11 Feb
 2025 10:38:28 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:803:40:cafe::5) by SN4PR0501CA0029.outlook.office365.com
 (2603:10b6:803:40::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.11 via Frontend Transport; Tue,
 11 Feb 2025 10:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 10:38:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Feb
 2025 02:38:14 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Feb
 2025 02:38:14 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Feb 2025 02:38:09 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <sashal@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [Patch 4/5] Documentation: ACPI: add autonomous mode ctrls info in cppc_sysfs.txt
Date: Tue, 11 Feb 2025 16:07:36 +0530
Message-ID: <20250211103737.447704-5-sumitg@nvidia.com>
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
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a7ca96-28ef-47f1-a948-08dd4a883866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qEa5THt6lZyx+9WjPGZEosrFKqmkM6eBWe0rwgRSkrqQzjuRMcLMuXRQ3LD1?=
 =?us-ascii?Q?/hQyJqxjstYSMeBgvWz245MaN1U4zJcY2ngmLzbulQ6OLjwpeK0E53nqdElM?=
 =?us-ascii?Q?BndCY0l7GCgKn1jv8H2gRxUnenFrNUFyWY0/T95+Z3kH5kvK9Jj3WU3zJUvy?=
 =?us-ascii?Q?iW905fBWCqzVcVt5a5WO35Qz7CKydzl6dgQRpWAXByzowEVU/MmEhrMS4fW5?=
 =?us-ascii?Q?6WEIW7SWflGFuvYr7HHjHzif/MC9HfeqzYmp8zQLW9VNE+fRe0AI/oIXEVnK?=
 =?us-ascii?Q?4c1F3Rab3Hx8yTnz7WT61rvDix+H+93E3A7Lif3x6CHXV6PR5mPizydIq5h5?=
 =?us-ascii?Q?3vCYnOlQVUhAVdyw8RasgxcGawAFP58eDwVLaQcD+3q2vDe0UvFW9iFJubVQ?=
 =?us-ascii?Q?kMvIIRcHLqesT5vkQZmYQqSDaJLCG0Ec9fVJV7TKCvlArOc3ZXBi4nCdCTda?=
 =?us-ascii?Q?8QdrQDQ2hC4SQDji0P74GpHa64sY7ZifcGC4j0bpFiQK8/oTLIHKLjyCxk4W?=
 =?us-ascii?Q?+0Pc22zZhF22Uas0P13o2OP4bJOWB4uLAhJtTQWnsCEj1rFcypeyINR8DcQX?=
 =?us-ascii?Q?+B2Rd4WSaC5KJQTjl5xeotOHUJjp1cwz7tTLf4I1buvW/eK9qOTgl6vTIjdc?=
 =?us-ascii?Q?SWmvd+1/+KyCaKX7ZeHgLuyVcT3QYPYVW7D3MWJdzPkkDHTWUlQwNm5hMUTr?=
 =?us-ascii?Q?O7TSO/VG/TikvOmULHTOqLI0VtxYLThIoxfCaFKbOmk9QvtNlPewm3kROARG?=
 =?us-ascii?Q?bMmsnikH7CBDO/kNAsVEutsnlSMC8ra/QGD7LtGzbOvNIo4SsQ66LRSJNI9i?=
 =?us-ascii?Q?CurclHU5IDz7T5jz0QzBGn8ae359jzPlGasLlVrxpF4bTJZddQ8Ema1uJZgh?=
 =?us-ascii?Q?KFblX4HBRNzOi+cfafg1cywEsMRAmitQLZfdDlHBrODunV5rIZaa7np4Yqjx?=
 =?us-ascii?Q?W5wutLWflcB6vZhtXWQCWNDLA03DCnH75yAlxkwRxHAYEUHNee4mRtmUt4Vv?=
 =?us-ascii?Q?WBegUgtChzq771vj+YNqmLO6EeosPVrstkIxLJzabZUziKnvaWtwiQ7XCO2a?=
 =?us-ascii?Q?8iF2TSo1VJVRRx8VRg40eABZ4zpojkhRfmSXfk3Ii1mItj7ahLYzOLsILEMK?=
 =?us-ascii?Q?UNcwBQpD620DVl7Iw+ZtrI9n6CexgOLW+NMEg2K6CKMLyX7A25N7oKwdCv6Z?=
 =?us-ascii?Q?m0iAIGn3UdlBREIoxUsC7CaOt/VKPayPtAImvYgvWzNAhoTRG0rLsOrld5KY?=
 =?us-ascii?Q?AHBCp5/65eFWkGrgkJbxPIzlypM2N9IAjDwaBvwczzglHy0Z/tvaSeRQB6iM?=
 =?us-ascii?Q?ympHqZQXbtoGri6hPoB8zl4z/Wf4t/AJKzmuUqbDKa4rAGKW/5P94WV2mwcZ?=
 =?us-ascii?Q?75GMOEOx+LzO86Pol742zM18OrEeE3BprEPo+RY+O4O2iCtXwd4j9CyidpU+?=
 =?us-ascii?Q?Ib0duBHUq0S0GuNYttmnsoqwNEIhtw6BpcmkqOFpzFq9HGs1+1gd2BT4o/Mm?=
 =?us-ascii?Q?nxugoCdLfVBcxoflhKIhECTy2XECX3BU+gxS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 10:38:27.7175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a7ca96-28ef-47f1-a948-08dd4a883866
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215

Add information about the CPC registers used during Autonomous
Performance Level Selection mode. Also, add information about other
regsiters like Guaranteed performance and Performance limited.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 Documentation/admin-guide/acpi/cppc_sysfs.rst | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/admin-guide/acpi/cppc_sysfs.rst b/Documentation/admin-guide/acpi/cppc_sysfs.rst
index 36981c667823..ff3f48d95bb7 100644
--- a/Documentation/admin-guide/acpi/cppc_sysfs.rst
+++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
@@ -27,22 +27,33 @@ for each cpu X::
   $ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
   /sys/devices/system/cpu/cpu0/acpi_cppc/:
   total 0
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 auto_activity_window
+  -rw-r--r-- 1 root root 65536 Mar  5 19:38 auto_sel
+  -rw-r--r-- 1 root root 65536 Mar  5 19:38 energy_perf
   -r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 guaranteed_perf
   -r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
   -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
   -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
   -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_perf
+  -rw-r--r-- 1 root root 65536 Mar  5 19:38 max_perf
+  -rw-r--r-- 1 root root 65536 Mar  5 19:38 min_perf
   -r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_freq
   -r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 per_limited
   -r--r--r-- 1 root root 65536 Mar  5 19:38 reference_perf
   -r--r--r-- 1 root root 65536 Mar  5 19:38 wraparound_time
 
+Performance Capabilities / Thresholds:
 * highest_perf : Highest performance of this processor (abstract scale).
 * nominal_perf : Highest sustained performance of this processor
   (abstract scale).
 * lowest_nonlinear_perf : Lowest performance of this processor with nonlinear
   power savings (abstract scale).
 * lowest_perf : Lowest performance of this processor (abstract scale).
+* guaranteed_perf : Current maximum sustained performance level of a processor,
+  taking into account all known external constraints. All processors are expected
+  to be able to sustain their guaranteed performance levels simultaneously.
 
 * lowest_freq : CPU frequency corresponding to lowest_perf (in MHz).
 * nominal_freq : CPU frequency corresponding to nominal_perf (in MHz).
@@ -50,6 +61,7 @@ for each cpu X::
   frequency instead of abstract scale. These values should not be used for any
   functional decisions.
 
+Performance Feedback:
 * feedback_ctrs : Includes both Reference and delivered performance counter.
   Reference counter ticks up proportional to processor's reference performance.
   Delivered counter ticks up proportional to processor's delivered performance.
@@ -57,6 +69,22 @@ for each cpu X::
   (seconds).
 * reference_perf : Performance level at which reference performance counter
   accumulates (abstract scale).
+* perf_limited : Set when Delivered Performance has been constrained due to an
+  unpredictable event. It is not utilized when Autonomous Selection is enabled.
+
+Performance Controls:
+* max_perf : Maximum performance level at which the platform may run in the
+  range [Lowest Performance, Highest Performance], inclusive.
+* min_perf : Minimum performance level at which the platform may run in the
+  range [Lowest Performance, Highest Performance], inclusive but must be set
+  to a value that is less than or equal to that specified by the max_perf.
+* auto_sel : Enable Autonomous Performance Level Selection on this processor.
+* auto_activity_window : Indicates a moving utilization sensitivity window to
+  the platform’s autonomous selection policy.
+* energy_perf: Provides a value ranging from 0 (performance preference) to
+  0xFF (energy efficiency preference) that influences the rate of performance
+  increase /decrease and the result of the hardware's energy efficiency and
+  performance optimization policies.
 
 
 Computing Average Delivered Performance
-- 
2.25.1


