Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57CB32B44A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 06:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353111AbhCCE5x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:57:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:2413 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1575654AbhCBPYQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Mar 2021 10:24:16 -0500
IronPort-SDR: tGSC/RbeZnFav9QCKAOs5qn9iNXSPXtO3EI37PFcoyyF4YMPUf7b8Cl1aIwd4JTc58fJ+rXr3c
 erP0UOO0MKog==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="250893647"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="250893647"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:21:25 -0800
IronPort-SDR: SfmgQ+HsK7TbX7TCF729/nx9mUGp32CqL5L/NzQNT0qBl/taPvBd/q3+zKAYoCyKk0dq5eYNr8
 e8cUndjyEBRw==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="399062802"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:21:23 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lH6pp-009PqC-Px; Tue, 02 Mar 2021 17:21:17 +0200
Date:   Tue, 2 Mar 2021 17:21:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/3] gpiolib: acpi: Add
 ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk
Message-ID: <YD5X7XUrx9AQvaXP@smile.fi.intel.com>
References: <20210225163320.71267-1-andriy.shevchenko@linux.intel.com>
 <20210225163320.71267-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdZj4TqOoJmfDhL1MuZCT9quz+5Gj8C6ckZ1i6cYCq9SOA@mail.gmail.com>
 <YD5VJMDC1TmIN/T8@smile.fi.intel.com>
 <20210302151430.GY2542@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302151430.GY2542@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 02, 2021 at 05:14:30PM +0200, Mika Westerberg wrote:
> On Tue, Mar 02, 2021 at 05:09:24PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 02, 2021 at 03:48:43PM +0100, Linus Walleij wrote:
> > > On Thu, Feb 25, 2021 at 5:33 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > 
> > > > On some systems the ACPI tables has wrong pin number and instead of
> > > > having a relative one it provides an absolute one in the global GPIO
> > > > number space.
> > > >
> > > > Add ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk to cope with such cases.
> > > >
> > > > Fixes: ba8c90c61847 ("gpio: pca953x: Override IRQ for one of the expanders on Galileo Gen 2")
> > > > Depends-on: 0ea683931adb ("gpio: dwapb: Convert driver to using the GPIO-lib-based IRQ-chip")
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > OH THE HORROR!
> > > However, we discussed it before. It is as it is.
> > 
> > Unfortunately :-( (And recently it seems MS does something really "creative" on
> > ARM ACPI platform)
> > 
> > > It's the right place to fix the problem, so:
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > I am waiting for Mika, but if he keeps silent let's say to the end of the day,
> > I will submit it as is to the v5.12-rcX fixes.
> 
> Sorry for the delay - I somehow missed this. Feel free to add my ACK too.

Thanks, Mika!


-- 
With Best Regards,
Andy Shevchenko


