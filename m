Return-Path: <linux-acpi+bounces-9678-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E0E9D2C76
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A153283218
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0191D6DA4;
	Tue, 19 Nov 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2QP6FQ2J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2751D5171;
	Tue, 19 Nov 2024 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036885; cv=fail; b=PpEcYveasg9/eRpZxZtt/jo5LTVUunfW7mihMiZlg4MbSAfrjcYfnQxDnuzvld7s1dE0JL04aViPxh6Agg4I15sDhFycqbj2S+v1X9wPNeKKcHpz+MH9HjrRg49aSflwukj42V/K7p+jVusGEjbOXHE2cg7wD5icSF3eAnRMwDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036885; c=relaxed/simple;
	bh=snLFbEnXBKQVGlUks73lyegCvX770SSCXi1gKbSURZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSiMGVkc+BKS6C+WObsErWhNzyGdC6zE+7QZMBDbezd+VShYleZPsyP9vrrcMC5rHQsLPv2n3enz3WqjRH42++jOSDys5VIuQjSLydbk7DOzCn1ZRBac62RmfMMEOqD3A5Si2uirEEfDzqv6XFeASm5N3rnVyNCogbMewo9FWVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2QP6FQ2J; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FT1ND2OwNEh8HOPE8dyCM70ZUmqb7OimJCkQM6eWB9cOVxWsw5WwjzjaUjRcchc/0VqN0biuO0U4JTeWcTwitOuej3g0GiWJkaX8EPzG6X7gVooC8+s0bZCwwpECZ5vfCgNk+BCWMdw1964lyYhgUkE6DLCWP9vI5jK5efp0wQBKb7CRnfyZWgoHtUMHUdTQFGARP6/uE0F80lrcYPn6kpQTyPGQLSnQGlHTUdQJqeYC5SEsx44PAWnMOWjWd2qJL2jACvaZ5u0HH+Yoku/pxWlWl/3dpskaH9fMocwcP38rFg7mDu8olRAWOEXbvWw3dosut+vHic4jnx7+nVg7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFeIu1OOy7NmI9v4XrT9b1Rd6G/IHgfIrbo7n8grD+A=;
 b=UjzmNPl4hgdWmVp+X6PYrS6zCHf7+yhPkKoOcFwmnpd4dhIwkhnDeQBcW7GLxYZ67N3ejyk+qtsHYVBUpf+KsPLRctrvrP1w0K4feFNqqkfwnQ0bHQHBp148sk2drq7WqcBW0CMUL4umWE+OL0Wwce36mkxd8Q6Ef7TK+bdOqwCoJXdSmN2XuEjIo9a279eAhJFtCf7GvaSUmZKkR+ryJ60ZaD8Z0vJA9B+HGYRxm6jHMnhHlEmcB2KC9BADvN0GdyMYNSLJGAkwkBJhgr1Ap7DpF5Uqkuuz3HeegaCQWlWbHVhiX8Rw9Ixu4zzQzyOQ3m/j8jCG8H2odjhty8xldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFeIu1OOy7NmI9v4XrT9b1Rd6G/IHgfIrbo7n8grD+A=;
 b=2QP6FQ2JWXZVeQR/eUaL9qUENyMi4P0lyXDD6/rgrycdaz2nm0WgjFFX8wpH5si/TH7E+v8wFu6EUP42lr/Jd03EOPIEMj9W+Z2QA39LeSJl2oDU4fpatKxk20x9UNFO/UiukQXD/Xc+lhnrJTq9A2lrAum/ME9S+qn/VYb53k4=
Received: from PH7P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::24)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 17:21:20 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::be) by PH7P220CA0040.outlook.office365.com
 (2603:10b6:510:32b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:20 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:18 -0600
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
Subject: [PATCH v7 13/22] ACPI: platform_profile: Add profile attribute for class interface
Date: Tue, 19 Nov 2024 11:17:30 -0600
Message-ID: <20241119171739.77028-14-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119171739.77028-1-mario.limonciello@amd.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: fca57492-3cdb-42e0-155d-08dd08be95a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1F8i2RiYQdZkgKUe4hlTAKekSF4azYoMAH7PgjH2D44YAFHm1OK5zADlDRSk?=
 =?us-ascii?Q?wxn3TADopUH5gEpCVzTqPoE9hOOToGjC6dRyKFI1NpqJi+8Jk37B9SUsUlx4?=
 =?us-ascii?Q?HGeZ0L0bfLFSG/Rrg9bK1BUrC0HHAf4h9Ktu8ICriK/9+tYAN/B4SKHuK6Pj?=
 =?us-ascii?Q?IxQCKOVgZ2e2IjLmTT2DmeDKae+6AmNkp/orYysqrKuOh5RDE6mZ4xyGrJie?=
 =?us-ascii?Q?EpFMSR2eZgUQmOG4+aGNMsLsFRfn9HVD4ZnJ/5w4RVgd2HomVlbbxOoxrhQc?=
 =?us-ascii?Q?b/iOo5+weT39eLhe2W/X2VBN4FXHYhOf2LGi7xov8i1Dr2GxEvwCeXwiAql+?=
 =?us-ascii?Q?CXmfeSXbxdpi+IHz8jJw/rhdNIJyV6zWyUOM6TZop2U84OR8gxZMRLdtbFvh?=
 =?us-ascii?Q?sxV9SwaqreNqB7N9zIojirsuTBeYMai52XXRqjCncAvwCJZxgODDhZBAYTws?=
 =?us-ascii?Q?ZnfQaaRGcKbjc9oB00Q6pv+9KuPZnuznyxtvAPWqHAftC8rTulSwPUtQqqXJ?=
 =?us-ascii?Q?9xuSVzZ1tVKNBe8Ts8I0Rpt3q/Sk2T+g8pbyJhny7beGTVbNQUErV0Ggwbb6?=
 =?us-ascii?Q?enF+8Z0EVTKpIUFuNFR7epApk0S7fzM66TDt/JCHrZQTMWs5c3TC73bg/n3u?=
 =?us-ascii?Q?NPCt17xY9w6DK2T0Y1zH/nxL7YOFtKdgvXrqgRNSobzMFFxOXNpKrwI1rFp2?=
 =?us-ascii?Q?8nj717cnpQVfV/awNScJgaUmDlVegei0XbQws3ZP+PjX4tvWTTx4iUIbczc8?=
 =?us-ascii?Q?lWGzjFgptuwNzmTjHVDZlgk4PkvYTGqowm2A7MfwACtCwRIXZ9I8JAJyqeAp?=
 =?us-ascii?Q?tkMx7PPUDlgzMwMNtQtF1e8BMkLZZmiYCCPg5n8oGKvYX0P2bbhnDyUCE8Xn?=
 =?us-ascii?Q?JYcqDr6At5X+HmBqv50/FM0xps/zNnQKbn2h85sFuKZ6Mq0QDeCPuxMVX5zz?=
 =?us-ascii?Q?0GQJ22L/+RCFgrYNMd4NiiZzcf2EKDDWSakOkpQ75FXY7EwSaime4suLsnwH?=
 =?us-ascii?Q?7uO+nENgsw3YqmtpqRFjTVwaRbJlQ0ocXkuKvti5JqG0bze7stCY73CMn1bQ?=
 =?us-ascii?Q?nTd5aidrylzPJIznTJSXOzWcTlpdijOX9FcjveBClvOzDbxnf42JVLTftU1S?=
 =?us-ascii?Q?EkETxz9Mpv4LBsNubccDOnu0dUOb24q3ZPxfO19/8HjaWasJQrwNacYDOU6O?=
 =?us-ascii?Q?ZiNZczSCCVPEb/S1u80lI5TLxF7G0RB7vsX0DX9by4QcFukwa7/aUUu30M2U?=
 =?us-ascii?Q?BSmmCiEHt2NYHtquv0EndFzmnn5CjJHW82YNJuPM3ZWeK2CvTr5BjEAvnKsJ?=
 =?us-ascii?Q?heAyDMLk+SSCouiwmNMgub3dH3HvnU1KtJB9aahekw4Ujn6PDa9Cx0j8ixVI?=
 =?us-ascii?Q?th9Dind+U09Xbdpddgghyk6ym5GZ40PsbcYtkNtG89h8iuylIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:20.1903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca57492-3cdb-42e0-155d-08dd08be95a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450

Reading and writing the `profile` sysfs file will use the callbacks for
the platform profile handler to read or set the given profile.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Remove extra handler set
 * Remove err variable
v6:
 * Fix return
v5:
 * Drop recovery flow
 * Don't get profile before setting (not needed)
 * Simplify casting for call to _store_class_profile()
 * Only notify legacy interface of changes
 * Adjust mutex use
---
 drivers/acpi/platform_profile.c | 100 ++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 9d6ead043994c..1530e6096cd39 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -46,6 +46,52 @@ static ssize_t _commmon_choices_show(unsigned long *choices, char *buf)
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
+
+	lockdep_assert_held(&profile_lock);
+	handler = dev_get_drvdata(dev);
+	if (!test_bit(*i, handler->choices))
+		return -EOPNOTSUPP;
+
+	return handler->profile_set(handler, *i);
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
@@ -77,12 +123,66 @@ static ssize_t choices_show(struct device *dev,
 	return _commmon_choices_show(handler->choices, buf);
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


