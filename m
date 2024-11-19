Return-Path: <linux-acpi+bounces-9685-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B7B9D2D8B
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 19:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E90FB3BDA7
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF0E1DB375;
	Tue, 19 Nov 2024 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KME/kyN4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4C1DA11B;
	Tue, 19 Nov 2024 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036897; cv=fail; b=fTl2d0EMOjvrBoO2AYaVypOa6Ly3ZREIOCsIEfo4q2TMlJ7gzQldXhXi8DkOlbrxqptrMIsiD3JbcPp06PqZuYDoVdUgZdv54rKZIRX/s0vpTjlRkwdNoRK4+0QYC6cS37j8ipoDXCJwfnW1k1t+hOCz/2yC7Rdjg9uM0cI/lyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036897; c=relaxed/simple;
	bh=XdhrySlYFp+OvrJQRA57C4rcdrTgfHNmuwKwtVISUdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BESgtkXWiZ+qzaqEBGpr+8IFzqjaNS3xXVF3MUXYoblzFsrhN9uwBbER87HB734IaNPY8ntYw4snHWISI7VqZ/SWgDvIT7CUiMjbhTdV2RQpTDdQrsWqEyHeLtfNvxTH6CitX0bgWdWkfVDfvmP+qq28mNK4RFUgiYvfsVBFpxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KME/kyN4; arc=fail smtp.client-ip=40.107.102.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UX6RqhbvAjSqHD2c8NnKd3oLMzi4HfrXmmzZfMLWa3+4Xoa7yVITosvVJwOwr8IaaS1S2Rdg/kz8j13zwy9TRN4hw9nxLAgqdHWmVAThoezq0rCapaxLj5LTaYDVwv9XX2PBIQtEYgFTbPrg86gXMC/dVEBwH4tGflYFDg0+ljQgay7NxJ+DMVCumV37vKY40eD3s7e3qI0KR7lSzDGupGkmxYx1e7R1DcvDTq8rnOpX3/cZ8kKeeKKROphXC/kQfbkkJkavzG+p0uMNp8CxuqHcl3gZeHD4iSHyOuihdX1eQA4M0NLroufzWXL/enudRFs93wk4SPVyZXWfZIRrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGPAqd1+1i81/Riyyy4bkGTFIxSQtRIuLq5MJ9N5+Ag=;
 b=VgS49ZQoHqz9Y+zBkbGY5IyY3+f09X36Psar1kECmRutQNrsstBX6sduadsPiwC6QL6XIyWcppIHlELL/S2/629ZykoSdSlC953J+EiD+m05LP/4b7+MHFAoEbdRz5a9VcPVB56qcv1H/QKUyfIFh3m3iApFJ9Z6TQmjYQRG1cUYc4tNQXCFYEFFSFJeAaaYx84Bi53OYTUsUJetp2zhtfRDjhNNiYcoN8QqoEtSx//J0ABygMIEoJ5JXg38Fc0F3Hh97aGkHko/Jnv6WdRCbcEmF2uibDM1nPCZ4R3R7F4m9FPfLfKsbGMlXTbGXMwjmyJ1dlj1mFEWvPkScZePuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGPAqd1+1i81/Riyyy4bkGTFIxSQtRIuLq5MJ9N5+Ag=;
 b=KME/kyN4mJl6lQuUdFNSnHJWhjjRDXIqTjbsQXqmQuMXooGWIjR+PbU6XcO19d2mWUtd1xuj4AKsQsiFNdKCd/hK6BC6UN7DTO29iWnG/kVGCpgoPzEGZXnwEW0fFwZDYN9tbZGrTUgii/qGYDvv9/I82POtaRenRzyJHsuy3j0=
Received: from PH7PR17CA0027.namprd17.prod.outlook.com (2603:10b6:510:323::13)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 17:21:27 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::e1) by PH7PR17CA0027.outlook.office365.com
 (2603:10b6:510:323::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:27 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:25 -0600
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
Subject: [PATCH v7 17/22] ACPI: platform_profile: Make sure all profile handlers agree on profile
Date: Tue, 19 Nov 2024 11:17:34 -0600
Message-ID: <20241119171739.77028-18-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: c240cc43-cc18-4e1f-d287-08dd08be99f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gtk2ysN/8gddDLZNfbcJfmxZcz1E7tksdsvduP3IKP3gTg4hK1NWS5i2xb5k?=
 =?us-ascii?Q?4eGFwE/LY4861uCOj6dIDQSRP+mmwUNHUIRl/7qSGhWFrVjNHdTRo+dP5p96?=
 =?us-ascii?Q?TI/Ph5eIwg+Ys5BLjU+kUiLSQWqKVy9fTPhPMCGNn6/FK40Ax7biE+xjgp2Q?=
 =?us-ascii?Q?e/IOhHPhDvgVEYbAf4JH+Fn6pv08mZaSMBw6P6uAyKbyhwznLseX+yxlovHn?=
 =?us-ascii?Q?F3k8EsUgD8GW+Pd0JTIs/S6El2Qs2sWpbVpKnQ+U5vGMQhTbHvCOqSUTCkq9?=
 =?us-ascii?Q?Kvt2gPbb0y4p2JmCFZcV94l57C35Cry4IiPD0LKs1s9AvBy6XPlvbKJmiDUV?=
 =?us-ascii?Q?lcMrr23rL45kA4/jyY801W2vaZDiInNbOp8z38J9u9ialbkWfXrodopJp3So?=
 =?us-ascii?Q?ZphgGd7tSWaMnboHXaB7VqdPrixkg7uN9/QxF+VNCFrfbStKqF9qlT+3DfNP?=
 =?us-ascii?Q?nwaZUvcLzGpz6coCItw6LABPPpawCSgCJr8185sQgryFnLPgUzpB7MrUFfmP?=
 =?us-ascii?Q?xQCQOJVR+8VVcfxxn5NO5p4eArKFQaK7djI1heFfaDY39aiweP7VZony3eZI?=
 =?us-ascii?Q?6G3Kqv0GHPdtyzKptVQY4x7HmeYX7VE28+0XTMar8Dixh9LVhTi+R2ZoB1Lo?=
 =?us-ascii?Q?YYGjJVVeQDRoeqEjsZ9QDq+cH8KwapsYpJkeEbQAqO1nIedsXqgjTkOXnWcp?=
 =?us-ascii?Q?haGbniw98eNViAD2eaJoi21SyYJTA/SnbVJEZMy7I0uzJU4fbWCAw/izoviu?=
 =?us-ascii?Q?GBPxzqAHSLrdshxFqecWzBwgwl//zIneZKlO7mljx+ldQdD49ORWH/OwH54i?=
 =?us-ascii?Q?7L/fd5lmzh/gndODGh2t2uGaFF2zNdbAJXN8hwnhSFrjmC/AiJJBXbX5KUqv?=
 =?us-ascii?Q?tfHoiCZ/+Z6DseBowyd/XdfOo+X+BB1moKmiwXtgfJ+5uEAC5EfP0U+F5DHP?=
 =?us-ascii?Q?/aiEQr9872xN6FxsFTW0W7BN9H4qEkgi+zjVNC8IvVRMuj0d+zS/IpLlY0A6?=
 =?us-ascii?Q?dsuFFSOmL9hXke5RoxV8vhbbiub/qcfAxxAsIhgrNNpFHWk5zV8lNiOenb+V?=
 =?us-ascii?Q?OOdB3NyUiTaOcYCv7aO7WxPKSlt8RPK+VWDRgDrp+OX6bBgUXckKJ574lqCC?=
 =?us-ascii?Q?6MVnOlTsE04mMX7wCaq8h4sNJCJKK4VtJriTYeZqO22NCldZF4x0fpNOo12l?=
 =?us-ascii?Q?+6rI2lfSA2jMaHCjQe4SdR+avvJm5yHsBXa9sY6g5L+i88glC4nE0COIYGnl?=
 =?us-ascii?Q?gRommHZPdcotCkhLUROFEIHYFdFWhmLOYk8CdcbIr34GBtWSPZRy8Bg1nC00?=
 =?us-ascii?Q?NTvyF8G46VU933YEQns5YZPnSj3Fz6UB4ULnB6XpPErgBGJC3BDL353p9lJO?=
 =?us-ascii?Q?fB6JCHszv+jth4+Bqr56Mlz8MHq5lqaWorg88P5AJu6u2BW5/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:27.4330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c240cc43-cc18-4e1f-d287-08dd08be99f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139

If for any reason multiple profile handlers don't agree on the profile
return the custom profile.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Whitespace
 * Add Armin's tag
v6:
 * Fix logic error with PLATFORM_PROFILE_CUSTOM
v5:
 * Notify class profile of change to legacy interface
 * Don't show warning when writing custom string, document in last patch
   instead.
 * Adjust mutex use
---
 drivers/acpi/platform_profile.c | 119 ++++++++++++++++++++++++++------
 1 file changed, 96 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d579de1b31be7..a258f2481246f 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -65,6 +65,22 @@ static int _store_class_profile(struct device *dev, void *data)
 	return handler->profile_set(handler, *i);
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
@@ -243,51 +259,108 @@ static ssize_t platform_profile_choices_show(struct device *dev,
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


