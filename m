Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF833008FD
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 17:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbhAVQrZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 11:47:25 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45057 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbhAVQY2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 11:24:28 -0500
Received: by mail-ot1-f50.google.com with SMTP id n42so5564826ota.12;
        Fri, 22 Jan 2021 08:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPqbjGqOCOoSzZRxoAwaj2hPNXhZmenfwoDHfGglI+Q=;
        b=LSbA68bTu6zq0a1WkO8+H8rD4vAiU0t00y5sYXzIil7f+CF4ZOQiOQfpC64XVmRTpf
         ttL0fxVc1XIVoU01aENBM0zBnYl+qhrrQQd6F9nlR7ANMjGYwjpElSEe8+sM4szZgSba
         S6xMsFkcyECSjqzJJGuTkcufUdej2cjMJo7Caw8i74sWGZb9WcERu/S+R4AoQYPoVmGd
         ucdE8L430eLuoefysSESQEYq7ms42g//wun3bWKDrncSBn/ImqXZcsjUmJ8sjoioBi5H
         DC4lWeYriBHL21JlujkObpZmvw6lJcZjnIxpc8y6FUitPsTIR1j1JU8ruS7AeGznx2FZ
         oFJw==
X-Gm-Message-State: AOAM5323QeiBI707CPacAkO651OQjxQKRhigsLVPcZnIu5XINFHcq5Mp
        7eQv9P02sqxsarlbhfOFATpEOz43kv+47AZrwLNCfHWU
X-Google-Smtp-Source: ABdhPJzGj7ZposAvStHiEOSFy/Ek2R7PveNB03N14lwckMK/Q5s5uAoFQ0udt+0ayKG7CJ9EIVib8tKPWaXHXs/ZtDg=
X-Received: by 2002:a05:6830:2313:: with SMTP id u19mr712384ote.321.1611332627100;
 Fri, 22 Jan 2021 08:23:47 -0800 (PST)
MIME-Version: 1.0
References: <3391226.KRKnzuvfpg@kreacher>
In-Reply-To: <3391226.KRKnzuvfpg@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 17:23:36 +0100
Message-ID: <CAJZ5v0gB4B_Os0VQv-F2SdVcJ8_rUdjic6rOEjOd=ZWhGzdLdQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal: Do not call acpi_thermal_check() directly
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Berman <stephen.berman@gmx.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 14, 2021 at 7:35 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Calling acpi_thermal_check() from acpi_thermal_notify() directly
> is problematic if _TMP triggers Notify () on the thermal zone for
> which it has been evaluated (which happens on some systems), because
> it causes a new acpi_thermal_notify() invocation to be queued up
> every time and if that takes place too often, an indefinite number of
> pending work items may accumulate in kacpi_notify_wq over time.
>
> Besides, it is not really useful to queue up a new invocation of
> acpi_thermal_check() if one of them is pending already.
>
> For these reasons, rework acpi_thermal_notify() to queue up a thermal
> check instead of calling acpi_thermal_check() directly and only allow
> one thermal check to be pending at a time.  Moreover, only allow one
> acpi_thermal_check_fn() instance at a time to run
> thermal_zone_device_update() for one thermal zone and make it return
> early if it sees other instances running for the same thermal zone.
>
> While at it, fold acpi_thermal_check() into acpi_thermal_check_fn(),
> as it is only called from there after the other changes made here.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208877
> Reported-by: Stephen Berman <stephen.berman@gmx.net>
> Diagnosed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Well, it's been over a week since this was posted.

Does anyone have any comments?

> ---
>  drivers/acpi/thermal.c |   46 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 13 deletions(-)
>
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -174,6 +174,8 @@ struct acpi_thermal {
>         struct thermal_zone_device *thermal_zone;
>         int kelvin_offset;      /* in millidegrees */
>         struct work_struct thermal_check_work;
> +       struct mutex thermal_check_lock;
> +       refcount_t thermal_check_count;
>  };
>
>  /* --------------------------------------------------------------------------
> @@ -495,14 +497,6 @@ static int acpi_thermal_get_trip_points(
>         return 0;
>  }
>
> -static void acpi_thermal_check(void *data)
> -{
> -       struct acpi_thermal *tz = data;
> -
> -       thermal_zone_device_update(tz->thermal_zone,
> -                                  THERMAL_EVENT_UNSPECIFIED);
> -}
> -
>  /* sys I/F for generic thermal sysfs support */
>
>  static int thermal_get_temp(struct thermal_zone_device *thermal, int *temp)
> @@ -900,6 +894,12 @@ static void acpi_thermal_unregister_ther
>                                   Driver Interface
>     -------------------------------------------------------------------------- */
>
> +static void acpi_queue_thermal_check(struct acpi_thermal *tz)
> +{
> +       if (!work_pending(&tz->thermal_check_work))
> +               queue_work(acpi_thermal_pm_queue, &tz->thermal_check_work);
> +}
> +
>  static void acpi_thermal_notify(struct acpi_device *device, u32 event)
>  {
>         struct acpi_thermal *tz = acpi_driver_data(device);
> @@ -910,17 +910,17 @@ static void acpi_thermal_notify(struct a
>
>         switch (event) {
>         case ACPI_THERMAL_NOTIFY_TEMPERATURE:
> -               acpi_thermal_check(tz);
> +               acpi_queue_thermal_check(tz);
>                 break;
>         case ACPI_THERMAL_NOTIFY_THRESHOLDS:
>                 acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_THRESHOLDS);
> -               acpi_thermal_check(tz);
> +               acpi_queue_thermal_check(tz);
>                 acpi_bus_generate_netlink_event(device->pnp.device_class,
>                                                   dev_name(&device->dev), event, 0);
>                 break;
>         case ACPI_THERMAL_NOTIFY_DEVICES:
>                 acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_DEVICES);
> -               acpi_thermal_check(tz);
> +               acpi_queue_thermal_check(tz);
>                 acpi_bus_generate_netlink_event(device->pnp.device_class,
>                                                   dev_name(&device->dev), event, 0);
>                 break;
> @@ -1020,7 +1020,25 @@ static void acpi_thermal_check_fn(struct
>  {
>         struct acpi_thermal *tz = container_of(work, struct acpi_thermal,
>                                                thermal_check_work);
> -       acpi_thermal_check(tz);
> +
> +       /*
> +        * In general, it is not sufficient to check the pending bit, because
> +        * subsequent instances of this function may be queued after one of them
> +        * has started running (e.g. if _TMP sleeps).  Avoid bailing out if just
> +        * one of them is running, though, because it may have done the actual
> +        * check some time ago, so allow at least one of them to block on the
> +        * mutex while another one is running the update.
> +        */
> +       if (!refcount_dec_not_one(&tz->thermal_check_count))
> +               return;
> +
> +       mutex_lock(&tz->thermal_check_lock);
> +
> +       thermal_zone_device_update(tz->thermal_zone, THERMAL_EVENT_UNSPECIFIED);
> +
> +       refcount_inc(&tz->thermal_check_count);
> +
> +       mutex_unlock(&tz->thermal_check_lock);
>  }
>
>  static int acpi_thermal_add(struct acpi_device *device)
> @@ -1052,6 +1070,8 @@ static int acpi_thermal_add(struct acpi_
>         if (result)
>                 goto free_memory;
>
> +       refcount_set(&tz->thermal_check_count, 3);
> +       mutex_init(&tz->thermal_check_lock);
>         INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
>
>         pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
> @@ -1117,7 +1137,7 @@ static int acpi_thermal_resume(struct de
>                 tz->state.active |= tz->trips.active[i].flags.enabled;
>         }
>
> -       queue_work(acpi_thermal_pm_queue, &tz->thermal_check_work);
> +       acpi_queue_thermal_check(tz);
>
>         return AE_OK;
>  }
>
>
>
