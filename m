Return-Path: <linux-acpi+bounces-9676-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B39839D2D6F
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 19:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85232B358A5
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BE41D5CC6;
	Tue, 19 Nov 2024 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KqVVD9xL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A77D1D4333;
	Tue, 19 Nov 2024 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036884; cv=fail; b=b9UgT1LZAmDa8grCv/FW7NnDkFr9Gt7uupKQOE1EpK4QXa1NeOpltd/r89wfEWD/rkc3i2dBObjaFJKsZlndcB/OK1TX45aCCkdnEiYlqQ9iHG277ml0jjDmDP7XkFTceBFh1JVLmtfa597HUTCDBxwpW1j1aUZAw48BeQ89TwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036884; c=relaxed/simple;
	bh=wBQDnDbMvL1S6Enbnu3r7J+KMcdaAx15fZAfucZABb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umuDAJkoDNPRwDhVRdJO2o8PhrMezLzkzP2IlwKJlNOqAoXN/oXJBgG6JvecDU1epKMFqdfvtWr/1oPHGvnR7I1L8PzRnzwnA+NvhFTJxo1YxIUuBeE730hOoR4PSJjF+WKhP6NRPSAMpEv1Rahd6GwPNvqjrBEByxTozlMGQoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KqVVD9xL; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnrcqd9EkW5EWBjMweGi7Byig0ANUSrToCtmYZmMax6xfLx8QcJZJo1RPTk+xJft4+cO0cDWrUnxGYfdS5SFgZhqz1eYNmewQHCpfJZ8EC+nUzwaWPVkOOlygjOqyJr8c2rrzeTyTl9lWyYeHWSFfg/mNOHbm4Y0mcG6xBWLDWBbWXmXnMlidvvdDgtq1R1Ao0r/BH095/+E7jbBbCVrPopStodQ0FSiXoqeWDI78jZnOKQckj4gDjJxSROyyvK629zvUAREA+OZmn79QbXBZswybhoy1eH5haAtETHyrgw1nnlX9/IWY17zWF/JrXHPRmYxfaFfIAKh2Wwf4Mk2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8DYtwULlzPhvvL2ryCL3gCt0hyAcSnLlGYhblzyqNY=;
 b=Zfk22G2iKsrA/y38+U1j9V8TDGY5ihLXdz/9RTfBgjdQtKxAwLmq38BOAuzIjtjEXI0hhChJs279qOP8ZfQkQSKuZgRohRdgY9qwsf7eWiNrrTe6BDC9HW/uhbSz8v0lcwbG4QEIknQBPfg9OsygoqPQvqSh1a++ynjzYcIdFROBZydf8fxYPNoa7LHGaZEzaMFbmhzQufg2aCUumqO9Nqinpbg+QNy8oVldHMIqTJY86Uj/n/5yiQ0JI68/sKdpCvDlaqjz3Jl1IWOer+w9b8F6aggk1e3Loq9q8GZVhOrOxealF5q5DTs5YqWPx68g+gj99VRLex7V62osv6NHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8DYtwULlzPhvvL2ryCL3gCt0hyAcSnLlGYhblzyqNY=;
 b=KqVVD9xLQUjWcypc3wAKeu7XLZijtkDj66chsuEM4Iz5gE51kCnr2hF7hXWt0gA6MFpLL5QtvGqVch3QgM8dT1AyYsSSxlwwL9lkKX0QeqzzcHQwEO3GiF3JbmNl/x9vRSbc7HHXijVpYeNngXiPmJEcUoh1s+clvCjxzTAEYtk=
Received: from PH7P220CA0051.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::13)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 17:21:18 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::8a) by PH7P220CA0051.outlook.office365.com
 (2603:10b6:510:32b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:15 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:13 -0600
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
Subject: [PATCH v7 10/22] ACPI: platform_profile: Create class for ACPI platform profile
Date: Tue, 19 Nov 2024 11:17:27 -0600
Message-ID: <20241119171739.77028-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119171739.77028-1-mario.limonciello@amd.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|MW6PR12MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8b494f-42ef-47ee-a6cc-08dd08be92ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wlgWGg6OeOf3IA7LIOZ6Q+FzSj1hPmCenMoP1ZpKu3PtGOQGhvGyPDgxuYFn?=
 =?us-ascii?Q?sk4T57+G0MKRfGmrOx6q+NkbaaREjbxNKYTdadF+hapNm3Po8Woe/dOZlTPi?=
 =?us-ascii?Q?nWpmenVXVURo9/kjXv7vrUw/U9zwRwnBEk5lRpMS8tUQXDdvF5rlC9p/tlmg?=
 =?us-ascii?Q?ulogdCpiGR7nW5qg6O8eR0eMrwALhL3YVkjjAylJWG9o5OOWzVVbcK3Y0Q26?=
 =?us-ascii?Q?dOZZ6iH6RaDQbG5Sn9CA0x5Idp1JS4UPxsJCiaA9jFdsnJ0Br3CYRX9F1iD5?=
 =?us-ascii?Q?7iRcRznhOnltmNwyCMHQNps6Yrg1++qk34X87/uNV0XZaCAmsj0R/rs9FWJv?=
 =?us-ascii?Q?c0miCuX0DLGVCtcXv3FhMC+12cT0kPWdiXtGLFjvftk0QrZLzqMZrELTVXn8?=
 =?us-ascii?Q?DuqwjQ43a2JDakiIBjKCtJuQwCCWoN6TH6TExC0Z96f1g7Msd71JcuXd6Pc4?=
 =?us-ascii?Q?+96ZhUGZ38Tu5BIB6XBzbHfs3tkzjoD8DUrIK1dRNlP3jm3cbDoe+Mz/ahwa?=
 =?us-ascii?Q?ZingbmIrRPs8lh8OBzsKUjtRSh6c/mkBte657PRMgFFJHh6UZRcl8aUXydBl?=
 =?us-ascii?Q?lMB4k40bDpjWmGwbiepxMJGT2H8cp9Ihrc1KGIKd8TesztkyTWKqMQgsB8QG?=
 =?us-ascii?Q?Yc/5t10GFfINt/YZunoCFN0r0MDTZ42eIZ1/UqP75VdmD/c/y3jEwNH17lLd?=
 =?us-ascii?Q?EimNPHTNU6kCPn1PaUmVvsn5lz/ldrrP/0Eb07tx+XT1VJBHrpQtIMm4Rz6q?=
 =?us-ascii?Q?gHBSrQ6IFaOe8vtUBrIyA2/nDQ5lHwuQ0G3G8TLA7Kqx5K8t08erPgvpgRUl?=
 =?us-ascii?Q?IBCj8TRC+CDz0zSEJFdQmcACBUON4YHGbD4EKBUoSr+QqLJEc8VQcaC/1+un?=
 =?us-ascii?Q?TXHMvbT+JMFrb5pUFZLvmXh959W3vbLUNZCBUaFitV47lO4Wy2BlH6HPKThV?=
 =?us-ascii?Q?hkzptK2y8EUsPZ5udllL6ubXAe1HaHCCYe45mvlNibURdzeg00U+eJ2ogfXm?=
 =?us-ascii?Q?kQwvFAYJs6tzHWp9QIC2xumm16/27Z/Bx1whXn/MsNmc2OIjwWjzhEaZOYkA?=
 =?us-ascii?Q?Ru1TLaER7S9kOVcw9fVTOpP85gDVQuK8EMu3RXvDCXN3T68Q1TnDtCWudHut?=
 =?us-ascii?Q?0uaR4tZlW+qg0UTZkG25aTIPifFH6QQH1vB98rWT6s+xkRpG09fmFdtGPUV3?=
 =?us-ascii?Q?D7txMNujYY0/Met6/jN8YOot0SpGQbvUKDwsinJyvD7SkYE3IjE9AQBUQoAp?=
 =?us-ascii?Q?hPcUQ1F9K5MeLU7fMbRGdd609zXY5VqvxgxoRwvNAe5SJCc0mq4lHCB4bvYv?=
 =?us-ascii?Q?YidOwrujKKoQ07ukNmDKGObpQtZpLOYq4RTOOq45qGpzOonzrOEfRL82AKEB?=
 =?us-ascii?Q?IiFjeXTDW+Jj7SXggeKZxNedji9indnrQuyqZ+HC2BhkX2cKzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:15.6435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8b494f-42ef-47ee-a6cc-08dd08be92ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019

When registering a platform profile handler create a class device
that will allow changing a single platform profile handler.

The class and sysfs group are no longer needed when the platform profile
core is a module and unloaded, so remove them at that time as well.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Whitespace
 * Add tag
 * Drop class_is_registered() check
 * Remove legacy sysfs before class
v6:
 * Catch failures in ida_alloc
 * Use 4th argument of device_create instead of dev_set_drvdata()
 * Squash unregister patch
 * Add module init callback
 * Move class creation to module init
 * Update visibility based on group presence
 * Add back parent device
v5:
 * Use ida instead of idr
 * Use device_unregister instead of device_destroy()
 * MKDEV (0, 0)
---
 drivers/acpi/platform_profile.c  | 86 ++++++++++++++++++++++++++++++--
 include/linux/platform_profile.h |  2 +
 2 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 32affb75e782d..3524a2b4618ed 100644
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
@@ -105,8 +112,25 @@ static struct attribute *platform_profile_attrs[] = {
 	NULL
 };
 
+static int profile_class_registered(struct device *dev, const void *data)
+{
+	return 1;
+}
+
+static umode_t profile_class_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	if (!class_find_device(&platform_profile_class, NULL, NULL, profile_class_registered))
+		return 0;
+	if (attr == &dev_attr_platform_profile_choices.attr)
+		return 0444;
+	if (attr == &dev_attr_platform_profile.attr)
+		return 0644;
+	return 0;
+}
+
 static const struct attribute_group platform_profile_group = {
-	.attrs = platform_profile_attrs
+	.attrs = platform_profile_attrs,
+	.is_visible = profile_class_is_visible,
 };
 
 void platform_profile_notify(struct platform_profile_handler *pprof)
@@ -164,25 +188,77 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	if (cur_profile)
 		return -EEXIST;
 
-	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
-	if (err)
-		return err;
+	/* create class interface for individual handler */
+	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
+	if (pprof->minor < 0)
+		return pprof->minor;
+	pprof->class_dev = device_create(&platform_profile_class, pprof->dev,
+					 MKDEV(0, 0), pprof, "platform-profile-%d",
+					 pprof->minor);
+	if (IS_ERR(pprof->class_dev)) {
+		err = PTR_ERR(pprof->class_dev);
+		goto cleanup_ida;
+	}
 
 	cur_profile = pprof;
+
+	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
+	if (err)
+		goto cleanup_cur;
+
 	return 0;
+
+cleanup_cur:
+	cur_profile = NULL;
+	device_unregister(pprof->class_dev);
+
+cleanup_ida:
+	ida_free(&platform_profile_ida, pprof->minor);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
 int platform_profile_remove(struct platform_profile_handler *pprof)
 {
+	int id;
 	guard(mutex)(&profile_lock);
 
-	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 	cur_profile = NULL;
+
+	id = pprof->minor;
+	device_unregister(pprof->class_dev);
+	ida_free(&platform_profile_ida, id);
+
+	sysfs_update_group(acpi_kobj, &platform_profile_group);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
 
+static int __init platform_profile_init(void)
+{
+	int err;
+
+	err = class_register(&platform_profile_class);
+	if (err)
+		return err;
+
+	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
+	if (err)
+		class_unregister(&platform_profile_class);
+
+	return err;
+}
+
+static void __exit platform_profile_exit(void)
+{
+	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	class_unregister(&platform_profile_class);
+}
+module_init(platform_profile_init);
+module_exit(platform_profile_exit);
+
 MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
 MODULE_DESCRIPTION("ACPI platform profile sysfs interface");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 8ec0b8da56db5..a888fd085c513 100644
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


