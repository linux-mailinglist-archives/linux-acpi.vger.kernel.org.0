Return-Path: <linux-acpi+bounces-9401-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB66D9BFE1E
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAC71F21FE0
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF2D1DF960;
	Thu,  7 Nov 2024 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j1wP7RA0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978E1DE88E;
	Thu,  7 Nov 2024 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959439; cv=fail; b=bX8E2QYUc5cQg+oiQ3QvtqKo4o+dhEA+lXG220g26f9j1mWQwTEJdmQUpq+loKJP9I4MwOw4nQAcnGpxfMmUHRlBgSj+KOcoPVJSGy+7ujaIwdMzhFps2FTliI4VYm0Ac9pBNS5T/Pkm2OaYSDjUCCVODTrGxXNhRDpZNfJDGqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959439; c=relaxed/simple;
	bh=K4AoFKCAu4P4SG3vzBedERFkMX9Pcihfe2eS1/CifE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzI+4PMW1I5FvQsTo3j2Tb/2jPaP6Y6K0AThDScbDU9S5Sx3U6VQWx2j8iIL/oCfQ8cURFpVi7K56c4yhePbRfHt8B10xdJTe0rT6EtPTbXOmEmBHSbiKZS3SJ7XUZpPuYWcY/uiN6AFRy+Kr7rtInuwMESmwvnUwX+HnBLVQrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j1wP7RA0; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PI5lWuG5KV2y2nYMEUyLFKh9QwtM02IEiDlrF2ovyS4ZUxUuYngtd7mR7IXJ55Tdd4h4XnkhsIbaVed3Z7rT1SBCT3r5n4jG9S2NGASt/7Tk/gy6k44IXdL+GbPjBv/9vLp6Q1ZPGDQbya1uREJrJ5K9EHWXDsLBBREva/oW2AdbavbpwH5iywi56mZII1E31Z3IbTA6eTREEZuL6HutAUidyr1bKiSDvEQVMrEM9CJtV893tjEPi/El0ttWTGey9HmTrXkjqmnoch0r+EVusK0Hem768voj7NrERi+51MOlmGoEyI1l6ixdwB5J6kb33d6bnu/0xkiPTgtTZfbRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyKpeqW3CvjjNWY5ZB9puuXGNn8a3q2KFzVzT6du1aE=;
 b=uVyEvqw8RtD9/bXxmxHsW/Ci/aHbeLv83wUqU4aLHX8szZUa3LYi/Wb/yvoDdPvau+SUfzE0zvgbcdwbFKDSRqrQl4GRyIpzgnPOMBOI6+t28IAiwbVLeYjAfkd0ySn67reFWA8dD3YRp0xCEgaOtOlkzDz/M28AykWGM7LGpa3rDw77S04vbnpsZ0fwXm8NgHbSC6IuYuxSrmrnYPTDRoO/8IgIs27EBw/OXK8BYYbkIEQymRpbdqhv0xiEfkvrSRZJtZas+NxA5ZAqSB9SGPAliIHYCEntayyV5JH/FcaYZdgEVASvCDQLq5cYpr2o9SuXuOTsji6cYQDDqP/9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyKpeqW3CvjjNWY5ZB9puuXGNn8a3q2KFzVzT6du1aE=;
 b=j1wP7RA0+MhvNDlL7jO1GwSUUMSAks3TneVzzIbexVS+MQi/KkKO27/Q1115OA3Kpy1IBlaNUGktxCZCIs5WWlPCSIZsZe9BtC6p/Mihx684AN9mX8p9yoUuTZBAF9xTxNABYmZQROi2epwPKwRfinZExnILWprydhasl1uUidE=
Received: from CH5P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::27)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 06:03:54 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::de) by CH5P220CA0013.outlook.office365.com
 (2603:10b6:610:1ef::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:51 -0600
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
Subject: [PATCH v5 16/20] ACPI: platform_profile: Make sure all profile handlers agree on profile
Date: Thu, 7 Nov 2024 00:02:50 -0600
Message-ID: <20241107060254.17615-17-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 331b0c0d-ddf3-4026-3e92-08dcfef1f5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s+t+UQnKNiQldBB0elpVKLmAbQzCO2NJE9j8BOAUEbV83bTCUT/eoxvh+w+G?=
 =?us-ascii?Q?dv5F8e3V96egCw0+xsRXTrNDyXhzEn5e7ofTSSt3asx0bKcjHHDv0Vz3Y8bK?=
 =?us-ascii?Q?lpSjuongm9d14swE4pRHGKaqCG7iPpAgIXvNgPfEZJ1NDDHSUoDJQV45i9VY?=
 =?us-ascii?Q?nRu+pdJTsDxW7lPnHzwIzF08CcC8+1vt5dvM6DWadOb6j/kOQ9KwCJhGi8ip?=
 =?us-ascii?Q?S6uPL56vjRfQKoB0Fmpvj/Tjdwc/VY98oYLQH4HKk2vfzTVb1pdDUHlSJAJV?=
 =?us-ascii?Q?f6J8/lx7yW0mHRzFl7xD2f2pq2xPONByfIusBR6kLvtULbhHxFVxHfmxlsQV?=
 =?us-ascii?Q?aNj+dQiysIZySIGurBf53Akm/JeyJ/kEJkDLmEfCfG4OYJQXZT07CJN+4ZUt?=
 =?us-ascii?Q?gWLoc6VfEGlum7q11V5i7byyYoeFWd1qREjNf7wOBgKfq1hEOMJgg5ECDWTd?=
 =?us-ascii?Q?n815xRLCVROKRJMahbVk4ryTtRvnzRsNVwJUZ0WihpQNREEEWHW9uHTXBzhJ?=
 =?us-ascii?Q?9Cp0jWgu/eMJEVsHVQeA3IsqHbhIS04aBorJ9WzpU1lGrE2C0DMguB8baZOB?=
 =?us-ascii?Q?8TRjLzTDdbdvNklA03qvweYD4Xv22fff+X0MyVDbrz5mM+SngLJcYk3hJjOF?=
 =?us-ascii?Q?GjrY6nfYBVQ6ZpugU2Vva1YYVO/iRexdW/Z7XUjxfd/8Js+uLap0gNm79yki?=
 =?us-ascii?Q?1hQDhvNklAOHJOwReajoM5+XBJAMpIuW9easmmYCosKD7NP3XJGanZoPQOV5?=
 =?us-ascii?Q?Hc1Qqaz+bmWtd94GcI4GoE7uRAQOWxIuMFIba5u/Upy7nq4Zvzp1O6VTaNVx?=
 =?us-ascii?Q?FzR12lv5Xui3RhlXJAlvKHdAXIJv3sbKStUcvhmDrSNzSQ4wMig1nujKoWro?=
 =?us-ascii?Q?lMvpD9BgjO+OcuX7C4SXRsRbh6PBEOsbwB/XRnJFlHM7KYFSBJgvLxv6du86?=
 =?us-ascii?Q?mIvSJLSvmroRFL48M4kqBfO/8qak4MRwO2hSz5KYAHd0EzJcR6Bwm+kS6h9b?=
 =?us-ascii?Q?yjv9yfPezaexeSomNKfLC8+o5EsGBm60wy8XCjZF4u1nAruc18rxlQoGtNJW?=
 =?us-ascii?Q?ydJZ3ItFWzpQFedAvJc1nZmezMWGCQWxG/FkbbmA4FuVmKCDhA0+lqZYF+Km?=
 =?us-ascii?Q?IuwgQljvLCZ+Ar92gD+hLEZir0ozlecVSJe63OoOy7wGd96hvlirXHUETMcB?=
 =?us-ascii?Q?sLqwd6LjxkLNRwuI6zO1Xi0HXGgbDxS+wi5kaQJaxROuXlehDGA6Y3eSocMv?=
 =?us-ascii?Q?7jU/KdpXo92lXhjsUvJsQZ8GB+ZrLhAIPEpu2YIjXuGM2cxYDRs3jGy4ErGb?=
 =?us-ascii?Q?Jhqps7kclKzsGCjcsrFKyN1cmPb1Nq09Ascw+1LTOWd0fPm5JzDXJOgaTeB1?=
 =?us-ascii?Q?zrYU8+ANXZCNn4Ruliv74CFi+QyCYVhYX2a7n/n9UBCe09l8RQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:54.0182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 331b0c0d-ddf3-4026-3e92-08dcfef1f5a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760

If for any reason multiple profile handlers don't agree on the profile
return the custom profile.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Notify class profile of change to legacy interface
 * Don't show warning when writing custom string, document in last patch
   instead.
 * Adjust mutex use
---
 drivers/acpi/platform_profile.c | 101 ++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index b6f3388b4eef9..7f302ac4d3779 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -94,6 +94,22 @@ static int _store_class_profile(struct device *dev, void *data)
 	return err ? err : 0;
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
+	sysfs_notify(&handler->class_dev->kobj, NULL, "platform_profile");
+	kobject_uevent(&handler->class_dev->kobj, KOBJ_CHANGE);
+
+	return 0;
+}
+
 /**
  * get_class_profile - Show the current profile for a class device
  * @dev: The class device
@@ -284,54 +300,89 @@ static ssize_t platform_profile_choices_show(struct device *dev,
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
+	int ret;
+	int i;
 
 	/* Scan for a matching profile */
 	i = sysfs_match_string(profile_names, buf);
-	if (i < 0)
+	if (i < 0 || PLATFORM_PROFILE_CUSTOM)
 		return -EINVAL;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
-
-		/* Check that platform supports this profile choice */
-		if (!test_bit(i, cur_profile->choices))
-			return -EOPNOTSUPP;
-
-		err = cur_profile->profile_set(cur_profile, i);
-		if (err)
-			return err;
+		ret = class_for_each_device(&platform_profile_class, NULL, &i,
+					    _store_class_profile);
+		if (ret)
+			return ret;
+		ret = class_for_each_device(&platform_profile_class, NULL, NULL,
+					    _notify_class_profile);
+		if (ret)
+			return ret;
 	}
 
-	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 	return count;
 }
 
-- 
2.43.0


