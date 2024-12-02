Return-Path: <linux-acpi+bounces-9862-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3829D9DFA7A
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE043281A0E
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EEA1FBEB2;
	Mon,  2 Dec 2024 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dcu7vSbq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0F1FBEA1;
	Mon,  2 Dec 2024 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118726; cv=fail; b=iIbsPMmWLer9m3Wqq8t2Wa7UX45egIYMwvEpBQI0v1qC3K4DFJ1aXoYz4m5zAi3C1uAPQfwGJx4DawMmiJEwhKC7/HklCbg+0T9fHIOwQj61GDEZKKwZ3ZnLI54ZdUNceAcxoMivLc0EntBOK58E46HapcPnhsr/WUPYt8GlKeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118726; c=relaxed/simple;
	bh=xJ+M4Lg2cIRGE7DzFAzUz3QMC2iv+n5Ah8qSAwPX1zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SElvbCgm675nCdz6sVTwU2YindceQkR/3JM9tLoXNY0rsQzVMmW1CGlkxUOTTOjW/J/oPlRQRc4ozsq6bfP5aBLto++OYSwNRDiJIUzWyF8A/204hjWalo14jXkAjq1PnlXtVyRIWpA7S09jgunHE49in4sKBogtPliqZvsaxlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dcu7vSbq; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7mobltIc//42CQXyj5In+eJmbZjyF6qqWb9M+NfLwEaY8mjdL7bsJQ+a7waM3N58++Y7rzpD5EnK+5W3xMweCIOqd+Z0Qwjh6EdL00jR1f3hfc6+mUXCr4Cg5pNYesNGvmIvg/io/zde8jvNzAIqLlhKy9KX0Nm2UJOTk8DUzqMoEuWJAWL3dKIGtvGFTkkY4LkRKRc2CumFlzyhEDMy9N7En1p8UiKlXbXfYD9ot6vE0MVUvNNn+uJjeqDvd8IEk8K5ZAg78wHOyJxNyiK41isWukHN6z+o8tUCnKAO8ZkmhXR7/Z0FFiKT45sJnWG5FrVEhA43vlT/zyjiIDb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKN4rAzipi4gAsFai9pIibJf+kkEH1x3D/3vlXFg0D8=;
 b=KzCihDnTUfMFsi254F7Zp0aNh+VGToyIwLqdbhYn88JwrmEvsS4u7ypgYNW33Bow86PBUzqBlQHklLV1IwixzaT9V7HBVBvYHX/jgWKwEJN25t57+C/caX1WygHZIfBw/2h18JUsInYvsgExpKKvpQUvJKv/KI0JE3FkOwgw/lmzEguk7im/Y3LpxcSXYgPT+ET9M3jnFOZAfjeMhcnSYhy5bLF4XUP3I0tOOAYwiXleX1j2aEvlWv7IadLEftELLv/i7aG2j9AD1IfX/dbZOVgL4KRlEeVSAXjqOfz++RRAQ+j30kykeLewO4gyzOpizgd/15oENECOmLXuFaINEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKN4rAzipi4gAsFai9pIibJf+kkEH1x3D/3vlXFg0D8=;
 b=Dcu7vSbqpAcX9Oh0M1DdDWwTZ//0h9mmwSov/oGQvi9jE9jZ8/DHimeORHQ1disl4N9zT/ZNywIPGESJxIn0NYFAbzZQmqDmRDHFGOou7IKQy9Csv5cHyqsyS40pstbz/lCWlgli4byKZBFKKiZIlp+vIzJwFH/Tr4TE65Q71bM=
Received: from CH0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:610:e6::10)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 05:51:59 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::30) by CH0PR03CA0275.outlook.office365.com
 (2603:10b6:610:e6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 05:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:56 -0600
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
Subject: [PATCH v9 17/22] ACPI: platform_profile: Make sure all profile handlers agree on profile
Date: Sun, 1 Dec 2024 23:50:26 -0600
Message-ID: <20241202055031.8038-18-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a079ef1-bcda-4592-462f-08dd12956ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PnHoeDM2jEAnidWxJ+z9xf1zGfTZ5FO2m0H9S8AamfpIFnagkequ10VlZppS?=
 =?us-ascii?Q?UIzqGSrl5NwkU7EWu0OjyBoEF4afilNBIgD4XwZLUxyB+0pf9nCFGi3JcJB5?=
 =?us-ascii?Q?zXi+9zB8k1VodlfN8OfnzZgw+d25I1CFVIruJonFlgVIr3A/SP7H3NS+g0ms?=
 =?us-ascii?Q?yPtDZTtTK/H15owdb0wgyaB2DnzIFiWIA5HmOqVx55xTXLv8WXYq6brdcAwE?=
 =?us-ascii?Q?9GUf+UBO8GA4X1aZusqfOPLVeG99dT9utxHCEs7vf+ZxDY051Pad5JHcO6g6?=
 =?us-ascii?Q?Q5KYuVzMOU6E+L5hRXEc4x4HVS/7E4naGYMmqw08A4UBwAoqPqk46SWf5aVD?=
 =?us-ascii?Q?VyCB5pFUcfTI8I57/awtxoTkLd8njTQPlaf4DRScluBU5ncqqerX4zoiqqer?=
 =?us-ascii?Q?9sIHqQlOL8R+zOoDM0AQpLOlOVH0ehuBily2yzV/Aawv+4bxeLEIw00LL2CU?=
 =?us-ascii?Q?Ln3sZIMRG3COVCv16NaPKNOOBM3okhTaV97hRdVR3H5bPYjDIeIuP1v7VdPG?=
 =?us-ascii?Q?x63ppAW5KnJuKwGL80HGpzdrp/Y05ubeWWQw7xu0W8vdSCvuGkSurcYPCjyw?=
 =?us-ascii?Q?y2dtZyW98rSpm6nvfnr6gbCLIkDyPM+F/VuR2PvUHYNIAIFxBB3rHZsQ8E2C?=
 =?us-ascii?Q?qBWkvAKK1nOV0Mrh5Q+quZPF7oW6ckaW0onPkrfbIHi3KklY3OjJSu/5Wv9V?=
 =?us-ascii?Q?lOJyKd77eNPmz8g74tDB8H2Y7a7exN7RyXCcFN58JMKPOylgJMB0NFogvbxj?=
 =?us-ascii?Q?P0xEZQ0nzfnxrGySk1gaJvMvRunRnLIcy1H0Q31t3gF3zN3ZqvF+LfJXzlx2?=
 =?us-ascii?Q?k2Ya1b45PbIj1ORMM/KnXcLjP69nY/hNT/+GQiPrsSMWDclCctXuEL3kQ8co?=
 =?us-ascii?Q?SLkqi4sOQNudtx60P6QLwpyp1wf9op65ROJxArk6vxf0SwMTurg7ILXx1EyW?=
 =?us-ascii?Q?RW3QoAIpiGWqzNfhtiBysbr9qZtpaZ9b9UNi7J2OpVs/PpKxOA9adwfJpZ2Y?=
 =?us-ascii?Q?o5r7/1En+luX7ScIqHnLNUzqpHib358P0f3E9IhsfAMf6UrcetRFLJzyNc2q?=
 =?us-ascii?Q?Aiz97DTffqaon8OCkktjdlr8nM8dQovKcyX+Lc07L/3WaOA4tO0gbh/QbIAg?=
 =?us-ascii?Q?OMKftEhHdDXXNYg5SIl0vg/3bg6tcuC1Ftmet75XIYiP1sORjj4wUWB0XAWh?=
 =?us-ascii?Q?RcTrXDn0g78dfEgcjEpNgd8UmLuGRT28vHQlG5i1UHzkl9fyInE/T9PvYHre?=
 =?us-ascii?Q?jEQ36fDi+BL+Cn+tLquREcKIFafHI1/+Iz69EpM7Z6r0h8oQQBq9Ey6PEQIT?=
 =?us-ascii?Q?xS+9WHLjqGi3T2Zx8b4d5NXSe0N365LZCHsSXtVYxkEBRGN20o24sGYX89NI?=
 =?us-ascii?Q?wHbb985YKme90cm/fqinWTmc2ICyWRkVaY34CwRo987ExwBly222fDwJN0Bx?=
 =?us-ascii?Q?r+PILFKZ0Eal+225Y7Cp1p4j/U0BcRQo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:59.3313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a079ef1-bcda-4592-462f-08dd12956ff5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085

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


