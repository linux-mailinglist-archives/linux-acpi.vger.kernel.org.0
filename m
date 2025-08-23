Return-Path: <linux-acpi+bounces-15990-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA8B32BC8
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 22:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F1C1B61A06
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 20:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9752E8B6C;
	Sat, 23 Aug 2025 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Imvgl4Uw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F463A55;
	Sat, 23 Aug 2025 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755979307; cv=fail; b=C2dlKd5Rz99iXQ6pWQ7Sboc067S/kRnsqO5jTfKq0qxVo0v55d7S5x4z10LGw2fjT4G8sjQjNw6Lw1McbA88TFhDBEdiQnIoygF6wDxYerhpzVHG75tS4YaAQ6NCqpiRspWaLm9nTf6FC30M6NxnFBey4FRKLrWxQIAh+keaJCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755979307; c=relaxed/simple;
	bh=MlvKtD/2ePHeAHfIKWaweCTqsQx1PJ8i2KUyvnyfKMw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H7reaMOKc5PSJNzz7Zkv+j6x9O/+GhINmbhyZRXFHIpDVOGfVGMMnHF6n9KFNmeN1qPvRmzzoA3OD+oIX+yHJDP/rmG9sAvlbeqXd82+vlDiYjsGUcPmL87ffFcw0rsMyuvPBzWlyUb+Bt7vN3HKkCaN7kF0kDSWSdmT82rHEiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Imvgl4Uw; arc=fail smtp.client-ip=40.107.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPcYuwS+wZhZPvWL5EGZG3QQvTvoe3x7WxbyKD/g/+GW5+lTpAABxgp9n4GmJBUgAGCM7zYbg2iaYBXvrkQ2INJr96pjia9wIyZcpwfsiVhEcryDz7r+l0NBSH1jQAL1xrtJYxsuwPGEejw3n/4rmbD3bnXToT8YOay+vCyON0vrLsbjcZNj16kvZMytrkPSZ61PJPZiBTMlxZV6In9SqXmAKJFoFmqK5weC9q1Qdfz2F1rLn5/BMLEMWPhTTsAD6tegaIWXNc339n/peAEflcpJlNcfSgCnVCBKS/fbJQbGnxmzx8zXz71hVZar0OtsHtM5Rbz84lDu30qGuXZLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVJey4KyszBthu206QBovK39P7/VAziRrjhN5Y2Et18=;
 b=hLQw/Ea77jrmdkxvmgwrSNKnhboxPYXAj1pWAeZHKjaY7XYXg/wAGA4rHoV23jXDPZMmKLs8rPX7tftMpFesR8Y9T7zpWOBtGIxRidxblu3vr31NfiEpFxJvUyU1CKtK4zb1jUmnO7wr5ri7Vko6LCisFiGwvmLMJ9qB7ZbLaqJxI3akw4QZ2TSLCiDOAd4k4zXbkPMAy/II4t0ndOHlDpn6QkBdUJh/pDQnz19Hc5LciruopXT/LNBn2utXyWwrgQ8qxGhPNl4uX52NNN8ncDbsD2pWyf/FEXcaHiG/4Ey46pN0es/7smgUsYAQV/IvfaiFxtgY/ssEZSB8kPlRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVJey4KyszBthu206QBovK39P7/VAziRrjhN5Y2Et18=;
 b=Imvgl4UwU268sLzTW8/WcO55Xk+iZIP2rvTO3eaOOPEeWwCrQC1V8SpfhvukWIj6ilA5ELYCSQKF60jepv+ovJov8qGxCK9FJ0cwfEs/BFYxMJSvHxOjm4pAxqk6cr1iayR1CX2KV5jHf4cqQDbsWyrMf1uyHEOuQXuW3HrgY4FD4StbmGqqdmj5zzRu5Tq59DR7gn0QfI1Tq752VWUgd4OjRAf+720LxnVFYKY/cESkKtE9//YYGBFIFEa1RsGfNLy8kd1+pXSu9NhO+b42MBsz6RLc5e8AVQ5Q+WSU0sxRbnu6XzY6JdBxIRdzHOk8vPTQBK+LVYtuMr6ZDcTJ4A==
Received: from SN6PR04CA0075.namprd04.prod.outlook.com (2603:10b6:805:f2::16)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sat, 23 Aug
 2025 20:01:41 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::c) by SN6PR04CA0075.outlook.office365.com
 (2603:10b6:805:f2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 20:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 20:01:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:01:30 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:01:29 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 23 Aug 2025 13:01:23 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <ray.huang@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 0/7] Enhanced autonomous selection and API
Date: Sun, 24 Aug 2025 01:31:13 +0530
Message-ID: <20250823200121.1320197-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 732237ac-9c3e-428c-621b-08dde27fe0e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SbWHYlBPgQEW4loTwoexkukP4Pb/XIxDGtLLBMdsXGnuwnsR7FIRes15tvV1?=
 =?us-ascii?Q?wvv76NwMm7g1YXGilcNnR+oNtW2PFBEtnv6547b13N8fh1HysFLMjSWj+Bq4?=
 =?us-ascii?Q?yspksD+cbutTEunjYxLe1RBtzErMQmt7vQqgi/XpBmQD78wW6zaw5YzevFEE?=
 =?us-ascii?Q?LlPKnat1hPFbqrvy1dzvAWlQDabM0Drhuoe4vZX2duBVZ3sZYiCuNu3FzZOY?=
 =?us-ascii?Q?hQHK7xxk7Df95DqUxkEQCKiI3HqrJBN5P/2d4gqBmMfZvmzWz/fFx5EV7BwW?=
 =?us-ascii?Q?C16Qk80QNZOO2MSs24TYZPOlrwtFRjM8hmmFs7ED5+X8mFZOgapGuNjOs4km?=
 =?us-ascii?Q?n1whb0RJ5JyUtdCXryI3oPRAMLFm4F1gVliKruetHlqaeIV3HU23BetoGoGm?=
 =?us-ascii?Q?KZXm4ix/dS2tIfDOM/TbYYdMVTqUm/W3xSYorM7WGlnyu7lT3n6jOCf7B1hZ?=
 =?us-ascii?Q?xsp6s0OjINO4o4f3+M+jJAfiwu7YzJJ7dZhzWRdfdEiX6Hb2SOO9VvRKvUsM?=
 =?us-ascii?Q?JTfU6/qjSDWukbwwnIbdy6PW5VosYIhEMoOHNJhEK7KZla5XSNVX/7CEHhGL?=
 =?us-ascii?Q?X89h4kMqpOijLX3YETS9dZ3nBx0CLSKwIqhpQPQJazxZLS+0qwYYB83MU8xZ?=
 =?us-ascii?Q?fVmmxT8nV6FRXOwaEo4Wbo7MCu5XmvSjdTvf6ITB4oveXXaEmF8miJ2lwv3P?=
 =?us-ascii?Q?f4JWvZPBdou2K1ZpUssyvsFFk+1cjYhp56qvOoIANt9B+W6EMG/B1ceIRGyf?=
 =?us-ascii?Q?Gi/tJxFqUT6GbKMj+IwldJZnZE01bsoMnGDa0mub/ExeE3i2zvpz+p5igA0e?=
 =?us-ascii?Q?rWxUo41naIWtiTCZ47Px5oRqafL5a+Tqv8lyBh0hiEk0exaAleJUv6uRLYgM?=
 =?us-ascii?Q?eP/yCMb4x2BO0elVGsvXw3tj+xsQxKvPj8kvp6AD1TkMxH6nAMUo0AJfXngQ?=
 =?us-ascii?Q?2eMiRWeBMvFyctF41XG5oxxNOixs3R4BVoGb9mM5Hl6zBlNI6G1LEOMcvjRg?=
 =?us-ascii?Q?HVFNw70nk5itvp34gn+tsSf17MuvOhZtRxFtaiZgYv/Q6XimXKqML9i/zn2v?=
 =?us-ascii?Q?csTud8p14OHBq75FJOPV+IVWWSTUAJZVar9cvAcd6xIezTtxoufiOrUDRASf?=
 =?us-ascii?Q?LG19t0OVi2fi426MT95NMpN9NhGYUcCMqECkhbZDQN7A29kLYIPiGkC28TPc?=
 =?us-ascii?Q?IYpXZ2H2DbQk74/5l5Zib3G7UYWCDCN3h9H+7YHTqHDGT2zLqHNcA7dwM8RA?=
 =?us-ascii?Q?UqdrKFnB/98bi6T2iknbS588ZBaxEBL6+e4nqUNTzv0cl3YH3HON6hBatfdh?=
 =?us-ascii?Q?2K6uhWQss5ujxkd+p83OXn6/oNRr7Dfr0hyo5BqYHWaLLYwIOXDtEp3U0Uus?=
 =?us-ascii?Q?nx/qxpMwxuH1q9kUGl3sV7iiVyfXG9In6pvYZ7STqQK6k5gMEN0Fvrp81msO?=
 =?us-ascii?Q?NWB6aPMbN9PV8NIx0zNC8xfDdbBpyzQDCMXaH1K/C+9ZAqZXKuzJA2kNs/MX?=
 =?us-ascii?Q?mcxaDQwKoMV0nnoL9WZqT1Ah0zhI2yizbVjWr8kYK4GNAkf53Hz8EoAsDA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 20:01:41.6121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 732237ac-9c3e-428c-621b-08dde27fe0e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126

This patch series enhances the ACPI CPPC CPUFREQ driver with
comprehensive support for autonomous selection, expanded runtime
control interfaces and improved API naming.

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

- Rename APIs to improve the inconsistent naming for clarity.

The patches are grouped as below:
- Patch 1: Improvement for clarity. Can be applied independently.
- Patch 2: Extend existing APIs. Can be applied independently.
- Patch 3: Sysfs to update min/max_perf. Can be applied independently.
- Patch 4: Sysfs to update perf_limited. Can be applied independently.
- Patch 5: Update policy min/max on auto_select. Depends on 'Patch 3'.
- Patch 6: add syfs documentation. Depends on 'Patch 3 and 4'.
- Patch 7: Boot Parameter Support. Depends on 'Patch 3 and 5'.

---
v1[1] -> v2:
- Move CPC register set sysfs from acpi_cppc to cpufreq directory.
- No sysfs to set auto_sel and epp. They were merged from diff series.
- Remove 'cppc_cpufreq_epp' instance of the 'cppc_cpufreq' driver.
- Synchronize perf_min/max with policy min/max.
- Update policy min/max Toggling auto_select.
- add sysfs to update the perf_limited register.

Sumit Gupta (7):
  ACPI: CPPC: add perf control read API and clarify naming
  ACPI: CPPC: extend APIs to support auto_sel and epp
  ACPI: CPPC: add APIs and sysfs interface for min/max_perf
  ACPI: CPPC: add APIs and sysfs interface for perf_limited register
  cpufreq: CPPC: update policy min/max when toggling auto_select
  cpufreq: CPPC: Add sysfs for min/max_perf and perf_limited
  cpufreq: CPPC: add autonomous mode boot parameter support

 .../ABI/testing/sysfs-devices-system-cpu      |  43 ++
 .../admin-guide/kernel-parameters.txt         |  12 +
 drivers/acpi/cppc_acpi.c                      | 208 ++++++++-
 drivers/cpufreq/amd-pstate.c                  |   2 +-
 drivers/cpufreq/cppc_cpufreq.c                | 400 +++++++++++++++++-
 include/acpi/cppc_acpi.h                      |  51 ++-
 6 files changed, 668 insertions(+), 48 deletions(-)

[1] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/

-- 
2.34.1


