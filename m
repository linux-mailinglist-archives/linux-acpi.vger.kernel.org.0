Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8C451C6
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2019 04:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFNCIm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 22:08:42 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46174 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfFNCIm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jun 2019 22:08:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id 65so788089oid.13
        for <linux-acpi@vger.kernel.org>; Thu, 13 Jun 2019 19:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8H9phhAbM592/xRkwLzBSB0ky/dXdqG638OeUP/3/E=;
        b=kItjBAZkGrKIo75hITC7Tb1ASCebaL/9fp/zXkqCegX03EiS6sLUUZh61QZ7LkFIML
         CRhMmt5JaBESn5TWeE43jAc8XvLOngkLyDnSfCiSbh9YZ1efQg2MXT0IRh3jZ3spmDj7
         lIrNmAr2YbKnnQGt4fBLmdDuVMdVgBD9s9bwBHUC2R13hfw4VcqwOBmc4J+VxY28qqIX
         gWGJWDtK9Zq/QNQU3Za8FYBhRQ9IMjhV6n/+CFG8HptetaixL1Jn701DS0zO5O+ixnmC
         UWrjzf9OZUGdXrbAY8hAFmxOFpn0rp4UZiRNWm/fnDWdDnLI7zJcKXSHgxWY+5j7kDMg
         DCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8H9phhAbM592/xRkwLzBSB0ky/dXdqG638OeUP/3/E=;
        b=Y/83FvDOgjKWLki/sMgl6FqPg9YHV+dsbnj5NoUepkaCsEsDUG+QXsCqOAqtOV/9WF
         Rhoilxst5qVD/AgFi/Fxhox+Y2QEYtgsKXBnMnO8Ev7u5lKGRqR/TwkzBP5CQP99ZtlQ
         mvG2zM4DIZ1i2hZYsX7Air5mbVnMJzbq2h6OUgKGmrLchCBLVshXBYJ9kek0+IXgKWZb
         mLkIjpm36OxmZNF8xK2q7i4Dkueh1NJdh5SKe1me+B/UmhONafKqdJI3lCSw5czLV4Tl
         TvAgCT64IA9CekfXsp56HJNCvFNHszX/0BQ/zto0TNc7WZmODZRcjmt0X6pXHHJWIQD1
         Bspw==
X-Gm-Message-State: APjAAAW5ezyNIXrd3qSww0Ej5iEGzuKxpIiSMUXeORenKU41hRsWoA9b
        pxwdsmmX9BgW6h2rYJ4oC8tlqErgS9kfdMSc2um0Yg==
X-Google-Smtp-Source: APXvYqxO0ALB4g+u9BVBpHypMpNDpb3aRpE3W9VjHZMiI81uXqegdLZ9Kp4W33YO/C9M4YMUggtcUE3lkbOy7OFSHL4=
X-Received: by 2002:aca:5612:: with SMTP id k18mr352899oib.12.1560478120705;
 Thu, 13 Jun 2019 19:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190423233904.195842-1-furquan@google.com> <26443804.PuBNBtcb44@kreacher>
In-Reply-To: <26443804.PuBNBtcb44@kreacher>
From:   Furquan Shaikh <furquan@google.com>
Date:   Thu, 13 Jun 2019 19:08:28 -0700
Message-ID: <CAEGmHFFBBg6cMLaAfPnihABNkMAPbO=isTH3iOakpxRLtXG5pw@mail.gmail.com>
Subject: Re: [PATCH] drivers/acpi: Turn off power resources while entering S5
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 31, 2019 at 3:13 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, April 24, 2019 1:39:04 AM CEST Furquan Shaikh wrote:
> > During boot-up, ACPI bus scan enables all power resources
> > so that respective device drivers can talk to their device. This causes acpi
> > ref_count for the power resource to be incremented to 1. When system
> > suspends (S3/S0ix) or hibernates(S4), DPM is responsible for calling
> > power off on all power resources whose ref_count is 1 i.e. no other
> > user of this power resource and thus resulting in _OFF routine being
> > called for it.
> >
> > However, in case of poweroff, DPM is not involved and so the power
> > resources are left on when the system is entering S5. This results in
> > the violation of power down sequencing for certain devices
> > e.g. touchscreen or digitizer I2C devices.
>
> I'm not sure I can follow you here.  Any details?

On the platforms that I am currently testing, I noticed that ACPI _OFF
routine does not get called for the touchscreen I2C device. Since the
device has power-on and power-down sequencing requirements, not
calling _OFF routine results in its power-down sequence being violated
when the system is entering S5. On further debug, I identified that
this is true for all the ACPI devices on the platform i.e. _OFF
routine does not get called when entering S5.

In case of S3/S0ix, I see that the _OFF ACPI routine gets called using
the following code flow:
pm_suspend()
   ...
   --> suspend_devices_and_enter()
        ...
        --> dpm_suspend() for every device
              ...
              --> acpi_power_off() for every ACPI device

On the other hand, in case of S5, _OFF routine never gets called
because of the following code flow:
kernel_poweroff()
     ...
     --> acpi_power_off_prepare()
            --> acpi_sleep_prepare()
            --> acpi_disable_all_gpes()
            --> acpi_os_wait_events_complete()
     ...
     --> machine_power_off()

In this sequence acpi_power_off is not executed for the devices.


>
> > In order to ensure that the
> > power down sequencing does the right thing, it is necessary for ACPI
> > to disable all power resources while preparing for S5.
>
> Well, I would say that this is not just about power resources.  ACPI PM methods should be
> invoked for the devices as well, so generally there should be subject to the normal PM
> during S5 transitions.

Agree.

>
> Generally speaking, S5 should follow the code flow of the last phase of hibernation.

By last phase of hibernation, do you mean HIBERNATION_SHUTDOWN?

My platforms do not support hibernation, so I can't really test it,
but from my reading of the code sequence below:
hibernate()
    ...
    --> power_down()
          ...

It seems the "last phase of hibernation" i.e. HIBERNATION_SHUTDOWN is
also going to have the same issue i.e. it will not lead to calling the
ACPI _OFF routine.
HIBERNATION_PLATFORM which calls hibernation_platform_enter() actually
makes calls to dpm_suspend() and dpm_suspend_end() which will end up
calling acpi_power_off.

I'm sure I'm missing something here as I'm not too familiar with this
code. Can you please help me by pointing me to the code sequence you
expect should result in getting the _OFF ACPI routine called for:
(1) Hibernation
(2) Shutdown (S5)

Many Thanks!

>
> > This change updates the function acpi_turn_off_unused_power_resources
> > to accept a parameter acpi_system_state, This function turns off power
> > resources according to the targeted system ACPI state:
> > 1. For S0: Unused power resources are turned off i.e. power resources
> > whose ref_count is already 0.
> > 2. For S5: ref_count is decremented first to undo the increment
> > performed during ACPI bus scan and then power resources with ref_count
> > 0 are turned off.
> > 3. All other suspend/hibernate states: No action is required since DPM
> > takes care of turning off power resources.
> >
> > This change should not affect the wake capable devices since:
> > 1. If wake capable devices are enabled before this call, their
> > refcount should be greater than 1. Thus, they won't be turned off.
> > 2. If wake capable devices are not enabled yet when this call is made,
> > they would eventually get turned on by call to
> > acpi_enable_wakeup_devices.
>
> Quite frankly, this looks like a hack causing a particular platform to behave
> as expected, but it very well may not be applicable to other platforms.
>
> > Signed-off-by: Furquan Shaikh <furquan@google.com>
> > ---
> >  drivers/acpi/power.c | 47 ++++++++++++++++++++++++++++++++++++++------
> >  drivers/acpi/sleep.c |  5 ++++-
> >  drivers/acpi/sleep.h |  2 +-
> >  3 files changed, 46 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> > index 665e93ca0b40f..945db762861a3 100644
> > --- a/drivers/acpi/power.c
> > +++ b/drivers/acpi/power.c
> > @@ -889,10 +889,42 @@ void acpi_resume_power_resources(void)
> >
> >       mutex_unlock(&power_resource_list_lock);
> >  }
> > +#endif
> >
> > -void acpi_turn_off_unused_power_resources(void)
> > +/**
> > + * acpi_turn_off_power_resources: This function is used to turn off power
> > + * resources in provided ACPI system state.
> > + *
> > + * Behavior differs based on the target system state:
> > + * ACPI_STATE_S0: Turn off unused power resources i.e. turn off power resources
> > + *                with ref_count zero.
> > + * ACPI_STATE_S5: Decrement ref_count first and turn off power resources with
> > + *                ref_count zero. This is done to ensure that the ref_count
> > + *                incremented during ACPI bus scan is undone and any power
> > + *                resources that are not required during S5 are turned off.
> > + * ACPI_STATE_Sx: No action required. DPM is responsible for turning off power
> > + *                resources while suspending/hibernating.
> > + */
> > +void acpi_turn_off_power_resources(int acpi_system_state)
> >  {
> >       struct acpi_power_resource *resource;
> > +     int decrement;
> > +
> > +     if (acpi_system_state == ACPI_STATE_S0) {
> > +             /*
> > +              * In case of ACPI_STATE_S0, turn off only unused power
> > +              * resources. So, no need to decrement ref_count.
> > +              */
> > +             decrement = 0;
> > +     } else if (acpi_system_state == ACPI_STATE_S5) {
> > +             /*
> > +              * In case of ACPI_STATE_S5, ref_count needs to be decremented
> > +              * first before checking if it is okay to power off the
> > +              * resource.
> > +              */
> > +             decrement = 1;
>
> Instead of doing this you could add a routing decrementing the recfount for all of
> the power resources in the ON state and call that, before the original
> acpi_turn_off_unused_power_resources(), in acpi_power_off_prepare().
>
> That said I don't think the approach is valid in general as stated above.
>
> > +     } else
> > +             return;
> >
> >       mutex_lock(&power_resource_list_lock);
> >
> > @@ -907,10 +939,14 @@ void acpi_turn_off_unused_power_resources(void)
> >                       continue;
> >               }
> >
> > -             if (state == ACPI_POWER_RESOURCE_STATE_ON
> > -                 && !resource->ref_count) {
> > -                     dev_info(&resource->device.dev, "Turning OFF\n");
> > -                     __acpi_power_off(resource);
> > +             if (state == ACPI_POWER_RESOURCE_STATE_ON) {
> > +                     if (resource->ref_count)
> > +                             resource->ref_count -= decrement;
> > +
> > +                     if (!resource->ref_count) {
> > +                             dev_info(&resource->device.dev, "Turning OFF\n");
> > +                             __acpi_power_off(resource);
> > +                     }
> >               }
> >
> >               mutex_unlock(&resource->resource_lock);
> > @@ -918,4 +954,3 @@ void acpi_turn_off_unused_power_resources(void)
> >
> >       mutex_unlock(&power_resource_list_lock);
> >  }
> > -#endif
> > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > index 403c4ff153498..fb6b3ca0eeb91 100644
> > --- a/drivers/acpi/sleep.c
> > +++ b/drivers/acpi/sleep.c
> > @@ -75,6 +75,9 @@ static int acpi_sleep_prepare(u32 acpi_state)
> >       printk(KERN_INFO PREFIX "Preparing to enter system sleep state S%d\n",
> >               acpi_state);
> >       acpi_enable_wakeup_devices(acpi_state);
> > +
> > +     acpi_turn_off_power_resources(acpi_state);
> > +
> >       acpi_enter_sleep_state_prep(acpi_state);
> >       return 0;
> >  }
> > @@ -524,7 +527,7 @@ static void acpi_pm_start(u32 acpi_state)
> >   */
> >  static void acpi_pm_end(void)
> >  {
> > -     acpi_turn_off_unused_power_resources();
> > +     acpi_turn_off_power_resources(ACPI_STATE_S0);
> >       acpi_scan_lock_release();
> >       /*
> >        * This is necessary in case acpi_pm_finish() is not called during a
> > diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
> > index 41675d24a9bc0..a495c91e2bf3b 100644
> > --- a/drivers/acpi/sleep.h
> > +++ b/drivers/acpi/sleep.h
> > @@ -7,7 +7,7 @@ extern struct list_head acpi_wakeup_device_list;
> >  extern struct mutex acpi_device_lock;
> >
> >  extern void acpi_resume_power_resources(void);
> > -extern void acpi_turn_off_unused_power_resources(void);
> > +extern void acpi_turn_off_power_resources(int acpi_system_state);
> >
> >  static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
> >  {
> >
>
>
>
>
