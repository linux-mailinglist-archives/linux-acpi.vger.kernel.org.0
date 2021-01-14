Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDA72F69EF
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jan 2021 19:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbhANSss (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 13:48:48 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58580 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbhANSsr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jan 2021 13:48:47 -0500
Received: from 89-64-81-33.dynamic.chello.pl (89.64.81.33) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 4b0a89bcdcba0787; Thu, 14 Jan 2021 19:48:04 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans De Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] ACPI: scan: Rearrange memory allocation in acpi_device_add()
Date:   Thu, 14 Jan 2021 19:46:47 +0100
Message-ID: <2999734.9HhbEeWEHR@kreacher>
In-Reply-To: <3494203.VBaj39JGmp@kreacher>
References: <3494203.VBaj39JGmp@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The upfront allocation of new_bus_id is done to avoid allocating
memory under acpi_device_lock, but it doesn't really help,
because (1) it leads to many unnecessary memory allocations for
_ADR devices, (2) kstrdup_const() is run under that lock anyway and
(3) it complicates the code.

Rearrange acpi_device_add() to allocate memory for a new struct
acpi_device_bus_id instance only when necessary, eliminate a redundant
local variable from it and reduce the number of labels in there.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   57 +++++++++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -621,12 +621,23 @@ void acpi_bus_put_acpi_device(struct acp
 	put_device(&adev->dev);
 }
 
+static struct acpi_device_bus_id *acpi_device_bus_id_match(const char *dev_id)
+{
+	struct acpi_device_bus_id *acpi_device_bus_id;
+
+	/* Find suitable bus_id and instance number in acpi_bus_id_list. */
+	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node) {
+		if (!strcmp(acpi_device_bus_id->bus_id, dev_id))
+			return acpi_device_bus_id;
+	}
+	return NULL;
+}
+
 int acpi_device_add(struct acpi_device *device,
 		    void (*release)(struct device *))
 {
+	struct acpi_device_bus_id *acpi_device_bus_id;
 	int result;
-	struct acpi_device_bus_id *acpi_device_bus_id, *new_bus_id;
-	int found = 0;
 
 	if (device->handle) {
 		acpi_status status;
@@ -652,38 +663,26 @@ int acpi_device_add(struct acpi_device *
 	INIT_LIST_HEAD(&device->del_list);
 	mutex_init(&device->physical_node_lock);
 
-	new_bus_id = kzalloc(sizeof(struct acpi_device_bus_id), GFP_KERNEL);
-	if (!new_bus_id) {
-		pr_err(PREFIX "Memory allocation error\n");
-		result = -ENOMEM;
-		goto err_detach;
-	}
-
 	mutex_lock(&acpi_device_lock);
-	/*
-	 * Find suitable bus_id and instance number in acpi_bus_id_list
-	 * If failed, create one and link it into acpi_bus_id_list
-	 */
-	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node) {
-		if (!strcmp(acpi_device_bus_id->bus_id,
-			    acpi_device_hid(device))) {
-			acpi_device_bus_id->instance_no++;
-			found = 1;
-			kfree(new_bus_id);
-			break;
+
+	acpi_device_bus_id = acpi_device_bus_id_match(acpi_device_hid(device));
+	if (acpi_device_bus_id) {
+		acpi_device_bus_id->instance_no++;
+	} else {
+		acpi_device_bus_id = kzalloc(sizeof(*acpi_device_bus_id),
+					     GFP_KERNEL);
+		if (!acpi_device_bus_id) {
+			result = -ENOMEM;
+			goto err_unlock;
 		}
-	}
-	if (!found) {
-		acpi_device_bus_id = new_bus_id;
 		acpi_device_bus_id->bus_id =
 			kstrdup_const(acpi_device_hid(device), GFP_KERNEL);
 		if (!acpi_device_bus_id->bus_id) {
-			pr_err(PREFIX "Memory allocation error for bus id\n");
+			kfree(acpi_device_bus_id);
 			result = -ENOMEM;
-			goto err_free_new_bus_id;
+			goto err_unlock;
 		}
 
-		acpi_device_bus_id->instance_no = 0;
 		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
 	}
 	dev_set_name(&device->dev, "%s:%02x", acpi_device_bus_id->bus_id, acpi_device_bus_id->instance_no);
@@ -718,13 +717,9 @@ int acpi_device_add(struct acpi_device *
 		list_del(&device->node);
 	list_del(&device->wakeup_list);
 
- err_free_new_bus_id:
-	if (!found)
-		kfree(new_bus_id);
-
+ err_unlock:
 	mutex_unlock(&acpi_device_lock);
 
- err_detach:
 	acpi_detach_data(device->handle, acpi_scan_drop_device);
 	return result;
 }



