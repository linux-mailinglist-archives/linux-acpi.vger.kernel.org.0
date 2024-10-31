Return-Path: <linux-acpi+bounces-9161-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F191E9B737D
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02461C2408E
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E3713B2B4;
	Thu, 31 Oct 2024 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2KpgXbyk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059EB126BF2;
	Thu, 31 Oct 2024 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347831; cv=fail; b=LYNFi9VkKP9iELRy6xjLzR5oHPghcVpQmpd2K7DKfmUrIyLg5wdD160cGP+YrXIvZa/Fx4uCn9YlNNjnJ6Vif3+wTtfDMAbv/B31uUXo5AOtByyGWuVTvqLE0PrxPwbzXtp5fuoHaeDTVKC/iu7wXCOQ6tcpXGgzqtYNfSKk5CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347831; c=relaxed/simple;
	bh=7Y1ye+dojnd83/ekD+XzCxFvj3T3Qdw+9hKUx108gN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAQu89wqgvAU5HNpYiDSXqDmSgt44ohUE2Rgxc/KIUhDIjYMYNWcq8bdBcTdsH4NyxZoHTe5Zr6bjEMw873/wIQFLosI0lZZH98oGg4PULdPIetmAFx+d9hsg/LW14XcjGUGSOiLHdLBSh22UfHqxYk4oC4PMkYJFnZh87UbuvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2KpgXbyk; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dt4m3UGcNWsA9MCcZNvNmoecQwK2wvwOE+19L6WC/wi0Jl9IoZaXy7T2RzqBpSV1m+k7s1jLqSm91vjvKTcJdtxXxiNYFZ64jaMZir82A+9N1JG/4upDqERv6T+tCBtyz+8Z8NeIfi4VmJv3rlu3rZZYQT5ko0YjAU6C9f940yppRssqhlVFXtELlrO1xVKBMDNiL+iQ2k5Dic2mSbFQ4+DUkIL/ZK1XWfS2nQk8tOJZip7B+/7YZwYYrAEMesEMexVWwY2xcBDzjvbZVaBc3HieRCCqVUBiMl3uzLN9Lum5nxgbiSm6KSWmLZei8KalXga0lYfr9ekh/QHkpTs7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mUyzhBT4vy03YoPp8fHD/o7qorvv1zgUumIXEtGe6k=;
 b=IhcSaG3SUgZDjQmnZ1H/8/gVIgpoOkCHKGX013AHy9Gt3bLIrL5jMZ4MoU0UAxWw3bCk/5dsfKRWgzff7kn3zv1a1Vb4DlbRFmoIK0r0ZehSHlJPZ4sLmo8Ws1gyfDGLM2AW4ZAEBs7dYMO3wiisz5zbg+kZERqfwxc7rpc8TMusj2PvM9C5PoK9pLaKvzW/Jp5tTchHFIX47ZA21xmZH9cOr7eyfYBrTLoRACavZ8xU+x3a/3SZQUXMzYhwQcB7I1negewnINUvyhDNlcLUmMdhKK7XYtcSucNNLq7770xTn4lLiiqZAb0pHbKLnGAjWGHSDyHgdD3Z9j6N3J/sGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mUyzhBT4vy03YoPp8fHD/o7qorvv1zgUumIXEtGe6k=;
 b=2KpgXbykLWalcayZD6Cz8RCvQbwm5S4/H0qrkoXHbk/q5Gorr/STgFclU2ZqpdyeyT+elbTWvYKqJfLUJc9jDUOoKgVPN5Ct372I55zBzSmzpN42v5qO3TnTNRXI3a42/hLt5YS+cRPxts9j67Eypl7HdG8MpgyMWBIKU11t7p4=
Received: from PH7P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::8)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22; Thu, 31 Oct
 2024 04:10:25 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::e) by PH7P222CA0020.outlook.office365.com
 (2603:10b6:510:33a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 04:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:10:24 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:22 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Corentin Chary
	<corentin.chary@gmail.com>, "Luke D . Jones" <luke@ljones.dev>, Ike Panhc
	<ike.pan@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	"Alexis Belmonte" <alexbelm48@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Ai Chao <aichao@kylinos.cn>, Gergo Koteles
	<soyer@irl.hu>, open list <linux-kernel@vger.kernel.org>, "open list:ACPI"
	<linux-acpi@vger.kernel.org>, "open list:MICROSOFT SURFACE PLATFORM PROFILE
 DRIVER" <platform-driver-x86@vger.kernel.org>, "open list:THINKPAD ACPI
 EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, Matthew Schwartz <matthew.schwartz@linux.dev>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 02/22] platform/x86/dell: dell-pc: Create platform device
Date: Wed, 30 Oct 2024 23:09:32 -0500
Message-ID: <20241031040952.109057-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031040952.109057-1-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: df2096cc-1754-445b-ccbf-08dcf961f21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zjd8H5bjiA8ZaMseRZvunorrLZd/UuAHQaf0FxsNdNfx9IuhqdgKNn4sj7P5?=
 =?us-ascii?Q?bTTlpaDFNKQfbA2kf1Ruchy8NgDlWbOX26NkYHkYq9s/YtWHCvc7ji09AG2L?=
 =?us-ascii?Q?X6ccK73oJz9g4Iw+E/NatdMb+Y62840YRSwvQBe6C5NMP9rhOJOd7ip24zyc?=
 =?us-ascii?Q?Rcn9PS3Kxn0Fg6SsQp48ZEptJ5jTepKUb540XlRhPV/AA5t/+j7CzKFQvteY?=
 =?us-ascii?Q?MIImOS3eZ9U0oFA89E7LHs2ybnWXDdQXZj1o+AKGPR7j7MHs3QE/k9LZsrqb?=
 =?us-ascii?Q?KUQXgqdQ+7FeGK+PfgC/7f2kL9RdEjnGpUfY2epjqvyahEKF5+p0Vf5U6Jy8?=
 =?us-ascii?Q?oBZNajBrvYAgapf/P+1V4FlufMv6YrUG7QX42VF3XuEpZp3CYv5Dmp2Sgl+U?=
 =?us-ascii?Q?9jnIq0JHnrhukw4300lrgoOvT6jpm4SW8MViBcCUqw+ug5HgliGwYFk7oJfu?=
 =?us-ascii?Q?R6vVvA7PvKJYrfm49JnBEl2cz+PQEfn1dRlS/17kh6ocfdbQQIZmRpyXnqLG?=
 =?us-ascii?Q?KsjaSdOfhVthGcPcda0LzOGpB7D4GCpUeAFsCCxaZEKKO60rzNQbXn/s842h?=
 =?us-ascii?Q?k/WrArJbORp9nKTsB6yAbO1CcXCaplB4iKvarmR8yQgh0mNpyWg8GjEl16ZC?=
 =?us-ascii?Q?CFUkDkBh/wd1p2aZZjd680XXwc/6l1zQv7r4C2P0G3NEyzSS8rb4KiTgJ/ka?=
 =?us-ascii?Q?zLGoEbOyJ7PErXIOUjyzjPvRxzoFg+wcZMXrfHyatVQksige05ntCR5zKezR?=
 =?us-ascii?Q?Sfi40EoRxH8g1dD5AqktATjDHnyEAMJ3lkJteUqrg2h0njld7RQCWYUKuvnG?=
 =?us-ascii?Q?SWorj19Z9izriR4ds6GDiFLsOKMqYoesbChFi0HnbBGZdzg6WrQc20hr9Fu1?=
 =?us-ascii?Q?UQrAM692VXCjjh3nkONSn82VGmP0FfLI/Rb6CHluhFKnglXDR1ipWZG2y6gd?=
 =?us-ascii?Q?4sI2OiSNgvbNXAiGYLrlN9paQ04jjKmavoxcBRWTCkhVjxok3e40KEPcUYIt?=
 =?us-ascii?Q?XLBWc4B02FYoT3gYLX5OTWUNkBsBaqPeusOS5QPrkWnIgdIhRLmba8J0opMR?=
 =?us-ascii?Q?kdH9OkxJW+0tNBudMKYfUROp9xwKRbDCGzkN3tu3j05mHJiMO1s84GPe05XE?=
 =?us-ascii?Q?j2a2UIeT3P6/bgpSy3jzOZTwberDsUQRcyPSaXlTHxdnzwLrxJbRJgK1aarS?=
 =?us-ascii?Q?27pLJRalWfcplsIRC2T4K2xd0OSk7QtA0EmBZWiQe4aLC5OvLMOvGn5ATA/B?=
 =?us-ascii?Q?1kR+SHO8VzN40mZd7M8K4L6BwaD7gyX5Jmw7fdLK7j6aEQGI5HZAQZkIvI9i?=
 =?us-ascii?Q?C+Nmtqwiz8C+p5NhEIW+iE6D0QL/PjLDhwYzorzyaFoXmGYgqYmz3zX+Lpgj?=
 =?us-ascii?Q?aI9RKMjI6ZrjXJYKQBg5Z0l7BUNgxh6WB452mM1QxA7wqnuIYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:10:24.7232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2096cc-1754-445b-ccbf-08dcf961f21d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066

In order to have a device for the platform profile core to reference
create a platform device for dell-pc.

While doing this change the memory allocation for the thermal handler
to be device managed to follow the lifecycle of that device.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/dell/dell-pc.c | 35 +++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 3cf79e55e3129..b145fedb6b710 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -18,10 +18,13 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_profile.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include "dell-smbios.h"
 
+static struct platform_device *platform_device;
+
 static const struct dmi_system_id dell_device_table[] __initconst = {
 	{
 		.ident = "Dell Inc.",
@@ -244,9 +247,18 @@ static int thermal_init(void)
 	if (!supported_modes)
 		return 0;
 
-	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
-	if (!thermal_handler)
+	platform_device = platform_device_alloc("dell-pc", PLATFORM_DEVID_NONE);
+	if (!platform_device)
 		return -ENOMEM;
+	ret = platform_device_add(platform_device);
+	if (ret)
+		goto cleanup_platform_device;
+
+	thermal_handler = devm_kzalloc(&platform_device->dev, sizeof(*thermal_handler), GFP_KERNEL);
+	if (!thermal_handler) {
+		ret = -ENOMEM;
+		goto cleanup_platform_device;
+	}
 	thermal_handler->name = "dell-pc";
 	thermal_handler->profile_get = thermal_platform_profile_get;
 	thermal_handler->profile_set = thermal_platform_profile_set;
@@ -262,20 +274,25 @@ static int thermal_init(void)
 
 	/* Clean up if failed */
 	ret = platform_profile_register(thermal_handler);
-	if (ret) {
-		kfree(thermal_handler);
-		thermal_handler = NULL;
-	}
+	if (ret)
+		goto cleanup_thermal_handler;
+
+	return 0;
+
+cleanup_thermal_handler:
+	thermal_handler = NULL;
+
+cleanup_platform_device:
+	platform_device_del(platform_device);
 
 	return ret;
 }
 
 static void thermal_cleanup(void)
 {
-	if (thermal_handler) {
+	if (thermal_handler)
 		platform_profile_remove();
-		kfree(thermal_handler);
-	}
+	platform_device_unregister(platform_device);
 }
 
 static int __init dell_init(void)
-- 
2.43.0


