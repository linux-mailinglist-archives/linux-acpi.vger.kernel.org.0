Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AD432EC7F
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 14:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCENuU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 08:50:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:48384 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhCENuT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Mar 2021 08:50:19 -0500
IronPort-SDR: eAJy1ae7Va4R5pOyrLxoI/gEMOseyZkqVFzvMVIG9SqbClxXoeNKrnf1l0TSEpMkx9YJwMILHm
 LTDPKQNJeKmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="207386364"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="207386364"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 05:50:18 -0800
IronPort-SDR: +9PZG4eBpr+263b9cKPCPo/AqftsSUJm98S9toPXMYaVKYu4Yb3ow3n+kygbOjmWuT4KvCyvVf
 /KU4tdWCHiAw==
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="384915896"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 05:50:14 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lIAqH-00A8LA-E8; Fri, 05 Mar 2021 15:50:09 +0200
Date:   Fri, 5 Mar 2021 15:50:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUILD REGRESSION] LAST PATCH: gpiolib: Reuse device's fwnode to
 create IRQ domain
Message-ID: <YEI3EfE8N/isD9Uk@smile.fi.intel.com>
References: <6041a2ff.18V+4AiVF2xWzVE+%lkp@intel.com>
 <YEIkhnfEMINzlZHH@smile.fi.intel.com>
 <CAJZ5v0idCJBQkDfN8GuUt3YqzBjcMZ4EACPogm=+LyihYRhwcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0idCJBQkDfN8GuUt3YqzBjcMZ4EACPogm=+LyihYRhwcA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 05, 2021 at 02:06:54PM +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 5, 2021 at 1:31 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Mar 05, 2021 at 11:18:23AM +0800, kernel test robot wrote:
> > > url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/gpiolib-switch-to-fwnode-in-the-core/20210304-230747
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git e749df1bbd23f4472082210650514548d8a39e9b
> > >
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch]
> > >
> > >
> > > Error/Warning in current branch:
> > >
> > > drivers/gpio/gpiolib.c:3672:24: warning: passing argument 1 of 'is_acpi_node' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> > > drivers/gpio/gpiolib.c:3675:24: warning: passing argument 1 of 'is_acpi_node' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> > > drivers/gpio/gpiolib.c:3686:24: error: passing 'const struct fwnode_handle *' to parameter of type 'struct fwnode_handle *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> > > drivers/gpio/gpiolib.c:3686:24: warning: passing argument 1 of 'is_acpi_node' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> >
> > Yeah, yeah. The fix should be in Rafael's tree.
> >
> > Rafael, can you submit it as material for v5.12-rcX, please?
> 
> What exactly do you want me to submit for 5.12-rc and why is it urgent?

I'm talking about
https://lore.kernel.org/linux-acpi/20210302133721.GG3@paasikivi.fi.intel.com/T/#u

It's not urgent per se, but it rather makes life easier in case that my
GPIO fwnode patch series will be routed thru the different tree (and
I believe GPIO would like to have pull it as an immutable branch / tag).

That said, I'm pretty much fine if the above mentioned fix will be in the same
(immutable) branch for v5.13 cycle.

-- 
With Best Regards,
Andy Shevchenko


