Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402843EB644
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Aug 2021 15:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbhHMNvF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Aug 2021 09:51:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:11007 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235656AbhHMNvF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Aug 2021 09:51:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="215289739"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="215289739"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 06:50:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="591139854"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 06:50:35 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mEXZt-00958O-Ki; Fri, 13 Aug 2021 16:50:29 +0300
Date:   Fri, 13 Aug 2021 16:50:29 +0300
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
Message-ID: <YRZ4palCFBFdR/7D@smile.fi.intel.com>
References: <YRUskkALrPLa2cSf@smile.fi.intel.com>
 <CH2PR12MB389540C4C751277287147E95D7F99@CH2PR12MB3895.namprd12.prod.outlook.com>
 <YRVLkMoTvp4+X0Nx@smile.fi.intel.com>
 <CH2PR12MB3895CB35E6EA17908979D631D7F99@CH2PR12MB3895.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB3895CB35E6EA17908979D631D7F99@CH2PR12MB3895.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 12, 2021 at 08:07:49PM +0000, Asmaa Mnebhi wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, August 12, 2021 12:26 PM
> On Thu, Aug 12, 2021 at 03:54:26PM +0000, Asmaa Mnebhi wrote:

> My first question, is it already firmware in the wild that does this?
> I.o.w. is there any time to amend it if needed?

> > Are you asking if it is possible to change the ACPI table's GPIO pin on the
> > fly at boot time in UEFI code?

I'm asking if there is any device with these tables on market?

...


> > We have 1 image common to all our board types. The ACPI tables are selected
> > based on the board id. Some board types have PHY_INT pin connected to GPIO
> > pin 9 and other boards have it connected to GPIO pin 12. So we have 2
> > ssdt.asl files:
> 
> Okay (You may have one and actually choose it based on some [NVS] variable)
> 
> Asmaa> Ok!
> 
> > // first file: PHY_INT -> GPIO pin 12
> > Device(OOB) {
> >         Name(_HID, "MLNXBF17")
> >         Name(_UID, 0)
> >         Name(_CCA, 1)
> >         Name (_CRS, ResourceTemplate () {
> >            // OOB Ethernet
> >            Memory32Fixed (ReadWrite, 0x03000000, 0x00000600)
> >            // mdio[9]
> >            Memory32Fixed (ReadWrite, 0x028004C8, 0x00000008)
> >            // gpio[0]
> >            Memory32Fixed (ReadWrite, 0x0280c000, 0x00000100)
> >            // OOB LLU
> >            Memory32Fixed (ReadWrite, 0x039C0000, 0x0000A100)
> >            // OOB PLU
> >            Memory32Fixed (ReadWrite, 0x04000000, 0x00001100)
> >            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BF_RSH0_DEVICE_OOB_INT }
> >            Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive) { BF_RSH0_DEVICE_OOB_LLU_INT }
> >            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { BF_RSH0_DEVICE_OOB_PLU_INT }
> >            Interrupt (ResourceConsumer, Edge, ActiveHigh, Shared) { BF_RSH0_DEVICE_YU_INT }
> >
> >            // GPIO PHY interrupt
> >            GpioInt (Edge, ActiveHigh, Exclusive, PullUp, , " 
> > \\_SB.GPI0") {12}

Just a side note I forgot in previous reply: The tables themselves look good in
my opinion.

> PullUp with Edge/Rise seems a bit awkward. Recently I have added a
> corresponding paragraph to the
> https://www.kernel.org/doc/html/latest/firmware-guide/acpi/gpio-properties.html.
> But it's just to double check that you got the idea how your hardware works
> (maybe it uses open-drain or so and it's indeed the correct setting).
> 
> > I forgot to cp/paste one more line from the ACPI tables. I have created a
> > DSD entry and named the gpio (although as you pointed below, it is not
> > really needed in this case):

> Name (_DSD, Package () {
>            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
>            Package ()
>            {
>               Package () { "phy-gpios", Package() {^OOB, 0, 0, 0 }},
>            }
>        })

Yes. in this case it's not needed. Only case when it might if you have a bunch
of platforms where a few GpioInt() resources are present and they have no
mapping. This will help to figure out what resource is related to what IRQ
line. Overall it's not bad decision to add one.

> The interrupt that we care about (which signals link up/link down events) is
> actually the shared HW irq BF_RSH0_DEVICE_YU_INT (edge triggered, active high
> whenever there is an i2c, mdio or gpio interrupt).  We get that interrupt
> value from the ACPI table as follows:
> priv->hw_phy_irq = platform_get_irq(pdev, MLXBF_GIGE_PHY_INT_N);

Wait, what you are telling is that the GpioInt() resource is a dup for one of
Interrupt() resource. Is it correct interpretation?

> Although it is overkill, I only used "GpioInt (Edge, ActiveHigh, Exclusive,
> PullUp, \\_SB.GPI0") {12}" to retrieve the GPIO pin number (12 or 9) in
> mlxbf-gige.

Yes, but why do you need to know this pin in software?

> We could also have created a property (phy-gpio-pin) to pass the
> GPIO pin and that would enable us to remove all code related to "GpioInt"
> code in the acpi and mlxbf-gige driver. But I thought that properties are in
> general not the preferred approach?

Properties make sense when there is no standard ACPI approach or it lacks of
some information. As far as I can tell here the properties is better, but I
would like to understand first the need for this information in the first place
(see above comment).

> So whenever that shared interrupt is triggered, this routine is executed mlxbf_gige_gpio_handler:
> ret = devm_request_irq(dev, priv->hw_phy_irq, mlxbf_gige_gpio_handler,
>                                 IRQF_ONESHOT | IRQF_SHARED, "mlxbf_gige_phy", priv);
> It checks whether the interrupt is for GPIO pin 9 or 12 (depending on the board). If it is, it clears the interrupt accordingly and triggers the generic phy_interrupt routine (in phy.c)
> phy_interrupt is registered via phy_connect_direct.

This sounds strange to me. What you are telling is that there is no hw register
from which you may retrieve this information? So it's a workaround of silicon
bug?

> What I have seen here is a regular GpioInt() resource with a single pin.
> 
> Asmaa> Yes we only use one GPIO pin.
> 
> As far as I can see in the code it has the flaw that it actually will use the last GpioInt() resource available in _CRS.
> 
> Besides that, why do you need to know the pin name and can't simply request an IRQ as every other driver does (the exception is only yours in the entire kernel)? The acpi_dev_gpio_irq_get() call can get Linux vIRQ for you same way you have got it for Interrupt() resources via platform_get_irq().

> To understand better this piece, can you point out to the GPIO driver code,
> which implements the driver for _SB.GPI0 in the kernel?

Any comments on this? Do you have a GPIO driver available?

> >         }) // Name(_CRS)

> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Thursday, August 12, 2021 10:14 AM

> > From time to time I do grep kernel for ACPI_RESOURCE_TYPE_GPIO usage.
> > Recently the drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_gpio.c
> > caught my eye.
> > 
> > Looking into the code I see that it looks like misunderstanding of how ACPI
> > works with GPIOs. First of all, I would like to inform that this code has
> > been properly reviewed neither by GPIO nor by ACPI maintainers. Second,
> > before going it to the real conclusions (and potential revert of this), I
> > would like to see the real ACPI tables for this and some explanations from
> > the authors of the driver about GPIO usage here (from hw and sw
> > perspectives).  It makes sense to discuss ASAP, otherwise I would really
> > want to revert it.

-- 
With Best Regards,
Andy Shevchenko


