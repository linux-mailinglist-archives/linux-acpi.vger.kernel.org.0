Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30A23EA884
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Aug 2021 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhHLQ0f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Aug 2021 12:26:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:59475 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhHLQ0e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Aug 2021 12:26:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="194977721"
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="194977721"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 09:26:07 -0700
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="676827425"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 09:25:59 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mEDWi-008hxC-TZ; Thu, 12 Aug 2021 19:25:52 +0300
Date:   Thu, 12 Aug 2021 19:25:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     Linux GPIO <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Thompson <davthompson@nvidia.com>,
        Liming Sun <limings@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: Possible ACPI abuse in Mellanox BlueField Gigabit Ethernet driver
Message-ID: <YRVLkMoTvp4+X0Nx@smile.fi.intel.com>
References: <YRUskkALrPLa2cSf@smile.fi.intel.com>
 <CH2PR12MB389540C4C751277287147E95D7F99@CH2PR12MB3895.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB389540C4C751277287147E95D7F99@CH2PR12MB3895.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 12, 2021 at 03:54:26PM +0000, Asmaa Mnebhi wrote:
> Hi Andy,

Thanks for prompt response!
My first question, is it already firmware in the wild that does this?
I.o.w. is there any time to amend it if needed?

> We have 1 image common to all our board types. The ACPI tables are selected
> based on the board id. Some board types have PHY_INT pin connected to GPIO
> pin 9 and other boards have it connected to GPIO pin 12. So we have 2
> ssdt.asl files:

Okay (You may have one and actually choose it based on some [NVS] variable)

> // first file: PHY_INT -> GPIO pin 12
> Device(OOB) {
>         Name(_HID, "MLNXBF17")
>         Name(_UID, 0)
>         Name(_CCA, 1)
>         Name (_CRS, ResourceTemplate () {
>            // OOB Ethernet
>            Memory32Fixed (ReadWrite, 0x03000000, 0x00000600)
>            // mdio[9]
>            Memory32Fixed (ReadWrite, 0x028004C8, 0x00000008)
>            // gpio[0]
>            Memory32Fixed (ReadWrite, 0x0280c000, 0x00000100)
>            // OOB LLU
>            Memory32Fixed (ReadWrite, 0x039C0000, 0x0000A100)
>            // OOB PLU
>            Memory32Fixed (ReadWrite, 0x04000000, 0x00001100)
>            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BF_RSH0_DEVICE_OOB_INT }
>            Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive) { BF_RSH0_DEVICE_OOB_LLU_INT }
>            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BF_RSH0_DEVICE_OOB_PLU_INT }
>            Interrupt (ResourceConsumer, Edge, ActiveHigh, Shared) { BF_RSH0_DEVICE_YU_INT }
>   
>            // GPIO PHY interrupt
>            GpioInt (Edge, ActiveHigh, Exclusive, PullUp, , " \\_SB.GPI0") {12}

PullUp with Edge/Rise seems a bit awkward. Recently I have added a
corresponding paragraph to the
https://www.kernel.org/doc/html/latest/firmware-guide/acpi/gpio-properties.html.
But it's just to double check that you got the idea how your hardware works
(maybe it uses open-drain or so and it's indeed the correct setting).

What I have seen here is a regular GpioInt() resource with a single pin.

As far as I can see in the code it has the flaw that it actually will use the
last GpioInt() resource available in _CRS.

Besides that, why do you need to know the pin name and can't simply request an
IRQ as every other driver does (the exception is only yours in the entire
kernel)? The acpi_dev_gpio_irq_get() call can get Linux vIRQ for you same way
you have got it for Interrupt() resources via platform_get_irq().

To understand better this piece, can you point out to the GPIO driver code,
which implements the driver for _SB.GPI0 in the kernel?

>         }) // Name(_CRS)
> 
> // Second file: PHY_INT -> GPIO pin 9
> Device(OOB) {
>         Name(_HID, "MLNXBF17")
>         Name(_UID, 0)
>         Name(_CCA, 1)
>         Name (_CRS, ResourceTemplate () {
>            // OOB Ethernet
>            Memory32Fixed (ReadWrite, 0x03000000, 0x00000600)
>            // mdio[9]
>            Memory32Fixed (ReadWrite, 0x028004C8, 0x00000008)
>            // gpio[0]
>            Memory32Fixed (ReadWrite, 0x0280c000, 0x00000100)
>            // OOB LLU
>            Memory32Fixed (ReadWrite, 0x039C0000, 0x0000A100)
>            // OOB PLU
>            Memory32Fixed (ReadWrite, 0x04000000, 0x00001100)
>            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BF_RSH0_DEVICE_OOB_INT }
>            Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive) { BF_RSH0_DEVICE_OOB_LLU_INT }
>            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BF_RSH0_DEVICE_OOB_PLU_INT }
>            Interrupt (ResourceConsumer, Edge, ActiveHigh, Shared) { BF_RSH0_DEVICE_YU_INT }
>   
>            // GPIO PHY interrupt
>            GpioInt (Edge, ActiveHigh, Exclusive, PullUp, , " \\_SB.GPI0") {9}
>         }) // Name(_CRS)
> 
> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com> 
> Sent: Thursday, August 12, 2021 10:14 AM
> To: Linux GPIO <linux-gpio@vger.kernel.org>; linux-acpi@vger.kernel.org; Rafael J. Wysocki <rjw@rjwysocki.net>; Linus Walleij <linus.walleij@linaro.org>; Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: David Thompson <davthompson@nvidia.com>; Asmaa Mnebhi <asmaa@nvidia.com>; Liming Sun <limings@nvidia.com>; David S. Miller <davem@davemloft.net>
> Subject: Possible ACPI abuse in Mellanox BlueField Gigabit Ethernet driver
> 
> Hi!
> 
> From time to time I do grep kernel for ACPI_RESOURCE_TYPE_GPIO usage.
> Recently the drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_gpio.c
> caught my eye.
> 
> Looking into the code I see that it looks like misunderstanding of how ACPI works with GPIOs. First of all, I would like to inform that this code has been properly reviewed neither by GPIO nor by ACPI maintainers. Second, before going it to the real conclusions (and potential revert of this), I would like to see the real ACPI tables for this and some explanations from the authors of the driver about GPIO usage here (from hw and sw perspectives).
> 
> It makes sense to discuss ASAP, otherwise I would really want to revert it.
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
With Best Regards,
Andy Shevchenko


