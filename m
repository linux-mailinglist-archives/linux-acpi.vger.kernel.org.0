Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDFF2EF50C
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 16:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbhAHPoX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 10:44:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbhAHPoX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Jan 2021 10:44:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4DAD23888;
        Fri,  8 Jan 2021 15:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610120622;
        bh=Bs/0LWZLuK53rX4OHj50gHqhKLt+LXdjjswb1+DP8gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFsGz/lC6Pu2kxYEjYewrtJAf1LALJehgFxbrMi1VQeFJ7oal6oNq6wlUSPPbD5i0
         HjFTPyxf+QQqCd9cQDmJJFHvQUIUQ5MjipvFzR9l73yF1B99V3nXKAoN5UIqfvZYe6
         7Wine9ZZXNMezottdi7mLnRdxLLkn3wb8bd+q5pw=
Date:   Fri, 8 Jan 2021 16:44:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Furquan Shaikh <furquan@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] drivers: core: Detach device from power domain on
 shutdown
Message-ID: <X/h9+1YUj49qQcil@kroah.com>
References: <20201201213019.1558738-1-furquan@google.com>
 <CAEGmHFGZM0mADs-Eiz780RHzyf3emJinSAMT6ipRMpOvb+HGjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEGmHFGZM0mADs-Eiz780RHzyf3emJinSAMT6ipRMpOvb+HGjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 14, 2020 at 08:56:48PM -0800, Furquan Shaikh wrote:
> On Tue, Dec 1, 2020 at 1:30 PM Furquan Shaikh <furquan@google.com> wrote:
> >
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
> >                         dev->driver->shutdown(dev);
> >                 }
> >
> > +               dev_pm_domain_detach(dev, true);
> > +
> >                 device_unlock(dev);
> >                 if (parent)
> >                         device_unlock(parent);
> > --
> > 2.29.2.454.gaff20da3a2-goog
> >
> 
> Hello,
> 
> Gentle ping. Just checking if there are any comments.

I'll wait for Rafael to ack this before taking it...

thanks,

greg k-h
