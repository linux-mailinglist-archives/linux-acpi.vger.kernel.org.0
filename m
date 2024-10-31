Return-Path: <linux-acpi+bounces-9180-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E94C9B73BA
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC31B23AFB
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11C5146D53;
	Thu, 31 Oct 2024 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EaTJi/JA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4B146A87;
	Thu, 31 Oct 2024 04:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347892; cv=fail; b=pZ8N74wKwLSPL6CgCZZJxoIfRwCQUoti12xWmwtFZzvPRlpwvLFVvjFRYWlmUdI0qsrn5epox2WzyMHuKoiVJ1oQrp5rZy9npXv9PpQ+KL0U56oPFVW6UY/DX5HlkFVvNfrT2/xedX6eG5gUqeNwmmtV7qqGt6ue1eQHAGLHueA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347892; c=relaxed/simple;
	bh=2bgiz07RWtlQAlUkySyB1AoW7uwWWD3IthivNQhZaUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3JwtrLgzGPxNMA6PRxB87rlAE3zWH4Aodb0Sc6gvJbRwtCrzMXRonRGuP9FxaWd1B0+0ceKxH+RsbE3tsMEKEfUIo9txNVSNM8vJ0Qx5RnRAWnJSXIS7znBjccVNsIfgbZVmsbUJjE2bTwVk011Aei6HlSNyPf3w6lODfaOcJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EaTJi/JA; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqKJhwgS4UnQPKgAaLZnxNVuH1U7uxrSmXwvFMmLbDiLtKJY6t3i/eJP+BZc20oO/avu7fPLONKSYyBU4nX1ybk4iKRDbIbHzV5LXfWwPRxQg8/+UOtdPFDBOpUOl+GSj0hW32MWLXGvDUDPDZZVcEa51waa8BtS7tOZtH8BHf4L0sihE8K1e3Ok9DBm48Ad26BqrLDbH49uSvDduHgCnZCiAIBNVLrc7HpreBIfY3SKUtytJMmidM06Z6JBVCqmR2v/S5Q9RXAnK5emAvcrgMZaIHPK/yNO7eaGDW69IbOKcLTZgGlyHKAErAzOVLyEKhucojWmYBxBC+7j6McEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrgXA5/hjgAqL0HSOmHsTShil3KJAlJa4+pswu/z1fk=;
 b=jYbhwvk1ydQMJql4cXGsuBzo+FKrh99SGC2w4bjxZCAbYV1ZOWRFj+Td8xq+rx2DFcIB7zaQmQrdEV+xnHFgyX2PbqZf8efY58aqq7e1GFJk1LOHLFBg2bPXgY1ObGjrhiv6UFGpWWylvaUcewe0NrJIQ7tFvADyVksu8HOjdVwRv4a6b1nixZaFpDt8L1NbJhflx7S3x5LiFY4f47yxifS5kVwdzgZ+wsSYKQ5WrZQtYE8g5l27RT/mD3PxgO6aMP1zjDa3jfSMg31IW6UtI9+b8Wa+PrMw3ZXVwI7xrWcDPUvy1yawLD3q78dMwoIiB/jd2or4sdLL7e1PvH25+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrgXA5/hjgAqL0HSOmHsTShil3KJAlJa4+pswu/z1fk=;
 b=EaTJi/JAddHUMkHyrrLTK4Uwz/aShNPTX5WQj1EmxuBRnVk6hgADb92msmGPwYp94UNHXLUTb4lbrxlp/kQuZH8CRk2cHGFInaLSJKuVV1n6ycYv1Cf37NLRX0N5ym+E7Cut5+eGqpsQPXMsko5qCR9QuTGowW+bYjjsFEa2tpk=
Received: from PH0PR07CA0043.namprd07.prod.outlook.com (2603:10b6:510:e::18)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 04:11:28 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::73) by PH0PR07CA0043.outlook.office365.com
 (2603:10b6:510:e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.33 via Frontend
 Transport; Thu, 31 Oct 2024 04:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:11:27 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:11:22 -0500
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
Subject: [PATCH v3 21/22] ACPI: platform_profile: Allow multiple handlers
Date: Wed, 30 Oct 2024 23:09:51 -0500
Message-ID: <20241031040952.109057-22-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c7a095-1f87-4885-b0d8-08dcf9621775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wzwOsD/Uhi10+N2MtYI3oMNUcYU9Vh5GXoUrE9gRjZ41aTs8EzL0MWw1RCV1?=
 =?us-ascii?Q?PZvSQlBMUFmM+sJivmA9Wfb8kzhWaflJHx5GcpJ7THFq1m4aGfZUDWGbbpc2?=
 =?us-ascii?Q?jRj1IRWU5Gk7NH6loM9abDb3WNm0G4aIu66R0R6LHXE+NYC2aZtAudKaIVx0?=
 =?us-ascii?Q?+mYIwk5jXUnRev8P8yDBeSmVS3hrHl1N+W+mNhGO6bAU1oCUF7wyAnwsMI3l?=
 =?us-ascii?Q?hvQhIAx20NnKSwe/EdAMfBL3HJMtnj5kKPQyNjRphAVzJE9da70+BwqdIH7+?=
 =?us-ascii?Q?SsorPXO/4I/KcFJ3cb08Af0pngIeJz4W7skrd60IgZcwNWtdPWRrCBiA52eo?=
 =?us-ascii?Q?R3hu68xXynYhzJsaCrXlrO+kSECNOimYXoeqCNpGqR505Ql19+CHT3vZy70l?=
 =?us-ascii?Q?aSu6rBnwu3xMYNscDBLfbVal8xneVeLKamd0Q2zhr6ImlWVwSkHNj7GV39Uc?=
 =?us-ascii?Q?yonON5R9Vt5bLtro44Mt4bWsQWLJu48wksaLn2oC9X3YHWptXkP/5pQN2pph?=
 =?us-ascii?Q?Va133zuTloAnT6Y5hNneVul3RF6rmkmOy8okpTHJmbOxsBwsb5DzqjR893d6?=
 =?us-ascii?Q?T/StLbPd+QnL0F6Ed03hAwdhshf54N/YvWX4fGrcUiZK2ihLHRK2cHm4SUq9?=
 =?us-ascii?Q?SsVxQxdSXnnEmsmVXtwbLZNWozogvi+svI4aGxMXkDIyXSXBNfpWpsk7/1nC?=
 =?us-ascii?Q?kmxiD4F5ZkHettY03howAPfFtlTgDBC8tH9ZhfIovo5/IME/tI4esj4CG6ga?=
 =?us-ascii?Q?d1YlFPNY/WLvxCFvCT20qdb4Jq4++bImM/N/b4sTXlGAzbujt9bQPe7xLN6L?=
 =?us-ascii?Q?uMZPZ4Z7f4ioEUtvkWq5APfpVNZS+Vp2D7EKIDW2/RaHk1a13ukuJtw1Lf6S?=
 =?us-ascii?Q?K5vOaNhTNYzKZOmnpQyLBUPvyOdf1dfcI3G9o1JwrzCHPEMSG8ml4ifdqrEr?=
 =?us-ascii?Q?k+VBx/xeskAOPHmCP1BaIhyNJDMT7BLHXYGqLco9XGkf/fX/Da1Z49mYKBF+?=
 =?us-ascii?Q?a4acGEZse3VN5vctF8479z5uCR5ujsCo5nK4zxaEATfvyA00Gd4xWwM+XPlw?=
 =?us-ascii?Q?5zLUv0gQxzb1JBARghaO5exY8MZG6GEGvMSaHr/VMD16RRhLRVbpzaSPjbaY?=
 =?us-ascii?Q?KYxoc4mLfTkA341R4GU6cm55Sy9SXWGdyo+Xwi7cdJDgK3OEio2RPUjy0Ro9?=
 =?us-ascii?Q?WEVil3TYPOcWPEFcYV4qiu06gnyhcrtqTtzmB1ZRzb/Kh+bB+ey0Xe/lOvAv?=
 =?us-ascii?Q?eW8fL5MWAqkf9udr6RKmQp6iYRpWIJ9hKnCTQPuOsxV6n2ib6TqAoIa4fLR8?=
 =?us-ascii?Q?+JFAnwMmUxgSph03sciRFZTYm8RUoTsq22uEA4eOEzL6E1KuOFC5TDrlqI7v?=
 =?us-ascii?Q?VkERxvaGpbQmRlSGXncONIiMfzDcumGNxuL5ij5e0Ay/b3JkbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:11:27.3749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c7a095-1f87-4885-b0d8-08dcf9621775
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202

Multiple drivers may attempt to register platform profile handlers,
but only one may be registered and the behavior is non-deterministic
for which one wins.  It's mostly controlled by probing order.

This can be problematic if one driver changes CPU settings and another
driver notifies the EC for changing fan curves.

Modify the ACPI platform profile handler to let multiple drivers
register platform profile handlers and abstract this detail from userspace.

To avoid undefined behaviors only offer profiles that are commonly
advertised across multiple handlers.

If any problems occur when changing profiles for any driver, then revert
back to the balanced profile, which is now required.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 1cc8182930dde..a845524a248b9 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -9,7 +9,6 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-static struct platform_profile_handler *cur_profile;
 static LIST_HEAD(platform_profile_handler_list);
 static DEFINE_MUTEX(profile_lock);
 
@@ -212,7 +211,8 @@ static const struct attribute_group platform_profile_group = {
 
 void platform_profile_notify(void)
 {
-	if (!cur_profile)
+	guard(mutex)(&profile_lock);
+	if (!platform_profile_is_registered())
 		return;
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 }
@@ -280,9 +280,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	}
 
 	guard(mutex)(&profile_lock);
-	/* We can only have one active profile */
-	if (cur_profile)
-		return -EEXIST;
 
 	registered = platform_profile_is_registered();
 	if (!registered) {
@@ -313,7 +310,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	list_add_tail(&pprof->list, &platform_profile_handler_list);
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
-	cur_profile = pprof;
 	return 0;
 
 cleanup_device:
@@ -336,8 +332,6 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 
 	list_del(&pprof->list);
 
-	cur_profile = NULL;
-
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
 	sysfs_remove_group(&pprof->class_dev->kobj, &platform_profile_group);
-- 
2.43.0


