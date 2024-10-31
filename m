Return-Path: <linux-acpi+bounces-9181-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62DD9B73BB
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B0B1C240E3
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A8D19258C;
	Thu, 31 Oct 2024 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="spXwOoiJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33278146A6C;
	Thu, 31 Oct 2024 04:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347892; cv=fail; b=uwKHwpKi8ZtOb9yRBZlZe02ru+fqdsWdPdMiENsKUvyegfTaRg4gs9zzcc1lnbXpxI8WS7VramgOqpopeYxHd5wmAokLWli1jcXgDtBkZCPlIbk9lP7Na4qUOA5LZl04yDiGaUWlyq0nB5imD748e2OGXqwQg6K+l5ouVgHF4M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347892; c=relaxed/simple;
	bh=ASgI2mf+wn+56shboFohC1GXeGNgqkK7PrRqtaLk6a8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kO4UT5TdM9By14SW2oyy3ZYqumARW5X05OcrZHCtpXPGAjJPDvuhAFfn77dMQ58cbduQILP+lyTL9fNNMWlC0ldF4nlUEZbmaOXNr0tpPjOEtHy6T030p+ZHaGIrgl/tSyAlr4FsS84UJaRch3w7Mlp7FeNCWds/UANXrtGTNUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=spXwOoiJ; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUkwvJUVqtRbuGKookuuab3C5xfW0Ouefnp4/GnDQy0gNMLEEJDBfqcxekhJpVNlygYuulSUu6tErUPFQX2RT2g34Ps4XP5kGyjvaneWg6S5tWnq33NOVq4qN7lR5uEKCodfClgBM6D/eQ265KD86DNBUnn9YFOpguW7Hx1lWMNVEZxj9/yQZ2iKEtkSC1tKZLgjmXVC7HmvN6nzD+XgQmnLW1e/L0orEOFimKF7NWOAYIs9cO0taAqdro8n5HlCbiATy8cZ/pjP5cTvOm/pd1+9tSYIdDkwdSrJYJB3Uds1NDdMrz5SFj2ihtLtczZ3EhbUrz8WkEb+7O0rAnMSrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQFE8Inguc1AFWBccMNoWw32J5ynjV70yDTo8C2otig=;
 b=TDcJuzWWzixnbVcxGkSmIz/BZfJ/hS/2tBLbU4JT4EQFWtuJsklUXBU+ZLd9LSOO0JsMbGRMoaokUusekl/B53siJI3wQUXQ3Rf+NcIdNCpGcAmdWChnfx7ufX4c2rUvmNQtD67zQjXh6sIuQKSE7TWYRzWx0YctE/4DVfWd42e1aKfiKtUDPF3mDQG3U0gTpnjVtHgYqbxrN6TvLR+gmHCtb6tlqx84HwOKl/8eZuCO41Nc1JZBa3EVGhefaCE7wlB4AZUG973iQVOjchCfaYiQf3P6aDtB3xvZMbAFVl03p68wXrukoqvEBbJJ42gUmxT4Y/jB2v9wll7YefeHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQFE8Inguc1AFWBccMNoWw32J5ynjV70yDTo8C2otig=;
 b=spXwOoiJ2OHl/khhlODrsK82E+NhhFkce8Fp+qqv9Pl3lix2OFjZmU0gMwmh6XTEQCHQ46z9tpWQD4o5w49YQYWqegnc7yPDZXza+e4+tM1PVbfY+SqxYtcjO3Mn7ZK3afAQPAIVFdhyk3UzlNcAltz9zZRJUv1X3Tp30ipYozQ=
Received: from PH0PR07CA0039.namprd07.prod.outlook.com (2603:10b6:510:e::14)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Thu, 31 Oct
 2024 04:11:26 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::b3) by PH0PR07CA0039.outlook.office365.com
 (2603:10b6:510:e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 04:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:11:26 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:11:21 -0500
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
Subject: [PATCH v3 20/22] ACPI: platform_profile: Register class device for platform profile handlers
Date: Wed, 30 Oct 2024 23:09:50 -0500
Message-ID: <20241031040952.109057-21-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031040952.109057-1-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: bd320fb9-b846-4778-4169-08dcf96216e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eo+Xlb0PN1ZjhfnJCPPiWgGFJ4GdfzX5oBOPMROEBnONYP7um9vTZ85BHUDc?=
 =?us-ascii?Q?h6cSuDJdVnAETjFuRVFDLo7Nh0krErYKzf8RILTM+DmHxaYjOn0d0Z1wXxgX?=
 =?us-ascii?Q?xiAtPG7tdKM2xpmD2/isBrTp+iP9923ZImIG0jvQIooSkLs5AfSfjBLQc4Id?=
 =?us-ascii?Q?nfY/dikKLpdSV191qjPaW5yWbhMSAu/PFOviUMbidZV0DpD1BZ3Fb8gMd+Hy?=
 =?us-ascii?Q?Pzzxp8fEm0CiAJL4VhMVhZfLPudCkXxXAQUKV9XZGoQQHx0p+iS2T1LT0+8j?=
 =?us-ascii?Q?jqdXy64rDoAIxYS6mOHsi/e/Tqn6JrAXsTmqfeL5AFTQX0fVffkCnEUp34zG?=
 =?us-ascii?Q?/YMjegXQqZ37RjmfD/gt2FH/lXxIbPijwzMtgl9uPs/lsWm7uJrQXiTgSxDW?=
 =?us-ascii?Q?hfFdk4htcnSoRLrKq0jtJtL3BkE7tYgk/95mNdUBmQtH2mUWf1hVS0FyuNnf?=
 =?us-ascii?Q?Grb/n7fSKjiqOQ81pw6j0J72nlS1FUUJA8C0K7DLDUiZYZ8eRDBc0Ks5VHD5?=
 =?us-ascii?Q?EyaLP+HB4W2xJSDqVDfmM2E9UhG7GrAr6OCM5nxPTneefAhe6ZJprIZXzbxI?=
 =?us-ascii?Q?AhOkxepSsKW6/Wd/gX2qqvCAER7WfA3NyUZT9RTyctqgLc5iD1GYEAF6gQcA?=
 =?us-ascii?Q?mZZCUzyn177ikfKfld7rCpNAcf9V5dvKlh5ZKv+jTUNRrUgBFeY2mN3sGmXo?=
 =?us-ascii?Q?UP8AW3j7dkxxY5eBglJPQRmLhptxTfO+nqGzcbZyHmBSR1eWvYRM4J8mI1CH?=
 =?us-ascii?Q?9La35XWXASCuYEUwi59/xWnvKXnox8f+dcUqBNZ90sm+viFyWVcx9pTa4B2G?=
 =?us-ascii?Q?aWY3KigW+DBQRzJyGA/eaJNIZTu+CxBksuRBvBkHgQt4hEVts1e/dctVvpwK?=
 =?us-ascii?Q?GjOAtgwqFecACS/MSZWyRNumVDu7toLMWkzbuslV8VrsJ4KajTJM1iHpZc0x?=
 =?us-ascii?Q?xAd6F9Gsj/UqDZlOMh0L2QON25PUP9lYwKGnZyB9FlAoQx+wsci18ocEehpV?=
 =?us-ascii?Q?ljxb2oeKpvuJd/Xzo4yt+D/eF6pP8blmTqJQ4Y97Iwp1K56gGpm9q05k9LIC?=
 =?us-ascii?Q?pO0xlvcfU7hUK5eSIlvG7LfkitcXXq4T/AnOqV5U2Hao6gYutc9OyThgqyTO?=
 =?us-ascii?Q?dl9CMFqie6jpeAvRaTnCGd51MhxTCaCQWdDLFa9k4HZkchvosNWJcZFxrtXk?=
 =?us-ascii?Q?4T2ZI9zJTim5ehYxslOl0nx5UsyuY4nxKXITMScQKRPm0jRuMSbMqcpxe/dq?=
 =?us-ascii?Q?W7Kh3aNJzDJFJjsAgGZDVhzeBdnQUPNhSBsNHfWdcqt9YiWlGQIDdUWhjn2+?=
 =?us-ascii?Q?939Whb1LBry1GrtzYJM/gNaqWXdwhtpAmmPHf1qu+K7qamI6PEt9gkLAAdLR?=
 =?us-ascii?Q?/hLSzhmSTNCKSUJEifAf9UgGFacU5faEotejGuAvWzgpcz9NGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:11:26.2655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd320fb9-b846-4778-4169-08dcf96216e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012

The "platform_profile" class device has the exact same semantics as the
platform profile files in /sys/firmware/acpi/ but it reflects values only
present for a single platform profile handler.

The expectation is that legacy userspace can change the profile for all
handlers in /sys/firmware/acpi/platform_profile and can change it for
individual handlers by /sys/class/platform_profile/*.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c  | 93 ++++++++++++++++++++++++++++----
 include/linux/platform_profile.h |  2 +
 2 files changed, 85 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 9b681884ae324..1cc8182930dde 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -24,13 +24,24 @@ static const char * const profile_names[] = {
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
+static DEFINE_IDR(platform_profile_minor_idr);
+
+static const struct class platform_profile_class = {
+	.name = "platform-profile",
+};
+
 static bool platform_profile_is_registered(void)
 {
 	lockdep_assert_held(&profile_lock);
 	return !list_empty(&platform_profile_handler_list);
 }
 
-static unsigned long platform_profile_get_choices(void)
+static bool platform_profile_is_class_device(struct device *dev)
+{
+	return dev && dev->class == &platform_profile_class;
+}
+
+static unsigned long platform_profile_get_choices(struct device *dev)
 {
 	struct platform_profile_handler *handler;
 	unsigned long aggregate = 0;
@@ -40,6 +51,9 @@ static unsigned long platform_profile_get_choices(void)
 	list_for_each_entry(handler, &platform_profile_handler_list, list) {
 		unsigned long individual = 0;
 
+		/* if called from a class attribute then only match that one */
+		if (platform_profile_is_class_device(dev) && handler->dev != dev->parent)
+			continue;
 		for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST)
 			individual |= BIT(i);
 		if (!aggregate)
@@ -51,7 +65,7 @@ static unsigned long platform_profile_get_choices(void)
 	return aggregate;
 }
 
-static int platform_profile_get_active(enum platform_profile_option *profile)
+static int platform_profile_get_active(struct device *dev, enum platform_profile_option *profile)
 {
 	struct platform_profile_handler *handler;
 	enum platform_profile_option active = PLATFORM_PROFILE_LAST;
@@ -60,6 +74,8 @@ static int platform_profile_get_active(enum platform_profile_option *profile)
 
 	lockdep_assert_held(&profile_lock);
 	list_for_each_entry(handler, &platform_profile_handler_list, list) {
+		if (platform_profile_is_class_device(dev) && handler->dev != dev->parent)
+			continue;
 		err = handler->profile_get(handler, &val);
 		if (err) {
 			pr_err("Failed to get profile for handler %s\n", handler->name);
@@ -69,6 +85,10 @@ static int platform_profile_get_active(enum platform_profile_option *profile)
 		if (WARN_ON(val >= PLATFORM_PROFILE_LAST))
 			return -EINVAL;
 
+		/*
+		 * If the profiles are different for class devices then this must
+		 * show "custom" to legacy sysfs interface
+		 */
 		if (active != val && active != PLATFORM_PROFILE_LAST) {
 			*profile = PLATFORM_PROFILE_CUSTOM;
 			return 0;
@@ -90,7 +110,7 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 	int i;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)
-		choices = platform_profile_get_choices();
+		choices = platform_profile_get_choices(dev);
 
 	for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
 		if (len == 0)
@@ -113,7 +133,7 @@ static ssize_t platform_profile_show(struct device *dev,
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
 		if (!platform_profile_is_registered())
 			return -ENODEV;
-		err = platform_profile_get_active(&profile);
+		err = platform_profile_get_active(dev, &profile);
 		if (err)
 			return err;
 	}
@@ -138,12 +158,22 @@ static ssize_t platform_profile_store(struct device *dev,
 		if (!platform_profile_is_registered())
 			return -ENODEV;
 
-		/* Check that all handlers support this profile choice */
-		choices = platform_profile_get_choices();
+		/* don't allow setting custom to legacy sysfs interface */
+		if (!platform_profile_is_class_device(dev) &&
+		     i == PLATFORM_PROFILE_CUSTOM) {
+			pr_warn("Custom profile not supported for legacy sysfs interface\n");
+			return -EINVAL;
+		}
+
+		/* Check that applicable handlers support this profile choice */
+		choices = platform_profile_get_choices(dev);
 		if (!test_bit(i, &choices))
 			return -EOPNOTSUPP;
 
 		list_for_each_entry(handler, &platform_profile_handler_list, list) {
+			if (platform_profile_is_class_device(dev) &&
+			    handler->dev != dev->parent)
+				continue;
 			err = handler->profile_set(handler, i);
 			if (err) {
 				pr_err("Failed to set profile for handler %s\n", handler->name);
@@ -152,6 +182,9 @@ static ssize_t platform_profile_store(struct device *dev,
 		}
 		if (err) {
 			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
+				if (platform_profile_is_class_device(dev) &&
+				    handler->dev != dev->parent)
+					continue;
 				if (handler->profile_set(handler, PLATFORM_PROFILE_BALANCED))
 					pr_err("Failed to revert profile for handler %s\n",
 					       handler->name);
@@ -194,11 +227,11 @@ int platform_profile_cycle(void)
 	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		err = platform_profile_get_active(&profile);
+		err = platform_profile_get_active(NULL, &profile);
 		if (err)
 			return err;
 
-		choices = platform_profile_get_choices();
+		choices = platform_profile_get_choices(NULL);
 
 		next = find_next_bit_wrap(&choices,
 					  PLATFORM_PROFILE_LAST,
@@ -228,6 +261,7 @@ EXPORT_SYMBOL_GPL(platform_profile_cycle);
 
 int platform_profile_register(struct platform_profile_handler *pprof)
 {
+	bool registered;
 	int err;
 
 	/* Sanity check the profile handler */
@@ -250,14 +284,49 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	if (cur_profile)
 		return -EEXIST;
 
-	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
+	registered = platform_profile_is_registered();
+	if (!registered) {
+		/* class for individual handlers */
+		err = class_register(&platform_profile_class);
+		if (err)
+			return err;
+		/* legacy sysfs files */
+		err = sysfs_create_group(acpi_kobj, &platform_profile_group);
+		if (err)
+			goto cleanup_class;
+
+	}
+
+	/* create class interface for individual handler */
+	pprof->minor = idr_alloc(&platform_profile_minor_idr, pprof, 0, 0, GFP_KERNEL);
+	pprof->class_dev = device_create(&platform_profile_class, pprof->dev,
+					 MKDEV(0, pprof->minor), NULL, "platform-profile-%s",
+					 pprof->name);
+	if (IS_ERR(pprof->class_dev)) {
+		err = PTR_ERR(pprof->class_dev);
+		goto cleanup_legacy;
+	}
+	err = sysfs_create_group(&pprof->class_dev->kobj, &platform_profile_group);
 	if (err)
-		return err;
+		goto cleanup_device;
+
 	list_add_tail(&pprof->list, &platform_profile_handler_list);
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
 	cur_profile = pprof;
 	return 0;
+
+cleanup_device:
+	device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
+
+cleanup_legacy:
+	if (!registered)
+		sysfs_remove_group(acpi_kobj, &platform_profile_group);
+cleanup_class:
+	if (!registered)
+		class_unregister(&platform_profile_class);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
@@ -270,6 +339,10 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	cur_profile = NULL;
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
+	sysfs_remove_group(&pprof->class_dev->kobj, &platform_profile_group);
+	device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
+
 	if (!platform_profile_is_registered())
 		sysfs_remove_group(acpi_kobj, &platform_profile_group);
 
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index da009c8a402c9..764c4812ef759 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -30,6 +30,8 @@ enum platform_profile_option {
 struct platform_profile_handler {
 	const char *name;
 	struct device *dev;
+	struct device *class_dev;
+	int minor;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	struct list_head list;
 	int (*profile_get)(struct platform_profile_handler *pprof,
-- 
2.43.0


