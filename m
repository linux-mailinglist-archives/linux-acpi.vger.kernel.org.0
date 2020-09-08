Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087D726125F
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Sep 2020 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgIHOJ2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Sep 2020 10:09:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:27022 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbgIHN6d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Sep 2020 09:58:33 -0400
IronPort-SDR: j1rb+VyL4y6f9UVj4mzg5ieTuTtPzROest3KgFNZSFux095SBr6BEXGOIPEg9KFNhGVUbe+Y7D
 P8KPn1uyEqgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="145840389"
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="145840389"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 06:52:12 -0700
IronPort-SDR: GtH7tHAz0ahq8zXLnnABf2GLWZGgYtsMnXaHdd82W1KnqJvzH5xd7xWYoriyVZbzqg4zqFYEF+
 X3UqcHJehHYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="333479206"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 08 Sep 2020 06:52:10 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFe0T-00FDbA-Gr; Tue, 08 Sep 2020 16:49:57 +0300
Date:   Tue, 8 Sep 2020 16:49:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 3/3] gpiolib: unexport devprop_gpiochip_set_names()
Message-ID: <20200908134957.GB1891694@smile.fi.intel.com>
References: <20200908125813.8809-1-brgl@bgdev.pl>
 <20200908125813.8809-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908125813.8809-4-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 08, 2020 at 02:58:13PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Now that devprop_gpiochip_set_names() is only used in a single place
> inside drivers/gpio/gpiolib.c, there's no need anymore for it to be
> exported or to even live in its own source file. Pull this function into
> the core source file for gpiolib.

Did you miss to remove old file?

>  drivers/gpio/Makefile       |  1 -
>  drivers/gpio/gpiolib.c      | 47 +++++++++++++++++++++++++++++++++++++
>  include/linux/gpio/driver.h |  2 --

-- 
With Best Regards,
Andy Shevchenko


