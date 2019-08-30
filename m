Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C65A3613
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 13:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfH3LzK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Aug 2019 07:55:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:42612 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbfH3LzK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Aug 2019 07:55:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 04:55:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="181186330"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 30 Aug 2019 04:55:07 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i3fUf-00077m-Jj; Fri, 30 Aug 2019 14:55:05 +0300
Date:   Fri, 30 Aug 2019 14:55:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Cai <peter@typeblog.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 2/2] touchscreen: goodix: define GPIO mapping for GPD P2
 Max
Message-ID: <20190830115505.GX2680@smile.fi.intel.com>
References: <20190830000024.20384-1-peter@typeblog.net>
 <20190830000024.20384-2-peter@typeblog.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830000024.20384-2-peter@typeblog.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 30, 2019 at 08:00:24AM +0800, Peter Cai wrote:
> The firmware of GPD P2 Max could not handle panel resets although code
> is present in DSDT. The kernel needs to take on this job instead, but
> the DSDT does not provide _DSD, rendering kernel helpless when trying to
> find the respective GPIO pins.
> 
> Fortunately, this time GPD has proper DMI vendor / product strings that
> we could match against. We simply apply an acpi_gpio_mapping table when
> GPD P2 Max is matched.
> 
> Additionally, the DSDT definition of the irq pin specifies a wrong
> polarity. The new quirk introduced in the previous patch
> (ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) is applied to correct this.

> +#ifdef CONFIG_ACPI

I guess most of these #ifdef:s makes code less readable for exchange of saving
few bytes in the module footprint.

> +	{ "irq-gpios", &irq_gpios_default, 1,
> +		ACPI_GPIO_QUIRK_OVERRIDE_POLARITY },

One line?

> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P2 MAX")

Comma at the end?

> +		},
> +		.driver_data = &gpio_mapping_force_irq_active_high

Ditto.

-- 
With Best Regards,
Andy Shevchenko


