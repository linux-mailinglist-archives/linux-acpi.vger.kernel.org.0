Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5281E1EE6D4
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jun 2020 16:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgFDOm5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jun 2020 10:42:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61894 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgFDOm5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jun 2020 10:42:57 -0400
Received: from 89-64-85-58.dynamic.chello.pl (89.64.85.58) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 7b0ab9fb5bfafce7; Thu, 4 Jun 2020 16:42:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        youling257@gmail.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI / PM: Do not infer power-state if there are no D0 power-resources
Date:   Thu, 04 Jun 2020 16:42:53 +0200
Message-ID: <2226585.qILhkvVZS1@kreacher>
In-Reply-To: <d084b424-a340-a24a-d681-c92d80d8421d@redhat.com>
References: <20200603194659.185757-1-hdegoede@redhat.com> <CAJZ5v0g7rhiWs0ZeGGS5OoSMH7DiVT1D-EUgX5HFXYkcvXcm2Q@mail.gmail.com> <d084b424-a340-a24a-d681-c92d80d8421d@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, June 4, 2020 2:15:41 PM CEST Hans de Goede wrote:
> Hi,
> 
> On 6/4/20 1:22 PM, Rafael J. Wysocki wrote:
> > On Wed, Jun 3, 2020 at 9:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Some devices do not have a power-resource-list for D0, but do have a
> >> power-resource-lists for e.g. D3 (_PR3).
> > 
> > This looks like a bug in the firmware.
> 
> The DSDT for these devices definitely has somw warts, see
> below.
> 
> TBH I'm not sure of the whole inferring state from
> power-resource-lists is the best idea. I think just going
> for UNKNOWN as initial state would be better. The issue is
> that getting the initial state wrong will lead to either
> skipping _PS3 (as is happening here) or _PS0 on the first
> transition to the matching state which can have undesirable
> side-effects, where as just running _PS0/PS3 for a second
> time _usually_ should be fine.
> 
> Anyways I know we have the inferring code for a long time,
> and I guess it mostly does its job fine...
> 
> > It is hard to imagine a design in which some power resources only need
> > to be "on" in the D3hot power state of a device and not in D0 (which
> > is implied by the lack of _PR0 and the presence of _PR3).
> 
> Right, except that the listed resource is a dummy power
> resource, here is the AML for the USB power-resource which
> is the only resource in the _PR3 list:
> 
>              PowerResource (USBC, 0x00, 0x0000)
>              {
>                  Method (_STA, 0, NotSerialized)  // _STA: Status
>                  {
>                      Return (0x0F)
>                  }

This is wrong, because the _STA return value is required to return the
current state of the power resource, which evidently is not the case
here.

> 
>                  Method (_ON, 0, NotSerialized)  // _ON_: Power On
>                  {
>                  }
> 
>                  Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
>                  {
>                  }
>              }
> 
> So not having this in _PR0 does not matter because the
> whole thing is a dummy implementation.

Now that is an important piece of information, because it basically means that
on the affected platform(s) the _PR3 is present only to indicate D3cold support.

It also means that the device doesn't really support D3hot and _PS3 puts it
straight into D3cold.

In the face of this, I don't think it is safe to use power resources if the
D0 list is empty (either _PR0 is not present or it returns an empty package).

> If you want the whole DSDT, the DSDT of one of the affected devices
> is attached here: https://bugzilla.kernel.org/show_bug.cgi?id=69011
> 
> Note it seems that pretty much any Bay Trail tablet version based
> device suffers from this.

Well, that's sad. :-/

> > So when the device goes from D0 to D3hot, we are expected to turn some
> > power resources "on"?  What sense does this make?
> > 
> > I'm guessing that this only works at all, because we only use D0 and
> > D3cold with the affected devices and _PS0 simply turns the power
> > resource(s) in question on.
> > 
> >> On these devices the "if (device->power.flags.power_resources)" check
> >> in acpi_device_get_power() succeeds because of the presence of the _PR3
> >> resources, so the code used to try and infer the power-state.
> >>
> >> In this case since there is no power-resource-list for D0, we can never
> >> infer that the device is in D0 even though it very well might be in D0.
> >> This results in the code inferring that the device is in D3HOT and on
> >> the first suspend acpi_device_set_power() skips calling _PS3 for the
> >> device because it thinks the device is already in D3.
> >>
> >> An example of a family of devices which are affected by this are
> >> Bay Trail based devices. The ACPI device for the XHCI controller on
> >> these devices does not have a _PR0 method, but it does have a _PR3
> >> method. The problem described above causes the XHCI controller's _PS3
> >> method not getting called on the first suspend of the device, which
> >> causes these devices to not reach the S0i3 power-state during suspend.
> >>
> >> Since we cannot infer if the device is in D0 or not when there is no
> >> power-resource-list for D0, the best thing to do is to change
> >> acpi_power_get_inferred_state() to return ACPI_STATE_UNKNOWN in this
> >> case.
> >>
> >> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205057
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>   drivers/acpi/power.c | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> >> index fe1e7bc91a5e..db54393a077b 100644
> >> --- a/drivers/acpi/power.c
> >> +++ b/drivers/acpi/power.c
> >> @@ -807,6 +807,17 @@ int acpi_power_get_inferred_state(struct acpi_device *device, int *state)
> >>          if (!device || !state)
> >>                  return -EINVAL;
> >>
> >> +       /*
> >> +        * Some devices do not have a power-resource-list for D0, but do
> >> +        * have a power-resource-lists for e.g. D3 so we do end up here.
> >> +        * In this case we can never infer that the device is in D0 even
> >> +        * though it might very well be in D0, so return ACPI_STATE_UNKNOWN.
> >> +        */
> >> +       if (list_empty(&device->power.states[ACPI_STATE_D0].resources)) {
> >> +               *state = ACPI_STATE_UNKNOWN;
> >> +               return 0;
> >> +       }
> > 
> > Well, this makes things work on the particular affected platform, but
> > that seems to be just by accident, because _PS0 does something special
> > on it.
> > 
> > IMO this needs to be addressed elsewhere and in a different way.
> > 
> > Namely, it looks like if _PR0 is not present (or its return package is
> > empty), but _PR3 is present, we should use the _PR3 list of power
> > resources for D0 as well as for D3hot.
> 
> That should work too.

No, it wouldn't, because the _PR3 power resources above are not functional.

> > Let me cut a patch for that.
> 
> Ok, let me know when you have a patch ready then I will test it.

Sure, please find appended.

That just avoids using power resources at all if the D0 list is empty.

---
 drivers/acpi/scan.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

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
 
@@ -970,6 +967,14 @@ static void acpi_bus_get_power_flags(str
 	for (i = ACPI_STATE_D0; i <= ACPI_STATE_D3_HOT; i++)
 		acpi_bus_init_power_state(device, i);
 
+	/*
+	 * Use power resources only if the D0 list of them is populated, because
+	 * some platforms only provide _PR3 to indicate D3cold support and in
+	 * those cases the power resources list returned by _PR3 may be bogus.
+	 */
+	if (!list_empty(&device->power.states[ACPI_STATE_D0].resources))
+		device->power.flags.power_resources = 1;
+
 	INIT_LIST_HEAD(&device->power.states[ACPI_STATE_D3_COLD].resources);
 	if (!list_empty(&device->power.states[ACPI_STATE_D3_HOT].resources))
 		device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;



