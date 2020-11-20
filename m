Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5687D2BAC4B
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Nov 2020 16:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgKTO7P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Nov 2020 09:59:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:61932 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgKTO7P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Nov 2020 09:59:15 -0500
IronPort-SDR: fWIs9zrADxyGL3dfiOYruVRvMYPUP/Gwxr4M1B03oMs50PvGiZJAgJ2CwlINizb5mL3Lg0UObW
 jPRr8Xp+UFGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171650401"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="171650401"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 06:59:14 -0800
IronPort-SDR: od+0Ob7EYGxTQKhMv8FgGAbv88yE5df3E06bQs7JSvgpn7hzq1t2fnDib5CHO2w+gOdCwPMfph
 gWccGfgoLGjg==
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="477252469"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 06:59:12 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kg7tW-008ImW-K5; Fri, 20 Nov 2020 17:00:14 +0200
Date:   Fri, 20 Nov 2020 17:00:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: ACPI: enumeration: add PCI hierarchy
 representation
Message-ID: <20201120150014.GS4077@smile.fi.intel.com>
References: <20201120111125.78296-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120111125.78296-1-f.suligoi@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 20, 2020 at 12:11:25PM +0100, Flavio Suligoi wrote:
> For "fixed" PCI devices, such as chips directly soldered
> on the main board (ethernet, Wi-Fi, serial ports, etc.),
> it is possible to find an ACPI enumeration.
> 
> This allows to add useful properties to these devices.
> Just for an example: the property "gpio-line-names" can be
> added to the pins of a GPIO expander on the PCI bus.
> 
> In order to find the ACPI name of a PCI device, it's necessary
> to disassemble the BIOS ACPI tables (in particular the DSDT)
> and also to analyze the PCI bus topology of the board.
> 
> This patch, with a practical example, show how to do this.

Good enough, we can amend style and formatting later on.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---

(Here you usually put a changelog what has been done in v2 vs. v1))

>  .../firmware-guide/acpi/enumeration.rst       | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
> 
> diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
> index c13fee8b02ba..9f0d5c854fa4 100644
> --- a/Documentation/firmware-guide/acpi/enumeration.rst
> +++ b/Documentation/firmware-guide/acpi/enumeration.rst
> @@ -461,3 +461,157 @@ Otherwise, the _DSD itself is regarded as invalid and therefore the "compatible"
>  property returned by it is meaningless.
>  
>  Refer to :doc:`DSD-properties-rules` for more information.
> +
> +PCI hierarchy representation
> +============================
> +
> +Sometimes could be useful to enumerate a PCI device, knowing its position on the
> +PCI bus.
> +
> +For example, some systems use PCI devices soldered directly on the mother board,
> +in a fixed position (ethernet, Wi-Fi, serial ports, etc.). In this conditions it
> +is possible to refer to these PCI devices knowing their position on the PCI bus
> +topology.
> +
> +To identify a PCI device, a complete hierarchical description is required, from
> +the chipset root port to the final device, through all the intermediate
> +bridges/switches of the board.
> +
> +For example, let us assume to have a system with a PCIe serial port, an
> +Exar XR17V3521, soldered on the main board. This UART chip also includes
> +16 GPIOs and we want to add the property ``gpio-line-names`` [1] to these pins.
> +In this case, the ``lspci`` output for this component is::
> +
> +	07:00.0 Serial controller: Exar Corp. XR17V3521 Dual PCIe UART (rev 03)
> +
> +The complete ``lspci`` output (manually reduced in length) is::
> +
> +	00:00.0 Host bridge: Intel Corp... Host Bridge (rev 0d)
> +	...
> +	00:13.0 PCI bridge: Intel Corp... PCI Express Port A #1 (rev fd)
> +	00:13.1 PCI bridge: Intel Corp... PCI Express Port A #2 (rev fd)
> +	00:13.2 PCI bridge: Intel Corp... PCI Express Port A #3 (rev fd)
> +	00:14.0 PCI bridge: Intel Corp... PCI Express Port B #1 (rev fd)
> +	00:14.1 PCI bridge: Intel Corp... PCI Express Port B #2 (rev fd)
> +	...
> +	05:00.0 PCI bridge: Pericom Semiconductor Device 2404 (rev 05)
> +	06:01.0 PCI bridge: Pericom Semiconductor Device 2404 (rev 05)
> +	06:02.0 PCI bridge: Pericom Semiconductor Device 2404 (rev 05)
> +	06:03.0 PCI bridge: Pericom Semiconductor Device 2404 (rev 05)
> +	07:00.0 Serial controller: Exar Corp. XR17V3521 Dual PCIe UART (rev 03) <-- Exar
> +	...
> +
> +The bus topology is::
> +
> +	-[0000:00]-+-00.0
> +	           ...
> +	           +-13.0-[01]----00.0
> +	           +-13.1-[02]----00.0
> +	           +-13.2-[03]--
> +	           +-14.0-[04]----00.0
> +	           +-14.1-[05-09]----00.0-[06-09]--+-01.0-[07]----00.0 <-- Exar
> +	           |                               +-02.0-[08]----00.0
> +	           |                               \-03.0-[09]--
> +	           ...
> +	           \-1f.1
> +
> +To describe this Exar device on the PCI bus, we must start from the ACPI name
> +of the chipset bridge (also called "root port") with address::
> +
> +	Bus: 0 - Device: 14 - Function: 1
> +
> +To find this information is necessary disassemble the BIOS ACPI tables, in
> +particular the DSDT (see also [2])::
> +
> +	mkdir ~/tables/
> +	cd ~/tables/
> +	acpidump > acpidump
> +	acpixtract -a acpidump
> +	iasl -e ssdt?.* -d dsdt.dat
> +
> +Now, in the dsdt.dsl, we have to search the device whose address is related to
> +0x14 (device) and 0x01 (function). In this case we can find the following
> +device::
> +
> +	Scope (_SB.PCI0)
> +	{
> +	... other definitions follow ...
> +		Device (RP02)
> +		{
> +			Method (_ADR, 0, NotSerialized)  // _ADR: Address
> +			{
> +				If ((RPA2 != Zero))
> +				{
> +					Return (RPA2) /* \RPA2 */
> +				}
> +				Else
> +				{
> +					Return (0x00140001)
> +				}
> +			}
> +	... other definitions follow ...
> +
> +and the _ADR method [3] returns exactly the device/function couple that
> +we are looking for. With this information and analyzing the above ``lspci``
> +output (both the devices list and the devices tree), we can write the following
> +ACPI description for the Exar PCIe UART, also adding the list of its GPIO line
> +names::
> +
> +	Scope (_SB.PCI0.RP02)
> +	{
> +		Device (BRG1) //Bridge
> +		{
> +			Name (_ADR, 0x0000)
> +
> +			Device (BRG2) //Bridge
> +			{
> +				Name (_ADR, 0x00010000)
> +
> +				Device (EXAR)
> +				{
> +					Name (_ADR, 0x0000)
> +
> +					Name (_DSD, Package ()
> +					{
> +						ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +						Package ()
> +						{
> +							Package ()
> +							{
> +								"gpio-line-names",
> +								Package ()
> +								{
> +									"mode_232",
> +									"mode_422",
> +									"mode_485",
> +									"misc_1",
> +									"misc_2",
> +									"misc_3",
> +									"",
> +									"",
> +									"aux_1",
> +									"aux_2",
> +									"aux_3",
> +								}
> +							}
> +						}
> +					})
> +				}
> +			}
> +		}
> +	}
> +
> +The location "_SB.PCI0.RP02" is obtained by the above investigation in the
> +dsdt.dsl table, whereas the device names "BRG1", "BRG2" and "EXAR" are
> +created analyzing the position of the Exar UART in the PCI bus topology.
> +
> +References
> +==========
> +
> +[1] Documentation/firmware-guide/acpi/gpio-properties.rst
> +
> +[2] Documentation/admin-guide/acpi/initrd_table_override.rst
> +
> +[3] ACPI Specifications, Version 6.3 - Paragraph 6.1.1 _ADR Address)
> +    https://uefi.org/sites/default/files/resources/ACPI_6_3_May16.pdf,
> +    referenced 2020-11-18
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


