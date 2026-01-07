Return-Path: <linux-acpi+bounces-19993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D5DCFD8E0
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 13:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9120130CC024
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 12:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD418238C3B;
	Wed,  7 Jan 2026 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q8nGlyD2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6043016F2;
	Wed,  7 Jan 2026 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787425; cv=fail; b=rLEhzs8ZPcfpI4A7uCDQtTHWCcX90RjG/oWiX7Em08pkBT885epzI/lL4yi+Tjxpzj2HyzOEtwZ7chBPIHK2d5Gys+JSwUOcPEOed/yL2r7+kgR6e1IYiAwtoS6H1Q+frdD0c73U4n0DEzrirg4MsMMJF3hBv/xoDW/TjBrGlbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787425; c=relaxed/simple;
	bh=9iduXtDcTsYJynb48Z4LbRsQy+WMqZ/x6t2Irgn586M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fOgp9D7qu/RMU15ZVYKW4bMgU01Ged+5K4qMVZbCVweKW0rDE4JMv15Zc1a9z8ZRT5RI9bI2v9oGeLTwvlmgO3j6Sv8RVQZXCZuOU6V5uS7aXXd47lgL6uIWhlCxY+MqbKbBodysjibFlLM/Kf2myTWzqNf8XQoW/FlgdNrkS/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q8nGlyD2; arc=fail smtp.client-ip=52.101.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWetTf5u2xSBIFU0+Hecudg6OVXXQb6yZPzd7Qf3/FQukbn6qZV3F/P4RFZY3R4EbDn+M1On6bzAOzWLzcLoivv22kzn+Q8H1xoRMHR7qx4inOawPzpJucs4yK/z/6OWKT7Qa1/xHYBi4+xcKVdyYfp9HKn+VofvWRS4pPkePfZDS+rCESyPHS0ZehGQvNBn8euQ9MrQ2pJ9T0qn6mpiSv2Gl23Mjey4/3HW3o/2K6BTBZo8T4hNnSEnQmSsGULYskbuolvVTQPYcvfcmPmC8QCAOMeOiXJ3Lt9TzK7fSRsTyS4Wsh1kOem8ysMl8fMUfp4NKOP0NBV7USX+YK7/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LdDCwUpSn68bAdhX4FlsmPs175rjINtNsSsb8lDmPM=;
 b=H3njzEGj7ijnAMiVAxITuJx0cK91apVv4BfZUtMeYb8Ecpi8nTANAnvFdF3RPDRPinKgw/CChKanz1QzyGGtC+gRdHjN3QkIGt8I2VItLm0rD5nFZFgz84yXlWpKZhgDm1SBD/T+i0t8y0N81FiatrZcgkqf4w9s9dHyfgaEWJAKXXdfif91Un3gQxlUylj++YipSV7G0clDlFn6rBClclbm/AtgjofEwTN5gzk84tx7xFQ/j0Lb/dkwIBCNGgyyEPYOL6NqXluS8x6z6Z3WwbsUlyGdkJgRe0UM6SXH9kgEivKPnTOEbEZNgRqMFRX1feEAgkVIaXxy2XvZ/P9hBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LdDCwUpSn68bAdhX4FlsmPs175rjINtNsSsb8lDmPM=;
 b=Q8nGlyD2gFkl8BY9V/rYfjaTRFk7qge8v6KNO0NhQ7RMCeWt1hRYlLQ++lg5fnOPQvzh80vgU+p6Cv4X7elAUoHH3V8v7VlMqRayDNykrtBOGpdyLH9Edo/z1mBQdfSoRn8yGG7vhDxZzKzQ/9doHWMVGdGQqa/wggkOnYsAezIzMZ6keh6z4KafMBOUftjlGgTsqCglc9IG/NYP3xWo9J1JGNnYNKlpKCRPndT7sfoaTUhBt1meLdMdP/kT4pv+BS+cCQP6GOxRXnFul2xxkoiPKZ45JnSA3bAHKg/XGpUNtAuRkyAeCmyIdI8WXOKRXSWA6p/GqNlT+6uzBgUXQA==
Received: from SN7PR04CA0238.namprd04.prod.outlook.com (2603:10b6:806:127::33)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 12:03:41 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::ae) by SN7PR04CA0238.outlook.office365.com
 (2603:10b6:806:127::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed, 7
 Jan 2026 12:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 12:03:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 04:03:24 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 04:03:23 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 04:03:21 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <lenb@kernel.org>, <sakari.ailus@linux.intel.com>,
	<mika.westerberg@linux.intel.com>, <andriy.shevchenko@linux.intel.com>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Kartik Rajput <kkartik@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] ACPI: bus: Use OF match data for PRP0001 matched devices
Date: Wed, 7 Jan 2026 17:33:18 +0530
Message-ID: <20260107120318.13130-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: fd03ed2f-a075-4484-43ab-08de4de4cc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QArEkimQio+4Ey1njx3p0x8+ct3wZi5FIO6Ts/dRnlb2JJegrHm4y0joETCw?=
 =?us-ascii?Q?em5BRAPs0/OAsS+LcQPQCGlVY4rpjFg3RA3jFzzI7WUs2mRYeak3deQdCqGT?=
 =?us-ascii?Q?XSfIy5wVsznAP0CeaOU/hioYUNBtNghywqqbsSAPqgm1wyv2ERAxYiXcJgow?=
 =?us-ascii?Q?8bVfX8EbY7bPK5UWuN99c3mSkckngGvXQ02Y1E0Bs7tMpkFyDcycZUaxng01?=
 =?us-ascii?Q?PlPJneh01T71tFXFXd+XWwS2wmEqR1AZE9QdQe0msp2QChjZEtWNz2H9fENS?=
 =?us-ascii?Q?FPKvkD2gFBmrV31Jy53PUr6fN0ZOFWToPT74mh9u25SQfj8JdSL5VLupGuxU?=
 =?us-ascii?Q?nsBoJj6Becn+mqGfLny05WXnhpmyCFCXgVDxu5dJbZYZhizRl+BOTPj6J6k0?=
 =?us-ascii?Q?6J4kUPzuCEXUJ3yXX60LZg+6y4sc3yRseuNKERi1e5OJ7mCgNDqnxPNpYrdr?=
 =?us-ascii?Q?1hKk6Z7DLQr6y/WqJVH+nWCxgf4Sz6nBOMqN3NTyfxJqsm1B8zKxffyMvzhu?=
 =?us-ascii?Q?ljzgLq9pemigdxmlI9oKn6TCZJHexigxw6fRySFwQnXDRL5DwGRnl/2lxIDy?=
 =?us-ascii?Q?iojnwJFQBvXTQfhnAQpfsSIdRNVC0fPo3h8Dh5LS73LLF21vZwNm0hV9psTy?=
 =?us-ascii?Q?rgG3Xfl+utSFqAxQfGV10h8TDPBcWmJgshme1PM3inohUL81PVPNFF1a6CW4?=
 =?us-ascii?Q?hb8fW16yiGYjP1J/jXJ5/Hcda5RtuqMoGVxNhdMpjVKHoYouZMJJR/YlmgP7?=
 =?us-ascii?Q?laqJYLJ8V3RCTQlcX7mtfO30nCOcjlsNdrB6VhA92mAohUd+b9Lhqy3JRdwG?=
 =?us-ascii?Q?bnt0gbsON4CjTTo2HmO/gcV+g/IAu9Df9LsXdOq7pOsbFnaIZtdshz5eHIhu?=
 =?us-ascii?Q?sBWLP8/JwLizh9NWOBSV0aQY91TuP0194yX4+sxaPL3aXocnYPGE62eZTh5c?=
 =?us-ascii?Q?TjqC5PbZihjwuaUwCeEZvKFrR1MkH4Rd7/kv+AcWpNDXkgwOxb6DTFpCqG2Y?=
 =?us-ascii?Q?xIsC6dSOSPW/YNMMCp4S//zFZQkA1hZ8HA2IgSQkP8A7fJKlukgXEa8pLYuU?=
 =?us-ascii?Q?sH9CGA1LbsXZXv9px6Pqnjro7KJhk6wm4wVL9JINduyeRZSLC8iKefyByISV?=
 =?us-ascii?Q?ERYVgkDPoujJOPiQVXIMr0u7Dtxph1jbNx7+0Vnyrukehh0Ggaesw8/o2/n1?=
 =?us-ascii?Q?91KazSxsZ/xCMLpn3m4rLq/FdwucHjEXwhp4nWeA8yQa6j1XIySR8CFdBgQq?=
 =?us-ascii?Q?AtxosYdCF8p9uNzw091XcEoaDt3aohJ+L+pq4gFKkNCGENM523oyQDUn0qKs?=
 =?us-ascii?Q?g4QehAvXdcOiW4wKlHbXY+tEaU0OIYEZTxroNGrR1pGXPOLIh+ZqW5QXb/Y3?=
 =?us-ascii?Q?BrIC0cC7296rsLynnrgCMGjhGoGyRI/DgX0+iLCIh/PdkXWz+rmL0EMQn3xg?=
 =?us-ascii?Q?XJCU85MdMv2VNqu9RxOwc4gBjjS/eDyYM888kfxEB41JsID4HiOWxCzg4xTO?=
 =?us-ascii?Q?jKSR1LdzUHzp0XsMwRVtpeKm2fn2VIQOTHB9oiaJeJbWcaQliqBSXNf5FzPR?=
 =?us-ascii?Q?8SQWuuOpVrZCTeEeh/U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 12:03:41.1736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd03ed2f-a075-4484-43ab-08de4de4cc91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577

When a device is matched via PRP0001, the driver's OF (DT) match table
must be used to obtain the device match data. If a driver provides both
an acpi_match_table and an of_match_table, the current
acpi_device_get_match_data() path consults the driver's acpi_match_table
and returns NULL (no ACPI ID matches).

Explicitly detect PRP0001 and fetch match data from the driver's
of_match_table via acpi_of_device_get_match_data().

Fixes: 886ca88be6b3 ("ACPI / bus: Respect PRP0001 when retrieving device match data")
Cc: stable@vger.kernel.org
Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
Changes in v2:
	* Fix build errors.
---
 drivers/acpi/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 5e110badac7b..6658c4339656 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1031,8 +1031,9 @@ const void *acpi_device_get_match_data(const struct device *dev)
 {
 	const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
 	const struct acpi_device_id *match;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 
-	if (!acpi_ids)
+	if (!strcmp(ACPI_DT_NAMESPACE_HID, acpi_device_hid(adev)))
 		return acpi_of_device_get_match_data(dev);
 
 	match = acpi_match_device(acpi_ids, dev);
-- 
2.43.0


