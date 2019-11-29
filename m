Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE3410D4A4
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2019 12:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfK2LUy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Nov 2019 06:20:54 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54162 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2LUy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Nov 2019 06:20:54 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id b78dcf457e8b1ccf; Fri, 29 Nov 2019 12:20:51 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI / button: Add DMI quirk for Acer Switch 10 SW5-032 lid-switch
Date:   Fri, 29 Nov 2019 12:20:50 +0100
Message-ID: <3611977.LLUoXj5ros@kreacher>
In-Reply-To: <20191118153556.28751-1-hdegoede@redhat.com>
References: <20191118153556.28751-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, November 18, 2019 4:35:56 PM CET Hans de Goede wrote:
> The Acer Switch 10 SW5-032 _LID method is quite broken, it looks like this:
> 
>             Method (_LID, 0, NotSerialized)  // _LID: Lid Status
>             {
>                 If ((STAS & One))
>                 {
>                     Local0 = One
>                     PBCG |= 0x05000000
>                     HMCG |= 0x05000000
>                 }
>                 Else
>                 {
>                     Local0 = Zero
>                     PBCG &= 0xF0FFFFFF
>                     HMCG &= 0xF0FFFFFF
>                 }
> 
>                 ^^PCI0.GFX0.CLID = Local0
>                 Return (Local0)
>             }
> 
> The problem here is the accesses to the PBCG and HMCG, these are the
> pinconf0 registers for the power, resp. the home button GPIO,
> e.g. PBCG is declared as:
> 
>             OperationRegion (PWBT, SystemMemory, 0xFED0E080, 0x10)
>             Field (PWBT, DWordAcc, NoLock, Preserve)
>             {
>                 PBCG,   32,
>                 PBV1,   32,
>                 PBSA,   32,
>                 PBV2,   32
>             }
> 
> Where 0xFED0E000 is the base address of the GPO2 device and 0x80 is
> the offset for the pin used for the powerbutton.
> 
> The problem here is this line in _LID:
>                     PBCG |= 0x05000000
> 
> This changes the trigger flags of the GPIO, changing when it generates
> interrupts. Note it does not clear the original flags. Linux uses an
> edge triggered interrupt on both positive and negative edges. This |=
> adds the BYT_TRIG_LVL flag to this, so now it is turned into a level
> interrupt which fires both when low and high, iow it simply always
> fires leading to an interrupt storm, the tablet immediately waking up
> from suspend again, etc.
> 
> There is nothing we can do to fix this, except for a DSDT override,
> which the user needs to do manually. The only thing we can do is
> never call _LID, which requires disabling the lid-switch functionality
> altogether.
> 
> This commit adds a quirk for this, as no lid-switch function is better
> then the interrupt storm. A user manually applying a DSDT override can
> also override the quirk on the kernel cmdline.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/button.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index d27b01c0323d..b758b45737f5 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -77,6 +77,19 @@ MODULE_DEVICE_TABLE(acpi, button_device_ids);
>  
>  /* Please keep this list sorted alphabetically by vendor and model */
>  static const struct dmi_system_id dmi_lid_quirks[] = {
> +	{
> +		/*
> +		 * Acer Switch 10 SW5-012. _LID method messes with home and
> +		 * power button GPIO IRQ settings causing an interrupt storm on
> +		 * both GPIOs. This is unfixable without a DSDT override, so we
> +		 * have to disable the lid-switch functionality altogether :|
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
> +		},
> +		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
> +	},
>  	{
>  		/*
>  		 * Asus T200TA, _LID keeps reporting closed after every second
> 

Applying as 5.5 material, thanks!



