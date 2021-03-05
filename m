Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364A032E5E2
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 11:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCEKNG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 05:13:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:52518 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhCEKMm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Mar 2021 05:12:42 -0500
IronPort-SDR: ZdKzOiMTCvu16SNshCgH+r2+6VV1tZPQyl2JK5c5NNKjrVIBLsBuVflbG8Huhcir3H1vVJrNIb
 /AXj1O4YwGLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="184242538"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="184242538"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 02:12:41 -0800
IronPort-SDR: wFhqOxGqKqmoavtlDlkvVI75iAOh7xndAFPBvn+C1pebG08EIdvwPCyYTHp0zO172HDaYuRHYx
 3pwvyRpVNDOA==
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="436559788"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 02:10:35 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lI7PY-00A5vm-7v; Fri, 05 Mar 2021 12:10:20 +0200
Date:   Fri, 5 Mar 2021 12:10:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
Message-ID: <YEIDjF7B/1gEyuUe@smile.fi.intel.com>
References: <20210226033919.8871-1-shawn.guo@linaro.org>
 <YD9bQXBD+9k3Lf/4@smile.fi.intel.com>
 <2ed0d4dc-2756-9a55-3f54-1377732e35fc@redhat.com>
 <20210305011429.GH17424@dragon>
 <f7aa417e-42b5-0c42-6f59-7311b060384f@redhat.com>
 <YEIDNJXlmBbVtLa3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEIDNJXlmBbVtLa3@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 05, 2021 at 12:08:52PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 05, 2021 at 10:10:50AM +0100, Hans de Goede wrote:
> > On 3/5/21 2:14 AM, Shawn Guo wrote:
> > > On Thu, Mar 04, 2021 at 08:32:14PM +0100, Hans de Goede wrote:
> > >> On 3/3/21 10:47 AM, Andy Shevchenko wrote:
> 
> ...
> 
> > > So we reach a consensus that this is not the right solution for Lenovo
> > > Flex 5G. But what about for Andy's Galileo Gen 2 case, where the GPIO
> > > number in ACPI is truly broken?
> > 
> > Well if the ACPI table truely simply has a wrong number in it, like in
> > this case, then we clearly need a workaround.
> > 
> > >   ba8c90c61847 ("gpio: pca953x: Override IRQ for one of the expanders on Galileo Gen 2")
> > 
> > And we have one in place, so I'm not sure what the question is?
> > 
> > I guess the question is of your generic GPIO renumber patch would not
> > be a better answer to that ?
> > 
> > IMHO no, we want to keep quirks out of the core as much as possible,
> > for example the code which Andy added a quirk to is build as a module
> > in the generic Fedora distro kernel, so for most users the code will
> > not be loaded into memory. Where as if we add it to the core it would
> > use up extra memory for everyone.
> 
> I guess Shawn is referring to my rework of that quirk [1] due to found a flaw
> in the upstreamed variant. I agree, that this is not ideal, but TL;DR: it less
> invasive even to the upstreamed approach and it has no use of any hard coded
> numbering schemes. The Galileo Gen 2 is "broken" in an *understandable* way,
> i.e. ACPI designers put an absolute GPIO numbers (there are two SoC based GPIO
> controllers: SCH and DesignWare which numbers starts at 0) instead of be

"...at 0 and 8 respectively)"

> relative. For the time being only one device has a driver that needs such GPIO
> number, but as I explained in the cover letter, to support it as a quirk I have
> to copy ~10% of the existing (in gpiolib-acpi.c) code.
> 
> I'm all ears for better approach!
> 
> [1]: https://lore.kernel.org/linux-gpio/20210225163320.71267-1-andriy.shevchenko@linux.intel.com/T/#u
> 
> > Also if, in the future, we were to ever add a generic GPIO renumber quirk
> > mechanism to the core, then your code would need more work. Because to be
> > truely generic it would need to remap one gpiochip-name:pin-number on
> > another gpiochip-name:pin-number pair. There might very well be a case
> > with multiple gpiochips with pin number 32 being referenced in the DSDT
> > and where we need to remap one of those 32-s to a different number
> > (or possibly even to a different chip + number).
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
With Best Regards,
Andy Shevchenko


