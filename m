Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B21300979
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 18:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbhAVQqT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 11:46:19 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:37246 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbhAVQns (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 11:43:48 -0500
Received: by mail-oi1-f182.google.com with SMTP id r189so6616052oih.4;
        Fri, 22 Jan 2021 08:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A53Fny55mdIWBsolGsXez4xo36IZS+ZOP3kW5TdEycE=;
        b=tPMi4tzArgdJd9KyZsUo+mz+Qk91nY6j+vOwLnq+km/1YwLWW6PyXluharOoNeZCWj
         BsNTNDyKvjnqlF69NtYiBOqIArIu+a/JOqc+ppN1qIYLAKPBuuX6rIHiexUefOA+4LGW
         gAwYBcH0azWIa6k1IPM9mHEd159UxyZceCpUpgGiKP7ReAqTJmU9M19DWMc4LbcvNIQQ
         l8lZzdd+IeEkYWwnS17TTTEdHm9F2Z32WBNnf+L6vP2EzOTUvILi9/Sx390v/0x5fzrm
         9M+DA9ol+lbllaR8U6IhpqYeLOn4uma9SKErFeR6zlppfRZkWVzVSHj5K7aWSZb+A2Kk
         gOzw==
X-Gm-Message-State: AOAM532TLk/1BpAIWtwBs2JtG00qG/PpwVBfjErgf8C9k+/4yWy5vVmT
        ouNjV2vhrMnrzeQvonf4ctF2tslVCn5bK2OLCA16rg4/
X-Google-Smtp-Source: ABdhPJzW3RgLPOFzjMcDYg2pFb+cVuufNP3kJ8Oxp5z+yB46v0CuCZYTlb1ZA9ThloXn9euITEQGu4uJCluhw/MK1e4=
X-Received: by 2002:aca:fc84:: with SMTP id a126mr3871328oii.71.1611333790631;
 Fri, 22 Jan 2021 08:43:10 -0800 (PST)
MIME-Version: 1.0
References: <3391226.KRKnzuvfpg@kreacher> <CAJZ5v0gB4B_Os0VQv-F2SdVcJ8_rUdjic6rOEjOd=ZWhGzdLdQ@mail.gmail.com>
 <87tur9vscw.fsf@rub.de>
In-Reply-To: <87tur9vscw.fsf@rub.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 17:42:59 +0100
Message-ID: <CAJZ5v0gQCxcxiFTtZ3Ea6gbY=WFt5oD4fq7vpQqvkJKqbg1=rA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal: Do not call acpi_thermal_check() directly
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 22, 2021 at 5:39 PM Stephen Berman <stephen.berman@gmx.net> wrote:
>
> On Fri, 22 Jan 2021 17:23:36 +0100 "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Thu, Jan 14, 2021 at 7:35 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Calling acpi_thermal_check() from acpi_thermal_notify() directly
> >> is problematic if _TMP triggers Notify () on the thermal zone for
> >> which it has been evaluated (which happens on some systems), because
> >> it causes a new acpi_thermal_notify() invocation to be queued up
> >> every time and if that takes place too often, an indefinite number of
> >> pending work items may accumulate in kacpi_notify_wq over time.
> >>
> >> Besides, it is not really useful to queue up a new invocation of
> >> acpi_thermal_check() if one of them is pending already.
> >>
> >> For these reasons, rework acpi_thermal_notify() to queue up a thermal
> >> check instead of calling acpi_thermal_check() directly and only allow
> >> one thermal check to be pending at a time.  Moreover, only allow one
> >> acpi_thermal_check_fn() instance at a time to run
> >> thermal_zone_device_update() for one thermal zone and make it return
> >> early if it sees other instances running for the same thermal zone.
> >>
> >> While at it, fold acpi_thermal_check() into acpi_thermal_check_fn(),
> >> as it is only called from there after the other changes made here.
> >>
> >> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208877
> >> Reported-by: Stephen Berman <stephen.berman@gmx.net>
> >> Diagnosed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Well, it's been over a week since this was posted.
> >
> > Does anyone have any comments?
>
> Sorry, I haven't been able to make time to test the patch yet, but I'll
> try to do so this weekend.  Is it just the patch below that I should
> apply, ignoring the previous patches you sent?

Yes.

> And can I apply it to the current mainline kernel?

Yes, it should be applicable to the current mainline (at least as of 5.11-rc4).

Thanks!

> >> ---
> >>  drivers/acpi/thermal.c |   46 +++++++++++++++++++++++++++++++++-------------
> >>  1 file changed, 33 insertions(+), 13 deletions(-)
> >>
> >> Index: linux-pm/drivers/acpi/thermal.c
> >> ===================================================================
> >> --- linux-pm.orig/drivers/acpi/thermal.c
> >> +++ linux-pm/drivers/acpi/thermal.c
> >> @@ -174,6 +174,8 @@ struct acpi_thermal {
> >>         struct thermal_zone_device *thermal_zone;
> >>         int kelvin_offset;      /* in millidegrees */
> >>         struct work_struct thermal_check_work;
> >> +       struct mutex thermal_check_lock;
> >> +       refcount_t thermal_check_count;
> >>  };
> >>
> >>  /* --------------------------------------------------------------------------
> >> @@ -495,14 +497,6 @@ static int acpi_thermal_get_trip_points(
> >>         return 0;
> >>  }
> >>
> >> -static void acpi_thermal_check(void *data)
> >> -{
> >> -       struct acpi_thermal *tz = data;
> >> -
> >> -       thermal_zone_device_update(tz->thermal_zone,
> >> -                                  THERMAL_EVENT_UNSPECIFIED);
> >> -}
> >> -
> >>  /* sys I/F for generic thermal sysfs support */
> >>
> >>  static int thermal_get_temp(struct thermal_zone_device *thermal, int *temp)
> >> @@ -900,6 +894,12 @@ static void acpi_thermal_unregister_ther
> >>                                   Driver Interface
> >>     -------------------------------------------------------------------------- */
> >>
> >> +static void acpi_queue_thermal_check(struct acpi_thermal *tz)
> >> +{
> >> +       if (!work_pending(&tz->thermal_check_work))
> >> +               queue_work(acpi_thermal_pm_queue, &tz->thermal_check_work);
> >> +}
> >> +
> >>  static void acpi_thermal_notify(struct acpi_device *device, u32 event)
> >>  {
> >>         struct acpi_thermal *tz = acpi_driver_data(device);
> >> @@ -910,17 +910,17 @@ static void acpi_thermal_notify(struct a
> >>
> >>         switch (event) {
> >>         case ACPI_THERMAL_NOTIFY_TEMPERATURE:
> >> -               acpi_thermal_check(tz);
> >> +               acpi_queue_thermal_check(tz);
> >>                 break;
> >>         case ACPI_THERMAL_NOTIFY_THRESHOLDS:
> >>                 acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_THRESHOLDS);
> >> -               acpi_thermal_check(tz);
> >> +               acpi_queue_thermal_check(tz);
> >>                 acpi_bus_generate_netlink_event(device->pnp.device_class,
> >>                                                   dev_name(&device->dev), event, 0);
> >>                 break;
> >>         case ACPI_THERMAL_NOTIFY_DEVICES:
> >>                 acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_DEVICES);
> >> -               acpi_thermal_check(tz);
> >> +               acpi_queue_thermal_check(tz);
> >>                 acpi_bus_generate_netlink_event(device->pnp.device_class,
> >>                                                   dev_name(&device->dev), event, 0);
> >>                 break;
> >> @@ -1020,7 +1020,25 @@ static void acpi_thermal_check_fn(struct
> >>  {
> >>         struct acpi_thermal *tz = container_of(work, struct acpi_thermal,
> >>                                                thermal_check_work);
> >> -       acpi_thermal_check(tz);
> >> +
> >> +       /*
> >> +        * In general, it is not sufficient to check the pending bit, because
> >> +        * subsequent instances of this function may be queued after one of them
> >> +        * has started running (e.g. if _TMP sleeps).  Avoid bailing out if just
> >> +        * one of them is running, though, because it may have done the actual
> >> +        * check some time ago, so allow at least one of them to block on the
> >> +        * mutex while another one is running the update.
> >> +        */
> >> +       if (!refcount_dec_not_one(&tz->thermal_check_count))
> >> +               return;
> >> +
> >> +       mutex_lock(&tz->thermal_check_lock);
> >> +
> >> +       thermal_zone_device_update(tz->thermal_zone, THERMAL_EVENT_UNSPECIFIED);
> >> +
> >> +       refcount_inc(&tz->thermal_check_count);
> >> +
> >> +       mutex_unlock(&tz->thermal_check_lock);
> >>  }
> >>
> >>  static int acpi_thermal_add(struct acpi_device *device)
> >> @@ -1052,6 +1070,8 @@ static int acpi_thermal_add(struct acpi_
> >>         if (result)
> >>                 goto free_memory;
> >>
> >> +       refcount_set(&tz->thermal_check_count, 3);
> >> +       mutex_init(&tz->thermal_check_lock);
> >>         INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
> >>
> >>         pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
> >> @@ -1117,7 +1137,7 @@ static int acpi_thermal_resume(struct de
> >>                 tz->state.active |= tz->trips.active[i].flags.enabled;
> >>         }
> >>
> >> -       queue_work(acpi_thermal_pm_queue, &tz->thermal_check_work);
> >> +       acpi_queue_thermal_check(tz);
> >>
> >>         return AE_OK;
> >>  }
> >>
> >>
> >>
