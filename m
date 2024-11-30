Return-Path: <linux-acpi+bounces-9814-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B99DF0D2
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607D3B2267F
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2E91AB6C1;
	Sat, 30 Nov 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S3F5vUoW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAEE1AAE37;
	Sat, 30 Nov 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975558; cv=fail; b=FAxKDvRvR8XREaYA4Y4sJqvtSkaCVK0+aaWwbKljVtHi7vGzUTZDAtZr3xek6yex/HrqN6tW8flD1F7XZu0OEjuGw33sNVO/aANDGDxj2dZEejxkubFhHEWiChza/8x3VXgztcroLWUtR+6OmIcyvlTT44+yh1HdiIimFgLGRes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975558; c=relaxed/simple;
	bh=wmdPWQqIJG/NThga/EvctX/BUlGiwWiYT2gh2w6KJCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFZJDiKw5SoYkQUuB07yjNrnzu5iT2r5svm8aFmLi6qzM/+PziR/rHTRdXR0V9IFwgF0oIzInITIDBEsb1+DFT5f8dWNzP/n9Oe6AO0r6bqPm3JA0a3PmET4+otrxBK9QReFIO4UKNL8jZA8HJucJJq3Ws/nEuFO1ngRr6l8isE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S3F5vUoW; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJs9LuA+VrrirYaPvLThjbQz0Z++3Tq4E1WHCyPQgZHzrwZ+CDpdPNjrnQK5xP050J4Pzrz2UQecOVd2zlwY10eRfGNS48Her4K/JTwEcwaXFjn41eiApe93wf1uUUQvAd51mdcu5uvmooeJVZpYu2VoBnBr5DWNQiUT4xDFuAykhXoB0GFgSQfRTPiSmPrg38aZcjSVQqfAn8HgqdRy9t/3+B3KThrq15BYCHWQcmnvM+MAVGlGsdnQ4lfrzStDBig+oKSCUqD1u7UR8rNvstoug2sVlO2d58b2/vP48zIeqxcYVVgMVWkoof1i9eFCcHksFRKr0D76RFx8q8WBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52hZzlVsBau/wCrbXAcGrGvAfqAMPX2AQWVoJTndIdU=;
 b=iS2rCM1ewFdzlLYuX5T3enSAR/Z+zgNm4uJvcEwR00AutQSv9Vbv22tNrl41aRrBs08x3MlExOlJPYIzpp8EFOesQF0qHV0xFxOh9ofvcFIIu8kjeowCJX92KuhT+/7hYZeYZ5qekukDKk8O1AS8Y6uu0dHQBJrUQYjRPFTvc2pBjpI751WJa6fmZrUN16Ku0xQyu8/FBh0jWvUce5ksDmMXAAE1Y79rkcP98ZLvHLyfjA+Wwu4mYKcglIaDYdVK6Exq9HY+TnmRehfh0svcdH5hoMTIP5Ufsay3/0DCUYJHJ/30aub7gi9eqolwL13DnBPP1xvWVa5iSPTLo+a0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52hZzlVsBau/wCrbXAcGrGvAfqAMPX2AQWVoJTndIdU=;
 b=S3F5vUoW6YJPqKM/uPLpP1fSFsnT2KqEB/Bpqil76dZhDxk9JoWOZlq5wjTMcz0fL0Eoxy4MadkV/xecZhrW08HWM5xWORkQ3aln20JdqhUp6AF2ettIjLrJRs0Pfecrpm7IihqHzA0sZrovQyHsGDRyLmVhwESo9MUNeXG46ZE=
Received: from PH0PR07CA0048.namprd07.prod.outlook.com (2603:10b6:510:e::23)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sat, 30 Nov
 2024 14:05:51 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::33) by PH0PR07CA0048.outlook.office365.com
 (2603:10b6:510:e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Sat,
 30 Nov 2024 14:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:50 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:47 -0600
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
Subject: [PATCH v8 14/22] ACPI: platform_profile: Notify change events on register and unregister
Date: Sat, 30 Nov 2024 08:04:46 -0600
Message-ID: <20241130140454.455-15-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c916f69-9aee-4809-40fb-08dd1148189a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dxbw7dgsuKQ/p6uiyG0Kr5xRpMRsC4l0ugBEKoqa9bf1AQY/UkUV2F+Twk0y?=
 =?us-ascii?Q?q0rHikIgL1DlhAKB9ijw5U/eFM/tOFoy7g2aCloDQ3/GvBR1DL5tYEh//OF2?=
 =?us-ascii?Q?232mp2qj40bIfx/JgbtPP+eUgCgs74uVlHg+ae6o31f5tP9Fu79TBfqviK/a?=
 =?us-ascii?Q?CPGC7bg2/nsuQxe6bVVFDWX631HmEsZljUhJDd+iuNYA7ozJlYUpLd4PzzKr?=
 =?us-ascii?Q?r6gmF7Ly1CEnA0ZkepfYVf8wK5Km1EU9SUezBRCU6wrBdIGYVKaNDm5LRpNw?=
 =?us-ascii?Q?PoX0o1XXFCQom/KxJjyA1F/UYw9eBz8kcPZPVG5CPiZqEto3V+JzIvSE4xY+?=
 =?us-ascii?Q?8mrCc9zJ/gbQmc/FPKQK8niG59vEXCx4d8zpOl1prjBlP3hHFEMIU0+M+pTc?=
 =?us-ascii?Q?nuDbnWbCThVeyg/E238v+33iIUw4DULUbo0+Zajp2osnwMbXXNhm0jhTHJPX?=
 =?us-ascii?Q?oFfIbez+esMjERMAGn7q8Ze/UmmWJP8qLUI8SDTnYf4Q757OAwo1qi2EVxbI?=
 =?us-ascii?Q?ZUoLOD/crodnmPHlQKnfc8266woJePLP16sO1Mj0OFXE+MF9El1BkJrNdfvK?=
 =?us-ascii?Q?W+uu7S+nSNmGn/yFZYev6gvQRX/U9l62VpqJI5BzySLkjUhkxiX0PuZazUNq?=
 =?us-ascii?Q?LzGATb8Ag5EMpiEECKILMVFEs5qzjvwEZsJtL/RvNzBEz5wsHsUh5P0htF5L?=
 =?us-ascii?Q?WbUj/YjcTzq1++PCmOTF+dwMrdt9Oe79pS8o3TSi3ZlUo2ItEuZXb+0DploW?=
 =?us-ascii?Q?nHuSkTjgw1T7KMacy1xASRTvQoKMDa8Xv0BVBKk9T0Oro1edYb9UXruu6JXP?=
 =?us-ascii?Q?Jk30AMjdam5jp/qbNOsceYe+NB1g+wWFUpgHVDqhll1Q1QbRhiVf96dbUSre?=
 =?us-ascii?Q?lAosVzLupdXTwC8gCKwA5GqrMJcBOfJKTkKkdM0yLaSZDgWSjKjl2BiJ+wuI?=
 =?us-ascii?Q?Q7EWhsHoygp3qVASbjQEZrFpxTG0mnI4HvKF3cAVnkQQUM8ir2CuBPK6nhZ9?=
 =?us-ascii?Q?ozqnwX0c7BRxsearqDthInpfTS4jtnU08t1QQvcDN1PRFAMsq/EpqlxtfmYe?=
 =?us-ascii?Q?d5KN1F+HmKR4gWgQuEiM10KL1rlXCMObuqqDdXp3oBJYFV9Y9DbvMgUShgsr?=
 =?us-ascii?Q?lEvJNsDktgE9IgvPm4No4o/Jcn2STOafLaN3sj07srSQrYHfoC6Sw9yXqZ/y?=
 =?us-ascii?Q?9Yyvq2iQx08u9MLPhpU1rifrVY1fj3ToVzbE3w7+y6lqH8ys1y9svyr63eIa?=
 =?us-ascii?Q?c4en3aZr2JDxTh46ArC4t70B8rVCURYeR5NW+zNM5/Az+w81HfAjohR+43mj?=
 =?us-ascii?Q?cCASKtKdUrHgJn3H8gHnXWwrrRpiNcrbobHJO82RjJMbMwNZ20OzjB8hk0Xx?=
 =?us-ascii?Q?RbHGQfE9wLaVGgaCjnxQ7R0k2DfXPxZ3ymIrB3B0ZuDnd3dULdgpKINdNsWt?=
 =?us-ascii?Q?8fcoWrXs7x5kIvzasnDd7SJwrdivrvtq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:50.2839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c916f69-9aee-4809-40fb-08dd1148189a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848

As multiple platform profile handlers may come and go, send a notification
to userspace each time that a platform profile handler is registered or
unregistered.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index dbb6428de3ad7..e93b79f654955 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -362,6 +362,8 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		goto cleanup_ida;
 	}
 
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	cur_profile = pprof;
 
 	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
@@ -392,6 +394,8 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	device_unregister(pprof->class_dev);
 	ida_free(&platform_profile_ida, id);
 
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	sysfs_update_group(acpi_kobj, &platform_profile_group);
 
 	return 0;
-- 
2.43.0


