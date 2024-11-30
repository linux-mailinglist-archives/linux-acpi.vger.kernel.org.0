Return-Path: <linux-acpi+bounces-9834-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E5F9DF116
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163D6164EEE
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352901C3036;
	Sat, 30 Nov 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LAY3/Qck"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3641C232B;
	Sat, 30 Nov 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975686; cv=fail; b=H0zaxEru2/eRJTUtYzEgXSOvjlQYPibgaMYUrRsH4za4P5TD9Fz6dYhuyzq/25gDuN2957s7IcRck1wm8DBpgmgnZTvo3j8GW1Ta2Ki9Ie1kNiKNIMyC7eSCNEASm0XyC5GLM+wP5DrAsxAxTbSyAXeVwGb+si++7iFDwuIKEfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975686; c=relaxed/simple;
	bh=raN5KExkCsujKrVcAi0TXfz8VmpAYeESNZ7vG3LUdsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFDicnKg83geuxDZQJKDVsnLeiSxc9LZ67k7sSeNfgHNSv63uWRaYIwApalLLHQOGRmxM/bQTGVMA0+MsQVmsJYBRjMjkJnH9PgoheccupCU5Wji6Ng7FzeHQuw91UCAaYXVOSSX0H+gYfH7Y+CVucjJLh2Zb7hjsEDGhJs+Jg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LAY3/Qck; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ltliyj5+9gpfWX7RsgX1IQsZvWgrf2wr208covsUhwNXi2Qo+bXNNM9Dpa9psCZTviHOp7FhpMC+LXhUiTaJM/vYCvoxk4DR5Id6fxbq3q5C7pCf7DrwjswKdg4tPx7h5h/rcdSCRcVnXivkWunTNiZq01oX2yqkMif6y2MRlzAYjK1qq3sG7raoXBCzL4hVFYFRM38SlHWIzRdEL1B6ntz7GTWTpMSy4J1kslfyNLYardJ+kF5LU3T97G1uwDuw5gIq/n2bmspmUmz7wKyV/bQILJQ8d/hGFaoi6td3kMDtHVj40Hp6W5Dml+qI8eDIO9CEm6kiQIujgtRgM41QYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QADJVeRreoewXJvxyin7Ng4jHEleXsWtt7TUFdQLkMw=;
 b=GiEpFAjGpo+Cl5tLytMlPBiIsq5UN0+x4LxIukmbtvC0b7kbV/hEdqIJAkRn0n/bAgqv7Cl+pddtHJGhBcFZmWV6i2riWmRy5CyxSC02yUHXK3VUVvYDKYQVFi9Ln87a0ITKUnHtGSbeJ/tLOcDL4WCiZ80kJavndLEEdDzw/fPhFEhdli1aGMGG0rjFImyaEBb6v5NGWQaXKppzk4q2/j2yxBx8UYm5Olpwnj1e9oe07D8sO42VvFCKnsm2EsOu2WIyzkRGMHetwcZaK/qn1mc2zlZ3gUaK/qlwyag1R8TsaIR81LQUJayfXs0PQYQ8mxRAH18BPzzgY0REhXsX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QADJVeRreoewXJvxyin7Ng4jHEleXsWtt7TUFdQLkMw=;
 b=LAY3/QckkJSJX5EHHDryQzRsH3hgbGrK3kMY9HJw1V1jjBdytONNjNm/LYPdkY/9H5Z2ES6GxvHLgchx5ZN+F4fwOhsPbGSXsetew+S4cPOgEn0GbqGu5kK9Yh/HxCpaG4yd+ABwrpgOPpDJY8vm3DpPoHXWhqplV7V5uFEt8VU=
Received: from PH7P220CA0124.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::27)
 by MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Sat, 30 Nov
 2024 14:07:59 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::46) by PH7P220CA0124.outlook.office365.com
 (2603:10b6:510:327::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Sat,
 30 Nov 2024 14:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:07:57 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:07:55 -0600
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
Subject: [PATCH v7 10/12] cpufreq/amd-pstate: Disable preferred cores on designs with workload classification
Date: Sat, 30 Nov 2024 08:07:01 -0600
Message-ID: <20241130140703.557-11-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MN0PR12MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 677b94ab-5884-4576-1f75-08dd11486490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JZzGagHbDu0y/lOGf/YZwzmKTcGfsWr5X9jX4LVSbmcgWTWDR8kiuyMGiqkz?=
 =?us-ascii?Q?Ea0R3JvE01namVx3dMMdp6oFQEF4V1AU+TD/IHqCMRuGtF7VfTNyoEQEQLca?=
 =?us-ascii?Q?TO7HaJleYnikXvnJPUPY+t0T+B/SCIbsdOFNk+jNjfBpcrgGlSLlwJF6+mCD?=
 =?us-ascii?Q?EFnvwKSrwBcUv0lbQsi42TztIPcIPdFuN7JGR+buUze2k6gVNPBAFPMDRdzh?=
 =?us-ascii?Q?/II86I4yYyyr35aO0sgYva4PFMozJVptr4z1C5ZZzc6in7o5cvoFHe1mNi7Z?=
 =?us-ascii?Q?yVKlnjmDguVJKfB8z+tNXAluGpi/YWS+LuNY6gXzh7ThcuUkB5TMqiAvzJWI?=
 =?us-ascii?Q?TLYbehK3Gb9ENHVDXl3bCzlrodWePMWwOAqcysAekS+xlxxxmbDDu8pfZY5t?=
 =?us-ascii?Q?ivSf2qkIh/RZAeZzPBJuqS7XIqaJWejN+e/2cYjX08O8uhXikECSfAAcMS3e?=
 =?us-ascii?Q?PglVrJbXRFXBmnzfYI57cfIS+8Uf63r7rd3rFOd5FrPCCe63RsdU20on5MKt?=
 =?us-ascii?Q?saUxnsSki0jIb11mfn6uEBl4q7NZ+jHCr6rING8BI7fO36bkh3OGg/p+0qy7?=
 =?us-ascii?Q?rxU9yc+C1+7lTuGdIP7oOkX6/2000miJYsOSN4CLG03oZwBUf6Bnn1intMlo?=
 =?us-ascii?Q?Ic7y5k8XVCsJOZswGFHvfG+wkFGUyB9vx0L1uCCBxZCa2bdlK3Yj6aGnobNq?=
 =?us-ascii?Q?ZxE/U605M3uMlxRtJKCMsojB84ycG24hLzJEdpfMJPilW3O82z99ear9S+2e?=
 =?us-ascii?Q?jnT+vI7RytYRjSx8MpDg3ENXqZ9rTU3lUjc7cOLCnrrx8zn4zDGZZqhe4VxE?=
 =?us-ascii?Q?Gt8m/2xBl2op/PVWsdA3tTYwtEymDlA4s9xR5JaRlfi9ghXBp+qRNiBDP/TK?=
 =?us-ascii?Q?V2EYICAauf4Jn1C4ipbbkXx33NRWF1VJs6wRs8U8CxTI6NVbSau03U8JZwHM?=
 =?us-ascii?Q?2x+NZlnTL55r4t1+JUqiY4DrC6nWmkcaViZ5hX2HQVGzpH/DXNFU8IaxoMVE?=
 =?us-ascii?Q?Gvvphzp4Mi1va1JRBenkO80M6o5lxCZn2RTQElsOZ8nd3jxJ9ZRAj6fd7CA/?=
 =?us-ascii?Q?IXU6bUsKxLjnoQi3Ecx8/kkSlII0E/RizrhnW9xPBUv7samNj5tUrSL2bY1G?=
 =?us-ascii?Q?dpEHajMEnMNJSIbD/s7t0ELcuj9Ir1XqpLcePpW9fYPPeiKS1y4E+AP/8h+T?=
 =?us-ascii?Q?X0+mjByg27yMvmn5HiH4Sjc6WX2X3wfa0A5/pQ8hh3hz+iAy6YRunTljNq+d?=
 =?us-ascii?Q?hK/rKiq3iLv3IME+M2sPRGMZhbBn5qGy+Xd5tGzWynjGgmDxcyLnIDqS7Vz+?=
 =?us-ascii?Q?0kp00/mIZR1yiEUOJsLDbtPTEc9EQg7vDxNRAWBVeSGK+uSgcCA/SVix12rU?=
 =?us-ascii?Q?vxjQFtMTS3Sk6joq9BNawfSU+R8AAamUVyGXbP1p0muoILqQ9CiRmmL05Rzu?=
 =?us-ascii?Q?UvdVXfZ58LhhvY+eFoMHCF+9EVneCZvr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:07:57.8181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 677b94ab-5884-4576-1f75-08dd11486490
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834

On designs that have workload classification, it's preferred that
the amd-hfi driver is used to provide hints to the scheduler of
which cores to use instead of the amd-pstate driver.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d7630bab2516f..6039c719961d6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -788,6 +788,12 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	/* user disabled or not detected */
 	if (!amd_pstate_prefcore)
 		return;
+	/* should use amd-hfi instead */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
+	    IS_ENABLED(CONFIG_AMD_HFI)) {
+		amd_pstate_prefcore = false;
+		return;
+	}
 
 	cpudata->hw_prefcore = true;
 
-- 
2.43.0


