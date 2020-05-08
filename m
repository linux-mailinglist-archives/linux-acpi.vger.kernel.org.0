Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB901CB52F
	for <lists+linux-acpi@lfdr.de>; Fri,  8 May 2020 18:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEHQuT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 8 May 2020 12:50:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59854 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgEHQuT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 May 2020 12:50:19 -0400
Received: from 89-64-85-173.dynamic.chello.pl (89.64.85.173) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 4ddab008868cad6b; Fri, 8 May 2020 18:50:17 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: System fails to exit s2idle by a keystroke on my laptop
Date:   Fri, 08 May 2020 18:50:16 +0200
Message-ID: <79452135.44xTU8OeJi@kreacher>
In-Reply-To: <CAB4CAwfFeJjrxQvpUz3V6VMW4aHWd7iZD6Xpu6rAnaPv=ZpFeg@mail.gmail.com>
References: <CAB4CAwdqo7=MvyG_PE+PGVfeA17AHF5i5JucgaKqqMX6mjArbQ@mail.gmail.com> <5029155.caIQduTdCh@kreacher> <CAB4CAwfFeJjrxQvpUz3V6VMW4aHWd7iZD6Xpu6rAnaPv=ZpFeg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, May 8, 2020 10:22:09 AM CEST Chris Chiu wrote:
> On Fri, May 8, 2020 at 2:05 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Thursday, May 7, 2020 5:38:11 AM CEST Chris Chiu wrote:
> > > On Wed, May 6, 2020 at 6:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Wed, May 6, 2020 at 11:32 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > >
> > > > > Thanks for the report, the issue evidently is EC-related.
> > > > >
> > > > > > @@ -1024,7 +1024,7 @@ static bool acpi_s2idle_wake(void)
> > > > > >                  * regarded as a spurious one.
> > > > > >                  */
> > > > > >                 if (!acpi_ec_dispatch_gpe())
> > > > > > -                       return false;
> > > > > > +                       return true;
> > > > >
> > > > > Have you tried commenting out simply removing the if () check and the
> > > > > following return statement?
> > > >
> > > > Scratch that.
> > > >
> > > > Instead, please try doing
> > > >
> > > > acpi_ec_dispatch_gpe()
> > > >
> > > > instead of the if () and the following return statement.
> > >
> > > Yes. I verified with the modification you suggested on my laptop. It's
> > > working OK.
> > > I can wake from a keystroke w/o problem.
> > >
> > > @ -1024,8 +1024,7 @@ static bool acpi_s2idle_wake(void)
> > >                  * If the EC GPE status bit has not been set, the wakeup is
> > >                  * regarded as a spurious one.
> > >                  */
> > > -               if (!acpi_ec_dispatch_gpe())
> > > -                       return false;
> > > +               acpi_ec_dispatch_gpe();
> > >
> > >                 /*
> > >                  * Cancel the wakeup and process all pending events in case
> > >
> >
> > OK, great, thanks for the confirmation!
> >
> > Does the appended patch work for you then?
> >
> > It should be functionally equivalent to the above change if I didn't mess it up.
> >
> >
> > ---
> >  drivers/acpi/ec.c       |   23 ++++++++++++++---------
> >  drivers/acpi/internal.h |    1 -
> >  drivers/acpi/sleep.c    |   14 ++------------
> >  3 files changed, 16 insertions(+), 22 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/sleep.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/sleep.c
> > +++ linux-pm/drivers/acpi/sleep.c
> > @@ -1013,21 +1013,11 @@ static bool acpi_s2idle_wake(void)
> >                 if (acpi_check_wakeup_handlers())
> >                         return true;
> >
> > -               /*
> > -                * If the status bit is set for any enabled GPE other than the
> > -                * EC one, the wakeup is regarded as a genuine one.
> > -                */
> > -               if (acpi_ec_other_gpes_active())
> > +               /* Check non-EC GPE wakeups and dispatch the EC GPE. */
> > +               if (acpi_ec_dispatch_gpe())
> >                         return true;
> >
> >                 /*
> > -                * If the EC GPE status bit has not been set, the wakeup is
> > -                * regarded as a spurious one.
> > -                */
> > -               if (!acpi_ec_dispatch_gpe())
> > -                       return false;
> > -
> > -               /*
> >                  * Cancel the wakeup and process all pending events in case
> >                  * there are any wakeup ones in there.
> >                  *
> > Index: linux-pm/drivers/acpi/ec.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/ec.c
> > +++ linux-pm/drivers/acpi/ec.c
> > @@ -1994,23 +1994,28 @@ void acpi_ec_set_gpe_wake_mask(u8 action
> >                 acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
> >  }
> >
> > -bool acpi_ec_other_gpes_active(void)
> > -{
> > -       return acpi_any_gpe_status_set(first_ec ? first_ec->gpe : U32_MAX);
> > -}
> > -
> >  bool acpi_ec_dispatch_gpe(void)
> >  {
> >         u32 ret;
> >
> >         if (!first_ec)
> > -               return false;
> > +               return acpi_any_gpe_status_set(U32_MAX);
> >
> > +       /*
> > +        * Report wakeup if the status bit is set for any enabled GPE other
> > +        * than the EC one.
> > +        */
> > +       if (acpi_any_gpe_status_set(first_ec->gpe))
> > +               return true;
> > +
> > +       /*
> > +        * Dispatch the EC GPE in-band, but do not report wakeup in any case
> > +        * to allow the caller to process events properly after that.
> > +        */
> >         ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
> > -       if (ret == ACPI_INTERRUPT_HANDLED) {
> > +       if (ret == ACPI_INTERRUPT_HANDLED)
> >                 pm_pr_dbg("EC GPE dispatched\n");
> > -               return true;
> > -       }
> > +
> >         return false;
> >  }
> >  #endif /* CONFIG_PM_SLEEP */
> > Index: linux-pm/drivers/acpi/internal.h
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/internal.h
> > +++ linux-pm/drivers/acpi/internal.h
> > @@ -202,7 +202,6 @@ void acpi_ec_remove_query_handler(struct
> >
> >  #ifdef CONFIG_PM_SLEEP
> >  void acpi_ec_flush_work(void);
> > -bool acpi_ec_other_gpes_active(void);
> >  bool acpi_ec_dispatch_gpe(void);
> >  #endif
> >
> >
> 
> Ｈi Rafael,
>     Thanks for your patch. I tried it on my laptop and it's also
> working fine. Wake up by keystroke/power button/lid open all work as
> expected. Thanks.

Thanks for the confirmation!

Please also verify the final version of the patch available from

https://patchwork.kernel.org/patch/11537215/

Of course, it will only make a difference if the ec_no_wakeup switch is set
on your system (either as a result of blacklisting or via the kernel command
line).

Thanks!



