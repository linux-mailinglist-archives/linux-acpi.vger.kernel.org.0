Return-Path: <linux-acpi+bounces-19986-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A50DCFC2EB
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 07:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1B4F3002B9B
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701922836E;
	Wed,  7 Jan 2026 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PQYvjlk5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58493C2F;
	Wed,  7 Jan 2026 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767767119; cv=fail; b=iNTNrJNdRraUPLYhwTLTifW+soj/FZ/F0HDyalBcApa9KR1EPYOWybEmzMJtVfvXb3JXFcqrVmy2BVQuP6MQScLCYjLK2yxY1q9LgoeUBkQSSqOVt4VGTHT1Ya55aA4sne2wQ//zaz0zdRAjPzHP7nNkB4IyMrwTAQwMJPDaclQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767767119; c=relaxed/simple;
	bh=pD8vIBuNTCEZgqH02IO5H0w7qOnh9Yoa2NG2KYXjHYY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kpTgGY12866BNpv2l5rnyCJizwP11Ymjamfo2hhwmOXNKfvVltXig3MoiNHdNzAB9NkPNxji/3zTOgphRNDw4I2Yn+P2Fe38cTSirP53ecsz6kn4IJJpxUEMnraDH8Tv0Olh0Lmp+okvcLSq0ZrWkrYcw9kUtBbP0pNJifnm6vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PQYvjlk5; arc=fail smtp.client-ip=40.107.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKd5GnP07UtMMIAWZJ4kFRoNj7CKzu0xtz0Mo8RWVD8FeERxcJ7lwBrABJxFCwZ/P9X+uoFesFhHBLe+ih4ahxzoTYKj4agoPCyMBXOw5JNNp7DsNEwM7G8fU+0t2XeApsgZrnQ9BFBAVgE3gPbUKcWPqTRhKWncL8uCQBLZWoLBADMGigaCbUYZNHidsyTLkbDYqA10hWvRV6wY3hyQ3a/vpv5UmwOHlegjtABYkA7Vhp/LGRLBDCh9mKTqoZcMCMXSo/UydwK8xPEigDTRvxk1f5P6BO+0rE0nsI3iR+wW5veGM2ikUdTdyYE0RdiMvHB6SP2hOnFkd1p2XEpenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXzMMtSA3vEwkWrSe0JB1+MOiw23dZOMC+GBIX6Dz1U=;
 b=gscsTVgfl7Yk7q49+NAvlSIOL6nElARnwDrvHI4qSRxH2re4mzyEdcG6wIJ/ErEI9NhC2jmq2+i8aBNGJSQmhb0P50v0owPczv6e3oL+xQrbPKSu0u77io0sQ5roJKyVxUh3NEM7k2+t5Fq/w6j70vUNX1Px97GiXTrWceMmB6p5v668ADErjyoMH7sST/WgCzBJL2Wn0wDk3nzZDu257P7OvukC3gsZ5vwhzfsUgaVYujwyX/zzxeQ76PKFIiUxHxsVRkyc02jnyepa39Ct/+TYIi11hAXRmTcdczjdWKa/VsEw5Es15JD0xprYoivBH0DwyhvAo5hvUZoaajMXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXzMMtSA3vEwkWrSe0JB1+MOiw23dZOMC+GBIX6Dz1U=;
 b=PQYvjlk59kVYNV9YiUt3Wv1MOsifke+OT/1DZjGxtHHDX659Fm0a7VUS0s7o0LhsESRjoe1GNCgy+DIDd0NY+kVXjDAsaZqqs/QwUo2UMqTUphPevkKqyA+Y1faTJYBQTrsgXsowAHYfiMhKHw47jnNcc43t5Q3qBrZXWZaXnWDmI+yOn+CJ4s7SoSQaO9CA1nML8EV2SBQvqHLlHAZxfdTJbbqMpoQZpI+yd0QxYx/1aK/9JErG+iGpG1StpuvvxsrrMcb6qdom5dgDcYpXLBN+YxBXxCmO1qBjMcOpZ++vAJFmx3F8hO6UrkawUJZ9Fnua8r+Fq3HkYXf01RaIkA==
Received: from PH7P220CA0092.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::28)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 06:25:13 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::fb) by PH7P220CA0092.outlook.office365.com
 (2603:10b6:510:32d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 06:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 06:25:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 22:24:58 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 22:24:57 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 6 Jan 2026 22:24:54 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <lenb@kernel.org>, <sakari.ailus@linux.intel.com>,
	<mika.westerberg@linux.intel.com>, <andriy.shevchenko@linux.intel.com>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Kartik Rajput <kkartik@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH] ACPI: bus: Use OF match data for PRP0001 matched devices
Date: Wed, 7 Jan 2026 11:54:52 +0530
Message-ID: <20260107062453.10893-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1a1075-4670-4c33-2e6c-08de4db583b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RTVeWbGC+j93+dJY8JxUhGpJHWkTK01fg5PL7ICi/PGfQUeaVQXcBhz/N5BF?=
 =?us-ascii?Q?WNknd6cRcZe+INfhang56Kdvzk4BOIYIpVyB4gTGTnm4V6jpGsGO8vytAbEg?=
 =?us-ascii?Q?MOyFJrvJOvc12FB4qJnTUjbeerP5fTeaEoqK3q1R5OvnSwD2trfDeQSKURn/?=
 =?us-ascii?Q?1osqM43HSsnCSga48yaQpOMKgHyuFbXaIw43+Ylga/Dq8RWK3ntJcXiaQzal?=
 =?us-ascii?Q?BekUvtbxXJ/aSLcVJjOKVleVCvrXSHTW+GxwpR6PMFCx7QJfzOBS1v1fyJYN?=
 =?us-ascii?Q?JzAcrXrwcAA56QbRJyYze9Lnj+LtnbTr/jLS+GBjSSy8ZzXKQDrpP2/1dl5Q?=
 =?us-ascii?Q?hYEtMXhxF/oHkh1wcR+M7ckHAgp/QUJE1MqULNw+7xhhGjmAkjJJPCSKXTu4?=
 =?us-ascii?Q?ul/8Nm6+SDMoKNWDR3xjl+cBFQ/5CxtZk/JEigoD1g+SMYaFo2suxQfZYQGo?=
 =?us-ascii?Q?VRmiMTBHEeFQUbbXVKczR4y7ZAy5G43Cem1mOmbZrpzGmFJoQSgYceBOexwy?=
 =?us-ascii?Q?8QocecjPyPA1FsrqX+ZXbCVxO5jRFpIzV3ZXCYpX+kpEt5/GZziTPh8QnTMF?=
 =?us-ascii?Q?aa16zPFEYqRyneZl9wH5gL6kfgqwAPHba6D1qgzxji5yUDeFuTtJLapU3R4B?=
 =?us-ascii?Q?48z8gtI1tNUM4UtUPscL4YApWvHMlI5M+gkJRGvkRe0QlGLTL1yWmN9Poxxg?=
 =?us-ascii?Q?LIY/ORBaJCZphXsYb4x6lAPHM4GR7MB9cgSCFxQyZGKWnrsNg4sWyKQ7XRc/?=
 =?us-ascii?Q?mJBKR6U4Zi/2lpXE0DT0UWR1Jltihi/GKCTGJkC88/MVykzCJ7i/kKwgDFOD?=
 =?us-ascii?Q?c2CJLHzS8RYsqlRz+w4/g+lP6XxTyKV9I2n7wsVOKMp8+5jQVMjymc0GVTo8?=
 =?us-ascii?Q?/723/Lkwr74Po12YBiflE8cktZjMclAsb5DaMNwgJKLpLxqK+QZOsjvYD+HK?=
 =?us-ascii?Q?pDw/dR1efx1yaiO6JSCUaI0i5Ytk1SiHbccu4DJMdi+F0mquRS5rP+872QqQ?=
 =?us-ascii?Q?NJuC3JoLjQXuQhzF17ucPtrHb5U9KgcJ/yHSe6z4Kj4FptDFaJYeUY79OkXQ?=
 =?us-ascii?Q?4AKfcPKbWX1FudbWxiq6EL4HfjirtHo68O2UfOV4tlRsRvCYvBmHlOe8mHJT?=
 =?us-ascii?Q?Fgl4KJZWw3FmcVAR3TSKY7U768BJ6FBCNf6oIennu1j3Gw0itcDPPDw2zqbI?=
 =?us-ascii?Q?53/fBb+A4Yd17KWCL7H1Io8/aqRQNTLGY1kMkvXVhAXrKivJUuNN3PBdQxkz?=
 =?us-ascii?Q?hT2y/m8yHtVCxR1nS9LSMpC7us04yJH4AIlJyw1o1vmwekeelzPoTNQNogDq?=
 =?us-ascii?Q?nTYUH3vkql/pVUdLwkyX75c89qpgTK1VT7fau94fNxNLjO6iHbFFqPsCRne2?=
 =?us-ascii?Q?0vfrMZ1iRlwBDsbJaykqNBYzkZWNaEG6onhRO7u6aitZ/PvSjbS865mSLGZq?=
 =?us-ascii?Q?R2rUzXCSrteDaXsGpnbl/hff5P3JEuA1nM3J/yVva9FqteHlJe5HChEz1DqM?=
 =?us-ascii?Q?4taX17hu2AuXWfK8Vvwo2D0zqoM7p6vJJNkFsHh91AoRVo74+2Cmif6fkg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 06:25:12.5804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1a1075-4670-4c33-2e6c-08de4db583b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445

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
 drivers/acpi/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 5e110badac7b..4cd425fffa97 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1031,8 +1031,9 @@ const void *acpi_device_get_match_data(const struct device *dev)
 {
 	const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
 	const struct acpi_device_id *match;
+	struct acpi_device = ACPI_COMPANION(dev);
 
-	if (!acpi_ids)
+	if (!strcmp(ACPI_DT_NAMESPACE_HID, acpi_device_hid(adev))
 		return acpi_of_device_get_match_data(dev);
 
 	match = acpi_match_device(acpi_ids, dev);
-- 
2.43.0


