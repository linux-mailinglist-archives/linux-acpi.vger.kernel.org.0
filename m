Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E95D30FBD8
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 19:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbhBDSod (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 13:44:33 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:37497 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239277AbhBDSmI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2021 13:42:08 -0500
Received: by mail-ot1-f51.google.com with SMTP id k25so2295696otb.4;
        Thu, 04 Feb 2021 10:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgEwsAIbfzk4F3LDN+BENUCsaMunUKWsUBAGbFyp4AQ=;
        b=eFG0h+tduXnyfEqzQzdkQ16zYz1Be42Jq65tfQnVoMHYn8ztt/sFsLDwJdQ08xG3Gd
         oewlMvWCXC7CxmKi+7Pke1R3XqELLd72lxPp6xQt8DPCwtlwBqk0e0RpQ5AL2AqqtpSf
         EABdXnNhKHhXcgcNl02DaApyRZZt3jc9e/Oj7VOAzOdOsZtYnwqx8otUnbczqVds2+Fz
         xDEzqjugzV3khuYKxgIY0YiSt0vyaEO/2CK+2g+jAKBQfXPZtZhuibWKa5OAb/nRqmYT
         uO1mUDRGP4FkiWslgELdsJYcUmQzZvC0S+Ulg4EdnN9sQ4DC8mDtmcjTorq8K9Z3RWBF
         M2gg==
X-Gm-Message-State: AOAM530KqV+R+zgn32dgh9MvFpVL3jIB9Q8cjcpuBkJ4rZREH3/M6djP
        zZSIdHRcbrsWHS+cA3HudZPHwJsTDK1CHF67rrotPWJFD2A=
X-Google-Smtp-Source: ABdhPJz2z2Hqnks7YBT+qY42QfOItvN7soEw5DnHRTXG15SX/Dvqtg9DK6HpLvBH1F1zj5OFwYsdzlOitHcy+Ussrj4=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr611814otm.206.1612464083340;
 Thu, 04 Feb 2021 10:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com>
 <20210202043345.3778765-3-saravanak@google.com> <CAJZ5v0g6t4kWaMrhj35G01_6t1rrOhOe8Vqa9bAanJDaE5+zCA@mail.gmail.com>
 <CAGETcx-nYs2Ab+sxyvT7pixWTrzLYkr3GbaRv2m16vAcpBD-DQ@mail.gmail.com>
In-Reply-To: <CAGETcx-nYs2Ab+sxyvT7pixWTrzLYkr3GbaRv2m16vAcpBD-DQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Feb 2021 19:41:12 +0100
Message-ID: <CAJZ5v0jeY3dFRCZr0h874q=dFQ7CvPy2XnemGQ6Zh5xB_Bu+ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] driver core: fw_devlink: Handle missing drivers
 for optional suppliers
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 2, 2021 at 8:47 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Feb 2, 2021 at 6:34 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Feb 2, 2021 at 5:33 AM Saravana Kannan <saravanak@google.com> wrote:
> > >

[cut]

> >
> > > + *
> > > + * This function requests fw_devlink to set itself up for a deferred probe
> > > + * retry. This allows fw_devlink to ignore device links it created to
> > > + * suppliers that'll never probe. This is necessary in case some of the
> > > + * suppliers are optional and their consumers can probe without them.
> > > + *
> > > + * Returns true if deferred probe retry is likely to make any difference.
> > > + */
> > > +bool fw_devlink_deferred_probe_retry(void)
> > > +{
> > > +       if (IS_ENABLED(CONFIG_MODULES))
> > > +               return false;
> >
> > To make the above more visible, I'd fold this function into the caller.
>
> I had written it this way because I'm thinking of adding a timeout
> heuristic for MODULES in here. I can move it to the caller if you feel
> strongly about it.

Not really strongly, but then moving it back when you need doesn't
sound particularly troublesome to me. :-)

> >
> > > +
> > > +       fw_devlink_def_probe_retry = true;
> > > +       return fw_devlink_get_flags() && !fw_devlink_is_permissive();
> > > +}
> > > +
> > >  /**
> > >   * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
> > >   * @con - Consumer device for the device link
> > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > index 9179825ff646..11325df2327f 100644
> > > --- a/drivers/base/dd.c
> > > +++ b/drivers/base/dd.c
> > > @@ -317,6 +317,11 @@ static int deferred_probe_initcall(void)
> > >         driver_deferred_probe_trigger();
> > >         /* Sort as many dependencies as possible before exiting initcalls */
> > >         flush_work(&deferred_probe_work);
> > > +
> > > +       if (fw_devlink_deferred_probe_retry()) {
> > > +               driver_deferred_probe_trigger();
> > > +               flush_work(&deferred_probe_work);
> > > +       }
> > >         initcalls_done = true;
> > >
> > >         /*
> > > --
> >
> > Overall, the "let's do nothing if modules are not enabled" approach is
> > a bit disappointing, because what if somebody builds all of the
> > drivers needed for boot in and enables modules anyway, for example to
> > allow USB drivers to be probed dynamically?
>
> Yeah, I'm disappointed too :( But I'm trying to get it to work for
> !MODULES so that we can enable fw_devlink=on by default at least for
> !MODULES to make sure drivers don't introduce more issues going
> forward. And then I plan to continue working on making it work
> correctly for MODULES case too.
>
> Getting fw_devlink=on to work perfectly for MODULES and !MODULES is
> not a problem at all. But it needs fixing a bunch of drivers (mostly
> simple fixes like setting the right flag, handling deferred probes
> correctly, etc), but I'm hitting a catch-22 here. I can't find the
> drivers without setting fw_devlink=on by default. But if I did that,
> it's going to break a bunch of boards.
>
> What's your thought on leaving fw_devlink=on by default on 5.12 and
> fixing drivers as issues are reported?

If there are any issues known today that need to be addressed, I'd fix
them first and then try to enable fw_devlink=on maybe just for
!MODULES to start with.

> If that's a no, do you have any other ideas on how to deal with this catch-22?

Try to enable, fix issues as they show up in linux-next.  If there are
still outstanding issues before the next release, back off and try in
the next cycle.  Repeat.

This doesn't sound particularly attractive, but I don't have any
better idea, sorry.
