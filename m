Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AE825F9F3
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 13:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgIGLx6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 07:53:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:28367 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbgIGLxp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 07:53:45 -0400
IronPort-SDR: D1BCgaLvVdV8i7RbTPUbCLG0ekRStFm4lKfXrBjjG+Eh4oU+nF+1ICumtvenkfFBVJw5SzWcro
 vj2exOHv+qQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="155393671"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="155393671"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 04:53:16 -0700
IronPort-SDR: ixF7b9yAVn836fAh6s2qzvEa19zv5JnMJMadxQWU2fYVdf/AbkKR8SLryoAUkqNJeLEyZYAANW
 7IyoOszCVMhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="333143101"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2020 04:53:13 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFFhu-00EwMi-ER; Mon, 07 Sep 2020 14:53:10 +0300
Date:   Mon, 7 Sep 2020 14:53:10 +0300
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
        LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for
 gpio-mockup
Message-ID: <20200907115310.GA1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-24-brgl@bgdev.pl>
 <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org>
 <20200907095932.GU1891694@smile.fi.intel.com>
 <CAMpxmJXvhYOVkZY7LLf=v+o8E2xKTh1RYhLrdVsS9nN1XZ5QJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJXvhYOVkZY7LLf=v+o8E2xKTh1RYhLrdVsS9nN1XZ5QJQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 12:26:34PM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 7, 2020 at 11:59 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Sep 04, 2020 at 08:15:59PM -0700, Randy Dunlap wrote:
> > > On 9/4/20 8:45 AM, Bartosz Golaszewski wrote:
> >
> > ...
> >
> > > > +GPIO Testing Driver
> > > > +===================
> > > > +
> > > > +The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
> > > > +chips for testing purposes. There are two ways of configuring the chips exposed
> > > > +by the module. The lines can be accessed using the standard GPIO character
> > > > +device interface as well as manipulated using the dedicated debugfs directory
> > > > +structure.
> > >
> > > Could configfs be used for this instead of debugfs?
> > > debugfs is ad hoc.
> >
> > Actually sounds like a good idea.
> >
> 
> Well, then we can go on and write an entirely new mockup driver
> (ditching module params and dropping any backwards compatibility)
> because we're already using debugfs for line values.
> 
> How would we pass the device properties to configfs created GPIO chips
> anyway? Devices seem to only be created using mkdir. Am I missing
> something?

Same way how USB composite works, no?

-- 
With Best Regards,
Andy Shevchenko


