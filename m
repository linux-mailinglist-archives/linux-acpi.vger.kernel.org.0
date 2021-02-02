Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562E230CF4C
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 23:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbhBBWpQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 17:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbhBBWoy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 17:44:54 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C55C06178B
        for <linux-acpi@vger.kernel.org>; Tue,  2 Feb 2021 14:44:13 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id j84so8889272ybg.1
        for <linux-acpi@vger.kernel.org>; Tue, 02 Feb 2021 14:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEYLnC3u7WyEhbD/FKNwftU+z2oHAmMTCcdaokM12wo=;
        b=Kl5ucGfgQsN2LtKbePCNETb96lKRFopLBGQF/DpYpWRc1FQNPBOCK2ZS8XoXGW3eMG
         PoRcqg6PSR+bQ6iCMnzll+P2o3Tmq1vQXQZgyQozkJqlDCB6tUvycOoYABEtGqFEK5SC
         HrqDPwICnSLuiQp4oI1z4KLxG31cR6216VEIostl/TOGCST99UPhylE5HmUbMQF03AGF
         yiJ5BvkdQacJoCJanX7mLtRmBQ652vEu5jMBbymsb1G4F86Zfdt2Gr7X1bq5cLHQVKbk
         qloXBwtJs+ezMa7VceE3cJo1Ae6+2PwtNxRF0Xgv85DrYWf3OXNY1uEMwFSAmV/k2iy/
         1B1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEYLnC3u7WyEhbD/FKNwftU+z2oHAmMTCcdaokM12wo=;
        b=cMPy8RVZVpHiM0KfNr+yiXaKgS3icwypZjunRqVJ+E1j+Pf9OxmV1ih9dKeaZ6070Y
         A3mi3IGKHBbLZYkTShu3JiDUITka6oNb0GSAEHftC2JwqUW9u2nlP26vMHaTPrq5LkN6
         4ng/GuRyceiZsrGpYdL7TkmxKgTo3eYDCkHYL9aBq7lBa+tr1MkHhByMyrYeAqRt9+PE
         zI7IPL6fR9nMEzTLYsCaDtMv1KbDyyhhk3q8K0yHjDfffeA3YJ1EgbE+jwypeaU0TH8a
         xRF3BXCBv4QASidH/BbYxxaNgUl+IXRDtJpmfh9Zb1kT3Vuw503R3xXb/XhnRg3pcK1J
         Gggw==
X-Gm-Message-State: AOAM533cLHCFFcOV2tPPAJ6U3eVLhqSQlHEysOun9Un9NlniuGFbo0Vg
        g1uZHGpUNbOPSde0HTPTkJTpu7CIDLA9mBf/sIIDbg==
X-Google-Smtp-Source: ABdhPJz8f9CiV9IMsKLsA2iuWlYWcAr9M2cWu28/QsYlV3ZoZT6Fj2KEfPn1+6Zo6tZqIADWuFbhS2Xm5mcrdRgOWAY=
X-Received: by 2002:a25:c683:: with SMTP id k125mr287913ybf.32.1612305853065;
 Tue, 02 Feb 2021 14:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com> <20210202212231.g5tj3f7tv74gagm6@viti.kaiser.cx>
In-Reply-To: <20210202212231.g5tj3f7tv74gagm6@viti.kaiser.cx>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 2 Feb 2021 14:43:37 -0800
Message-ID: <CAGETcx_cS_Y-1Bw3tNhZRckEQO=yB8UDzNRr+Khs_X2ym7tnwA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Make fw_devlink=on more forgiving
To:     Martin Kaiser <martin@kaiser.cx>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 2, 2021 at 1:22 PM Martin Kaiser <martin@kaiser.cx> wrote:
>
> Hi Saravana,
>
> Thus wrote Saravana Kannan (saravanak@google.com):
>
> > Martin,
>
> > If you tested this series, can you please give a Tested-by?
>
> I tested this v2 series on top of next-20210202 (without the fsl,avic
> patch).
>
> If modules are enabled, the kernel doesn't boot on my imx25 board. This
> is expected, I guess.
>
> With modules disabled, the kernel boots but probe fails for some
> (non-mainline) drivers in my tree.

Thanks Martin!

> All of those drivers have a gpio in
> their device-tree node, such as
>
> my_driver {
>    gpio_test1 = <&gpio1 0 0>;
>    ...
> };
>
> with gpio1 from arch/arm/boot/dts/imx25.dtsi.
>
> The probe function calls
>
> of_get_named_gpio(np, "gpio_test1", 0);
>
> to get the gpio. This fails with -EINVAL.

And you didn't see this issue with the fsl,avic patch?

The property you are using is not a standard GPIO binding (-gpios,
gpio, gpios) and I'm not surprised it's not working. The gpio1 is
probably getting probe deferred and ends up running after "my_driver".

-Saravana
