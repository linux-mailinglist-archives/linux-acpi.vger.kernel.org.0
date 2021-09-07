Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765D7402E21
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 20:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345555AbhIGSH0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 14:07:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:21842 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233525AbhIGSHZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Sep 2021 14:07:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="219966950"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="219966950"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 11:06:19 -0700
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="478802532"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 11:06:13 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mNfU2-000zMm-0g;
        Tue, 07 Sep 2021 21:06:10 +0300
Date:   Tue, 7 Sep 2021 21:06:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     abel.vesa@nxp.com, festevam@gmail.com, heiko@sntech.de,
        kernel@pengutronix.de, lee.jones@linaro.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        mturquette@baylibre.com, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net, s.hauer@pengutronix.de, sboyd@kernel.org,
        shawnguo@kernel.org, zhangqing@rock-chips.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v4 1/4] clk: fractional-divider: Export approximation
 algorithm to the CCF users
Message-ID: <YTeqEilet1p4vTAU@smile.fi.intel.com>
References: <20210812170025.67074-1-andriy.shevchenko@linux.intel.com>
 <20210907154400.26656-1-macroalpha82@gmail.com>
 <YTenPMOOepGo2ZU8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTenPMOOepGo2ZU8@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 07, 2021 at 08:54:04PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 07, 2021 at 10:44:00AM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Unfortunately, I can confirm this breaks the DSI panel on the Rockchip
> > PX30 (and possibly other SoCs). Tested on my Odroid Go Advance. When
> > I revert 4e7cf74fa3b2 "clk: fractional-divider: Export approximation
> > algorithm to the CCF users" and 928f9e268611 "clk: fractional-divider:
> > Hide clk_fractional_divider_ops from wide audience" the panel begins
> > working again as expected on the master branch.
> > 
> > It looks like an assumption is made in the vop_crtc_mode_fixup()
> > function in the rockchip_drm_vop.c that gets broken with this change.
> > Specifically, the function says in the comments "When DRM gives us a
> > mode, we should add 999 Hz to it.". I believe this is no longer true
> > after this clk change, and when I remove the + 999 from the function
> > the DSI panel works again. Note that I do not know the implications
> > of removing this 999 aside from that it fixes the DSI panel on my
> > PX30 after this change, so I don't know if it's a positive change
> > or not.
> > 
> > Thank you.
> 
> Thank you for the report!
> 
> I'll check this. Perhaps Heiko can help with testing as well on his side.

On the first glance the mentioned patch may not be the culprit because it does
not change the functional behaviour (if I'm not mistaken). What really changes
it is the additional flag that removes the left-shift of the rate in the
calculations.

To me sounds like you found a proper solution to the issue and that +999 is
a hack against the (blindly?) copied part of the algorithm used in fractional
divider. Have you read the top comment in clk-fractional-divider.c? It should
explain how it works after my series.

In any case I'm not going to come to any conclusions right now and also want
to hear from people who have better understanding of this hardware.

-- 
With Best Regards,
Andy Shevchenko


