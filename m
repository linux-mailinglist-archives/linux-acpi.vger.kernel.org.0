Return-Path: <linux-acpi+bounces-8937-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840569AD315
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 19:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0943F1F214D7
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D13A1D07AA;
	Wed, 23 Oct 2024 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L3QlbsTY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45741D0175;
	Wed, 23 Oct 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705489; cv=fail; b=OTj3kSPXEOBliROuMQmjvbQ6jTtf/0UDL1vwRUpJXXei0GWNumtzSGWge+U2aVsvnrl++04dEuKZsZpp7UAgds0ntmPxDjG5J0LWHkM/idDMhh7fq7g7g8crhtrIpbzQFGIM08N76nTj/D+cmgBNy4WzVvVvxD5LpANOnA7ypvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705489; c=relaxed/simple;
	bh=iPeED/xiItX0aEfMtqUf9jG7ENSAgp4e1giO+JX6UgQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ccYbNwImilPs/Q/BPjrTcGuufqBeu2r5iPmovbp6MhXvzXMMHrj7ewGjKw9DvldDVUq/EmVO6FtNfKgoCwHnRWoUESdqZRSNCFMvkhi1rcTIkgTQpf4+C1fVaQnPEqEJRGM68V5bP6B1soPu5Lqhida6J1GBIeaIr7EK7vcKVpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L3QlbsTY; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5SUP3bovmyEoyAq51aryx2Y5rz9QVZpB2kcUagdLRj5z0qFDKt/8cHDrJVLje5W8roDLfnVq3vA7qUAZtl2gwKvKTY6YXVZpGWftVTMTEUF/VSgbhlfbf4oFAgdsKtsDusjpiC86R21WG6h4/tcl58+LdpSC62mzcjUwztXVWiDceU+cnlzmGBnZLLREBPHbkWSxB/jpuLdX5gv9zzWXhiVQeOG77fTEaU9VZ0okHjLiFj/29C59XQ5nxVLnX4J27/hnoS9AuBcNClTU6AsubzibYLRSZKAnkyY5uOIO2SJtyxgvjLo0VoAVgr27wwHorPRn4vuh2tBj+8kafclJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWj318giMEwg6/i+EwTjvVX3/jvcyuA3hPKBLeRWPHs=;
 b=y/GagYJprKezLM6AQCnlNw2LCDZQ/+o0rurrVfQuS2h6m1g35vxZ1fua9zGbCil6gnORcsM9tko4g2SOV5mqoLFL/yZfsihWftC2ixcZH5p0Eb7HaLs/nVkVGxMg/b2ISrJpSKu0crdGUrdITbvHkbABQIEIhsJh+morCOx2EOc3UqiDy1CofwzqrR+G6GdyViX/PCIQpw9Vh4Bv3/YHp7nYB0qkw/rDEAxvprGC30/qhe/3NE/GszqDbPRlX30ISazWJyJP1NghBhWdJrZ5LwGgo99nipPvu6/uM6EC1g+dQ0OHpfOruncLGSrxRplR0lXiOwIFPkBH56RrI5XhNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWj318giMEwg6/i+EwTjvVX3/jvcyuA3hPKBLeRWPHs=;
 b=L3QlbsTYIOuByqqs0DeFgDusGINnZ6Njk/E+rkuzdLzHO2mtTHnre8Nb9J2v2w+jHGJ0rsP/s4U+Vjb2DJ2Gti7D2qcrbyOvOpyUCIHV8uP+OXwTdZgJPe/KyhXOfY/iNlbVas83z7JUnl00vLd1FiHinYaqt4fdkgB6NhECa/s=
Received: from DS7PR06CA0014.namprd06.prod.outlook.com (2603:10b6:8:2a::11) by
 IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Wed, 23 Oct
 2024 17:44:39 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::ba) by DS7PR06CA0014.outlook.office365.com
 (2603:10b6:8:2a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Wed, 23 Oct 2024 17:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:44:36 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:44:34 -0500
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
	<linux-pm@vger.kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v3 0/5] x86 Heterogeneous design identification
Date: Wed, 23 Oct 2024 12:43:52 -0500
Message-ID: <20241023174357.34338-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fa4db0-7da1-48d7-f091-08dcf38a5cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZUQAnYyEiCr4EYrfZeI4MhBBplRB+7ebtbcMV2cZ/XywLSaagphTqoRLeUGr?=
 =?us-ascii?Q?5xGPhgctJwO4vQgu+yvs+nqHwloP7Nvfw3sP5p3Yew/LMm7B51q4bom5c8QG?=
 =?us-ascii?Q?FQlemSME0nl/n/DesvsB0MZaurawqOt1ePEYgywqqckJuFrz07akfLaKUZz5?=
 =?us-ascii?Q?ZWHJUAHPSOWR4B7lrt1wkVK8mJK3Wv4OjwaYl8A4iSlykr8UdlRTcNECx21J?=
 =?us-ascii?Q?rTmNRUpR6eSGEXEyZTyamkO1ORiZb7cltG6aT2X6SsV0Ls13O15onQt+95HA?=
 =?us-ascii?Q?2X2f3HhzWqC87gvFq6ayobg5hev+vkAX+GUn4Cif8IXG1iG7Fp2NZ/7sO5O9?=
 =?us-ascii?Q?qPkqxaxw0bPxe/R4Vh/2ElbGNrGfIvVNfA1tse50IpwwJw+P64TF71k365/0?=
 =?us-ascii?Q?DfX2ZajZA7+cTU+bq6B3ON8mkZYPm3/wrRsTkXpL2T6c91yfwVM6A5zip+0f?=
 =?us-ascii?Q?C6kbSdtOxuidLGAOKe4HZIrPRZqjg6dXoXbU5UHCkNFS348WtOOjxaCjyHzX?=
 =?us-ascii?Q?BVbEl4UIEHFHuasnImG9egB48YuWaTR/5tPxhex4vJS4lOtpW2V09ZfGCh7M?=
 =?us-ascii?Q?HDJ78LAbKPRpw1VPI6t55WZ9aRuK55HflhPr6468zIrPEQFebSLESOwv26pc?=
 =?us-ascii?Q?IGt3wpJhwgljXn8nd12QRGnrkYaFz79t26fr6GV40NRLzXPHpINzxEVNORT2?=
 =?us-ascii?Q?cqMqU+B4LV/1gAhCZAGLbYgfqMn3Izlwr//mIsD/BWB3X1NlimOyAvjzWHUD?=
 =?us-ascii?Q?prJ8eNXhRZliQxAQ2JEltRWLw1vcoPafeCe4Na9ZOxBFKpyg8f4y1V24JUN8?=
 =?us-ascii?Q?IJY9nC/lUGYrcsk2zR9K2Zak1sjrSg7p00eZX+iWzOer7+dUe1RkmRtIu03l?=
 =?us-ascii?Q?cWF6umBg18gdV/IZcy37yPROzwNN9HqBbtV1z+I4dd8pInyPf+ToB2EdIikc?=
 =?us-ascii?Q?1xuOzH9s2rF7XQ707GXFX7m8EbxPxEdVJLBGQEff/jTtYCioLReG71xwmxpI?=
 =?us-ascii?Q?B96WDluEIx3g7X+uv9s8JaBX24FJllW4L08gwBf+UTkB1bAkc1KfA1QBLlDP?=
 =?us-ascii?Q?QKQY1rkq2DlkSqFKHHS5RQFl5SoLKPJ4LWyrOoQ4SF05WXqkQvRWpwGX7upz?=
 =?us-ascii?Q?hneh2gmRuMh+ajMNHvbebqa3KCwk3xGaU1bE3wqrH04KoAS6PTQfCSppdYyR?=
 =?us-ascii?Q?6vEeBBOayLKbg4OC1Oqh8lLYJt6UVZSk7Mx+z/4ibpbnyEx09OMBJW/453A7?=
 =?us-ascii?Q?cWKAAw/gJgQCXBNlbQhSC2IjpjJG/vSwok6CM5BCin3K9SNnKO5UfgbsYScO?=
 =?us-ascii?Q?n44MdZ3l8SNBzU+53Y25Bb3pYmSsXP9N60n3NqdCV+wgwHJel2ghcQDQrUpA?=
 =?us-ascii?Q?SwXh8eIN7TcKX0wCgXxv+p7Wd2kpAoat9tPKgeRiwEivlvK84xOuJgxtcIK7?=
 =?us-ascii?Q?v7qblVCpFDo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:44:36.8771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fa4db0-7da1-48d7-f091-08dcf38a5cf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748

This series adds topology identification for Intel and AMD processors and
uses this identification in the AMD CPPC code to identify the boost
numerator.

This series was previously submitted as [1], but this was based on some
patches in linux-pm/linux-next that will be dropped.

Instead the series is now based on tip/master.

This also pulls one patch from Pawan's series [2] and adjusts it for all
feedback while adding AMD support at the same time.

[1] https://lore.kernel.org/all/20241021175509.2079-5-mario.limonciello@amd.com/T/
[2] https://lore.kernel.org/all/20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com/

v2->v3:
 * Adjustments on Pawan's patch from M/L feedback.

Mario Limonciello (2):
  x86/cpufeatures: Rename X86_FEATURE_FAST_CPPC to have AMD prefix
  x86/amd: Use heterogeneous core topology for identifying boost
    numerator

Pawan Gupta (1):
  x86/cpu: Add CPU type to struct cpuinfo_topology

Perry Yuan (2):
  x86/cpufeatures: Add feature bits for AMD heterogeneous processor
  x86/cpu: Enable SD_ASYM_PACKING for PKG Domain on AMD Processors

 arch/x86/include/asm/cpufeatures.h       |  3 ++-
 arch/x86/include/asm/intel-family.h      |  6 +++++
 arch/x86/include/asm/processor.h         | 18 +++++++++++++
 arch/x86/include/asm/topology.h          |  9 +++++++
 arch/x86/kernel/acpi/cppc.c              | 23 ++++++++++++++++
 arch/x86/kernel/cpu/debugfs.c            |  1 +
 arch/x86/kernel/cpu/scattered.c          |  3 ++-
 arch/x86/kernel/cpu/topology_amd.c       |  3 +++
 arch/x86/kernel/cpu/topology_common.c    | 34 ++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c                |  5 ++--
 drivers/cpufreq/amd-pstate.c             |  2 +-
 tools/arch/x86/include/asm/cpufeatures.h |  2 +-
 12 files changed, 103 insertions(+), 6 deletions(-)


base-commit: 21f0d4005e7eb71b95cf6b55041fd525bdb11c1f
-- 
2.43.0


