Return-Path: <linux-acpi+bounces-8986-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7193D9B0B0C
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92871F21D21
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC60B21F4CB;
	Fri, 25 Oct 2024 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HbI5v2Ey"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7961FB8A9;
	Fri, 25 Oct 2024 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876546; cv=fail; b=uYbf5ct6GaCL+LZr48foaQ7DaugUlsxZzIqjPZKKkqmgymrVjujW9LKjCrzjIzGnIF/8XtsOhIVgU+Nt9i7B/89CgnZ5+Ck9BwQWO0jdpIEusGI6UL8qEi1UPVysBku/CUEacSOU8GRTiLOF2Ip7l3Zn6CkUAny4i7gP83fs9o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876546; c=relaxed/simple;
	bh=Plpaew6OcjYJ3boxDMwv3bLOAsi+CZaMGQTANUmHM5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrV5FLtNKMo2GSJ2pfRPepbddiJpMP0ls2fA1GbFc1oDrMmdgMez1UnHI4Bg9OLW4rFcdwtqZK/3cVsTASQF3nPxmHWHs8Uz9zTE8G5fNT1f1L7xiMt0uCGrZGZeqwi5c2+ed0oE46eq73tKuIDMsMs2JrT5sTvLn19ixlr1MSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HbI5v2Ey; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/vJW5mRtrlVdyFvL7jAkSFyqCNI0V28J+OVy0EUH9GfBTgT1Vgi8aNYraA7LI/FfE8uJ0M4ryDmgRNCs9ch8Psn6eFlQ5lhWnYNGefNdBo9/qTcU6rDvmPd52TwFBvEA4rvCsFJ2x1W2ARKq5XPBGUgaOrUwz6KTj4wcW9j8peC+w/a5s+4JL2nJ3nZchqvt8YcUMVs9adEsSCG7mgkT7YDirY5m/BLUCNHLVsCkvtWZq8Tic2I633zWzwjZW8Qk4siw3GXQNsrKskSE7POA1qqyErwI2FxlU2mnMDK16PxXNVJ4temJyQvopXn7cRKNPx/C+attc6O9UrdU+z5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUSFho06aSLaoMID3uGBG3sYCSv+5pvelFzxIkM5jSc=;
 b=e9NHcwoam1fr4iEPvSfnhom1gDhLpA0vjABzELz3ujTTziUV+4NIoBi2/qykCb9jSV1vmwYPhHeLbHLxl0Iw3bqqdhmYQzdJN97EdhyTUbCY/IoMd8NZ+qdC0Xpug4zjXFchkPlUN/59c6ySsIahMxMiPxeMN4a0aMfH1NAQdylN8qIZ5KmEkAAkBAFGpHmKDp5fnlhkkyQbfbdykoJfX4YZDRKJ5RL4RUXzdpybYvJkvX1fVfmvNFBx98vYsv8XLgwOaKgllSJMdVJqePUqSc0j0P593T1yzMDto6Dr/aJGhyLjFtgctYl+fXGwB9WZxfNXvxJ9nU5ViLrzEJ4QGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUSFho06aSLaoMID3uGBG3sYCSv+5pvelFzxIkM5jSc=;
 b=HbI5v2Eyh75rPr2hovx9ePg3b0czJZy1dQ41XeDJwB2GvYxSvXujI+QKDvz9zYfOGQmqIVVbyNPWFxlEuH382DTLFKYVRuHma/Rri/15xRevz5K9t3ZTHbAsxy4zpq9HI3soxKweJc11tRX5tQXFnOR4KFu6DNIF2WnkGLzBbC0=
Received: from BLAPR03CA0052.namprd03.prod.outlook.com (2603:10b6:208:32d::27)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 17:15:34 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::61) by BLAPR03CA0052.outlook.office365.com
 (2603:10b6:208:32d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Fri, 25 Oct 2024 17:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 17:15:34 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 12:15:31 -0500
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
Subject: [PATCH v4 3/5] x86/cpu: Enable SD_ASYM_PACKING for PKG Domain on AMD Processors
Date: Fri, 25 Oct 2024 12:14:57 -0500
Message-ID: <20241025171459.1093-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025171459.1093-1-mario.limonciello@amd.com>
References: <20241025171459.1093-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cdf1d2-22c6-4a89-9e3c-08dcf518a2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mv7VVXHJccPjnjXq2JGPPZVa+xHnwr5IQZen6UwJaGX3DUqSPM9Uuw75BW4Y?=
 =?us-ascii?Q?U86jqljok1cCUomRKWjyqznRCNsYGCsCAIuUbs8jLHnEJPDwdJelhx+psdBF?=
 =?us-ascii?Q?3BgzKsobv0NZYRk8dbCGq/fsl7QFAw0jDI48YNxNGeBfDnB7aOx2uMPkIc5y?=
 =?us-ascii?Q?U1h/5YCKHe1N1+13ewfbaSOYB/MKNpTUgs6T9azo4ImaCOMfH2PUEJFTl3QW?=
 =?us-ascii?Q?f4AU2MF0WPrjlOQ5+ZcZgo26akZa0UnCBOi8ecAQ95RGc8Q/jXLLei4+FyWf?=
 =?us-ascii?Q?kdJRLCJc3Ut5tJDkC/nh+HVQP+n+y7igndVCJtJ9r62W1GroowMx5Ph3KcGh?=
 =?us-ascii?Q?+Ym09XSBA+ap6CsZbAfe5nXJJQiwsDue6xJjMl0LzYKrs1zSlrO8A910lhFl?=
 =?us-ascii?Q?cjkM5r4UWmsixVGFsMs0OAoLxjhX0NN+oQDXmu/+bQdXo/qdpseV18dwVDQh?=
 =?us-ascii?Q?N1UZ7l14YTPp3rLWBFvVuBeQs1OiLivqhCb7XntZCxU/K0KCKNGbS2HwG+sC?=
 =?us-ascii?Q?M7RLTUcUWuhN5D4KKpZK3f4X125uW7QDNL/Bxgvy6wGWOuw92038xQwxVg7V?=
 =?us-ascii?Q?4OL95N5lDVefF7+1oAp+HxEJBLchrB385k9arMhFqZQwg3hcYTjQf3ZRfn48?=
 =?us-ascii?Q?jaalMVdFP3NeVv2CGKgmyGA2UxYkFZrGhjdgvMTca5ZIYzeA2lrxvLkna2WZ?=
 =?us-ascii?Q?mj02PnjjqxuXSSack5tsM+T8LwZStursxB5JnU76QC9xjCGVy+RBk0HYHx9F?=
 =?us-ascii?Q?L38Tqk9D/mB2Uso2r5LySJ+8eHNCUn7scRYJE1Gm1YgBp+JTz8S+R16qkWyD?=
 =?us-ascii?Q?oKNTu4nor7P4IRXq5s5hoJ1dsJt16lTVMlV186MnUuJGFB7aXcb4ekH86r1B?=
 =?us-ascii?Q?JY/+qHeV+vH7egt46hp0iD5DbZXQ4sySzX9zuyuDwj/YfNiHkPHcc7pQH+jB?=
 =?us-ascii?Q?1kvYDyabxwCaC6uo/wj+abbcZjq0iQOWJCHsw598Vxje1Z8WTRdHvxnp60NV?=
 =?us-ascii?Q?YCwlF4KRlwgtESiIwpOi/QexIZK4CzWgXnYU51qi3z7xdhVFQBUI5mHNctwB?=
 =?us-ascii?Q?MDbDQrJhe5bmQUKRTurqNOe0M6lt3fpewXYi8TqgS/YCVsuCi3cHhrkdIahL?=
 =?us-ascii?Q?OdBWaqYRyXY21krwIPrPNsIOdhdyqmAG4rTlNzU6eGuRSAwU7ovDejCWjJ5m?=
 =?us-ascii?Q?QUlxmtejytFPy0FWMcRSrw9N4vLr5bG548CdlJ//IvRK4AxXfyESrkxFdCES?=
 =?us-ascii?Q?W4gGC7iLN1hNpbeCpKJdnE51EH+uz0ITidbPEd8kK8SFDex7Bzp2fx0JYtXP?=
 =?us-ascii?Q?MCiw9kwqEmUdJIfuOnpHtN3PDygy6Tw+G6Px/yvyhDOX2SAw08ybwMO3T3fx?=
 =?us-ascii?Q?6xfTd0WA16yMgPN6DvbonQKqloWN+WWJ5zrc6CmhD9bN5jQd8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:15:34.1012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cdf1d2-22c6-4a89-9e3c-08dcf518a2f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807

From: Perry Yuan <perry.yuan@amd.com>

Enable the SD_ASYM_PACKING domain flag for the PKG domain on AMD
heterogeneous processors.
This flag is beneficial for processors with one or more CCDs and
relies on x86_sched_itmt_flags().

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Pick up tag
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


