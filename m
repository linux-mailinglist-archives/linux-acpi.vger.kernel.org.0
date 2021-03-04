Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB0732DB0F
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 21:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbhCDUS3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 15:18:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:17424 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238817AbhCDUSG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Mar 2021 15:18:06 -0500
IronPort-SDR: Y8qO7J2A52c+6vHvGa9J5WoFeizYuTeuqd6iG4utbB4JDiOo8FQCkuuV+0jUXj8J4qbJUf2EbA
 b/w3dCjaQlBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="251538045"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="251538045"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 12:16:20 -0800
IronPort-SDR: SIRn559Qub6ZACqgq0BtAaso2Y0zsypYoI4nEF4bNQCw94fY4JIddvbzf5JyZWiCiIwF0e9ZJV
 pgdUTu9zwubw==
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="384614675"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 12:16:18 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHuON-009y0Q-C6; Thu, 04 Mar 2021 22:16:15 +0200
Date:   Thu, 4 Mar 2021 22:16:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
Message-ID: <YEFAD1tyocd/IErn@smile.fi.intel.com>
References: <20210226033919.8871-1-shawn.guo@linaro.org>
 <YD9bQXBD+9k3Lf/4@smile.fi.intel.com>
 <2ed0d4dc-2756-9a55-3f54-1377732e35fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ed0d4dc-2756-9a55-3f54-1377732e35fc@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 04, 2021 at 08:32:14PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 3/3/21 10:47 AM, Andy Shevchenko wrote:
> > On Fri, Feb 26, 2021 at 11:39:19AM +0800, Shawn Guo wrote:
> >> Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
> >> not working.  That's because the GpioInt number of TSC2 node in ACPI
> >> table is simply wrong, and the number even exceeds the maximum GPIO
> >> lines.  As the touchpad works fine with Windows on the same machine,
> >> presumably this is something Windows-ism.  Although it's obviously
> >> a specification violation, believe of that Microsoft will fix this in
> >> the near future is not really realistic.
> >>
> >> It adds the support of overriding broken GPIO number in ACPI table
> >> on particular machines, which are matched using DMI info.  Such
> >> mechanism for fixing up broken firmware and ACPI table is not uncommon
> >> in kernel.  And hopefully it can be useful for other machines that get
> >> broken GPIO number coded in ACPI table.
> > 
> > 
> > +Cc: Hans.
> > 
> > Hans, would appreciate your opinion on this thread. Maybe I'm mistaken in my
> > conclusions.
> 
> So I've read the entire thread here:
> https://lore.kernel.org/linux-gpio/20210226033919.8871-1-shawn.guo@linaro.org/T/#u
> 
> And I agree wih Andy, this is not something which should be fixed up in the
> generic gpiolib-acpi code.
> 
> Note that we have similar things going on on x86 platforms. There are cases
> there where there are e.g. holes in the GPIO ranges advertised by the Intel
> pinctrl drivers. And in the beginning as i2c (and thus GpioIRQ) HID devices
> started to become more common there were also several rounds of work to make
> sure that the GPIO numbering (per ACPI-device / island) exported to the rest
> of the kernel (and thus to gpiolib-acpi) matched with the numbering which
> the ACPI tables expected (so the numbering which the Windows driver use).
> 
> It seems to me, esp. in the light that there are a lot of "crazy high" GPIO
> indexes in the DSDT of the Lenovo Flex 5G, that the right thing to do here
> is to fix the qualcom pinctrl/GPIO driver to number its GPIOs in the way
> expected by these ACPI tables. This will break use of existing devicetrees,
> so it will likely need to detect if the main firmware of the system is ACPI
> or DT based and then use 2 different numbering schemes depending on the
> outcome of that check.
> 
> Please also do not try ti fix this with some quirks in e.g. the i2c-hid driver,
> I will definitely NACK such attempts. From what we can see now any fix clearly
> should be done inside the qualcom GPIO driver.

Hans, thank you very much!

-- 
With Best Regards,
Andy Shevchenko


