Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D262327E30
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Mar 2021 13:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhCAMUi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Mar 2021 07:20:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:46189 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233890AbhCAMUg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 1 Mar 2021 07:20:36 -0500
IronPort-SDR: epkHSyRXZhKJlByCplHw5bqwXX3ILFfv/Bd1lrHNm6b8HEaZDWbleBa6hZjugifhkbRYfC4Y2M
 2uyYhB2VtELA==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="165676900"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="165676900"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 04:19:55 -0800
IronPort-SDR: DlynpZTyXXtgCJTGDiAn++DmbVlhImCgqjku9baFJlRy5o8/10J7IhePXf4ECwoVtxBaeT2nm/
 JOL7ghrBqBqQ==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="383032657"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 04:19:53 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1lGhWg-0098av-UD; Mon, 01 Mar 2021 14:19:50 +0200
Date:   Mon, 1 Mar 2021 14:19:50 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
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
Message-ID: <YDzb5llywkzbGEF+@smile.fi.intel.com>
References: <20210226033919.8871-1-shawn.guo@linaro.org>
 <CAHp75Vcb=NO9OWjSpBeVC4c+9=aXE=yiDWVBwLD1DnzwdgFD6Q@mail.gmail.com>
 <20210226093925.GA24428@dragon>
 <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
 <20210227034641.GC24428@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210227034641.GC24428@dragon>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Feb 27, 2021 at 11:46:42AM +0800, Shawn Guo wrote:
> On Fri, Feb 26, 2021 at 12:57:37PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 26, 2021 at 11:39 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > >
> > > On Fri, Feb 26, 2021 at 11:12:07AM +0200, Andy Shevchenko wrote:
> > > > On Fri, Feb 26, 2021 at 5:42 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > >
> > > > > Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
> > > > > not working.  That's because the GpioInt number of TSC2 node in ACPI
> > > > > table is simply wrong, and the number even exceeds the maximum GPIO
> > > > > lines.  As the touchpad works fine with Windows on the same machine,
> > > > > presumably this is something Windows-ism.  Although it's obviously
> > > > > a specification violation, believe of that Microsoft will fix this in
> > > > > the near future is not really realistic.
> > > > >
> > > > > It adds the support of overriding broken GPIO number in ACPI table
> > > > > on particular machines, which are matched using DMI info.  Such
> > > > > mechanism for fixing up broken firmware and ACPI table is not uncommon
> > > > > in kernel.  And hopefully it can be useful for other machines that get
> > > > > broken GPIO number coded in ACPI table.
> > > >
> > > > Thanks for the report and patch.
> > > >
> > > > First of all, have you reported the issue to Lenovo? At least they
> > > > will know that they did wrong.
> > >
> > > Yes, we are reporting this to Lenovo, but to be honest, we are not sure
> > > how much they will care about it, as they are shipping the laptop with
> > > Windows only.
> > >
> > > > Second, is it possible to have somewhere output of `acpidump -o
> > > > flex5g.dat` (the flex5g.dat file)?
> > >
> > > https://raw.githubusercontent.com/aarch64-laptops/build/master/misc/lenovo-flex-5g/dsdt.dsl
> > >
> > > > And as Mika said once to one of mine patches "since you know the
> > > > number ahead there is no need to pollute GPIO ACPI library core with
> > > > this quirk". But in any case I would like to see the ACPI tables
> > > > first.
> > >
> > > Oh, so you had something similar already?  Could you point me to the
> > > patch and discussion?
> > 
> > Similar, but might be not the same:
> >  - patches in the upstream [1] (v3 applied), discussion [2]
> >  - new version with some additional fixes [3]
> 
> Thanks for all the pointers.  It looks to me that it's the same problem
> - the GPIO number in ACPI table is broken and needs an override from
> kernel.

Not exactly. On Galileo Gen 2 platform it's broken in understandable way.
In your case it's different and I'm not sure at all that's considered "broken"
in the MS' eyes.

> So I think what we need is a generic solution to a problem
> not uncommon.  Rather than asking all different drivers to resolve the
> same problem all over the kernel, I believe GPIO ACPI library is just
> the right place.
> 
> Looking at your platform and problem, I realise that to be a generic
> solution, my patch needs an additional device identification matching,
> as one GPIO number that is broken for one device could be correct for
> another.  I will improve it, so that your problem can be resolved by
> simply adding a new entry to acpi_gpio_pin_override_table[].

Before any steps further I really want to see more information about that IP
and how firmware applied the numbering scheme.

If it's confidential, you may sent any insights privately.

-- 
With Best Regards,
Andy Shevchenko


