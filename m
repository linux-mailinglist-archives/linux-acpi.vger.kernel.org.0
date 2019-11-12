Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96A6F8509
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2019 01:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKLATT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Nov 2019 19:19:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfKLATR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Nov 2019 19:19:17 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD4E720840;
        Tue, 12 Nov 2019 00:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573517956;
        bh=7Viu80YlFDf/U2qYiv71cMwq4T3UA/2DZ1VgU9m0rWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NgnDFJijO8asY3t2SPzE2AOteKCC+6tt0EO5p2aFa2st3NXLH+miZOoMaqA/LZWtZ
         ZSjcUU7AOYcrA+ZqgME3ViU7Wp5+1sZuxUDYkHiNSPOXIWNhw1kVlPl1INmdFPhLZR
         Z9UWycaMvvgoUAuFQW4R3pQnMYTrlwtP2qRxdUks=
Date:   Mon, 11 Nov 2019 18:19:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Valerio Passini <passini.valerio@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] ACPI / hotplug / PCI: Allocate resources directly under
 the non-hotplug bridge
Message-ID: <20191112001914.GA78121@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030150545.19885-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 30, 2019 at 06:05:45PM +0300, Mika Westerberg wrote:
> Valerio and others reported that commit 84c8b58ed3ad ("ACPI / hotplug /
> PCI: Don't scan bridges managed by native hotplug") prevents some recent
> LG and HP laptops from booting with endless loop of:
> 
>   [   26.237796] ACPI Error: No handler or method for GPE 08, disabling event (20190215/evgpe-835)
>   [   26.238699] ACPI Error: No handler or method for GPE 09, disabling event (20190215/evgpe-835)
>   [   26.239306] ACPI Error: No handler or method for GPE 0A, disabling event (20190215/evgpe-835)
>   ...
> 
> What seems to happen is that during boot, after the initial PCI
> enumeration when EC is enabled the platform triggers ACPI Notify() to
> one of the root ports. The root port itself looks like this:
> 
>   [    0.723757] pci 0000:00:1b.0: PCI bridge to [bus 02-3a]
>   [    0.723765] pci 0000:00:1b.0:   bridge window [mem 0xc4000000-0xda0fffff]
>   [    0.723773] pci 0000:00:1b.0:   bridge window [mem 0x80000000-0xa1ffffff 64bit pref]
> 
> The BIOS has configured the root port so that it does not have I/O
> bridge window.
> 
> Now when the ACPI Notify() is triggered ACPI hotplug handler calls
> acpiphp_native_scan_bridge() for each non-hotplug bridge (as this system
> is using native PCIe hotplug) and pci_assign_unassigned_bridge_resources()
> to allocate resources.
> 
> The device connected to the root port is a PCIe switch (Thunderbolt
> controller) with two hotplug downstream ports. Because of the hotplug
> ports __pci_bus_size_bridges() tries to add "additional I/O" of 256
> bytes to each (DEFAULT_HOTPLUG_IO_SIZE). This gets further aligned to 4k
> as that's the minimum I/O window size so each hotplug port gets 4k I/O
> window and the same happens for the root port (which is also hotplug
> port). This means 3 * 4k = 12k I/O window.
> 
> Because of this pci_assign_unassigned_bridge_resources() ends up opening
> a I/O bridge window for the root port at first available I/O address
> which seems to be in range 0x1000 - 0x3fff. Normally this range is used
> for ACPI stuff such as GPE bits (below is part of /proc/ioports):
> 
>     1800-1803 : ACPI PM1a_EVT_BLK
>     1804-1805 : ACPI PM1a_CNT_BLK
>     1808-180b : ACPI PM_TMR
>     1810-1815 : ACPI CPU throttle
>     1850-1850 : ACPI PM2_CNT_BLK
>     1854-1857 : pnp 00:05
>     1860-187f : ACPI GPE0_BLK
> 
> However, when the ACPI Notify() happened this range was not yet reserved
> for ACPI/PNP (that happens later) so PCI gets it. It then starts writing
> to this range and accidentally stomps over GPE bits among other things
> causing the endless stream of messages about missing GPE handler.
> 
> This problem does not happen if "pci=hpiosize=0" is passed in the kernel
> command line. The reason is that then the kernel does not try to
> allocate the additional 256 bytes for each hotplug port.
> 
> Fix this by allocating resources directly below the non-hotplug bridges
> where a new device may appear as a result of ACPI Notify(). This avoids
> the hotplug bridges and prevents opening the additional I/O window.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203617
> Fixes: 84c8b58ed3ad ("ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug")
> Cc: stable@vger.kernel.org
> Reported-by: Valerio Passini <passini.valerio@gmail.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied with Rafael's reviewed-by to pci/hotplug for v5.5, thanks!

> ---
> I was able to reproduce this without access to the affected system by
> forcing ACPI core to send Notify() to the TBT root port like this:
> 
> void acpi_notify_rp(void)
> {
> 	struct acpi_device *adev;
> 	acpi_handle handle;
> 
> 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB.PCI0.RP17", &handle)))
> 		return;
> 
> 	if (acpi_bus_get_device(handle, &adev))
> 		return;
> 
> 	dev_info(&adev->dev, "queueing hotplug\n");
> 	acpiphp_hotplug_notify(adev, ACPI_NOTIFY_BUS_CHECK);
> }
> 
> and calling it from acpi_init() directly after acpi_ec_init().
> 
>  drivers/pci/hotplug/acpiphp_glue.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index e4c46637f32f..b3869951c0eb 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -449,8 +449,15 @@ static void acpiphp_native_scan_bridge(struct pci_dev *bridge)
>  
>  	/* Scan non-hotplug bridges that need to be reconfigured */
>  	for_each_pci_bridge(dev, bus) {
> -		if (!hotplug_is_native(dev))
> -			max = pci_scan_bridge(bus, dev, max, 1);
> +		if (hotplug_is_native(dev))
> +			continue;
> +
> +		max = pci_scan_bridge(bus, dev, max, 1);
> +		if (dev->subordinate) {
> +			pcibios_resource_survey_bus(dev->subordinate);
> +			pci_bus_size_bridges(dev->subordinate);
> +			pci_bus_assign_resources(dev->subordinate);
> +		}
>  	}
>  }
>  
> @@ -480,7 +487,6 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  			if (PCI_SLOT(dev->devfn) == slot->device)
>  				acpiphp_native_scan_bridge(dev);
>  		}
> -		pci_assign_unassigned_bridge_resources(bus->self);
>  	} else {
>  		LIST_HEAD(add_list);
>  		int max, pass;
> -- 
> 2.23.0
> 
