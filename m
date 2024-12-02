Return-Path: <linux-acpi+bounces-9858-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B67E49DFA6C
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7700B2819D6
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC4C1FA838;
	Mon,  2 Dec 2024 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o3nwSrVi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75F1FA25D;
	Mon,  2 Dec 2024 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118716; cv=fail; b=GlWwN7x/3ZpWN0o8zhitO/DyADcTMusTdVahitcUFHjKPJPmPms+kfUl7y0dwDikR+2Ns3JIS/fcCCOyD9g2IL29vEymndEQIM3rCZebV2GHP2FsLKlv1kwh39v32OATmgDrh+a4aCq1DA9Czxp2HVNe/KikU+h8jTVSsE16kbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118716; c=relaxed/simple;
	bh=hiCWV5Ciccc7IZdNV8FshBAGXHQO12fWiThiZON8daM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXHl9aYssdATNjoYrmlAlnkE16tJHCccGBeR5FW9z8kDlXYqwm8kV1B1J5prVL58O8ytBl0dKGC52eRtFMNemSBj/CvwLC/2utcK6c789FMVelEII4gq4BXY3HQwvai0VrYn1y2RI2XSs//XEj35hCFX/dYCS1Wu/wIZ2XenZlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o3nwSrVi; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIckD3PXNWRR3GXeBIJb6azy/Ovtwlvet17WY3ohdAYK0+PBzPoSGyh90oCZfxeHsUYN8P9hbrhW920m04HvqVB7AsQqhx0xeAts3Trh9EHf9Sc7UN539lvfc71FU8Ypwt0abhYjNxz7W1M3+aWPVFthrWGcjnx3I2vAAm5PqHyCEQZzzfM3EHuQc5KaFruxyithLKh4zqQ9Bx3ZnzJqIr+aQ83MUPT5QL2FXWhBLFRh4tvGf9VNDhWp5Mnci1z52ROtpg7KHzLs40AFTBN/FiwSFUT7J7c6Znn/a0FdoawoYQ6rvRv0Ml7rYtf+cdoPP8dmpqvGewolFALzfO4peQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ1+jIvN/hKauFl7u3gq7oiXHB4v+3oh9XKPoOpjc64=;
 b=AHTD9psSqXm1dPNOnx0EMgO0moxxyz9sdPEnH4Oxayn3h7dXlChdJY8/CV0Z3iKUE/3oa6cTvGInW+PRymOzCcxNkT2x9Om9kXedXy3wz7xZThc8adOHOPRTZENtrnP72jX5aVl3pDuB6vMegAFFyzcEdAvoY33MNGJ1cyDxeb9iIl3pzbVa+mfCGya5rIig4zAr0U6Cu2MzubUSIePhPAsySiP29TaHtTtiRPYu0xwkPKlAnOAZH9BNt+IqG+M4t0wFGFYtdG1us8IFRq8G3VzFe3yrVQCz8gMxVSoqRa51eDWgFNEBvGBJcZbBHVoo7+jAcld8UA65GrWFA7F1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ1+jIvN/hKauFl7u3gq7oiXHB4v+3oh9XKPoOpjc64=;
 b=o3nwSrViDJ1pGmGpbJtbzWNCH7dVTMgxDaNmUHCxeUHQ/iaOoxLy0cPkXkaPsXo6nzGuoQRIqfTHUHqClM7knBCrgb7ROqtT0AJFAiwgb61SgEM3ZAv0uesYLAZqEXW0Bv8s+S1oSVeHRvoBoVlsbemSzjf9/KAOzyoKbMnQpn0=
Received: from CH5PR05CA0006.namprd05.prod.outlook.com (2603:10b6:610:1f0::11)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 05:51:51 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::27) by CH5PR05CA0006.outlook.office365.com
 (2603:10b6:610:1f0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7 via Frontend Transport; Mon, 2
 Dec 2024 05:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:51 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:48 -0600
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
Subject: [PATCH v9 13/22] ACPI: platform_profile: Add profile attribute for class interface
Date: Sun, 1 Dec 2024 23:50:22 -0600
Message-ID: <20241202055031.8038-14-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2911ac-45de-4a4c-688c-08dd12956b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7pYMB3JNJjYzVOnTYz9AeXLFT/fKwZBF4AXFT7G9Dl6cZ4xtPPiZTuldF6g4?=
 =?us-ascii?Q?RU6C/dp84dC7vCpBRvdJgIjv1lloIwy1qnSnUN5Srx5y0vp8eTWP9wmGlWZ8?=
 =?us-ascii?Q?1Mith0TDQf/m+4QlsEmfhCYQL8Gf9iLQW6OkZbhU8jS9c9XNveGs0NWvQKyp?=
 =?us-ascii?Q?Ri9IHgJlQ6quR/kwxqujzhHIhfDcuhNTyDS+r2Stpw42l4gXb4Da2Bq3c9iR?=
 =?us-ascii?Q?PznPLCDdZlVKLdP01TnekFdDrMJ/CJR+LgpFquk+lBiNzDvkArwcAih2mIs7?=
 =?us-ascii?Q?7e1Gke08ZyAjW5TOFacL/bFeypnZdIdEdpHCNVW+ySfAOFH32aaoqeTkg/yy?=
 =?us-ascii?Q?FOuZ3+EfAy2YAzjRG8kJkMM9jz6MyQWiKTXctPiRPo/h/tPCI27ya6JL1tqU?=
 =?us-ascii?Q?7MzMzGOgEX6+FIrZwSXjb+D1YRYnlamjPNDGBp+SvevcARlFteevEY7S3wIr?=
 =?us-ascii?Q?TirM9p+5LzjQvInZBPNpseoVmm5Dk9NHBWr2kPbTTptF+Z8sQn+qN9hcsQER?=
 =?us-ascii?Q?KaBHjJVQ099EUcvpgLr+1Vwrnxw4XhTOaKxxneuyAWhuHR4HMWJ16KPSQJ2t?=
 =?us-ascii?Q?wuMTYKP0JW4llFcxFl7xjLvOwSEadAxkoMaZJ1NoexLrHLBl6bHoPgV5aQGc?=
 =?us-ascii?Q?W4z64K+oKFzqmGjl+f/xze9tWqIQrF0O+bNbW6M2+kBBs2DADhV7ql7bBF8h?=
 =?us-ascii?Q?rFob1eZaDCy6LD8gzVUeaqXq25CkFFY1QmJYcRnpKyDPF1d19hQr8fg7QYKX?=
 =?us-ascii?Q?67pEyyFyOZLIFZZWEeH0ba90CEchy8YO0YfmCN2WcrwR9/WM8oSygS4+Unic?=
 =?us-ascii?Q?cFsG6QafUyD/ThdmVmHOxwKvTeCAxbYUXPhunJLR4aslmiA2Cz16thTirZwJ?=
 =?us-ascii?Q?51w0P3PcVCcCDKQu6qnYfRH6+c+d7hjAUtq2pH3MrJZsq4ZkF8eQZ9gf7v97?=
 =?us-ascii?Q?XSBLEWhBUof8eMxlIX3puWSRXzubggi/9bPyyADH+xBZWM3qUXpGHMNbIvyI?=
 =?us-ascii?Q?xvuSGZIUC7+/+TB9L686870Gs60QlrfDV2W2Nu7GArusYJ+ay6av9alzWsC5?=
 =?us-ascii?Q?nHKlfUe5i7KRKV7/F50PvYZTdcLbspBgVrK0G9EtZKJ3ADfc3GE8hj1qRH+l?=
 =?us-ascii?Q?LbScSEiFbX6a9PxYxSnJYldBkGtLIHe3IQdKZcTb4C27PBwdSSDdImQLHoBL?=
 =?us-ascii?Q?c80o8LEr8XzfNM6fIxjq87n2BoiqJyEZdiq8BsSzl/tbdjO8oWtFdaNwl+7B?=
 =?us-ascii?Q?8VFOVWEq4EmRs9TIaZnlkUi3Dj4lHL6Plg4dCdoCYPfWmiX6BVFugawcImry?=
 =?us-ascii?Q?z9aNnWa4WoWoTUigdU7XVLQjeNScQ2apkBK2ng6d3d4Hs7eL0DLc8w9bq71s?=
 =?us-ascii?Q?rIpaZ0cdJPEbGMv/dQ3e8vftxHzgyvJ2OXiWk0YR85lYUsWK1T8QZeNqdbtT?=
 =?us-ascii?Q?7uHUBkTJAEI8lgUu1rTgbBJJ8bE1uL0A?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:51.1754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2911ac-45de-4a4c-688c-08dd12956b16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928

Reading and writing the `profile` sysfs file will use the callbacks for
the platform profile handler to read or set the given profile.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v8:
 * whitespace
 * rename variables
---
 drivers/acpi/platform_profile.c | 102 ++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 885f41bca6c25..fdff374aab128 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -47,6 +47,52 @@ static ssize_t _commmon_choices_show(unsigned long *choices, char *buf)
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
+	int *bit = (int *)data;
+
+	lockdep_assert_held(&profile_lock);
+	handler = dev_get_drvdata(dev);
+	if (!test_bit(*bit, handler->choices))
+		return -EOPNOTSUPP;
+
+	return handler->profile_set(handler, *bit);
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
@@ -81,9 +127,65 @@ static ssize_t choices_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(choices);
 
+/**
+ * profile_show - Show the current profile for a class device
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ *
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
+ *
+ * Return: The number of bytes read
+ */
+static ssize_t profile_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	int index, ret;
+
+	index = sysfs_match_string(profile_names, buf);
+	if (index < 0)
+		return -EINVAL;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		ret = _store_class_profile(dev, &index);
+		if (ret)
+			return ret;
+	}
+
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
+	return count;
+}
+static DEVICE_ATTR_RW(profile);
+
 static struct attribute *profile_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_choices.attr,
+	&dev_attr_profile.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(profile);
-- 
2.43.0


