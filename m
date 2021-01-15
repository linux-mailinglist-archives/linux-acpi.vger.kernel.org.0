Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C862F7F70
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 16:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbhAOPXh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 10:23:37 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:65032 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731525AbhAOPXh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jan 2021 10:23:37 -0500
Received: from 89-64-81-100.dynamic.chello.pl (89.64.81.100) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id b95aab54fdf6e60a; Fri, 15 Jan 2021 16:22:55 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
Date:   Fri, 15 Jan 2021 16:22:54 +0100
Message-ID: <10742637.M1KgVVZ4YP@kreacher>
In-Reply-To: <c27b98bf-c829-e128-cb74-149b14028a22@linux.intel.com>
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com> <CAJZ5v0i63MsXX18rat7XfxUHBsc_OKD1nZvdv07WytgNP7+mtQ@mail.gmail.com> <c27b98bf-c829-e128-cb74-149b14028a22@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, January 15, 2021 4:09:05 PM CET Pierre-Louis Bossart wrote:
> 
> >>> In addition to what Hans asked for, can you please build the kernel with the
> >>> debug patch below applied (instead of the Hans' debug patch), try to boot
> >>> the affected machine with it and see what is missing with respect to booting
> >>> the kernel with the two problematic commits reverted?
> >>
> >> Sorry, not following. Are you asking me to apply the patch below as well
> >> as revert the two problematic commits? Or just the patch below?
> > 
> > Just the patch below.
> > 
> >> the boot process is stuck without the reverts and I don't have a serial link to
> >> see what happens (closed form-factor).
> > 
> > The point is that the patch below may unstuck it, in which case it
> > should be possible to find out what is missing with respect to the
> > full successful boot.
> 
> No luck. I tried twice with the patch below only, and the device is 
> still stuck after the 'Loading initial ramdisk ...'.

Thanks!

This means that skipping the enumeration of a certain device alone is
problematic which is a surprise of sorts.

Let's see what device that may be.

Because the machine booted with the debug patch from Hans, it should also boot
with the one below, so please do that and send the output of

$ dmesg | grep Dependencies

---
 drivers/acpi/scan.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1950,10 +1950,8 @@ static acpi_status acpi_bus_check_add(ac
 	if (type == ACPI_BUS_TYPE_DEVICE && check_dep) {
 		u32 count = acpi_scan_check_dep(handle);
 		/* Bail out if the number of recorded dependencies is not 0. */
-		if (count > 0) {
-			acpi_bus_scan_second_pass = true;
-			return AE_CTRL_DEPTH;
-		}
+		if (count > 0)
+			acpi_handle_info(handle, "Dependencies found\n");
 	}
 
 	acpi_add_single_object(&device, handle, type, sta);
@@ -1961,8 +1959,7 @@ static acpi_status acpi_bus_check_add(ac
 		return AE_CTRL_DEPTH;
 
 	acpi_scan_init_hotplug(device);
-	if (!check_dep)
-		acpi_scan_dep_init(device);
+	acpi_scan_dep_init(device);
 
 out:
 	if (!*adev_p)



