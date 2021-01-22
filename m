Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0033008FC
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 17:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbhAVQqx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 11:46:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:44731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728600AbhAVQlD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Jan 2021 11:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611333554;
        bh=8JhrUSLQfP7dDQdOLnPL+t1Zayg5JlWEKlwDL/njyGU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=h2GcywzjkwCiyOPjDXV8DtU6HXE/wFBrrWqxPEE2Vm6dI6QWnb1NzCWXD9maqM9YR
         cqbvXg82mqclsu+GSAlsiUp4LyPjw8sCbHIDeUFIBXBY0ClDjjl2czLY4dRnCJldDF
         +/Kh6TQDAQPiWRIVtn5u3Ilju0lljhTt6nutMJf8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([84.61.247.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe9s-1lPRlH2gmU-00NfuR; Fri, 22
 Jan 2021 17:39:13 +0100
From:   Stephen Berman <stephen.berman@gmx.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] ACPI: thermal: Do not call acpi_thermal_check() directly
References: <3391226.KRKnzuvfpg@kreacher>
        <CAJZ5v0gB4B_Os0VQv-F2SdVcJ8_rUdjic6rOEjOd=ZWhGzdLdQ@mail.gmail.com>
Date:   Fri, 22 Jan 2021 17:39:11 +0100
In-Reply-To: <CAJZ5v0gB4B_Os0VQv-F2SdVcJ8_rUdjic6rOEjOd=ZWhGzdLdQ@mail.gmail.com>
        (Rafael J. Wysocki's message of "Fri, 22 Jan 2021 17:23:36 +0100")
Message-ID: <87tur9vscw.fsf@rub.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:vmPxUglWxqRNscgAb6ImLdo82Wms5ucH7ULN87au2PGI3z7OfKp
 vd5n6OZxO7CN3C/V/7rWnXHmiJ7H8MPuhmwTN+Tujt3TcpQO3JgVNftZeDYVyobIqsW9Ilb
 +EnP/HJs6BtfjKIHpWoLlKnuE4LQ5dTnYiSrnEn/AE94qGzgxJHCAzgzy4brbeG/FN5D/Df
 r70+lSLCEXLEGFaBrPsVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0U1G1Ig9BqE=:i0kqnIo59InULsWkrqZa6y
 2Grd4aOchoLSWRfEk6BHDHCAATQevV/g3Czbh7z7XG0CcqNf9Crlh2SC/63dleq7HiDwycX3L
 RVv0OXFbyPc5rJfZV4bx8k5wxak8biyP9hhv4KZVcisaR16dDU9F/x28F7GvltM3dMItUAENN
 kT3hyXcMvR3E4BdEOBpnZ1WzEhBFuX8ojUt+JLsvS1uO1BDlViHIr/hSYqqSP9CL89PDUCYuE
 lxF2t9ufmvG8ZGR7D/v/oI5TchlOPHMcgxWxCCMxKgCdZ6xhksCxumXDjXzR3FznWQ3tVS08b
 bPMtHfKd/qwATVW7zlqV6s6xHeJvVtGFpSYLgUIBgiHrkKMckvATnOAvxyWZunOrEBKiInBE+
 PUrQfRccdJyVLUuvH2S5/thl6p/IoYYepzhcAeKsXlPkr0cMhzozwX0EmHYgxCyfLTypz50SS
 H2yRFYVsDhNhUwzlobK83Pv9e9CxWGTgJkmkCnvARAotp2k6/4PEnjNobLQgt4WybUhWIFwZo
 4BxNVjKsGpvpdustXUmDTOyL+oenUeoiN5DBJNUHfLyH9M9vRTgVHGysCK5qhjXLzM+28K3tN
 5EvQf2GRG9QjhAdEuBv2UJfpMpZ62uKhGRzPP/Hn3CIIsz3xRFwzsYJ0C8I9GjAU9fqjpE6yB
 xZjWBHjxdIdL380xiBAywoclLV7aBM2wiM6in79DGxu625Yme65cSl13x9ADTdMPixtKvnwxr
 GPmHQeR93DVUxu9D+wSe/qRVVmCyUxm1vkQ+PArXLmsvr2Bm4cqHupP1+JVgqLF9Twchdz/H8
 4sqTXSy96HR1krW8zZvL28DaCAzHGlcDPsyRUSzdtdaO59k+1EQb/ESAveZaRQLTX4s8Sprdv
 GgK4GRCyO7H+mtCRzsGg==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 22 Jan 2021 17:23:36 +0100 "Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Thu, Jan 14, 2021 at 7:35 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Calling acpi_thermal_check() from acpi_thermal_notify() directly
>> is problematic if _TMP triggers Notify () on the thermal zone for
>> which it has been evaluated (which happens on some systems), because
>> it causes a new acpi_thermal_notify() invocation to be queued up
>> every time and if that takes place too often, an indefinite number of
>> pending work items may accumulate in kacpi_notify_wq over time.
>>
>> Besides, it is not really useful to queue up a new invocation of
>> acpi_thermal_check() if one of them is pending already.
>>
>> For these reasons, rework acpi_thermal_notify() to queue up a thermal
>> check instead of calling acpi_thermal_check() directly and only allow
>> one thermal check to be pending at a time.  Moreover, only allow one
>> acpi_thermal_check_fn() instance at a time to run
>> thermal_zone_device_update() for one thermal zone and make it return
>> early if it sees other instances running for the same thermal zone.
>>
>> While at it, fold acpi_thermal_check() into acpi_thermal_check_fn(),
>> as it is only called from there after the other changes made here.
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208877
>> Reported-by: Stephen Berman <stephen.berman@gmx.net>
>> Diagnosed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Well, it's been over a week since this was posted.
>
> Does anyone have any comments?

Sorry, I haven't been able to make time to test the patch yet, but I'll
try to do so this weekend.  Is it just the patch below that I should
apply, ignoring the previous patches you sent?  And can I apply it to
the current mainline kernel?

Thanks,
Steve Berman

>> ---
>>  drivers/acpi/thermal.c |   46 +++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 33 insertions(+), 13 deletions(-)
>>
>> Index: linux-pm/drivers/acpi/thermal.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/thermal.c
>> +++ linux-pm/drivers/acpi/thermal.c
>> @@ -174,6 +174,8 @@ struct acpi_thermal {
>>         struct thermal_zone_device *thermal_zone;
>>         int kelvin_offset;      /* in millidegrees */
>>         struct work_struct thermal_check_work;
>> +       struct mutex thermal_check_lock;
>> +       refcount_t thermal_check_count;
>>  };
>>
>>  /* --------------------------------------------------------------------------
>> @@ -495,14 +497,6 @@ static int acpi_thermal_get_trip_points(
>>         return 0;
>>  }
>>
>> -static void acpi_thermal_check(void *data)
>> -{
>> -       struct acpi_thermal *tz = data;
>> -
>> -       thermal_zone_device_update(tz->thermal_zone,
>> -                                  THERMAL_EVENT_UNSPECIFIED);
>> -}
>> -
>>  /* sys I/F for generic thermal sysfs support */
>>
>>  static int thermal_get_temp(struct thermal_zone_device *thermal, int *temp)
>> @@ -900,6 +894,12 @@ static void acpi_thermal_unregister_ther
>>                                   Driver Interface
>>     -------------------------------------------------------------------------- */
>>
>> +static void acpi_queue_thermal_check(struct acpi_thermal *tz)
>> +{
>> +       if (!work_pending(&tz->thermal_check_work))
>> +               queue_work(acpi_thermal_pm_queue, &tz->thermal_check_work);
>> +}
>> +
>>  static void acpi_thermal_notify(struct acpi_device *device, u32 event)
>>  {
>>         struct acpi_thermal *tz = acpi_driver_data(device);
>> @@ -910,17 +910,17 @@ static void acpi_thermal_notify(struct a
>>
>>         switch (event) {
>>         case ACPI_THERMAL_NOTIFY_TEMPERATURE:
>> -               acpi_thermal_check(tz);
>> +               acpi_queue_thermal_check(tz);
>>                 break;
>>         case ACPI_THERMAL_NOTIFY_THRESHOLDS:
>>                 acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_THRESHOLDS);
>> -               acpi_thermal_check(tz);
>> +               acpi_queue_thermal_check(tz);
>>                 acpi_bus_generate_netlink_event(device->pnp.device_class,
>>                                                   dev_name(&device->dev), event, 0);
>>                 break;
>>         case ACPI_THERMAL_NOTIFY_DEVICES:
>>                 acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_DEVICES);
>> -               acpi_thermal_check(tz);
>> +               acpi_queue_thermal_check(tz);
>>                 acpi_bus_generate_netlink_event(device->pnp.device_class,
>>                                                   dev_name(&device->dev), event, 0);
>>                 break;
>> @@ -1020,7 +1020,25 @@ static void acpi_thermal_check_fn(struct
>>  {
>>         struct acpi_thermal *tz = container_of(work, struct acpi_thermal,
>>                                                thermal_check_work);
>> -       acpi_thermal_check(tz);
>> +
>> +       /*
>> +        * In general, it is not sufficient to check the pending bit, because
>> +        * subsequent instances of this function may be queued after one of them
>> +        * has started running (e.g. if _TMP sleeps).  Avoid bailing out if just
>> +        * one of them is running, though, because it may have done the actual
>> +        * check some time ago, so allow at least one of them to block on the
>> +        * mutex while another one is running the update.
>> +        */
>> +       if (!refcount_dec_not_one(&tz->thermal_check_count))
>> +               return;
>> +
>> +       mutex_lock(&tz->thermal_check_lock);
>> +
>> +       thermal_zone_device_update(tz->thermal_zone, THERMAL_EVENT_UNSPECIFIED);
>> +
>> +       refcount_inc(&tz->thermal_check_count);
>> +
>> +       mutex_unlock(&tz->thermal_check_lock);
>>  }
>>
>>  static int acpi_thermal_add(struct acpi_device *device)
>> @@ -1052,6 +1070,8 @@ static int acpi_thermal_add(struct acpi_
>>         if (result)
>>                 goto free_memory;
>>
>> +       refcount_set(&tz->thermal_check_count, 3);
>> +       mutex_init(&tz->thermal_check_lock);
>>         INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
>>
>>         pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
>> @@ -1117,7 +1137,7 @@ static int acpi_thermal_resume(struct de
>>                 tz->state.active |= tz->trips.active[i].flags.enabled;
>>         }
>>
>> -       queue_work(acpi_thermal_pm_queue, &tz->thermal_check_work);
>> +       acpi_queue_thermal_check(tz);
>>
>>         return AE_OK;
>>  }
>>
>>
>>
