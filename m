Return-Path: <linux-acpi+bounces-9829-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8080D9DF0FC
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA51B22496
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF41AA1C1;
	Sat, 30 Nov 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UlBnV5jK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB83A1A76DA;
	Sat, 30 Nov 2024 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975678; cv=fail; b=MyPDZ2A9grsIT2bzwT0WYN4eDvwAAf/LIYC0xizGarjG6G8zOxS14LJPeapeSzPf4Xw14BOUHxb/G+PRcrrytfhKnfKaS+OyGaKTt544YtMahtsMFvCWX/ZVCM5BBqfpG7mx9SVpILXc+6mH4vzNC3/o1V/uzFzbF4zGiFJa0tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975678; c=relaxed/simple;
	bh=FpLsiRAJ0TzAVlqt/XYgzXMXQTsiGNGdRN6lg7gXd6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jx7dNU3dmyKhXycYLCbCvUvPXZJUewYsrQezWXRphirlcUyyLqyV9lASZyh+5AxffykZCtz6/65jwrZ/sfCJl6XGejuEtvs4GM/xegWlxjTW5u6oB7r6HzUOqnC6B0JE1J3AIEvTGrEre+eNIAyVIRUwmjM2Yq92+zEaBsO+MAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UlBnV5jK; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Shwz4rkKAleUaNJbGa1b/TtgCUOV4OL42DzyI8YI5NdCT5pbtIovO/qtKSLZBGB5/qsesthi0tkFxWuGiT5TXE/0a+o6o4CJ36CYdj3flrwFKc+cmSBac+knVXX/PxVQQTDgWSHd5wu6q6IouGomv+7QrYLXwE7scVtOIel9YsXaxcgDiccz9YRfD11iFIMfcQqgl2lY5Tdb7ym4YpCoOBbm8CV1rMjs7cU+XNc5/76QDV0R+NKjk4NwBPfVHcpk6goQ9uEMyqKW1i42efmN/xiDs71nHbFrWE5z/r0vm85BznG61ydc12PbaggVVejh/mLiwvAPQsHHdfH+C7BuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RknzHyVcDROpyuEbZtKEZ2l63n4PQHm96/Tru68mFr0=;
 b=TS8P6LQRNoWBbTR6W7W+s6SXrrmN/zAAZ/028nGrsiNaDXRybIu+xntnyTlDGCqlfPoTXryGLBRQConBgzO8hQKrIWe+YTraEu3/lEsX31tzgi6RuwYjKzjt7aCAbz8n1V991JOEn6PQSzv+6Ox0or0AeeVfT6XkKENNUjMWWlM7tb/341NfxAceciKdailoXCpf3wxsnUpjQ/4K6aPTKB+mvngwtkZK4XFbj2tZn6l3KPBApb2QnkOYiHlZKHD/wWkbKgLM24R0x/d2K9xZka3UGAb++BHpOsdwKIsUT6AYWEQK9HzbfNM7xAJz+CNAh1gMk+SdazY2yl1ndzDsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RknzHyVcDROpyuEbZtKEZ2l63n4PQHm96/Tru68mFr0=;
 b=UlBnV5jK1FpoGWAIx5kexSfGh94fzVis2Q5fxuILcyBBy3caW7BlPfkcecz+zIONEBCdgKr9otSKVTprlzImHUpZvpXoYHiI4WqQvFXdqZgxz+KMWGPfbv/59AQEUcc62ywBSWG66o8MkMbpuL6NvBhVk9YVxbktO5Abxfyux+w=
Received: from SN1PR12CA0075.namprd12.prod.outlook.com (2603:10b6:802:20::46)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Sat, 30 Nov
 2024 14:07:53 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::8) by SN1PR12CA0075.outlook.office365.com
 (2603:10b6:802:20::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Sat,
 30 Nov 2024 14:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:07:52 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:07:49 -0600
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
Subject: [PATCH v7 07/12] platform/x86: hfi: add online and offline callback support
Date: Sat, 30 Nov 2024 08:06:58 -0600
Message-ID: <20241130140703.557-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: a838f119-4641-478a-a949-08dd11486159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?woMKsHdqXSXLJTo8u7vE5r1M1U9gg/heYNmcnEOzVoWRjhzB2sZEV8NRaPld?=
 =?us-ascii?Q?f2NJhJjGi5vG4gUQWgWuR9EPlIa9PBZC2lvMgfx5nZxL/2csTzz/4y7X4vNE?=
 =?us-ascii?Q?7Dm/B1LiXilP/v5vqqliw46LmssCnVMmlMNQQMAXNd5MIyxn9iFkZjlwl0Nt?=
 =?us-ascii?Q?7v3Y1qZDknR3cs6KUFYDNgK47pKCtvR9w6HuoYiS0AfCQK6IdqFhC7E8jx3s?=
 =?us-ascii?Q?ngo4Q2vlQ8vEulqT8HFEJPsXaFYO5pPVlnd40RbBEd6FbJH8Yd8mJEiB+Ffd?=
 =?us-ascii?Q?UCNjB1b4egkgHI42hVyg0wZrEr6bvpO0eYNIt24Cwu1RzR8QLLe1R6N89PzS?=
 =?us-ascii?Q?JmHf9uMX1Otf1ExnGJmCGoa1pzIlRCXhd3c1TNaAk6NhzyGen7Fj/j+6dvcB?=
 =?us-ascii?Q?P63qt1vvoHabAn8GcpilRIM/awGqyDWngcOtIExpqQ6Uye5GPYTayG10OOKi?=
 =?us-ascii?Q?irSnNU5imNHbB0SmxhtanyAE/I1ww0NpDmvilripXOOC0wfmp24awBb7i8jv?=
 =?us-ascii?Q?mw2VQo7ydq3jrIYbAT7mHIS+NTgiTdOduhCKkgSXhJ6BqfKMChCpStllS2D1?=
 =?us-ascii?Q?MQBnPECmwUA/tIYMCJO4fVudsp06oACssTbqZpyVtD0RkhPDZvRDV9yihoaQ?=
 =?us-ascii?Q?Fy9bT16s61+vZvLbiLVmbrDlslKGUVceZJM/NSLSy7mDCE+izSOyI8M88eu8?=
 =?us-ascii?Q?BXP5hHfTZ+Uml8tJrxjioAtPMO9nPB7tARJxwU+mi1QlYJ4E7M7MGpEt/X8F?=
 =?us-ascii?Q?17CqktMJLvTr52z0RMIfx2e6NTBRZpnRxdjWYBXz2cFnHhvtYZSq2xmZdHP3?=
 =?us-ascii?Q?q8fuZHjixZxsUCZeDfNOWT6G7VqwRbFp46lniXWIgNaRyJEJxl9N12ApUSjp?=
 =?us-ascii?Q?6JtMP2yRn9wUjHAwCdA2gohEOISQbxmzDSDQGbJy+UVzXIXxGFLjd+7KaDbS?=
 =?us-ascii?Q?OBb0KBH/S9PPbAz+2hN44Qh10Nt3AyQrG+RK5dqaYhnisi1WLp04OUV1XT08?=
 =?us-ascii?Q?bRib0ISy/u4y0o7117rHYhkQA3O6vWt07tl3IdnE94qXY6qiYoMTOvspBvYP?=
 =?us-ascii?Q?VL1+jTIjY607GK/VVnnMK3HOT38rzwNzHDmCW/Q+lmJMFm5p2n3ZF5KNUS6o?=
 =?us-ascii?Q?axxGWFLAxUrhVrVhKhKfKWVD7nzoYfPxF5XsD/k6FfeMV/lUh9TduHOC7OjV?=
 =?us-ascii?Q?93l4PSdtp5Ju78HLhw+MBDosbb2XQ+8tj9vc+6Y2sEWjh08hqaIpspAln99H?=
 =?us-ascii?Q?53xfl0yh53ec+RE1kkrbBytJ0cf+FovgojUDtkdiemE1lspA1TNQMbDWgkCM?=
 =?us-ascii?Q?OTwU9q4H5W1/YXHd+1Y6ARj+/A4X4y9oZpRpeGxZYUVxts7GcsiiQaPdIzjW?=
 =?us-ascii?Q?RokC8GKdr4AacGCPLwdLFUNJV6xbVoWbvuOHug/jf9obtXmSVdtIR72U2qBu?=
 =?us-ascii?Q?ioo8tzkysTUDt0lo3TuebYLpoqIjKRo6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:07:52.4124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a838f119-4641-478a-a949-08dd11486159
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710

From: Perry Yuan <Perry.Yuan@amd.com>

There are some firmware parameters that need to be configured
when a CPU core is brought online or offline.

when CPU is online, it will initialize the workload classification
parameters to CPU firmware which will trigger the workload class ID
updating function.

Once the CPU is going to offline, it will need to disable the workload
classification function and clear the history.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * move mutex to this patch
---
 drivers/platform/x86/amd/hfi/hfi.c | 81 ++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 9671f07c76390..922a9ff0d447a 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -113,6 +113,8 @@ struct amd_hfi_cpuinfo {
 
 static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
 
+static DEFINE_MUTEX(hfi_cpuinfo_lock);
+
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
 	int cpu_index;
@@ -235,6 +237,80 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 	return 0;
 }
 
+static int amd_hfi_set_state(unsigned int cpu, bool state)
+{
+	int ret;
+
+	ret = wrmsrl_on_cpu(cpu, AMD_WORKLOAD_CLASS_CONFIG, state);
+	if (ret)
+		return ret;
+
+	return wrmsrl_on_cpu(cpu, AMD_WORKLOAD_HRST, 0x1);
+}
+
+/**
+ * amd_hfi_online() - Enable workload classification on @cpu
+ * @cpu: CPU in which the workload classification will be enabled
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amd_hfi_online(unsigned int cpu)
+{
+	struct amd_hfi_cpuinfo *hfi_info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+	struct amd_hfi_classes *hfi_classes;
+	int ret;
+
+	if (WARN_ON_ONCE(!hfi_info))
+		return -EINVAL;
+
+	/*
+	 * Check if @cpu as an associated, initialized and ranking data must be filled
+	 */
+	hfi_classes = hfi_info->amd_hfi_classes;
+	if (!hfi_classes)
+		return -EINVAL;
+
+	guard(mutex)(&hfi_cpuinfo_lock);
+
+	if (!zalloc_cpumask_var(&hfi_info->cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_set_cpu(cpu, hfi_info->cpus);
+
+	ret = amd_hfi_set_state(cpu, true);
+	if (ret)
+		pr_err("WCT enable failed for CPU %d\n", cpu);
+
+	return ret;
+}
+
+/**
+ * amd_hfi_offline() - Disable workload classification on @cpu
+ * @cpu: CPU in which the workload classification will be disabled
+ *
+ * Remove @cpu from those covered by its HFI instance.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amd_hfi_offline(unsigned int cpu)
+{
+	struct amd_hfi_cpuinfo *hfi_info = &per_cpu(amd_hfi_cpuinfo, cpu);
+	int ret;
+
+	if (WARN_ON_ONCE(!hfi_info))
+		return -EINVAL;
+
+	guard(mutex)(&hfi_cpuinfo_lock);
+
+	ret = amd_hfi_set_state(cpu, false);
+	if (ret)
+		pr_err("WCT disable failed for CPU %d\n", cpu);
+
+	free_cpumask_var(hfi_info->cpus);
+
+	return ret;
+}
+
 static int update_hfi_ipcc_scores(void)
 {
 	int cpu;
@@ -340,6 +416,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/amd_hfi:online",
+				amd_hfi_online, amd_hfi_offline);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
-- 
2.43.0


