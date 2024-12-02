Return-Path: <linux-acpi+bounces-9847-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5856D9DFA4B
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1431C1613E0
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F881F8F0A;
	Mon,  2 Dec 2024 05:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OYe77kvQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA01F8AEA;
	Mon,  2 Dec 2024 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118697; cv=fail; b=CJp8P/BIvKQZJJVAIbZdQ9DXEzo5Fcu/L9IaW39ak8Ry/vwrafu48MkHU84we1PilJlcyRQ10qtIqLL7jLGlqoJzR/I52WpQm8vdkHmaLPTB7ZA3y9pRFIoby02/jHJM5aHJPMb11iZq//QLkohL20NaSE+SxJCGyYVIHCQ/VR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118697; c=relaxed/simple;
	bh=7FR0mS053av9fSakTvKuY8cLkqdOo6I54zrt7+qryVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDS9M4sOfNxDITexWFd61uNsWB/9V0zzkQkEAwT30xBU970cCMEQXyfh1lhfAf2nhJ7I+4sr0bqwIP2fEkuHc6UzjmQ25AwxD+USeVndyPeseeq19zOJCzR+u7s7BngI+oTv0qEiC7txkOFrU89IiaL/bef4AzLrDu4EbLoroZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OYe77kvQ; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVZtTWwmSVd/KWP3e9OFfSds5CT3Nlyfo080P20t181k8e6mVwzhz5O7V94v+HS7CX/CtLnmYfAWy7k9ek4r24wraDyxq5IAc1K5y2upS42rstc0KJecS4XmaCwqMgjjfYNNnKbhpSbpvobOshRsFQuJDdwVW1I2Z+FUZwZfB6zMiAyDUMnQ5ahMGl0hClWMh2U6h6QjDCHsbFWzAAWxL1mXGzt/CFnPEdPXVjI0MnmiNcSedgC2feF9h21QXLhxwuNe8fS9VpWqA4qBLAl4KKUB9V/p3wQLRCV88AVs5BYgTcdphCcGYfot7GK+ZikgG29wJT40OdJkyMkWylTkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO5D+drA4qa07bYVA6TrUgo8LFJF1qHTIg2teKV8f8U=;
 b=G1R0UOwTAfWI7xukgS5jYInJymQlzco/5HbffCPy4Gtg9bDhKrdFNQWdbmmqpH3qt/4k107G0saqzP9JPnTAro9m003d5Rl/gwSpzhpXgsX4TlVigXfdtrBGjFpAvW0Aqe1Utm95QolAwH7e6OFC1ho/7M2xv6J7O3rdwBykbmB7oEpMoJiIh+/7IBWSuOJulOKsC3tbpvaKrf8+tX/XHotMlaKfO2QnYXOFpe42topN+hUseTEfkykf78qPKZrC5qcam4xSrfqb/Ss/x1Yjhicz9bfzeKECtnsIUGDvhI8i30pyyqOFLo9JgPgRh76/Kls8zYQ+PTNoUIVsn3GtuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO5D+drA4qa07bYVA6TrUgo8LFJF1qHTIg2teKV8f8U=;
 b=OYe77kvQiE9Ne+ds0SsPTilxy3d7sqNsRsO8DgsOlfVxx+MIgt/DKaHr29LTOuE7cJJ7ajWpijJ6w0WTQToFeBXoVGjCc1PEBX4AMWNRLZTokzERqTPBub2QXGEDm3nkrKdF8oZn6aublfqjtiGRkENIrrnvnLs4t3MaBUohTEw=
Received: from CH2PR16CA0006.namprd16.prod.outlook.com (2603:10b6:610:50::16)
 by SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 05:51:30 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::53) by CH2PR16CA0006.outlook.office365.com
 (2603:10b6:610:50::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 05:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:30 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:28 -0600
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
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH v9 02/22] platform/x86/dell: dell-pc: Create platform device
Date: Sun, 1 Dec 2024 23:50:11 -0600
Message-ID: <20241202055031.8038-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: e4bf76ba-b86b-422a-2eb0-08dd12955eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0dLRHZydHg5N1Y5OERqZ1V1aDhsMVBSRzk2RWpIOWFBUUpjNmMzTm00ZUNW?=
 =?utf-8?B?eThXVG1LYllyWHAxVTA3Q0dxT2NoTE91UkpYOGcwVUhTTHhhM0ZJYnBaYyt3?=
 =?utf-8?B?L1BCd2RnV3lRK0RJUmM4eDRTNFBmbVBkZmpVK0o3SkxQNEkwZFN4YTJPWG9h?=
 =?utf-8?B?aVNXNEZOMUpBSUQyNXpjajBFY0Z3RWVIWDRUaEh2bjdkZllaRmk2UUpjRGlE?=
 =?utf-8?B?MWNIWFQxOGxUNFpLV0NBTFN6VHJORTNMdEZXVGhGeENqRjEybFN2WnhjV3hE?=
 =?utf-8?B?NWlkb05aSFNxS0xvdndPaDNaOFpPV25IeW1OTzVkckhyaDZ1QmkwVUIrV1VH?=
 =?utf-8?B?VEY0K2tMUEhrZGd2WUhhNTNobStjKzh2dmdhUWk4aFZtdmVvbEZSUlJCV1Vt?=
 =?utf-8?B?dCtpck1KMDgrd0crS3pjSm5KQTBQekZpZ2ZCQXVVMjBXNU5Tb2xEcVZ6WURl?=
 =?utf-8?B?dWxFbXc0MENaRWpYYU5JLzJidmNlYjZPMWkra09NTFFPVkc0bjFaekNIa3Bh?=
 =?utf-8?B?NXBqY3EyUmR0KzRXc0FsUDhsTi9lcEVuSTlWdFRqNktBM2FBaGZFcU1iQmZh?=
 =?utf-8?B?SnZBYWw3eHhTYWZHWnI5Zi9CdG1pdUlxOTBvdzI3ZUE2VjZrdGlOblBWQnQy?=
 =?utf-8?B?WUo2V0h2c0x4MURSdG1CZHNLY2RURVF0bnNVV0d3cHQ0NGQ4dDAzZXZGMUZu?=
 =?utf-8?B?Wi96VnR0eG10NmtiaFpKN1lscFhWN2dielB6b2I5MTNwUGFpajNyaUZtcVNn?=
 =?utf-8?B?cnN1VzNLSkZWU0VFYkpKYVQ2djRua09kQXh6azZ0T2VycVZsM2NxZ2FUczQz?=
 =?utf-8?B?MnRjRGR4Y3R6QXZEZHRuVFh2WU1LbGU2YnNhWTRROU9CWXFPUTJRWnhVeXdI?=
 =?utf-8?B?RDh3QzVsdUp1dzZER3RNb1doUUdERjhreENVUnZvYlRGNklUczE1Y0Eya0M0?=
 =?utf-8?B?bVRacnFUaEZGOWVLckVCMElUTVUwS3pYRTl4eUxQV2ZrTm5MQXlQQjdVRnhV?=
 =?utf-8?B?YnNGcmI4Z01qRVRKcisrdXU5UHJPY3NEL2tJVkZvRk9DSjhPU0tOR1Q5Nmo3?=
 =?utf-8?B?QmpvS3BLN0VZWVdMeE9ydkgwVHY5R1plbjEvRWJjZmcrTnM0eWFYTmJXSDNH?=
 =?utf-8?B?UVJuRWlkQmJMa3UycHpzNFFqd2ZRVzZHaFZzK0FFS1JSeU81dnJqbkE4VDlD?=
 =?utf-8?B?bzVxcDYwekZHK0FFV2NyOG9ZOEpPMDErT0JFbmhsWTBneVZVWWlaLzNqQU5H?=
 =?utf-8?B?WEZVZGlVdkdyOHhVYnFvWmswcEpSdDlqd1RwZjZ5bklyKzNWblVjK1pVWS9Q?=
 =?utf-8?B?OUU4K0pBTkpRbWZNdjJtenVTMWFuVUVOcnM1US9PNFFJTmhyTkVsRjYya3pG?=
 =?utf-8?B?R1VHY0pWenlXNmZzOGlKM0NNYXkyMUZjUHV1OEpyNTJzZ0ZrMFptckZFTURX?=
 =?utf-8?B?RE1YWFpteEtVd01CbFpWa0txajlDTk9VT3BzYkFoRTdweXJBNTU1QXVlK1RH?=
 =?utf-8?B?dkVOcjBTRkFiQnliaDRrUXVHa2tpcmJGVUh6T3d5STlqK3dJM0Zvd1dMQndk?=
 =?utf-8?B?RmtuRzRldTV3M0JHRzVDU0c0akVlYWJCejZaRzR3OTVhdVRHRGFCazBoclhC?=
 =?utf-8?B?cWk4cVYyZHprMGxOR3dFYjJseUliRnVXL1kzZ3NNTjA0N3FBbVdORVlRbjZ2?=
 =?utf-8?B?UXEvRHVPNGpMMy84OG9YRW5XVHppK2l5Q1NzdExwRVpPTmZUcENkcEwwdWd4?=
 =?utf-8?B?MDBNWkNaWmVKSEIrQ1J0d1BBZllXblNwZzZqZnJtOU81LzJIcURtM1Via1V2?=
 =?utf-8?B?bTJkQm9NbkJ6OHpBN3RoQnRYbVZMV1A2OXZjM21CbFZ2aFZZUE5UV2s4eWZM?=
 =?utf-8?B?NllWa3AveGM0b0gzTnJzOS81cldxUXBDL0JvQk1lcDJrcDZobjJ6b2NCeWdN?=
 =?utf-8?Q?VxmKB9wb37tJmiFemDw77QNaQtlZnfIL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:30.3859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bf76ba-b86b-422a-2eb0-08dd12955eb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811

In order to have a device for the platform profile core to reference
create a platform device for dell-pc.

While doing this change the memory allocation for the thermal handler
to be device managed to follow the lifecycle of that device.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v9:
 * ERR_PTR() -> PTR_ERR()
v8:
 * Use IS_ERR()/ERR_PTR()
---
 drivers/platform/x86/dell/dell-pc.c | 34 ++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 3cf79e55e3129..c0dbbd3b23065 100644
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
@@ -244,9 +247,15 @@ static int thermal_init(void)
 	if (!supported_modes)
 		return 0;
 
-	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
-	if (!thermal_handler)
-		return -ENOMEM;
+	platform_device = platform_device_register_simple("dell-pc", PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(platform_device))
+		return PTR_ERR(platform_device);
+
+	thermal_handler = devm_kzalloc(&platform_device->dev, sizeof(*thermal_handler), GFP_KERNEL);
+	if (!thermal_handler) {
+		ret = -ENOMEM;
+		goto cleanup_platform_device;
+	}
 	thermal_handler->name = "dell-pc";
 	thermal_handler->profile_get = thermal_platform_profile_get;
 	thermal_handler->profile_set = thermal_platform_profile_set;
@@ -262,20 +271,25 @@ static int thermal_init(void)
 
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
+	platform_device_unregister(platform_device);
 
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


