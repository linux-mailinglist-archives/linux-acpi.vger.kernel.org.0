Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E93619B63E
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Apr 2020 21:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbgDATJo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Apr 2020 15:09:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61598 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732148AbgDATJo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2020 15:09:44 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id ba57d8af24efef5a; Wed, 1 Apr 2020 21:09:41 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5.6 regression fix 1/2] ACPI: PM: Add acpi_s2idle_register_wake_callback()
Date:   Wed, 01 Apr 2020 21:09:41 +0200
Message-ID: <4023796.rWsessMiv5@kreacher>
In-Reply-To: <daea7dad-73ac-3f2a-75a1-58017988ec89@redhat.com>
References: <20200329223419.122796-1-hdegoede@redhat.com> <CAJZ5v0iapuqnfsQHhTQTWXdEtzX_MMTBUqdAzCej19AF9rtrNA@mail.gmail.com> <daea7dad-73ac-3f2a-75a1-58017988ec89@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, April 1, 2020 8:26:16 PM CEST Hans de Goede wrote:
> Hi,
> 
> On 4/1/20 6:32 PM, Rafael J. Wysocki wrote:
> > On Mon, Mar 30, 2020 at 12:34 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Since commit fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from
> >> waking up the system") the SCI triggering without there being a wakeup
> >> cause recognized by the ACPI sleep code will no longer wakeup the system.
> >>
> >> This works as intended, but this is a problem for devices where the SCI
> >> is shared with another device which is also a wakeup source.
> >>
> >> In the past these, from the pov of the ACPI sleep code, spurious SCIs
> >> would still cause a wakeup so the wakeup from the device sharing the
> >> interrupt would actually wakeup the system. This now no longer works.
> >>
> >> This is a problem on e.g. Bay Trail-T and Cherry Trail devices where
> >> some peripherals (typically the XHCI controller) can signal a
> >> Power Management Event (PME) to the Power Management Controller (PMC)
> >> to wakeup the system, this uses the same interrupt as the SCI.
> >> These wakeups are handled through a special INT0002 ACPI device which
> >> checks for events in the GPE0a_STS for this and takes care of acking
> >> the PME so that the shared interrupt stops triggering.
> >>
> >> The change to the ACPI sleep code to ignore the spurious SCI, causes
> >> the system to no longer wakeup on these PME events. To make things
> >> worse this means that the INT0002 device driver interrupt handler will
> >> no longer run, causing the PME to not get cleared and resulting in the
> >> system hanging. Trying to wakeup the system after such a PME through e.g.
> >> the power button no longer works.
> >>
> >> Add an acpi_s2idle_register_wake_callback() function which registers
> >> a callback to be called from acpi_s2idle_wake() and when the callback
> >> returns true, return true from acpi_s2idle_wake().
> >>
> >> The INT0002 driver will use this mechanism to check the GPE0a_STS
> >> register from acpi_s2idle_wake() and to tell the system to wakeup
> >> if a PME is signaled in the register.
> >>
> >> Fixes: fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system")
> >> Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > I generally agree with the approach, but I would make some, mostly
> > cosmetic, changes.
> > 
> > First off, I'd put the new code into drivers/acpi/wakeup.c.
> > 
> > I'd export one function from there to be called from
> > acpi_s2idle_wake() and the install/uninstall routines for the users.
> 
> Ok.
> 
> >> ---
> >>   drivers/acpi/sleep.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
> >>   include/linux/acpi.h |  7 +++++
> >>   2 files changed, 77 insertions(+)
> >>
> >> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> >> index e5f95922bc21..e360e51afa8e 100644
> >> --- a/drivers/acpi/sleep.c
> >> +++ b/drivers/acpi/sleep.c
> >> @@ -943,6 +943,65 @@ static struct acpi_scan_handler lps0_handler = {
> >>          .attach = lps0_device_attach,
> >>   };
> >>
> >> +struct s2idle_wake_callback {
> > 
> > I'd call this acpi_wakeup_handler.
> > 
> >> +       struct list_head list;
> > 
> > list_node?
> > 
> >> +       bool (*function)(void *data);
> > 
> > bool (*wakeup)(void *context)?
> > 
> >> +       void *user_data;
> > 
> > context?
> 
> Sure (for all of the above).
> 
> > 
> >> +};
> >> +
> >> +static LIST_HEAD(s2idle_wake_callback_head);
> >> +static DEFINE_MUTEX(s2idle_wake_callback_mutex);
> >> +
> >> +/*
> >> + * Drivers which may share an IRQ with the SCI can use this to register
> >> + * a callback which returns true when the device they are managing wants
> >> + * to trigger a wakeup.
> >> + */
> >> +int acpi_s2idle_register_wake_callback(
> >> +       int wake_irq, bool (*function)(void *data), void *user_data)
> >> +{
> >> +       struct s2idle_wake_callback *callback;
> >> +
> >> +       /*
> >> +        * If the device is not sharing its IRQ with the SCI, there is no
> >> +        * need to register the callback.
> >> +        */
> >> +       if (!acpi_sci_irq_valid() || wake_irq != acpi_sci_irq)
> >> +               return 0;
> >> +
> >> +       callback = kmalloc(sizeof(*callback), GFP_KERNEL);
> >> +       if (!callback)
> >> +               return -ENOMEM;
> >> +
> >> +       callback->function = function;
> >> +       callback->user_data = user_data;
> >> +
> >> +       mutex_lock(&s2idle_wake_callback_mutex);
> >> +       list_add(&callback->list, &s2idle_wake_callback_head);
> >> +       mutex_unlock(&s2idle_wake_callback_mutex);
> >> +
> >> +       return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(acpi_s2idle_register_wake_callback);
> >> +
> >> +void acpi_s2idle_unregister_wake_callback(
> >> +       bool (*function)(void *data), void *user_data)
> >> +{
> >> +       struct s2idle_wake_callback *cb;
> >> +
> >> +       mutex_lock(&s2idle_wake_callback_mutex);
> >> +       list_for_each_entry(cb, &s2idle_wake_callback_head, list) {
> >> +               if (cb->function == function &&
> >> +                   cb->user_data == user_data) {
> >> +                       list_del(&cb->list);
> >> +                       kfree(cb);
> >> +                       break;
> >> +               }
> >> +       }
> >> +       mutex_unlock(&s2idle_wake_callback_mutex);
> >> +}
> >> +EXPORT_SYMBOL_GPL(acpi_s2idle_unregister_wake_callback);
> >> +
> >>   static int acpi_s2idle_begin(void)
> >>   {
> >>          acpi_scan_lock_acquire();
> >> @@ -992,6 +1051,8 @@ static void acpi_s2idle_sync(void)
> >>
> >>   static bool acpi_s2idle_wake(void)
> >>   {
> >> +       struct s2idle_wake_callback *cb;
> >> +
> >>          if (!acpi_sci_irq_valid())
> >>                  return pm_wakeup_pending();
> >>
> >> @@ -1025,6 +1086,15 @@ static bool acpi_s2idle_wake(void)
> >>                  if (acpi_any_gpe_status_set() && !acpi_ec_dispatch_gpe())
> >>                          return true;
> >>
> >> +               /*
> >> +                * Check callbacks registered by drivers sharing the SCI.
> >> +                * Note no need to lock, nothing else is running.
> >> +                */
> >> +               list_for_each_entry(cb, &s2idle_wake_callback_head, list) {
> >> +                       if (cb->function(cb->user_data))
> >> +                               return true;
> >> +               }
> > 
> > AFAICS this needs to be done in acpi_s2idle_restore() too to clear the
> > status bits in case one of these wakeup sources triggers along with a
> > GPE or a fixed event and the other one wins the race.
> 
> The "wakeup" callback does not actually clear the interrupt source, just like
> for normal interrupts it relies on the actual interrupt handling (which at this
> point is still suspended) to do this.

Of course, you are right, sorry for the confusion.

What I meant was that the interrupt handler needed to run in acpi_s2idle_restore(),
but that should be taken care of the acpi_os_wait_events_complete() in there
which synchronizes the SCI among other things.

Thanks!



