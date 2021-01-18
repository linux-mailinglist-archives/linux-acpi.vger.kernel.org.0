Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0474E2FAAA4
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 20:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437417AbhARTxF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 14:53:05 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47536 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393965AbhART0e (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jan 2021 14:26:34 -0500
Received: from 89-64-82-41.dynamic.chello.pl (89.64.82.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 29d09316bb40c20e; Mon, 18 Jan 2021 20:25:37 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI: scan: Rearrange code related to acpi_get_device_data()
Date:   Mon, 18 Jan 2021 20:25:37 +0100
Message-ID: <3445520.6OZ3MRzmT7@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are two callers of acpi_get_device_data(), acpi_bus_get_device()
and acpi_bus_get_acpi_device(), but only one of them takes the int
return value into account.  Moreover, the latter knows that it passes
a valid return pointer to acpi_get_device_data() and it properly
clears that pointer upfront, so it doesn't need acpi_get_device_data()
to do that.

For this reason, rearrange acpi_get_device_data() to return a strct
acpi_device pointer instead of an int and adapt its callers to that.

While at it, rename acpi_get_device_data() to handle_to_device(),
because the old name does not really reflect the functionality
provided by that function.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of https://patchwork.kernel.org/project/linux-acpi/patch/20210115215752.389656-1-hdegoede@redhat.com/

---
 drivers/acpi/scan.c |   35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -578,29 +578,31 @@ static void acpi_scan_drop_device(acpi_h
 	mutex_unlock(&acpi_device_del_lock);
 }
 
-static int acpi_get_device_data(acpi_handle handle, struct acpi_device **device,
-				void (*callback)(void *))
+static struct acpi_device *handle_to_device(acpi_handle handle,
+					    void (*callback)(void *))
 {
+	struct acpi_device *adev = NULL;
 	acpi_status status;
 
-	if (!device)
-		return -EINVAL;
-
-	*device = NULL;
-
 	status = acpi_get_data_full(handle, acpi_scan_drop_device,
-				    (void **)device, callback);
-	if (ACPI_FAILURE(status) || !*device) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No context for object [%p]\n",
-				  handle));
-		return -ENODEV;
+				    (void **)&adev, callback);
+	if (ACPI_FAILURE(status) || !adev) {
+		acpi_handle_debug(handle, "No context!\n");
+		return NULL;
 	}
-	return 0;
+	return adev;
 }
 
 int acpi_bus_get_device(acpi_handle handle, struct acpi_device **device)
 {
-	return acpi_get_device_data(handle, device, NULL);
+	if (!device)
+		return -EINVAL;
+
+	*device = handle_to_device(handle, NULL);
+	if (!*device)
+		return -ENODEV;
+
+	return 0;
 }
 EXPORT_SYMBOL(acpi_bus_get_device);
 
@@ -612,10 +614,7 @@ static void get_acpi_device(void *dev)
 
 struct acpi_device *acpi_bus_get_acpi_device(acpi_handle handle)
 {
-	struct acpi_device *adev = NULL;
-
-	acpi_get_device_data(handle, &adev, get_acpi_device);
-	return adev;
+	return handle_to_device(handle, get_acpi_device);
 }
 
 void acpi_bus_put_acpi_device(struct acpi_device *adev)



