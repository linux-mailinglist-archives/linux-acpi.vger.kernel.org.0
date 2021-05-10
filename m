Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF5337967D
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 19:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhEJRy0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 13:54:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53704 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbhEJRyZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 May 2021 13:54:25 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id 379239d53aab3172; Mon, 10 May 2021 19:53:19 +0200
Received: from kreacher.localnet (89-64-81-75.dynamic.chello.pl [89.64.81.75])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A2E7A669592;
        Mon, 10 May 2021 19:53:18 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI: scan: Rearrange dep_unmet initialization
Date:   Mon, 10 May 2021 19:53:18 +0200
Message-ID: <2607573.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.75
X-CLIENT-HOSTNAME: 89-64-81-75.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdegkedguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppeekledrieegrdekuddrjeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurdejhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The dep_unmet field in struct acpi_device is used to store the
number of unresolved _DEP dependencies (that is, operation region
dependencies for which there are no drivers present) for the ACPI
device object represented by it.

That field is initialized to 1 for all ACPI device objects in
acpi_add_single_object(), via acpi_init_device_object(), so as to
avoid evaluating _STA prematurely for battery device objects in
acpi_scan_init_status(), and it is "fixed up" in acpi_bus_check_add()
after the acpi_add_single_object() called by it has returned.

This is not particularly straightforward and causes dep_unmet to
remain 1 for device objects without dependencies created by invoking
acpi_add_single_object() directly, outside acpi_bus_check_add().

For this reason, rearrange acpi_add_single_object() to initialize
dep_unmet completely before calling acpi_scan_init_status(), which
requires passing one extra bool argument to it, and update all of
its callers accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   62 +++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1670,8 +1670,22 @@ void acpi_init_device_object(struct acpi
 	device_initialize(&device->dev);
 	dev_set_uevent_suppress(&device->dev, true);
 	acpi_init_coherency(device);
-	/* Assume there are unmet deps to start with. */
-	device->dep_unmet = 1;
+}
+
+static void acpi_scan_dep_init(struct acpi_device *adev)
+{
+	struct acpi_dep_data *dep;
+
+	adev->dep_unmet = 0;
+
+	mutex_lock(&acpi_dep_list_lock);
+
+	list_for_each_entry(dep, &acpi_dep_list, node) {
+		if (dep->consumer == adev->handle)
+			adev->dep_unmet++;
+	}
+
+	mutex_unlock(&acpi_dep_list_lock);
 }
 
 void acpi_device_add_finalize(struct acpi_device *device)
@@ -1687,7 +1701,7 @@ static void acpi_scan_init_status(struct
 }
 
 static int acpi_add_single_object(struct acpi_device **child,
-				  acpi_handle handle, int type)
+				  acpi_handle handle, int type, bool dep_init)
 {
 	struct acpi_device *device;
 	int result;
@@ -1702,8 +1716,12 @@ static int acpi_add_single_object(struct
 	 * acpi_bus_get_status() and use its quirk handling.  Note that
 	 * this must be done before the get power-/wakeup_dev-flags calls.
 	 */
-	if (type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_PROCESSOR)
+	if (type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_PROCESSOR) {
+		if (dep_init)
+			acpi_scan_dep_init(device);
+
 		acpi_scan_init_status(device);
+	}
 
 	acpi_bus_get_power_flags(device);
 	acpi_bus_get_wakeup_device_flags(device);
@@ -1885,22 +1903,6 @@ static u32 acpi_scan_check_dep(acpi_hand
 	return count;
 }
 
-static void acpi_scan_dep_init(struct acpi_device *adev)
-{
-	struct acpi_dep_data *dep;
-
-	adev->dep_unmet = 0;
-
-	mutex_lock(&acpi_dep_list_lock);
-
-	list_for_each_entry(dep, &acpi_dep_list, node) {
-		if (dep->consumer == adev->handle)
-			adev->dep_unmet++;
-	}
-
-	mutex_unlock(&acpi_dep_list_lock);
-}
-
 static bool acpi_bus_scan_second_pass;
 
 static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
@@ -1948,19 +1950,15 @@ static acpi_status acpi_bus_check_add(ac
 		return AE_OK;
 	}
 
-	acpi_add_single_object(&device, handle, type);
-	if (!device)
-		return AE_CTRL_DEPTH;
-
-	acpi_scan_init_hotplug(device);
 	/*
 	 * If check_dep is true at this point, the device has no dependencies,
 	 * or the creation of the device object would have been postponed above.
 	 */
-	if (check_dep)
-		device->dep_unmet = 0;
-	else
-		acpi_scan_dep_init(device);
+	acpi_add_single_object(&device, handle, type, !check_dep);
+	if (!device)
+		return AE_CTRL_DEPTH;
+
+	acpi_scan_init_hotplug(device);
 
 out:
 	if (!*adev_p)
@@ -2222,7 +2220,7 @@ int acpi_bus_register_early_device(int t
 	struct acpi_device *device = NULL;
 	int result;
 
-	result = acpi_add_single_object(&device, NULL, type);
+	result = acpi_add_single_object(&device, NULL, type, false);
 	if (result)
 		return result;
 
@@ -2242,7 +2240,7 @@ static int acpi_bus_scan_fixed(void)
 		struct acpi_device *device = NULL;
 
 		result = acpi_add_single_object(&device, NULL,
-						ACPI_BUS_TYPE_POWER_BUTTON);
+						ACPI_BUS_TYPE_POWER_BUTTON, false);
 		if (result)
 			return result;
 
@@ -2258,7 +2256,7 @@ static int acpi_bus_scan_fixed(void)
 		struct acpi_device *device = NULL;
 
 		result = acpi_add_single_object(&device, NULL,
-						ACPI_BUS_TYPE_SLEEP_BUTTON);
+						ACPI_BUS_TYPE_SLEEP_BUTTON, false);
 		if (result)
 			return result;
 



