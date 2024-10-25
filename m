Return-Path: <linux-acpi+bounces-8984-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2809B0B03
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A871F261BC
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B350E21E63A;
	Fri, 25 Oct 2024 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nyf93PZW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8884E21E621;
	Fri, 25 Oct 2024 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876539; cv=fail; b=MO/iSZ8+9eIKMqEQF07grft+5H8otDB9+aZ0yDHJ2CWKf0dE3HQaCawUnUSCuVH8niyUXeTjpWvi3B64yYdcYuAaUNoSI2barPxSHqAss+tWqAbfNvbnWQZQItmHVnHVCwfDCCwPGMD3yZ3/QOjva5BWniSjWQol5E8A62oh9p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876539; c=relaxed/simple;
	bh=jJOLSzkvfP7p+b855UfbCFJoiHhCs8fMRL0tZBRLgZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuQQcrT7rXIYRdYVvMEjNPbEuTEiBrHKMoPM+rwX0NcVR2nvHnwaZL4AIV0spf2Rkb+ohF9dCJxM+LleVPcPeiEoseWq90G+fYP/KXCZ1Xr61VrumGxCue89RczGnk5WG5n0wvcHS2uPRip18ipQTTT5+XJYXYXWjLi++S6GFHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nyf93PZW; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jak2zEfOTkE+y5js23qvcZpRUUzNhqpv2e2gJdD2t257klddMb/Kh3qCWv8CtGklo5qA1kiCNjSnTk7MFuPmAQQSrq+twb1owAQ4iUYzI807/ZOOx2hWBxJLnr1liBKYBryBK4aL8VjEfnImwXe5HjeDwsBj/7jo6AZ1AkmB5gEgOIZbo86b0zNtcI6z062NXtxuCh4aOyrNFrLPqAhNOOo7Xy4LMiSo3DI3fzECmUTnRIoLaSvSMBZYZOv8RkKyud2B5K9qgX7K/wcbpPfVUssGhF3Wt1A9pzlaJhvtRqsPXv/CeclabQ70jY4cr79cGB1F/BBStYmjgM7qQa0UkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDBw8le5kBLx+UpjItK4zlvcDmURMDII5ktiQNH5RNs=;
 b=l8mAmVPmvtJWC/ZSW0l1nNFiRT4qMTtlaSlMhuR/sqwWVzl96KrLdox8qikYFDCbM5n0SCV7H4UaiM4vblValrfJRLA1RoyTwC+Gm3eNJbODpCynFkfSN2GB+ovXiFTNUC+mM696XWJdvreJ8gFNDNur7rR7fMonE6QHwkzml1a/JjysETP8X4Ou8kxgdm5Eixwc3uFwSB6l/JEiwWsrwFOVu2k5K0GLLBQ8Kq+LJbhbnNntHaYjW5Bxi6wxCNqFEJEWAZlRY/w+ONeEbhMeiE0sIRRi9d4nzfDwK2Q3e4H3g6hBzHCh5N3lz1SyJ2MNqPzdY8+VY/rYZ3B5KNhGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDBw8le5kBLx+UpjItK4zlvcDmURMDII5ktiQNH5RNs=;
 b=nyf93PZWcW2ZikuB51ysgXzIYIJZJltgB658/lcchAk/XBNjoQvebgJBjaiblnQMexDIEdBJr/2iHK9jSl2fQjzljIrSk3kpyNyTyWYjsxKO7TBPsFrbSa+dL8IE5I6X7HwyNrHINxkm5M3YFaw2ULaeIj2OV6GwjzMbPNuah0w=
Received: from MN0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:208:530::35)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 17:15:32 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:530:cafe::6a) by MN0PR02CA0017.outlook.office365.com
 (2603:10b6:208:530::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 17:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 17:15:31 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 12:15:29 -0500
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
Subject: [PATCH v4 2/5] x86/cpufeatures: Add feature bits for AMD heterogeneous processor
Date: Fri, 25 Oct 2024 12:14:56 -0500
Message-ID: <20241025171459.1093-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SN7PR12MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 291f8b33-edf5-4402-3460-08dcf518a15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JlI2/TJkQiymZ/FbfGqp9hm1vYODEYwans8YuBRXuOLP4pBykHYxNHq2L4Ae?=
 =?us-ascii?Q?Da1l3OOwDV7/SYCu8lBqopfn4NlCpX+QcJRuplcBHjyfS6WgUKB5V7swbTUL?=
 =?us-ascii?Q?NsOCmppY+HKIoz6rq6SGODLK1xU1iqbK6uGZLEZzHnLj6lnnjTnvLtwLyv+t?=
 =?us-ascii?Q?XuJETP/COMA3ywtAkROrvVH1qqcmpcflzhaMnutdNIHXfwWDwvFNBsxdeMar?=
 =?us-ascii?Q?d1UnVHXgKlPInSqwxbjA83d775dapVJv/0d5y6RnOVB/md0dUDiQ2m4Obfkw?=
 =?us-ascii?Q?NLikxrvlUU9s2lZhISxF53ZCvkvAYUFZAOXBM9riPr46Pyx6Ny4m1O/67+OJ?=
 =?us-ascii?Q?cpAZzBCOpFQLkQHvYAV83fwlVJFBG6KmQuVv53mITpWGEkJq81mV/RmURX3v?=
 =?us-ascii?Q?nfk8Cltnlg2YFSmpOmmho8bP+M2Fy38N2fjlKJvffYtf2hHv0k4adv0Dizja?=
 =?us-ascii?Q?cAvR4h8HiQoH5pp55hcug+Y+aOYlN7Vx7+ezKI/zsAhjgp4eZ4eF7Q2XfqI0?=
 =?us-ascii?Q?RjAgdCcScHPEiPSf77Q180ZVNQNZr6M+c9rEO31jFAeyLDqLbvdSNS+GO4Pr?=
 =?us-ascii?Q?XXst3ImO5p7diKveShpL3qc/Frzxvgh4xfzUCLvSKqzjE8Ga8FvyJsPlfaVU?=
 =?us-ascii?Q?xeZHf5G6QhFSrXQKUis+Kmk791oU8wfQ40DEloE5Q79mo07vbxuRbe8HIueU?=
 =?us-ascii?Q?RFemN/qJdF4WfCffpyyV3E2d+ZiF3GTLJDJ4FcBI5d7eNzgvgq6cbrrvL7I8?=
 =?us-ascii?Q?RfAhDVpILWj9XVruD85QlpF8qdL40BFiYdIB+91e4Y8tYo8XmCBqNE3RRkOV?=
 =?us-ascii?Q?y++1CJawIBwgwuldsvcJUxKMglFfoc1Gnx4cn38n7WA/WtQuZWFhqW4JNQdC?=
 =?us-ascii?Q?5V3wX2Xo8pQv4YK0+g2JpnCkSbMyZkMBIzfi0oMFsg3mq3wD6XDt+xOwJEPA?=
 =?us-ascii?Q?pbC/WySF/RzXB4FU8cVOiYI068n3V2og569SsvT1qtsThcKIJtyiviMsN1Po?=
 =?us-ascii?Q?VrpI60S4WrnjovUz05DJWC//BtDMJ6X1y+xanIp0OErVglCbVNnjq4cr2etA?=
 =?us-ascii?Q?eNLFHFHkxjjXSdXVyDRBGytPo2ZHOqGBvhdXGlTsMlYov1WKawYOHgScKRGf?=
 =?us-ascii?Q?gByQFO4cCYHbBp6iZUGkJULehc/KisTh5I/Tw1NxiVrqzv5aDwt0DnHpCwKS?=
 =?us-ascii?Q?7rX30oK4hzrdDFmbr2FrGp45tLdjdt0wsNNTxNlsdiurCkH9aRp4x6HhcNq2?=
 =?us-ascii?Q?REi1kLE7vO7VRPUOVVMFIuhozV4E0gQCyfAc1S4SvCDRN7n9jgjFySyOkwpi?=
 =?us-ascii?Q?J56gryY6nG5CFNhbX5btjMPhAWDRZYIIsa/SyWnd9U73rii+owVYzJIwO+7R?=
 =?us-ascii?Q?hxXxrdJVBpLZoec1PdTANAAy8mTPOrNGf8d3Yo3eIWCDMFm9ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:15:31.4312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291f8b33-edf5-4402-3460-08dcf518a15e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251

From: Perry Yuan <perry.yuan@amd.com>

CPUID leaf 0x80000026 advertises core types with different efficiency
rankings.

Bit 30 indicates the heterogeneous core topology feature, if the bit
set, it means not all instances at the current hierarchical level have
the same core topology.

This is described in the AMD64 Architecture Programmers Manual Volume
2 and 3, doc ID #25493 and #25494.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Drop tags
 * Squash original attempt and new changes with feedback together
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index aa63437a677c0..51b38bc667960 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -474,6 +474,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
+#define X86_FEATURE_AMD_HETEROGENEOUS_CORES	(21*32 + 6) /* Heterogeneous Core Topology */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 1db2bb81a3847..307a917415343 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -52,6 +52,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
+	{ X86_FEATURE_AMD_HETEROGENEOUS_CORES,	CPUID_EAX,  30, 0x80000026, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.43.0


