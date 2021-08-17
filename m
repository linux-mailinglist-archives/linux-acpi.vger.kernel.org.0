Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51833EECAF
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Aug 2021 14:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhHQMp6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Aug 2021 08:45:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:36852 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhHQMp6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Aug 2021 08:45:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="214224082"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="214224082"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 05:45:25 -0700
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="449256501"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 05:45:20 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mFySv-00Ak6X-9i; Tue, 17 Aug 2021 15:45:13 +0300
Date:   Tue, 17 Aug 2021 15:45:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/4] clk: fractional-divider: Export approximation
 algorithm to the CCF users
Message-ID: <YRuvWdI+M7JuKCPC@smile.fi.intel.com>
References: <20210812170025.67074-1-andriy.shevchenko@linux.intel.com>
 <162879819529.19113.6409882476721828944@swboyd.mtv.corp.google.com>
 <YRY+uoTrBjkdh4Zj@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRY+uoTrBjkdh4Zj@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 13, 2021 at 12:43:22PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 12, 2021 at 12:56:35PM -0700, Stephen Boyd wrote:
> > Quoting Andy Shevchenko (2021-08-12 10:00:22)
> > > At least one user currently duplicates some functions that are provided
> > > by fractional divider module. Let's export approximation algorithm and
> > > replace the open-coded variant.
> > > 
> > > As a bonus the exported function will get better documentation in place.
> > Applied to clk-next
> 
> Thank you, Stephen!

When they are expected to be visible in Linux Next?

-- 
With Best Regards,
Andy Shevchenko


