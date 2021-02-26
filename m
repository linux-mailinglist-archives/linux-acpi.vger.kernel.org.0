Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BCB3261A4
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Feb 2021 12:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBZK6f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Feb 2021 05:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhBZK6d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Feb 2021 05:58:33 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C32C06174A;
        Fri, 26 Feb 2021 02:57:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t9so5770294pjl.5;
        Fri, 26 Feb 2021 02:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpfHHnCLi9iPuaB4OGPWMTLPFj9UeNNtDCviBs376xc=;
        b=jZgixpWvGPjT5HjoD9Rd0j1Kh5l1dz/YQqqDtfPMT8NEeEhiy/jpEFYktybpvQ+TT5
         TO+PM4fzWy1Xxf7T3hdnGeKGzS8LBcXlqoXE0XeDg5v5o0ISpcE6Fjz+kelax6rZGP/p
         UGzjhY5UTYibDNW8VkFPR34Bw3Cy/P7FrpqP1baQPVcHF/Ud8H/wdxR5gHqIbLtFAZ+M
         bfncN2NIgxWIT2Eghl4rJWdfxYlBXyGBhUr7qt1PCMxHWE7tsunlCjP75gEWEDDt/o/q
         2Ql3W8mmWCQH9KVs45R86EPD71e5DgHoSLRF0p0MIaolHGYdzAHau5BLztE/ycLzfjLt
         CusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpfHHnCLi9iPuaB4OGPWMTLPFj9UeNNtDCviBs376xc=;
        b=W4X9zw+6en/AoxPcjGw9Z3AEJDKSNA4m6qEDU6eHR67/FBQxGp2vqANoALAPROWniR
         5ejJ82EnHhQovhjmosb4+LBzXXHzayQ/FTV1cJf4J8Zsc2upn0P0zGx0MW+SyHJmHoQV
         hEKYB7DJ7q4SpwAxVRdUkXZHFAdwDv7S2lcO2I/drH4nKCvRwACkUTjSEdWrdWdLmNIU
         VY9GdIuPRAOwtLyfED7JFZcROtLxVgjbv/0z9kZ1VflTQw1QgCd24c7p98OmEV+fTg6U
         vOSXrL3yiKl8V6eJ28pC5HiZeTv2Ohecp0gEK9LXJXJhF7KdEl8YHeLk1AAzrCJTnLW/
         hytA==
X-Gm-Message-State: AOAM533vR1EjAx/58AeoyxLuvDYnTC3cXUWaI6C+mlDGMEzfQtaNfaQc
        OvDs7Qhr0imqIROFbKeqxLNprsjg4GUKGnxTr9w=
X-Google-Smtp-Source: ABdhPJx+Hg4T6GvTNVL4bu0uHoGoTpne0ZfecBn9XtQ9Zc4z6j6s84PnSVUTkGV7R/GbdUskQDstsiCIQbjjeDdKcYY=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr2956161pjx.181.1614337073187;
 Fri, 26 Feb 2021 02:57:53 -0800 (PST)
MIME-Version: 1.0
References: <20210226033919.8871-1-shawn.guo@linaro.org> <CAHp75Vcb=NO9OWjSpBeVC4c+9=aXE=yiDWVBwLD1DnzwdgFD6Q@mail.gmail.com>
 <20210226093925.GA24428@dragon>
In-Reply-To: <20210226093925.GA24428@dragon>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Feb 2021 12:57:37 +0200
Message-ID: <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 26, 2021 at 11:39 AM Shawn Guo <shawn.guo@linaro.org> wrote:
>
> On Fri, Feb 26, 2021 at 11:12:07AM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 26, 2021 at 5:42 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > >
> > > Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
> > > not working.  That's because the GpioInt number of TSC2 node in ACPI
> > > table is simply wrong, and the number even exceeds the maximum GPIO
> > > lines.  As the touchpad works fine with Windows on the same machine,
> > > presumably this is something Windows-ism.  Although it's obviously
> > > a specification violation, believe of that Microsoft will fix this in
> > > the near future is not really realistic.
> > >
> > > It adds the support of overriding broken GPIO number in ACPI table
> > > on particular machines, which are matched using DMI info.  Such
> > > mechanism for fixing up broken firmware and ACPI table is not uncommon
> > > in kernel.  And hopefully it can be useful for other machines that get
> > > broken GPIO number coded in ACPI table.
> >
> > Thanks for the report and patch.
> >
> > First of all, have you reported the issue to Lenovo? At least they
> > will know that they did wrong.
>
> Yes, we are reporting this to Lenovo, but to be honest, we are not sure
> how much they will care about it, as they are shipping the laptop with
> Windows only.
>
> > Second, is it possible to have somewhere output of `acpidump -o
> > flex5g.dat` (the flex5g.dat file)?
>
> https://raw.githubusercontent.com/aarch64-laptops/build/master/misc/lenovo-flex-5g/dsdt.dsl
>
> > And as Mika said once to one of mine patches "since you know the
> > number ahead there is no need to pollute GPIO ACPI library core with
> > this quirk". But in any case I would like to see the ACPI tables
> > first.
>
> Oh, so you had something similar already?  Could you point me to the
> patch and discussion?

Similar, but might be not the same:
 - patches in the upstream [1] (v3 applied), discussion [2]
 - new version with some additional fixes [3]

[1]: ba8c90c61847 ("gpio: pca953x: Override IRQ for one of the
expanders on Galileo Gen 2")
[2]: https://lore.kernel.org/linux-gpio/20200520211916.25727-1-andriy.shevchenko@linux.intel.com/T/#u
[3]: https://lore.kernel.org/linux-gpio/20210225163320.71267-1-andriy.shevchenko@linux.intel.com/T/#u





-- 
With Best Regards,
Andy Shevchenko
