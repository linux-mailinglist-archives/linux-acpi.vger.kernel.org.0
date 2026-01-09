Return-Path: <linux-acpi+bounces-20101-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B909D085AD
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 10:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 574E53008FB3
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32764334C2B;
	Fri,  9 Jan 2026 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h+uhnOED"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3264334C06;
	Fri,  9 Jan 2026 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952466; cv=fail; b=LmOdAJThFJWIXhgFoWuATjggHs5U7O5lwhxBnmovYj57f2A+KJg8D1Chy3NIb1YUrYLNOgm/HTlOvXmXha+sqzGiOg8doAqTYNzcPcT7jS4FextqgzzPQ3k3Bymwce+nFSwB7reBum/RvStJH0OU0H1Pl5jCA42mUglWyUOI7LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952466; c=relaxed/simple;
	bh=CE7k5lOmWt+90n6nv9FXhHMYB0OpUn9OBSizLZD1CN4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GHb3UNQ10HqNXzN9w7RRK6bMZpSUMArBWpyi6DbHRJpwcb3/ToPibMPWTJkWeKjAyW1S8FzEMm71dVRs7xXk9/2a6y+7fPS64Ulj5OvJcGJA4j9eicH6jZSDnh0r7waTVussX3HFUvyfahvLTHrboZM5rpCaZQz7dj6FZ+TYjvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h+uhnOED; arc=fail smtp.client-ip=40.107.209.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoPKR73vGuzq7U5pj8fcFZUAShXYJ0C3CuUKzX8T6ndB9tLCasSuHVz4c0SEKkRXAywCBb1SeWEvaPiQR0HxkB05yi28qbvURLKYocTNv4jgYX0iN46Q+Bvj5qge4cCc/CJPWVhwIYKIMsnq7RkLIscOBH2PkLmFP8xonhlNZoYWkApn6cEAncwcF+yBggTHwkekX+1b2TX77dxr5DEblhLG72YOv7vt1aPCk11E+81QFG5WPF+ev/JfvblOZQOZEZzAWNiKAbHhJcR8NO76mWGoXXlGZb09oyEv495h2IrfJZSxoEM7lhYkLKM8Ug/beIKWEhqJso7KnEmAi+CsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=816Bq2F9ynmzApPGT9ue0mZjTAJ33TQSAEI7Tlfw+Oo=;
 b=pjC+l4iDWmoeHfdQydUUjtqzg2BRTtCrfamEyGu2iW0td/pkbu6BGA+DiweWLr1YHwAoDjGsrHm5wQ1dhI6OqPArks4IJwfMjZKisZWpiw9urt9Jfm1QSKfe/6cp73And+CfKFvygZpwU7SESpD35NfroszRURTtabsufFr/6yTn58j/1g7D/Fm/dbgFEy8Hc3/ccOECiFIOtnedvK74fcLkvxOwTL3Ow/oLytqnqwT68TqWKAF0a9bytKRs9QsnNDrCRL/ocm0vyjZwq14v97rLklGtT5co62vTZr6ec+9agEBGVK8DGcqh2I07vpNHtSifTvxBE1lwpuH0SDpowg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=816Bq2F9ynmzApPGT9ue0mZjTAJ33TQSAEI7Tlfw+Oo=;
 b=h+uhnOED1WeTaSmI77mvWlUYPr4Pch7AAQYpc8m9knwc7P2j/mwN92kYa/XekTdcL5sr2UMDWygF6qUE5R+nCAuAPucNC421mKAbdX3VG9qhvqD3EteByoEou32tCwT6F8B9IKgcnLhqAJEF352W7WhLQZRbdWkLwjSy+Om+r2kCIIYuVolAi5h7vsluZFaHw2PS4W4qsi0Gt5TfBfpKXA/OKvriqj8Oii5w4Hr6RJPIpPEknJ0OOgNPWUFbl9KLnuGeXxilh70Qz4CiZqyfjM/CH5zn5Dtb49ex8eXuAzly5Emluw7RGEJypNnqIRgLTYSChVqQ1ndWzHmLIDpA9Q==
Received: from MN2PR20CA0049.namprd20.prod.outlook.com (2603:10b6:208:235::18)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 09:54:20 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::e0) by MN2PR20CA0049.outlook.office365.com
 (2603:10b6:208:235::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 09:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 09:54:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 01:54:06 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 01:54:05 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 9 Jan 2026 01:54:02 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <lenb@kernel.org>, <sakari.ailus@linux.intel.com>,
	<mika.westerberg@linux.intel.com>, <andriy.shevchenko@linux.intel.com>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Kartik Rajput <kkartik@nvidia.com>
Subject: [PATCH v3] ACPI: bus: Use OF match data for PRP0001 matched devices
Date: Fri, 9 Jan 2026 15:23:58 +0530
Message-ID: <20260109095358.24265-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4a6415-1963-43a4-2731-08de4f650f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWZlZ1hnakw4YmdUdGhFVFhtdmtjVlVCaFdwYWw3NDFnUmNnbnNzTnVZbmoy?=
 =?utf-8?B?KzJPRWdDMzVrM3NLUEQxemsxNk1JMUhyWjNtK0lKeEFPd01vSHprWFpCQ216?=
 =?utf-8?B?dGhvS1oxdVVnYjliYzlNTEZOWEU3SkFhYlQ4dlp4clE2K0swOVQvYk45N0RZ?=
 =?utf-8?B?SDhpREtyTmtMSDNicnA4b2c4ZTFLTGhHWjlQRXk1elM5Wkp5ZkNRWlI2Q0Vx?=
 =?utf-8?B?MVFmSUpYbDFVN3RUcjlGdlBaSE4wS2FrZVU2aUZCOXJZWnZmbFo3c0hsajl0?=
 =?utf-8?B?Q2lpWXlaWnJIdGtoWCszSkkxVlF2UXpIcXdrRGFUK2NPcUNibVMxUXBWQVk2?=
 =?utf-8?B?b2ZrUVJnSmtBaW9qN3JyOVU4MTRWZU0rOU9PTVFXMkhETjIyZE9Jb0x6Vlkv?=
 =?utf-8?B?N1NIYXgwc29Qb0JDWUVJTXYyVDMzRkhnMWFNSjVIemVhdnJvS0JKR0NHdXZz?=
 =?utf-8?B?ZFJIMmxoNmhWSFcvRGYvUERnYkVVUTZHRnZ4K2h0VmRia3Ywd2JFcVFsZHZR?=
 =?utf-8?B?cXpCN3ExMUpyMzdGUFZXcGdDWmhUbHY4Sk9jdWFmMHJaWTl3dHhXdmtPOGxI?=
 =?utf-8?B?SlkrbEFNUjNJRFNoZk4zUkhJSmlVY1lWOUtlblpPL0w3TkNiOEZPMWNpNHpv?=
 =?utf-8?B?SytQakdLcXJmeVFiRGF6TXZEeUhMRkI3SktJY0lTTEI4RkZpb0RGVUdmeGxG?=
 =?utf-8?B?QmtoQmQwYlQzcjRUQlBpc1JMTFordFJycjUxU3VFcFFmRnAyOGtGQSthd1Qr?=
 =?utf-8?B?SENMZWozZm5HcHRXc1U3NkpRN25BbmtrR3k1VnJaT0krQUpVUU81b3pBc2N5?=
 =?utf-8?B?ZDBIMzFoUGpFVHllRCtKUUpsMVVxbC9EcTFvNzNNbUhyNWUwMWVXT25RVDhq?=
 =?utf-8?B?cDcyR0F2RmxXRkRtbHkxN1ZrTXlNZlNWbWdpRzJyZUtsekNWcHhDb29GWHNI?=
 =?utf-8?B?L3lDd3BJR1phcU5OV3NJRFBqVDJiOWRvVmhGY2l1dVJoWE5VVnd2MzFHV2s0?=
 =?utf-8?B?dW9OVTkyYXZTd0crb0RsN2t0SlkvUk05T0FLNFJTelR5cTFFMmdtdHJOUVpS?=
 =?utf-8?B?cVVaeGU5QXk0T3oyZ2Iwb3Y2aWNkZFpjeDFQRUpkYzNWaUJPM3kzNnoyM2hX?=
 =?utf-8?B?eVdyNjg4R3VKdHk3dUczcmcwUWtFZlRoQWZDM21EQ1d0VHpQMCtPNXJmMzNK?=
 =?utf-8?B?VDh1Y2phWmovR2tXUnNCM3ZNTGVxUUJrYmhkUmFOMElRZmtPckczRWhyMFpD?=
 =?utf-8?B?MmZBOG80ZkxvNi90OVZsNU0vNFlpVmRadjVTNnF1bVY0UzU3SDAzeGUySE9V?=
 =?utf-8?B?NkFoZmc4OExZT2k4RkFxbXNDanA1TVc3SUF3TEtVQkFNNTNqc2doSFFQY1Yz?=
 =?utf-8?B?NEErVnk5WEhPYndsZm9kM1lFNmwxSEhoT2Z4elJQazdLdXdWQzR2VFhBazZ6?=
 =?utf-8?B?UUpHUjUwU0xaV2RiNGRhV3dCTTV5QnRTaStmVHFyN0VrMUpKTGFOSmlZK0hV?=
 =?utf-8?B?bWRnUjdaUHRsT1BEZDRNdFk3TkIxejg5dG9VcFNGZllHb2dTTWVFY1M0Ulow?=
 =?utf-8?B?MHBGd2tOaGxBZlozQ2QyOVhYdVVrb2JsWStHRVdPNWFtWEplOFZaRVg1L3Av?=
 =?utf-8?B?RFBCWXhIaTZWUEVoaGc2WHJXMHlPSnpxa2NyV3Fhd2NkQ0lpbUgzMnh3dVlk?=
 =?utf-8?B?bDN2aHdVS1BObFY3SUNya1k5RGpjSEZwOEpQZXNtME5Xa3lKK2E2ci9Td2N3?=
 =?utf-8?B?TTVYNUtFbVVjd2x0OFIxN2E0Um9GY011ZlJ1LzQ3OEVQVDZjT2ZrTGhkMW5v?=
 =?utf-8?B?bW00ZlRrVHdwR24zdFd0bGJDTkZ0RUMraXlKa2l1d01ZSG9ESVpEMFRwUndl?=
 =?utf-8?B?Rkl5OXNwSDVMd21Ec2VwUWk2SGdnb2VncHNLcGY1VjRRMHZCdHlBL05NdDhL?=
 =?utf-8?B?VEp4M3JMSmowdUw0aFNIcnFRSThWNkJDUnJvUWV3Tkt3Q3hMYTJJSXROd3JD?=
 =?utf-8?B?cTJWSENVWnllTG9iODBxcGEyNEhqTjRBQ2U2Q0kxMFo2V3ZVNnFjOVc0M21K?=
 =?utf-8?B?SzBuVjJJZVZ5MEpOVVMwL3JQR0JMT2llZnJRaG1yR3J5cGJYdUxWdkV2SVpv?=
 =?utf-8?Q?xTTY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 09:54:20.0256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4a6415-1963-43a4-2731-08de4f650f6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

During pre-production development, drivers may provide both ACPI and OF
match tables while a formal ACPI HID for the device is not yet
allocated. Such devices are enumerated via PRP0001. In this case,
acpi_device_get_match_data() consults only the driver’s ACPI match table
and returns NULL, even though the device was successfully matched via
PRP0001.

This behavior also risks breaking existing PRP0001 setups if a driver
later gains an ACPI HID, as the presence of an ACPI match table changes
the match-data lookup path.

Explicitly detect PRP0001 and fetch match data from the driver's
OF match table via acpi_of_device_get_match_data().

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
Changes in v3:
        * Swap arguments while comparing HID against PRP0001.
        * Check value of adev against NULL.
        * Declare variables in reversed xmas tree order.
        * Update commit message.
Changes in v2:
        * Fix build errors.
---
 drivers/acpi/bus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 5e110badac7b..e960df2fcea7 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1030,9 +1030,13 @@ static const void *acpi_of_device_get_match_data(const struct device *dev)
 const void *acpi_device_get_match_data(const struct device *dev)
 {
 	const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	const struct acpi_device_id *match;
 
-	if (!acpi_ids)
+	if (!adev)
+		return NULL;
+
+	if (!strcmp(acpi_device_hid(adev), ACPI_DT_NAMESPACE_HID))
 		return acpi_of_device_get_match_data(dev);
 
 	match = acpi_match_device(acpi_ids, dev);
-- 
2.43.0


