Return-Path: <linux-acpi+bounces-9028-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CE29B2255
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1E4B21EA6
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB9D18F2C5;
	Mon, 28 Oct 2024 02:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0fJo4wXb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F5418E758;
	Mon, 28 Oct 2024 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080952; cv=fail; b=fc+gVnsxwYX4JTNlQyRNBMf7hcOOrT/mJReDcdM4Kka1HM3qYEUN4A3mx/7aUrxOtYK6lGI2jWN8k3uQhLhtTZZc++iJSeEK1wKT4iWqbWMFXcgMfaC8RNO5W3Hj08gkczZirK78zFk6XB+WExiSf7CR1JJl/ledCocgSs8aQxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080952; c=relaxed/simple;
	bh=fjLVtWLvjdxjEjtwy83jVOC5p2fUEmI3179W2pZoPGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSJYVc0l/lVJJDaEsuwILsERCnVL/hxXIIya6vMyZg3u8GiJ6Lplnzc4FiKkrugP2XDbUviSAar4W0WvEibBWkNHXciz0rR0kZCVwEijQQ/4cDSSk/l/Qt4U3itml7KRVjOGWjbetS/voEOX2E1x2vco+pzBP+pSJ/wWlUbxKZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0fJo4wXb; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S65MwHl1nEp07l4eGKo5eD0oO40R064Ekvujb1fm8iaPB/lEa/6WnxdGp7IMYXCLPgCz2pXWtDg7V2ZdCTuE4EC5w8+l985tMVr1ZMFo/FKPfKzdr4OcsArWjsevbEiaVWxztDj8DfrOb3gQWn8gFlkkQKDDnH/C6foqqds6G61zm4IaJ/FJ/e3LL54Tw+719du9EhzGCCwjmzczEz2AAx3ShahNJ07BT2D67EPPNiMGnjYcip0kcZ2EGF/EEJ8QBGMSX//QvCIrVMEOiC3luO+uXbE2Zdt7bqeZffdbKCTw5k+Zx6Ap/PGaAtplEOAv48t+juzANqEAP5AmF8cC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfRMK+/cK1f36OYEo4S6/Q9As/pXGudvLftjTZfY9GU=;
 b=hqPAQMwrGJ31C1l5PwYNr9KXrQHzlAZiDAqXKIZVuLQH/ia6P6NNoMlgH6hoG0U5dkaF8AawEzEoAi+ikaPpSta6aX5D4KQIPcFcR1LP6bTQ9Ef4pEVWxzmVyPjNnIhvDsRtFrctUv7C22KQSwkZ6Iy1nUZiOQ2L+n2Kp9lkZ3z0A+OKRnJ3KmmdpR0WPDeL6X8dteH//M04AGZOSi5azBYiocuQgxsSLDDfStH5gEg8qr3D1WOjZRDWZ7DPjQ3rvcLCXHgipNmJi+NyTJdfcYFFAvrOg1KrlzBY0JkJDBbgUjBk4TKo7U2FAxZGTZrqhV+dbsK5MtuijHrdgYV+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfRMK+/cK1f36OYEo4S6/Q9As/pXGudvLftjTZfY9GU=;
 b=0fJo4wXbWLLWuMxu8cJ28kniZ/XAooyeKufId5T159qbgA7B5XFZcb59IR1gCDGEglcZjei12gazC3WxpB5gW/RffqdmqiB0m+y/CbyTexN2rCljINKUsZvRyOaGuedjAy1WuU/E8fe5mtJbj5v/H4IcJt2qNfe90fZQcGaLuH8=
Received: from BL1P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::10)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 02:02:26 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::fe) by BL1P223CA0005.outlook.office365.com
 (2603:10b6:208:2c4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 02:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 02:02:26 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:02:22 -0500
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
Subject: [PATCH v2 14/15] ACPI: platform_profile: Allow multiple handlers
Date: Sun, 27 Oct 2024 21:01:30 -0500
Message-ID: <20241028020131.8031-15-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: d77a7ae3-b86e-473e-6e48-08dcf6f491f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HiKr5eAfJE4p5AXOPEGqAluWlgMxjSRSxtA+bRWQrsf7fEmSDgU/G7Xn9Uea?=
 =?us-ascii?Q?Th/FJOFIw03EXQ/ZUJSgRxQCiRjrbXf9vEPL9j/EqgqcilFOZbM1TX5Wpeum?=
 =?us-ascii?Q?V4tA+A/vEdJBa3WqXPe261XaBnssA93xVHHzCem4NlpMVgkMOE7uLW0tiJs6?=
 =?us-ascii?Q?rWVqRsQupok9hLrgxARY0XyyAse75liKWc3CABXfjm7a0/2wquF8GDolICQQ?=
 =?us-ascii?Q?duDgbonMcLmlW1vNleAEFzj4a32n9I1Gt7gQn3P4cZaB7V3rWomfmTBih2l1?=
 =?us-ascii?Q?yz7qnP5a95/zBOwrP6bVgf5dkZv14G+MXO8z9KjtXq9VszJde11ZGETJO/lW?=
 =?us-ascii?Q?GEifDtBXM8piSBlbu7wQYAAbgltIapEeyEniLq6lac8R7niq09d/J7RoEtuy?=
 =?us-ascii?Q?jXU9FSQm10cXj5W0+YNZdgJZXdCSVbripfdGWrEbqPt6Th8b5YwFfpuASq55?=
 =?us-ascii?Q?S1qlKPorVYWhj1smrivOcWLIuXcvffECBYVnLFI4LVxCI6+HXhfXszKjAPGw?=
 =?us-ascii?Q?U2sMtOzFsTlLtxhKdQrRvx3ZxddcK1nkhicrey+X4l5e3fmssawY7BwBI8gm?=
 =?us-ascii?Q?nJWsBRQKt4gHmtZGlvaA7QsVQeX1lf1JIXwtCiAx9bm+ATDzYXo/eOanuKb9?=
 =?us-ascii?Q?/5Lo7JgZ6Kibsj8+b/v+sMDVFM5yqQWotZtKP1H7Utdjq7Ohm3Yl9JOGeF0q?=
 =?us-ascii?Q?hpHvaRDd8HkIAhKVu7iWSqWndAVUkTfI7Oj4Md22rlZKB9KVvygnpnvd/fKh?=
 =?us-ascii?Q?z2jEEh6+5qceimuFZzZ7GNVsDUV/i69oZ4OktKb1cp1YMcbtJFDuuejkhFIj?=
 =?us-ascii?Q?KxfWMo0xzg8OzBkQMIYFAwLAVbsZ6z66Iv10wdHf/5rcNvkhPPuRsBwwfhme?=
 =?us-ascii?Q?DvoJQQOtu9Fn28poT8V7761jiQ2Lgus4wFZg1DscdSX0Yo//CrQiEpeJZLWY?=
 =?us-ascii?Q?pgkqRUb4xGicxGEDaryJ2QmO6jq3jbUDhHFJKDBXirbB7zrLK4PP9U+Ezur2?=
 =?us-ascii?Q?N4tg/cbClaTUHDKfgzlNSxgPlQJ8BKZrJg9ewScyCWp1un3EzcaAdj2VdtWZ?=
 =?us-ascii?Q?8rxxEsoL2XuaKL55iZNPt0hfPT0zTNIgan9uC1RsMufi3VwfmXpSvyo6J2PQ?=
 =?us-ascii?Q?DOD8hbgRz3wHBqAmUMfcKNxR6Vb5h6WRpn/3LWoTI2L1rBgoKVSIFe13RGZ5?=
 =?us-ascii?Q?23QiKTWUWkE2hTQqFIsLTtuSgbifawTefsWx5Ar/kln4mdds+wW9ZYRj7+M9?=
 =?us-ascii?Q?e3QDLJUJKvKCHFyAWf7A6SQSsbVTMtSWYUyF4kbyG2vwRbfP4kplBE7hstXh?=
 =?us-ascii?Q?3bZkCb4kmBFSlwMri0X1Vc3KXIx/YyFu2N1yDivegMuWE8HWvfJuKVglxfp4?=
 =?us-ascii?Q?gHSlLy7DEaJ0Pnj62GObGy0FTESKGvXGBW6KFAcweLF6xD/8Rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:02:26.0376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d77a7ae3-b86e-473e-6e48-08dcf6f491f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431

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
 drivers/acpi/platform_profile.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index e6ea5b600e2af..2794a8f686200 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -9,7 +9,6 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-static struct platform_profile_handler *cur_profile;
 static LIST_HEAD(platform_profile_handler_list);
 static DEFINE_MUTEX(profile_lock);
 
@@ -188,7 +187,8 @@ static const struct attribute_group platform_profile_group = {
 
 void platform_profile_notify(void)
 {
-	if (!cur_profile)
+	guard(mutex)(&profile_lock);
+	if (!platform_profile_is_registered())
 		return;
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 }
@@ -251,17 +251,15 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	}
 
 	guard(mutex)(&profile_lock);
-	/* We can only have one active profile */
-	if (cur_profile)
-		return -EEXIST;
 
-	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
-	if (err)
-		return err;
+	if (!platform_profile_is_registered()) {
+		err = sysfs_create_group(acpi_kobj, &platform_profile_group);
+		if (err)
+			return err;
+	}
 	list_add_tail(&pprof->list, &platform_profile_handler_list);
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
-	cur_profile = pprof;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
@@ -272,9 +270,8 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 
 	list_del(&pprof->list);
 
-	cur_profile = NULL;
-
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	if (!platform_profile_is_registered())
 		sysfs_remove_group(acpi_kobj, &platform_profile_group);
 
-- 
2.43.0


