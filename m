Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A565838C78F
	for <lists+linux-acpi@lfdr.de>; Fri, 21 May 2021 15:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhEUNOk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 May 2021 09:14:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51834 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbhEUNOi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 May 2021 09:14:38 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id ac0a1602abfabcef; Fri, 21 May 2021 15:13:13 +0200
Received: from kreacher.localnet (89-64-82-20.dynamic.chello.pl [89.64.82.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 97A9E6696CA;
        Fri, 21 May 2021 15:13:12 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dave Olsthoorn <dave@bewaar.me>,
        Shujun Wang <wsj20369@163.com>,
        David Box <david.e.box@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] ACPI: power: Refine turning off unused power resources
Date:   Fri, 21 May 2021 15:13:11 +0200
Message-ID: <11762320.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.82.20
X-CLIENT-HOSTNAME: 89-64-82-20.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdejfedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeeiffduheeigfeufeektefgueffheejvddvveehuedtueetgefhteeigfffleegteenucffohhmrghinhepuhgvfhhirdhorhhgpdhkvghrnhgvlhdrohhrghenucfkphepkeelrdeigedrkedvrddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekvddrvddtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdp
 rhgtphhtthhopegurghvvgessggvfigrrghrrdhmvgdprhgtphhtthhopeifshhjvddtfeeileesudeifedrtghomhdprhgtphhtthhopegurghvihgurdgvrdgsohigsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 7e4fdeafa61f ("ACPI: power: Turn off unused power resources
unconditionally") dropped the power resource state check from
acpi_turn_off_unused_power_resources(), because according to the
ACPI specification (e.g. ACPI 6.4, Section 7.2.2) the OS "may run
the _OFF method repeatedly, even if the resource is already off".

However, it turns out that some systems do not follow the
specification in this particular respect and that commit introduced
boot issues on them, so refine acpi_turn_off_unused_power_resources()
to only turn off power resources without any users after device
enumeration and restore its previous behavior in the system-wide
resume path.

Fixes: 7e4fdeafa61f ("ACPI: power: Turn off unused power resources unconditionally")
Link: https://uefi.org/specs/ACPI/6.4/07_Power_and_Performance_Mgmt/declaring-a-power-resource-object.html#off
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213019
Reported-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Reported-by: Dave Olsthoorn <dave@bewaar.me>
Tested-by: Dave Olsthoorn <dave@bewaar.me>
Reported-by: Shujun Wang <wsj20369@163.com>
Tested-by: Shujun Wang <wsj20369@163.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/internal.h |    4 +--
 drivers/acpi/power.c    |   59 +++++++++++++++++++++++++++++++++++++-----------
 drivers/acpi/scan.c     |    2 -
 drivers/acpi/sleep.c    |    2 -
 4 files changed, 50 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -52,6 +52,7 @@ struct acpi_power_resource {
 	u32 system_level;
 	u32 order;
 	unsigned int ref_count;
+	unsigned int users;
 	bool wakeup_enabled;
 	struct mutex resource_lock;
 	struct list_head dependents;
@@ -147,6 +148,7 @@ int acpi_extract_power_resources(union a
 
 	for (i = start; i < package->package.count; i++) {
 		union acpi_object *element = &package->package.elements[i];
+		struct acpi_device *rdev;
 		acpi_handle rhandle;
 
 		if (element->type != ACPI_TYPE_LOCAL_REFERENCE) {
@@ -163,13 +165,16 @@ int acpi_extract_power_resources(union a
 		if (acpi_power_resource_is_dup(package, start, i))
 			continue;
 
-		err = acpi_add_power_resource(rhandle);
-		if (err)
+		rdev = acpi_add_power_resource(rhandle);
+		if (!rdev) {
+			err = -ENODEV;
 			break;
-
+		}
 		err = acpi_power_resources_list_add(rhandle, list);
 		if (err)
 			break;
+
+		to_power_resource(rdev)->users++;
 	}
 	if (err)
 		acpi_power_resources_list_free(list);
@@ -907,7 +912,7 @@ static void acpi_power_add_resource_to_l
 	mutex_unlock(&power_resource_list_lock);
 }
 
-int acpi_add_power_resource(acpi_handle handle)
+struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 {
 	struct acpi_power_resource *resource;
 	struct acpi_device *device = NULL;
@@ -918,11 +923,11 @@ int acpi_add_power_resource(acpi_handle
 
 	acpi_bus_get_device(handle, &device);
 	if (device)
-		return 0;
+		return device;
 
 	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
 	if (!resource)
-		return -ENOMEM;
+		return NULL;
 
 	device = &resource->device;
 	acpi_init_device_object(device, handle, ACPI_BUS_TYPE_POWER);
@@ -959,11 +964,11 @@ int acpi_add_power_resource(acpi_handle
 
 	acpi_power_add_resource_to_list(resource);
 	acpi_device_add_finalize(device);
-	return 0;
+	return device;
 
  err:
 	acpi_release_power_resource(&device->dev);
-	return result;
+	return NULL;
 }
 
 #ifdef CONFIG_ACPI_SLEEP
@@ -997,7 +1002,38 @@ void acpi_resume_power_resources(void)
 }
 #endif
 
-void acpi_turn_off_unused_power_resources(void)
+static void acpi_power_turn_off_if_unused(struct acpi_power_resource *resource,
+				       bool init)
+{
+	if (resource->ref_count > 0)
+		return;
+
+	if (init) {
+		if (resource->users > 0)
+			return;
+	} else {
+		int result, state;
+
+		result = acpi_power_get_state(resource->device.handle, &state);
+		if (result || state == ACPI_POWER_RESOURCE_STATE_OFF)
+			return;
+	}
+
+	dev_info(&resource->device.dev, "Turning OFF\n");
+	__acpi_power_off(resource);
+}
+
+/**
+ * acpi_turn_off_unused_power_resources - Turn off power resources not in use.
+ * @init: Control switch.
+ *
+ * If @ainit is set, unconditionally turn off all of the ACPI power resources
+ * without any users.
+ *
+ * Otherwise, turn off all ACPI power resources without active references (that
+ * is, the ones that should be "off" at the moment) that are "on".
+ */
+void acpi_turn_off_unused_power_resources(bool init)
 {
 	struct acpi_power_resource *resource;
 
@@ -1006,10 +1042,7 @@ void acpi_turn_off_unused_power_resource
 	list_for_each_entry_reverse(resource, &acpi_power_resource_list, list_node) {
 		mutex_lock(&resource->resource_lock);
 
-		if (!resource->ref_count) {
-			dev_info(&resource->device.dev, "Turning OFF\n");
-			__acpi_power_off(resource);
-		}
+		acpi_power_turn_off_if_unused(resource, init);
 
 		mutex_unlock(&resource->resource_lock);
 	}
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -134,7 +134,7 @@ int acpi_power_init(void);
 void acpi_power_resources_list_free(struct list_head *list);
 int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
 				 struct list_head *list);
-int acpi_add_power_resource(acpi_handle handle);
+struct acpi_device *acpi_add_power_resource(acpi_handle handle);
 void acpi_power_add_remove_device(struct acpi_device *adev, bool add);
 int acpi_power_wakeup_list_init(struct list_head *list, int *system_level);
 int acpi_device_sleep_wake(struct acpi_device *dev,
@@ -142,7 +142,7 @@ int acpi_device_sleep_wake(struct acpi_d
 int acpi_power_get_inferred_state(struct acpi_device *device, int *state);
 int acpi_power_on_resources(struct acpi_device *device, int state);
 int acpi_power_transition(struct acpi_device *device, int state);
-void acpi_turn_off_unused_power_resources(void);
+void acpi_turn_off_unused_power_resources(bool init);
 
 /* --------------------------------------------------------------------------
                               Device Power Management
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -504,7 +504,7 @@ static void acpi_pm_start(u32 acpi_state
  */
 static void acpi_pm_end(void)
 {
-	acpi_turn_off_unused_power_resources();
+	acpi_turn_off_unused_power_resources(false);
 	acpi_scan_lock_release();
 	/*
 	 * This is necessary in case acpi_pm_finish() is not called during a
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2356,7 +2356,7 @@ int __init acpi_scan_init(void)
 		}
 	}
 
-	acpi_turn_off_unused_power_resources();
+	acpi_turn_off_unused_power_resources(true);
 
 	acpi_scan_initialized = true;
 



