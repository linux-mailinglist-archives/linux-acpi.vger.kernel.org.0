Return-Path: <linux-acpi+bounces-11002-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6A4A308A9
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 11:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E907163D38
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50921F4E5B;
	Tue, 11 Feb 2025 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e+TWzU1F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7931F472E;
	Tue, 11 Feb 2025 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270282; cv=fail; b=D/IsFsLgEZ3V9w2kEMpgK7fmIVIUIYJcQXRpwQJMg4Dxl3jqs9y4a1xR3PQjtzaP55XYeJxCnDt6sjngZdK9bu4kIOz0fIw5SLIueIaeagtL4u/SLDVXw0G1AT6g4DbQMKAz8p6EBdOfzCzbmC/XDB8Bfkk4AzncnG0MaoWkkog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270282; c=relaxed/simple;
	bh=JMKUGND2G9+aIWKhij1ebLrQNVm6bI9EPlqQp6l85ck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SD1Ex3+lhZCir8pNmOiVulFgVQSXLU3trQdh1W2R9G5Qkl9p9Gu3XoyKwGXdRQCRgI0Fr9HZh0Dp7GLv2QYrW0v19TH/qDojS426mc8gsQcwUSDQo/Xow1J8U1sONvCwrTbbsiJYGgMv3SpC8kbodc20o4LFCYhvMYMI4kO9UGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e+TWzU1F; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTO03n5MOskUwHVaNyQr+f687oErZ8dnjQWIQK3PU7kLJeyqLMhFYMzhS8liP3aTU5yvdjcDv/Q0/1GXkMYq+ucUDxXi6x4sqweiebSMze1CiJZg9+zGUUlU1E0IjEKcm1QuwaPnzZf4eVoMN7LWnjS/tjL502iGHEMTy2IR8HIte2+7yvWS3hI0TNKU3kg93N9pXNwvH/xXee91xcLVw13RMoTnwmwvUmeJLkLcmdRhx0XYWmsdKF3c3GEaermFAJjGV79jR+c9v/k/er+kmzQLt/wRrkXHnWwbJrF8ZW4j+1YcwXlbEOyBKO7aydH1SXag/5kUNmNjSU3xTB4gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkCzXgmSOByJKTfbgb4kkpX+TXMqWPEGhnFIJU/Ma4g=;
 b=kpTp3sa+t2+pQVDwlKj99Z7K/G2mZ9SHCcHVeZ2z8PHNfnEKzhGBlnwhapnY+ZiS4lT9WinhBvcY4eY2/sujxp9PBVz30LRBC5FSgKMWDY3lS+lPUx2snzRYQJbjjtHBKvSz5L2BEAisnNUBkwspzQbAuS2BANtLmySUfp5vtd+Ug1z4RPghYJ5l7RNxChz9u9F2vJ47DdWiCPEfkzxC0cMNglPp9+ri0lAvcCtGRN1Xgz+UlfK0Ii2mZj2NR/ff/0fJaMB2YcOoGomY2H87XWOGuzjnQwYtWXskSCZSoNgOR2yXDsRtCmg4aeWf4lrVPWbiIGd2PyBSQoEfQ9vTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkCzXgmSOByJKTfbgb4kkpX+TXMqWPEGhnFIJU/Ma4g=;
 b=e+TWzU1FeySl2FvCkbGBPMmVF8/apG5f+BX42o4k6yo77ibnA2pcgRfg7n4aBseyw9qlJnJv684EGais1YzSYoTqATLsoIFEoVgTWRL8wyDXhRK9/esRFDVgdF9y2te5STyZf7ynFrNDDkwENDo8nhjGXUOnc/JiINY4US/GtnQym5El6FU3Xpb+nh9b+6e58oSvHgVRydaBeuUYtEqQvl/yCMkr3QkN4Jd3yArdwo7QJj7XR08g2lq7kmpcB5R03jg9c0FUjzpqM1Htiq8eqiquA2T78YMU7TUfdePtOBZu6M2w/E6HZBQHfZWEzb59dDVWLiXa5FB0poHb3UHYTg==
Received: from SA0PR11CA0023.namprd11.prod.outlook.com (2603:10b6:806:d3::28)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 10:37:57 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::38) by SA0PR11CA0023.outlook.office365.com
 (2603:10b6:806:d3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 10:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 10:37:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Feb
 2025 02:37:46 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Feb
 2025 02:37:45 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Feb 2025 02:37:40 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <sashal@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [Patch 0/5] Support Autonomous Selection mode in cppc_cpufreq
Date: Tue, 11 Feb 2025 16:07:32 +0530
Message-ID: <20250211103737.447704-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e113579-c2fe-45d7-27e7-08dd4a882686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7EGtXIzDU9gwXaKy5jtRP/tb+JOVjRmz6swR/0PORREe7o2GZUlbShJibDf3?=
 =?us-ascii?Q?fjPU5ZcMpDBI1LoPDIllsjAKJR+26YnV+V7mvUUb6JQDPQM9UbIhVhEQ26sM?=
 =?us-ascii?Q?6wY9azsLJgefdEZ4QeShD1wuYlc2SHIwH3jzJdbBbJ05LTBaMlD68xmCkPHP?=
 =?us-ascii?Q?NFFVoeKpN1uQHuD/0Obf5KvfnG9EakntFCiCPJZW5gQ47ENBWHjT9UoPBmYG?=
 =?us-ascii?Q?Ot8xjNgItFGpPWFYLgneGcgELkMFuL+juiH8bLfYZIInBcrc1OOy4Ibe3WU8?=
 =?us-ascii?Q?LNrarW+LJa6CjqrUjFW3RFey+3PNRI1CtQi87gtgxKd9yyaDlRzO3T/MY8Fd?=
 =?us-ascii?Q?3UGsqVn2O02lvz0dX++iEmDQnKSebEPsHbwm9o7aebvP9n9TJUzDMdE6RHdA?=
 =?us-ascii?Q?/U6M+KZCM0xNQn1u/nR7zhpf+I0gsikJee1jRqxWtyokW6Es1iGV7CTGjeNW?=
 =?us-ascii?Q?SnGhOUDDjuC8Wap/AHWJiKREVzdMALTM0PYfKI+OPyQQxAkb9Ihdw33Mj5As?=
 =?us-ascii?Q?Y9evGlOyK3l92cLBcHo3ZczGbvx285YzWlOehMkILz9ig8WC/hAeYMqXVaYF?=
 =?us-ascii?Q?Lw8SgLeyz1T2s9JGKtX5qKrMC//zgm2zk8J0cVSVbD9tqC1PAoVgHFk8RxkD?=
 =?us-ascii?Q?6oj7iomIE+Jas8nj1ZZnvwLGPZkqr64q6xlJJURRF4EmR6FWvAKwcfbR1W/q?=
 =?us-ascii?Q?aoZcXRojeob9Zz9OuGDqxneIEf3RIA3Pr34pAEhXt1YL+omaWz6uRvNMkfHo?=
 =?us-ascii?Q?9QueOL7dsSLvNzAzBZ4M0/BHxcMhlTXpicq4tTpsSC2qP05+Dq5TGNYsDhfA?=
 =?us-ascii?Q?YjuDonw+2ElDZGEB/pB1GbrBuh+fYL8MEc8VoxHlJKM1KV3KRS8nPbMJ4rLx?=
 =?us-ascii?Q?+htrEIT/Lj9h/MyPUheMuw1zSQ7bg+wyPe2iZz/Cv1Yw2kRiJ5GvWu3QHAX2?=
 =?us-ascii?Q?3kydaxkChRCjesHt512YV9zMRk8GtVfkPM7i1riLApSSTODi+0PLBIPPXnKc?=
 =?us-ascii?Q?uzFSztCI3UiGKB/66v8kmHs/DVFq9ksx0psDdtuK7BQvLW1jVrSFS46Au4/R?=
 =?us-ascii?Q?5ojUU/bo0uu1KZ3GqYFiUVn9hMq5aiLQdpywMv75ObmPNi5k1LAbr5/AqVhs?=
 =?us-ascii?Q?XfLWqfocFXBqD8KJB3KhImwtabKX5I2d0KTzFJgJsmQH0ywvw4yn2aXKwEc0?=
 =?us-ascii?Q?rs3e0S7/AiUNk2fnRLeDnfYhuwD+5Ycb4lyod9Ah5D0+BYG1c7XWdLUNnaU5?=
 =?us-ascii?Q?WxCPxAOgWAksGWCCxhN9vWNc42a8hHMLXFFm7W6W9WRcf6JWsrTYUa1+r8IL?=
 =?us-ascii?Q?Px8JLjHvCrbU+l/EZ3tZNxx0zI8uU4bdr7m2DGdi2q5iOEeIr//GhDcidl9M?=
 =?us-ascii?Q?0/2gaXXZo3gExIuIMFdtuk+P59umnhZfyiGgYUdrHMdiJFstN59+9V1azLP+?=
 =?us-ascii?Q?4+o4/JIjTBjX026XIb7Hrvh8LNHWkA73rSzjkvIAXs29OOZPwmQrnYXxNbSj?=
 =?us-ascii?Q?g+C+je3O/SwVFpYbL8INy4MBzAYjACK8JUO8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 10:37:57.7249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e113579-c2fe-45d7-27e7-08dd4a882686
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936

This patchset supports the Autonomous Performance Level Selection mode
in the cppc_cpufreq driver. The feature is part of the existing CPPC
specification and already present in Intel and AMD specific pstate
cpufreq drivers. The patchset adds the support in generic acpi cppc
cpufreq driver.

It adds a new 'cppc_cpufreq_epp' instance of the 'cppc_cpufreq' driver
for supporting the Autonomous Performance Level Selection and Energy
Performance Preference (EPP).
Autonomous selection will get enabled during boot if 'cppc_auto_sel'
boot argument is passed or the 'Autonomous Selection Enable' register
is already set before kernel boot. When enabled, the hardware is
allowed to autonomously select the CPU frequency within the min and
max perf boundaries using the Engergy Performance Preference hints.
The EPP values range from '0x0'(performance preference) to '0xFF'
(energy efficiency preference).

It also exposes the acpi_cppc sysfs nodes to update the epp, auto_sel
and {min|max_perf} registers for changing the hints to hardware for
Autonomous selection.

In a followup patch, plan to add support to dynamically switch the
cpufreq driver instance from 'cppc_cpufreq_epp' to 'cppc_cpufreq' and
vice-versa without reboot.

The patches are divided into below groups:
- Patch [1-2]: Improvements. Can be applied independently.
- Patch [3-4]: sysfs store nodes for Auto mode. Depend on Patch [1-2].
- Patch [5]: Support for 'cppc_cpufreq_epp'. Uses a macro from [3].

Sumit Gupta (5):
  ACPI: CPPC: add read perf ctrls api and rename few existing
  ACPI: CPPC: expand macro to create store acpi_cppc sysfs node
  ACPI: CPPC: support updating epp, auto_sel and {min|max_perf} from
    sysfs
  Documentation: ACPI: add autonomous mode ctrls info in cppc_sysfs.txt
  cpufreq: CPPC: Add cppc_cpufreq_epp instance for Autonomous mode

 Documentation/admin-guide/acpi/cppc_sysfs.rst |  28 ++
 .../admin-guide/kernel-parameters.txt         |  11 +
 drivers/acpi/cppc_acpi.c                      | 311 ++++++++++++++++--
 drivers/cpufreq/cppc_cpufreq.c                | 260 ++++++++++++++-
 include/acpi/cppc_acpi.h                      |  19 +-
 5 files changed, 572 insertions(+), 57 deletions(-)

-- 
2.25.1


