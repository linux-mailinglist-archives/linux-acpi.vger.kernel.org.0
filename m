Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35B02F2F4E
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 13:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbhALMqU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 12 Jan 2021 07:46:20 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43784 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387974AbhALMqU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2021 07:46:20 -0500
Received: by mail-ot1-f45.google.com with SMTP id q25so2082511otn.10;
        Tue, 12 Jan 2021 04:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EFOSSjP2fTd1K6RGm8lMh2K690UVe2NBQkQwH5LWtVE=;
        b=p51g4VnsBc0vJcrt93uyuSmVjBE/sxcuboKWaGe77/BJgtIimlu6aiZkk8G972lnMH
         D8zZFwzWuCbS71U3rdIk64TrPfHG8XFu3SfO6V/XQSHCXpE8C22rww2HuWGBIx86Pbj7
         G2R7yMCXbo23vF93s+Y6a1QXDyv5Sbev5lClTNM/HhtDsKqXRmYpnPUfC5hv9IA5RlGF
         jJ0fC8JKmwJH21plPHe3pRQOMQ6ClXwTCOVSOLY17awOGxFBu11+FCP00K35fr2puhdo
         tF0VQaQ+EPb0KlAcSlcVc2RbWBt2G2oOKoW3Nq1nkFYleieVkn7yUvxHfOS2jdu55Nzg
         urJA==
X-Gm-Message-State: AOAM53263x6SEFHgyZSZ78dgEnIlxjx/bQfwLMVWQnd2PYk7V3nPc/yX
        AnwGfYmE94jeZG6AKLpFP8W9SsbgBUCpf5yGk1mpJKJn
X-Google-Smtp-Source: ABdhPJyawNLYHpp3fs0HwK16+5LDEjwKVxHsqC5aggXbKqlM6e3ARb7zgK9iSZn6Zl/iLEr4qIO18zAKTIzYogi+Fb0=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr2572558ota.260.1610455537788;
 Tue, 12 Jan 2021 04:45:37 -0800 (PST)
MIME-Version: 1.0
References: <20201201213019.1558738-1-furquan@google.com> <e77e0569-568a-f7fb-9f0d-e64943b467f0@gmail.com>
In-Reply-To: <e77e0569-568a-f7fb-9f0d-e64943b467f0@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jan 2021 13:45:25 +0100
Message-ID: <CAJZ5v0jhniqG43F6hCqXdxQiQZRc67GdkdP0BXcRut=P7k7BVQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: core: Detach device from power domain on shutdown
To:     Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Furquan Shaikh <furquan@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 12, 2021 at 10:55 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 02.12.2020 00:30, Furquan Shaikh пишет:
> > When the system is powered off or rebooted, devices are not detached
> > from their PM domain. This results in ACPI PM not being invoked and
> > hence PowerResouce _OFF method not being invoked for any of the
> > devices. Because the ACPI power resources are not turned off in case
> > of poweroff and reboot, it violates the power sequencing requirements
> > which impacts the reliability of the devices over the lifetime of the
> > platform. This is currently observed on all Chromebooks using ACPI.
> >
> > In order to solve the above problem, this change detaches a device
> > from its PM domain whenever it is shutdown. This action is basically
> > analogous to ->remove() from driver model perspective. Detaching the
> > device from its PM domain ensures that the ACPI PM gets a chance to
> > turn off the power resources for the device thus complying with its
> > power sequencing requirements.
> >
> > Signed-off-by: Furquan Shaikh <furquan@google.com>
> > ---
> >  drivers/base/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index d661ada1518f..5823f1d719e1 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/genhd.h>
> >  #include <linux/mutex.h>
> > +#include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/sched/signal.h>
> > @@ -4057,6 +4058,8 @@ void device_shutdown(void)
> >                       dev->driver->shutdown(dev);
> >               }
> >
> > +             dev_pm_domain_detach(dev, true);
> > +
> >               device_unlock(dev);
> >               if (parent)
> >                       device_unlock(parent);
> >
>
> This patch broke system shutdown on NVIDIA Tegra using today's
> linux-next because power domain can't be turned off until device drivers
> handed control over device resets to the power domain of Power
> Management controller on Tegra. This patch introduced the wrong
> behaviour, apparently it should be made specific to ACPI only.
>
> Please fix, thanks in advance.

OK, so Greg please drop it.
