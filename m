Return-Path: <linux-acpi+bounces-10003-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27F99E64FE
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2800F1885826
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320811D515D;
	Fri,  6 Dec 2024 03:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M7hRlP8Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C0D1946DF;
	Fri,  6 Dec 2024 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455589; cv=fail; b=UdUkLlYpHQ6/alJFGHnMvLaTgstptl9TYpWud+6FOtiovZupiuJ7L5zx9vbtzIk7togXocu3UZIMZeBIe++gVfShui2HnLps0agbDpCXh7P5Wzpfa8Plgs9T+NcniMXWOzgxzKffdZeDpzW2yfhSdbOjhv80FXFls924Fj38NM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455589; c=relaxed/simple;
	bh=g3ki28Ci1PiUh/5QyfrbTEjjGzwFD7CbNTldJSWQOc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtQQA1FSyspfzwqpkpLUunRDHBna+VR0gpfM5q+t9Kj0P8gsb5yzdwJSuyHxCLarPGe91ug1EdwrWNmAVGVKVRz4EntMUV8nOHu6UkOTvK8rhHkmy12+ankjLWYOFt77COfA2lDSHQuYaPtcv7I79QTDgbqMnyEHPh/JAHtjP9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M7hRlP8Y; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7kTYAyDjgOU6YLeJj+9T3nqStkuMfOJu8Q0jN8WBrxbgvabm1MDUJVaoYIgf29FZKMMW054PvEtRAxpg6lQGiZYGJ1G9MyImHuV+xRx9H7VHGT5T3kszeTV1yex06Mo10Duu7LAMVc7/1DPwSoZKydPsuR7OX7SiRC6QBKJC8fm2f5Qxcx+ftT4B9XJqmP86ooLWbQFzY2Gk803LVMONrNYJsHP6FlMeHbPKpjtxx5ERvLSJig9hq+f1ZGTg7zzGoc5WCXzuos9g5gbuZ7bxjpl1x6iDWTuy687t18seCf8BQnl/rPMwqLtgIWKs/6M5ki5aWT5PdmYncroVGxDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4ORTFObqqN0AW0TcTMHLTYnCDiVe/fvkUiquKZttwM=;
 b=tZS6IGTEfjesmClnfuHHdf6SjBKDnYBixABXpHUeFeNby4cMOfx2outtS3rbHXz1oFAVHCgwHi2XyIWwwuWIsV8b64V52JVonqCi9irR0XmmSJ03MU+20yzfJGusdtb4yeWwsnul3F8HUMjnssKGOF/EnLaPPLMnQaIy/S0duyIRcxWxSYPsUrPLbuHvVYUxqF5/Ctp3Rk3poXzyXuz7ppUV0aCjk7Pw0/VesuPcNP73tMw5BcCExmFd5n4bW5NdcBTvkvyHBjt1lQcBBZGvcrzAEYrBGnxDdjYEk5aNlZ5FTNyQxgRAsWuTnu095P/CAu0Wof4baPLc4W6ofY02ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4ORTFObqqN0AW0TcTMHLTYnCDiVe/fvkUiquKZttwM=;
 b=M7hRlP8Ysi1FN1CSh4WHT7b7hazBl5Ec2eAltS3wIouetFn7FZBj/CPD27t+3eLT+ugEAS51YRw6K30aMsHHkXPfhYZYyaCkEl3lf9ecyuPMi4+dlKIWJD+01XxFaiesr05/rSQuXefQysYVzw2d8x6LK3jJv84oqpWWAaEPQ14=
Received: from MW4PR04CA0060.namprd04.prod.outlook.com (2603:10b6:303:6a::35)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Fri, 6 Dec
 2024 03:26:23 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:6a:cafe::be) by MW4PR04CA0060.outlook.office365.com
 (2603:10b6:303:6a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Fri, 6
 Dec 2024 03:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:26:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:26:14 -0600
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
Subject: [PATCH v10 18/22] ACPI: platform_profile: Check all profile handler to calculate next
Date: Thu, 5 Dec 2024 21:19:14 -0600
Message-ID: <20241206031918.1537-19-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206031918.1537-1-mario.limonciello@amd.com>
References: <20241206031918.1537-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 242c30a0-b1f6-4046-80e8-08dd15a5c25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ED4CUo1StHPgGLFueEhFpDGa8cbdN6L7gkfMsCG7nyqlqA/yWvBKw/9L+Whz?=
 =?us-ascii?Q?NLZ4nopXjk/+c5TjEOy0mpbT3rktXIsRfNNcUESefGnSzOsrQfbX9nkRsJvp?=
 =?us-ascii?Q?VZQ9MEjYl35iOmOsB6uG9AW7ZUiaDzPzV1fe2J1dMTgvN2GBuY6M56emjJxj?=
 =?us-ascii?Q?xaL4Tgn5O1Z+Xel0/C8b2l8c2WuWechiMowlV/E1HFxdy3zCcUHMts4K1h9V?=
 =?us-ascii?Q?C74yI+2YgIr/X1xrrFFU1U6WI05a7HdI7BxNkkNiYUzCtozljdUl+AXkrsJo?=
 =?us-ascii?Q?yaVrKbw1ipRAdCkBQAEEEQA7k7GF77JaBHrOKLBaqF9h/7N1EO0XmGrhkY83?=
 =?us-ascii?Q?BJ1akCPMLgiWD5KhYEJYEcMn4sDkmsIgchooMUhtYcDn1Lv73pAJ8qLv4AkK?=
 =?us-ascii?Q?muGLBoUhx3f0/wMDy3YKToaJpX7tsFF1hX7dO77mcjZr0bHbnTtImeitRvc2?=
 =?us-ascii?Q?7kUWa69orm/0c+ycXwLm2lXjwmA5yYwbgrz64arjEi47oyoOnqnPxMgToNA8?=
 =?us-ascii?Q?/3gkbLRlJxGZxvvYNo9Rt4CfJTp7KWThy74wqOnTE7XRp2bwdjfCOYBO4nvn?=
 =?us-ascii?Q?VqZyowYIkKi/VshMbBihjj52irSdW3V31PxOpE6rFmGB44ZbvBWCNRf3+ceU?=
 =?us-ascii?Q?ldEsgcBbYAhw8QK/rFfBd4Jgp48DnwCj7Cf4apxcONIzA/lfYCxwP2hXuDNT?=
 =?us-ascii?Q?zQoO3TTUCUboXPCpfSrB9tUekcJTvyUXHj2NhmoQJXs44DgSxNm8vTIrFFFt?=
 =?us-ascii?Q?Y2biNY9H4fvUNMqm7RSN6g6x9KAHH2qeJ5VIH0gsBij8sAvtCtBPjyGSAUlg?=
 =?us-ascii?Q?jrWPKDbkmLC+QnLev+kaNT5lq6/ycrCYA8/EWVD4S2JaD+0gSO63Yxmz+II6?=
 =?us-ascii?Q?sF3mXXe5dWbOCPNhv61OyEvktePPO5pEqwJS4SNd+/55niz+ZQcH+sAqmiR6?=
 =?us-ascii?Q?1HEehjNmR/GQNp3LeJh0VEVv4vGcmZLoY4rqLUZXvtGUKR+T/2mYf0H7MIkd?=
 =?us-ascii?Q?WJf/6VLaoBw+r0R3q40HaWJPD2yDpnVtb3Mz06s+HHuuv0a/nvbZQEH9jcok?=
 =?us-ascii?Q?o3+p9v3dBSwOfcr+m3XNLdrI/AXbPhwMkA9CU0pE2qASm132tcCWkC5ZMZBK?=
 =?us-ascii?Q?D6US+rjPdGWkJ4CkHLVYLeLgDlQUDIjndXNeTlu7j1R7frofjoiUmPOMUI4w?=
 =?us-ascii?Q?MU6jlbFIhDuVW6xlUN+IexYqkzCi5BSF680ToyXx+TUuKUHWfKivuXXRt+Sm?=
 =?us-ascii?Q?HsmJjAZ7HX++XHQzrxjisA1jCbWeAJUgK6va7JhSlP/ucBygZsJvyVwBid0e?=
 =?us-ascii?Q?SID40oxwZJhtK8dKipiV5+upA7yABfjns8cbj+vHeKUfi56fCbGPQLJIDc0M?=
 =?us-ascii?Q?zZVNYMJd2cUduRpWGFZV+4DfcE0+rbgxAZ4w+e0HN5DIobjZVrJEY1JMST44?=
 =?us-ascii?Q?oUfTrjsSyHdL4yD2XKlxKlwSP8jLkFYI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:26:22.9741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 242c30a0-b1f6-4046-80e8-08dd15a5c25f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514

As multiple platform profile handlers might not all support the same
profile, cycling to the next profile could have a different result
depending on what handler are registered.

Check what is active and supported by all handlers to decide what
to do.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 95aff045a1eb3..a1fdc56537baf 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -418,25 +418,37 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
 
 int platform_profile_cycle(void)
 {
-	enum platform_profile_option profile;
-	enum platform_profile_option next;
+	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
+	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
+	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int err;
 
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
+					    _store_and_notify);
 
-		err = cur_profile->profile_set(cur_profile, next);
 		if (err)
 			return err;
 	}
-- 
2.43.0


