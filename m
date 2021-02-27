Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBB9326B78
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Feb 2021 04:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhB0Dra (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Feb 2021 22:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhB0Dr3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Feb 2021 22:47:29 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABE4C061786
        for <linux-acpi@vger.kernel.org>; Fri, 26 Feb 2021 19:46:48 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b15so7132185pjb.0
        for <linux-acpi@vger.kernel.org>; Fri, 26 Feb 2021 19:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pHwELUqccdBmAIg0m7n6Box0vpJWKPugDvgpP9sWbf0=;
        b=rw0XRB//u/XUtHFfv7BWAKOST6LsTCfGebmh8LKkSjXiN3EiI6oazPQnZBX1ad/3nh
         Au0zZ7y4KQybuklU8FXDb1QGW+QLM9ilrpIUi1iClplzJi0dPsaLYNLgcrzQhZHZvBXa
         NOrAczMeuEMsfvjJPcdRjX0LhwjMl5iBsxjHIEZXP3rxL3HxExKlvQ5SEdrUBrbBWRmj
         lXspdBrLL4DYf7z9vlKhjX82zOlt+Nc6tUcREcv68kIryI1Nw9nLfy77JjUpPN2IA/0W
         AsNeZr55fgu9XuEbHxZA5G56swtcS+c5a4pJfY3MhBOPp6gnfzRpZRu1ma52tsCAaxbB
         YSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pHwELUqccdBmAIg0m7n6Box0vpJWKPugDvgpP9sWbf0=;
        b=rHFZpYtjvLWxYGVKSw4JylyAwjfZtEhep4wEcIENcOW8FihSxrGqAqUZxhhk9CCpiB
         gp6/TaeRx+K9Wh7ENv04lSHHopLW3YC7d0kXuOqntuzW/b7PUsPruUsE3B6AQdqYZdZs
         NLmorGYwbWeX3TVfLQhevy6V+pGyWRS/Cd2h6JcQmqD+QZJf87gIHLdHxbE5F7Sn8NcW
         pJdU7GEFo/U+hEdlkQD38ojywwW9+osacOTCRifSflzlR9VbfTSyPr9dNhssjG6hv+qv
         j8r2mu/geCDJhC1JuPsxNvsy7jwOH1BOBwgm19E4EEKPtDZrV3g+7ZY7uYaJnFp2dWuK
         YS+A==
X-Gm-Message-State: AOAM532YIngyk7qXo+TdQqQsxwrS61lUS/Pq+VFn1djs1yctuQbvPwk2
        PQdy+y1iOSJF8zCJI2XnHaRL0g==
X-Google-Smtp-Source: ABdhPJxVo5cZ8UZ7+ZQdCP6vhhTjoRIDuAhSLuizUutQNwf977e+WstSfxUjh6j8GvVH0KqJ4inRrA==
X-Received: by 2002:a17:90a:a10a:: with SMTP id s10mr6642891pjp.36.1614397608212;
        Fri, 26 Feb 2021 19:46:48 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id 72sm10568295pfv.5.2021.02.26.19.46.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Feb 2021 19:46:47 -0800 (PST)
Date:   Sat, 27 Feb 2021 11:46:42 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
Message-ID: <20210227034641.GC24428@dragon>
References: <20210226033919.8871-1-shawn.guo@linaro.org>
 <CAHp75Vcb=NO9OWjSpBeVC4c+9=aXE=yiDWVBwLD1DnzwdgFD6Q@mail.gmail.com>
 <20210226093925.GA24428@dragon>
 <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 26, 2021 at 12:57:37PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 26, 2021 at 11:39 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> > On Fri, Feb 26, 2021 at 11:12:07AM +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 26, 2021 at 5:42 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > > >
> > > > Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
> > > > not working.  That's because the GpioInt number of TSC2 node in ACPI
> > > > table is simply wrong, and the number even exceeds the maximum GPIO
> > > > lines.  As the touchpad works fine with Windows on the same machine,
> > > > presumably this is something Windows-ism.  Although it's obviously
> > > > a specification violation, believe of that Microsoft will fix this in
> > > > the near future is not really realistic.
> > > >
> > > > It adds the support of overriding broken GPIO number in ACPI table
> > > > on particular machines, which are matched using DMI info.  Such
> > > > mechanism for fixing up broken firmware and ACPI table is not uncommon
> > > > in kernel.  And hopefully it can be useful for other machines that get
> > > > broken GPIO number coded in ACPI table.
> > >
> > > Thanks for the report and patch.
> > >
> > > First of all, have you reported the issue to Lenovo? At least they
> > > will know that they did wrong.
> >
> > Yes, we are reporting this to Lenovo, but to be honest, we are not sure
> > how much they will care about it, as they are shipping the laptop with
> > Windows only.
> >
> > > Second, is it possible to have somewhere output of `acpidump -o
> > > flex5g.dat` (the flex5g.dat file)?
> >
> > https://raw.githubusercontent.com/aarch64-laptops/build/master/misc/lenovo-flex-5g/dsdt.dsl
> >
> > > And as Mika said once to one of mine patches "since you know the
> > > number ahead there is no need to pollute GPIO ACPI library core with
> > > this quirk". But in any case I would like to see the ACPI tables
> > > first.
> >
> > Oh, so you had something similar already?  Could you point me to the
> > patch and discussion?
> 
> Similar, but might be not the same:
>  - patches in the upstream [1] (v3 applied), discussion [2]
>  - new version with some additional fixes [3]

Thanks for all the pointers.  It looks to me that it's the same problem
- the GPIO number in ACPI table is broken and needs an override from
kernel.  So I think what we need is a generic solution to a problem
not uncommon.  Rather than asking all different drivers to resolve the
same problem all over the kernel, I believe GPIO ACPI library is just
the right place.

Looking at your platform and problem, I realise that to be a generic
solution, my patch needs an additional device identification matching,
as one GPIO number that is broken for one device could be correct for
another.  I will improve it, so that your problem can be resolved by
simply adding a new entry to acpi_gpio_pin_override_table[].

Shawn
