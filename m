Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F24319886
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 04:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhBLDCB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Feb 2021 22:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhBLDBj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2021 22:01:39 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BEAC061793
        for <linux-acpi@vger.kernel.org>; Thu, 11 Feb 2021 19:00:31 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id i71so7716131ybg.7
        for <linux-acpi@vger.kernel.org>; Thu, 11 Feb 2021 19:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2YjH7EUH7e5dFZyK95JFbg4Mk0a2h8e9VHpnb/uN+f4=;
        b=hrrZIRrCawC05z8ys0aGjWa1eOqkwmku4UHqTFr13ZSIA6fT+G2IvzKpKYh9K5dqwn
         NIABQJjxAd28M3i8JvfkPjLBLQwPlGHAgBCTRoMjjkw7ZVxU+l7U68uX4Xm4dneE1KzF
         Vthvf9SBlYUJa8qd4KE1Yplts1yOFoAUi8F+g0z31m5ckKC/LzJo5EcW4YIv6eCp3k51
         nX1yU/6un0qh6l4Um5ikuPa98QpzhY0sgOgYLAseeWfyQ/ejxSsSWx4zVon9MqL/ofF1
         Mlb+0a3lG5bWPnL31fTMQz52NB2wT3ptd77Zg2UC4PQDql2P4piYPqTCvzV9Li53IoTp
         C7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YjH7EUH7e5dFZyK95JFbg4Mk0a2h8e9VHpnb/uN+f4=;
        b=qaJwo8ipJarHrEHIcvqR0/Q17wNzvJbsyYJN5925B85UBJrnRKEbK2/0Vni86fRB+K
         MX3q4JmPWjIQljfVjOXToB200Aa5mZBMIvyqVX1exXcdTKTwka3ZjnLnhP7wDaI/8+Ks
         CvScbld1EQaPa5uPk9APdqmaJEEbTq4iMtN7Ke7ipDCagCpu/CYxneNrsyo9BrzCPvkH
         trJKC3nEtOR9epv+3h29AE5trA67qrzRIiziOBykY45Srshyq+tyRG10l/TQ1GyYxr2v
         lTMhqz6sgrcQp2lVr+LNDNON8ys+aPn1KbZXRE2q7IWQuHWt9ZcDAhi+MaCtZN+XK86U
         afDg==
X-Gm-Message-State: AOAM531l4Yqc0QjaRUZSwoC9EiPlBAg+1dmzhbHduUldeDHwrFnXo8kj
        czW/TuSCD3lGgK7vlUUHxQbzjhEykoGQxEqNQM/Hng==
X-Google-Smtp-Source: ABdhPJw6f1k6YLFcwH8KpWSdfwb1r7O3nU7PUBUXU5E04MP4wEtpHd6uo0Zyq5FVRz5Rb0wmmDnSAoGB1af2cA2rWx0=
X-Received: by 2002:a25:cc89:: with SMTP id l131mr1299415ybf.346.1613098830159;
 Thu, 11 Feb 2021 19:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com> <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com>
In-Reply-To: <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 11 Feb 2021 18:59:54 -0800
Message-ID: <CAGETcx-668+uGigaOMcsvv00mo6o_eGPcH0YyD28OCVEyVbw+w@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Make fw_devlink=on more forgiving
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 11, 2021 at 5:00 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Fri, Feb 5, 2021 at 11:26 PM Saravana Kannan <saravanak@google.com> wrote:
> > There are a lot of devices/drivers where they never have a struct device
> > created for them or the driver initializes the hardware without ever
> > binding to the struct device.
> >
> > This series is intended to avoid any boot regressions due to such
> > devices/drivers when fw_devlink=on and also address the handling of
> > optional suppliers.
> >
> > Patch 1 and 2 addresses the issue of firmware nodes that look like
> > they'll have struct devices created for them, but will never actually
> > have struct devices added for them. For example, DT nodes with a
> > compatible property that don't have devices added for them.
> >
> > Patch 3 and 4 allow for handling optional DT bindings.
> >
> > Patch 5 sets up a generic API to handle drivers that never bind with
> > their devices.
> >
> > Patch 6 through 8 update different frameworks to use the new API.
> >
> > Thanks,
> > Saravana
> >
> > Saravana Kannan (8):
> >   driver core: fw_devlink: Detect supplier devices that will never be
> >     added
> >   of: property: Don't add links to absent suppliers
> >   driver core: Add fw_devlink.strict kernel param
> >   of: property: Add fw_devlink support for optional properties
> >   driver core: fw_devlink: Handle suppliers that don't use driver core
> >   irqdomain: Mark fwnodes when their irqdomain is added/removed
> >   PM: domains: Mark fwnodes when their powerdomain is added/removed
> >   clk: Mark fwnodes when their clock provider is added/removed
>
> Thanks for your series, which is now part of driver-core-next.
> I gave driver-core-next + [1] a try on various Renesas boards.

Thanks!

> Test results are below.
> In general, the result looks much better than before.

Ah, good to hear this.

> [1] - https://lore.kernel.org/lkml/20210210114435.122242-1-tudor.ambarus@microchip.com/
>
>   1. R-Car Gen2 (Koelsch), R-Car Gen3 (Salvator-X(S), Ebisu).
>
>       - Commit 2dfc564bda4a31bc ("soc: renesas: rcar-sysc: Mark device
>         node OF_POPULATED after init") is no longer needed (but already
>         queued for v5.12 anyway)

Rob doesn't like the proliferation of OF_POPULATED and we don't need
it anymore, so maybe work it out with him? It's a balance between some
wasted memory (struct device(s)) vs not proliferating OF_POPULATED.

>       - Some devices are reprobed, despite their drivers returning
>         a real error code, and not -EPROBE_DEFER:

Sorry, it's not obvious from the logs below where "reprobing" is
happening. Can you give more pointers please?

Also, thinking more about this, the only way I could see this happen is:
1. Device fails with error that's not -EPROBE_DEFER
2. It somehow gets added to a device link (with AUTOPROBE_CONSUMER
flag) where it's a consumer.
3. The supplier probes and the device gets added to the deferred probe
list again.

But I can't see how this sequence can happen. Device links are created
only when a device is added. And is the supplier isn't added yet, the
consumer wouldn't have probed in the first place.

Other than "annoying waste of time" is this causing any other problems?

>             renesas_wdt e6020000.watchdog: Watchdog blacklisted on r8a7791 ES1.*
>             (rwdt_probe() returns -ENODEV)
>
>             sh-pfc e6060000.pinctrl: pin GP_7_23 already requested by
> ee090000.pci; cannot claim for e6590000.usb
>             sh-pfc e6060000.pinctrl: pin-247 (e6590000.usb) status -22
>             sh-pfc e6060000.pinctrl: could not request pin 247
> (GP_7_23) from group usb0  on device sh-pfc
>             renesas_usbhs e6590000.usb: Error applying setting,
> reverse things back
>             renesas_usbhs: probe of e6590000.usb failed with error -22
>
>             rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:
>             rcar-pcie fe000000.pcie:       IO
> 0x00fe100000..0x00fe1fffff -> 0x0000000000
>             rcar-pcie fe000000.pcie:      MEM
> 0x00fe200000..0x00fe3fffff -> 0x00fe200000
>             rcar-pcie fe000000.pcie:      MEM
> 0x0030000000..0x0037ffffff -> 0x0030000000
>             rcar-pcie fe000000.pcie:      MEM
> 0x0038000000..0x003fffffff -> 0x0038000000
>             rcar-pcie fe000000.pcie:   IB MEM
> 0x0040000000..0x00bfffffff -> 0x0040000000
>             rcar-pcie fe000000.pcie:   IB MEM
> 0x0200000000..0x02ffffffff -> 0x0200000000
>             rcar-pcie fe000000.pcie: PCIe link down
>             (rcar_pcie_probe() returns -ENODEV)
>
>             xhci-hcd ee000000.usb: xHCI Host Controller
>             xhci-hcd ee000000.usb: new USB bus registered, assigned bus number 7
>             xhci-hcd ee000000.usb: Direct firmware load for
> r8a779x_usb3_v3.dlmem failed with error -2
>             xhci-hcd ee000000.usb: can't setup: -2
>             xhci-hcd ee000000.usb: USB bus 7 deregistered
>             xhci-hcd: probe of ee000000.usb failed with error -2
>
>       - The PCI reprobing leads to a memory leak, for which I've sent a fix
>         "[PATCH] PCI: Fix memory leak in pci_register_io_range()"
>         https://lore.kernel.org/linux-pci/20210202100332.829047-1-geert+renesas@glider.be/

Wrt PCI reprobing,
1. Is this PCI never expected to probe, but it's being reattempted
despite the NOT EPROBE_DEFER error? Or
2. The PCI was deferred probe when it should have probed and then when
it's finally reattemped and it could succeed, we are hitting this mem
leak issue?

I'm basically trying to distinguish between "this stuff should never
be retried" vs "this/it's suppliers got probe deferred with
fw_devlink=on vs but didn't get probe deferred with
fw_devlink=permissive and that's causing issues"

>       - I2C on R-Car Gen3 does not seem to use DMA, according to
>         /sys/kernel/debug/dmaengine/summary:
>
>             -dma4chan0    | e66d8000.i2c:tx
>             -dma4chan1    | e66d8000.i2c:rx
>             -dma5chan0    | e6510000.i2c:tx

I think I need more context on the problem before I can try to fix it.
I'm also very unfamiliar with that file. With fw_devlink=permissive,
I2C was using DMA? If so, the next step is to see if the I2C relative
probe order with DMA is getting changed and if so, why.

>       - Disabling CONFIG_IPMMU_VMSA (IOMMU) now works, good!
>
>            ignoring dependency for device, assuming no driver
>
>       - Disabling CONFIG_RCAR_DMAC works for most devices, except for
>         sound:
>
>             -rcar_sound ec500000.sound: probed
>
>              ALSA device list:
>             -  #0: rcar-sound
>             +  No soundcards found.
>
>             # cat  /sys/kernel/debug/devices_deferred
>             2-0010
>             sound
>             ec500000.sound
>
>             platform e6510000.i2c: Linked as a sync state only
> consumer to ec500000.sound
>             platform ec500000.sound: Linked as a consumer to e6060000.pinctrl
>             platform ec500000.sound: Linked as a consumer to
> e6150000.clock-controller
>             i2c 2-0010: Linked as a consumer to ec500000.sound
>             platform ec500000.sound: Linked as a consumer to 2-004f
>             cs2000-cp 2-004f: revision - C1
>             i2c-rcar e6510000.i2c: probed
>             i2c-rcar e6510000.i2c: Dropping the link to ec500000.sound
>             i2c 2-0010: probe deferral - supplier ec500000.sound not ready
>
>         With CONFIG_RCAR_DMAC=y, ec500000.sound is probed quite early.

I saw your other reply, so I'll ignore this sound/DMA issue.

>
>             arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dts
>
>             ak4613: codec@10 {
>                     clocks = <&rcar_sound 3>;
>
>                     port {
>                             ak4613_endpoint: endpoint {
>                                     remote-endpoint = <&rsnd_endpoint0>;
>                             };
>                     };
>             };
>
>             sound_card: sound {
>                     dais = <&rsnd_port0     /* ak4613 */
>                             &rsnd_port1     /* HDMI0  */
>                             &rsnd_port2>;   /* HDMI1  */
>             };
>
>             rcar_sound: sound@ec500000 {
>                     ports {
>                             rsnd_port0: port@0 {
>                                     rsnd_endpoint0: endpoint {
>                                             remote-endpoint =
> <&ak4613_endpoint>;
>                                     }
>                             }
>                     }
>             };
>
>
>   2. SH/R-Mobile AG5 (kzm9g), APE6 (ape6evm), A1 (armadillo800-eva)
>
>       - "PATCH] soc: renesas: rmobile-sysc: Set OF_POPULATED and absorb
>         reset handling" is no longer needed
>         https://lore.kernel.org/linux-arm-kernel/20210205133319.1921108-1-geert+renesas@glider.be/

Good to see more evidence that this series is fixing things at a more
generic level.

>       - On R-Mobile A1, I get a BUG and a memory leak:
>
>             BUG: spinlock bad magic on CPU#0, swapper/1
>              lock: lcdc0_device+0x10c/0x308, .magic: 00000000, .owner:
> <none>/-1, .owner_cpu: 0
>             CPU: 0 PID: 1 Comm: swapper Not tainted
> 5.11.0-rc5-armadillo-00032-gf0a85c26907e #266
>             Hardware name: Generic R8A7740 (Flattened Device Tree)
>             [<c010c3c8>] (unwind_backtrace) from [<c010a49c>]
> (show_stack+0x10/0x14)
>             [<c010a49c>] (show_stack) from [<c0159534>]
> (do_raw_spin_lock+0x20/0x94)
>             [<c0159534>] (do_raw_spin_lock) from [<c04089d8>]
> (dev_pm_get_subsys_data+0x30/0xa0)
>             [<c04089d8>] (dev_pm_get_subsys_data) from [<c0413698>]
> (genpd_add_device+0x34/0x1c0)
>             [<c0413698>] (genpd_add_device) from [<c041389c>]
> (of_genpd_add_device+0x34/0x4c)
>             [<c041389c>] (of_genpd_add_device) from [<c0a1e9bc>]
> (board_staging_register_device+0xf8/0x118)
>             [<c0a1e9bc>] (board_staging_register_device) from
> [<c0a1ea00>] (board_staging_register_devices+0x24/0x28)
>             [<c0a1ea00>] (board_staging_register_devices) from
> [<c0a1ea30>] (runtime_board_check+0x2c/0x40)
>             [<c0a1ea30>] (runtime_board_check) from [<c0101fac>]
> (do_one_initcall+0xe0/0x278)
>             [<c0101fac>] (do_one_initcall) from [<c0a01034>]
> (kernel_init_freeable+0x174/0x1c0)
>             [<c0a01034>] (kernel_init_freeable) from [<c05fd568>]
> (kernel_init+0x8/0x118)
>             [<c05fd568>] (kernel_init) from [<c010011c>]
> (ret_from_fork+0x14/0x38)
>             Exception stack(0xc19c9fb0 to 0xc19c9ff8)
>             9fa0:                                     00000000
> 00000000 00000000 00000000
>             9fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
>             9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>
>             unreferenced object 0xc4134e00 (size 512):
>               comm "swapper", pid 1, jiffies 4294937296 (age 3541.930s)
>               hex dump (first 32 bytes):
>                 00 4e 13 c4 00 4e 13 c4 ff ff ff 7f ff ff ff 7f
> .N...N..........
>                 ff ff ff 7f 02 00 00 00 00 5f 13 c4 1c 4e 13 c4
> ........._...N..
>               backtrace:
>                 [<de1a3c34>] dev_pm_qos_constraints_allocate+0x10/0xcc
>                 [<d21cf6e4>] dev_pm_qos_add_notifier+0x6c/0xd0
>                 [<e04bbc90>] genpd_add_device+0x178/0x1c0
>                 [<95067303>] of_genpd_add_device+0x34/0x4c
>                 [<c334b97a>] board_staging_register_device+0xf8/0x118
>                 [<01bd495a>] board_staging_register_devices+0x24/0x28
>                 [<fb25a5d8>] runtime_board_check+0x2c/0x40
>                 [<65aed679>] do_one_initcall+0xe0/0x278
>                 [<97e3f4f7>] kernel_init_freeable+0x174/0x1c0
>                 [<63c8fed0>] kernel_init+0x8/0x118
>                 [<f704d96c>] ret_from_fork+0x14/0x38
>                 [<00000000>] 0x0

Hmm... I looked at this in bits and pieces throughout the day. At
least spent an hour looking at this. This doesn't make a lot of sense
to me. I don't even touch anything in this code path AFAICT.  Are
modules/kernel mixed up somehow? I need more info before I can help.
Does reverting my pm domain change make any difference (assume it
boots this far without it).

>
>   3. RZ/A1 and RZ/A2: No issues.

Great!

-Saravana
