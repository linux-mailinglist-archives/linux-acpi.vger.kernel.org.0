Return-Path: <linux-acpi+bounces-9468-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2517A9C29F7
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD121F22AC2
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA65F14F9F4;
	Sat,  9 Nov 2024 04:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b80oDnBq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2F814BFA2;
	Sat,  9 Nov 2024 04:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127360; cv=fail; b=GuY/DvA2+/RUMdk9A5+zcRtbTEeupUuSwGUuv04BtC7aVcY5aggMBttfNidc4iur2f4alovhseuVisKqZDUcnSHChNB2gAb7Me5UXVHtLmYVGsNmoGynAPi55CYxRFbHLkxQIsiimSjDBlOw8q2pjZ3Sx8ofaONEPqcy8YTTtAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127360; c=relaxed/simple;
	bh=D+yCQxbo6OQVYgq4rUDJX6Wq9/+HRYxdcjv7STWA1cE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtaoegAd6Kdr9zsjx42xYbQyWr2FqaVTo9lxHlHnUPioGqRV+rVzXzDENWLHOTFsJqYPkArNIbWFh/80zFIH3Grmdw+wXt4FCS6U8UK+rpCvdQmgkT2OW2defj6bPZu0JJucVCzT8ZUGsO96fLwK5EM6JUhwItkOo7KCnZchQrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b80oDnBq; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDRsRj3WpSONFMN8ED3oJ3Ud17IkJvxx5Q4dGBKcIT4C6zieCxY5TJUdDFidlOAY8MMau7oNbXBvUIO8og81xoowg0lKiQy82RVyhKGrRrveo94Lwkll2LaQaY5KPqTVjOrjL/UnhAvrVO/2DkbgEcOyGmQCLN/pUSRvA7ZXcXqgg3AsT4Q0DarcJO0qDdM+FQnKUpRojnxOMfDjW9Ei5CAVl+vdAPhs4+xOXj2P2MCTv7JPGgvOG2VvST26xx+gt0++KSdquhue6e77GMvkDyd4RBJtpjsFYlCqst+YDS9o8afAHHs5GFcTxasGkyT3537tXkK+kiMoGVW7h9PxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmA0qmmNZISG15FOi9ca4nKDuX+mtJBiIBI0F557wD8=;
 b=J/dMz5UqcImCLFq7eRj4bELv/d5zuXp/dGdVduiv6Ub3rUzYiP/D6ehYxuY64Zi+A8uUzeKfmh88YFGR53sVPGezzKpKSgEgh75AuG/U9YJ/qVTKMfCrewAZZn3LCaRHMJnFLTgf5VMJH0Cqnzr5EXRRlnTFaJcT1DDuMXuweVgXv274C8vq8PuOJ8y51zq++QWtvSNoRXDqeF3n6W+I6fCxSE6AXbdcLPMAkvrh42LZSnZC+Oghk31mvLoyP71i7ZID/xoptigpke+uVlsV9Ajo6gitAxHRqxRzaw9ReC7R9OEf7g93UlwDEzustEmw3+59VTPzNJbp1MmjwC71Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmA0qmmNZISG15FOi9ca4nKDuX+mtJBiIBI0F557wD8=;
 b=b80oDnBq4h4LzvhHUVhpfbDaR7+zNAEsHMbih08YAnyju1Bo4UE+ZStLcGQ47lFEOaD714yguYAcvdcw1FAj2AtOjoVbtTfmF0LdwixPptJN2XxiM0xHGodz5XCAEvFNmuJ7r3/QDScTPae0pSyND/Jb/T2vouQgGr4wjN4Il6Y=
Received: from SA0PR11CA0166.namprd11.prod.outlook.com (2603:10b6:806:1bb::21)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Sat, 9 Nov
 2024 04:42:34 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::fc) by SA0PR11CA0166.outlook.office365.com
 (2603:10b6:806:1bb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:34 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:32 -0600
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
Subject: [PATCH v6 10/22] ACPI: platform_profile: Create class for ACPI platform profile
Date: Fri, 8 Nov 2024 22:41:39 -0600
Message-ID: <20241109044151.29804-11-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb49b3e-a894-4f93-4433-08dd0078edba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hD2M5cuPykH55vXN4pTg9NWmQ4fI9AkTHQYHCSBf4OUKRezF2IOSdyox7OKx?=
 =?us-ascii?Q?mugHyDFYSFDo9wVbiNeXdXKecDJHaPc85T1JalWN8q7mRSxd0E+zacQT06N5?=
 =?us-ascii?Q?Uyjhg27y7Xyzy4ZpBAf6Ed8si+WiqLMIuJSgGEEkJMoSX07kSvo3Hwz2Rnbl?=
 =?us-ascii?Q?XjkDkKuK81ISjsUvzbd9Jr5SqvC/0ri7ZStvQrwDmJ8tr81bhVk1gHpycGJb?=
 =?us-ascii?Q?BsfBilklGIUbZvrSNevpxqECkjFEfKqWEsxZB9l3JfNGu6YoirUvHf4obTgI?=
 =?us-ascii?Q?N2HjlUEkl5q+A8he/kUtGM7xMnzPL0pCLDddqv954Gn/9y7Arh72kYy41vhG?=
 =?us-ascii?Q?+TnYHYzb88nX3d96kGjuODWzfK1EMCLtkQ075k5MR4/dPxBQdgR4TBo/Eyrt?=
 =?us-ascii?Q?FZB/muIrrcjMEcKe8iF5tFubd6iSJAVBbl07WyPUyEILwysBmeWMX65aqPw2?=
 =?us-ascii?Q?kY+GUZJ7hHI8XmCXqjYOppA9nabp5bVQ0sDpLm2iP2WEuSb9sIuejVxvssXC?=
 =?us-ascii?Q?JfU7mk3+8f1K9OC+KxFBpwAFQit76PqWwQc3BGXd7Hcbs/A8Oe9W/lPEqUiT?=
 =?us-ascii?Q?cTZeXEOfBXa++RtILEKKoOLG5/2+vjhRXVNoF4qyd0FHixnkwx4SCjaazn5A?=
 =?us-ascii?Q?WkfsmAsB4fxr8tXQF0GQ9rESShPjKeF0Dg5ShPe5lpSWrTF1XP1Rb8aKmV0P?=
 =?us-ascii?Q?Gl4qeSjQLouBEyf1ZrT/vxjvLOKok7qD+4zXwOQGK6AmkdRae0lBDIBZeKyG?=
 =?us-ascii?Q?dj7XiwYBphcA0qDRu/8sGSHH0ODrKAjsaK5NV6MfrYsLV6Cn8ztNa/VzdcLo?=
 =?us-ascii?Q?DZsIO08611gkjmv58yVFGcSHHq4Pf7uleXLEp+vKWsfiIRn4doBM1BBAA/yi?=
 =?us-ascii?Q?PQtPHxVk7upmHckge5papO3c6L4y5KIkVuALlFETLS1T2XRJukhVSAugk/5g?=
 =?us-ascii?Q?AjvrEtIDrkHGd/AmDvgAmzvirGBHyJdpkOAc/bdY0ql49uxi14T9MP7EHDaD?=
 =?us-ascii?Q?X670ewwH6kwF9/Gx3rg0BSLX4ui5kO9uOLhKlHxTh5RLZcBeo59UTD9/Ttfq?=
 =?us-ascii?Q?l4+DlviDMJiwEq1GTcJK0ajGHAxFQjoPeTVzeV5gla0AjKMIwKDpyo/kcSZ4?=
 =?us-ascii?Q?b71BW0NlUvutyo04jLa1dKcNzouapJU2Qe9JyE58yzgzwy9faJ8jz3DjHmnv?=
 =?us-ascii?Q?m2Tmve5riOOYCYayjaK1uzZpNVv0DCz6Il+PcVIa+4eHA23vm12yZ1JmS69k?=
 =?us-ascii?Q?JsCfDsY4aqG7U/018Y1owJkjHKnaiWwRk78EWYroflqGrIUcbar/KVaIQsXy?=
 =?us-ascii?Q?q10L3veAnC77op7cUP8z8cavTM1lGatxdOSZpkc1KQyKIWGCiubIh2JuG6os?=
 =?us-ascii?Q?aqWCN3y4JTP7UTVP3w8UFASgEtAptr1NoYZhzes8tTFheaopmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:34.0180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb49b3e-a894-4f93-4433-08dd0078edba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496

When registering a platform profile handler create a class device
that will allow changing a single platform profile handler.

The class and sysfs group are no longer needed when the platform profile
core is a module and unloaded, so remove them at that time as well.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
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
 drivers/acpi/platform_profile.c  | 88 ++++++++++++++++++++++++++++++--
 include/linux/platform_profile.h |  2 +
 2 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 32affb75e782d..ef6af2c655524 100644
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
@@ -123,6 +147,9 @@ int platform_profile_cycle(void)
 	enum platform_profile_option next;
 	int err;
 
+	if (!class_is_registered(&platform_profile_class))
+		return -ENODEV;
+
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		if (!cur_profile)
 			return -ENODEV;
@@ -164,25 +191,76 @@ int platform_profile_register(struct platform_profile_handler *pprof)
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
+	id = pprof->minor;
+	device_unregister(pprof->class_dev);
+	ida_free(&platform_profile_ida, id);
+
 	cur_profile = NULL;
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
+static void __exit platform_profile_exit(void)
+{
+	class_unregister(&platform_profile_class);
+	sysfs_remove_group(acpi_kobj, &platform_profile_group);
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


