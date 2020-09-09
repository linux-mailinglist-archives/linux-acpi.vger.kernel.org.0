Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC71262D4E
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Sep 2020 12:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIIKfI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Sep 2020 06:35:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:45989 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbgIIKew (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Sep 2020 06:34:52 -0400
IronPort-SDR: g/o0rrupzx140CJS7pDJtR1/Mh1pjHVrMxzBbBMR4E/jaI6Izbe79+Hi1IxGLiGkEy3uAzHWTw
 fC+KEjiaRp+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="155781444"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="155781444"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 03:34:45 -0700
IronPort-SDR: 0tve1CYzhTsytisDy1TclHePtLyVjyq3/rDx/tErL8bdbcltl3BLKazn/LxTYXfTz+kvvbMY13
 9vpMtXBxBTpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="333775053"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2020 03:34:43 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFxR2-00FPx9-BJ; Wed, 09 Sep 2020 13:34:40 +0300
Date:   Wed, 9 Sep 2020 13:34:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 0/3] gpiolib: generalize GPIO line names property
Message-ID: <20200909103440.GM1891694@smile.fi.intel.com>
References: <20200909085426.19862-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909085426.19862-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 09, 2020 at 10:54:23AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> I initially sent this as part of the gpio-mockup overhaul but since
> these patches are indepentent and the work on gpio-mockup may become
> more complicated - I'm sending these separately.
> 
> The only change is adding additional property helpers to count strings
> in array.

Seems it lost my tag for patch 1/3, but in any case now I'm good with it
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> v1 -> v2:
> - actually remove the previous devprop source file in patch 3
> - rename the string counting functions to something more explicit
> 
> Bartosz Golaszewski (3):
>   device: property: add helpers to count items in string arrays
>   gpiolib: generalize devprop_gpiochip_set_names() for device properties
>   gpiolib: unexport devprop_gpiochip_set_names()
> 
>  drivers/gpio/Makefile          |  1 -
>  drivers/gpio/gpiolib-acpi.c    |  3 --
>  drivers/gpio/gpiolib-devprop.c | 63 ----------------------------------
>  drivers/gpio/gpiolib-of.c      |  5 ---
>  drivers/gpio/gpiolib.c         | 55 ++++++++++++++++++++++++++---
>  include/linux/gpio/driver.h    |  3 --
>  include/linux/property.h       | 13 +++++++
>  7 files changed, 64 insertions(+), 79 deletions(-)
>  delete mode 100644 drivers/gpio/gpiolib-devprop.c
> 
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


