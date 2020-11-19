Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1876E2B90AD
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 12:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKSLI0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Nov 2020 06:08:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:20059 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgKSLI0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Nov 2020 06:08:26 -0500
IronPort-SDR: 1/mJzocLENP1MLNcR92aNVyEj3ORzm49DRHoHh+4J8BP805HoOQluWpPe8mlsolBTu/TymurhZ
 1mpO0WtbHTTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="167760903"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="167760903"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 03:08:20 -0800
IronPort-SDR: q9Fn4HBFJ/jBqF8Kq1AJiSUB/wKNNR+jphULGCkodly7lT0ywyOUyjZ9HXstVaKoWdk/KeD2o9
 m/0ZMKobPdlQ==
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="359934471"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 03:08:19 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kfhoX-007ulQ-Bi; Thu, 19 Nov 2020 13:09:21 +0200
Date:   Thu, 19 Nov 2020 13:09:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: ACPI: enumeration: add PCI hierarchy
 representation
Message-ID: <20201119110921.GB4077@smile.fi.intel.com>
References: <20201119101233.701918-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119101233.701918-1-f.suligoi@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 19, 2020 at 11:12:33AM +0100, Flavio Suligoi wrote:

Thank you very much for nice piece of documentation!
My comments below.

> For "fixed" PCI devices, such as chips directly soldered
> on the main board (ethernet, wi-fi, serial ports, etc.),

Wi-Fi

> it is possible to find an ACPI enumeration.
> 
> This allows to add useful properties to these devices.
> Just for an example: the property "gpio-line-names" can be
> added to the pins of a GPIO expander on the PCI bus.
> 
> In order to find the ACPI name of a PCI device , it's necessary

No space before comma.

> to disassemble the BIOS ACPI tables (in particular the DSDT)
> and also to analyze the PCI bus topology of the board.
> 
> This patch, with a practical example, show how to do this.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  .../firmware-guide/acpi/enumeration.rst       | 180 ++++++++++++++++++
>  1 file changed, 180 insertions(+)
> 
> diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
> index c13fee8b02ba..b08431a93cf5 100644
> --- a/Documentation/firmware-guide/acpi/enumeration.rst
> +++ b/Documentation/firmware-guide/acpi/enumeration.rst
> @@ -461,3 +461,183 @@ Otherwise, the _DSD itself is regarded as invalid and therefore the "compatible"
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
> +in a fixed position (ethernet, wi-fi, serial ports, etc.). In this conditions it

Wi-Fi

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
> +	root@debian:~# lspci
> +	00:00.0 Host bridge: Intel Corp... Host Bridge (rev 0d)
> +	00:02.0 VGA compatible controller: Intel Corporation Device 5a85 (rev 0d)
> +	00:0e.0 Audio device: Intel Corp... Audio Cluster (rev 0d)
> +	00:0f.0 Communication controller: Intel Corp... Trusted Execution Engine (rev 0d)
> +	00:12.0 SATA controller: Intel Corp... SATA AHCI Controller (rev 0d)
> +	00:13.0 PCI bridge: Intel Corp... PCI Express Port A #1 (rev fd)
> +	00:13.1 PCI bridge: Intel Corp... PCI Express Port A #2 (rev fd)
> +	00:13.2 PCI bridge: Intel Corp... PCI Express Port A #3 (rev fd)
> +	00:14.0 PCI bridge: Intel Corp... PCI Express Port B #1 (rev fd)
> +	00:14.1 PCI bridge: Intel Corp... PCI Express Port B #2 (rev fd)
> +	00:15.0 USB controller: Intel Corp... USB xHCI (rev 0d)
> +	00:16.0 Signal processing controller: Intel Corp... I2C Controller #1 (rev 0d)
> +	00:16.1 Signal processing controller: Intel Corp... I2C Controller #2 (rev 0d)
> +	00:19.0 Signal processing controller: Intel Corp... SPI Controller #1 (rev 0d)
> +	00:19.1 Signal processing controller: Intel Corp... SPI Controller #2 (rev 0d)
> +	00:19.2 Signal processing controller: Intel Corp... SPI Controller #3 (rev 0d)
> +	00:1f.0 ISA bridge: Intel Corp... Low Pin Count Interface (rev 0d)
> +	00:1f.1 SMBus: Intel Corp... SMBus Controller (rev 0d)
> +	01:00.0 Ethernet controller: Intel Corp... I210 Gigabit Network Connection (rev 03)
> +	02:00.0 Ethernet controller: Intel Corp... I210 Gigabit Network Connection (rev 03)
> +	04:00.0 Ethernet controller: Intel Corp... I210 Gigabit Network Connection (rev 03)
> +	05:00.0 PCI bridge: Pericom Semiconductor Device 2404 (rev 05)
> +	06:01.0 PCI bridge: Pericom Semiconductor Device 2404 (rev 05)
> +	06:02.0 PCI bridge: Pericom Semiconductor Device 2404 (rev 05)
> +	06:03.0 PCI bridge: Pericom Semiconductor Device 2404 (rev 05)
> +	07:00.0 Serial controller: Exar Corp. XR17V3521 Dual PCIe UART (rev 03) <-- Exar
> +	08:00.0 Ethernet controller: Intel Corp... I210 Gigabit Network Connection (rev 03)
> +	root@debian:~#

At least here, I would rather drop unrelated lines (except bridges, serial controller).

Like:

	00:00.0 Host bridge: Intel Corp... Host Bridge (rev 0d)
	...
	00:14.0 PCI bridge: Intel Corp... PCI Express Port B #1 (rev fd)
	00:14.1 PCI bridge: Intel Corp... PCI Express Port B #2 (rev fd)
	...
	05:00.0 PCI bridge: Pericom Semiconductor Device 2404 (rev 05)
	06:01.0 PCI bridge: Pericom Semiconductor Device 2404 (rev 05)
	06:02.0 PCI bridge: Pericom Semiconductor Device 2404 (rev 05)
	06:03.0 PCI bridge: Pericom Semiconductor Device 2404 (rev 05)
	07:00.0 Serial controller: Exar Corp. XR17V3521 Dual PCIe UART (rev 03) <-- Exar
	...

> +The bus topology is::
> +
> +	root@debian:~# lspci -t
> +	-[0000:00]-+-00.0
> +	           +-02.0
> +	           +-0e.0
> +	           +-0f.0
> +	           +-12.0
> +	           +-13.0-[01]----00.0
> +	           +-13.1-[02]----00.0
> +	           +-13.2-[03]--
> +	           +-14.0-[04]----00.0
> +	           +-14.1-[05-09]----00.0-[06-09]--+-01.0-[07]----00.0 <-- Exar
> +	           |                               +-02.0-[08]----00.0
> +	           |                               \-03.0-[09]--
> +	           +-15.0
> +	           +-16.0
> +	           +-16.1
> +	           +-19.0
> +	           +-19.1
> +	           +-19.2
> +	           +-1f.0
> +	           \-1f.1

And possible here cut unneeded branches.

> +	root@debian:~#

This is not needed.

> +To describe this Exar device on the PCI bus, we must start from the ACPI name
> +of the chipset bridge (also called "root port") with address::
> +
> +	Bus: 0 - Device: 14 - Function: 1
> +
> +To find this information is necessary disassemble the BIOS ACPI tables, in
> +particular the DSDT (see also [2])::

> +	cd /sys/firmware/acpi
> +	cp -a tables/ ~
> +	cd ~/tables/

acpidump followed by acpixtract from ACPI tools is better to advertise.

> +	find . -type f -exec mv {} {}.aml \;

Unnecessary step. But I think you wanted to have it to distinguish sources and
binaries in the text below.

> +	iasl -e SSDT?.* -d DSDT.aml
> +
> +Now, in the DSDT.dsl, we have to search the device whose address is related to
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
> +DSDT.dsl table, whereas the device names "BRG1", "BRG2" and "EXAR" are
> +created analyzing the position of the Exar UART in the PCI bus topology.
> +
> +References
> +==========
> +
> +[1] Documentation/firmware-guide/acpi/gpio-properties.rst
> +
> +[2] Documentation/firmware-guide/acpi/method-customizing.rst
> +
> +[3] ACPI Specifications, Version 6.3 - Paragraph 6.1.1 _ADR Address)
> +    https://uefi.org/sites/default/files/resources/ACPI_6_3_May16.pdf,
> +    referenced 2020-11-18

-- 
With Best Regards,
Andy Shevchenko


