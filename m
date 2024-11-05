Return-Path: <linux-acpi+bounces-9312-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837CD9BD0A0
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71071C222C3
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1FB1DDC10;
	Tue,  5 Nov 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D5K7I3H2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491931D9669;
	Tue,  5 Nov 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820831; cv=fail; b=RJugFZlVpkik+IWyyCPvVKLYi3ZHgbThH/JWqUYkkFpXP1w8DwE7rVptYzeVL5spnNepaVxzwRKsVY7dpFcWmmKJVk3Ig5AWBgOPLtHhaD0iXLB1RpX5acO2W44IzKr/nCtXb+Q2jKxAjAB+nRPl+3AbHxib/tVyL8S4ir352Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820831; c=relaxed/simple;
	bh=7EKQRIUFbmHdiD7bG+5mSsPZ+0rhm2SGPEQdCXLXBT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hB5cQ3hVwoh490LEulHsVMcWjRMjHsXGusHmh/LT39HSAi93Ek/s2O2wt4Lf4x0KlkQdGARudzZ2/TB/hiIJ3vlPpQtUAm7mDpndY40Qaam2c7Mbj0ujKdsK8rtMDajgEzoTl1nSfzRKLSxd9POizk3ADa6b6O09I65HyBxmLVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D5K7I3H2; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZG00jN3UAU17rdrHhLUxzjeF7/L8U/zole5GQM29CwCXbLqsZBdJqwoW/sAaFmKvO6l71relvfqNdd3j0p/vpixb7fpfNh3kWKGnZo3Nzpo3/DxpP8Xj+Dg0Mne45oziuzDaAWn+k7K6LRoIJFRM3UUA3O1jX4K3Q5UENfwoytUBbZZ+yOYWfAix4XqyZ7nycTDoRgLEuR08YA6DFJ2QBxtp76d7lEdqnvSSm9h54pWBsrjFPSpU+ggYFReeXOGEg6LlRjPZvQE37Po6kMECluyQm0M0VykCVDOeKMxvvIrx/a/PZnZ6a1TEVxPpu89gzBRdenygRflZ6FYXC8lGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGwvhOXSQqEMg3VRy0cWLQm0Ref24Xtdqg/sVQL/t6s=;
 b=NR9/zA69+u25JM/OskPGagowcEGefXeZom782+iK1Ee3kS+y/Z/+CTePDc9qziVMThkbAEA17SHGSW7xa5jaVIw95XseMZo8wCUfoelFEKmokBrA03kYb/QA2dktrVRPK6c/0uLrFJWn0ZO800G07O2ZtRenXQYNeTSsiG8NHLXPiMCKYwqJcIlqFEgMIvXYCsyKRpsrU7iG4B3WXGpAyuRkpHeKSpq9pku45D7PQytmPPRY2EcL/ihjz6BMZZW3FNB1RX2s/iloX+prY+fi/AsCbMZmkItivdJVEuD2girbPSsiwgICTk5MEJUUwAdRRxEDcw84VjjEJqdYuLHPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGwvhOXSQqEMg3VRy0cWLQm0Ref24Xtdqg/sVQL/t6s=;
 b=D5K7I3H2sfQNGnBPlFANtKmoHhzql504PK+HG4AhQLj2LNmcPVArWiEmfrDxbpv894wGm6NteFu1PbmYjRYetPrnjsrjd1SAgu0dDZjWYPX0IWAXTOfy4WZlyCAgs5GLG98Q59FTGYcMh2mVI79CxdDGSR0xIlIxiNJIqoUnUgw=
Received: from MN0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:208:52d::15)
 by SN7PR12MB7179.namprd12.prod.outlook.com (2603:10b6:806:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 15:33:46 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::f5) by MN0PR04CA0003.outlook.office365.com
 (2603:10b6:208:52d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:46 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:44 -0600
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
Subject: [PATCH v4 16/20] ACPI: platform_profile: Make sure all profile handlers agree on profile
Date: Tue, 5 Nov 2024 09:33:12 -0600
Message-ID: <20241105153316.378-17-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SN7PR12MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c1324b-6a97-437f-bcf6-08dcfdaf3ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k1V2uhwFq2v9YDFmC9P0CI6S+hETFP0WqdjM+muYchc2XHr1FypmCkXelHp1?=
 =?us-ascii?Q?vZacdzp6NwjFT57KT/gLE8fmBH622z/OiDsG5qEcCGIoHuiuK/OAHPIcSijy?=
 =?us-ascii?Q?Udwncnz5nQkHIfiTOh/JaqP34SDj27KLF+Da/OJ5er52d3h3c6kFraN1+Bfb?=
 =?us-ascii?Q?otNcTVjaZ7t4pyupoGY48/4VeD3WSxbw4u+YGzrZ7dViqBEQOQvWTxFbMQzD?=
 =?us-ascii?Q?U/KqVt0OnIkxc2f3Fp6TQxyxMMmESvrgfLsJSjGPVXGqis8qWJjVavgMtBZ+?=
 =?us-ascii?Q?hnQBfuk2OXb63FKaZb/NPg4lN6T82dHP2d8x6tXVMJkusXDuN/Dqc2H1aBL7?=
 =?us-ascii?Q?ft94o0rmbs3qh2iuBHiLcQcXHktZTiy/YOEZqEF4714h+ihUpSIdhTEFjoLg?=
 =?us-ascii?Q?khyDTYADO5A9v2u0RBOsC9R1p31M1Brvw9oQOB7I+X45U83i07k+PKe+qrbq?=
 =?us-ascii?Q?P0SyqKHLPoAk7xokydoMwXjLL4/WawrrraXYzAXcIUliPhG9OGM1JHn1Fw1l?=
 =?us-ascii?Q?e/HR0YISWpdpYYAl2v5m2tawMPvRmquet3bM9Sfi6cm3gzGbK0yAE0zG8H/3?=
 =?us-ascii?Q?Jf9AH7MQ70tH98afhLrcqZ3MF18ps/pNhuDdeRdsFRUp85nPUVsXyIl4RX1q?=
 =?us-ascii?Q?VBfNorCU1jsgYIGQxkhl9Wq6654+umz4MY1mAejaF9DyDR6sRW8eYueYJ0As?=
 =?us-ascii?Q?YycLRSuiE4KbhyA6lfkYNEPYYv2TIOMQXMVXjQnAJeY+yYuJ1hWyo8PKI7lZ?=
 =?us-ascii?Q?OUlP6df4kAvq9ECfLwLPu1tR5ukbsT+fkxQizir9Y6xQcAAp8/fA617tqnLc?=
 =?us-ascii?Q?7Lds+4Qxm3wD3DTAoJD5z6Yu9Pp6VlWcU/9oknXkkYkF1GDSPavkcN3q/BZE?=
 =?us-ascii?Q?mBRgVRDUprA0bh1cLu7F5vzxoNqv0PeP5MqmjlY4hBfD+CuZwBb9CxNz27yB?=
 =?us-ascii?Q?txQn1ewtEZ87RkHr6WTuUrc8eNlY2CW9C9teMZ1NYSm4n97YV8SYALHYkWl5?=
 =?us-ascii?Q?GvHOaLUxyjvk+bw9a6ANE9OI/G/8xRTTY7Y5kcHOfVamJRCYAQMGxqMOXDw1?=
 =?us-ascii?Q?nLwU4nPWT/XUzaHKzRtJe7C5qTzD8gaaDzubuEGjdgjT5nkvjpJvi2P5xrnX?=
 =?us-ascii?Q?DmgL7OCWsRRsJT11biPjMUDqMaYg+qYUmS6ptLw9l+uZEBByR/jnTLC3gR6a?=
 =?us-ascii?Q?QxqZ3784yFeQlLl3+wLTSgCPo5oWcXEK/MnjD+EyU8ci0D2URl29gRZDk9GU?=
 =?us-ascii?Q?wJYBZXNSuMygCBe1JNE5gY5aDWAKmkdYkIN9WvR72ANEeEwUqP+gr+STDeDq?=
 =?us-ascii?Q?zaLZziH6959mYCtJn8MPHmXioQme6ZaV1g/51xiCjMK7SudqRa1WnP1FuUO3?=
 =?us-ascii?Q?Ugf3s9chPLzkLjNJ1f+FvQfqFJSkSgb5lIej/gGjRY1Pz/9wQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:46.0297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c1324b-6a97-437f-bcf6-08dcfdaf3ccc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7179

If for any reason multiple profile handlers don't agree on the profile
return the custom profile.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 84 +++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d8c2d195106c2..7861fccc2e58c 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -280,55 +280,77 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 	return _commmon_choices_show(aggregate, buf);
 }
 
-static ssize_t platform_profile_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+/**
+ * _aggregate_profiles - Aggregate the profiles for legacy sysfs interface
+ * @dev: The device
+ * @data: The profile to return
+ * Return: 0 on success, -errno on failure
+ */
+static int _aggregate_profiles(struct device *dev, void *data)
 {
-	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
+	enum platform_profile_option *profile = data;
+	enum platform_profile_option val;
 	int err;
 
-	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
+	err = get_class_profile(dev, &val);
+	if (err)
+		return err;
 
-		err = cur_profile->profile_get(cur_profile, &profile);
-		if (err)
-			return err;
-	}
+	if (*profile != PLATFORM_PROFILE_LAST && *profile != val)
+		*profile = PLATFORM_PROFILE_CUSTOM;
+	else
+		*profile = val;
 
-	/* Check that profile is valid index */
-	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
-		return -EIO;
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
+static ssize_t platform_profile_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
+	int err;
+
+	err = class_for_each_device(&platform_profile_class, NULL,
+				    &profile, _aggregate_profiles);
 
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
 	if (i < 0)
 		return -EINVAL;
-
-	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
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
+	if (i == PLATFORM_PROFILE_CUSTOM) {
+		pr_warn("Custom profile not supported for legacy sysfs interface\n");
+		return -EINVAL;
 	}
 
-	sysfs_notify(acpi_kobj, NULL, "platform_profile");
-	return count;
+	ret = class_for_each_device(&platform_profile_class, NULL, &i, _store_class_profile);
+
+	return ret ? ret : count;
 }
 
 static DEVICE_ATTR_RO(platform_profile_choices);
-- 
2.43.0


