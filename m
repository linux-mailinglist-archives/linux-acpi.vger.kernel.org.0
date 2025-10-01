Return-Path: <linux-acpi+bounces-17480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E007BB0F49
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 17:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA1A172174
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 15:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0322F305974;
	Wed,  1 Oct 2025 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OBLXemv2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23AA305070;
	Wed,  1 Oct 2025 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330971; cv=fail; b=GsBTss9mcaUbJAFD/hIwgIG1PjODDsu3Bkjegwz4rNfVx11Gd9JV/S8rsfuqcPyt6ATxC89yfq2PdQ76hU9j4PMMakEqoiVSpTmUGECWiW0Sn1kav1xMrB38ewEC3Mv5K5prRjjFtqaWXw87+Bko1F3do8CxkUxwSBj3d11UQfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330971; c=relaxed/simple;
	bh=zzi0eqrnn+qj/X7BWZlOeT0f6dVVkCSWvXazwtlErig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqiPsfCzhdfvXZiCOYs8xhCTs3IBoTnXkNJxuKIUW8uSD+iSoCQU9Rtr3w9wbmIkdiRkWIytmoZTNuCbAiC97ICTSzkyKTk6+GPulI/BPUELDiV2xnp/DkNiVwi8gtcxSIH1kvGpj9SHWUMbjlKkeWLfxv03Z3Pp4qrOqNDKCpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OBLXemv2; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tznret9nmcUpS39aUlpnMR/io7+DCR9hrULnnQrDM4wdf1ygxs2651YYMIaJwP+LPzh+9iJbbocrkvl7h+APxFKaTcDf9szjZFJZgxNfmKuJ831crQ0hG1gX59VDFvHN0SAXzR/sallqsQOCpvJZ0RapYyKMjeqOXTC1qkTXvjZqrZYnb9MeE9UZWl0AWc3tqb5oHziwVH6EnTIIQesP5hgjv9u97DyQamVRvJiH5Su8Ma+RbcVIXK65UFqicrsr3u91uOx6n2w+gS2uJ0M7UozmZTf1A1mrRbGJ+qKAFYyrQb57LpJ+9GniWsA4tov3q3dKAXWnCLgRBoIhGI5yTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCW6f4S+l52ghuNRtCnhyfpRAezEa8UA1R2rN1JucWo=;
 b=DdDtgU2m+kv1rM9sw8hWYCI0SwkSIYOL3Q88amcc2e32bUaz/NcHSpAl4H5etPjxQuEF0H21svQOV9D/8/gNGW3MqHkgYnyV434QVASmG2PckLMVKkd0qn5qvb/w39HdLwKjRz1uYZZ5la9/5UVlOL9SC+vO6i2PnXlGCTRtuHQfD7beih236DUg/e3VO7rT6/15lOPRmBLXBxtYEnukfKq5TfvvwYXE52CRSdUDUUQUHpk+fN8nBTPaeNwORCqP7BTZAyp3RibaJpTMjWsVuNYlGXZtD20IR7KkEbZqboo/yzKBLAEugFHSBS5iFNQQoxKcg4UkqynfoPT5RntVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCW6f4S+l52ghuNRtCnhyfpRAezEa8UA1R2rN1JucWo=;
 b=OBLXemv2cNmjswMwY3VhX8u8metiK0DcfNIskMRE8KoZXbbQ27QeRe4Xbrt2mtJhTgIQkPzHu/PNr4+M7C3V99IFj0EKZ4PjOkFWcoAPqivf6P+3AcL7fz15TGmhOwync4WahRNL6mSbChxfS6WFODSUTuwDHIfeGwfJmoGB1dWBOpYyesuzopfOVIfXEEoUZ29tmbx2ZJH02diL/AcshRX4115onFncMyN3Z8zknwIPPJMakJQQPadISkrp9TzpMXyZWRByQUfH2plTrHL8xvd3HSIyKVtetmXENZaImyFt+Zqi9nZxmDtxLnjN1hRwgmOYkhRjzOe+afyQmi13qg==
Received: from BL1P221CA0036.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::6)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 15:02:44 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:5b5:cafe::28) by BL1P221CA0036.outlook.office365.com
 (2603:10b6:208:5b5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 15:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:02:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 1 Oct
 2025 08:02:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Oct
 2025 08:02:22 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Oct 2025 08:02:16 -0700
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
Subject: [PATCH v3 6/8] cpufreq: CPPC: Add sysfs for min/max_perf and perf_limited
Date: Wed, 1 Oct 2025 20:31:02 +0530
Message-ID: <20251001150104.1275188-7-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 75909f09-fe5d-444f-e673-08de00fb9271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tNBhlKg1lmmiW8LkS6aUSLSJdPZ2/2dhbDf113HFel7HNzXbFrcM04o+QJ4O?=
 =?us-ascii?Q?yS2ib+kIpBBKYgcPwzkLuuvFAsMs8t/tmmLEyoS3mEAY1GkwdAl3s+1yvgcM?=
 =?us-ascii?Q?aDcy8TMnbGSmsmDyVaAcNPDKLR5emBhnlr55VzH/h3sTCos36+lj8XF604Kt?=
 =?us-ascii?Q?cSP8MvbI9eGcWQGBOoEZ3oYViKXaTWNJRJZjvJFq55oRIgO56y6wM+ERNens?=
 =?us-ascii?Q?yyAR9D3AXLjTQ+Xng9pphzW6VtfKLL6vBfFUbgiIjuy7q41v8kEn9EGAtJTV?=
 =?us-ascii?Q?MtkiO3pfWc9vRxzQDr39ZznSF8mgfcZXfPeiPqbrImS/YlXt7EsbZELsa46Z?=
 =?us-ascii?Q?OmTDjmpoloqBLI6qM5agRz0ZfqNVk1VudLQkVYqhKiR7lIx4zYRBY36IPBeY?=
 =?us-ascii?Q?x0V/dmxqGK02ob0gPJiKSRzU4O4K12RZN2S+9aMOwU+vksKDb63NMVubCup5?=
 =?us-ascii?Q?cxnTdtlx5Enwf7cngYfzrHTiVYODaDKECaDnJ25aV3Mwytup7pQhRglenMTQ?=
 =?us-ascii?Q?QJxf/SZpL2+0JYc44lfTZOgJuMAJNK2N4wvTD/NYNfaDJ9E/PiFq3L/JpYlD?=
 =?us-ascii?Q?xnJ7vIhDii594VFh/Pg2LrDYBWl4BAN2EHQ+gXeoCE5R7ezGMlL6l2mGT+bq?=
 =?us-ascii?Q?NSMlMIW1E64FWj0NmNauhuVmhpAily0BIOTN7lz7U54Ki7dWux38J7xfk2GV?=
 =?us-ascii?Q?jUEsb4otkMJ/7jQ37vrNveSxF8JnqQVwYIubFDwtncBmsNFm8crRXGVlPa/T?=
 =?us-ascii?Q?ZmxGRx2gEoqLXOSvMsyfVzI/JYGRI3UlCuCw2iIr8j4mV1hys+ZUof2AqdNB?=
 =?us-ascii?Q?DEMLKNY5mA0og0r0seheRfhRQo6v3hrpTBkCd2/4qqStE50fnGuZA5hmk71g?=
 =?us-ascii?Q?uc6BsuVT8dl+Kt0wOnoBNSYl4j0lPzhyoW3VlJ73nggWvUIYk3gIGxvc00GV?=
 =?us-ascii?Q?OQM4pbfyoJTccMUIe8SjywkUwSvL0fXT2bxFxPO0viXfP+epd1VLCf8gqo3c?=
 =?us-ascii?Q?v4gIHcoklL6pUEVbLGRTZjauRrPi9rUSm1W5KhKqkNFq4/a5KMkKaVAB5vla?=
 =?us-ascii?Q?lMVK4ob5kaG/tD7euXxFWv6C/KxqA7dkvkYz+sCtV1PCgmsjPB0sQyn5piYp?=
 =?us-ascii?Q?oB4Gbok78lR7fe52VcIENWfHOvVOduLdxrkpUy8vRw59LdARual7gA7yoxvV?=
 =?us-ascii?Q?C+9k4N28jzzDsKFTajkFcd8er6ak2Z6QYlFAo2w5VYoF+D1+c8Nw09Pxgkfr?=
 =?us-ascii?Q?yCOj+lf8Ki+GZtDthxYcoSDiM886ySCcAJdo55rxTbCzv7TZHBkOJjt8pXy8?=
 =?us-ascii?Q?fsXNOxFNgRB+5GeK4fdtvrKl5usaNqwxN+do34gtl2z9PUFRycs6z4xL11fi?=
 =?us-ascii?Q?Fzd49KQIxr7si5WQrFsK8ABi8dU2i3Lflu7APsjQcyJ8PIyuJDi/Jyg6hfmp?=
 =?us-ascii?Q?3xnoBHQ9j0JeaED9+egOSUa8TpMHnPa9gniMkr8ZViGQ4apoJLt+4Zxod97E?=
 =?us-ascii?Q?jcCrP4d4vKkxDlbucRe+MsCETj7Y7mVpwd//j3HU1EhF3UP0j5lmVlVJrZp8?=
 =?us-ascii?Q?ibY7cN2nDK7GwXZjxeeiIC5dbpfdPLsWINft4Bh/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:02:42.4766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75909f09-fe5d-444f-e673-08de00fb9271
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622

Add sysfs interfaces for Minimum Performance, Maximum Performance
and Performance Limited Register in the cppc_cpufreq driver.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index ab8cd337f43a..82141b45d58c 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -327,6 +327,49 @@ Description:	Energy performance preference
 
 		This file is only present if the cppc-cpufreq driver is in use.
 
+What:		/sys/devices/system/cpu/cpuX/cpufreq/min_perf
+Date:		September 2025
+Contact:	linux-pm@vger.kernel.org
+Description:	Minimum Performance
+
+		Read/write a 32 bits value from/to this file. This file
+		conveys the minimum performance level at which the platform
+		may run. Minimum performance may be set to any performance
+		value in the range [Lowest Performance, Highest Performance],
+		inclusive but must be set to a value that is less than or
+		equal to that specified by the Maximum Performance Register.
+
+		Writing to this file only has meaning when Autonomous Selection
+		is enabled.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/max_perf
+Date:		September 2025
+Contact:	linux-pm@vger.kernel.org
+Description:	Minimum Performance
+
+		Read/write a 32 bits value from/to this file. This file conveys
+		the maximum performance level at which the platform may run.
+		Maximum performance may be set to any performance value in the
+		range [Lowest Performance, Highest Performance], inclusive.
+
+		Writing to this file only has meaning when Autonomous Selection is
+		enabled.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/perf_limited
+Date:		September 2025
+Contact:	linux-pm@vger.kernel.org
+Description:	Minimum Performance
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


