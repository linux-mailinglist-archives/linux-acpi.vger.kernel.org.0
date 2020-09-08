Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69DD261622
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Sep 2020 19:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbgIHREI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Sep 2020 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732080AbgIHRDs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Sep 2020 13:03:48 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE15C0613ED
        for <linux-acpi@vger.kernel.org>; Tue,  8 Sep 2020 10:03:41 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y2so16097416ilp.7
        for <linux-acpi@vger.kernel.org>; Tue, 08 Sep 2020 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNS3GRvMOTeZUyA2sVYVT7axCdo6ttiBNGmu42dBjv0=;
        b=npjYldHdaKN5sNer+//ioO2vd9ZSVt9HRwo/GOz64WLrI1EApu0/oVVpSTuxBpaETH
         zdGBQ1cmVWfRfzBpvEygk0e/Fp1/SJWo0V3MDfwI7uOYbujcbc+EgdlnCvoMMGyWdorN
         Ch0dMop8qmboQmcQ3HM+FjgNWOndFL2BTCgUoiKdJehhEJdoap2e078A90wr5gAxeCsQ
         /RrrJPONIApVqG45o9UVb+oIhU+db+SXQ4Ek6X1+ay0n5jrwUq9T80W+l/s3tK6L0DpE
         H3abAhf3ldad3rCQYdZdGwfEWAvIKImuxO/EYXyb1SfmLSaNac6ePbX1OyihycfpogaN
         3C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNS3GRvMOTeZUyA2sVYVT7axCdo6ttiBNGmu42dBjv0=;
        b=YrOLgNzwDmYc0XYLp29E6jXFOD6bvanBWWVjGSQFlRNFT2uGbNMpaLcSEfyj2n6UVj
         Gf9Mf0uZFrz3QMmWG8B9QxTwiTWPnIJuH+wqQLYA6TYGwaIZd5hvAmHJ5SRwWkMhqu4g
         UB5MjsI3TMeOm/Gtp551YuvefADEiJaMee0aGaXlpvP6FZP2+FGDr1jnfsNeWEn9nhgk
         Ku8/UeDvE47s53RXEBNXSph2Fxn9HwFvl+Inplvv0sN467otohlSFHM9+3jEy+Suky9U
         6LTzDGa5BzrtW9PY/T5pkaF+NYaONaxWEsOT3DrXiDE1VtwF2O+uxrVKnfbj0697NGMh
         gPbQ==
X-Gm-Message-State: AOAM532oeGtxSJ5qi6IjSDRO9UDlU31/CrURszQ6QacQdbz/5I3t450A
        P+46rO92XH3Bry1GuuIJayxYAnP9lsrC+qkbWYKqmA==
X-Google-Smtp-Source: ABdhPJwOhRRAeSvUfM7aXnDLV+8iSGJDTYZ7p05b46NMWtlXoPSG1kGZXtFg8PzijNzZ5d2ig2phLPuE10vzV0zX6Ps=
X-Received: by 2002:a92:1b0b:: with SMTP id b11mr24464248ilb.287.1599584621007;
 Tue, 08 Sep 2020 10:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-24-brgl@bgdev.pl>
 <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org> <20200907095932.GU1891694@smile.fi.intel.com>
 <CAMpxmJXvhYOVkZY7LLf=v+o8E2xKTh1RYhLrdVsS9nN1XZ5QJQ@mail.gmail.com>
 <20200907115310.GA1891694@smile.fi.intel.com> <CAMpxmJUfNkko4Rrb4N5CF_rdwRAWGhVr9DSOHfhYyTxYSH7dsQ@mail.gmail.com>
 <20200907122238.GA1849893@kroah.com>
In-Reply-To: <20200907122238.GA1849893@kroah.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Sep 2020 19:03:30 +0200
Message-ID: <CAMRc=MexhEbnxCN3aN57k4V-mO-vQL=+8z9QFEzOCPkmn16-XQ@mail.gmail.com>
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for gpio-mockup
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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

On Mon, Sep 7, 2020 at 2:22 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Sep 07, 2020 at 02:06:15PM +0200, Bartosz Golaszewski wrote:
> > On Mon, Sep 7, 2020 at 1:53 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Sep 07, 2020 at 12:26:34PM +0200, Bartosz Golaszewski wrote:
> > > > On Mon, Sep 7, 2020 at 11:59 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > On Fri, Sep 04, 2020 at 08:15:59PM -0700, Randy Dunlap wrote:
> > > > > > On 9/4/20 8:45 AM, Bartosz Golaszewski wrote:
> > > > >
> > > > > ...
> > > > >
> > > > > > > +GPIO Testing Driver
> > > > > > > +===================
> > > > > > > +
> > > > > > > +The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
> > > > > > > +chips for testing purposes. There are two ways of configuring the chips exposed
> > > > > > > +by the module. The lines can be accessed using the standard GPIO character
> > > > > > > +device interface as well as manipulated using the dedicated debugfs directory
> > > > > > > +structure.
> > > > > >
> > > > > > Could configfs be used for this instead of debugfs?
> > > > > > debugfs is ad hoc.
> > > > >
> > > > > Actually sounds like a good idea.
> > > > >
> > > >
> > > > Well, then we can go on and write an entirely new mockup driver
> > > > (ditching module params and dropping any backwards compatibility)
> > > > because we're already using debugfs for line values.
> > > >
> > > > How would we pass the device properties to configfs created GPIO chips
> > > > anyway? Devices seem to only be created using mkdir. Am I missing
> > > > something?
> > >
> > > Same way how USB composite works, no?
> > >
> >
> > OK, so create a new chip directory in configfs, configure it using
> > some defined configfs attributes and then finally instantiate it from
> > sysfs?
> >
> > Makes sense and is probably the right way to go. Now the question is:
> > is it fine to just entirely remove the previous gpio-mockup? Should we
> > keep some backwards compatibility? Should we introduce an entirely new
> > module and have a transition period before removing previous
> > gpio-mockup?
> >
> > Also: this is a testing module so to me debugfs is just fine. Is
> > configfs considered stable ABI like sysfs?
>
> Yes it is.  Or at least until you fix all existing users so that if you
> do change it, no one notices it happening :)
>

Got it. One more question: the current debugfs interface we're using
in gpio-mockup exists to allow to read current values of GPIO lines in
output mode (check how the user drives dummy lines) and to set their
simulated pull-up/pull-down resistors (what values the user reads in
input mode).

This works like this: in /sys/kernel/debug/gpio-mockup every dummy
chip creates its own directory (e.g.
/sys/kernel/debug/gpio-mockup/gpiochip0) and inside this directory
there's an attribute per line named after the line's offset (e.g.
/sys/kernel/debug/gpio-mockup/gpiochip0/4). Writing 0 or 1 to this
attribute sets the pull resistor. Reading from it yields the current
value (0 or 1 as well).

This is pretty non-standard so I proposed to put it in debugfs. If we
were to use configfs - is this where something like this should go? Or
rather sysfs? Is it even suitable/acceptable for sysfs?

Thanks,
Bartosz
