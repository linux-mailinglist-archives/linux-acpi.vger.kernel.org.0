Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382A932A4BC
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Mar 2021 16:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446510AbhCBLMm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 06:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348021AbhCBA2O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2021 19:28:14 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B744DC061788
        for <linux-acpi@vger.kernel.org>; Mon,  1 Mar 2021 16:27:33 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id j12so12626545pfj.12
        for <linux-acpi@vger.kernel.org>; Mon, 01 Mar 2021 16:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RRU270YlOIbTR3Jczpep3B6cFOurKYvHFTuOv1fd+U4=;
        b=DHxoaAwHa7TMohlAjLE5qbGEz3mY0BcSqY6nAFtujiL/AIiWlwSXEZX81zZaIh1tct
         m8MrlRTCPX5d6WiAEKZB8RWkH20PjnDlOh8APE0SSb0Z3ISW49vBp7aGNpwZDUKbpvg1
         v2T6g33yx2xzOL9cWC1TzlGHU0TvCMnfmR2WaDEPVKyTr5UeXKSySsSt80mnIru4bMT4
         cU3TQkg2pmY+jp3SOwDdklAb/orzYh/yk3dfFSqAk6W9456pi+ZjXIV2w7o7F/JeBll8
         xConXBRHUKLIzX6+7fFmcv5o2WbpadfSYftl8yJ0hYYPYDHJfbxFVke0t+ZOUCT7tirJ
         UC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RRU270YlOIbTR3Jczpep3B6cFOurKYvHFTuOv1fd+U4=;
        b=bddE+fWmVisSZ7OOJgljxN+8ido6gfSc6eAEIKDy0pvG0rgWjcWY0ZwX+XspHDQssP
         T6lw8bSD5kAeQQFAU3WhLvXZCgYrbPuNPe3ZYjvTRg3NjL4N3bmJlTQc+yaDCWS6Nk3W
         5//hMs/LW48hXgatDVVM9y1OSlapAWHbeIq6RHDZC2H+9daQk7wAs63lQhDORM6mp5RS
         dOCQYJK6SopsA/zXALjZmpSnSvZRqcUrHJpaIo9j46QDvJzFm4NA/VZtRekhakPboYPi
         murGj7ftLkp3QvVdXc3Qk1NE5qMRrF5erE/DyadlM1sWRRMD0M8/ipVpr40dMAvLSFIa
         Rm9w==
X-Gm-Message-State: AOAM530W21BnWCbGf7uLHIZwfT+EItF/Q5wc9s4JIpyQUCwTe1KQyUrp
        bNfj9RpX0AcvBGFDVOIz4qs61Q==
X-Google-Smtp-Source: ABdhPJxk620SmxOEf0mXUXOIpP7SJT19PXewbp7X7qAGQF/BfSgLXnNEgQk1qGRLHUCLh9hIarv/BQ==
X-Received: by 2002:a63:d20a:: with SMTP id a10mr15567339pgg.451.1614644853032;
        Mon, 01 Mar 2021 16:27:33 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id g17sm14765900pfb.214.2021.03.01.16.27.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Mar 2021 16:27:32 -0800 (PST)
Date:   Tue, 2 Mar 2021 08:27:26 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
Message-ID: <20210302002725.GE24428@dragon>
References: <20210226033919.8871-1-shawn.guo@linaro.org>
 <CAHp75Vcb=NO9OWjSpBeVC4c+9=aXE=yiDWVBwLD1DnzwdgFD6Q@mail.gmail.com>
 <20210226093925.GA24428@dragon>
 <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
 <YDjZOU+VMWasjzUb@smile.fi.intel.com>
 <20210227031944.GB24428@dragon>
 <YDzbQqHspfvpYS7Z@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDzbQqHspfvpYS7Z@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 01, 2021 at 02:17:06PM +0200, Andy Shevchenko wrote:
> On Sat, Feb 27, 2021 at 11:19:45AM +0800, Shawn Guo wrote:
> > On Fri, Feb 26, 2021 at 01:19:21PM +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 26, 2021 at 12:57:37PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Feb 26, 2021 at 11:39 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > > On Fri, Feb 26, 2021 at 11:12:07AM +0200, Andy Shevchenko wrote:
> > > > > > On Fri, Feb 26, 2021 at 5:42 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > > > > Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
> > > > > > > not working.  That's because the GpioInt number of TSC2 node in ACPI
> > > > > > > table is simply wrong, and the number even exceeds the maximum GPIO
> > > > > > > lines.  As the touchpad works fine with Windows on the same machine,
> > > > > > > presumably this is something Windows-ism.  Although it's obviously
> > > > > > > a specification violation, believe of that Microsoft will fix this in
> > > > > > > the near future is not really realistic.
> > > > > > >
> > > > > > > It adds the support of overriding broken GPIO number in ACPI table
> > > > > > > on particular machines, which are matched using DMI info.  Such
> > > > > > > mechanism for fixing up broken firmware and ACPI table is not uncommon
> > > > > > > in kernel.  And hopefully it can be useful for other machines that get
> > > > > > > broken GPIO number coded in ACPI table.
> > > > > >
> > > > > > Thanks for the report and patch.
> > > > > >
> > > > > > First of all, have you reported the issue to Lenovo? At least they
> > > > > > will know that they did wrong.
> > > > >
> > > > > Yes, we are reporting this to Lenovo, but to be honest, we are not sure
> > > > > how much they will care about it, as they are shipping the laptop with
> > > > > Windows only.
> > > > >
> > > > > > Second, is it possible to have somewhere output of `acpidump -o
> > > > > > flex5g.dat` (the flex5g.dat file)?
> > > > >
> > > > > https://raw.githubusercontent.com/aarch64-laptops/build/master/misc/lenovo-flex-5g/dsdt.dsl
> > > 
> > > Looking into DSDT I think the problem is much worse. First of all there are
> > > many cases where pins like 0x140, 0x1c0, etc are being used. On top of that
> > > there is no GPIO driver in the upstream (as far as I can see by HID, perhaps
> > > there is a driver but for different HID. And I see that GPIO device consumes a
> > > lot of Interrupts from GIC as well (it's ARM platfrom as far as I understand).
> > 
> > Yes, it's a laptop built on Qualcomm Snapdragon SC8180X SoC.  The GPIO
> > driver is generic for all Snapdragon SoCs, and has been available in
> > upstream for many years (for DT though). It can be found as the gpio_chip
> > implementation in MSM pinctrl driver [1].  The SC8180X specific part can
> > be found as pinctrl-sc8180x.c [2], and it's already working for DT boot.
> > The only missing piece is to add "QCOM040D" as the acpi_device_id to
> > support ACPI boot, and it will be submitted after 5.12-rc1 comes out.
> > 
> > > Looking at the Microsoft brain damaged way of understanding GPIOs and hardware
> > > [1], I am afraid you really want to have a specific GPIO driver for this. So,
> > > for now until we have better picture of what's going on, NAK to this patch.
> > 
> > Thanks for the pointer to Microsoft document.  On Snapdragon, we have
> > only one GPIO instance that accommodates all GPIO pins, so I'm not sure
> > that Microsoft GPIOs mapping layer is relevant here at all.
> > 
> > Please take a look at the GPIO driver, and feel free to let me know if
> > you need any further information to understand what's going on.
> 
> Yes, I looked into the driver and see that it has 3 blocks of GPIOs (we call
> them communities, but in the driver the term 'tiles' is used) AFAIU (correct me
> if I'm wrong). And who knows how many banks in each of them.

I'm not sure that the 3 'tiles' means 3 blocks of GPIOs.  Maybe, @Bjorn
can help clarify.  But the ACPI table shows that there is only 'GIO0'
with 'QCOM040D' HID.

> 
> I'm afraid that MS does on his way and not yours.
> 
> Can we have TRM for GPIO IP used there and any evidence / document from
> firmware team about the implementation of the GPIO numbering in the ACPI
> (at Intel we have so called BIOS Writers Guide that is given to the customers
> where such info can be found)?

Unfortunately, I do not have the access to any sort of these documents.
But I looped in Jeffrey who is part of Qualcomm kernel/firmware team,
and should be able to help clarify GPIO numbering in the ACPI table.

Shawn

> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/qcom/pinctrl-msm.c#n713
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/qcom/pinctrl-sc8180x.c
