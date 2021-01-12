Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AD22F30B6
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 14:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbhALNKL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 08:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730094AbhALNKK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Jan 2021 08:10:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C455C2311D;
        Tue, 12 Jan 2021 13:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610456969;
        bh=LtMEfIjW927NolOA4/+0HIR0sfp/7v2eXzqxStddmBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RYjZZsh1Kw/llLotuOa/hGgXEGGhcc7pdVBVfnPZYfaRXEQJ2P34GuMTwSL17RsDL
         bSLgdytVe+Xmm6a1LQ8n9Wa4mcVJgf42X+zW18FKITQMnFLZ2QUfbJt6QETQPssXST
         C7XawTKZCe2vE4yA+BGGt7DkKe68ejQE6njG1d88=
Date:   Tue, 12 Jan 2021 14:10:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Furquan Shaikh <furquan@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] drivers: core: Detach device from power domain on
 shutdown
Message-ID: <X/2fzghPXnuDNBPU@kroah.com>
References: <20201201213019.1558738-1-furquan@google.com>
 <e77e0569-568a-f7fb-9f0d-e64943b467f0@gmail.com>
 <CAJZ5v0jhniqG43F6hCqXdxQiQZRc67GdkdP0BXcRut=P7k7BVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jhniqG43F6hCqXdxQiQZRc67GdkdP0BXcRut=P7k7BVQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 12, 2021 at 01:45:25PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 12, 2021 at 10:55 AM Dmitry Osipenko <digetx@gmail.com> wrote:
> >
> > 02.12.2020 00:30, Furquan Shaikh пишет:
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
> > >                       dev->driver->shutdown(dev);
> > >               }
> > >
> > > +             dev_pm_domain_detach(dev, true);
> > > +
> > >               device_unlock(dev);
> > >               if (parent)
> > >                       device_unlock(parent);
> > >
> >
> > This patch broke system shutdown on NVIDIA Tegra using today's
> > linux-next because power domain can't be turned off until device drivers
> > handed control over device resets to the power domain of Power
> > Management controller on Tegra. This patch introduced the wrong
> > behaviour, apparently it should be made specific to ACPI only.
> >
> > Please fix, thanks in advance.
> 
> OK, so Greg please drop it.

Now reverted, thanks.

greg k-h
