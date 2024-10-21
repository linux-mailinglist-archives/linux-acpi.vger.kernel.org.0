Return-Path: <linux-acpi+bounces-8889-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6F59A718D
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 19:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8C81C2132F
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 17:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A951FA27A;
	Mon, 21 Oct 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AsdNZ3fG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436831F707F;
	Mon, 21 Oct 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533415; cv=fail; b=tLZwbqKbQTSZxRG6dfGLnjDxy1cwjX2+x5hcfYSZQj5flslba1bqaqBNV1DoCETlpwwIyK05pVJES1GQfY1EqhmcOTiEgcLnz7BHh6NAhvXi1g4jZ/Pd1KiJZfnwgAwZndGyxK9U8BAEVUxWHAGNXBWCvYemIMUR4A8LkWxToUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533415; c=relaxed/simple;
	bh=7HxiLM96a66bvTgj1JOg44niaVlqWwzj7vq05ju5vHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XflBc5CqmV2IzNvbktjby10k+/+y54p1uaq+2P+PIaX4fEjIsud3vrUs4niSjmd0Y3oSMlWhuZ1ncOkLg8K0ZKqDwaY+kt394HNBaSHV0kDceUEUCet1Vsnhu9i+Sebi3r68VczmKZD0BZT4/ORmPCUzlxhWUsjqUy9yOYB6IiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AsdNZ3fG; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNHB6/vvALIhY7Br096zXgIsn7fo2Ex8rG5DQvUbYVusgR2beqXHiLQTwrp0rk6rjVWp3H4a/sHLlkvZHLBMa+hLOpugEdjOk87MtmROgPwIu1NbDwuUZ6QoQ3a98Xw+imNZwzxS3e7WD14NFNv3hfk1ZrWeSEGWbDR+7yhfvFs1SRIyri9Rj0jwpJVpOfnIpQDRrXoka3NdOXMAyvdPisJTr5v2TVKiX7ty4Ann7isPnrx9voSWu60W99vLweUU1KJnZGryt277ku3AARUacGRVod3+t/o0aCtWti+qdMWUyLlem7F9iaDVho6CyzydAJsNkz6T1xvue3GI3vSy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72Ltp69SdFXvdS7XP2fG/0VBuWMBscLFbvmR3zn1GfM=;
 b=XYfhA+YAt+LPv5HvhFsrJXHKcbgsPUUwg1OW98NJpNlP2NuWTpamQR+GgiCm5fiPNYEuZ0FPCsRCv3mBepbF5u7U36YaB/1gqlVDGi2pc9AhnqYJcn50YxualoLFw0TCFYNBr8GijOBYW9ClLfbTkUwCGs48e8bKMv4yqoNEhPKW6SIUpI0q0XKYNtDIoLCNj9k77Akd1C4O7K5W4sfF+gjc/lv6M5+o99dTH9xJnBw89VUt7q0sTYzOzRXW2ZMwgnBB9rke78mGhMK5hr9dh6UVnlPh7ZAuMWtcRpG/srbAtbQYy8ExvPB+Fm9CAOcY5o2mrRUYlbZ/y+tevr4+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72Ltp69SdFXvdS7XP2fG/0VBuWMBscLFbvmR3zn1GfM=;
 b=AsdNZ3fGvVtGJX4kj9e6x0XtCfgU7VvXiw/P+ndJLrZZmQILSuDb6L0P6DwvsQ0e5UY/LPg6rVpnyv5UqYAk01pF3jPxOwatMtxgtAXlzHIxqdYwWIRqp3xO8t7NCjvaQ7TTNRKhllqI55atZ8/zpXlM9F+r1r17t/I1GCOSWJM=
Received: from MW4PR04CA0365.namprd04.prod.outlook.com (2603:10b6:303:81::10)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 17:56:46 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::e4) by MW4PR04CA0365.outlook.office365.com
 (2603:10b6:303:81::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 17:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 17:56:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 12:56:42 -0500
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
	<linux-pm@vger.kernel.org>
Subject: [PATCH 3/4] x86/cpu: Enable SD_ASYM_PACKING for PKG Domain on AMD Processors
Date: Mon, 21 Oct 2024 12:55:08 -0500
Message-ID: <20241021175509.2079-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021175509.2079-1-mario.limonciello@amd.com>
References: <20241021175509.2079-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2090fb-22c2-49b5-1ba4-08dcf1f9ba57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PTJE0znKWrEyCrlux8MzZDo0p4SxZPOXvtqeZEGZAmfPIheLBq6msrItQ5Bu?=
 =?us-ascii?Q?UrtNar1768oSNec94RYrwwVSiJeI6fVNHEyctteLJ0SzwV0Ka+1nWuj1myHf?=
 =?us-ascii?Q?F/0T5bja8zsLIPcMMGZqsP7Q6DjA04+LFfMDc2TYCSw57qQi1QGOBK+sNYil?=
 =?us-ascii?Q?0lRDgbXHqXQdHAr+fOIDqOaRtfdyULHc7DTlYjDerQfuq/ZW7DmT8u6ayto9?=
 =?us-ascii?Q?tebXA/ClIThY32s/LHDuugx2chHtPCOVKPYNBf+T+t3Ydkoqz4mfF2SRzS5i?=
 =?us-ascii?Q?CNZExEK2wZ7kdcKEiezduPk5DFMOChH3kjvJZ4zYIHtgnl0RZaayS4/ht7f1?=
 =?us-ascii?Q?xxDArg7LLj8JtWpa84V1maMQ9IFNmb5vBy4HXQy5tfSCN1XSC4vUytXCzxek?=
 =?us-ascii?Q?NU/LXEWAsYXzVVF2g7yLHdTsBzBAA3DE5HbuSE+Bo1OyWhvMzmiNPEIoV5lR?=
 =?us-ascii?Q?RgDTHHyJlcEE1bVKuiu1aPjG3Tg4iwx6mIV3MbhMsihxgiFafkzQBb+1kT+U?=
 =?us-ascii?Q?zureeyGoKBgln+7TEYbUbkHQlJUe3yjGLq6xGs7sxJlxkHoxzd8tyLfIImbu?=
 =?us-ascii?Q?bFZESowaAbFVz3EvOrxTODuSpt7Rrz9CftZyLd5v5c5y3FHHVRbqGeyRhB9u?=
 =?us-ascii?Q?UG7Fai/e7uG6ozHjIAzxQp0EgG1pfaMARml4Bm9ZlPAClE2KC2m7UT92IGbs?=
 =?us-ascii?Q?6pqkEFMIEB1cJlsWB/PZLZ63pe9cgbouJ+hT3FHh2eTT0T2KJ9uhgJg5/1t/?=
 =?us-ascii?Q?qW9lg4H1D9rTiWbEGLqk6RGnpSio3zM74xSDqemg+YQ7BHSlVWD1GAqGYCwc?=
 =?us-ascii?Q?qUj4T4Mtkw1fOOZUI0MQ/mFJnVT195fNNYl38VTOIo02UD5ngP+Ba3BmWZv/?=
 =?us-ascii?Q?T96DOMIVMDNArVCJDxNeYDzbBiJGLDPe6YdoCtst3q6vTNZ0RMpqu60GRUne?=
 =?us-ascii?Q?CuPGRdqD5h8RUM/yMleY3wkAK7y4UmcUVuVy0/QI23PJj+W4ftDNvxFp4rqh?=
 =?us-ascii?Q?Rr3imhCtTGd3K8RoFx3GXRJah/tWRr+av2AT2BxwQW3ialEEkx7SXPDtYw4t?=
 =?us-ascii?Q?YSaOkZrUUYWRYgxdDbx7Z9v4+Y/fs6WjvnRn+Lvdpl73sizWL1PzdvBv3zd/?=
 =?us-ascii?Q?xh0XDbJ0aRA+zuGvJJ7hDO2vLy+Q4XzIgAUlffMfWPlBcIymAfltZdRQHwA7?=
 =?us-ascii?Q?fDquPCGOK2ClY7ybcnAzYLz1EeXQzuh6/yF3uYeaMhrpP9JYphmg9Zp97mCq?=
 =?us-ascii?Q?BITosWeWWX1WFL2xPV6LAmkqq/kqeaA2NNB/Ox530zjcSC2Wuu6Ver/xJMf5?=
 =?us-ascii?Q?rSafqhtZ8qXtORrTbAZ+ycUIqzup8c/qPa/qKp6xqkBnOuOMxp0EHXp1ajQg?=
 =?us-ascii?Q?lrDNyEiD7ZIL7xKrVSuHHUgKRd3KfpGCVMjVHEghjuRxk5orIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:56:45.4095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2090fb-22c2-49b5-1ba4-08dcf1f9ba57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

From: Perry Yuan <perry.yuan@amd.com>

Enable the SD_ASYM_PACKING domain flag for the PKG domain on AMD
heterogeneous processors.
This flag is beneficial for processors with one or more CCDs and
relies on x86_sched_itmt_flags().

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Rename to match correct x86 feature name
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


