Return-Path: <linux-acpi+bounces-9833-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C693E9DF114
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4545E1603A8
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23571C2DCF;
	Sat, 30 Nov 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yMzQzbaP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FDF1C2301;
	Sat, 30 Nov 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975685; cv=fail; b=Cc+pBntbFWBX5w2z7J6j1Z2H5xvQmozxrHOV4GHz9+p+Nppky6Pfyftnc9fxTjkwaFtDdvPmjIESi4Iesk2sL8aOtKe242VQpLCb8RlbhvKC042GrStpj2NX7X9FTbnE2pWQLM0j6afcxNemJoF0YjUZsM7TlvGgwlsRoHXaf4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975685; c=relaxed/simple;
	bh=SyTSHZsCUn82tUVuRI0O8Q8JYKLMIYs/4RA3IHHMzq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOxpWQQsIz0VcJGQGlYdXrIdyUpO3i2sMg3aXNhvZlhYtU5H1HV6YcsLPiPxfepxJy2GBimey6ivCloQBZivZiWbNWg9yOATt5+VOUdNJ3gSVX1v2RU7cbtiRCNSe01Oh5YciJ/8AzBV8zhu3rg7Fwkuz+/DH71WvGvKoGTb1A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yMzQzbaP; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnfTlmQZer/bZASj64gQ4Nf4+R2he9GBrfObwHczYYBEx5g44jUl+YlzdPVv2W7ICXBEtD3+eNVgVbQ20HKAORPpz5+piH3fs3nSSbnMD1IQD0lLdb4aPFoK4ynYMXiGgeeIguk+LiLyZ6/+BchnWmZrf8ojSjnFz08KI1OBPjaGOU5omY/f5yN+rjUuKtoDfRLrnGLVJwgsH95m0WIpKyE5kdAk8B3nXARqzKRAwBEf7OxpwCpFf+EDEayKPQwY3anlEA68AQBqFT7rNLSKQlmh3hWoPJGCqiFccv8qDu4GIOfwAf3gVHRjI0L+KynQuq5bBAo6qP6tSDE2sxoNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jynr0rR5oKbG7uuIa/0APhD+gIeciu7tVnGInLD4URk=;
 b=rHGrRfgnAC+NASHqDM8GroJyGx7/0Palvxmdxz34nzsBARn/HZGNH1ZOoG9aL3o+xNTgPgGhJJiunAio+Q3CLRjwFnU41u5bqc3D7gUk3yB+YAxQTLdwYgt5osFvPILuqXmURV1XXbNxA1bkQXhcn33mS+VEwnirtGf/JQ4VXgymXWDXZ971shzoR9cR+dVsg1bGppRprunC0y/aD5+oLJeDeeX1ra6vjkp860XIBL9QFfNmWIF4qEm2zTqBXXs34mKz0hYhSINyZKtaTEUpe2mcslNWjz1m7l/Bbcy0yiUuOS8+ZnpIQdAtq5eOxp/aKLqQJs6myB3Pge4h9MDU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jynr0rR5oKbG7uuIa/0APhD+gIeciu7tVnGInLD4URk=;
 b=yMzQzbaPzhWCQo0+OfQ4v0hbYyYQArtqV7WE94OULdS0c0013Xh58c3VOdP7Eg8UaKDSatYE/kZZG4wN4SuIM5RsqFhx+gmGbryZ4rVpHY3HMwex3TQ7dHrR1fxkJPdOfL/Ni/nIKJWxCLL71YUu8WgFN89E91PWYGfwuz4M3Z8=
Received: from PH7P220CA0143.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::25)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 14:08:00 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::b6) by PH7P220CA0143.outlook.office365.com
 (2603:10b6:510:327::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:07:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:07:57 -0600
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
Subject: [PATCH v7 11/12] platform/x86/amd: hfi: Set ITMT priority from ranking data
Date: Sat, 30 Nov 2024 08:07:02 -0600
Message-ID: <20241130140703.557-12-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MW4PR12MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 9140c8d4-fd88-4475-25e0-08dd114865ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zZYC1VGvj3g6yLz+HXV4Bmb1kX9HOYa2qKGfUKQbdCQDsKgsEAD4IpOBsP+H?=
 =?us-ascii?Q?IrOEY1IWXyRom+rT/+x4w/s2vIH3Idn3mPRlwkK+qQLp7PTXQPR/T8IEpfGD?=
 =?us-ascii?Q?mU4jvrclblkRFgCk0XtbRoxCETR31nSFrBOjjhao8f2w4rzBrBQji7Ms+UsI?=
 =?us-ascii?Q?NIhOP0wmq6IS9ACwXZnoz0/DJ96GaGkF+iRYL02l5mw+DmMbsyFzFan+pKdB?=
 =?us-ascii?Q?Ra0grWhSQ7bJVu6IvAOsq0uFUV3lKDoOFCQmdSXs2X52qcEZUA3IJTTg5FOL?=
 =?us-ascii?Q?R3v9AvNHlWWY8481EgiPwS3i14khmgzRXQYi9TREy0U8oeNkLzH3osh2KaiL?=
 =?us-ascii?Q?JgdiTdTuY9ttyVqSNQR60YCvpV3xiU5fcrov+IjElH2bxv0sMRcUEOt07/x1?=
 =?us-ascii?Q?5XHwacL2nHbEHaPB74FfsDm7pg7meCe0+ux5mSPsjtE4rjOrG3x9n4S2U0o3?=
 =?us-ascii?Q?F1iXtf3pFjWj6SbiEYhN4iTi/5Mf1pHQ8psSdLogaqCBWB5bh54eJ7oBhl/p?=
 =?us-ascii?Q?CIYUDOB+qW/OLQQqokXtgZSLx6qxAzub9H7Tm14xrD4Dfey9SBnyxzf/QMKM?=
 =?us-ascii?Q?bsdELhytXyq5eQmyQL1U6WwhtEv7GT7A7tVFDUIz/l7+/RUZHPnwdjVoKiTV?=
 =?us-ascii?Q?9nQ4CaRvGM40q7hqwlIZI0NWbLCSUu9k877xXamoM+/PWJmju6rGX3nGHU8E?=
 =?us-ascii?Q?pVaKviynJuJJ1a4ya7uteYArs+JpWD+iVBAyHsqUZE8gGH42kkq80Ty5lfPX?=
 =?us-ascii?Q?3/bRts4IkCPTuPFH/Jw0tVq2l2DUE1zVy5VyhK4LpBWih4yanWFHO0pa+BmF?=
 =?us-ascii?Q?k04lKA9hp8o9kPdmyNFe4nTVXiQeTiu5xGRRIgU+j/TrpjJFQwp2CtZ5uZsq?=
 =?us-ascii?Q?qaYZhZITyPN++nbOD758O1jddP1cDCM37QzBNUYEpd+6OYQ7CGgGso9aMmgY?=
 =?us-ascii?Q?hPOwOlNwPes+lmSXBAndTgvpuJ9/Fa6BMfxmrZ5ZSv8deDiO6oWd+klvVt9X?=
 =?us-ascii?Q?FZiklfr+06IfHCNEw7Q3j1LhePwejENeD9/zWhqHgINsztH2ZDKOOeAICCoi?=
 =?us-ascii?Q?EkL5HhLeNhD/8XVaeNewG5y5ps8zEAiHl8YYuKMjPaSwvtqMGjX1zLHBrXqt?=
 =?us-ascii?Q?ft8KNYiGWp1/nitjO1KFOHKlQMaCIy4ekpgjlOESusHigJHSNLzXhsMAg9Hr?=
 =?us-ascii?Q?XDPDPMTkOh2obtMgrbQyEIlb7kiJJUh7Mhljj74Y1+ALYStP6uK5KcFxhqK8?=
 =?us-ascii?Q?FdTVyHhmr7e1cz1ejOHV/sxk+iqHqnLLS/dn6YvyMAejUnT9lQvdAwQJ66Wq?=
 =?us-ascii?Q?0D1o/PskBA/98mRe4WdI8uNyTuFX2Qe3/ErnEUsMa+C+0JALrXler9wbLDiM?=
 =?us-ascii?Q?sqyz4K7JxG7l1Nob+l7VhzmOJ8ce1YfiW9zp8SAb/DMPjU2EfWtt4nuU0HVV?=
 =?us-ascii?Q?JF89Er3EwdBL/Xr8c84QBmfMHoQotPpR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:07:59.7712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9140c8d4-fd88-4475-25e0-08dd114865ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668

The static ranking data that is read at module load should be used
to set up the priorities for the cores relative to the performance
values.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/Kconfig |  1 +
 drivers/platform/x86/amd/hfi/hfi.c   | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
index 532939eb08a6a..045f598f4866c 100644
--- a/drivers/platform/x86/amd/hfi/Kconfig
+++ b/drivers/platform/x86/amd/hfi/Kconfig
@@ -7,6 +7,7 @@ config AMD_HFI
 	bool "AMD Hetero Core Hardware Feedback Driver"
 	depends on ACPI
 	depends on CPU_SUP_AMD
+	depends on SCHED_MC_PRIO
 	help
 	 Select this option to enable the AMD Heterogeneous Core Hardware
 	 Feedback Interface. If selected, hardware provides runtime thread
diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 80ccc50ee0914..0940950dd7adc 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -115,6 +115,12 @@ static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index =
 
 static DEFINE_MUTEX(hfi_cpuinfo_lock);
 
+static void amd_hfi_sched_itmt_work(struct work_struct *work)
+{
+	sched_set_itmt_support();
+}
+static DECLARE_WORK(sched_amd_hfi_itmt_work, amd_hfi_sched_itmt_work);
+
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
 	int cpu_index;
@@ -234,6 +240,8 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
 			   hfi_cpuinfo->amd_hfi_classes[i].perf);
 
+	sched_set_itmt_core_prio(hfi_cpuinfo->ipcc_scores[0], cpu);
+
 	return 0;
 }
 
@@ -453,6 +461,8 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	schedule_work(&sched_amd_hfi_itmt_work);
+
 	return 0;
 }
 
-- 
2.43.0


