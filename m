Return-Path: <linux-acpi+bounces-9472-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 581249C2A03
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187402846E1
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B099F16C6A7;
	Sat,  9 Nov 2024 04:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r+Cwx6rO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C8715B102;
	Sat,  9 Nov 2024 04:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127374; cv=fail; b=eVOULfOzUKjA9eoTpB4oSAWs5lX9kWtW57Zoi+hyq0ZQ2HufqEvz0e7kz8ujDxkD6L3SB9oEXWOMvGMbaY4BoyX47SlK+YNEoBm6Fpf3jZGS6Jgtugm83D/rhDi9tctpcF2c/5WBCXINVJMBjL6XQ41FijLz6Xo5ES+C+yMfkzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127374; c=relaxed/simple;
	bh=R/D0pZCX7xPWmwET/WRTWsCIwAuy4oYe3zFjmaYpqb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1N3kRcPl52itzvHZOOBhu0il/qIhp+qAKMC/4IXArb5rDHw/g6mOcRf6WQLdJ82e9vX61ymW/87grLy9aYrmXNChhvW9lO7pKgYfQp2T4vyCcB7Ly2GgD0G6edGoWxklddZCdZ4W4hCoTvUAwJC/rmEEpfNpOyUjqylPZWSxE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r+Cwx6rO; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpaK3KDLN8+jCnHsIDUw+fcxr2D8WFpP1vGesAA3Qmr76cieru50icBcWUGJUh4kseKcSUZ2udlMr8l6QXwuDRRDT2HH2siEHio0rc5p6DNgagVdcwfhM+/yxrYKWVB0K3hQuOUOiI6QOwv8ThhcZpwRavycZ0gaiGx5YhjL2LsE/JNFN2QTNMG5ocqX0tWUw+iMhKAOIT6j4p907i3cATFl2jcm7S1RJog7b7CnAsmdehZ3UbPJ4x9tApIjvfjnPmyp+RDmlGFqH3B0PbaDL0o/VejWEJtM3vp5qqSdULUG6Fc/9CYuT4l2QCdjNr3E6Y8AbF7QUHQC/+SvT6T43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdoBQmoVGQvItmMMHUhxb3OZe7hpOCSc1K41jQ3+6bo=;
 b=Ty2D1oFoFhpX08KzpBxSsbXPiQoNH5WmRq8CfOlNT2uBTc8nGAhLvvwgN5Z6UWzf6A2k0XXJmlwF9DHIiz/2TUS0r3oZSzafEBmHUtjd9Y6buyssdJ+LTsyaswD3qAWV31gcheXU3LB94cmOgmCG7pbobU2feHwuOptleufQKJtBbmtOBu9FTkNzmTENpcLpcCGRHCTd6JyNQqJZUdmFJXDQHIj8Yfn/LnwkhS1P/zHoMBN1x8hFjy6c78W4e9oWu/MswwIt2EPRFAljgHPyWC6U8wZjqDZVFLKbii8jpUQ0uA+PVV2AISAZ+xGuWqYeFQQxfESL3iudD/qEJ6MDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdoBQmoVGQvItmMMHUhxb3OZe7hpOCSc1K41jQ3+6bo=;
 b=r+Cwx6rOQSl3AaJCmRAo4tWW3t/vMmLgukU6weqJCkrjNcY/xixgdu4m8KWXHiuAekwGfsK8okNPvnif9s7zOfhg2dzieraWGwqjlTBQLP/ELaSE/XWE6DSiOvY3O+pW/l1RexeO339xOM+UOMm4Ft9g25E0xeO9l6eXRPfByss=
Received: from SN6PR05CA0007.namprd05.prod.outlook.com (2603:10b6:805:de::20)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Sat, 9 Nov
 2024 04:42:48 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::fc) by SN6PR05CA0007.outlook.office365.com
 (2603:10b6:805:de::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.11 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:48 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:46 -0600
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
Subject: [PATCH v6 14/22] ACPI: platform_profile: Notify change events on register and unregister
Date: Fri, 8 Nov 2024 22:41:43 -0600
Message-ID: <20241109044151.29804-15-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SN7PR12MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: da628f72-8d43-43e2-4d31-08dd0078f65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/h0K4Kd88hAExOdDhKPS5aw4QPhJKrLajpa9R23ResBTTgEfaQgfx6T5+Mdg?=
 =?us-ascii?Q?lTIQVricVab9DJ3jRFk0LIaA8lAya3lc8cbMyJT6KJ0qzHj1TgNHX0xKwAlh?=
 =?us-ascii?Q?eGDUTpmx+PjGI2pWiiA04nQHc43lQVwvoBKEA/o8p8sSiVn3n7MSgViRlIzv?=
 =?us-ascii?Q?ug3m4iUnrVLzlKpzwnYYd7f3ulTf6V0ALOT7Zp7CQ+i0vOi7TlNbruDFl0Yg?=
 =?us-ascii?Q?HeBeIHjwzs2kHFbblRaHarkOAeLPXua2qm9GK7gs/gQ6+TYx+nJe9zbiqVRa?=
 =?us-ascii?Q?OEm7N/OKENckPe6A1iMitNcU/2E6EjUeuHu1qULyjrHqlgDGDDqYC2gBhaXd?=
 =?us-ascii?Q?OsxJjhjCEyY6Hp2X5QPPwgJJKWUN4hFQVPISwvYmRvko03I7l8JqSDvFT1bc?=
 =?us-ascii?Q?C3IkwjxtrCwJOv50/DXPYi60ar7xYLK8GDhAPM2nLofLqNF6/uuMaeSBsE+w?=
 =?us-ascii?Q?3Q+UPe2pWL8IOXl7W4g061PpGKK01aziqekgIVo/P/Pjuvv1SpKsrAT9hRsz?=
 =?us-ascii?Q?OMBgmh9+P+H0sVY+8fSf3+lRNcVuRQwFbalySiXoZ1wQ+FjH8npISVkhT+Ju?=
 =?us-ascii?Q?IRsd91RuLnvVXUEu+nTMMgYxGPMAXqKlbKLYh27czMI09rgqrzF6y1M2ctPQ?=
 =?us-ascii?Q?8YlEWEASqJ7jINlqvvcpCQSLsCrOS5KIhttdgxRSlMamXb8cVcaLC206HP1T?=
 =?us-ascii?Q?6VR9/zRQE9rkdq+xlYGFSBL374UNXJ5HMvifP0jYBf5lo6TbXNpe1seTX3DI?=
 =?us-ascii?Q?atvsQfDXjpic1hH+of97C7i96xJu6Fne5ar8jXXS3nH3UmY0cmCWWtNfcmAX?=
 =?us-ascii?Q?d3bKQvXQqYUg4gMrrj2h1Wc1EZWtKK7IWXTm02vClmQ99w4bnn0A6/4W7RjF?=
 =?us-ascii?Q?31SL7M7I2YYyDVii8b85wgg0EP967hrS7dIIVIgo1EaAreu3VJRa61eAlxhm?=
 =?us-ascii?Q?7efpExvrlxzoYYkOcVg37scapZcj39X4vJGOEe/rpBA4gI6lkE07jFcv7flQ?=
 =?us-ascii?Q?OxqM/Km4E46SFUzHLu7eBqOVYCT9rCF8pwn2FUGRBLrCBIaOVzNGHaKbaqLv?=
 =?us-ascii?Q?9kigIhzc4ENJYAsMr9DkolW3kf12YSDPrY+GkllM2eS4ZkGjwK06V/D93fio?=
 =?us-ascii?Q?hsAMfJEShyIr2A/1S1eMqJoYb31VyqiaE6x/Hhq7Lkew3tqiwqj+pxUPjJOk?=
 =?us-ascii?Q?TDRnKLkQkAy6LBb55RxmzWs8WsAum9XDaNlI2lNbyJjvTGcJSrodmZuCcZW8?=
 =?us-ascii?Q?5j0xd9MItjURGXxOxYwQvfHvr23VLGEMi8Htw9ShfdrjPL2RqRo1/HTwml/H?=
 =?us-ascii?Q?RqXJ9qGXcXLJckyRSQ3j4jU0AveH8d40xdStMuKK/gXP1RG3hQfX8s3Qm4Ey?=
 =?us-ascii?Q?wxviWtOG5eex8L6raHwsBWjVUttF8iSMXoVMsQHAxUUlJLx92g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:48.5082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da628f72-8d43-43e2-4d31-08dd0078f65d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714

As multiple platform profile handlers may come and go, send a notification
to userspace each time that a platform profile handler is registered or
unregistered.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index c5487d3928c1b..c4d451782ff18 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -380,6 +380,8 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		goto cleanup_ida;
 	}
 
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	cur_profile = pprof;
 
 	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
@@ -408,6 +410,8 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	device_unregister(pprof->class_dev);
 	ida_free(&platform_profile_ida, id);
 
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	cur_profile = NULL;
 
 	sysfs_update_group(acpi_kobj, &platform_profile_group);
-- 
2.43.0


