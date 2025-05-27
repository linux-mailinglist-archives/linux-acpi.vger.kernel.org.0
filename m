Return-Path: <linux-acpi+bounces-13906-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 357B8AC4686
	for <lists+linux-acpi@lfdr.de>; Tue, 27 May 2025 04:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569FB1883C3B
	for <lists+linux-acpi@lfdr.de>; Tue, 27 May 2025 02:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB6C1917F4;
	Tue, 27 May 2025 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I5uvh+/O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33951863E;
	Tue, 27 May 2025 02:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748313814; cv=fail; b=oHTwOT3+33DX5ZTvN1Pjl7jFmjZP+A9X6qHOsPo6grLowq34GLp3jkhInd1Bw8WdbXRyl/Z8vMcwDQck7wwe6Rt1su8g0RvWygX8GKjnYu/HlHTDkqLbBnXqvvGV8cpld+i+6IXnIrsl2CeHzFEZvE8omXetkd5saW93Keu1hXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748313814; c=relaxed/simple;
	bh=IkOrj510YFWRDNSm44ivGUKJnKE50wms1mxHclGNhFY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=brJFeiXVI4y8mk3chRzKgpDVJzThmY7elXFSPlFQXi4GxnW23fjOhO1gRdtxs6ceq+S4pP3vqM/h3VkzSqWx9gpL/XG3MQA4ZLXKbVKCqxkFKdXYCU+LlpVvRz6n7IpE4tPy51NybB+kKctN3B4gy0N7m20FAGa1mleO7qGrUbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I5uvh+/O; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJqwGbYpgBtlwb1I0Y2pQSYfaDFpUx7+okpOK2nxUBoylWfFp6KQkajHwBNxfmKsLFd35tyQfNvANAW99hrAph1XxNm4Spq9iqzIVRIrr5isSBkghbNoUf3U5OxFvwzEPy/7sUJNqNH/ig4yeSZppzwnmbSBjiA1ZpnycHXwWWVbskhbdutfiYU9mKPMkp2UftifpnvRegM5J7NWIKfCou4eqi3/lGkTNGZjZLFcgCsO8nHxpdqdZeGSaXEilzTwP+u2ZzAMA3oHLECT0T/PYc82e0mdoNv66pZDWWl4CB2Oe0dzNjBC3fz/kwv3GaQN7ASnRybwxe2K915hVmK7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu+icsXbXuRczsQPhjPvdsEHYLFVuhFEYGdotm5OVvY=;
 b=N61VWpxa/NNkJVvyAcf95FhYWEifgdvY+or/iG9bhfmZeNt+FZK3nWnfrGrsnLuVyVO5N3yWyxVJSfUUIXsmeTHna4hf20JvDz4I/i8+FjfmDP1mrrAMJbyQT26D3wtzW2L6Cx2VsKwhFpXYSmNtoGwQiLBTLuaIZKrTk9qKSXoPu+Fl0h6OUFaqGwhU3AtYGIs/v/tAHNAJrYyjXM1t2S2tHscaIaQBJcgrTBGND75nK/gv/oGd3JjW/XLlzP/2T9LFzvjVUttoJFaYveCtXqo3yoWDYJ3bCFGybJ2DWtJB4ekiACZC32i7yd3du48c8k1eVXD4qPy6efxohxhrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu+icsXbXuRczsQPhjPvdsEHYLFVuhFEYGdotm5OVvY=;
 b=I5uvh+/Oh9gLSWfr4WHV4rm7IUWrLsSnRp+PzlrzthdKzO95ViHeBRcRsE0sqkd00wI2qFwX7dRPB9AoW0kmyBoGVaI4sdtUBKzwMCWMMAS3WW8d0wXU/2S0b4LhfnBNR8SVi1f7uCcc7Obeyw0Ytvp30NPqJE2TFi50KfwmFwU=
Received: from SA9PR13CA0084.namprd13.prod.outlook.com (2603:10b6:806:23::29)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 02:43:28 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::a2) by SA9PR13CA0084.outlook.office365.com
 (2603:10b6:806:23::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Tue,
 27 May 2025 02:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 02:43:28 +0000
Received: from qyzhu-os-debug.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 May
 2025 21:43:26 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <qiyuzhu2@amd.com>
Subject: [PATCH v5] ACPI:PRM: Reduce unnecessary printing to avoid the worries of regular users
Date: Tue, 27 May 2025 02:42:59 +0000
Message-ID: <20250527024259.56996-1-qiyuzhu2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 45429438-552f-440d-4d96-08dd9cc842a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pohf4oFFwEmMYXgnQoU/ewv7y7ERrVjy5iWYMXNa+Y28C5Pbo82kF1xo2mch?=
 =?us-ascii?Q?oybDjYU+YJ1sPaQcMwnenca6Omf88Pd7dD73yfJQC9b1dEUCXdRilNTfPXJB?=
 =?us-ascii?Q?2F+hkpEt1KKdF7pJU7QPRNJXYEcP3I6sI5sPbNU+YDkLCawG7Eukhdp8VKEh?=
 =?us-ascii?Q?TDLAeKE9sCpNLNqNSVwdKAaHc4GJj5muHNNerrzlyUAUgR1Y95kJyzjlLGG4?=
 =?us-ascii?Q?BlIWFmKHxbmxpYZ4ymY1oZwGEkQDhC59ppxoP8ZxuS8SRtM5cVZYulEw4MI4?=
 =?us-ascii?Q?wOJqx21H8Loa1o6qre6yQa7TzsNY3ttLYy6XPqocHefXKDhVf9UCqqnzZAP6?=
 =?us-ascii?Q?19XM8bUlPKCz5ce/Yw84fLd5Gig+YKJAY0sG8LpqaKskfmml20lf0iWSTorD?=
 =?us-ascii?Q?hKoJEJ5AWThiX95iftSmXH/bXUVjLq+OVe67ZtaDvDoolPK6Xdv1eG7MwjDg?=
 =?us-ascii?Q?YNiYSCVHFyTWRSuhR6doPnJ/35ZS93Dp7CP7PYoU3vQBdOC9vzEWvAjKHT+L?=
 =?us-ascii?Q?glM0FO53vrrJLXcmm+7RPYVc8Q7AU67KmLhdZbyO3o2YfEgDqY6e+e+CqJDq?=
 =?us-ascii?Q?CfHddHdezBLvuzQR8k+eHw4f1wPWjGQODJxyazwFf3Yu45Cd+q1d1/1xDrY1?=
 =?us-ascii?Q?jE172V2BH3LAG/UMmlQzwZGVLOPh7kXujlMYNb6CW01/YNpNCazUIHPQkEtd?=
 =?us-ascii?Q?V21epwhO7I2+PP+V+u6TQq7Y4eaqdckybm0LQG5+PocRWMNK4aoL30PzKO+f?=
 =?us-ascii?Q?z/Rr0Pkz94ETuY1f4NLXiaUIiBp3UVslBFoDQ9L7SJ096ObNjYZ89xbs19s/?=
 =?us-ascii?Q?FyZ1A4dnrgtcg9CM9svhefPjYsDxeJf9KbAtv8b2KAPVaW2toQRrYHG03jUj?=
 =?us-ascii?Q?J/duBRAJrkQYL1G4KKMIJYuO5VxfeJTMnbFsXOfW9wz+jveZsNbIjp0hzcAM?=
 =?us-ascii?Q?fUvcVaG12bzTMKLcjrGJsN0dHVlD0NyyELOJCAmN6L2poM+oSSR2r86jwmAe?=
 =?us-ascii?Q?bA07d+Nb+WuhgzFuUQtL5GjxYKaMrmATVkoTqf4ouPA1Ecd4WTkY0tN8o5nh?=
 =?us-ascii?Q?sXiWFesFc4QQ/Kr/gDV/DNx9l7Rg5ObZDCBrBc2NT1UDMUiryt/PnO/GYX70?=
 =?us-ascii?Q?ZmEdYC1GduDGKoB3fvbVNYSQCCjvTjXMOyDn/iLmZMh/LPHXm+Tsa34NIZrm?=
 =?us-ascii?Q?RFyyFNaBPClrryWiGh/6RRwYRF1zKDpuzHL8LYk3VHxFIdcNOBYr/925MJ+5?=
 =?us-ascii?Q?xdHdWsENqXUJqNTXQnJBw9jaV5hLROFhLwnKOSRtSLgcXx9GEaPDrw7ljVDH?=
 =?us-ascii?Q?7GdTDf3RSChin9xGG75CaLvDHEC9EbVB59e35vp011tPZKvTfnMM5WqoytBW?=
 =?us-ascii?Q?O+6QA1eVi2ZRfsL12cVly09wesUrduceCozDWzS5FNyuow1qIv2ZWonEFGWF?=
 =?us-ascii?Q?5oROJ1Ux0sDW3yLPmy/ZpCIz7BxWj2Z/lcEtIghr6oQMXDUB65LBowSTqo5H?=
 =?us-ascii?Q?JfPO5ftq/v+yeD8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 02:43:28.1195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45429438-552f-440d-4d96-08dd9cc842a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062

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
v1: https://lore.kernel.org/linux-acpi/20250427075317.42687-1-qiyuzhu2@amd.com/ 
v2: https://lore.kernel.org/linux-acpi/20250512010620.142155-1-qiyuzhu2@amd.com/#r
v3: https://lore.kernel.org/linux-acpi/20250512011833.142204-1-qiyuzhu2@amd.com/t/#u
v4: https://lore.kernel.org/linux-acpi/20250518062507.218855-1-qiyuzhu2@amd.com/

Changes in v2:
 - Reduce the code changes.
Changes in v3:
 - Fixed title letters not showing.
Changes in v4:
 - Only print the necessary warnings.
Changes in v5:
 - Add more cases of print warnings.

 drivers/acpi/prmt.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index e549914a636c..ed39502ed86f 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -85,8 +85,6 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
 		}
 	}
 
-	pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa);
-
 	return 0;
 }
 
@@ -154,13 +152,33 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
 		th->handler_addr =
 			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
+		/*
+		 * Refer to PRM Spec, both static data buffer address and
+		 * ACPI parameter buffer address may be NULL if they are not
+		 * needed, so there print out warning if handler_addr is zero.
+		 */
+		if (unlikely(!th->handler_addr))
+			pr_warn("Failed to find VA of handler for GUID: %pUL, PA: 0x%llx",
+				&th->guid, handler_info->handler_address);
 
 		th->static_data_buffer_addr =
 			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
+		/*
+		 * As for the static_data_buffer_addr/acpi_param_buffer_addr,
+		 * if the physical address passed to efi_pa_va_lookup() is nonzero
+		 * and the return value is zero, there should print out the warnings.
+		 */
+		if (unlikely(!th->static_data_buffer_addr && handler_info->static_data_buffer_address))
+			pr_warn("Failed to find VA of static data buffer for GUID: %pUL, PA: 0x%llx",
+				&th->guid, handler_info->static_data_buffer_address);
 
 		th->acpi_param_buffer_addr =
 			efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);
 
+		if (unlikely(!th->acpi_param_buffer_addr && handler_info->acpi_param_buffer_address))
+			pr_warn("Failed to find VA of acpi param buffer for GUID: %pUL, PA: 0x%llx",
+				&th->guid, handler_info->acpi_param_buffer_address);
+
 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
 
 	return 0;

base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
-- 
2.43.0


