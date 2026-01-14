Return-Path: <linux-acpi+bounces-20276-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BE4D1D167
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 09:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 468D7302411E
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 08:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C38437E2F1;
	Wed, 14 Jan 2026 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eSddIxg5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693C37E2F3;
	Wed, 14 Jan 2026 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379020; cv=fail; b=owTSOl6Hi3ljr9gRc57sm4/r+mZwbIBOt4eDYTmw92ooeFNXtB2vhTxqRAVOKeGNmLGC39eAwzPRMZwaNtqDWsSL2Uqd2xPUi0mA9e9KRY5fMmOjl7SW+Fw/KQKv8u55ECRMpLm/Q4pUzBwfJmkOuY7SkIc+41XF1BGO56q7kLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379020; c=relaxed/simple;
	bh=7+/o3wOKXg8qbHvp8gXOQlbIyCrlLuok2o/JRaJ6EQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bEMAUlLxB6z+e3/iPPa5YsAUJ/qg0QPWzybcZg2NcSHuuHRLGUFQrbTy6V20g4KKh7xsSn/HAbCTFO/f0mGoAJ263+FBBsjfiShr8aislZ2cTSnXQ86TJeBoQ9qnGzZF8JPQbDTAKGrA6tQw7qerxzD85omOHqRabHZ51wCZ3oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eSddIxg5; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJPi2E6piaak2n2JxLYjEMA1KCO9h/6HajW2Qdwm1zR5BermNFvplDxITqq1XWHtJQeTzJx+dkHYaV5leJO+CQtUGeUM8CFB4gT9FO0SJZ+3J+59vtn2R2zhUnX6jletbt194PtXshygguZD8NRMKON8X93S5acqt1sWNNFItLiwSMKMo34+Tp6DEnu1nNIx9wOwTDa+GPqmCsbEMFQWiYaRkjZHYbNpqbc8mYVCYZQ6R4SG8gY9nPy5jP8FWcoX1IblLoVH/EZ6YVlmHkbUG+8wWbyexJjNM8YDarctnDtTrGHqC3BpNSNLqt4t1KWkpZhsnfkF5alM3A3/6NpU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UthrEDBC1x08hLtQX0fNialVAgbPzOuB/AIvr+1j5MI=;
 b=e10L5hEqtG0oQ3OiGtj8u8lf1JxDwU4U2EIHnPb552L0iVMA7cHS4Xw9dzPb3YG1WtoPIHXxNndJW0Jn2kp9S9ovy2Q3aXHNXpGPQo0oTaQgmT9uCJ6lEx/PO343+pMMN5Wfc4mewBEuwqxyMQ7VScFDFgR1pDla3LvrsuMvuKyi/MfzqfMcF3BOc8EPlNK8v7eRd/81mUxSw1L7/vE0bkR+xh5g5PYLyBvWXHQgGC6KBa6Bsm7IIYT+cUIlc5/977exipisxsx6Vo6Jb6N4lVx6z5CUX/tjQnCFl7BzPiEYo67tGJtKcJe1CJn3AW+1/qwcMlqoVFB0fgfX6HYK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UthrEDBC1x08hLtQX0fNialVAgbPzOuB/AIvr+1j5MI=;
 b=eSddIxg5RaydYxwhaovHLsOlTOgTPKjSl4V8GmYMjc2inBm92KvNtI4w1VgU8o5OHdCwlBZ21yWKfaO9fj/7lKP+29Wg3lhu7C/xBmI+SV7/+YaIjjfhIOh0U8VbMNucePxXdT3yg/CSGYExuf8hX/Kt+OAbTXQKmAmwf8CazhCJI6/LbjK9WDcQyConO1GogUlaKOZQ+ulmJDeZgJiNKwGZ2Qjzw3Us5Gl4FJ9lkDVJ/w+czyRSczuaBnabHw+A1ECRMkvD5dCnNoQ0j5lqoIiX83FMz8mL7jLMiPiKbnAi4op0eNAvmrNT5xa8dW9K1lUVDxw8l6AIPf6aGxfuRw==
Received: from CH0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:610:b1::20)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 08:23:31 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::80) by CH0PR13CA0015.outlook.office365.com
 (2603:10b6:610:b1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 08:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 08:23:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 00:23:12 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 00:23:11 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 14 Jan 2026 00:23:08 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <lenb@kernel.org>, <sakari.ailus@linux.intel.com>,
	<mika.westerberg@linux.intel.com>, <andriy.shevchenko@linux.intel.com>,
	<rafael@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Kartik Rajput <kkartik@nvidia.com>
Subject: [PATCH v4] ACPI: bus: Align acpi_device_get_match_data() with driver match order
Date: Wed, 14 Jan 2026 13:53:06 +0530
Message-ID: <20260114082306.48119-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: fd69d9d4-b136-4219-345b-08de534633a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkszN0tRZElHR1BhRU9ORHB2emhRaFFidGF0cEY5SGFpV3JEb2dqbnZpMkZN?=
 =?utf-8?B?SmU5bWNxT29OUEdqNTdQcVovbHVCSkVLTmE4S0kzbDNtMzhRb1BDUzVNbEh3?=
 =?utf-8?B?cEpTbGl4YnJCR3dtc1RCd01ZcWQ1MGVVNjQzQks5OWZZU0sramhhdEJsYzZz?=
 =?utf-8?B?MloyczdpY0prcXJxNWFEQVEzYm5HSUJoU3EwdnFiSE12K3QrL1BSWmFkMFhk?=
 =?utf-8?B?Y2RCTG1NM3JNc3NiZ2ZOVDRSYmRYT0ltbGZpUlJDR1lpRlg2V2I3bVMrSFhk?=
 =?utf-8?B?UFF3ei95QTc0VWVBZENLVWsvaWVuNE4xUGNrOTZlL1U0eVFKRE9hMDNZK0w2?=
 =?utf-8?B?QWZrQ05pNFR0SWxRa1VicUJ2VkRZTU5PNXBWWFM1bndMUmVaa1dyRE55R3dx?=
 =?utf-8?B?LzQzRGtlcElHZzlGdkpsakx6YnhMNHpTR20rTjRRcHhaZlZxbTBDeDMzUWJK?=
 =?utf-8?B?UEZTcnRMRFgxWUlrcDQveHBDNFYvYWxPbGdldHZpOTdDaFV4Y1lVN0p6aG1m?=
 =?utf-8?B?VHNCNlFURjZiTG9VcVBhNXFsSk93RHBZWi94N2ZCRlFOcll3NGRKRjFCRXk2?=
 =?utf-8?B?Z04yUDdJSHpKVStUb2tNTUh1ZVFodTd2Qms3Njg1UE9DOGs2VjZIeXgrcHNT?=
 =?utf-8?B?ZG9LeTBZYWxuSXN1RVpuTW1CNHhrUU0zb3JFY25PcklYT0N2SVFjL1FacjZk?=
 =?utf-8?B?Q1QrSGhRMXFxOUNBakZXTThUS0E5OHIzY1NDdUQzRDhLSnNSRlZvaE1rS2pm?=
 =?utf-8?B?RHhybS8xbmw2VHNyV2k1MjZ6Wld0U1o1RklidlBEa1FkdXVEczMwYm1PQ1JU?=
 =?utf-8?B?V29UclRDWEVFaW9zT2VjNkt0VXFha1B5VEFmUytJdmVhS0NMY0pjUi9uYjNn?=
 =?utf-8?B?b0c0SGNLSm9ReTJEWlZsWVNsR3EzZ2ZubmhOK2JpSEMzaVNBM1lDREw1U1Fn?=
 =?utf-8?B?UWNMbjE0T3Z5MnVTc3Z6cGQ3bGhwbU9jYUZOWkoxckpqYnFpWTVVNWFEZ1Ft?=
 =?utf-8?B?VExDVGt5UFFZYjFicVJRR2xJcHMwNWlOOVdEL29pSVhuSkJuWk1VdjhPaS9h?=
 =?utf-8?B?SkN3NlN1akwxY2lvVlM4anRJWlBQV2hwcnRGbXg5bXU4YTJLd2tTQVJVUXRN?=
 =?utf-8?B?Rm1jUmtyNEhXeTFxMmlGbGs5NXNPNlBpUklXMFZFTURDZE8yaUpkNE51SVo0?=
 =?utf-8?B?SVlpUWVUZC9XM1AwcmZrM2VpYTNWYnZiZ0dwTEU0eTZyWVcxY0hTVnZTWjVL?=
 =?utf-8?B?eSt6MzJKRWpmVnUyK0IyMmVzVnNPR1JWMkI2RWFuT09GcnpzbmFuTTBZTE15?=
 =?utf-8?B?Slk3VU0xVEVEZnErY0t4eG1NazBreFVobWhWcTEwb3kvV0k2T0dJOXlCd3Rk?=
 =?utf-8?B?b1ZhenZjYnlYYTlOOFdQeUdhMFF1a1NxSHhjY1ZVcC8zYjZXTldOa3ZnaWdt?=
 =?utf-8?B?eU1oSy9talkrK0N1V25Dbnl0MVlVRDB0aExPYmZGWldNR1kvVHhNSEY4emtt?=
 =?utf-8?B?SUcvd1oxOExCT1R5TDFwaG1OYnQ2TzZJR2FXcFN2WXhZMWRaTHFaazBib3Ir?=
 =?utf-8?B?Y1FSUmo1L0Y1aE5IeDJjQXZKbnFBTWY0eUI5OUczYXFyR2tSNHA4RjJvbVBU?=
 =?utf-8?B?SWMrYUhrQVVsY0JIaHpManEvWFRlenVqYk1LUUNoRjJDZVRkOEswMGtncEhO?=
 =?utf-8?B?V2MvVmZvNkJpSUplbFNObG1jTjR6T0pTRk82REpYOGVSN2JZSWZ3WG90eUVG?=
 =?utf-8?B?amMrOWNpemxJVzI4S1RoQTJTaDdTWHJnb3VjZDFhSXRVcjFRYUtHUUEyLzFB?=
 =?utf-8?B?Vzk5TG1OYVlNMUcrSlJ2cEZOY1hSa0lsK1NwV2JUL1ZVZFVQTTVwNEd6K0w1?=
 =?utf-8?B?WjhBdGxwbWpSNmVadmFyaHNKd3dmTHFoWHNsMkl0L3JNcFVYRzZ1MUJwbk96?=
 =?utf-8?B?aVdsWWVYSXpNdmJGZlNOdElvWkoyb2hGdDU2N3VaSnhsZ1Fta0xyNVplZ3lY?=
 =?utf-8?B?WVc2c2ZDYkpCTGlvRkZoV21PRDJSMmV0WlR3S3kraTVYS0h0TVJ3c3pGT3Rm?=
 =?utf-8?B?V0txSTJVb2Y2ZFZnejJLcHdieElKUzREbEdRaXZCckNrYjZYcEJGZW1QVHlJ?=
 =?utf-8?Q?gEEU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:23:31.0883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd69d9d4-b136-4219-345b-08de534633a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546

During pre-production development, drivers may provide both ACPI and OF
match tables while a formal ACPI HID for the device is not yet
allocated. Such devices are enumerated via PRP0001. In this case,
acpi_device_get_match_data() consults only the driver’s ACPI match table
and returns NULL, even though the device was successfully matched via
PRP0001.

This behavior also risks breaking existing PRP0001 setups if a driver
later gains an ACPI HID, as the presence of an ACPI match table changes
the match-data lookup path.

Make acpi_device_get_match_data() use the same precedence as driver
matching by using __acpi_match_device(). Return match data from the
acpi_id or of_id that was actually matched.

Remove now-unused acpi_of_device_get_match_data().

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
Changes in v4:
	* Use __acpi_match_device to get the match data.
	* Remove now unused function acpi_of_device_get_match_data().
	* Update commit message.
Changes in v3:
        * Swap arguments while comparing HID against PRP0001.
        * Check value of adev against NULL.
        * Declare variables in reversed xmas tree order.
        * Update commit message.
Changes in v2:
        * Fix build errors.
---
 drivers/acpi/bus.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 5e110badac7b..c973de7cbe33 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1016,30 +1016,24 @@ const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 }
 EXPORT_SYMBOL_GPL(acpi_match_device);
 
-static const void *acpi_of_device_get_match_data(const struct device *dev)
-{
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-	const struct of_device_id *match = NULL;
-
-	if (!acpi_of_match_device(adev, dev->driver->of_match_table, &match))
-		return NULL;
-
-	return match->data;
-}
-
 const void *acpi_device_get_match_data(const struct device *dev)
 {
 	const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
-	const struct acpi_device_id *match;
+	const struct of_device_id *of_ids = dev->driver->of_match_table;
+	const struct acpi_device *adev = acpi_companion_match(dev);
+	const struct acpi_device_id *acpi_id = NULL;
+	const struct of_device_id *of_id = NULL;
 
-	if (!acpi_ids)
-		return acpi_of_device_get_match_data(dev);
-
-	match = acpi_match_device(acpi_ids, dev);
-	if (!match)
+	if (!__acpi_match_device(adev, acpi_ids, of_ids, &acpi_id, &of_id))
 		return NULL;
 
-	return (const void *)match->driver_data;
+	if (acpi_id)
+		return (const void *)acpi_id->driver_data;
+
+	if (of_id)
+		return of_id->data;
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(acpi_device_get_match_data);
 
-- 
2.43.0


