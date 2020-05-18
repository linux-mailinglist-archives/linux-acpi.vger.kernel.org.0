Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176F41D7678
	for <lists+linux-acpi@lfdr.de>; Mon, 18 May 2020 13:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgERLOm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 May 2020 07:14:42 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:33199 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgERLOg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 May 2020 07:14:36 -0400
Received: by mail-oo1-f66.google.com with SMTP id q6so1948442oot.0;
        Mon, 18 May 2020 04:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIPLeWfzuIiw+O1I+1psfswOSkbFeXLFcX0dH9PjiPk=;
        b=VKXy+kZFmQZOVGV4ja7GB9lC/o6XQ25NP4HKhhIIRpMukzO0GmDm2lBq6DOH/3RTgy
         JluM3WKFVRm1HpxTIgrCPDXhWFxBmXJDEIvSwIdOV2it/71ZnxyWPJuxYlBSTzSP1Mil
         q9p/Pjzp8oXnxSrryoJGkPEDuRLBQnRAv0ygAue/veGcKVCNdt0UfWRTyQeFEJK7AWxh
         CPlDYza+zNa14g5K7yLkfZaXM3dAm+sNfWhIpkCBQlh0tBQV0JjGw+dvNPvVFNXNlC0w
         tPwad7bwXdjJjPDsg46N/2Uq9fCJn495l0BPx3ZILD8oS0dsX32NlXzkCZg6vjDnbKgF
         HepA==
X-Gm-Message-State: AOAM531d4L/CAUOOh6/9VWFn2iVGFSoheT8rp3tlvbZw/01RTn9wrld5
        NP7JA9XJ/YQINI3haYxEuYfHahjsrju06PlbW0w=
X-Google-Smtp-Source: ABdhPJyjjRohNtzYOZux1PadVtPRgk3RCnO2GQyqFlC1CuoS1BzGXLkakHwRRIC6/Jm5lH2+Px+N/LPVW0cgUdFmPrs=
X-Received: by 2002:a4a:a286:: with SMTP id h6mr12497264ool.38.1589800474994;
 Mon, 18 May 2020 04:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <4502272.pByIgeXik9@kreacher> <CAJZ5v0j6S+we7tHeV9TM30LS+TO3zWigACe0ZUFfWphg2FBBZQ@mail.gmail.com>
 <CAB4CAwc4y7xitv9L9w61GKfBsbhHXuk+iM+QWKc2=0mks_fNFg@mail.gmail.com>
In-Reply-To: <CAB4CAwc4y7xitv9L9w61GKfBsbhHXuk+iM+QWKc2=0mks_fNFg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 May 2020 13:14:23 +0200
Message-ID: <CAJZ5v0hMtxmu9S3xsyEhT-b-qYiects80cLt18orxEXyeH6ESw@mail.gmail.com>
Subject: Re: [PATCH[RFT]] ACPI: EC: s2idle: Avoid flushing EC work when EC GPE
 is inactive
To:     Chris Chiu <chiu@endlessm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 18, 2020 at 1:11 PM Chris Chiu <chiu@endlessm.com> wrote:
>
> On Mon, May 18, 2020 at 4:59 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, May 14, 2020 at 12:10 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Flushing the EC work while suspended to idle when the EC GPE status
> > > is not set causes some EC wakeup events (notably power button and
> > > lid ones) to be missed after a series of spurious wakeups on the Dell
> > > XPS13 9360 in my office.
> > >
> > > If that happens, the machine cannot be woken up from suspend-to-idle
> > > by a power button press or lid status change and it needs to be woken
> > > up in some other way (eg. by a key press).
> > >
> > > Flushing the EC work only after successful dispatching the EC GPE,
> > > which means that its status has been set, avoids the issue, so change
> > > the code in question accordingly.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > Hi Chris,
> > >
> > > Please check if the key press wakeup still works on your system with this patch
> > > applied (on top of https://patchwork.kernel.org/patch/11538065/).
> >
> > Hi Chris,
> >
> > Since I haven't heard back from you and the problem at hand is a
> > regression on the machine where it happens, I'm going to push this
> > patch for merging.
> >
> > If it causes the key press wakeup issue to reappear on your machine,
> > I'm afraid that we'll need to quirk it in the EC driver.
> >
> > Thanks!
>
> Hi Rafael,
> My laptop works w/o problem waking up from a keystroke with this patch
> on top of https://patchwork.kernel.org/patch/11538065/).

Great, thanks for the confirmation!

> > > ---
> > >  drivers/acpi/ec.c    |    6 +++++-
> > >  drivers/acpi/sleep.c |   15 ++++-----------
> > >  2 files changed, 9 insertions(+), 12 deletions(-)
> > >
> > > Index: linux-pm/drivers/acpi/ec.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/acpi/ec.c
> > > +++ linux-pm/drivers/acpi/ec.c
> > > @@ -2020,9 +2020,13 @@ bool acpi_ec_dispatch_gpe(void)
> > >          * to allow the caller to process events properly after that.
> > >          */
> > >         ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
> > > -       if (ret == ACPI_INTERRUPT_HANDLED)
> > > +       if (ret == ACPI_INTERRUPT_HANDLED) {
> > >                 pm_pr_dbg("EC GPE dispatched\n");
> > >
> > > +               /* Flush the event and query workqueues. */
> > > +               acpi_ec_flush_work();
> > > +       }
> > > +
> > >         return false;
> > >  }
> > >  #endif /* CONFIG_PM_SLEEP */
> > > Index: linux-pm/drivers/acpi/sleep.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/acpi/sleep.c
> > > +++ linux-pm/drivers/acpi/sleep.c
> > > @@ -980,13 +980,6 @@ static int acpi_s2idle_prepare_late(void
> > >         return 0;
> > >  }
> > >
> > > -static void acpi_s2idle_sync(void)
> > > -{
> > > -       /* The EC driver uses special workqueues that need to be flushed. */
> > > -       acpi_ec_flush_work();
> > > -       acpi_os_wait_events_complete(); /* synchronize Notify handling */
> > > -}
> > > -
> > >  static bool acpi_s2idle_wake(void)
> > >  {
> > >         if (!acpi_sci_irq_valid())
> > > @@ -1018,7 +1011,7 @@ static bool acpi_s2idle_wake(void)
> > >                         return true;
> > >
> > >                 /*
> > > -                * Cancel the wakeup and process all pending events in case
> > > +                * Cancel the SCI wakeup and process all pending events in case
> > >                  * there are any wakeup ones in there.
> > >                  *
> > >                  * Note that if any non-EC GPEs are active at this point, the
> > > @@ -1026,8 +1019,7 @@ static bool acpi_s2idle_wake(void)
> > >                  * should be missed by canceling the wakeup here.
> > >                  */
> > >                 pm_system_cancel_wakeup();
> > > -
> > > -               acpi_s2idle_sync();
> > > +               acpi_os_wait_events_complete();
> > >
> > >                 /*
> > >                  * The SCI is in the "suspended" state now and it cannot produce
> > > @@ -1060,7 +1052,8 @@ static void acpi_s2idle_restore(void)
> > >          * of GPEs.
> > >          */
> > >         acpi_os_wait_events_complete(); /* synchronize GPE processing */
> > > -       acpi_s2idle_sync();
> > > +       acpi_ec_flush_work(); /* flush the EC driver's workqueues */
> > > +       acpi_os_wait_events_complete(); /* synchronize Notify handling */
> > >
> > >         s2idle_wakeup = false;
> > >
> > >
> > >
> > >
