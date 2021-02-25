Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435913251FA
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Feb 2021 16:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhBYPIr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 10:08:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:30880 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhBYPIe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Feb 2021 10:08:34 -0500
IronPort-SDR: hsQFVcoLI27OjOjt8uaYYa/llSKirjCGWhv+I9x5T4dhj5Pz2589dSHu9LWnE2Tp5fwMMd2yV+
 XB1qexRQJfFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="185679076"
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="185679076"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 07:06:43 -0800
IronPort-SDR: SOv2HaqhEGEtFQUkLc6tuMoLrqzmYVpZ3NtE8G1HueEITGgabUIAGpVCSZK2KzWrblm5ROpM6F
 mI30XGEDO10A==
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="442611084"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 07:06:41 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lFIDv-0082r4-8f; Thu, 25 Feb 2021 17:06:39 +0200
Date:   Thu, 25 Feb 2021 17:06:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add missing IRQF_ONESHOT
Message-ID: <YDe8/2toCGEH2Mf1@smile.fi.intel.com>
References: <1614069358-50943-1-git-send-email-yang.lee@linux.alibaba.com>
 <YDTsWR/kXhd96ICI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDTsWR/kXhd96ICI@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 23, 2021 at 01:51:53PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 23, 2021 at 04:35:58PM +0800, Yang Li wrote:
> > fixed the following coccicheck:
> > ./drivers/gpio/gpiolib-acpi.c:176:7-27: ERROR: Threaded IRQ with no
> > primary handler requested without IRQF_ONESHOT
> > 
> > Make sure threaded IRQs without a primary handler are always request
> > with IRQF_ONESHOT
> 
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Bart, I guess I will collect this in my branch and send you a PR.
I have more fixes to that file anyway.

-- 
With Best Regards,
Andy Shevchenko


