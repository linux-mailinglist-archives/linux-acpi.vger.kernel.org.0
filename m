Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2A11AE196
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Apr 2020 17:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgDQPyA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 17 Apr 2020 11:54:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63087 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgDQPyA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Apr 2020 11:54:00 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 643ac3c85cee0d5c; Fri, 17 Apr 2020 17:53:55 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Subject: Re: regression 5.6.4->5.6.5 at drivers/acpi/ec.c
Date:   Fri, 17 Apr 2020 17:53:55 +0200
Message-ID: <5392275.BHAU0OPJTB@kreacher>
In-Reply-To: <5478a950-4355-8084-ea7d-fe8b270bf2e3@infradead.org>
References: <fdd9ce1d-146a-5fbf-75c5-3a9384603312@gmx.de> <5478a950-4355-8084-ea7d-fe8b270bf2e3@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, April 17, 2020 5:17:17 PM CEST Randy Dunlap wrote:
> [add Cc's]
> 
> On 4/17/20 8:10 AM, Toralf Förster wrote:
> > At a T440s under hardened Gentoo Linux I' faced with this new spew (system seems to be working fine otherwise):
> > 
> > 
> > pci 0000:02:00.0: reg 0x10: [mem 0xe0500000-0xe0500fff]
> > pci 0000:02:00.0: supports D1 D2
> > pci 0000:02:00.0: PME# supported from D1 D2 D3hot D3cold
> > pci 0000:00:1c.0: PCI bridge to [bus 02]
> > pci 0000:00:1c.0:   bridge window [mem 0xe0500000-0xe05fffff]
> > pci 0000:03:00.0: [8086:08b2] type 00 class 0x028000
> > pci 0000:03:00.0: reg 0x10: [mem 0xe0400000-0xe0401fff 64bit]
> > pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
> > pci 0000:00:1c.1: PCI bridge to [bus 03]
> > pci 0000:00:1c.1:   bridge window [mem 0xe0400000-0xe04fffff]
> > ACPI: EC: interrupt unblocked
> > ACPI: EC: event unblocked
> > ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> > ACPI: EC: GPE=0x25
> > ACPI: \_SB_.PCI0.LPC_.EC__: Boot ECDT EC initialization complete
> > ACPI: \_SB_.PCI0.LPC_.EC__: EC: Used to handle transactions and events
> > ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> > ACPI: EC: GPE=0x25
> > ACPI: \_SB_.PCI0.LPC_.EC__: Boot ECDT EC initialization complete
> > ACPI: \_SB_.PCI0.LPC_.EC__: EC: Used to handle transactions and events
> > ------------[ cut here ]------------
> > Could not request EC data io port 0x62
> > WARNING: CPU: 0 PID: 1 at drivers/acpi/ec.c:1677 acpi_ec_add+0x26e/0x280
> > Modules linked in:
> > CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T 5.6.5 #5
> > Hardware name: LENOVO 20AQCTO1WW/20AQCTO1WW, BIOS GJET92WW (2.42 ) 03/03/2017
> > RIP: 0010:acpi_ec_add+0x26e/0x280
> > Code: fe ff ff 48 8b 75 10 48 c7 c7 d0 27 9b 8d e8 81 c7 b6 ff 0f 0b e9 c9 fe ff ff 48 8b 75 18 48 c7 c7 a8 27 9b 8d e8 6a c7 b6 ff <0f> 0b e9 8a fe ff ff 41 bc f4 ff ff ff e9 ac fe ff ff 48 83 3d f8
> > RSP: 0000:ffffb45b40053c80 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: ffffa2827012b800 RCX: 0000000000000000
> > RDX: 0000000000000026 RSI: ffffffff8e26f666 RDI: ffffffff8e26fa66
> > RBP: ffffa282709b4b00 R08: 0000000089294f76 R09: 0000000000000026
> > R10: 000000000000000f R11: ffffb45b40053aa8 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000030
> > FS:  0000000000000000(0000) GS:ffffa28272600000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffa2827e5ff000 CR3: 000000008e80a001 CR4: 00000000001606f0
> > Call Trace:
> >  acpi_device_probe+0x40/0x100
> >  really_probe+0xe8/0x2d0
> >  driver_probe_device+0x57/0xd0
> >  ? driver_allows_async_probing+0x50/0x50
> >  bus_for_each_drv+0x90/0xe0
> >  __device_attach+0xea/0x160
> >  acpi_bus_register_early_device+0x4b/0x70
> >  acpi_ec_init+0x2ee/0x361
> >  acpi_init+0x410/0x4a0
> >  ? acpi_sleep_proc_init+0x4c/0x4c
> >  do_one_initcall+0x93/0x1f0
> >  kernel_init_freeable+0x3e7/0x4cc
> >  ? rest_init+0xc0/0xc0
> >  kernel_init+0x6/0x110
> >  ? rest_init+0xc0/0xc0
> >  ret_from_fork+0x35/0x40
> > ---[ end trace cd90af9f64ca9345 ]---
> > ------------[ cut here ]------------
> > Could not request EC cmd io port 0x66
> > WARNING: CPU: 0 PID: 1 at drivers/acpi/ec.c:1679 acpi_ec_add+0x257/0x280
> > Modules linked in:
> > CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       T 5.6.5 #5
> > Hardware name: LENOVO 20AQCTO1WW/20AQCTO1WW, BIOS GJET92WW (2.42 ) 03/03/2017
> > RIP: 0010:acpi_ec_add+0x257/0x280
> > Code: 8b 55 00 48 89 ef 48 89 10 e8 65 e0 ff ff 48 8b 2d 4e d7 3b 01 e9 4a fe ff ff 48 8b 75 10 48 c7 c7 d0 27 9b 8d e8 81 c7 b6 ff <0f> 0b e9 c9 fe ff ff 48 8b 75 18 48 c7 c7 a8 27 9b 8d e8 6a c7 b6
> > RAX: 0000000000000000 RBX: ffffa2827012b800 RCX: 0000000000000000
> > RDX: 0000000000000025 RSI: ffffffff8e26f665 RDI: ffffffff8e26fa65
> > RBP: ffffa282709b4b00 R08: 000000008935c8e8 R09: 0000000000000025
> > R10: 000000000000000f R11: ffffb45b40053aa8 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000030
> > FS:  0000000000000000(0000) GS:ffffa28272600000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffa2827e5ff000 CR3: 000000008e80a001 CR4: 00000000001606f0
> > Call Trace:
> >  acpi_device_probe+0x40/0x100
> >  really_probe+0xe8/0x2d0
> >  driver_probe_device+0x57/0xd0
> >  ? driver_allows_async_probing+0x50/0x50
> >  bus_for_each_drv+0x90/0xe0
> >  __device_attach+0xea/0x160
> >  acpi_bus_register_early_device+0x4b/0x70
> >  acpi_ec_init+0x2ee/0x361
> >  acpi_init+0x410/0x4a0
> >  ? acpi_sleep_proc_init+0x4c/0x4c
> >  do_one_initcall+0x93/0x1f0
> >  kernel_init_freeable+0x3e7/0x4cc
> >  ? rest_init+0xc0/0xc0
> >  kernel_init+0x6/0x110
> >  ? rest_init+0xc0/0xc0
> >  ret_from_fork+0x35/0x40
> > ---[ end trace cd90af9f64ca9346 ]---
> > iommu: Default domain type: Translated
> > pci 0000:00:02.0: vgaarb: setting as boot VGA device
> > pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> > pci 0000:00:02.0: vgaarb: bridge control possible
> > vgaarb: loaded
> > SCSI subsystem initialized
> > libata version 3.00 loaded.
> > ACPI: bus type USB registered
> > usbcore: registered new interface driver usbfs
> > usbcore: registered new interface driver hub
> > usbcore: registered new device driver usb
> > pps_core: LinuxPPS API ver. 1 registered
> > pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> > EDAC MC: Ver: 3.0.0
> > PCI: Using ACPI for IRQ routing
> > PCI: pci_cache_line_size set to 64 bytes
> > e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
> > e820: reserve RAM buffer [mem 0xaf70b000-0xafffffff]
> > e820: reserve RAM buffer [mem 0x33e600000-0x33fffffff]
> > hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> > hpet0: 8 comparators, 64-bit 14.318180 MHz counter
> > clocksource: Switched to clocksource tsc-early
> > *** VALIDATE ramfs ***
> > *** VALIDATE hugetlbfs ***
> > pnp: PnP ACPI init
> > system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
> > system 00:00: [mem 0x000c0000-0x000c3fff] could not be reserved
> > system 00:00: [mem 0x000c4000-0x000c7fff] could not be reserved
> > system 00:00: [mem 0x000c8000-0x000cbfff] could not be reserved
> > system 00:00: [mem 0x000cc000-0x000cffff] could not be reserved
> > system 00:00: [mem 0x000d0000-0x000d3fff] has been reserved
> > system 00:00: [mem 0x000d4000-0x000d7fff] has been reserved
> > system 00:00: [mem 0x000d8000-0x000dbfff] has been reserved
> > system 00:00: [mem 0x000dc000-0x000dffff] has been reserved
> > system 00:00: [mem 0x000e0000-0x000e3fff] could not be reserved
> > system 00:00: [mem 0x000e4000-0x000e7fff] could not be reserved
> > system 00:00: [mem 0x000e8000-0x000ebfff] could not be reserved
> > system 00:00: [mem 0x000ec000-0x000effff] could not be reserved
> > system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
> > system 00:00: [mem 0x00100000-0xbf9fffff] could not be reserved
> > system 00:00: [mem 0xfec00000-0xfed3ffff] could not be reserved
> > system 00:00: [mem 0xfed4c000-0xffffffff] could not be reserved
> > system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
> > pnp 00:01: [Firmware Bug]: PNP resource [mem 0xfed10000-0xfed13fff] covers only part of 0000:00:00.0 Intel MCH; extending to [mem 0xfed10000-0xfed17fff]
> > system 00:01: [io  0x1800-0x189f] has been reserved
> > system 00:01: [io  0x0800-0x087f] has been reserved
> > system 00:01: [io  0x0880-0x08ff] has been reserved
> > system 00:01: [io  0x0900-0x097f] has been reserved
> > system 00:01: [io  0x0980-0x09ff] has been reserved
> > system 00:01: [io  0x0a00-0x0a7f] has been reserved
> > system 00:01: [io  0x0a80-0x0aff] has been reserved
> > system 00:01: [io  0x0b00-0x0b7f] has been reserved
> > system 00:01: [io  0x0b80-0x0bff] has been reserved
> > system 00:01: [io  0x15e0-0x15ef] has been reserved
> > system 00:01: [io  0x1600-0x167f] has been reserved
> > system 00:01: [io  0x1640-0x165f] has been reserved
> > system 00:01: [mem 0xf8000000-0xfbffffff] has been reserved

Does the patch below (untested) make any difference?

---
 drivers/acpi/ec.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -2067,7 +2067,10 @@ static struct acpi_driver acpi_ec_driver
 		.add = acpi_ec_add,
 		.remove = acpi_ec_remove,
 		},
-	.drv.pm = &acpi_ec_pm,
+	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+		.pm = &acpi_ec_pm,
+	},
 };
 
 static void acpi_ec_destroy_workqueues(void)



