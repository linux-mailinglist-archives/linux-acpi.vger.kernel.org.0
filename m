Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7687E3B0D6F
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jun 2021 21:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFVTI7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Jun 2021 15:08:59 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:38637 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhFVTI6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jun 2021 15:08:58 -0400
Received: by mail-ot1-f50.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so22260994otk.5;
        Tue, 22 Jun 2021 12:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skB5NwL8zHWZqw+O43Sq9dc4ExRKZ46WUWu8K8GlMp0=;
        b=jvDW/XY9cboLrZAILL9pMRZiXZdQocPlw665HassyIJs+YpW8fJFRzy7qZGv8AUAwg
         FC/XNSbvMnBtAZpfBPAi//G8AbrkLV+XgeveFNX1CSmIGSLh4JMA63+nRy/E+krUUdGT
         aHt5u6d1S2zBzgRLCoGFNKEGBVBNznPH6vIIW6L9KKiBDmZ/9DCzaZVL2+3GU+9PcM7I
         kTjkHlAO8wuoSuze4Tpq+FGyHL4SCTDSRKqeN0olMJ1ZDZ3NpFBcDjKLLe7ObhFdWBoi
         IrSDJm4KSeKMZ+GBhI2CTv/qE5vSSlf2StPNQk6Pwjyf2MdNwFrmH0Jfi7VTCdYy6e/K
         WxGw==
X-Gm-Message-State: AOAM5317ZBqonhx2KK63Fa53exTuYK2d6ROAlyPTt7R0+ZyIHDcaMsGl
        AM956VCTax4/YEbIGQhZ8BudwZt7RghEfCbyr40=
X-Google-Smtp-Source: ABdhPJxzHxmr8x34Y2wtFg1KsQLbkV9Li9xWjE4h5/dWowR6E4RYKlkiBi9CKtLLWAxfYcrsGFtutoWtFI8p8eL0HZw=
X-Received: by 2002:a9d:674b:: with SMTP id w11mr4373560otm.260.1624388802508;
 Tue, 22 Jun 2021 12:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <YNEQjAzq6iWNgnBc@google.com> <CAJZ5v0jVzFWfNX-ujOz=A8SXyWGv_HC+YSVEzowSN+aU5aGiYw@mail.gmail.com>
 <YNIoWrR8W5Uow7kk@google.com>
In-Reply-To: <YNIoWrR8W5Uow7kk@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jun 2021 21:06:31 +0200
Message-ID: <CAJZ5v0g4_E0srO6mTTgH=BWEHGVHBc8Zmis0OVt40Cy6rjdmHg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: postpone bringing devices to D0 unless we need them
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Tue, Jun 22, 2021 at 8:13 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Rafael,
>
> On Tue, Jun 22, 2021 at 03:40:05PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jun 22, 2021 at 12:20 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > Currently ACPI power domain brings devices into D0 state in the "resume
> > > early" phase. Normally this does not cause any issues, as powering up
> > > happens quickly. However there are peripherals that have certain timing
> > > requirements for powering on, for example some models of Elan
> > > touchscreens need 300msec after powering up/releasing reset line before
> > > they can accept commands from the host. Such devices will dominate
> > > the time spent in early resume phase and cause increase in overall
> > > resume time as we wait for early resume to complete before we can
> > > proceed to the normal resume stage.
> > >
> > > There are ways for a driver to indicate that it can tolerate device
> > > being in the low power mode and that it knows how to power the device
> > > back up when resuming, bit that requires changes to individual drivers
> > > that may not really care about details of ACPI controlled power
> > > management.
> > >
> > > This change attempts to solve this issue at ACPI power domain level, by
> > > postponing powering up device until we get to the normal resume stage,
> > > unless there is early resume handler defined for the device, or device
> > > does not declare any resume handlers, in which case we continue powering
> > > up such devices early. This allows us to shave off several hundred
> > > milliseconds of resume time on affected systems.
> > >
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >  drivers/acpi/device_pm.c | 46 +++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 41 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> > > index 096153761ebc..00b412ccb2e0 100644
> > > --- a/drivers/acpi/device_pm.c
> > > +++ b/drivers/acpi/device_pm.c
> > > @@ -1131,17 +1131,52 @@ static int acpi_subsys_resume_noirq(struct device *dev)
> > >   *
> > >   * Use ACPI to put the given device into the full-power state and carry out the
> > >   * generic early resume procedure for it during system transition into the
> > > - * working state.
> > > + * working state, but only do that if device either defines early resume
> > > + * handler, or does not define power operations at all. Otherwise powering up
> > > + * of the device is postponed to the normal resume phase.
> > >   */
> > >  static int acpi_subsys_resume_early(struct device *dev)
> > >  {
> > > +       const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> > > +       struct acpi_device *adev = ACPI_COMPANION(dev);
> > >         int ret;
> > >
> > > -       if (dev_pm_skip_resume(dev))
> > > -               return 0;
> >
> > The above doesn't need to be changed AFAICS.
>
> I was trying to have if string if/else if/else, but I can keep it as it
> was.
>
> >
> > > +       if (dev_pm_skip_resume(dev)) {
> > > +               ret = 0;
> > > +       } else if (!pm || pm->resume_early) {
> >
> > This is rather tricky, but I don't see a particular reason why it wouldn't work.
> >
> > > +               ret = acpi_dev_resume(dev);
> > > +               if (!ret)
> > > +                       ret = pm_generic_resume_early(dev);
> > > +       } else {
> > > +               if (adev)
> > > +                       acpi_device_wakeup_disable(adev);
> >
> > This isn't necessary here.
>
> Just to confirm - you are saying that disabling the device as a wakeup
> source can be safely postponed till the normal resume stage?

Yes, it should be safe.  Moreover, it may be unsafe to change the
ordering between acpi_dev_pm_full_power() and
acpi_device_wakeup_disable().

> I was trying to keep as much of the original behavior as possible and this is
> a part of acpi_dev_resume() that we are now postponing.

I would postpone the whole thing.

Thanks!
