Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A973C61E1
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 19:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhGLRb0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 13:31:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64670 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbhGLRb0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jul 2021 13:31:26 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id 3a22d4adfed6713b; Mon, 12 Jul 2021 19:28:36 +0200
Received: from kreacher.localnet (89-64-82-45.dynamic.chello.pl [89.64.82.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A5EF8669C37;
        Mon, 12 Jul 2021 19:28:35 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: [PATCH v1 5/6] software nodes: Split software_node_notify()
Date:   Mon, 12 Jul 2021 19:27:12 +0200
Message-ID: <5627033.MhkbZ0Pkbq@kreacher>
In-Reply-To: <2780027.e9J7NaK4W3@kreacher>
References: <2780027.e9J7NaK4W3@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.82.45
X-CLIENT-HOSTNAME: 89-64-82-45.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddruddvgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedvrdegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekvddrgeehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
 ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Split software_node_notify_remove) out of software_node_notify()
and make device_platform_notify() call the latter on device addition
and the former on device removal.

While at it, put the headers of the above functions into base.h,
because they don't need to be present in a global header file.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/base.h      |    3 ++
 drivers/base/core.c      |    9 +++---
 drivers/base/swnode.c    |   61 ++++++++++++++++++++++++-----------------------
 include/linux/property.h |    2 -
 4 files changed, 39 insertions(+), 36 deletions(-)

Index: linux-pm/drivers/base/swnode.c
===================================================================
--- linux-pm.orig/drivers/base/swnode.c
+++ linux-pm/drivers/base/swnode.c
@@ -11,6 +11,8 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 
+#include "base.h"
+
 struct swnode {
 	struct kobject kobj;
 	struct fwnode_handle fwnode;
@@ -1053,7 +1055,7 @@ int device_add_software_node(struct devi
 	 * balance.
 	 */
 	if (device_is_registered(dev))
-		software_node_notify(dev, KOBJ_ADD);
+		software_node_notify(dev);
 
 	return 0;
 }
@@ -1074,7 +1076,8 @@ void device_remove_software_node(struct
 		return;
 
 	if (device_is_registered(dev))
-		software_node_notify(dev, KOBJ_REMOVE);
+		software_node_notify_remove(dev);
+
 	set_secondary_fwnode(dev, NULL);
 	kobject_put(&swnode->kobj);
 }
@@ -1117,44 +1120,44 @@ int device_create_managed_software_node(
 }
 EXPORT_SYMBOL_GPL(device_create_managed_software_node);
 
-int software_node_notify(struct device *dev, unsigned long action)
+void software_node_notify(struct device *dev)
 {
 	struct swnode *swnode;
 	int ret;
 
 	swnode = dev_to_swnode(dev);
 	if (!swnode)
-		return 0;
+		return;
 
-	switch (action) {
-	case KOBJ_ADD:
-		ret = sysfs_create_link(&dev->kobj, &swnode->kobj, "software_node");
-		if (ret)
-			break;
+	ret = sysfs_create_link(&dev->kobj, &swnode->kobj, "software_node");
+	if (ret)
+		return;
 
-		ret = sysfs_create_link(&swnode->kobj, &dev->kobj,
-					dev_name(dev));
-		if (ret) {
-			sysfs_remove_link(&dev->kobj, "software_node");
-			break;
-		}
-		kobject_get(&swnode->kobj);
-		break;
-	case KOBJ_REMOVE:
-		sysfs_remove_link(&swnode->kobj, dev_name(dev));
+	ret = sysfs_create_link(&swnode->kobj, &dev->kobj, dev_name(dev));
+	if (ret) {
 		sysfs_remove_link(&dev->kobj, "software_node");
-		kobject_put(&swnode->kobj);
-
-		if (swnode->managed) {
-			set_secondary_fwnode(dev, NULL);
-			kobject_put(&swnode->kobj);
-		}
-		break;
-	default:
-		break;
+		return;
 	}
 
-	return 0;
+	kobject_get(&swnode->kobj);
+}
+
+void software_node_notify_remove(struct device *dev)
+{
+	struct swnode *swnode;
+
+	swnode = dev_to_swnode(dev);
+	if (!swnode)
+		return;
+
+	sysfs_remove_link(&swnode->kobj, dev_name(dev));
+	sysfs_remove_link(&dev->kobj, "software_node");
+	kobject_put(&swnode->kobj);
+
+	if (swnode->managed) {
+		set_secondary_fwnode(dev, NULL);
+		kobject_put(&swnode->kobj);
+	}
 }
 
 static int __init software_node_init(void)
Index: linux-pm/include/linux/property.h
===================================================================
--- linux-pm.orig/include/linux/property.h
+++ linux-pm/include/linux/property.h
@@ -484,8 +484,6 @@ void software_node_unregister_node_group
 int software_node_register(const struct software_node *node);
 void software_node_unregister(const struct software_node *node);
 
-int software_node_notify(struct device *dev, unsigned long action);
-
 struct fwnode_handle *
 fwnode_create_software_node(const struct property_entry *properties,
 			    const struct fwnode_handle *parent);
Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -2003,16 +2003,15 @@ static inline int device_is_not_partitio
 static int
 device_platform_notify(struct device *dev, enum kobject_action action)
 {
-	int ret;
-
 	if (action == KOBJ_ADD)
 		acpi_device_notify(dev);
 	else if (action == KOBJ_REMOVE)
 		acpi_device_notify_remove(dev);
 
-	ret = software_node_notify(dev, action);
-	if (ret)
-		return ret;
+	if (action == KOBJ_ADD)
+		software_node_notify(dev);
+	else if (action == KOBJ_REMOVE)
+		software_node_notify_remove(dev);
 
 	if (platform_notify && action == KOBJ_ADD)
 		platform_notify(dev);
Index: linux-pm/drivers/base/base.h
===================================================================
--- linux-pm.orig/drivers/base/base.h
+++ linux-pm/drivers/base/base.h
@@ -202,3 +202,6 @@ int devtmpfs_delete_node(struct device *
 static inline int devtmpfs_create_node(struct device *dev) { return 0; }
 static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
 #endif
+
+void software_node_notify(struct device *dev);
+void software_node_notify_remove(struct device *dev);



