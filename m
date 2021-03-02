Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC0332A4BE
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Mar 2021 16:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbhCBLNX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 06:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377071AbhCBApe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2021 19:45:34 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99A4C061788
        for <linux-acpi@vger.kernel.org>; Mon,  1 Mar 2021 16:44:53 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id q20so12676550pfu.8
        for <linux-acpi@vger.kernel.org>; Mon, 01 Mar 2021 16:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=39RX2YE4NXwbxTEMtPuIacM6Gof41YukFLFpW3m9oBI=;
        b=YgR7FX+4ACXbwxkoqvkDW5uCOYJ690pOqAAaK1bJXHWxkt5pJ8+kK7zFes7PXSFT/l
         4Zx3I3S5UZmNXmb6ABMssVAf0bwV9DZeG0qyPlzQPTLKmkzT7V5ekIMcC3hISSH72Xq4
         vGViPPnQTl+Q0+HSQKJJ1Zp2p0o1uvOBnCxlyjxRR0BiDxSuJ3Q/6gp7UUaquNG6PG5Z
         A02hfxV1Fhaxr/iQD5KC/xUy/jN3u/iH4jOY+2ByUoAFkINjCnQBwsQnp5zkyT3p2wq5
         OuhaxTNf/RndxkmIAXk5f4Dl/lgr27DC9OU2rOx3x2/zdfaSqsoyYC8103fRBG2ZxIx3
         P6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=39RX2YE4NXwbxTEMtPuIacM6Gof41YukFLFpW3m9oBI=;
        b=KbF/r7ilQoxRvSqHmlXjn7GwLfCGsY625UfGODXAXWB90pQZrOcibCdlGgdlD9UIPv
         BFSmKID2gaBpkhgcRSMu288Eedj7i15nL9LahzXCgvhX5HlfwXXSRaig7EQ0z4hHmiIP
         arhRgk7YEyBfKgKKoiL2FqOjIaJViP1cjaoj8+iyh930rVU9OqQRS/4g9xVlyAEZe72U
         cTpbxKnx156chBmyzcvUjGN3DjBOeoUQ72DJY1j1xf5F56KITIfqvOOUvZ1Dq+nOB9k8
         +236DyeG6drvzPRBPisA2BHKKRd1VCatIWhFDDXr0iLT9dndLfyZ8sLVtrG7AHxha3ZD
         AH3w==
X-Gm-Message-State: AOAM5338Q3UK+Irs3/ZJKOjI08YQNy8a3ZXkkFOYuLmPdk8r1q3IXkBA
        XMk2TxlFycFVfvOBqtcWJbP3Ag==
X-Google-Smtp-Source: ABdhPJzt2/UYkyu0GiyWPXLQFW8tzLr86iEp21k+9n54aauH5+FHIw1+2jGFHSlV1h3RqD4VIpA1ow==
X-Received: by 2002:a63:d451:: with SMTP id i17mr733709pgj.391.1614645893181;
        Mon, 01 Mar 2021 16:44:53 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id cv3sm680211pjb.9.2021.03.01.16.44.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Mar 2021 16:44:52 -0800 (PST)
Date:   Tue, 2 Mar 2021 08:44:47 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Message-ID: <20210302004446.GF24428@dragon>
References: <20210226033919.8871-1-shawn.guo@linaro.org>
 <CAHp75Vcb=NO9OWjSpBeVC4c+9=aXE=yiDWVBwLD1DnzwdgFD6Q@mail.gmail.com>
 <20210226093925.GA24428@dragon>
 <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
 <20210227034641.GC24428@dragon>
 <YDzb5llywkzbGEF+@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDzb5llywkzbGEF+@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+ Jeffrey

On Mon, Mar 01, 2021 at 02:19:50PM +0200, Andy Shevchenko wrote:
> On Sat, Feb 27, 2021 at 11:46:42AM +0800, Shawn Guo wrote:
> > On Fri, Feb 26, 2021 at 12:57:37PM +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 26, 2021 at 11:39 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > > >
> > > > On Fri, Feb 26, 2021 at 11:12:07AM +0200, Andy Shevchenko wrote:
> > > > > On Fri, Feb 26, 2021 at 5:42 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > > >
> > > > > > Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
> > > > > > not working.  That's because the GpioInt number of TSC2 node in ACPI
> > > > > > table is simply wrong, and the number even exceeds the maximum GPIO
> > > > > > lines.  As the touchpad works fine with Windows on the same machine,
> > > > > > presumably this is something Windows-ism.  Although it's obviously
> > > > > > a specification violation, believe of that Microsoft will fix this in
> > > > > > the near future is not really realistic.
> > > > > >
> > > > > > It adds the support of overriding broken GPIO number in ACPI table
> > > > > > on particular machines, which are matched using DMI info.  Such
> > > > > > mechanism for fixing up broken firmware and ACPI table is not uncommon
> > > > > > in kernel.  And hopefully it can be useful for other machines that get
> > > > > > broken GPIO number coded in ACPI table.
> > > > >
> > > > > Thanks for the report and patch.
> > > > >
> > > > > First of all, have you reported the issue to Lenovo? At least they
> > > > > will know that they did wrong.
> > > >
> > > > Yes, we are reporting this to Lenovo, but to be honest, we are not sure
> > > > how much they will care about it, as they are shipping the laptop with
> > > > Windows only.
> > > >
> > > > > Second, is it possible to have somewhere output of `acpidump -o
> > > > > flex5g.dat` (the flex5g.dat file)?
> > > >
> > > > https://raw.githubusercontent.com/aarch64-laptops/build/master/misc/lenovo-flex-5g/dsdt.dsl
> > > >
> > > > > And as Mika said once to one of mine patches "since you know the
> > > > > number ahead there is no need to pollute GPIO ACPI library core with
> > > > > this quirk". But in any case I would like to see the ACPI tables
> > > > > first.
> > > >
> > > > Oh, so you had something similar already?  Could you point me to the
> > > > patch and discussion?
> > > 
> > > Similar, but might be not the same:
> > >  - patches in the upstream [1] (v3 applied), discussion [2]
> > >  - new version with some additional fixes [3]
> > 
> > Thanks for all the pointers.  It looks to me that it's the same problem
> > - the GPIO number in ACPI table is broken and needs an override from
> > kernel.
> 
> Not exactly. On Galileo Gen 2 platform it's broken in understandable way.
> In your case it's different and I'm not sure at all that's considered "broken"
> in the MS' eyes.

At least, I was told by Jeffrey that MS admits this is something needs
to be fixed in the future.

> 
> > So I think what we need is a generic solution to a problem
> > not uncommon.  Rather than asking all different drivers to resolve the
> > same problem all over the kernel, I believe GPIO ACPI library is just
> > the right place.
> > 
> > Looking at your platform and problem, I realise that to be a generic
> > solution, my patch needs an additional device identification matching,
> > as one GPIO number that is broken for one device could be correct for
> > another.  I will improve it, so that your problem can be resolved by
> > simply adding a new entry to acpi_gpio_pin_override_table[].
> 
> Before any steps further I really want to see more information about that IP
> and how firmware applied the numbering scheme.

Deduced by those working GPIO numbers in ACPI table and how Linux kernel
is working, I think the GPIO is numbered without any bank thing.  All
available pins are just numbered linearly, and every pin can be
configured in GPIO mode.

> 
> If it's confidential, you may sent any insights privately.

Unfortunately, all those documents are confidential to me as well.

Shawn
