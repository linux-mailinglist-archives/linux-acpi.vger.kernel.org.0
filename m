Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6760C3280F0
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Mar 2021 15:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhCAOc2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Mar 2021 09:32:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:40501 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236379AbhCAOcQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 1 Mar 2021 09:32:16 -0500
IronPort-SDR: QvXHoElGDeee9yA2PaPU8Wi1ahrcSgw/QZ+KT9i63TYLmLJCYJ27Qt1PEcWTSK6k6YeXequ6Ia
 gVzS8b08Vtsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="206090285"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="206090285"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 06:30:26 -0800
IronPort-SDR: NwcDCNj7XqUq2dqA/wMXN8k6qUH7EnB3cPbBpvBsONTNpZiWHAfkW71mvbZ4evOnT2LbMhsizH
 oLnGqg0Ar3GA==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="383074888"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 06:30:23 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lGjYx-0099w2-Dv; Mon, 01 Mar 2021 16:30:19 +0200
Date:   Mon, 1 Mar 2021 16:30:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: acpi: Add missing IRQF_ONESHOT
Message-ID: <YDz6e9POQuhzNgkp@smile.fi.intel.com>
References: <1614069358-50943-1-git-send-email-yang.lee@linux.alibaba.com>
 <YDTsWR/kXhd96ICI@smile.fi.intel.com>
 <YDe8/2toCGEH2Mf1@smile.fi.intel.com>
 <CAMpxmJV5go-fHR2RWWdyi5a6ONeXrhC5c958oNZNzszt2aGN9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJV5go-fHR2RWWdyi5a6ONeXrhC5c958oNZNzszt2aGN9A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 01, 2021 at 02:57:53PM +0100, Bartosz Golaszewski wrote:
> On Thu, Feb 25, 2021 at 4:07 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Feb 23, 2021 at 01:51:53PM +0200, Andy Shevchenko wrote:
> > > On Tue, Feb 23, 2021 at 04:35:58PM +0800, Yang Li wrote:
> > > > fixed the following coccicheck:
> > > > ./drivers/gpio/gpiolib-acpi.c:176:7-27: ERROR: Threaded IRQ with no
> > > > primary handler requested without IRQF_ONESHOT
> > > >
> > > > Make sure threaded IRQs without a primary handler are always request
> > > > with IRQF_ONESHOT
> > >
> > > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Bart, I guess I will collect this in my branch and send you a PR.
> > I have more fixes to that file anyway.
> 
> Fine with me!

Good! So, when you have time, please review [1] and I'll send PR for fixes.

[1]: https://lore.kernel.org/linux-gpio/20210225163320.71267-1-andriy.shevchenko@linux.intel.com/T/#u

-- 
With Best Regards,
Andy Shevchenko


