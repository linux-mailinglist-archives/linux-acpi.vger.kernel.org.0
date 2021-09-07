Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E75B402E00
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 19:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhIGRzT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 13:55:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:33561 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233525AbhIGRzS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Sep 2021 13:55:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="207504544"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="207504544"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 10:54:12 -0700
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="449103196"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 10:54:07 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mNfIK-000zB0-0M;
        Tue, 07 Sep 2021 20:54:04 +0300
Date:   Tue, 7 Sep 2021 20:54:04 +0300
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
Message-ID: <YTenPMOOepGo2ZU8@smile.fi.intel.com>
References: <20210812170025.67074-1-andriy.shevchenko@linux.intel.com>
 <20210907154400.26656-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907154400.26656-1-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 07, 2021 at 10:44:00AM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Unfortunately, I can confirm this breaks the DSI panel on the Rockchip
> PX30 (and possibly other SoCs). Tested on my Odroid Go Advance. When
> I revert 4e7cf74fa3b2 "clk: fractional-divider: Export approximation
> algorithm to the CCF users" and 928f9e268611 "clk: fractional-divider:
> Hide clk_fractional_divider_ops from wide audience" the panel begins
> working again as expected on the master branch.
> 
> It looks like an assumption is made in the vop_crtc_mode_fixup()
> function in the rockchip_drm_vop.c that gets broken with this change.
> Specifically, the function says in the comments "When DRM gives us a
> mode, we should add 999 Hz to it.". I believe this is no longer true
> after this clk change, and when I remove the + 999 from the function
> the DSI panel works again. Note that I do not know the implications
> of removing this 999 aside from that it fixes the DSI panel on my
> PX30 after this change, so I don't know if it's a positive change
> or not.
> 
> Thank you.

Thank you for the report!

I'll check this. Perhaps Heiko can help with testing as well on his side.

-- 
With Best Regards,
Andy Shevchenko


