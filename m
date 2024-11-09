Return-Path: <linux-acpi+bounces-9476-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C28029C2A0F
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450511F22D71
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DCD19408B;
	Sat,  9 Nov 2024 04:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E86VPkc8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E671192D6D;
	Sat,  9 Nov 2024 04:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127381; cv=fail; b=tLtPrbov+7KCahGSjU8YRgoQ7eIi+LkpkLE4zk6rY4cP+dW0J38XpqcTnMK2E8KHBNwRfB44Jb3udzRtS4EhbkzmVn1VHP/b7YrUmaTVWJAxNYQM70Hpjsbt3j+G14hSUZjR3EO4p6KTLlQvSVUOjr5zMfDeXbblvngiKHQj824=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127381; c=relaxed/simple;
	bh=HpTBxpGWcFUk1njHPyD8zpusRLZCSn+TW4gmVMOWUb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjIVdrJqVEr1HuwV1XAwV+BPgUYgD5XPyRiTdoLdmCxq93gVPkqN/hmiiryBwmxuFAUlOSIAs1iPwxFMxyM5b63bzFrueyQRVw1ZHEuZhNYci2lGRhbd0XWW3LlFt3cGSX9smFZK4MGjREjs6sQ+k82jw3W4+C4caOS1EtTeeO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E86VPkc8; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZZdIYQynjQ//dfF4GnG6ExI5Knoozic+e4rW/0paLyFd39BFwg49n7bNRhByOvinH6bgvFsFR3JPBckVfCt7RzA3oinI+kGefc1lmi1Kixmyc0qaEVtlF04GLbEwGXvC/q0n2C5TsXYBoEfbD/CbfutkwuDgryMaXHEgplL5hA6Pv/X1Vx7//0EIorcwaQ8K8JKFBMAKn+lz29l3FHJwCY+xOKIIayXECL1eov9USx5S4tJH8Ju7uAHDAY/lfFG42eVVyjy9qSjWdQZVPk9KSB7oCCukcGoZKiz+NoX/HjeQ3aQQznXgriqHN75lEn0nXgWRCmqMQO2VfEse3BdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZoCYD/0/64rjoFoTrPbqlFnT6HYWqcKLBXHrf/XwKs=;
 b=YyPnToQcXKHnmS2Va5mSXXvQM17GiIJkDzjHPNlih0MmClzDOI9msIncI2+2aT01+I9yIxme+if7WkAv30WbYUAvYQJqD/4p3fS/Inje/G6VUPt9PBapi4L7fZrPanwWYFPZk6WkKZrmLOR9Mxsr/DYeqdiTbVrhy8vhlUf2LyKsPwfv/kAsLNozK9KXPmf3ChfK9mZeRPe7JSABRKT5aayN4tnU99FOM1YztOiVCSxbVpiVkP/CbLeVJwQRjHDvI4K6sAPBXcAwF9wLqw6R+6++mRk0jchMAUDGs3KwI2N8aLYK/qBsN0EXjaHXLoLBLY15kfu4tG3PLC0GRN+Hcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZoCYD/0/64rjoFoTrPbqlFnT6HYWqcKLBXHrf/XwKs=;
 b=E86VPkc8BNT7Gn5I71kzduqUCI9kPOaTPpx3DHtQCvREp2P2+bu7d/EKBvgx7UYeHWJQVafK7+XCmbR9hRSoxWX204OJqULIHCuRukRAO8H0HbXRaRGMrHW+c2iMMQwht2+CYfe1PEvaJw060Jp+DUQe0OeHG+7jECZdPxYYc+o=
Received: from SN4PR0501CA0060.namprd05.prod.outlook.com
 (2603:10b6:803:41::37) by PH7PR12MB8155.namprd12.prod.outlook.com
 (2603:10b6:510:2b2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Sat, 9 Nov
 2024 04:42:55 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::51) by SN4PR0501CA0060.outlook.office365.com
 (2603:10b6:803:41::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:52 -0600
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
Subject: [PATCH v6 18/22] ACPI: platform_profile: Check all profile handler to calculate next
Date: Fri, 8 Nov 2024 22:41:47 -0600
Message-ID: <20241109044151.29804-19-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109044151.29804-1-mario.limonciello@amd.com>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|PH7PR12MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 00267fcf-5197-4d8d-bbfb-08dd0078fa34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9pY2e9GNlN7gQIPQJ5DrgkurVVrfypRlOzGYv3HQuzNkJ6t8ptPXnHNM02xJ?=
 =?us-ascii?Q?1o/zaYjIepvGTTkUPIhbr6hqb9dr/l/6d1aSmwT+A14gnhyBZqGcFXNSUIRM?=
 =?us-ascii?Q?CLBUiAVlSc4F3gFPyIXC2Lwhc8xbqXhDdGmhJ1tXjDdSJyYxZUk95novBnBQ?=
 =?us-ascii?Q?v/L/3/XbbWXJRWmrDdyG6trBLkBg9drzkmIwZsUgg1jS8MOMGdLj+XpRvPtz?=
 =?us-ascii?Q?4lUx64P0QnAY5PrAl0RGb8ZtTIuGBr50VqMU8P5H8Eb0YWq6xLjEZCC69KhU?=
 =?us-ascii?Q?ar3s0PVphRhWB7VjmzPYA1ymS67OcX4QRJwLPwhgxNrqPOmzvv2CVN4jEUXG?=
 =?us-ascii?Q?hXRDCvB3CzQPS8ZSxMbD+Aom7vsxb9ord/R9XJUosDjNMUNxmPkRZZjTX9sW?=
 =?us-ascii?Q?Isy6UwXAJ9Uftczp1KfV2RRQGjMZYhtS7V50H63E84s9COOZgFrqjrOe+Lmp?=
 =?us-ascii?Q?OHgxhvtk40Jz1YLI93g4cqXcA8jF0m59HxHhfqhqmBvet/+FUP6ItuO2boG/?=
 =?us-ascii?Q?FWd5r41QfsVJjQIbSaq0GGW3V6xDsA8cBVI+LG/VC2H+nOV8cqPocAgzqHbl?=
 =?us-ascii?Q?hJ3JIRo9y2Oj7yyfU282bj6zy5ywbON7NWTNddjGtu4lt253GRKY7hksa2c4?=
 =?us-ascii?Q?asV+lUW5WYW3U5AQ52xPMFyeeLwBHPIYIe6LNPcDi7raldcewGFQd9l6AfZW?=
 =?us-ascii?Q?tvLtDCybRwtk+/tojwPe3A9pY0rnB9PMmzBVcAKxkvpg5r0H3WfETo7UMM0C?=
 =?us-ascii?Q?4Q+iwG0dAhRcd73ZBr3gGJjuMnvEbjawKl9sV18yp4M3mxSz8auHo3vWmQq1?=
 =?us-ascii?Q?DteeSASj2ZkDO1UIjJ7oyBQQzwhxD8Of4SRayTOZJSuvWYLGAB8AQ0PSQvea?=
 =?us-ascii?Q?WsFX1xn0ngN+Dw9oxy76QS51krzwk7LexTMwDOgaGrlb1ObXtFoyLzVMjOTk?=
 =?us-ascii?Q?izzsAIHnKgMsZW3H8Q41QkheLdM4hBX5Fob6yEKETGIXDKx1HbZB0wo6Hw6i?=
 =?us-ascii?Q?uAniHLaiV8nmWj2f49lGg1RUO3ruYvIRsvM0RUTf8gRMOMpziYk2btDcJGlF?=
 =?us-ascii?Q?WW/29OCAvalnR8LVsyGE2GHTOwPFycfqzclck0PQJpVrsLOAcRDgrhleNX+P?=
 =?us-ascii?Q?1NUcuOLt+YnIM1gDvIGFGguHXo9GKlkW2rLoXmNcD6nan6FrKhUb7JiXU2si?=
 =?us-ascii?Q?bDnaCj1zpESTXWJQr78Zk4LwChU/0Znv8tWA9Rt+3gilj4b00rjnYSOvvDdY?=
 =?us-ascii?Q?20mMIBf4rSQxdSFdD4wP4taY3/2r7qwg3IvOzyNykWP3m4U5VyxnnEEzzXvS?=
 =?us-ascii?Q?tekoM9MYdKXQ6/OPCtDbP4CvND/a4JZkRQe2t7KF3/XR5rqi3drUCbUGADhq?=
 =?us-ascii?Q?ga/xvFKjRhbD80mGMI7TVqDpfJ+tg0Sx5Ld+dVVkiS6FmlldnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:54.8907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00267fcf-5197-4d8d-bbfb-08dd0078fa34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8155

As multiple platform profile handlers might not all support the same
profile, cycling to the next profile could have a different result
depending on what handler are registered.

Check what is active and supported by all handlers to decide what
to do.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v6:
 * Handle cases of inconsistent profiles or all profile handlers
   supporting custom.
v5:
 * Adjust mutex use
---
 drivers/acpi/platform_profile.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 2676f4a13689e..c574483be4fd1 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -423,28 +423,40 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
 
 int platform_profile_cycle(void)
 {
-	enum platform_profile_option profile;
-	enum platform_profile_option next;
+	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
+	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
+	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int err;
 
 	if (!class_is_registered(&platform_profile_class))
 		return -ENODEV;
 
+	set_bit(PLATFORM_PROFILE_LAST, choices);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
+		err = class_for_each_device(&platform_profile_class, NULL,
+					    &profile, _aggregate_profiles);
+		if (err)
+			return err;
 
-		err = cur_profile->profile_get(cur_profile, &profile);
+		if (profile == PLATFORM_PROFILE_CUSTOM ||
+		    profile == PLATFORM_PROFILE_LAST)
+			return -EINVAL;
+
+		err = class_for_each_device(&platform_profile_class, NULL,
+					    choices, _aggregate_choices);
 		if (err)
 			return err;
 
-		next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
+		/* never iterate into a custom if all drivers supported it */
+		clear_bit(PLATFORM_PROFILE_CUSTOM, choices);
+
+		next = find_next_bit_wrap(choices,
+					  PLATFORM_PROFILE_LAST,
 					  profile + 1);
 
-		if (WARN_ON(next == PLATFORM_PROFILE_LAST))
-			return -EINVAL;
+		err = class_for_each_device(&platform_profile_class, NULL, &next,
+					    _store_class_profile);
 
-		err = cur_profile->profile_set(cur_profile, next);
 		if (err)
 			return err;
 	}
-- 
2.43.0


