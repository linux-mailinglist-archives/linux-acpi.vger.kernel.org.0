Return-Path: <linux-acpi+bounces-9474-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E89C2A07
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296DA281901
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75F217E01B;
	Sat,  9 Nov 2024 04:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R/HAukMK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5E170A26;
	Sat,  9 Nov 2024 04:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127376; cv=fail; b=udqphD0jc301r5R9hRJ3MQlu0kvQGcvbmrTeTdRwkf00A3Z3Gi0aFjfxZTT+jS1ZQ+xNSxIYS/Q9jTppF5j4PRznFVGCTQO6Lk98sYFudLqsUt2XZ+CxXMu1ArGstvAk/KD5l3O75R/RXPNDBSk/DSqU8+tpPt0KE+5Min/pCDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127376; c=relaxed/simple;
	bh=5ok8HyywPi7zBzNVKuFwEwwp0ngJF6+GHEz3IGeEUe0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I38oA6RgOvKk6DjnxU0Jy7sXwE+Ng+EgPjdmJ24mPoIrhW6YxKmgVm7hNMFXB8FYUsenIJNxtmjY71i5MoaACNCn60OO+cKpHkFq66pSGktis1/5FP14y4Hd2fL2d5z7cx+2CTxKXqhPAlT6rPhlUvBBn9kYUeJ4fEfy7qgICvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R/HAukMK; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSVx/1ITDrE1/AlpUpC5FmCBDcUGVT0eHqqDKhfwOi51U6kOUPHvJ7luV2n0wB+s8Ydup2FE8PiK9jAX0J8XqlcZOAhzdxgzgxx/AkdH/9+bR4hDro0A3peiarY3H+z4jxDn3z8xpDLbehX1tNppf704aogse9/qc2EGseD1WzABdCj8b3zMIa0CR9LXKSSkbbYAeVmWWc21g+CUpCuOoi85wfZfqKB+F8DEhn4+/bVhL1ca2gT34hWyx87nlROfHoml25Xfzc8RiGYy1vk2LDkRAWEPVXkJejxZe71bnw6l8AJGCmkb4FITaUAA/LGoa3ETmzAvC+vIrwERtCrT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsZMqzt8tT5M++EZAQxlGMoBZHQY/vNLsNUz9A427kY=;
 b=eCtUhYFzpD8QCORZSJ40cgpUGNlDRY7TtQ0w2qr46837yiUB/vX5VRlOLaTdrNS4QccnQVlheLl0R9AYSCNCMzkLf1/wLxs9leKy0NW+9FjmlUFhTMr2E6aWRSR1K2ERNuHuKK5ylbYjTilRNJ3cvjvVexjRSMM4xMWIv54V+zBQ0BEhuHPkWkzA+CK01S9vqdYhL62uJ3ouU6B29jGDK5Kq8xNsMZG49qC7P2rGo6deGITMFEG5bZmbqbDUtTbiucopAda3sBAezVlmjqscBroMjSuH+HBIKSeEbd2n0vsc7qY9F8KmS+YpX564x51HOUpBvZOELFzj+MFA77//wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsZMqzt8tT5M++EZAQxlGMoBZHQY/vNLsNUz9A427kY=;
 b=R/HAukMKRqrU9gOw+gI+G6DmQ22MZCue1U6iNTN42P8oZlfwKql9FykT3QbtUwRLUGMo0In5RgyEA1+DgpcLsa9vYXLVrj5kSfb2FahOLcRPEtaZFnPmIEdPaNgmHK+0lNr9N7h8MMrdvHdnauDGsELYSTdf3+rwJk9lAOuLMfE=
Received: from SN7PR04CA0221.namprd04.prod.outlook.com (2603:10b6:806:127::16)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Sat, 9 Nov
 2024 04:42:52 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::50) by SN7PR04CA0221.outlook.office365.com
 (2603:10b6:806:127::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:51 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:49 -0600
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
Subject: [PATCH v6 16/22] ACPI: platform_profile: Add concept of a "custom" profile
Date: Fri, 8 Nov 2024 22:41:45 -0600
Message-ID: <20241109044151.29804-17-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb677c8-6cc7-4af2-ef59-08dd0078f86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CtvBREi1Y3UhqYbnEUAWdz+YwZY6sUjVsdblJXD1YpsPGD6xmK0qQiPHVzPv?=
 =?us-ascii?Q?JIPU02oLt5lHkLn664FW88QeWU0OFAJTZL8YWRHSWJjrQrTHZEwIQGU8TYgW?=
 =?us-ascii?Q?ulHOgN5lOsc5f8PMI7OZHZFoQL9Kc1+lQgSIoNJS4FcLZzNJuWXaUwLk+bdZ?=
 =?us-ascii?Q?hOnwUp/ZLqZD8vc5l70afUigr9Hb8TepsiqaaH4xuf/CNRq6PzTTNyOoIQZD?=
 =?us-ascii?Q?FZW8V3BuqaCMMsmKAZbmvAnD2DRfSsWi9tXiPGBsY9f57KqSzrSl6Xy1rrSc?=
 =?us-ascii?Q?d/crrAjEJa2+a8W9IuH0jVBobYMvhcXOI6TID1DQ23JKIJY64vM9xz+G9AnQ?=
 =?us-ascii?Q?6TJyx4EGdKkmJmGVjrEDUrPs/xCv7cczBDk4XTSuLucfIjlMHrF0DrZ1S2TU?=
 =?us-ascii?Q?x16lupM2HQuVXjO6owE2XBN5EpB4BdeEW+q6Oi/nX6BaQA07y+LN+D9NI2ho?=
 =?us-ascii?Q?8hW3pZAY4P+z56LSEhG+lTYoLDqg7C//TVnXiuj4nZWMgBw3WDySr548irVq?=
 =?us-ascii?Q?0A9KOMAIGIYPUjXTANcxIZJiYexrmly8ezUGVIqNEg1K/ujjQP9Ecx37oHBB?=
 =?us-ascii?Q?j47toEyX09eIu7DUvk/ynB14Sv396M6jPFbwEZH69x7KEHjcTeBc1zzde4Xa?=
 =?us-ascii?Q?wvGAu6zuFwgSEV1y6XDRhgfdfZFZALoYrTGShHcrqAxOXLx5yE739frmLVG6?=
 =?us-ascii?Q?ig+48V31Y2p2OhhXG6y47y6fYjJj9ZbGTP+ecb8R/4X/4hnnzzMhUjRBl0VK?=
 =?us-ascii?Q?4cdmxLAkLS9W7U8R+cIwRuA8kF+BhRC2469n6dWb598OmCE2XeXIWryGlj5i?=
 =?us-ascii?Q?6piH/mct2HA/z1VAdF8nnXn3fkZ37LJBNpQToMOMdPnotKY0IPQgBlMmFOgE?=
 =?us-ascii?Q?Nko98vfKIszm1LVu49MziwPNRr8dK7rt8E3KX/pyI0eBsKM/jpG545o86msL?=
 =?us-ascii?Q?EZeekz0aZ0pSG2U2jjcWm84rktyinBrEmnLVH52sTWqVVQNT5zqLssunCpbF?=
 =?us-ascii?Q?Oie1xgrgB6YPrCVLXc8+R/Ljudbbp78AKyJzkf3Dx6iWDp8pK1WpsnO6hGtK?=
 =?us-ascii?Q?68T4ynlHyh972R+pZyKim0Ch8XZKGE3apEQyDzparOTE4JWBEyYJ4Cp4fZGU?=
 =?us-ascii?Q?8EqU8itN90vfCbknRuLhamibmRZF2sNF67eZXzX80SVMNfkVNeBjyPkKatzO?=
 =?us-ascii?Q?HLCv/SyKREKA+pz6pZEVnC0Urn0N1M6Ub2RP2ywOibz1axYdETPG7kTfPx1O?=
 =?us-ascii?Q?VH8CEf6YBkK0oQDKKiJjnknZmCWtSGgcLJnheRrTBMyCWARo/OmHssPZW24Q?=
 =?us-ascii?Q?4sc/WS5D7S2IChpKpVYD00uTv9VugUJzvg3xfRSo/OzpZv1buj8B28zIidz1?=
 =?us-ascii?Q?2Kr82Bp2CyvlrhzLTHLkCRyC8LXo3fa8SkSdgxeioGu3UH6jcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:51.8723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb677c8-6cc7-4af2-ef59-08dd0078f86c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671

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
index c4e2c75116988..089ac73b3ec97 100644
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


