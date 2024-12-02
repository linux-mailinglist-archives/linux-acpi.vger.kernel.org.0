Return-Path: <linux-acpi+bounces-9863-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A499DFA7C
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF921163129
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15851FC0E7;
	Mon,  2 Dec 2024 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FEj94E9m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D691F8AEA;
	Mon,  2 Dec 2024 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118728; cv=fail; b=la1s/gKcDB641xZWieg0fxOcLMZbc0Y1dHuXDfbzmThuh53sRWuMmtI9KbC48PNwJAX+lyN7qsYabPmOQTEm9Fn/zGHWL/9TL2ppWRJTK8H0tjd7WfE5KCeRrWVqHuUNjdkvFQFswn+pAb2zm0r1+P3rFFvvNpH1lF3qLef/wHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118728; c=relaxed/simple;
	bh=KM+dPq6fppV/EB4F1B1uEv7wI59aTtfxB2Knml06lVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxE1cUHmB3/T6IF6gZPe4QvpZiIOeDG62SrVmXxiu9GdLvFLFqHoDa1V5W0kYx570wqezVIr6GqkGvXFsJD0ZlRrgGDyxaMGXgR8j+YljDFKPVxPUKOLF8VChE1xFtRz6IwvrzxDQQnBoOrw6coXX5NAOopxtJ8SHhQc3HRSah4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FEj94E9m; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CycQl8cVaue9an7U0rfYd8QKIyt6z5XrsO4XI5VHlb1G+ACR8/SOz4mxxuCYSsJ1UVVWtF/rc/39i8K0D2Otzp1m3gZn0FyaynMhKotk8X0PS77sq1ZzsQpc7yTKyM50TrKPo/RLINUfqQ58Eqvr/fKSLIilQ+VHPCT/E8UlPCpknqHLr7aC76usCoeKOdWdyBnu+aqQp8AGkk58OgPHqXIKJoIOAQQDi3X0DOo4IpO/3F8/0UB5f0AWtd1dbEVyC9u+/5feoBaUHZGqy6D4UGmCp/s/XHuFfZHMNyuEt8PFo2cx/U7ktonP0rH5ga9z7OhJ8F9FG5mr9LGkqXY5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smturJnl38zpoH+XcVv6chpREJCbKkNG0Dg6yMqE52A=;
 b=JsR+MxMrnue89oUZGdn5iCz6JsPulrhM2pmh/LJkjSwoFsZx8jXfyIoUjnlmzCqQV/q7rj3btORHrJLjfEcsgpEMS217q0uoy5O5yyZTriis5OCUM+QuNBRU/BDhFop6bvZELYI4b5ojSNHSw+gMH14B5Ik3Ip7VvixkQPwWKrs/z4yGvBLU+nx1HCcCM6aRW23E3mwAUbqvmLITQ4p5DGXa4o1GFgMuf6/5n+QVdAL3RK1LnCp/GNNcm/OaeSjJyz/NybIWSHMxmU8shwp18nLNynlLwWSuFI8fD3onkIud5XQM6lnp1+ccMFEgXjZwCWWVrXjDO66Z/0hVsURaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smturJnl38zpoH+XcVv6chpREJCbKkNG0Dg6yMqE52A=;
 b=FEj94E9mf4v3iGBvZ5Z9e/2S3OWLGaneJGltXf2F9cTJ4IZA7uBdBYK1/o3Ug1icfKcKeAzEFV8PuPbsq/pdNoNAeBzG4mL5vJrcyUqVqBheC/ftuasCjv+MlzXaCeVNBK1dTQLi598U4T5BdNsL+h2EPQtOia36FZSdjVvXK5I=
Received: from CH2PR17CA0002.namprd17.prod.outlook.com (2603:10b6:610:53::12)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 05:52:02 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::3c) by CH2PR17CA0002.outlook.office365.com
 (2603:10b6:610:53::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Mon,
 2 Dec 2024 05:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:52:02 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:59 -0600
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
Subject: [PATCH v9 18/22] ACPI: platform_profile: Check all profile handler to calculate next
Date: Sun, 1 Dec 2024 23:50:27 -0600
Message-ID: <20241202055031.8038-19-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: faf1e545-ef0d-43ff-4908-08dd129571d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jMCqLqlW7zbEoroEkYXDFdwO4s1emsc2kJYTpLLgkbwH48x8kEqg0uMTU7mv?=
 =?us-ascii?Q?OjeMyr2EXzQyFLxS2Yq/VekhzQ6Yq+DuBLZgU8GyEVzcMAqLvjNKNwmPtC37?=
 =?us-ascii?Q?m4zDVDkfuLrImMIW0OzpngcNf4rE5iHmg6J2vQFBVI3CxEh6nZ+0pfgg2wBF?=
 =?us-ascii?Q?pDoGZHAYraEP4mscYXUGLUaXTGYANaYQCBCyr6teU31132kNVOjssW1x/pfm?=
 =?us-ascii?Q?Vdzbvtgn6KsJcNjFl+UEs41NDunQNblSC7/cOAlQieeGRk/Nabmvc/ztwH11?=
 =?us-ascii?Q?phCWvt7OsBK35piHg5CL8/mC9WF1N4GMINta+iDzOWCYuCbq3gAFgadIpRUi?=
 =?us-ascii?Q?AWfjJxNsIJsxBy4eF1UcKrOcHSZZymzvvNRrIBdpXB999L9ghFxoPr3pHUtu?=
 =?us-ascii?Q?tcLgqgKin+O17d95dSMjLH30Eg5hPtj+u082vyae+8i0nfsXjHpNba9SxA77?=
 =?us-ascii?Q?FlRyaekGSFl5oHWOQcvPvSPyn81LxahO0smCCmmqt+W/7Kue3OjbD7g6RpkG?=
 =?us-ascii?Q?p6gonCLsGdbJXuc9sZyNgjTtXu2U12TkJ1BP7kPaFjihXpShgWacE0mSUtoa?=
 =?us-ascii?Q?8IvtOUopBvBL0ieHw51S2v2PErrjyRtgMcgRnZJ4CeAc8pkmN1t6AJFsp7lq?=
 =?us-ascii?Q?rnfEcFs8aD6wC552LqPMdQWNMHN3M+LpbAMjk4XxlqNuZq4ZDtEKiRr5adGJ?=
 =?us-ascii?Q?Oj9eewTu8Q3wvqk/Vm2DiqkQJBPcpfauCmYHIYqadFRXUb9qfM0Jx73hV18R?=
 =?us-ascii?Q?GjKKTeJ9qyWYJhdTjAvN07xKTHO5iA+Lo49x0DGRgSkoWLCjtb2GE1H6VqaB?=
 =?us-ascii?Q?O0ET44Mnw1R7bFMobbeqq3TS1BQuMxFrQvVG2Xp3tgqy8JA115YBp5wlgnH4?=
 =?us-ascii?Q?ue42lrGwA44zvK1185Xs81H/yFI6foy+VEC+GndFiILL+ZhmirlRH6ASRmQY?=
 =?us-ascii?Q?sTsnuo8vVUaZ6R1i3JQqT9/7jSpCNZpN3itFuwwDcasYN89IaKHJ0/Bihoov?=
 =?us-ascii?Q?NyONXaLfR4E1kSvqwlT04Io6OUEM7E5PJ2sXcbaErI9YQ/Pu3Z0qT2N9CGPO?=
 =?us-ascii?Q?jyOOTQzjWop7elB1ZIzIqrGcqVrQy69DcN/KQ6Nd4PUzvazlI7cbbhia0jDe?=
 =?us-ascii?Q?idSKT6Sr/jNEKowV1L8gF5gpcMotX4bKm05Na6LJ5QXlXumGOW4yx22jQNNB?=
 =?us-ascii?Q?DehWer++HVknRvKeuf61U/9heRAY86QKWf+uSJsogqHLU1jQEsQ6+YKJgPYB?=
 =?us-ascii?Q?VlKMpa1mAYUTueid6mhamVjCCTqSzr4E3oTNL6C+Gv57aBFovUpNjFMlqN9u?=
 =?us-ascii?Q?BQS1UDGLIOt7tf/RrMGB8YZvLRcdgfxhuimk7xfcbGltxpfdctuRtB8i1vDS?=
 =?us-ascii?Q?1eUhE93iA6xFgMMqAzNopLkXPgEZOcifDRg6kZA8MM63APW8LzYGQjMUbbKH?=
 =?us-ascii?Q?O7co8N4Vdpw6pEK44siX0nthStGOc0Qt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:52:02.4509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf1e545-ef0d-43ff-4908-08dd129571d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900

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
index d5f0679d59d50..16746d9b9aa7c 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -407,25 +407,37 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
 
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


