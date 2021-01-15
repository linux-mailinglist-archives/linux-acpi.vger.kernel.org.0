Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EBE2F84FC
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 20:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbhAOTCG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 14:02:06 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41310 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbhAOTCG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jan 2021 14:02:06 -0500
Received: from 89-64-81-100.dynamic.chello.pl (89.64.81.100) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 6ce390c9e10ea77e; Fri, 15 Jan 2021 20:01:19 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
Date:   Fri, 15 Jan 2021 20:01:19 +0100
Message-ID: <2803525.PQFCXvBIof@kreacher>
In-Reply-To: <8b316bf8-6a5c-c6d4-c0db-304ec529c805@linux.intel.com>
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com> <CAJZ5v0j87iF7S2-H+5D3A9HbRBA=W03r_9GPgwWLtH6nLwwZfw@mail.gmail.com> <8b316bf8-6a5c-c6d4-c0db-304ec529c805@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, January 15, 2021 5:41:57 PM CET Pierre-Louis Bossart wrote:
> 
> >>> [    0.516336] ACPI: \_SB_.PCI0.BRCM: Dependencies found
> >>
> >> Ah, that is enlightening, that is not supposed to happen, that device
> >> has both an _ADR and an _HID method which is not allowed according
> >> to the spec.
> 
> it's not an uncommon issue for audio codecs, here's three examples:
> 
>              Device (RTK1)
>              {
>                  Name (_ADR, Zero)  // _ADR: Address
>                  Name (_HID, "10EC5670")  // _HID: Hardware ID
>                  Name (_CID, "10EC5670")  // _CID: Compatible ID
>                  Name (_DDN, "ALC5642")  // _DDN: DOS Device Name
> 
>          Device (MAXM)
>          {
>              Name (_ADR, Zero)  // _ADR: Address
>              Name (_HID, "193C9890")  // _HID: Hardware ID
>              Name (_CID, "193C9890")  // _CID: Compatible ID
>              Name (_DDN, "Maxim 98090 Codec  ")  // _DDN: DOS Device Name
> 
>          Device (TISW)
>          {
>              Name (_ADR, Zero)  // _ADR: Address
>              Name (_HID, "104C227E")  // _HID: Hardware ID
>              Name (_CID, "104C227E")  // _CID: Compatible ID
> 
> It's been that way for years...
> 
> >> Can you try a clean 5.11 kernel (so none of the previous
> >> debug patches) with the following change added:
> >>
> >> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> >> index 1f27f74cc83c..93954ac3bfcc 100644
> >> --- a/drivers/acpi/scan.c
> >> +++ b/drivers/acpi/scan.c
> >> @@ -1854,7 +1854,8 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
> >>           * 2. ACPI nodes describing USB ports.
> >>           * Still, checking for _HID catches more then just these cases ...
> >>           */
> >> -       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
> >> +       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID") ||
> >> +           acpi_has_method(handle, "_ADR"))
> >>                  return 0;
> >>
> >>          status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
> >>
> >>
> >>> [    0.517490] ACPI: \_SB_.PCI0.LNPW: Dependencies found
> >>
> >> And idem. for this one.
> >>
> >> That might very well fix this.
> 
> Nope, no luck with this patch. boot still stuck.

OK, thanks!

Now, there is a theory to test and some more debug work to do.

First, the kernel should not crash outright if some ACPI device objects are
missing which evidently happens here.  There may be some problems resulting
from that, but the crash indicates a code bug in the kernel.

Apparently, something expects the device objects to be there so badly, that it
crashes right away when they aren't there.  One of the issues that may cause
that to happen are mistakes around the acpi_bus_get_device() usage and I found
two of them, so below is a patch to test.

Please apply to plain 5.11-rc3 (or -rc4 when it is out) and see if that makes
any difference.

---
 drivers/acpi/scan.c         |    3 +--
 drivers/usb/core/usb-acpi.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2120,8 +2120,7 @@ void acpi_walk_dep_device_list(acpi_hand
 	mutex_lock(&acpi_dep_list_lock);
 	list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
 		if (dep->supplier == handle) {
-			acpi_bus_get_device(dep->consumer, &adev);
-			if (!adev)
+			if (acpi_bus_get_device(dep->consumer, &adev))
 				continue;
 
 			adev->dep_unmet--;
Index: linux-pm/drivers/usb/core/usb-acpi.c
===================================================================
--- linux-pm.orig/drivers/usb/core/usb-acpi.c
+++ linux-pm/drivers/usb/core/usb-acpi.c
@@ -163,10 +163,9 @@ usb_acpi_get_companion_for_port(struct u
 	} else {
 		parent_handle = usb_get_hub_port_acpi_handle(udev->parent,
 							     udev->portnum);
-		if (!parent_handle)
+		if (!parent_handle || acpi_bus_get_device(parent_handle, &adev))
 			return NULL;
 
-		acpi_bus_get_device(parent_handle, &adev);
 		port1 = port_dev->portnum;
 	}
 



