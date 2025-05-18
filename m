Return-Path: <linux-acpi+bounces-13775-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC486ABAE27
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 08:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4B07AB49B
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 06:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255A61DE2D7;
	Sun, 18 May 2025 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o91B8Yor"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DCF469D;
	Sun, 18 May 2025 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747549539; cv=fail; b=LA6wKO4Bhi6/J401YaVRhNwKFOW28fJ2JBlcf02TQ70uEsiCScZ9ehufS7PyNv61XxiW9yjpcvrHNPyyFHZlb14aIzUcoSV4oIXW6ZxUmRZuvcTxPFfLktIpcnZcGsS7TJ6XfphKjq7F+2uz05E9vIbQ7e2rKoxfLjT1U0ufNMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747549539; c=relaxed/simple;
	bh=D5Ovb6dscI3nIXHu0FjQSPdLe7ypkR3uKa6msR5q86g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uoXezPeI7QlsqRBhoJkBCWNo96Z5pI38NUv32a30jiliEjLWs3nGSHS4M4teurvAcgMIV4aa4vDp1sXa5AU2ZOFC8y2mguRiyj+GDYJW+qQxLGMba82MtTKr1foltrjPj/2y18fY2SKGGz9D+nPmcCQrFKmxox1VjrxmCPp++8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o91B8Yor; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VML7uMjnaQxPuzRPJnd2yBtvfG2Nva0hk3x4k+CyD7lKnHqZBRtdzi1K3DPmoX0t+QTEiqvxepdQQuZeCaj9c5j8qzNnHIEN7SFFw5uwCbh9S7vh9MpmsW/9BslYi9VUO1yOgPVl1ztfCg9tctyw6oGrbERMgwtq1u7ll5/sA2jJw4IEBsQsYvEJkzSXp3H6EI+5h+UzPGLoUffFW87+GZefW7zdVqeFqRhtUAY03ttaX30IoLS9UmIs7hfXO4HU+iBK7BO1h+4a/6qCJAHkQDV6qMoc4vVIpis2KqxkwibY7DujgS27OYMV060VNtXlH2aZsZK9GVcBsMq/k/NARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tzfQYK8s9v/FPxIeV3BA+JRuj4olHtzhrN63AveWLg=;
 b=kAKiT8r08liGuAwMoOzZzH17mBH5IuAC6gIKzsWUX96Z3uRSWs5qI13eTZ5GGXxvU7aa7A0jDE9pq5wcxbbfzNEQ/O3RzruomquSMq5f8Abvn6OeauXMaGkyyNOzQshcqPp2D1DtuDdtxfgKC46h7jPjcCsCdD5tryvoibGGaEVwzTf2XGSZI17XUVVVGxsH1/SlZkZxhu5mGJdTRZgebVc21rxin1ChzRcG8RtQ1Kdv3HNZjLE5GogVt8cPBkDOk35BEcKfKlsT/qnMFxRzbWZI3k7I9Sc4buY10LqqN3qFoHRuVbQouPbOllRS3WaEk3xJ8n7mlkgk7x0rt6t+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tzfQYK8s9v/FPxIeV3BA+JRuj4olHtzhrN63AveWLg=;
 b=o91B8YorsGYIQ9YibTZQ3/8d4E6HVYBUweOS2RW50ciZLCSBhDuW/wnxDrgq0SU+B3feA/2jwz0wJI+5Vh236nSsaf7pcAKh1diTYDq0CL/vshEudPCK1g/y/gGiY8HY24TnBKUIXxFRXtpsf7H6U3EeN2eGj7mDg9eOgAhIVPA=
Received: from MW4PR04CA0325.namprd04.prod.outlook.com (2603:10b6:303:82::30)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 06:25:30 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:82:cafe::5a) by MW4PR04CA0325.outlook.office365.com
 (2603:10b6:303:82::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.25 via Frontend Transport; Sun,
 18 May 2025 06:25:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 06:25:29 +0000
Received: from qyzhu-os-debug.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 18 May
 2025 01:25:26 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <qiyuzhu2@amd.com>
Subject: [PATCH v4] ACPI:PRM: Reduce unnecessary printing to avoid the worries of regular users
Date: Sun, 18 May 2025 06:25:07 +0000
Message-ID: <20250518062507.218855-1-qiyuzhu2@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: efb76478-b745-40b4-309a-08dd95d4c8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vZs53nO14XuBui3v6tUktczofHSjyrVwT3yRIUDgV4+g9NSyQ0as8sm4WHxs?=
 =?us-ascii?Q?mTt7LZgIMNUGHYMI9MDFQFhP0LvWFBybFcCmMmCfumHbyxQ3E7+I3sar2BJ7?=
 =?us-ascii?Q?riLGACcvQOm04HraEyToEW4E8Y2bphD6X+IdsYDLtTTOIdeZHiwIfl3oF+Wy?=
 =?us-ascii?Q?jVqrjC3n7CpiBQafQhGdMiBqZxWOebElUXjQpUSkO51WOsw6IdIXMmzNnzQU?=
 =?us-ascii?Q?68pGUbfvgpm4Odq/4Shn7CIDVDXd7cEsGxoeghUnZDqJ+8ErQXJWcxQK9uyE?=
 =?us-ascii?Q?g0mMB3bI0SrzK2+jY1/B88wqjK5SCB99qVDDtxjAMz9SLaIxeqSvBxatS3l2?=
 =?us-ascii?Q?/xCz1TAhWKdgSrB4VtyoAwHFrR4jV6V86AozgVCcy2mV3efmrCueWGHwNMyJ?=
 =?us-ascii?Q?lw5odHazrXrQTpEYthszydL/3/XVugOkn4dnJ7V8tutoVaQFDbQvVLiYN9vd?=
 =?us-ascii?Q?+AlWmET8qNo0op/5PpRcGb70w2Rr7d9H665s6fRkfqJvwGigeLUO45kRXVfw?=
 =?us-ascii?Q?KNcURButccosqjmITIgnWiWvxPwy5k20141ePjM3Xb/DLJG16GaJ5fEoFnuv?=
 =?us-ascii?Q?Go2H3dyBZbkUyMA+iYnpNR4TrMP9K+/D46CipP+gUsI5dRjPwVG8unJNJiGw?=
 =?us-ascii?Q?33FJYPhR9ylTWNZVA2PFnkya/EiPP47/HFTRxIb5tzqwoTsBpl07HIgmN0F4?=
 =?us-ascii?Q?vAZ9lTi2JzBeJhxGqmKxnCr0KGu11KbJMAodx+FU4en0+n7wVCT0KRoDrXMl?=
 =?us-ascii?Q?d44uFEPAnSs7yTCUAWj8xzAnRlNSAowx4pJUTqP3M+3wpAuelFBNuJjSIGlw?=
 =?us-ascii?Q?q3GhrIXVHyBT5sGK3fEUYqY98rvbUiHqCvmssCadcnIjUqakk+Xvb2kHXP0a?=
 =?us-ascii?Q?nZHJl9DiYsM+hI/uWOk9TGkxGcLTAbPDaGA9D/F3nQnQj8/dKW1Wg0WQGMhH?=
 =?us-ascii?Q?vEw4nP+WlQEk8efAawP6O67QouUPZSRNZxvTs735qQl3jCx20zFaGAaB8IRM?=
 =?us-ascii?Q?EqSi/e/LbJhZTRj4nWcx3MlGDYr7OP1oZeWsVAHGsNaemMIsLmjHG75Jsceu?=
 =?us-ascii?Q?yib2IpIS1DdZyjEkUlNqu7TV9+kOwFF1QfJLxTzaVwTEzndeHPoAhVS3yD9A?=
 =?us-ascii?Q?rVI0Q0R7kvIWdBsTVbXMHvVI21Cu3HqKEc58r/QflTwtAIbVsCfs3Urmas9L?=
 =?us-ascii?Q?nUKFIfl5Un4VFOS4gMU6CPpcvXLRGGym6sh+mc++X70xMbVFWCMDUpHW54Zu?=
 =?us-ascii?Q?8wmZLNEQeecDjVUbwhGTpAOnhtznUE03zxEx/emXswB2L6s7zHLoDQab3t7R?=
 =?us-ascii?Q?zRzhFE8iX9CiGuL6EvGMajGs2YhxlAspNyYR1ePLGiMPcdDGD4UoZLloRmul?=
 =?us-ascii?Q?Qf5bz87uyRRC9k7DpPf4IJnk1aPEI/XQYCwPpclSPrkUEHY0Jb0WQuL0VOws?=
 =?us-ascii?Q?iw2zr8fs5POxQVymlnWc9/I6eAN7b8IqE3a+bCn5MlCNCA5srj6LqDwjl44F?=
 =?us-ascii?Q?+5oOPeRV1WszYcY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 06:25:29.1911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efb76478-b745-40b4-309a-08dd95d4c8f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449

Commit 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM
handler and context") introduces non-essential printing "Failed to find
VA for GUID: xxxx, PA: 0x0" which causes unnecessary worry for regular
users.

Refer to PRM Spec Section 4.1.2[1], both static data buffer address
and ACPI parameter buffer address may be NULL if they are not needed.
So there is no need to print out "Failed to find VA ... " to intimidate
regular users.

Link: https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf # [1]

Signed-off-by: Zhu Qiyu <qiyuzhu2@amd.com>
---

Previous versions can be found at:
v1: https://lore.kernel.org/linux-acpi/CAJZ5v0hv0WKd-SXFhUgYs-Zpc+-PsSNOBu0r7L5TzJWgddtsKA@mail.gmail.com/t/#u
v2: https://lore.kernel.org/linux-acpi/20250512010620.142155-1-qiyuzhu2@amd.com/#r
v3: https://lore.kernel.org/linux-acpi/20250512011833.142204-1-qiyuzhu2@amd.com/t/#u

Changes in v2:
 - Reduce the code changes.
Changes in v3:
 - Fixed title letters not showing.
Changes in v4:
 - Only print the necessary warnings.

 drivers/acpi/prmt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index e549914a636c..bee450869cce 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -85,8 +85,6 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
 		}
 	}
 
-	pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa);
-
 	return 0;
 }
 
@@ -154,6 +152,15 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
 		th->handler_addr =
 			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
+		/*
+		 * Refer to PRM Spec, both static data buffer address and
+		 * ACPI parameter buffer address may be NULL if they are not
+		 * needed. So there only print out warning if handler address
+		 * is zero.
+		 */
+		if (!th->handler_addr)
+			pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx",
+				&th->guid, handler_info->handler_address);
 
 		th->static_data_buffer_addr =
 			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);

base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
-- 
2.43.0


