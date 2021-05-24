Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A107E38ECF4
	for <lists+linux-acpi@lfdr.de>; Mon, 24 May 2021 17:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhEXPa4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 May 2021 11:30:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61668 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbhEXP3F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 May 2021 11:29:05 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id a097bffec5af0e03; Mon, 24 May 2021 17:27:35 +0200
Received: from kreacher.localnet (89-64-80-49.dynamic.chello.pl [89.64.80.49])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 97B8266971F;
        Mon, 24 May 2021 17:27:34 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Olsthoorn <dave@bewaar.me>, Shujun Wang <wsj20369@163.com>
Subject: [PATCH v1 3/3] ACPI: power: Rework turning off unused power resources
Date:   Mon, 24 May 2021 17:26:16 +0200
Message-ID: <9903404.nUPlyArG6x@kreacher>
In-Reply-To: <2074778.irdbgypaU6@kreacher>
References: <2074778.irdbgypaU6@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.49
X-CLIENT-HOSTNAME: 89-64-80-49.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedtrdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrgeelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvihgurdgvrdgsohigsehlihhnuhigrdhi
 nhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvgessggvfigrrghrrdhmvgdprhgtphhtthhopeifshhjvddtfeeileesudeifedrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make turning off unused power resources (after the enumeration of
devices and during system-wide resume from S3) more straightforward
by using the observation that the power resource state stored in
struct acpi_power_resource can be used to determine whether or not
the give power resource has any users.

Namely, when the state of the power resource is unknown, its _STA
method has never been evaluated (or the evaluation of it has failed)
and its _ON and _OFF methods have never been executed (or they have
failed to execute), so for all practical purposes it can be assumed
to have no users (or to be unusable).  Therefore, instead of checking
the number of power resource users, it is sufficient to check if its
state is known.

Moreover, if the last known state of a given power resource is "off",
it is not necessary to turn it off, because it has been used to
initialize the power state or the wakeup power resources list of at
least one device and either its _STA method has returned 0 ("off"),
or its _OFF method has been successfully executed already.

Accordingly, modify acpi_turn_off_unused_power_resources() to do the
above checks (which are suitable for both uses of it) instead of
using the number of power resource users or evaluating its _STA
method, drop its argument (which is not useful any more) and update
its callers.

Also drop the users field from struct acpi_power_resource as it is
not useful any more.

Tested-by: Dave Olsthoorn <dave@bewaar.me>
Tested-by: Shujun Wang <wsj20369@163.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/internal.h |    2 +-
 drivers/acpi/power.c    |   45 +++++++++++----------------------------------
 drivers/acpi/scan.c     |    2 +-
 drivers/acpi/sleep.c    |    2 +-
 4 files changed, 14 insertions(+), 37 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -52,7 +52,6 @@ struct acpi_power_resource {
 	u32 system_level;
 	u32 order;
 	unsigned int ref_count;
-	unsigned int users;
 	u8 state;
 	bool wakeup_enabled;
 	struct mutex resource_lock;
@@ -174,8 +173,6 @@ int acpi_extract_power_resources(union a
 		err = acpi_power_resources_list_add(rhandle, list);
 		if (err)
 			break;
-
-		to_power_resource(rdev)->users++;
 	}
 	if (err)
 		acpi_power_resources_list_free(list);
@@ -1018,39 +1015,10 @@ void acpi_resume_power_resources(void)
 }
 #endif
 
-static void acpi_power_turn_off_if_unused(struct acpi_power_resource *resource,
-				       bool init)
-{
-	if (resource->ref_count > 0)
-		return;
-
-	if (init) {
-		if (resource->users > 0)
-			return;
-	} else {
-		int result;
-		u8 state;
-
-		result = acpi_power_get_state(resource->device.handle, &state);
-		if (result || state == ACPI_POWER_RESOURCE_STATE_OFF)
-			return;
-	}
-
-	dev_info(&resource->device.dev, "Turning OFF\n");
-	__acpi_power_off(resource);
-}
-
 /**
  * acpi_turn_off_unused_power_resources - Turn off power resources not in use.
- * @init: Control switch.
- *
- * If @ainit is set, unconditionally turn off all of the ACPI power resources
- * without any users.
- *
- * Otherwise, turn off all ACPI power resources without active references (that
- * is, the ones that should be "off" at the moment) that are "on".
  */
-void acpi_turn_off_unused_power_resources(bool init)
+void acpi_turn_off_unused_power_resources(void)
 {
 	struct acpi_power_resource *resource;
 
@@ -1059,7 +1027,16 @@ void acpi_turn_off_unused_power_resource
 	list_for_each_entry_reverse(resource, &acpi_power_resource_list, list_node) {
 		mutex_lock(&resource->resource_lock);
 
-		acpi_power_turn_off_if_unused(resource, init);
+		/*
+		 * Turn off power resources in an unknown state too, because the
+		 * platform firmware on some system expects the OS to turn off
+		 * power resources without any users unconditionally.
+		 */
+		if (!resource->ref_count &&
+		    resource->state != ACPI_POWER_RESOURCE_STATE_OFF) {
+			dev_info(&resource->device.dev, "Turning OFF\n");
+			__acpi_power_off(resource);
+		}
 
 		mutex_unlock(&resource->resource_lock);
 	}
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -142,7 +142,7 @@ int acpi_device_sleep_wake(struct acpi_d
 int acpi_power_get_inferred_state(struct acpi_device *device, int *state);
 int acpi_power_on_resources(struct acpi_device *device, int state);
 int acpi_power_transition(struct acpi_device *device, int state);
-void acpi_turn_off_unused_power_resources(bool init);
+void acpi_turn_off_unused_power_resources(void);
 
 /* --------------------------------------------------------------------------
                               Device Power Management
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2356,7 +2356,7 @@ int __init acpi_scan_init(void)
 		}
 	}
 
-	acpi_turn_off_unused_power_resources(true);
+	acpi_turn_off_unused_power_resources();
 
 	acpi_scan_initialized = true;
 
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -504,7 +504,7 @@ static void acpi_pm_start(u32 acpi_state
  */
 static void acpi_pm_end(void)
 {
-	acpi_turn_off_unused_power_resources(false);
+	acpi_turn_off_unused_power_resources();
 	acpi_scan_lock_release();
 	/*
 	 * This is necessary in case acpi_pm_finish() is not called during a



