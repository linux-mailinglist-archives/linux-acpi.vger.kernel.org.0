Return-Path: <linux-acpi+bounces-9393-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE019BFE04
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3281F23D89
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74171D2F73;
	Thu,  7 Nov 2024 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="khQYl9cK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B38193425;
	Thu,  7 Nov 2024 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959424; cv=fail; b=TkGvmDavkMjgeM55GHIHVl9BKeNP90MgBbFAyzcIt35PgpuvnSViKj33ECFVt/eTGS4twOan1hsn06ctmbnHMGwvPiJ+6NCK9lXXoOAMtPLcLykAE6bbLBs7HNehD7aa9SQSTcoR5P/bzFqerg1Ye/ipfxt4v5mLwTFunnwwlHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959424; c=relaxed/simple;
	bh=q9GZvBlwrd92oTt1mnV2lyNEoxYbU4zV1u2AvfyM0ow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcFfgm1UT1O5/vjl0qyfBncoZFSYF6kQt6+CpvuURjNW4tnVfX5EIMsLRwwvWJMNLnM4CnGOeZeUZGSMUN8fePJsDK4pIJruT9DLScO4nJplwg4B+ePWuYN51rq0eTYemNlTWkTe5jxHEKeZdhj7Pd3fD6EKF0AgjmXrxduyU0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=khQYl9cK; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9EW6nvHB/+V6wRjSlBo15Oid0gL5ZjILbQG98OW78Up4VXM5CuJX6P67kvqyc2C+JXG6BhYxiumbo+3KAdbbi3vl+9j7c1Sya3OIW/u12DfWFVfzzSaYufWkH/yuha3ZpSUFIt5gSGwhq6b7yyMyDv5nMeb75zWkgmq4RWgOJJGO56S6Xt23CKLLIcHq9BR6Qn5p1w+9Dbe7gp339G/RMeaZVqxGkRIY9I3f4v0RGTJcZ2yb4sX5Zie8MvXzi5Fv08N/N/5GKouura+4NjBtI+afoDUseqwWSPgeL9pa0uwCyZlXq0IU7FEEeVjvoFYAocfOMnjyWuR3II6txeI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OninPEMgDexlVeaKcBObF+G4EqFFKv7D7USsC0HuLoI=;
 b=leQexynj7/7qj5y2gyUVffZw8s9dIvfzUd+fOHAUljnov+aZySnkV/J6nfYWtgfdgCsPjlZ+dxqmWvaTJGDznc3/hM+sDk1HPxL5ZVGw/Q9ttwt/dWDTFA7+XeSrS10S/PaI3Wst7L7qEtBOYHEtGIMQRB8vN5T9KyUGlnGYyvznOA9ee7/CrjqD5cYSips6HYYTX28Lan3qSeMXnynycyyI42+l1kjCe4UbO5Mvh9kb4aktDsKZcJKCrTxw6riv58SQla3ZbcKmLVbKWbLxTjlu0GgfUS4dJZrRpY95XQM8KFFXTm9T+sCabh0pKF9P25tLO9P48DHDsPB+qdmTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OninPEMgDexlVeaKcBObF+G4EqFFKv7D7USsC0HuLoI=;
 b=khQYl9cKsDgAcIydNFuPusSXYYkL8MuxGzrDre4r+dKTPfswW8cZ14DaM//vryEMbpcwWn9VYdnFge/8WcKMHbSM87j/NJEvwd3DdCI1zxSxTwWuPkDDb+906EdwW8VPYcG5KCbgIeT7UXCK2oEG++R5KqtB4J837zOfP5hnOJY=
Received: from CH2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:610:59::26)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 06:03:40 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::cb) by CH2PR03CA0016.outlook.office365.com
 (2603:10b6:610:59::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:37 -0600
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
Subject: [PATCH v5 08/20] ACPI: platform_profile: Create class for ACPI platform profile
Date: Thu, 7 Nov 2024 00:02:42 -0600
Message-ID: <20241107060254.17615-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107060254.17615-1-mario.limonciello@amd.com>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 1978dc77-2b8f-4baa-a9ec-08dcfef1ed5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k39CNQK0MeX/GsszhAkeC9H2/rdHmkHTe1/Md37YtRh5M2kP+UeaKKJesGTp?=
 =?us-ascii?Q?v2GTl0Abk453BX09Iw0aZ1e/EIauZjh91IcbiIk5IER7ztMpZ5BGOjyHeTP1?=
 =?us-ascii?Q?/ymygaNbOAiq+uyrgXTTr8DaDxgCjOy26NbKMVNKWjBSMDalGaTSbGyBnuh2?=
 =?us-ascii?Q?qodDl70ooAxynxl+Gpot3MmYGoZ/oi6dYpusd1UoRcuK5/prGD2M2mfhABce?=
 =?us-ascii?Q?7JjRNKK2gstuHimJBNKLaV9N0D1ibNsKlT1JD21eecCK7YvrBnrjkDHYg5Zr?=
 =?us-ascii?Q?CP1VyB43gQOfxoAd80VFzjilZWWZEKxV/1o1XENQjOxeQQua6o0kJ+0A23PD?=
 =?us-ascii?Q?HJAs9zetspFSUWSye3WLWZ3YBWm4kAPg15YHzFwKWC+AgNltZK2fIwgF7RvT?=
 =?us-ascii?Q?72ZskZ7WYViYTaPuF/OlRmuJgngGBj+L8R3ZhhSq4+vZ5AuvBMJtT+RwqID+?=
 =?us-ascii?Q?3LGirytgweWmvFDJbUz4WDuzUdlubhTaTeTqJSvgkvnqxMo1L/iYid/Kmdy6?=
 =?us-ascii?Q?7RamsoJ1sXsDeMIwhc6+Fro/2vYqO2TiIjXBihB5oZ7sBqMyOi8gGjlPClGa?=
 =?us-ascii?Q?UjYJpem8Flt5Y2h9nftlHsAdHcKC4PVXrFB3trMI70CKPhQrf0ritLQ3hD9h?=
 =?us-ascii?Q?PRgTBQgKrQmKoswf6Ucc+pM+2fg0QctHqvE9ZHHOQ7Tl9QXhlQEY6rQpyYwd?=
 =?us-ascii?Q?oLfuW7z9Bn1XEWEd4nhSGlEID2XGOLHjsyWq1s2Zf9zl5IKsEFMKjf5SVCcT?=
 =?us-ascii?Q?JslOY7tRaMJqu19ZfARRXJXWoJ6jLFcc6id9oHWp44n/GXb/fdUhxFzKU7dh?=
 =?us-ascii?Q?8FruipFwpBXTnagemFaHERq2F7TZng+pn1Rjtb9MqmbjawFt8sJM2MVP6Jw6?=
 =?us-ascii?Q?sBvj24KdLNCic8bHzBUyjXfWeDqoh4ZNh945GgHjWP1+yRJxnEe/ux/1yTxT?=
 =?us-ascii?Q?5O2SO3p8wbJxtLAi7H3M6J/VQt/f65xNXTH0WhBcHbm64qtf03Hz81L/T+RV?=
 =?us-ascii?Q?kHtuh3uh6dLH3NVuzzz+pzb+ZLmvxFRdDBkorIwXm2UpBKLEpvZRJchFE/5i?=
 =?us-ascii?Q?+Ki5HtdZ2+uu71tVoVDKL3UpB0YAc+1bMtXoSehAfP4XMGnJIyfjgwyD3XU2?=
 =?us-ascii?Q?kZKG8Xs1ls31rI6UvWImj1ER1ItTsDsRgaM9eaMbpufS+Za54puxVJphangL?=
 =?us-ascii?Q?o3JE7bFP9KtecXy0+/JVJAjoDR2TCydBIRpc1GGhuLhJ8a2/WkA3ALp5qQbV?=
 =?us-ascii?Q?DXXF6CMt81XqBrbdmRCqLtpgGfgaWDraZWSiYptKCmI7Us28pfb070dadxQ8?=
 =?us-ascii?Q?TOi5AMUP1rx8hQ4Cr4gHzGK9tiGeswY+fn3rj4Sgd5gJ5dJTKduJJWu2iyt2?=
 =?us-ascii?Q?9782yWqkawU3lBz4nbpACV8YGlN0jZX5chhxiiwKCGo7n1DTtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:40.1051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1978dc77-2b8f-4baa-a9ec-08dcfef1ed5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403

When registering a platform profile handler create a class device
that will allow changing a single platform profile handler.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Use ida instead of idr
 * Use device_unregister instead of device_destroy()
 * MKDEV (0, 0)
---
 drivers/acpi/platform_profile.c  | 50 +++++++++++++++++++++++++++++---
 include/linux/platform_profile.h |  2 ++
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 0450bdae7c88b..652034b71ee9b 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -5,6 +5,7 @@
 #include <linux/acpi.h>
 #include <linux/bits.h>
 #include <linux/init.h>
+#include <linux/kdev_t.h>
 #include <linux/mutex.h>
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
@@ -22,6 +23,12 @@ static const char * const profile_names[] = {
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
+static DEFINE_IDA(platform_profile_ida);
+
+static const struct class platform_profile_class = {
+	.name = "platform-profile",
+};
+
 static ssize_t platform_profile_choices_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -113,6 +120,8 @@ void platform_profile_notify(void)
 {
 	if (!cur_profile)
 		return;
+	if (!class_is_registered(&platform_profile_class))
+		return;
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
@@ -123,6 +132,9 @@ int platform_profile_cycle(void)
 	enum platform_profile_option next;
 	int err;
 
+	if (!class_is_registered(&platform_profile_class))
+		return -ENODEV;
+
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		if (!cur_profile)
 			return -ENODEV;
@@ -163,20 +175,50 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	if (cur_profile)
 		return -EEXIST;
 
-	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
-	if (err)
-		return err;
+	if (!class_is_registered(&platform_profile_class)) {
+		/* class for individual handlers */
+		err = class_register(&platform_profile_class);
+		if (err)
+			return err;
+		/* legacy sysfs files */
+		err = sysfs_create_group(acpi_kobj, &platform_profile_group);
+		if (err)
+			goto cleanup_class;
+	}
+
+	/* create class interface for individual handler */
+	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
+	pprof->class_dev = device_create(&platform_profile_class, NULL,
+					 MKDEV(0, 0), NULL, "platform-profile-%d",
+					 pprof->minor);
+	if (IS_ERR(pprof->class_dev)) {
+		err = PTR_ERR(pprof->class_dev);
+		goto cleanup_ida;
+	}
+	dev_set_drvdata(pprof->class_dev, pprof);
 
 	cur_profile = pprof;
 	return 0;
+
+cleanup_ida:
+	ida_free(&platform_profile_ida, pprof->minor);
+
+cleanup_class:
+	class_unregister(&platform_profile_class);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
 int platform_profile_remove(struct platform_profile_handler *pprof)
 {
+	int id;
 	guard(mutex)(&profile_lock);
 
-	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	id = pprof->minor;
+	device_unregister(pprof->class_dev);
+	ida_free(&platform_profile_ida, id);
+
 	cur_profile = NULL;
 	return 0;
 }
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 58279b76d740e..d92a035e6ba6a 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -28,6 +28,8 @@ enum platform_profile_option {
 
 struct platform_profile_handler {
 	const char *name;
+	struct device *class_dev;
+	int minor;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int (*profile_get)(struct platform_profile_handler *pprof,
 				enum platform_profile_option *profile);
-- 
2.43.0


