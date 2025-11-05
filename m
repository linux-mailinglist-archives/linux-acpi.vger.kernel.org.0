Return-Path: <linux-acpi+bounces-18539-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2B6C35724
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 12:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0218622787
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0F53112C0;
	Wed,  5 Nov 2025 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sXb6iUNt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B10A30FC3A;
	Wed,  5 Nov 2025 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342845; cv=fail; b=ugn5Yvw48tTw8SK7wm+XDX9YN1n1UnyiCLFZQqNuMhvDm4p2FspIfTZtnjZCoMxcvu1X7Qvs+uYrJhgachEc9kLvls/2KAn0ieOAkpbnxeUeBQZmEjHgEAyw/8kVPtpY9IylXlTc5u+wCAyQQhgKCliGobKEPHI0zlsc/9ALAw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342845; c=relaxed/simple;
	bh=PniQjyXAvgNxwXm4TCcafnkKbSns9iqRDYXZ4Y4xdcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8t2FbWkWGm5jKVKyT29vtmEgrxhNMP4niNm5f7YjwrjB3B19JI4nVPXclGaszRliaRK3Yteje4NpxZOL7+YEfNTAnYXQjeZIFN1RG6r1hg0HYynhd5mvnITwGYA2V+yYb9ZLzNcc51w9Wnl72Y3stq2xzF5+EZo4smL7hliLi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sXb6iUNt; arc=fail smtp.client-ip=40.93.198.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0RKGaFduot+R55AusK4jLM+8BhMadKx9PFigGVjXoEIQ8KUSbwWQbDUI4Xu99o95ck1O+m2FvFnYru4DNeEksQ6p9/d1s7y5Os/6dQ5OIfACs0VIzzY2a+byjVHLXQbRoDy3dgGx1sYbNEkTNBGZJzLMuz7crn2XzNLT/7FKb9auIyqdAEHYfyMPG8fXYt1zhpvKURyOW+tf24nT7KIUA+KyR926Dp+BL2XGsGmFnSFS0yCJLkoSkVtIJ+zPAd33kHFZMogZngPpEAQY2252wunwaTG7PVPDuTJko/f8FO6gYgRJq/yRJzaG0sBJwU/v9p6RMlI/RXKXFZtxxQBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXgK7YNZyzbaGZoAMKsMSgnEOmVF9pqLUDnInBMDG4I=;
 b=byNfLUaEXUkJT22TV+QS3BCIwtGalVnGL3vLYHmtSstj3XD7veehuNk7RiSkXQiOXnt8GsmHsM5csS3YZ4jfRg7UhShJHY+auzMbuADtTRjUATqOJlNMjcitP9262YtGpPWTQHUSNYekx3eIZaONaT0q+WACTs1AbP0JRN4i/S2YWkKiW2QUTMu4rUva89b0FwzZlYLrin4fIKYv/oEkSqNM3FSSlkndAxIKnYhMAwPrJfwmSvMAio9TTC3enuck0PdEQ7f2WCI2FFCB+0hFMiL11xE7Zhn1qbrV90yEBifFXR/iJ8wy8nff2h635DotXCJc4XB+Xt40A4OIbQfdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXgK7YNZyzbaGZoAMKsMSgnEOmVF9pqLUDnInBMDG4I=;
 b=sXb6iUNtWZYbfqK8d2umVNc65e9bBne4zy6b4CeKvyfWMCE/lIeBIVfZvoaQwBORGitC5y2rVh4a2cKMKMjmDw/ct3dq0eWo59HrdIJ2zqW7/NJm3NjI9NP9j7bPVH6V4p8MDZ/HwN+osGKLTl5ZjKS89rCKFkafUgBBIe34hSwHphxXHPt/XYpTWS46OvoRb+tnYIp9k5VzdA3wEp+ycNj8/N0ejU8bGB4MIp2hxxtevdfm4MKyXkJ6+Li0mrRtABzOzTF9OsgffskMTyknRf4t9M5+Epnrngm1+MDHXLWsK5+1C7gC0V0IRPiLHosMYjtxX4RiQxXYwV3a0OSozA==
Received: from BL1P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::6)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 11:40:40 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::91) by BL1P221CA0012.outlook.office365.com
 (2603:10b6:208:2c5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 11:40:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 11:40:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:40:21 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:40:20 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 03:40:13 -0800
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
Subject: [PATCH v4 6/8] cpufreq: CPPC: Add sysfs for min/max_perf and perf_limited
Date: Wed, 5 Nov 2025 17:08:42 +0530
Message-ID: <20251105113844.4086250-7-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf9180f-b3a8-426f-57ed-08de1c602540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2K6i6wUFP6YGeSjycQRCEOtmIXZp5TVVEcxZtAbHAXG2sk+5gw7zq6c+kw02?=
 =?us-ascii?Q?J6atJSZh4znnY3QNPco003kvsm1iO9GWygcTQzSojZFXC1ybqXjtzy0mykCA?=
 =?us-ascii?Q?VzLqW3yUk5TUyVgUGl6n8ERV8jsOXoe0lQx00oIKs076ZNMjjhk1uDyn2vy+?=
 =?us-ascii?Q?CpEGEhtHYFzN+DkzD21irYJW82XWFkGH+ThaZQICgEN+LDrvz0ANwrH+nWl1?=
 =?us-ascii?Q?3Bwqbw78azHQNxEedkaJEaS8Gxzz185DXTnkoFe2NNwwsWGrtAISbqT+ogHy?=
 =?us-ascii?Q?iN896o+AWGd2d4WariVt6rXKY4xPT64XSOyUk0do3W8AhV+BLG+uWO7wSS+t?=
 =?us-ascii?Q?BD+zaZafsRRO0rSb40ijVw2KtNDXH+cmsFHZk56vP2st/+0eb9TlGERO1OJv?=
 =?us-ascii?Q?m8k6fsRA3Wx590oYDMcrIfoHvK6nI6x5HVTjABjjKUJFKLjhzJGM3sqnen44?=
 =?us-ascii?Q?BUd/ZNUhVTGH/XTgYehqH7OLT5kyXQA8X0YRTzy/sM12OLXXafXNfeMYzYCJ?=
 =?us-ascii?Q?u0u1KysApFbCoWup48zT5ambBVRxGYTgmkAK79312HkLE7Ph1/zBGPWV0KbG?=
 =?us-ascii?Q?U6gBzR/Wc6wJoZiv1TqojqBibqeJESoWXCmBBqegVh+oyrLo9oZmp/BdU2hb?=
 =?us-ascii?Q?UB4wnlknH4vErr37kUHjiPDPN/23W2JPGkkeE+C6mGT33hwjh8TnixGwrdC4?=
 =?us-ascii?Q?D3nMJ36yDAnDFPwbQHNL8AhsJfurCohlktLNgfTq9iDoT/kv8xQl1TsNcTCo?=
 =?us-ascii?Q?poZ26Wwwn4iHGeF9UB32dXv0jlzbGoLeB1LKDVS8aZxmJl1hZ4czxixWr6Xb?=
 =?us-ascii?Q?TNzQ1NyA+fX3pXOsFFEjz3RHsdlVV+fHlHNzqbQx9sKEoaIH14fopCPOsI31?=
 =?us-ascii?Q?dCoatOXfx1OWek+pL0CpQ8tfeKY4GUfj3nRbu3lRGeLRCWK+JsynVCoSRcKM?=
 =?us-ascii?Q?7Evz9etrWbjsxM8ZH1ZeY6uDovRQZrTusNfLoedKMuvfoiyU7SigMqCQ1Z9C?=
 =?us-ascii?Q?93Q6K0f8/bNR2lt0u4kSVW/i9vzVPRUllhRmpYWLcFfmefqzjM49bMIFQvFy?=
 =?us-ascii?Q?mR8H0a9V2n0FAYRTi0tWn4pUAfOwMtlmgMxmWkG7kuinOEU2LZhVNpBDxTcC?=
 =?us-ascii?Q?P8q191hSyHqsGxdMe78u+W5txBk0UUopfSr4a4wXVBbgMvxS5482mq65raue?=
 =?us-ascii?Q?7jb+QFwMa1EwVueShKLq778rcUccEiIbM7s2KaYxjTaQoV5F/TvbrEkAjWUl?=
 =?us-ascii?Q?nIQMYedBG552c503zDRz9WUpX0B0HeyqBD1dUU69PsxIejQafR+jSBjWr/IL?=
 =?us-ascii?Q?6TeslxGuxBIyfjjlhc4rJekm/F5l9KDhq2DeKYqr5q5tYTctmi4k6jimjRTG?=
 =?us-ascii?Q?b5EBJ15Cfx5TWmaj6hWif1BxtetZ9jq2VuPyKC0+DqbquNvXblBxco8NVa20?=
 =?us-ascii?Q?aWceZ0dtRSYuKhDGfGxeYrln68QtDlmN31fNXLXPiNWbl6nA7B7TPj00FDxv?=
 =?us-ascii?Q?lJbHh03Misit/rY7Dwoz/dKM4HxGQbGSbP7IVflhtKm9EHU/vWmuAubkfJvG?=
 =?us-ascii?Q?MkXUlaWLQVy5RdIEBedsaEhYWlRqpSxmb2wHq6WP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 11:40:39.8654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf9180f-b3a8-426f-57ed-08de1c602540
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970

Add sysfs interfaces for Minimum Performance, Maximum Performance
and Performance Limited Register in the cppc_cpufreq driver.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 8aed6d94c4cd..6f1f70696000 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -327,6 +327,52 @@ Description:	Energy performance preference
 
 		This file is only present if the cppc-cpufreq driver is in use.
 
+What:		/sys/devices/system/cpu/cpuX/cpufreq/min_perf
+Date:		December 2025
+Contact:	linux-pm@vger.kernel.org
+Description:	Minimum Performance Frequency
+
+		Read/write a frequency value in kHz from/to this file. This
+		file conveys the minimum performance level (as frequency) at
+		which the platform may run. The frequency value is internally
+		converted to a performance value and must correspond to a
+		performance level in the range [Lowest Performance, Highest
+		Performance], inclusive. The minimum must be less than or equal
+		to the maximum performance. The performance range can be checked
+		from nodes:
+			/sys/devices/system/cpu/cpuX/acpi_cppc/highest_perf
+			/sys/devices/system/cpu/cpuX/acpi_cppc/lowest_perf
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/max_perf
+Date:		December 2025
+Contact:	linux-pm@vger.kernel.org
+Description:	Maximum Performance Frequency
+
+		Read/write a frequency value in kHz from/to this file. This
+		file conveys the maximum performance level (as frequency) at
+		which the platform may run. The frequency value is internally
+		converted to a performance value and must correspond to a
+		performance level in the range [Lowest Performance, Highest
+		Performance], inclusive. The performance range can be checked
+		from nodes:
+			/sys/devices/system/cpu/cpuX/acpi_cppc/highest_perf
+			/sys/devices/system/cpu/cpuX/acpi_cppc/lowest_perf
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/perf_limited
+Date:		December 2025
+Contact:	linux-pm@vger.kernel.org
+Description:	Performance Limited
+
+		Read/write a 32 bits value from/to this file. This file indicates
+		to OSPM that an unpredictable event has limited processor
+		performance, and the delivered performance may be less than
+		desired/minimum performance.
+
+		This file is only present if the cppc-cpufreq driver is in use.
 
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
 Date:		August 2008
-- 
2.34.1


