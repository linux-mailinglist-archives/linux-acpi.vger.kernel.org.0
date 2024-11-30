Return-Path: <linux-acpi+bounces-9828-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546559DF0FA
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 992E2B236E1
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780591A9B59;
	Sat, 30 Nov 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JrBT2/JM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626C71A76B4;
	Sat, 30 Nov 2024 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975678; cv=fail; b=hzoR9MyKTKy5JaSa2ZkNyEXVt82pLh6dhT6P4nM6y6CLar18jkddRie1LKTHSsoLSx9AyCB94bcM5oKyWP3y1Q5g4bw3g4sOefvZ8c2PIDSMQThRaF9NsdTIiAtlfxB5ZVORMo04V5ZpZJGznlVe22qTCHgJRsrW5stFGkCTHhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975678; c=relaxed/simple;
	bh=PLIN9Di4iSKUgShzNiv/me6wtqLVjfircb034nTlU6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBauOPzMmiMk0J9H3s9pYyX9uUQLGzlVonkLXK/lAu8gBLLOhoNf//Nt7v6gnxWibeVtDMPE8L2kqgDyGoLW1GrjBNZPqYuWI8SoqVubpmJk6L0Hal49FB61qMewAaT5Kh1Qr2vYLLLafXAEW0gAC0S/Xs+VWrkrOw8Yf/b2FLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JrBT2/JM; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4uq6K+GZMTJXqfof2n0Nc7D76rx3oWZDIA+N2LHTbGiEAbfCHKH+SXUwpOGUBiOTbkInYHGpIR8uunDpMIbcbtlwase8kLkHIX32RtHn5lVUopKLqIY9KgnVUt8AC4X5er3UZKeulruJMc4scI4X2HJCC0dH2dUnh5Lb+qVQV2jMaKSAynKXXjHSklYzF49B8DtIbmapAwKBAB5GBsjwvBxORqdV1Su1MQRDiYRSB0AXii7OG/8VfgSO3LI9nJ1Y+//cLF4zULMsut2fRBGVC/unMlsNOLT9cwmbVIh2dXHBuLmvEdCUKfJ4LYCYlh+1ye1jn32bOCFaMnwIEqP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy9dv4xCxmrEZGkcGwXZO4M6YugEJjOtZzXUC8M5aL0=;
 b=eT4d8FPIDzinmDxB9FEdA4Jyj+XXcGP6bGl9EfwefCxWeOj3bBO/CZrbl4bc/bLAQt7/1v+5RKZXJG4OQ3Tf4WBR3xZ+27taD7ND8TD2vcYMtYkW97KZymm5tVh7hHWj9qq4IUbp5Ys78s5H9u1L4l+oWRGWtrvuzM7H5rGrZpbSma1pW0CsmSRBX/12wQ6PiHEiIuAm/paZf+JFx+K6pvV8UvMi29GmRmCrEB4f9CUdY4u9egn9TdO9vL6oeNVMA/t/8fVvs0wzbJIz51df0OW1OtTqoDm0s9qdJCB7ci0T2wnIK2JTh2i6K2nZ0QHwHRYD5ZyCqfrwn4/cKO1j9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy9dv4xCxmrEZGkcGwXZO4M6YugEJjOtZzXUC8M5aL0=;
 b=JrBT2/JMFdjX3GRWme2kpKpqu76L5pgVA+g8iK9CEtJX2PD63ypxaX1lMlgEk/ZUJ08aXnWl2pZhlIWVIQnK1EVtScmNwSEhq+oIVkGL2EAe5EEGUsKzYD/zoYqMxdGCUMlVrfDP6j+ozeY4C4HMFMmLaebbHwY2SXt7vOliNyc=
Received: from PH7PR17CA0012.namprd17.prod.outlook.com (2603:10b6:510:324::12)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:07:51 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::ed) by PH7PR17CA0012.outlook.office365.com
 (2603:10b6:510:324::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:07:51 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:07:47 -0600
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
	<linux-pm@vger.kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v7 06/12] platform/x86: hfi: init per-cpu scores for each class
Date: Sat, 30 Nov 2024 08:06:57 -0600
Message-ID: <20241130140703.557-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140703.557-1-mario.limonciello@amd.com>
References: <20241130140703.557-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa5fa88-6645-4bed-4aaf-08dd1148607b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d5nuMICfYRB5o7xvgWeddzI0RbzjT4bu51UeyK0RIpdku1TaHb8shBKsOXxG?=
 =?us-ascii?Q?UXHhVmdaXhx9nIccDF1kVD4kTiR0CtrLpoEe5kw7QnuaV+xtpLYgxGUYiBu2?=
 =?us-ascii?Q?ezoYM4H2KthTFQqJmvELolxJtFCdybqJcqqOfnWYvL4AcqPYLC2FxlLhuPk1?=
 =?us-ascii?Q?aNsr7PjX7MNWIn7ekSPUjuY96TeRcCSVO8sbLW70p4FrYrfRaGs7nfZiahRq?=
 =?us-ascii?Q?0ZvDzVs3g+qicOxEWukGTOcFyla1pPA42HKSF2L1MSduO0lfmcbyuMgQnTPh?=
 =?us-ascii?Q?m6nhgCt7UFvfWmPJGPTdfS8s62mWc8Ayo6v1d2VM5M3eSXnFvTSVIlZTHyfn?=
 =?us-ascii?Q?gOb4CGr7FnUBcXm2UP81CZhrhmiaad7+NfO4vP1ksoG8zNYWKKIsUbZ4siww?=
 =?us-ascii?Q?h46+oUTPWPaBv/SqtLu99olxsy6JdugNOoxgPtHAI+A5P7rZmw/5dviBKGz5?=
 =?us-ascii?Q?9xyi3C4c69HE7+Oo9aoK2/mspjw5hx41d2WKFrsEXMPhMwIXgTWjcZjKnM1u?=
 =?us-ascii?Q?emg5FWy+MOhAL/Cu3R91ROcd0prfVhItTG5VVBF+LbfFK5qNb8IX2zEMh8S6?=
 =?us-ascii?Q?IRlLAwWTaxZzzVAXDvr0bkXAiDn+TU7LkKClkcrIjtHWZwrLC+ijfmwmQlsQ?=
 =?us-ascii?Q?2pGHGvmpQJ4VvxiVJ2jTHGidAGIBM802037pnkBmtasVfBK7dB8HDN+TBJ9L?=
 =?us-ascii?Q?VVv8CqThx7UtEbXvGha0H28tKIsQzm4umQHu3YOaBI4DmEazx61KpZdmk4MQ?=
 =?us-ascii?Q?oRz9nYu8kM8aaLimvI/DZvCLfuFAzDS67K1OhIjbN3B+YxW1Ot9b3CRK4r4o?=
 =?us-ascii?Q?uh8/rC3zdzfLY4tOxMto97PrOatJLxPlTr3B2SL+0W914/9mIiSgDUlQmtpP?=
 =?us-ascii?Q?VL3ZIypOD2YNOaH2bNf11BOZ4T4NTPdoapp4a9/nD1QhZr0eDXQ0ZcrDuhjU?=
 =?us-ascii?Q?3je0RDIX/guOPYuljvJt8jlI40s7lbzRbnY5frXfd0EUXlaboZNKgxbrySUq?=
 =?us-ascii?Q?s8JFr6GFQkMFu+7QI3m4Q30Px52b/OAKuOVAw/ZMo+xkjwZvw3qsT0xDKl+S?=
 =?us-ascii?Q?ZczoSr0mN1TaXLl9L5CHHdxrQn9InxhW6qj6698hT1noa0sfkGmHQIiXBjsm?=
 =?us-ascii?Q?iUSW1kXTdOxUVPL/tJnmPdVzKvFb3Lk9KW1CULNy+23SBT/LwLDYVf9MvqNF?=
 =?us-ascii?Q?DiYWbh0L/yI89gx80vj27QvfXcFAYpz1qpTk9lWWbCShZMiosOnohqNCWE64?=
 =?us-ascii?Q?ea/IGRBTKvlNb9mhUBYw6FqQnbnESG7OHXPif7Tc14emjp3SXQPqBR2kVsLo?=
 =?us-ascii?Q?Mu/vwO3x3MgpHtj6L2a+T6/WD3Gm4HrwK7D9GGcfJaBQNGWCx9cfo5FiMU0W?=
 =?us-ascii?Q?Dgthn2JdnXxGYhctlw4/yuKLbMMXvAmz2I80/tc2D6fDUEM5pcdeITmGAzHQ?=
 =?us-ascii?Q?ULau4ohIwLQ59IqPP2XCSS+mXv1gVDvH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:07:51.0019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa5fa88-6645-4bed-4aaf-08dd1148607b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858

From: Perry Yuan <Perry.Yuan@amd.com>

Initialize per cpu score `amd_hfi_ipcc_scores` which store energy score
and performance score data for each class.

`Classic core` and `Dense core` are ranked according to those values as
energy efficiency capability or performance capability.
OS scheduler will pick cores from the ranking list on each class ID for
the thread which provide the class id got from hardware feedback
interface.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Drop mutex, move to proper patch
---
 drivers/platform/x86/amd/hfi/hfi.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 3c90e93fd192c..9671f07c76390 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -226,6 +226,31 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 	return 0;
 }
 
+static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
+{
+	for (int i = 0; i < hfi_cpuinfo->nr_class; i++)
+		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
+			   hfi_cpuinfo->amd_hfi_classes[i].perf);
+
+	return 0;
+}
+
+static int update_hfi_ipcc_scores(void)
+{
+	int cpu;
+	int ret;
+
+	for_each_present_cpu(cpu) {
+		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+
+		ret = amd_set_hfi_ipcc_score(hfi_cpuinfo, cpu);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int amd_hfi_metadata_parser(struct platform_device *pdev,
 				   struct amd_hfi_data *amd_hfi_data)
 {
@@ -311,6 +336,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = update_hfi_ipcc_scores();
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.43.0


