Return-Path: <linux-acpi+bounces-20459-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDvkFQG+b2kOMQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20459-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 18:40:17 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED90048BB2
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 18:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE3A57A98E1
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C544E02A;
	Tue, 20 Jan 2026 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fHkfSTnC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FC44DB91;
	Tue, 20 Jan 2026 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921045; cv=fail; b=gm3BCBjAPn8jNjk3oVUD6x62MB5vuIdvuW1Gv38IhRFMvEgucBMGquPSQv8QncmAz83PKWxZlNJsmkn86+sDvXwzTK/jP02G3yEoCS/gf7pwdWFfceNkMJpeA7m1eVEhb047Qs8AeWdoD4IPdVX+gH6slKWtZ/rcyjAbgeJcTCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921045; c=relaxed/simple;
	bh=8YHy7bYx3m4iaMFIavzvNRj5w+gu0UODg/av+mgpaU8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iDiSQDprVD72Zu+DcG8nwnNiDM6CIU+Jg3EnVXMl/cn2x6x+hycgmrQ/yRILAgusnt4lxXB7gyXRA2dXmcDN2Sn6ra6r+g0IeuQY6NyCJ+nTdAnKB43qeKbOl11/d3FWt5GphkJy74nr9UkDEsktTclp8y76D6g1rcwsHOZj/bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fHkfSTnC; arc=fail smtp.client-ip=40.107.209.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ht6uXiYnpaxlGLbuypLIHST39HTrpgfvdGAM73NpampLAjNMwjpxJwh4gzrCZAiPCK846q06y3r1bDcjf8V/A3ta44b12/b+oYKCY+hrQCLGqHCWvDuJVg6b7+eW72SKNRaU6swwF3LHg3joeFM8CTDZ1SZwDlXR8b+o308u6+c6FiXwRLQ56IXpnGcJd2pTs7nDHOvAflEwkHuxHteACeJazjEferXYvf6EskNyOcisdvvQINLUDYmLsIFEjDCaPTRrvpbbR4LZrT054CkZkzYnHPkp3bsE5G6xA6sOP4CV7pcdpNDFTOoxQWlW+KevqZIm6SO20ZdPf/unwlSHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sOlvaeJXxqviArKK3gX0tgedNWh4WrM8OsM/lUmhas=;
 b=nrFbDj1W2biIJaDAPnRUIGN01FVlgjEq3Ry8yqYktH/aF7zWFc/axLQ/fBa/SK41guhsVV0GJMKRSdOJjP1LjPgg7LeOMENHZxznIDkZMCFwMgtcm4LXnVGiHu/5cjUSifdNk6lh/50yIMGUbKoITcy8VWkYzw9yFQGnf4KJ4OyW5mj8HiAQV548/yU2i48OSJ8akXGNegnqw8Y5X70/EuWGxhIK4DxB2/oKREdtAYo/BwAEzBdodl/yn1I3Ts6MekwgiMjfECEj8PgcfYykADKXboVhkDgF5GAsrqUw9Z0xB7zgmXZfKvFzhTQu9E/ua+XjcIK1a49WSZ3i0PZUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sOlvaeJXxqviArKK3gX0tgedNWh4WrM8OsM/lUmhas=;
 b=fHkfSTnCyLL0PrTJUQHyEoxuWUnWLvICrwG3sA+qgn9ejS1oNuK6Amqg1x8p1iDQzN8NbQ4/ULNnkzmFNL0G8HS2OQtl8yUe7DQFnaOKEckQPn3ZGUHW0D1Ae1/71AesW7KFx2XihBUaU4RgYAQcKDC+arcLxO4Vw3FBrfjnxEu57Rb7rXEjJMAyFzhWhGNoXOotCqL0BCpVjzZfS0TrxxFxEBRjlJT5CY2Xlj01+3tyUohg3ooUAegHjtDpPUqtorwT9ZYQl62SaYu1L59/8p/oYER6LOhksANCyYeOmZ8Rv68B2KZ0S0TaP1xwiQT+mr/3C8H4T9yDOqhHyOJxpg==
Received: from PH8PR15CA0016.namprd15.prod.outlook.com (2603:10b6:510:2d2::26)
 by DS2PR12MB9565.namprd12.prod.outlook.com (2603:10b6:8:279::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 14:57:14 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::e0) by PH8PR15CA0016.outlook.office365.com
 (2603:10b6:510:2d2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 14:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 14:57:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:56:38 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:56:38 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 06:56:30 -0800
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
Subject: [PATCH v6 0/9] Enhanced autonomous selection and improvements
Date: Tue, 20 Jan 2026 20:26:14 +0530
Message-ID: <20260120145623.2959636-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DS2PR12MB9565:EE_
X-MS-Office365-Filtering-Correlation-Id: de0a6c15-e1be-4db9-b0df-08de58343238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GDb47K65D68/waXdewffZlbCd1zbTAbluAa91lN3IHpY1nfKJNceZpHaOXeY?=
 =?us-ascii?Q?YtgDcSfnupXNrLu95ynRvjBUU6E9i7olex3JdqN+H5uS8GvvYat8Qs//LFgB?=
 =?us-ascii?Q?ETNuDSYLOe5ClMHRdM7U7kBizb2vQD2ABjRfcwQT5B/wxcH8J70GFVTVRUYC?=
 =?us-ascii?Q?kQ8TNv/DrkkP51cBq4mp2aLCpthbFRi+pa8avdVwkXvG43jwQQnqFDgivm1P?=
 =?us-ascii?Q?Gznqs1Bj68paQslY743iJC3jxWBFfHhmit6/peazAPC8P4QOWYXRKDSGM8hj?=
 =?us-ascii?Q?E0PY6M/U9gnWoN50UGy9DyEKr3ceJ1QtFAc+wP5wNMN/m4ZgkPrgoOfPZDkl?=
 =?us-ascii?Q?1RqUQjJAdctCLCLakwUWXNDwhytrJ0HDI7HrnYh+6I2lqauoHiKdMOCGcZEF?=
 =?us-ascii?Q?fv+1LNBiaihP50jNkySjdDOYk997w4lo3r25uymTgrrLz0Z9r0wjaihdeq9K?=
 =?us-ascii?Q?xtAQlVrA1qqvkr9r7+6GuvUJFiSG6nZoR72QzFgdqmJzpBTuc91HjSj6O/55?=
 =?us-ascii?Q?0+n3T+pEUCIEtnqLazFPxl8BdBCJUmbOpTn0IDyT3BuaxTdAI/zKgbNdvSQy?=
 =?us-ascii?Q?tjNcFVqLK4GLMhEAXopgP3KawbDEoxDwdZ9Y2GlXgM4+uzXRiFxMNDeU/Aok?=
 =?us-ascii?Q?q/cZQYG4J5/Zvt98qw995HPreWSgExvTT7ZWOowIJgHRDULRS4Nz99lK1sWn?=
 =?us-ascii?Q?hveI5WAXhPWF2G8bUv1UdIXWAQCqp9wFSN50nXrzB35YqoE3apc7hAAcYIXn?=
 =?us-ascii?Q?2H7RznSmzMDv6HIWiWRsl3N7nnWvj8AZHg+0lKY6NCogcfKXJGb6jfYe0EZq?=
 =?us-ascii?Q?pa4hYBtHBECGluZnD6Pmjhnq0efIy0QPHPgrPTHdbuiN6ZPaTlfoMDc2iuxK?=
 =?us-ascii?Q?h9t4lRSMrnkQROlAbC9N5kvLm3fWzZrLjE/1AXzjtDKFuLBJnV/7vBvygiLc?=
 =?us-ascii?Q?CywwMi6VOwlh1cGsM8ExZiGLfSCymMgD8++Iwq475hDC8JagE+bDQtRGUvHo?=
 =?us-ascii?Q?2kGhEtD4Ye5nQSZOw03shc/yehtxFd1xUL0nm0afKjtAMYnI0/ucx0/67lpC?=
 =?us-ascii?Q?/ewQnY0Xm6gsRUiTlJ0xzwXXMJ5g1OAS21189/c3GCBWd0uSDDqO7f3NO+Je?=
 =?us-ascii?Q?SYHscPyb9ilmAvQdINL0PRSv0oR4yElW+fKV2cPy9GD4YXf3oyKeMrH1H5f/?=
 =?us-ascii?Q?FP/Hd3IparSNGEMLh1Ezs6aCFiz1rgcDr6ybhkUkQ5TgIuRGIU+rxh3UEb7v?=
 =?us-ascii?Q?y1epoVJPSA0Kbas0oMwOpzv+6F/aHvVK52eM8Z2G0Rfdb3fu95Ds/qSqWtOG?=
 =?us-ascii?Q?7UtLEJATUcVH9rd0wx6Bn2nUFtMOWm94N/Q/+h8EH/VfVdbyEPhHk8Hs1qHJ?=
 =?us-ascii?Q?Qs3w5UPVa5wHaX6yPbBKOuv3z98LSSfCAr8hIMG0hH+i/BUEKTnvWvmHLIfm?=
 =?us-ascii?Q?o05b4cNQ+dFNb6d7CeXZw0mjbFSJxwYbdu020Wglb1qh2kxqNNO6ul7Phodm?=
 =?us-ascii?Q?XmwV5TkslfCWKMRw0o/2cJgtuvORHpjI4qPoHHMT2bVSt9kWSYY41dWAEG/B?=
 =?us-ascii?Q?j+6B7/HQDUssK5sSZEpceIY4EUm53X8MaXdwTd3syJK5cxzGgBIzAy8aSdAP?=
 =?us-ascii?Q?EqQ8gD5zmSsYUl0nrwb9ILwqMXmY9KQeYrq6GyOYiX2gsl67Hf6OMckkmdYk?=
 =?us-ascii?Q?HbKMELcKHNQR3/5glfPCIcFlqxc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:57:13.5935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de0a6c15-e1be-4db9-b0df-08de58343238
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9565
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
	TAGGED_FROM(0.00)[bounces-20459-lists,linux-acpi=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_TWELVE(0.00)[28];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: ED90048BB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As discussed in [6], v5 is split into two parts. This is part 1
(v5 patches 1-7) and can be applied independently. I will follow up
separately with part 2 (v5 patches 8-11).

This patch series adds sysfs interfaces for CPPC min_perf, max_perf,
and perf_limited registers, along with supporting ACPI APIs and
improvements for the cppc_cpufreq driver.

CPPC autonomous mode (auto_sel) enables hardware-driven CPU performance
scaling using Energy Performance Preference (EPP) hints. Currently,
there's limited runtime control and visibility into CPPC performance
registers.

This series addresses these gaps by:
1. Exposing min_perf/max_perf registers via sysfs (as frequency in kHz)
   to allow fine-grained performance bounds control in autonomous mode.
2. Exposing perf_limited register to detect and clear throttling events.

It also includes code improvements: generic sysfs helpers, struct
cleanup, new APIs for reading performance controls, and extended
epp_perf support.

The patches are grouped as below:
- Patch 1: Generic sysfs helpers (refactoring, independent).
- Patch 2-4: Code improvements (can be applied independently).
- Patch 5: Extend cppc_set_epp_perf for FFH/SystemMemory (independent).
- Patch 6-7: APIs and sysfs for min/max_perf, perf_limited (independent).
- Patch 8: ABI documentation (depends on patch 6-7).
- Patch 9: Update cached perf_ctrls on sysfs write (depends on patch 6).

---
v5[5] -> v6:
- Split patchset as described above.
- patch1: added CPPC_CPUFREQ_ATTR_RW_U64 macro for sysfs attributes.
- patch3: new patch to rename EPP constants for clarity.
- patch5: simplified else block in cppc_set_epp_perf().
- patch6: fallback to caps values if registers are uninitialized.
- patch7: use CPPC_CPUFREQ_ATTR_RW_U64 macro for perf_limited sysfs.
- patch9: new patch to update cached perf_ctrls on sysfs write.
- Renamed mutex to cppc_cpufreq_autonomous_lock.

Sumit Gupta (9):
  cpufreq: CPPC: Add generic helpers for sysfs show/store
  ACPI: CPPC: Clean up cppc_perf_caps and cppc_perf_ctrls structs
  ACPI: CPPC: Rename EPP constants for clarity
  ACPI: CPPC: Add cppc_get_perf() API to read performance controls
  ACPI: CPPC: Extend cppc_set_epp_perf() for FFH/SystemMemory
  ACPI: CPPC: add APIs and sysfs interface for min/max_perf
  ACPI: CPPC: add APIs and sysfs interface for perf_limited
  cpufreq: CPPC: Add sysfs for min/max_perf and perf_limited
  cpufreq: CPPC: Update cached perf_ctrls on sysfs write

 .../ABI/testing/sysfs-devices-system-cpu      |  44 ++++
 drivers/acpi/cppc_acpi.c                      | 206 +++++++++++++++-
 drivers/cpufreq/cppc_cpufreq.c                | 224 ++++++++++++++++--
 include/acpi/cppc_acpi.h                      |  46 +++-
 4 files changed, 491 insertions(+), 29 deletions(-)

[1] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20250823200121.1320197-1-sumitg@nvidia.com/
[3] https://lore.kernel.org/lkml/20251001150104.1275188-1-sumitg@nvidia.com/
[4] https://lore.kernel.org/lkml/20251105113844.4086250-1-sumitg@nvidia.com/
[5] https://lore.kernel.org/lkml/20251223121307.711773-1-sumitg@nvidia.com/
[6] https://lore.kernel.org/lkml/66f58f43-631b-40a0-8d42-4e90cd24b757@arm.com/

-- 
2.34.1


