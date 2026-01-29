Return-Path: <linux-acpi+bounces-20755-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOhmKRA9e2mNCgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20755-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:57:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA94AF40B
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 117BB30514AA
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 10:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E573816E7;
	Thu, 29 Jan 2026 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RjKzHjwm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D1D37FF49;
	Thu, 29 Jan 2026 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683730; cv=fail; b=hpqCvaqiFhnCSQk68SFFSDHmXwB+Dpe3iJXgB6tDzPbP7uQt3FmBSf+qjZI9XdZYUxMoMqUN57wfC2QIXSQOYjnRWzBGQNBPlTp42n8O36q7efGN8cZysCknBxt2MVE9UtCEFO5BDBeEYuq4+UEQ8sIDU4q/RlW6uzzjU/m1Qms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683730; c=relaxed/simple;
	bh=c2Ds/rIXpDPA5NDXsbIPUG8+3wm7c2p3cx4Jd+zU/+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JoOFP12Mzc/iSgrvsyrXYkQCw0i5qE3mFcHQ3DVeEyR8CPVJ9r6r3vIjeNy/e1NOrtYM6URb2bWXyPO5FhaOkS+YR+9OFIHF9w8tbx0Uh/+3symSwV3E6f3AUQevXQrMiyKr6eHGqh3MXOLJWwBXcjM3GYCklnFZmSDNBD5qnts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RjKzHjwm; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNvslVy6OsgF0SnFsVx9//1xs8+/DQwDyHf/2hUw57DeNDtSyWTibCYQpR4MmOhZguw7a4rk1cS4eis+i/fjHZ/wazGTsuCh/ViLub+enCYm47vyuLnhbJV/wtpnJaT9bk6BD5MeYO1/r/s8MhIcrQpIX6hS493ivNvRgCVuUDvWmPZPbg4lqwl9te1zLX2WChjPIq9ioWedmL3cqYL9/gA8oa9/4vymucGbIQnxzNEMyUv1X1hQJnrTKyglg7C4ujRDrV0qW+2hVrUVqArak87xH7mIA3F4O0a5hhl5r0MramFdtreZFMoeoy7Wlby7efHTm9VNGz2xDxcS55VT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDjkvDqcBfn/7Wmpbew5GlhamzH3bjQ/b5Nx9nk/190=;
 b=Ns6vyd8K6+xLnVw0gSEni7rG+kNOjLj0yK+1XBjZ/ZRu19q49ZtPozEVsQQRHq9OkIucv6+mMipNlarc505IPR1T0NerKirH/slkCGOAMCg2d6L7+9br4ajz+ZQ47+i8MrLJxy9wu1i/9vA1j0YbtFk4oPsDVPkQNLaKrcmUAkN/ddQKQhi6YQOChvSDIT0D1IZgwmMhUTTB+cXAEoHeO7+3SQlqmGk4ZA+amTowaKvLZW020jRpMMxMMUfeihQPFnNTENgwbcltEqlNeDbZLot+FAa61Bf7gpLvkwcGogzZuq5MNGZqitFM0F7F18BIQf9yvxoVrYkOtOef8yMWkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDjkvDqcBfn/7Wmpbew5GlhamzH3bjQ/b5Nx9nk/190=;
 b=RjKzHjwmnmIupDsVSOMRx29meGLVI2wnh82RFD5Ohi4VYQbKmKthMJ5+eJiat3Um/RQnk5C2V3rMfKFYB0bBdh4H7jD09mUkb7JJLmqklSgMqzgNz6GVFiHAvB3a3AV3XfVxwiplDLbvx+cMsczIllKzsnzUru+kYpNbgQ7CxtNAA8CQLaRvi0fkeZWLErrpltNOijxvvs6rXnfdL4mn3+AirTBBfkhGQjCGULtrWVMjPfisZxbMck6sieFfjwEYZG6Yjrp9whmN0O+RX3oN5vXozC3QgKp3ylVVKRQQMu4fxjyG11w/e+BUlIz7YKu53PFp3ADrjUiHMlCq3onAxQ==
Received: from BL0PR02CA0035.namprd02.prod.outlook.com (2603:10b6:207:3c::48)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:48:43 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::77) by BL0PR02CA0035.outlook.office365.com
 (2603:10b6:207:3c::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Thu,
 29 Jan 2026 10:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 10:48:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 02:48:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 29 Jan 2026 02:48:26 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 02:48:19 -0800
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
Subject: [PATCH v7 0/7] Enhanced autonomous selection and improvements
Date: Thu, 29 Jan 2026 16:18:10 +0530
Message-ID: <20260129104817.3752340-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f2c6ed-b8e1-4909-c6e0-08de5f23f84b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?73Gd5Rs22pZW6TWatzsiZh61lPp6MnuINjQSLsSQzzZZ4av0Kg0Xf1pxP7NL?=
 =?us-ascii?Q?6CGhamIbJM8/oipSmA6zJrM/W1bQZckfmPbS9Do/Dvhl16b67Cfj4az7Gpqb?=
 =?us-ascii?Q?J5ygo/eARJSAWnlbwg/y8Hc7bRLjnVngZ8obtAD+VQsYhSynrr8TlThm0E+Z?=
 =?us-ascii?Q?bb0ThTDbSvBZeXzxE7BS+mKt1qXBnwIVKAuDMbv6szXGBQZEiibLnj5QPqKB?=
 =?us-ascii?Q?HyhXoDGkqgfsGbX0tKoU76oLT4vT5l5OIqfyoub2BzXbOG5ffZ6VFV2qNoJX?=
 =?us-ascii?Q?SmNinsXE8rGDcCJlSfpQR/+3+UZxQrHzT3KGs75UrqHxO2VXMgMAG2NPo8Gp?=
 =?us-ascii?Q?TUXzHGAb1wOIPZWBYXCfbsLyt4fM9tFxBsUTynrgGICIrVJW7tEfSzyNJSFq?=
 =?us-ascii?Q?9E3Hi4ikFIl3kI68s4FJf9O30OZyOsI2P9E/y38ZkMD0zmx3V8CLbQPSIrgO?=
 =?us-ascii?Q?5ppm2atJfWUz4BpyypFfliqsww1+/E/19urGYzS2bQ2CHrZ1Y4I2iIyelEc+?=
 =?us-ascii?Q?A08a2UwKsiDif1tW8crxKtK+Abxz7nMPh1tA7aDU1TOwGvx9lGiS5cJ/xa0P?=
 =?us-ascii?Q?xqQ8S3IoFEVaiLbVXBc+rR4+1rCDnorkhQpqINTBzRqJy0ShAOHVHbM+Zfxy?=
 =?us-ascii?Q?GHwJM22luBtFOuD623iRS0AyK2TECvNfdMp+pIikwOobiCRZVWZfeM5K88Kh?=
 =?us-ascii?Q?rkUNaN8ceYA7aKCnqdAm9yg6JEFrPNPyY3N/1d4obT6vDWya6AhfgsX2mfvF?=
 =?us-ascii?Q?BqSCZO9oN3GPpxye3d4c745NmfwksNhYSW3YgKybJ71OLufwySFsl7Exemz+?=
 =?us-ascii?Q?y+gQXcGN5u+ebkzmevnUj5XrU5w2v0fyoCjZdcB28QnbX/e2hNaZM+jn8cXj?=
 =?us-ascii?Q?1YcEKqUzrsD444IRdlmqIpo36o7QDEkeD3SMiAf9DAIFVNJ3AIgubiusIXsb?=
 =?us-ascii?Q?KxB4THBMdWxRWyJVPHMaNKYEAFYC7FXFIbA80YybQhhW8Hd9CFIeXSb6m7RK?=
 =?us-ascii?Q?sgHiv8xmPUFKM2mkJa/O2ES0H3acqr9SgngLiXL7nIt4T700XNFucMu9xhVh?=
 =?us-ascii?Q?dncr2mN8rt+3aR+6lN71DT9V5RyIH6XkUyRS0c5334hdQO2QawuLfWvJC0PT?=
 =?us-ascii?Q?bM6pKmGDg5fzFvv3R0ADTA2RyvQlfik0t6YMCEayTf6QWq5600i0PEzxKQhE?=
 =?us-ascii?Q?bcS4yC+5RVMBCqJZmxizGcq9udbXcb7FUcElDayvvxq3rEuKzj9ZraUlzW4q?=
 =?us-ascii?Q?tM31cdoS3RN1QNt2OEAhu+2MiUy+pRxiKWABR6vexo3gbDdIvtnQSVMWWiHO?=
 =?us-ascii?Q?jKlwOwPm+ZE2L6XaHRZb+5RUyNR9w480Jw2M0S/QS7mTLeYTiW+/+g2Luh69?=
 =?us-ascii?Q?HIxe1pr3dRdAGLxkKcjVXJ5b9xB84mljSD/7Shb+aod68f5weqbo2m668UFr?=
 =?us-ascii?Q?sQRNyAuJnsq//9+gHmJdspFis1ClogHxsNbb6DJE6G8uOqUf9lJEINhyIqTc?=
 =?us-ascii?Q?EHtq+qp6m8KGRsuAWHTwhUH27XcvxiLBEzgpScqywzYRD1vDZ4MSv0WSsnxQ?=
 =?us-ascii?Q?jppPnrvH4tjUHv1UUGPf2humtiIGPwmn5OBuOTJcoLYbJiPWvUksJKs4mtFs?=
 =?us-ascii?Q?el6eqqVUIBW6GDYUdvUm1KUU2jVqEtbo0e2N/R3izSxZdHOJY3Y1EFVvicRl?=
 =?us-ascii?Q?kHaX71LNMgfRPn2aE28jqv7mE5U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:48:42.5776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f2c6ed-b8e1-4909-c6e0-08de5f23f84b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20755-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2CA94AF40B
X-Rspamd-Action: no action

As discussed in [7], v5 was split into two parts. This is part 1.
- Patch 1-3 from v6: Applied by Rafael for 6.20.
- Remaining patches: Included in this v7 with review comments addressed.
Part 2 (v5 patches 8-11) will follow separately.

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

It also includes code improvements: new APIs for reading performance
controls, a warning for missing mandatory DESIRED_PERF register, and
extended epp_perf support.

The patches are grouped as below:
- Patch 1: Add cppc_get_perf() API (independent).
- Patch 2: Warn on missing mandatory DESIRED_PERF (independent).
- Patch 3: Extend cppc_set_epp_perf for FFH/SystemMemory (independent)
- Patch 4-5: APIs, sysfs for min/max_perf, perf_limited (independent)
- Patch 6: Doc for min/max_perf and perf_limited (depends on 4-5)
- Patch 7: Update cached perf_ctrls on sysfs write (independent).

---
v6[7] -> v7:
- patch 1-3 (v6): Dropped as they were applied by Rafael for 6.20.
- patch 2 (v7): Added new patch to warn on missing DESIRED_PERF as
  suggested by Pierre.
- patch 4, 7 (v7): Removed mutex from sysfs store functions as
  policy->rwsem already provides synchronization.
- patch 4 (v7): Added validation checks in store_min/max_perf.

Sumit Gupta (7):
  ACPI: CPPC: Add cppc_get_perf() API to read performance controls
  ACPI: CPPC: Warn on missing mandatory DESIRED_PERF register
  ACPI: CPPC: Extend cppc_set_epp_perf() for FFH/SystemMemory
  ACPI: CPPC: add APIs and sysfs interface for min/max_perf
  ACPI: CPPC: add APIs and sysfs interface for perf_limited
  cpufreq: CPPC: Add sysfs for min/max_perf and perf_limited
  cpufreq: CPPC: Update cached perf_ctrls on sysfs write

 .../ABI/testing/sysfs-devices-system-cpu      |  44 ++++
 drivers/acpi/cppc_acpi.c                      | 214 +++++++++++++++++-
 drivers/cpufreq/cppc_cpufreq.c                | 207 ++++++++++++++++-
 include/acpi/cppc_acpi.h                      |  40 ++++
 4 files changed, 500 insertions(+), 5 deletions(-)

[1] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20250823200121.1320197-1-sumitg@nvidia.com/
[3] https://lore.kernel.org/lkml/20251001150104.1275188-1-sumitg@nvidia.com/
[4] https://lore.kernel.org/lkml/20251105113844.4086250-1-sumitg@nvidia.com/
[5] https://lore.kernel.org/lkml/20251223121307.711773-1-sumitg@nvidia.com/
[6] https://lore.kernel.org/lkml/20260120145623.2959636-1-sumitg@nvidia.com/
[7] https://lore.kernel.org/lkml/66f58f43-631b-40a0-8d42-4e90cd24b757@arm.com/

-- 
2.34.1


