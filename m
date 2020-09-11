Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2344D2660F5
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Sep 2020 16:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgIKOJr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Sep 2020 10:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgIKNRk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Sep 2020 09:17:40 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A742C061756
        for <linux-acpi@vger.kernel.org>; Fri, 11 Sep 2020 06:07:14 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q21so9898193edv.1
        for <linux-acpi@vger.kernel.org>; Fri, 11 Sep 2020 06:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TgQoed0GxIerQ44x+71MWXYhJbzdbOqc1n5qsFlaJSg=;
        b=EarytBvwoQep7qd57VxmLST9JhvldbG08X3Nhqjheaj8MGEJpUXQbQdXO9VsM17+03
         b1qLL2NsHvu9J9xBXIZvZarcrQoDu0q+HllUQxkpUyTsxMId3oXHB1Tn07+fRJ1jFTf8
         +5jh35x6TyiSpnx7oUljGT0afOX2lXuVBSl4XpEijxq/NGNs1cimpkYYG6C3EEeqHK2G
         y6OQEZE4nTNaqwyc45DYEJUC/gCELLHgmGL9F+MQmMIvSuaK/TtZRT6Z5yGjJyxMUBTu
         2w+2PLGV+qbr3yjE73O+TjHkWTlvHPSQrDWJ0TiBY9Z+RJc/v+2HUd2d/hD2asyZCEaS
         6mpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TgQoed0GxIerQ44x+71MWXYhJbzdbOqc1n5qsFlaJSg=;
        b=Jl1v+33fJslGKShS+uSjZ9d0R4Zr6QbW0u90ozw6d6/RCu4SqbhsXJ1x56+TEqAu0I
         OwyHc4n9g8fRRMvzNBzFKJWrE/c7syxxbUawg7jt4kH5NuaNwBPV0FIqwaA7GvBuyhKC
         wG6j8oPUZdsOcyQjAxtv/43xChP4wk9RYZrnQt1VZ07JgWGK2RYyPaPHgLXhRWmRUw/P
         TZ7ZkUW+TOwbrT/3gsIWF0sL8k+tK+gaUqcSUO91jQ90K+qTlhRNc+tihTqkqv8Q6W+w
         F8mO92g6oGF7ybI1mrF5OWKdNLPUhzVK9/4+togOHxuPP8/V9/mCatPPJRvjIkPVEf1f
         Rs0g==
X-Gm-Message-State: AOAM530GHFO47Tr1JZ1Haxvg086L4CYrpvVmMsZOF8GqXUtuacbsHUl4
        9yzp3/iV+OSAmQ/YMzMv+fSfg8sih+Y66DhviUxiFZIRVAI=
X-Google-Smtp-Source: ABdhPJy+rDUfCaOK6p6Va0hZoFOBHdUKP5x0jZI7yOtovb7mUCA9QlmaUYaRaxfvgu4qMN52cQ6UDcW0sSJC9puhE3Q=
X-Received: by 2002:a50:f687:: with SMTP id d7mr1944285edn.353.1599829633051;
 Fri, 11 Sep 2020 06:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-24-brgl@bgdev.pl>
 <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org> <20200907095932.GU1891694@smile.fi.intel.com>
 <CAMpxmJXvhYOVkZY7LLf=v+o8E2xKTh1RYhLrdVsS9nN1XZ5QJQ@mail.gmail.com>
 <20200907115310.GA1891694@smile.fi.intel.com> <CAMpxmJUfNkko4Rrb4N5CF_rdwRAWGhVr9DSOHfhYyTxYSH7dsQ@mail.gmail.com>
 <20200907122238.GA1849893@kroah.com> <CAMRc=MexhEbnxCN3aN57k4V-mO-vQL=+8z9QFEzOCPkmn16-XQ@mail.gmail.com>
 <20200911125625.GF3758477@kroah.com>
In-Reply-To: <20200911125625.GF3758477@kroah.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 11 Sep 2020 15:07:02 +0200
Message-ID: <CAMpxmJUd-ALoBi4aC1nsJ7JmEsANe_gZfBegCiZtP6BwPpC52g@mail.gmail.com>
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for gpio-mockup
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 11, 2020 at 3:01 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 08, 2020 at 07:03:30PM +0200, Bartosz Golaszewski wrote:
> > On Mon, Sep 7, 2020 at 2:22 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Sep 07, 2020 at 02:06:15PM +0200, Bartosz Golaszewski wrote:
> > > > On Mon, Sep 7, 2020 at 1:53 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > On Mon, Sep 07, 2020 at 12:26:34PM +0200, Bartosz Golaszewski wrote:
> > > > > > On Mon, Sep 7, 2020 at 11:59 AM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > >
> > > > > > > On Fri, Sep 04, 2020 at 08:15:59PM -0700, Randy Dunlap wrote:
> > > > > > > > On 9/4/20 8:45 AM, Bartosz Golaszewski wrote:
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > > > +GPIO Testing Driver
> > > > > > > > > +===================
> > > > > > > > > +
> > > > > > > > > +The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
> > > > > > > > > +chips for testing purposes. There are two ways of configuring the chips exposed
> > > > > > > > > +by the module. The lines can be accessed using the standard GPIO character
> > > > > > > > > +device interface as well as manipulated using the dedicated debugfs directory
> > > > > > > > > +structure.
> > > > > > > >
> > > > > > > > Could configfs be used for this instead of debugfs?
> > > > > > > > debugfs is ad hoc.
> > > > > > >
> > > > > > > Actually sounds like a good idea.
> > > > > > >
> > > > > >
> > > > > > Well, then we can go on and write an entirely new mockup driver
> > > > > > (ditching module params and dropping any backwards compatibility)
> > > > > > because we're already using debugfs for line values.
> > > > > >
> > > > > > How would we pass the device properties to configfs created GPIO chips
> > > > > > anyway? Devices seem to only be created using mkdir. Am I missing
> > > > > > something?
> > > > >
> > > > > Same way how USB composite works, no?
> > > > >
> > > >
> > > > OK, so create a new chip directory in configfs, configure it using
> > > > some defined configfs attributes and then finally instantiate it from
> > > > sysfs?
> > > >
> > > > Makes sense and is probably the right way to go. Now the question is:
> > > > is it fine to just entirely remove the previous gpio-mockup? Should we
> > > > keep some backwards compatibility? Should we introduce an entirely new
> > > > module and have a transition period before removing previous
> > > > gpio-mockup?
> > > >
> > > > Also: this is a testing module so to me debugfs is just fine. Is
> > > > configfs considered stable ABI like sysfs?
> > >
> > > Yes it is.  Or at least until you fix all existing users so that if you
> > > do change it, no one notices it happening :)
> > >
> >
> > Got it. One more question: the current debugfs interface we're using
> > in gpio-mockup exists to allow to read current values of GPIO lines in
> > output mode (check how the user drives dummy lines) and to set their
> > simulated pull-up/pull-down resistors (what values the user reads in
> > input mode).
> >
> > This works like this: in /sys/kernel/debug/gpio-mockup every dummy
> > chip creates its own directory (e.g.
> > /sys/kernel/debug/gpio-mockup/gpiochip0) and inside this directory
> > there's an attribute per line named after the line's offset (e.g.
> > /sys/kernel/debug/gpio-mockup/gpiochip0/4). Writing 0 or 1 to this
> > attribute sets the pull resistor. Reading from it yields the current
> > value (0 or 1 as well).
> >
> > This is pretty non-standard so I proposed to put it in debugfs. If we
> > were to use configfs - is this where something like this should go? Or
> > rather sysfs? Is it even suitable/acceptable for sysfs?
>
> That sounds like it would work in sysfs just fine as-is, why don't you
> all want to use that?  configfs is good for "set a bunch of attributes
> to different values and then do a 'create/go/work'" type action.
>

I've started looking into it. I need to first implement committable
items for configfs because mockup GPIO chips need to be configured
before they're instantiated. It'll be configfs to configure and
instantiate each chip and a set of sysfs attributes to manipulate
existing chips.

Bartosz
