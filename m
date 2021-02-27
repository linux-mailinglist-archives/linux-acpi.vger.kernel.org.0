Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A008D326B50
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Feb 2021 04:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhB0DUe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Feb 2021 22:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhB0DUc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Feb 2021 22:20:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B15CC061756
        for <linux-acpi@vger.kernel.org>; Fri, 26 Feb 2021 19:19:52 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d12so4989999pfo.7
        for <linux-acpi@vger.kernel.org>; Fri, 26 Feb 2021 19:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=96LdUz1OtaaIygWHxO7H9gQAOCVGM05dMV+72gzMXsY=;
        b=dm2nY6Qok+AHKh10EUZHshjkJ2KxietKlYDoEAKbVy52U0/0mTzKeDcwlNdtzq+3Uj
         IG8oQDnpqjaimBQ4xFKHZLesaN2YOLBPC9yYizzk6KUXGdXwGeAzmW6jDutATvoUaSPI
         orG5oB6fvILv9daB/GakqEaX89xJpTDctAmIq+4774Dy2t1Hk+SOEYtUbuvwQ/29SWDh
         C58z9Bo1hzRm6UAxHZkD+caQxaSkJ3FgqkTonQRsbmd/tRDMKCpXiIyFCjD3ldN6gdUi
         gVTbbgRxBmo/VQovt6TGZv9JbDSlahJkpqT4PAHYpT57jJJocJGuyUfLTtykJVr9UZTZ
         VwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=96LdUz1OtaaIygWHxO7H9gQAOCVGM05dMV+72gzMXsY=;
        b=WyDHrzl8iPZ+bbAmouIbfoy+DJKwENRMKXdo1vuwUzb/JiYS/XXaIvA8HEYZVxedgB
         g1DVgFDszY+ThRT8j0yE+9GhWmf8+VHmZVCe0tYF4u+JIi8KS8aG5qh3udbCbbJ1D6rb
         ygJKFSQIVbqdETj0g4S8tVwkBLcRoT3HnUgYpzQXYwauvrTyBjPNcHphwC6gaH0deYnT
         SsBf/GIygkcTmGSJXyCh4rgJRt8f80lfq2thrx6A6MlCPEy6RmUCGZ4zbjHBfPrc4E7R
         SofuXtgzOKwzeycnXYX14cFBWWVgvmrwZ4mRVRY8EjODQpLgAI+zMWa3PIGwJsaF65k6
         hQ0Q==
X-Gm-Message-State: AOAM530ZTKHfRqeAGBnarOUxBn582Wco3vdsaoZkoOUyj4+vHm7b8Yjv
        Kdvqs/WfHtOYYCiNR9CZLrqLYQ==
X-Google-Smtp-Source: ABdhPJzl9oZjeq6dlcubkralpaIjNLcFuiIZgdYfLJaBGbz3Z6yLl8kCtF+G8NA44HwbC0FHIl6e0w==
X-Received: by 2002:a65:5a0a:: with SMTP id y10mr5518078pgs.285.1614395991691;
        Fri, 26 Feb 2021 19:19:51 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id 190sm10987285pfv.155.2021.02.26.19.19.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Feb 2021 19:19:51 -0800 (PST)
Date:   Sat, 27 Feb 2021 11:19:45 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
Message-ID: <20210227031944.GB24428@dragon>
References: <20210226033919.8871-1-shawn.guo@linaro.org>
 <CAHp75Vcb=NO9OWjSpBeVC4c+9=aXE=yiDWVBwLD1DnzwdgFD6Q@mail.gmail.com>
 <20210226093925.GA24428@dragon>
 <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
 <YDjZOU+VMWasjzUb@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDjZOU+VMWasjzUb@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 26, 2021 at 01:19:21PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 26, 2021 at 12:57:37PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 26, 2021 at 11:39 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > > On Fri, Feb 26, 2021 at 11:12:07AM +0200, Andy Shevchenko wrote:
> > > > On Fri, Feb 26, 2021 at 5:42 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > > Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
> > > > > not working.  That's because the GpioInt number of TSC2 node in ACPI
> > > > > table is simply wrong, and the number even exceeds the maximum GPIO
> > > > > lines.  As the touchpad works fine with Windows on the same machine,
> > > > > presumably this is something Windows-ism.  Although it's obviously
> > > > > a specification violation, believe of that Microsoft will fix this in
> > > > > the near future is not really realistic.
> > > > >
> > > > > It adds the support of overriding broken GPIO number in ACPI table
> > > > > on particular machines, which are matched using DMI info.  Such
> > > > > mechanism for fixing up broken firmware and ACPI table is not uncommon
> > > > > in kernel.  And hopefully it can be useful for other machines that get
> > > > > broken GPIO number coded in ACPI table.
> > > >
> > > > Thanks for the report and patch.
> > > >
> > > > First of all, have you reported the issue to Lenovo? At least they
> > > > will know that they did wrong.
> > >
> > > Yes, we are reporting this to Lenovo, but to be honest, we are not sure
> > > how much they will care about it, as they are shipping the laptop with
> > > Windows only.
> > >
> > > > Second, is it possible to have somewhere output of `acpidump -o
> > > > flex5g.dat` (the flex5g.dat file)?
> > >
> > > https://raw.githubusercontent.com/aarch64-laptops/build/master/misc/lenovo-flex-5g/dsdt.dsl
> 
> Looking into DSDT I think the problem is much worse. First of all there are
> many cases where pins like 0x140, 0x1c0, etc are being used. On top of that
> there is no GPIO driver in the upstream (as far as I can see by HID, perhaps
> there is a driver but for different HID. And I see that GPIO device consumes a
> lot of Interrupts from GIC as well (it's ARM platfrom as far as I understand).

Yes, it's a laptop built on Qualcomm Snapdragon SC8180X SoC.  The GPIO
driver is generic for all Snapdragon SoCs, and has been available in
upstream for many years (for DT though). It can be found as the gpio_chip
implementation in MSM pinctrl driver [1].  The SC8180X specific part can
be found as pinctrl-sc8180x.c [2], and it's already working for DT boot.
The only missing piece is to add "QCOM040D" as the acpi_device_id to
support ACPI boot, and it will be submitted after 5.12-rc1 comes out.

> Looking at the Microsoft brain damaged way of understanding GPIOs and hardware
> [1], I am afraid you really want to have a specific GPIO driver for this. So,
> for now until we have better picture of what's going on, NAK to this patch.

Thanks for the pointer to Microsoft document.  On Snapdragon, we have
only one GPIO instance that accommodates all GPIO pins, so I'm not sure
that Microsoft GPIOs mapping layer is relevant here at all.

Please take a look at the GPIO driver, and feel free to let me know if
you need any further information to understand what's going on.

Shawn


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/qcom/pinctrl-msm.c#n713
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/qcom/pinctrl-sc8180x.c
