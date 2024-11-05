Return-Path: <linux-acpi+bounces-9308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5827C9BD091
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8811C22118
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED95E1D6DC4;
	Tue,  5 Nov 2024 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nYMXHmvF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667861714D0;
	Tue,  5 Nov 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820828; cv=fail; b=poyGSQE2hkOl64x+KxG58pjN+02/Cm0znwZ0tALC/j7WN2MfRBLOgAdZNJPAtly/s9TfL//k77VqeUamVBNT1igPo8XW7totg7g65UiycuyZ9tMFNlFE2qeCJRqiwR+kYszTL49wKGyA36loF6in2CzitLUDG8dxd5VF/uygf78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820828; c=relaxed/simple;
	bh=IKVHLpA4A5Emcm9TiMSim8CDvCbkac0/6uf5InyDifQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRQHgTGsOdhpQvl3qwgOBAtPnbvwZXnx2cKMqObThePm8jKInxudtT5AFZxxMeeQPmwleNBzEnNDyNb7zAoTWnJH+NPmzOwoWar+34sPzEKvNmjFn4gFfEdMppWeYRI7yhKhlHtbQVmEvpxKGc7e+Ls+SRERzgQFNWoPX+eCMss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nYMXHmvF; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKiwQecVnO0QVaUP5okXS3wGH/4rnXPE6JcXGrsdRUszAMhTgOhwn5Q26x4UUXzCx4813qMWM294W/4wFf/cw5FBLuuMeO2Rj6IRniw4Ntr4sMC38JNz7wRxvh+ECggOty8maqyznIxfI14DTziAx1BK+9bM2VjW5Mu28//tL/0RQGlnYkOHwKzRT2lJYiXraGfA8HuE0aPohTSdbWClCwfJGMvIUGiOFWuFfb+MtxsNrT1AzeUx0U0G5QDvv9Zt/8SOCRTwiRzwZJuj/hcMi1uzSh28IdO7YfzC/fxTNGdyorKz0JIpAnb44jixnguvpcJfMPCjlggdtcdJ0yJTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeHUBXnx2/eWL3xINfk4aXphOjzqTzP4FAaeqbocuiQ=;
 b=L56VMsehWaFYidwTSswLVKE43HMErmkWw/IuZ9X6O0RrLAGW34WdISarDiA3nGQsT6OiM/P3dS3jRjJTYv979392igwgk41gfrVP5aAdYpVTrjuryOC2CFN1+KJhsdTGf4CR8L5Ln+bOuJ5GKgAsUnP2gGk7l/NNYWm7P1Avm/7+MCtpkriB11AEW8uO7tG/RXyBjaOJefrDvT/g6t615um3roTUYPzwheCkEIVAMm7yVHh3ni4ux0JuTVzLSmDNoQVc4w4UcqHcRV2GNATdPkNXp3IOdr7MbvD1zoEBfNXvG+iTg/4FLFX/9pWcVAo8UBkk4Rl+IJ8ajDTdir74dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeHUBXnx2/eWL3xINfk4aXphOjzqTzP4FAaeqbocuiQ=;
 b=nYMXHmvFzXoEiEnJP+hUE1WmpygaKNDn8wuwLzza/3IlyXSfRkCcOLAsUc04FQkE7W/LxVnKnOqRt8e0TwKgXVjqkUA0qD7G3yYzpT4nECBtTVnLyxvIQowXiBi0qvA3jlzurNn8ub+U6QM2JCI3Kh8NvDycCJo2yFVX1qzJSwU=
Received: from MN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:52d::17)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Tue, 5 Nov
 2024 15:33:41 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::56) by MN0PR04CA0026.outlook.office365.com
 (2603:10b6:208:52d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:38 -0600
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
Subject: [PATCH v4 09/20] ACPI: platform_profile: Create class for ACPI platform profile
Date: Tue, 5 Nov 2024 09:33:05 -0600
Message-ID: <20241105153316.378-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105153316.378-1-mario.limonciello@amd.com>
References: <20241105153316.378-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 8faca741-fcf3-442d-e51b-08dcfdaf3968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/rHMM46gVePch5+zbyXVVluFhFThHNYOYhpaY4nql6jfwuHJbYA355CIfM/i?=
 =?us-ascii?Q?e0U9eEE0aOyoBpf3uV77UGO0vZCK2UCbBZ5YXdBq+2dtOJ6M+kXvuyoRppCT?=
 =?us-ascii?Q?V3aD6U8LJ02/8b2yFNsBbO2LDhUDFaTTi0lb3QJiXoSVzBN0ITPwrAYJon9Q?=
 =?us-ascii?Q?UqkpYKKGJGeZBudtnG0CbpE9G3huY/nZ2wYJbricGXvPVsFfhoG6rB2XroKA?=
 =?us-ascii?Q?TibKCYRdnHJjts1soS4I3RQI9dFiwiEvb3VlfK/DVkLXCiiUqVM81HI5HSWc?=
 =?us-ascii?Q?gAQ5NR0oBDyDnBdAgMKo80Oq8jYvXFzs5mM0kxMahblnctNKyhw8T6qZ4qCw?=
 =?us-ascii?Q?1CDbuKN5/bksBkmHl67LVSNv1rRxL5boFvNv832FkGw8zkmSpOYw3pkX7j5Y?=
 =?us-ascii?Q?W1xREnCzAsYDP29PPGcSuYIbuo0caVnKJbPW+NSxbqOQi8vYrD/ASZ1UJr2g?=
 =?us-ascii?Q?BhDH/OTxtXJwS2t5zTeLQmlD2GMOi6jS1VhGWK8R2KeUz0ixwF3OeDONsQFa?=
 =?us-ascii?Q?3ejkbWwU3BF/wHCiZckkrtn4tvZJyrjyl8ph0jk0EeGZbed7zASfXv2gDpqy?=
 =?us-ascii?Q?WM3lfNRRSoKon7MUdcCqLU3+tfQwOWeopctnnamnKWeK3/c/byAyjpY9Hrgh?=
 =?us-ascii?Q?DF5p47X7wiuPnAFagUmscwnDVHPYEVFFe5bzHp7uwU0wUDQg6xOI8QxD8UHG?=
 =?us-ascii?Q?Jy6c5Vv/JuvNl/pHY4bwOzQ/xrH0I036IfKpF7TxdVzLMkEIqwuYPRl3MiPW?=
 =?us-ascii?Q?+Y7mpY8bb2awaAypi0R5KecwZetBMp3S43vnZNj408mTdZMygCunt3QmNW0U?=
 =?us-ascii?Q?SZ6FyOSr5CX1M+eL1HFQR76tuYNeUpZKd3QDcWf6m3gFU8DG96HKizabnbCU?=
 =?us-ascii?Q?vMYhPEuJrpTdioMWYo5UAVrB9/1NcGUStkToMcmbodQMRnnYyCUV/gwNus+h?=
 =?us-ascii?Q?fbq+pBZTNBUfpSYaTokba2RW1P/h+b2ZyHy6+u7R9cXOSGWS67ZkPGwbTtaA?=
 =?us-ascii?Q?9qbbZ+cf5oI1Fc/DuaG0qIZaCKrDkC4blLxUbJiLRjZ0BUtWZ+pGJoOacuzJ?=
 =?us-ascii?Q?LMTZl8p4AaA3b8bOsVCaeXR8oQ3QHijvPuL8rgB11gExXVsl65K3PD6M8TSt?=
 =?us-ascii?Q?v9SGDWv6iPTaf48Mh/oszBqZjQ3OfuMzVXhevjZJzjEkEubrVCeMaNQ5As05?=
 =?us-ascii?Q?YL6nD6DCjWfY8nNgJBtI5GZj37+Iunl8Wg68FF9/c7Wle2QkAi6eu0aXU0RC?=
 =?us-ascii?Q?9kLYlWxurEogjC4bh/zu/7x2614kpLPC0uNJdDlZGCOEDVSvf7anq3lrUB9v?=
 =?us-ascii?Q?ikCSx7omB2ppHX40bpfFjGqhg0vPKBhlI01Mgty6YUG57+9rmpd3t7mwenyn?=
 =?us-ascii?Q?NamtsxDxNRw68FtrHW9IAwh/oXNCnoWdnZxmqKlWEWrZdibofw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:40.3422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8faca741-fcf3-442d-e51b-08dcfdaf3968
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

When registering a platform profile handler create a class device
that will allow changing a single platform profile handler.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c  | 42 +++++++++++++++++++++++++++++---
 include/linux/platform_profile.h |  2 ++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index fd1c4e9dccf0a..f8e9dc9a10d54 100644
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
 
+static DEFINE_IDR(platform_profile_minor_idr);
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
@@ -167,12 +179,33 @@ int platform_profile_register(struct platform_profile_handler *pprof)
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
+	pprof->minor = idr_alloc(&platform_profile_minor_idr, pprof, 0, 0, GFP_KERNEL);
+	pprof->class_dev = device_create(&platform_profile_class, pprof->dev,
+					 MKDEV(0, pprof->minor), NULL, "platform-profile-%d",
+					 pprof->minor);
+	if (IS_ERR(pprof->class_dev))
+		return PTR_ERR(pprof->class_dev);
+	dev_set_drvdata(pprof->class_dev, pprof);
 
 	cur_profile = pprof;
 	return 0;
+
+cleanup_class:
+	class_unregister(&platform_profile_class);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
@@ -181,6 +214,9 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	guard(mutex)(&profile_lock);
 
 	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+
+	device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
+
 	cur_profile = NULL;
 	return 0;
 }
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index bcaf3aa39160f..f81c3afcb7575 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -29,6 +29,8 @@ enum platform_profile_option {
 struct platform_profile_handler {
 	const char *name;
 	struct device *dev;
+	struct device *class_dev;
+	int minor;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int (*profile_get)(struct platform_profile_handler *pprof,
 				enum platform_profile_option *profile);
-- 
2.43.0


