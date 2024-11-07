Return-Path: <linux-acpi+bounces-9397-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149E19BFE12
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B316B237DC
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D55A1DD543;
	Thu,  7 Nov 2024 06:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E4p/+3fn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21981DCB2D;
	Thu,  7 Nov 2024 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959435; cv=fail; b=TT7QzAWHD1/DjsSrOnhWfZowekbM7JGtIGzOHrvEP8LDJAQVX8meC/wJe1YatHBmca9cHc03qRBcPS7ywqJw/jA4xDVA0hLlLH6wZvNFN+BAK25FTTtt4DIRLljra3TCJXwUkCkrD3VRMclcN7ahNBHfL6a5kKIt4/1Oh3y9CbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959435; c=relaxed/simple;
	bh=f0l893LI4FVlohn2BPDpkgTKzCKlgVj83c0H0mShSkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRSPYj8yExjr11mvKj2MsW2ntR6zAP5gvwKbeK7wencWoVMgAV6IJi6A/Xodx9NIbY1uF/IVHPg2fAB0LfuPHK8jrCzpuLqoO5fJxtBrKEBOPi7mncYVPgu/P5Mhmoh3FU/M3XEmOnWHgUTgRgpXVUmUaDlZfmubIAmqMJVnn0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E4p/+3fn; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtUhRo0weFmkugPGTsY2jNbMY+SqPf7+c1c9Y4xMaF8wwZqe5SW5UxwY7/RZ03gKEwcsQTbFtJ1NiYfIesgsKCZAE7G3nHSyYajxiMTS4BF2La//lm14xDv3sDzU/nmZEWkMY4djM5ms8JiMeZIZCBsW5/iRv6oDwiaQfdtigkQ1UTXElgr2ZvbD2+GuoIOlQQj2jwEIjt1wID7b9NjTVj3epv9QjAAixWZ7OUDRvlhNLjQ7YIi8WEZV/PgnOv5SqQPTDTjqt73HgBmdCr4HCCAHh/gV3Ttn5dV00ZBucQyWvYsN7yaY3K+E1lv4GxoFmJg+UL6Ds41DTO8xqIkkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKO6ignEE16gTq7imld5NyURl13XVX5rOoT2wTuRBDw=;
 b=mRE4N4b6NaQJDJdeoM7pM3gtsB1jJQo+LeltGY3fodLFgychmbiKbE1m62/b9y/ke4a5vLrDRRmY/h0jGyY2pAMXN3YXAGqDdQ979/uZtoJyxwA0UUz/7RUa1wbUOmEVcLZDSwqybnMDm502uEfWwJ0xW7rO2SmgMVMOhYsmDi0V5oHF5Ezg4pZCdoxk2CMCMB6V8pfWl8HGi5E7wdDsEJl3H+VhCQVCBfEqnUS/ApWzBxhQPjMhstguJIJXkHm91GXdxY1r716FUXvm48oFnBIeQH+HTPgRXjW8s92rLmPGPeYiRPXLAsW3s88EzReVqAT9CCEakINGtYULDdyuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKO6ignEE16gTq7imld5NyURl13XVX5rOoT2wTuRBDw=;
 b=E4p/+3fntAzw1IXQzi+JJGYMvEAL9+TKcPGQAkryQ2BhI2HEx8Kcloz8txLB7WO2+QVgxIyq7lvfVGbs5POeJRrhFL2R5hbTdXTHQHBxJM1juw5oA4hRJEQPmzfVU0H/1dsWN7ClDuFz7UOlmkxvEX5fsQ9gl9LZKsDP2tjsYAw=
Received: from CH5P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::17)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 06:03:45 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::33) by CH5P220CA0019.outlook.office365.com
 (2603:10b6:610:1ef::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:43 -0600
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
Subject: [PATCH v5 11/20] ACPI: platform_profile: Add choices attribute for class interface
Date: Thu, 7 Nov 2024 00:02:45 -0600
Message-ID: <20241107060254.17615-12-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 3165bf55-0f15-4754-ebce-08dcfef1f085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?on4eKRnvJEooSDZCAUkhJ0KEGkE16Ne3EbraH9ZWAp5Oc2QRMGxBiELoC9x3?=
 =?us-ascii?Q?4Rg2KzXGSRE5PLtAfKVQsg3tBVdxkpMHNvB+nIFXtix+npNEIo5H3jyO4GDL?=
 =?us-ascii?Q?Hpldablw9lJQpjk2FUyvWs2wYYPrDr8KbtyvcMkTXrk5izJd38oxIpc54vHt?=
 =?us-ascii?Q?BqZNvYqJKzU13mJrFAUDiNmw19n743S+YBrlyLpAF4QukT0gvj30dm/Cl3RU?=
 =?us-ascii?Q?83UZFgaUil6bpWfL++Etm8NyolgZwCtgQKQc9jRnUPaN5/7PCnaxAJHg/50H?=
 =?us-ascii?Q?a27XjyrRu2bmSoeErWvFx7nFjjT5br9oKYkGwCOFOzPU/xhgghpVGjFEwrPw?=
 =?us-ascii?Q?qD4Lrz5644BDHS4NTs/7fWBLiR6DX4koZe6QbgaKD26pwzwOgY9rT271ZplM?=
 =?us-ascii?Q?0fSr2sYRzO3II8b/5zmoz3dBKsuHoro5ySbIc60iheE0arszqTPVTs+tDfvz?=
 =?us-ascii?Q?lIyS4rz7JQe8v+9hXGtm9o16NvXStLZOzVG+QXVR/jCl8NzqiBU/lfJT7EdB?=
 =?us-ascii?Q?AIQbFgwc/Tkuo0/xCRdhB/UvVxFqy5jfRPPhrFjERa4/X42lw5LcPoNk8I77?=
 =?us-ascii?Q?m8rDKIz80jGpXocAEE0UIE9bQenEe02zjno89451GNtjle/6Ffay6jCUHO+U?=
 =?us-ascii?Q?3IPctUzvl2zk7jDvMwClWNS89IjplY8f+Uw/V5n8phIrusZf4bHJRps/RgYC?=
 =?us-ascii?Q?S2UZmk5pl/vIQEsekAZ9aE6W/htAuN6oVEVPzSncicIQGMC4Qe3ziO75ALb4?=
 =?us-ascii?Q?NSuGT6At/nPbkW0fW42I+3v3+mD2Ub5hx4OAdGl0n6FywPTgDBtzy52Vlr/4?=
 =?us-ascii?Q?rX7agvU8/ZHfvIAFEf+o3+9u/bOw94xUGVOG78cXR3jJsaUpfVeRwffSzYqf?=
 =?us-ascii?Q?SBbCaKQMvVrhi1kV8FK8cfLMkGWsrY/ui7ZwVoC2c1ypnqvCQ8TroCpis4so?=
 =?us-ascii?Q?PkBfQCYPEJ2twacYtvqAyM/mTdQmYC4uFgMJCK0H2fQn0aKUnMBpMmZozg0G?=
 =?us-ascii?Q?7zF4e2j09d4GRFPfM5ZZnIKgcTy1NHpgFyEL7u/qJcCYTOBWDaSm7nfhNxh6?=
 =?us-ascii?Q?+bHv4stc1O5YA+7QfisCaK9OZ7M4PxPy98cLhzoGhTHizibL8qNQ+CGd6Ew0?=
 =?us-ascii?Q?WKZWEcpqHQmwTTUYM4WuFpWdjYIpGwpVwVpHXmg4mEfwBwjs/rpMQsrgTHdk?=
 =?us-ascii?Q?eu7LO7XV+2cl11EpKbG7lS9RHuIGwE5wPdIqrntZ68ayQhxT0ImBbpZj+nvc?=
 =?us-ascii?Q?jkSIQ6rOQe9bv7IVfkCOPGt/yxi1npPMb0XI7OWnFD2vKHz5ymxzK/stwRXE?=
 =?us-ascii?Q?zBfZJP54CKG44NEEV2aih6NrTCibUUdWW9xeR9TWaUyMdww3STLIcXo9uOxf?=
 =?us-ascii?Q?FclEUAMOjiK6rKk/9v6H03rgdVG32610L8juu0ErOtCywl836g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:45.3305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3165bf55-0f15-4754-ebce-08dcfef1f085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413

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
 drivers/acpi/platform_profile.c | 65 +++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index f605c2bd35c68..5e0bb91c5f451 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -25,6 +25,46 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
 static DEFINE_IDA(platform_profile_ida);
 
+/**
+ * _commmon_choices_show - Show the available profile choices
+ * @choices: The available profile choices
+ * @buf: The buffer to write to
+ * Return: The number of bytes written
+ */
+static ssize_t _commmon_choices_show(unsigned long choices, char *buf)
+{
+	int i, len = 0;
+
+	for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
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
+/**
+ * _get_class_choices - Get the available profile choices for a class device
+ * @dev: The class device
+ * @choices: Pointer to return the available profile choices
+ * Return: The available profile choices
+ */
+static int _get_class_choices(struct device *dev, unsigned long *choices)
+{
+	struct platform_profile_handler *handler;
+	int i;
+
+	lockdep_assert_held(&profile_lock);
+	handler = dev_get_drvdata(dev);
+	for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST)
+		*choices |= BIT(i);
+
+	return 0;
+}
+
 /**
  * name_show - Show the name of the profile handler
  * @dev: The device
@@ -44,9 +84,34 @@ static ssize_t name_show(struct device *dev,
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
+	unsigned long choices = 0;
+	int err;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		err = _get_class_choices(dev, &choices);
+		if (err)
+			return err;
+	}
+
+	return _commmon_choices_show(choices, buf);
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


