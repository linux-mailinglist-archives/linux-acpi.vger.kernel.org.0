Return-Path: <linux-acpi+bounces-18546-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 247ACC3622F
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 15:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210206228E0
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5AA32E13D;
	Wed,  5 Nov 2025 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uL682sxa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F6C15665C;
	Wed,  5 Nov 2025 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353569; cv=fail; b=j2VDS0Sl9+aclvwTKriw7xqnzfRu/BCi+EdmkT9I+2qO/+uw2g2y91dU1Zlrpv6NKTHRVulLzNjKCI2P/N3V/q98uY2JQ/AGEnOWJwozd1g0tzGUMOd6j3MiPe4/V02hp+zTifkbedruaSkWEyHbq1grdowFrQCxVFLTNbqii0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353569; c=relaxed/simple;
	bh=CM4kmm1dVSNYvnAuJoVKz49PA5hXgvQwtP4z6q2qPJw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MvO/PxdLstpVecAgH4oCyqMGElklzswk0+pSZC42eNgP47IhOXroW2yCmbEMJA+41oFNk8eRuTGF6660Cr7AR8kuKmWnd0LuDDOiJOU5OoAoh7clqAbJqHxu9CsHxskgiJdNkWL9MD4llbiO1K/7oG8wVpoOTPAn6vHVQM+iuEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uL682sxa; arc=fail smtp.client-ip=40.107.209.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVnLynXlKmWsBErGr0UOL8DBqCQxTs0KcrGBrpWZIq/3qnIU8TUebrT42szQc1wTLVD3auCukG27OwVCfX8JXZyyY5Xx8D5RaB3uzFlbSKqDSm1B1hrDoMW2Z5nKmtzEnOLUFS606VCmYL892Riu3ukd0od0iviOaC2FTKt1cyPBIn2vw2rtAtjp2YNsf19agy/4toJ1MvyqsGoKEsd81/96Eq22Ocdlm/3OsJpwLS9eANL62eA83d09hgqODgbJwTFDs9FoZGQ7LZAPT7yGfByXuv60h2PR1XDEyA8n5a+C0mo5d3ZPsYkpEKs82MSOZRPMO29IsTwql++HtdMxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NdhemjhqDHxQclzUu3ZDQ94Qu9L80VTfMginQcXqa0=;
 b=VlYw3R7XxKPR/8wLQ02umLW01k97+ocW5DXLKIlwc2e6CVJBYFKipVRHAdN0Tizf1SzTfLeYQEJ2jevO783EyExbaok+yrf+sKesQbI9RR0l+NkM4zfdkP0Rlu+Au0dRUlJZ5o6tbVj8oyMbJSCwbNJHAPsr+cq9vS+/8T/2VEouFaSiP3nDcSQGO8PhQjV7N0GSP/+rFazWJzmRp+Di8bFX6azFYKOsgAwHLGf3hA7RpnIv9QtEqTCw2TqrX+U9i2OXN+dJBgm6KWur31ckllqZDdR6k8uwxgrrZfOqLK1KlHpv+BdR5FNE1LzlDnL4cJTgM58TaqeHONj9R2ndgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NdhemjhqDHxQclzUu3ZDQ94Qu9L80VTfMginQcXqa0=;
 b=uL682sxaaYVDJE8+eumWRYrMIsJlI5GlLHoPrKS5mXMRmkkKilkCM4XhJj+48DynxJHUp9TNSqbSBk5+LcksKDr8eU8+rKfdVinJNzEOuxN2aZS2vHDY/8/WXfniZqjxZDslcNpd1GgvimVgzfBSZLIw8XfnrdVMwQpT+wyjaK4=
Received: from SA0PR11CA0197.namprd11.prod.outlook.com (2603:10b6:806:1bc::22)
 by DS4PR12MB9564.namprd12.prod.outlook.com (2603:10b6:8:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 14:39:20 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::fa) by SA0PR11CA0197.outlook.office365.com
 (2603:10b6:806:1bc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Wed,
 5 Nov 2025 14:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 14:39:20 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 06:39:16 -0800
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui
	<cuiyunhui@bytedance.com>, Jeremy Linton <jeremy.linton@arm.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christopher
 Harris" <chris.harris79@gmail.com>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 0/4] ACPI: CPPC: Fixes to limit actions to online CPUs
Date: Wed, 5 Nov 2025 20:08:47 +0530
Message-ID: <20251105143851.4251-1-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DS4PR12MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: 751959e8-dd41-4d10-1228-08de1c791ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M3XoiKVQhLm37UGQuNnWBENqmTLMrmkRft35MNHQac0Lbxo3fkX5bLVKCcQD?=
 =?us-ascii?Q?xJ1v1zqD6+NVcG3HEp7+otxz2fgQHM5O00RJjnQsQSBXp842rAsC0Mkdgf+9?=
 =?us-ascii?Q?C4bzRIOqfQ1+Q3UkPHmhAJJbWk+Y/KKtrlLPI6xbrpkwIUQj5c8erzvbSCOm?=
 =?us-ascii?Q?6NAS4Cz4Ns9suTO3NuiY1ETd3BYXvBQXo+5SJxg1yAJ2ykmd2D6sfQrhRq/K?=
 =?us-ascii?Q?f1ZPXtD9W/sinvEoHiZY+1FE9WIKs1WY4/4QMqoFum19aPJ3S/62BNrfQh3D?=
 =?us-ascii?Q?8nwDaFr0FPr0GgYmmuzujfZW3M7O1EQOnpotza9iHXDD3qz5mdQWrJxlZkne?=
 =?us-ascii?Q?8ZwgkyHzX96r8jWdgK0eNXFJFiVqrrSHjUcrL2/t0huxw+cRM3Px+tpQTyDC?=
 =?us-ascii?Q?xQx2Duyx1/dRaqbpN2DFXL8ITpEyIvqC7R/Ajy769MLO7FEXYLsg9Hl0Z+Cn?=
 =?us-ascii?Q?/mb68adIqlUxbNoRv9B3/Jhk8WrG0mLzQhSKzdN7N7d1zcUprqCx0Pc4afb1?=
 =?us-ascii?Q?zzqXfhsdrOlmN+/Ck6Bvg8YD7XCHKZw/K6k5E3uKiikT7c2vQk2uMfJmO8Hn?=
 =?us-ascii?Q?BW5hzJsVq0U7tg09n6ZBbO/QtUMa85anEa9ShcGAnGLFn9SPxVz/0QB593xI?=
 =?us-ascii?Q?EAJBznshAb2l/y5/LNwIt+0zEQmMLz8857WvLl37W9G+CTSFobOF8H47ZSGo?=
 =?us-ascii?Q?Nc+YKGf9rXwsmZkPp+OXqXnNvm/+4xfdbeylDB21nqQuK+cL8F+fiJidRPqZ?=
 =?us-ascii?Q?/NBc4dniuMLJV2Q5L0n4mPsKpQAyRRiw94PXBntc6ePeTQRQxSwbSS3T9cct?=
 =?us-ascii?Q?kR6m7k+d7H0Fg1PAxXHAHGqgybT/ymPNy7VsEAl0q1aRsL0tU3veWRlNDV2p?=
 =?us-ascii?Q?AlG2t4CbeOWJ1OYMxPAVbN+pv/QessXmSXqmi4EMUBYNDXVsfk2XcAyvH/G/?=
 =?us-ascii?Q?hYPH1yCC3AdepNa0JuImut6eEBFp9SSPrdUurc3g7VNqN8n9NZia1/URUkyX?=
 =?us-ascii?Q?G9lRcibfsq2ZPZ+wnsBCq2674iguD6T3bfGHTQ+Vy/QyAviPsD2mp4Nnjfet?=
 =?us-ascii?Q?bdid3VBavtIoFqJLTyib3MyzoAWGGtWxkOO6SE24iJEWW+LpCiTlxTCPuLUz?=
 =?us-ascii?Q?o1izmyC87XGIHFQR6z5yEWkGkpa50RRiDRADcRgvwVR1GAsQUJ2j/vCSYTqH?=
 =?us-ascii?Q?oa/jaNIVND6/QjGlWDu0fPR/TLRunrqvfQnkfC1Nhack/I6HB6YfW0D2baun?=
 =?us-ascii?Q?gUZ3bk3+Gcp/37rFm55MZhFMeMUMaowJIEi7CMiNmdHq+kwXx22LkfLNO0AF?=
 =?us-ascii?Q?rz6faA66y94PD9tzMlBmfP/DSzNfmi6+Cwsxt0n7dz+pntoORWLZRBk1Iz+l?=
 =?us-ascii?Q?ReS7TeTnuGbXaM2DbbXAmWQurF/FZGokId50NL/JD6w2Zs2YKlblSb6MzaYB?=
 =?us-ascii?Q?ZDy2f7AViwqwAp4sT/Hhcxs2c+9mI5Wr79gCBdtzn+wF+V3ZFbssMTe9f6pt?=
 =?us-ascii?Q?9iKYqXya+44NkOlHfKtprcCHzFKrfNMXw+2lC/EosWuERcEuT+dKwrdSJouv?=
 =?us-ascii?Q?HjiH1hNSxeQKnGLHRyvg2lelqy8ZeDusYIZqrl0/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:39:20.0485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 751959e8-dd41-4d10-1228-08de1c791ae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9564

Hello,

Christopher Harris reported a regression between v6.10 to v6.11 that
the amd-pstate driver failed to load even when the commandline had
"amd_pstate=passive"
(https://lore.kernel.org/lkml/CAM+eXpdDT7KjLV0AxEwOLkSJ2QtrsvGvjA2cCHvt1d0k2_C4Cw@mail.gmail.com/)

On debugging the issue it was observed that when the commandline
contains "nosmt=force", the CPPC code fails when performing certain
checks such as checking for the presence of preferred cores and
validity of the _CPC object since it iterates through all "present"
CPUs while the object state was populated only for "online" CPUs.

This patchset contains fixes to address this issue.

The first two patches in the series address the issue reported by
Chris.

Patches 3 and 4 harden the code in a couple of more functions which
iterated through the present CPUs when it is more apt to restrict the
operations to online CPUs



Gautham R. Shenoy (4):
  ACPI: CPPC: Detect preferred core availability on online CPUs
  ACPI: CPPC: Check _CPC validity for only the online CPUs
  ACPI: CPPC: Perform fast check switch only for online CPUs
  ACPI: CPPC: Limit perf ctrs in PCC check only to online CPUs

 arch/x86/kernel/acpi/cppc.c | 2 +-
 drivers/acpi/cppc_acpi.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1


