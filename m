Return-Path: <linux-acpi+bounces-9024-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD7B9B2244
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617631C20B4E
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD59F18CBE7;
	Mon, 28 Oct 2024 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x2L9dHY4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009E18B475;
	Mon, 28 Oct 2024 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080943; cv=fail; b=V7Wx2GNe3CAFLuJkizO5zlpQlktJnmin7TpFD1qf5MtTUftTL9Nr3EK9UKBV6AEGkRbijMOGueQODAhHkWb5qUDAGY2oVXkfr6ddLEuTIKMZ02FRlZ6L0QvF7FRQGj4DD2L8ttmcIVJPqQhRkxQXfl5ro7KNsff66RocWYgjrt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080943; c=relaxed/simple;
	bh=2QWvixAlAOe4y3rfwVCRHvrO11PnTziEQIsgrr0+79o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdPDEWid8vJQhskP5nD6HFj2gAnaE2S+nddYSD0gVk0PS5NnWzFxjnn6LiscqR9DsrdWQfzFW0KX8kOjKUMqNzjhkEK1iHdz17kK/OtwqFBFqR0WpN230ja95P4qJymzRyDC+s9rQgPRMFtn/Xt4XiOW/vovfVVAjphhheBm2MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x2L9dHY4; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMH61BkrcHXJKGnsJ6WqkunhqbEXDo5EM9Q3+ziAOvpwJshEislzEoi0kO0Y1DXFj3JfDZpXcnWEt5wWZzY8iL9+BLMkiot4FDwpekQm7rdzVQRX2fUpvAesUp4El0TUYke32cw6DbEd0rf12or8LjlHRaYG/A2a99WsFjyK7oCJDf50FE2tJ+hCsfGXn8+6Xqb5ANo3qkAlXsDHSVkMWuLoLyNLz6pbjt612npSKygl/25WMbu4H8pVS79ymp14TXcnI61QyFCXyd/r0Hh+wng08e0UVStrqOHHQBGVZTiBD72j9P3q3T9dOmTSm25OlFvnGlGwJh9fB1QeMNL+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2vb0lbHs0eiBbQV/g463nhHMqsys4ERBQOYpqJcx6A=;
 b=LB3y4W2Gli3vbCR9FLYxH3y93DtZ8GHKGLy7sEEZ3L5rkWoz+l+UCkZclwFUldBC+0Rf62tcvwJPG1CRKsCtpLbcfuzeeKQDw05ghKnQDmr6kM4wYM1PJIH4lbZsnsJLOtU1gu2BCM9/G4SsfI6BaX2ghjkvqy2gw7k/yEex+hWLH4p/pHIW7eDNI8lOHlXkyiFugkEKXCz9jqgh/onVzl+H9vgCdzbUo4JLpGW9vy5rSgSI3hZm24e+pplDMunGgb+4BJhNH4dhinoYSHH/I5cerV+oDdzZJxwRnS4m0zwx8EMAbqpyuaGnTRcyWv6moE48fk65OeZyJo3giDRGqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2vb0lbHs0eiBbQV/g463nhHMqsys4ERBQOYpqJcx6A=;
 b=x2L9dHY474nUjfD2p9u2kriB2MSOAopMiJvMxTFubuXrv85wlHD5LAsXlsLgf2h3thxKORf3lHiXld2TdY2H5Bt5Zzl4m5sPNDy98tzioqolhhyLj+k4sDx0sL1KR86+LEpm/sJtmeA2bwPnn5rO0KSigaFdNSLMqH3V+P5WfyQ=
Received: from BLAPR03CA0068.namprd03.prod.outlook.com (2603:10b6:208:329::13)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Mon, 28 Oct
 2024 02:02:17 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::e2) by BLAPR03CA0068.outlook.office365.com
 (2603:10b6:208:329::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 02:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:02:17 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:02:15 -0500
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
Subject: [PATCH v2 10/15] ACPI: platform_profile: Only show profiles common for all handlers
Date: Sun, 27 Oct 2024 21:01:26 -0500
Message-ID: <20241028020131.8031-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020131.8031-1-mario.limonciello@amd.com>
References: <20241028020131.8031-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH0PR12MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: c6dddaea-2375-47be-a19a-08dcf6f48cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZOzBeZQpnBBvI2tAY8HRbAKRRg0PzC4HJMKnengqtezIkAVKGJz2erJaba6E?=
 =?us-ascii?Q?iyctYpHCvhunKurxE+i+JHb1WYF3YvPwpTD89TcoCnTn018XxM1gPArYjXhG?=
 =?us-ascii?Q?s7bVqYExK/OSbAUQzW2kotGs6z9Txi3xhpkFlLGMhWUmu/DWuxzqvSU+IjM7?=
 =?us-ascii?Q?oUwjmCijLmBnBcH6+255q2v18I4Poh6jJ0cIpyn9E6UH2PhN76BgcnYUDEzT?=
 =?us-ascii?Q?hEPPRb/kEZsGJ0FWAOuP39U7gW9/Pwr1eJ1AIJ58HktajFpRaJ1FoBNPcXq7?=
 =?us-ascii?Q?ppolyXdbyjHn14jA/J/bxbh7BoQzkZSNyes9uY5WAmtL2KQPPtSyd95ym0qG?=
 =?us-ascii?Q?1byBuReCQCWWA1ib9iQEKB4QnuaqP5+Hw4u1EOnTP+UzKSemmAF5DygsLZL7?=
 =?us-ascii?Q?B6i7lKV5rqZa/j7P8U7WDtxFKq8yB+hNz6aFtcB3ml9Di/oaPvA/yc9ENA78?=
 =?us-ascii?Q?FbuOGC0jWpfNjjQmevJ5Patornt+qlS9NCwGCAfDmfugLGVd4U9+GIs6zrp/?=
 =?us-ascii?Q?1G50ireyDnjaDgB1vX6RdP37yFJpUs7v2AbIn/kNPaUaNHGumiUkCDOYuKcH?=
 =?us-ascii?Q?VA8qp2SiMGjLCuIdfPWU0wNGr4BW1Uzv5XyE+f070VubDLF1UqCF9cGFRkYV?=
 =?us-ascii?Q?VyJNo5LNlnzs07/S0FB08cTzEDD6TnedUa+sOm49djVUsx9Ex84BybzOtRnY?=
 =?us-ascii?Q?CxmF5l2yMlT4LUN2/GiPVfOQQvPF1HjTuNjzklQrdtVvqpFI3lyI8wcYuJlw?=
 =?us-ascii?Q?xZlWEzKHs6m5D0S84HX+gHmzqytoKEO4D6FZ/lFdGZOl0tJ8wAj5jQgwTShA?=
 =?us-ascii?Q?OF9HYqf8Qkr/oxeJwZvnMDhJU7bj4wOtKcsfcuesuYmBGjXNVUf9IqZokgHq?=
 =?us-ascii?Q?zIbIS4cgyjfBnGRYlYHTuT4773r3MT2WCZSiTW4FKLiQSYwEfRc8+9nlWBAB?=
 =?us-ascii?Q?SSEtJm6e8VdvI63gOy7FodNZPBpRUT0cmZjq8QotePie+FHWe6n5U9CNZA4c?=
 =?us-ascii?Q?CGgNjQdW0Used9RGMOH0DKZ1CIlt2XWphNvilyT3sSnIUD2g47AkcsfJ25v7?=
 =?us-ascii?Q?XuLB5rFUtIdT9+15Qi4OF9S62gfFGVRtRlNg3P5Snbw7XP/noY6ymDHXiA8U?=
 =?us-ascii?Q?dejiRxKNByjNY0DMBUkHiMVdvcj4Mtz7scT0XFPyQHew8Ag6QTdO18W4Q/DP?=
 =?us-ascii?Q?P7+MDdLHUjRSdpQAvy5+0G/EUp20E5a/G4KrEHgRSCUKBcrFIgizd93kbYDo?=
 =?us-ascii?Q?8PrlCcVWYmVkl9R1YdE+RBAGSSnzSRsdi063lK6QrtGcsUr1OVtp2t4PKUWr?=
 =?us-ascii?Q?70woWgkSpscaw/DsCOtvzMAEVNqjOQn7+PMLJAm/VAtWxhuY0XvZz6yoOwaW?=
 =?us-ascii?Q?AVOpZ50tgfMTLQJZxjhAc6tG0bqfybGwyf22rQOpgT384MTW9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:02:17.1654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dddaea-2375-47be-a19a-08dcf6f48cab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632

If multiple platform profile handlers have been registered, don't allow
switching to profiles unique to only one handler.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 35 ++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 5fee467614eac..a83842f05022b 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -33,30 +33,43 @@ static bool platform_profile_is_registered(void)
 	return count > 0;
 }
 
+/* expected to be called under mutex */
+static unsigned long platform_profile_get_choices(void)
+{
+	struct platform_profile_handler *handler;
+	unsigned long seen = 0;
+	int i;
+
+	list_for_each_entry(handler, &platform_profile_handler_list, list) {
+		for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST) {
+			if (seen & BIT(i))
+				continue;
+			seen |= BIT(i);
+		}
+	}
+
+	return seen;
+}
+
 static ssize_t platform_profile_choices_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
+	unsigned long choices;
 	int len = 0;
-	int err, i;
-
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
+	int i;
 
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
-	}
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)
+		choices = platform_profile_get_choices();
 
-	for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
+	for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
 		if (len == 0)
 			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
 		else
 			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
 	}
+
 	len += sysfs_emit_at(buf, len, "\n");
-	mutex_unlock(&profile_lock);
 	return len;
 }
 
-- 
2.43.0


