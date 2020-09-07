Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAAD26036E
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 19:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgIGRtI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 13:49:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:42086 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbgIGMj1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 08:39:27 -0400
IronPort-SDR: WBEeyuFP8hGcnGsYKszVJMrEVm9/hhP4MDtGgH+RcJ3+i9c6cGVDKB5VispU5Masx/ZkLI2FqZ
 iizPQrDHofpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="242811803"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="242811803"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 05:38:43 -0700
IronPort-SDR: b9BfZlr40QZ2qISx/JXwCtkBAzS5PgLGV5xflcnOM8vMWXear5QSlnH4ccfPIOpexgx7jr18OP
 bYmVrfDS4+yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="333151425"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2020 05:38:40 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFGPt-00Ewye-H3; Mon, 07 Sep 2020 15:38:37 +0300
Date:   Mon, 7 Sep 2020 15:38:37 +0300
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
Message-ID: <20200907123837.GG1891694@smile.fi.intel.com>
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
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 02:06:15PM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 7, 2020 at 1:53 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Sep 07, 2020 at 12:26:34PM +0200, Bartosz Golaszewski wrote:
> > > On Mon, Sep 7, 2020 at 11:59 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Sep 04, 2020 at 08:15:59PM -0700, Randy Dunlap wrote:
> > > > > On 9/4/20 8:45 AM, Bartosz Golaszewski wrote:

...

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
> is it fine to just entirely remove the previous gpio-mockup?

Since, for example, I never saw device property bindings for that driver I
assume that it was never considered as an ABI, so feel free to hack it in
either direction.

> Should we
> keep some backwards compatibility?

I wouldn't probably spend time on this.

> Should we introduce an entirely new
> module and have a transition period before removing previous
> gpio-mockup?

Neither transition period.

> Also: this is a testing module so to me debugfs is just fine. Is
> configfs considered stable ABI like sysfs?

But this one is a good question. I think ConfigFS is stricter than DebugFS,
up to being an ABI. But never did myself such a thing, so would like to hear
experienced developers.

-- 
With Best Regards,
Andy Shevchenko


