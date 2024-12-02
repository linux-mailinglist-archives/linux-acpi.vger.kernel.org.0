Return-Path: <linux-acpi+bounces-9856-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0EC9DFA66
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3003C281961
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C341FA17D;
	Mon,  2 Dec 2024 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Coh9bAJP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A391FA15D;
	Mon,  2 Dec 2024 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118713; cv=fail; b=Id7EqOJRvO14cWV7mOjRVQ9dExxHEvbNcISZv7hD8JHAw7xv3Y77ItgI5XadUDQpN9ZqPKxhPbhPH1G88WHPw7Va92xJTQwk+YBWes/ZbjE8RH+7xwTG3RCh+jmsxUQ3VO7cD8rgBMzmuzreX+TWADj4nks6zjUgjk7GT7GLq7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118713; c=relaxed/simple;
	bh=tnlb1jYrZFRhofbi7UJYTXe3VMdHpMv8C+ata/uZWwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bthMr4GSonvIVm4UJFD/OAGxRGqKTJtNeqh7PKqFHr04u2Q0Gf5lJ26s2BqRXtqjeU8cA6t1HYKkb5g7WKEpzDLVD5StkpqOaQZzB4qf0WbgmGpAN907FSBrOKpUxNjmS8YX0wPIu2KPE2XTgdEwtNbIUpKV1Av34/a35CpFHL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Coh9bAJP; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmbiXsyMRjtLTh/h1UzL4u+YbCa1QhG9M8ieor1/7HZhVkkVG63Or9zVyVpogQjgeE3eanEaBJJEyxYSF02408p0s7hmbyhVq7sQzeBr0i9SQKIWSST8GNTaFvuA6KrbGi+R6Pq7P6ZCNRS9SLNg5k1Ip+jFwrnJtvlJeIiEwcm4mxKwDZK6KYmRzq2+Ey6+ACkmtXOkpCgoWxL5LvVEC4uwIUuozpnSeH6Oko+xzqGriR0pH772gOJuK5uZ/7F8mp4DC6h6gyIKgg2VE533fV1PgQdvs4vM2xnZsuzTDC8G/Ej+u+SDqhfKUws3IEmu40Y7z69k+YgEYstprOQVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoW0ZqmQ9VFosdHm3pny8yHfT4BkNi2/J+aCF6hRzy8=;
 b=vt31cn6gdbVgKj7KlNsilb5NP+zoZ1ML7JVF2onYN2hFJTaFS76jAhKYfQtOy8OdySrPaV+qlIu/sPc+arbl1B8EFj5qGgNrmrfEJgZUHXEMFVm8dDZYZsIXGA2vUKyzxiH/gL1NGnOS53JoR+yMlJ0emzb5cMPTGvokzdlvrmYdseBJAFIRwQJbCk4tS5o2L2jas8WvCMTJrp9N1bPfNoFyZAjXaReh1VNH2wxbeV3h0yyjCBYOrZhUWbV2ZesDaj0VLGV7efOVPzO7VWlwI2kp2ZurBF4tGvr8aH5TLi1TWE58p/FILfAlKLysVa6mUWTbJHzJ9lo0vC8KXesDpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoW0ZqmQ9VFosdHm3pny8yHfT4BkNi2/J+aCF6hRzy8=;
 b=Coh9bAJPWa21HqBHUCnR57DP/bIOHOHUdGc0yvSoWMWHL/CW9ms2dAqqM6L3wPoidB+yeOp1pV5ZD08/8SDgY97pZiZ2vcFXQ2q9AFdCK+TLhyxTmbj66dSEU+DOvKM+FDQbx6dt3FttQtnfJ6v65auxP6IzssnxhFifYAexU2g=
Received: from CH5P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::17)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 05:51:45 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::80) by CH5P220CA0019.outlook.office365.com
 (2603:10b6:610:1ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Mon,
 2 Dec 2024 05:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:42 -0600
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
Subject: [PATCH v9 10/22] ACPI: platform_profile: Create class for ACPI platform profile
Date: Sun, 1 Dec 2024 23:50:19 -0600
Message-ID: <20241202055031.8038-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: f2279424-58bf-4d6d-2863-08dd1295676d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HNo6ydGB575g2YeRT16JY/XDgrYy1YZnY8NFY7CEjBfSaaXB5NmSoiuws0zp?=
 =?us-ascii?Q?RNkCBkaZehadY1t87D3cu06zrv5bfR9KQlvlR6WlkOlGlWtXtgUz7ydXT2nb?=
 =?us-ascii?Q?qREgzVeWZZoOXWUFV/oELHlvKb3zzAOpLO1MhtPzIsrujxmKMthLyBN7dRo3?=
 =?us-ascii?Q?TzusghHhI2RiRDMr/kTT7Vr5BIGy0+L0zZH+gX4VeQn5EO/+kPojVb6JFi11?=
 =?us-ascii?Q?M6VnHpgBTD9YZqHafee3eTPEUPCbKma2FjnZPJX93FH8o2JC4PZ9ulnv7HCS?=
 =?us-ascii?Q?ut2ZtDCqXYglhrfbX2TVt8rxMoxr6IX+GNdKkWJ9YUP72atyYZxPkZKghMhU?=
 =?us-ascii?Q?84LikuUSZWuJReMguR9W9EdhAyP4jLgtA3FWXp4rGcaJSHDvzQyMViNHBD0z?=
 =?us-ascii?Q?LnQXsyVXxMD+vkx+axlZK+yHAOJbCFidL6PBaoIHBSVoXEe9Ox5fv+qY1yxN?=
 =?us-ascii?Q?7JdZ1KOo8GHDxwrXHJ0PjcefwIN63orDZWI5Q+3iQSW4ptLMDN5MCZAMVXPY?=
 =?us-ascii?Q?TEme2XeKUAvtCoqtMbNoQZ/rBH2apADojaM3Iiblg/o80CAdLPalut1msdeS?=
 =?us-ascii?Q?t/P2vrhYMIPCm2h9otjhUXpbGpyXfVl2hFgu/yjT84E37vfK01R94bEjXDeg?=
 =?us-ascii?Q?sW2es+wcLWuYXBJJx15mHssLKsBPXELHWg04j2VNnKlq+DJQkNlt4gH7wJt+?=
 =?us-ascii?Q?sROWgU89BKYxgFRFUSlRScLoEebsYyEOM3tYOUyx1iemkqLhqmL5/eR5n2u8?=
 =?us-ascii?Q?ZYIkcD0suvSGyPIrY7yu8bMBJxyS9/aBE97ZMGbMXrbSkN5sGx7GGscqfjgY?=
 =?us-ascii?Q?vC7ApFY4h2ULdnW7ehT6+F+SRXHfJASCa+xfzVgvmBgleQjPFk7ywiFdbEBG?=
 =?us-ascii?Q?HKtjXz2PVpmUqGiNfbidYtzVNWvQWRWZiJ4CCyyOdTenzdbGqOkY/JVVbguL?=
 =?us-ascii?Q?tMORzietqGwyoRoRyjpJnJciedvAu2cadMkxL045RTwvXU3TmOrNIWE7Tmw0?=
 =?us-ascii?Q?brLwCX1C42jhhk99cHnITA73iZJIMTFblD1cDObwxHr1LJMEY/OhDrq3+pm6?=
 =?us-ascii?Q?D8EdGeDSWsBUaAsIywv1WpJnFYAf5nJTkLXkTvTSNZHKxqhYcIF7AY5R16ye?=
 =?us-ascii?Q?Kv9djYLteQty/71Yi3sFwPoMB4ieKfbkLW8u9SdNCZvfHXZJw1b1/kb/Rg61?=
 =?us-ascii?Q?ipMCVI97eDhDLcWhUIOUwH/nbRz0FziNIZqID6sxyqKATfc7XSYceoZ6aoO9?=
 =?us-ascii?Q?LmesEQCZIpDQPZvswe/n8my8X28IUTCP27mMkBqp3N0j7MIGpX28u4CgQIDe?=
 =?us-ascii?Q?VkLvNYYSUVNWGJlE2/GykcDCTwlsqA2974cF78xghfMsYmQwFUnfp6y4LAeq?=
 =?us-ascii?Q?6DBlJOGCjw8ZwKR+5CPwTV+WJCab2eA7IRy6sieLqtwSOw52vTK3S8FA/Xoq?=
 =?us-ascii?Q?t7vtiJBmHohIaHpZ9cKl0TlR6rC3gkxt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:45.0331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2279424-58bf-4d6d-2863-08dd1295676d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110

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
index a1f0378f15e62..11eb60b09bac4 100644
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
@@ -101,8 +108,21 @@ static struct attribute *platform_profile_attrs[] = {
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
@@ -160,25 +180,77 @@ int platform_profile_register(struct platform_profile_handler *pprof)
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


