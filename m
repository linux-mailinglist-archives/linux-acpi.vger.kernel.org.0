Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9891825FA66
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 14:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgIGMWk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 08:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729242AbgIGMWa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 08:22:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B031021707;
        Mon,  7 Sep 2020 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599481344;
        bh=hO9ipewOxdkfWfb7kBKgMdC6UCFJZgkb2q8sjiDbxKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/hORE3XgUiGv7oUQ/2rhFBTipX8xL/hiFkh+K4uXwDOgiroiPLlfnOeZmJSKYBd3
         il7GsuOBmOQ9DpO5j+Qx/Js4rtSWIisIORjqkNhjxRSiBRZsKkOqOqEl1h2lyPtb8l
         3q0RePLQmgUeG0HyXdgOrYFisTVJC5qD1y+h1Syc=
Date:   Mon, 7 Sep 2020 14:22:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
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
Message-ID: <20200907122238.GA1849893@kroah.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-24-brgl@bgdev.pl>
 <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org>
 <20200907095932.GU1891694@smile.fi.intel.com>
 <CAMpxmJXvhYOVkZY7LLf=v+o8E2xKTh1RYhLrdVsS9nN1XZ5QJQ@mail.gmail.com>
 <20200907115310.GA1891694@smile.fi.intel.com>
 <CAMpxmJUfNkko4Rrb4N5CF_rdwRAWGhVr9DSOHfhYyTxYSH7dsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJUfNkko4Rrb4N5CF_rdwRAWGhVr9DSOHfhYyTxYSH7dsQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 02:06:15PM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 7, 2020 at 1:53 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Sep 07, 2020 at 12:26:34PM +0200, Bartosz Golaszewski wrote:
> > > On Mon, Sep 7, 2020 at 11:59 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Fri, Sep 04, 2020 at 08:15:59PM -0700, Randy Dunlap wrote:
> > > > > On 9/4/20 8:45 AM, Bartosz Golaszewski wrote:
> > > >
> > > > ...
> > > >
> > > > > > +GPIO Testing Driver
> > > > > > +===================
> > > > > > +
> > > > > > +The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
> > > > > > +chips for testing purposes. There are two ways of configuring the chips exposed
> > > > > > +by the module. The lines can be accessed using the standard GPIO character
> > > > > > +device interface as well as manipulated using the dedicated debugfs directory
> > > > > > +structure.
> > > > >
> > > > > Could configfs be used for this instead of debugfs?
> > > > > debugfs is ad hoc.
> > > >
> > > > Actually sounds like a good idea.
> > > >
> > >
> > > Well, then we can go on and write an entirely new mockup driver
> > > (ditching module params and dropping any backwards compatibility)
> > > because we're already using debugfs for line values.
> > >
> > > How would we pass the device properties to configfs created GPIO chips
> > > anyway? Devices seem to only be created using mkdir. Am I missing
> > > something?
> >
> > Same way how USB composite works, no?
> >
> 
> OK, so create a new chip directory in configfs, configure it using
> some defined configfs attributes and then finally instantiate it from
> sysfs?
> 
> Makes sense and is probably the right way to go. Now the question is:
> is it fine to just entirely remove the previous gpio-mockup? Should we
> keep some backwards compatibility? Should we introduce an entirely new
> module and have a transition period before removing previous
> gpio-mockup?
> 
> Also: this is a testing module so to me debugfs is just fine. Is
> configfs considered stable ABI like sysfs?

Yes it is.  Or at least until you fix all existing users so that if you
do change it, no one notices it happening :)

thanks,

greg k-h
