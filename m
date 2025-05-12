Return-Path: <linux-acpi+bounces-13676-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E95AB2CBD
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 03:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF023AED7C
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 01:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4CF1AA1E0;
	Mon, 12 May 2025 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BdiAbJD+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C93CF58;
	Mon, 12 May 2025 01:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747012755; cv=fail; b=QEJfqsuaMMEFvDSvAykgD1aI0kgalTtDPfj4RfKBrbk8wLVP/C8Unigvb/R5hwD78ko6J0oOC0tCcy1V05h97gshgaBozyVkeGmJyDqOmx4CjOXNrAI6eGtkmpzIhWFghP/EBG/J4UMHvp2Ait+ffdM2mmUhGp5iRSu0tskkTvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747012755; c=relaxed/simple;
	bh=osjvq7WpUFmiIZ5otKaoBL37t/LrFTvYPVNs6zHz1zk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X6tMDaIh1iQaaq7NmU4J3TDSP6y8o+GhJVN9/9tbGjRZDZjB7Ap1L4JlyVytSFoWeMuij4jxji+FT8MfpaqAEW3uvoZnAxuNOFrsEwtANHOwRxVIaZU7EzH5Wsyf4bTVgjxK0B9kNgYbApmeF3yLb6lRx0stQ/VppONsKnAp3VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BdiAbJD+; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n90gSCSNpA6LYp7CJHarrrOU5fuJ92cPOgxeopIf+voX+iu0TSY08ZsGGFBiSnX+FBQgCUjW+bEVeiFeZGDK5hMjjdm5IOedvGr2+sNgjNonnIiaQeVrnvXt7Y0P8W2AuksNUACDopdyGzUj6fnHxXBwIhNfiseEWUH4EoxSP5leVFsF4x5uT+JifAmd9Uch/YQxmu/ND9UyGPLfXbdv1cvN9zWMf0bGgt9hStbYWGQXJoPdTQDB+qy9LPQ29W6zUrZYX8pWnylvavNIFE8TiywKjl+KL40fMuIrhExh2b/No+ajPM5QKVVY4Yxlj1Nu8HokDZylYhs874ZzvbNA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do5IczmS0ajiKBrRgQiJPdoWXl59c1ap6ZEF+GNAlkw=;
 b=ZtIl8a/ceETR3PxWyi7QVwynb0O0ZB9R47nuWA1m+kpmccbyoDMT8Q/zTi4Vp6vMgqlBuOc8hPj+mppJd3PtInxMGZ9qV7tIyUrf1YMn51ua8uSQ18V0iAQwE0dnnzAc2CSPKiSTwy/Q8iaoPc/GNoJb28PPRqTZ6BTtR+17uVeGqWheJVxWk+kz2LbUWCpqsxxHoZSeYoI3KaQYC8j2syThVz/PmPxLzDACfyFB3JRKJxGI0rSD/tGE+qmXDGLOhCZt++1Y1zFhF2poF8zUpLghelt/+GEvrbJqroB94lqpZiFf0a00miN/t0HVzYQQNQikWeJlYcCRZ8gamV4fVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do5IczmS0ajiKBrRgQiJPdoWXl59c1ap6ZEF+GNAlkw=;
 b=BdiAbJD+JArxjR6kvJ+AFVWAdVfw2xgXytP/wWoko8kDB5HcZmtPiwRi9a3eNhd/9GgLee8boOfOzJZGDUxZlRQ0ZPk7Rhd0s+J/7xd91wy0kakeMXq5TyfLWBD/vB3++ceg5BhzUdxNpSOQ6zyiYcE21gOV0+tLdiw2TmziM74=
Received: from BN9PR03CA0984.namprd03.prod.outlook.com (2603:10b6:408:109::29)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 01:19:08 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::4f) by BN9PR03CA0984.outlook.office365.com
 (2603:10b6:408:109::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Mon,
 12 May 2025 01:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 01:19:08 +0000
Received: from qyzhu-os-debug.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 May
 2025 20:19:06 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <qiyuzhu2@amd.com>
Subject: [PATCH v3] ACPI:PRM: Reduce unnecessary printing to avoid the worries of regular users
Date: Mon, 12 May 2025 01:18:33 +0000
Message-ID: <20250512011833.142204-1-qiyuzhu2@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: a00c1d70-4658-4383-9ee4-08dd90f2fe7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A2N/hbLdjIITD81XaxulWrtge8VOb562ZlpVHWcXAoK5QcbsPgkQUn3KCGCw?=
 =?us-ascii?Q?p0SKli+R4A+0zawxccNdm7MOKRJpXlWwBcrWo288MQCRTU39cEDH3y5daFio?=
 =?us-ascii?Q?4tENjNsE4KS42G0zBxQXzsBhTWtpYFn9j/reeZ4BEaj1mm2VppEggyHEhriT?=
 =?us-ascii?Q?CqNa8j156JnmJSepclrfes5IO8F8I8tozGYRVk5HbZmwuaySPjHfk85Jl4UL?=
 =?us-ascii?Q?ln/+aTo9rbUHZjNePTBxjnud2IFzIqSairns8sts3a54vwOYthvbebWnD73o?=
 =?us-ascii?Q?tB/kNtHO9PYMQXBiupDBvAaukkL+Oi/BM6JnMIQ3PiNIkeWhFQAfwiX5Kn5p?=
 =?us-ascii?Q?NIKJlrBHiCI6Hivrgnq45DyP7USCCZ4WwGvBaKeSSTUC7k3F1MhLuiG6RhYE?=
 =?us-ascii?Q?t6vrhAEkb8m0o7aPrn8STBS6xcdEAs0XRHozgnqewd3t5JTxSPcfwbsHM9Pu?=
 =?us-ascii?Q?Nb2ecW/iUJhIPB7h/4vV/8YfPvkSNahOX966R+0lhCKtgVlU+Bnd3o+XmZPD?=
 =?us-ascii?Q?Z6HCC+wlLpdaA/RP8+GS7BPqZsRCpYGaavWH/lkCNoHahhsJ3776ut8rJ/yi?=
 =?us-ascii?Q?beFiWSCS3vjhv7zi6JmCdoJrNZBN1BwAHTZHS3A6wjKovFUQFp0KmGDUX/rh?=
 =?us-ascii?Q?Lyg9rKfESxN2AJLUhuabn49dCkEXIr06B/RgMd6vN4uN561kot3vQhMkUlqW?=
 =?us-ascii?Q?sHA86nmQcXGoR29UUmOItnGSe+5sGv+Hv4EhxLEjCu5eWSlTMFLE/eFhz7h1?=
 =?us-ascii?Q?KMVtsKHpfzNMMOQmTiqHrI+Ay+E0qur3nPwpfJQydE1FEyHciHZoz35H2iiW?=
 =?us-ascii?Q?frTgw7sFGr2BYdKAdWXb1zIqOT54bvHIJX/kifH/u/cKik96l/+71MBHm8fy?=
 =?us-ascii?Q?whrznikLXJiArAT0wkLAfGC5C557SLp1GhSBSMtdRp36N8zr5nE6OOXxAPU4?=
 =?us-ascii?Q?bbguzz09+lUCcjae4Olq41OTVXdxqkx37Yvah3IUGk+cnESOR0aFCdJVJHyL?=
 =?us-ascii?Q?IlQVX9CLZHgv4L7EcGQS9YOilt2Mn8eRPrD4Beay9fIl3H2J5GhdhQLwwWgi?=
 =?us-ascii?Q?VKCoekcKIdVdzV+ktJXDEdx9h26BSJ+d0QiZe0oTaQ9BMBZpqh4xFTm/oQ94?=
 =?us-ascii?Q?imKh2lGEFBPKEGN9SkBfTjLWnhFEncAS8ZLMSgTvy31SM1+eNRrp2+HHaNCI?=
 =?us-ascii?Q?Ha2a0ghvClUvO8pfa3fex4lZEin0DQR6rIhs2+NB84JWw33Ek5hQu1qsTl3K?=
 =?us-ascii?Q?6TstrO752H6xmmRxq3isK4MdVskWbS7DuCmZmqzITaWgK6C0ydZm9Ah1B3Bb?=
 =?us-ascii?Q?K1Glp9ySqu3AcKCATddHUjH3VLNAz9zxazm9AUAn+QK6GQCUgWyff/C6vcj+?=
 =?us-ascii?Q?L5vK+jprr50M52CJSeKll2hTRnBWJB6D8w4T9dWHxOKyhb/K/QsbCd5M52//?=
 =?us-ascii?Q?rFyQhkM6TpBG/g+q/pVHty9u28IRb1+3k3oLnQhbLKwB3FvYGt8J8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:19:08.2177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00c1d70-4658-4383-9ee4-08dd90f2fe7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454

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

Previous versions can be found at:
v1: https://lore.kernel.org/linux-acpi/CAJZ5v0hv0WKd-SXFhUgYs-Zpc+-PsSNOBu0r7L5TzJWgddtsKA@mail.gmail.com/t/#u
v2: https://lore.kernel.org/linux-acpi/20250512010620.142155-1-qiyuzhu2@amd.com/#r

Changes in v2:
 - Reduce the code changes.
Changes in v3:
 - Fixed title letters not showing.

 drivers/acpi/prmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index e549914a636c..28a9930267a3 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -85,7 +85,7 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
 		}
 	}
 
-	pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa);
+	pr_info("VA for GUID: %pUL, PA: 0x%llx not found\n", guid, pa);
 
 	return 0;
 }

base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
-- 
2.43.0


