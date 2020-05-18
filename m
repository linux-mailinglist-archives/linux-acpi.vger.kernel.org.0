Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8801D7648
	for <lists+linux-acpi@lfdr.de>; Mon, 18 May 2020 13:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgERLLz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 May 2020 07:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgERLLy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 May 2020 07:11:54 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2621DC05BD0A
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2020 04:11:53 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a68so7654226otb.10
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2020 04:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnW/FS5/y4iqPUCTNlQB9p3cf5TdTtltAqzqXbWyNfI=;
        b=SiF13+OdH5oD2MsnF+14BeV0juhIGdHZwlgf9ugvpGzlkis+pc2aPv+YZhWio19ltD
         1yYWHnvgi3l+QyHS+EEtuAvZezYgiTxH4nfAuK8o9vQqfz/RJLBu7R/P93N0N1EU6j3G
         XX+zjrmZ8JIoQoXFWUCwtt86X2HyO+NpbkLrZYXKZiPQuU/NmiZveSsYEPi6GWVhIoYk
         VvUgj3kcYR8dVVy6wjmLhHza8TVKI3hhiZJLeCG6eq4C45K0QLrxPBo5DltmQtRsYWPK
         +8rhSmFQDmQBnjGfsBnbmqaJuXHRhiu2ASH6VXl3Xc4jMxEoAzihAzS5LakL7MrUsSMl
         7drA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnW/FS5/y4iqPUCTNlQB9p3cf5TdTtltAqzqXbWyNfI=;
        b=tglFLtHnSoR2nzMWfWq8kKACxNOhntTVzXwqxrcMHl9VtywiDeGe4iaMWw/GAfjOKg
         sB60NxEvmYXmdGwnOEW69z0NK0NuLyPS5v+fGg5JnSl90o521BEwmVA0BzgvY8ZIlkun
         H6ufdQsJqWzjW+0KLQjUm9OMZP5sG+2gToxe/h6L6gnMV2iBjKi5Tvsk4X69pQLtzn8f
         IU9VvlV9EO0qoJdx+o9wW9GMfg9+BWe//gVpanQPqKYwhc+sp0SOCbfckr+363OW45aG
         FnSkUx0CZKtUNOAMXFGKObyO2z5t69Ww0O1xhyxJQjE0T3q/TgJyU+uR4+JJ1XpSNwYF
         6/XQ==
X-Gm-Message-State: AOAM532HVhyrto33WsGeQui4sFAvhPdMMtNDrz/NLIpiMn9oisHbnjGV
        k+6gSQ4nY1gGhTsc5ZxfcZ7sOlcdYXsFes86Xz4t1g==
X-Google-Smtp-Source: ABdhPJzWvG5+/mZbntvuQZrcmj5uN3TMQ1/8ZTeXO22o5c3VJZ54RceNb3EEyK68Aqyy1pe6SVztkskLFqAxY3YK/dI=
X-Received: by 2002:a9d:6ac9:: with SMTP id m9mr12024444otq.33.1589800312261;
 Mon, 18 May 2020 04:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <4502272.pByIgeXik9@kreacher> <CAJZ5v0j6S+we7tHeV9TM30LS+TO3zWigACe0ZUFfWphg2FBBZQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j6S+we7tHeV9TM30LS+TO3zWigACe0ZUFfWphg2FBBZQ@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 18 May 2020 19:11:41 +0800
Message-ID: <CAB4CAwc4y7xitv9L9w61GKfBsbhHXuk+iM+QWKc2=0mks_fNFg@mail.gmail.com>
Subject: Re: [PATCH[RFT]] ACPI: EC: s2idle: Avoid flushing EC work when EC GPE
 is inactive
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 18, 2020 at 4:59 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, May 14, 2020 at 12:10 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Flushing the EC work while suspended to idle when the EC GPE status
> > is not set causes some EC wakeup events (notably power button and
> > lid ones) to be missed after a series of spurious wakeups on the Dell
> > XPS13 9360 in my office.
> >
> > If that happens, the machine cannot be woken up from suspend-to-idle
> > by a power button press or lid status change and it needs to be woken
> > up in some other way (eg. by a key press).
> >
> > Flushing the EC work only after successful dispatching the EC GPE,
> > which means that its status has been set, avoids the issue, so change
> > the code in question accordingly.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Hi Chris,
> >
> > Please check if the key press wakeup still works on your system with this patch
> > applied (on top of https://patchwork.kernel.org/patch/11538065/).
>
> Hi Chris,
>
> Since I haven't heard back from you and the problem at hand is a
> regression on the machine where it happens, I'm going to push this
> patch for merging.
>
> If it causes the key press wakeup issue to reappear on your machine,
> I'm afraid that we'll need to quirk it in the EC driver.
>
> Thanks!

Hi Rafael,
My laptop works w/o problem waking up from a keystroke with this patch
on top of https://patchwork.kernel.org/patch/11538065/).

Chris
>
> > ---
> >  drivers/acpi/ec.c    |    6 +++++-
> >  drivers/acpi/sleep.c |   15 ++++-----------
> >  2 files changed, 9 insertions(+), 12 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/ec.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/ec.c
> > +++ linux-pm/drivers/acpi/ec.c
> > @@ -2020,9 +2020,13 @@ bool acpi_ec_dispatch_gpe(void)
> >          * to allow the caller to process events properly after that.
> >          */
> >         ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
> > -       if (ret == ACPI_INTERRUPT_HANDLED)
> > +       if (ret == ACPI_INTERRUPT_HANDLED) {
> >                 pm_pr_dbg("EC GPE dispatched\n");
> >
> > +               /* Flush the event and query workqueues. */
> > +               acpi_ec_flush_work();
> > +       }
> > +
> >         return false;
> >  }
> >  #endif /* CONFIG_PM_SLEEP */
> > Index: linux-pm/drivers/acpi/sleep.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/sleep.c
> > +++ linux-pm/drivers/acpi/sleep.c
> > @@ -980,13 +980,6 @@ static int acpi_s2idle_prepare_late(void
> >         return 0;
> >  }
> >
> > -static void acpi_s2idle_sync(void)
> > -{
> > -       /* The EC driver uses special workqueues that need to be flushed. */
> > -       acpi_ec_flush_work();
> > -       acpi_os_wait_events_complete(); /* synchronize Notify handling */
> > -}
> > -
> >  static bool acpi_s2idle_wake(void)
> >  {
> >         if (!acpi_sci_irq_valid())
> > @@ -1018,7 +1011,7 @@ static bool acpi_s2idle_wake(void)
> >                         return true;
> >
> >                 /*
> > -                * Cancel the wakeup and process all pending events in case
> > +                * Cancel the SCI wakeup and process all pending events in case
> >                  * there are any wakeup ones in there.
> >                  *
> >                  * Note that if any non-EC GPEs are active at this point, the
> > @@ -1026,8 +1019,7 @@ static bool acpi_s2idle_wake(void)
> >                  * should be missed by canceling the wakeup here.
> >                  */
> >                 pm_system_cancel_wakeup();
> > -
> > -               acpi_s2idle_sync();
> > +               acpi_os_wait_events_complete();
> >
> >                 /*
> >                  * The SCI is in the "suspended" state now and it cannot produce
> > @@ -1060,7 +1052,8 @@ static void acpi_s2idle_restore(void)
> >          * of GPEs.
> >          */
> >         acpi_os_wait_events_complete(); /* synchronize GPE processing */
> > -       acpi_s2idle_sync();
> > +       acpi_ec_flush_work(); /* flush the EC driver's workqueues */
> > +       acpi_os_wait_events_complete(); /* synchronize Notify handling */
> >
> >         s2idle_wakeup = false;
> >
> >
> >
> >
