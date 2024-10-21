Return-Path: <linux-acpi+bounces-8885-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D5A9A717E
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 19:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8071C22D0B
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 17:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BF61F4FB5;
	Mon, 21 Oct 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QzjnYYIO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E51CBEB6;
	Mon, 21 Oct 2024 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533409; cv=fail; b=SHhrByE2I4vHJimc1DzUAuWyEBSxfab2OY3iDCEbgRdmNjR1pCfUb3FodzSQhUfoC3OSleBpqMYcDgguqRnwYkSJH9EjKHgErhqzIVP2vOHgi5uGLxzf+0F7dhDpES/q4e7AkZwPlmlINt6vvGfjgCg/JThR7up1VhPOKbIZa4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533409; c=relaxed/simple;
	bh=CF+yNQOkt4lcpGHZj3MsQNQ62kgwnfJ2Omn/GLEzfn8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZxleRDDdvu9p7DiHk1YclYTObfhzsHGOEG3QgUpBkhzDHNtflPTIYXwxTGpUXeu3rxHY8kEi8/IzxrKXYKC/w1vxCyEURjMGcBk4Eh33E0+VkleoDkrMOyFkryN3trR7aM7wsCrF5SN+6gZXXfNhUdVUvsWQs4SC/8WThFlTYNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QzjnYYIO; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qB8s1nRdZLsf0poTxK5Kf237/LW8aYw1eR1v5RC6vrdbcquiIqT1pgtMsgQ/jEl/iucz+Wade7dbNWMiaHvooFnGxlB9gaOS1Pq8rGtPF/oS8ws4v4urBlORvymvl9gjbr2W87N0YrFNDCKTH9mE+hJetzawfPEi5p7PW/XbFOI2ToxmCWHq/7eVErtCEFQ9gOtnQcM7nrqbxVEuv5VxODpZqHiijokCOrbgzeKdRH5227EWMRGtiZzYWXc9WvtAWKUUM4VVowTFVnr813K+/cJsDKGSq1261ACPtfqVoNmftDtHtabadFb3vL4FUKLCgNXXUIDtbCeMX21pioK1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tURDPu785uZhh/7v3v9HMCzOxvmmZ9eyQN+g7jNyZ4E=;
 b=Bjsifv8kyfjkSqAptVIPyKL/AEzcsg+RAxNY1G48mllUE3sCz/Vg/Q89clyTdlXvTv83FBCVqDCabjpOAia9NPx0fwW5PE8ZjZJmR2UtBhMBr63+KV6RI2e36tJ2uJTWww6oI9610ulZzO/oO4H1zrt8Z4ptnyv66cw/XEQqHyDSsf+7jJBeHLFat5Y8lRU3V8Api/FVhUjomeNwIxr5MKZOiwYrC0Y95RElpDUHENwxX8U1AtYoFZTAp0xx4mko5sFFM6mZb3RwvuE857miwZdQ6utkGvj7nkxFnBqVaY0M9HFCLs7KVJASIRA7hBWkEUaTGsdJOZ/zLVR47Isc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tURDPu785uZhh/7v3v9HMCzOxvmmZ9eyQN+g7jNyZ4E=;
 b=QzjnYYIO6CWuyKEJDLSxp5FyIkmC5EwWJNcGi0vd9GWegTU5hS435pGzJK8L1sIuhmZi1o/0ckTshicRjU/FFBGMrbcOyqAgmgLyL17stvT1Sxr1XtsD6QyDxWTBKwA165Mu/ZyEypfTt51OkpBx3HqAosTwcbiIAlvymvw4W9s=
Received: from MW4PR04CA0370.namprd04.prod.outlook.com (2603:10b6:303:81::15)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Mon, 21 Oct 2024 17:56:42 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::41) by MW4PR04CA0370.outlook.office365.com
 (2603:10b6:303:81::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 17:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 17:56:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 12:56:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE
 (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, Peter
 Zijlstra <peterz@infradead.org>, Li RongQing <lirongqing@baidu.com>, "open
 list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:AMD PSTATE DRIVER"
	<linux-pm@vger.kernel.org>
Subject: [PATCH 0/4] Adjustments for AMD heterogeneous designs
Date: Mon, 21 Oct 2024 12:55:05 -0500
Message-ID: <20241021175509.2079-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: a93d02a8-b6dd-4a36-aa66-08dcf1f9b81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NcRGiNEmxeF0wWsRLaZ92AdCVxXiWMx6HKeehb2KHIN2n8eVTjYM1cipwEq+?=
 =?us-ascii?Q?FCvAYvFHmySh0zT5BRRbuYrBYwGcnPBiUZEVGyx8oVNfRsw8uQZTR5mMxNQH?=
 =?us-ascii?Q?07BwnbyYt+hIILAdrTKvPfuzzDzLD9V/8sOUE2ngLnTISk32+VTE+PQKAgeB?=
 =?us-ascii?Q?cwq1QoeMk2IzP1gXiyT74rCTtkGK7NQ4+rC2I/mDzS8kGUWqvh0PQe031Af9?=
 =?us-ascii?Q?p7QIJYAdS7pxhaXX3FlgO8ynFXv5EzcUMO+JF20enjRX8geTmsq0Hw5E41dp?=
 =?us-ascii?Q?elZeuAC8mTais21sV3S4/+MxcMRa/Mfb1nGGTT6uhPo6FxxdHl/D4vEtQorv?=
 =?us-ascii?Q?z8VdQpY220ExvVhTAwBu09eErYqECzlsILfZ4iYLdhiuka7FDjlHPga87czh?=
 =?us-ascii?Q?4FYjbl3AQXh9HVfoLPN6TkZIGE1GH/k3/eNMT48Il+IF+ju7Odw+uCha4ff0?=
 =?us-ascii?Q?sOPP9xsCN94PNNYvdRuxt7iwUjB+MnqUcLaZv21OjgiG94Ea4Q3OLKDpmBME?=
 =?us-ascii?Q?0S3H0BnPtiKLuAncYvdP3xGzBgUP+MHzIHC/kQ9Dka6mOwOLfWaGIZZ+jIix?=
 =?us-ascii?Q?oK+e96sATgk6CdLfwY5pusO5fD03CBfG0cVXImkx5cRyRkB33+s7U2kU1c5v?=
 =?us-ascii?Q?YE2Bb4HzMFoIJCQ4+6F3NPy9gry5Zh7Asi4LiET2UdWLtx7xP1xReam3vk3p?=
 =?us-ascii?Q?skLmUsh4TiNFS0XRy2hAYMgMxO9cXEiVTRtPmhMujsK6vYXf779R+NWxFNAw?=
 =?us-ascii?Q?eqyrxpnN7tUDVXycmFfTOFbD1+y8h8KT2JK9egk0+dBPqPaxeqkmoKugVTed?=
 =?us-ascii?Q?yAEvm0RsZ+aP/xnEU3TDRfFjDpnybSRfQKXIy8X4ezRtSOP91NK97kO2q+EX?=
 =?us-ascii?Q?1hfi3jC5PUAuYHsdZtjthAZtUfCeyRhCaJHU5jc4z8ZAM3iDxoHn4RQMN011?=
 =?us-ascii?Q?ZOkjYWRAjXXZfWMAh9+g2Xp/PwfDHwi0Gz11inDV+z0bS1D6wRD+5RL0dfTe?=
 =?us-ascii?Q?o9TFreGX1XHnR7cjmUHGqI1uVndivWqivqa7NYrXiL97tsX4ZfZkZaOHy5pr?=
 =?us-ascii?Q?c3qtwpqOBNCi/gZT5WA20ZUZR0/ExBTaWgjaIwaNwhM2WMyQ0nc3NuDM230s?=
 =?us-ascii?Q?dS80cVR8tK1M52LdOGNYvQt4pl3X80ABzinFlpzLZdGUhc9hbugMtkixS+6P?=
 =?us-ascii?Q?ELU2ReHAQD31MdSydaUkYzonivyZcavRzt48hzxEZLrPCeHhP7aR7htrjmsO?=
 =?us-ascii?Q?11PXAk3kIJUE1tF3WhDSnQpScgQtc5K/DR18m1R4oijQJpucpfCWqm21iHri?=
 =?us-ascii?Q?Cc1vPTADsykopVFElV+3O6Fy8flrLzs1H5yT3XMFg4hCHLJ61KRez95tZT0G?=
 =?us-ascii?Q?o2+PZDZKQWMwUH3g7P4e/Wh7myMPfSTHdtSmolzeHk9G/x5GLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:56:41.7220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a93d02a8-b6dd-4a36-aa66-08dcf1f9b81f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256

This series corrects some of the patches that were already queued up for
linux-next and also enables some optimizations for AMD Ryzen AI processors.

This is based off superm1/linux.git linux-next branch and would intend
to merge through this tree with other amd-pstate changes.

Mario Limonciello (3):
  x86/cpufeatures: Rename X86_FEATURE_FAST_CPPC to have AMD prefix
  x86/cpufeatures: Rename X86_FEATURE_HETERO_CORE_TOPOLOGY to
    X86_FEATURE_AMD_HETEROGENEOUS_CORES
  x86/amd: Move AMD core type identification code

Perry Yuan (1):
  x86/cpu: Enable SD_ASYM_PACKING for PKG Domain on AMD Processors

 arch/x86/include/asm/cpufeatures.h       |  4 ++--
 arch/x86/include/asm/processor.h         | 15 +++++++--------
 arch/x86/kernel/acpi/cppc.c              |  2 +-
 arch/x86/kernel/cpu/amd.c                |  9 ++++-----
 arch/x86/kernel/cpu/scattered.c          |  4 ++--
 arch/x86/kernel/smpboot.c                |  5 +++--
 drivers/cpufreq/amd-pstate.c             |  2 +-
 tools/arch/x86/include/asm/cpufeatures.h |  2 +-
 8 files changed, 21 insertions(+), 22 deletions(-)

-- 
2.43.0


