Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9513ACC75
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 15:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhFRNnd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 09:43:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:36253 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231883AbhFRNnd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Jun 2021 09:43:33 -0400
IronPort-SDR: 5CEEHIHvlmXZxBPYjy6EopYyxoqyfPGeU+CPgFILAztV8kBb1/xGUvG1OwX1pVU65JhTQfet1B
 1U+RO4ESAp/Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="203531064"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="203531064"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 06:41:10 -0700
IronPort-SDR: 6o8LAVP9zVKEbHOWkujOnuU+rIzKBCOzkDI/ULphR9LZQjDJVF33hD88HWuoy876uqWM+9FSFn
 y+VMsNrX9IMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="451398487"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2021 06:41:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5EE5050E; Fri, 18 Jun 2021 16:41:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 1/2] ACPI: sysfs: Use __ATTR_RO() and __ATTR_RW() macros
Date:   Fri, 18 Jun 2021 16:41:27 +0300
Message-Id: <20210618134128.59335-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We have a few open-coded __ATTR_RO() and __ATTR_RW() macros.
Replace the custom code with generic macros.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on top of bleeding-edge (Rafael)
 drivers/acpi/sysfs.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 940410976e0f..18e93c3c39cf 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -907,27 +907,22 @@ static void __exit interrupt_stats_exit(void)
 	delete_gpe_attr_array();
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
@@ -939,9 +934,7 @@ static ssize_t hotplug_enabled_store(struct kobject *kobj,
 	return size;
 }
 
-static struct kobj_attribute hotplug_enabled_attr =
-	__ATTR(enabled, S_IRUGO | S_IWUSR, hotplug_enabled_show,
-		hotplug_enabled_store);
+static struct kobj_attribute hotplug_enabled_attr = __ATTR_RW(enabled);
 
 static struct attribute *hotplug_profile_attrs[] = {
 	&hotplug_enabled_attr.attr,
@@ -999,9 +992,7 @@ static ssize_t force_remove_store(struct kobject *kobj,
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

