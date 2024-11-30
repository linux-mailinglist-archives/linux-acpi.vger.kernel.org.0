Return-Path: <linux-acpi+bounces-9825-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D64CE9DF0F4
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F14B21400
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFB91A257A;
	Sat, 30 Nov 2024 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z5kyEjIo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC21A0BF2;
	Sat, 30 Nov 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975670; cv=fail; b=Xw3IoP1xYui+i6sRgV0Sfft95PahD+2hILUwiRgV78tcd2yat0o/hy5pwXJppvWEEdH07chuOULVdr3wRI0QZ7H4opHl2c255GP/3i49HjZjXSy12ggQgxB44sssfOXOl1PTie6SMN39K4EkBmIBgZndMgV4VOGxSJN5dLacX54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975670; c=relaxed/simple;
	bh=6/GNpT2p5G0nMQWNGh63AxQqGIghyA/swYKFuepemJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVIgNxzUmdd1gegbbnQBmkrorAS0Gx22dgfX1CBqxo3cJ2FMBtazeVF39/AnAFyaCx/fRD4YJefr0OHxlGYf+RQDsI3ioVPFicu9RJaSRYmRjv8L698vKhd46YVQcJRgH9lju/YOhb9dcQAdZZRFkBvOh61EJgQZMxO3Dskr90U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z5kyEjIo; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmL3kIO/B8ywxAN93jzkR7uMb06KiVPtx4ZsBjDn2F7z1rOtL0wuX1NWuYCyowqmrAIYlJfmRsXLrPxsxh9DKEFkk6lXVbDCfJ/BEP3R+5/UPAirvAHz6ddIjclIaAlYOHArEDTIUmifWYa2374IPfY15htpFHOczC/nXZCf2Xsbawlo4nuOoSZ00+lidl+zpSEn7AJHJAb0/qmBkI5aT32veWLDyWXTqRr+nJNdWrnkoaUouOsWb8VufgUlHaBRF7CSrKsoUvh/XFwsLdtuU2eKPPw5shBjoSvF8nom/T3kCknjWUwk71282nE+1ANvBS7S+MFC+OmdSrZP2Nkk6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK4bqI2kTIwrrtnwYodnqVtCHNR2bI5U4bV4Sc3i77M=;
 b=SldC1lYZ8tJ1QPuMf2obB/Ypomm3f7RwEI4lofL13uVmMStehE10MK/LBt+wdrLox4FiwrCPunuoJcFV94VC55JmXSmJBaaGxR7hmfx6ZTKj1LlXIAyILH2Ogmc+7HcPTUDEJeRdqVZbGv6J8JK88XzzW1abKbx+5AqQ3zYn/Aegbov/Yh8AJh3xEoQiamDT3HV83z3drCbCohXKEqO8/wONiVD8X+NT3NCzLl7aRB4a6Y4foqxUxY7iNG9WzgAf5+jum8OMdhjzIcdq4svUSMWRX5wCAX8pyIk4TiiMTKeAEqwj1RoP5iYmRYmX/iCCAGFR9YC4LOaJjr7z/CEfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK4bqI2kTIwrrtnwYodnqVtCHNR2bI5U4bV4Sc3i77M=;
 b=z5kyEjIoraBV51CI51SsV7+uEcuGJ+lvMRLqeKJh5Q79bh5R7F3kGTs/6+IDMC4gs2qmGzbOzQAj7vtVDGXcOaSXqQYCrYQAXeEjkCMyc3wS/hp3eulAA77IlbUDmXkNRywCkWZPZUw5QhOvehciPe5BPsTXuummfPXo2LKsdyE=
Received: from SN6PR04CA0073.namprd04.prod.outlook.com (2603:10b6:805:f2::14)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 14:07:45 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::a9) by SN6PR04CA0073.outlook.office365.com
 (2603:10b6:805:f2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Sat,
 30 Nov 2024 14:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:07:44 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:07:42 -0600
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
Subject: [PATCH v7 03/12] x86/msr-index: define AMD heterogeneous CPU related MSR
Date: Sat, 30 Nov 2024 08:06:54 -0600
Message-ID: <20241130140703.557-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce1e6fd-8163-43a9-612c-08dd11485c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UHpOiwgRe6FxkV1ExtxtDm0ui3D2bCczv8ZXlNg6c3yJRZlfKbpxYSIGNkvq?=
 =?us-ascii?Q?zWusS/QxFhkxTZvOQvdlU4LySssBmV8VenXhHB/bG5nUcQXIaFNDC9EnBWQo?=
 =?us-ascii?Q?MVZ1wpAuUOSuj+1axhoSYK9x33BMmrlVghwuJVXTlQgqmEt1jjes215oVzmV?=
 =?us-ascii?Q?lRU+JmOiWFbtscJl35xRGEK0O/bGVfP6XS7bNnSDlUI2mRQIyCWr+nQk9e2U?=
 =?us-ascii?Q?uXgHsSO7zVAtXSD/8bQh1XYl2HGlE5DJ3lHu+4JOS8mFnxFFVXHAH7s+bd3H?=
 =?us-ascii?Q?RUj4JYp0U0v29j+9DztKiIBZPlNct6adeshdxOnrlXE4uxhUS3N/Sjmg2pr9?=
 =?us-ascii?Q?9RSENE+JbZkG/D4mAj8MoYsRYOpnUejl+dsFQpXvb/YKM9uTjVfKykIdVKa3?=
 =?us-ascii?Q?2rbcoIWhhdCwoFuq3v5WafEBrFw2KhNWlRtSSBe0ndgguwt58hyUQn0xhrtl?=
 =?us-ascii?Q?fKR6ASRz6kSRoybEcuM/GZl76umLkRMvwDbr4lE3YS8oo9+U4NQ2g8gvhtz8?=
 =?us-ascii?Q?V6kquegOjRhjSstd81FYtsosSyZtOlfO7lpwjnQm7ZbVrN6gh/1IUvEfJ6Ai?=
 =?us-ascii?Q?Lq11cxpPO0zt2XDN41tohhWkrmhDlhyfL+6DefMnzGGvfI4bloZFQheDHlSM?=
 =?us-ascii?Q?Kl+D3v+ULQTMF7uLawXVSUi0hyvhukA2icdR93E1FIKQSXwJhfQYRLzxyfGE?=
 =?us-ascii?Q?wDSBCAwptVCBQ30hxzU7X1GAnWWtOJshl7ETAUjnGGonmRamuspYHV7QSY6b?=
 =?us-ascii?Q?F54f+/2+xs+RtA3ET9OG/mb4Hnzw1NIE+Ww+k2phgfKf1mypfaRIGxWu45Wk?=
 =?us-ascii?Q?7KteaN8ytAIriIGg7yqbLPi2jUn0d9F4Uwy7sq9xQajswe1cwGMcDFxO6FYK?=
 =?us-ascii?Q?evxDZd03juqwTC+h7K4yrP66F6YNyiObDvMwM5TMP3+7KiTcRaxYa8zpuX0/?=
 =?us-ascii?Q?BiLinjek2nvqkqwg+B6VK8uNQASN0WmVUvcFuqwL57dL9F+5+DNuQ5kOsMMs?=
 =?us-ascii?Q?FEueFwmft6GNo+rLm1lVc1tlCmu3UsCRvS24hPSgvUBiYUealKiIu1y8RogH?=
 =?us-ascii?Q?prb24ajQs54svPn/h2h053LwBSjAqOBpdRzlI7AiJsRPsqXxcbT90A4qkEHv?=
 =?us-ascii?Q?xHbEs0WTjS/bt1yvWYvYL0Ky5DWCn47oaXhKvGFfWxam5RBAPWYpDE51TkVX?=
 =?us-ascii?Q?DhO0LdyXbaOmwIDo/0AfKRsOZYgso7dH6ef3RT/c8q+6HaIc1e1zDBIrUbh/?=
 =?us-ascii?Q?icz0DWQAnSRimbiBrZoO7dKSEhZoR4oq5GR804Red4GthJsNcgxA8rMe4Tcb?=
 =?us-ascii?Q?tMRm3Nm3fWKqg1BZAW+1poKFnujVHIhBbEJdz7591pOM8uzSVQVJjDEefqGs?=
 =?us-ascii?Q?ZTRdrrgrleyqSAau7S3/bfIuegY1nmScIgYKZ7lQeID50eRps6B9FW7JsBLA?=
 =?us-ascii?Q?SXm+L0YJf5ZNpyITS+70yITsbAXtPX0J?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:07:44.4742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce1e6fd-8163-43a9-612c-08dd11485c9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339

From: Perry Yuan <perry.yuan@amd.com>

Introduces new MSR registers for AMD hardware feedback support.
These registers enable the system to provide workload classification
and configuration capabilities.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6db..0cd5ffe50f4a4 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -712,6 +712,11 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Hardware Feedback Support MSRs */
+#define AMD_WORKLOAD_CLASS_CONFIG      0xc0000500
+#define AMD_WORKLOAD_CLASS_ID          0xc0000501
+#define AMD_WORKLOAD_HRST              0xc0000502
+
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
-- 
2.43.0


