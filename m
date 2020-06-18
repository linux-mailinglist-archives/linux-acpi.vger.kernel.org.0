Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FD91FEC7C
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jun 2020 09:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgFRHcK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Jun 2020 03:32:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41656 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgFRHcK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2020 03:32:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id k15so3780769otp.8;
        Thu, 18 Jun 2020 00:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEd1sSUwdgNZZk5MhGirM5YmWviEJTOtC4NnWjH7dvs=;
        b=JgZzxUhwYl2Oo1Y5a2+Y8lVtmKr9ba0dl2S8Zr8HxiIv19FlMPOI/N2pMb/eaC0oSf
         4tjY8OFZld1MeXJWrYXQMp4yqSVfzZe+anLZPoZuhuEbcpD+C8mZ5qO81nCXFAWDg0qZ
         1s/bQRuMNuJ4Dhp1CqM+P9W1E1b3IvZ07wxESuve4RkOmcqK1OxnffOkQa0gNYKzZVyJ
         qMDtDgsktFDJeFdYwsod29Eo3gskFSLBOZahCRREVDgaKLCwV5Kb2PdH3wiurEvckN53
         w4+FvBhLiwcvAkbKdrkQUpDyjOh25LOe+g1VKMk9S89/v06ORulhpd0/IrAAKJtejhvX
         +d1w==
X-Gm-Message-State: AOAM530dKxiQ2n7T9rraLR9cfskMnXTu0TYjhq65MePO0KXNXFZsiIDK
        jG4y5Z9RxUBzf0BTLNtbdWpDIpnUZKj9EULsmXU0eU6c
X-Google-Smtp-Source: ABdhPJzv7NazxpQziK4ICo68wZfq8CFtvcli0G2OvLQydZwJFlaOxvB3Z1eIrjApn1tJkAreg7GGVY1NGQagEfYp5l0=
X-Received: by 2002:a05:6830:141a:: with SMTP id v26mr2368151otp.250.1592465527028;
 Thu, 18 Jun 2020 00:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com> <20200515053500.215929-5-saravanak@google.com>
 <CAMuHMdUnbDvn6GdK51MN-+5iRp6zYRf-yzKY+OwcQOGrYqOZPA@mail.gmail.com> <CAGETcx9JKbNQWQwNah7pO5ppVSAe86R-OmMujZPYNkuTCLwKnQ@mail.gmail.com>
In-Reply-To: <CAGETcx9JKbNQWQwNah7pO5ppVSAe86R-OmMujZPYNkuTCLwKnQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Jun 2020 09:31:55 +0200
Message-ID: <CAMuHMdU2gF=aTeVxRvtzAMLGY=GyBDfBwrYZxoRkL1tV7dL56g@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding all
 top level devices
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ji Luo <ji.luo@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Saravana,

On Wed, Jun 17, 2020 at 8:36 PM Saravana Kannan <saravanak@google.com> wrote:
> On Wed, Jun 17, 2020 at 5:20 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, May 15, 2020 at 7:38 AM Saravana Kannan <saravanak@google.com> wrote:
> > > The fw_devlink_pause() and fw_devlink_resume() APIs allow batching the
> > > parsing of the device tree nodes when a lot of devices are added. This
> > > will significantly cut down parsing time (as much a 1 second on some
> > > systems). So, use them when adding devices for all the top level device
> > > tree nodes in a system.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >
> > This is now commit 93d2e4322aa74c1a ("of: platform: Batch fwnode parsing
> > when adding all top level devices") in v5.8-rc1, and I have bisected a
> > regression to it: on r8a7740/armadillo and sh73a0/kzm9g, the system can
> > no longer be woken up from s2ram by a GPIO key. Reverting the commit
> > fixes the issue.
> >
> > On these systems, the GPIO/PFC block has its interrupt lines connected
> > to intermediate interrupt controllers (Renesas INTC), which are in turn
> > connected to the main interrupt controller (ARM GIC).  The INTC block is
> > part of a power and clock domain.  Hence if a GPIO is enabled as a
> > wake-up source, the INTC is part of the wake-up path, and thus must be
> > kept enabled when entering s2ram.
> >
> > While this commit has no impact on probe order for me (unlike in Marek's
> > case), it does have an impact on suspend order:
> >   - Before this commit:
> >       1. The keyboard (gpio-keys) is suspended, and calls
> >          enable_irq_wake() to inform the upstream interrupt controller
> >          (INTC) that it is part of the wake-up path,
> >       2. INTC is suspended, and calls device_set_wakeup_path() to inform
> >          the device core that it must be kept enabled,
> >       3. The system is woken by pressing a wake-up key.
> >
> >   - After this commit:
> >       1. INTC is suspended, and is not aware it is part of the wake-up
> >          path, so it is disabled by the device core,
> >       2. gpio-keys is suspended, and calls enable_irq_wake() in vain,
> >       3. Pressing a wake-up key has no effect, as INTC is disabled, and
> >          the interrupt does not come through.
> >
> > It looks like no device links are involved, as both gpio-keys and INTC have
> > no links.
> > Do you have a clue?
> >
> > Thanks!
>
> That patch of mine defers probe on all devices added by the
> of_platform_default_populate() call, and then once the call returns,
> it immediately triggers a deferred probe.
>
> So all these devices are being probed in parallel in the deferred
> probe workqueue while the main "initcall thread" continues down to
> further initcalls. It looks like some of the drivers in subsequent
> initcalls are assuming that devices in the earlier initcalls always
> probe and can't be deferred?
>
> There are two options.
> 1. Fix these drivers.
> 2. Add a "flush deferred workqueue" in fw_devlink_resume()
>
> I'd rather we fix the drivers so that they handle deferred probes
> correctly. Thoughts?

While the affected drivers should handle deferred probe fine, none of
the affected drivers is subject to deferred probing: they all probe
successfully on first try (I had added debug prints to
platform_drv_probe() to be sure).
The affected drivers are still probed in the same order (INTC is one of
the earliest drivers probed, gpio-keys is the last). However, during
system suspend, gpio-keys is suspended before INTC, which is wrong, as
gpio-keys uses an interrupt provided by INTC.

Perhaps the "in parallel" is the real culprit, and there is a race
condition somewhere?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
