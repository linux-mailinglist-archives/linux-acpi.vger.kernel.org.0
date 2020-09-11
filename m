Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7D226613A
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Sep 2020 16:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgIKOaE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Sep 2020 10:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgIKNMA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 11 Sep 2020 09:12:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9AC22473;
        Fri, 11 Sep 2020 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599829259;
        bh=IyvEvOPgto/Pn5HZjNjgTK0PWnd9QVmaHjv3C3iB+l0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njqGWaXDI2bwZRIKgvzoWnAM/8gymlwGBUYLNfq1bjuDPLiZa082yMwG9zIqGgDBf
         XVlAsQ58AkucCUgbLs9WZ1aFWT08HetSenRxCiOVcfnEZdo1gJDqyzJdNi1AyRshuK
         PTwY7QrsapXkhwPyC1BS602027lZ4eJCem1iEAu4=
Date:   Fri, 11 Sep 2020 14:56:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
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
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for
 gpio-mockup
Message-ID: <20200911125625.GF3758477@kroah.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-24-brgl@bgdev.pl>
 <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org>
 <20200907095932.GU1891694@smile.fi.intel.com>
 <CAMpxmJXvhYOVkZY7LLf=v+o8E2xKTh1RYhLrdVsS9nN1XZ5QJQ@mail.gmail.com>
 <20200907115310.GA1891694@smile.fi.intel.com>
 <CAMpxmJUfNkko4Rrb4N5CF_rdwRAWGhVr9DSOHfhYyTxYSH7dsQ@mail.gmail.com>
 <20200907122238.GA1849893@kroah.com>
 <CAMRc=MexhEbnxCN3aN57k4V-mO-vQL=+8z9QFEzOCPkmn16-XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MexhEbnxCN3aN57k4V-mO-vQL=+8z9QFEzOCPkmn16-XQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 08, 2020 at 07:03:30PM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 7, 2020 at 2:22 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Sep 07, 2020 at 02:06:15PM +0200, Bartosz Golaszewski wrote:
> > > On Mon, Sep 7, 2020 at 1:53 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Mon, Sep 07, 2020 at 12:26:34PM +0200, Bartosz Golaszewski wrote:
> > > > > On Mon, Sep 7, 2020 at 11:59 AM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > >
> > > > > > On Fri, Sep 04, 2020 at 08:15:59PM -0700, Randy Dunlap wrote:
> > > > > > > On 9/4/20 8:45 AM, Bartosz Golaszewski wrote:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > > +GPIO Testing Driver
> > > > > > > > +===================
> > > > > > > > +
> > > > > > > > +The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
> > > > > > > > +chips for testing purposes. There are two ways of configuring the chips exposed
> > > > > > > > +by the module. The lines can be accessed using the standard GPIO character
> > > > > > > > +device interface as well as manipulated using the dedicated debugfs directory
> > > > > > > > +structure.
> > > > > > >
> > > > > > > Could configfs be used for this instead of debugfs?
> > > > > > > debugfs is ad hoc.
> > > > > >
> > > > > > Actually sounds like a good idea.
> > > > > >
> > > > >
> > > > > Well, then we can go on and write an entirely new mockup driver
> > > > > (ditching module params and dropping any backwards compatibility)
> > > > > because we're already using debugfs for line values.
> > > > >
> > > > > How would we pass the device properties to configfs created GPIO chips
> > > > > anyway? Devices seem to only be created using mkdir. Am I missing
> > > > > something?
> > > >
> > > > Same way how USB composite works, no?
> > > >
> > >
> > > OK, so create a new chip directory in configfs, configure it using
> > > some defined configfs attributes and then finally instantiate it from
> > > sysfs?
> > >
> > > Makes sense and is probably the right way to go. Now the question is:
> > > is it fine to just entirely remove the previous gpio-mockup? Should we
> > > keep some backwards compatibility? Should we introduce an entirely new
> > > module and have a transition period before removing previous
> > > gpio-mockup?
> > >
> > > Also: this is a testing module so to me debugfs is just fine. Is
> > > configfs considered stable ABI like sysfs?
> >
> > Yes it is.  Or at least until you fix all existing users so that if you
> > do change it, no one notices it happening :)
> >
> 
> Got it. One more question: the current debugfs interface we're using
> in gpio-mockup exists to allow to read current values of GPIO lines in
> output mode (check how the user drives dummy lines) and to set their
> simulated pull-up/pull-down resistors (what values the user reads in
> input mode).
> 
> This works like this: in /sys/kernel/debug/gpio-mockup every dummy
> chip creates its own directory (e.g.
> /sys/kernel/debug/gpio-mockup/gpiochip0) and inside this directory
> there's an attribute per line named after the line's offset (e.g.
> /sys/kernel/debug/gpio-mockup/gpiochip0/4). Writing 0 or 1 to this
> attribute sets the pull resistor. Reading from it yields the current
> value (0 or 1 as well).
> 
> This is pretty non-standard so I proposed to put it in debugfs. If we
> were to use configfs - is this where something like this should go? Or
> rather sysfs? Is it even suitable/acceptable for sysfs?

That sounds like it would work in sysfs just fine as-is, why don't you
all want to use that?  configfs is good for "set a bunch of attributes
to different values and then do a 'create/go/work'" type action.


thanks,

greg k-h
