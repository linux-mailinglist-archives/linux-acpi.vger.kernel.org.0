Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C453ED3B8
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 14:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhHPMMR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 08:12:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:2451 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhHPMMR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Aug 2021 08:12:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="203048050"
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="203048050"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 05:11:45 -0700
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="509678987"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 05:11:43 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mFbSq-00ANtl-R8; Mon, 16 Aug 2021 15:11:36 +0300
Date:   Mon, 16 Aug 2021 15:11:36 +0300
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
Message-ID: <YRpV+OkStsy3p96b@smile.fi.intel.com>
References: <YRUskkALrPLa2cSf@smile.fi.intel.com>
 <CH2PR12MB389540C4C751277287147E95D7F99@CH2PR12MB3895.namprd12.prod.outlook.com>
 <YRVLkMoTvp4+X0Nx@smile.fi.intel.com>
 <CH2PR12MB3895CB35E6EA17908979D631D7F99@CH2PR12MB3895.namprd12.prod.outlook.com>
 <YRZ4palCFBFdR/7D@smile.fi.intel.com>
 <CH2PR12MB38954677254F4243A9067E9ED7FA9@CH2PR12MB3895.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB38954677254F4243A9067E9ED7FA9@CH2PR12MB3895.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 13, 2021 at 02:32:25PM +0000, Asmaa Mnebhi wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com> 
> Sent: Friday, August 13, 2021 9:50 AM
> On Thu, Aug 12, 2021 at 08:07:49PM +0000, Asmaa Mnebhi wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Thursday, August 12, 2021 12:26 PM On Thu, Aug 12, 2021 at 
> > 03:54:26PM +0000, Asmaa Mnebhi wrote:
> 
> > My first question, is it already firmware in the wild that does this?
> > I.o.w. is there any time to amend it if needed?
> 
> > > Are you asking if it is possible to change the ACPI table's GPIO pin 
> > > on the fly at boot time in UEFI code?
> 
> I'm asking if there is any device with these tables on market?
> 
> Yes it is.

Ouch. But luckily there is no crime in the tables per se as I have told before.
Should be fixed in the kernel without any firmware updates / fixes involved.

...

> > The interrupt that we care about (which signals link up/link down 
> > events) is actually the shared HW irq BF_RSH0_DEVICE_YU_INT (edge 
> > triggered, active high whenever there is an i2c, mdio or gpio 
> > interrupt).  We get that interrupt value from the ACPI table as follows:
> > priv->hw_phy_irq = platform_get_irq(pdev, MLXBF_GIGE_PHY_INT_N);
> 
> Wait, what you are telling is that the GpioInt() resource is a dup for one of
> Interrupt() resource. Is it correct interpretation?
> 
> Yes GpioInt is not needed since the ACPI entry (from the above code snippet) defines the shared interrupt as:
>            Interrupt (ResourceConsumer, Edge, ActiveHigh, Shared) { BF_RSH0_DEVICE_YU_INT }

Okay, you need to use GpioInt() properly.
See cover letter: https://lore.kernel.org/linux-acpi/20210816115953.72533-1-andriy.shevchenko@linux.intel.com/T/#u

> > Although it is overkill, I only used "GpioInt (Edge, ActiveHigh, 
> > Exclusive, PullUp, \\_SB.GPI0") {12}" to retrieve the GPIO pin number 
> > (12 or 9) in mlxbf-gige.
> 
> Yes, but why do you need to know this pin in software?
> 
> I need to know this pin in software to be able to access the corresponding GPIO bits in the control registers. Each gpio register (there are more than 30 HW GPIO related registers) is a 32 bit register. Each bit in those registers corresponds to a different GPIO pin.
> For example, in each of the following registers (which are used in mlxbf_gige_gpio.c), we only care about R/W to bit 9 or 12 (depending on the board):
> MLXBF_GIGE_GPIO_CAUSE_OR_CLRCAUSE
> MLXBF_GIGE_GPIO_CAUSE_OR_CAUSE_EVTEN0
> MLXBF_GIGE_GPIO_CAUSE_FALL_EN
> We don't want to modify any other bits since they are bound to other GPIO pins which have specific HW functionalities.
> 
> > We could also have created a property (phy-gpio-pin) to pass the GPIO 
> > pin and that would enable us to remove all code related to "GpioInt"
> > code in the acpi and mlxbf-gige driver. But I thought that properties 
> > are in general not the preferred approach?
> 
> Properties make sense when there is no standard ACPI approach or it lacks of some information. As far as I can tell here the properties is better, but I would like to understand first the need for this information in the first place (see above comment).
> 
> Ok. Please see my reply above.
> 
> > So whenever that shared interrupt is triggered, this routine is executed mlxbf_gige_gpio_handler:
> > ret = devm_request_irq(dev, priv->hw_phy_irq, mlxbf_gige_gpio_handler,
> >                                 IRQF_ONESHOT | IRQF_SHARED, 
> > "mlxbf_gige_phy", priv); It checks whether the interrupt is for GPIO 
> > pin 9 or 12 (depending on the board). If it is, it clears the interrupt accordingly and triggers the generic phy_interrupt routine (in phy.c) phy_interrupt is registered via phy_connect_direct.
> 
> This sounds strange to me. What you are telling is that there is no hw register from which you may retrieve this information? So it's a workaround of silicon bug?
> 
> Yes. There is no register where I can retrieve this information : ( . This is why firmware decides that at boot time based on the board id.
> And that is a good idea, I will share this proposal with the HW team as this will make the code a lot cleaner for future generations.

Consider to handle this in GPIO driver and you won't need the headache in the
consumer drivers. Hardware is fine in this design (as far as I now got it).

> > What I have seen here is a regular GpioInt() resource with a single pin.
> > 
> > Asmaa> Yes we only use one GPIO pin.
> > 
> > As far as I can see in the code it has the flaw that it actually will use the last GpioInt() resource available in _CRS.
> > 
> > Besides that, why do you need to know the pin name and can't simply request an IRQ as every other driver does (the exception is only yours in the entire kernel)? The acpi_dev_gpio_irq_get() call can get Linux vIRQ for you same way you have got it for Interrupt() resources via platform_get_irq().
> 
> > To understand better this piece, can you point out to the GPIO driver
> > code, which implements the driver for _SB.GPI0 in the kernel?
> 
> Any comments on this? Do you have a GPIO driver available?
> 
> Yes please see below:
> The gpio driver is gpio-mlxbf2.c

Thanks! It's helpful!

> Here is the ACPI table for it:
> 
> Device(GPI0) {
>         Name(_HID, "MLNXBF22")
>         Name(_UID, Zero)
>         Name(_CCA, 1)
>         Name(_CRS, ResourceTemplate() {
>           // for gpio[0] yu block
>           Memory32Fixed(ReadWrite, 0x0280c000, 0x00000100)
>         })
>   }
> 
> Device(GPI1) {
>         Name(_HID, "MLNXBF22")
>         Name(_UID, 1)
>         Name(_CCA, 1)
>         Name(_CRS, ResourceTemplate() {
>           // for gpio[1] yu block
>           Memory32Fixed(ReadWrite, 0x0280c100, 0x00000100)
>         })
>       }
>         
> 
> Device(GPI2) {
>         Name(_HID, "MLNXBF22")
>         Name(_UID, 2)
>         Name(_CCA, 1)
>         Name(_CRS, ResourceTemplate() {
>           // for gpio[2] yu block
>           Memory32Fixed(ReadWrite, 0x0280c200, 0x00000100)
>         })
>         Name(_DSD, Package() {
>           ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>           Package() {
>             Package () { "npins", 6 }, // Number of GPIO pins on gpio block 2
>           }
>         })
>       }
> 
> > >         }) // Name(_CRS)
> 
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Thursday, August 12, 2021 10:14 AM
> 
> > > From time to time I do grep kernel for ACPI_RESOURCE_TYPE_GPIO usage.
> > > Recently the 
> > > drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_gpio.c
> > > caught my eye.
> > > 
> > > Looking into the code I see that it looks like misunderstanding of 
> > > how ACPI works with GPIOs. First of all, I would like to inform that 
> > > this code has been properly reviewed neither by GPIO nor by ACPI 
> > > maintainers. Second, before going it to the real conclusions (and 
> > > potential revert of this), I would like to see the real ACPI tables 
> > > for this and some explanations from the authors of the driver about 
> > > GPIO usage here (from hw and sw perspectives).  It makes sense to 
> > > discuss ASAP, otherwise I would really want to revert it.
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
With Best Regards,
Andy Shevchenko


