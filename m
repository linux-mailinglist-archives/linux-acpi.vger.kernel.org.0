Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E157B260230
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 19:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgIGRT5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 13:19:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:40312 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729565AbgIGNxU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 09:53:20 -0400
IronPort-SDR: FRYaLof1Stayp3r3/A32d5+SC8+T5VqW7lqR0RbEAO/jzyH5EFlBK9vI/KoWBMSiCe7k3u8MIU
 3BNpHFBBnQWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="145714274"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="145714274"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 06:53:04 -0700
IronPort-SDR: ZpD+nR3zD5cFp9j3Cc3dwR1QwVccLWIgbyDzO5RuQx1ta5A3XEWYaZZ2XACE5B4yL8bRHhiDEr
 hX9xYuaV/5pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="333169481"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2020 06:53:01 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFHZq-00ExvU-05; Mon, 07 Sep 2020 16:52:58 +0300
Date:   Mon, 7 Sep 2020 16:52:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for
 gpio-mockup
Message-ID: <20200907135257.GJ1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-24-brgl@bgdev.pl>
 <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org>
 <20200907095932.GU1891694@smile.fi.intel.com>
 <CAMpxmJXvhYOVkZY7LLf=v+o8E2xKTh1RYhLrdVsS9nN1XZ5QJQ@mail.gmail.com>
 <20200907115310.GA1891694@smile.fi.intel.com>
 <CAMpxmJUfNkko4Rrb4N5CF_rdwRAWGhVr9DSOHfhYyTxYSH7dsQ@mail.gmail.com>
 <20200907123837.GG1891694@smile.fi.intel.com>
 <CAMpxmJXNYZb66SPuzR_3CEVwD=PQ6z6Ew3ia7ZL=wSU0QGhjEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJXNYZb66SPuzR_3CEVwD=PQ6z6Ew3ia7ZL=wSU0QGhjEA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 02:57:29PM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 7, 2020 at 2:38 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Sep 07, 2020 at 02:06:15PM +0200, Bartosz Golaszewski wrote:
> > > On Mon, Sep 7, 2020 at 1:53 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Sep 07, 2020 at 12:26:34PM +0200, Bartosz Golaszewski wrote:
> > > > > On Mon, Sep 7, 2020 at 11:59 AM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Fri, Sep 04, 2020 at 08:15:59PM -0700, Randy Dunlap wrote:
> > > > > > > On 9/4/20 8:45 AM, Bartosz Golaszewski wrote:
> >
> > ...
> >
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
> > > is it fine to just entirely remove the previous gpio-mockup?
> >
> > Since, for example, I never saw device property bindings for that driver I
> > assume that it was never considered as an ABI, so feel free to hack it in
> > either direction.
> >
> > > Should we
> > > keep some backwards compatibility?
> >
> > I wouldn't probably spend time on this.
> >
> > > Should we introduce an entirely new
> > > module and have a transition period before removing previous
> > > gpio-mockup?
> >
> > Neither transition period.
> >
> 
> I wouldn't rush this actually. gpio-mockup is used a lot by libgpiod
> and probably by Kent's Go library. My main goal with this series is to
> extend it to allow for more advanced testing like simulating spurious
> irqs to test the software debouncer or custom line name formats to
> test name lookups.

When I wrote above I didn't mean this should be done in a hurry. Just during
one release to make all parties ready for the change.

> I need to think about it some more. An entirely new configfs interface
> would take time too.

Sure!

-- 
With Best Regards,
Andy Shevchenko


