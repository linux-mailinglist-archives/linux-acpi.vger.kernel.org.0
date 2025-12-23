Return-Path: <linux-acpi+bounces-19823-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B77CD9326
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 13:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D80830136E3
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 12:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEDB333441;
	Tue, 23 Dec 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XkCK6erB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2463314CC;
	Tue, 23 Dec 2025 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492092; cv=fail; b=rvyXeAmMvh7zKY5OxuVVkCxgvi9UvpE1f/kF9b3MnHoJeJyV50hzU1aBMdQa9QciEu+3w7ueArRQcdDPOtnfL4ymPu+Sv6TNYGgvPrVB9uGrYIKPPPLdsGJKZlqjHtJvT/28CXY6Z721D7EKj73NSfaZ9+tYcRFSVTpHXRhEU6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492092; c=relaxed/simple;
	bh=fbIecVL9ld70PyE2O2TAg0Or49loBCDsvAvEN3kiYNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnPdxlBWngcKacydbvLaRwWnmQwkcKiihCSbdPkHGfwBG5a0QSE+Sp2OXcOfQTlzOyewamGw9341A1Tuoq/0nZ6xUkkQdhaA0FntzSWDbi6xgpmHqw9DVOHk/5pRwOig1Bj5aP//gfdrSvm+tpSXkOHTzL5t+rtvfxM4+HbCR1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XkCK6erB; arc=fail smtp.client-ip=40.93.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRbiO9HzlvypBhXzci5+A/f7DoqCilU2DUMAV4ik2yGx0YO+hBw+cq4K/XJOzA76+i3GfAMOW+rziM0yW7mrWAsGTOKjW8QhSJiLwwNXjHsjx0mY2R1wtnCwo6mnVUg+dOYX2tITWjhfbU+XXgbKMa8V5+DKf8iuwCPURFuCEJNWjPe4gL8fGYpZ9CHdLNSpypCkr0hrnM1BGEGZLgZU+MiDT8q1sjSlrLGD72O/xd2HwVtKBtqcZkpzg48/cdBm/gF2tL/3ut5pA+MRNpNRt0OSukwZraHl8bXO3Xx6I9nfBw/LFXLpohBt+DHgKjz3To28vWHIoNqHlFI52LKSMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RcQ99u8HAYAQLy6Rf14H4VIjyENayglQU/Wgm7H+1w=;
 b=Uf1FehxgmBuSB+HQMmeciA4PFrm3v2Jjkgxw5Dlu/9mRuVKXAorRfi0rGlAQQXVQTVR36uH2KfbZ8L7zMt+RRvNa9CiFIOlM9RFvvM6XrZWxqWv5tpv/jt6LwIAEgM6jLS9Z05dZtKbneTqnYUJU9lz9VEgTn4Wu+Ky08xgCKgtYWDraI17yy/WvfYXKIhSfknBzDCH+7SPd/PytccpKlh/9nhZ3rR3sqneRcb8Cg1vVVKBaHVHmaf85BcznlyIuxjhKyrBGwSaSpHMm1zLj5qnrwzDyLhD6Mulq256CiAhLP1O1qeC+7YpmRdhEiG5aQP/CPYmyOazDdgWr3RgqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RcQ99u8HAYAQLy6Rf14H4VIjyENayglQU/Wgm7H+1w=;
 b=XkCK6erBAEgUpQgIyatu7egJxD1G/+/232emL7OChumcvkxD+2B33vnDIbA+wOaekQTIqJW6UyAAdnxmJtBhA1guWE+/c7eELzft1LgWMZW0oLUCjjK9OwcLOUiFaXq9v5lusZO6ZDmtQD7IOD45HPXuTJuGNzFWufN/YPMqG8VEU8x3i905Ckzl/Y6psoceQbXE2JuEgW+oBAr1hJ6OWa5exJIBl3FwyiuHD4SJD7O0U4U2iWsCwykAs1WxWHFt0S2l0rD1ZG87UCqmA3jncypb95yHfAA25sCz8+xtPCVJ4kGVgdILf+Uu9DF3qhNTlFLQ6nFZjJVvHRS6ZgFoSg==
Received: from BL1P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::6)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 12:14:47 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::2a) by BL1P223CA0001.outlook.office365.com
 (2603:10b6:208:2c4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Tue,
 23 Dec 2025 12:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 12:14:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:14:32 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:14:31 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 04:14:24 -0800
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
Subject: [PATCH v5 07/11] cpufreq: CPPC: Add sysfs for min/max_perf and perf_limited
Date: Tue, 23 Dec 2025 17:43:03 +0530
Message-ID: <20251223121307.711773-8-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: b736fcda-47d7-4d85-7d69-08de421cdd97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VhlTfhbKRqH5t5wkjLVMa+JjveqH5Mkx+4Mjt3G+dKq+O9d8E5vA3+EgtmvK?=
 =?us-ascii?Q?etj8ZbZYuncgkOjq9zyO6/4iD05/a9SKti9BmBuNbZbLVek06Vbvn+b+X9JK?=
 =?us-ascii?Q?nmIni5r9ICVSUAHNh1I6cMUvh3r5HgXXTRKyAxbvk2Y/fCU8zwAd5ReZGMjH?=
 =?us-ascii?Q?ppsMEE26BCEJ4la0X+C85VH02ZQ6VJh+LulotRAr6fAkrrUOJhGGIJmlGcv6?=
 =?us-ascii?Q?FobI8EEIp+V3VzGWB+4fCea2CnIBFOYlAyW/G5bxKUZ4dEDy59w6FQvtIjNO?=
 =?us-ascii?Q?dPoYGDjhrTXqHTWIriSVyVZ242Fg9KLoUgGTUjZzd84Up1uBbYTb1t4jj8yr?=
 =?us-ascii?Q?83XgilhmczwOCDsi8AYn2Th9b2tj9bqS2Qdnp6N1a6QBfpFnwZHAWupzjAXc?=
 =?us-ascii?Q?B4bSfuYn+Utk6Y8v8DM9GirMoML76CQs3f/LYJIOF/IPE4obsnWeYaSiGxCf?=
 =?us-ascii?Q?KC04kzVS66XmHTUa0f/QBnpCCq15s9C4JkIS/27I0zoLI//A/CmtJAEsCLzT?=
 =?us-ascii?Q?MRmYk0xBK1DokQzoWSXjWJG1VtpUYf9/sGaMym8Wnog5h0I6ZXAwtg4RX/BB?=
 =?us-ascii?Q?MoTzPpfggb8cSsDcB103SyTuOyodFpbCrFvSPLfaYXW/ot/GuOc2ujHdShh3?=
 =?us-ascii?Q?OHEaWtCAwQcRDh3Bnz4x3ojvJpvcsEVb7f2JRCgrZFhOnaNXe2TkZRBM5fik?=
 =?us-ascii?Q?jtUqA9gZ0OM5A0Pz+tD0/MwWZdGyXFtX4n7hF/L+FYQqQxjJDH2f1vBGGyUR?=
 =?us-ascii?Q?QroBL4oTEkWGwRkK14i7HympeQrUQ+63YDsXfL274Ny9/OSPLM4KKygZkG9+?=
 =?us-ascii?Q?z0ae+foKbRtZ23qT6Vf8i9kI6XyIonXVaPLZWvPDurZPIgK1enG3LBTfrjDk?=
 =?us-ascii?Q?ycJ2As17UHWbbnaN6B+tceXn+ScPIpzRi71l02jS1dxArfmk6j1w7hx7AAYr?=
 =?us-ascii?Q?RhXFRL/iHkBt1V7FF8pgO+CcUhEnt6Lx5DPvyrLMT8qKviYoV5SyfQViFZl9?=
 =?us-ascii?Q?AHHQOE5Y6XQ3UlifXjIT6EMMPCYjQOIZDhgCULOYFdNVBbEBYLrlh6mVettu?=
 =?us-ascii?Q?dkYPgZSnWIRvP/rVBGSE3RboLZzdDzCqec5EMzVO07cMVVm+ZfJobUoR8DFy?=
 =?us-ascii?Q?M1mOZDbnvWcEpi28ueWuLgGnnVZ4ymuiPCU8qzJEskvU4casNle9+d7jZYW6?=
 =?us-ascii?Q?d7gNObq/3BJMhUwsmfhVoM16A0FVLQfacwPyL7VwEr5FXKm+tcP/qyiwDdEd?=
 =?us-ascii?Q?ITpKH9X686Ye8A3HNg09/LP/1ggP+VHHyN1GHYf3liT8tGEj5mLSyyJyVg0q?=
 =?us-ascii?Q?gkxXYYOs0NJlYoMN7ht61Gptta3JS74WQAAnzHn58FWdJgmwUeaZ0SMKr6Uj?=
 =?us-ascii?Q?0QM8aF1TIcd+ou8hHBqnHNwPwLmw//l0diwbUOl3BnZZHg0nO2D2Olhs8g7j?=
 =?us-ascii?Q?aGyYAOc/7Cl9zxCG/RYJlX+8c8p1Dpn0ooF/MRGn2tOXEL5T5q8ZSxQlIl9j?=
 =?us-ascii?Q?n0ZnkgynGIr3rcs5w65NBbrtBIJ+XTHOy+XsFWT5zJFvFsOQkdh9n6mFM1og?=
 =?us-ascii?Q?QX883K03McxMgtjVubnZJ4hmpO0frJT6Wnq3mvzd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 12:14:47.5437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b736fcda-47d7-4d85-7d69-08de421cdd97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

Add sysfs interfaces for Minimum Performance, Maximum Performance
and Performance Limited Register in the cppc_cpufreq driver.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 3a05604c21bf..b022cbf46adc 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -327,6 +327,48 @@ Description:	Energy performance preference
 
 		This file is only present if the cppc-cpufreq driver is in use.
 
+What:		/sys/devices/system/cpu/cpuX/cpufreq/min_perf
+Date:		February 2026
+Contact:	linux-pm@vger.kernel.org
+Description:	Minimum Performance Frequency
+
+		Read/write a frequency value in kHz from/to this file. This
+		file sets the minimum performance level (as frequency) at
+		which the platform may run. The frequency value is internally
+		converted to a performance value and must be in the range
+		[cpuinfo_min_freq, cpuinfo_max_freq], inclusive.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/max_perf
+Date:		February 2026
+Contact:	linux-pm@vger.kernel.org
+Description:	Maximum Performance Frequency
+
+		Read/write a frequency value in kHz from/to this file. This
+		file sets the maximum performance level (as frequency) at
+		which the platform may run. The frequency value is internally
+		converted to a performance value and must be in the range
+		[cpuinfo_min_freq, cpuinfo_max_freq], inclusive.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/perf_limited
+Date:		February 2026
+Contact:	linux-pm@vger.kernel.org
+Description:	Performance Limited
+
+		Read to check if platform throttling (thermal/power/current
+		limits) caused delivered performance to fall below the
+		requested level. A non-zero value indicates throttling occurred.
+
+		Write the bitmask of bits to clear:
+		  1 = clear bit 0 (desired performance excursion)
+		  2 = clear bit 1 (minimum performance excursion)
+		  3 = clear both bits
+		The platform sets these bits; OSPM can only clear them.
+
+		This file is only present if the cppc-cpufreq driver is in use.
 
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
 Date:		August 2008
-- 
2.34.1


