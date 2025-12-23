Return-Path: <linux-acpi+bounces-19816-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F5BCD92F0
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 13:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC61F301B480
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 12:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1219330646;
	Tue, 23 Dec 2025 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LJ5UtcLZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77CB1F75A6;
	Tue, 23 Dec 2025 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492017; cv=fail; b=vAo6BXtVU/BK5+F68ZGIwBqq7SccMCQwx4YKIGreoe0t/BHaeR8WekxUnPlZdGJYnjuLtQA2YR+a5XPCKf0xK+LPp3PiFgLUR2iNoBK7zbE7TyF8tqEz/Uiy+ziyi1IEHqdOvDTox6eHghYdgH4GQOguv0t54xsFeJ1t1iTXBMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492017; c=relaxed/simple;
	bh=JtTq2VuEX9Q6G3HfDXs22eUUJ6bCi+13EzKNirM8JDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P9LlP3Wbj9HnKYksmzgKgGEUCE6EPLyqhWa3sFTFP9WygUiBp9dKKL5DC0eCTsydXTlwOoyRriYUmmmOGDzWl6P7DMyt6q82E0XxMGVrgLKio4mHXDTbAOzEgBHPmh27E2LxnLeJFLtQmMGawhahHD4LS5byaSSXdXIZ6FzrgOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LJ5UtcLZ; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqFT6gv7jhR1kaMmNJ48xiJYX46qI08Y9UO1iqSVIDLfzIYmaDyN+CNmMOUcAQ2wsHq6+rkplWI/PBELWN+e5vtmWfR1/4IQ7Au6DMtuDz8cK+D9PksuP2tGhB2Cqwt4JmbnTSKKdcFNxDAzla8RMK9vMs6bf6TFmaph1zFkt28ifFKS/XsXibPlHqrM9O/aFUxQ7J1pFcIXMHATqlwUGVA52kHAdgMmhBuIclsvTGrvU0m0ZCuPs6fla2opuDS0Mi/+wus6s9xITJ2+t8Wz8d3TKaj1U3cYknyisR5cURg2aangTitCv5peF1IhgBuDs9qC1yGwbcbxpKmchuDxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVs1UoDV32Y15tMsSgMRxjeSXPMlY9VSKkuOsdJpc5c=;
 b=ee5DJDzEhZoFlfNXYPTmMe1wWIEonyZuFM0Co00usOzKVQOmCbrC37vZoLKJvWg4E3ifOZPVYt1zfClhIu0UyiWMhL+0X0Rt/aSR35FKwJzIdsqi1GUBkk5hj1pMvrtmYiVNY990rSV65bvD70IYXkmEA11pQIvi4JMRF7znoOSM8wBEihKnRasa0qGDQOg/tkC5XO4OWtHNvxSPZPfo/GQTg6QWMDhtLdUncwpq2/sq2jnlNwP/9uyHdr80xwpFAY/FJ+wn8L8KhQmEyWHxSnP2ThA+gRYZ5tpLG/INi2I8eQmsQXWlfcmlTbsNG0Ne+7PCkvFpYLitd6/xgC78wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVs1UoDV32Y15tMsSgMRxjeSXPMlY9VSKkuOsdJpc5c=;
 b=LJ5UtcLZkP6Gup9LeFzXjaU2TeaZjGg3zfvoX6YCwzFOv5AmhehBxZo9RR/mzDlmjrIDqXsu4Rpb/hqzZk2bYrRpFgNY2NrmiEQsvR8UAowzsZF6mqiEUvyfC0sgAVAbFlD20tU0ZE6BDzEseYmHdiGry3AmtfEtabTleEL2N5GjKzzo2p98b0OcMcz99fSLR/ABefzw8Rs1oHfNLjni6pcAWFLxBMSYJngTY/AHde3comuViRYRYOpc497MGGpQcP3WHirsHs28vSbZmHJnAOzcYWkZJR3BozZ0/q+sN8ttsb1sQ4xZahJ8LERNCW9p3jJ5KYIrNYOXwTukmM83lA==
Received: from CY5PR15CA0071.namprd15.prod.outlook.com (2603:10b6:930:18::16)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Tue, 23 Dec
 2025 12:13:31 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::2e) by CY5PR15CA0071.outlook.office365.com
 (2603:10b6:930:18::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Tue,
 23 Dec 2025 12:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 12:13:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:13:19 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:13:18 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 04:13:11 -0800
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
Subject: [PATCH v5 00/11] Enhanced autonomous selection and improvements
Date: Tue, 23 Dec 2025 17:42:56 +0530
Message-ID: <20251223121307.711773-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: de40b0c9-e1c3-45d3-df21-08de421cb034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d8GJB2f/eTn3SxEd/Qtdltt9u/321xuxvvrl7QF/oO9cRY0+O4eTAR38X4Ia?=
 =?us-ascii?Q?R057aSP8uP9AS314CnOsxU8ieTTxzIv/AqO3nyxvzI9AKHdwKzVcfPxwsw0s?=
 =?us-ascii?Q?9OqyIGU5ZtP0nxRs51/5lAkY0nesnD3KhlZn2aCaWulLb9C4fK+g5ShB8JCo?=
 =?us-ascii?Q?vJjnacM9GO4FTEA8296CopsI/QykUg/hzVA9Gx094ZlD/LNai+1WpLg2C7Ee?=
 =?us-ascii?Q?ADz+cWD3BSOFdlIXUmICyruDVtsyByz/xGE9+w1GseHeMiuUEt8PR/Q7ZAeH?=
 =?us-ascii?Q?sbO6IEXNFlXNk7IFchm21P/1A3w7iC7IRl0IFd8cPdwCy8pDZ/w4/+yLr53s?=
 =?us-ascii?Q?7zlpMzAnmo10lCCb+L9IjFJeCVmGYR2AivXHvwjm7RJD9P50MN1Z7vNYmXf9?=
 =?us-ascii?Q?HzlFnTBOPtZeOMWcbjs6DVIeGjzicfEgbSrDs5GSPoA/wWWV79wJ49liz/eQ?=
 =?us-ascii?Q?wCvDTsyc6mOD+8BKGHcdBlqdWUUNtTh+eeF+Z7qLYsIqwkY1jF7tV6Ah2cbs?=
 =?us-ascii?Q?u7zxS8wjliXQQJeDx66ISfT6QNasL+jBz/IWGSZMOk5NoGm9LV3TqtD+Hvwx?=
 =?us-ascii?Q?Sj+SqNnul+9qvqUyQboodu9QWH2skvCQzMhpJFVyKsMGfEpnO2b1FZhBZPEu?=
 =?us-ascii?Q?q0YlP/O1BlDOfcJXwYMM2iYE9y85yFXeiy/Ziqv9+QgHtvulYadrIsdUnptG?=
 =?us-ascii?Q?MtAUerq493pvH0t+7EQuLXaXDZtjaDflEYf9mX+pKenOkZwShGFBg5nOtfI0?=
 =?us-ascii?Q?xfr60NftDg2PZV8UjIth9cdb+2Ipi4uAxICIWGURdPuPD7Ui+27/qFtp6/WU?=
 =?us-ascii?Q?G9ck8NrotkgayZC9wDuc6c8f3jFHFkULgjEX7w72cuEW+C2B4kR7oinj3/tu?=
 =?us-ascii?Q?9RhqPokh+F6Q9G4uwWffirtJc/LRxKQGJ/H0FQCqXjy2mggdWBxRZaNDXmit?=
 =?us-ascii?Q?Sls75ULqqnxJaVpLtLlG5T23w407W3eimGd8q1TW18hLGiKereOkiq9UwntF?=
 =?us-ascii?Q?rR1lSsANeTVM7+UkVupLdBA3h0DvsfaRSNdX0smf6bBKT1L89ROv7wrkomZb?=
 =?us-ascii?Q?qe/66PMVz3Jph72PwhqUhQvhJtpEGBwgMkH6lixd4WteBUmKf5i1LRw7MWy0?=
 =?us-ascii?Q?FTkmr4OhJhkBoOhQx6cXZJVCQCC4I+bGBvYxKlRJNJNMbInkgmiGItS2Y2Ou?=
 =?us-ascii?Q?aiAM5Vlop3U54LGpnyQglTHf27P5pkiX9dzsoPS+9+p/pW6fDpirgutCXx/F?=
 =?us-ascii?Q?lmcdPA6nj47IirKB9xGaULtGQz89MUGle4Wu4jfmwpXOfjZ70iaXl6eFTQES?=
 =?us-ascii?Q?+Ta1eBO5wS0uJheltArkHOEtDIIafbiRzsSk9jM6QCLg16NTiR3YBtpomJu8?=
 =?us-ascii?Q?WrmMqh6zbOCK32I0pbMkMoRG/0ngUpEoP8uC7fUjht9E+oycN+x8C7LQNnIh?=
 =?us-ascii?Q?yQKXT6xq0Di1yQ9CdsDoRzIq5j4uokrcKHrpoZl9CWmfArzCu45cLICAUWOz?=
 =?us-ascii?Q?8yG+2lInyqV10gvL2lndCRzuCR0AGZjw+thOsu2KTHLtXlMy/Qtjwwkw4d/N?=
 =?us-ascii?Q?8ZJ8wDoQNcrf42cC512dUgevvkRrQ+P0owlC2vqsWun4HSVcbQhSPzQw6KcO?=
 =?us-ascii?Q?BQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 12:13:31.4860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de40b0c9-e1c3-45d3-df21-08de421cb034
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103

This patch series enhances the ACPI CPPC CPUFREQ driver with
comprehensive support for autonomous performance selection, expanded
runtime control interfaces and improvements.

CPPC autonomous mode (auto_sel) enables hardware-driven CPU performance
scaling using Energy Performance Preference (EPP) hints, without OS
governor intervention. Currently, there's limited runtime control and
visibility into CPPC performance registers when using autonomous mode.

This series addresses these gaps by:
1. Exposing min_perf/max_perf registers via sysfs (as frequency in kHz)
   to allow fine-grained performance bounds control in autonomous mode.
2. Exposing perf_limited register to detect and clear throttling events.
3. Keeping policy limits synchronized with hardware registers to ensure
   consistent behavior between HW state and userspace view.
4. Providing boot parameter for system-wide autonomous mode enablement.

It also includes code improvements: generic sysfs helpers, struct
cleanup, new APIs for reading performance controls, and extended
epp_perf support.

The patches are grouped as below:
- Patch 1: Generic sysfs helpers. Refactoring, independent.
- Patch 2, 3 & 4: Improvements. Can be applied independently.
- Patch 5: ACPI APIs and sysfs for min/max_perf. Independent.
- Patch 6: ACPI APIs and sysfs for perf_limited. Independent.
- Patch 7: Add ABI documentation. Depends on Patch 5 and 6.
- Patch 8: Sync policy when min/max_perf updated. Depends on Patch 5.
- Patch 9: Sync policy when toggling auto_select. Depends on Patch 8.
- Patch 10: Make scaling_min/max_freq read-only. Depends on Patch 9.
- Patch 11: Boot parameter support. Depends on Patch 9.

Patches 1-7 can be applied first if they are Ok.

---
v4[4] -> v5:
- patch2: new patch to clean up cppc_perf_caps and cppc_perf_ctrls.
- patch3: moved cppc_get_perf() call from v4's patch8 to here.
- patch5: fix ABI documentation format (kernel test robot report).
- patch6: update perf_limited logic to only allow clearing set bits.
- patch8: new patch to sync policy limits when updating min/max_perf,
  update_policy parameter moved from v4's patch5.
- patch9: refactored from v4's patch7, added update_reg parameter,
  handle -EOPNOTSUPP for auto_sel (platforms with fixed auto_sel).
- patch10: new to make scaling_min/max_freq read-only in auto_sel mode.
- patch11 (v4's patch8): moved boot param handling to cpu_init,
  handle -EOPNOTSUPP for EPP (platforms without EPP support).
- general code improvements, kernel-doc updates, reduced redundancies.

[4] has detailed changelog of previous versions.

Sumit Gupta (11):
  cpufreq: CPPC: Add generic helpers for sysfs show/store
  ACPI: CPPC: Clean up cppc_perf_caps and cppc_perf_ctrls structs
  ACPI: CPPC: Add cppc_get_perf() API to read performance controls
  ACPI: CPPC: Extend cppc_set_epp_perf() to support auto_sel and epp
  ACPI: CPPC: add APIs and sysfs interface for min/max_perf
  ACPI: CPPC: add APIs and sysfs interface for perf_limited
  cpufreq: CPPC: Add sysfs for min/max_perf and perf_limited
  cpufreq: CPPC: sync policy limits when updating min/max_perf
  cpufreq: CPPC: sync policy limits when toggling auto_select
  cpufreq: CPPC: make scaling_min/max_freq read-only when auto_sel
    enabled
  cpufreq: CPPC: add autonomous mode boot parameter support

 .../ABI/testing/sysfs-devices-system-cpu      |  42 ++
 .../admin-guide/kernel-parameters.txt         |  13 +
 drivers/acpi/cppc_acpi.c                      | 214 ++++++++-
 drivers/cpufreq/cppc_cpufreq.c                | 434 ++++++++++++++++--
 include/acpi/cppc_acpi.h                      |  46 +-
 5 files changed, 712 insertions(+), 37 deletions(-)

[1] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20250823200121.1320197-1-sumitg@nvidia.com/
[3] https://lore.kernel.org/lkml/20251001150104.1275188-1-sumitg@nvidia.com/
[4] https://lore.kernel.org/lkml/20251105113844.4086250-1-sumitg@nvidia.com/

-- 
2.34.1


