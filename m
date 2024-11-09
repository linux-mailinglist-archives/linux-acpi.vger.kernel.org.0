Return-Path: <linux-acpi+bounces-9471-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E1F9C2A00
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B1E1F20C3A
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8C614E2E2;
	Sat,  9 Nov 2024 04:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zk2xKB4b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2E13D882;
	Sat,  9 Nov 2024 04:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127371; cv=fail; b=i/JERaqhNW9tfb1FWKVSQOEY9gDFhLQ+jeRLiTbk4JLy2Xi0wGWP1v8sJnthkxmqZF11ZoowYzouFA69Pz416sCdrMANcPka8nYFFj3XSDpP6z5U3PHnsOez4Ns7HuQTvHY1an2hxN3/ZwIUPaIQ4J+1MnLSvgfC9aSO1fuJU6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127371; c=relaxed/simple;
	bh=n6C5QFardExgYW1Ni3u6F/ge0lNfYFhVDD9M6/rvTa4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDl4HyeUFq0QSRO0/mHRcTYMVUlqpmA+5lQathDl4PK1swqn06DXrlZzqsR9s6X0T3NiRozcCALKVUvDwP3RXch2mXcPBipbdIHwj0VxMhljhipUnFvCfljidkTnhzq3kRZMe4rapLE/oM1NzH0x0qeNoVtuDXL0FUgoyqLgJec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zk2xKB4b; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EV1FpYh9ZVHoU4708jXLkz3dAmK0xbSSretn2aWtJBOQaLJC1KJe3ukWNRjXJJC7CmE1+LMSdhlGIr3bTErsq1ziLn2GNFaKHio5qyxkrpHMozJEbySnXJK7jLzJ4tsz4vXM4OdZkulKy2z4og79KCzkt1uI/c+zuqJePRCSFmBnMo0rOwrPA4rUDI0IpnaLJAT7uRQW7Irfmo+qcWtLUWN5eZDHDxVAYy2FPwWyAwwpTkWrrsKZ846lNUtJXKdbadhOHjV+UhQWo9WxkWCQqY59px7E23bCKXX+0sMXWGSUnoyPNek8DiLWS+9NqX73rE2AchkhYu84vSRhDNUDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQm/S63A77MvKwU8l2hIw/TuavTv044wqWiPewpk2jc=;
 b=v/AhAFIURPuwfnvIMHZPbyqR70Djaij4ERHQxJxGKOGCEI3dyTR/KSjb1tgNA7Lm8zUuZohNqmonC8+OrWS2IfmoHnqwaXThp4XGJ3VV2vB2WDarvLg6KlKoaX3VyYcXqY1SRrNhFyjHnYTBffkSmVhGS+wiLloYZE6q3UjHQMxiM5A80cbmp08mXgR7HhVDXhAiSTW1uFewf1FQg3RsHfjzsznGcaAHtzTvo5F/PefOdwVvCGQ+Y7fTrKPqIAUwgOCn54ut8y1km2vgeVMghqlv6cRR87oPbw3DlmbXBnCM8ocn5roR3egxkGfAnOCevh4PT69d3Q6KZdo8l6II9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQm/S63A77MvKwU8l2hIw/TuavTv044wqWiPewpk2jc=;
 b=zk2xKB4b9Xzv4GF1t8E8UWZ7D/pklcaMZpkJL/IZIqxm9IJTawthWH4znbPUla0OIfse9y3Bn7KZlLh00JZN5nln5uYjv0KCAYyXt52FdM4pM0dXTUqr9BLq/RN5qyT3wbbEWDlWPxbyvfJDtYGtM94RrW0CbeQAvpgGssDMSvo=
Received: from SN7PR04CA0221.namprd04.prod.outlook.com (2603:10b6:806:127::16)
 by CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Sat, 9 Nov
 2024 04:42:47 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::6f) by SN7PR04CA0221.outlook.office365.com
 (2603:10b6:806:127::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:46 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:36 -0600
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
Subject: [PATCH v6 13/22] ACPI: platform_profile: Add profile attribute for class interface
Date: Fri, 8 Nov 2024 22:41:42 -0600
Message-ID: <20241109044151.29804-14-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: f47b19fb-f241-416e-d5ad-08dd0078f56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KMSwu1engp4jdTjYd5M6/fY9MwEOu7jJkRJCl1tlz6xIE/H7Vcn2Yu7mqViv?=
 =?us-ascii?Q?aIRNdL9we38clmnUDvUpzygx+9dia41JS/tRyCJyLKEnzjonay8cowlD5vXo?=
 =?us-ascii?Q?D/zBkm6KoUGyJhlel9I0l1His32lX3u6axEdUc7/mC9KeBszA72TivjZASIY?=
 =?us-ascii?Q?q0pnTyQ+R8rHB9ng5DfGA42WwhSI3IX5QNKBahaPFX6ARwATOm90BDWshXDp?=
 =?us-ascii?Q?AUDAbIGMiOk3Dg/1G9tkjGsMm8VJbkqEv7iacc2kEsL5wY72WkFc5KnMnibj?=
 =?us-ascii?Q?4tlnfWpUJsE92EHh9atfxgyA5B1udfSnPqvcLmmFZF8JfP9rRHwAEerODiyt?=
 =?us-ascii?Q?z5lXlGvOlLEgK+ogEeR6CO6juzgkzjQaQv7VDYcy482mtwMlj3UOl72mmHnH?=
 =?us-ascii?Q?xWd6GPfPGpmowVFxZpdF4kQfV9txp/JS8iAJyWcL8KaDJFi6j4HmSOnxkk7I?=
 =?us-ascii?Q?BdkItA2qxS9Fa05W9CJGbnLt6QT5f99ctUpicAP8dbH3v4tefgWbDAsvYLRU?=
 =?us-ascii?Q?8CxXZFiFMa27XHTuyGmbT/ZICbQTiAXDYB5OREAvUVS/bYyEsgLsUnbCv21u?=
 =?us-ascii?Q?FAT7skXElv9jTds957Qa7HI6zk7Tb2JzYh6QpomUhWDcyhUiECBOQz/l7Jh1?=
 =?us-ascii?Q?uFP+xD7aKY0hMD8YraMxpbO4cQ/+A0oGyMzfugswYAGMQy9+WjGtBBvH6uNQ?=
 =?us-ascii?Q?qV507TZdUN/C+wsH8FvmSaMLUITyLNkIEtZYFJk3f8DQgp88QG2+bzIeWY5X?=
 =?us-ascii?Q?KHBoSAmCFDt0ou6k39JwthVGqdgXDfmP10C+D+3IwFuDFcBxrwxcDs4YEbP6?=
 =?us-ascii?Q?LJNg57ubEGuExzK4npmCjnk3xZtQgD7romt0S2cxrn1euHmYowLhbQjMtR3g?=
 =?us-ascii?Q?wwOVsoI+HBn2kJZ3r2TmUEFmIMhpX60Gpf4hdAlja1ROzdAjWg69Fa7kzIwy?=
 =?us-ascii?Q?yrRD5rtEKAHJs6ZMb6f6fIAu16BGRnDbWyM/1OvNUN/0mXkSHlo+Gj+GQTb1?=
 =?us-ascii?Q?e5A2xtdurd4I2hdh51/idinupl6pLiduniXGK6EjDGWsFYjWjUIOHwDcJVqj?=
 =?us-ascii?Q?O1om6mhTjvXlFvj7DquDQ+p7tPVp+5MoLQoeKqTyw53Nlt1kwHvl1uVI3U+3?=
 =?us-ascii?Q?7QWqlrWpjjP1b2AuHpKtbeYh1fgs281ocs+Ie2Jy7kvxQz3AKoHDAS8FAxsx?=
 =?us-ascii?Q?dr1ZNc7554SWzb3GGW/jzrRSW6kZyd0sqZNPA6bqUvuBu8WmQkaeFtAhpSc2?=
 =?us-ascii?Q?TgWu8HqR9+0WoQ2XB90B2dab7V/TCqoLbkF/x0AC1EPkIvoTrUA0wkpE4PYd?=
 =?us-ascii?Q?pPTL4ilrBloog+RpvyPBVNr5HTMAhJoR1PuiFk2sbhsCKdoYSM3Qyh4Sik3+?=
 =?us-ascii?Q?/f+YQWfRuW8eAdOHWq90J32B8QsiQsOEvkO3S/7KKRyhX/dCAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:46.9192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47b19fb-f241-416e-d5ad-08dd0078f56a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170

Reading and writing the `profile` sysfs file will use the callbacks for
the platform profile handler to read or set the given profile.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v6:
 * Fix return
v5:
 * Drop recovery flow
 * Don't get profile before setting (not needed)
 * Simplify casting for call to _store_class_profile()
 * Only notify legacy interface of changes
 * Adjust mutex use
---
 drivers/acpi/platform_profile.c | 106 ++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 86d0eb7cc6fc3..c5487d3928c1b 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -46,6 +46,58 @@ static ssize_t _commmon_choices_show(unsigned long *choices, char *buf)
 	return len;
 }
 
+/**
+ * _store_class_profile - Set the profile for a class device
+ * @dev: The class device
+ * @data: The profile to set
+ */
+static int _store_class_profile(struct device *dev, void *data)
+{
+	struct platform_profile_handler *handler;
+	int *i = (int *)data;
+	int err;
+
+	lockdep_assert_held(&profile_lock);
+	handler = dev_get_drvdata(dev);
+	if (!test_bit(*i, handler->choices))
+		return -EOPNOTSUPP;
+
+	handler = dev_get_drvdata(dev);
+	err = handler->profile_set(handler, *i);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/**
+ * get_class_profile - Show the current profile for a class device
+ * @dev: The class device
+ * @profile: The profile to return
+ * Return: 0 on success, -errno on failure
+ */
+static int get_class_profile(struct device *dev,
+			     enum platform_profile_option *profile)
+{
+	struct platform_profile_handler *handler;
+	enum platform_profile_option val;
+	int err;
+
+	lockdep_assert_held(&profile_lock);
+	handler = dev_get_drvdata(dev);
+	err = handler->profile_get(handler, &val);
+	if (err) {
+		pr_err("Failed to get profile for handler %s\n", handler->name);
+		return err;
+	}
+
+	if (WARN_ON(val >= PLATFORM_PROFILE_LAST))
+		return -EINVAL;
+	*profile = val;
+
+	return 0;
+}
+
 /**
  * name_show - Show the name of the profile handler
  * @dev: The device
@@ -85,12 +137,66 @@ static ssize_t choices_show(struct device *dev,
 	return -ERESTARTSYS;
 }
 
+/**
+ * profile_show - Show the current profile for a class device
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ * Return: The number of bytes written
+ */
+static ssize_t profile_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
+	int err;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		err = get_class_profile(dev, &profile);
+		if (err)
+			return err;
+	}
+
+	return sysfs_emit(buf, "%s\n", profile_names[profile]);
+}
+
+/**
+ * profile_store - Set the profile for a class device
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to read from
+ * @count: The number of bytes to read
+ * Return: The number of bytes read
+ */
+static ssize_t profile_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	int i, ret;
+
+	i = sysfs_match_string(profile_names, buf);
+	if (i < 0)
+		return -EINVAL;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		ret = _store_class_profile(dev, &i);
+		if (ret)
+			return ret;
+	}
+
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
+	return count;
+}
+
 static DEVICE_ATTR_RO(name);
 static DEVICE_ATTR_RO(choices);
+static DEVICE_ATTR_RW(profile);
 
 static struct attribute *profile_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_choices.attr,
+	&dev_attr_profile.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(profile);
-- 
2.43.0


