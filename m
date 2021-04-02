Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6ED352F00
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Apr 2021 20:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhDBSOZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Apr 2021 14:14:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:33925 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBSOZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Apr 2021 14:14:25 -0400
IronPort-SDR: TbJvnhgZzzeYEbEiWIEf3nPXu0R7tM142vYDjsI5dv+VHs9+kPEyhFifTP14HcgV0mey/u5jgA
 f79QgceihGcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="192618411"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="192618411"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 11:14:23 -0700
IronPort-SDR: yfwH1boSOqBYCjorz72RchoXUMXON4isp4KzLaL4bqd9USlaRmo0xQ426ixwrqATKZrBbAFcmv
 TczkoPZPXYqg==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="456511596"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 11:14:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lSOJH-000cJd-Aj; Fri, 02 Apr 2021 21:14:19 +0300
Date:   Fri, 2 Apr 2021 21:14:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add quirk to ignore EC wakeups on Dell
 Venue 10 Pro 5055
Message-ID: <YGde+w35hC7bM7Hr@smile.fi.intel.com>
References: <20210401162740.4602-1-hdegoede@redhat.com>
 <YGYKbXDu1QlYCXew@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGYKbXDu1QlYCXew@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 01, 2021 at 09:01:17PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 01, 2021 at 06:27:40PM +0200, Hans de Goede wrote:
> > Like some other Bay and Cherry Trail SoC based devices the Dell Venue
> > 10 Pro 5055 has an embedded-controller which uses ACPI GPIO events to
> > report events instead of using the standard ACPI EC interface for this.
> > 
> > The EC interrupt is only used to report battery-level changes and
> > it keeps doing this while the system is suspended, causing the system
> > to not stay suspended.
> > 
> > Add an ignore-wake quirk for the GPIO pin used by the EC to fix the
> > spurious wakeups from suspend.
> 
> Fine by me,
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I have sent my PR to Bart few days ago and today he applied it.
> So, since I'm not expecting much going on in this cycle, I assume
> it's okay to go directly to Bart's tree.

Bart, nevermind, I'll take it thru my tree. It seems we have two and perhaps
even three patches, so it will be easier to handle together.

-- 
With Best Regards,
Andy Shevchenko


