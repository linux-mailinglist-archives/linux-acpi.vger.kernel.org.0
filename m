Return-Path: <linux-acpi+bounces-18615-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F7DC3EC7A
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 08:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FDC3A49CA
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 07:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B1230CD84;
	Fri,  7 Nov 2025 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JGEu0Gal"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0280D30C60B;
	Fri,  7 Nov 2025 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501339; cv=fail; b=DlxdwHWB0DGMUdsGaSyDcpFT5vZD++ehRfcN526wQAbovL6xEC1kk9JHWz8+wq5ns4sJQqplxSsultUJXBXgH0jJXt3b6kqadZF2s6ki2jhYq1UiMb5d1UatQTCDY/rBe7tJ+GFN/+Ur8FZNznbEdCnqOwaUBb1/ZpeIPsQT6LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501339; c=relaxed/simple;
	bh=hj6a4Zeu3z+B0RouxzbdQFoW6vRumuwI4yRsnRTwTW4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RlgWrgK743kppuGsmyHAWNla5rveBOWKGEvQOwOEXP/UtOt3Ll2b2kvzznDlYFwRK16tNQxdFCTbEyqkh/cFUZxXSuM7/7zG9nRYh+tLC9d0FDC3EtYuBwrvZQvFvW7VZvdBPjCA5P3bGPUkQmk+6Tb9WSF86wyyVSZ+dBMy6Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JGEu0Gal; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kc8OERK8rSYlrEskX27FWgxQ9OE2aIoyCnlHnMndSuvnYEMX0b2oIMjrcanzqwAlZHG3KfZo4s30UxUuw1GY/Le7R74KFopRgRQAVmRE6TjIoJ/aKjOohIXFO4OTaMN16wt5gBBdS/wAGngmVW4uMuWo9k8+hl+FHJH8kxvJiRQTlXRSBXnP8MDjQNObO1c35qoWYAC8pWLAsehoatwzBBYzxq5+jUgV71grXDZNcHWSN4by6q+2BEFfqpL+0HR44yMJtbZIlGduqRCejdJ+o6B9YcjvvrBBPhk/ayNw+UmtqxeaBIBYxGeM7T+eJpYOFKLMRi8Vb+tdT4LANo3W0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4A/+TOOD4uul8nSxn0G5I1/IKchbpjto/+fvLlZeco=;
 b=TNe4t7AKQEM/OrNrW7IrXff7g31/QeHpEYj15/r4WPjopeyn+TU/sPuyFsYDklhixK8Z46DyJBmNzSdmhceuPfF3+JRBHsap+6ssfovjIr0EKdwjUMT5kVnUqw27sVMcpLpQu2zuZfV2BKHTdoRf+wqrKYDlozEjnu4P7SfZ/hrkkhumnIXIUXuv+utJrq+TC912KnK9qdKu2BqoL8rOXeTzmLwI2944c7qyMWvvFgI1UVgUHm6ghNTibn5ziXOIO/2565CfEwmlc3a7aiIlQ2mQhS5c0mXju+/DScyl66/PkDe1IgLjykP9A/sjvZoTDU8KGhEZ7gBHDgKHGkBSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4A/+TOOD4uul8nSxn0G5I1/IKchbpjto/+fvLlZeco=;
 b=JGEu0GalGbzWV2j7IGsXJSJZSD88U9UilujnWFYaVmwB0fMAzNSK5PZglNdftGPW3hYoCf2D2BEFhriDYw6wYfRFemHhKbFEJhh296NYH2bGEkpMI9rLIEcgTiLPPttHSqd3yTEYgnWJIPHmO2VRN7Qm7HnG5NJuFo6Rok3g2BY=
Received: from PH7P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::11)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 07:42:12 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::8c) by PH7P221CA0034.outlook.office365.com
 (2603:10b6:510:33c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 07:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 07:42:12 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 23:42:03 -0800
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui
	<cuiyunhui@bytedance.com>, Jeremy Linton <jeremy.linton@arm.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christopher
 Harris" <chris.harris79@gmail.com>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v2 0/5] CPPC/amd-pstate: Fixes to limit actions to online CPUs
Date: Fri, 7 Nov 2025 13:11:40 +0530
Message-ID: <20251107074145.2340-1-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3e2385-78c3-4084-7d34-08de1dd129e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9EwzBjljXnOw6581uWPb+vrDQuGdeYia/gceM128RKA+zcqwDEmVnkpur9Ut?=
 =?us-ascii?Q?LKroxjx2Lb6Zo0Of3uCiBT1SUMzNDFMUfDdOFA59RcB86XoyqHmh3UX+uoN9?=
 =?us-ascii?Q?mzG29CovgTwemWDx1DHPJ8KpUD/J17C4OO6sd3IVY8xa+qmxAJ2xDMowfXNG?=
 =?us-ascii?Q?yQUJSnCNPPdy9yHNzOcVQQmHlj0VB+jcRJ40kkOo3ZNfaotTtZfdCEdirxUN?=
 =?us-ascii?Q?Ss8PpRRmf7GbnZ0FGuWcz0xZUdiTKtoQ3EhuzpV5mff0GGSmW+mX0ZnT/It1?=
 =?us-ascii?Q?w+cFWpTK3eSPjH2yASJX1L9PM3DRCoI7HqjraIv7RnkV+4h96udWxHJJQzqb?=
 =?us-ascii?Q?PPMGFPuZyUiYpGeLSNp2s9O49dHwXFCIYD41tLwhs/Tf6H+ZBGGSH7/LJJaw?=
 =?us-ascii?Q?E45NL64A4cfLmhRE2sqvfcZyvIK3oDj2SUDBZi9WGnwF45huUsTM62TcKhMc?=
 =?us-ascii?Q?3LnhK87V4rpS9d2McroTAAx9S4Isbqejv9bq8ZWD+Tb9gGKJdT+IRb/T50gr?=
 =?us-ascii?Q?4ASzKxxTI84ssuSpK4GrDNNRhN66R3/WDdYuvqJCSYgCNoQvQZS27WHkw/Vy?=
 =?us-ascii?Q?OBPngFGTJLIKuD9K0o00CBtIS1iXvSVIgVFJIHkiRlUUjANkrPkEBOQpUFdw?=
 =?us-ascii?Q?wUs4HgW3rvonXzflcETa11w5Qt+PgJwatfSZSuDzuwwJG+LSvyOeYyAVlesv?=
 =?us-ascii?Q?xbyQ+b7ATiFygk49e7mPiYVN3PsU9HbFih2sdH4Yg7cRQFL9EquC4167+tFh?=
 =?us-ascii?Q?5ay3DWHuq4b8a5Gxyb+3+6mL49lv4iOcRsRoHw6OGJnfoz0o2ncJ2ZnMsY6C?=
 =?us-ascii?Q?SJ7FvyeJlNRq9OvmAzd5SBHeNYParc+YmqpDe8hojihGw27+YpzmDoRq1a6o?=
 =?us-ascii?Q?K8lw2ofiUejDTV2UT3aciJtyCdtQQZfB10vMIvAki7vAe0SL+LTMLKkdSKtr?=
 =?us-ascii?Q?RR1Cvpw5hksOKN+ws14gqYly1c/PUd+Tnh/QByLdrPlfSTte/EaIgr/1WHy2?=
 =?us-ascii?Q?IS8pkqbjjTd6dEsSvCAe5XTDe25txaySyrKFGYfrCr/QU9WAVo0aNhnlwJlB?=
 =?us-ascii?Q?hjWt0vO0Q6VUCA8DT6uFea4LaesojJhIYdiitSaZjb3A6j3Ft7878OfwulTq?=
 =?us-ascii?Q?JkmwCN2exEGpaGpmeOd1L7+NBqIgJBmOMRJwh0HwATWWkaYMwTkeTWGAgEg9?=
 =?us-ascii?Q?xH87j2z6zq2rTD1lH+ovQGgmZLAQyKwiNJW7+FnU7p01yeM4PZszQa5MHOiv?=
 =?us-ascii?Q?foXLmLHevG32ovJkXbjtxzfoVlbSyCtsFRJXqq5a1JeO929iRRYhEIqy6Np0?=
 =?us-ascii?Q?eQjWx/n1i8Og3llGDDYUBUruOJPRgQrWsSs2RTUIKn9euO4w/Vyr79Kq2iMG?=
 =?us-ascii?Q?jyRwnJro+OEWVgv1nOLs31Myv4m5w3jRHWplbkx/FpoAZ9Z9QpPh2lCVmo0q?=
 =?us-ascii?Q?ab5+M7QyP6j/sUzktgEiZisJ67KB/edwQTcQSxabX3eVESP5o8WM9qXIilSH?=
 =?us-ascii?Q?2QOHOmlHkwFMjPcnsXL5UHYwDpNnxXqFY+CU9Rb3drstsjEb4jzL80rZyDwu?=
 =?us-ascii?Q?6h/yfgaU8rhCMtB82MU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 07:42:12.0549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3e2385-78c3-4084-7d34-08de1dd129e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285

Hello,

This is the v2 of the patchset to restrict certain actions to only
online CPUs instead of present CPUs.

The v1 of this patchset can be found here:
https://lore.kernel.org/lkml/20251105143851.4251-1-gautham.shenoy@amd.com/

Changes between v1 --> v2:

 * Picked up the Reviewed-by tags from Mario for the first four
   patches
 
 * Picked up the Tested-by tags from Chris for the first two patches
 
 * Added a fifth patch to fix calling of cppc_set_auto_sel() for only
   online CPUs in the amd-pstate driver code (Mario)


Gautham R. Shenoy (5):
  ACPI: CPPC: Detect preferred core availability on online CPUs
  ACPI: CPPC: Check _CPC validity for only the online CPUs
  ACPI: CPPC: Perform fast check switch only for online CPUs
  ACPI: CPPC: Limit perf ctrs in PCC check only to online CPUs
  cpufreq/amd-pstate: Call cppc_set_auto_sel() only for online CPUs

 arch/x86/kernel/acpi/cppc.c  | 2 +-
 drivers/acpi/cppc_acpi.c     | 6 +++---
 drivers/cpufreq/amd-pstate.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.34.1


