Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C052F30FDF
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfEaOQE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 10:16:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:8345 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfEaOQE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 May 2019 10:16:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 07:16:03 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 May 2019 07:16:01 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 06/16] driver core: Add helper device_find_child_by_name()
Date:   Fri, 31 May 2019 17:15:37 +0300
Message-Id: <20190531141547.22728-7-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
References: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It looks like the child device is often matched with a name.
This introduces a helper that does it automatically.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/base/core.c    | 28 ++++++++++++++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index fd7511e04e62..b4c64528f13c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2474,6 +2474,34 @@ struct device *device_find_child(struct device *parent, void *data,
 }
 EXPORT_SYMBOL_GPL(device_find_child);
 
+/**
+ * device_find_child_by_name - device iterator for locating a child device.
+ * @parent: parent struct device
+ * @name: name of the child device
+ *
+ * This is similar to the device_find_child() function above, but it
+ * returns a reference to a device that has the name @name.
+ *
+ * NOTE: you will need to drop the reference with put_device() after use.
+ */
+struct device *device_find_child_by_name(struct device *parent,
+					 const char *name)
+{
+	struct klist_iter i;
+	struct device *child;
+
+	if (!parent)
+		return NULL;
+
+	klist_iter_init(&parent->p->klist_children, &i);
+	while ((child = next_device(&i)))
+		if (!strcmp(dev_name(child), name) && get_device(child))
+			break;
+	klist_iter_exit(&i);
+	return child;
+}
+EXPORT_SYMBOL_GPL(device_find_child_by_name);
+
 int __init devices_init(void)
 {
 	devices_kset = kset_create_and_add("devices", &device_uevent_ops, NULL);
diff --git a/include/linux/device.h b/include/linux/device.h
index 72a6260f2b4d..a0da7d578257 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1250,6 +1250,8 @@ extern int device_for_each_child_reverse(struct device *dev, void *data,
 		     int (*fn)(struct device *dev, void *data));
 extern struct device *device_find_child(struct device *dev, void *data,
 				int (*match)(struct device *dev, void *data));
+extern struct device *device_find_child_by_name(struct device *parent,
+						const char *name);
 extern int device_rename(struct device *dev, const char *new_name);
 extern int device_move(struct device *dev, struct device *new_parent,
 		       enum dpm_order dpm_order);
-- 
2.20.1

