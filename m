Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744B43EB378
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Aug 2021 11:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbhHMJoB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Aug 2021 05:44:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:50121 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239028AbhHMJoB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Aug 2021 05:44:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="202726304"
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="202726304"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 02:43:34 -0700
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="470040425"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 02:43:29 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mETik-0091Jx-R2; Fri, 13 Aug 2021 12:43:22 +0300
Date:   Fri, 13 Aug 2021 12:43:22 +0300
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
Message-ID: <YRY+uoTrBjkdh4Zj@smile.fi.intel.com>
References: <20210812170025.67074-1-andriy.shevchenko@linux.intel.com>
 <162879819529.19113.6409882476721828944@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162879819529.19113.6409882476721828944@swboyd.mtv.corp.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 12, 2021 at 12:56:35PM -0700, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2021-08-12 10:00:22)
> > At least one user currently duplicates some functions that are provided
> > by fractional divider module. Let's export approximation algorithm and
> > replace the open-coded variant.
> > 
> > As a bonus the exported function will get better documentation in place.
> Applied to clk-next

Thank you, Stephen!

-- 
With Best Regards,
Andy Shevchenko


