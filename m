Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7A032C43B
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349596AbhCDAMA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344506AbhCCP6o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2021 10:58:44 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47CCC061762
        for <linux-acpi@vger.kernel.org>; Wed,  3 Mar 2021 07:58:01 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id a13so26488280oid.0
        for <linux-acpi@vger.kernel.org>; Wed, 03 Mar 2021 07:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zhVr6K8r2z3/ZhGqFoxBH1FeHeZIi/F72+oBarEiB3k=;
        b=R3XSi8RRCP7cWEkBhtOnB6s+tSUjGfn7qu4k9MPRMFcBrKr2JMNcSd1m1/eCi5hALz
         +VIdhI4eddycL5AVJYfCkbU2CDPRqa2yx9TAZg98pMEtaEuLfvx8PQy+ZilUECuKxvRo
         PnAMqOuBVoF/NZ5Utk9I8NiOspiAryZXLXN44VgxiXGcSLIVAjsGGa59RtlLNlXEqLnb
         z8wCCS/Ib9OqUGX5+o7VrK50PsCYX8sUmvtof/uZV4XU0v/A668yJtQbFXexepAUKrYq
         n05au0P2g8pLk5M4lj868L7yTg9j609h7iQ1dvy9KlOYdVNGkklMhSmveyW3T/V06Plu
         2K3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zhVr6K8r2z3/ZhGqFoxBH1FeHeZIi/F72+oBarEiB3k=;
        b=tJdrmPuWen5nERbA7xDnFpZsYnhWg44AnwDxGCULxHOphNxhdijS5FHXLh8xjoNzO1
         8SeHymGGVGt+e6lL22qpVDjcMvkaFHdTtEyqfr3Y3buf7RthA/vpGtvx/IjsOmR6xJWC
         16x3PEuJomjbxs5BxiBgui6f/gv7CDPpDefP8LSzIO1KJv/z/bmv9cdhCBhkXLv7r6hg
         GVIZAl8LXk1VX2jYDe82uhHf/7+2l9SCrqVXsTD8ATtMpIn0EIOaI++3SPmtQyjTues+
         +6Q9BecMJLDPl8rpAdVGCpz+m9v03xLMqumogLdSpAPx4KEKGc3vBwTYjWjT2XueV4Qw
         wPrw==
X-Gm-Message-State: AOAM532Uw2ILT3PSXPMH4W9EQ6cCmwlaRyqHGeEPykJRXnz94q5bYwvT
        8uxGSaC91o2n8K7bmAFaLPehqg==
X-Google-Smtp-Source: ABdhPJwflt5EacJvsf71Ng2vkB1o2dwBvAXm7b8Y/L3vy6Om6bfpgOP+bEnyr+ddS9MnA6/YObV0xw==
X-Received: by 2002:aca:3285:: with SMTP id y127mr7674441oiy.98.1614787081022;
        Wed, 03 Mar 2021 07:58:01 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w9sm4711161oia.46.2021.03.03.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 07:58:00 -0800 (PST)
Date:   Wed, 3 Mar 2021 09:57:58 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
Message-ID: <YD+yBmPrKm1n8Tjm@builder.lan>
References: <20210226093925.GA24428@dragon>
 <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
 <YDjZOU+VMWasjzUb@smile.fi.intel.com>
 <20210227031944.GB24428@dragon>
 <YDzbQqHspfvpYS7Z@smile.fi.intel.com>
 <20210302002725.GE24428@dragon>
 <YD4twyAGvDDOCv+n@smile.fi.intel.com>
 <abbfcdfa-c287-3828-ed6f-bc1e1f13c6b2@codeaurora.org>
 <20210303094300.GB17424@dragon>
 <41593c7e-368b-cfb8-b24a-2e4dca48b465@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41593c7e-368b-cfb8-b24a-2e4dca48b465@codeaurora.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed 03 Mar 09:10 CST 2021, Jeffrey Hugo wrote:

> On 3/3/2021 2:43 AM, Shawn Guo wrote:
> > On Tue, Mar 02, 2021 at 10:02:49PM -0700, Jeffrey Hugo wrote:
> > > Sorry, just joining the thread now.  Hopefully I'm addressing everything
> > > targeted at me.
> > > 
> > > I used to do kernel work on MSMs, then kernel work on server CPUs, but now I
> > > do kernel work on AI accelerators.  Never was on the firmware team, but I
> > > have a lot of contacts in those areas.  On my own time, I support Linux on
> > > the Qualcomm laptops.
> > > 
> > > Its not MS that needs to fix things (although there is plenty of things I
> > > could point to that MS could fix), its the Qualcomm Windows FW folks.  They
> > > have told me a while ago they were planning on fixing this issue on some
> > > future chipset, but apparently that hasn't happened yet.  Sadly, once these
> > > laptops ship, they are in a frozen maintenance mode.
> > > 
> > > In my opinion, MS has allowed Qualcomm to get away with doing bad things in
> > > ACPI on the Qualcomm laptops.  The ACPI is not a true hardware description
> > > that is OS agnostic as it should be, and probably violates the spec in many
> > > ways.  Instead, the ACPI is written against the Windows drivers, and has a
> > > lot of OS driver crap pushed into it.
> > > 
> > > The GPIO description is one such thing.
> > > 
> > > As I understand it, any particular SoC will have a number of GPIOs supported
> > > by the TLMM.  0 - N.  Linux understands this.  However, in the ACPI of the
> > > Qualcomm Windows laptops, you will likely find atleast one GPIO number which
> > > exceeds this N.  These are "virtual" GPIOs, and are a construct of the
> > > Windows Qualcomm TLMM driver and how it interfaces with the frameworks
> > > within Windows.
> > > 
> > > Some GPIO lines can be configured as wakeup sources by routing them to a
> > > specific hardware block in the SoC (which block it is varies from SoC to
> > > SoC).  Windows has a specific weird way of handling this which requires a
> > > unique "GPIO chip" to handle.  GPIO chips in Windows contain 32 GPIOs, so
> > > for each wakeup GPIO, the TLMM driver creates a GPIO chip (essentially
> > > creating 32 GPIOs), and assigns the added GPIOs numbers which exceed N.  The
> > > TLMM driver has an internal mapping of which virtual GPIO number corresponds
> > > to which real GPIO.
> > > 
> > > So, ACPI says that some peripheral has GPIO N+X, which is not a real GPIO.
> > > That peripheral goes and requests that GPIO, which gets routed to the TLMM
> > > driver, and the TLMM driver translates that number to the real GPIO, and
> > > provides the reference back to the peripheral, while also setting up the
> > > special wakeup hardware.
> > > 
> > > So, N+1 is the first supported wakup GPIO, N+1+32 is the next one, then
> > > N+1+32+32, and so on.
> > 
> > Jeffrey,
> > 
> > Thanks so much for these great information!
> > 
> > May I ask a bit more about how the virtual number N+1+32*n maps back to
> > the real number (R)?  For example of touchpad GPIO on Flex 5G, I think
> > we have:
> > 
> >    N+1+32*n = 0x0280
> >    N = 191

There's 190 GPIOs on SC8180x, but then the math doesn't add up to a
whole number...

> >    R = 24
> > 
> > If my math not bad, n = 14.  How does 14 map to 24?
> 
> 
> So, if this was 845, the wakeup hardware would be the PDC.  Only a specific
> number of GPIOs are routed to the PDC.  When the TLMM is powered off in
> suspend, the PDC pays attention to the GPIOs that are routed to it, and are
> configured in the PDC as wakeup sources.  When the GPIO is asserted, the
> signal to the TLMM gets lost, but the PDC catches it.  The PDC will kick the
> CPU/SoC out of suspend, and then once the wakup process is complete, replay
> the GPIO so that the TLMM has the signal.
> 

SC8180x has the same hardware design.

> In your example, 14 would be the 14th GPIO that is routed to the PDC. You
> would need SoC hardware documentation to know the mapping from PDC line 14
> to GPIO line X.  This is going to be SoC specific, so 845 documentation is
> not going to help you for SC8XXX.
> 
> Chances are, you are going to need to get this documentation from Qualcomm
> (I don't know if its in IPCatalog or not), and put SoC specific lookup
> tables in the TLMM driver.
> 

I added the table in the driver, see sc8180x_pdc_map[], and it has gpio
14 at position 7, with the 14th entry being gpio 38 - which seems like
an unlikely change from the reference schematics.

> Does that make sense, or did I not answer the question you were actually
> asking?
> 

It does.

Regards,
Bjorn
