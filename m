Return-Path: <linux-acpi+bounces-18616-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D5C3EC83
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 08:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777FA188D22A
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 07:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A215630C63D;
	Fri,  7 Nov 2025 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pds9+gcH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A830C62C;
	Fri,  7 Nov 2025 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501362; cv=fail; b=CdivlWanx7bzMKNXk51zHAO2/9SSdquYQYyJYcj8FGGApEAN2YMz+m2iDZCi7MANOWTlqM1hAXBJ6FE5ZO/8xMcNTHjmnP1XKR+YQaMqKBYFSWUy9rHFWx1jLqn6DnYf5tqFbsI3iD1Rv9qVPe8bbEvmC6k57NPK6m5lilFn8gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501362; c=relaxed/simple;
	bh=GFX4YnCsu87yV1eSlhHJtD5QlrWb7o73yuUInXCJz+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMydfNaNDxyi4mwY1AhADEAV/9t0ZY1evD/RYJI87KYUuOpsj5/3hO6sBFWB/V4w9gysYYvxRo2gtFTSXQ0bEztz5ipnLgwGDfldxpGodDQ2MNxLShbEpYB5m+cCopP6pwMiH158Uk7gtddVfVwzqf2yH9I5VlUV+V38Tv6vMyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pds9+gcH; arc=fail smtp.client-ip=40.93.196.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAZ0Zh2OXfPfolC6OZgqRgCbuuYJNhS2PBG6q2P+vVX8MlYIkAlt69ruhNVHDQufUZnTGWmxgus7+VhO9CowgFNc/7Fcjfi0942fkoI0s0DVAXKIbqzk2ho1dTU2S0mDmv/NaRVsGEQrRiMF7YgO/DCaXgeMaD9EOQmJy0RdNITEU4hIMWoaCIYIc74I9FQ4QR7Kycu0Fs/sqA2wmSwFPYHbUgKgK4Ki+8QrXpPgJ7aHCe8BiCH/JUta1Q+++ZtufJwCzJ0m8RndMK1mMP+gkZLHXvDcabFxRIwQmyymqm0JiAUv/XLsl3NaqWtC+a7IWL2A3FNh4MAmqZ5td5sUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDlz1tLA4MMIbsbUhrZfkp6OyiycsgMfjiZSRry11sU=;
 b=yiw8ZH67tNMXL5tPtCQaxk1kQgyOg/0/vSeKc8uZQiVGNEmn18oZhBEr5BT2twqkStiRcMRf1RJ5YR1gF69UNBbHPlLJTfIiUxIeXuB7QBVa1j/ue9VOGmc0lv11YZt3zLk1rCbef444iTmV5IguSxWYZKAHIxCVYqcQeqaeCycVymN+ryuvQ7RafhkRgaptnAy+msYe4IDjTGIyG7JlgovDUaq9Tsw8yNCYMvQ1lWK5ImuB8yY1OFKeJqHNIc9GaRTxInc7w55nGOyexf0WfKR4ZnnS9SeVZctR78IBmuftAgxrb3vE055SeAz4rNCdTD1nJfqvEm5Prwlhf34Wlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDlz1tLA4MMIbsbUhrZfkp6OyiycsgMfjiZSRry11sU=;
 b=pds9+gcHN+Q+PlL0o1trMVr5uzTBsLwRHClH8denCSMH+D6ze3pZ9Y28+UmiyF9ix2IkdWA8Od0MhvwotdcHQh/7xZ3diMS+OeDtp5BUYMzvtqSJEWDUjGjBamftLHjunM7HFcc3Ddx2tT3jsGzURKrWccyjQNpl1dAY+CfMhmM=
Received: from SN6PR2101CA0011.namprd21.prod.outlook.com
 (2603:10b6:805:106::21) by DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 07:42:34 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::63) by SN6PR2101CA0011.outlook.office365.com
 (2603:10b6:805:106::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.6 via Frontend Transport; Fri, 7
 Nov 2025 07:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 07:42:33 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 23:42:26 -0800
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui
	<cuiyunhui@bytedance.com>, Jeremy Linton <jeremy.linton@arm.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christopher
 Harris" <chris.harris79@gmail.com>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, "Mario Limonciello (AMD) (kernel.org)"
	<superm1@kernel.org>
Subject: [PATCH v2 1/5] ACPI: CPPC: Detect preferred core availability on online CPUs
Date: Fri, 7 Nov 2025 13:11:41 +0530
Message-ID: <20251107074145.2340-2-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107074145.2340-1-gautham.shenoy@amd.com>
References: <20251107074145.2340-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 9abbb735-1ceb-4490-eb99-08de1dd136c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h2wH/nsJZRz+sUaIv6eYG4eps4V6lVoYtFKcKepPCBfr9OtKdMfMmiCCtzR5?=
 =?us-ascii?Q?4aRgtoJu5zHiXwj9U8QNOacQjuNERPcXBRLWPU/K655Ir+xJsy/LOnxna0PG?=
 =?us-ascii?Q?LW1G+i7q1iXupO+q9X7ZYA6MvROY8tsjtxcSqQh6lgV4JS4fiyixRKLUYDMD?=
 =?us-ascii?Q?bWB7NhSLq+dMsgCLuuxU2H80/579AHaZYC1fEf1IteigTDW9LXLwfowV/2od?=
 =?us-ascii?Q?piQM2LzmpbLZuyVWbicM1kLcZWLzAHh3JCx2xXuqxRiS9/2N0E3pgYZBumTe?=
 =?us-ascii?Q?Cpb4HgHbcEmwrHMxSaCh4eP0xv013mMvnN+/ERh90a4/o3ajAkqu8BUaAy5L?=
 =?us-ascii?Q?83dYAsDqZKGr9LxLQRySW4m3uaa5RM3w5GRvWsNkN/phnVxjJWBzaLeZsDFd?=
 =?us-ascii?Q?dTCBakY05tOUc7wuFCY8sK3YdmE4M6SHrpCPof+9YBhUBcXqqGCNcFYYzXBi?=
 =?us-ascii?Q?1oLcXWwYwC0CPvj3C+JIGx+1AO86qN25tDcA6QhCX3KCZOFm2TwS2SjsGxJ7?=
 =?us-ascii?Q?kbQmVeW+ZQBc2zaGahdduNRJf+Opn7fgZ8mvDZc+MftA0qQ/kJrm6CMwo59p?=
 =?us-ascii?Q?F8He1UY5WDIDhSSxIIisQUATgQaTS3ta0C5N5cn4GDPwEFjgj+Ckl9zbqfFu?=
 =?us-ascii?Q?uPtsZS1rgKviAD7k12FYb+Ftfr2M6duQzmgqH7VuV8vLSqNq9QEMn+DOUFCh?=
 =?us-ascii?Q?sROhdrzpKL9YBl/YKFK91mvduIh+MKbUtjhMI7LluxYMDXKYnfRojq0kkajG?=
 =?us-ascii?Q?/n3B0UgNwiIi8MPPQzretCHJ0wkXVZPyi9equPHPr7otlAdMLioogV/UfkIj?=
 =?us-ascii?Q?WOSSeapFHCxpKK+Sj4rlg8TyZTHY+owCPWAiHBYs5YdZAWHxkcJtyX7SRNA9?=
 =?us-ascii?Q?fn0lVFSE7KT3FYAZCAfbhklDMGj/aqqsox62Y3jZtX3lRcbmbjUVY47ma9LP?=
 =?us-ascii?Q?HXlC90wJD0A78dmNsRtqaScRMu0fxkSex3I96dOeZcAiHsNrJPpQ62rwoiip?=
 =?us-ascii?Q?DzLi3K0Q8NaI3F5/SbqNiVgFGoFs3ddIGqTOFe3vLfR/Gv2hTzG9T7vzhZUi?=
 =?us-ascii?Q?sBJ1sDYQB1ll2F7X/M4HORv4tEOkcdD+r0Gw+JDxhsN561Higdv7Dm7PSi2Y?=
 =?us-ascii?Q?5sW9dK1atdlS2edzXB7Flw/0rq2jm8GZE4g16kr45WM1rq+/C/RvuSGzedMh?=
 =?us-ascii?Q?H3thLjk1zbc/lBrLc3gBmXBohbeUKgsBQUzFGjNmN7iC7O+uXGbhuM+fmWph?=
 =?us-ascii?Q?bfHFIyOVWpVaFbYvMyKhNrdL/sjz1tSCMxNdMXzR6DFpAS61r3soHVUgP++x?=
 =?us-ascii?Q?vmHri78ApZOUF4y43lr/Hh3f4AtaH1qobZAYYsTGK+mTSBohfwNQOCFzmAn7?=
 =?us-ascii?Q?RQ4gtojX5TsZgPK4SqQo/w4QD4qQFLoZgFaeQQHD5ZatWFA2RxLaRE/3P+eh?=
 =?us-ascii?Q?I/MzaEvmaqV4sI9WwNgIKncXs01YA4hYh+hhD6CwfJZ7cvllKibbVQ/VhGb9?=
 =?us-ascii?Q?qSRDbGvIlbk4zDZpjsaj7Q3mAH0D6bI/MDwZwpF1X28Y+Z3stZcG7U9e0TR7?=
 =?us-ascii?Q?jCRTg/5Dkj5iMuNWBNaPD1VimPYoVtnJjhgJzT9z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 07:42:33.6628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abbb735-1ceb-4490-eb99-08de1dd136c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140

Commit 279f838a61f9 ("x86/amd: Detect preferred cores in
amd_get_boost_ratio_numerator()") introduced the ability to detect the
preferred core on AMD platforms by checking if there at least two
distinct highest_perf values.

However, it uses for_each_present_cpu() to iterate through all the
CPUs in the platform, which is problematic when the kernel is booted
with "nosmt=force" commandline option.

Hence limit the search to only the online CPUs.

Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()")
Reported-by: Christopher Harris <chris.harris79@gmail.com>
Closes: https://lore.kernel.org/lkml/CAM+eXpdDT7KjLV0AxEwOLkSJ2QtrsvGvjA2cCHvt1d0k2_C4Cw@mail.gmail.com/
Reviewed-by: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Tested-by: Chrisopher Harris <chris.harris79@gmail.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 arch/x86/kernel/acpi/cppc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 7047124490f6..d7c8ef1e354d 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -196,7 +196,7 @@ int amd_detect_prefcore(bool *detected)
 		break;
 	}
 
-	for_each_present_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		u32 tmp;
 		int ret;
 
-- 
2.34.1


