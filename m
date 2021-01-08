Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39842EF520
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 16:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbhAHPuu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 10:50:50 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:46593 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbhAHPuu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 10:50:50 -0500
Received: by mail-ot1-f43.google.com with SMTP id w3so9988408otp.13;
        Fri, 08 Jan 2021 07:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvJeCYxadcyoAzF1SiLwwloKn8yQ7/+aj8/jI72xI9s=;
        b=b8sZGAqvJ/qxWP+m2lXjb6XKZpoe00SQFwfGUZ3/y/fAzr74BHHKg8aycCdYnQkzLl
         OeDqcQR1sVIUO5jJ03gH50moiNFcaa2TGRDDU7YcMAjzmOvTnESDFqKp512X1VY4tpck
         bblba2EEBdF/tVVMX9BFx/Ka8ieZ6dKhxc1uIw19oyvwQtof652B3UimfxOuF9hUzkXr
         d/LM7o+NmK5POexMYr7Y+OUXR0fMQZOWtcUf461TMf7nIfRRpx8A3j19qf+xRkQb7Clv
         FtDc7yKsf/zsokDf4iLhg8ARfWmOQp60LgTRs5auXJLbA2Z7jnWY50BsjmZwgwkKIFYq
         w2zw==
X-Gm-Message-State: AOAM5320+zuL4yZ6pxjhHE4bqGzkQ7gBVDI50mn6Tuh9zYhL/jGeK9l9
        RcsTC5WtqDRC8PCp+Mg+lgwz+pQQnJ9YxdWrPfk=
X-Google-Smtp-Source: ABdhPJzhk6ZttQly8yx3EcnFBoo7Ui0FTYZ13DKb90t5youTBK4XgR/5mhjcA8VYl4AZruQiGjUNPWY4zcsHXs0eF70=
X-Received: by 2002:a9d:7191:: with SMTP id o17mr2106178otj.321.1610121009033;
 Fri, 08 Jan 2021 07:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20201201213019.1558738-1-furquan@google.com> <CAEGmHFGZM0mADs-Eiz780RHzyf3emJinSAMT6ipRMpOvb+HGjg@mail.gmail.com>
 <X/h9+1YUj49qQcil@kroah.com>
In-Reply-To: <X/h9+1YUj49qQcil@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Jan 2021 16:49:58 +0100
Message-ID: <CAJZ5v0j0wmV5tMuZDpRvELNcd=4aR-=D-KVnX1wEmoE-oJeFnA@mail.gmail.com>
Subject: Re: [PATCH] drivers: core: Detach device from power domain on shutdown
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Furquan Shaikh <furquan@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 8, 2021 at 4:43 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 14, 2020 at 08:56:48PM -0800, Furquan Shaikh wrote:
> > On Tue, Dec 1, 2020 at 1:30 PM Furquan Shaikh <furquan@google.com> wrote:
> > >
> > > When the system is powered off or rebooted, devices are not detached
> > > from their PM domain. This results in ACPI PM not being invoked and
> > > hence PowerResouce _OFF method not being invoked for any of the
> > > devices. Because the ACPI power resources are not turned off in case
> > > of poweroff and reboot, it violates the power sequencing requirements
> > > which impacts the reliability of the devices over the lifetime of the
> > > platform. This is currently observed on all Chromebooks using ACPI.
> > >
> > > In order to solve the above problem, this change detaches a device
> > > from its PM domain whenever it is shutdown. This action is basically
> > > analogous to ->remove() from driver model perspective. Detaching the
> > > device from its PM domain ensures that the ACPI PM gets a chance to
> > > turn off the power resources for the device thus complying with its
> > > power sequencing requirements.
> > >
> > > Signed-off-by: Furquan Shaikh <furquan@google.com>
> > > ---
> > >  drivers/base/core.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index d661ada1518f..5823f1d719e1 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -23,6 +23,7 @@
> > >  #include <linux/of_device.h>
> > >  #include <linux/genhd.h>
> > >  #include <linux/mutex.h>
> > > +#include <linux/pm_domain.h>
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/netdevice.h>
> > >  #include <linux/sched/signal.h>
> > > @@ -4057,6 +4058,8 @@ void device_shutdown(void)
> > >                         dev->driver->shutdown(dev);
> > >                 }
> > >
> > > +               dev_pm_domain_detach(dev, true);
> > > +
> > >                 device_unlock(dev);
> > >                 if (parent)
> > >                         device_unlock(parent);
> > > --
> > > 2.29.2.454.gaff20da3a2-goog
> > >
> >
> > Hello,
> >
> > Gentle ping. Just checking if there are any comments.
>
> I'll wait for Rafael to ack this before taking it...

Done.

Cheers!
