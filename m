Return-Path: <linux-acpi+bounces-6428-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20802908CEE
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 16:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037511C25D03
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 14:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C30519D8B1;
	Fri, 14 Jun 2024 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DXgw4/Nj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FA7D52A
	for <linux-acpi@vger.kernel.org>; Fri, 14 Jun 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373741; cv=fail; b=POBYL5W74XiObCnXCG4hTTzBLmaGiF94RPzqW7VF7SN7+ftf55CnAasGAjHjB9ICt4CDu/Gxe3KzWouKEQGiOM9zwTMxW0XZBtwBsRY6DDKAPYROwjg2wuSr3ytE9B43/4AxNOfQ+1wyzrG2FmE2NLVeXql1IDdCuyyWu/wikcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373741; c=relaxed/simple;
	bh=0GMO/6xr29CV8HVNoc2Lf6vOr+0MhI0Infs1pOWnFRw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J0U9ap+dQGSWWKOzInX5HiYgUoqz0ezAz57OhWNpfWoOpFbxq80AcutKTCBIvr8sONPmq2UubEx/euwdqLpD8PJRLJmInrBE65hw/EibXHerZE2QYNHlAxFDCoQpOCW0FFL2mXVKBPjQKtGcLKpyyUzUi+Druhf5Mjb7eXD9/V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DXgw4/Nj; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnIxQRKPoZjfLK78aoKlHTBJTS7F0eb/BiNqnN/U85BQ/Q8UnlQN7pKpqyluUsTjHe3/5BZAEUuOQDJ1KA9/5XGQqELFkoURz/54s9i1oO1mJHPxDgmhW3NXr65AfLycgGFPGL60nev6LFfXUH6oHAKNX2VQyU7y5QcxJ4tqEoYSVSaKGudCanejOIDxBmVlGyEyDYMK5tFuBA8HrAVvddQwmfYEkMJ07LRNeLrPDsD9Q4H+MGxkM0oaIW68a6Wg3geX3zH4FF2NfRslXy0nSMgzJx9pFFPh5Sz+A7Pmte4hEFQmlYEvKDvigZZTOiCUtK6M6j2NB1L95vI4NdbTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2uFUZVOq1YdOvSjOOariDnrNMextexWZGg4VlOxVTI=;
 b=K0Tcnvz1lu0zaarpbSi6fG24g4jaPbOjDbTRRSy4LlKSYL7YFyXHSCfrBQWizaxOIIT1POp/P3r1MKpuD9xl5++2b6xOvnO2tbhqkAiQ+3aXX4kzL+FSFx/mN+Xivtzs+4n8q4F1pt/QMa9PAyEwZS7q9M1kv0RXZakm5gxQd3KXSdsV6+x90gfN6SkDMESvDzIgz6T4+aS/SW4nUSls7Lu8VMrYOXqV6I+ZSfq6oewVLJlEQmP8c+iLj1XPI4GDOwPxWl+DbiFGDhrS3jz26NUKeHnNl4bvB+mGVgC5e5akC2r1h92nUrpyfIhgr9gZzVoI5FYr/KMYNI2t5NUfUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2uFUZVOq1YdOvSjOOariDnrNMextexWZGg4VlOxVTI=;
 b=DXgw4/Njg+0g+vLzkEGvagYZ+NEq4JBC5VMC55ymFcvZV4pH9+1nbBes0jwWBOwp+06q1eeiln2UDMemnD9nTh2ndHz5A7YTgQtdrk50QYhY0dzEB/E1VH0Y1eeglpcxY31Kf4H8c0kAXmLxU0BntAzXMlHPRDjAc7dO7mjhpZA=
Received: from MW2PR16CA0070.namprd16.prod.outlook.com (2603:10b6:907:1::47)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Fri, 14 Jun
 2024 14:02:17 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::5e) by MW2PR16CA0070.outlook.office365.com
 (2603:10b6:907:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 14:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 14:02:16 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 09:02:11 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <robert.moore@intel.com>, <rafael.j.wysocki@intel.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Sanath S <Sanath.S@amd.com>
Subject: [PATCH] ACPICA: Revert "ACPICA: avoid Info: mapping multiple BARs. Your kernel is fine."
Date: Fri, 14 Jun 2024 19:31:49 +0530
Message-ID: <20240614140149.1654251-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7ad559-f46a-4e39-a35e-08dc8c7a9948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q1Lq6pfzG9PxU3aRnVGSv3nz2LUjji5qacjpagX6364Hn2MitrLIZ4e19TjG?=
 =?us-ascii?Q?DGv/l0X8FWYsZkCAGhvlMdFah5akbMNPLlPK4SeaWbKo7h2LonOPDYuaLbqL?=
 =?us-ascii?Q?pq0ChNgooVuEWy0gfvZ7uGjTrUMc6dx6A5Cr1w7rl5sP/FBrkcvxBljhxkCa?=
 =?us-ascii?Q?OF980/4+Rd1mGgz4/CMwCnInKfrRUwnDdjOopEETN6t3qNo8rGL+JxkM7TpJ?=
 =?us-ascii?Q?+z8rUA2EK/g4TN1z4tvy2S7s2RWWNuiOOqg2helG69h4STl28L5lVYcT3Y7d?=
 =?us-ascii?Q?NMk00pz8jzt9ipq+gVb3AYsuY/Ek8UYA37nDMT+hfLKmyfJzzo2fjMHTlLYJ?=
 =?us-ascii?Q?wgGzvWRjV9ps78scggp1eQ5GdBVoyOkUw3aoWY9IMrDo6f8ZcrtBe2kZ21b0?=
 =?us-ascii?Q?8gM1sRCsy7fp5FkOSBeOJrBnqrtIqhIGzb4S5aCb/K4Q1hr6zK7QqjcGuLeg?=
 =?us-ascii?Q?1FKwEqHwDkyy6c5+YSP1xSyeN5iE56/WnNS29vqgwSwBbAWKDVvx7Db7Ayog?=
 =?us-ascii?Q?CCZJ1rgv1rNz0EcVkUbndD7OvaJ4go4rol+rveVXGGsPDjtSr59MgTNE34/U?=
 =?us-ascii?Q?NkbcSFADXZQK2pg9DuFVeWBIg6zIVvheYxjeoLpk7iPpUYF/1lWUW9gazWqA?=
 =?us-ascii?Q?e5I23xjHSx9b7K2X0uXC7upJHLwoM+/wequVXmFPhUXg3K4CImaM/zzqQJxH?=
 =?us-ascii?Q?0KnSxNfLbXV1MduLh9xRXvTTGtDnVJGkz24WLTLZwDfVU0IbNmMZOpkk7y+t?=
 =?us-ascii?Q?yOvXOa1BtNPI4MEf+A62Q6kkgbwwDUmiuaNdY3ZYJUBf3aO63bcn6cAw65tj?=
 =?us-ascii?Q?RRXRmp2/SxAAuuF40uvzkK1sx+DYHHpseqyPR/5Lmf0zZpJV5acUbYDvXpt4?=
 =?us-ascii?Q?Ck+VrrwbUjFZKNAoylhV3spJEAiZbFKxaJEkbf32SficQ1OXF/3YfE08j662?=
 =?us-ascii?Q?6B+HpiaMRh5NqlKiJIVDS5yjtlhr8UdjD4TIeK4yl3tsWv9mdZNDgDCA8ljP?=
 =?us-ascii?Q?TuhJj9cdOF8vcGe4fnYgkBwz9/8J2qRPkGLycq1T2IGOB9f1DhfntFa0uC0Z?=
 =?us-ascii?Q?D34Dw3WAewo4d6oYBUSc38PZ+XeulKXAeJ3l+zTjRN/s+otqtiD4kFmBD6NI?=
 =?us-ascii?Q?ivFPoG5y+5hlKP+sQydh5SnFrl2QkTsoSweY3EcLASUjU3JFnejGompRRZMo?=
 =?us-ascii?Q?5OcmV5fdAVhRerNiJIx4WQpBPbmGfDRwhy4ZPaASoxRV5OGBYwgGF3g4wKvS?=
 =?us-ascii?Q?/g2mO+86yQRArhvQo6pCZLryiPkYv87+CM9Iz5FvaDiFS8AIvSOEAZlE/MMQ?=
 =?us-ascii?Q?l3AGA/ks8h7+8qMZAe6n8XQmUfm2VJBAXWJsFYlk0bCRUsa7wA2hcPG6iLcb?=
 =?us-ascii?Q?6YPtaVg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 14:02:16.2216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7ad559-f46a-4e39-a35e-08dc8c7a9948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318

Undo the modifications made in commit d410ee5109a1 ("ACPICA: avoid
"Info: mapping multiple BARs. Your kernel is fine.""). The initial
purpose of this commit was to stop memory mappings for operation
regions from overlapping page boundaries, as it can trigger warnings
if different page attributes are present.

However, it was found that when this situation arises, mapping
continues until the boundary's end, but there is still an attempt to
read/write the entire length of the map, leading to a NULL pointer
deference. For example, if a four-byte mapping request is made but
only one byte is mapped because it hits the current page boundary's
end, a four-byte read/write attempt is still made, resulting in a NULL
pointer deference.

Instead, map the entire length, as the ACPI specification does not
mandate that it must be within the same page boundary. It is
permissible for it to be mapped across different regions.

Link: https://github.com/acpica/acpica/pull/954
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218849
Fixes: d410ee5109a1 ("ACPICA: avoid "Info: mapping multiple BARs. Your kernel is fine."")
Co-developed-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/acpi/acpica/exregion.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 8907b8bf4267..c49b9f8de723 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -44,7 +44,6 @@ acpi_ex_system_memory_space_handler(u32 function,
 	struct acpi_mem_mapping *mm = mem_info->cur_mm;
 	u32 length;
 	acpi_size map_length;
-	acpi_size page_boundary_map_length;
 #ifdef ACPI_MISALIGNMENT_NOT_SUPPORTED
 	u32 remainder;
 #endif
@@ -138,26 +137,8 @@ acpi_ex_system_memory_space_handler(u32 function,
 		map_length = (acpi_size)
 		    ((mem_info->address + mem_info->length) - address);
 
-		/*
-		 * If mapping the entire remaining portion of the region will cross
-		 * a page boundary, just map up to the page boundary, do not cross.
-		 * On some systems, crossing a page boundary while mapping regions
-		 * can cause warnings if the pages have different attributes
-		 * due to resource management.
-		 *
-		 * This has the added benefit of constraining a single mapping to
-		 * one page, which is similar to the original code that used a 4k
-		 * maximum window.
-		 */
-		page_boundary_map_length = (acpi_size)
-		    (ACPI_ROUND_UP(address, ACPI_DEFAULT_PAGE_SIZE) - address);
-		if (page_boundary_map_length == 0) {
-			page_boundary_map_length = ACPI_DEFAULT_PAGE_SIZE;
-		}
-
-		if (map_length > page_boundary_map_length) {
-			map_length = page_boundary_map_length;
-		}
+		if (map_length > ACPI_DEFAULT_PAGE_SIZE)
+			map_length = ACPI_DEFAULT_PAGE_SIZE;
 
 		/* Create a new mapping starting at the address given */
 
-- 
2.34.1


