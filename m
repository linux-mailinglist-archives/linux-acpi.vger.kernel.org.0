Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9110B25F9F7
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 13:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgIGLrr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 07:47:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:18497 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbgIGLq3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 07:46:29 -0400
IronPort-SDR: u4KohBcvYcG9RbkmPJ3ozmpfiYzDMsjWNloDyxd9KR012bFb7MH/gw1Y3NYSAU8MddCr0BTx8J
 BVlYhcWaDl4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="176046003"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="176046003"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 04:45:57 -0700
IronPort-SDR: 2c5/thtWfGsvF/VAAo2KUZsh1d3mpudhrE42tnry+4xfAzgIgzUSc25JQ7BeBaa6gPcu27O6tp
 kRAMhOH3CdHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="333141071"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2020 04:45:54 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1kFFap-00EwG6-Fz; Mon, 07 Sep 2020 14:45:51 +0300
Date:   Mon, 7 Sep 2020 14:45:51 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 03/23] lib: uaccess: provide getline_from_user()
Message-ID: <20200907114551.GV1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-4-brgl@bgdev.pl>
 <20200904163517.GW1891694@smile.fi.intel.com>
 <CAMpxmJWQsgV5WZrdPW3UUOVTEy1L6Y_rb7ThQK1QTRinmHSqWA@mail.gmail.com>
 <CAHp75VdOWdwT-e5ufsZ8MEH=YtdBgm1=TDKn3f8fJxXY4YKh9A@mail.gmail.com>
 <CAMpxmJXmY8oBpPue5v0wBvmjHkFGaUmzHScHoV-1pNEQ59am4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJXmY8oBpPue5v0wBvmjHkFGaUmzHScHoV-1pNEQ59am4w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 12:28:05PM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 7, 2020 at 12:19 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Sep 7, 2020 at 1:05 PM Bartosz Golaszewski
> > <bgolaszewski@baylibre.com> wrote:
> > > On Fri, Sep 4, 2020 at 6:35 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Sep 04, 2020 at 05:45:27PM +0200, Bartosz Golaszewski wrote:
> > > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > > > Doesn't mm/util.c provides us something like this?
> > > > strndup_user()?
> > > >
> > >
> > > Yes, there's both strndup_user() as well as strncpy_from_user(). The
> > > problem is that they rely on the strings being NULL-terminated. This
> > > is not guaranteed for debugfs file_operations write callbacks. We need
> > > some helper that takes the minimum of bytes provided by userspace and
> > > the buffer size and figure out how many bytes to actually copy IMO.
> >
> > Wouldn't this [1] approach work?
> >
> > [1]: https://elixir.bootlin.com/linux/v5.9-rc3/source/arch/x86/kernel/cpu/mtrr/if.c#L93
> >
> 
> Sure, but this is pretty much what I do in getline_from_user(). If
> anything we should port mtrr_write() to using getline_from_user() once
> it's available upstream, no?

But you may provide getline_from_user() as inline in the same header where
strncpy_from_user() is declared. It will be like 3 LOCs?

-- 
With Best Regards,
Andy Shevchenko


