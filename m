Return-Path: <linux-acpi+bounces-8897-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF629A974B
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 05:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31C81F221A5
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 03:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B5484A3F;
	Tue, 22 Oct 2024 03:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kxlPxJJh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8355770FD;
	Tue, 22 Oct 2024 03:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568821; cv=fail; b=q3KjQLC4MaACo3OJlKy9Jtq9xtW5XC5iOWgqRs3zD+MNlAB5kPa11ncUzHkcT3E19A7kJVFptwRXYF2UhpmMQ/eL+hxsvM8OkldQ8indHhLTUTmjYLsd/P4JpqgK63WteIscsvTN2Rc0gWOajklhZZZYuv0u+xhVkSPcsR+mYZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568821; c=relaxed/simple;
	bh=nj/qTAPnX8yqZwgDLhsGPD/DuLJRmoeEWXVMtpEOmiU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRRvLqrzswR3telf4U/EXy2dx7mbL1fEywxejweaTzwjeZnlXKT151S8iQx4pazrouZncHizBQStng9NfDddpmUhAf5Do8M3Q3QpM+x/aJ7ciz3ItSwqgaw5+bvRgo4BjHc3I5PzoFUwCvPLgFXBKu28tl86qTgdLxkpebaXr0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kxlPxJJh; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7JvLXC4H62TTBrRtSI19qbBmNiPSFSt6MKJ5FYaKzvfPX/KixJ9y4ar6OvC8v5F0+2W1Urt1pdqmdxlcZ+rpsIpqVGR5OP6Sv7VG/TEwan1ovVmOjwzxhzDe1VQYiDMZoU5+YBTOQ51wEmEpGvkH5FHmeBcGl8fnlj/kCerjmfDBivqjdYA1a29AGtSf81TiluqxlPx04gWKwblAyNnwMIwW9WufhkrJm37jzWcq60YwGyD+Vmd1IVBj41scGlFW0s4x4LGQFdEs8hoFdzV548aM0rz8kSvxtwF/GfUDRMSDHdBTlxRkzPoOjjTrSwlgd5rqFbg3qTJ5ONdPivXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3ZAl/5I27aIN1xRadL1S6FisiIXQ2tgBmiNwo/kvZw=;
 b=j3sp3YDdWx7yiTFBq+nWleak5RTcFTTIDvNNWBmB0JwIck4pczPy2DepaiKJzFWSQwlK6gnlJm+Y3gDjxvYvdWa5aoFpnDVdTmIWrf8Jnk7CAutm0+h+NbygorDDULnBBNMptKK0UvFHqPyYJ6bubXhKiBBZmbPXFu6UphcGPr/NmFzeAT/ZYtDq8PdV6ovDHYnwzKJ0Gx/VmsC+nW8AK6EDuQ9xhjx4Wx4O4+aEkjBB6YM1bLdh+LlsgLk9Zg02Dbut9SuVrIxEQiCb8iLhF/CcoDM5uxsCqpChONyfgsOnhd7mlpEiIBLUihBl1wAXXcg437TeHyDPQCS2IgAYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3ZAl/5I27aIN1xRadL1S6FisiIXQ2tgBmiNwo/kvZw=;
 b=kxlPxJJhWS7jvq10F1p3eAGrG1uOa8Z89K95yM8rgBAYEtOTJ9Zr5WKewGiP4KG8S+JnDgBUqYOWw+V1h6ev3mdaHjuThpf/iPTTL6OlSNg6tFtiZ4Szg76yCZI4ozDUXQet1jb/qLSHtzd01dfKrQQdOejm5r2dkJOiKJuVnJ8=
Received: from BN1PR14CA0004.namprd14.prod.outlook.com (2603:10b6:408:e3::9)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 03:46:56 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::b1) by BN1PR14CA0004.outlook.office365.com
 (2603:10b6:408:e3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 03:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 03:46:55 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 22:46:54 -0500
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
Subject: [PATCH v2 5/5] x86/amd: Use heterogeneous core topology for identifying boost numerator
Date: Mon, 21 Oct 2024 22:46:08 -0500
Message-ID: <20241022034608.32396-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da1fa2d-03b8-455c-f4e1-08dcf24c2c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fopKHDYmT5F8gFpeEHL2P3t3QQN9B0mZy4qh0FXlzdGz5yhSu71Dn1yqtYXu?=
 =?us-ascii?Q?carhfFihSW8lB27JwJxviyoG9PZkA35WGU7q97nP3lPz639QBZ22w7kFThPK?=
 =?us-ascii?Q?1FDKJs9zbp2KxoTDANb8rAzhqtFIS1lNDLoXp5mugHsBVQshQHIVJ1VeRtEN?=
 =?us-ascii?Q?VEY53AH9JKu28PW3KvPfFzDom7yHEvazmYTZbiBcFYV3bUf/NXdLgCkqEhko?=
 =?us-ascii?Q?PoFqf8SpIQKWp0vGnS7HgZyG/wxl0pm8W8sWs3VFoLSBtqXC/sj0zEIbF0l4?=
 =?us-ascii?Q?rTBTgVrIFFs+MVC/xXAYOl6gYxIt0T36Q8k+lA3y2J2uleXs6/kj7CQUXl3b?=
 =?us-ascii?Q?WLjIJhRbio0o/60sFTJYWBSW3gdAfGvDXnVmAVXWpA/psfCXjM22m3liGpl0?=
 =?us-ascii?Q?iXLNgPoudOzvlC7i5QXYpVno8mkeKDU8z9hAZFv8dHm2/9A6G1rfmnPFdGwm?=
 =?us-ascii?Q?JYHOrIMTSh3owmmOxRX2Ckr9jAcnulqjuHm+YewCsmr70uJd4MMkMK2njei8?=
 =?us-ascii?Q?aT75mrRTXsADb6umJofPPS97arbf+YWRlQ0o6xx/v/4GwTyFrxn+oaoSod5H?=
 =?us-ascii?Q?6lzFHFkQ2hjn+rc+wsDw8syiQ2i7Hi7ER6Qc4tWKitzGSSiLbg+gZfeNqxk3?=
 =?us-ascii?Q?R+fNeTWTIGB08z1Eswgai4XFCYOqWrnQ2cRbb8GxuU2/uFwVVvqTZVGrRSu9?=
 =?us-ascii?Q?k4r1d8Mku/WPRXVOjA8lmU5YnzwoKhS93FwSCNgyr+n5xgh0xoEaTbe5pdXT?=
 =?us-ascii?Q?fwiiIfw7f7wc9+JzvxdHUk2CpxuJfR6GZlmMVOvQ31Dj7yMtG4PMfxUxV+jK?=
 =?us-ascii?Q?yCEQVyop9/JluNL+9XlqvF7PC1WL4OwZV9j2+Nq4pLzSc9pjJjBzi9/WS+Nk?=
 =?us-ascii?Q?bM2MCcAjFh19+4w5YLKj7H68Zgj6lGLooQua1APuhL9Tj6gkVbziCj9wnJ5x?=
 =?us-ascii?Q?vd4UiZEyuoY49SrxDSKKku99T/o+eAjsFKkjL4AJnv0O25+MwA+pAMHmFWG6?=
 =?us-ascii?Q?T7R1mrXDy7DAkiPGQR4jBahMCMl4FO2kIL4J80NpBYBOruiCWdzo4O/oCEi+?=
 =?us-ascii?Q?llgPkx8O4ye0JOXWueAUuyn+FaxdG+pr32p7SVctOvr1S+gmr0fpbIUiEaRx?=
 =?us-ascii?Q?aKvVOllWNqDDe1UG6NsWzezlVQ9hr9HBW4QM1MWAMKDCqnbfQdwC5Cc+VGiD?=
 =?us-ascii?Q?pgaUFNBnf9aMClYZGqdR7zJ051/a0jafFRCMyLLhPR6sjrkQQmslgqLYpoh7?=
 =?us-ascii?Q?Web8AXdfdYJ4f+FKktgftIx/f8JbZP09347LuL13XMDqSZ1XsxZKBL+WCh/H?=
 =?us-ascii?Q?OUJ1+wSbthyjwz2h4v7yREZq3ABu7S3c8YVltjiREE5fX2rDVpTtDxn825Ng?=
 =?us-ascii?Q?Ad65XlPUz28i8WvFHmITrsLAV8FMPlLQpILEhiyLhIuRP4KVEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 03:46:55.8906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da1fa2d-03b8-455c-f4e1-08dcf24c2c9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365

AMD heterogeneous designs include two types of cores:
 * Performance
 * Efficiency

Each core type has different highest performance values configured by the
platform.  Drivers such as `amd_pstate` need to identify the type of
core to correctly set an appropriate boost numerator to calculate the
maximum frequency.

X86_FEATURE_AMD_HETEROGENEOUS_CORES is used to identify whether the SoC
supports heterogeneous core type by reading CPUID leaf Fn_0x80000026.

On performance cores the scaling factor of 196 is used.  On efficiency
cores the scaling factor is the value reported as the highest perf.
Efficiency cores have the same preferred core rankings.

Suggested-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/cppc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 956984054bf30..4fd007eac0c71 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -234,8 +234,10 @@ EXPORT_SYMBOL_GPL(amd_detect_prefcore);
  */
 int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 {
+	enum x86_topology_cpu_type core_type = topology_cpu_type(&cpu_data(cpu));
 	bool prefcore;
 	int ret;
+	u32 tmp;
 
 	ret = amd_detect_prefcore(&prefcore);
 	if (ret)
@@ -261,6 +263,27 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 			break;
 		}
 	}
+
+	/* detect if running on heterogeneous design */
+	switch (core_type) {
+	case TOPO_CPU_TYPE_UNKNOWN:
+		break;
+	case TOPO_CPU_TYPE_PERFORMANCE:
+		/* use the max scale for performance cores */
+		*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
+		return 0;
+	case TOPO_CPU_TYPE_EFFICIENCY:
+		/* use the highest perf value for efficiency cores */
+		ret = amd_get_highest_perf(cpu, &tmp);
+		if (ret)
+			return ret;
+		*numerator = tmp;
+		return 0;
+	default:
+		pr_warn("WARNING: Undefined core type %d found\n", core_type);
+		break;
+	}
+
 	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
 
 	return 0;
-- 
2.43.0


