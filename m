Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339B625E15E
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 20:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgIDSJx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 14:09:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:31564 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgIDSJx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 14:09:53 -0400
IronPort-SDR: +qbM+VYBvH/vpIXE5Qnd1Vr7fmJrqo6xmZsDz3UZo9kINwEy0EvXs70uKk5VYbJGNOqxsDnBu/
 255HLhEf2Isg==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="155304044"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="155304044"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 11:09:52 -0700
IronPort-SDR: 0yCa45sL1KoSTvaCm7vrPxSfIYgl8J0gmhDJyeV0vLWzrePidLlJTCkDaYJxWYBgjdhbDY+xHz
 PIkrWoWSq37A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332248303"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 11:09:50 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEG9j-00ELFb-Ju; Fri, 04 Sep 2020 21:09:47 +0300
Date:   Fri, 4 Sep 2020 21:09:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pinctrl: cherryview: Preserve
 CHV_PADCTRL1_INVRXTX_TXDATA flag on GPIOs
Message-ID: <20200904180947.GL1891694@smile.fi.intel.com>
References: <20200904172141.180363-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904172141.180363-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 07:21:41PM +0200, Hans de Goede wrote:
> One some devices the GPIO should output the inverted value from what

> Fixes: a7d4b171660c ("Input: goodix - add support for getting IRQ + reset GPIOs on Cherry Trail devices")

Hans, a side note. Can you clean up that driver using ACPI GPIO quirks and the
idea that IRQ line will be retrieved in client->irq?

I recently submit a patch against BT Intel driver [1] where similar approach is
utilized.

[1]: https://lore.kernel.org/linux-bluetooth/20200903184850.53055-1-andriy.shevchenko@linux.intel.com/T/

-- 
With Best Regards,
Andy Shevchenko


