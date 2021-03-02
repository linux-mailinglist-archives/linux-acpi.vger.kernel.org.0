Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BCC32B43F
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 05:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353064AbhCCEyz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:54:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:28234 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350685AbhCBMXb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Mar 2021 07:23:31 -0500
IronPort-SDR: 178IsVga0rbNAJ9jzCHiDL90xCqDStKbo6IBjGTmJpVTyh9ROyQyUXi4tivfpshAZKf2RHbMrP
 7FtHi+Pqy8Eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="184358985"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="184358985"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 04:21:28 -0800
IronPort-SDR: uElB7C+qz7NzFA4Ca9Y93eJ+gdGGpwoEfVqCanWoLOz1VjHoww6HX/HnSnX7neIBs683UrirCR
 LlSvT0VCJo8w==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="506307518"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 04:21:26 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lH41j-009NUH-Hi; Tue, 02 Mar 2021 14:21:23 +0200
Date:   Tue, 2 Mar 2021 14:21:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
Message-ID: <YD4twyAGvDDOCv+n@smile.fi.intel.com>
References: <20210226033919.8871-1-shawn.guo@linaro.org>
 <CAHp75Vcb=NO9OWjSpBeVC4c+9=aXE=yiDWVBwLD1DnzwdgFD6Q@mail.gmail.com>
 <20210226093925.GA24428@dragon>
 <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
 <YDjZOU+VMWasjzUb@smile.fi.intel.com>
 <20210227031944.GB24428@dragon>
 <YDzbQqHspfvpYS7Z@smile.fi.intel.com>
 <20210302002725.GE24428@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302002725.GE24428@dragon>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 02, 2021 at 08:27:26AM +0800, Shawn Guo wrote:
> On Mon, Mar 01, 2021 at 02:17:06PM +0200, Andy Shevchenko wrote:
> > On Sat, Feb 27, 2021 at 11:19:45AM +0800, Shawn Guo wrote:
> > > On Fri, Feb 26, 2021 at 01:19:21PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Feb 26, 2021 at 12:57:37PM +0200, Andy Shevchenko wrote:
> > > > > On Fri, Feb 26, 2021 at 11:39 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > > > On Fri, Feb 26, 2021 at 11:12:07AM +0200, Andy Shevchenko wrote:
> > > > > > > On Fri, Feb 26, 2021 at 5:42 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > > > > > Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
> > > > > > > > not working.  That's because the GpioInt number of TSC2 node in ACPI
> > > > > > > > table is simply wrong, and the number even exceeds the maximum GPIO
> > > > > > > > lines.  As the touchpad works fine with Windows on the same machine,
> > > > > > > > presumably this is something Windows-ism.  Although it's obviously
> > > > > > > > a specification violation, believe of that Microsoft will fix this in
> > > > > > > > the near future is not really realistic.
> > > > > > > >
> > > > > > > > It adds the support of overriding broken GPIO number in ACPI table
> > > > > > > > on particular machines, which are matched using DMI info.  Such
> > > > > > > > mechanism for fixing up broken firmware and ACPI table is not uncommon
> > > > > > > > in kernel.  And hopefully it can be useful for other machines that get
> > > > > > > > broken GPIO number coded in ACPI table.
> > > > > > >
> > > > > > > Thanks for the report and patch.
> > > > > > >
> > > > > > > First of all, have you reported the issue to Lenovo? At least they
> > > > > > > will know that they did wrong.
> > > > > >
> > > > > > Yes, we are reporting this to Lenovo, but to be honest, we are not sure
> > > > > > how much they will care about it, as they are shipping the laptop with
> > > > > > Windows only.
> > > > > >
> > > > > > > Second, is it possible to have somewhere output of `acpidump -o
> > > > > > > flex5g.dat` (the flex5g.dat file)?
> > > > > >
> > > > > > https://raw.githubusercontent.com/aarch64-laptops/build/master/misc/lenovo-flex-5g/dsdt.dsl
> > > > 
> > > > Looking into DSDT I think the problem is much worse. First of all there are
> > > > many cases where pins like 0x140, 0x1c0, etc are being used. On top of that
> > > > there is no GPIO driver in the upstream (as far as I can see by HID, perhaps
> > > > there is a driver but for different HID. And I see that GPIO device consumes a
> > > > lot of Interrupts from GIC as well (it's ARM platfrom as far as I understand).
> > > 
> > > Yes, it's a laptop built on Qualcomm Snapdragon SC8180X SoC.  The GPIO
> > > driver is generic for all Snapdragon SoCs, and has been available in
> > > upstream for many years (for DT though). It can be found as the gpio_chip
> > > implementation in MSM pinctrl driver [1].  The SC8180X specific part can
> > > be found as pinctrl-sc8180x.c [2], and it's already working for DT boot.
> > > The only missing piece is to add "QCOM040D" as the acpi_device_id to
> > > support ACPI boot, and it will be submitted after 5.12-rc1 comes out.
> > > 
> > > > Looking at the Microsoft brain damaged way of understanding GPIOs and hardware
> > > > [1], I am afraid you really want to have a specific GPIO driver for this. So,
> > > > for now until we have better picture of what's going on, NAK to this patch.
> > > 
> > > Thanks for the pointer to Microsoft document.  On Snapdragon, we have
> > > only one GPIO instance that accommodates all GPIO pins, so I'm not sure
> > > that Microsoft GPIOs mapping layer is relevant here at all.
> > > 
> > > Please take a look at the GPIO driver, and feel free to let me know if
> > > you need any further information to understand what's going on.
> > 
> > Yes, I looked into the driver and see that it has 3 blocks of GPIOs (we call
> > them communities, but in the driver the term 'tiles' is used) AFAIU (correct me
> > if I'm wrong). And who knows how many banks in each of them.
> 
> I'm not sure that the 3 'tiles' means 3 blocks of GPIOs.  Maybe, @Bjorn
> can help clarify.  But the ACPI table shows that there is only 'GIO0'
> with 'QCOM040D' HID.

Yeah, I already got that ACPI there is screwed up...

> > I'm afraid that MS does on his way and not yours.
> > 
> > Can we have TRM for GPIO IP used there and any evidence / document from
> > firmware team about the implementation of the GPIO numbering in the ACPI
> > (at Intel we have so called BIOS Writers Guide that is given to the customers
> > where such info can be found)?
> 
> Unfortunately, I do not have the access to any sort of these documents.
> But I looped in Jeffrey who is part of Qualcomm kernel/firmware team,
> and should be able to help clarify GPIO numbering in the ACPI table.

Thanks! Will wait for new information then.

> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/qcom/pinctrl-msm.c#n713
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/qcom/pinctrl-sc8180x.c

-- 
With Best Regards,
Andy Shevchenko


