Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165AD132665
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2020 13:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgAGMix (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jan 2020 07:38:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:28578 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbgAGMix (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Jan 2020 07:38:53 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 04:38:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,406,1571727600"; 
   d="scan'208";a="253741871"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jan 2020 04:38:41 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ioo89-0005zu-PZ; Tue, 07 Jan 2020 14:38:41 +0200
Date:   Tue, 7 Jan 2020 14:38:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: baytrail: Do not clear IRQ flags on direct-irq
 enabled pins
Message-ID: <20200107123841.GE32742@smile.fi.intel.com>
References: <20191227230447.32458-1-hdegoede@redhat.com>
 <CACRpkdaR4vFp=huuqvsnZTFnAmKNJmjpwM8sPpVX2aERp-LogA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaR4vFp=huuqvsnZTFnAmKNJmjpwM8sPpVX2aERp-LogA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 07, 2020 at 11:35:17AM +0100, Linus Walleij wrote:
> On Sat, Dec 28, 2019 at 12:04 AM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> > Suspending Goodix touchscreens requires changing the interrupt pin to
> > output before sending them a power-down command. Followed by wiggling
> > the interrupt pin to wake the device up, after which it is put back
> > in input mode.
> >
> > On Bay Trail devices with a Goodix touchscreen direct-irq mode is used
> > in combination with listing the pin as a normal GpioIo resource.
> >
> > This works fine, until the goodix driver gets rmmod-ed and then insmod-ed
> > again. In this case byt_gpio_disable_free() calls
> > byt_gpio_clear_triggering() which clears the IRQ flags and after that the
> > (direct) IRQ no longer triggers.
> >
> > This commit fixes this by adding a check for the BYT_DIRECT_IRQ_EN flag
> > to byt_gpio_clear_triggering().
> >
> > Note that byt_gpio_clear_triggering() only gets called from
> > byt_gpio_disable_free() for direct-irq enabled pins, as these are excluded
> > from the irq_valid mask by byt_init_irq_valid_mask().
> >
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Patch applied as non-critical fix for v5.6 with Mika's ACK.
> (Tell me if it's critical.)

Can we collect it in our tree (what we are consider a proper for this) and
submit a PR?

-- 
With Best Regards,
Andy Shevchenko


