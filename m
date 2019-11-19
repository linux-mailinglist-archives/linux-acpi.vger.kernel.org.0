Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCB51024D0
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 13:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfKSMqM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 07:46:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:13469 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfKSMqM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 07:46:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 04:46:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,324,1569308400"; 
   d="scan'208";a="218241772"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2019 04:46:10 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iX2tV-0004X1-Gm; Tue, 19 Nov 2019 14:46:09 +0200
Date:   Tue, 19 Nov 2019 14:46:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI / button: Add DMI quirk for Acer Switch 10 SW5-032
 lid-switch
Message-ID: <20191119124609.GG32742@smile.fi.intel.com>
References: <20191118153556.28751-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118153556.28751-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 18, 2019 at 04:35:56PM +0100, Hans de Goede wrote:
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

Fair enough, thanks for the quirk.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


