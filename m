Return-Path: <linux-acpi+bounces-8893-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8D09A973E
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 05:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D00B2833EA
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 03:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21E546BA;
	Tue, 22 Oct 2024 03:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vCE99R9F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2371B2581;
	Tue, 22 Oct 2024 03:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568791; cv=fail; b=UROrd3ozcL3uuUlHxhuulcgEvuVPbyN+BiWo0aKqxibWd7Boz6qFGH/DDq2lRyNhX2//eeJoy6E4sIGBG3oOrPTvfWQX+58J7j2QUpWJlwDaRMm7jYibT/tCVNsy2zDOjr9gr/5iuLcUp7pBqzdhV7SC+z8Zxu7Bjn8sGqAg8VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568791; c=relaxed/simple;
	bh=l22w2kSglp3ch7wFsqXfWVnD2jc+PoMuACtSqZBMxdE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FRpCE6/fPEK6KL/+b2jP5EC6KO0SnQv3njjNUlyjSIfsl+LaahEA/s65YYZBiiWQ15CP5uNpOca3RpXTHhlQtEhKr0D1b5aB5u9YOw4mWP5TO6hcg9gaCnztZ3gxVNz0JGKE+90FZs7m1kkhx/dCGw8xSXjGqP9aJVagnfBH4HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vCE99R9F; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1guP2rYY+Kiem32c7JKZscVEjfPona1z0KzyCTNXEJKJUbO1hvE84j9R52GpXTXPeHUX+898x2MW/L182HD8R2vRRbfc5QR9EBycawulVE6892pufD7ul2NbS6hhCPs5VhWqJE+hL0gEVvaf19i2LfGxTkBPZRH5sNIpvEWlemXjuQv0BBbyZ5awjfCCcAaaRQyA7W2hAJFNviKFWodFu/Ol5807HHevdG8BZAgxlQDHUKSilocbyK9PtLBr/3hadKgsxXcIBn/04WbAHcU6Rd7YxNFdfyeusigLBN2uAs06XUJVm3jOndJwdBXvCbkXEWxNu2wiC1piM+VQslRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JZbHk/BSxEEh78BAuGPu0BHtaSMKwv5BqhvmQo7tY0=;
 b=n4n9UMjsh+sgEFF1kOm2LCd2okmviaOsAqhAfMFPeeQIwK6V4UTCT/fRlQoTDgje7CUsjcNP3cUc5/oGuHM5Jzk4U89oLz9zH0OiQ/QjFfw0/B0e65vS2xwBhkIMxZeMquO5XqboqemKx1sSSeULyqH8/PcHQhS27sW2PpxbqttBCuWt4adCwk9ArQUc8dbdWgB/5UurKQJPknPyZGfv/yOeiTadWA04kAKqgalEF+dnNzaPLO/HEw9QauwYlk9wmEp1Rf+ECS4TigWGxqIu/TsdBD1lOJW5Bvx29odv1Gh40DDATZi+xg4yNVbOp3m2VT9KwLk6tabHivq8/kvKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JZbHk/BSxEEh78BAuGPu0BHtaSMKwv5BqhvmQo7tY0=;
 b=vCE99R9Fue6rgdgve4Fe2oNpiW7CV73LuCiehcPLH25V3XuvkrFGz9255w17BE4eymzaJlmz8HSpNht//f5gyufNOEd1Vb2QylhgxwCr7TtBmqlwvyH7+mMOL47i2mwgIT800xAUk4zEZBuXkYibqvBmXplbqfAX7lHz07vmREg=
Received: from BN1PR14CA0030.namprd14.prod.outlook.com (2603:10b6:408:e3::35)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 03:46:27 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::6b) by BN1PR14CA0030.outlook.office365.com
 (2603:10b6:408:e3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 03:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 03:46:26 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 22:46:25 -0500
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
Subject: [PATCH v2 0/5] x86 Heterogeneous design identification
Date: Mon, 21 Oct 2024 22:46:03 -0500
Message-ID: <20241022034608.32396-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 347824ec-0c25-4679-985c-08dcf24c1b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?De6FUeMpuei52HIL/pQSgP/KxKN/hTytbdVJpejbn4d02T6jZhCO6l1xf9C6?=
 =?us-ascii?Q?Q7fAIpWls3YpvVEjyiROFEupDoK0aB5VcN0YfcJmQeQUmTI/qkWjiiUoUeZI?=
 =?us-ascii?Q?vkCnHG7SvRgNSo5qsciV34mRJQylLLpB3MQlmNWXDns8k+AD9QrHZYiH7PpA?=
 =?us-ascii?Q?sryUBaIoMiYvbtqJ56icvZl5kSprYy0Dd6CRDARXmQUf4+6T0Hb3pH7e+01i?=
 =?us-ascii?Q?Wsj34BcRtS87UbCXudHaMVP/sxIwxiqSMWLxc+SuEeusCRKjcTWOYwalJ6WX?=
 =?us-ascii?Q?95tJcAyOAa6uAKy1jDduZ7BqM2N/Jw2IjICZUOpzdZ7YR04LqVFqM07r0yo6?=
 =?us-ascii?Q?8wY2bbkkDJZLfaC4yT8kvCc0zGrSTplYlEuH/rlFUj9Ykcn0MUEx9m8LRlo2?=
 =?us-ascii?Q?xbWQtQpm41QxslbHSNSRmzLURbsmxgFvOtxsxkH95T4Vu2CACdhxqESENADu?=
 =?us-ascii?Q?l9g4Y0OGME655cZXyozKG9l1pKuWQIM3MeljB8k2DMS9rB++6U7N394xxNdb?=
 =?us-ascii?Q?eV1DwcwCtciQH0/Z/2KNAdYRHW+hsRWj+abPwxnXY/7MUVqkvlLxp9ih24nI?=
 =?us-ascii?Q?ags/8kplhrgr5JNMm4lnDph+FhjlspqOaRLQh0i5TJCqSMJHw0zoa+mNg+p+?=
 =?us-ascii?Q?OlaE8k39hHuVV92EreXHScSrAF0bS/flymaE5wQyNhqfQ28/9XN2FIOYCGG7?=
 =?us-ascii?Q?vyS5CrrUN8M8ZUm9ybBgAIBk2iGdCA2UCqoivYNCtNYyTskn/tnctpuwQKe+?=
 =?us-ascii?Q?dCpQjdcUUims3rwkq1kZ7HayHbbjfKvFyjIM2EGLWu/udGGXBKwkKQ5faaI4?=
 =?us-ascii?Q?4k5XcRgim0CXv/3eND1dZpw+R+46fe2Uitgx1a+tcXZJDxI2FOPTKDzfcgyU?=
 =?us-ascii?Q?ZubGEl5YGo1YWtWW9BEeEyGUUaIt1ToNjR1kCm6/hVGXjDYYC/zrltArNPpy?=
 =?us-ascii?Q?Bms41QFXyYmya8P6FmrAfwa/vTYmNMxyI5nuOMJkljacPlQxmTMRAZ+bBI/w?=
 =?us-ascii?Q?tHZJq1RNczzbHjosOj1N3ky8yRtJjUh1SY+27x0QSWw2ELdnhXCgqAQjs7LU?=
 =?us-ascii?Q?hS1FxMtofP5BXToxVTSC/tsppGiZ0QVu1pDnGeHq3ZwajBxCH2R1gDBZrKTQ?=
 =?us-ascii?Q?XSgFD5jYA4o3B3deYcfI4R0DFynEMywtFkfsQoq+TVdXBg3NF6lncIbET7Hd?=
 =?us-ascii?Q?GT9YkxjKK/uuZmQvcAYDy1BRYpG4SEBqmLcQTrGrbegdl4g2pun0Wxti5SPj?=
 =?us-ascii?Q?zjgogW2NJSEkV3rQf6XLKNS77TcYHPFXWq8LfrA8ixD8/o8a4P8NGCQExgqa?=
 =?us-ascii?Q?xD8tPKPCUCK/zHo2KJzJuWCZOQNwg8hAVeYpo1fhaSd9vZjeUADG9UomzdRD?=
 =?us-ascii?Q?tT2u0NQx4wOlde7Gd+37ZMgzLC4bIjdHuANeY6c7Z9z6NVWGxREbryXMJRbZ?=
 =?us-ascii?Q?zXnJsGJHcLg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 03:46:26.6093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 347824ec-0c25-4679-985c-08dcf24c1b26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578

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

Mario Limonciello (2):
  x86/cpufeatures: Rename X86_FEATURE_FAST_CPPC to have AMD prefix
  x86/amd: Use heterogeneous core topology for identifying boost
    numerator

Pawan Gupta (1):
  x86/cpu: Add CPU type to struct cpuinfo_topology

Perry Yuan (2):
  x86/cpufeatures: Add feature bits for AMD heterogeneous processor
  x86/cpu: Enable SD_ASYM_PACKING for PKG Domain on AMD Processors

 arch/x86/include/asm/cpu.h               | 19 +++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h       |  3 ++-
 arch/x86/include/asm/processor.h         | 18 ++++++++++++++++++
 arch/x86/include/asm/topology.h          |  8 ++++++++
 arch/x86/kernel/acpi/cppc.c              | 23 +++++++++++++++++++++++
 arch/x86/kernel/cpu/amd.c                | 14 ++++++++++++++
 arch/x86/kernel/cpu/debugfs.c            |  1 +
 arch/x86/kernel/cpu/intel.c              | 18 ++++++++++++++++++
 arch/x86/kernel/cpu/scattered.c          |  3 ++-
 arch/x86/kernel/cpu/topology_amd.c       |  3 +++
 arch/x86/kernel/cpu/topology_common.c    | 13 +++++++++++++
 arch/x86/kernel/smpboot.c                |  5 +++--
 drivers/cpufreq/amd-pstate.c             |  2 +-
 tools/arch/x86/include/asm/cpufeatures.h |  2 +-
 14 files changed, 126 insertions(+), 6 deletions(-)


base-commit: 21f0d4005e7eb71b95cf6b55041fd525bdb11c1f
-- 
2.43.0


