Return-Path: <linux-acpi+bounces-8936-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12389AD30F
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 19:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB471F2171B
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 17:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B8C1CFEC7;
	Wed, 23 Oct 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V/lM40Y9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099231BCA07;
	Wed, 23 Oct 2024 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705487; cv=fail; b=Yb57ARw9vycTmuJ8I/9TS7AjOd81MSWBTM1WRo1VuHxC3HqJt7OEKbfv2ipjXiSsq/u1VaiFniXXzhVVyGqrTMIhLmWSR5+S9XaGXaObPaMrnhC+9mnXFnuAawPBCmXtBUB/78Y4mN1UgSa6/D4tdsLka3S+cGAdr88d3/sxc1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705487; c=relaxed/simple;
	bh=Plpaew6OcjYJ3boxDMwv3bLOAsi+CZaMGQTANUmHM5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rY393UofaNiiV1J8r+HS87g9hzCU+1bQwRpmKNSXVfT040f/CpqRtI4sBjI2kzraiatqrDhoOv883nFv8EsxOBljJXDrPt/ewq70LUYwjLp9fRgN4Mek6t7vn4JiXnMBkIARhmEw2OZrp5k9PZEdizDwlPAZref9fMnBfebQRbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V/lM40Y9; arc=fail smtp.client-ip=40.107.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=it4WgkHNDr8HjlRh4NsKwZy+YxPt/dpD1RlWnT83r1GHRAfHS/sPu4ruB+swX1M9tkySgeJq/9iVEC8d9Cz2pb1B2tJhKd2d61BBfKqsqnPrc02KtXqv65XGHxrbjA7Bc7hbsmpEx0AQIh+FXSxmWhJKpe+f3SlX/PLXi+dxtWoWhB56JMHIcovq8sFGdOf6hNqjBSjIH/Vw1VFMGSZkYfJkhjpob0jCbZBML8es1bLsjF200drrmlJyygTKUql04Sde5XjXgdDyzCNeCeEdRaTVe0q2uBT4Xp95mKSJ0O5BDgz532BNw722UfaeNwD7fUeKJo4JJPVhftU5My6lpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUSFho06aSLaoMID3uGBG3sYCSv+5pvelFzxIkM5jSc=;
 b=BC6hRIQ74aHE9Qs7jxvUdQRZUcmMSJ5urANSLeJ+ACmrwqmLcghnsKmlaHmlW7YKqFnwfenXZ/MJiGVYifeR/K8E5XqFfE+76y1gMFGCy42NyBKp93drazcHCVV4JQnrk850p9PRs54a2h3MNsRwm2r3fI4eLXAchGfoK8HNdEEsCC/LUIroAGA+k5hlIbFuBkY5sSQY0HBQ6yCx/AVmP5C60iQms5RcCce5hQIVKunqbnXN2Vtx+MO6M6zR9oCaWpMpQ9wAHlpeHQdzXGPwQ9MuQvaMrL5lkI9BxJ2xlA9zCTwc6LLBh6Ad6lvqesoahjB24eEmsStSoWF2aiJz1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUSFho06aSLaoMID3uGBG3sYCSv+5pvelFzxIkM5jSc=;
 b=V/lM40Y9J81GeWeOwBuP/4ZFZLWrpJ4R0f30RuvLZYULobexVTCk64LVPoLDTjb1il+iGfDC40AXtVO1lBK0S6r3cVnsAincCZ+DoRi38ePq0Op3CV6/nGxII82wGEevNmkb9cc2eHSezyBlh3IXJ+P1i2QlUS+arB82wRMkdWw=
Received: from DS7PR06CA0017.namprd06.prod.outlook.com (2603:10b6:8:2a::24) by
 CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.19; Wed, 23 Oct 2024 17:44:42 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::4c) by DS7PR06CA0017.outlook.office365.com
 (2603:10b6:8:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Wed, 23 Oct 2024 17:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:44:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:44:38 -0500
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
Subject: [PATCH v3 3/5] x86/cpu: Enable SD_ASYM_PACKING for PKG Domain on AMD Processors
Date: Wed, 23 Oct 2024 12:43:55 -0500
Message-ID: <20241023174357.34338-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023174357.34338-1-mario.limonciello@amd.com>
References: <20241023174357.34338-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ddfe8b-cd4d-49b9-c4b3-08dcf38a605a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NNtnSzRYVeTPP06gFQTOdTYdo3Gi6ePGbhVAMbFcmgbxqua0fqek5t1sIOmq?=
 =?us-ascii?Q?ltwAlS25913oUosfrh/8lp5k+mUOXKJbjQM6BKyVRNF5082QeqND1h0XaBEI?=
 =?us-ascii?Q?WfYyBwJsVkxTUfpz00pd6dSiKCexGlM1OC7eCo+IfH90yjdlZ5o6gnqfM7D1?=
 =?us-ascii?Q?axL00AQcf8fZtoSYhN8KUaPq3x6/pYDHwvqQYyY8NRy7Df/cVyEquwYX94h9?=
 =?us-ascii?Q?r4BxpIkHWnYNqG8iAgmhBWL9za//pI5ewMWM/S/HUP9U7rbIaqHpkaFXPzSj?=
 =?us-ascii?Q?MxQ+YZ3IM1Y+oW2JPQckX2xZMDQtkC6NKo8L7J/vG/0dMCGOgGC2JhJzr30g?=
 =?us-ascii?Q?QFgQkovsE/m8bQCS3juyG+0keMQNz0gNJ8O+zW9rN7W/PmLMJdBlPOnv71F9?=
 =?us-ascii?Q?MDBS/1jXvps/tswLwtcYjYrQD4dT0C+we2pwUdi41kI4rVyYv9OLj9j6I9vJ?=
 =?us-ascii?Q?0Y1XXXns0emQRIjPtzb0jgFYtsanopMLzEWHEqyV1eiiS4r2JWrUZY5fTi3D?=
 =?us-ascii?Q?NlaccyhEkgE7zARLbtU/Wm3hvvrnsVYyc6whxJWQlQN0N4z7hcCGJV5vSDrA?=
 =?us-ascii?Q?v30LxnuMe+McytpPyxHX6clk7uuZkkSaVYKYqdZJYe3p5zJ6tM795jZciTFv?=
 =?us-ascii?Q?gsTjzR1wi8h9CPMv+lqJei8xwlEu0PONVX+PtWZlZbld9WmqV6fm8YDOtsxd?=
 =?us-ascii?Q?A8klZwgGEOBPi3Ix0YbQ87GhhaP2LxmQ9TDzJ7P4JvkC5RhHHrK8LkIBzfaC?=
 =?us-ascii?Q?yR3SSEVsevSuRY3SO3++Ko2iMfSasD3upg+uFi9weF2FvtXXORG6lfWKk8A1?=
 =?us-ascii?Q?E3onAK/3ZSbJOyG2qCYtUNqnzviQMEJaWMxfKmgK0XVEyPVj0MyzZ24nMn8m?=
 =?us-ascii?Q?1oeu6m/lEKKS38DepedKQoPe+WyAdmhpyOqZtkAfafm4Nl2qOy+LfLS6mBud?=
 =?us-ascii?Q?ZQpspTrYG3OPz8nhviCTVqRy9fZ0eaVkOujoHzQEKq/sb/Z3WsEsOkXVkHks?=
 =?us-ascii?Q?0nEpmJT87QU/2GM0A3gL3QLOr/yK1r7BSy7cPKKZthvM9ZxXRvOBCLp99DU1?=
 =?us-ascii?Q?s0/xGNc3S7DFOcz787wSwNji1fZaZEgRrTd4jICUZjndqUrpznVURUzYULQA?=
 =?us-ascii?Q?1jh03w5nxdD0KoCvhOK36pvZ7O5C23zzCFa9Fxgn5OoN1IPzlYDF9it5bHF3?=
 =?us-ascii?Q?2bULh27fmbTAr9uBnBWS1U+uTUnc/XzUTrBDLBcGsHUYX5Pc/KpCj3daDObJ?=
 =?us-ascii?Q?vfHt9V9bF4n4m0/nR6p9C4yqE+QCMUe4PlCChs8LJaUlgkgxB4B2XEPP8nee?=
 =?us-ascii?Q?FW6ri57xX/o2P1bSlHJsWVw2HXToNcNtnMjOtietY383u1Hlaq8lS/gD5xKA?=
 =?us-ascii?Q?eQzv5VGTbrr4YfzhPny4OuX9Vp8w6bOVYJ9/fYgM++NLUoCobA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:44:42.5646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ddfe8b-cd4d-49b9-c4b3-08dcf38a605a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

From: Perry Yuan <perry.yuan@amd.com>

Enable the SD_ASYM_PACKING domain flag for the PKG domain on AMD
heterogeneous processors.
This flag is beneficial for processors with one or more CCDs and
relies on x86_sched_itmt_flags().

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Pick up tag
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


