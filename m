Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E184285578
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Oct 2020 02:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJGAft (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Oct 2020 20:35:49 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38978 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgJGAfs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Oct 2020 20:35:48 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 355CA1452;
        Wed,  7 Oct 2020 02:35:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1602030946;
        bh=YKJdDrojWu8MOC9ryGY7hoCkUsbMKxMZjLLD9swk/k0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oMx0VYjGW3bPU5kQvfz7Hjm7Q21vs0kajYQ73gNGCCS02av6zpWUTc2qVNiW82Mjq
         Hb/9MCpAIeMB1qyXJ0yTsQRh3JDeWJ7Oxwmr3Z6i7TcUkgUluOvSGWtszmDNHdkhZy
         S2e1LUvYx+y1rJdqDLygEstnbHal3o2GoRHiRF0Y=
Date:   Wed, 7 Oct 2020 03:35:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ben Gamari <ben@smart-cactus.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: OpRegion conflicts for Skylake LPSS
Message-ID: <20201007003504.GE6709@pendragon.ideasonboard.com>
References: <87lh41nqqq.fsf@smart-cactus.org>
 <20160426155437.GA10202@lahna.fi.intel.com>
 <87eg9snkiw.fsf@smart-cactus.org>
 <87r3dona7g.fsf@smart-cactus.org>
 <20160429074227.GJ32610@lahna.fi.intel.com>
 <8737q24std.fsf@smart-cactus.org>
 <20160502103501.GP32610@lahna.fi.intel.com>
 <20201001221023.GA12766@pendragon.ideasonboard.com>
 <20201002103512.GZ3956970@smile.fi.intel.com>
 <20201002122654.GA3933@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201002122654.GA3933@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 02, 2020 at 03:26:55PM +0300, Laurent Pinchart wrote:
> On Fri, Oct 02, 2020 at 01:35:12PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 02, 2020 at 01:10:23AM +0300, Laurent Pinchart wrote:
> > > On Mon, May 02, 2016 at 01:35:01PM +0300, Mika Westerberg wrote:
> > > > On Sun, May 01, 2016 at 12:47:58AM +0200, Ben Gamari wrote:
> > > > > Mika Westerberg <mika.westerberg@linux.intel.com> writes:
> > > > > > On Fri, Apr 29, 2016 at 09:30:27AM +0200, Ben Gamari wrote:
> > > > > >> Ben Gamari <ben@smart-cactus.org> writes:
> > > > > >> 
> > > > > >> > [ Unknown signature status ]
> > > > > >> > Mika Westerberg <mika.westerberg@linux.intel.com> writes:
> > > > > >> >
> > > > > >> >> On Tue, Apr 26, 2016 at 02:44:13AM +0200, Ben Gamari wrote:
> > > > > >> >>> 
> > > > > >> > snip
> > > > > >> >
> > > > > >> >>> It looks very much like these are describing the same device. Perhaps
> > > > > >> >>> the lpss driver should be binding to this ACPI node? Or perhaps this is
> > > > > >> >>> a firmware issue? Any guidance would be greatly appreciated.
> > > > > >> >>
> > > > > >> >> Can you send me full acpidump of that machine?
> > > > > >> >
> > > > > >> > It can be found at
> > > > > >> > https://github.com/bgamari/dell-e7470-dsdt/blob/master/acpi.log.
> > > > > >> >
> > > > > >> Did this provide any insight? Let me know if more information would be
> > > > > >> helpful.
> > > > > >
> > > > > > Sorry about the delay.
> > > > >
> > > > > No worries.
> > > > > 
> > > > > > The GEXP device is most probably a GPIO expander that is connected to
> > > > > > one of the I2C buses. And it indeed looks to use directly the I2C host
> > > > > > controller registers so kernel rightfully complains about that.
> > > > > >
> > > > > > Are you able to run Windows on that machine? If yes, it would be nice to
> > > > > > know if the INT3446 I2C device is shown in the device manager.
> > > > >
> > > > > I had the original SSD that came with the machine with the original
> > > > > Windows 7 installation intact. I popped it in and found no such device.
> > > > > I then updated to Windows 10 (albeit still booting with the legacy BIOS,
> > > > > not EFI) and found that once again there is no such device shown in
> > > > > device manager.
> > > > 
> > > > That's what I would expect. ACPI spec says that if there is an OpRegion
> > > > touching the same registers than PCI device the OS should not load any
> > > > driver for that device. I guess this is exactly what Windows does.
> > > > 
> > > > Linux does it also but it in addition it issues a scary warning which
> > > > might get users thinking there is something wrong with their system.
> > > 
> > > I'm trying to get camera sensors detected on a Microsoft Surface Go 2
> > > machine (ACPI dumps available at
> > > https://github.com/linux-surface/acpidumps/tree/master/surface_go_2).
> > > The CPU is an Intel Pentium Gold 4425Y, based on Kaby Lake-Y. The DSDT
> > > has been carefully designed, with great care to make it as useless as
> > > possible, so I'm experiencing a few issues.
> > 
> > I think Sakari has a laptop with PCA953x driver in ASL (AML). I remember it had
> > some issues.
> 
> What a surprise, isn't it ? :-)
> 
> > > One of the camera sensors is connected to I2C4, backed by an LPSS I2C
> > > controller.
> > > 
> > > 00:19.2 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #4 (rev 21)
> > >         Subsystem: QUANTA Computer Inc Sunrise Point-LP Serial IO I2C Controller
> > >         Flags: fast devsel, IRQ 34
> > >         Memory at b1648000 (64-bit, non-prefetchable) [size=4K]
> > >         Capabilities: [80] Power Management version 3
> > >         Capabilities: [90] Vendor Specific Information: Len=14 <?>
> > >         Kernel modules: intel_lpss_pci
> > > 
> > > Unfortunately the driver fails to probe due to the same issue reported
> > > by Ben:
> > > 
> > > [    2.060237] intel-lpss 0000:00:19.2: enabling device (0000 -> 0002)
> > > [    2.060483] ACPI Warning: SystemMemory range 0x00000000B1648000-0x00000000B16481FF conflicts with OpRegion 0x00000000B1648000-0x00000000B1648207 (\_SB.PCI0.GEXP.BAR0) (20200528/utaddress-213)
> > > [    2.060489] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> > > [    2.060726] intel-lpss: probe of 0000:00:19.2 failed with error -16
> > > 
> > > I've checked the GEXP device in the DSDT, and it includes an LPSS I2C
> > > host controller driver in AML, using an OpRegion that covers the I2C
> > > controller registers.
> > > 
> > > Adding acpi_enforce_resources=lax to the kernel command line allows the
> > > I2C controller to be probed, but that's hardly a good solution, as two
> > > drivers (one in the DSDT, one in the kernel) that poke the same hardware
> > > is calling for trouble.
> > > 
> > > I've noticed that Windows maps the devices to different addresses than
> > > Linux. On Windows, the I2C controllers are at
> > > 
> > > I2C0 (8086:9d60): 0xfe40f000 - 0xfe40ffff (IRQ 16)
> > > I2C1 (8086:9d61): 0xfe40e000 - 0xfe40efff (IRQ 17)
> > > I2C2 (8086:96d2): 0xfe40d000 - 0xfe40dfff (IRQ 18)
> > > I2C3 (8086:96d3): 0xfe40c000 - 0xfe40cfff (IRQ 19)
> > > I2C4 (8086:96d4): 0xfe409000 - 0xfe409fff (IRQ 34)
> > > 
> > > while on Linux they're at
> > > 
> > > I2C0 (8086:9d60): 0xb1642000 - 0xb1642fff (IRQ 16)
> > > I2C1 (8086:9d61): 0xb1643000 - 0xb1643fff (IRQ 17)
> > > I2C2 (8086:96d2): 0xb1644000 - 0xb1644fff (IRQ 18)
> > > I2C3 (8086:96d3): 0xb1645000 - 0xb1645fff (IRQ 19)
> > > I2C4 (8086:96d4): 0xb1648000 - 0xb1648fff (IRQ 34)
> > 
> > Addresses are defined by BIOS/Linux PCI core. Basically it sounds like the
> > addresses from the BIOS are changed by OS. Can you enable PCI early dump in
> > Linux and look at what the BIOS assignments there?
> 
> For the record if anyone wonders how to do so, that's pci=earlydump on
> the kernel command line.
> 
> [    0.843745] pci 0000:00:19.2: [8086:9d64] type 00 class 0x118000
> [    0.843747] pci 0000:00:19.2: config space:
> [    0.844637] 00000000: 86 80 64 9d 00 00 10 00 21 00 80 11 10 00 80 00
> [    0.844638] 00000010: 04 80 64 b1 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.844639] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 2d 15 37 12
> [    0.844640] 00000030: 00 00 00 00 80 00 00 00 00 00 00 00 ff 03 00 00
> [    0.844641] 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.844641] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.844642] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.844643] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.844644] 00000080: 01 90 03 00 0b 00 00 00 00 00 00 00 00 00 00 00
> [    0.844645] 00000090: 09 00 14 f0 10 00 40 01 01 21 00 00 c1 24 00 00
> [    0.844645] 000000a0: 00 08 0f 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.844646] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.844647] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.844648] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.844649] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.844649] 000000f0: 00 00 00 00 00 00 00 00 b3 0f 41 08 00 00 00 00
> [    0.844920] pci 0000:00:19.2: reg 0x10: [mem 0xb1648000-0xb1648fff 64bit]
> 
> So I think Windows remaps the PCI BAR, Linux doesn't.
> 
> > Also you may check it in EFI shell.
> 
> The firmware doesn't provide one by default on this machine.
> 
> > In any case I don't think it should affect the system, but if the ASL
> > has hard coded addresses for hardware, it's a very bad one and must be avoided.
> 
>         Device (GEXP)
>         {
>             Name (_ADR, One)  // _ADR: Address
>             Name (_STA, 0x0B)  // _STA: Status
>             OperationRegion (BAR0, SystemMemory, SB04, 0x0208)
> 	    ...
> 
> SB04 is a field in an operation region defined as
> 
>     Name (PNVB, 0x8CF70018)
>     Name (PNVL, 0x0287)
>     OperationRegion (PNVA, SystemMemory, PNVB, PNVL)
> 
> # acpidbg -b 'evaluate SB04'
> Evaluating \SB04
> Evaluation of \SB04 returned object 00000000207ad9ad, external buffer length 18
>  [Integer] = 00000000B1648000
> 
> Do I correctly understand that the GEXP.BAR0 operation region address is
> set to a value provided by the firmware, and then never changes ? If the
> OperationRegion of the GEXP can't be remapped, it will be left accessing
> a PCI device (he LPSS) that have been moved after the PCI BAR has been
> remapped by Windows, right ? I wonder if this means that these AML code
> paths are not triggered after boot time, or if something else is put in
> place to handle the conflict.
> 
> My goal is to figure out how to operate this safely in Linux.
> acpi_enforce_resources=lax is good enough for "operate", but doesn't
> seem it matches the "safely" requirement.

I have a crazy theory that I really hope someone will help prove false.

Given that Windows remaps the I2C controller PCI BAR, accesses to the
old memory mapped I/O range from AML will obviously not behave
correctly. Could it be that the CPU will then generate a fault, which
the Windows driver for the I2C controller traps, in order to emulate the
hardware and arbitrate accesses from the AML driver and the OS-side I2C
clients ?

> > > Interestingly, the I2C4 object contains the following in the DSDT:
> > > 
> > >             If ((SMD4 != 0x02))
> > >             {
> > >                 Name (_HID, "INT3446")  // _HID: Hardware ID
> > >                 Method (_HRV, 0, NotSerialized)  // _HRV: Hardware Revision
> > >                 {
> > >                     Return (LHRV (SB14))
> > >                 }
> > > 
> > >                 Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> > >                 {
> > >                     Return (LCRS (SMD4, SB04, SIR4))
> > >                 }
> > > 
> > >                 Method (_STA, 0, NotSerialized)  // _STA: Status
> > >                 {
> > >                     Return (LSTA (SMD4))
> > >                 }
> > >             }
> > > 
> > >             If ((SMD4 == 0x02))
> > >             {
> > >                 Name (_ADR, 0x00190002)  // _ADR: Address
> > >                 Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
> > >                 {
> > >                     If (PCIC (Arg0))
> > >                     {
> > >                         Return (PCID (Arg0, Arg1, Arg2, Arg3))
> > >                     }
> > > 
> > >                     Return (Buffer (One)
> > >                     {
> > >                          0x00                                             // .
> > >                     })
> > >                 }
> > >             }
> > > 
> > > I've evaluated SMD4 with acpidbg and it's equal to 2. I thought it might
> > > be set to a different value in windows, but the hardware IDs reported by
> > > the device manager all refer to the PCI device, not the ACPI device, so
> > > I don't think that's a lead.
> > 
> > This is basically a switch in the reference BIOS how to enumerate LPSS devices,
> > if you don't have such a knob in BIOS menus, I think it's no way to change it.
> 
> The firmware menu is very simple, it's a MS machine, designed for
> Windows exclusively, so there are very few options (secure boot can
> still be disabled though).
> 
> > > I really wonder how this is supposed to be handled, would the device
> > > really be designed to work in such an unsafe way ? Does Windows remap
> > > the BAR due to the conflict with the GEXP, rendering the GEXP
> > > non-operational after boot ? I have tried to locate the GEXP in the
> > > device manager in Windows, but with its _STA method returning 0x0b, it
> > > seems not to be visible.
> > 
> > Obviously it's designed for Windows (sic!) for a very certain driver which can
> > have all possible ugliness in the world. When people are living by the terms of
> > 20 years old world and doing things in the same way we won't have situation any
> > better.
> > 
> > > > > >> Also, is there a way to simply allow the driver subsystem to allow
> > > > > >> probing to proceed despite this resource conflict so that I can resume
> > > > > >> debugging my original input device issue?
> > > > > >
> > > > > > Try to pass "acpi_enforce_resources=lax" in the kernel command line.
> > > > > 
> > > > > Thanks, indeed this allows the driver to load. Unfortunately it didn't
> > > > > take long to encounter further issues.
> > > > > 
> > > > > The motivation for all of this is to get the touchpad into I2C mode, since
> > > > > currently it is merely exposed as a simple PS/2 device. Unfortunately it
> > > > > seems that even Windows 10 doesn't use the touchpad's I2C mode (although
> > > > > I suppose it's possible that this is guarded on UEFI boot; moreover
> > > > > Windows appears to have proper support for configurating this touchpad
> > > > > in PS/2 mode, which is unfortunately an ALPS devices).
> > > > > 
> > > > > Looking at the DSDT it seems that enabling the I2C interface may require
> > > > > the help of the embedded controller, the state of which is exposed in
> > > > > the DSDT through a mysteriously-named SDS1 field. It looks like this
> > > > > field could take on a number of values which identify a variety of
> > > > > different touchpads. Given that it looks like GPIO pin states may be
> > > > > determined by the value of this field I'm a bit reluctant to go fiddling
> > > > > around with it. 
> > > > > 
> > > > > I do wish that firmware weren't such a nightmare.
> > > > 
> > > > +1

-- 
Regards,

Laurent Pinchart
