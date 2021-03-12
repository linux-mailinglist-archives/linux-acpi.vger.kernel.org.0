Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA0233929F
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Mar 2021 17:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCLQBn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Mar 2021 11:01:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:16773 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232009AbhCLQBa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Mar 2021 11:01:30 -0500
IronPort-SDR: LeW9whgosBf0qQFByb5/5WDhptHrUuHON8Ux4WjU3dbHLq3ZS4sHRGPJh3NXjx1hk3emkrP6YT
 0S8vwucqNftQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="168122734"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="168122734"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 08:01:30 -0800
IronPort-SDR: +tYUtikwOqGLdg82cqaEX8bTBOwucBY2wIOKMx+sFsGc6zzPprZtjk32u/r1xQ4Fypfvi8Nmfs
 M9LOCJS+5ARA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="603969354"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 12 Mar 2021 08:01:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CBAF92AF; Fri, 12 Mar 2021 18:01:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: scan: Use unique number for instance_no
Date:   Fri, 12 Mar 2021 18:01:37 +0200
Message-Id: <20210312160137.19463-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Current mechanism of incrementing and decrementing plain integer
to get a next free instance_no when creating an ACPI device is fragile.

In case of hot plug event or namespace removal of the device instances
with the low numbers the plain integer counter can't cover the gaps
and become desynchronized with real state of affairs. If during next
hot plug event or namespace injection the new instances of
the devices need to be instantiated, the counter may mistakenly point
to the existing instance_no and kernel will complain:
"sysfs: cannot create duplicate filename '/bus/acpi/devices/XXXX1234:02'"

Replace plain integer approach by using IDA framework.

Fixes: e49bd2dd5a50 ("ACPI: use PNPID:instance_no as bus_id of ACPI device")
Fixes: ca9dc8d42b30 ("ACPI / scan: Fix acpi_bus_id_list bookkeeping")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/internal.h |  4 ++-
 drivers/acpi/scan.c     | 55 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index e6a5d997241c..6fee4f71ba1c 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -9,6 +9,8 @@
 #ifndef _ACPI_INTERNAL_H_
 #define _ACPI_INTERNAL_H_
 
+#include <linux/idr.h>
+
 #define PREFIX "ACPI: "
 
 int early_acpi_osi_init(void);
@@ -98,7 +100,7 @@ extern struct list_head acpi_bus_id_list;
 
 struct acpi_device_bus_id {
 	const char *bus_id;
-	unsigned int instance_no;
+	struct ida no;
 	struct list_head node;
 };
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a184529d8fa4..a118a58f7dad 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -468,9 +468,27 @@ static void acpi_device_release(struct device *dev)
 	kfree(acpi_dev);
 }
 
+static int acpi_device_get_instance_no(struct acpi_device *device)
+{
+	const char *p;
+	int result;
+	int error;
+
+	p = strrchr(dev_name(&device->dev), ':');
+	if (!p)
+		return -ENODATA;
+
+	error = kstrtoint(p + 1, 16, &result);
+	if (error)
+		return error;
+
+	return result;
+}
+
 static void acpi_device_del(struct acpi_device *device)
 {
 	struct acpi_device_bus_id *acpi_device_bus_id;
+	int result;
 
 	mutex_lock(&acpi_device_lock);
 	if (device->parent)
@@ -479,9 +497,13 @@ static void acpi_device_del(struct acpi_device *device)
 	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node)
 		if (!strcmp(acpi_device_bus_id->bus_id,
 			    acpi_device_hid(device))) {
-			if (acpi_device_bus_id->instance_no > 0)
-				acpi_device_bus_id->instance_no--;
-			else {
+			result = acpi_device_get_instance_no(device);
+			if (result < 0)
+				dev_warn(&device->dev, "Can't get instance no\n");
+			else
+				ida_simple_remove(&acpi_device_bus_id->no, result);
+
+			if (ida_is_empty(&acpi_device_bus_id->no)) {
 				list_del(&acpi_device_bus_id->node);
 				kfree_const(acpi_device_bus_id->bus_id);
 				kfree(acpi_device_bus_id);
@@ -631,6 +653,19 @@ static struct acpi_device_bus_id *acpi_device_bus_id_match(const char *dev_id)
 	return NULL;
 }
 
+static int acpi_device_set_name(struct acpi_device *device,
+				struct acpi_device_bus_id *acpi_device_bus_id)
+{
+	int result;
+
+	result = ida_simple_get(&acpi_device_bus_id->no, 0, 255, GFP_KERNEL);
+	if (result < 0)
+		return result;
+
+	dev_set_name(&device->dev, "%s:%02x", acpi_device_bus_id->bus_id, result);
+	return 0;
+}
+
 int acpi_device_add(struct acpi_device *device,
 		    void (*release)(struct device *))
 {
@@ -665,7 +700,9 @@ int acpi_device_add(struct acpi_device *device,
 
 	acpi_device_bus_id = acpi_device_bus_id_match(acpi_device_hid(device));
 	if (acpi_device_bus_id) {
-		acpi_device_bus_id->instance_no++;
+		result = acpi_device_set_name(device, acpi_device_bus_id);
+		if (result < 0)
+			goto err_unlock;
 	} else {
 		acpi_device_bus_id = kzalloc(sizeof(*acpi_device_bus_id),
 					     GFP_KERNEL);
@@ -681,9 +718,17 @@ int acpi_device_add(struct acpi_device *device,
 			goto err_unlock;
 		}
 
+		ida_init(&acpi_device_bus_id->no);
+
+		result = acpi_device_set_name(device, acpi_device_bus_id);
+		if (result < 0) {
+			ida_destroy(&acpi_device_bus_id->no);
+			kfree(acpi_device_bus_id);
+			goto err_unlock;
+		}
+
 		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
 	}
-	dev_set_name(&device->dev, "%s:%02x", acpi_device_bus_id->bus_id, acpi_device_bus_id->instance_no);
 
 	if (device->parent)
 		list_add_tail(&device->node, &device->parent->children);
-- 
2.30.1

