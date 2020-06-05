Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEA51EFF92
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jun 2020 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgFESCF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jun 2020 14:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgFESCF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jun 2020 14:02:05 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B074C08C5C3
        for <linux-acpi@vger.kernel.org>; Fri,  5 Jun 2020 11:02:05 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y17so4010813plb.8
        for <linux-acpi@vger.kernel.org>; Fri, 05 Jun 2020 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHvqFJ8oCcu50e+zYBwkicGtXHwb2WQMqQiqUSCHqLM=;
        b=lrLHiQpwrf3PSMg0+BYQkXEEFNO8TIAgOHdxf3VJP8Y7tqyWo6tsUDc0dqusobqRF4
         7bs1I5NhcgtPDdgOFWoBiCTIfz2A0TyAjtktSJCsHdSEuImxvJFfiruh5PxXricNXJ1K
         oIEyNoJYBqpjou5qSJMFi/BjGGW18QVKvOc60BFFpfPjcfql46+LG0LYwGzlM3ry+tMM
         5kYWQNIdNbrBEWTEJE2+F/xU2b1TWP4DgaK5ZcaRoUog5QJt2MBkuf2WmxZLcOgHEGk2
         wvBdswWjUkPa5JhmNiDmcWdCQBL8A1+GfPd515riCZao4TZU5yfnLEpxUDUbZ8R1j7dO
         9LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHvqFJ8oCcu50e+zYBwkicGtXHwb2WQMqQiqUSCHqLM=;
        b=QeMaocskK5ft7qTA+3RBwe0cQOLOiR86T6weTA4nAfw+MIWTLWyYP12vs3g2gryPxD
         qk+rrk/HYj+c/T166rNnE8KRGG2xsIWQWQIOyeOKaPd7wHebZ75M+4L0npY9qCkgz9Gv
         K7Ln3EnULqGpwrno/0+mt4vhvm8jjn2Xo9UOX1vCIS+BvVfgXAeUeqckHcXOxvIiecfj
         vPY5QPiBAqfFOloMDPKGad9/vD3upCNpyf5PnmlNfggoWQQ37YCyBj5XVdVm5H0HiULn
         yjRoYWDk2WId2KWmq/L1c+r9yP9Azel6qDO/KWeVWUcYKrtyA7x88Sym9/pgiW+PRz2K
         EhKQ==
X-Gm-Message-State: AOAM5335OxagXXg/ZC5CVN7PjoZzLzE9VFUxIUN4m1dURRyrE1onVpa0
        FmfBXKBSM4V/Nfd3AglUaGfIdnsbD8lyFmPuIzAYTg==
X-Google-Smtp-Source: ABdhPJzc0mV2oziH4qGkpO5HC1UUDuJQsq6zz1Mj5V4/F/xYGsYIIdQgPNHbGtJnaWfjtaNY6UGENHHwjf5vXw6oKnQ=
X-Received: by 2002:a17:90a:34cc:: with SMTP id m12mr4415124pjf.123.1591380124156;
 Fri, 05 Jun 2020 11:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200604195658.66201-1-mathewk@chromium.org> <CAJZ5v0iteOV=4CnQrVx5ZmnWq5Uf88k7UMMmKcMxgJnco3kxvg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iteOV=4CnQrVx5ZmnWq5Uf88k7UMMmKcMxgJnco3kxvg@mail.gmail.com>
From:   Mat King <mathewk@google.com>
Date:   Fri, 5 Jun 2020 12:01:52 -0600
Message-ID: <CAL_quvQRT+3wnxO9NsqHG+UcJiCc5aucN4a7V0mpMy2MxoX+ng@mail.gmail.com>
Subject: Re: [PATCH] acpi: battery: Always read fresh battery state on update
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mathew King <mathewk@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 5, 2020 at 5:30 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jun 4, 2020 at 9:57 PM Mathew King <mathewk@chromium.org> wrote:
> >
> > When the ACPI battery receives a notification event it should always
> > read the battery state fresh from the ACPI device and not use the cached
> > state.
>
> Why should it?

According to the ACPI Spec 10.2.1 Battery Events, "When the present
state of the battery has changed or when the trip point set by the
_BTP control method is reached or crossed, the hardware will assert a
general purpose event." So when this event is received we should
assume that the cached state of the battery is no longer valid

>
> > Currently the cached state stays valid and the new state may not
> > be read when a notification occurs. This can lead to a udev event
> > showing that the battery has changed but the sysfs state will still have
> > the cached state values.
>
> Is there a bug entry or similar related to that which can be referred
> to from this patch?

No, I discovered this issue while working on an internal issue where
it was observed that udev events generated when a battery changed did
not accurately reflect the state of the battery. I initially suspected
that the EC may not be updating its state before generating the ACPI
event, however after much debugging I discovered that the battery
driver was caching the state and the state is not always immediately
updated when the event is received. If there is a more formal process
to discuss the issue I will work through that process.

>
> > This change invalidates the update time forcing
> > the state to be updated before notifying the power_supply subsystem of
> > the change.
> >
> > Signed-off-by: Mathew King <mathewk@chromium.org>
> > ---
> >  drivers/acpi/battery.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index 366c389175d8..ab7fa4879fbe 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -981,6 +981,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
> >                 acpi_battery_init_alarm(battery);
> >         }
> >
> > +       battery->update_time = 0;
>
> AFAICS this is equivalent to dropping battery->update_time altogether.
> Isn't that a bit too excessive?

It is not the same as dropping the update_time. The cached state is
still used when acpi_battery_get_property() is called which happens
anytime userspace accesses the sysfs properties it is also what is
called by the power_supply subsystem when creating the environment for
the udev events. In those cases the cache still works and makes sense.
The acpi_battery_update() function is only called in a handful of
cases and in all of these cases reading the battery state fresh makes
sense to me. Those cases are:

1. When the battery is added with acpi_battery_add(), this case the
update_time is already cleared
2. On system resume with acpi_battery_resume(), in this case
update_time is cleared before calling acpi_battery_update() so that
static battery info is also updated by calling acpi_battery_get_info()
3. The acpi_battery_update() is called from procfs power functions
which should not be called a frequency where reading fresh battery
state from ACPI will have a performance impact
4. Finally it is called from acpi_battery_notify() when a battery
event is received from firmware that the state has changed

I considered clearing the update_time in acpi_battery_notify() before
acpi_battery_update() is called but if I did that by itself then
acpi_battery_get_info() would also get called and I wasn't sure that
behavior would be wanted. So invalidating the cache where I did seemed
to be the least disruptive way to fix the problem. I can see
opportunities to refactor this driver and I felt that this fix was
acceptable until a refactor could be done.

>
> >         result = acpi_battery_get_state(battery);
> >         if (result)
> >                 return result;
> > --
