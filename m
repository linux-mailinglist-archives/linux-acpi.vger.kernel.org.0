Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10EC1E0A9E
	for <lists+linux-acpi@lfdr.de>; Mon, 25 May 2020 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389462AbgEYJbu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 May 2020 05:31:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:19513 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389559AbgEYJbu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 May 2020 05:31:50 -0400
IronPort-SDR: 8LPwpuaxc/0J+80ZYrH6SXDFyuQDLHByWdzl8Vgr+mMxuDyXt61CDJTf/99sMxhgBihltKrkZS
 u6hsQCthsoRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 02:31:49 -0700
IronPort-SDR: ipb4IScDpQ0DTPhaDKSIbG7junOmSVQfwhdJPFlT8/PAzLRJOD/3lKip7OZoCvYY94rj4rM5qN
 D6c6SY43VUzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="256184182"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 25 May 2020 02:31:47 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jd9SY-008l7m-Hs; Mon, 25 May 2020 12:31:50 +0300
Date:   Mon, 25 May 2020 12:31:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 5/5] gpio: pca953x: Override GpioInt() pin for Intel
 Galileo Gen 2
Message-ID: <20200525093150.GL1634618@smile.fi.intel.com>
References: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
 <20200520211916.25727-5-andriy.shevchenko@linux.intel.com>
 <20200525092028.GQ247495@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200525092028.GQ247495@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 25, 2020 at 12:20:28PM +0300, Mika Westerberg wrote:
> On Thu, May 21, 2020 at 12:19:16AM +0300, Andy Shevchenko wrote:
> > ACPI table on Intel Galileo Gen 2 has wrong pin number for IRQ resource
> > of one of the I²C GPIO expanders. ACPI GPIO library provides a special
> > quirk which we may use in this case. With help of it, override GpioInt()
> > pin for the affected platform.

...

> > +static const struct acpi_gpio_params pca953x_interrupt_gpios = { 0, 0, true };
> > +
> > +static const struct acpi_gpio_mapping pca953x_acpi_interrupt_gpios[] = {
> > +	{ "interrupt-gpios", &pca953x_interrupt_gpios, 1, ACPI_GPIO_QUIRK_FORCE_PIN, 1 },
> > +	{ }
> > +};
> > +
> > +static int pca953x_acpi_interrupt_get_irq(struct device *dev)
> > +{
> > +	struct gpio_desc *desc;
> > +
> > +	if (devm_acpi_dev_add_driver_gpios(dev, pca953x_acpi_interrupt_gpios))
> > +		dev_warn(dev, "can't add GPIO ACPI mapping\n");
> > +
> > +	desc = devm_gpiod_get(dev, "interrupt", GPIOD_IN);
> > +	if (IS_ERR(desc))
> > +		return PTR_ERR(desc);
> > +
> > +	return gpiod_to_irq(desc);
> > +}
> > +
> > +static const struct dmi_system_id pca953x_dmi_acpi_interrupt_info[] = {
> > +	{
> > +		.ident = "Intel Galileo Gen 2",
> > +		.matches = {
> > +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GalileoGen2"),
> > +		},
> > +	},
> > +	{}
> 
> Since you do everything already in this driver, I think we can live
> without adding ACPI_GPIO_QUIRK_FORCE_PIN to the core code at all.

Hmm... I don't see how (perhaps need morning coffee). Any pointers?

-- 
With Best Regards,
Andy Shevchenko


