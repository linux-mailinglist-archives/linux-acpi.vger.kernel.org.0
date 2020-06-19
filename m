Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49716201BFA
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jun 2020 22:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733039AbgFSUIL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Jun 2020 16:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731854AbgFSUIK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2020 16:08:10 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB81DC0613EF
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2020 13:08:10 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id q188so2140065ooq.4
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2020 13:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6cChN1CWJKAIkfkaDzcS4umHpeFkFLGnn2w8hUos2oI=;
        b=q6lwCzCD+nc+ZvxijEpZHJ3Hp1Eh+wg0jLHu+ESMzOz9HPbhomMmAdLQIps/HyaMN8
         tBqKXXjTVdtVWvqEqCVpxtA6GcUpmj6q/fCRfKZ34EZluf76f/sJpOug+Du0mwd+zbKs
         iwxl3f/6W0/0kwNWXi1m/wmGFdUVy+kjMe+l0MwepRdFDpGUinJWCU6UG/FYx5utqsan
         5KeRuUuKhCZGldyvFxRffNQTFjDhJM1Pj/+9/cuBaf1W7iV5fcBt8WoKnzcCRKWFGu6k
         1+ysmFEh8UhjJO++6bdbIU3giHNhSMgtjfTtc+YGOfxGx1ypt/RT5urPugI2L6mV48XN
         qFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6cChN1CWJKAIkfkaDzcS4umHpeFkFLGnn2w8hUos2oI=;
        b=YGw8BmJby0iCeFQPqVQ8xHs75c4K2UWK0hGICqyDntyrLpzvf4LaMlmVeakjfR8uO0
         5UU/OmcpQMgLDugC5FVaJEgjz7VLY4R7LSuht/x3haVHG9LBMJkFt+3jiUUESXZLfBX6
         e9ilUsOtq5n8MH27zTcksIaJ5DoZIGsxqM/CVWbRMmcAfbJkpFMfoFCWU7eBgjrkathR
         uzaX/oThdSzyURDEKMzK1wv8uM1auQqkL0EGRIfiH0OXFpIU71mB0oE+bnP8ms8jz0uF
         xgFFD+Jj6Dvqp4ynraJmlQfw3V0ucXmiyGGJ7nflQUOOoZQO4dQipSt21x2wrfEJdf2q
         lENQ==
X-Gm-Message-State: AOAM532Vh+J444T2A+EPsFMRvYwVVBZkbQY25/i6poH9LYYHmvHbtLfL
        kY8l5FQwcpOcAGN8QfUZ8Sjkslua0+GwY0mrSMg76w==
X-Google-Smtp-Source: ABdhPJxq+u3aiSnnm9ryW3GqhCLWVL1G2jUnd7WtdsL4sMJKoJqYGI0+CY1vicH2J/uzXbApgUXWAErr+EQMPVVJO+s=
X-Received: by 2002:a4a:374b:: with SMTP id r72mr4855925oor.15.1592597289633;
 Fri, 19 Jun 2020 13:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com> <20200515053500.215929-5-saravanak@google.com>
 <CAMuHMdUnbDvn6GdK51MN-+5iRp6zYRf-yzKY+OwcQOGrYqOZPA@mail.gmail.com>
 <CAGETcx9JKbNQWQwNah7pO5ppVSAe86R-OmMujZPYNkuTCLwKnQ@mail.gmail.com>
 <CAMuHMdU2gF=aTeVxRvtzAMLGY=GyBDfBwrYZxoRkL1tV7dL56g@mail.gmail.com>
 <CAGETcx-rHFthf-aLb_S-ST6Evozvgis5XX5u0LNxyvfMoJOLKQ@mail.gmail.com> <CAMuHMdXW0jM-A5cvYtFVcgc1Gm3tKkvr0+kWpeJqpJDzNOuYeA@mail.gmail.com>
In-Reply-To: <CAMuHMdXW0jM-A5cvYtFVcgc1Gm3tKkvr0+kWpeJqpJDzNOuYeA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 19 Jun 2020 13:07:33 -0700
Message-ID: <CAGETcx8W96KAw-d_siTX4qHB_-7ddk0miYRDQeHE6E0_8qx-6Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding all
 top level devices
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

Snipped a bunch of old context.

On Fri, Jun 19, 2020 at 5:24 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Fri, Jun 19, 2020 at 1:01 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > When you say the "The affected drivers are still probed in the same
> > order", are you only referring to the devices that would have probed
> > before of_platform_default_populate_init() returns? Or ALL devices in
> > the system are probing in the same order?
>
> I was referring to all platform devices (based on a debug print added to
> platform_drv_probe()). See more below.
>
> > I assume gpio-keys gets probed in the "normal init thread" and not by
> > the deferred probe workqueue? I'm guessing this because gpio_keys
> > driver seems to register during late_initcall() whereas
> > of_platform_default_populate_init() runs as an arch_initcall_sync().
>
> After adding a WARN(1, ...) to gpio_keys_probe(), the backtrace shows it
> is called directly from do_one_initcall(), in both the good and the bad
> case.
>
> > > However, during
> > > system suspend, gpio-keys is suspended before INTC, which is wrong, as
> > > gpio-keys uses an interrupt provided by INTC.
> > >
> > > Perhaps the "in parallel" is the real culprit, and there is a race
> > > condition somewhere?
> >
> > I tried digging into the gpio_keys driver code to see how it interacts
> > with INTC and if gpio-keys defers probe if INTC hasn't probed yet. But
> > it seems like a rabbit hole that'd be easier to figure out when you
> > have the device. Can you check if gpio-keys is probing before INTC in
> > the "bad" case?
>
> It is not, gpio-keys is always probed very late.
>
> Hence for testing, I moved gpio-keys initialization just before INTC, so
> it is probed before INTC. Then gpio-keys is deferred, as expected, and
> reprobes successfully later.
> Interestingly, that fixes my wake-up issue, too?!?
>
> > Also, in general, can you see if there's a difference in the probe
> > order between all the devices in the system? Adding a log to
> > really_probe() would be better in case non-platform devices are
> > getting reordered (my change affects all devices that are created from
> > DT, not just platform devices).
> >
> > I want to make sure we understand the real issue before we try to fix it.
>
> Enabling all debug prints in really_probe(), comparing the output
> before/after the bad commit, and filtering out all noise, I get:
>
>      bus: 'platform': really_probe: probing driver reg-dummy with
> device reg-dummy
> B    bus: 'platform': really_probe: probing driver renesas_intc_irqpin
> with device e6900000.interrupt-controller
>      bus: 'platform': really_probe: probing driver renesas_intc_irqpin
> with device e6900004.interrupt-controller
> A   +Workqueue: events deferred_probe_work_func
>      bus: 'platform': really_probe: probing driver renesas_intc_irqpin
> with device e6900008.interrupt-controller
> C    bus: 'platform': really_probe: probing driver renesas_intc_irqpin
> with device e690000c.interrupt-controller
>      bus: 'platform': really_probe: probing driver sh-pfc with device
> e6050000.pin-controller
>      bus: 'platform': really_probe: probing driver reg-fixed-voltage
> with device regulator-1p8v
>      bus: 'platform': really_probe: probing driver reg-fixed-voltage
> with device regulator-3p3v
>      bus: 'platform': really_probe: probing driver reg-fixed-voltage
> with device regulator-vmmc-sdhi0
>      bus: 'platform': really_probe: probing driver reg-fixed-voltage
> with device regulator-vmmc-sdhi2
>      bus: 'platform': really_probe: probing driver i2c-sh_mobile with
> device e6820000.i2c
>      bus: 'i2c': really_probe: probing driver as3711 with device 0-0040
>      bus: 'platform': really_probe: probing driver as3711-regulator
> with device as3711-regulator
>      bus: 'platform': really_probe: probing driver i2c-sh_mobile with
> device e6822000.i2c
>      bus: 'platform': really_probe: probing driver i2c-sh_mobile with
> device e6826000.i2c
>      bus: 'i2c': really_probe: probing driver pcf857x with device 2-0020
>      bus: 'platform': really_probe: probing driver sh_cmt with device
> e6138000.timer
>      bus: 'platform': really_probe: probing driver armv7-pmu with device pmu
>      bus: 'platform': really_probe: probing driver simple-pm-bus with
> device fec10000.bus
>      bus: 'platform': really_probe: probing driver as3711-backlight
> with device as3711-backlight
>      bus: 'platform': really_probe: probing driver sh-sci with device
> e6c80000.serial
>      bus: 'platform': really_probe: probing driver smsc911x with
> device 10000000.ethernet
>      bus: 'i2c': really_probe: probing driver st1232-ts with device 1-0055
>      bus: 'i2c': really_probe: probing driver adxl34x with device 0-001d
>      bus: 'i2c': really_probe: probing driver rtc-rs5c372 with device 0-0032
>      bus: 'platform': really_probe: probing driver rmobile_reset with
> device e6180000.system-controller
>      bus: 'platform': really_probe: probing driver cpufreq-dt with
> device cpufreq-dt
>      bus: 'platform': really_probe: probing driver sh_mobile_sdhi with
> device ee100000.sd
>      bus: 'platform': really_probe: probing driver sh_mobile_sdhi with
> device ee140000.sd
>      bus: 'platform': really_probe: probing driver sh_mmcif with
> device e6bd0000.mmc
>      bus: 'platform': really_probe: probing driver leds-gpio with device leds
>      bus: 'i2c': really_probe: probing driver ak8975 with device 0-000c
>      bus: 'platform': really_probe: probing driver snd-soc-dummy with
> device snd-soc-dummy
>      bus: 'i2c': really_probe: probing driver ak4642-codec with device 0-0012
>      bus: 'platform': really_probe: probing driver asoc-simple-card
> with device sound
>      bus: 'platform': really_probe: probing driver fsi-pcm-audio with
> device ec230000.sound
>      bus: 'platform': really_probe: probing driver asoc-simple-card
> with device sound
>      bus: 'platform': really_probe: probing driver gpio-keys with
> device keyboard"
>      bus: 'mmc': really_probe: probing driver mmcblk with device mmc2:0001
>
> So all devices are probed in the exact same order.
> A: Note the addition of the message "Workqueue: events
>    deferred_probe_work_func", which might give a clue?
> B,C: "e6900000.interrupt-controller" and "e6900008.interrupt-controller"
>      are the two devices that are suspended later in the wrong order.
>      One of them is probed before A, one after, so A may be a red herring?
>

Thanks! Your logs and the tip above helped!

*face palm*/Sigh... (for what is happening)

In the absence of other info (like device links, parent-child
relationship, etc) the device_add() order is used as an implicit order
for suspend (in reverse) and resume.
device_add() -> device_pm_add() -> list_add_tail(..., &dpm_list)

But the deferred probe code reorders the deferred devices:
deferred_probe_work_func() -> device_pm_move_to_tail()

So, this is what is happening:
1. of_platform_default_populate() adds all the top level devices in DT order.
2. So dpm_list is: ... INTC, ..., gpio-keys
3. Only devices with drivers already registered by this time get added
to the deferred probe list (because that only happens when a driver
matches)
4. INTC is one of them.
5. So when deferred_probe_work_func() gets to INTC, it moves it to the
end of the dpm_list
6. So dpm_list is now: ..., gpio-keys, ... INTC

Things fail.

Obviously, my patch is causing this unintended behavior and I could
try to fix it. But I'm not really sure if the actual bug is in my
patch...

Deferred probe is supposed to allow a driver to defer probe without
worrying something else is going to get screwed up. Also, order of
devices in DT isn't supposed to affect functionality. Both of these
are not true with the current behavior.

I think instead of deferred_probe_work_func() moving the device to the
end of the dpm_list, I think the device probing successfully is what
should move it to the end of the dpm_list. That way, the dpm_list is
actually ordered by when the devices become functional and not the
random order in DT or random probe order which can get pretty
convoluted with multiple deferred probes. This feels right and will
make suspend/resume more robust against DT ordering -- but I'm not
sure what other wide ranging impact this has for other platforms.

Greg/Rafael, do you agree with the paragraph above? If yes, I can send
a patch out that orders dpm_list by probe success order.

Thanks,
Saravana
