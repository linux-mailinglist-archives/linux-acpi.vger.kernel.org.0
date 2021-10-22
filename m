Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78C437C83
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 20:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhJVSTE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 14:19:04 -0400
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:14689
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231472AbhJVSTD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Oct 2021 14:19:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoqMTU/q3qZeWVpqfWQJGvmdrnk0/+5tbUWfJVY0gRx9oaO2YYS57N5L7ubeUcdXj0FoT8FTmBEjGxZ6OFE3j8T/FIhrhULl2JtCrKS53aOyWoQlsycAiRmC5R2DtI6m2otC53f67/+DDA5q5Luv4KfM08hk2hb5JJWEHN99XQZgXr4UqMJYvWl6jFdvt6FV60JQmvT6fImNqG25rSj7rHMthGQiSVgGX/Qvkt8JXzBvbMlfUPAYCuzrxveH4wXmYZTvN5RueQEljBnBfrdand9ssCaMqVI0bGTnkG47j+OXKTPtuBw9wQeOgALmr74FTQ/McwqC3eDI2djiqcbqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB2+xTo3jdu1AvUE7i094rYJQdQkLm4N8VZGZ4qWf0c=;
 b=jtvp9pADBfc0coTdo1UPNrFO5hq5ya91tXXoeu2xSrQelfLkLpqQ+x5ye3+YyEYDHxgzuSnzNThtt8P3eEmp0DyRahDBiAdRcHYYGQSXeL6y5WRA/r9D5huy31zZW5R8E9O/V0WmAK8FkRzCzKPC2n+PVxiEpqauyhIusvvOFY3N7NDOpp4+iBAw7UfzjL66viR2Jxle2nDXV2hRQvBLczYrOglU+waNUEnNi6grwBB6ShHJK/GCbj1wGizsIEIXwrlBCZd6xhSpn/JjFpinFy9wzZCLi4t2G2Wb1WHTCz2ms25D4VmgPD3DPEeZL+SFycP9PpOD8sCZHzTD/Gmf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB2+xTo3jdu1AvUE7i094rYJQdQkLm4N8VZGZ4qWf0c=;
 b=TU6i0wyRFOKj5vj8u90FPoCljOCNtXkWm2yTJdKo9LFpBhqB3sa7NJ/dfcXG+Jksfmos5u5iTj1Jr29rI6UbELToM/GjezcLCV3CChtSXME398bbTgDN9//CNqjb2AXQjg/7yIR4PHBY4r5ggBj3DncWZZ9kMmIpVyiaslNDKRY=
Received: from BN9PR03CA0960.namprd03.prod.outlook.com (2603:10b6:408:108::35)
 by DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 18:16:44 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::fa) by BN9PR03CA0960.outlook.office365.com
 (2603:10b6:408:108::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Fri, 22 Oct 2021 18:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 18:16:43 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 13:16:43 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     <markpearson@lenovo.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] ACPI: platform_profile: Add support for notification chains
Date:   Fri, 22 Oct 2021 13:16:08 -0500
Message-ID: <20211022181608.3121-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9432017-50b7-4726-9c0f-08d995881a5c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1323:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13230CC6882AAAFACA928290E2809@DM5PR12MB1323.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUOiy+2u7E9EBQMK/317yEsRcR44QYeGB18sPq9hEBLSaVg/YK5ehFK9bQIQa+aYNDY6A50Ga5WrAkGZWj0+xl3Y/kTkX9x7ffh3V5fWyhGESPhITIka5vhkrybv7Zyz1OzIMzCx6WA0iEp/s3E+mH81/HDTfUW8X/5WtLbtjmeZh7laUuXZu1UtjuJyn61ozrMstGCEUR0AZDcfrBJO6NVQr9OpLJZsGgoht5Eb4OAQslqHHtDwRmd+FB5thl/4LM0K5Ypm9FAxJZ4nt9usHzRWncv5HVeNgHtgix3agRGsUj3v4dmW1vX3pVWFJzlOMywxZFxiCCYq2nUn3OsLzxLP/ssXQWYCrvYEQCvJJQB9XUpheSycqkYQZYRY6vv+oOKcjU+vyGyY/V2GyVbhvpM3n1qIGBekrpEVE4pMWCfRiurX8FPWDG5UuX0/+L3RCmQcb3RtUf6dbeHloxbsd4K+Re7lU2m3MK5tu9ZSoWJxKr0eS/CCuhS6dMBIQBpeDL/MxCS2IzAHicEatBRcnFhODGX8Mf+udwCVlu6cQNk8T2dcYb6BX3T4oO8vTUjkfCBWy2a3t2wPX11Wnf9//IuZb3jG5SndRFLD+2+KB13VZjFQ48Tw/7LMxXLT7bUcNZrwqPVPR9DsRhoM1jT9m0mtvu0vvk3jGxQUoziM+miBnawk1zQRoBBUm8hNSQPEbDjglKdSzn1tr7YTO35fo7vkNuL1/t4Cm1KiZJWjlVQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(47076005)(356005)(15650500001)(316002)(8936002)(110136005)(4326008)(2616005)(336012)(2906002)(36860700001)(81166007)(44832011)(6666004)(86362001)(54906003)(8676002)(426003)(1076003)(36756003)(70206006)(70586007)(186003)(16526019)(82310400003)(7696005)(83380400001)(26005)(5660300002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 18:16:43.9553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9432017-50b7-4726-9c0f-08d995881a5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Allow other drivers to react to determine current active profile
and react to platform profile changes.

Drivers wishing to utilize this should register for notification
at module load and unregister when unloading.

Notifications will come in the form of a notifier call.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c  | 44 +++++++++++++++++++++++++++-----
 include/linux/platform_profile.h | 11 ++++++++
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index dd2fbf38e414..964e0c9bf70d 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -21,6 +21,25 @@ static const char * const profile_names[] = {
 	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
+static BLOCKING_NOTIFIER_HEAD(platform_profile_chain_head);
+
+int platform_profile_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&platform_profile_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(platform_profile_register_notifier);
+
+int platform_profile_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&platform_profile_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(platform_profile_unregister_notifier);
+
+void platform_profile_call_notifier(unsigned long action, void *data)
+{
+	blocking_notifier_call_chain(&platform_profile_chain_head, action, data);
+}
+EXPORT_SYMBOL_GPL(platform_profile_call_notifier);
 
 static ssize_t platform_profile_choices_show(struct device *dev,
 					struct device_attribute *attr,
@@ -49,11 +68,8 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 	return len;
 }
 
-static ssize_t platform_profile_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+int platform_profile_get(enum platform_profile_option *profile)
 {
-	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
 	int err;
 
 	err = mutex_lock_interruptible(&profile_lock);
@@ -65,15 +81,28 @@ static ssize_t platform_profile_show(struct device *dev,
 		return -ENODEV;
 	}
 
-	err = cur_profile->profile_get(cur_profile, &profile);
+	err = cur_profile->profile_get(cur_profile, profile);
 	mutex_unlock(&profile_lock);
 	if (err)
 		return err;
 
 	/* Check that profile is valid index */
-	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
+	if (WARN_ON((*profile < 0) || (*profile >= ARRAY_SIZE(profile_names))))
 		return -EIO;
 
+	return 0;
+}
+EXPORT_SYMBOL_GPL(platform_profile_get);
+
+static ssize_t platform_profile_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
+	int ret = platform_profile_get(&profile);
+
+	if (ret)
+		return ret;
 	return sysfs_emit(buf, "%s\n", profile_names[profile]);
 }
 
@@ -130,9 +159,12 @@ void platform_profile_notify(void)
 	if (!cur_profile)
 		return;
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	platform_profile_call_notifier(PLATFORM_PROFILE_CHANGED, NULL);
+
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
 
+
 int platform_profile_register(struct platform_profile_handler *pprof)
 {
 	int err;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index e5cbb6841f3a..390d95d47e07 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -11,6 +11,8 @@
 
 #include <linux/bitops.h>
 
+struct notifier_block;
+
 /*
  * If more options are added please update profile_names array in
  * platform_profile.c and sysfs-platform_profile documentation.
@@ -37,5 +39,14 @@ struct platform_profile_handler {
 int platform_profile_register(struct platform_profile_handler *pprof);
 int platform_profile_remove(void);
 void platform_profile_notify(void);
+int platform_profile_get(enum platform_profile_option *profile);
+
+int platform_profile_register_notifier(struct notifier_block *nb);
+int platform_profile_unregister_notifier(struct notifier_block *nb);
+void platform_profile_call_notifier(unsigned long action, void *data);
+
+enum platform_profile_notifier_actions {
+	PLATFORM_PROFILE_CHANGED,
+};
 
 #endif  /*_PLATFORM_PROFILE_H_*/
-- 
2.25.1

