Return-Path: <linux-acpi+bounces-9470-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9C99C29FB
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BBCE28460D
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103681547EE;
	Sat,  9 Nov 2024 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MT02j6as"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF4F153828;
	Sat,  9 Nov 2024 04:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127362; cv=fail; b=QiDOO7ySY4iivCzoG/fVkfGgihvbEYJv2WdT0+DqLICbcVJTgobxy+ay8rC47FGkZPwT2MMM7GfT49Gshhl12svSdBfJpzDH9qPmH1yprHSGeaNNEvYQePSU504J0u/AvbU1GIvvRv3r96Hj4/THIRZJRqUZIpvRhEY0rZfxAvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127362; c=relaxed/simple;
	bh=Rf7su+HSPVdgq36Yj8jujQk6/H5RCWvxS50NzowJhes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EaDLdNu5ENEaAbP97CVatDqDn/PiEP2wtvYWR6TYlgv1P+sMtbMFcBnaWQNURLrRDKr87quKKCnoKCAnVxcXJf7i/xgUjIrI5YgfMjWKF+7fcRr/F2SuZuP4FLuFOhV3Bb8VdNWNr+bjgfdBDRAs+leRPwVRb3UqcQZWQhctS5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MT02j6as; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFJ4tkGiTtPpVJZHjxNc3ZTsEoZ76WH2QnKwD9OwUGYdjH7aUYJULOGklDI5+pSuDyDnADkuD5dIssPU9W6wKcB5fWQdPuviRdkJ5x6XtEv7yghRRyY+nHxIcQjLtTcnjIVuqEeqxL4wgtu56OfwmchMSYUMdX/td1UBtEzrVdnTOj9M2obTj6lkgQCCvxoYMYXm5VIFWcZAFjwJgmBOH4lxDikFJXZxv9pjg4p8oBk+9ReMFklgLQN/bW7eOh+WCtdaQWb14I9jY0jb2A9bGJ5tYuVdJN/pu+Md2QFTIuvFSdtQtixiwyYbLwRrPjxqZlNvUVAvhu3QgjxwyeBr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z41Dx+lgJIJApg61W8wnpRXUX4cXnyjQpNEFZIlus8=;
 b=mnyT5LqkkG942OHB+xH7u7Yuy4rkQSWl2kxxLnCiak+KJMKRX6xLYA16lW0VwXuLc8JO2+tMX0uSeHCIDcfclJX3ST2n8/jA37aEyHIYyMUeKTP+1hDzKVcGJWQIdXFg4lhzuF4nOPs1iEoSkXo3AmJX6sOY/3hWHFp6jaAsTagzKQnsa3OV1N58wmRCqk87Xp7CaAxgaPV/DYI2QAChQtX6vdIvriW13AinAynskbCqnk9k9SRNSeOUF6Qq+PgdjPTLEZrksQ43tgXBO2zDaiTNANpDWvMNgq4JkxRmESAnS2FgDE9Tvoru7GmKX0Y0BJlVPyw8nxAoxwnv5OVn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z41Dx+lgJIJApg61W8wnpRXUX4cXnyjQpNEFZIlus8=;
 b=MT02j6asIT/mb5JkdOQ14Jk6HtqnjXwo/N78S7denbUKYSrSUzuyg4jNok0y88BQCZcYoqhnKLEoNpp11BSNI9qwwE8BraOPNhViNcZmtLS6VWIELWM/hGoQ8kK5fXGs2mWbUwJsjftPmXX9U2MQei1XagITb7tHs5xLipCT4hM=
Received: from SN4PR0501CA0055.namprd05.prod.outlook.com
 (2603:10b6:803:41::32) by CYYPR12MB8963.namprd12.prod.outlook.com
 (2603:10b6:930:c3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Sat, 9 Nov
 2024 04:42:37 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::d8) by SN4PR0501CA0055.outlook.office365.com
 (2603:10b6:803:41::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.12 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:37 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:35 -0600
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
Subject: [PATCH v6 12/22] ACPI: platform_profile: Add choices attribute for class interface
Date: Fri, 8 Nov 2024 22:41:41 -0600
Message-ID: <20241109044151.29804-13-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 93aa8639-5d3c-405e-87e5-08dd0078ef9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uJlqwgvtC/0B1rAXZBCGNep3BCP+x1jcFgPRO8eB7Uq0GlFqodrwCnGhWELv?=
 =?us-ascii?Q?YVbAymBHMSHgjzOJrT911ZAxFsg5U5Nlo/Zz/i5ZGp36qFrTYjI8kA5O/Hzk?=
 =?us-ascii?Q?dlDq7m8koVYy8H1+rjFJJf3O9wcVtmkdDKNCDQibM/ll4tYOGPnoYT4vJr3z?=
 =?us-ascii?Q?glaT4q2Td0F6WlPaYAXE1rgRTwAj3HUN6lFEtmMaqQjw+zzzHTgrsFTnksl9?=
 =?us-ascii?Q?T8P82DoaRBGdFkcQQQgEwO7XstBq2+fV7FaUQfmSG+OnoH8P0wPpyYUXTemv?=
 =?us-ascii?Q?uDzWhjrCRuxW+8EexJac64unWtxWnHTBa3YPCfxg7088hbgaDGgnTy7KRxBC?=
 =?us-ascii?Q?0UF64eo/m2CS/Y30Y9VJJSHWVzDer33dVKFGyIslNbDf1EqeOnDWSuzzZKXq?=
 =?us-ascii?Q?9mvu3TOFoJQe3Y2q8WJYuSLq+IVGyatI8l7QMw7ELsFkOySVPwZU2oZ2dzKn?=
 =?us-ascii?Q?gfZ9td2jLGREjVgUPrPb6HtLYGV3ynfb2RevmA0W7/EJ8BfCgMPBmJKy815G?=
 =?us-ascii?Q?Twve/IQC3Ag1rTjTDtsryMk1u+a3ni2JLpWuSzy1QteY/HLUBF5+X49LhYfZ?=
 =?us-ascii?Q?Ss4oP0s0oVHAIdT08RoT/hhE/mIn6d8dq06fdzNUgebhCzyQyzJo1sbJf7zy?=
 =?us-ascii?Q?i3OyHKNu6Dxx1lZ/QLCspTkK305rDpIT62Sge3xxrMKQlREp7yIFI3cD54PV?=
 =?us-ascii?Q?BdRWIGqE5uWu9X2isAHQMhFOBd4K9uv6QuYHo1xAOVQKUjmB39+5wxG0KD03?=
 =?us-ascii?Q?YWPuvFsuFiVXvIPJ6bOpDAHwS9qWVm8eT6+b49mnylIAcQJYicvinubx9bfW?=
 =?us-ascii?Q?jTbN2nQ09inzjsVPa1AO8AZ64A+de/gm4PB274u8O4ZnIeJwiVDCYoLjaOYf?=
 =?us-ascii?Q?KbqPCrQ8OOK0BeqpPnQgwW6/L3omblR3Q7S09nnzI8uR95E5dhW86ksLUfOc?=
 =?us-ascii?Q?NS/5sG1SnUfelFTyyjrtahO+XGxfW6t32h6ZQ7WrmisFMGtuMg5wtgZkAfKV?=
 =?us-ascii?Q?R0uijVlzd/ecCbiSucYWc7yUQjGnTTLUdIU7OVNImZXQAJGqcOWcL6+K/bmH?=
 =?us-ascii?Q?PfqqXL8ZThxgOhqpeEHFuVp6kkUGuBvxaRR2yhM2hbc/XjCAgNeDV7F3XIB2?=
 =?us-ascii?Q?fclej/END4DCeeNjqYlMjsELqHje1M8b/ICBm4PggoHGPbw4jU3bIsDriaui?=
 =?us-ascii?Q?6mGdTFp+XQHvYOFuzsz9bDGhWJf7ncZ8Jd6Gwbcw8jgZpeDQH68nGUeoQTA1?=
 =?us-ascii?Q?GcEG/28BmUDiU2dKu/mS4q8ouS0ZnSyjeKn6N3/c/6Wd9BcBHE4VwLC1R4zG?=
 =?us-ascii?Q?holKOB7+UGbyUV7ZzpJXdNMibjVn/pmzuK8uFCjT21ggCQIKFA5QZH+aryMG?=
 =?us-ascii?Q?Lp4boSaStrOw/0bWQYN5jSjXAQ2fHLEFoSsC2dmG/zqbcuo28A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:37.1720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93aa8639-5d3c-405e-87e5-08dd0078ef9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963

The `choices` file will show all possible choices that a given platform
profile handler can support.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Fix kdoc
 * Add tag
 * Fix whitespace
 * Adjust mutex use
---
 drivers/acpi/platform_profile.c | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 4e2eda18f7f5f..86d0eb7cc6fc3 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -25,6 +25,27 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
 static DEFINE_IDA(platform_profile_ida);
 
+/**
+ * _commmon_choices_show - Show the available profile choices
+ * @choices: The available profile choices
+ * @buf: The buffer to write to
+ * Return: The number of bytes written
+ */
+static ssize_t _commmon_choices_show(unsigned long *choices, char *buf)
+{
+	int i, len = 0;
+
+	for_each_set_bit(i, choices, PLATFORM_PROFILE_LAST) {
+		if (len == 0)
+			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
+		else
+			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
+	}
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+
 /**
  * name_show - Show the name of the profile handler
  * @dev: The device
@@ -44,9 +65,32 @@ static ssize_t name_show(struct device *dev,
 	return -ERESTARTSYS;
 }
 
+/**
+ * choices_show - Show the available profile choices
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ */
+static ssize_t choices_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct platform_profile_handler *handler;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		handler = dev_get_drvdata(dev);
+		return _commmon_choices_show(handler->choices, buf);
+	}
+
+	return -ERESTARTSYS;
+}
+
 static DEVICE_ATTR_RO(name);
+static DEVICE_ATTR_RO(choices);
+
 static struct attribute *profile_attrs[] = {
 	&dev_attr_name.attr,
+	&dev_attr_choices.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(profile);
-- 
2.43.0


