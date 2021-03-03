Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C08032C434
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382438AbhCDALq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:11:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:21192 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357324AbhCCKtZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Mar 2021 05:49:25 -0500
IronPort-SDR: uPPcHaxKRlcAtN+qt2JEdlzIzU0ym/EMNXERgUkCpTRzp6QjZIDthl7pNRVFUKJrMVJWpG7+/6
 Ut6bWMspZ2zQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174277732"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="174277732"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 01:42:33 -0800
IronPort-SDR: 1a8Zp68hzl1fLUUysrZRL9nl1/vboccfQ8WKiaLQOJvR0N7DyN8WQYBAuup/pbpay3+bkK1qYv
 KS+YnBCrk+gw==
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="445185719"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 01:42:31 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHO1U-009beC-E8; Wed, 03 Mar 2021 11:42:28 +0200
Date:   Wed, 3 Mar 2021 11:42:28 +0200
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
Message-ID: <YD9aBB0a3V4OhTCV@smile.fi.intel.com>
References: <20210226093925.GA24428@dragon>
 <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
 <YDjZOU+VMWasjzUb@smile.fi.intel.com>
 <20210227031944.GB24428@dragon>
 <YDzbQqHspfvpYS7Z@smile.fi.intel.com>
 <20210302002725.GE24428@dragon>
 <YD4twyAGvDDOCv+n@smile.fi.intel.com>
 <abbfcdfa-c287-3828-ed6f-bc1e1f13c6b2@codeaurora.org>
 <YD9DnWC4ht7AYjb/@smile.fi.intel.com>
 <20210303084508.GA17424@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303084508.GA17424@dragon>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 03, 2021 at 04:45:09PM +0800, Shawn Guo wrote:
> On Wed, Mar 03, 2021 at 10:06:53AM +0200, Andy Shevchenko wrote:
> > Since the mapping of those wake IRQs is totally platform specific, it needs a
> > platform driver. On above mentioned x86 platforms we have a one you may take as
> > an example (good or bad it's another story):
> > drivers/platform/x86/intel_int0002_vgpio.c.
> > 
> > I think you will need something like this somewhere in ARM platform
> > infrastructure in the Linux kernel.
> 
> Well, you have the Virtual GPIO controller defined in ACPI as device
> "INT0002", but we do not have such a thing.  I'm not sure it makes much
> sense to create a baseless driver.

It has similarities and differences. In your case you need to have somewhere
some piece of the code that will do proper things, but it shouldn't be GPIO
ACPI layer.

> > That said, I don't see that those numbers are "broken", they have their own
> > meaning and specific mapping to the real GPIOs and it's so platform specific,
> > that we can't treat it as a quirk.
> 
> Those numbers have their own meaning only for Windows.  It's OS specific
> rather than platform specific.

Platform is a combination of hardware, PCB and uC firmwares. AFAIU that
platform was never designed for use in Linux, correct? So, it is not the same
as any other platform on the same SoC.

> Snapdragon platform manual has explicit
> numbering of every single GPIO pin.  Those broken numbers in ACPI table
> violate the hardware specification and are *broken* to Linux which
> implements GPIO driver properly.

No, they are not broken. They have a specific (Windows way) meaning. There is
no quirk implied.

-- 
With Best Regards,
Andy Shevchenko


