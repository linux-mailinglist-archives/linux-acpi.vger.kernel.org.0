Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA981E0A2D
	for <lists+linux-acpi@lfdr.de>; Mon, 25 May 2020 11:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbgEYJUc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 May 2020 05:20:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:2961 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388920AbgEYJUc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 May 2020 05:20:32 -0400
IronPort-SDR: D/rgkgv4rNRmu/sCLFoiqOrJGb7P8bN1fDN8krX90szexNok72hywd9EKhjOLm45o56S+0+6EW
 NipxjJTgcfqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 02:20:32 -0700
IronPort-SDR: YTSdOWF0d14uMR86raM1HjE8YO9sMJaCQ4b+irLECD1kjcel5wt8Peq0V6ZS/g1GhEuGA/Z3dL
 IDsncXB0X9KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,432,1583222400"; 
   d="scan'208";a="375388521"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 25 May 2020 02:20:29 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 25 May 2020 12:20:28 +0300
Date:   Mon, 25 May 2020 12:20:28 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 5/5] gpio: pca953x: Override GpioInt() pin for Intel
 Galileo Gen 2
Message-ID: <20200525092028.GQ247495@lahna.fi.intel.com>
References: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
 <20200520211916.25727-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200520211916.25727-5-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 21, 2020 at 12:19:16AM +0300, Andy Shevchenko wrote:
> ACPI table on Intel Galileo Gen 2 has wrong pin number for IRQ resource
> of one of the I²C GPIO expanders. ACPI GPIO library provides a special
> quirk which we may use in this case. With help of it, override GpioInt()
> pin for the affected platform.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 44 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 1fca8dd7824f..2014563309be 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/bitmap.h>
> +#include <linux/dmi.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
> @@ -113,6 +114,39 @@ static const struct acpi_device_id pca953x_acpi_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, pca953x_acpi_ids);
>  
> +#ifdef CONFIG_GPIO_PCA953X_IRQ
> +static const struct acpi_gpio_params pca953x_interrupt_gpios = { 0, 0, true };
> +
> +static const struct acpi_gpio_mapping pca953x_acpi_interrupt_gpios[] = {
> +	{ "interrupt-gpios", &pca953x_interrupt_gpios, 1, ACPI_GPIO_QUIRK_FORCE_PIN, 1 },
> +	{ }
> +};
> +
> +static int pca953x_acpi_interrupt_get_irq(struct device *dev)
> +{
> +	struct gpio_desc *desc;
> +
> +	if (devm_acpi_dev_add_driver_gpios(dev, pca953x_acpi_interrupt_gpios))
> +		dev_warn(dev, "can't add GPIO ACPI mapping\n");
> +
> +	desc = devm_gpiod_get(dev, "interrupt", GPIOD_IN);
> +	if (IS_ERR(desc))
> +		return PTR_ERR(desc);
> +
> +	return gpiod_to_irq(desc);
> +}
> +
> +static const struct dmi_system_id pca953x_dmi_acpi_interrupt_info[] = {
> +	{
> +		.ident = "Intel Galileo Gen 2",
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GalileoGen2"),
> +		},
> +	},
> +	{}

Since you do everything already in this driver, I think we can live
without adding ACPI_GPIO_QUIRK_FORCE_PIN to the core code at all.
