Return-Path: <linux-acpi+bounces-9021-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDACD9B223B
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB25281FC3
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CEB18C01E;
	Mon, 28 Oct 2024 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SkQSzxZL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4B17BEC5;
	Mon, 28 Oct 2024 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080940; cv=fail; b=Af5u8ltdov76qXe2jGNjjRqiN739Ooz/dTdTjqaKQftikVWG8AuRPM6Y4UL35Y/OK9Ld+Lvxqnbv9OKFXL32Df/DzuU0FezjQUzTFR3y1hueCsoeob8yOySCsAQPGq5d1vtVktUXjCSC3E0PylhduHEyHTEvN3KT38+y93XTQIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080940; c=relaxed/simple;
	bh=gzG9evIvix7BJIIw6KKXk58iE199qvBV7N4bBkYhB5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVVnIh+DTofL58Y4d2K7F5w6TRyM6fED3ODkYaa3X2Ze9dqUjo3ZhxiNP1hAelvku1Uz538qcsNQovbGHOk0UAQGJN5X9GKQBOdQ3CXrUw/derYFdiTY74G6XxwjvtXPG1jR4EY8iSOi9JYRyfccKtphSdThPoTvlF4nXpcmme0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SkQSzxZL; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHolHMa4kQg+y+pO/oaRZHzKaC+M4Redu2HLYKqFBpLhVFHC20VnqpJwDkFB15s7pKYk+9f4+FxC7cksNcZG/tT36eanxDgmeiIA9J7Qq3Y/c9cVacuLJDwGhQoWt6i8RsoadPTe7EUfsd38ZQS6xAWzYZKdQ2LeFAkFjpCSciv3DsRWcGMt77yTuuwb/g1UWTfBfBvjT9S12+/Jpb2lf96ho62Bzf0zgumItGBIUhQ/GHNaXYP697oKFFLNV9dprCicNxR5f14ZivHbUz7Pr1+OsPMPFhwhjOwvbsOHULBu0PotEDM2mUXouCpRnANEnaxRKT8dnyaXnkAxBlvvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of+tWu8dno3uGfpHQBfXgzG+HIF2ayWDNCC63bi1cJc=;
 b=Dv1NDBfOq5WqDtPOsAaoexnqiPSBhCaZQGSgKNGgRdBcfTI70LmZyW6Y0g50OCSc0ohgDQsSN7A1KeVi6rj14VA3hO6tyiuNnk0lWDAg7Jx7nnoYO/wrqeJHyj8tRU43TpQKj7RXpLPn/j0rT9T+yOPk4VrTHZl9lVXX1mfEh2qN0AJJPMp2e0/D7zYACwy5o8YUIbCRwoWwykMONY51jeITee7NOghQfO2Oz/ptOukSl3oLWXXn2N28lXmT2SvpscW1agAI+NpCokKmerSDVOxPa8W4I+A6xK4OiC3GMC8jcSWONeC94JIuZGdlcvDY5afUE/JnsudTSZtCnKUaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Of+tWu8dno3uGfpHQBfXgzG+HIF2ayWDNCC63bi1cJc=;
 b=SkQSzxZLmEfhQSc1HBxEeq1yHvr2Nj+8nJhoSmjbWnfvwcEb6UvJA2L+IK+FHWGhzzh2zV9YwE8UgPq9Z/oC0ERh296f3GRSpQjY5fK22W6qIlB4OwCvV8kTdBuDB+//R43oILT6avREk8DglKJfAZGZIHVhX0DuVdzjdG3s67g=
Received: from BLAPR03CA0089.namprd03.prod.outlook.com (2603:10b6:208:329::34)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:02:13 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::4d) by BLAPR03CA0089.outlook.office365.com
 (2603:10b6:208:329::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Mon, 28 Oct 2024 02:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:02:12 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:02:06 -0500
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
Subject: [PATCH v2 06/15] ACPI: platform_profile: Use guard(mutex) for register/unregister
Date: Sun, 27 Oct 2024 21:01:22 -0500
Message-ID: <20241028020131.8031-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: d28b285f-e8d7-42b8-48d7-08dcf6f48a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k+C6WZWTJyWlrrO4XDiVD23UzVuSQ/HrJEB1RYki+/v4cOuSA4MEIfnbu2tN?=
 =?us-ascii?Q?WAomCOi1wNf0rbmgIfTT5OpeiQ65GwWUOc1axI9h0+JqhoXAZBcjLXbPrAzs?=
 =?us-ascii?Q?ULkKBSQ47qXlBSnqKctV3E9qOo62b5qGJbKTDONmmZLtFsk3aC7HxNJNKq4x?=
 =?us-ascii?Q?po9ZK91ZY7Q+Nw8BM9dUGTrGdNPJHU11jrr0qa6qZAAvsMCeivO5tN2SJBZy?=
 =?us-ascii?Q?4El6SLOzZ9MXAJKGHMuMPoE6m5t2BlTj4VHarfEFpTCNwIWnZvDSBipdLkpD?=
 =?us-ascii?Q?LeoSNFN6p2apZmzdB0nS3brkv+4YA0l5+1fGtJOnAvB/9JUS6JLdG5XrUt5x?=
 =?us-ascii?Q?cc9n+yDBWFqHi02KZV711nlSkeyhp2SaGSCEZZRAw6Hswy89VLpK0tk5Tt32?=
 =?us-ascii?Q?OzMBgvWyBFJyB5WSi6kATPF302U4GlQfR334PHS11P7grsj1HpSL6ewqaZq8?=
 =?us-ascii?Q?tLnsfPV4EIfCU/ug0vmeCOPEPVKj6bpcGej4x+kdo874oeKrwui5q1Jev3+1?=
 =?us-ascii?Q?Y0KvjZRBIQ895Zmop2a/NCjszP47W4baLFAtAU47e8/WOdtuh3sa0SVvUWnN?=
 =?us-ascii?Q?8aYLzGcaNlC44sa4FpSEoEzmNEcHxU/5BuWhc6W9nBORvejmxoY0xMuRPQrH?=
 =?us-ascii?Q?6vyruyHiNm7ZfGpSFsDOqFX35JcdLMRyxfOsyhbEOy31++V2GxvYB+IJOM1q?=
 =?us-ascii?Q?KdVKQNomh+l+KoNdp0xsaho014PSn785sY7rGyNIsDbG0OMuiTPaHu1L9VKr?=
 =?us-ascii?Q?8xhiy8NzYri+0KsiaYS1zmZ39cA30XoM/a77O4BjIoac8A8pDsM7uMqxP+XE?=
 =?us-ascii?Q?0q/3b+dgdPxKyk5IjtUvFfRonFe8zFhrcMpLmhBXzEdGi35hKQ+qkLqFimkg?=
 =?us-ascii?Q?if8+mnoFOnvU7X2SAWeaptgU03P0XZe/9Z5uH1CBDAa2ztodgGYUJsi78oz4?=
 =?us-ascii?Q?E4HFox6f5s2/wEiGHWAgXyd1OO0bpPeaEvuLmry5VIYb1guENgCZ8s+eck/5?=
 =?us-ascii?Q?2q4u2XbT4IiX+1E4JcpwudHuieL8qawn90T1LSuA6sl39vSXY9ObyNEQAmhX?=
 =?us-ascii?Q?8uwJnHdnJ7oxMIzh4nQpekmKOzoMaltqmmAyVezxUqcRy1+BBil2xtDxaPTz?=
 =?us-ascii?Q?8zXKTkf5/zbxHcz07nDOrUanKVP2ITgEwMFmtEhPOhz8SRg11nEYIFfYrgtx?=
 =?us-ascii?Q?SeAzvUF0Kq3yBSwsf+4x76l5VWx2S4zrUyD8LSljTlrnonYUH0ggdruomXnQ?=
 =?us-ascii?Q?B0pc1wY863qd8Os5NZcpIGE3m/ezedMb+KsWfip2OZzvAodSgx4EgkRPQJR+?=
 =?us-ascii?Q?oY9sL8fbag8kkmzPDatuKFpxTUHjPY+/eiT+q70ikDtOwy0/4bJxWW0Bkv61?=
 =?us-ascii?Q?a6rUi/dSk6PYIQWhej4sgmkzlzLNEVkbwxTpAGVHDoRWK4mXZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:02:12.9622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d28b285f-e8d7-42b8-48d7-08dcf6f48a2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222

guard(mutex) can be used to automatically release mutexes when going
out of scope.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index c20256bb39579..100d6ffb10cdb 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -186,34 +186,29 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		return -EINVAL;
 	}
 
-	mutex_lock(&profile_lock);
+	guard(mutex)(&profile_lock);
 	/* We can only have one active profile */
-	if (cur_profile) {
-		mutex_unlock(&profile_lock);
+	if (cur_profile)
 		return -EEXIST;
-	}
 
 	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
-	if (err) {
-		mutex_unlock(&profile_lock);
+	if (err)
 		return err;
-	}
 	list_add_tail(&pprof->list, &platform_profile_handler_list);
 
 	cur_profile = pprof;
-	mutex_unlock(&profile_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
 int platform_profile_remove(struct platform_profile_handler *pprof)
 {
+	guard(mutex)(&profile_lock);
+
 	list_del(&pprof->list);
 
 	sysfs_remove_group(acpi_kobj, &platform_profile_group);
-	mutex_lock(&profile_lock);
 	cur_profile = NULL;
-	mutex_unlock(&profile_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
-- 
2.43.0


