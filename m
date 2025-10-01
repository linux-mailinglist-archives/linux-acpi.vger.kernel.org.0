Return-Path: <linux-acpi+bounces-17476-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8624DBB0ED2
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 690627A19C4
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 15:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91538274B2B;
	Wed,  1 Oct 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jsf6i+Us"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BF2610B;
	Wed,  1 Oct 2025 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330915; cv=fail; b=AsQoxh+LDaMFN3g/6vsIxQlJzdkBg96QiPqT9J+FXPoEsq2ZUQ7rVwrAKDjSrfi1anFOvXrHNJ7C5iUO5niZyrV1hnJt9td2qvgKHFnhuw3YdxhyCo7JjuNwgSM26KqKy7oCW/Pbw9/N6yQoetyZdtpmBunWZyHGkhdMmD6yDkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330915; c=relaxed/simple;
	bh=Yix7ySrXaJTB8p3pGR30DmiauU2lDC74937uPjlK6Zw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U11qMPfc4CAfacYVQTPy28pQeS2FaQhIxdgbzDhFwag8fNBsGJxXtfGE8ozTIsgtOqsXyxNqEec8JY5dNXazdEJDCa81VGmXLL7r8956iUenQKYTiypOyP9xPGL2OpbKxQfGNmzru8yoIDjSMXGu8F0Yt/ViLmkq5zHRZaZuHDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jsf6i+Us; arc=fail smtp.client-ip=52.101.61.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NG3f6rL2GOCv2nAOcBxsikTfTrPvobqswr7tfnlMh+OzLYNul7XexjqQ3L2rrGTYKNOH+zgls5+XbOf88EZhxb2NdW/H33BkLMySCKD+D3/LtPvq7JRv0zLabWSbKD4dxdESDH+eJ6in405XBPYkkTFg77D4co9Hgs6eydfTo3kBn0vmHYv38dfLpwuMNKGC6ZgS1QMJDjSXDtCZdPnphapmNim5PXXsIqbNIsmvU1QFgCqOEYGwb7elu6Aj5tVR2b6JoitGQAoOuuB4wDqB2GtoSxFsp1PNbQjxfkveOOb3rt/QDZozch50pgE++4za4mMmWRhkHKnTpwHScb02GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgwwMBK0LvYQ6lOt/wVv7mr8GCfCJU7Na2A1IlPmllI=;
 b=i8NswtEFXflVCsXW+URP5aup1xGQIiIv3EAwVl+9AcG+hjz7EN7YyaZ6GcGK5chbW1Dihee+fe8Iul9WZTfQLF7mUF+29VH2RsnG0nWTKD4O1DZEleEx0ZXcvM8ykLO8z/jptTjW2yV4r1QyRkvWwR5j4IGM9chKF40GXCNMu9lSZDB55CznACrjSHLLbddzBmWlFd87/mPlRygdavEQ7BmDjhFHyT1ImrAhOXPpiKjinL3/5vMaUsq5h9YWmQw2n5LE2WJfgiC9Lb9QzDS/We6o4Kws4yQkGZjJT9fAUZUGTlqyD6PnEkFzFyx9+o2Ttb/KAd4alr1ojmilH52A2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgwwMBK0LvYQ6lOt/wVv7mr8GCfCJU7Na2A1IlPmllI=;
 b=jsf6i+Us2GEY1KeBudNAnxcXNx990khjltUZzoC32boy7XLXKB0mnfiqNC3KIfMlxa8y1sxgLpQ6EOPViyEHojSmPiYyI3rccY4nuQ5L/kzl7lxTd/SizRQKCsVOZcNG8gBWa4A10lLFtC50LAmZGHvzSzYA2GO/krzd3tnvC7KOTkAWIl9PyvIFJ1Ier96myrZkQW1Z3LPEdehcNljrECPQsTDCFHpC+hvQCCRB9j5zdhj8eyaHwvG1I82h7V7NIh1B03PKPDnL/34SaC032Cp59nCAeHvXocqsY2+e9OK131AmRDiVotL6AcnP9MRevwmwpOyGB5BmC/o/OFdjdA==
Received: from MN2PR20CA0059.namprd20.prod.outlook.com (2603:10b6:208:235::28)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 15:01:48 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::57) by MN2PR20CA0059.outlook.office365.com
 (2603:10b6:208:235::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.18 via Frontend Transport; Wed,
 1 Oct 2025 15:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:01:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 1 Oct
 2025 08:01:14 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Oct
 2025 08:01:14 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Oct 2025 08:01:07 -0700
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
Subject: [PATCH v3 0/8] Enhanced autonomous selection and improvements
Date: Wed, 1 Oct 2025 20:30:56 +0530
Message-ID: <20251001150104.1275188-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: aed6d58c-a091-481b-84cc-08de00fb724a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JoYsk2yva9TsQs8wQO1Yi7yLQmMD//0fOQYhtjhAMhZjMzHwcglxPeNLdu/A?=
 =?us-ascii?Q?E7xa0c2HoaEpgrtnQnKUyHwkrVxvvJTkCisk287t4towHcDjtpyoz7NTkkGX?=
 =?us-ascii?Q?75nuXk9WqpVru/GIWZOJaXRMvMwvu1XeATgAGM4uAEQSf3V6lwVcmI9H0BUn?=
 =?us-ascii?Q?MPOIPK5H+wj1FlnQbrLMjynyYZojcP5AzEF1FES/X7aM6pzZ6KuLcBp72Zt1?=
 =?us-ascii?Q?XT5LYkp8fpaYk8mVld/OcfmFVBLo2Fm42pqL0DQe0m9aL0LiN6eFo9lyBae3?=
 =?us-ascii?Q?vARhukPaFQLzdHLpAZmLtg62o9w750/lBWGOoz3TVdRCmUOoOZfhjbj6wDF5?=
 =?us-ascii?Q?UVy/HdV/sud6vKELjRxYrdSh18MIdua2T3jJE6fuufJWDt5bDfVSa8KrQ1SD?=
 =?us-ascii?Q?oHI++cZ/bgo9TYLI62ukO994T5HyQnJ7dCggkr+4MtdSRkiPouKc5Mh6WQEw?=
 =?us-ascii?Q?/Hjfv9pFO1Hzb2kyzFp0OuZka58yZA9s+fC8MSDlOqKHzEi5VPM6djjVYCIR?=
 =?us-ascii?Q?bj8xQkXZrqOPsfHeed4w7kbbNnQbngYMdBJz0TcrwKW3ZNR8ZTHgd1C5s1w1?=
 =?us-ascii?Q?Fj5DzMLmQ2LDaDSLmb2xyy/26AwbiuldVQ5n+3iCkejjsjjCTwxB66N/d/Nl?=
 =?us-ascii?Q?PQA5979yJkHZ9q6EHj9aVz+twkM/1yWiX2Pf0cz0NSMV2f9sIxEPGG7LDf+h?=
 =?us-ascii?Q?c/mr+tNLFI9sSb6YYXEkeuUXGsX4qFvWmVzwxLYVzgfBs8mCNtt9Wo6gtF+F?=
 =?us-ascii?Q?QUJ+vvRtvPnbjv+yMwyheWr+T+Wy1Ae2q8+Wlj4LFEmm7Q0YnEnBtP9WLAfO?=
 =?us-ascii?Q?iKuCkR2p34COYgdcI52iqTcqHMZ9J9kyqB8O3e27HXk0W9QxmlZXX0j/lzjx?=
 =?us-ascii?Q?vrUsr/mJVhq9MJZbmDmI3BLFc5yHOYu1iYoUAxKIs6k2Q/rnu+9INwO2/g0+?=
 =?us-ascii?Q?Bp+tcCoLNCYpcs8xPLG+W0/O3mumY6I7/ZTr0fWzUeKYcXO2yZEhn0x8COyB?=
 =?us-ascii?Q?sVwzl3/AMsVk8LOODanAB3x01Q5s/ZLb7RQT/LC9FQwu3EM+js+w8Kduwkdr?=
 =?us-ascii?Q?wADTRxoKJ2dqebcHbYZb7WSRFcikF0AznwkLPlLlQoqIJ9vXrCTqbUsFQtR+?=
 =?us-ascii?Q?RH3bcRHSrAgrQRLsNdHu4YOBG7qNaLLebk80EzjnccyXzSpqgNsCo8OMWKUI?=
 =?us-ascii?Q?IcgQ35ADcGZps6FSN63zEOnnAtXYST9fgBBWbXLlWpoYE5aER7m8zksLTcyL?=
 =?us-ascii?Q?iJFfB6KMqCc6JLXhG78RoFhvG+OdhWs8HQxRpWrsEZp4fyDSNAChQPMjh5tQ?=
 =?us-ascii?Q?04zaUoqRT2T6C/rHgl8Ov/kYz4M++O1V52HOp9I57sraMkbsiHD09VGpREFH?=
 =?us-ascii?Q?s/hhYkcPt3/Azu17Q/nIWdZiS967aCD5iPDAPNdI5PpGr5Xsy0GyRy5fhpC/?=
 =?us-ascii?Q?sGxROZjabvLfGhWNqAWAQrBjY6UYvbGLEQyd2kUrL32mTH8Bw9RkqegMCSoz?=
 =?us-ascii?Q?r6jIFiGqaS2Cv62OSecJOXQFdOXA6H0yYLdKq9zJEZDzu06C1Lrcclp0l1Ae?=
 =?us-ascii?Q?lThd5OoDc0Q0doB/bFAVU8hM+IHjPBWb1S/R24Ht?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:01:48.5985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed6d58c-a091-481b-84cc-08de00fb724a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127

This patch series enhances the ACPI CPPC CPUFREQ driver with
comprehensive support for autonomous performance selection, expanded
runtime control interfaces and improvements.

It adds support for below:
- Expose sysfs to read/write the Mininum/Maximum Performance Register
  and update the policy min/max accordingly.
    /sys/.../cpufreq/policy*/min_perf and max_perf

- Expose sysfs to read/write the Performance Limited Register.
    /sys/.../cpufreq/policy*/perf_limited

- When toggling autonomous selection, synchronize the policy limits
  by updating the policy min/max.

- System-wide autonomous mode configuration via 'auto_sel_mode' boot
  parameter. Mode can be switched dynamically on individual CPUs.

- Generic sysfs helper functions to reduce code duplication.

The patches are grouped as below:
- Patch 1, 2 & 3: Improvements. Can be applied independently.
- Patch 4: Sysfs to update min/max_perf. Can be applied independently.
- Patch 5: Sysfs to update perf_limited. Can be applied independently.
- Patch 6: add syfs documentation. Depends on 'Patch 4 and 5'.
- Patch 7: sync policy min/max with auto_select. Depends on 'Patch 4'.
- Patch 8: Boot Parameter Support. Depends on 'Patch 4 and 7'.

---
v2[2] -> v3:
- drop changes to rename exisiting APIs.
- add new 'patch 1' with generic helpers for sysfs show/store.
- used guard(mutex)() in place of mutex_lock/unlock.
- update kernel-parameters text to 'enable if supported by hardware'.
- disable auto_sel for all cpus if one fails in auto_sel_mode.
- use min/max_perf values if set from bootloader.
- general code improvements, error handling and reduced redundancies.

v1[1] -> v2:
- Move CPC register set sysfs from acpi_cppc to cpufreq directory.
- No sysfs to set auto_sel and epp. They were merged from diff series.
- Remove 'cppc_cpufreq_epp' instance of the 'cppc_cpufreq' driver.
- Synchronize perf_min/max with policy min/max.
- Update policy min/max Toggling auto_select.
- add sysfs to update the perf_limited register.

Sumit Gupta (8):
  cpufreq: CPPC: Add generic helpers for sysfs show/store
  ACPI: CPPC: Add cppc_get_perf() API to read performance controls
  ACPI: CPPC: extend APIs to support auto_sel and epp
  ACPI: CPPC: add APIs and sysfs interface for min/max_perf
  ACPI: CPPC: add APIs and sysfs interface for perf_limited register
  cpufreq: CPPC: Add sysfs for min/max_perf and perf_limited
  cpufreq: CPPC: update policy min/max when toggling auto_select
  cpufreq: CPPC: add autonomous mode boot parameter support

 .../ABI/testing/sysfs-devices-system-cpu      |  43 ++
 .../admin-guide/kernel-parameters.txt         |  12 +
 drivers/acpi/cppc_acpi.c                      | 184 +++++++-
 drivers/cpufreq/cppc_cpufreq.c                | 392 ++++++++++++++++--
 include/acpi/cppc_acpi.h                      |  39 +-
 5 files changed, 629 insertions(+), 41 deletions(-)

[1] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20250823200121.1320197-1-sumitg@nvidia.com/

-- 
2.34.1


