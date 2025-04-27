Return-Path: <linux-acpi+bounces-13308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C02A9E09E
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Apr 2025 09:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3347A5862
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Apr 2025 07:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4E241671;
	Sun, 27 Apr 2025 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cUXOcMxI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98561DE8BB;
	Sun, 27 Apr 2025 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745740441; cv=fail; b=MSUn9j5stFs2LhXQKAKAMF+ZOCAphlqAXxoJntsMwY0pETCRqSdvYhGroYPZLYR/cAwngrjIgn+ulWtNgLBQt9nstyHnuLCnrwyRTOAI3E8HmIMAQUHlfQxvSb0UQzkxO0o9YoGUt9YfYrTwyqb2liQmU1Az5eRJmSLi6tTAR1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745740441; c=relaxed/simple;
	bh=Utci7A3zm04tp9YkPO9VPwYn81k6rtKtm6OQZLbbo74=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VxsTtfL9hDorFPicPvB1kFFWGSjW3hMrx4Kay15yFDiHM76DmsmK9sFKcNOPQPIL5AjCqKa/Ns1ugnsnvBBXvLOzZV1IStYA3BaKv1RaYTlX8qLcNNQdioK7+HJYg62MGVz/Nnsa8+4lRHM1Ka54qyvCHKnD85a+/1q5gMbQCbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cUXOcMxI; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrB16WytloQni0NDJlNwfC1RAIj8vbbXT3TKbOjvirkTTYMoZTvGHAH3dc0lsKO6jSgFo2ZOjeo4xgQimxV8yKuPKiVEAT4aJcXH0OiaS7KOjOFjszF3wBQ2LJT6tyCmShHWIdIbRi82a7q2SRKBAG8167RjSDGqBeA4HA4YRq7rED23W+QsapM+QolytbAIQ//nU3+Eu7DZBsp7jwGAE1H/Ku0S8S4ixUkzd7EK2aOUUdDaGllVzAEgHwx3TqtKKIisKPPwkY/mtdIFZWFqMQRHs6sv9X/Fa+qH9BgADRi6rO1nsJzgCYD9Q2+5uEmWTLcYWsiZIa/BFla5I33HOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3YAzKJZLJqfk1Xsi969Z88EZu02mRJelfre43IGml8=;
 b=N0Cklx4Si4TKH6UiAYoA87VSqXOXvbMqCMzd46wgo5lqrA3ZQkVmxSCpyEpM1JiawvX3saCOmWptkMnjXyY+33kar0tmE2cz2CmkdQrXQaqxaR5WkYTgBhDts6azRjfVASvJVEerPrQSco9iWx4SOHx02O7B65TSHE/YvEh30lnfcTiRfLVMULRD539pJ7jM9+OZhIp7d64QQO0uTT9fdFUTz8KIWwvrHHbyzYHDHPBwYC8IVM8YUDvRANRsuZFgOhIlub3eCOApRqe4Q1/fNz8XKg26fbSMCaPt3LfMNxlgcFs0vbjwvuKBvK6PCUzdI56XyAXY69m31NgY5cWGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3YAzKJZLJqfk1Xsi969Z88EZu02mRJelfre43IGml8=;
 b=cUXOcMxIqdaPdUkPpeJ+aNEt3Cnp+ktVREUKrd64Ct9V8OHtJoaZFACJMjz1a/SnuE09iUPHUXD/MSXg/xpsz9XFtwxYMTD2n3XrqsKyb5nviHgYJkdUdkN4cHNjhs1mTv+ccIozj/AcfVcBJ2RBjD3DD7KLc6febWXhQp1og5A=
Received: from DM6PR02CA0092.namprd02.prod.outlook.com (2603:10b6:5:1f4::33)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Sun, 27 Apr
 2025 07:53:52 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::e1) by DM6PR02CA0092.outlook.office365.com
 (2603:10b6:5:1f4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Sun,
 27 Apr 2025 07:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Sun, 27 Apr 2025 07:53:52 +0000
Received: from sh-pool-purico-44bd.sha.scpi (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Apr 2025 02:53:50 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <qiyuzhu2@amd.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI:PRM: Reduce unnecessary printing to avoid the worries of regular users
Date: Sun, 27 Apr 2025 15:53:17 +0800
Message-ID: <20250427075317.42687-1-qiyuzhu2@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 473a0d9e-7f67-48bf-34eb-08dd8560a73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/lnIGRD+EhLtkOqdfaiU3qt8q9zOqN5FOfdVaxdNJcvUuRFMB2mJcDExt7cS?=
 =?us-ascii?Q?KoTeCZIQoFDBrar4hA8XTh826bYHm7/J4nld3vR8d5DwScuPReNUVY2TSLia?=
 =?us-ascii?Q?IvE5lq21lKfDpOk1uctXbIFtWBA/m3G0t8CwrPW64AA1u3b4BjhqXo9KrKKM?=
 =?us-ascii?Q?te0gBmUINjTARbZK+GqcIp5GepUfyMEKk4cjnFuW5kRjAYp5emIXttRmpnXv?=
 =?us-ascii?Q?O7y1ayUlLUCLm0ydfFxp2Hf8H/CFToUZngbPOrDLNxGIiWhgYUbS169lfND8?=
 =?us-ascii?Q?1jkBE2oW3cHf6HM39eDsefechQcl58LL42dJ79HiNvWVKFjAOpIh2mlzfba1?=
 =?us-ascii?Q?EHmheF7oDKYJjypXKCGSd0WqjNop24nycLXimqFxdqwSbuUGs4Kg3p55rSDD?=
 =?us-ascii?Q?tJ5NP/T0gjNHM2DbJedypu7fv6NaB62wgiceKYtExfLx4Vxg5q6L4wssqoLG?=
 =?us-ascii?Q?fdMCtHnT1aauhC97JtS7vZLeb6CrRmnQRAtCSR2/4cKRb+JxnnRz9ZsZlMo7?=
 =?us-ascii?Q?6J+fDmzYERE//bApORYm/+487SNuxanzrp5uZ84LhzkkSShw2kbUKsN1he5U?=
 =?us-ascii?Q?o2PmYDhbkQllsWAIp+fjYoupeFWb+WJZVU+17BNpQH49JFPHdj6QLXZeX3Fw?=
 =?us-ascii?Q?Ctl2fCKOuJxGYdydXtFK416YEtG1zChIEPtzbC+FoL9C/3CMnaN4a6Elj9ia?=
 =?us-ascii?Q?1/SevJsTJAwjsnQhWjuu7+/A81xHO1ULgobK9h/dOoKksvpXNZAaUWFsax+v?=
 =?us-ascii?Q?tnifo9OHMIB/JgwuqeG9Y34E9GySLB1oe28IlJ7wijZ6uHvkfRxN+Jw/a9j8?=
 =?us-ascii?Q?M96tiFZg2mlLsERpDpHxxjoqTz30/A3VSDJFzP98UNTcT+QgfDCOTrQHJKt9?=
 =?us-ascii?Q?zuhF5j+bkKFHTkeTCYzoBMDguOLToj9tggQb0NhoJtTbzb7QOuvpByKkz8sy?=
 =?us-ascii?Q?vE8loKuuoaJ8vHMNebwIRtanOoapx55Jjg2v6rdoiyW6K98mCsU0BJboiqot?=
 =?us-ascii?Q?LY/KX/FEAIHXEtgw87v1feozyhbY39B7676qRjupETV6Y0jt/qdrghqVLq4t?=
 =?us-ascii?Q?BKoqO7AqqC8FYsBBY5oAJo+5VD780uJPdauTOjp5DtTP83qefq5EAqhzdy1s?=
 =?us-ascii?Q?aUHeJZWEb0TL3DzwYsxoabTFGnqxVU3TLDj7eHQc2PJwM4GisCsAHpv2FPd4?=
 =?us-ascii?Q?MzBR9+B8epFP2X1ygGxq76eNfQ/RLEKQWDLWrUoOYQF019eHwnpITxTYYs4L?=
 =?us-ascii?Q?r05PIhZmHVKtpUIXrmhWh0gjdAFA0IMrE8c/6Hh+NxPojkx6lJGu+zHTIbnX?=
 =?us-ascii?Q?CAmSow2QCKvwvVXqE6Spqi6davm4bOr+cSrEKrELi6TRAAE9gRSEhMIS2vUj?=
 =?us-ascii?Q?srlCGdXrF6TKs2V/9BOX75YqmdXpFQHpwglWaML9ZMiYXvJsNaKKggypI2Q0?=
 =?us-ascii?Q?cve9LTOz0NX84sQ5UHh+xUCzobjy2cl/5MWx3tIvNv0Di998cIsIrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 07:53:52.4661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 473a0d9e-7f67-48bf-34eb-08dd8560a73a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196

Commit 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM
handler and context") introduces non-essential printing "Failed
to find VA for GUID: 7626C6AE-F973-429C-A91C-107D7BE298B0, PA: 0x0"
which causes unnecessary worry for regular users.

Refer to PRM Spec Section 4.1.2[1], both static data buffer address
and ACPI parameter buffer address may be NULL if they are not needed.
So there is no need to print out "Failed to find VA ... " to intimidate
regular users.

Link: https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf # [1]

Signed-off-by: Zhu Qiyu <qiyuzhu2@amd.com>
---
 drivers/acpi/prmt.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index e549914a636c..fcd721559eb5 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -72,7 +72,20 @@ struct prm_module_info {
 	struct prm_handler_info handlers[] __counted_by(handler_count);
 };
 
-static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
+enum prm_addr_type {
+	PRM_HANDLER_ADDR,
+	PRM_STATIC_DATA_BUFFER_ADDR,
+	PRM_ACPI_PARAM_BUFFER_ADDR,
+	PRM_ADD_TYPE_MAX,
+};
+
+static char *prm_addr_type_name[PRM_ADD_TYPE_MAX] = {
+	"handler",
+	"static data buffer",
+	"acpi param buffer",
+};
+
+static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa, enum prm_addr_type type)
 {
 	efi_memory_desc_t *md;
 	u64 pa_offset = pa & ~PAGE_MASK;
@@ -85,7 +98,12 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
 		}
 	}
 
-	pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa);
+	if (type == PRM_HANDLER_ADDR)
+		pr_warn("Failed to find %s VA for GUID: %pUL, PA: 0x%llx",
+			prm_addr_type_name[type], guid, pa);
+	else
+		pr_debug("Failed to find %s VA for GUID: %pUL, PA: 0x%llx",
+			prm_addr_type_name[type], guid, pa);
 
 	return 0;
 }
@@ -153,13 +171,16 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
 		th->handler_addr =
-			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
+			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address,
+					PRM_HANDLER_ADDR);
 
 		th->static_data_buffer_addr =
-			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
+			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address,
+					PRM_STATIC_DATA_BUFFER_ADDR);
 
 		th->acpi_param_buffer_addr =
-			efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);
+			efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address,
+					PRM_ACPI_PARAM_BUFFER_ADDR);
 
 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
 

base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
-- 
2.34.1


