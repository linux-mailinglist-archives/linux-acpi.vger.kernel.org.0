Return-Path: <linux-acpi+bounces-9475-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC789C2A0C
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1C01F22494
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346CA1898F2;
	Sat,  9 Nov 2024 04:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HQxcuagd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981B13D886;
	Sat,  9 Nov 2024 04:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127378; cv=fail; b=oBCuep098iXqNb7GWH/tz09+AFxYGb8Xrn7+0KEGwP24jCflF2S2c8NM81v3k+bmnql+BY6YhiVOSulCSMa14NVeXx7NaX73Y/bG4jgVrO1WbelNu1mBANMaPtyj0cUdbJkY0Fjkh7voa70H89uUlhxhaAt1bniQvejQ4IhhO9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127378; c=relaxed/simple;
	bh=m1EAp1mhUE37Ciip74hEcu+lOeknOcMmA42WqHgr1zw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dO2+QtUa5ZtZlG7DHKTL62/zxzNvSWciMHUXjrYiEAOSD0SeYE+sA5OdFNtfbz3LRcJcykCLtkocLtACJWrcv+mdaPGzzZ/6OJJMOMhl9eDPpa0T1HbTqiQ4XALgYGUdC/IJ0i7Ty+6p1b2wwhfRPen5Y//D3ZuW/30OIQ8P8ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HQxcuagd; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZXE6CUKkGr6aiAQbueCle9hZMP32VIXdLrF+zkSWoRUifRZSPg28dIdgOehou98UyrDXww/HsClH2VEqACZvPP4YhC+mJagiEwYsIYjIzTIGzoZ/HyO4hgjdBBF/wABGhGldE7c2gn0KkXeCoOCssKRH52BKBPIDpcYaZcXVLe+82ZrMQw4q8WaRty9FvCbGP1b/4F/hg1EDiRoGKWSZcyweW2Yn1b/y1rIztE9ovJ2guTDAuqCOCOved4lqlRHXB8VpncQzsD3YdnJp8bblIM1mNTQS9o0ooLpHEtJGs4JoMxKosCiLkpgCvvGTT356miqzZsdTIwl+qN7eyw9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEXniE+ZSQVj23HmSp3rjWwsQIqfFBDdu9eCr2VUMZw=;
 b=J6sOzCcdM1GlvN36nu1GXwibfEod8l91X9McbLbwbmqWxVLSueJfnMD6tDS09ik730nhDgJJR1a+KaZw/D8myR0nE6q1vRXapaHQyu3g6ODUjqULPBI6JkHUVnoP1TtMW1J1J1veG5EUxKYi/vgKo3Q0hksVqtIFEKmy2Qse1nRcd7z+3GaJJCS32QtxRyeyEGQRGM+u6z2BUdEKURBnLr0VMeItNWwwKTcf9o3qfs2w1oS2JXYVBL+GyU4TRJDy5FNXVYO0mbt4wden1ORJsSCmCGL3xgk2cpXoGP4R/C2mtszgDuOirz36bADhcpLb9dsfT1Wrm72cXFJZzjWa1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEXniE+ZSQVj23HmSp3rjWwsQIqfFBDdu9eCr2VUMZw=;
 b=HQxcuagdUazwmSf0RTpjn2BveidIQ+n1pXHt06vTOpfypJyjoV3Ve/GVJPF0AtIFA42T4vgJlZ9NgRBnYEIepECIUhL1LBgJiZAzxHAli2p7ibkgXHfVPtuz/44NpizLdIlNGjaWJ0sHzNX/xqsFNL7jPjfisdYCMhB5r7xUqeU=
Received: from SN6PR05CA0014.namprd05.prod.outlook.com (2603:10b6:805:de::27)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Sat, 9 Nov
 2024 04:42:53 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::af) by SN6PR05CA0014.outlook.office365.com
 (2603:10b6:805:de::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:53 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:51 -0600
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
Subject: [PATCH v6 17/22] ACPI: platform_profile: Make sure all profile handlers agree on profile
Date: Fri, 8 Nov 2024 22:41:46 -0600
Message-ID: <20241109044151.29804-18-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: c10edbb7-c37a-4bb8-05e2-08dd0078f91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LO+Z2H05uha+8tZSzGNT6ld1pwXceUN4HGLhXI4ALCS4bpWo+EZmAAZtoeIV?=
 =?us-ascii?Q?hjypmUCz2PwhWvEUs5i5Ue0fC5+3t8mJdBP9kM73RD1JGkYtG8ctolrGvQ1c?=
 =?us-ascii?Q?VR7tgG5F6j0cuHqLrf4iicXRTRbwTXGeZ07KN9jxyx3y8ZM3thchv2L/WRm3?=
 =?us-ascii?Q?TKKrQAknnUF2Seu/m086XyD55DmPmR8doQi/u2qqpNALEKJdKxMNivpEmf43?=
 =?us-ascii?Q?P8HHoxbL6HXZADKBdFDAkGbQZNhrR6jIHNyhm7EirGNfXU9RS26Kln3XwZS8?=
 =?us-ascii?Q?CtjAYYjG1p+qtR/dwkq4KjyHRoH+IbqYOMOpGQVGmVbps6z1E7CZyWIsWY0r?=
 =?us-ascii?Q?Pl04gxFQ8x+aXZ3XzhJWvDZHaPr8bd72Yue7aGF3DIh+S/j1xc+LiGA5qpmp?=
 =?us-ascii?Q?Rf+R3rTEf/GRAqyJPHYnXBwY32sYrhtd+sFoJcy1elUz+gjbbKX/umWvvf+d?=
 =?us-ascii?Q?m2CAXxXUxKLsGlfb6xWD6p2FnujB4aPEYRJbu0+9RYkebSkLqgMulVNj6Ab4?=
 =?us-ascii?Q?+9+00NWHlwoRZryu+djde82Ezn5WGF79vTP7JQdg0eRTFNbZG9c0CbDzRDsx?=
 =?us-ascii?Q?frdsh3Q5C38AU7xL2nbkOLWnOZOOVbXAZ1YdVZjSI8tOrepzyJaphEpZb+2l?=
 =?us-ascii?Q?I9vN5Ml5FAgn6cQg/yAWY+9AHWEhS+fSUYGugjfOGrwTbs0mkGY9GmUPaett?=
 =?us-ascii?Q?gMRyJImjfb3KLmBze5YA/RNxCEQuLwnUqKxiuKY95dN499GsI0pNMzPEUxei?=
 =?us-ascii?Q?OZN/MOuPtyaow1ja0NGEUH96gzkIUXimF5hoHrJLxCORGZpUk3gwFNBy4nol?=
 =?us-ascii?Q?2fVe92miUkiXiLAupbYp2FpXkrXAS/phWVK5/W9Fm4RllmqXyRK1NUreo8J/?=
 =?us-ascii?Q?qGNCxZScelbYmVwmveFigaD/gs7jkp6e5m3xerFf/K8k1eBBhWKauMEzI4C3?=
 =?us-ascii?Q?a01aqKUpFnvCdYdahgERcNVwLMgYlfz/4Yak3Q1VqjuoSUU+KuNERdbAToCp?=
 =?us-ascii?Q?rOpsAbXazPAKYDLOWUMQyHUgg4wfau6mOTU3TGdH+MfKbPbQAyl1uL/1UlE8?=
 =?us-ascii?Q?zx6m+o5G19ubTgR3Fg7x+BrzTgWTrgRlyxLe9C5AXWEkA3UgpKcorlxAJLyb?=
 =?us-ascii?Q?GaUzK5aL1y53W+RywD5XedJ65erauKkTPNWtVdYsaWfaNvz0epzBDiigv+dO?=
 =?us-ascii?Q?Z8I2WMNjJIXcZXq1tsOTVn4W7gxRdeq0BPBF19bd5sbQzOCCR6aY5MZpUN2Q?=
 =?us-ascii?Q?C71+yOsJPHfyxdL6mrDz0M1bONP2Zy813OMYYyobZN5jnzfhdUu3Caw1fVE7?=
 =?us-ascii?Q?5zbVfP1pgPG/qlIaPDqkFXbr4H9zrlD6qLQiN9umZFdYlvfD7rmhfosvnDqt?=
 =?us-ascii?Q?olonodu0yCP6i+6ExemjU6GN/Iwp9HNH/PjH+Ngt50kEbq7ziQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:53.1176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c10edbb7-c37a-4bb8-05e2-08dd0078f91f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970

If for any reason multiple profile handlers don't agree on the profile
return the custom profile.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v6:
 * Fix logic error with PLATFORM_PROFILE_CUSTOM
v5:
 * Notify class profile of change to legacy interface
 * Don't show warning when writing custom string, document in last patch
   instead.
 * Adjust mutex use
---
 drivers/acpi/platform_profile.c | 120 ++++++++++++++++++++++++++------
 1 file changed, 97 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 089ac73b3ec97..2676f4a13689e 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -71,6 +71,22 @@ static int _store_class_profile(struct device *dev, void *data)
 	return 0;
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
@@ -257,51 +273,109 @@ static ssize_t platform_profile_choices_show(struct device *dev,
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


