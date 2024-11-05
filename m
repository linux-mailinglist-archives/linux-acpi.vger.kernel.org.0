Return-Path: <linux-acpi+bounces-9309-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7E49BD094
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C190D1C21B7A
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9741D9A79;
	Tue,  5 Nov 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DAwQB/l9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D517917C9F8;
	Tue,  5 Nov 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820829; cv=fail; b=FmXXFPtuQshWwY+hmtrSPavtnG5M9Ru8lfMlHegM+67OyKq+6lIOL0go6AKJXY2EqPpVvzBScTE1itpKzCgQOVi+PmJG2mCek+M9LOYixrcUT/uJ1zbEX2wH4H370AOpElROc6iyTiJi4xj74MvG2p2C47lHv8halz0Nn/ZVVWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820829; c=relaxed/simple;
	bh=TKrfIx/ehNBqFKp6HxS0kQpPp2ZLQ7nnOD0u69SIGUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWtdw11Od/Us4AWZEkWniOZ2BXL4Grm8HBmuLZTEGdwwQb09whLr9CmFjZeBdd1lcEN7t9o2fOZIQaHxdQ5SkasOvq2KcAowEc3PsJi82Ho8gzKTnG5wJEqCk6XPWO5OtNOBCwxWNWjBmLxdSZQUAEqsspfpRiqiA44mFplc4mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DAwQB/l9; arc=fail smtp.client-ip=40.107.95.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2WVmSn6+UAkxJvj2F4MS1zSzTllDnbP/Gz8saFycGyiVFxtojU9JnA2Xu1x6Gy3wziV8nSOKDcP6G/HtzFHhKK5ABGmEbjKEh+WEQ8PROEku8gqcSt26JC2hr1sbdiRP2xXNalV1IBMNYnFWkIHLkdGqwnmA/YjcyGPv3LYD6CIGEOzFcB8SgF1wkLKN9EcV+NS0ZnK1JZS4vpA7PQ5DzHllXMpnpbYc1nhQYKzcMCcYNi5hoFjk1LxcEZNAcUL6VIvYh8e4pwFt/Ob7tl9HPnNV5oPTgi5Kkx9lN5zwbdjmdieVtK57l7fI0r+5tdXV/5V8sFo+KmIPlkSvdvXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJpLiFAFUIKpH4h3eLZ/owU1Hf+GXYfHSQ/QgRftZXE=;
 b=kgUiK5kHEfHcI9GU/+tzuk5KhEag4fv5x79azlTU9C3wP35pKg2LTUZZtRzgaRYOIH9O0MsRPvXBgcYGJE8zv6aNTY9+8iZ38GT4xQpeTc1UCef8Gdl9WaPpFjg+DjngphsbAcIdRLfqAbsbadZxj0Y4/CP8Mc1CA0ZKE5HtllUlWB0O/XitKL6Bj7hOdO/eiUBBTM7LZEuYsUk0FwhOwIJKMd7xKiwsSXhrWGUBbPmDgNiov2CwqwDn65bwqQXQDj76tyRySmz4UuPIH15IUOfCcDhOSbYmkkgKXzOIFgNurx9SFuN2bmauY7b6np2k+oz4/dItAtIKcrB5JSZfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJpLiFAFUIKpH4h3eLZ/owU1Hf+GXYfHSQ/QgRftZXE=;
 b=DAwQB/l9JEp1zPCdt6HOP8bKUW38NwE6fiHRJUQOdpQqyLoQAeqKOzG7f1EFISLBpPCMtpzW7K94soHjOiLiImqDjyIGIyHBXdWX/f17iwAuCOmmbR24SHVfpGMpdwyabvMlR18CAcVRkP70Ubj2jI9mqXKQf4PmWJVD1k+2M0E=
Received: from MN0PR04CA0007.namprd04.prod.outlook.com (2603:10b6:208:52d::12)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 15:33:42 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::93) by MN0PR04CA0007.outlook.office365.com
 (2603:10b6:208:52d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:40 -0600
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
Subject: [PATCH v4 12/20] ACPI: platform_profile: Add profile attribute for class interface
Date: Tue, 5 Nov 2024 09:33:08 -0600
Message-ID: <20241105153316.378-13-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|CH3PR12MB9455:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b06ef5d-1755-4d4d-e812-08dcfdaf3ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CvuLkxShw9THo/Uw3u4Jf9VNLdZXQ7RQsvIFIdoSu/ZiJ9TTKIT2hTgyuy9R?=
 =?us-ascii?Q?6YNJmL+uRQr1AkXqAbX6pW2MWk2tgGTaxSRrWbuPqDDusrdRD0Z6esW/4q97?=
 =?us-ascii?Q?a7/P0NrNxwoA6JqFcPgI7NGbUQyvArvSyuvvAhRjwW96Lth50AOfds8qdlpF?=
 =?us-ascii?Q?GGvTc2SE0CRqzrxfU2xYabsmJd3heT1mZL5USmrRz702Tlj9Rc/9RwpsEV8q?=
 =?us-ascii?Q?Mm1r9hBdpUHZg/TOv3hDWa9ZFKP75CAFfJ4mpjvhh0mLaELX/zaeJ2a0NCHW?=
 =?us-ascii?Q?yLb/gRbi3cqEprdwz9I36/ctzqQQ2SkZdPXV+5HFXFsewI51I2ckxfambir2?=
 =?us-ascii?Q?drp7eOkrMPZ8ynoSa6GURc6eLQCRL2LaTgjO352tH6TCgvWjzlaU9KmL1kxL?=
 =?us-ascii?Q?XPDMqhQ8WhcvEBRPw4XlqZUbOB0f233Dr5MmlaZ3JmVEICjiJqUUlWRHLbFh?=
 =?us-ascii?Q?CXWFsputOxSqvacKIyCYQA6GZJAqRub4pd0sgbzY+Pu6bTrSi0mr8oWUcovv?=
 =?us-ascii?Q?bpknqiuxZbAjhxUTn9Nu7VYPRXg87Voz/4Hu/JV4nBlwDOvYQs9M/nG1R0+G?=
 =?us-ascii?Q?GD26d3+CzG5wMqNyeWvE/P4UentDTlh6d6VNpjhQV5FF4ks2Qa5rGdhOc4I/?=
 =?us-ascii?Q?GauzrI0W39J8snkTMzPKhOknUPzqZkzXxjJuEzP+kpqUlDBMqWrED1HQjB7R?=
 =?us-ascii?Q?ig46J17o6Zmg81C7NhzUH6ZfRa6xbftwAllAPCsD4rkDT50Ioga1tK7BneCP?=
 =?us-ascii?Q?Tl8rMtqiLb+ZBKIoJJelqioV2Oo4gSO9TfXn8UKk1CTPPppTRp2shlqjJdQT?=
 =?us-ascii?Q?92NFWD7QbXHMW/VjoSlngzbQsTzii7we+dtuDfrkHWEAx5wOPOq3v8mm7SKU?=
 =?us-ascii?Q?9pqJ99cmK9w0DDGks4nzL3gX4bGtwIlElkZasJQBlYE4FBwtNkdvaoERW9k9?=
 =?us-ascii?Q?zi8KiiXYC5EwqIpgzWFB01WeSYJ9XIW4Dlk5coKBAaha9GLQTIguxQVXd1PU?=
 =?us-ascii?Q?F9flcN5dw6ofglXW3M8lObpmCK+m1PLIBqDrHgBk9TduKZmtOHP6r6d0MEar?=
 =?us-ascii?Q?vb0yxpYLVoUL86p4ktDhmSnYiWVChQVKyFCGnRUVDjxsmZ0r9QxP1THYbI/g?=
 =?us-ascii?Q?/WPLpH4h/cobsbMa9OnZBI5pDIbXTHEt7Lf7GiRNfx5Oo7sKFewiKUvjMchr?=
 =?us-ascii?Q?hFYib7OHlK8A3qypRO4CbzF1L53ellcXrBOnrl1POU8svDTJ/7HqMtJDiq5B?=
 =?us-ascii?Q?Xs2CDMX/VWsL+XCYBjzuVgS+yPk7edARvxHgAZWZfu3nLvftX8UV6Ns0OexE?=
 =?us-ascii?Q?aWqjVDi5WqJrehkLrwgCPuGkvfunee6CovI+7Hglmy3kmh6Je5cKBWhrnINN?=
 =?us-ascii?Q?qAqU6Gdnx8LfOyLaLOQLaBcmrctoXddV2hNGevx5o64JcViZHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:42.7016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b06ef5d-1755-4d4d-e812-08dcfdaf3ad0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455

Reading and writing the `profile` sysfs file will use the callbacks for
the platform profile handler to read or set the given profile.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 118 ++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index e1b6569c4ee70..79083d0bb22e3 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -65,6 +65,78 @@ static int _get_class_choices(struct device *dev, unsigned long *choices)
 	return 0;
 }
 
+/**
+ * _store_class_profile - Set the profile for a class device
+ * @dev: The class device
+ * @data: The profile to set
+ */
+static int _store_class_profile(struct device *dev, void *data)
+{
+	enum platform_profile_option profile;
+	unsigned long choices;
+	int *i = (int *)data;
+	int err;
+
+	err = _get_class_choices(dev, &choices);
+	if (err)
+		return err;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		struct platform_profile_handler *handler;
+
+		if (!test_bit(*i, &choices))
+			return -EOPNOTSUPP;
+
+		handler = dev_get_drvdata(dev);
+		err = handler->profile_get(handler, &profile);
+		if (err)
+			return err;
+
+		err = handler->profile_set(handler, *i);
+		if (err) {
+			int recover_err;
+
+			dev_err(dev, "Failed to set profile: %d\n", err);
+			recover_err = handler->profile_set(handler, profile);
+			if (recover_err)
+				dev_err(dev, "Failed to reset profile: %d\n", recover_err);
+		}
+		sysfs_notify(&handler->class_dev->kobj, NULL, "platform_profile");
+		kobject_uevent(&handler->class_dev->kobj, KOBJ_CHANGE);
+	}
+
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	return err ? err : 0;
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
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		handler = dev_get_drvdata(dev);
+		err = handler->profile_get(handler, &val);
+		if (err) {
+			pr_err("Failed to get profile for handler %s\n", handler->name);
+			return err;
+		}
+	}
+
+	if (WARN_ON(val >= PLATFORM_PROFILE_LAST))
+		return -EINVAL;
+	*profile = val;
+
+	return 0;
+}
 
 /**
  * name_show - Show the name of the profile handler
@@ -102,12 +174,58 @@ static ssize_t choices_show(struct device *dev,
 	return _commmon_choices_show(choices, buf);
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
+	err = get_class_profile(dev, &profile);
+	if (err)
+		return err;
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
+	ret = _store_class_profile(dev, (void *)(long)&i);
+
+	return ret ? ret : count;
+}
 
 static DEVICE_ATTR_RO(name);
 static DEVICE_ATTR_RO(choices);
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


