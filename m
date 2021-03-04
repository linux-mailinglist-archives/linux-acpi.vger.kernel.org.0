Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D9132CCE7
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 07:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhCDGiY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 01:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbhCDGiA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2021 01:38:00 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA519C061756
        for <linux-acpi@vger.kernel.org>; Wed,  3 Mar 2021 22:37:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id kx1so82751pjb.3
        for <linux-acpi@vger.kernel.org>; Wed, 03 Mar 2021 22:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DcBwSRYXwJgh73TAHGnFm4EDcUGNqvcxJAKsIbZgreY=;
        b=St5xIRnflDz/K+jN2ygevVUdjx/uGuut94oNGw0svvyhspYOOk1Vt0ZfdS4MpwPvqo
         noVforIO9Bh0Fs6VoCvdQJi7kJrnj7pOU8/7c5jvQjajZx/cpif2YA9r2heDcIGd4FXn
         q4cg7LtYHdNO94y3Hl3KizP8t9mKCLPm3o/MfT/LobHE4pv6bxpK4KsQuskcb/yZkCkx
         fvqa6xkNTgNF/L3Bbtyu/sFtfcV4dCS8YItxp8Ol10KzRkx5HlirpacYOoOcxO0+8v9t
         vssSyIDQtK58bOeTWSejORuhaXBRQWquRVmhQxAEDfWOzHH616fMUEq/7HSC8v7v6cgg
         ZFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DcBwSRYXwJgh73TAHGnFm4EDcUGNqvcxJAKsIbZgreY=;
        b=fkEsX+YiZurQLmQzT8ZiCIlpWbPZt2N+ps+tmZMAJ61jBcEgBZdlgTwJPe9ZZkr+Jw
         XDqVAdW0Lr7MdHnnxND/eGj8LZXB7ezFOv+5JF3R27mb46QUmZ7X24/nKOo/cmx/cKe2
         js+EeuNgcUv1EsIm5AwzzUKGQpfAIDFLZKj6hM6kDLemRno3/BRMR4qEsnmlZjV+m8sH
         qZ5rzOQwne7ygrfYNHfwEYvAbMJBq3kFCP/boJmg425Yf6/voIxYxU8bzHS1k5FAjLfs
         R9AleAGUwYzHlaZZTwikx1XuM/IO6lBm0rt+sl7DUspIavGUNa6nsWnbTxW3tuNfHIAy
         PxDQ==
X-Gm-Message-State: AOAM531x78+lH3ksC5XCipey342y6DxvvlLY61866UMu8tuVAogpnf1H
        MPXATJYO0b2+2gjz+zEfIx0a8A==
X-Google-Smtp-Source: ABdhPJxYvDMRvNIVVUpHDhVH2zFVimjOWMbu8V6B7Pvx4Ez+nmm/+HVSHqEFj28W9qYQ+CnSXeSDhA==
X-Received: by 2002:a17:902:a412:b029:e5:d7dd:9e41 with SMTP id p18-20020a170902a412b02900e5d7dd9e41mr2655188plq.78.1614839839141;
        Wed, 03 Mar 2021 22:37:19 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id 67sm27421739pfw.92.2021.03.03.22.37.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Mar 2021 22:37:18 -0800 (PST)
Date:   Thu, 4 Mar 2021 14:37:12 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
Message-ID: <20210304063711.GF17424@dragon>
References: <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
 <YDjZOU+VMWasjzUb@smile.fi.intel.com>
 <20210227031944.GB24428@dragon>
 <YDzbQqHspfvpYS7Z@smile.fi.intel.com>
 <20210302002725.GE24428@dragon>
 <YD4twyAGvDDOCv+n@smile.fi.intel.com>
 <abbfcdfa-c287-3828-ed6f-bc1e1f13c6b2@codeaurora.org>
 <20210303094300.GB17424@dragon>
 <41593c7e-368b-cfb8-b24a-2e4dca48b465@codeaurora.org>
 <YD+yBmPrKm1n8Tjm@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD+yBmPrKm1n8Tjm@builder.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 03, 2021 at 09:57:58AM -0600, Bjorn Andersson wrote:
> On Wed 03 Mar 09:10 CST 2021, Jeffrey Hugo wrote:
> 
> > On 3/3/2021 2:43 AM, Shawn Guo wrote:
> > > On Tue, Mar 02, 2021 at 10:02:49PM -0700, Jeffrey Hugo wrote:
> > > > Sorry, just joining the thread now.  Hopefully I'm addressing everything
> > > > targeted at me.
> > > > 
> > > > I used to do kernel work on MSMs, then kernel work on server CPUs, but now I
> > > > do kernel work on AI accelerators.  Never was on the firmware team, but I
> > > > have a lot of contacts in those areas.  On my own time, I support Linux on
> > > > the Qualcomm laptops.
> > > > 
> > > > Its not MS that needs to fix things (although there is plenty of things I
> > > > could point to that MS could fix), its the Qualcomm Windows FW folks.  They
> > > > have told me a while ago they were planning on fixing this issue on some
> > > > future chipset, but apparently that hasn't happened yet.  Sadly, once these
> > > > laptops ship, they are in a frozen maintenance mode.
> > > > 
> > > > In my opinion, MS has allowed Qualcomm to get away with doing bad things in
> > > > ACPI on the Qualcomm laptops.  The ACPI is not a true hardware description
> > > > that is OS agnostic as it should be, and probably violates the spec in many
> > > > ways.  Instead, the ACPI is written against the Windows drivers, and has a
> > > > lot of OS driver crap pushed into it.
> > > > 
> > > > The GPIO description is one such thing.
> > > > 
> > > > As I understand it, any particular SoC will have a number of GPIOs supported
> > > > by the TLMM.  0 - N.  Linux understands this.  However, in the ACPI of the
> > > > Qualcomm Windows laptops, you will likely find atleast one GPIO number which
> > > > exceeds this N.  These are "virtual" GPIOs, and are a construct of the
> > > > Windows Qualcomm TLMM driver and how it interfaces with the frameworks
> > > > within Windows.
> > > > 
> > > > Some GPIO lines can be configured as wakeup sources by routing them to a
> > > > specific hardware block in the SoC (which block it is varies from SoC to
> > > > SoC).  Windows has a specific weird way of handling this which requires a
> > > > unique "GPIO chip" to handle.  GPIO chips in Windows contain 32 GPIOs, so
> > > > for each wakeup GPIO, the TLMM driver creates a GPIO chip (essentially
> > > > creating 32 GPIOs), and assigns the added GPIOs numbers which exceed N.  The
> > > > TLMM driver has an internal mapping of which virtual GPIO number corresponds
> > > > to which real GPIO.
> > > > 
> > > > So, ACPI says that some peripheral has GPIO N+X, which is not a real GPIO.
> > > > That peripheral goes and requests that GPIO, which gets routed to the TLMM
> > > > driver, and the TLMM driver translates that number to the real GPIO, and
> > > > provides the reference back to the peripheral, while also setting up the
> > > > special wakeup hardware.
> > > > 
> > > > So, N+1 is the first supported wakup GPIO, N+1+32 is the next one, then
> > > > N+1+32+32, and so on.
> > > 
> > > Jeffrey,
> > > 
> > > Thanks so much for these great information!
> > > 
> > > May I ask a bit more about how the virtual number N+1+32*n maps back to
> > > the real number (R)?  For example of touchpad GPIO on Flex 5G, I think
> > > we have:
> > > 
> > >    N+1+32*n = 0x0280
> > >    N = 191
> 
> There's 190 GPIOs on SC8180x, but then the math doesn't add up to a
> whole number...

In pinctrl-sc8180x driver you wrote, it has sc8180x_pinctrl.ngpios = 191.
Which one of you should I listen to :)

BTW, if you read this number from DTS, I already sent you a series to
fix them.

https://lore.kernel.org/linux-gpio/20210303033106.549-1-shawn.guo@linaro.org/

> 
> > >    R = 24
> > > 
> > > If my math not bad, n = 14.  How does 14 map to 24?
> > 
> > 
> > So, if this was 845, the wakeup hardware would be the PDC.  Only a specific
> > number of GPIOs are routed to the PDC.  When the TLMM is powered off in
> > suspend, the PDC pays attention to the GPIOs that are routed to it, and are
> > configured in the PDC as wakeup sources.  When the GPIO is asserted, the
> > signal to the TLMM gets lost, but the PDC catches it.  The PDC will kick the
> > CPU/SoC out of suspend, and then once the wakup process is complete, replay
> > the GPIO so that the TLMM has the signal.
> > 
> 
> SC8180x has the same hardware design.
> 
> > In your example, 14 would be the 14th GPIO that is routed to the PDC. You
> > would need SoC hardware documentation to know the mapping from PDC line 14
> > to GPIO line X.  This is going to be SoC specific, so 845 documentation is
> > not going to help you for SC8XXX.
> > 
> > Chances are, you are going to need to get this documentation from Qualcomm
> > (I don't know if its in IPCatalog or not), and put SoC specific lookup
> > tables in the TLMM driver.
> > 
> 
> I added the table in the driver, see sc8180x_pdc_map[], and it has gpio
> 14 at position 7, with the 14th entry being gpio 38 - which seems like
> an unlikely change from the reference schematics.

As it's clear that the real GPIO number is 24, and the only possible map
in sc8180x_pdc_map[] is:

	{ .gpio = 24, wakeirq = 37 }

So we need to understand how 14 turns to 37.

Shawn
