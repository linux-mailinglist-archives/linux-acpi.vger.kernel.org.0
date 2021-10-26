Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0862143B8FD
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 20:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbhJZSIU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 14:08:20 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:1505
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235285AbhJZSIS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 14:08:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+L2Dg5BiN2KNCkUwh/z1gWhT5CSjJBX6G9C3oAQOPBXcRSVlQ1uG0ycmkGthgG5FYwhRXWB31Scgfgg9aHpTBh1Lheu0ulEMzpOeftuhSVTsyf5Fs8amSMKQLfVLsOivmYbJr7421MqCNlNGk31qB2NcAodMwEK/AyNJf/NcOTzdocK/+b+HAsVwom6JlkHWMFNypMBi+gpm5qhgVY4YS6WXWLQdjjPiKH4eRknyEtT1h5dmp0nelemQtZ/yQ0IHQ2dy7xFHelAeMNIddINSZOrusbA/j2wvhdeaBVl0cY8bKqCKbbH+Sj4o8V+R0/fV3YhkSppjOuQbD++mHE0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjkGC4Po/WcoCA/sAxsi8X7kyb5f1JbpEuXorhAYlJY=;
 b=BCI7jIyg5SwMQo3P9GSBOCKWxowDvDbPUkN/+VJXvgc44B5nZLFxGmiqhzEvT51nPfrE7mYPj9X4j6SP1dTPRIdhaFTfYznlg+R4SGUmeQ7rblm6SjR++NDOpgOrD70KCvEAMRuz2sfYb34Vrx4p7xhkTWqExviCaF/eIp3exzgBab1Xw/oXZWFkY92VDlXfMNvDH0qKGuUQKXSN2JhUxULXx0+BzavoRdK2PFkw7mdHlNdAg1lNp3GssPBxzt323HWTwfb135eZPWnsEYzDwX6uYDaCiqarsqooNePVUznWEpmo9h156qyXp1CWCj4OskXy0R8G+5Lk9cZMC/eeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjkGC4Po/WcoCA/sAxsi8X7kyb5f1JbpEuXorhAYlJY=;
 b=VmVsasO57+Z2f7K+laks8mOB4WSDSoAEX2wiyJ8U2QFXxQ+ZhkFPCghBKJ+e4FBuFNR31xzziAOFKK5vCIahrcbxVj7MNVe2crxexqKf0ySQDfrEo0+lXN8+DkewSIOj9XYkCJn2ImSXZYxa13hnspNH9GLOBRKEsVRuX+xBql4=
Received: from BN0PR02CA0009.namprd02.prod.outlook.com (2603:10b6:408:e4::14)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 26 Oct
 2021 18:05:51 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::dd) by BN0PR02CA0009.outlook.office365.com
 (2603:10b6:408:e4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Tue, 26 Oct 2021 18:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 18:05:51 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 13:05:48 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, <markpearson@lenovo.com>,
        <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 3/3] ACPI: platform_profile: Add support for notification chains
Date:   Tue, 26 Oct 2021 13:05:35 -0500
Message-ID: <20211026180535.9096-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026180535.9096-1-mario.limonciello@amd.com>
References: <20211026180535.9096-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 507aa93b-fabf-47a7-695f-08d998ab3ed2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-Microsoft-Antispam-PRVS: <BL1PR12MB504588047D0875E0E9F43784E2849@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFASbDSUq/yg3T2Ko6XHzK4wc30LnCwWkE+LHXrodAdxl2ev89gy2EVwGcfi94d5tXtH9Ys/RcMzbIb0itIRgPDH6x4FJA8fh0S3kkjc/4kifXFkkWrM5jb/RGz+Blrqv3Mc8S8D2sv984pvEVmWOjpHCNHG2bo0pk8ZA+hLQkjaqsw0rvx2FGw2VgNCubbX3K+ZCR7lb1M10ZtpNgpxxqlmAlCsJm9IFzfay/TJJIzt4w1uH8xOzRgSWFmlaUBl2sX+lMBwVs8hRhiIYhXdWJZknF01EzCrRmhxQ1jYc7E0sKuOGYTsXSUHXwPZdDqtMCLDUcHo7lRl5u5fA7ymH26PU766CoZbSqwIWvs2TgpcSp/EwL8tyZ1PdIPKDE3QH5i/T0UrDAl9m/YFg0a6A9zzozu6FtAt8zapR51JOzB3WtyfxGTG6QvV8BrNE0/Fp5VK6E7GPCErJqPYg5VD4ZrefxdI906kbVRIr0xuMPj0ijBlbNOYqiEHTfUq18yBSW533payAO6P+5TS+EtpV9+2un57Qa/1dXp31uMUoqxu4QmeHoF/wOkX/mzMuhTnJuHJq+WudMuWrUKeC7yx5IettaT+wxNWxFPjGxzun8pvnKOshDMiZKKoEuQi+veGn1wDvqfFKCMP4EA6Ijbm1tSdYhv25RDidClPFRnixu1OW/son5j6suwOYP2PPBLju+bN0a2rS9ktZ1G2t4Gy/nNcAWYzgTwSkaeU2YXl31Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(508600001)(70586007)(6666004)(2616005)(426003)(86362001)(4326008)(2906002)(5660300002)(36860700001)(70206006)(47076005)(44832011)(7696005)(336012)(15650500001)(186003)(316002)(16526019)(81166007)(26005)(356005)(110136005)(8676002)(82310400003)(83380400001)(1076003)(36756003)(8936002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 18:05:51.0002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 507aa93b-fabf-47a7-695f-08d998ab3ed2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
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
 drivers/acpi/platform_profile.c  | 48 ++++++++++++++++++++++++++++----
 include/linux/platform_profile.h | 10 +++++++
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d418462ab791..225247efa55f 100644
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
 
@@ -130,9 +158,17 @@ static const struct attribute_group platform_profile_group = {
 
 void platform_profile_notify(void)
 {
+	enum platform_profile_option profile;
+	int ret;
+
 	if (!cur_profile)
 		return;
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	ret = platform_profile_get(&profile);
+	if (ret)
+		return;
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

