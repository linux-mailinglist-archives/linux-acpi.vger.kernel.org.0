Return-Path: <linux-acpi+bounces-9830-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD99DF0FE
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D34280362
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0081AA7A4;
	Sat, 30 Nov 2024 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kfEejDZs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87E1AA1CE;
	Sat, 30 Nov 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975680; cv=fail; b=Cq97kAElZFfSRwjipsUtkgn1Ezch4E1cYRrRdRszHs09fIt6ihX9T9zuPMDmWsfpObjFsjYvJNnHUKLANyc+bflEXkzgeHolQzYygkuZlIqctdLSb09DljBQsQHHLwJPB+qEsy3AySql6MF8HjMndIeVzYppzt9bHTqcS42wGj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975680; c=relaxed/simple;
	bh=ien+250UDGSrySnQglG7UUoGBOSS6C1yuHB+mvVLNHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JY72qf0UF9IauW53XktB39JRF7n8N1QV3hvXBmPS4pfEzk2bKca5AgN1Yu48yP/jsHCL6bWk1kh61R8x98PYuDNJFiqU13W1Km1YkDGT2twGl+TohAO9biTk3Rj1zySdq93ToeHpbEbqIhacEzokcc4g6mdMz1kBLNcbobZ8dPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kfEejDZs; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPuPyJ3m8L6ElVbIdxHB2T3YXTzaFfZgAKQolVK/gh7ib02w76rceLwzqndLrwUVi5IbbdSrXraLSIfMG0pexI6qA2mdFcrYuDNR4iNgMdBqNaUheEFrmHKsf2mmcyUJSxuvNmiTUCgcd9k3fApk/ECsyMDp+jzS8dEFBEwlFXfLK6vGAgDn8QZnbYPgr/R/h6B4GzRcPKGQnCTHQBipX9MYPwB65cVVDQk5xZCZgy3gGElSr6B3ICtv9zpYpaQgQRWvZW+Z/VRs8X9xN0sTcBiRyUKdTbMN0GpI9RtdVwyEwdruyceXPEKdh6fMj46W7jQjGVxyVCukeONWwupykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZ0JhNSo5HIbRJxB/mR7KS3J2do3bzPNbgtturNXyiU=;
 b=RDgbnR4mVONSz576j5a1wyLEEMV/cb/4Wqgq701H1haO+gC+lMyFTLkGXAkAKLrrM6cKLbZfUctLAS9ULDODd9GsyRNAZQuaTNcBnQiOQbxPn5aMxOeXcwq3Vq28DLBf/PS1BOI9/EoE/YAx3Vtw//0HUK0IwrjKi+p5u7EDJUhWPFQoTpFmc0wa+++PSrohXrknn95uIlgkQilQTW2HKIbtoOFRlALz0lrHGAYGCGvlmGdinVTKGyGXPXJajLeW31x3gl1kQ0fuSq/NlUPWMazGY9KyTKuGgzRJmUp7CfeQFc34RExbjgkj4awpLvP8I2bFV4WzSGI3XED7OkPJvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZ0JhNSo5HIbRJxB/mR7KS3J2do3bzPNbgtturNXyiU=;
 b=kfEejDZsWZjGXq0jH6YBU6KlqREpkZ6YFUTUdrLtxeFpj20orl4DUTBW0e4UxW2qYTY9VQ+sxPR88Jlte4FQxrn4TnpqRilrNfXliRt6xKOfNPWcxWMgqRl26kkPd6mG7hY1U5J2rKEsu+PQNcL6oDIBi02GhuuprN8TvrRF3V4=
Received: from PH7PR17CA0023.namprd17.prod.outlook.com (2603:10b6:510:324::24)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Sat, 30 Nov
 2024 14:07:48 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::b4) by PH7PR17CA0023.outlook.office365.com
 (2603:10b6:510:324::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:07:48 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:07:46 -0600
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
	Perry Yuan <Perry.Yuan@amd.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 05/12] platform/x86: hfi: parse CPU core ranking data from shared memory
Date: Sat, 30 Nov 2024 08:06:56 -0600
Message-ID: <20241130140703.557-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140703.557-1-mario.limonciello@amd.com>
References: <20241130140703.557-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b5c8de-b434-4bb5-998f-08dd11485ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWkwMndYV0h1MWF0cnNTRUtNdys4NE9qcVRuMUgzcUlMVjhwVTdOVjBXMGFS?=
 =?utf-8?B?Tm0wMXduNHFXYmFaYVNjVHJvaUwrZU5FcXl3MGhFcHlaTEtVZFB3MDhNL1RZ?=
 =?utf-8?B?NjlpaDdQbjRFOHAwTENodnpqZ0RFdmFXYmM4UlhFODlUVnlJVVJyeE5aUFRJ?=
 =?utf-8?B?aGJ3dzhlZzByQzFtMHZqNVVQWVZoTEs0ajdhSTZOY0FrTEJ0UDdCWlVaVFJZ?=
 =?utf-8?B?UzhKbUFNMW83UUROOVQ0RWtBd1V6Skh1M3llNjFvbG1UaXVFbHhpTUVNdjZU?=
 =?utf-8?B?YVFtZUJtZnFsZXlpV3A1VUxoU0NVMVJTSzBwWjdocmt4eUdSa09RbllYVUZU?=
 =?utf-8?B?UFpLdXcwa3VKMkFuS241dkR5UWhZVnJOZCtKVTNmQ0creDE4bUZ0QVBMYlZs?=
 =?utf-8?B?SnlRdUNJYUVDWXZRT3NIVWFNeHAya2tsMDhXKytKWHZjUmEvNjVCK0ZkZENo?=
 =?utf-8?B?bmNXRkUrVFAva1dnQ0xMbzdzMlNwT3l5bUtnUmkrelBCQ3o1Z0phUUY1N3RQ?=
 =?utf-8?B?eHp5U3FuYTY2eDRZdEs3d3AzVi9JUWxQUjNwQ0pvc1FpREZUN29YT3M3K0pi?=
 =?utf-8?B?S2Y3Y0d2bVNSSDBzT3JJRGdaazRDS0JqVGRSOHJBL1piQy9sZFpwZ1Z6S0Y2?=
 =?utf-8?B?SUlrd3lqY1JaUHVXdXpqUSsrWjNkZU01akNNUUM1RjNzdWV1T1EvNEhudnJY?=
 =?utf-8?B?dnJlMTBMUEdCUEZYTnFCdHFhREh5NGFYWWtZUVJuS1BYOXRJdHdSc3N5dXFC?=
 =?utf-8?B?WFFXOHBVYnh1RWU3VUFYcHpUamhoVFlhbjZPMEN6NllRWUJNN2NMeGZYRDd6?=
 =?utf-8?B?SFZmWUVhdFhvdlFDRDZKNDRxVkRuNnU4SkJ3WVhYQmhDR1FGS3poOEt3Q296?=
 =?utf-8?B?R3hZTTVUNm9kRzY4OHI5dk1ySy9wRGc2R0Y0eXRTVm5jNkd4dnh3SWVHNWxO?=
 =?utf-8?B?Yk5Dc051MHJ6K0dub1J5dWtKUUw5TncvZlo5MmxZU3BvMkM5WWoxOFI3d0hE?=
 =?utf-8?B?TzBJQWhDZDJ2WU1VSURYTGJkRmtweExrQ1h1T1JwOEttc1BJOVRNV1lSdUpW?=
 =?utf-8?B?ZXB6ajlzUWRlcnpOVlo1bVBnRlFwSTNvTC9QQXF6K29BVGFyNFRMcEpDUXRG?=
 =?utf-8?B?OVZWeEFlTTRaY2ZWWmYzZXdKeVRNbHdUTjg1N2hRWmRmUDNRcUcxdzFkSkdn?=
 =?utf-8?B?T256bytubkQ3WW9uQ0RxVmFBVmtUVmNqZEVQRWNKZzBhMnp4dTVCNGFoSzMz?=
 =?utf-8?B?LzRyUmgwVys0VHoxbHY5d0d2U3c5MUZNcDMyMHo4dndaVEFGa3Rlc3IzZDBG?=
 =?utf-8?B?ZGR1VmdIU1FEOFJuV2x0dkJOQnc2SlhBUXMrNzR4TlRYKzlxTmFRQU12Y1VV?=
 =?utf-8?B?KzllclRPTzB4ODA3YWNWV2xpWkdGOGxNZFBUbGxiMzhzc3kzQSt1UCtCcTdu?=
 =?utf-8?B?UHRkYWd5blF4MnA4TlVTbmZ1ZWIyRjFOMmNTNFIyYy9xQXU3NDBnNk04Z3BI?=
 =?utf-8?B?OWt6MXROeUhkeHQyWDcrZU5yckpKZ2JjSmMxb3F1RmxBNWY5WEFFUEtlaEVt?=
 =?utf-8?B?aEpTWkQ2WE5XREgxY0tTZjg1RENlNy96ZG9iWnBON0ZNM3VZTXVKZzVKZWh6?=
 =?utf-8?B?MFk0eU16aHA1c2R5a2hNSnM1NmlYcDBSUUlkdkFDSzgzV0lreUgzWUlpblJL?=
 =?utf-8?B?SGxLb2piemhrbkdpMzB0UHAvWFBaMnZIbjE2WUlJa0JPVTg3ZGlQRGtkeGpD?=
 =?utf-8?B?TzcvRkZyRVBnZXJ1dk5pcjdLUmNrMjdDSnR2MGZseElUMmxxY0YyaE9icFRz?=
 =?utf-8?B?TkxzRDJSUVhMZUxFam9KWjF0bXFkTHpUWGR0UTdGSytMM0VtNjk4N20xWHND?=
 =?utf-8?B?OTg2clFUeFJWdzNBS2VXdXQxbi9Bbm9FY0EzQ25rdFprb0tZSG42bUV3S2Fn?=
 =?utf-8?Q?WKFkrNsYeNYm6CL6SUFAkEYJKnkTVQ3I?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:07:48.0019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b5c8de-b434-4bb5-998f-08dd11485ec4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794

From: Perry Yuan <Perry.Yuan@amd.com>

When `amd_hfi` driver is loaded, it will use PCCT subspace type 4 table
to retrieve the shared memory address which contains the CPU core ranking
table. This table includes a header that specifies the number of ranking
data entries to be parsed and rank each CPU core with the Performance and
Energy Efficiency capability as implemented by the CPU power management
firmware.

Once the table has been parsed, each CPU is assigned a ranking score
within its class. Subsequently, when the scheduler selects cores, it
chooses from the ranking list based on the assigned scores in each class,
thereby ensuring the optimal selection of CPU cores according to their
predefined classifications and priorities.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 * Drop __packed
---
 drivers/platform/x86/amd/hfi/hfi.c | 196 +++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 2cd71d79a22c9..3c90e93fd192c 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -18,20 +18,72 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mailbox_client.h>
 #include <linux/mutex.h>
+#include <linux/percpu-defs.h>
 #include <linux/platform_device.h>
 #include <linux/smp.h>
+#include <linux/topology.h>
+#include <linux/workqueue.h>
+
+#include <asm/cpu_device_id.h>
+
+#include <acpi/pcc.h>
+#include <acpi/cppc_acpi.h>
 
 #define AMD_HFI_DRIVER		"amd_hfi"
+#define AMD_HFI_MAILBOX_COUNT	1
+#define AMD_HETERO_RANKING_TABLE_VER	2
+
 #define AMD_HETERO_CPUID_27	0x80000027
+
 static struct platform_device *device;
 
+/**
+ * struct amd_shmem_info - Shared memory table for AMD HFI
+ *
+ * @header:	The PCCT table header including signature, length flags and command.
+ * @version_number:		Version number of the table
+ * @n_logical_processors:	Number of logical processors
+ * @n_capabilities:		Number of ranking dimensions (performance, efficiency, etc)
+ * @table_update_context:	Command being sent over the subspace
+ * @n_bitmaps:			Number of 32-bit bitmaps to enumerate all the APIC IDs
+ *				This is based on the maximum APIC ID enumerated in the system
+ * @reserved:			24 bit spare
+ * @table_data:			Bit Map(s) of enabled logical processors
+ *				Followed by the ranking data for each logical processor
+ */
+struct amd_shmem_info {
+	struct acpi_pcct_ext_pcc_shared_memory header;
+	u32	version_number		:8,
+		n_logical_processors	:8,
+		n_capabilities		:8,
+		table_update_context	:8;
+	u32	n_bitmaps		:8,
+		reserved		:24;
+	u32	table_data[];
+};
+
 struct amd_hfi_data {
 	const char	*name;
 	struct device	*dev;
 	struct mutex	lock;
+
+	/* PCCT table related*/
+	struct pcc_mbox_chan	*pcc_chan;
+	void __iomem		*pcc_comm_addr;
+	struct acpi_subtable_header	*pcct_entry;
+	struct amd_shmem_info	*shmem;
 };
 
+/**
+ * struct amd_hfi_classes - HFI class capabilities per CPU
+ * @perf:	Performance capability
+ * @eff:	Power efficiency capability
+ *
+ * Capabilities of a logical processor in the ranking table. These capabilities
+ * are unitless and specific to each HFI class.
+ */
 struct amd_hfi_classes {
 	u32	perf;
 	u32	eff;
@@ -40,23 +92,105 @@ struct amd_hfi_classes {
 /**
  * struct amd_hfi_cpuinfo - HFI workload class info per CPU
  * @cpu:		cpu index
+ * @apic_id:		apic id of the current cpu
  * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
  * @class_index:	workload class ID index
  * @nr_class:		max number of workload class supported
+ * @ipcc_scores:	ipcc scores for each class
  * @amd_hfi_classes:	current cpu workload class ranking data
  *
  * Parameters of a logical processor linked with hardware feedback class
  */
 struct amd_hfi_cpuinfo {
 	int		cpu;
+	u32		apic_id;
 	cpumask_var_t	cpus;
 	s16		class_index;
 	u8		nr_class;
+	int		*ipcc_scores;
 	struct amd_hfi_classes	*amd_hfi_classes;
 };
 
 static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
 
+static int find_cpu_index_by_apicid(unsigned int target_apicid)
+{
+	int cpu_index;
+
+	for_each_present_cpu(cpu_index) {
+		struct cpuinfo_x86 *info = &cpu_data(cpu_index);
+
+		if (info->topo.apicid == target_apicid) {
+			pr_debug("match APIC id %d for CPU index: %d\n",
+				 info->topo.apicid, cpu_index);
+			return cpu_index;
+		}
+	}
+
+	return -ENODEV;
+}
+
+static int amd_hfi_fill_metadata(struct amd_hfi_data *amd_hfi_data)
+{
+	struct acpi_pcct_ext_pcc_slave *pcct_ext =
+		(struct acpi_pcct_ext_pcc_slave *)amd_hfi_data->pcct_entry;
+	void __iomem *pcc_comm_addr;
+
+	pcc_comm_addr = acpi_os_ioremap(amd_hfi_data->pcc_chan->shmem_base_addr,
+					amd_hfi_data->pcc_chan->shmem_size);
+	if (!pcc_comm_addr) {
+		pr_err("failed to ioremap PCC common region mem\n");
+		return -ENOMEM;
+	}
+
+	memcpy_fromio(amd_hfi_data->shmem, pcc_comm_addr, pcct_ext->length);
+	iounmap(pcc_comm_addr);
+
+	if (amd_hfi_data->shmem->header.signature != PCC_SIGNATURE) {
+		pr_err("invalid signature in shared memory\n");
+		return -EINVAL;
+	}
+	if (amd_hfi_data->shmem->version_number != AMD_HETERO_RANKING_TABLE_VER) {
+		pr_err("invalid version %d\n", amd_hfi_data->shmem->version_number);
+		return -EINVAL;
+	}
+
+	for (unsigned int i = 0; i < amd_hfi_data->shmem->n_bitmaps; i++) {
+		u32 bitmap = amd_hfi_data->shmem->table_data[i];
+
+		for (unsigned int j = 0; j < BITS_PER_TYPE(u32); j++) {
+			struct amd_hfi_cpuinfo *info;
+			int apic_id = i * BITS_PER_TYPE(u32) + j;
+			int cpu_index;
+
+			if (!(bitmap & BIT(j)))
+				continue;
+
+			cpu_index = find_cpu_index_by_apicid(apic_id);
+			if (cpu_index < 0) {
+				pr_warn("APIC ID %d not found\n", apic_id);
+				continue;
+			}
+
+			info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
+			info->apic_id = apic_id;
+
+			/* Fill the ranking data for each logical processor */
+			info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
+			for (unsigned int k = 0; k < info->nr_class; k++) {
+				u32 *table = amd_hfi_data->shmem->table_data +
+					     amd_hfi_data->shmem->n_bitmaps +
+					     i * info->nr_class;
+
+				info->amd_hfi_classes[k].eff = table[apic_id + 2 * k];
+				info->amd_hfi_classes[k].perf = table[apic_id + 2 * k + 1];
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 {
 	struct amd_hfi_cpuinfo *hfi_cpuinfo;
@@ -73,20 +207,78 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 
 	for_each_present_cpu(idx) {
 		struct amd_hfi_classes *classes;
+		int *ipcc_scores;
 
 		classes = devm_kzalloc(dev,
 				       nr_class_id * sizeof(struct amd_hfi_classes),
 				       GFP_KERNEL);
 		if (!classes)
 			return -ENOMEM;
+		ipcc_scores = devm_kcalloc(dev, nr_class_id, sizeof(int), GFP_KERNEL);
+		if (!ipcc_scores)
+			return -ENOMEM;
 		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
 		hfi_cpuinfo->amd_hfi_classes = classes;
+		hfi_cpuinfo->ipcc_scores = ipcc_scores;
 		hfi_cpuinfo->nr_class = nr_class_id;
 	}
 
 	return 0;
 }
 
+static int amd_hfi_metadata_parser(struct platform_device *pdev,
+				   struct amd_hfi_data *amd_hfi_data)
+{
+	struct acpi_pcct_ext_pcc_slave *pcct_ext;
+	struct acpi_subtable_header *pcct_entry;
+	struct mbox_chan *pcc_mbox_channels;
+	struct acpi_table_header *pcct_tbl;
+	struct pcc_mbox_chan *pcc_chan;
+	acpi_status status;
+	int ret;
+
+	pcc_mbox_channels = devm_kcalloc(&pdev->dev, AMD_HFI_MAILBOX_COUNT,
+					 sizeof(*pcc_mbox_channels), GFP_KERNEL);
+	if (!pcc_mbox_channels)
+		return -ENOMEM;
+
+	pcc_chan = devm_kcalloc(&pdev->dev, AMD_HFI_MAILBOX_COUNT,
+				sizeof(*pcc_chan), GFP_KERNEL);
+	if (!pcc_chan)
+		return -ENOMEM;
+
+	status = acpi_get_table(ACPI_SIG_PCCT, 0, &pcct_tbl);
+	if (ACPI_FAILURE(status) || !pcct_tbl)
+		return -ENODEV;
+
+	/* get pointer to the first PCC subspace entry */
+	pcct_entry = (struct acpi_subtable_header *) (
+			(unsigned long)pcct_tbl + sizeof(struct acpi_table_pcct));
+
+	pcc_chan->mchan = &pcc_mbox_channels[0];
+
+	amd_hfi_data->pcc_chan = pcc_chan;
+	amd_hfi_data->pcct_entry = pcct_entry;
+	pcct_ext = (struct acpi_pcct_ext_pcc_slave *)pcct_entry;
+
+	if (pcct_ext->length <= 0)
+		return -EINVAL;
+
+	amd_hfi_data->shmem = devm_kzalloc(amd_hfi_data->dev, pcct_ext->length, GFP_KERNEL);
+	if (!amd_hfi_data->shmem)
+		return -ENOMEM;
+
+	pcc_chan->shmem_base_addr = pcct_ext->base_address;
+	pcc_chan->shmem_size = pcct_ext->length;
+
+	/* parse the shared memory info from the pcct table */
+	ret = amd_hfi_fill_metadata(amd_hfi_data);
+
+	acpi_put_table(pcct_tbl);
+
+	return ret;
+}
+
 static const struct acpi_device_id amd_hfi_platform_match[] = {
 	{"AMDI0104", 0},
 	{ }
@@ -115,6 +307,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = amd_hfi_metadata_parser(pdev, amd_hfi_data);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.43.0


