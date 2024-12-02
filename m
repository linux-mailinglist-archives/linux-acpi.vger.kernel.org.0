Return-Path: <linux-acpi+bounces-9861-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1849DFA77
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1D428182B
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045AA1FBE85;
	Mon,  2 Dec 2024 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YwI8svyN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5579A1FA15D;
	Mon,  2 Dec 2024 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118722; cv=fail; b=hWrYRJLX9OsQTVBf89lsHbvkVexWl/aX3EUd9UGBx5UrARNjn7lStACtZ0gyfeikGoQ5iV3XO8im2kIZqoNYHU568fZ8qcuUQJe/dGuVYGzdZz9Rc2dBB2qmCaE9B6HqAbJ7Rc8MUz1LEOoy2+jjMmM3YenGMrJnMYepKN+sCiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118722; c=relaxed/simple;
	bh=f+GAxf2ilYPGunufrK0qKluIJjjPc6FBvYYjc4HgZf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Un9ee916qF0fekRyKBK4ht62LGTIgog3hsZZLaP6ElSfCfZ8W6kmaQiARurVfQYZ6hsp0FqZGGWril1Lu5myAAVAJrv32GpHmDghfxSmAJA+LMMcuzkeLxV5mMpP72i1I+tvsW4Z6I0rZ/N0tQLLj5pWtX244qYN0uf50bePlws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YwI8svyN; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUHVSxMF+jCb/TeuDJxGMmfwDLCbMyZo0VX1z15RI5WsAJ2Rt9aGtwxjUEkAL0tWNNCVpGOwKbTm/4BzuI4Sj+eqTrFjhI9VuHK5A8fqEP+iQbI6RgyzCjJSpFf+opixm6MJP60++W8Yytb99ATNp5yvr3uga9vqqzaVlitMDlmqBBUEWW49STUVU9AbtZokLYGdPwbhxwhwUA97en+DQ0cKrhFzFNH/wt2CePt2VJD0WvGtZAmPC7Z+ekZ/fwpIhbOhRDsXo/B6eSGgugXPaA8r60eVBtCo2UXP0BAcsLHgSjKONk7zdTXDaIFI6i8u7SYwbz8ozf8uCwprrCvXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJM86/5fT/kTWIaWTa20k/1Hba2Jgn8oT1io5vhyWVs=;
 b=ldsYRu1gtMuyfBZpuB1ckVzl6blXEcAP12semlurAO1HHgRz6+AyH3kj0++/QYbkuHhSliG38cGV5fwAUcq4Cv4qFy1J0FQgjqM42SBVdccmX62GYyF78aeqhYRTEHIz/td0lD6EreDNyG+DQ96xqPnUAy7xyNcMz9A/rNgA50wnoehMV4Xnzcx0rmr5/WWGo6BUL/PamVZf1As1zgLsrkrRdnKTL5rmExhAhYFzw2AsSUhmCIHRjfvUKHoLHzTShNA2fpMBPoFSDDjwg9l4MF5wXzT/kknW61jblEMP/AjZx58adA7ZlrY5NymOtIK696bON36MXxl32tE98DQ4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJM86/5fT/kTWIaWTa20k/1Hba2Jgn8oT1io5vhyWVs=;
 b=YwI8svyNkld8aEqgcG4Gob4jAAa/0LcmBPcG3phL3F+2y1xqGYxwga/BKbSrdQWMN+dYxKBAhMdTSosRsEmy2IFEq7kDASfE4JfumH1aQru5A8H9AcHYTWFL4OACzGSmvzyJFrt6Xw2AeqwMHjgzy0XVQ+N0lLBPvU3S0w/IQOw=
Received: from CH2PR17CA0004.namprd17.prod.outlook.com (2603:10b6:610:53::14)
 by PH8PR12MB8606.namprd12.prod.outlook.com (2603:10b6:510:1ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 05:51:57 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::7b) by CH2PR17CA0004.outlook.office365.com
 (2603:10b6:610:53::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 05:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:57 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:54 -0600
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
Subject: [PATCH v9 16/22] ACPI: platform_profile: Add concept of a "custom" profile
Date: Sun, 1 Dec 2024 23:50:25 -0600
Message-ID: <20241202055031.8038-17-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|PH8PR12MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: db90c848-16bf-4013-0bb8-08dd12956ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7bihjDCb5+0XAmbm/JDiEUCdW5sdCPSap7R4lfwLTPzPYQWCHHoxLaxKuSro?=
 =?us-ascii?Q?rS11zrR2dhj0QDZT0GTrtMd3I3pPKTg6U/SLlXHr7suM1G77bKTdqErp0+WU?=
 =?us-ascii?Q?Ou0/YfXAQplO6AUwX6fVMQJ7+tYt1Zz8vh7BFN+IhX4vQcwa9UCi3f3Q8b2y?=
 =?us-ascii?Q?qJlHD4KD5jyU1sQfvaUX69AN8vME1sQbNKole5Pl/rISpv3UltPBVKxRjJ+a?=
 =?us-ascii?Q?yGNm12SJaQdIWqnOMOJENFPCIU+uYg2zQKmd+Xhf+nObkVVKE0qsnWMLiyfR?=
 =?us-ascii?Q?dkrh2OdPC4YVoracWyvvaWJlvHL5K8qxLisQYnE5iX3bGG1x783Pp88+zh3e?=
 =?us-ascii?Q?UYnKbs05ewwzY0c5pRQUy6X8br0wfrZWgcY7+wxqCJzt+UBrIz4InbmVHjUT?=
 =?us-ascii?Q?DH/C7t8TSgVAxF/L7VNku+oF7qsOU1fjfVQ/ruanGnIKX+P0miosbQNcxpmG?=
 =?us-ascii?Q?0Z+9n5d/EbEABzNlSHqzMuOtiMZsabq0SctgzOAFbpc0q/2GYkmUSgZB33C+?=
 =?us-ascii?Q?pPXy0Kty59gFN0cZjaTSvra8uFOW3674f0ldHZvu22d6rwCOS68Tr+/e7AbM?=
 =?us-ascii?Q?dk4CSiNjIWkt7Dmzau7ERlFCFhiRNKiDIwRn61bVY+OmmFkGzS9uB7n2Fh59?=
 =?us-ascii?Q?PPWfDxEmZanBmMp2TzBDR4RkgXwG1o3NAJBHCpl7758oTk3LTCcPHusJAcui?=
 =?us-ascii?Q?w1s/WVVyMLIsXMNAyfOnA3/SEH1ndnJLseX+LBbO74IewMH6ECr7BQ3i0TJH?=
 =?us-ascii?Q?yKHiF6ThblPQdbfvmYaoXoenoY+mzdh7gSWBlbIqLDiLsS6SP1gw+XVwLcRT?=
 =?us-ascii?Q?unJNAdIt8jBUM91WuspuI8isjRpDBgttMuxZ0Ov4dd8387q7rZGpcRKvbTsz?=
 =?us-ascii?Q?6hN+3dcyHzc2I+3lUsF3xmBtS1Y6Qpuhy7Qv7c1iqgD+s5GsoVPHywNMQEFE?=
 =?us-ascii?Q?Ev+Rfs1yXuZ1GU/fAytkSCc81tILhV9UK2jjI0+V5g3ZcxDP05ymzPbrlDaR?=
 =?us-ascii?Q?lxyA3DFOt7QR75KCwPFUEb6zfB9aSCwf7HoVs39RFyfcH73kPBz+fcaTjbAE?=
 =?us-ascii?Q?D8iyEheP2EWZcqoO5DeN+UwVbVwVsN1enSZyH89bJYXtH9OA8nn/Frod8vSe?=
 =?us-ascii?Q?hgQLcDLNMIzg4j/DcRAKvOruCgVW+y7SePOKT689BD19SiuF//FpQKcqnZNR?=
 =?us-ascii?Q?bJUG92doO+w66KyGhCkMEOHrGyf6IUSK+i3nx0ZkBaVMpxOiaxa736nvnCKi?=
 =?us-ascii?Q?Sin0SaRzcQmhFwEKkLmpn7norrS8cWIJGNurcqSrbgZ9bNaQjFkB6B87x3tc?=
 =?us-ascii?Q?0B0TlM6yw3rzHGlVO3nvKA0/d00Kuti9vdAEe43IfsLxn0jD3idBJ78y29PS?=
 =?us-ascii?Q?xxB8RG9EkVsbxr/xeLnOYMPRsCwrF28XUE99H5QAx8ku0PuWwK1GJHUytQS7?=
 =?us-ascii?Q?81qo17g//QIEm1RKfOLRTf6YDpncrcoP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:57.1540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db90c848-16bf-4013-0bb8-08dd12956ea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8606

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


