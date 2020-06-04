Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9D21EE958
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jun 2020 19:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgFDRWa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jun 2020 13:22:30 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42574 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbgFDRWa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jun 2020 13:22:30 -0400
Received: from 89-64-85-58.dynamic.chello.pl (89.64.85.58) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 27bd5aa14999d311; Thu, 4 Jun 2020 19:22:27 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        youling257@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] ACPI: PM: Avoid using power resources if there are none for D0
Date:   Thu, 04 Jun 2020 19:22:26 +0200
Message-ID: <13388608.OHKVb9tm6R@kreacher>
In-Reply-To: <d084b424-a340-a24a-d681-c92d80d8421d@redhat.com>
References: <20200603194659.185757-1-hdegoede@redhat.com> <CAJZ5v0g7rhiWs0ZeGGS5OoSMH7DiVT1D-EUgX5HFXYkcvXcm2Q@mail.gmail.com> <d084b424-a340-a24a-d681-c92d80d8421d@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

As recently reported, some platforms provide a list of power
resources for device power state D3hot, through the _PR3 object,
but they do not provide a list of power resources for device power
state D0.

Among other things, this causes acpi_device_get_power() to return
D3hot as the current state of the device in question if all of the
D3hot power resources are "on", because it sees the power_resources
flag set and calls acpi_power_get_inferred_state() which finds that
D3hot is the shallowest power state with all of the associated power
resources turned "on", so that's what it returns.  Moreover, that
value takes precedence over the acpi_dev_pm_explicit_get() return
value, because it means a deeper power state.  The device may very
well be in D0 physically at that point, however.

Moreover, the presence of _PR3 without _PR0 for a given device
means that only one D3-level power state can be supported by it.
Namely, because there are no power resources to turn "off" when
transitioning the device from D0 into D3cold (which should be
supported since _PR3 is present), the evaluation of _PS3 should
be sufficient to put it straight into D3cold, but this means that
the effect of turning "on" the _PR3 power resources is unclear,
so it is better to avoid doing that altogether.  Consequently,
there is no practical way do distinguish D3cold from D3hot for
the device in question and the power states of it can be labeled
so that D3hot is the deepest supported one (and Linux assumes
that putting a device into D3hot via ACPI may cause power to be
removed from it anyway, for legacy reasons).

To work around the problem described above modify the ACPI
enumeration of devices so that power resources are only used
for device power management if the list of D0 power resources
is not empty and make it mart D3cold as supported only if that
is the case and the D3hot list of power resources is not empty
too.

Fixes: ef85bdbec444 ("ACPI / scan: Consolidate extraction of power resources lists")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=205057
Link: https://lore.kernel.org/linux-acpi/20200603194659.185757-1-hdegoede@redhat.com/
Reported-by: Hans de Goede <hdegoede@redhat.com>
Cc: 3.10+ <stable@vger.kernel.org> # 3.10+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    2 +-
 drivers/acpi/scan.c      |   28 +++++++++++++++++++---------
 2 files changed, 20 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -919,12 +919,9 @@ static void acpi_bus_init_power_state(st
 
 		if (buffer.length && package
 		    && package->type == ACPI_TYPE_PACKAGE
-		    && package->package.count) {
-			int err = acpi_extract_power_resources(package, 0,
-							       &ps->resources);
-			if (!err)
-				device->power.flags.power_resources = 1;
-		}
+		    && package->package.count)
+			acpi_extract_power_resources(package, 0, &ps->resources);
+
 		ACPI_FREE(buffer.pointer);
 	}
 
@@ -971,14 +968,27 @@ static void acpi_bus_get_power_flags(str
 		acpi_bus_init_power_state(device, i);
 
 	INIT_LIST_HEAD(&device->power.states[ACPI_STATE_D3_COLD].resources);
-	if (!list_empty(&device->power.states[ACPI_STATE_D3_HOT].resources))
-		device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
 
-	/* Set defaults for D0 and D3hot states (always valid) */
+	/* Set the defaults for D0 and D3hot (always supported). */
 	device->power.states[ACPI_STATE_D0].flags.valid = 1;
 	device->power.states[ACPI_STATE_D0].power = 100;
 	device->power.states[ACPI_STATE_D3_HOT].flags.valid = 1;
 
+	/*
+	 * Use power resources only if the D0 list of them is populated, because
+	 * some platforms may provide _PR3 only to indicate D3cold support and
+	 * in those cases the power resources list returned by it may be bogus.
+	 */
+	if (!list_empty(&device->power.states[ACPI_STATE_D0].resources)) {
+		device->power.flags.power_resources = 1;
+		/*
+		 * D3cold is supported if the D3hot list of power resources is
+		 * not empty.
+		 */
+		if (!list_empty(&device->power.states[ACPI_STATE_D3_HOT].resources))
+			device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
+	}
+
 	if (acpi_bus_init_power(device))
 		device->flags.power_manageable = 0;
 }
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -186,7 +186,7 @@ int acpi_device_set_power(struct acpi_de
 		 * possibly drop references to the power resources in use.
 		 */
 		state = ACPI_STATE_D3_HOT;
-		/* If _PR3 is not available, use D3hot as the target state. */
+		/* If D3cold is not supported, use D3hot as the target state. */
 		if (!device->power.states[ACPI_STATE_D3_COLD].flags.valid)
 			target_state = state;
 	} else if (!device->power.states[state].flags.valid) {



