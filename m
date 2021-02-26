Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A34325FCF
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Feb 2021 10:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhBZJPM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Feb 2021 04:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhBZJNE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Feb 2021 04:13:04 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0C2C061574;
        Fri, 26 Feb 2021 01:12:23 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w18so5855559pfu.9;
        Fri, 26 Feb 2021 01:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lPqrvGOM/KxlTUCjatUeX0M7ibWEjhxXFLOE1+buRlw=;
        b=FlXECRlidF8uQU1OVc4FL5J8KoAoHk0AcktARnXgD8JBow3qyJuUJv8KICmQSlcwWS
         TsIYau0oCOC9iiq6ki9hNHqylgKM5UyoVnFbQbI5ycyKYg5auT4k63mbaUuuHEm98VBJ
         7OGYxN5pYziCqMMeBQGyDo0PfBjGxFQ8mVNKVqkn1PrclFXaqPil0XzDd5DdnHIqa5U1
         xd8XgK/fTMxrrONXjIw53wDjK3V6/+k6WZOFWycX+cN7LTABVi7srJdJjH+qy5iRTaI5
         xNR3ZL+t5IiH+jYl7uSkJv4msP/2huv5e6ub4cmwv77EfLJA8z59Aqb98gKbkNVZozbQ
         J7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPqrvGOM/KxlTUCjatUeX0M7ibWEjhxXFLOE1+buRlw=;
        b=EDUr9GBlHHB4yL9ieA0JJoqge+MHij5q4E/rKBq4s6KNo5EsZmoXz+ziTwi6Bqvi+X
         PXxWAZGhChSwHqqBSHGpwMFqftZoXyCRWwycdE8nArw7WV7EgbLx3PG0EtboON3DTCHx
         R6FfuqXqP4wG7mu0i2HClVKryClt48TZGR1aon9uuxxwQyCqjnphg6emXHndsUMcevjZ
         fOYwKm9omrqukapzKrbzlIlRDjbvjKsR/O9BOHk3mbAYiOE1Uc/QqESqc/Gx66Gzq4JQ
         /Bf+DDsi8KcHkgujfkBP2ygMYlrWTelKIPglonviGAS5P914afD8bU19OpSa1bHIN3H/
         X0Bg==
X-Gm-Message-State: AOAM531BT5OFMTbUpFIx4f+e7jYmwOcjnXds96f5NMZbdCmxWXFHKZXI
        fhKymaqitHzdR2C3j0sF3n/GTECZKKdEo7DGCGw=
X-Google-Smtp-Source: ABdhPJxwO1ID0hD4wYchNm1wqsK9bAJ9S/d7SSGeo4uTlTzk7T6IsMtspmU31Jmkqfao9k087+w9AHj28sCckRxseWk=
X-Received: by 2002:a05:6a00:854:b029:1b7:6233:c5f with SMTP id
 q20-20020a056a000854b02901b762330c5fmr2463442pfk.73.1614330743282; Fri, 26
 Feb 2021 01:12:23 -0800 (PST)
MIME-Version: 1.0
References: <20210226033919.8871-1-shawn.guo@linaro.org>
In-Reply-To: <20210226033919.8871-1-shawn.guo@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Feb 2021 11:12:07 +0200
Message-ID: <CAHp75Vcb=NO9OWjSpBeVC4c+9=aXE=yiDWVBwLD1DnzwdgFD6Q@mail.gmail.com>
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

On Fri, Feb 26, 2021 at 5:42 AM Shawn Guo <shawn.guo@linaro.org> wrote:
>
> Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
> not working.  That's because the GpioInt number of TSC2 node in ACPI
> table is simply wrong, and the number even exceeds the maximum GPIO
> lines.  As the touchpad works fine with Windows on the same machine,
> presumably this is something Windows-ism.  Although it's obviously
> a specification violation, believe of that Microsoft will fix this in
> the near future is not really realistic.
>
> It adds the support of overriding broken GPIO number in ACPI table
> on particular machines, which are matched using DMI info.  Such
> mechanism for fixing up broken firmware and ACPI table is not uncommon
> in kernel.  And hopefully it can be useful for other machines that get
> broken GPIO number coded in ACPI table.

Thanks for the report and patch.

First of all, have you reported the issue to Lenovo? At least they
will know that they did wrong.
Second, is it possible to have somewhere output of `acpidump -o
flex5g.dat` (the flex5g.dat file)?

And as Mika said once to one of mine patches "since you know the
number ahead there is no need to pollute GPIO ACPI library core with
this quirk". But in any case I would like to see the ACPI tables
first.

-- 
With Best Regards,
Andy Shevchenko
