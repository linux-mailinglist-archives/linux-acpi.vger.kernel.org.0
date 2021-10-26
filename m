Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0BF43BA64
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 21:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhJZTLV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 15:11:21 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:5149
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231531AbhJZTLS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 15:11:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVjBmoeMTI/ijLYAFcr2cuBtZ3R6aTkIVfPqcmTaisOjAE1vjumnRloPi/WqGF6RWGBuaFnM5cSooCm9gcqfgBgVbvdRmc+xhZo3H5LN3Kdgplp1BKSQTuVQLD0ttOTDAMMvzyqIjM9dB85kI6UFj0h+BU5CR+UR1eoI2ywCPZNE0RR8MaQ8XSs4LuRC2cmD5rwQB0qkN89ffQyVbn68g50C6GPsXGp/4jDaCMHPe4Mn4wuflJhh1RfXbjY4cjBY0kMxErxdq3S4bNqwQPVZ/qs4x2iSldOxdPCwo02XMplVK8xVLO3PiqGuCcVRsecLupMZv/1Qg4kGgraptnvxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpRQJO0gIIW4zNlAjZ8wFo2iNNGpSGmOE0iSaQWDFRU=;
 b=gHWfCCUhfcwLGaHdVjkvmrSt4nfX1Nrt77zLVQLCFozCmsV0c5SZ26oaWggve8Lc98NORw9Z4ubq46e3Ppns+5tQ0qDx1NWPDXJ/BHx5lEXqlr7UtIcg6huzEYorNu7ZYcyy7rUtv67pg/1vIOe/AkKssUZVCyDvGxqPxus9aG6HYezwbw19piJNERPusjZZZBWUtDZKFSQKhgrcg8lFbHrbMuUqD8kwLdZitjb018kHy6sqWJ/2gA4kb2JXVQuLIRacyBCXIhjZY068ZB4ubz8VD9dun3fQBs1OwgtMQJySshRG9hAWXU14ZNfAvbJ96/ZMS9fuEb00qFuvDykvAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpRQJO0gIIW4zNlAjZ8wFo2iNNGpSGmOE0iSaQWDFRU=;
 b=KeMWnRIOrif1kmPc76Q3ShCMgiLkUVpVRolzL3TTz/bpMG8ceyWxel6KPJaEf4P/JkQezzYdrbVfDYxbR9++BpVJRm4MnFhkzBm/ndT5HR2ll908YXirjTS0SGVJMCeSK/uaSDsZxTnUtLDpvqIvnanW1xwSXb0rQkK92QYc4Uk=
Received: from BN9PR03CA0339.namprd03.prod.outlook.com (2603:10b6:408:f6::14)
 by SN1PR12MB2589.namprd12.prod.outlook.com (2603:10b6:802:2c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 19:08:52 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::ea) by BN9PR03CA0339.outlook.office365.com
 (2603:10b6:408:f6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 19:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 19:08:51 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 14:08:50 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, <markpearson@lenovo.com>,
        <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 3/3] ACPI: platform_profile: Add support for notification chains
Date:   Tue, 26 Oct 2021 14:08:35 -0500
Message-ID: <20211026190835.10697-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026190835.10697-1-mario.limonciello@amd.com>
References: <20211026190835.10697-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e387b7d4-d5b6-4a15-d112-08d998b40c4f
X-MS-TrafficTypeDiagnostic: SN1PR12MB2589:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2589B11E5CC66CCD3AAB4DDAE2849@SN1PR12MB2589.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1d0NlD5QsWu5WzOJCLRYaPFvvOOVWUkcI5JBT4kxwpFa/kLold0VYEet90n4q/8sWxQ3gQRsbaeb5c+y3Mde5VJ6cZx5hcqzQn/zCIi21Y++LwmfUCxl1RWOeb2jgFArcVtjGurAj+xCHtxD1LPdkQDnN2ehsEMvjTgXtwtIRUJO/5HxMJZ9z4oeK/RMws0nK+FIvfB9VZHIsDXzNKfT2BApGWsYPFiNQG1Muotm2kRizTtcOwN1N/0FFD08CHaLkReU21fjjo9yPam4azYlFIAn46wteox0/UI9tlOrjlEH0VgpJm0Mpmjmm0gSmi+8fxtsMfqJzgCC1CDHCwc+EpHPkbHMIx/jGGBd+IvFd3OtnffEo8UdqUGEzGD9RkaqzHo4CZqdKqa+cM8tuVgq83HfoOnNicUWdRx82Y/UJw1lijriUMs1QCHYgzOzwvJhmvF30NIyGUwvz9IYlpom4/GpzstDWo9duz33x4RygKS7ldKQ6WTRaFmrVYnPHKov4qZOGTAGAx0qiuQ3/y5olgaqgsP5VwdUhPEnleAsDogskIJ4r4Khd0vBZGD92px4zZoafV0of6+yppFZKw6prUnyeAlHTWKiulFFoN3oTEMAfyI6HfFec1jYQMiqSSkmt212IO1UWnH/+IX5qi5hUjrNhCKq98eFChMJmL9bUaP3vFk5oZ4zU0az8EVrY2gg7Sd0VXD7yVPHpF9Tx+B2pUO0YUhm1K5Nsdp4WGXhRA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(508600001)(356005)(81166007)(4326008)(1076003)(86362001)(47076005)(83380400001)(82310400003)(7696005)(44832011)(8936002)(36860700001)(8676002)(70586007)(70206006)(316002)(2906002)(54906003)(336012)(110136005)(26005)(5660300002)(6666004)(186003)(16526019)(15650500001)(36756003)(426003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 19:08:51.7168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e387b7d4-d5b6-4a15-d112-08d998b40c4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2589
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Allow other drivers to initialize relative to current active
profile and react to platform profile changes.

Drivers wishing to utilize this should register for notification
at module load and unregister when unloading.

Notifications will come in the from a notifier call.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c  | 46 +++++++++++++++++++++++++++-----
 include/linux/platform_profile.h | 10 +++++++
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d418462ab791..a2ea36d2b329 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -21,6 +21,24 @@ static const char * const profile_names[] = {
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
+static void platform_profile_call_notifier(unsigned long action, void *data)
+{
+	blocking_notifier_call_chain(&platform_profile_chain_head, action, data);
+}
 
 static ssize_t platform_profile_choices_show(struct device *dev,
 					struct device_attribute *attr,
@@ -49,11 +67,8 @@ static ssize_t platform_profile_choices_show(struct device *dev,
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
@@ -65,15 +80,28 @@ static ssize_t platform_profile_show(struct device *dev,
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
 
@@ -130,9 +158,13 @@ static const struct attribute_group platform_profile_group = {
 
 void platform_profile_notify(void)
 {
-	if (!cur_profile)
+	enum platform_profile_option profile;
+
+	if (platform_profile_get(&profile))
 		return;
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	platform_profile_call_notifier(PLATFORM_PROFILE_CHANGED, &profile);
+
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
 
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index e5cbb6841f3a..05ba3403509a 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -11,6 +11,8 @@
 
 #include <linux/bitops.h>
 
+struct notifier_block;
+
 /*
  * If more options are added please update profile_names array in
  * platform_profile.c and sysfs-platform_profile documentation.
@@ -37,5 +39,13 @@ struct platform_profile_handler {
 int platform_profile_register(struct platform_profile_handler *pprof);
 int platform_profile_remove(void);
 void platform_profile_notify(void);
+int platform_profile_get(enum platform_profile_option *profile);
+
+int platform_profile_register_notifier(struct notifier_block *nb);
+int platform_profile_unregister_notifier(struct notifier_block *nb);
+
+enum platform_profile_notifier_actions {
+	PLATFORM_PROFILE_CHANGED,
+};
 
 #endif  /*_PLATFORM_PROFILE_H_*/
-- 
2.25.1

