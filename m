Return-Path: <linux-acpi+bounces-9810-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D69DF0C9
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A974B21449
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1741AA1CD;
	Sat, 30 Nov 2024 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MYbTL7QL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44511A9B4B;
	Sat, 30 Nov 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975546; cv=fail; b=lvnHendQ8rXQp2KZFm3Cah94P48LrUzouapoRX19kfzogOxhF4QBF6QBgVDFlXiO4W53LE4uU7D0WnMMulMUjZzeeKoAXkQl3qsKQhKxCVyavSKOQG7z3JFruUq7z5p/26lCZHxaQkf3yI+eZYmVMHNbmmuwzOk4DyLuiKoYbJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975546; c=relaxed/simple;
	bh=FI7FSjcQBb4qdhj94EVuAigUaPmcDtV3WEUVFUlKcxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/uQcRgJnqW5EFqPGhKeba29vSVZrPCsZq8WyH8rUO+DHW+uNcyHGodMt9Bl6bqWVcNXQRV1y/vqsILENcFt0SPfEK1h8SS5QVDaIdjpwhuvnD2bRcmKDue5SJ/5iYPOc02Jk4jW7Xlpmq76MYzclP47FLiqZFHb47RYuAVbhl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MYbTL7QL; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eM9Z/vMEwPb71Zg12zJW+Q4hclce+5KxquVNE7nUOGnc8e0nAW5gjQhCZzsod4ntLqCLAQXLHrtRdV8RUmBttBiEF9V0iiPaSLYnOJrY9DWW+u9wT4nuhfNwblJQ2gHajAWGyY9CFTN8wdO+Ww9gW+gHHnyD3VEi1sErw+Yc2Syt3JM1o21zDRt60Ybg2mt/a2C+O/UeGWQxzjFa3Z0ArzFbqd+az6wkZyCe9PgJc5BsNcUNxuE1keQiFwuhCPl/Q5tDjznO5eyj0y/RRqbJ1/jcofCvOTmnQHestDlkBGE8E/YZhNwNd1WvqbyJd6Qb6m4C6yXOYdXtlfG2wbcfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AlGnRfO7dlsSelCXZkRBoMdAmTa4FQanRex3onNr0I=;
 b=lKfW+/x4lr3qKmYpsjIl9TNmw8fcFog/pWd85bl/JlS/T/XVJk8EAB5NGyEJ70SuGlAt2R7PedOuIgL+jnoLRK5+SeIIAYeyvrmf6o6D5AI0qbtdFuFx6hVq0eyUSz5x0qDQQ+j4yDjBPxg9B0sSqFO7NfIjtixwBIoHzLlw4omAaA1bZzdeMPrDiUbPa/fRddKIE+mI7Ubkf1ulGnF0M9Ws2H2PJLWH8+mzQntmJrNrtv7z5RZXKHTojYu39KtlHbm2wR+92rzKW8W18exC0EQBGIhQ1DF3KuFZtZeSxspV9QBDbHSBasqfqpNJdgZ8s5ApdF9Df9h4s0yCDPHz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AlGnRfO7dlsSelCXZkRBoMdAmTa4FQanRex3onNr0I=;
 b=MYbTL7QLK1vMp8vaVl9oOd5U1EEzNisRIC5jZyyaC/T11B3twm7btIQxc1WeVOYkVV0uXqM2S43BW+ZDKzS3neY6eQ/CBtr3iP09LDhC9KEcGDlFlHbPqwXevQgE1y8W4ONeIXnL4BWSO/m4Dh7dRb8z6F4e0vExto7VqmjmBLw=
Received: from CY8PR10CA0034.namprd10.prod.outlook.com (2603:10b6:930:4b::11)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.13; Sat, 30 Nov 2024 14:05:40 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::30) by CY8PR10CA0034.outlook.office365.com
 (2603:10b6:930:4b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:37 -0600
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
Subject: [PATCH v8 10/22] ACPI: platform_profile: Create class for ACPI platform profile
Date: Sat, 30 Nov 2024 08:04:42 -0600
Message-ID: <20241130140454.455-11-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: eab8c6d3-3c9f-4af8-221c-08dd1148124b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5IEdJ4sDwbs/5ylbqFeTLFB/GhHMDb6RbHwF2YhH5XpUlZJ81vAHSSidR0bO?=
 =?us-ascii?Q?Aq/6SsDY09LX+8vHEYGJdTiNFrTft8pCkpCwyrGtIA3JNGz2k6f0hAI6pSr5?=
 =?us-ascii?Q?An9wH5c8kEnxkgBc6Y+maKekj2+BF+rUjkxZzjQ6CIolNgAQ0zuX31aybkSH?=
 =?us-ascii?Q?wcJ2U0BFDJJyHmwHQ+KN+x6QKDKk9t094URm9NZJ6A/iVqvZhzU/vh9vWLt7?=
 =?us-ascii?Q?h3/TOhhYPZIaXgFWPZPV92Rr0OPFY03cloN+kLa04RpsVafp2ovGtQQEZjVq?=
 =?us-ascii?Q?IpuZ6aBC1sheuTXXjGJn6WC0mv05khCAYPCgZiqU3pKjZtuWR6Zi9dtapGC6?=
 =?us-ascii?Q?ILIHSRWyOYW0wmFOB0+3U566eBTWbg0s/53VhtDY2Cv/dmvozfnNPUUw01iC?=
 =?us-ascii?Q?OouILWxd5QKLHm/fFhiNm4P83UZczIJ1CaXUybLZTicBCOXyL3eQXV/Zclor?=
 =?us-ascii?Q?HMT9hvzyhVkmpMZuXgqqMA+tHSzDofBun6uHT1NC2vJWCnl237/L+9MfbyRm?=
 =?us-ascii?Q?ZOfGklq8vjaww56U8FAGF6MvTUXfoPkMz99v+LxhCSquuKhpJqnudp8/SVyb?=
 =?us-ascii?Q?X4I3ErGcMlfOsTN/cAigx5yUM6x50KBEqLv7fvqqAu6R+kR38CW3OkzQpJUV?=
 =?us-ascii?Q?etOka7pKi4owAj42l0fUw9/QoLR/qXGqsIAsZSwR5EnIhEKvESFyCTmqYaBI?=
 =?us-ascii?Q?E/R0M9S7NFDjEtHufSZvydInl8ttsU+m3VRSQiqGpVQfL3fXxRJ78BNFBEyO?=
 =?us-ascii?Q?pFEBt03YmKC/9mIE4KhilEBrlmW5yc54sDXr1RbezJmYriK6fjpWy7zLJjEa?=
 =?us-ascii?Q?hnnCq6uHWqdaHwDudEpD4ewFJw7ICHOWUftTDLGSIhSdMUKchMdQIfIQiauf?=
 =?us-ascii?Q?QtiV1bLvHLTYgymqKRMSFYi/fXZpbL+aN3UwPITs3RB33cPOvaa8N0QbI/CX?=
 =?us-ascii?Q?BmubIqVeCsaPDdjp2+t3/aN9nYeugaj49xRxr8LkXTb6/vYqe/0QJZEVeUFF?=
 =?us-ascii?Q?YS1n37OiR0X++2gYFA+UZKu6z3tqylcAr9Bzv3ePEGpJQ27NZURPDGijztNY?=
 =?us-ascii?Q?k/crP02KshrlgGZBEGZ5ScdfOUO7iTS5cJDR15Te7OQKqbXsVq9mdquhRGK5?=
 =?us-ascii?Q?/w5EV92fHCqcSN/NVlTcrFHgU30FB927QVpiIUlVJAh04LkERIuhxZun0vWP?=
 =?us-ascii?Q?CVV2n5KREajXfyH873YJd+a6xzZihiMApjfwxltsrIcj71AR2xzSulGxhDh2?=
 =?us-ascii?Q?w7hxfxP9Z8ACYtfur+pJSYMxuMOHYf5wzdj2uhPAbLCu28Ix5Xrh+tKTjRLr?=
 =?us-ascii?Q?NrK+l+NpelKO5H8AWi5JBW3MLxqv9s7DJIWMDc7ZOTtbHMDaxHuC1mzdxEzV?=
 =?us-ascii?Q?ATUKKs58RzTA5KTHWuEsZ7MAgG5tOPDQe0FdVw1+wFux6DsawQ/MJrjWDJwZ?=
 =?us-ascii?Q?Rq9xpQY2Gl/9SdsMclvUv8RLF9N+xM8S?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:39.6991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eab8c6d3-3c9f-4af8-221c-08dd1148124b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485

When registering a platform profile handler create a class device
that will allow changing a single platform profile handler.

The class and sysfs group are no longer needed when the platform profile
core is a module and unloaded, so remove them at that time as well.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v8:
 * Use attr->mode
---
 drivers/acpi/platform_profile.c  | 82 ++++++++++++++++++++++++++++++--
 include/linux/platform_profile.h |  2 +
 2 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 32affb75e782d..36f7b568deba5 100644
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
@@ -105,8 +112,21 @@ static struct attribute *platform_profile_attrs[] = {
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
+	return attr->mode;
+}
+
 static const struct attribute_group platform_profile_group = {
-	.attrs = platform_profile_attrs
+	.attrs = platform_profile_attrs,
+	.is_visible = profile_class_is_visible,
 };
 
 void platform_profile_notify(struct platform_profile_handler *pprof)
@@ -164,25 +184,77 @@ int platform_profile_register(struct platform_profile_handler *pprof)
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


