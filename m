Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54F13B0CA8
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jun 2021 20:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhFVSQH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Jun 2021 14:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhFVSQG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jun 2021 14:16:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33AAC061574;
        Tue, 22 Jun 2021 11:13:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so2222708pjs.2;
        Tue, 22 Jun 2021 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oGjXQCSsFX/bTDreTeHfa9QhPldXdsTmOBFvpzMwJwI=;
        b=T1gPw4wkkUEy43nZnbxpBX6eXW1O0aJwAvLHgT9PLC6aGAaVZkbYgKOyHH0omio3Yx
         10OaUTd+gef8r6q0Ft2XXwdfJ4LhS8N8ZhpojGNRxHEV/LI8L6NsZiiwb2IKdRu6yydg
         xS13NElIZygZjL8OWtvWpNxPUYm5hgHONaVfgiLNW4urgYOJI6PnUAhdpBJwn4UgUjv8
         hFJ62bb9CZ2xiXdGnDSeY/ZDlbTVMd/+XTXQ31BT6lL4Ujz/ZhB7I4dm0GHNjMRmZOdu
         YU/t2s264X74Oxx8bWPvtLiOwrj+eeg1+9w8RU1VanOAfMom8teQmnkwLz+A5zoGY3kh
         8nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oGjXQCSsFX/bTDreTeHfa9QhPldXdsTmOBFvpzMwJwI=;
        b=OcBf0hxupKm2FXqmyAYbLUEKlfO7ZAd2Rm283QT1QVOjmzaERN5MOVlUn8Ne5v+L1z
         +A9Gp2IwkVB0bIGwnQVqE3h46RgnwKZx+kKXutnz6EtxjujYx7hJTjKegtvUqI/9gCa2
         hj2cbX5RBtsXx43juFpzuW/yncse0P3jS96jv0ffrStckUoOTg5GIT17bdehPp2YUBMh
         K8HAmcZZm06G9qUEuYSowDsAyL/QjhiGP5Vqkl/zxvZQVjjd2NaGZj5WEHG5V0elkdA9
         GooUdokJRj0lc5RlW3/n7aQ7Y/DdJRnM8FZcmw4yBGcNzJzAC/iJoQ2R3iLBBUyeetQr
         /thw==
X-Gm-Message-State: AOAM531oS2i2T+5CbWK6HN044anN2bWB5we0Vzd3JS7RB24nSa3q2OLS
        1QqEJOm9ZXfghkoZLtn7i7c=
X-Google-Smtp-Source: ABdhPJzgX8Ii4ePkWIxYzldKImg5WJx+/nUumQhoswu0zGkWdNKRe/5eoa8vsRVxs8mrrFv1CYdIhw==
X-Received: by 2002:a17:903:1c1:b029:125:b183:7989 with SMTP id e1-20020a17090301c1b0290125b1837989mr7711058plh.57.1624385629844;
        Tue, 22 Jun 2021 11:13:49 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:b7e7:569c:6adc:f5e8])
        by smtp.gmail.com with ESMTPSA id c9sm36084pfb.82.2021.06.22.11.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 11:13:49 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:13:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: PM: postpone bringing devices to D0 unless we need
 them
Message-ID: <YNIoWrR8W5Uow7kk@google.com>
References: <YNEQjAzq6iWNgnBc@google.com>
 <CAJZ5v0jVzFWfNX-ujOz=A8SXyWGv_HC+YSVEzowSN+aU5aGiYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jVzFWfNX-ujOz=A8SXyWGv_HC+YSVEzowSN+aU5aGiYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Tue, Jun 22, 2021 at 03:40:05PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 22, 2021 at 12:20 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Currently ACPI power domain brings devices into D0 state in the "resume
> > early" phase. Normally this does not cause any issues, as powering up
> > happens quickly. However there are peripherals that have certain timing
> > requirements for powering on, for example some models of Elan
> > touchscreens need 300msec after powering up/releasing reset line before
> > they can accept commands from the host. Such devices will dominate
> > the time spent in early resume phase and cause increase in overall
> > resume time as we wait for early resume to complete before we can
> > proceed to the normal resume stage.
> >
> > There are ways for a driver to indicate that it can tolerate device
> > being in the low power mode and that it knows how to power the device
> > back up when resuming, bit that requires changes to individual drivers
> > that may not really care about details of ACPI controlled power
> > management.
> >
> > This change attempts to solve this issue at ACPI power domain level, by
> > postponing powering up device until we get to the normal resume stage,
> > unless there is early resume handler defined for the device, or device
> > does not declare any resume handlers, in which case we continue powering
> > up such devices early. This allows us to shave off several hundred
> > milliseconds of resume time on affected systems.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/acpi/device_pm.c | 46 +++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 41 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> > index 096153761ebc..00b412ccb2e0 100644
> > --- a/drivers/acpi/device_pm.c
> > +++ b/drivers/acpi/device_pm.c
> > @@ -1131,17 +1131,52 @@ static int acpi_subsys_resume_noirq(struct device *dev)
> >   *
> >   * Use ACPI to put the given device into the full-power state and carry out the
> >   * generic early resume procedure for it during system transition into the
> > - * working state.
> > + * working state, but only do that if device either defines early resume
> > + * handler, or does not define power operations at all. Otherwise powering up
> > + * of the device is postponed to the normal resume phase.
> >   */
> >  static int acpi_subsys_resume_early(struct device *dev)
> >  {
> > +       const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> > +       struct acpi_device *adev = ACPI_COMPANION(dev);
> >         int ret;
> >
> > -       if (dev_pm_skip_resume(dev))
> > -               return 0;
> 
> The above doesn't need to be changed AFAICS.

I was trying to have if string if/else if/else, but I can keep it as it
was.

> 
> > +       if (dev_pm_skip_resume(dev)) {
> > +               ret = 0;
> > +       } else if (!pm || pm->resume_early) {
> 
> This is rather tricky, but I don't see a particular reason why it wouldn't work.
> 
> > +               ret = acpi_dev_resume(dev);
> > +               if (!ret)
> > +                       ret = pm_generic_resume_early(dev);
> > +       } else {
> > +               if (adev)
> > +                       acpi_device_wakeup_disable(adev);
> 
> This isn't necessary here.

Just to confirm - you are saying that disabling the device as a wakeup
source can be safely postponed till the normal resume stage? I was
trying to keep as much of the original behavior as possible and this is
a part of acpi_dev_resume() that we are now postponing.

Thanks.

-- 
Dmitry
