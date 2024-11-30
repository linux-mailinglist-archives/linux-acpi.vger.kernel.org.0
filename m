Return-Path: <linux-acpi+bounces-9818-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E809DF0E0
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE46280E7B
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE541B654C;
	Sat, 30 Nov 2024 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3RIYhA5/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579171B5821;
	Sat, 30 Nov 2024 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975568; cv=fail; b=PesIdSRdMZXk1lFGRLIPC5Corn3tDH5Q5obf+Tes4k/nVxCz47a/2XyZAGrsrBsraFfn8LgU2rIAb16H1XNM7OMflkTJQLSJKMlRnpmPWRHjD2cV6/qLdzWFP9KV1SazNQp9a7wDV464KgJuoX+KbFJntTaYqDzLi9OtADOftgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975568; c=relaxed/simple;
	bh=KM+dPq6fppV/EB4F1B1uEv7wI59aTtfxB2Knml06lVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XngPsRnaReAMUt6SABF7jAkljrmJ9XQCYJUjYUDgER52DVWtGTCrIPKuykpJQPYxKc7BixSh51GtJcDsmoi7U+lg6R5v/3pS7EQkwWIIV4EnpB1W2gadanop9VITsfe5SFBUbDpcpOP+/35+gsij+yUeNxuefvktXNs19ZLP/XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3RIYhA5/; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUZCdtZ10IxSZAYKPddrKMkyCsBWuZQhsvggh/p7bebUUIb7shBPqA3tGrT+FtViSVo/E8P1YiDq3d69PFvnPMM5u1o8xkfEh4s0rn3ll1RmGMoVu0kVUvmn0enz/XMsTEqj7vHzaLoPH40T5yTuOkDGpyllVG1RXPgv7uPQRHI9q/BDW93iID8yR1hv/OeCC31NqIIld8nbPJQw6K+N4H55pf7RgqZMlnFeDCfQrIeeYQbpUG9ics1e4H90O5Xm5udjn17jF9YrIR8rKB+HZaKFFQaJ4Ub7FIHXiSwaZt34oIf0AzKXE0F3XmbeYN2SnSXBL9yDAXSzK/sTsxvfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smturJnl38zpoH+XcVv6chpREJCbKkNG0Dg6yMqE52A=;
 b=mSVpdzkmgnCMuieAFAmFOsmHNFJopRWLLo3K529cbh5YqjAzv2yUJYe1l/BdH6TEUIl1a8nBagpXyCLxIsPJhy6oEo4MYjQ2g4tJo2/7C+hFNDsKF3DZ/Z22FV4WJEQ42dNItHc1EQHURXXL960Uxnlw30C/sxjakUN9Cprpv0SfUe7DmwOwFl1TNf/vysG9lAzogjaEiysdI++/m9zDumuiw88N7mZJQPAKeZtXSVsBBIXGUUMW4VPj6bJhyBFDHvT17Z+yUcTh1rcQ3+zd9Kg7Xm1JDCO2Dt+lb2sv58mUT/Egl77eIetnIUu6lzNibD51R23vNrUPgUyC47vE1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smturJnl38zpoH+XcVv6chpREJCbKkNG0Dg6yMqE52A=;
 b=3RIYhA5/qwG6nqPEA2btkjkTQ1yvC7sAysKE/J2V8wFKlWaCX+9cueGA3KLJ5XA8ZqqTKulhH58+fXi2DVdziiCXHO6aDP6vJETX6YoUQbYCO+BbSSAyBGGczu2GoXJxZiZ8v0PKL/zjSWqw+3QQvt/ge7UIRmylkiWrx7xB4ns=
Received: from PH7PR10CA0019.namprd10.prod.outlook.com (2603:10b6:510:23d::27)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:06:01 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::4c) by PH7PR10CA0019.outlook.office365.com
 (2603:10b6:510:23d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:58 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:56 -0600
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
Subject: [PATCH v8 18/22] ACPI: platform_profile: Check all profile handler to calculate next
Date: Sat, 30 Nov 2024 08:04:50 -0600
Message-ID: <20241130140454.455-19-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 93121692-6d6d-4d6d-1f0e-08dd11481d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Goa02tBmzZZ01H5wQWT3J/Z7D2h6W/mPUFKt0aYnAcX8WI0dTjRcFjDl8Ce5?=
 =?us-ascii?Q?2CtHgH7GleCp71nuF3y7Upt5blgcjTv8fclnsiEb3US2hDbq/pa6G/OhTBR1?=
 =?us-ascii?Q?BZ427bXTE29KqVimc8A3mKQbYLuhsQEkBuOevhgcPr9DoksUQ14iNe0TxeHJ?=
 =?us-ascii?Q?U2IvhCZD0AQ2ndib2cY+PepFedLE4FM+y8HSnr3jEYb0+IoUyJfpjUhLHwLi?=
 =?us-ascii?Q?U+sl6qG/VxtVL3A7q3QnBjgHncUmpCVYwrS7rrIJDuCQcmOgqxdJdPUFapX2?=
 =?us-ascii?Q?jm1NcImUm3hQ88zKVgsSd5HRLZwAooFFcPP7gT3S1gnUBW7hFmDagsG79eXi?=
 =?us-ascii?Q?v0VZ11zJBfSxd7JfCUrCUfYv6kkfs53hfba2/ocEOhgkbDJn3xrR6ac4uBAd?=
 =?us-ascii?Q?y6O6KXM7POVd3T4J4YGZv4RRm+76bJbozLSxqF/b5pAXrDJ3TxXTrvBCGh0F?=
 =?us-ascii?Q?5av0nENlF5v6tiNdYVd+ncGqgnNwJ9xVxg0/uWXoM/cfVCDK5rr3ljMYUFQc?=
 =?us-ascii?Q?npeBibImP4oFouRZpqJGCkJTgWcRP0kPYR5pCKGSoA95ED06xJCv9YplQE/v?=
 =?us-ascii?Q?nwvY5yh4Pe5Mor6oBHL2J1bc43NWKiemuryevagMmgSHhKykRTsMf0mx9R5v?=
 =?us-ascii?Q?RlCJWDdthnSAPRbnvb0XCaCraFW8v1h3hWU07OI0AFlO8Mw42Yzkf52q/1Oz?=
 =?us-ascii?Q?8bUON8UIzZFAKAiV6xM82DFdXd+EWAsCeTe1IpIw0UBqh4K6VNuxAeu26LtE?=
 =?us-ascii?Q?BUOqzfIW80p1I2/E981NaGC0HVdVJZEwx5g1F6Bo9AIZly4pSOIVcfRpmH0A?=
 =?us-ascii?Q?kAuz4FBWQaZ+gJTBbVKZoEERllB2WE9IlP2gxBEareXNXOfbdlL/yoIl0XfW?=
 =?us-ascii?Q?a0E2CiLJNFarNpQj7hcT3c/+qkBsgRSzQ50LNJQXBLqWCufG586uoRGzTGoj?=
 =?us-ascii?Q?Nf3+wsAN4LTDbrmU7/4I3md9MH8sau58gKoGRsXTm/OcN5K50wv/XS06/qzk?=
 =?us-ascii?Q?BLNO/8c6hy7s2w+1pajQ0j/7fHYGsRKhArYb07DWjp2dtCUcS9ugkoB1dlJm?=
 =?us-ascii?Q?I2c6nNF63T5l0c7GMwz2vrKU7OKmNU2QJpVDMXy93gvlL/HmBQ0lmacJoKcw?=
 =?us-ascii?Q?2CIxkjwRNawRAFlgIY8vIUKqVbiQiYsdAA11nW3HDvwx3YQO3n2uAzVN+Wlc?=
 =?us-ascii?Q?9BdfOYM+wYnrGePpkfs3DgbyuXmLfsMjh+epGI+9GNue4QgGKwS4kpVYKYnR?=
 =?us-ascii?Q?7teuo47xMmuJHS3hgdJKivvS/tl7yEK0osqAMbFXPATdgclSoU0zTORzV92F?=
 =?us-ascii?Q?UQSv3nLcpbDBOjMQuOzi23tzA4rQEoJZW2cQK6hJtJr4KmOmqcT3Wcr8KPY2?=
 =?us-ascii?Q?hYi/KjuLNSiRhhWOK5xHdbSV08T1xuZNpqUTHmBey7WeSyp0l5S8OxkeHDaQ?=
 =?us-ascii?Q?2EEPk7Bb0ECtZ3Bn9BTS8PFXSYmanZi+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:58.5471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93121692-6d6d-4d6d-1f0e-08dd11481d87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

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


