Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99893CF7E5
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jul 2021 12:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbhGTJvB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Jul 2021 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhGTJrn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Jul 2021 05:47:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98316C061574;
        Tue, 20 Jul 2021 03:28:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id my10so13329439pjb.1;
        Tue, 20 Jul 2021 03:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yt6N2aX6RjTV8ey7tH1MG5YP2S2wCxXaUz++48Vz5WQ=;
        b=QB0iWyLAU0c+xUAm9VED1tGFiyh7uZu9/eseByx7SMUsTl0Sy1RmtfGXVeomNBCEdn
         zb+33UT4EzVDYRT7YQe9BrjxRY4SupulUBsO1B5Xu5Ul5AgZdHh4WYkzqEBrySoEc+Ep
         HWLn4jQTCjUTx+0XrRWFiuABmftfWbnajMASyqtHL6HMEwKxr4wjo0wkTm3IEa68spsR
         ZIPuBmk4Ieq7nS8VmopReVlwJIs7R/PoEiMP44jFpQYRDBtFT+1EuXetCxxa4jQ1LMSW
         nDFOcvxdksJJlHu0VIf55IBSiP3tnis4v7Zu3Zkprraz/Wd3NYQ7Ks96exnncIt9SsXn
         HQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yt6N2aX6RjTV8ey7tH1MG5YP2S2wCxXaUz++48Vz5WQ=;
        b=NC7IO4hkgLxX4LzUvWiNrQ8yC6v/s/WgIQbnWuLrpTs2i+GverDhKMj0Qm3/4eTh2h
         HmfVPPE0Tru2ZJpJlaPPNFr3ITbE/EsFNCUFzvBgz+CyumMsxBj4GiLikvMsRTy1JAJ4
         GaVTVWudGR7a915DNUhrYOG7D1I27c9ZQ0qP3dsKhiHyy7BAwUPS7F+xj3p7J57PHLRT
         ldN/3WHgKYznBQroHZi/u4Ya+yG5v155k2CVBfX+fZCjK/KSMH8f795gQGBwzg+Yqv15
         aUjWwQNJZH+7m5VvbHe19lNuLlxrmPr7IY1L6w1zebO4ER5J3ZKsRGS6kTeeGJkKzIUA
         Nh5A==
X-Gm-Message-State: AOAM532Fh6kie/tEDX5w06AWhy0wM9GXiOcVnYLYFI08UbTt1+EF+QvQ
        5XVWbrao+ThFhG/u7YoF0SGlosJn2lHzQ4Ue7XA=
X-Google-Smtp-Source: ABdhPJzfpnwAduiJWNpvWxJSVRwKTdvq1drNC88sLkxcqdgvaghnT76DN9iNP4sWULuDKhH4IudIYPLWEMndZivxrqw=
X-Received: by 2002:a17:90b:3647:: with SMTP id nh7mr29470822pjb.228.1626776901079;
 Tue, 20 Jul 2021 03:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210716101602.1891-1-laurentiu.tudor@nxp.com>
 <YPF40t5bhgTFM2wK@smile.fi.intel.com> <CABdtJHuKyybhJazpAc8KT54ELtZ319rdb6CbSH6zB5x3NhgtAw@mail.gmail.com>
 <bb009f85-687e-d560-9cc5-1ac4f586a6bd@nxp.com> <YPVufjevu5WaaIxQ@smile.fi.intel.com>
 <2a0f7fa6-b164-eeb4-118a-acd57d79a484@nxp.com>
In-Reply-To: <2a0f7fa6-b164-eeb4-118a-acd57d79a484@nxp.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Jul 2021 13:27:40 +0300
Message-ID: <CAHp75VcYt+VQq4jp9JdkA4EpGqtks2sP-NRkfSbGj+-Vn5ke=g@mail.gmail.com>
Subject: Re: [PATCH] software node: balance refcount for managed sw nodes
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jon Nettleton <jon@solid-run.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 20, 2021 at 12:22 PM Laurentiu Tudor
<laurentiu.tudor@nxp.com> wrote:
> On 7/19/2021 3:22 PM, Andy Shevchenko wrote:
> > On Mon, Jul 19, 2021 at 03:00:17PM +0300, Laurentiu Tudor wrote:
> >> On 7/16/2021 8:21 PM, Jon Nettleton wrote:
> >>> On Fri, Jul 16, 2021 at 2:17 PM Andy Shevchenko
> >>> <andriy.shevchenko@linux.intel.com> wrote:
> >>>>
> >>>> On Fri, Jul 16, 2021 at 01:16:02PM +0300, laurentiu.tudor@nxp.com wrote:
> >>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>>>
> >>>>> software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
> >>>>> software nodes, thus leading to underflow errors. Balance the refcount by
> >>>>> bumping it in the device_create_managed_software_node() function.
> >>>>>
> >>>>> The error [1] was encountered after adding a .shutdown() op to our
> >>>>> fsl-mc-bus driver.
> >>>>
> >>>> Looking into the history of adding ->shutdown() to dwc3 driver (it got reverted
> >>>> later on), I can tell that probably something is wrong in the ->shutdown()
> >>>> method itself.
> >>>
> >>> Isn't the other alternative to just remove the second kobject_put from
> >>> KOBJ_REMOVE ?
> >>
> >> Or maybe on top of Heikki's suggestion, replace the calls to
> >> sysfs_create_link() from KOBJ_ADD with sysfs_create_link_nowarn()?
> >
> > _noearn will hide the problem. It was there, it was removed from there.
> > Perhaps we have to understand the root cause better (some specific flow?).
> >
> > Any insight from you on the flow when the issue appears? I.o.w. what happened
> > on the big picture that we got into the warning you see?
>
> I encountered the initial issue when trying to shut down a system booted
> with ACPI but only after adding a .shutdown() callback to our bus driver
> so that the devices are properly taken down. The problem was that
> software_node_notify(), on KOBJ_REMOVE was dropping the reference count
> twice leading to an underflow error. My initial proposal was to just
> bump the refcount in device_create_managed_software_node(). The device
> properties that triggered the problem are created here [1].
>
> Heikko suggested that instead of manually incrementing the refcount to
> use software_node_notify(KOBJ_ADD). This triggered the second issue, a
> duplicated sysfs entry warning originating in the usb subsystem:
> device_create_managed_software_node() ends up being called twice, once
> here [2] and secondly, the place I previous mentioned [1].

This [3] is what I have reported against DWC3 when ->shutdown() has
been added there. And here [4] is another thread about the issue with
that callback. The ->release() callback is called at put_device() [5]
and ->shutdown() is called before that [6]. That said, can you inspect
your ->shutdown() implementation once more time and perhaps see if
there is anything that can be amended?

> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/arm64/iort.c#n952
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/host.c#n111

[3]: https://lore.kernel.org/linux-usb/CAHp75Vd-5U5zgtDfM5C3Jsx51HVYB+rNcHYC2XP=G7dOd=cdTg@mail.gmail.com/
[4]:  https://lore.kernel.org/linux-usb/c3c75895-313a-5be7-6421-b32bac741a88@arm.com/T/#u
[5]: https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L2216
[6]: https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L4447

-- 
With Best Regards,
Andy Shevchenko
