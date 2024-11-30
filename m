Return-Path: <linux-acpi+bounces-9813-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1229DF0D8
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A2B164347
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFE71AB508;
	Sat, 30 Nov 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IHH96HZ+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B73D1AAE1C;
	Sat, 30 Nov 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975556; cv=fail; b=YzHfiGeKk7gft4BAoMBd1bVHsKqJjmccazhVVpuN9Cm8PseQQx9+2zCAIGHTsylp42bgvfMWi8P29U5FaSXnTC9A6uwfAkUp5pzGFiwoGVxH+NpPitEb98dbPxiCwP0laFAt9gYxfaCJSqePdLnZhKZSD+/sWb43RKuJ0GNUSVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975556; c=relaxed/simple;
	bh=h2Ky7jtzBaaR5QlbUS5caTXpmWSM38o1jfEgxVkS04I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxnCkURksmnfmjO4BscCmMkhrGTt/ve+FZnUGCBscK9PQKknkJJ6sdn+jNSqgUB0TruPwDwoFwdgmMspFTCcuMB/wagnsRJY0+RRVZmyzsKkiQ0+PnVfiQpi1FDXB+ZQdHFfYSpX+/2dho/J44wKPYAYOGYLj0i/8zsuL06lg7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IHH96HZ+; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxXpU9QBi/UmRm58CCYYHLp7EXH68hG8hh6C8fNkw/h8oMiZFgIyzquOvDEnuN1w70oW45coMw5y4+WkuxuFdPLo14HOKrJ/5p94CqI0q8W1xgepqwPzF36ImjH4MpQlFD1OqN2Tr/tebkacptH90GucemyPRsvVlopuaBFV+s1MxuxvU15bzqGcQoJoGBAQiSMfEany70LOn+x9jUKq71T0NIF2SpqfaEUxFYw1p2jU4DokXj2CKU04jGZKnrncHft72RAgqnr8CjHeIL637iRm3JO+TWPRooJ5VxHF6EDQN7cyyRNUfMlAWJnSZYipVKxELzyLuyngFfmO8pMaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5u9rsFMLdnHOXF2WWNeZ48KTr43LMKytBkZyDTIzUI=;
 b=AqgzWmLxiWo+PCgRSvBmZ5kLEml9NfjD+TeJdpiWLW9ref4ynICrzYtFQv7Olz5h1/k0tNhxJRdo1Az9BoO2M18dArM5oxMrdvCxlD4mHNJqVKzdtT0Ndi3UypMGJqkCKnZgbS8SGtTysBppZwtMcB/9kUtwT1gWd1kEkpMltb5qu0x/ClAcJklAIFxzGeRM/d5aQDxZeNFWQbYFoujsQLcbfuGqFZAF7EH/TpkYW9w6QCOvA5Gw7LDYGZYN/6l/uYFEQHIElzRDwZNMa6IzE6vaviPgYlhso4OS+VRrn1iDz0+6lYzjjhmRWXMjsO4Qx3Zc0fSGSjs3gRZRzrTNBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5u9rsFMLdnHOXF2WWNeZ48KTr43LMKytBkZyDTIzUI=;
 b=IHH96HZ+GzCfBgB0UmutNjU4PUih1q6QaGlwGD2lI31CNbZLgcNgRQtySXIxIWZjQzWY6+h5ibytj+Wko6KClbDRZg0B+vOHgdkO/27qIUjd5cepKXmRspgovAh/tNvZWFuKXDLfEKZtqgFteM7Ki9M3B5OB3Yo2ASfN2w+MKy8=
Received: from PH8PR05CA0004.namprd05.prod.outlook.com (2603:10b6:510:2cc::23)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:05:49 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::5a) by PH8PR05CA0004.outlook.office365.com
 (2603:10b6:510:2cc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.6 via Frontend Transport; Sat,
 30 Nov 2024 14:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:48 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:45 -0600
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
Subject: [PATCH v8 13/22] ACPI: platform_profile: Add profile attribute for class interface
Date: Sat, 30 Nov 2024 08:04:45 -0600
Message-ID: <20241130140454.455-14-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140454.455-1-mario.limonciello@amd.com>
References: <20241130140454.455-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eab7266-e5ea-4b29-1cc2-08dd11481762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cQBbXZHunCphh2Id4GkQUK1iTKyIf1amS+3kgKRq/8AVsvpJYz3RIuHT5yDa?=
 =?us-ascii?Q?O07scq7/rGT5+XMSdeJEPy51ecCXaY7SwY0qsNnCC7uh6QHx5Qk3REJ0zWsl?=
 =?us-ascii?Q?tx1WTMP6ObGKtly0pwWC/7/YuM8XvO6+Xq1mKYPK7h/PGXoZqZIb+W0JZiG0?=
 =?us-ascii?Q?sPNpQI8akFRC/Y2RhvBzPP/rjIXHC0TNLG3WDA2yw4IAghEo9QrfAEkc65nu?=
 =?us-ascii?Q?FXHSgoCQeorRZuEGFa3yuxjoFg/fFA5KdhFTPr408am/npaAkRsYXoaLALDb?=
 =?us-ascii?Q?DX0pkb0+AJyOMHn5/m/0PncMGZxb3edS2LjmDk4RRWV+Af5Qe9BNZJDFlfbx?=
 =?us-ascii?Q?MTQg1lWEcNTvTZxugdTxiGe/xxP9b1D6sskyBh4OAWUsDMUqEUirXKqBw6pI?=
 =?us-ascii?Q?wHgyDeUYiDrbCinHP1ODZJsCQQd5KAy3X4E1/162zjQmahAaITq+CXVFZT46?=
 =?us-ascii?Q?oGkak/n/P/sID/j56niU5Sb4gzPg44Ul7m5VCg991EtwhdHqqhWtg6SFBql6?=
 =?us-ascii?Q?1vB748YIhexKysOvc9c1WF+JuM3lrIfpcDzyl0CRq3sTSBO3VJKqROaZXxD8?=
 =?us-ascii?Q?SG9C2qckFcjJjCabCf+3A07tXnXdNymXn3X7oQ9VW3SaYZWomZtTMw4iLEUi?=
 =?us-ascii?Q?5ta2WKiO4M3bCLiGH/fcqKK0ZNBAbe7yAxeBP9mR8MTKzZ7DP8Ucxj90PTNq?=
 =?us-ascii?Q?3/fRpqz7aWrqIeMqfxaAzeRxO8ihCqA4ZaFSAsHKQqQjj3wuJ4HLHSi4OQ4z?=
 =?us-ascii?Q?HFZqUJCbhH7IGHNw3y6XmRbHcYdqVJSERuI434H0htDiqnluCIs2sIEVcm1A?=
 =?us-ascii?Q?uZI6O3ItOFN4yBsE3GENqFOk/WISxIoVTpqxm+6MIXqX/JvoDpzsiet3LkqW?=
 =?us-ascii?Q?EBspnastcUadn5mHSbqIA4bmYcu+aKKLSXdKJuBcBZvhWxcg9gH96JT6CYz+?=
 =?us-ascii?Q?vtfJOFGqtoOpUJK9VAkWYmmbWShRLzrDcsE/71js/0gpfP/b1O/soBhMO9Tj?=
 =?us-ascii?Q?EqsxHL4McxPSatfSzozjyPwB78AFZmBJ0s8vOsynBR9TP92QXCbWZ8AiwwOu?=
 =?us-ascii?Q?dbXXCJ039yeDQC4DzroCHPEsjzQMzajmF3bQVNoOSzn4+6BxWy+RoSkUZGor?=
 =?us-ascii?Q?6sQDnRhfh1Y+ic2uKfNcp8+wTaH+aMJI76mlZqkkzjrKkVTOqw6mxRd0JP6u?=
 =?us-ascii?Q?JknTiT77HLPNnA5eAQTJ7OfvkFePDKFOBvIb/Csw6zumSum0L0BG+jlILB0x?=
 =?us-ascii?Q?7ldGc9Zkeonqc/COygJDoz4krLgbeba+m/k3+cWpMHnFltoC4X8yHAgRhf86?=
 =?us-ascii?Q?3Y681HBg1S1X+z3RwaV85En1KRwHncOoBMxRyUxtvB3g7FrFdqIV6pH3Nlr5?=
 =?us-ascii?Q?zkJNtElD4IaxnohyqQR/D4Td8CkGSxfJjpLGR1s7uXHvY9lX5k3p19vkP+L+?=
 =?us-ascii?Q?K6k9zmVxRaBtyd9OgeJK/WBOgHXlhVXh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:48.2383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eab7266-e5ea-4b29-1cc2-08dd11481762
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378

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
index 6a257e500b190..dbb6428de3ad7 100644
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


