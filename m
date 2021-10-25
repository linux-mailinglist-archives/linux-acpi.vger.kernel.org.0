Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1989443A562
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 23:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhJYVFd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 17:05:33 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:16993
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231339AbhJYVFc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Oct 2021 17:05:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFhFxUCv79EJsAGVnZbEYVwglFg5tWo5icGAP2LTD7ikCLX1UVjQLyhA9sWnEpEllo4U0LvJECH1T3cSUf11a+UFW0xTisIQO7M7mrrQaIosBvnVfeLq2l4pJXA8aO5Xse/AVAaBz1i/wbKDQQKjwY0gz04c/FykA3va4jYrVg7qEFMkDH6VJ5fsDSFYi2gxKB8Fi+kfS8PWcUpTHt/eAhwH+U8QUVH2nX6ocH1k2FI9vvATSRu4zmMuaUxHTZijLboH1U9o03IGt3PXz43TeIrW4/2BcD7ch34gyZRyQY9ztMcUsu2x7mlUaYaC0xqMkTdgtIbc4aiyAluSKhljnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnRl29aXok+GnDEZFhs+iPcMRK17CUHUeqJzWC6gXV8=;
 b=es+a8ICCFb7rCwC8+IsztWq7Q8BLGyR3wcFFxGT/vaESPifgZ8zLa2Mhbo/DWB8YBiPINsBUoqMuExYTItoXa+ddLpXOFhYhyzuLNUFeLdzPNT/SRzx1bjWoBvpdOwiZRwFYiKV+TJeXGlyUDBtuG5WovJZ213KfHxwHGYqwDu22jRiePxA2qSHNn0wrUiRjHFcuBc8iRfQLX01Jx3fK4dGRNzRVWAQNNsa3hN+pIaWrp5AhBxroW6l4w/b5r8UbSzh65do/LnoD5srjs3sIVNhcMpjI08J7fcBiAFKaXV+AQCgd6odcgJwsf4OBtR5D0A3BZKKQ/NFg9AJU5EqOvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnRl29aXok+GnDEZFhs+iPcMRK17CUHUeqJzWC6gXV8=;
 b=cjUClP0BtV35PT4LrQS1XXxdTSrWY5nxMfv16XIv9gB79rJbH29DGUM5HCjIEDv+Vus0kwIXlICKAVD0/UyI/drM3dykUKZonlUK8nK3+HHgSn/PE+VIJMaGF+/sA8J51ctWfytKe2INL409vTUG487hwjOb+zr1fLEP+lP3PGQ=
Received: from BN6PR21CA0013.namprd21.prod.outlook.com (2603:10b6:404:8e::23)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 21:03:08 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::d6) by BN6PR21CA0013.outlook.office365.com
 (2603:10b6:404:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.2 via Frontend
 Transport; Mon, 25 Oct 2021 21:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 21:03:07 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 16:03:06 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     <markpearson@lenovo.com>, <pobrn@protonmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] ACPI: platform_profile: Add support for notification chains
Date:   Mon, 25 Oct 2021 16:03:03 -0500
Message-ID: <20211025210303.29083-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34570042-b635-495b-cdda-08d997fad88c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5083:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5083A023159B0B87EBA84C4BE2839@BN9PR12MB5083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fE7NsbUChCj+eLDO5K8zY60+ZFpzFUfog60LuMIjI9QehBMrkCsHoKiMef+WsupFc07Jv9WQja6gKhZPtVqPDkuJaHMFAy+3bMoUf3ZncEjhp98hLUMFFXu5BPgvWpSMO/md0vfnNNgdTDR1JG9PoxnqOJ9zDc7G5kZvh9/b8pmLzVSikboX4EXvoxjQ1c3PFx0+2K06HqQBJ/LKpiL5AHwjMmWmWgQf9v05lzkdw7LZZ0MHntNy4JXGraf7JHKZ105uqEZlHB8OzJsJ/FfrcUlOpjxvmHHydQJ6SZDVU8iNWL9Ibwoy8QFfQ/6fV4H/wYEUNvdGID184O/LDSxqZJyDSDAxHVhzFCjT+Dn0ptOu53hNgqrQ2p9kw7zaYHQf+uSLUt8ent1DzGZ0/22ku87Ho7ymeK4t74p/9jx26m1WoalxL8g6lj7phtxCu8XFcaP4C3CGvtdPZ/9ONDb5oSy0mSaRYEwIiRt2EpY98seH2kgZzmPStNWEtbxTrFkyQBWeMfl0HyR4gFwPNTs7KiUpGMsJJdNZDrYh+k77XXAIdLMMknThZEt8ngZMvcy6PRa0+sYfETiKPozJrD5KWolwDX+9d9o/N6u8WFfNr8Yw1T43rhOePQ7I/8GEOQQ9q8I+ZdZJ8947y0aRwsl7g5HraSgHOCjFmz4P9xujBC0l4xmi4qf7BO13gez8TbPoXr1GhEkCpPXqQiAz/3LeAraJCeMhgi05LrfAyPJ9Jnsm0GvkeihxXZEdQxcsSIcywV57pdXn2TRbk5LZQCpqYaY+KHow3qiI6T5yq9FdLXd4NPMB7w7QLODVf4LlGTj1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(186003)(6666004)(8676002)(110136005)(336012)(81166007)(7696005)(82310400003)(83380400001)(16526019)(36860700001)(54906003)(508600001)(47076005)(356005)(426003)(316002)(5660300002)(70586007)(36756003)(1076003)(44832011)(966005)(86362001)(70206006)(4326008)(2906002)(26005)(15650500001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 21:03:07.9730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34570042-b635-495b-cdda-08d997fad88c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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
V1: https://lore.kernel.org/linux-acpi/7d0c7f12-a412-582e-22f2-8285cf74066a@amd.com/T/#m834d32b2ebcf8bd3dab0c5aa48f6deaa48e34e62
Changes from v1->v2:
 * Add the new performance mode as part of the callback to simplify callers.
 * Drop the GPL symbol export for platform_profile_call_notifier

 drivers/acpi/platform_profile.c  | 48 ++++++++++++++++++++++++++++----
 include/linux/platform_profile.h | 10 +++++++
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index dd2fbf38e414..1badbc8d6012 100644
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
 
@@ -127,9 +155,17 @@ static const struct attribute_group platform_profile_group = {
 
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

