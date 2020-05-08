Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5D1CA5F3
	for <lists+linux-acpi@lfdr.de>; Fri,  8 May 2020 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHIWW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 May 2020 04:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgEHIWV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 May 2020 04:22:21 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67036C05BD09
        for <linux-acpi@vger.kernel.org>; Fri,  8 May 2020 01:22:21 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m33so843338otc.5
        for <linux-acpi@vger.kernel.org>; Fri, 08 May 2020 01:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h/Rz9wFnZCM8W9Uzhf8hhBprPQEGzRH3w8O3PZ5rlcQ=;
        b=RVuAkDh3S7jS0Kb/CZiUVltsuZ4GokIbs2rpfwHHcTjvyFTQUDZxFDyWtlEN5er0iI
         hSUUXNvqXf+rOosk9LlyKd/N/W+72VACsQkMOb3G9XGrLE7pvfvdrxoPTJus06PP2VjP
         O0CFprR4EeKWaLwA805ecejwRnd2tAzMzpDAuA2v1kPEunCFfrIimJS6wEreBvKsWneG
         Uq/aMS1WFnv+6XebTIymmDx7gRdls9XMi/vXSsdl25lmSaOv0w9s1f+Im6B+/kbDviet
         7YaPDJaYuOBYL0plej7e8WqlURWnI6YmZEjQQtDPl044oTNusOKf3aG+poQNEDz5KpRY
         6yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h/Rz9wFnZCM8W9Uzhf8hhBprPQEGzRH3w8O3PZ5rlcQ=;
        b=IfpKrzWh6DjXEHBCiXFIIumYMh2pau0JXF8Ajhtc0TlAd8C0DGGRn90xFTuCRtoiBv
         24kLy3M+Ug+34vK9MjkqIqVBZkM0g4RA0U19F0Nq5xwFjS1ywRMkYR8WL+2Lh61rjY2a
         UXFcTAXTbKAdJweIoPhSoITqVcO3u3nDPswhv7UrnGTEt03Ln0KtDXwapWJiK4/tC3V6
         5VKKeleQV+GNU/LVitZCO+eD4tyMOcqtR61ej6u9S+W8P2AplDyz+xB9UctHSgqIcbYa
         SMzO4Zx4HCZxLyCAniOLWMZAkiiWmbfhC8TY4X0AvL71VpeQMIDAYSNwlhYaXYo1gxqW
         JUDA==
X-Gm-Message-State: AGi0PuYoY/nJ0aenRa7nS9/QmovAKB6l4BG73qr5Y4C5q6LdkEdG5cfQ
        BSP8EiWO3fUnd4hpd5w91nvPK9sN9wCxfoiH3+vtWQ==
X-Google-Smtp-Source: APiQypKTZGwRNoLv/Ck2tgsg+o835lb5y9HwhlKTO6Il+1y7ujoxLKejI6aKpY95YigvPXJMUdRs/nSDSHVWCYQxNg4=
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr1276000otp.144.1588926140522;
 Fri, 08 May 2020 01:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwdqo7=MvyG_PE+PGVfeA17AHF5i5JucgaKqqMX6mjArbQ@mail.gmail.com>
 <CAJZ5v0gX1gx1_zTZg=M+xEOqxPEaq8ZU-N3hwk7OGcGdzrdBTg@mail.gmail.com>
 <CAB4CAweZcN0SPe-a7jbthV=-ip9cCzJOM=NfP9YvtXw97ugKgQ@mail.gmail.com> <5029155.caIQduTdCh@kreacher>
In-Reply-To: <5029155.caIQduTdCh@kreacher>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 8 May 2020 16:22:09 +0800
Message-ID: <CAB4CAwfFeJjrxQvpUz3V6VMW4aHWd7iZD6Xpu6rAnaPv=ZpFeg@mail.gmail.com>
Subject: Re: System fails to exit s2idle by a keystroke on my laptop
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 8, 2020 at 2:05 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, May 7, 2020 5:38:11 AM CEST Chris Chiu wrote:
> > On Wed, May 6, 2020 at 6:19 PM Rafael J. Wysocki <rafael@kernel.org> wr=
ote:
> > >
> > > On Wed, May 6, 2020 at 11:32 AM Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> > > >
> > > >
> > > > Thanks for the report, the issue evidently is EC-related.
> > > >
> > > > > @@ -1024,7 +1024,7 @@ static bool acpi_s2idle_wake(void)
> > > > >                  * regarded as a spurious one.
> > > > >                  */
> > > > >                 if (!acpi_ec_dispatch_gpe())
> > > > > -                       return false;
> > > > > +                       return true;
> > > >
> > > > Have you tried commenting out simply removing the if () check and t=
he
> > > > following return statement?
> > >
> > > Scratch that.
> > >
> > > Instead, please try doing
> > >
> > > acpi_ec_dispatch_gpe()
> > >
> > > instead of the if () and the following return statement.
> >
> > Yes. I verified with the modification you suggested on my laptop. It's
> > working OK.
> > I can wake from a keystroke w/o problem.
> >
> > @ -1024,8 +1024,7 @@ static bool acpi_s2idle_wake(void)
> >                  * If the EC GPE status bit has not been set, the wakeu=
p is
> >                  * regarded as a spurious one.
> >                  */
> > -               if (!acpi_ec_dispatch_gpe())
> > -                       return false;
> > +               acpi_ec_dispatch_gpe();
> >
> >                 /*
> >                  * Cancel the wakeup and process all pending events in =
case
> >
>
> OK, great, thanks for the confirmation!
>
> Does the appended patch work for you then?
>
> It should be functionally equivalent to the above change if I didn't mess=
 it up.
>
>
> ---
>  drivers/acpi/ec.c       |   23 ++++++++++++++---------
>  drivers/acpi/internal.h |    1 -
>  drivers/acpi/sleep.c    |   14 ++------------
>  3 files changed, 16 insertions(+), 22 deletions(-)
>
> Index: linux-pm/drivers/acpi/sleep.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -1013,21 +1013,11 @@ static bool acpi_s2idle_wake(void)
>                 if (acpi_check_wakeup_handlers())
>                         return true;
>
> -               /*
> -                * If the status bit is set for any enabled GPE other tha=
n the
> -                * EC one, the wakeup is regarded as a genuine one.
> -                */
> -               if (acpi_ec_other_gpes_active())
> +               /* Check non-EC GPE wakeups and dispatch the EC GPE. */
> +               if (acpi_ec_dispatch_gpe())
>                         return true;
>
>                 /*
> -                * If the EC GPE status bit has not been set, the wakeup =
is
> -                * regarded as a spurious one.
> -                */
> -               if (!acpi_ec_dispatch_gpe())
> -                       return false;
> -
> -               /*
>                  * Cancel the wakeup and process all pending events in ca=
se
>                  * there are any wakeup ones in there.
>                  *
> Index: linux-pm/drivers/acpi/ec.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -1994,23 +1994,28 @@ void acpi_ec_set_gpe_wake_mask(u8 action
>                 acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
>  }
>
> -bool acpi_ec_other_gpes_active(void)
> -{
> -       return acpi_any_gpe_status_set(first_ec ? first_ec->gpe : U32_MAX=
);
> -}
> -
>  bool acpi_ec_dispatch_gpe(void)
>  {
>         u32 ret;
>
>         if (!first_ec)
> -               return false;
> +               return acpi_any_gpe_status_set(U32_MAX);
>
> +       /*
> +        * Report wakeup if the status bit is set for any enabled GPE oth=
er
> +        * than the EC one.
> +        */
> +       if (acpi_any_gpe_status_set(first_ec->gpe))
> +               return true;
> +
> +       /*
> +        * Dispatch the EC GPE in-band, but do not report wakeup in any c=
ase
> +        * to allow the caller to process events properly after that.
> +        */
>         ret =3D acpi_dispatch_gpe(NULL, first_ec->gpe);
> -       if (ret =3D=3D ACPI_INTERRUPT_HANDLED) {
> +       if (ret =3D=3D ACPI_INTERRUPT_HANDLED)
>                 pm_pr_dbg("EC GPE dispatched\n");
> -               return true;
> -       }
> +
>         return false;
>  }
>  #endif /* CONFIG_PM_SLEEP */
> Index: linux-pm/drivers/acpi/internal.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -202,7 +202,6 @@ void acpi_ec_remove_query_handler(struct
>
>  #ifdef CONFIG_PM_SLEEP
>  void acpi_ec_flush_work(void);
> -bool acpi_ec_other_gpes_active(void);
>  bool acpi_ec_dispatch_gpe(void);
>  #endif
>
>

=EF=BC=A8i Rafael,
    Thanks for your patch. I tried it on my laptop and it's also
working fine. Wake up by keystroke/power button/lid open all work as
expected. Thanks.

Chris
