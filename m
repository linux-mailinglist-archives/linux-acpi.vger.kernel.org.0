Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8A23261E9
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Feb 2021 12:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBZLVL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Feb 2021 06:21:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:57150 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhBZLVL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Feb 2021 06:21:11 -0500
IronPort-SDR: eq8TQKIHt8BaYcgGkLSSSDYAejYzp2FfrDylH7nJgoTQk8Uv9Xx+MiV3lAQVrat4seHkHGcqMM
 OyJEUo+YHA7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="270825411"
X-IronPort-AV: E=Sophos;i="5.81,208,1610438400"; 
   d="scan'208";a="270825411"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 03:19:25 -0800
IronPort-SDR: C+sOiyLfHDwfPB2K10E4qIB6ygfMiKj2tLfOb8p/mMp3BdxlHBJZ2rBjt0k+jaauTTPCX0QM1F
 7a8GA2qvSeGw==
X-IronPort-AV: E=Sophos;i="5.81,208,1610438400"; 
   d="scan'208";a="393552309"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 03:19:23 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lFb9V-008KI9-1K; Fri, 26 Feb 2021 13:19:21 +0200
Date:   Fri, 26 Feb 2021 13:19:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
Message-ID: <YDjZOU+VMWasjzUb@smile.fi.intel.com>
References: <20210226033919.8871-1-shawn.guo@linaro.org>
 <CAHp75Vcb=NO9OWjSpBeVC4c+9=aXE=yiDWVBwLD1DnzwdgFD6Q@mail.gmail.com>
 <20210226093925.GA24428@dragon>
 <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 26, 2021 at 12:57:37PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 26, 2021 at 11:39 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Fri, Feb 26, 2021 at 11:12:07AM +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 26, 2021 at 5:42 AM Shawn Guo <shawn.guo@linaro.org> wrote:
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

Looking into DSDT I think the problem is much worse. First of all there are
many cases where pins like 0x140, 0x1c0, etc are being used. On top of that
there is no GPIO driver in the upstream (as far as I can see by HID, perhaps
there is a driver but for different HID. And I see that GPIO device consumes a
lot of Interrupts from GIC as well (it's ARM platfrom as far as I understand).

Looking at the Microsoft brain damaged way of understanding GPIOs and hardware
[1], I am afraid you really want to have a specific GPIO driver for this. So,
for now until we have better picture of what's going on, NAK to this patch.

[1]: https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/general-purpose-i-o--gpio-

  "...All banks have the same number of pins, except for the last bank, which
   might have fewer."

They added completely unnecessary mapping layer and brought a lot of confusion
to everybody (developers, users, etc).

-- 
With Best Regards,
Andy Shevchenko


