Return-Path: <linux-acpi+bounces-18549-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB27CC361E7
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 15:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D15534EE1F
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEAE32E739;
	Wed,  5 Nov 2025 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bmiR2VxR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5138532E13D;
	Wed,  5 Nov 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353668; cv=fail; b=HO8CWKqISQp7NqeDiZuYTQN+q2bWE0MjckPaeQTGGqc/UIT3XrVvgorpDS2zciKK+TC/aENjBMl7vVO4CLjvSLU5RHiPm4wEBHEhbPIhsR2Xe44gEKXXr1rD4mB/gYJy3wWNV0zl8X6sr5VbWqH+d2uftgUokM1e1t6Z9nd6hSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353668; c=relaxed/simple;
	bh=YeMopl8Hb+SPrmtzkbKAf5PLbsPOqJGx+kjL/m+JWY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfVPr2Kcc2ffHin5aQEGtyXYxC+hlAPL6XqaIxBLDTV57X7irFkdq0CO3Fu78X620tlcZZkriYAKMdoMOv8tzbaYZ9n6vlkeM2MOvSWCZ4aJkskWDjURgeM80/d+u2Y+EtU4DJRw8F3OkZP1Byo0abmrsSNUiqmXr3FU/q30Gt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bmiR2VxR; arc=fail smtp.client-ip=40.93.194.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ep/XPj6gbVqq748GZIIAc4Yv77uxX/k2iHu++ntAiGDkb7rkf80I1w+HtVJ4m6KAkITguSZByMwism6UZX87V4i1fzGLwSpVh5W13JvkJVEjmr9aUTQh3eiu7iG9gaOB3yk0riWHmnzAC4mtm6OL3KxBcLlxjlAhp8HmPXF+jAWoVSn0xb3qyDUzoAQi2tbDbsyIlbMO9UWZjMaLh6ip2+tq/0uSDbJy/HwLD8nNahjMUZVeLP3aP+iqzNnvvgEfGJc8/uiZwuihE/KcPUhIUvIBEDzJQviWHgVJewygBEsCOKFuyasXn41kM1BjXT7ZMYxJhHnzw2sIZQnRepibVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/jRnZyVfmd67MAd6Jl0ZbkiYit2XeUU6Inel5r7DFM=;
 b=GKjC9LtjKfYdUeU7oLChQnYylTOl8E5PIgU2EDAH9I4lfVvyTyvSzWrzZVAonZ9h87w15vIUYE+6ZEGHdv17JXiy/KAvVMgRzDdq4i08BGs4YR0xDLv6HocKDsnYCgP8j+tZTJ/pQuFc5etxWSoX+fXXJNnB8SNZ2cSSOPvd9k6KIIQm6CeBS2SOknwr8zrLlYteqoZ5v6lU75AxOwghtziHH94ip0Bao3hHLNrpCEikoffa82H2tIVA09Z0Krm4wTsY0BX1yoLxi1kdjf01szoTjtjQHXVLFCJPD1F5IjMXyKPfxcUTqbowj7TymcP0rOv0UE3SZyb/+V5MNdP+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/jRnZyVfmd67MAd6Jl0ZbkiYit2XeUU6Inel5r7DFM=;
 b=bmiR2VxRvkZwtmSy12OlP4iN1alv3VEEtpkO/QuM+jpQ6A9Q/H63TWrNVtv4ZquJTu8uHe80Gjv3NTzacU//hPatwtDeIAhzCyReRQElFO159MKYo+ZP3AKXp63DPkvqK92tTEmheu+40EWxMaR47vHCPVAuZEb/KQPNTqmWfxU=
Received: from BY3PR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:217::18)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 14:40:58 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::b2) by BY3PR04CA0013.outlook.office365.com
 (2603:10b6:a03:217::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 14:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 14:40:58 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 06:40:54 -0800
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui
	<cuiyunhui@bytedance.com>, Jeremy Linton <jeremy.linton@arm.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christopher
 Harris" <chris.harris79@gmail.com>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 3/4] ACPI: CPPC: Perform fast check switch only for online CPUs
Date: Wed, 5 Nov 2025 20:08:50 +0530
Message-ID: <20251105143851.4251-4-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|MW6PR12MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: f5107ebf-bd3f-489b-bb6d-08de1c7955a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?307QQZ6aeRqV1PDvgd5cnHW82Pl5D3KZoBf6SYqXsaNlTigfOuQyKHhXPqvG?=
 =?us-ascii?Q?SdChpplUz/OQkARcei0QFXJrsjx9ge/bwAufmeUP6wxd7sakqJsoTm4AW1KW?=
 =?us-ascii?Q?XlllkiVhIo7P6RLSMzIRK4IWCKtBLfB//t/gEFoHl7izRm0tSitvyFM+xXqi?=
 =?us-ascii?Q?beUMxTDFvNA/KttThMvkynHe4lftPYfGf8BFqWMolpX/fN7Kb3mNNNHM5amR?=
 =?us-ascii?Q?ZXUEw6cJHOipxMeZX+jBteicSt2LsXeDHyPmVoLzIy3k/oNyRZ/pZqS2ke/Q?=
 =?us-ascii?Q?MPxnV9oFnIiqR/zSNv8pgbVQsXhPapCYFQNjDjeO8cK5HrzY4bXuUFu31mdZ?=
 =?us-ascii?Q?2yNviScJhVELCsbCgRxWgXlA65kopdfJvTvv9bUB5paWGFmmiguzvs0pDU0r?=
 =?us-ascii?Q?APfNjbPn4DlThdQMxKylMSp94NAF67gthh73dqErERWQXSy1HHSoPivn1GQv?=
 =?us-ascii?Q?apWMNpNRxNIYv1Pr7md9u4skAW0qC0cpk8M5x0jnAKxHXIyQ9V6++s0svnrF?=
 =?us-ascii?Q?4hjjKgt+4PP6/j+2YfbnjDWum65GQK/A7mFgMemTLhbEfO3JcNrZonOea9eg?=
 =?us-ascii?Q?eX34XE+Hqt5joC2ASqQOb6qEB7Z4I/g0Zr1UpaBRXfKFQBMedNCQ7AE/zP/Z?=
 =?us-ascii?Q?cwZy/PGmRcJk2t4YUmFnReKiz7Lj+s/IX8AnCypeVxov8T4UyVtk0s21Z0CT?=
 =?us-ascii?Q?oPy/l7kZA96lwR/cwyVPHMKlfQwYPW+XQBl7YKcAMi2iYK2xEInwuLnbakBe?=
 =?us-ascii?Q?khQhE6pNPf9lxIFfwXYlo09zmezvrdo5fItMTs2zPh/1C7h5nz8EygbqBbDv?=
 =?us-ascii?Q?u0JhcfoRQ25e8KgQXdvHm95zIeYEsliAn81mjMwOPRtd6GW8UP1gH9VTjm/x?=
 =?us-ascii?Q?Uxh9llIfvuPODgjndyG7nhK/JB58SsUcZo2hrTtk/hCGQfAdd1YlVMCJbuS3?=
 =?us-ascii?Q?ooFNGRmdRKlKTdHmQaT9MIKB8JbHN5JXtKMDk6cj77pnpU0mK7jqucbE3BZz?=
 =?us-ascii?Q?r/I0Wq37fcHCIy779otp4bLT1vhRS961j8PeBywSJg+rH/9cu5Rst/eGSvkg?=
 =?us-ascii?Q?IGiPzDXKccubplK3EdSI8MHX8CcRTLKiSETXD8+du0lzQD/00JZ82eAnAvwg?=
 =?us-ascii?Q?AVJOWVUSCrC8udcvy9yrf0LXq78xent6uheB5+0SN0EK4F3UAdLZtluM0gBj?=
 =?us-ascii?Q?Hm8v4m9KpBbEd/fe+U1I4RW3SG6+xOnNZpXi03nU86R5EmgvriQ7PS2lxErc?=
 =?us-ascii?Q?gxqLCht968L7WQ8AR0fmsOmZvVHnlPExvNcVy8TINl+4EawTTse0zyKaRszY?=
 =?us-ascii?Q?evh+JEgsswUrs1avPjKj2uroFY0lqhXO4GAZJ7oSI7a6+xKAZGLnoiJnfpnX?=
 =?us-ascii?Q?kTRWMvB+r6tY5idgzT/76YWBM5vAezKv3V4sSW0U4cQZCCEAxuBLpn0mG3zk?=
 =?us-ascii?Q?DQOFgi1nl5MqKsIj25AOT/nZRCavAT5vlBhFKE8CAa7vIN6uGwBZX2udk5MZ?=
 =?us-ascii?Q?on3Y1pyM+L1QIhi4Yy5stoPlv013K/JjzUuPvaZkPvQ/FjbDJ/6EKAcvVqx+?=
 =?us-ascii?Q?Zw/zYwuNTTqXB0+SVOk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:40:58.5393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5107ebf-bd3f-489b-bb6d-08de1c7955a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019

per_cpu(cpc_desc_ptr, cpu) object is initialized for only the online
CPUs via acpi_soft_cpu_online() --> __acpi_processor_start() -->
acpi_cppc_processor_probe().

However the function cppc_allow_fast_switch() checks for the validity
of the _CPC object for all the present CPUs. This breaks when the
kernel is booted with "nosmt=force".

Check fast_switch capability only on online CPUs

Fixes: 15eece6c5b05 ("ACPI: CPPC: Fix NULL pointer dereference when nosmp is used")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 50e6348b511f..fb7696b27d82 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -476,7 +476,7 @@ bool cppc_allow_fast_switch(void)
 	struct cpc_desc *cpc_ptr;
 	int cpu;
 
-	for_each_present_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
 		desired_reg = &cpc_ptr->cpc_regs[DESIRED_PERF];
 		if (!CPC_IN_SYSTEM_MEMORY(desired_reg) &&
-- 
2.34.1


