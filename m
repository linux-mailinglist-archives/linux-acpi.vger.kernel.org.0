Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED19E26A4E3
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Sep 2020 14:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIOMRt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 08:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgIOMCK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2020 08:02:10 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE7DC061354
        for <linux-acpi@vger.kernel.org>; Tue, 15 Sep 2020 05:02:09 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id q8so2801297lfb.6
        for <linux-acpi@vger.kernel.org>; Tue, 15 Sep 2020 05:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZJ+GbXc0wmHPJm25O4vi0yPUnebJyibV4Y+lWCt0+0=;
        b=ACGjOsqYMP3W+ZFb5of5vpmVTwBuG62LZrzZaBFgNeYvwqO859mMvZBEYQiJIgQgNb
         UPrbR/VK1ho4Pnoer/NfYREwCfGFQtHrdCs7uLG6InbMc8W/ZhU76BwGSLYnG7IduY61
         FK6Sdakr0Z8ueBxFakucZIQBNwyl72BWcJM734s4RFvGRiqURtUZHHbR6LjHQFePAskz
         HvX2V7eNWpVfrgf914kqkLO/rL1slXoieGLMb32oCzx8iGNLfnE9q9ZH0EpJxxNRKf8o
         Cnm9EJ32p7menxU82yE728RbVvNkzfOqguU5VibAzR4XnpueMNlDGXdyEpF20f4LP/yK
         W7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZJ+GbXc0wmHPJm25O4vi0yPUnebJyibV4Y+lWCt0+0=;
        b=NsbQrUckzUlHs7PpRCNXRszGmyrvm5lSRG0AtP1/Qb9n2KMBJ3FHjuU2+YfYhTzfcR
         h5ZygB4skpRNCz1A9JL0ENBVAd2jLydrUxGplj4m6eHqmv4C1y/j08u7TCCzU/eNEBSW
         KcKW3tHnrktrPjC//e8uiOZubLCyHciyEK0MCZnF/lR+WL8OQkBMi6iFt0lDFmFqxPta
         6MXXD957SK481r5VYrlNUYOyBFX1DN8PESAJBxWdhmx4kFC6nrJRiVIyjI6DvrzNPvTG
         1o2OXga3EAkMoldu3J4112XgtFed9IBIqFT/WBGNQKhAz3OHVoTCRLFCtnbhPyQem+vQ
         gxLw==
X-Gm-Message-State: AOAM532FJdsofcGUi5CA38DKcfpO/ElUp8o/akxjFDY3bV4gKSfs8IIk
        FVxeizRMOqB2e3kNiDW0RnaMPPT/2WpUHRICKmOnCw==
X-Google-Smtp-Source: ABdhPJz+rPNx9r/2oJ8y8WaQrTKm2idA42hHus5emYon+7xs//tS2onQrAkrZ9mxGClX74aBYQ8UCFTLrakGDfzjhsA=
X-Received: by 2002:ac2:54b4:: with SMTP id w20mr6963969lfk.13.1600171327699;
 Tue, 15 Sep 2020 05:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200908125813.8809-1-brgl@bgdev.pl>
In-Reply-To: <20200908125813.8809-1-brgl@bgdev.pl>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 15 Sep 2020 14:01:56 +0200
Message-ID: <CADYN=9+3kHG0CexzZiMQoXdF2piN2ZhOTObhY=7VCKrnFVN0Kw@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpiolib: generalize GPIO line names property
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 8 Sep 2020 at 18:40, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> I initially sent this as part of the gpio-mockup overhaul but since
> these patches are indepentent and the work on gpio-mockup may become
> more complicated - I'm sending these separately.
>
> The only change is adding additional property helpers to count strings
> in array.
>
> Bartosz Golaszewski (3):
>   device: property: add helpers to count items in string arrays
>   gpiolib: generalize devprop_gpiochip_set_names() for device properties
>   gpiolib: unexport devprop_gpiochip_set_names()

I do an arm64 allmodconfig build fron linux-next (tag: next-20200915) and
run that in qemu. When I run I see the following output (see full log [1]):
"BUG: KASAN: null-ptr-deref in device_property_read_string_array".


[ 6186.339462][    T1] unittest-gpio
testcase-data:overlay-node:test-bus:gpio@0: no pinctrl handle
[ 6186.346148][    T1] gpiochip_find_base: found new base at 507
[ 6186.348684][    T1]
==================================================================
[ 6186.351563][    T1] BUG: KASAN: null-ptr-deref in
device_property_read_string_array+0x40/0xa0
[ 6186.355157][    T1] Read of size 8 at addr 0000000000000570 by task
swapper/0/1
[ 6186.358212][    T1]
[ 6186.359361][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G
W         5.9.0-rc5-next-20200915-00006-g104c8fe4916b #1
[ 6186.363877][    T1] Hardware name: linux,dummy-virt (DT)
[ 6186.366156][    T1] Call trace:
[ 6186.367540][    T1]  dump_backtrace+0x0/0x320
[ 6186.369446][    T1]  show_stack+0x38/0x60
[ 6186.371282][    T1]  dump_stack+0x1d4/0x278
[ 6186.373193][    T1]  __kasan_report+0x148/0x180
[ 6186.375265][    T1]  kasan_report+0x44/0xe0
[ 6186.377168][    T1]  __asan_load8+0xbc/0xe0
[ 6186.379069][    T1]  device_property_read_string_array+0x40/0xa0
[ 6186.381741][    T1]  devprop_gpiochip_set_names.isra.0+0x4c/0x200
[ 6186.384394][    T1]  gpiochip_add_data_with_key+0x75c/0xf80
[ 6186.386876][    T1]  unittest_gpio_probe+0xf4/0x1e0
[ 6186.389049][    T1]  platform_drv_probe+0xac/0x160
[ 6186.391184][    T1]  really_probe+0x430/0xaa0
[ 6186.393136][    T1]  really_probe_debug+0x3c/0xe0
[ 6186.395238][    T1]  driver_probe_device+0x134/0x1c0
[ 6186.397443][    T1]  device_driver_attach+0xec/0x180
[ 6186.399639][    T1]  __driver_attach+0x1f0/0x220
[ 6186.401718][    T1]  bus_for_each_dev+0x104/0x1c0
[ 6186.403796][    T1]  driver_attach+0x44/0x60
[ 6186.405731][    T1]  bus_add_driver+0x214/0x3c0
[ 6186.407745][    T1]  driver_register+0x1a8/0x240
[ 6186.409835][    T1]  __platform_driver_register+0x90/0xa0
[ 6186.412207][    T1]  of_unittest_overlay_gpio+0x20c/0x7cc
[ 6186.414595][    T1]  of_unittest_overlay+0x748/0x7c0
[ 6186.416810][    T1]  of_unittest+0x148/0x184
[ 6186.418732][    T1]  do_one_initcall+0xc4/0x280
[ 6186.420782][    T1]  do_initcalls+0x148/0x1ac
[ 6186.422758][    T1]  kernel_init_freeable+0x158/0x1a0
[ 6186.425023][    T1]  kernel_init+0x24/0x1f0
[ 6186.426938][    T1]  ret_from_fork+0x10/0x18
[ 6186.428894][    T1]
==================================================================
[ 6186.433241][    T1] Unable to handle kernel read from unreadable
memory at virtual address 0000000000000570
[ 6186.437207][    T1] Mem abort info:
[ 6186.438639][    T1]   ESR = 0x96000004
[ 6186.440536][    T1]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 6186.442791][    T1]   SET = 0, FnV = 0
[ 6186.444660][    T1]   EA = 0, S1PTW = 0
[ 6186.446233][    T1] Data abort info:
[ 6186.447938][    T1]   ISV = 0, ISS = 0x00000004
[ 6186.449749][    T1]   CM = 0, WnR = 0
[ 6186.451222][    T1] [0000000000000570] user address but active_mm is swapper
[ 6186.454000][    T1] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[ 6186.456422][    T1] Modules linked in:
[ 6186.458232][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B
W         5.9.0-rc5-next-20200915-00006-g104c8fe4916b #1
[ 6186.462833][    T1] Hardware name: linux,dummy-virt (DT)
[ 6186.465170][    T1] pstate: 60400005 (nZCv daif +PAN -UAO BTYPE=--)
[ 6186.467910][    T1] pc : device_property_read_string_array+0x40/0xa0
[ 6186.470653][    T1] lr : device_property_read_string_array+0x40/0xa0
[ 6186.473380][    T1] sp : ffff000069827770
[ 6186.475138][    T1] x29: ffff000069827770 x28: ffffa00014a2cc20
[ 6186.477806][    T1] x27: ffff000068794760 x26: ffff000068794800
[ 6186.480444][    T1] x25: ffff000068794000 x24: ffff0000674e1094
[ 6186.483107][    T1] x23: 0000000000000000 x22: 0000000000000000
[ 6186.485794][    T1] x21: ffffa00012d61ca0 x20: ffffa00012d61200
[ 6186.488457][    T1] x19: 0000000000000000 x18: 00000000000014b8
[ 6186.491100][    T1] x17: 00000000000014f8 x16: 0000000000001438
[ 6186.493779][    T1] x15: 00000000f1f1f1f1 x14: 0000000000000003
[ 6186.496405][    T1] x13: 00000000000ca688 x12: ffff80000d304e7b
[ 6186.499084][    T1] x11: 1fffe0000d304e7a x10: ffff80000d304e7a
[ 6186.501775][    T1] x9 : ffffa00012702b2c x8 : ffff0000698273d7
[ 6186.504409][    T1] x7 : 0000000000000001 x6 : 00007ffff2cfb186
[ 6186.507074][    T1] x5 : 0000000000000000 x4 : dfffa00000000000
[ 6186.509706][    T1] x3 : ffffa000126f85c4 x2 : 0000000000000007
[ 6186.512352][    T1] x1 : ffff00006981c040 x0 : 0000000000000001
[ 6186.515009][    T1] Call trace:
[ 6186.516511][    T1]  device_property_read_string_array+0x40/0xa0
[ 6186.519155][    T1]  devprop_gpiochip_set_names.isra.0+0x4c/0x200
[ 6186.521806][    T1]  gpiochip_add_data_with_key+0x75c/0xf80
[ 6186.524294][    T1]  unittest_gpio_probe+0xf4/0x1e0
[ 6186.526518][    T1]  platform_drv_probe+0xac/0x160
[ 6186.528632][    T1]  really_probe+0x430/0xaa0
[ 6186.530600][    T1]  really_probe_debug+0x3c/0xe0
[ 6186.532679][    T1]  driver_probe_device+0x134/0x1c0
[ 6186.534936][    T1]  device_driver_attach+0xec/0x180
[ 6186.537119][    T1]  __driver_attach+0x1f0/0x220
[ 6186.539182][    T1]  bus_for_each_dev+0x104/0x1c0
[ 6186.541315][    T1]  driver_attach+0x44/0x60
[ 6186.543233][    T1]  bus_add_driver+0x214/0x3c0
[ 6186.545307][    T1]  driver_register+0x1a8/0x240
[ 6186.547373][    T1]  __platform_driver_register+0x90/0xa0
[ 6186.549754][    T1]  of_unittest_overlay_gpio+0x20c/0x7cc
[ 6186.552105][    T1]  of_unittest_overlay+0x748/0x7c0
[ 6186.554272][    T1]  of_unittest+0x148/0x184
[ 6186.556193][    T1]  do_one_initcall+0xc4/0x280
[ 6186.558248][    T1]  do_initcalls+0x148/0x1ac
[ 6186.560227][    T1]  kernel_init_freeable+0x158/0x1a0
[ 6186.562492][    T1]  kernel_init+0x24/0x1f0
[ 6186.564395][    T1]  ret_from_fork+0x10/0x18
[ 6186.566404][    T1] Code: aa0303f7 97b54003 9115c260 97c3ca39 (f942ba74)
[ 6186.569375][    T1] ---[ end trace f489669ae669dad0 ]---
[ 6186.571688][    T1] Kernel panic - not syncing: Oops: Fatal exception
[ 6186.574448][    T1] Kernel Offset: disabled
[ 6186.576306][    T1] CPU features: 0x0240002,20002004
[ 6186.578453][    T1] Memory Limit: none
[ 6186.580215][    T1] ---[ end Kernel panic - not syncing: Oops:
Fatal exception ]---


Cheers,
Anders
[1] http://ix.io/2xDy
