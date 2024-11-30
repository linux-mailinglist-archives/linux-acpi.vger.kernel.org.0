Return-Path: <linux-acpi+bounces-9816-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B379DF0E4
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3555816476B
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C09A1ADFE6;
	Sat, 30 Nov 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EFAiME2Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0A81AB6E9;
	Sat, 30 Nov 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975560; cv=fail; b=ugyRe5dsrnmHWX7XtCuphncGA4LtuLZCeDLllhm826h3Um5DbTxvVGnqpszoOQ418DdYDWeQVu62J9YFUW1/+K2Tqav9FXUS1o5x7jLfr2k8XZctNVIh/frCma+J+9855/gS+gk/G7SGEbT0V4RvMDPZ1x+KpnLkzOP3IeVeRnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975560; c=relaxed/simple;
	bh=f+GAxf2ilYPGunufrK0qKluIJjjPc6FBvYYjc4HgZf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6n2PbMU3+U1Bx86opB6fWsTUJeEnVmrIcfC2+ZVUMGJ8w3clgIEadbY/ODIy2Z08kZsN0LIaGvEaYHsHUCIPiyoAzUGKXSqgHv3q/GCaUD+jsO3zliHsSMMDOTovxv4tX+l5vAT6/2PjOe8d8FABE1ykjsybEQY60+8J3p1J74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EFAiME2Q; arc=fail smtp.client-ip=40.107.102.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qO2V4bL+wY4YKX66pCoclzI1z1pyl8YQ4Nt1oneuQnV0tmxZCQDfPkdUGhD6sgw/Q6NGu1Bgw/IADoyOw5xR8XbEIKNZRzULOt7fcmdTkfladcjyUpQjphiZNYz8daghusFFbguIIbubpww3LbaEEHhJVy8xOm/lyP7B2lw96o9+IX28Z9/zWri5i3B9IVOpEo/M+BMYQqABhW7UtSJLDOAwJKkQDMkWDctdQprBwftiy+y4K+oxo1z3YRTdehpGwd6E3xpiWiolwefG5oaEznGShHH+mDaz6tdoDw1u55OAF960peYsgCMxLQBfUpV9E4HoW4k2fSFibatK+5cEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJM86/5fT/kTWIaWTa20k/1Hba2Jgn8oT1io5vhyWVs=;
 b=cR/qiM20Lp7zH2Tw3whT26XimHSsDgM3V1Uw6H6z6D0A/2HWHCCkTpQa5w7XS6DbSGh1rpXt6RaiK9C1t6InAxpMBtS2kX7xR3KtB6yJNJKXy8iYS9OoDmXKiy9EDDl5GXr7+iIHJcGQWO4rF+hXr8heB0J167J9N0+3mNXnKlc1H/gi9S8M1MwXrUKrvLfLEm50aoAwZYRCrVL4+3R5l4JXIiNUEtGvvYneYAvWHcFUwhXshOK0OvR5Vnt5SQADbE7WQH4eA+Jo/G4nhzV/e/Obvgfkrg5UKPgFNsYtgbjWUOt4EXHpcYAuet63F6YMJaFaCdcQ/nW/TUQe7638lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJM86/5fT/kTWIaWTa20k/1Hba2Jgn8oT1io5vhyWVs=;
 b=EFAiME2Qeelqix/nzt121aiL+e/x60kmlT5rbKUKc5U8TAUOqZpsBHvTIm2+cmQ4vwcdTSbjU8qZD2HBQwJ5dxjUJ4eVEpdiIH/nm4N/tMeWHsEG+tTWnWtrp8a6t6EW+RDTNboey7+AqoTIPSyjwT59RX/lpAn7B3UniBBXRFY=
Received: from DS7PR05CA0069.namprd05.prod.outlook.com (2603:10b6:8:57::21) by
 SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:05:54 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::e4) by DS7PR05CA0069.outlook.office365.com
 (2603:10b6:8:57::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.5 via Frontend Transport; Sat,
 30 Nov 2024 14:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:51 -0600
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
Subject: [PATCH v8 16/22] ACPI: platform_profile: Add concept of a "custom" profile
Date: Sat, 30 Nov 2024 08:04:48 -0600
Message-ID: <20241130140454.455-17-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140454.455-1-mario.limonciello@amd.com>
References: <20241130140454.455-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 757e29dd-8bd7-4a2f-f56e-08dd11481afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W7ottaj8Pt5bcg56Gf/ggDaWUAzrqY1yWkDyLUviJBXApyBTUTITnXmUBYaT?=
 =?us-ascii?Q?V+VBl/vkSuvW0JGCjJDTaZeouIWqNZcmSe9XaWkP6oKsgEH/bf3PasxDWykI?=
 =?us-ascii?Q?MTs6qtKqEtBxEuWXeC5sC5DiPs7pzvwUS0ae/Ig/oZcr+J1Cr7pn4odIt04s?=
 =?us-ascii?Q?fIc/vJEIZb/iOW2PvNb6U2sTwanA+InB1GsBSwZMX1fY9b7FT2ZA9RvvEBkG?=
 =?us-ascii?Q?FTAM+kIylQQSaeNIMFbb8XbnUa0reXW3HQWOdRhoMeNwFTlUTrwSAz5MNiPA?=
 =?us-ascii?Q?v+Rw/5cVCW0w9I19iOf8lMLap43iiILulvJg8Qv/rS6RMIaLtRBon+oLRva4?=
 =?us-ascii?Q?Td+bJtTSWg36XmDnETuxmmvwgzlgdZ2m3ovgJRegqFowreq0Ldd5u7OqtbAn?=
 =?us-ascii?Q?wIsvoY7MY8DhoNsPddcMlMTVt/uh+PIE+yh1FW3p1ImgTTeBknVPZAfmBMs0?=
 =?us-ascii?Q?PjkFgYrbQplH4NBMkhYpwXUKvPkf6+PDJKV709DO9wl5HQjafW7Smxq7uKuG?=
 =?us-ascii?Q?g3U37CLt0HLH/PUFwTwQ5NDspzozKqbxLbsOIE4kocP9/K+6wNBsbhwEvsrS?=
 =?us-ascii?Q?P75nU2Wwl8thRGrtJBZ2mBZloJPHhzI6jTjG929c/YinXKurqRh/AutPI6PE?=
 =?us-ascii?Q?1kuGYlKtTfAcibxx0m4j7oCwjcdMg1dmFCjgN1Z6CD8zjIecy8CH7XloGgHm?=
 =?us-ascii?Q?degnR/lhfnPNQBdBIedZANbfr9LnAaVk379mcaGw5Zt9QLx0RxL5EQZjcwDB?=
 =?us-ascii?Q?p4mwVY4kQSiKAPGPEDkUXIF0PafB39U4c8H7wzxzotgpys74HwIUCp6K6lRg?=
 =?us-ascii?Q?SsYQWs9ic/Mkuu7GP6ybRUm2S2UTZyBaTJEW9ZFvHgdn6WlSiu0wbfGQD7fF?=
 =?us-ascii?Q?j5IgggToX+d9pkC/FEFf3SZzMVDXYN57u3vEuTZsSIJrn9k0u+1s74awROue?=
 =?us-ascii?Q?FPCVwB7Nc7JE6CY6TfJOlrM/NzQKML0+Xxja/1meIriBwBuDgAVbXhV6nbUo?=
 =?us-ascii?Q?DWosMvwmzZIHn2O9dUagOKtwTjrsAaJN/jshD/qGvN8XOmUGJ2pIwGo1Q7Jd?=
 =?us-ascii?Q?gTxAx3lYIlOdAxz5q6fZYm5ulX7MwUeG278JW1Acp3eWI6rElRdahLc4XoPk?=
 =?us-ascii?Q?8U9kQK7VicpKgxXulQ2Ywo8KN+S49g/az0e7elmCbLwksWXxxl858MLEhvlp?=
 =?us-ascii?Q?1SHs7AIJItNX5H/+XrqYla+nwjmcYGKiCRMw6KW58w4usbxyypvEmrlKbsxg?=
 =?us-ascii?Q?uKUu6bTpm6zM2kOPdT7w7j3QlB3HRczc8ZxL3ZPbc0fb4Upp1pR0SVJQ5lld?=
 =?us-ascii?Q?+jF1Jecme0xmO4TFqiRA4IbScMLGEGEQ3646oOpt/sV/0eiPSKM/B4gdkqLI?=
 =?us-ascii?Q?B+HusUBZBXA5URmLRQLyurJzK68f19Xpt046u3MjJ3b3+TpC7x7wDFPsmOkJ?=
 =?us-ascii?Q?XNhsus3YZeFMcaak6oci2X52o0kCQVOu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:54.2797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 757e29dd-8bd7-4a2f-f56e-08dd11481afb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157

When two profile handlers don't agree on the current profile it's ambiguous
what to show to the legacy sysfs interface.

Add a "custom" profile string that userspace will be able to distinguish
this situation when using the legacy sysfs interface.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c  | 1 +
 include/linux/platform_profile.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 40826876006b5..a9cd13c5fd39b 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -20,6 +20,7 @@ static const char * const profile_names[] = {
 	[PLATFORM_PROFILE_BALANCED] = "balanced",
 	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
 	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
+	[PLATFORM_PROFILE_CUSTOM] = "custom",
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index a888fd085c513..0682bb4c57e5d 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -23,6 +23,7 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_BALANCED,
 	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
 	PLATFORM_PROFILE_PERFORMANCE,
+	PLATFORM_PROFILE_CUSTOM,
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
 
-- 
2.43.0


