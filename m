Return-Path: <linux-acpi+bounces-8896-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F5C9A9748
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 05:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28AF4B21A95
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 03:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F14E8003F;
	Tue, 22 Oct 2024 03:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YmcOhsBY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE824F1F2;
	Tue, 22 Oct 2024 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568820; cv=fail; b=a585ZrBB4iZplT6EDRdBwL54z7m/gt/Cl8dH/S7NiHyEXNdCzlb/9+QBoqnziJ+jfhW4yr/auRY1e8DrbCFfxs2giWydC62VMc1ZDXQ3q3s4bWnAPnBtEb64hA6+3RHlaRKo4U5xFw6tPJUidh+ukvu3EjaDqEFdq4cBCfk4Bng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568820; c=relaxed/simple;
	bh=vW61Zco01jlC/MINyf3bTohI7s+0pyLuYnulVqwgxhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sb7H0Z8gsqpYd19kOz7Joc7dKOaCn4NnpQE5Mrgt9ZGqS7c3yiO9MjI0L4DiZ3pNAKrk0UP3lmTSF4AdTpK80yUc6Rv5aMWSNncnQnwqI1oFLFr7BaugytJdUcsGYZCXWPgrk2esBRl22Ayc+B79rTyk3xW5SpN+k3lk8ZqbIeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YmcOhsBY; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XN5cKWN6UxrDbeSE55zLBvu/g0srTb1eLzuiONI1xY4/c7NRzt0P48GYruUfaDQDZL8O7foxqqCUsX7ecZb47bWfJHGZplrtOeuQj7qBf0nlDYSa5ty/Eg8UFjKXd0poLAlpP6K/vuGxOvw3o3gfMJjX2QW1vpaz/hgxIMkiMtQJdok9MkNvfSEkuTITbIgkYdDGrn13eQ5QS6Y+7KnrCtYdld2v1gYf9Cr4rp7Dg+GKEw9XXQxq59IWeg2FmSus1yKBZ0q4Z9EjiXFhRN8mxHhYiWAXe7ParWchAzfwr42MA+/UpAbq3+PfnMCmTR978CumRivQnClRhpU9xRL3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fO/QJf5z0U+k+l9lT2uFx3WjfSkwYagrkM0lmRVxfY=;
 b=ThdQlz17u0twORGbeglGs8DjbrSnx2fbXxtAPfj5WgyF7TMvFc+cythZ/H8ifsVXDnaRKHsBka1xDlX9OXjqrCH3LXXu4VMNXFNLjyk0TjloZm14T2f7VJPlnvvNCnBu266Cf6oIac43e9N0O3gO7J/JSUuJfOJLYqzYVMIYrsAVPu2nhzTmdTu0/WE8vSi53FzUubEVB9HOBpbZ9Zq8zukgTbA9NtVBwEwF5NVJW20lGCdPqmli9ag1L7V+JxCXgXdh/f1+5r2Gg4FYXEagXd/INsTi6pQ3m04+VFc0JjczfNneMGbtBluZoet8U38CJmN7wkHppHdaCzsqmmDhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fO/QJf5z0U+k+l9lT2uFx3WjfSkwYagrkM0lmRVxfY=;
 b=YmcOhsBYS4wR5hkh4CJ81DLOegGZj4LLEahrHnlV6MIbPYgxZWU7UXXzXk1vLp2+Gpf1TWUM8NrayX8bOh26hJiUfhuJ/JFWuuQPmfyuI3hhk8H3mstNK56ExTGJNuL4nPjoMRrMDDyUBZxo+UfNxhRjBSQLaXNluQNnLqR1SDk=
Received: from BL1PR13CA0210.namprd13.prod.outlook.com (2603:10b6:208:2be::35)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 03:46:54 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::8d) by BL1PR13CA0210.outlook.office365.com
 (2603:10b6:208:2be::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 03:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 03:46:53 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 22:46:51 -0500
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
Subject: [PATCH v2 3/5] x86/cpu: Enable SD_ASYM_PACKING for PKG Domain on AMD Processors
Date: Mon, 21 Oct 2024 22:46:06 -0500
Message-ID: <20241022034608.32396-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022034608.32396-1-mario.limonciello@amd.com>
References: <20241022034608.32396-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e07596-4f57-4dee-949c-08dcf24c2af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IaG9mqOcK67NECP6HgAEB3vgS/GYyrDdaJW6+cxtk/N50v+VAO9h3P2Pve91?=
 =?us-ascii?Q?VG/Fsb61EDdTIb/1lrlXZgLqtT52kKa+z6ggdh6G8+sz1FA7tEt29KgRI2n5?=
 =?us-ascii?Q?7Zutuw1GOwpxjfgT6DStsm45H64qfwzrddJQzqVXMpCPt9C/MNPydO0oaKvt?=
 =?us-ascii?Q?GLX2xU8Sg3W8j1ylMRetxmrusdWSXiM1dnVJMq/iH+vCLwWZOD3AYa2fQwNA?=
 =?us-ascii?Q?n/x0fu9cNnz68vlR7quNO2gOmCKMUlDkgqwyoHpDP9AM3qjROwCz134BKbF8?=
 =?us-ascii?Q?TRaRh9TwRy70DE4aftIUSR7Ucq4sRw7XTYzrBFXUrqYTF8mgVhDj5RcOZqbJ?=
 =?us-ascii?Q?n2OGKXKNU4zkFOiP023ANSV66gFmu/614dT/4h4i9m12txU1rgRjcTdoLV+G?=
 =?us-ascii?Q?X/fzADhPxESfSCuL3QUFIrLvGv20yWxm++6PvSP4I4+tOWMeryl/YmMH+CZR?=
 =?us-ascii?Q?TIMW2CTzNHJ7YPdBDmq7YEAt1T1l7Gtm/bnX77PprRF+YcZfTA+E4fK+nxDU?=
 =?us-ascii?Q?3m/hr1SPiC/XNsjjg4oYBTB026ZoGiYRYR5pN6bTZLjEKqzQKGnDBcLhLXp3?=
 =?us-ascii?Q?/iWmisgIVbadzTlxhKzrYfNJCyChT4yPf9ljRVP2RCfpsUlHooED9rSt/MDh?=
 =?us-ascii?Q?zgagk+j+GCLyN67iXWMCE+up5z2unh5a/pxDQzJvEYv6WNgFphwsJBHqlF52?=
 =?us-ascii?Q?vinPRSA2ImnEfB57f5bQhk0DEE+U4xTnXbzCmVIwVB3eBLHDV7d8v/8x+cfc?=
 =?us-ascii?Q?jBH21TT6T+AtAxmlzyigAmDbK0IHCmqBhI9RipWZlTYGxZlhWylw8YIuGFpP?=
 =?us-ascii?Q?ktb+E7qVqy/UxYFJE+TmU4Ywl+vjJA73UbSFNuC2N6A5KemKMuCDV2MWWcsB?=
 =?us-ascii?Q?Wx5Zlw5XapZkuo/lMNynhVi69/TcKraojrOm8HMndBmNNEqQ9ZmpcmDFlI6T?=
 =?us-ascii?Q?WpZAhxa5pKPCjzvvsf7TQTJQeYiKy0CiFdw+b94SKnMl0vTgGFDlMoRob4ho?=
 =?us-ascii?Q?ikvoPrAOHcXI0caB+JB5hhbXHfxkOHCExjIyNZyAaEMt8sAztDFhvq6cFCGr?=
 =?us-ascii?Q?SvhgJXx0tG0Ne5PQ72q+WH5wsV8dfvlUCfA8MCEMgvACdDWQdXN+9Mqd9nz+?=
 =?us-ascii?Q?xwVNJG4V9p90HOYPti60DGs/v/GS2Z4RGcVk1Su+kJohbrcIocuqFpl82Dxl?=
 =?us-ascii?Q?T3jbqlaaYZD43KrcLSGfK8epAdqtN1BB/4hKicVYQZpcCZO8OcW8H9mzPYV7?=
 =?us-ascii?Q?0AgyRwNsHSqcZJ4N61PfVjb8sMIZeY+WaIMJcppSxy3XrGPjt43b7lHc2MyM?=
 =?us-ascii?Q?hDYizVDI3RGqwAvCiNcEPyIMt3hvEtlPiiyXTQ+ApSwedg1d4L3RqEe8xork?=
 =?us-ascii?Q?1SQgAbnW4oFoVC4xyp0/jlJPz9k4b/i4c06tcqEPwSYIBmklTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 03:46:53.1578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e07596-4f57-4dee-949c-08dcf24c2af9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800

From: Perry Yuan <perry.yuan@amd.com>

Enable the SD_ASYM_PACKING domain flag for the PKG domain on AMD
heterogeneous processors.
This flag is beneficial for processors with one or more CCDs and
relies on x86_sched_itmt_flags().

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/smpboot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 766f092dab80b..b5a8f0891135b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -497,8 +497,9 @@ static int x86_cluster_flags(void)
 
 static int x86_die_flags(void)
 {
-	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-	       return x86_sched_itmt_flags();
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU) ||
+	    cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
+		return x86_sched_itmt_flags();
 
 	return 0;
 }
-- 
2.43.0


