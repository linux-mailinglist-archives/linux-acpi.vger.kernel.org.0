Return-Path: <linux-acpi+bounces-18533-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CD1C3564B
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 12:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 911D634C271
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 11:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD4C30FF28;
	Wed,  5 Nov 2025 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O9+7+W/8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA33A30F81A;
	Wed,  5 Nov 2025 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342758; cv=fail; b=HOJcCSlf0jF+SnlBx+hrTJ2fVJVrt3I7rfDlTmTsLK0QdYLHNaG/yVzif3hNfvVKTWMFTaY13STEQMApFbKpmyIluabMUxC8wAyNWuk4TKl6h8pixcZAln6G1kLGR6rWa0cIKikuNzJ4Z9fsizLVQ+1MjpujomME27AwowgZjF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342758; c=relaxed/simple;
	bh=2F5yWJZMCbQaVtl1Y8ghSk0unlN+2DHx+eW3i147bG0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bPLKvy9OHTovOgNbW1aT6w+uYkCsk5PEI1g/Aa/COfGnReeYFki6/n6ImDp78aE8vT3IrXig0qz9ddOBlilOW2iHVyNKoKmzAPwZo8cyDVtUcsbfqLAaYKmtEKTzUQo4y5QRKLEklgm0lVsxEbucdUiH0fTiRrkBTphuaB8tY3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O9+7+W/8; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0QBAs9wjKeo5INEjullESoMH4AYYR9iL4sHWHhZZxBdbGVg/ebi3G6Uz2Y7TGrZwgHLLYJty9a4U62cpw96V7NkUact+B4OS3xC8iOD023o75TOOGUJwL5LrH0Q7QzTK+nSMih8C5BbNKDYj/WNjMPzkLWfrVVts7SUF9ya2w2/jJVyIvrcJApUGKpeoa/2NoxekqFMD9Hk3tQ1+WgLKiSsLaFXfafQYwtQxmLJ6w68jtmUQUiABIeapTJ2gnqIWzDtt15r7krvC9dqUZ3nzVa6NrChxKXRo+QhBo8f1+7xX6/CjfrxrKTKMXW7IWrS6Fw48WgndYgFqfDZkzK3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LDOX5TutPntvPOtfohqjDSGZ+iPmup+JB1H7UCTYr4=;
 b=N01QpvmqJZ7E6ExnA0N3r1LMag+1fK5RvB4JmY4EQ3qc/lcmcGrzc3ALNUUWJnr622fNwxYsm3+TgVhAGz1foBceFYbgby5DUpuCRTMADfZAyZMClj7GL+V8oYfndemtZvtGVpBkgj0mClQrXDvNC57TFIsELxQlHJ0TNbvZUQKzZqwROk5pSAtHRpBYYk3COR9MVp6od3qNWxOan/nrqwXrig1+zU2Akq8C5bgbYd+cTf+N03T8tJT5h89DCYwhGYLEGcRs1VUceR1e1kDqqaUiM8JZphOFWIxiYb7vrJxcraqh+vugsTUZkfAftoPYU+zYRCBjBfphPad0Uy7Iig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LDOX5TutPntvPOtfohqjDSGZ+iPmup+JB1H7UCTYr4=;
 b=O9+7+W/8rmOdtWuTietLcWr1zI7f//hURg65hhOJpccNQCWyzpSo3SmZAyfUDcEHoNT5Asu869zDVmBTV7QfldqycK1ETbpv3T+vs7RsGzpO9pTomAebd6CA9ovrT2WBp8nnfqC87QjmoHSn2uGBzQVrTaLCFUabvWxYbycvW9Kv6FlQxPpoueE6N63gWr3snr44wjAZ0sQmJqe9Ye0RMTgxHXaiIJO/9Tb251Zhs5CU9lTevhO+nIoQFBf5UrCePbKBPov5GkinYtTjersD6YREfEmkTV9d15hCzLTw0mIUGQJksCh4LewV24zDylaswdfAtnzuJxbBS5vNNo96JQ==
Received: from MN2PR13CA0001.namprd13.prod.outlook.com (2603:10b6:208:160::14)
 by CH8PR12MB9838.namprd12.prod.outlook.com (2603:10b6:610:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 11:39:11 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::3c) by MN2PR13CA0001.outlook.office365.com
 (2603:10b6:208:160::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 11:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 11:39:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:38:55 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 03:38:55 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 03:38:48 -0800
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
Subject: [PATCH v4 0/8] Enhanced autonomous selection and improvements
Date: Wed, 5 Nov 2025 17:08:36 +0530
Message-ID: <20251105113844.4086250-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|CH8PR12MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd273a4-485d-4a0f-185c-08de1c5ff076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rXM6vBe3BsSBIL/+ggU9LtpIROgF6isSO+PkxJ5cHN9hR3bqrzhu18VsWATD?=
 =?us-ascii?Q?iSTYv+ioOEwvm0HSA8qDL2iV0SBkaNyKBDgDet3Lw0VZOLU9ewppunYT8YJH?=
 =?us-ascii?Q?d5H+pbLkIW1nLTjc5lnX3bEXDmb/2Pra2ZS1jpHundWT1tNO9W4BlwpIwApX?=
 =?us-ascii?Q?786JhcRbzeakaiMlalRQ+HxcjdfdcdxwWRaVlLXZNNiGGhJhlvXylBqO3Uy3?=
 =?us-ascii?Q?UTN+Za3CxFSgyUnixjMOM11eh+ajmJZlu7R6MszINfEvAaFYf8NGt81TzZdS?=
 =?us-ascii?Q?JualMcUYxoOgII/YaeG7wZZdVNo9xevpT+Rv6SM3SmaTSOeEhpFPK82B5Ml0?=
 =?us-ascii?Q?fH4pZbVXglD+46BDHwisn79cDgZuvGh0cwyVyCFh0hfOF4khi50fM1/eYdiR?=
 =?us-ascii?Q?84cnoBkjb83ZvJTSAHTFoNH/Ou6pN/Jz1Jic6TdYrE6Hf4vYipkbwhB49iQs?=
 =?us-ascii?Q?Vb36ZjfhQ2WRDWRZodweA1xRTrYiH+nitb5HFy/VKJHcKoGyroAIooizjklM?=
 =?us-ascii?Q?oyxzRKNI6TaK01Q6A0ipXdVSioNoZmosrAFAB/Im0KW+Ws0/Go9UKQsUZcJc?=
 =?us-ascii?Q?SpCEVUhgYz+NM48RoBDGB7rV30/jCLXybaEjxEMQeu0YK0gHGypQt3DFnXFQ?=
 =?us-ascii?Q?FfWOQZLs0X6g3ujN2jN1+MkWYgANNQLaYDPuWuobAqgp7ipi/B+YFWJ6BrSr?=
 =?us-ascii?Q?5BkcZhQR9z9ozYMrknH8IL+6d4Jriw5772i/IBTINQYyquENdG8nNdBwXGsL?=
 =?us-ascii?Q?iJ8uU8RN16aW+zSl1HtcUJuhTV7guLJKqU7OAB9sSe/M425Oj/Ng6QJ1mVsz?=
 =?us-ascii?Q?TgLu9QhxxG7WMYUN7J3AWlqtQpUtXk5XF2I63JP6EN6TFxj69Crj+twns9Zi?=
 =?us-ascii?Q?W488Pma09sc3v2eS5MRub7yhc2rtKabkCwxXsfdPBcn/UkiNJMDHUEiCI0H9?=
 =?us-ascii?Q?4NEcznbmk9VgD13r9R6cFqcidea2ermWcvYL7bJz3vdJBkhppVbGWdGwunzu?=
 =?us-ascii?Q?yingQC0TioF3eJ6M62WZt45nHid6aHK3vQOuvS17jgWY6vCgN9tM4tw5jm5G?=
 =?us-ascii?Q?1c9eQR18iuGHBnh8E9xTmZM7HjS8+n0VhJxscHebiIMvSMudfte4eFEf7WXc?=
 =?us-ascii?Q?tp4FuCRu742XZ/A5FzobiC3Jo0kTc0DOGH2f0zytVW5OQ8Ju1O3tv3Ms7oF6?=
 =?us-ascii?Q?AWXLejPXL40z60KX6QTh32zX8laA/d693mSvBPqYnTbGgDjXKR0S3u023o1P?=
 =?us-ascii?Q?P2Te2fSWD6Jg8C1XacMNVxYs4LkYyGRy2qV9FJnk/U157vAz/hMvNDappWm7?=
 =?us-ascii?Q?QbHr5ZOMwbfW9HPXHo7WOp/Pofm+VkmH9wLLJw6TpWHZM6n1L6YPu6g9wFMl?=
 =?us-ascii?Q?7TugqavnHSU+JwFa9NDKQ+zaEvylHSMM5vA9pjm4DqmCqguoD8TuITBVEtu/?=
 =?us-ascii?Q?16zDS7T/n3NuI5oFqRdRMcib3Wr9h4aVwiivDt1bchUmpvGBG1G/4BZvZjZ9?=
 =?us-ascii?Q?rAHF4nSx3Hbxe6YyKAxOzJwfjxUsc02FHoIgAuZSjwR1RUnvqAN4/M7/qz2h?=
 =?us-ascii?Q?Xs3eDYK3/sSD5tHsO4H/SE2iJJrh2rqw/voE6QGP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 11:39:11.3017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd273a4-485d-4a0f-185c-08de1c5ff076
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9838

This patch series enhances the ACPI CPPC CPUFREQ driver with
comprehensive support for autonomous performance selection, expanded
runtime control interfaces and improvements.

It adds support for below:
- Expose sysfs to read/write the Minimum/Maximum Performance Registers
  using frequency (kHz), with internal conversion to performance values.
  Also, update the policy min/max accordingly.
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
- Patch 6: add sysfs documentation. Depends on 'Patch 4 and 5'.
- Patch 7: sync policy min/max with auto_select. Depends on 'Patch 4'.
- Patch 8: Boot Parameter Support. Depends on 'Patch 4 and 7'.

---
v3[3] -> v4:
- patch1: changed param order for show/store and moved them above use.
- patch3: write epp and auto_sel registers independently. 
- patch4:
  - move mutex define outside macro.
  - return EOPNOTSUPP error also to the caller to handle appropriately.
  - change min/max_perf sysfs to accept freq, convert to perf internally
- patch6:
  - update dates and corrected names in description.
  - remove dependency of min/max_perf on auto_sel.
  - add info about highest_perf and lowest_perf interfaces.
  - update info about min/max_perf interface to read/write freq in kHz.

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

 .../ABI/testing/sysfs-devices-system-cpu      |  46 ++
 .../admin-guide/kernel-parameters.txt         |  12 +
 drivers/acpi/cppc_acpi.c                      | 196 +++++++-
 drivers/cpufreq/cppc_cpufreq.c                | 425 ++++++++++++++++--
 include/acpi/cppc_acpi.h                      |  39 +-
 5 files changed, 676 insertions(+), 42 deletions(-)

[1] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20250823200121.1320197-1-sumitg@nvidia.com/
[3] https://lore.kernel.org/lkml/20251001150104.1275188-1-sumitg@nvidia.com/

-- 
2.34.1


