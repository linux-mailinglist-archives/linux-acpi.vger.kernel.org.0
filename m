Return-Path: <linux-acpi+bounces-9179-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785C49B73B5
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BED21C2209C
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F129218CC0B;
	Thu, 31 Oct 2024 04:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fXNUWLTG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C223513B2B4;
	Thu, 31 Oct 2024 04:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347891; cv=fail; b=ffjS2nycfOg4wwmeZ/zG4ifmJT19KGM+q+3lvsn/rkBMAab0RFS5li2UTa2DflWmcDGj0g/gJ5XQ7EE1ANGKO0YsLPsAj6b+W/LCGYs5Fr0bILh71Qr7eYWiWJfKDcBo2If1zQjJbdNW2k0OIXnVMS3P+jSvsKG9ylMopHz1W7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347891; c=relaxed/simple;
	bh=OYjck0t5lChXtVOi739FYh2KJY2cGMLR7AjODyNcx9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnvWLrpdqH/DtUUulIKvOGugftTt8bG9J04Pu+/zOAzMZGTGwwBkA76qg8Rc+alxYnj6+6YkOXVHhuF1RHPUHz4quZcWEje6FGfnTpQcKuG2fhrfVaDrGljI6UMt0g65I/ikcboGwfXLChy9cTqZQc+jCf9e7mhQGEqBB0WXH1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fXNUWLTG; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4TJ7N+H5Db0SZQnQ7Un9YMq1rARJtv299QC3+sbN6oQWI7hovboKbqXjaGKM6g/eKMFDr2qMx+X/BBVI37W5tNf+nMgrYa+/5k6KzsWXgikrCRAJs57QO2m4j/2N4SCKDxrIl4McY9g2r0uQDJ4NLbhqxkjXNtEn2vvb3WkMGbe2KpX9GJlhSI7p1kV2Opso2Gp2verXtjP8MtT3PMbFsSq201ef3OQjrewS5uaqyZ66pGONGBT7/IgJbyx1njlEnkX5ERzgCY0jYrEu6FZKkIaHExumycrXjjjoTRxi56n9vp8hqfJywXPGZfCRtYim8d6cI2pkloCfaouhslYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BHOmBpCMLd2UWhz8UzPz+xuXGm5140wW5a7FSkKKrk=;
 b=QMvCMgnxxsSPZ/51IUsp+xWtJjrgbaVXKIZ/StQJvVva2hHn7tcsRHK7BUFNWC73JGqVbZvmn4QqZiLKWf8UHyOm2EuS+jFcp+vz1bRvpUIVii8iw2Hc1nGQM00NoNFAscM9NlcPvEYeuYI+zI/02+hbiFYCwTzvKyiH+EsSHM4a8m793GSHCY/VDKtFhg1peiqbB3H/vhjDmTNE4nlN/ucGhM/yYR9y1iEMNNpYn5hIX8Lgxrqn7psZl0qUsyga/eZiq/iPzEC83dFhRePQ0Vcs6b/j4HiwpF1HzY6xB8STs41glbwxedKPUrNnXKgSw7ftrTRonlf7d4igR74eqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BHOmBpCMLd2UWhz8UzPz+xuXGm5140wW5a7FSkKKrk=;
 b=fXNUWLTGYpHTXAz1bs6gnYa3h+OBwuuUUiNTwewmoxPOBspDXvfeaEGcMcG7CeOY7j8yIpagWXegnRJxWhGrj5dYIKgWBZeakDvimTyYqdrNp8LNkNVAjT855J3Y465ZLdCXAzbDLzWWa0Zz95trpixuTwj7+rknhaid6slxOx0=
Received: from PH0PR07CA0058.namprd07.prod.outlook.com (2603:10b6:510:e::33)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 04:11:25 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::fd) by PH0PR07CA0058.outlook.office365.com
 (2603:10b6:510:e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.31 via Frontend
 Transport; Thu, 31 Oct 2024 04:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:11:24 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:11:19 -0500
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
Subject: [PATCH v3 19/22] ACPI: platform_profile: Check all profile handler to calculate next
Date: Wed, 30 Oct 2024 23:09:49 -0500
Message-ID: <20241031040952.109057-20-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 692e7e49-a65d-4145-83ed-08dcf9621644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?anXxWTWYt72qvS/TR24MBR1AC+R5j/ILRfuCty15EAXxU3wUBrJfkaW7osTk?=
 =?us-ascii?Q?GJAU85bNMp6zIfheS8hI1IFm5FWbd/4pYsmYLlUX30QyLCHCWHVVLPNVRgZ5?=
 =?us-ascii?Q?BlCqQPTTxWd919+PgQFElSRuDK2U3nuGeuJq01jsqMdmedLrFjPXsJoqdh8X?=
 =?us-ascii?Q?MU4s+UHxpqxjfWmPViR6UfRMfpRPaDvnEwk3cPtgKteS5Du2F0bIpNoLobXv?=
 =?us-ascii?Q?fdpj0VAQMBZgPB/7IZwGdDcH2U336Gr3u/mOItPeeV9rPai1HwdasjEXVs23?=
 =?us-ascii?Q?v+rt+YSO2vne7Zf16Dnd6fNq62a8gmDGr6Oe1Mhc4f/AGhHVJs0Oh62kOl7k?=
 =?us-ascii?Q?NkRYaNvpKYRtAWHmUCCyc4+XYWASLbei+KDhzeDw+14ObB/q58FXxZvEwolX?=
 =?us-ascii?Q?mE7iat67fhnRomRnJjraLExDnDMXOzevFd2ntYyz+yGtMUqK9RXJ7L//WvJD?=
 =?us-ascii?Q?OJSB+EEstGUwbTW3LK8VEq7jDqfWgFiBaNJMqCO2T43jjmF1nQLzBfkOMlyX?=
 =?us-ascii?Q?pSzh3PnJxkBtzdLugkX4sCjOWQkYOsRkWBCyKf6GGDJG0yrSn8Laqo/wj+O6?=
 =?us-ascii?Q?tvegIK1hZug/fvusQQ37bLFFHNSpNNuFMzzHJds8SGIiK/2OSeRypqH3vEBp?=
 =?us-ascii?Q?8yBJsTyrw4uaM9RnCss6H56c/pE7u62hhV4hBqjvn9LYUlCkiWc3UA3dJGbJ?=
 =?us-ascii?Q?3z7GYeUrPPx2nyNHgl6fn1IjDXyCV8ZEO1jVkAUdNXEDBq2/9ODLMLldA2Qi?=
 =?us-ascii?Q?gk0hrFtQfSkf/Nqv3dJpO8wdlsnzJeUCDvIBlQ2IMWABCbA98f8nPaDJrYXt?=
 =?us-ascii?Q?RWnEr6ksn0c6YuPDhyGpVPONyMev7Ja+QcKFC5F2EsEvP6W6iNly/sWaY9P3?=
 =?us-ascii?Q?XoQ+Wz9WGepCxjTgCYyg12/UYeJr1ZI6RD3i9gWvZtEFrR9lIBdBlBtbGfMk?=
 =?us-ascii?Q?g8O8EKYGTM2QBdB1vqLciecPdOlBD8p2NjJZrj0OtQr4/iL9W1hK4QaSP5OC?=
 =?us-ascii?Q?y4QrDzveFdpXxlFyguVtVX4rDyD+FGw5QNjLI9fiGtEn9vWmyoedrtoZTUF6?=
 =?us-ascii?Q?WDEolyjNxnKbGztpiLi2gecfBUTp2NmJNFP4FJ/271m+raJhi7BwsAm5zqWO?=
 =?us-ascii?Q?c7BALKANdENJCWSSww2Xi7eurzG4y8C1a48jWIptYDkSSPoTY8gJtgCBU9uO?=
 =?us-ascii?Q?TWhpYPfrOYCep87fUvf642+XfkEB+8Scnce+Yj54jbQQIo2E8urtemkv9Txl?=
 =?us-ascii?Q?NmABJ472fBzThmp0scOIBlOTGU/6TOOtgLI8/i8PKs+r8WhUmlvHxk8el+0I?=
 =?us-ascii?Q?Ousu6EuIEy7RR09wJAiL7VL0QkCfK7hc+jXs4hhgsMELRf8JUK3zZgIrzmNm?=
 =?us-ascii?Q?jfphkU7zgx4zZ/PVz+mRv+GcUq465HyfpsOUF24KG81a8JMUsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:11:24.8592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 692e7e49-a65d-4145-83ed-08dcf9621644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069

As multiple platform profile handlers might not all support the same
profile, cycling to the next profile could have a different result
depending on what handler are registered.

Check what is active and supported by all handlers to decide what
to do.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 35 ++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 5baac1f9a9c0e..9b681884ae324 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -187,30 +187,41 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
 
 int platform_profile_cycle(void)
 {
+	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
+	struct platform_profile_handler *handler;
 	enum platform_profile_option profile;
-	enum platform_profile_option next;
+	unsigned long choices;
 	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
-
-		err = cur_profile->profile_get(cur_profile, &profile);
+		err = platform_profile_get_active(&profile);
 		if (err)
 			return err;
 
-		next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
-					  profile + 1);
+		choices = platform_profile_get_choices();
 
-		if (WARN_ON(next == PLATFORM_PROFILE_LAST))
-			return -EINVAL;
+		next = find_next_bit_wrap(&choices,
+					  PLATFORM_PROFILE_LAST,
+					  profile + 1);
 
-		err = cur_profile->profile_set(cur_profile, next);
-		if (err)
-			return err;
+		list_for_each_entry(handler, &platform_profile_handler_list, list) {
+			err = handler->profile_set(handler, next);
+			if (err) {
+				pr_err("Failed to set profile for handler %s\n", handler->name);
+				break;
+			}
+		}
+		if (err) {
+			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
+				err = handler->profile_set(handler, PLATFORM_PROFILE_BALANCED);
+				if (err)
+					pr_err("Failed to revert profile for handler %s\n", handler->name);
+			}
+		}
 	}
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_cycle);
-- 
2.43.0


