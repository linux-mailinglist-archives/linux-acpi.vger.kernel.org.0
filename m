Return-Path: <linux-acpi+bounces-14985-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6844BAF8545
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 03:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FB41C4601D
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 01:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B5F19D8A3;
	Fri,  4 Jul 2025 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F3yPn5Ri"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB15E18DF80;
	Fri,  4 Jul 2025 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751593301; cv=fail; b=pB47tWyZ4wTmj+rvAPhKpJi+TzqOO3TxwhqXIU4/Uow1CL5/hRB2YSCFt8aYIg+IE5L1ZUDIHDU2NOdsfrSozv+EcIKxBtaoP9ChOJweFdSfO7NZlsq/azc7CjjHtOpJVGsClbnvusICtlo6znpAlnps+XAS//RVr5xNtTYf3+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751593301; c=relaxed/simple;
	bh=MD9PmHElu+24oMUiXbQbsTyS1MoKsMIbGb6b3OUzDdY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ESrzu/pOwFxkx/X7LvwKXHu8m2+ju0RRiH3tB8GgiI0avJBcX5P1DslOIg1Q2WiUhqPnGh/MQVDtBKyou7nzfM5IMG1qRnqFsgO1bZ1dGW4PmAS9Mo2/zW19MtjGx3s0we6X0uniZvMx5nLR9ra4dvCkjBZAKu7ImR/FCrVA2hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F3yPn5Ri; arc=fail smtp.client-ip=40.107.101.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WH2JBOjYXYSq5RDwbsrEdUPBxsU75OyRAMxoNEatiUxmrhoFREAn+/q5f15PfiT+5eh8AEutPyRngcmLm6vlByeK3jbjWxtYr42Ravlq7tHeLgZRWkTmfc0w9tKW8aBk4t2EQGLKG3C+yHLkAcfNgluy9dYfs2XPW3L8uXY5a2P9YnyaoIOQl6UDo8Kzi4YXXy3JdFeoia9n5dwqU8B2m9L3mzFTE3G0BjU9xJXuD2iJOIPPwl/5gW2XHbmZ7H1QPEvk5YbyJJDRZ6fkJxGzA6SXv0tQHeqmQKg69rGrbrvm0/vCqm7mOO5OBLFqyDl41jCMMAxuGh/+XGBOcIiAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkQIHdO7iutwAseoaM6weq2vn6PzLF57X2mnFMNEER0=;
 b=a1A27FM6jQuSJsg2mfSEVqw3LZFlwsn7nc1CngXHi/zWMgeNQazVtnBWcAkYoxJXFrlcSekuPitLLpOVcAhSnR+O7sCSWeUwUtBpsH7bZRcDo4ZheP1AIsG3ijMSzMBW7DdS8kwCl5e9KBkM6D7M491Q1q5v8raAR59cdDBMDKFXilZ1VMp6ScJO6vbc6apVeDYbqzyKlBFqduxa2Lerpa33RE5HJJdHS+er2CnX1o4O+5xkZyaanDTXhfsssogNiMlYA4o8k8s+jgsRCthptiz7MICk6b5TplbLMgxkSYI7o3RvsyHi7RtV3aT0KuRIqSbo4/66Slm3pDEzlm4u3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkQIHdO7iutwAseoaM6weq2vn6PzLF57X2mnFMNEER0=;
 b=F3yPn5Rifhs7VrZWMZTX72FOJNvxonmq2KLO9fUoxZSlEUlE1V6+Zx/NtUcpav+njTDmVwsN+CZJV4aAQoKsTnTQDSuYNJdr15r7YXUpmcQS+nJ+pzTwXUylC7wczLWaiX/+0HpliXk+8l+XZxjd/DnVH96qbMhF/Y7N2RngUwU=
Received: from MW2PR2101CA0006.namprd21.prod.outlook.com (2603:10b6:302:1::19)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 01:41:35 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::8c) by MW2PR2101CA0006.outlook.office365.com
 (2603:10b6:302:1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.12 via Frontend Transport; Fri,
 4 Jul 2025 01:41:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 01:41:34 +0000
Received: from qyzhu-os-debug.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Jul
 2025 20:41:30 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <qiyuzhu2@amd.com>
Subject: [PATCH V6] ACPI:PRM: Reduce unnecessary printing to avoid the worries of regular users
Date: Fri, 4 Jul 2025 01:41:04 +0000
Message-ID: <20250704014104.82524-1-qiyuzhu2@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: de787af5-7aef-446d-e75f-08ddba9be8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?60mmjWdfBCxdIdW26TSPcnTH/b7f/XaK/4/BydXJ+EurfVnBmnYg6q/3fiko?=
 =?us-ascii?Q?/1IMzOkqci/2E/cu5dW5z+sb2WHCXCFcbA7PAggZ4cKUlSumRSf4casWCw+F?=
 =?us-ascii?Q?yUFD9AfV+sScercNOLjHxpvwvynvLCcUhsuIZrH6PQBUeNzxarIMGDy5VIw5?=
 =?us-ascii?Q?X7CMVFWULnTzZJJlk9n5YPvB6EsAh9JRH5B0+5Osdxrvq6JF/8C/cyrHsnTT?=
 =?us-ascii?Q?XX96uIO0lgf6Xd/qsfaYZJf6dRIIvrH2U76omzRT/8dol5s/Q2pnIJUss0LM?=
 =?us-ascii?Q?1qBEOhc6QqSbPAt630673OgW27ZyrVeFD9qGl9R48aMBq5aV3laFDNdxut9A?=
 =?us-ascii?Q?LAmPs8pALiF1BGqScnDIyZuboJzCWKjRb9LOevnLq6L0q2CPQQYIeFw81KQ8?=
 =?us-ascii?Q?PeOcTeD6PuwaMY9luZXNNiEBZerccUZr8tp6vUx+6Pm3uU1JnuQoW1Nhe4+S?=
 =?us-ascii?Q?mYvvtKJ0nsmuM/L0JvOQxONCzIW5PJkQ1T/JKhBkmU6qqNMkhtYjsIHrJG7x?=
 =?us-ascii?Q?x5ZURIcgbP1QAPirUDDc9pBfC+oBzioNXwIXsiPjxQLgHrEU4eVmJGKqqAi7?=
 =?us-ascii?Q?KWX2Bx85YyOUGinG8rty7KdGV3LRDSUg11LYtbRslSqOHdbLvkIW27l5nx2O?=
 =?us-ascii?Q?tty1M5Xwu4/Jyg4taD3YwW/DSQn7CbVfkxbFGEzFroGL0ntsv7tv+xvq7HkR?=
 =?us-ascii?Q?oSU6ww+14fBb7tA7IZusbp/FZmEsee9D+smcWtfGW2qmydx5Tj92JdUuTzAK?=
 =?us-ascii?Q?xZnA0sP8uVe3ymq/LRJn4jAqkXv31N9oeSSUtpQ6UPbjFlYA+d0nFO2NVhin?=
 =?us-ascii?Q?4SdhSGgzgz/+R6oDEsoHHKAjb7ff4EebzVtzjgl2c3TicioRs5ffuOQf4u4C?=
 =?us-ascii?Q?fV0f9s9y2lLa4tLTbpTTuS3S8LhHx3wDZvKih4k9o3EfSmEYDDONlwgUe29Z?=
 =?us-ascii?Q?zqx8A1KOHtcvmCRP0lQhg7wTBWXKsev5eYS8AJmHXw9jUU34A/y1xfuAAudC?=
 =?us-ascii?Q?KbvKOgT+1fuxU/jWR2f2VEJg1izzuyG3wDHsvtC/oiv8P+Km/dXaWmSrx2KF?=
 =?us-ascii?Q?X84q+Xg2zj32pOvK2j9peyMLhDOke6JEaXufbCof/1/+34Go2AQ8JCVBAM3R?=
 =?us-ascii?Q?hEH4iXx82h6Zpn4RUZGhmuiK44gagxkYQ3gAWmOQRpt9l3IV+DxVIHC9VVy9?=
 =?us-ascii?Q?GVtD8nnjt7m18z44OkUm0b47s6j/87QBptnYPumWOAsYUO+XpCbwPcVrHZmF?=
 =?us-ascii?Q?34mItB6GMsHo9dgseHMuUyOcitvt34/NqfU77RSjqoYRnmz/MQCqsEDhjGWE?=
 =?us-ascii?Q?wRBL0tCEurZWnpNHKD/mcehjRBjCCPIJbls4mTwSs3pzTuE+NJ46lGH+25ra?=
 =?us-ascii?Q?WMOXdK6IOucSyEjC+Us+QzMhXekBT/ZGllqDDdz9UUIKiJ2uaGY4PfXvR1uL?=
 =?us-ascii?Q?QYVjLI9OSYGmEu5pPuLIu8f09Su1OjHWkf2wTNttu20/kXZI4ctEZlqhW7l5?=
 =?us-ascii?Q?2yZFLCRVED01ybo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 01:41:34.1615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de787af5-7aef-446d-e75f-08ddba9be8ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257

Commit 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM
handler and context") introduces non-essential printing "Failed to find
VA for GUID: xxxx, PA: 0x0" which causes unnecessary worry for regular
users.

Refer to PRM Spec Section 4.1.2[1], both static data buffer address
and ACPI parameter buffer address may be NULL if they are not needed.
So there is no need to print out "Failed to find VA ... " to intimidate
regular users in that case.

Link: https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf # [1]

Signed-off-by: Zhu Qiyu <qiyuzhu2@amd.com>
---
Previous versions can be found at:
v1: https://lore.kernel.org/linux-acpi/20250427075317.42687-1-qiyuzhu2@amd.com/
v2: https://lore.kernel.org/linux-acpi/20250512010620.142155-1-qiyuzhu2@amd.com/#r
v3: https://lore.kernel.org/linux-acpi/20250512011833.142204-1-qiyuzhu2@amd.com/t/#u
v4: https://lore.kernel.org/linux-acpi/20250518062507.218855-1-qiyuzhu2@amd.com/
v5: https://lore.kernel.org/all/20250527024259.56996-1-qiyuzhu2@amd.com/

Changes in v2:
 - Reduce the code changes.
Changes in v3:
 - Fixed title letters not showing.
Changes in v4:
 - Only print the necessary warnings.
Changes in v5:
 - Add more cases of print warnings.
Changes in v6:
-  Adjust the code comments.

 drivers/acpi/prmt.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index e549914a636c..d7857ca8fb4c 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -85,8 +85,6 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
 		}
 	}
 
-	pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa);
-
 	return 0;
 }
 
@@ -154,13 +152,39 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
 		th->handler_addr =
 			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
+		/*
+		 * Print a warning message if handler_addr is zero which is not expected to
+		 * ever happen.
+		 */
+		if (unlikely(!th->handler_addr))
+			pr_warn("Failed to find VA of handler for GUID: %pUL, PA: 0x%llx",
+				&th->guid, handler_info->handler_address);

 		th->static_data_buffer_addr =
 			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
+		/*
+		 * According to the PRM specification, static_data_buffer_address can be zero,
+		 * so avoid printing a warning message in that case.
+		 * If the static_data_buffer_address passed to efi_pa_va_lookup() is nonzero
+		 * and the return value is zero, print a warning message in that case.
+		 */
+		if (unlikely(!th->static_data_buffer_addr && handler_info->static_data_buffer_address))
+			pr_warn("Failed to find VA of static data buffer for GUID: %pUL, PA: 0x%llx",
+				&th->guid, handler_info->static_data_buffer_address);

 		th->acpi_param_buffer_addr =
 			efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);

+		/*
+		 * According to the PRM specification, acpi_param_buffer_address can be zero,
+		 * so avoid printing a warning message in that case.
+		 * If the acpi_param_buffer_address passed to efi_pa_va_lookup() is nonzero and
+		 * the return value is zero, print a warning message in that case.
+		 */
+		if (unlikely(!th->acpi_param_buffer_addr && handler_info->acpi_param_buffer_address))
+			pr_warn("Failed to find VA of acpi param buffer for GUID: %pUL, PA: 0x%llx",
+				&th->guid, handler_info->acpi_param_buffer_address);
+
 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));

 	return 0;

base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
-- 
2.43.0


