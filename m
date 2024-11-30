Return-Path: <linux-acpi+bounces-9831-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BDB9DF100
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99BE2813FE
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8641C07D3;
	Sat, 30 Nov 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o7mYeOCU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE81AA1FB;
	Sat, 30 Nov 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975681; cv=fail; b=e59cw0UZEXrQkxBVQh3/UvHsn/JeUlkkbsODBLJYbqLHHNkiUPp3SnQngeYQAhEuf/LMvjDZQxXNQ+ocb8xSdV36vMTt5A4XuQXnWd3ZxC0foQSNvPSCaUwb3qj6l0yWA18f81WAx+qFVJJsTUQxej8oB9ckxK6dhVd7E76QRYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975681; c=relaxed/simple;
	bh=BFlPzCKDOQ/lwYLxGzA4h0BVSXB32LqPDTE4h2a/b/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rO9iGML6dgwSeW7EejI2ATE/DrVFVSJuaAbYKPC5wUN/uhHu3LyaoWlx1oLvh+OiE+Eood81tspmyn/cZXk7s20qqPR9zVa702lG18OkWSNUQkd0vMdHp4uWmFPippQ6jmDi7WnyIR+4ihJ8dHxwqldMFgJ3E7R6CFTaG7OTK9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o7mYeOCU; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxW7fQP52ckhT0+KnMFo+mT5CDfvM9uspwHTq5NFZbys4bmGCzAa6WCmtggYJm29ktbd08j9CGyw1+/uu6hsPLs5fylve9+QVzRFK6AdTKczuOK/btDeQ848DKjGdeqNxumT+AtXJyfqSTJxxbbTJTOiNTco+koIR3af3Cb1gTxc29d3OewcGtsX80LxyYm5UthahNR/XYN6obyUqiQNjdJ3Tdt6p9EdZUauEcO4OnsmLcgFjz+azYHvk/c8M6arFYqc1KH4eEQFhuUBMAxv6DredJds6KoFkoJ/rYK+ztPB5j2Yw4ZzKWzqHc8s3I80CjMfP/p3C/15rtSDlJQtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oye4hmxA/QeIDK9bNf843lF0pJB8f8VefTi8+5z/8WI=;
 b=vSrMl9ka8kofW/uNcGfRnS7kjJTJeotjp7eMVPTDcmla7QwgEsmDZ49Q9txWUnEClyxFbo6rZBqfl32E3AYCOw8MHDyPNQ+pm1tX7kLiyJ2lWX/SUYfRQFqFzMkxOAXI0nh/QIVnCXPMZ75CzqjWMIBGm6H7FVBjn3EYzmQ3SFGii65vrkTGRN0XYwjjPvIk+ElBMMy2s97V+s9AsYb/Movi9u+6T9dXC4o3JVYhiVFCJC4vVMv+TapEk2ilMmCRmp3ZVf98kB7Ib7DQSL0prnaFyDmwyOrCHRSkiJ/2XyyWhbfuUXHYl08BOBRMQm1UMrQm7gdmPZh9p6c+InIDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oye4hmxA/QeIDK9bNf843lF0pJB8f8VefTi8+5z/8WI=;
 b=o7mYeOCUUrXId0AOr7pUF7jqPWrgc/TIFeMw8R2OcTwaoYGs0tSmz2pVDnfhU2+4ZWtZFkAZsJCpFhDKALcSjsRi280L8+koV6IPGNbKK2D0CYXwBEp3+v4SDm6fAtW5iwTOKqhRVLkOOWtsQRyQajHmIlbjRa/izuFlDjlUn5c=
Received: from SN6PR04CA0089.namprd04.prod.outlook.com (2603:10b6:805:f2::30)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Sat, 30 Nov
 2024 14:07:56 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::4d) by SN6PR04CA0089.outlook.office365.com
 (2603:10b6:805:f2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Sat,
 30 Nov 2024 14:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:07:56 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:07:53 -0600
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
Subject: [PATCH v7 09/12] x86/process: Clear hardware feedback history for AMD processors
Date: Sat, 30 Nov 2024 08:07:00 -0600
Message-ID: <20241130140703.557-10-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e5fbaa-fb8f-4c32-d6aa-08dd11486389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?20oCt3Wr4P6l9wML8eZYtw3eD8/qfi9MoaPa2+OdKarpd1TX/AL1VGeanB5s?=
 =?us-ascii?Q?EusKqbywNDmmmdbUAG/r4BmPGQ8Jwi/Pn/43nFUn8KD/ybJGfvXhGThK5SKf?=
 =?us-ascii?Q?ZTIlj7BimrTZOWtJ0hS1yNq6w6K72JjabpWZtj6X+0bMllI3MUhZJyZhCOaR?=
 =?us-ascii?Q?uGlPAm1saEu9hJI15Y7U+lqsnXuP39OA+ILvI0QKxVescJ/Ds0/pPS2lm6Nc?=
 =?us-ascii?Q?B4CUdIwlqKNdszzh9Ad2tFQuBbbswspuJgOlVoosD3r4Oqmei9SEL5/w0XCN?=
 =?us-ascii?Q?j3Pd7RBwEiDyXtfhnTfnqxAzpYY+R0C05ed7k0mZ1DxnYZsG0KKsoU/NPZhe?=
 =?us-ascii?Q?CJbCixlepWpVnOSH9+jAlMcU6e+YLSHJpwU6FqLsOy7VJctMQk+n9YDJkcRk?=
 =?us-ascii?Q?ZZr/VhbwUe3GdFOllh7+GPi39xxby3le12wzwIXgDnGdL1tSHwCyPbORvyPq?=
 =?us-ascii?Q?1lmtSR8jxGrp+u+OtZke0PD9dAwBm3PT4isEWlZ7/MEbhMeUT0gd+9koT68q?=
 =?us-ascii?Q?/1PCh++KddyCSj0XiE0TH6saJuZrTUK3d/F5IUaP58Wv3s+Hu0AYiwnkO9vC?=
 =?us-ascii?Q?8/Js6QyxmrQUsKILAbpscm0iVFMcWLaPchAZH/FS/knTJaBKW1VSlHsNxm/H?=
 =?us-ascii?Q?1u5ccjdXmAB72wTHBNI/p4qiQB8bTP59SC9O+t6J6mgXuM8LQ5ZI0O706KQj?=
 =?us-ascii?Q?PAujO+WKR53XTg7a5oohJyxDSmAIkHFzG7ODvpcHfE9GYNW6MLaFCN3zQvvM?=
 =?us-ascii?Q?HJyYmtZURPFz4AjC5ZyO0cKKszOgVFiB0ar5bEX49h4vaNN3zbb6FpzIn3ME?=
 =?us-ascii?Q?czhj8LSqTV5YOqD/QfEJo2hqt7XKDihFt+04pUw5wTlxQWONgC/S+poJy391?=
 =?us-ascii?Q?coJ7GJJTBeuWg98zlfCNN4wjqLjrlurAG4AjRljaM7Ckpbm0XA5Mj5mrCjre?=
 =?us-ascii?Q?YOcZgSJQ/TvVr2bBOK3DQe33U1L0L8NEgZ0S2+lqKl4rh84LdRQqSILn5dGm?=
 =?us-ascii?Q?RTnOmF9/NvEPARkPu9QSZ7ZNt9jaENvbh+S81AwUhLBEkPtCiGQuCYuj3ZNb?=
 =?us-ascii?Q?cFwYn5w6RG9p7mMnpQxk3tYPpklrEXqX3hr3wiOWrnpR+ttD6u90QqGsfPne?=
 =?us-ascii?Q?x7x6PHbN92llim6MGgNn61jCBS4kWtVi3e1gWjok/+I+T+Pwy6wnFHRm4Kki?=
 =?us-ascii?Q?tcCgSH/hnE1n4455Dubj2q/YcGko9/wKDU9T58OBgAnGCBmXDfnmigJmxYAO?=
 =?us-ascii?Q?Vtk2FNIr5CwbAY+N0rD6V09FvT2BosNXedevnQg6kFQGx1vJ8eoSMsGLQi/s?=
 =?us-ascii?Q?4Vc74tK7egni8XJH4SZPAfxzasrx9jcivRM38d0PvxoTdRI2+Lf0dxblFJqm?=
 =?us-ascii?Q?Oily7fONVoL82+En2Q6Vlub8iR8soqLln8ob11k6j/xL8iuGLl+DH593qZkV?=
 =?us-ascii?Q?k8cZvj3x53MDsgude9fe6NjJnehOZnmf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:07:56.0836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e5fbaa-fb8f-4c32-d6aa-08dd11486389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707

From: Perry Yuan <perry.yuan@amd.com>

Incorporate a mechanism within the context switching code to reset
the hardware history for AMD processors. Specifically, when a task
is switched in, the class ID was read and reset the hardware workload
classification history of CPU firmware and then it start to trigger
workload classification for the next running thread.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/process_32.c | 4 ++++
 arch/x86/kernel/process_64.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0917c7f25720b..0bb6391b9089b 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -213,6 +213,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
+	/* Reset hw history on AMD CPUs */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
+		wrmsrl(AMD_WORKLOAD_HRST, 0x1);
+
 	return prev_p;
 }
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 226472332a70d..371e0e8f987fa 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -709,6 +709,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
+	/* Reset hw history on AMD CPUs */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
+		wrmsrl(AMD_WORKLOAD_HRST, 0x1);
+
 	return prev_p;
 }
 
-- 
2.43.0


