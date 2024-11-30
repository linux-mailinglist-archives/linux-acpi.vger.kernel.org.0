Return-Path: <linux-acpi+bounces-9817-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B06D9DF0EE
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E861A1644DD
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB55A1B5805;
	Sat, 30 Nov 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jiCRChfV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08DC1B0F0B;
	Sat, 30 Nov 2024 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975565; cv=fail; b=UzVunNKpDTFnVNivThGWcXO5X4uZsRrQi3pSQ0TgJVqMGF9SW66mbSETtk3Vd2Vk4AkyY15t6n+/ZQkw9l2hqN30z2Ui7QEjYGdkxN4Pgx/SKwqOC1xX4LbuCUZDpnBfPwb3LTynxz9c+bIeTybVuo8j4o3FFYrIBvJyLnAmQ/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975565; c=relaxed/simple;
	bh=xJ+M4Lg2cIRGE7DzFAzUz3QMC2iv+n5Ah8qSAwPX1zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7AZWnVeBkP6TlR3HmHutDcN9R4ECi5gYMRmObwSAiJTMZ9TSOKW75cSIZ+aDB/YcyO/LHPy8WuOI/nHzhB31sylTHr3pRxSQVuOKXv3X1lby2HtrsO773SGIGEeZxA3KkQL4Tm1NMQnrdkIwjpFzAScuyw4VKauc8xT2vsRSng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jiCRChfV; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haWw623ESxup+Y3ktPqa6AfwZi3sg318or5DoJ9C2If2hrT/kcuawt7pyxBjVXWZ7pZ2dCXhyUjJPsERDWganFM8IHkme/WNs84dqym6gjCm7GE3ITaVJIuHqL1ZtsWam8uTq8AdQUczu7Ijs0f2NWEZZvLvuD6eGG76tOlqkfMcSb8qAy+NHUX8uyt3aw/sFc1dJ14NRPAObWR+aB39IKUiz3ESmbDu2SnGNm1Q/MAAZOIHy028rVo7Nyd78AWWwAHM5CnzmqmsoubW5g7pmo/XNX133jD/Uf3Sn7HQrS5i4g9vyGX/AVkqvE6MVmb6I78WsrykyV+IwKdZnbw3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKN4rAzipi4gAsFai9pIibJf+kkEH1x3D/3vlXFg0D8=;
 b=DLRavCF05/BAhVWMldOEQkpGIZ/KmJKaKuXFaPxkhdQxY0b+0cTI4uSzMxqqiZIA/Yzj+Whf8RobTJW/xCiuleJgMvq4PRnOVtQ59waQMeQfdw1ScLpaxOZmEkMFrEQrgZRbUgCWqpxWiDcYMcz/Goy53WyVogwWU6b2LrO55H4g9jTwc2VRQK5moy4Hi5WzGIWh8F2AXuPXkgvySLtLg7tlEeUJZTU6EkSKKLlfVu+UIJUiSiBS3ftNVkBF2Lxo9Cr7U6DqQXZOUYgTmtbLJR8sweK1F2uVa8f9AOWkEmIPON270R5qzvZkD4Q6R0iY2TFmFnLYu89f65CCEfMFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKN4rAzipi4gAsFai9pIibJf+kkEH1x3D/3vlXFg0D8=;
 b=jiCRChfVRt8MvhWCcrE/kkaFYAxIMug2aTfZgwNqrYdcnMmHhSThojxOrnQR0e0El3PcEcQ4drWSRZAFL88J9egHsBZZBeXsg1o/wV4/w9b6IvuD82AJkqaWmLZE8zKk9tzFx3oRuffehcXerQeC1EPdMvA+EPf2e91VvGK1TdM=
Received: from PH7PR10CA0013.namprd10.prod.outlook.com (2603:10b6:510:23d::9)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Sat, 30 Nov
 2024 14:05:57 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::ad) by PH7PR10CA0013.outlook.office365.com
 (2603:10b6:510:23d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Sat,
 30 Nov 2024 14:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:56 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:53 -0600
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
Subject: [PATCH v8 17/22] ACPI: platform_profile: Make sure all profile handlers agree on profile
Date: Sat, 30 Nov 2024 08:04:49 -0600
Message-ID: <20241130140454.455-18-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 033cb31f-9eca-4a43-18f1-08dd11481c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JhXfx43MaaYL9PnbL9a47cubFfOfhN7sC+Ygwwa40S3V94X2nIGKMMSUiUIH?=
 =?us-ascii?Q?2jmBWHRBRqhmLowhHSsmiKJN3xN+cpZ5frmDbrh/rqoWGRPk/7UXkBL6qDVB?=
 =?us-ascii?Q?czvLnUO7FDu35BQjkudI8EOfn36Ua3cYBBp12mjnN4g1Yp0kyec801e/naMw?=
 =?us-ascii?Q?YtvO2Qh1Ol9U/FlBJzso+GWbRM/91kGR/W5czoX16dbtDD5k09a5cwnaqCbr?=
 =?us-ascii?Q?amAu+K3cko7n5cxO0OTvotw17fhPDVcujFP7ubdtE+mefKTs2tWaBmPfMThL?=
 =?us-ascii?Q?wqGP69TzTPfA5MlqedoKZAqVucMmgy63jmIkM2W2bBwT5wHiIpB8h2UdmIn5?=
 =?us-ascii?Q?ueq65oFZY7JdTsT0BuCa180C53YdQHwVw7mFk6dI6uGcIgywXd9kfzGgbgCS?=
 =?us-ascii?Q?l20lIo7Hb8vv8GzelyZrjU8PrnL7xC3pbX57bVvdrOz/OKZDEFy/LweJqq6a?=
 =?us-ascii?Q?ETkrVeAJFG2y9ueZRB8WgeW2T9ic3xFrIGn22DqQKNcHcCCZyIKzu0GB8Tzp?=
 =?us-ascii?Q?DiXLQQhcv/as09jPuv9avlXVgsbIIkwOj06i2KqoENG4MrLZ0m4fa/pj1UxH?=
 =?us-ascii?Q?7R8y9SrzfjwT3eFupdysxFx7VSgM9kewURkCp16y6dLGbzG/Nby+NywoyAR1?=
 =?us-ascii?Q?ozlKSp1V4+MCjUOFDVQ6P00XHwpaNwUUkXe2iDP7eiY4OdOgWjZJ2jgoDlqR?=
 =?us-ascii?Q?iSEErMcYlqdwxaxxHjVAjmHMTsIqNwJ9/z6mRdZR73lhxDWXgHtBwN/gvuoA?=
 =?us-ascii?Q?OB/0+DBtwmDByQjOntOHr7+iU79KfzLbpO6pamFiN/Mc/0rANC7MnKFBu+mi?=
 =?us-ascii?Q?2eNqZH7bcoFVDcABwSmCJ2D/ajYOjAbc/WQooMvrZ++2TyUBaRI7TEiwtCvY?=
 =?us-ascii?Q?rtfLzV9mleb/3F/L3UCfV143xD4s36cq97hKdL2mlc5KqqgqVqT+tpQmvLNe?=
 =?us-ascii?Q?XLXGIuOKtTf7jXlAxsk6GAhRwZpaEXB8pMbXBAHsY+OtXQ4uxZxcsvmbVEtA?=
 =?us-ascii?Q?re8oZTEoz76drn4t2CLOZKmZmZOKIj8rMEFV39H3qmumdVcVRHjjnaEiesgB?=
 =?us-ascii?Q?Xmg6lbzu+bLoKEUZhqOYGG+2v/McGdtXG1/TamO+X2WMwwEnzFN+u8nMskyL?=
 =?us-ascii?Q?9vHqUQ98xzj2opjq1FpCSyGySJncr+wa50biqj/RpJUmvkxpjyO9jmvdrHNM?=
 =?us-ascii?Q?gdOW8XJ+jAZEZmVjMx79k5QDuCxf9p2MFrwH1o99kUxxOoYCOyvde/Yb2y4Z?=
 =?us-ascii?Q?eX8BQpaxYMhalCrOYYePbpEp8Dd5mPn28hjDcogYFqqbD68K6HV54TRv7V+a?=
 =?us-ascii?Q?0vmj4Z2sy/zIaPmf0qE1Hwl7X3h4jUDrtZ24JrQY6cOkWfhSk4B/ZEEMMru7?=
 =?us-ascii?Q?7Hdhi+n4hL5urBEvegvlYUM4c9RmiZTFbRVamfEdeTK0PoZb6uRczQsiDlY9?=
 =?us-ascii?Q?xBh7CT4cDizgESEn54UQ92HD9spJ3Oy3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:56.5940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 033cb31f-9eca-4a43-18f1-08dd11481c5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002

If for any reason multiple profile handlers don't agree on the profile
return the custom profile.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 119 ++++++++++++++++++++++++++------
 1 file changed, 96 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index a9cd13c5fd39b..d5f0679d59d50 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -66,6 +66,22 @@ static int _store_class_profile(struct device *dev, void *data)
 	return handler->profile_set(handler, *bit);
 }
 
+/**
+ * _notify_class_profile - Notify the class device of a profile change
+ * @dev: The class device
+ * @data: Unused
+ */
+static int _notify_class_profile(struct device *dev, void *data)
+{
+	struct platform_profile_handler *handler = dev_get_drvdata(dev);
+
+	lockdep_assert_held(&profile_lock);
+	sysfs_notify(&handler->class_dev->kobj, NULL, "profile");
+	kobject_uevent(&handler->class_dev->kobj, KOBJ_CHANGE);
+
+	return 0;
+}
+
 /**
  * get_class_profile - Show the current profile for a class device
  * @dev: The class device
@@ -246,51 +262,108 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 	return _commmon_choices_show(aggregate, buf);
 }
 
+/**
+ * _aggregate_profiles - Aggregate the profiles for legacy sysfs interface
+ * @dev: The device
+ * @data: The profile to return
+ * Return: 0 on success, -errno on failure
+ */
+static int _aggregate_profiles(struct device *dev, void *data)
+{
+	enum platform_profile_option *profile = data;
+	enum platform_profile_option val;
+	int err;
+
+	err = get_class_profile(dev, &val);
+	if (err)
+		return err;
+
+	if (*profile != PLATFORM_PROFILE_LAST && *profile != val)
+		*profile = PLATFORM_PROFILE_CUSTOM;
+	else
+		*profile = val;
+
+	return 0;
+}
+
+/**
+ * _store_and_notify - Atomically store and notify a class from legacy sysfs interface
+ * @dev: The device
+ * @data: The profile to return
+ * Return: 0 on success, -errno on failure
+ */
+static int _store_and_notify(struct device *dev, void *data)
+{
+	enum platform_profile_option *profile = data;
+	int err;
+
+	err = _store_class_profile(dev, profile);
+	if (err)
+		return err;
+	return _notify_class_profile(dev, NULL);
+}
+
+/**
+ * platform_profile_show - Show the current profile for legacy sysfs interface
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ * Return: The number of bytes written
+ */
 static ssize_t platform_profile_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+				     struct device_attribute *attr,
+				     char *buf)
 {
-	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
+	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
 	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
-
-		err = cur_profile->profile_get(cur_profile, &profile);
+		err = class_for_each_device(&platform_profile_class, NULL,
+					    &profile, _aggregate_profiles);
 		if (err)
 			return err;
 	}
 
-	/* Check that profile is valid index */
-	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
-		return -EIO;
+	/* no profile handler registered any more */
+	if (profile == PLATFORM_PROFILE_LAST)
+		return -EINVAL;
 
 	return sysfs_emit(buf, "%s\n", profile_names[profile]);
 }
 
+/**
+ * platform_profile_store - Set the profile for legacy sysfs interface
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to read from
+ * @count: The number of bytes to read
+ * Return: The number of bytes read
+ */
 static ssize_t platform_profile_store(struct device *dev,
-			    struct device_attribute *attr,
-			    const char *buf, size_t count)
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
 {
-	int err, i;
+	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	int ret;
+	int i;
 
 	/* Scan for a matching profile */
 	i = sysfs_match_string(profile_names, buf);
-	if (i < 0)
+	if (i < 0 || i == PLATFORM_PROFILE_CUSTOM)
 		return -EINVAL;
-
+	set_bit(PLATFORM_PROFILE_LAST, choices);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
-
-		/* Check that platform supports this profile choice */
-		if (!test_bit(i, cur_profile->choices))
+		ret = class_for_each_device(&platform_profile_class, NULL,
+					    choices, _aggregate_choices);
+		if (ret)
+			return ret;
+		if (!test_bit(i, choices))
 			return -EOPNOTSUPP;
 
-		err = cur_profile->profile_set(cur_profile, i);
-		if (err)
-			return err;
+		ret = class_for_each_device(&platform_profile_class, NULL, &i,
+					    _store_and_notify);
+		if (ret)
+			return ret;
 	}
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
-- 
2.43.0


