Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F7030FC31
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 20:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbhBDTFZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 14:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbhBDTEc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2021 14:04:32 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285C2C061786
        for <linux-acpi@vger.kernel.org>; Thu,  4 Feb 2021 11:03:52 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id r2so4227193ybk.11
        for <linux-acpi@vger.kernel.org>; Thu, 04 Feb 2021 11:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8pFMSWYtOcx3mOzDSdCGPWAdMJDgzGkU83bZlEALqTo=;
        b=vfEVvC1lYHn6Fj+zWqdky+ChL5ta8UEWXXK+vig24H5APqmBhB4mw53fJR4LAyRfpY
         UiQaVeGt8rQJMu8H4AvmdLhhocepsS8iLD9kUA1hFMJxUWikkQxPL8GLK9bL/0xAHF8o
         D+ZORW6p/sXmLD3S5sHj3bn0ew5FaEQzSeTfQ0Qwq9g9ywE8kDFa0G9VLwJGO8vuUiyp
         55xdaaQszFePyj4dm9JWN8J/2Zt6/Anv5L/76YWypAGMhovrFFIcdq56JRrU1v80Wm4C
         RQ2q5RNrDi6/KlwXoH7WPxLGRnCQ3CWZTzdA2OP2z4iY4W87tkvtwCwflD12jnP7oC77
         zLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pFMSWYtOcx3mOzDSdCGPWAdMJDgzGkU83bZlEALqTo=;
        b=U6LMJtgZrDnNPNI3CeF/tpe7QeqVgvN7rXhvkBFv0XlOHvzEi175XE6hMVkksvhWq7
         dvT4Qle1s62YS6j1p0mujPgKvvrfzyewMWR0QLLQIUzLe96ofNZTpTjjGVse86wcOjXR
         ZtK57X6D9efQTHBlJtKpjN/KS2ksDkDJSQoPN0WscSskuXmaEfxbPDHxYfjkw4andaia
         FycORmZi23BIbOj0v5dFhijr+RrGFraZxY9Nzx3H9xZxJrfuzRXGOg/+F8acppyX9hhf
         RgRjFIEeI/7MUrGGdAIe6EdzkjFiy+zpckYRN1EYVkDIonjZK3Mkolj0DtsG1ybyNMxT
         FdHg==
X-Gm-Message-State: AOAM530lIoSDpXv8XkNle7ElWqJnWvnLc0P8xhaejoei8RfkLm2YZ8jv
        DKmdaKxFMOwKcIFIm+U8NXWIzHOJHTjkxrwdbcD1Ng==
X-Google-Smtp-Source: ABdhPJzcGgzu8LZWzsJhcX66VRN4ZDnrbioj+FqeXow0ChEDW0z0f85UCmOn7Ept/b/Q+cyBQ0jTcYinD8ez1LgPdjU=
X-Received: by 2002:a25:c683:: with SMTP id k125mr1179350ybf.32.1612465431205;
 Thu, 04 Feb 2021 11:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com>
 <20210202043345.3778765-3-saravanak@google.com> <CAJZ5v0g6t4kWaMrhj35G01_6t1rrOhOe8Vqa9bAanJDaE5+zCA@mail.gmail.com>
 <CAGETcx-nYs2Ab+sxyvT7pixWTrzLYkr3GbaRv2m16vAcpBD-DQ@mail.gmail.com> <CAJZ5v0jeY3dFRCZr0h874q=dFQ7CvPy2XnemGQ6Zh5xB_Bu+ZQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jeY3dFRCZr0h874q=dFQ7CvPy2XnemGQ6Zh5xB_Bu+ZQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 4 Feb 2021 11:03:15 -0800
Message-ID: <CAGETcx-B_--ZUFcbVmL7Y3KeG+Sq16hbaSR8eNk2+XNa_W7-Pg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] driver core: fw_devlink: Handle missing drivers
 for optional suppliers
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Thu, Feb 4, 2021 at 10:41 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 2, 2021 at 8:47 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Tue, Feb 2, 2021 at 6:34 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Feb 2, 2021 at 5:33 AM Saravana Kannan <saravanak@google.com> wrote:
> > > >
>
> [cut]
>
> > >
> > > > + *
> > > > + * This function requests fw_devlink to set itself up for a deferred probe
> > > > + * retry. This allows fw_devlink to ignore device links it created to
> > > > + * suppliers that'll never probe. This is necessary in case some of the
> > > > + * suppliers are optional and their consumers can probe without them.
> > > > + *
> > > > + * Returns true if deferred probe retry is likely to make any difference.
> > > > + */
> > > > +bool fw_devlink_deferred_probe_retry(void)
> > > > +{
> > > > +       if (IS_ENABLED(CONFIG_MODULES))
> > > > +               return false;
> > >
> > > To make the above more visible, I'd fold this function into the caller.
> >
> > I had written it this way because I'm thinking of adding a timeout
> > heuristic for MODULES in here. I can move it to the caller if you feel
> > strongly about it.
>
> Not really strongly, but then moving it back when you need doesn't
> sound particularly troublesome to me. :-)

Ok, will move it. I'm also rewriting this patch. So we'll see where this lands.

>
> > >
> > > > +
> > > > +       fw_devlink_def_probe_retry = true;
> > > > +       return fw_devlink_get_flags() && !fw_devlink_is_permissive();
> > > > +}
> > > > +
> > > >  /**
> > > >   * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
> > > >   * @con - Consumer device for the device link
> > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > > index 9179825ff646..11325df2327f 100644
> > > > --- a/drivers/base/dd.c
> > > > +++ b/drivers/base/dd.c
> > > > @@ -317,6 +317,11 @@ static int deferred_probe_initcall(void)
> > > >         driver_deferred_probe_trigger();
> > > >         /* Sort as many dependencies as possible before exiting initcalls */
> > > >         flush_work(&deferred_probe_work);
> > > > +
> > > > +       if (fw_devlink_deferred_probe_retry()) {
> > > > +               driver_deferred_probe_trigger();
> > > > +               flush_work(&deferred_probe_work);
> > > > +       }
> > > >         initcalls_done = true;
> > > >
> > > >         /*
> > > > --
> > >
> > > Overall, the "let's do nothing if modules are not enabled" approach is
> > > a bit disappointing, because what if somebody builds all of the
> > > drivers needed for boot in and enables modules anyway, for example to
> > > allow USB drivers to be probed dynamically?
> >
> > Yeah, I'm disappointed too :( But I'm trying to get it to work for
> > !MODULES so that we can enable fw_devlink=on by default at least for
> > !MODULES to make sure drivers don't introduce more issues going
> > forward. And then I plan to continue working on making it work
> > correctly for MODULES case too.
> >
> > Getting fw_devlink=on to work perfectly for MODULES and !MODULES is
> > not a problem at all. But it needs fixing a bunch of drivers (mostly
> > simple fixes like setting the right flag, handling deferred probes
> > correctly, etc), but I'm hitting a catch-22 here. I can't find the
> > drivers without setting fw_devlink=on by default. But if I did that,
> > it's going to break a bunch of boards.
> >
> > What's your thought on leaving fw_devlink=on by default on 5.12 and
> > fixing drivers as issues are reported?
>
> If there are any issues known today that need to be addressed, I'd fix
> them first and then try to enable fw_devlink=on maybe just for
> !MODULES to start with.

Yeah, that's what I'm thinking of for now.

> > If that's a no, do you have any other ideas on how to deal with this catch-22?
>
> Try to enable, fix issues as they show up in linux-next.  If there are
> still outstanding issues before the next release, back off and try in
> the next cycle.  Repeat.

If it's just dealing with outstanding issues that are reported, I'm
hoping I can do that. The biggest headache right now is dealing with
devices that have drivers that directly parse the fwnode AND still
have a struct device. So the struct device remains unbound even if the
driver has initialized the device.

>
> This doesn't sound particularly attractive, but I don't have any
> better idea, sorry.

:'( Yeah, another approach I'm thinking of is to have a separate
"strict mode" for fw_devlink=on or above. Where it'll try it's best
till kernel late init and then fallback to permissive. But it's
becoming a headache to deal with some corner cases.

-Saravana
