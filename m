Return-Path: <linux-acpi+bounces-9176-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD829B73AD
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439561F24F83
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C995145A05;
	Thu, 31 Oct 2024 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ev1oKIih"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD413E03A;
	Thu, 31 Oct 2024 04:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347882; cv=fail; b=HixHh113DsFrptCPOU3zZb4BsMbN6yu9FRYWZUraer/sDYFXtCMx/4fufGF67DQ9UjIkxzwmbKUK5jss9bRswGrWrLreYt7uURUNT656emPq9hZJKTxh6Cc/2MHlAvSWYWiiktOrywKmTGp3HvwqMtouS3bHWxEFFfurXlNAotM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347882; c=relaxed/simple;
	bh=FGMZ2R/7poj/mINnOz6nbRH87uy6ciuIa8LOGQcLobs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bn672iiOd4LY6BoS35UvkkfU3/hwoaAf8fu2CT4VpUgjKQ0YERGZftGLLW9SjFoThqb2Aw3th5AD+MkIr/+lBQvEZ0mrhsn0lEahLGuxblVxsMe5VhSMncTZdlO/04pZ7hye+sRAQN5jWpttQWXABpq65xIOaqxE/n4l8tt2AAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ev1oKIih; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2cAkzE7VP7OwFCw8cUBLDx1LqCqMqxvq9q69yq/7deHpHaaLYSmXGB4NA36rprkBXDeYVxtgkdlMRRkbKXgxpuuUYnlb8KKxhxdSq+rA2R7dj64MTouwxNVH1dRMOiHOgfdZ+N6MS6k9pfpRQQkpQe80Q86GIAg8zwdP1A6BqG1/5LTX45OnPG+5Ao0r1OlHiMDYbIH+otbafXxybHKUOPG/ZhBADYA1d2mmJAMpPduuHBRtEcZrBMCa0zCA6XWXrxq6pnEqwELix05F/ldDYsv7wZtbl9zaO5Kuw2R3gLaVPfIBzCX2n2l735oGph6MMPPPxEiorYpWRAcUFO0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqhdUL5T+XIdKvYZ5ARQFgfkK5iJmpT73Z6Z8A1LXxY=;
 b=rmCkR+z9hy56W96XOla2GrGU77KCGahX3pyeAnLMv92fp89UgUYzPOkh5I/ZpDZM3Vd19i+WkfQYs3tbBst4vjh+dvd1yqT6IckFDINIeic5ldyVdQ6YT1YGXuGu4JgoRaVagKS/FnPN1M5yH9CgFIRvPa2m2LRYBte3SrhY8U5sH/6Bzno0LP+TuDDnLA/mOadnQ59k+fj2skId8f6Eu3098v1n9Q539GZG/qCv3fG/p+4JFDoPmrRrvntEAiJS09mrzkrTBa1zogc4S8+IC8L5Ap0iqfNwQqIA1hB/Lu+YzHMPX6gnMnI4CzZT+geYOScq5S65u+weE8OXNx814w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqhdUL5T+XIdKvYZ5ARQFgfkK5iJmpT73Z6Z8A1LXxY=;
 b=ev1oKIihS+4hFOkSw4f1ccWjxXD2E8uHpB6vgSaGTTtLG0IAOv7Y+Fe+tGWy8/QSTq3ChkVdawHifVsOn+aPXZyDNisG8t2WJO0g7RtdL6QWta6Q5r6werG7es8P+8Ncv5emufoRZfYX1MpF/Il0Vmv0q3B+TYMvpaL9TSbl/Jk=
Received: from DS7PR03CA0344.namprd03.prod.outlook.com (2603:10b6:8:55::28) by
 DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Thu, 31 Oct 2024 04:11:18 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::ff) by DS7PR03CA0344.outlook.office365.com
 (2603:10b6:8:55::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Thu, 31 Oct 2024 04:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:11:18 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:11:16 -0500
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
Subject: [PATCH v3 17/22] ACPI: platform_profile: Add concept of a "custom" profile
Date: Wed, 30 Oct 2024 23:09:47 -0500
Message-ID: <20241031040952.109057-18-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 197942c1-f4c6-43a7-5d60-08dcf96211f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SIWPB7jZfpQ1t874sjVzkzvDIRr5A3PDvrRxZnx2rwhdExWCxmH/iSxnJg1O?=
 =?us-ascii?Q?t01CKPtDUVAKeqdpc/Rx/X4ZIDjLTDh2ZDMBpHmun2fAYKhKb5xhUZrRcErC?=
 =?us-ascii?Q?VlspuPc/VEghEQlHPgdbX631fI7I4rINhJCfPHp5L6/jejobRwfAdHb9IeuS?=
 =?us-ascii?Q?nqEoMjKLi4//yrXhxzE6Od5iR/3kZqTJho67ZWQKK9lj6128n6JBzRjie9x9?=
 =?us-ascii?Q?aDmQaDdSGmc/mUlefeEQZ7G5VmteZBuDKU/7y3gyg7bOEGDHU2czuKIr06cp?=
 =?us-ascii?Q?wVyaynWkyfXowV3jDtLzXK7G0tFwgf7vtsLHsuw0vQEl8jZyFHCll47U3AoR?=
 =?us-ascii?Q?lpQ0lwKa4xwP4iVSxfFwzmlwCY8zaOBvo1tqz1irEKWQYGlL6IGfpfnn8+nk?=
 =?us-ascii?Q?mgjrsRv+9r1HYPetEr0PmIN3+02TpM/g8rulMeFNfJ1FOLQO+a6Ox4qy9hkC?=
 =?us-ascii?Q?dwGIs5KeTFrW9bpZJcQm1sjjodmEuxnLkP+xojx26cqpDeosMtW924HUW8CL?=
 =?us-ascii?Q?zVk0yWWh433s4CN5FPgGLxb4jpQAxydoCWBHxSOlY/VDfWlPMJ8zjMtBRbPK?=
 =?us-ascii?Q?+Ed9VoLibDjWwtF2/Q5TfOPDDiVdQnNN/3xR4z1onaUqHIY+5Iey7ubZMeki?=
 =?us-ascii?Q?zpv0ivtofKvAN7GqkRGb/d7RpZTu9yUdzDp16Sh1cI5IlkKtXYvT3nMd5CPL?=
 =?us-ascii?Q?2t2QRsIMsvBre8l0ExuL38c5k2+6LHYTEW9EdOHOmxiVrw/GktctglUNqqgq?=
 =?us-ascii?Q?xLKiYq5yanRc/oZWJIS1RDq3OXJt5tMNfpWQ8qdNoNbp4jq91O6i9e3F2ROh?=
 =?us-ascii?Q?Vz0TcyOgp7TNTUqAxGmMYRbYmbvEhtprLMJfGi2YxdMtQmCp/4KidvLBJxjh?=
 =?us-ascii?Q?zOB753UqaaPw5ngTUBLSbJvmrLUB0zG9rgS5keawfUBAQN7oouTrF+zzwFhD?=
 =?us-ascii?Q?pGTJYmLVT0tYSaXo54LMFDFx1MX/p1XJyutSEVh6CZDpl6dT4JIVurhaR+OU?=
 =?us-ascii?Q?HL4YPGN1/KPnYEhBoN4IoHVh8S1ah4mknCU7pMS5yXbWkP+USxG9w8iUJB87?=
 =?us-ascii?Q?55GYjRvjd0jNqCClGOYefM0setrXIRMLFtC1gvlqqLM5G9jx1F1Gx2vzzVZU?=
 =?us-ascii?Q?BjZEZyp3rPpTuywgcGg+xexjC9hmCtO4WgDy8tkO+aeRTo0p3x33SbeXEQKQ?=
 =?us-ascii?Q?iWOj285kWXFy61MRatBqk+fd5MffOker6Sa5LYyBRx+TmfBROleCOp6q/AFu?=
 =?us-ascii?Q?VItvc985zOO0Gp47q4qOBRsxXDCPZPm+gIwxz502GXbtHCYEGgccUk7iaMMy?=
 =?us-ascii?Q?GDBLS12JiEiK5+vdu7a3BPnrUKGpvHvPqAwkfAU6wZro4B3qMUAW+5O9CufK?=
 =?us-ascii?Q?zR+D0LvmrWok24kDn9zgFxK1urUmGEcfPGeQ+LlbI8EIQRpdaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:11:18.1125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197942c1-f4c6-43a7-5d60-08dcf96211f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938

When two profile handlers don't agree on the current profile it's ambiguous
what to show to the legacy sysfs interface.

Add a "custom" profile string that userspace will be able to distinguish
this situation when using the legacy sysfs interface.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c  | 1 +
 include/linux/platform_profile.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index c2bb325ba531c..3128bd16615b6 100644
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
index 6aad98f4abaf4..da009c8a402c9 100644
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


