Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A1687992
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2019 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfHIMPR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Aug 2019 08:15:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42570 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIMPR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Aug 2019 08:15:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so131744057otn.9;
        Fri, 09 Aug 2019 05:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPhQEfpz2L9VudZCV93fBfsiwCxuI7FC2IEWQ3k3cwk=;
        b=bu9o1lxop2dB53R9PaxhTZb0axc1le/joJNESDWnIh+/6kOvvya3BVVtT9xjy8/7LS
         lKe3qmqO7kCy5YMkYDx0UPICb+Y27//RuWt3ww8LuydVGdwi3zXbKuojrfalmVaS5opP
         dvBxkt/hn1a+A27ChN/G1g43wKA5xa4TBxRbL9CymNXE9X2CyOeW2kptbjqwJXPTLIo3
         GTdCHiIbobI3xKt4FwVWyGmAkeJEpw9MuVzDI6R0zBhMsH8Wbszl3Z0RE+2J6Px66r3j
         79w8892bMoThOw8pEvzTw3MIVgj9/GRmCGb9uXfzh6Njyg1q1gwnuWbNWmpvLDkhegpK
         0YyA==
X-Gm-Message-State: APjAAAXNX4MeOr+QZRjCr4E2uMsihkSKokDnK3zP9Lts/Zefi4Ib/SGD
        o2Wd8fYFRLKTU5p1O93HZXMbscK7f/QTCOWwRXI=
X-Google-Smtp-Source: APXvYqxNJ013eLC09yGsgapHlLqfUe7REnVobb2QQ0Zm5fWHeXii/Qw7Uj++14PuKNVdHPErOsjLrF24st3nrgHmFx4=
X-Received: by 2002:aca:d907:: with SMTP id q7mr5752039oig.68.1565352915951;
 Fri, 09 Aug 2019 05:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <5997740.FPbUVk04hV@kreacher> <CGME20190809120052eucas1p11b56806662ef4f4efb82a152ad651481@eucas1p1.samsung.com>
 <74514118.QN1Ey1fWSL@kreacher> <1b181f35-29c3-c6ce-6c42-ae55e890579e@samsung.com>
In-Reply-To: <1b181f35-29c3-c6ce-6c42-ae55e890579e@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Aug 2019 14:15:04 +0200
Message-ID: <CAJZ5v0h_Bem4U46tgJyE7k+uHFN7viqUo10Vgh+UWZf_C1qD2g@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] ACPI: PM: s2idle: Execute LPS0 _DSM functions with
 suspended devices
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 9, 2019 at 2:00 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Rafael,
>
> On 2019-08-02 12:45, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > According to Section 3.5 of the "Intel Low Power S0 Idle" document [1],
> > Function 5 of the LPS0 _DSM is expected to be invoked when the system
> > configuration matches the criteria for entering the target low-power
> > state of the platform.  In particular, this means that all devices
> > should be suspended and in low-power states already when that function
> > is invoked.
> >
> > This is not the case currently, however, because Function 5 of the
> > LPS0 _DSM is invoked by it before the "noirq" phase of device suspend,
> > which means that some devices may not have been put into low-power
> > states yet at that point.  That is a consequence of the previous
> > design of the suspend-to-idle flow that allowed the "noirq" phase of
> > device suspend and the "noirq" phase of device resume to be carried
> > out for multiple times while "suspended" (if any spurious wakeup
> > events were detected) and the point of the LPS0 _DSM Function 5
> > invocation was chosen so as to call it (and LPS0 _DSM Function 6
> > analogously) once per suspend-resume cycle (regardless of how many
> > times the "noirq" phases of device suspend and resume were carried
> > out while "suspended").
> >
> > Now that the suspend-to-idle flow has been redesigned to carry out
> > the "noirq" phases of device suspend and resume once in each cycle,
> > the code can be reordered to follow the specification that it is
> > based on more closely.
> >
> > For this purpose, add ->prepare_late and ->restore_early platform
> > callbacks for suspend-to-idle, to be executed, respectively, after
> > the "noirq" phase of suspending devices and before the "noirq"
> > phase of resuming them and make ACPI use them for the invocation
> > of LPS0 _DSM functions as appropriate.
> >
> > While at it, move the LPS0 entry requirements check to be made
> > before invoking Functions 3 and 5 of the LPS0 _DSM (also once
> > per cycle) as follows from the specification [1].
> >
> > Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf # [1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > In v2 this was patch 2.
> >
> > ---
> >   drivers/acpi/sleep.c    |   36 ++++++++++++++++++++++++------------
> >   include/linux/suspend.h |    2 ++
> >   kernel/power/suspend.c  |   12 +++++++++---
> >   3 files changed, 35 insertions(+), 15 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/sleep.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/sleep.c
> > +++ linux-pm/drivers/acpi/sleep.c
> > @@ -954,11 +954,6 @@ static int acpi_s2idle_begin(void)
> >
> >   static int acpi_s2idle_prepare(void)
> >   {
> > -     if (lps0_device_handle && !sleep_no_lps0) {
> > -             acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> > -             acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> > -     }
> > -
> >       if (acpi_sci_irq_valid())
> >               enable_irq_wake(acpi_sci_irq);
> >
> > @@ -972,11 +967,22 @@ static int acpi_s2idle_prepare(void)
> >       return 0;
> >   }
> >
> > -static void acpi_s2idle_wake(void)
> > +static int acpi_s2idle_prepare_late(void)
> >   {
> > -     if (lps0_device_handle && !sleep_no_lps0 && pm_debug_messages_on)
> > +     if (!lps0_device_handle || sleep_no_lps0)
> > +             return 0;
> > +
> > +     if (pm_debug_messages_on)
> >               lpi_check_constraints();
> >
> > +     acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> > +     acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> > +
> > +     return 0;
> > +}
> > +
> > +static void acpi_s2idle_wake(void)
> > +{
> >       /*
> >        * If IRQD_WAKEUP_ARMED is set for the SCI at this point, the SCI has
> >        * not triggered while suspended, so bail out.
> > @@ -1011,6 +1017,15 @@ static void acpi_s2idle_wake(void)
> >       rearm_wake_irq(acpi_sci_irq);
> >   }
> >
> > +static void acpi_s2idle_restore_early(void)
> > +{
> > +     if (!lps0_device_handle || sleep_no_lps0)
> > +             return;
> > +
> > +     acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> > +     acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
> > +}
> > +
> >   static void acpi_s2idle_restore(void)
> >   {
> >       s2idle_wakeup = false;
> > @@ -1021,11 +1036,6 @@ static void acpi_s2idle_restore(void)
> >
> >       if (acpi_sci_irq_valid())
> >               disable_irq_wake(acpi_sci_irq);
> > -
> > -     if (lps0_device_handle && !sleep_no_lps0) {
> > -             acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> > -             acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
> > -     }
> >   }
> >
> >   static void acpi_s2idle_end(void)
> > @@ -1036,7 +1046,9 @@ static void acpi_s2idle_end(void)
> >   static const struct platform_s2idle_ops acpi_s2idle_ops = {
> >       .begin = acpi_s2idle_begin,
> >       .prepare = acpi_s2idle_prepare,
> > +     .prepare_late = acpi_s2idle_prepare_late,
> >       .wake = acpi_s2idle_wake,
> > +     .restore_early = acpi_s2idle_restore_early,
> >       .restore = acpi_s2idle_restore,
> >       .end = acpi_s2idle_end,
> >   };
> > Index: linux-pm/kernel/power/suspend.c
> > ===================================================================
> > --- linux-pm.orig/kernel/power/suspend.c
> > +++ linux-pm/kernel/power/suspend.c
> > @@ -253,13 +253,19 @@ static int platform_suspend_prepare_late
> >
> >   static int platform_suspend_prepare_noirq(suspend_state_t state)
> >   {
> > -     return state != PM_SUSPEND_TO_IDLE && suspend_ops->prepare_late ?
> > -             suspend_ops->prepare_late() : 0;
> > +     if (state == PM_SUSPEND_TO_IDLE) {
> > +             if (s2idle_ops && s2idle_ops->prepare_late)
> > +                     return s2idle_ops->prepare_late();

This should be

return s2idle_ops && s2idle_ops->prepare_late ? s2idle_ops->prepare_late() : 0;

> > +     }
> > +     return suspend_ops->prepare_late ? suspend_ops->prepare_late() : 0;
>
> This unconditionally references suspend_ops here, what wasn't done
> earlier. On one of my test boards (OdroidXU) it causes following NULL
> pointer dereference since Linux next-20190809 (the first -next, which
> contains this patch):

Sorry about this, will fix early next week.
