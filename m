Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E762CC158
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 16:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgLBPwn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 10:52:43 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61188 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgLBPwn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 10:52:43 -0500
Received: from 89-64-87-31.dynamic.chello.pl (89.64.87.31) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id b44ba3b869077574; Wed, 2 Dec 2020 16:52:00 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 0/7] ACPI: scan: Split root scanning into 2 steps
Date:   Wed, 02 Dec 2020 16:51:59 +0100
Message-ID: <3608964.tmAejbicsr@kreacher>
In-Reply-To: <CAJZ5v0joWwOqaBkEXOsi3oT__j8JMJt68TPuRAY7f5WY6w=KrA@mail.gmail.com>
References: <20201121203040.146252-1-hdegoede@redhat.com> <CAJZ5v0joWwOqaBkEXOsi3oT__j8JMJt68TPuRAY7f5WY6w=KrA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, December 2, 2020 2:49:17 PM CET Rafael J. Wysocki wrote:
> On Sat, Nov 21, 2020 at 9:30 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi Rafael,
> >
> > A while ago (almost 2 years ago) I discussed an issue with you about
> > some devices, where some of the methods used during device-addition
> > (such as _HID) may rely on OpRegions of other devices:
> >
> > https://www.spinics.net/lists/linux-acpi/msg86303.html
> >
> > An example of this is the Acer Switch 10E SW3-016 model. The _HID method
> > of the ACPI node for the UART attached Bluetooth, reads GPIOs to detect
> > the installed wifi chip and update the _HID for the Bluetooth's ACPI node
> > accordingly. The current ACPI scan code calls _HID before the GPIO
> > controller's OpRegions are available, leading to the wrong _HID being
> > used and Bluetooth not working.
> >
> > Last week I bought a second hand Acer device, not knowing it was this
> > exact model. Since I now have access to affected hardware I decided to
> > take a shot at fixing this.
> >
> > In the discussion you suggested to split the acpi_bus_scan of the root
> > into 2 steps, first scan devices with an empty _DEP, putting other
> > acpi_handle-s on a list of deferred devices and then in step 2 scan the
> > rest.
> >
> > I'm happy to report that, at least on the affected device, this works
> > nicely. While working on this I came up with a less drastic way to
> > deal with this. As you will see in patch 4 of this series, I decided
> > to first add a more KISS method of deciding which devices to defer
> > to the second scan step by matching by HID. This has the disadvantage
> > of not being a generic solution. But it has the advantage of being a
> > solution which does not potentially regress other devices.
> >
> > Then in patch 5 I actually do add the option to defer or not based on
> > _DEP being empty. I've put this behind a kernel commandline option as
> > I'm not sure we should do this everywhere by default. At least no without
> > a lot more testing.
> >
> > Patch 6 fixes an issue with patch 5 which causes battery devices to stop
> > working.
> >
> > And patch 7 adds some extra HIDs to the list of HIDs which should be
> > ignored when checking if the _DEP list is empty from Linux' pov, iow
> > some extra HIDs which Linux does not bind to.
> >
> > Please let me know what you think about this patch-set. I would be happy
> > to see just patches 1-4 merged.
> 
> I took patches 1 and 2, because IMO they are generally useful (I
> rewrote the changelogs to avoid mentioning the rest of the series
> though), but I have some reservations regarding the rest.
> 
> First off, I'm not really sure if failing acpi_add_single_object() for
> devices with missing dependencies is a good idea.  IIRC there is
> nothing in there that should depend on any opregions supplied by the
> other devices, so it should be safe to allow it to complete.  That, in
> turn, will allow the flags in struct acpi_device to be used to mark
> the "deferred" devices without allocating more memory.
> 
> Next, in theory, devices with dependencies may also appear during
> hotplug, so it would be prudent to handle that on every invocation of
> acpi_bus_scan() and not just when it runs for the root object.
> 
> So my approach would be to allow the first namespace walk in
> acpi_bus_scan() to complete, change acpi_bus_attach() to optionally
> skip the devices with missing dependencies and return a result
> indicating whether or not it has set flags.visited for any devices and
> run it in a loop on the "root" device object until it says that no new
> devices have been "attached".
> 
> Let me cut a prototype patch for that and get back to you.

Maybe something like the patch below (untested).  I borrowed a few items from
your patches, hopefully not a problem.

The multiple passes idea would require using a static variable which would
be slightly inelegant, so this assumes that two passes should be sufficient.

---
 drivers/acpi/scan.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1961,12 +1961,50 @@ static int acpi_scan_attach_handler(stru
 	return ret;
 }
 
-static void acpi_bus_attach(struct acpi_device *device)
+/*
+ * List of IDs for which we defer adding them to the second pass of the
+ * scanning, because some of their methods used during addition depend on
+ * OpRegions registered by the drivers for other ACPI devices.
+ */
+static const struct acpi_device_id acpi_defer_attach_ids[] = {
+	{ "BCM2E5B", 0 }, /* Acer SW3-016 bluetooth vs GPIO OpRegs */
+	{"", 0},
+};
+
+static bool acpi_scan_should_defer_attach(struct acpi_device *adev)
+{
+	if (acpi_match_device_ids(adev, acpi_defer_attach_ids))
+		return true;
+
+	/*
+	 * We check for _ADR here to avoid deferring the adding of the following:
+	 * 1. PCI devices
+	 * 2. ACPI nodes describing USB ports
+	 * Note checking for _ADR catches more then just these cases ...
+	 */
+	if (adev->pnp.type.bus_address)
+		return false;
+
+	return adev->dep_unmet > 0;
+}
+
+static void __acpi_bus_attach(struct acpi_device *device, bool first_pass)
 {
 	struct acpi_device *child;
 	acpi_handle ejd;
 	int ret;
 
+	if (first_pass) {
+		if (acpi_scan_should_defer_attach(device))
+			return;
+	} else if (device->flags.visited) {
+		/*
+		 * This is not the first pass in the given scan and the device
+		 * has been "attached" already, so get to the children right away.
+		 */
+		goto ok;
+	}
+
 	if (ACPI_SUCCESS(acpi_bus_get_ejd(device->handle, &ejd)))
 		register_dock_dependent_device(device, ejd);
 
@@ -2013,12 +2051,23 @@ static void acpi_bus_attach(struct acpi_
 
  ok:
 	list_for_each_entry(child, &device->children, node)
-		acpi_bus_attach(child);
+		__acpi_bus_attach(child, first_pass);
 
-	if (device->handler && device->handler->hotplug.notify_online)
+	if (first_pass && device->handler &&
+	    device->handler->hotplug.notify_online)
 		device->handler->hotplug.notify_online(device);
 }
 
+static void acpi_bus_attach(struct acpi_device *device)
+{
+	/*
+	 * Assume two passes to be sufficient to satisfy all of the operation
+	 * region dependencies.
+	 */
+	__acpi_bus_attach(device, true);
+	__acpi_bus_attach(device, false);
+}
+
 void acpi_walk_dep_device_list(acpi_handle handle)
 {
 	struct acpi_dep_data *dep, *tmp;



