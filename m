Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390DF3AA203
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 19:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhFPRFn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 13:05:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:49305 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230162AbhFPRFl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 13:05:41 -0400
IronPort-SDR: dM5Dj9jRNOXnT2tpm1kyRtvZof9DATWjgNmfR6obbtfsEAK/At1D9EajBpxAlUBN8McnymuY18
 MMuRX1P4TGAA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="193528294"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="193528294"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 10:03:33 -0700
IronPort-SDR: WS06BE79EurnER0SWuARW3G4xGlfRsQQfLZc9jmOUtiTBS9xb4GthD0j5LpXIjlN6AUCHS5jqy
 e70bnoMnHBkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="484954964"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2021 10:03:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4C2E0516; Wed, 16 Jun 2021 20:03:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 5/7] ACPI: sysfs: Use __ATTR_RO() and __ATTR_RW() macros
Date:   Wed, 16 Jun 2021 20:03:36 +0300
Message-Id: <20210616170338.23057-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
References: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We have a few open-coded __ATTR_RO() and __ATTR_RW() macros.
Replace the custom code with generic macros.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/sysfs.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 7239d87e78e6..231aaa8b6c2c 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -915,27 +915,22 @@ static void __exit interrupt_stats_exit(void)
 	return;
 }
 
-static ssize_t
-acpi_show_profile(struct kobject *kobj, struct kobj_attribute *attr,
-		  char *buf)
+static ssize_t pm_profile_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d\n", acpi_gbl_FADT.preferred_profile);
 }
 
-static const struct kobj_attribute pm_profile_attr =
-	__ATTR(pm_profile, S_IRUGO, acpi_show_profile, NULL);
+static const struct kobj_attribute pm_profile_attr = __ATTR_RO(pm_profile);
 
-static ssize_t hotplug_enabled_show(struct kobject *kobj,
-				    struct kobj_attribute *attr, char *buf)
+static ssize_t enabled_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct acpi_hotplug_profile *hotplug = to_acpi_hotplug_profile(kobj);
 
 	return sprintf(buf, "%d\n", hotplug->enabled);
 }
 
-static ssize_t hotplug_enabled_store(struct kobject *kobj,
-				     struct kobj_attribute *attr,
-				     const char *buf, size_t size)
+static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
+			     const char *buf, size_t size)
 {
 	struct acpi_hotplug_profile *hotplug = to_acpi_hotplug_profile(kobj);
 	unsigned int val;
@@ -947,9 +942,7 @@ static ssize_t hotplug_enabled_store(struct kobject *kobj,
 	return size;
 }
 
-static struct kobj_attribute hotplug_enabled_attr =
-	__ATTR(enabled, S_IRUGO | S_IWUSR, hotplug_enabled_show,
-		hotplug_enabled_store);
+static struct kobj_attribute hotplug_enabled_attr = __ATTR_RW(enabled);
 
 static struct attribute *hotplug_profile_attrs[] = {
 	&hotplug_enabled_attr.attr,
@@ -1007,9 +1000,7 @@ static ssize_t force_remove_store(struct kobject *kobj,
 	return size;
 }
 
-static const struct kobj_attribute force_remove_attr =
-	__ATTR(force_remove, S_IRUGO | S_IWUSR, force_remove_show,
-	       force_remove_store);
+static const struct kobj_attribute force_remove_attr = __ATTR_RW(force_remove);
 
 int __init acpi_sysfs_init(void)
 {
-- 
2.30.2

