Return-Path: <linux-acpi+bounces-18547-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF437C361CC
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 15:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600C41A22D5F
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38A8330B28;
	Wed,  5 Nov 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J2JSGTLZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C38D15665C;
	Wed,  5 Nov 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353612; cv=fail; b=AMs+52LAwkti/VOTcJsskjHsrMcOMIA7egeqTY39GtkklquW3bPYxrKNPb7aynWWoaYX139yLO/BIoocIwKbViu1jfBHwkq+jKF5RcOnFpALLeg9rdrbG8fFzXmF+eI4/Vht9QSuUZCT8GMtE8TPXn3VORI8mIixvvvDLgQce5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353612; c=relaxed/simple;
	bh=WkSPuxgsHn2guOlkxkhs9HZnuMHxLDW/9SNe7cmWC3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HX/3c3+wBKyTRYw8bNXAF4jRjXQBz4hChKxyu+/AeMi4+0eqhZohqpxtll2nPRrk/fXkZtTPQ1L4KYzu6RCq8kTTWzh2MaFWMUnHrRMkcwN80/JHJmpC7kRgQ+LxfoQC9eCWTIWBz11D10KsBmL3GnfrlqWun6do/7kQndPw6nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J2JSGTLZ; arc=fail smtp.client-ip=52.101.53.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmrG71TaPsto0YF+NRuRZPzqp17yTgPtvFhcbq6y+Qjg6SikvWdV3pLScTSuGEGgqO+gPTqlV8XMivERTy39YT3ZTiIcvjUnRhmv+wMnXc/LG/dCR/fPLQml0L2bXgDEJDZ5XPxNS0jNJwInpetJqHcEZWBAA8+q2kxXAiht4q5kdy70PAScAtIB6ctmDVicKihq3BMHgfZX/1BrICozd4kJNBTYc96UrFXAHc8h1to7s1vaKq44jmM9qmmalq8M8N4Q2QKi23rjrkjeE8YEwkXt3ou+Espwoj1Xh44HNvoMdpAkjZujocko7szBl0x3c7DRbzZK2iR1zcu3CukHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdeQl0sMfwa/Q18Rj5Epbfkiu1gBeo/Ow4XsYngWJis=;
 b=UA5GY/wANIDR2Xr3PUkRoh/wnuuR8dOUzkxI2omP7GMNrtt6kXW5Rj4EZKlHMWT6GA82YChTZBVBMrT9iY7yD/9U3ubQnHvDuSHoTIVscA7+ZThDk0BHmxuhomdmn+2jo90vbaxGpetL+QfWdZi0k8ii5wwBCODItZreaDntUlLAjpjMzA3RtA7c9PSf1yVLg6Nw1xO+QP7QEFsNi2vN1opZL9iPsvTPy5/ifcdIeQVVQvRNjhFbDgt02Y51GB5pw2yAbrJ/hqtpzmXS1H+eUJFLkWperAGcEA94p9G9jKedaa3A/BeEdTNpNYpoJXDN6MRlUh5UQ9xo8d8//aDU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdeQl0sMfwa/Q18Rj5Epbfkiu1gBeo/Ow4XsYngWJis=;
 b=J2JSGTLZEeEx8IQeJlnUPTClHkRrXQF4g/oVK5aUTcozr0vj09bxqIXTGHHS4WRMVBwqVZvzm1ViM+Izqwk0T4UgKAxiUhRXsG1YoNWAK4G3FK4wcMVdSBOp881z96luhQH2JS60hJEWDYwIvo/Rv8TIdGV4JfU419x0hKTm3GY=
Received: from SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 14:40:07 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::3f) by SJ0PR03CA0218.outlook.office365.com
 (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 14:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 14:40:07 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 06:40:03 -0800
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui
	<cuiyunhui@bytedance.com>, Jeremy Linton <jeremy.linton@arm.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christopher
 Harris" <chris.harris79@gmail.com>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 1/4] ACPI: CPPC: Detect preferred core availability on online CPUs
Date: Wed, 5 Nov 2025 20:08:48 +0530
Message-ID: <20251105143851.4251-2-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105143851.4251-1-gautham.shenoy@amd.com>
References: <20251105143851.4251-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 2229cb86-aa36-4473-1e86-08de1c793750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FZkZVZycyEqmXezp/NN2n5+0vUkNBylhTeApLwC1J5EkXE4RO2aMtuEs8OVp?=
 =?us-ascii?Q?+Be8uc9Fs/P7zxjNpmggokhnLPuz3ommwnyYM7TbFPw2Sf1KRpAI6RjpFEXq?=
 =?us-ascii?Q?rdQl+Wp8CDgPF/edp8yCS2ySPqs7wIKrEKeexSACWlWo0v3XaNf4OhRMz9dV?=
 =?us-ascii?Q?1M2QJ30QzG1uSxOgDUy3b6MjI62M+J4mihoVt0LCNQOuO5OZ/F/q9N7bXXoQ?=
 =?us-ascii?Q?WxjjlTTpTJMm/9kJhFtJIJ3yHSL889+9eC6RkfXJ5J1Z4UDg53Kx8n3hRxeg?=
 =?us-ascii?Q?RU3ZGxP+h13sNq9nQm/d7u7s64+ONYjC9pGT//gcpcy2lbthooTyN7hNejV7?=
 =?us-ascii?Q?VsXgugBilBjLw0nFkngdfN0dgZo6nz7fRRIDAm08Op4RwM/JRKSulfMq7rT6?=
 =?us-ascii?Q?pj4j7SUyAmFcEC2+y9iP2R/WagS8SG6GVVfIcVy/nL2nsxIUJujQJTp4nMuL?=
 =?us-ascii?Q?Fyg7yCfOOHDP46okZpgjXt2ZNrzVxr92qARgabnmKBwM7lFa6utPfbZxYoLj?=
 =?us-ascii?Q?ABtPgwAd0869cDJDeeUQ+NOxhi/jdoJexjAyGFfolnJdQXMFy/rJY6AQ5QA2?=
 =?us-ascii?Q?dCDYTh+8wck8p8FDrt141DPalHueDswqP/wbmC4+CFMl+9DF2bJi+SHW68k/?=
 =?us-ascii?Q?tnIBJ3QBvGl0vleSJF3Im2qvVRu9+4KwZLaavBU+GA2TUSrRkBJA0TvhCMsB?=
 =?us-ascii?Q?hpcLS5lI9lVgwq/c/tVwUaIu4r4Whl2OftSVgSfz9B5LHzpYTIIA0/yQGj6l?=
 =?us-ascii?Q?AGPsEnlhpeivljRFDOFhucicdOdu0NNxHmTqcAyOIvkN3omJY1rgQf4gNpEy?=
 =?us-ascii?Q?FUwrIAUN4FgaUXn4oy+JRbhlsfi173Hbb2Ed6+FBvgv/yS+NntwaUNfJKMRY?=
 =?us-ascii?Q?Ba7Y8mxXKdyF2fRX6w0axAI88Gvb2dRPbN8ROJa43DxHjnONQUe3l49p6cN9?=
 =?us-ascii?Q?odSlntF2szCfB4onCNQ36yW95agFZkEeRccaL//zb6OrLYtEUPrd3gkb4ikW?=
 =?us-ascii?Q?baBdatJh2oPFGLHVndAndR3ixPT+k11eOeQ2DgByubKLQFJ8Z+9keHwTmxUJ?=
 =?us-ascii?Q?1ZWy1DDtcmtUvCaRx2+C2zLeeGVzol+nIovYrCMahJhH4Nrw+boN6N/oakvQ?=
 =?us-ascii?Q?lfeaqVXvSShjw7hXhqg6ydVj8JULXMvBdmDxGWGc3mUw3ttLWY5fO9w6aETJ?=
 =?us-ascii?Q?uvWIM0oicbSU0mC3NZNt8DUK8xeLzftFrNr1seWgC+yPSBmO2tUXurlnNEJb?=
 =?us-ascii?Q?V/Z7V7d6odA+sVCOB4880kyqWkIHGoOFFZVIGsheKAsqmQ4JrROSy+kGaXuh?=
 =?us-ascii?Q?rFkS/UYUEnAbiEEnM1qDDs8TEjqorxzZ2hG2PZiOCrSce4rz3PGorRMIgOGm?=
 =?us-ascii?Q?C9DvvRxuh+VrHlSJpqMcOflGj0B/m3lO5bBuIatFcR7yOFciIABRX78V9RzR?=
 =?us-ascii?Q?YBd6cvLFlWv5l1X+eo83iKNtUwhZbEyJ/uJ/vGPYVFtwh7D1Vdv3yIWj7Bhr?=
 =?us-ascii?Q?I0EpvZZcedEXbDrjsZ4YsBCXtcO3MgzV7orkm/MqSn1Y/6DOVRVe3ErjQYCC?=
 =?us-ascii?Q?gOiFxbIQhUUKN0Cxvk4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:40:07.6372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2229cb86-aa36-4473-1e86-08de1c793750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083

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


