Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42266200895
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jun 2020 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbgFSMZM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Jun 2020 08:25:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38493 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731186AbgFSMYx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2020 08:24:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id n70so7116476ota.5;
        Fri, 19 Jun 2020 05:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1B2NFl3JAjViF1CAa+xtmFOsezmy3C5BI/HUiPc0QI=;
        b=NjyOb5gG7/2s+XNqj/zxphJTB2jrD3mDmX3eekQXZa4m1MewIpMEeF3kfXksID6L7S
         sKJFx1IISbF7L0rPSQ+AENzXTmBkcjMTKZ3Fayt83f9Yh301UXJhB1dyxZ0ndlsujmIn
         ItDMWyjguk8cwGHBTdOUBZmYg16XvQSLxIdQpYOXIfzoFTkROaUcqf8O8XP6c+rKCD59
         3CCjZ06H/P4BoLlIFaoqIZ+5DzuHfQXpFlGc/xp7CIvDL4lcm77W9gG9pSBo4q08WvGl
         k6/xymn8ybR9FrBU1pPGHuD3Tk+9ixsBi86ujTUeNGlcPh69Gl+wgxsIujnws1RRMkc0
         AzAw==
X-Gm-Message-State: AOAM530lGFQ2B+qF9N3piomF5yhC8hmXBB0eo1+otNNW3u+SYWqJDhU4
        ObICt8/dRrq9YB5dHBdEdY7ldonchaTs9rU3hTo=
X-Google-Smtp-Source: ABdhPJyIdEZpFkGflO2lHluTi8nQiQnP6OpD8brttkDx/ry6OUgTubCl1sWqGuF5B5i/usx18bcMU38DST4NDGnymu4=
X-Received: by 2002:a05:6830:141a:: with SMTP id v26mr2810640otp.250.1592569491903;
 Fri, 19 Jun 2020 05:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com> <20200515053500.215929-5-saravanak@google.com>
 <CAMuHMdUnbDvn6GdK51MN-+5iRp6zYRf-yzKY+OwcQOGrYqOZPA@mail.gmail.com>
 <CAGETcx9JKbNQWQwNah7pO5ppVSAe86R-OmMujZPYNkuTCLwKnQ@mail.gmail.com>
 <CAMuHMdU2gF=aTeVxRvtzAMLGY=GyBDfBwrYZxoRkL1tV7dL56g@mail.gmail.com> <CAGETcx-rHFthf-aLb_S-ST6Evozvgis5XX5u0LNxyvfMoJOLKQ@mail.gmail.com>
In-Reply-To: <CAGETcx-rHFthf-aLb_S-ST6Evozvgis5XX5u0LNxyvfMoJOLKQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Jun 2020 14:24:40 +0200
Message-ID: <CAMuHMdXW0jM-A5cvYtFVcgc1Gm3tKkvr0+kWpeJqpJDzNOuYeA@mail.gmail.com>
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

On Fri, Jun 19, 2020 at 1:01 AM Saravana Kannan <saravanak@google.com> wrote:
> On Thu, Jun 18, 2020 at 12:32 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Wed, Jun 17, 2020 at 8:36 PM Saravana Kannan <saravanak@google.com> wrote:
> > > On Wed, Jun 17, 2020 at 5:20 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Fri, May 15, 2020 at 7:38 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > > The fw_devlink_pause() and fw_devlink_resume() APIs allow batching the
> > > > > parsing of the device tree nodes when a lot of devices are added. This
> > > > > will significantly cut down parsing time (as much a 1 second on some
> > > > > systems). So, use them when adding devices for all the top level device
> > > > > tree nodes in a system.
> > > > >
> > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > >
> > > > This is now commit 93d2e4322aa74c1a ("of: platform: Batch fwnode parsing
> > > > when adding all top level devices") in v5.8-rc1, and I have bisected a
> > > > regression to it: on r8a7740/armadillo and sh73a0/kzm9g, the system can
> > > > no longer be woken up from s2ram by a GPIO key. Reverting the commit
> > > > fixes the issue.
> > > >
> > > > On these systems, the GPIO/PFC block has its interrupt lines connected
> > > > to intermediate interrupt controllers (Renesas INTC), which are in turn
> > > > connected to the main interrupt controller (ARM GIC).  The INTC block is
> > > > part of a power and clock domain.  Hence if a GPIO is enabled as a
> > > > wake-up source, the INTC is part of the wake-up path, and thus must be
> > > > kept enabled when entering s2ram.
> > > >
> > > > While this commit has no impact on probe order for me (unlike in Marek's
> > > > case), it does have an impact on suspend order:
> > > >   - Before this commit:
> > > >       1. The keyboard (gpio-keys) is suspended, and calls
> > > >          enable_irq_wake() to inform the upstream interrupt controller
> > > >          (INTC) that it is part of the wake-up path,
> > > >       2. INTC is suspended, and calls device_set_wakeup_path() to inform
> > > >          the device core that it must be kept enabled,
> > > >       3. The system is woken by pressing a wake-up key.
> > > >
> > > >   - After this commit:
> > > >       1. INTC is suspended, and is not aware it is part of the wake-up
> > > >          path, so it is disabled by the device core,
> > > >       2. gpio-keys is suspended, and calls enable_irq_wake() in vain,
> > > >       3. Pressing a wake-up key has no effect, as INTC is disabled, and
> > > >          the interrupt does not come through.
> > > >
> > > > It looks like no device links are involved, as both gpio-keys and INTC have
> > > > no links.
> > > > Do you have a clue?
> > > >
> > > > Thanks!
> > >
> > > That patch of mine defers probe on all devices added by the
> > > of_platform_default_populate() call, and then once the call returns,
> > > it immediately triggers a deferred probe.
> > >
> > > So all these devices are being probed in parallel in the deferred
> > > probe workqueue while the main "initcall thread" continues down to
> > > further initcalls. It looks like some of the drivers in subsequent
> > > initcalls are assuming that devices in the earlier initcalls always
> > > probe and can't be deferred?
> > >
> > > There are two options.
> > > 1. Fix these drivers.
> > > 2. Add a "flush deferred workqueue" in fw_devlink_resume()
> > >
> > > I'd rather we fix the drivers so that they handle deferred probes
> > > correctly. Thoughts?
> >
> > While the affected drivers should handle deferred probe fine, none of
> > the affected drivers is subject to deferred probing: they all probe
> > successfully on first try (I had added debug prints to
> > platform_drv_probe() to be sure).
> > The affected drivers are still probed in the same order (INTC is one of
> > the earliest drivers probed, gpio-keys is the last).
>
> Thanks, this is useful info. Now I know that my patch isn't somehow
> reordering devices that would have probed as soon as
> of_platform_default_populate_init() added them.
>
> When you say the "The affected drivers are still probed in the same
> order", are you only referring to the devices that would have probed
> before of_platform_default_populate_init() returns? Or ALL devices in
> the system are probing in the same order?

I was referring to all platform devices (based on a debug print added to
platform_drv_probe()). See more below.

> I assume gpio-keys gets probed in the "normal init thread" and not by
> the deferred probe workqueue? I'm guessing this because gpio_keys
> driver seems to register during late_initcall() whereas
> of_platform_default_populate_init() runs as an arch_initcall_sync().

After adding a WARN(1, ...) to gpio_keys_probe(), the backtrace shows it
is called directly from do_one_initcall(), in both the good and the bad
case.

> > However, during
> > system suspend, gpio-keys is suspended before INTC, which is wrong, as
> > gpio-keys uses an interrupt provided by INTC.
> >
> > Perhaps the "in parallel" is the real culprit, and there is a race
> > condition somewhere?
>
> I tried digging into the gpio_keys driver code to see how it interacts
> with INTC and if gpio-keys defers probe if INTC hasn't probed yet. But
> it seems like a rabbit hole that'd be easier to figure out when you
> have the device. Can you check if gpio-keys is probing before INTC in
> the "bad" case?

It is not, gpio-keys is always probed very late.

Hence for testing, I moved gpio-keys initialization just before INTC, so
it is probed before INTC. Then gpio-keys is deferred, as expected, and
reprobes successfully later.
Interestingly, that fixes my wake-up issue, too?!?

> Also, in general, can you see if there's a difference in the probe
> order between all the devices in the system? Adding a log to
> really_probe() would be better in case non-platform devices are
> getting reordered (my change affects all devices that are created from
> DT, not just platform devices).
>
> I want to make sure we understand the real issue before we try to fix it.

Enabling all debug prints in really_probe(), comparing the output
before/after the bad commit, and filtering out all noise, I get:

     bus: 'platform': really_probe: probing driver reg-dummy with
device reg-dummy
B    bus: 'platform': really_probe: probing driver renesas_intc_irqpin
with device e6900000.interrupt-controller
     bus: 'platform': really_probe: probing driver renesas_intc_irqpin
with device e6900004.interrupt-controller
A   +Workqueue: events deferred_probe_work_func
     bus: 'platform': really_probe: probing driver renesas_intc_irqpin
with device e6900008.interrupt-controller
C    bus: 'platform': really_probe: probing driver renesas_intc_irqpin
with device e690000c.interrupt-controller
     bus: 'platform': really_probe: probing driver sh-pfc with device
e6050000.pin-controller
     bus: 'platform': really_probe: probing driver reg-fixed-voltage
with device regulator-1p8v
     bus: 'platform': really_probe: probing driver reg-fixed-voltage
with device regulator-3p3v
     bus: 'platform': really_probe: probing driver reg-fixed-voltage
with device regulator-vmmc-sdhi0
     bus: 'platform': really_probe: probing driver reg-fixed-voltage
with device regulator-vmmc-sdhi2
     bus: 'platform': really_probe: probing driver i2c-sh_mobile with
device e6820000.i2c
     bus: 'i2c': really_probe: probing driver as3711 with device 0-0040
     bus: 'platform': really_probe: probing driver as3711-regulator
with device as3711-regulator
     bus: 'platform': really_probe: probing driver i2c-sh_mobile with
device e6822000.i2c
     bus: 'platform': really_probe: probing driver i2c-sh_mobile with
device e6826000.i2c
     bus: 'i2c': really_probe: probing driver pcf857x with device 2-0020
     bus: 'platform': really_probe: probing driver sh_cmt with device
e6138000.timer
     bus: 'platform': really_probe: probing driver armv7-pmu with device pmu
     bus: 'platform': really_probe: probing driver simple-pm-bus with
device fec10000.bus
     bus: 'platform': really_probe: probing driver as3711-backlight
with device as3711-backlight
     bus: 'platform': really_probe: probing driver sh-sci with device
e6c80000.serial
     bus: 'platform': really_probe: probing driver smsc911x with
device 10000000.ethernet
     bus: 'i2c': really_probe: probing driver st1232-ts with device 1-0055
     bus: 'i2c': really_probe: probing driver adxl34x with device 0-001d
     bus: 'i2c': really_probe: probing driver rtc-rs5c372 with device 0-0032
     bus: 'platform': really_probe: probing driver rmobile_reset with
device e6180000.system-controller
     bus: 'platform': really_probe: probing driver cpufreq-dt with
device cpufreq-dt
     bus: 'platform': really_probe: probing driver sh_mobile_sdhi with
device ee100000.sd
     bus: 'platform': really_probe: probing driver sh_mobile_sdhi with
device ee140000.sd
     bus: 'platform': really_probe: probing driver sh_mmcif with
device e6bd0000.mmc
     bus: 'platform': really_probe: probing driver leds-gpio with device leds
     bus: 'i2c': really_probe: probing driver ak8975 with device 0-000c
     bus: 'platform': really_probe: probing driver snd-soc-dummy with
device snd-soc-dummy
     bus: 'i2c': really_probe: probing driver ak4642-codec with device 0-0012
     bus: 'platform': really_probe: probing driver asoc-simple-card
with device sound
     bus: 'platform': really_probe: probing driver fsi-pcm-audio with
device ec230000.sound
     bus: 'platform': really_probe: probing driver asoc-simple-card
with device sound
     bus: 'platform': really_probe: probing driver gpio-keys with
device keyboard"
     bus: 'mmc': really_probe: probing driver mmcblk with device mmc2:0001

So all devices are probed in the exact same order.
A: Note the addition of the message "Workqueue: events
   deferred_probe_work_func", which might give a clue?
B,C: "e6900000.interrupt-controller" and "e6900008.interrupt-controller"
     are the two devices that are suspended later in the wrong order.
     One of them is probed before A, one after, so A may be a red herring?

I'm still not much wiser, though....

BTW, r8a7740/armadillo is single CPU, while sh73a0/kzm9g is dual-CPU.
So both UP and SMP are affected.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
