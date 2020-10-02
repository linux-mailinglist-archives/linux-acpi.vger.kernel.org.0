Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759E52810A3
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Oct 2020 12:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbgJBKf1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Oct 2020 06:35:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:29987 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgJBKfY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Oct 2020 06:35:24 -0400
IronPort-SDR: 7/MlFAq9V3EA2akYHFhyp9Ws2aCN97Uym8pOzRVLtxR4QE06v7UA/V/eRP902uXsD/hbgX2Fw2
 16fpF6wYdZgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="181090276"
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="181090276"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 03:35:20 -0700
IronPort-SDR: 0G7etxleBVpGOwOlrqUukpKE6pwya/Ra64Fx2ins+Lify1EK3Ru/mVA+5vmppInJqVPnEiUqtv
 M6jGBj+F5+Ew==
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="339954397"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 03:35:17 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kOIPA-003Pph-7D; Fri, 02 Oct 2020 13:35:12 +0300
Date:   Fri, 2 Oct 2020 13:35:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ben Gamari <ben@smart-cactus.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: OpRegion conflicts for Skylake LPSS
Message-ID: <20201002103512.GZ3956970@smile.fi.intel.com>
References: <87lh41nqqq.fsf@smart-cactus.org>
 <20160426155437.GA10202@lahna.fi.intel.com>
 <87eg9snkiw.fsf@smart-cactus.org>
 <87r3dona7g.fsf@smart-cactus.org>
 <20160429074227.GJ32610@lahna.fi.intel.com>
 <8737q24std.fsf@smart-cactus.org>
 <20160502103501.GP32610@lahna.fi.intel.com>
 <20201001221023.GA12766@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001221023.GA12766@pendragon.ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 02, 2020 at 01:10:23AM +0300, Laurent Pinchart wrote:
> Hi Mika,
> 
> Reviving an old thread.

Very old :-)

> On Mon, May 02, 2016 at 01:35:01PM +0300, Mika Westerberg wrote:
> > On Sun, May 01, 2016 at 12:47:58AM +0200, Ben Gamari wrote:
> > > Mika Westerberg <mika.westerberg@linux.intel.com> writes:
> > > > On Fri, Apr 29, 2016 at 09:30:27AM +0200, Ben Gamari wrote:
> > > >> Ben Gamari <ben@smart-cactus.org> writes:
> > > >> 
> > > >> > [ Unknown signature status ]
> > > >> > Mika Westerberg <mika.westerberg@linux.intel.com> writes:
> > > >> >
> > > >> >> On Tue, Apr 26, 2016 at 02:44:13AM +0200, Ben Gamari wrote:
> > > >> >>> 
> > > >> > snip
> > > >> >
> > > >> >>> It looks very much like these are describing the same device. Perhaps
> > > >> >>> the lpss driver should be binding to this ACPI node? Or perhaps this is
> > > >> >>> a firmware issue? Any guidance would be greatly appreciated.
> > > >> >>
> > > >> >> Can you send me full acpidump of that machine?
> > > >> >
> > > >> > It can be found at
> > > >> > https://github.com/bgamari/dell-e7470-dsdt/blob/master/acpi.log.
> > > >> >
> > > >> Did this provide any insight? Let me know if more information would be
> > > >> helpful.
> > > >
> > > > Sorry about the delay.
> > >
> > > No worries.
> > > 
> > > > The GEXP device is most probably a GPIO expander that is connected to
> > > > one of the I2C buses. And it indeed looks to use directly the I2C host
> > > > controller registers so kernel rightfully complains about that.
> > > >
> > > > Are you able to run Windows on that machine? If yes, it would be nice to
> > > > know if the INT3446 I2C device is shown in the device manager.
> > >
> > > I had the original SSD that came with the machine with the original
> > > Windows 7 installation intact. I popped it in and found no such device.
> > > I then updated to Windows 10 (albeit still booting with the legacy BIOS,
> > > not EFI) and found that once again there is no such device shown in
> > > device manager.
> > 
> > That's what I would expect. ACPI spec says that if there is an OpRegion
> > touching the same registers than PCI device the OS should not load any
> > driver for that device. I guess this is exactly what Windows does.
> > 
> > Linux does it also but it in addition it issues a scary warning which
> > might get users thinking there is something wrong with their system.
> 
> I'm trying to get camera sensors detected on a Microsoft Surface Go 2
> machine (ACPI dumps available at
> https://github.com/linux-surface/acpidumps/tree/master/surface_go_2).
> The CPU is an Intel Pentium Gold 4425Y, based on Kaby Lake-Y. The DSDT
> has been carefully designed, with great care to make it as useless as
> possible, so I'm experiencing a few issues.

I think Sakari has a laptop with PCA953x driver in ASL (AML). I remember it had
some issues.

> One of the camera sensors is connected to I2C4, backed by an LPSS I2C
> controller.
> 
> 00:19.2 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #4 (rev 21)
>         Subsystem: QUANTA Computer Inc Sunrise Point-LP Serial IO I2C Controller
>         Flags: fast devsel, IRQ 34
>         Memory at b1648000 (64-bit, non-prefetchable) [size=4K]
>         Capabilities: [80] Power Management version 3
>         Capabilities: [90] Vendor Specific Information: Len=14 <?>
>         Kernel modules: intel_lpss_pci
> 
> Unfortunately the driver fails to probe due to the same issue reported
> by Ben:
> 
> [    2.060237] intel-lpss 0000:00:19.2: enabling device (0000 -> 0002)
> [    2.060483] ACPI Warning: SystemMemory range 0x00000000B1648000-0x00000000B16481FF conflicts with OpRegion 0x00000000B1648000-0x00000000B1648207 (\_SB.PCI0.GEXP.BAR0) (20200528/utaddress-213)
> [    2.060489] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [    2.060726] intel-lpss: probe of 0000:00:19.2 failed with error -16
> 
> I've checked the GEXP device in the DSDT, and it includes an LPSS I2C
> host controller driver in AML, using an OpRegion that covers the I2C
> controller registers.
> 
> Adding acpi_enforce_resources=lax to the kernel command line allows the
> I2C controller to be probed, but that's hardly a good solution, as two
> drivers (one in the DSDT, one in the kernel) that poke the same hardware
> is calling for trouble.
> 
> I've noticed that Windows maps the devices to different addresses than
> Linux. On Windows, the I2C controllers are at
> 
> I2C0 (8086:9d60): 0xfe40f000 - 0xfe40ffff (IRQ 16)
> I2C1 (8086:9d61): 0xfe40e000 - 0xfe40efff (IRQ 17)
> I2C2 (8086:96d2): 0xfe40d000 - 0xfe40dfff (IRQ 18)
> I2C3 (8086:96d3): 0xfe40c000 - 0xfe40cfff (IRQ 19)
> I2C4 (8086:96d4): 0xfe409000 - 0xfe409fff (IRQ 34)
> 
> while on Linux they're at
> 
> I2C0 (8086:9d60): 0xb1642000 - 0xb1642fff (IRQ 16)
> I2C1 (8086:9d61): 0xb1643000 - 0xb1643fff (IRQ 17)
> I2C2 (8086:96d2): 0xb1644000 - 0xb1644fff (IRQ 18)
> I2C3 (8086:96d3): 0xb1645000 - 0xb1645fff (IRQ 19)
> I2C4 (8086:96d4): 0xb1648000 - 0xb1648fff (IRQ 34)

Addresses are defined by BIOS/Linux PCI core. Basically it sounds like the
addresses from the BIOS are changed by OS. Can you enable PCI early dump in
Linux and look at what the BIOS assignments there? Also you may check it in EFI
shell. In any case I don't think it should affect the system, but if the ASL
has hard coded addresses for hardware, it's a very bad one and must be avoided.

> Interestingly, the I2C4 object contains the following in the DSDT:
> 
>             If ((SMD4 != 0x02))
>             {
>                 Name (_HID, "INT3446")  // _HID: Hardware ID
>                 Method (_HRV, 0, NotSerialized)  // _HRV: Hardware Revision
>                 {
>                     Return (LHRV (SB14))
>                 }
> 
>                 Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>                 {
>                     Return (LCRS (SMD4, SB04, SIR4))
>                 }
> 
>                 Method (_STA, 0, NotSerialized)  // _STA: Status
>                 {
>                     Return (LSTA (SMD4))
>                 }
>             }
> 
>             If ((SMD4 == 0x02))
>             {
>                 Name (_ADR, 0x00190002)  // _ADR: Address
>                 Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
>                 {
>                     If (PCIC (Arg0))
>                     {
>                         Return (PCID (Arg0, Arg1, Arg2, Arg3))
>                     }
> 
>                     Return (Buffer (One)
>                     {
>                          0x00                                             // .
>                     })
>                 }
>             }
> 
> I've evaluated SMD4 with acpidbg and it's equal to 2. I thought it might
> be set to a different value in windows, but the hardware IDs reported by
> the device manager all refer to the PCI device, not the ACPI device, so
> I don't think that's a lead.

This is basically a switch in the reference BIOS how to enumerate LPSS devices,
if you don't have such a knob in BIOS menus, I think it's no way to change it.

> I really wonder how this is supposed to be handled, would the device
> really be designed to work in such an unsafe way ? Does Windows remap
> the BAR due to the conflict with the GEXP, rendering the GEXP
> non-operational after boot ? I have tried to locate the GEXP in the
> device manager in Windows, but with its _STA method returning 0x0b, it
> seems not to be visible.

Obviously it's designed for Windows (sic!) for a very certain driver which can
have all possible ugliness in the world. When people are living by the terms of
20 years old world and doing things in the same way we won't have situation any
better.

> > > >> Also, is there a way to simply allow the driver subsystem to allow
> > > >> probing to proceed despite this resource conflict so that I can resume
> > > >> debugging my original input device issue?
> > > >
> > > > Try to pass "acpi_enforce_resources=lax" in the kernel command line.
> > > 
> > > Thanks, indeed this allows the driver to load. Unfortunately it didn't
> > > take long to encounter further issues.
> > > 
> > > The motivation for all of this is to get the touchpad into I2C mode, since
> > > currently it is merely exposed as a simple PS/2 device. Unfortunately it
> > > seems that even Windows 10 doesn't use the touchpad's I2C mode (although
> > > I suppose it's possible that this is guarded on UEFI boot; moreover
> > > Windows appears to have proper support for configurating this touchpad
> > > in PS/2 mode, which is unfortunately an ALPS devices).
> > > 
> > > Looking at the DSDT it seems that enabling the I2C interface may require
> > > the help of the embedded controller, the state of which is exposed in
> > > the DSDT through a mysteriously-named SDS1 field. It looks like this
> > > field could take on a number of values which identify a variety of
> > > different touchpads. Given that it looks like GPIO pin states may be
> > > determined by the value of this field I'm a bit reluctant to go fiddling
> > > around with it. 
> > > 
> > > I do wish that firmware weren't such a nightmare.
> > 
> > +1

-- 
With Best Regards,
Andy Shevchenko


