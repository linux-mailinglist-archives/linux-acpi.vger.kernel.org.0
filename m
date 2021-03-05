Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A307C32DEF9
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 02:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbhCEBOm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 20:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCEBOk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2021 20:14:40 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D855DC06175F
        for <linux-acpi@vger.kernel.org>; Thu,  4 Mar 2021 17:14:39 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id i4-20020a17090a7184b02900bfb60fbc6bso5307335pjk.0
        for <linux-acpi@vger.kernel.org>; Thu, 04 Mar 2021 17:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XiPQ0qbz5NlheKY3OXWnuwygc2sesfubntE23mumebc=;
        b=MDZgx3TBuJGboGUsWHzFm1tAX4R92paHV0EMX3tKPE9kImpnk/cColwnE0t7QOulVO
         HDF8jYCjnfyasp0ouU1RClFN4JzVl7KNBUHWw9Rnj8AZKsUhb42D04tJmiIN/PP4yKWM
         fGsqbCWsal07kMKfu62FdVF1E5m2kK4yX7Wm7xrf+QAAIRTlyMAsr6AFxQnEMZ9DBX4b
         Gbw/uQfbAKnEu8LYudLbV+ZDhpN7Z+htNgIK/iQX2wp5p6JLi5ARPE96/+2lFPyw5GSA
         CIOQf01x9voa0BzEMGOUlUxSRpkuus3TGHbvHF1/4j72UXnuDejWN18nN8t28QnoAiwo
         BCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XiPQ0qbz5NlheKY3OXWnuwygc2sesfubntE23mumebc=;
        b=M3Io4c2nFVANEfQRDkD4Ot3V2n5VfFRRx+SY7PNQ5/lWICRYGBOUiStQymC1X1mISC
         5CXVqdV/jJlSpGuiUFqzaVYNOAEsncrmC5BTk1RXhqYrCRbLfVDX2h4WwSAWrdlkSDh9
         UU1f7Dpg9EleKWuENK63mC3C5h1aFBqYlAEw5L0yZuJ+FVtRKsG9fc4cJMwS7aEiwlDd
         nVQasXNrOaR2tALviqsg8k80ieaacpxY5WMtvZnVwq6Gj2EksvMERzaNYluDvRnX6y2g
         VNBVpnqnViPtXSNWarMrgqr70ddh4crPPl2rbNjS9M1SuxPy3xzb2TviXg7oTPtIWA+f
         ZniA==
X-Gm-Message-State: AOAM533G0z2TeeQlOUrYrVV/AQlbhSv3sPmeR40p55ipXqSZu/SwkXhN
        76p9l9zovrtB9K2vRzyWuIWvMg==
X-Google-Smtp-Source: ABdhPJxKzmJ2qx6ZJejZ2IsZUNoZiHysTu4Rj/Gfl2KyGVCeQVE3NeF2zuYwPU2DZAES8IaVH5L57A==
X-Received: by 2002:a17:90a:c389:: with SMTP id h9mr7464794pjt.226.1614906879427;
        Thu, 04 Mar 2021 17:14:39 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id v3sm495603pff.217.2021.03.04.17.14.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Mar 2021 17:14:38 -0800 (PST)
Date:   Fri, 5 Mar 2021 09:14:32 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
Message-ID: <20210305011429.GH17424@dragon>
References: <20210226033919.8871-1-shawn.guo@linaro.org>
 <YD9bQXBD+9k3Lf/4@smile.fi.intel.com>
 <2ed0d4dc-2756-9a55-3f54-1377732e35fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ed0d4dc-2756-9a55-3f54-1377732e35fc@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 04, 2021 at 08:32:14PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 3/3/21 10:47 AM, Andy Shevchenko wrote:
> > On Fri, Feb 26, 2021 at 11:39:19AM +0800, Shawn Guo wrote:
> >> Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
> >> not working.  That's because the GpioInt number of TSC2 node in ACPI
> >> table is simply wrong, and the number even exceeds the maximum GPIO
> >> lines.  As the touchpad works fine with Windows on the same machine,
> >> presumably this is something Windows-ism.  Although it's obviously
> >> a specification violation, believe of that Microsoft will fix this in
> >> the near future is not really realistic.
> >>
> >> It adds the support of overriding broken GPIO number in ACPI table
> >> on particular machines, which are matched using DMI info.  Such
> >> mechanism for fixing up broken firmware and ACPI table is not uncommon
> >> in kernel.  And hopefully it can be useful for other machines that get
> >> broken GPIO number coded in ACPI table.
> > 
> > 
> > +Cc: Hans.
> > 
> > Hans, would appreciate your opinion on this thread. Maybe I'm mistaken in my
> > conclusions.
> 
> So I've read the entire thread here:
> https://lore.kernel.org/linux-gpio/20210226033919.8871-1-shawn.guo@linaro.org/T/#u
> 
> And I agree wih Andy, this is not something which should be fixed up in the
> generic gpiolib-acpi code.
> 
> Note that we have similar things going on on x86 platforms. There are cases
> there where there are e.g. holes in the GPIO ranges advertised by the Intel
> pinctrl drivers. And in the beginning as i2c (and thus GpioIRQ) HID devices
> started to become more common there were also several rounds of work to make
> sure that the GPIO numbering (per ACPI-device / island) exported to the rest
> of the kernel (and thus to gpiolib-acpi) matched with the numbering which
> the ACPI tables expected (so the numbering which the Windows driver use).
> 
> It seems to me, esp. in the light that there are a lot of "crazy high" GPIO
> indexes in the DSDT of the Lenovo Flex 5G, that the right thing to do here
> is to fix the qualcom pinctrl/GPIO driver to number its GPIOs in the way
> expected by these ACPI tables. This will break use of existing devicetrees,
> so it will likely need to detect if the main firmware of the system is ACPI
> or DT based and then use 2 different numbering schemes depending on the
> outcome of that check.
> 
> Please also do not try ti fix this with some quirks in e.g. the i2c-hid driver,
> I will definitely NACK such attempts. From what we can see now any fix clearly
> should be done inside the qualcom GPIO driver.

Thanks for your opinion on this, Hans.  Yeah, with the information from
Jeffrey, I now agree with Andy that these high GPIO numbers are not
broken but have some meaning, and we should map them back to real GPIO
number in Qualcomm GPIO driver.

So we reach a consensus that this is not the right solution for Lenovo
Flex 5G. But what about for Andy's Galileo Gen 2 case, where the GPIO
number in ACPI is truly broken?

  ba8c90c61847 ("gpio: pca953x: Override IRQ for one of the expanders on Galileo Gen 2")

Shawn
