Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E5D30E559
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 22:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhBCV6u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 16:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhBCV6t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 16:58:49 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBB9C061573;
        Wed,  3 Feb 2021 13:58:08 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1l7Q9t-0000kb-Rx; Wed, 03 Feb 2021 22:57:57 +0100
Date:   Wed, 3 Feb 2021 22:57:57 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 0/3] Make fw_devlink=on more forgiving
Message-ID: <20210203215757.pnfvfny2x67phyd7@viti.kaiser.cx>
References: <20210202043345.3778765-1-saravanak@google.com>
 <20210202212231.g5tj3f7tv74gagm6@viti.kaiser.cx>
 <CAGETcx_cS_Y-1Bw3tNhZRckEQO=yB8UDzNRr+Khs_X2ym7tnwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_cS_Y-1Bw3tNhZRckEQO=yB8UDzNRr+Khs_X2ym7tnwA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thus wrote Saravana Kannan (saravanak@google.com):

> > With modules disabled, the kernel boots but probe fails for some
> > (non-mainline) drivers in my tree.

> Thanks Martin!

> > All of those drivers have a gpio in
> > their device-tree node, such as

> > my_driver {
> >    gpio_test1 = <&gpio1 0 0>;
> >    ...
> > };

> > with gpio1 from arch/arm/boot/dts/imx25.dtsi.

> > The probe function calls

> > of_get_named_gpio(np, "gpio_test1", 0);

> > to get the gpio. This fails with -EINVAL.

> And you didn't see this issue with the fsl,avic patch?

No. With the fsl,avic patch in place, all drivers are probed correctly.

> The property you are using is not a standard GPIO binding (-gpios,
> gpio, gpios) and I'm not surprised it's not working.

I know that I should be using the gpiod API as suggested by Geert.

BTW is this definition ok? Could its driver be converted to using the
gpiod api?

rtc: rtc {
   compatible = "moxa,moxart-rtc";
   gpio-rtc-sclk = <&gpio 5 0>;
...


> The gpio1 is probably getting probe deferred and ends up running after
> "my_driver".

I added a debug print in the probe function. It turned out that the
driver for gpio1 is probed for the first time after my_driver.

I removed the interrupt-controller property for gpio2 for testing. gpio2
was then probed much earlier.

Best regards,
Martin
