Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AFE25E06D
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 18:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgIDQ6Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 12:58:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:24022 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgIDQ6X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 12:58:23 -0400
IronPort-SDR: tatuHcS13egl3yMQnSDNoVHfGTO89+Qc1/ov3jcoVv/pj2pfErKyLj+PpZOR+7FeZweptN4IS6
 87jzFKEszLAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="137306594"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="137306594"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 09:58:22 -0700
IronPort-SDR: fvIQqyvpT+8yq4ky+Ofmsp7u5g5tPOzdE5X3ikAlRFUuNGZ4MVaa4Sjn5kvRR59sGSJ9/RIvfD
 tYSes7oXVgVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332221166"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 09:58:19 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEF2W-00EKWv-Rn; Fri, 04 Sep 2020 19:58:16 +0300
Date:   Fri, 4 Sep 2020 19:58:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for
 gpio-mockup
Message-ID: <20200904165816.GF1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-24-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904154547.3836-24-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:47PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> There's some documentation for gpio-mockup's debugfs interface in the
> driver's source but it's not much. Add proper documentation for this
> testing module.

I always for the documentation!

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../admin-guide/gpio/gpio-mockup.rst          | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/admin-guide/gpio/gpio-mockup.rst
> 
> diff --git a/Documentation/admin-guide/gpio/gpio-mockup.rst b/Documentation/admin-guide/gpio/gpio-mockup.rst
> new file mode 100644
> index 000000000000..1d452ee55f8d
> --- /dev/null
> +++ b/Documentation/admin-guide/gpio/gpio-mockup.rst
> @@ -0,0 +1,87 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +GPIO Testing Driver
> +===================
> +
> +The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
> +chips for testing purposes. There are two ways of configuring the chips exposed
> +by the module. The lines can be accessed using the standard GPIO character
> +device interface as well as manipulated using the dedicated debugfs directory
> +structure.
> +
> +Creating simulated chips using debugfs
> +--------------------------------------
> +
> +When the gpio-mockup module is loaded (or builtin) it creates its own directory
> +in debugfs. Assuming debugfs is mounted at /sys/kernel/debug/, the directory
> +will be located at /sys/kernel/debug/gpio-mockup/. Inside this directory there
> +are two attributes: new_device and delete_device.
> +
> +New chips can be created by writing a single line containing a number of
> +options to "new_device". For example:
> +
> +.. code-block:: sh
> +
> +    $ echo "label=my-mockup num_lines=4 named_lines" > /sys/kernel/debug/gpio-mockup/new_device
> +
> +Supported options:
> +
> +    num_lines=<num_lines> - number of GPIO lines to expose
> +
> +    label=<label> - label of the dummy chip
> +
> +    named_lines - defines whether dummy lines should be named, the names are
> +                  of the form X-Y where X is the chip's label and Y is the
> +                  line's offset
> +
> +Note: only num_lines is mandatory.
> +
> +Chips can be dynamically removed by writing the chip's label to
> +"delete_device". For example:
> +
> +.. code-block:: sh
> +
> +    echo "gpio-mockup.0" > /sys/kernel/debug/gpio-mockup/delete_device
> +
> +Creating simulated chips using module params
> +--------------------------------------------
> +
> +Note: this is an older, now deprecated method kept for backward compatibility
> +for user-space tools.
> +
> +When loading the gpio-mockup driver a number of parameters can be passed to the
> +module.
> +
> +    gpio_mockup_ranges
> +
> +        This parameter takes an argument in the form of an array of integer
> +        pairs. Each pair defines the base GPIO number (if any) and the number
> +        of lines exposed by the chip. If the base GPIO is -1, the gpiolib
> +        will assign it automatically.
> +
> +        Example: gpio_mockup_ranges=-1,8,-1,16,405,4
> +
> +        The line above creates three chips. The first one will expose 8 lines,
> +        the second 16 and the third 4. The base GPIO for the third chip is set
> +        to 405 while for two first chips it will be assigned automatically.
> +
> +    gpio_named_lines
> +
> +        This parameter doesn't take any arguments. It lets the driver know that
> +        GPIO lines exposed by it should be named.
> +
> +        The name format is: gpio-mockup-X-Y where X is the letter associated
> +        with the mockup chip and Y is the line offset.
> +
> +Manipulating simulated lines
> +----------------------------
> +
> +Each mockup chip creates its own subdirectory in /sys/kernel/debug/gpio-mockup/.
> +The directory is named after the chip's label. A symlink is also created, named
> +after the chip's name, which points to the label directory.
> +
> +Inside each subdirectory, there's a separate attribute for each GPIO line. The
> +name of the attribute represents the line's offset in the chip.
> +
> +Reading from a line attribute returns the current value. Writing to it (0 or 1)
> +changes its pull.
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


