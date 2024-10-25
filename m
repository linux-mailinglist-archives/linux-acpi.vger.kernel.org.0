Return-Path: <linux-acpi+bounces-8982-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96D59B0AFD
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D732879F7
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADE520D4FB;
	Fri, 25 Oct 2024 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bx59WvSH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A321FB89E;
	Fri, 25 Oct 2024 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876535; cv=fail; b=dsglHbT6Rn2bvBwbqW6jkECtjmmB1xuaQkjGP9cu6DDp+Jx0hwbjvR/0BBMjWYZXSwDDSRomYuUo3PBpbWt2lVtbppEje0BrL5QdSwoET5uCcfaSy2/FfOrLHLUYNPu4h8jGOTiGwDTZHfoBZKXii2d0aYUDszpUoj64NFtPugQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876535; c=relaxed/simple;
	bh=OD6pHqAMlDJpD8U6NH9qlKBuwIB22hB2aAYJJFsfSik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Idy0lh9qX5JMl3ZTfXmN1Q4MuC+esjN/aU2ap6tc332NqkYrLrVnXlZPDjqGfv60O2jiTK5A15Up1mhQfowsw8xg/7FbMrJE50oE+JriYIOtSb5XMNlti9Fk7Tl6hD3jyQb6k3Cw+26ijwZdaggyOWb9TRZhl6UHQC2cATuJJh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bx59WvSH; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wN74DcGVpINnka7BU37osVkE3GlwGXVWVjM5EYPwInAVcEXkNbvBsyVt2qKkqReQlQPUkY8/l6jZJqd/vOR2/aafNbHw/EBCVcxQkyCDa0cAvocb7cJNdzHFsUljtMdBaI50K+lWigTgaA2ZE/vsCDAHmW7N0oZ9ZZ7ZBwUHAJl2wQ/IUIRFhFBghc+nE18jmeC2dqax3I2y1Fj9dMc5NlEZJZ5SYPldNFUzqXK02ieS8jPf6blXzbwILFJcMN29H8P/PDTmyE0U1PF2RwJrvYytXxD1ONHtNLvvfocESy9rnYReoLBcP0Msu4DlGizzgGrdo5cYqRCt5cPznFlr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCrdbNXfdYJ4yCKLanQqQRve/Qr6AHivOLImiw7LaAI=;
 b=mBtscvLsz/ac7KR/brCR1xNiZT7+fw5KtCjSUtpQ2eQ0ByExbK2gwpQqSGjP2dtNg9asfIu+fuilws1oNIXEVo5WNIEsdgwfJu3nCKgE5KeMmcohpxqwc0wOBo5U4/yl4r6ArSp61QHuR+SYKZ3hnsgysf3W+2GTz/BL7pigofAne5UwxoOQszK2MPja68tv3YavI04wvlK1NfpfF7O7YFXtEwalzy1lzQgpNWieQBx7Q30mo1vijCt2DdSNgksfoqQmuBANjS0C7BDhErO+wKcF2zbVTV7DBMOJw8BZknCIQEztwsStCJJs/v2ZF+kt6NI4vc0LQhPkv1WF9YOfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCrdbNXfdYJ4yCKLanQqQRve/Qr6AHivOLImiw7LaAI=;
 b=Bx59WvSHYPzyZAGdork6ohftQX4GGST/2ybPmt9ceWgGvQZ5npq6cE+o45ILJszL2nmYUPW3as2+KIxvENhE7O55Fa8gEEXskvhccZa3flieuxOLZmW4L+RfrZpjdEfo0D2V4BNTSvoxieE3Y98TIhO8hORdYX9hLDmxjrgXf3k=
Received: from BN8PR04CA0044.namprd04.prod.outlook.com (2603:10b6:408:d4::18)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 17:15:28 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::c5) by BN8PR04CA0044.outlook.office365.com
 (2603:10b6:408:d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 17:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 17:15:27 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 12:15:25 -0500
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
Subject: [PATCH v4 0/5] x86 Heterogeneous design identification
Date: Fri, 25 Oct 2024 12:14:54 -0500
Message-ID: <20241025171459.1093-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 771e828c-3ae1-4c0a-1e79-08dcf5189ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ORpsIkRCYid6qa3bTCwf6H7PUsexHfIGj0fGVId+7W/vph7degN6IZVf5wsc?=
 =?us-ascii?Q?l8QF7kP66LnQLOCYbv6sgiV0ryRSTB5mHoYgXE8b96WdCLH5Pt3o6Kx3txk8?=
 =?us-ascii?Q?coKQZadAt09DAtV8LEL7z+llwofB5HBZQgPZheTqJNNwvUp/tOJOSoF36EL/?=
 =?us-ascii?Q?hUSk67vu7KsdoE4VfW2+t5lbvqF5VwLw/ViLzKst9J272JCSEtw46ab+EwWb?=
 =?us-ascii?Q?KlbOmA0n39IpxnlZpqhWj5q10BFWMpdOmoG3/3Ayaw4DtPdhoxleZA2K7dPg?=
 =?us-ascii?Q?RTeMbYkrAxYoxW+wHF2K3RAfMThWwEO9ZdpXxvLzQtf0KbRSKlR0dmtrVXFg?=
 =?us-ascii?Q?uvYaU1v0wau92VjoX4bJfjo95G3r05t5sOCyuxk+WxqvH2E2cLodhia31U2p?=
 =?us-ascii?Q?9X7ZsTQ5JBT9sXREbwTHMEgP9hSKJOopzE4knY1/MNKrimwjihEIHNxO6dY2?=
 =?us-ascii?Q?bex2auvIleg0UA+rz7rtZphSNIy6ue7OVzp5Ks4LwcWm5lrK8+X+EjYBux2O?=
 =?us-ascii?Q?mQoPcE6VHv2RKIS7zqYi2xAPAjj1VAMWQJ00vi5VatOAojsyylsAxCPvL3lW?=
 =?us-ascii?Q?t/hopaHgW8k8BDATBERJ7VsouRZID1xSEEs0Xm909Ajva3uzQaFwpE7iLdp9?=
 =?us-ascii?Q?tBM0WoZ89qbve/eaXYurjFKRpnjS822P+ou7VqtnUuWu+fusbjb2TJxQeFhL?=
 =?us-ascii?Q?+01Pcdl1MrV4RmkPz2SvIb3vxdqZlr/CH9NHm+DrpYltfslA/EDrMjgjVhlr?=
 =?us-ascii?Q?ki2t2sUKrbLKwcmbKk2KYQw1HVE60YJXOjKaGpWz0NXmQMCS8N+Mue1O+G7F?=
 =?us-ascii?Q?kjnnmvcQ30AIVrAc7Eg88QZPoCA5wcpFFceS8fhmeNR64JXoR/3bKbXfjOqb?=
 =?us-ascii?Q?5nnRiI+l2pP1l4/ptGmXeoQXyBqmCmseaRcf7U0HLNq24ZIXtPTm37K77To0?=
 =?us-ascii?Q?GrxbwFMkGCkheXRilhovzzUq/O9Fx2Mpscre7lUKwRtpIT4WrdHfd8FcUywG?=
 =?us-ascii?Q?gfvN1EcFDBBnosCiQkDASPSI3AJk3U536FPaQTOsKs5rMVHxWo2r3IPWL6mM?=
 =?us-ascii?Q?K75VJ+LZebIqDrazmzDa7oEYRjgmls0v9k8Mnewk/v9kLmLRCpJNuw0c1JY0?=
 =?us-ascii?Q?tcvC6qWgvunaWGHw3i6nYK/zK0QlpRmGl6f7c9NHuQ0PIQgaS0E1GA44JhCZ?=
 =?us-ascii?Q?oeMY6v0G2eP1fG5fcxQDCmblLXGSF7/Ogu9zyUs8eHmewA7OuI/2kxcc5b7p?=
 =?us-ascii?Q?pQIyMdwphh2G/8AkRLnc7U38V9aKL54Ozhj2fIF9BtPSle9281oaVi8yQ3Wp?=
 =?us-ascii?Q?vLIBuMLwnxqBwmKnjJ0r1/CsTs9OLHmZzkT3P2ws7uMTz1pbbzy2nEn1BhVN?=
 =?us-ascii?Q?kMOukvBqynVQYYXM9a1h24XmWFYJgvmibrkN1jk8gcic3hG832MIzizh1rUA?=
 =?us-ascii?Q?dytDfjKve2E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:15:27.2847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 771e828c-3ae1-4c0a-1e79-08dcf5189ee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864

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

v3->v4:
 * Fixes from M/L feedback.
 * Pick up tags
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


