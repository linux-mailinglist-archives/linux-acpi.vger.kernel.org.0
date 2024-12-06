Return-Path: <linux-acpi+bounces-10002-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63F89E64FB
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB9C188559C
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950171D5CC1;
	Fri,  6 Dec 2024 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oJDH3Swf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA11D515D;
	Fri,  6 Dec 2024 03:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455580; cv=fail; b=UE1y9bKUsF+LphmNf7VwwWMuZOBdLOSCaXLAVYki4vSbg1gfJhvREZagdCotqvi5+hcAOA2VtImckBb5wBRVCj/k/miBssyxPs+xr9KWEaocCtmRyA+83WJxedF5MHPyCJx/a4jgnmcZxbARlMyyWB6MP3P6ZKWvmDeHgNp7xws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455580; c=relaxed/simple;
	bh=73VCGxXEUH+QMSbDdxeJ397X7eVUA6+afqZAfy83QXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMMtfq12pTOMTiXF3SCwNsC1904gSEcdzvbjwgAOWG8uRHx8iJpNIZ4P79nxpYCzYXN5tqmu2YpjRegqiVB50c0+Nt0DskK8VYmArKe88salPqah9jbBWL6bsXz/pCSo5WKooHbUG+CEA+z72L8T7S2sOT7SmhTJ5A9zpsAzXGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oJDH3Swf; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIIXvIASEIJQwzFiUl2gyQlTMpBd0oTgwhEGvWetBXdFucYv0xNuFHX/GqJlCVHaCb/VUhBAN+MzOTLwii1i5Am7oV4ZINLsxWT69CE3PUcC0EaQgwuIuLdNsR2/y+5f7xaiNnAXWi9CBnBnFHFAIiu4eJSHF/RVsoam0khGhflx66YcBvlZIb8aRyz/jWUUrMKySEMSPRWQMlh4iezX9dxr/1LB9MzsegBqcBkvYYmSb4DaUUBB0fr1LSSZThRf9vr7JXVOf8t++kQFiX3Q3fT4jjGWidOk8r/P8y7tQMUNBMmWB8H6yQXQk2Y1wqrQLg4kp6wuLdLzJ+5K7daTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/orDSLYV1gL0+Vvmo9e+6jP2d9Qr1AnkAhlrFTLpBHs=;
 b=i/7+xWndZuTSLqo4E1Sebk4vQnxGPlKD2cOW8Geq+42zny23To6v92S8h8zQ0bggixkpwvJkJ+txisAbz62iB1w0JQzrWF9EXM8UmUh3DEO0QgpF6goihR9k2X2Ahs8oXMk4TJ97/bs2DRvEk7l6MNrya3/Kx5ozrw/v6VpqzsNlZ7fqxXHDkWkzAQzWwMrFyNsR3iMKcMpblLZCqwpoiWAxNygXADWR0jblwNpK+Ma20kI8rLOUBQMJZv67sSOL1Wj836dnOtLCJUjdBC7Ve5DUwHu0rfHxtbx1fOVNKOJF4MpSrQ14rfeFC8nxaVEGgFLBCrNwIG6VoFWdquakVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/orDSLYV1gL0+Vvmo9e+6jP2d9Qr1AnkAhlrFTLpBHs=;
 b=oJDH3Swfua3jQ6GdSoVQ+vpV2ECvIC13KF0tqPTtG+msNsWpN+4kG5Y2WbY/IilYCZHC1pc8pv7L1a13hItkOaJfZO3GVWGo9MPLLCducMKD2WUrQyvwNi3rHCHj+5eiY8BjgpAKuvuTrmUmy8EMxRQAlmC2huiLO8IC7d751bI=
Received: from DS7PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:3bb::26)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 03:26:14 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::ad) by DS7PR03CA0081.outlook.office365.com
 (2603:10b6:5:3bb::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 03:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:26:14 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:26:11 -0600
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
Subject: [PATCH v10 17/22] ACPI: platform_profile: Make sure all profile handlers agree on profile
Date: Thu, 5 Dec 2024 21:19:13 -0600
Message-ID: <20241206031918.1537-18-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206031918.1537-1-mario.limonciello@amd.com>
References: <20241206031918.1537-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 107b3539-f11c-483b-86b9-08dd15a5bd44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVRNR09IMlcyV01aZ3dKVEw0THNhTTc3S3JtY01MbUYvR3g4N2xyM2lGT21r?=
 =?utf-8?B?WEduQXlSNlNNVEgzWkZsQWVPaE9NRytUTkVmVzk4NlB0T1ordVBmNjhJcWU2?=
 =?utf-8?B?RlhmVGxQMFA0QTl4QmovK0ZueDJwcitoM3QwM3FhdVE1MDRkbGo0QU1UTGFs?=
 =?utf-8?B?NnpsSWsvN3JlWEhreVZxQldCRjV5bFJyMFBrdDRwdlh2Wk9ERTdnb2JUTU85?=
 =?utf-8?B?QThFa0IrVmZyVVAzQ3lqQU1Zck4zaVpTcVdtdzB3bFpoUDQxekxqb284WlNZ?=
 =?utf-8?B?bUVNNUNMUXVHYWNqVHcreVVHL1hSWjdqS3QwWE1mcHpSOWVUYW5XMm5qZDVV?=
 =?utf-8?B?aE1LcUtaMWZueUlPNXY4VEpPdDZ6TWR5T2tTUGNjeHcwdG5nTFJuUDdOTWxC?=
 =?utf-8?B?b1BOalk1UnMwQnhtZkxibXk3YUVDbTgrbmhtcGpySTcxV3FTeFl2TlB5UEpx?=
 =?utf-8?B?aDVzOGVEa0NqMmp1YU9ZNTR0ckZwUnZadnEzZllIT2NLb285RFJQa0xJT1ll?=
 =?utf-8?B?aXNaRVMzY2Y2U1FPSS9mb3VyR2RxR1JueHhFQjlaR0dlSW5ITVRHWmF0bzhE?=
 =?utf-8?B?VUdtbm0xT2QvUVZIZVpCMVowYVd3TDVpVjNOQ1lJSVJ4M3o4enY3aW5nT1Bv?=
 =?utf-8?B?bjluK3EwcDAvS1llL3hIcUF3M0NibDUrWFYxN1BKTUtHQytoNzRmSGl6eTFW?=
 =?utf-8?B?YWRpanJnSm1yRFpOUmxaVTBlQ3JNQVFQVitjQzcxdXNnL3NwTnl4VHI5TEZH?=
 =?utf-8?B?Qnp4SWMxRmNkZ2svQ3dzTzZHSUVwSUxxemtWeFAvTWxub3Z2VFRweEZacXo5?=
 =?utf-8?B?TjFmSkNzUXhOWFdUNTZkbnhBajZ6OU01ZDJwTld5WFBOVlNLaGNYZkFqNUVK?=
 =?utf-8?B?VVBsSUtpQlhRM3lKUkNqRUU5Wmt2Q083VlYwaHUwL054amJiOG5BTThBcjh1?=
 =?utf-8?B?RVMzUjdtNkdSdDUxODcrRnVKV2FodHVKWG5RTmxmcjlqL1hVYjRBUGtnVlhy?=
 =?utf-8?B?NGw5ZkE2NGovSzk2NGQrclhIWWhKa2tzU0VEK1JaRnVqbzBGbzJ3NUI0L1pT?=
 =?utf-8?B?dmMrVDFIK25QV3o5VU1xcGVaTjMxNjJ4MGI2cGVpQXJPM3V0VnJLZnU2dThl?=
 =?utf-8?B?UVBSa3dCeVFlaWdMS0NUcElEQjFlVkwvRHJCVEF4UEkveGxsMlNlMmlXQUFn?=
 =?utf-8?B?c3dyZEdlcHVFRldxVTIzeDFocTRNMitnRFVGRVNRcVNnMzJnTnhHR0dycStj?=
 =?utf-8?B?YXcwanVIeFNMM1kyK1NULy84VFhBNFRFNXlUNExaOFNOckF1aW8zalNYU3V4?=
 =?utf-8?B?UU93UVB0cGJOSHBySlhrYllnekhHZW55bCtUMnF0OU9TUU0wN2Uva0Exd0Ez?=
 =?utf-8?B?dmY4OHRFeE51a203Z2s3VzlHaVRtdXF0WHhmY21FbjN6M3RUSGQxUjlRYndD?=
 =?utf-8?B?cmpqNHRLYlo2cG1WSWo1YVN6UW9GY2JkaExOczdnTVNmdVpGdVZvN1UwNzEv?=
 =?utf-8?B?RnpVUjE0MllSbUgydWFDVUNBdytpUzVmVXRtb0p1S2FGb01VVDdpL2RsUCt2?=
 =?utf-8?B?aXg0Q21oTFBXZ2J2RzRNeFBqUnJhRmUxNU9wNFlJL2pqZWRWRjlINFJENW4w?=
 =?utf-8?B?WkZkaFNNNnJpUW4rVEdsWkdKV0pkMTkzVy90OWN4bVRuWlcvSVpJanJlRVE1?=
 =?utf-8?B?Z3BybEFhOXBqVEpta1NvTWFnYTVESVFUMjZGY1ZaamhRVmRxR1NId0VQSjZw?=
 =?utf-8?B?T1h1ODJBMU1uTm1tZ0FGL3ZYMzZ0OW5jUWFDcm9kUklPSUhSMVltRlBJeTRU?=
 =?utf-8?B?VVFQRkh5bzI0VW1jUEd4aGd6b3pCSWpRS0x6NjRIZnNKUnRUNDRrUWN0aUpU?=
 =?utf-8?B?UjlmQmVUVWYrSU1Va05UcThndDV5cjluWlJVY0lyY285UklLclFCRFgzT3A2?=
 =?utf-8?Q?T7aYCtnYo5ldkrX/rAZgkYxuhl+C9fS3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:26:14.4556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 107b3539-f11c-483b-86b9-08dd15a5bd44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701

If for any reason multiple profile handlers don't agree on the profile
return the custom profile.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v10:
 * Whitespace
---
 drivers/acpi/platform_profile.c | 125 ++++++++++++++++++++++++++------
 1 file changed, 102 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 54483269b8834..95aff045a1eb3 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -68,6 +68,24 @@ static int _store_class_profile(struct device *dev, void *data)
 	return handler->profile_set(handler, *bit);
 }
 
+/**
+ * _notify_class_profile - Notify the class device of a profile change
+ * @dev: The class device
+ * @data: Unused
+ *
+ * Return: 0 on success, -errno on failure
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
@@ -251,51 +269,112 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 	return _commmon_choices_show(aggregate, buf);
 }
 
+/**
+ * _aggregate_profiles - Aggregate the profiles for legacy sysfs interface
+ * @dev: The device
+ * @data: The profile to return
+ *
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
+ * _store_and_notify - Store and notify a class from legacy sysfs interface
+ * @dev: The device
+ * @data: The profile to return
+ *
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
+ *
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
+ *
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


