Return-Path: <linux-acpi+bounces-9819-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1B79DF0E3
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17372B2171A
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7971B86CF;
	Sat, 30 Nov 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qRLVVa74"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D633F1B5827;
	Sat, 30 Nov 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975570; cv=fail; b=O29ssL4Vt4jcrbpcCf1n0JFY11t0r3uvYegd66wLdP/Jlbpz3vYakcP32HAQcSuuvicQm7ltDb566v7Bl7U1YWu0tz9dpR7au9XHDpCJPJlXV66ucLoERIpxw5RH+/sHGekwLpPuD4YAYlkAQn+TpAJ7e/gL882iFWfA2c/fcrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975570; c=relaxed/simple;
	bh=Q9avaHbOthdc41LgOEuzAOMf3jR41UX86Qe6lJzXjYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9lNyR8+azf3gZir8HJlivxsk+W8uNX4DhJOndNKiqYDO3VmDRT4fNQqxhAV31Mqm6xnbqlycezaH4l5KFLNSe4POOckhmda3lKB1HmKEPjU+lBnkTrbOpLBvNBM0l/zMAv3Ufm7s1WIunmG9RXjwbB4ipDJin41DFbUU+MtvoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qRLVVa74; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaHPwTGP0IzAsuS9hpK3+A5Bj5/1ner115iNmZwlF+jlxNXKRqPAjFYLYt/tBDGuV4Mo25sKQMFZ8dPs5BESIEgVMyNdbzvCBp1205RizKMZBLLZ5t17Wiykw4U0QRoGMwUlGBdmY/jcblCMqvSKMWm+u+6sEANEhspMxmaP1cGyLxqaw17P8c++D/x0EOq37JunlU/zqbxUVgtXEbUgQJ1SfcRVT3BUYprh8K4se+MoRYKnRQ1qSCaTFfDWPRtWvh2Sbzqnlw6QL3Aaji1ltsS+93XSBNdvB716ouTsAcS6y6odoB6WwGEC3bFJr4OKQOw6oLuhTtipcLkqekccBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhPbuhl5p8r1g6n/pTVVP/pO7JKpLp1XJelDnHFGo9k=;
 b=h28K3ujT6EykzUTRXxFJOqfcVHUPL/ERSTDYhxa4ImHiZHUs0viQPuItIRz8EnbOxsti5N7E04bp0tiLeg8QVRmiIY34KF1xM8/RmwtOHq0AooflIE7WZKZVLP4VxIoiwaFy3OMvtDVTU3JKNL/mXzYUpFlMlDB1eLDxoWxALGfjsGl1S1xk1q82qjOS+hhDrBSxc//vQdl4KuqrbGTGOsOSm240Vs9UBl0D8UO3lT/rvQ4h8vynKHs3pJabtmDFf6zslrCfviQVIy6QG1JCOsvUdijdbfcQTAmRz8dITWpLHj4DnOBhIVfOR24I8G2CkigJscwBke1oFmvME1nLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhPbuhl5p8r1g6n/pTVVP/pO7JKpLp1XJelDnHFGo9k=;
 b=qRLVVa74b2SNb6PKTtH3WUjM1pTbLakWTCcgmTsmTVHE2YrIPPWL8nBwfyW8IGIq2iS9kT8TdJL0cMWPgFDDusr1wZmbHN2R/L/L3Z+rQGV4FGvkoKz+hJp2GHp711wmC742+hoz6k5c5wSomgSzKKzSivqnUwKLLNm0/1NcwL4=
Received: from PH7PR10CA0007.namprd10.prod.outlook.com (2603:10b6:510:23d::7)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sat, 30 Nov
 2024 14:06:03 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::5e) by PH7PR10CA0007.outlook.office365.com
 (2603:10b6:510:23d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:06:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:06:03 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:57 -0600
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
Subject: [PATCH v8 19/22] ACPI: platform_profile: Notify class device from platform_profile_notify()
Date: Sat, 30 Nov 2024 08:04:51 -0600
Message-ID: <20241130140454.455-20-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d8b033-f9c9-42f9-eaa5-08dd1148205b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zDqYMbulF0QMaPk1JUM3sjGz4FkqSxKXbdNAC/Nh2WS2dk7FgIHYIujy6B9X?=
 =?us-ascii?Q?97cnu2cVai5B/QQoMfacU4jUQfoRfzjK/CKyYyfgOTs43PAOct+5tdvaolr+?=
 =?us-ascii?Q?rngtzDFEDZFykstfXZd9GCyN7xgbl7FkGTzADcw633Lstv3tNd0v7zsDW1Cy?=
 =?us-ascii?Q?q+zhlCljv9a+2kuJlXAnBB9jR/0keBZgi4WBo+dg1ZPcRqgOfyMgO05DO2w3?=
 =?us-ascii?Q?InbWjq0CqYCNRP2qAy+srAzimLIduMo20CTdE4XwsCGl/l+wVx3UKWLgGOJc?=
 =?us-ascii?Q?MqlUq9n3o8f/ydoMc/B0nBzOFvIFdLbsAxhwDQXHKF23ZaWMIR+4J7WQA1zv?=
 =?us-ascii?Q?F4dTw4kKfbhny7KQxuZebnrwu/oyWR0sFYmQ2BiiVeBOn3ue6rEpiF1SgETy?=
 =?us-ascii?Q?LvUbJ9xTznvYX+eo7kQYwP6xK+bGdI5mwVKFIh4ZHjU4j5lG1smtUekuAB2X?=
 =?us-ascii?Q?B25ifbxji1cCctETHak26vdiZOSQ9sYVP7b97HGZzCtLvw6fKvL0Cb/UH6E5?=
 =?us-ascii?Q?EGRv9S4Je7cwbb4w6Rm5aieI8i5XVgUEiUTmF27WBkeVOzcKUZUbi0Xjyh4d?=
 =?us-ascii?Q?CFIsD4+cs4IbW/gum3zquSNS+MwWoRZAEd0I+NO8GxICC0ZBJUsOdAkIZP7t?=
 =?us-ascii?Q?nhu5RfyX/aHj0SQFwuGC3gr7Do3DsiA+Q9CEP+PiJcsktHSM9zXvYmjVOcR+?=
 =?us-ascii?Q?XeJjsgv4Gi7b2v+ZkAt3Zd+f+1CT7ciS0jKt9UxqJJqk4e51iKtXyBUaKd7Q?=
 =?us-ascii?Q?MuR0DrmIeYOgED5vdQcLO5eaLBKHYVGcpgHfWtrG/BCZmDocu+ckAUf2Td5r?=
 =?us-ascii?Q?asw/+k0JZB+K0PiO5kpj0Ao5rEo6u5MXhwSZzQ3YLA/iSoDaOZcJLYy8m5Vc?=
 =?us-ascii?Q?AU6Jv5DfbdTmQ0l6+cOKEBZ3dO15sj2ASTqpdIdckusnd6hk6w9P+xGSLdc3?=
 =?us-ascii?Q?aBWkxzcdI781W3Ag7iMhhBHiy1LmOoe9hMxJsfGTcxid19vFvaRaIKp4WDmU?=
 =?us-ascii?Q?Z1UZXnp62XYQDHjv1tgZksfr1hB70KZRauxtxNuUEG6Qjdc402IXXUW+6B72?=
 =?us-ascii?Q?6P7vww4Eb1MH1bIAHGS4H3JK7S3EL6LcWNsLvMrgpBDCqGTe6DlvAuJxdi6L?=
 =?us-ascii?Q?fvMZds2bDIRg+9XmmZGTzfgQXAzcjvKzfdia9qCmyUpu9QtPBQvI3Vn0nNQB?=
 =?us-ascii?Q?aB6/7d1tw78CK9VeA+ueipjANEllEww23nR7cCFjD8mTlk0I2b9rHfmQ2F3e?=
 =?us-ascii?Q?CtJMkyIjmI/JHvsl6EU/bq7eONwB7WJFKs0vpenYtYAG/KhmJcorjldv9BAg?=
 =?us-ascii?Q?yZCnRwOqe3593/U1KIILUGg+zxtlR9AE2OtijMWXfQu3M+DrXCRQfvEDBKxK?=
 =?us-ascii?Q?dReleKN3PuZYjacgRZb4o4syg2wffCuw+MOk/s+Da6KbJL8SId8GvbJjlh/d?=
 =?us-ascii?Q?gP+zBKqidXtcpciEzyVCWyndSPrFvu7x?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:06:03.2972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d8b033-f9c9-42f9-eaa5-08dd1148205b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209

When a driver has called platform_profile_notify() both the legacy sysfs
interface and the class device should be notified as userspace may listen
to either.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v8:
 * notify only one dev
---
 drivers/acpi/platform_profile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 16746d9b9aa7c..289b5d43638ae 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -401,6 +401,9 @@ void platform_profile_notify(struct platform_profile_handler *pprof)
 {
 	if (!cur_profile)
 		return;
+	scoped_cond_guard(mutex_intr, return, &profile_lock) {
+		_notify_class_profile(pprof->class_dev, NULL);
+	}
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
-- 
2.43.0


