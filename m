Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031002D62CE
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 18:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392374AbgLJRAA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 12:00:00 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53828 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgLJQ7y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2020 11:59:54 -0500
Received: from 89-64-77-250.dynamic.chello.pl (89.64.77.250) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 4643ab17ba859cb3; Thu, 10 Dec 2020 17:59:10 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: acpi_device_notify() binding devices that don't seem like they should be bound
Date:   Thu, 10 Dec 2020 17:59:09 +0100
Message-ID: <1874841.VfOVrlA5c3@kreacher>
In-Reply-To: <d3758b6a-7661-03b7-5a67-1fcb82253fb7@gmail.com>
References: <1409ba0c-1580-dc09-e6fe-a0c9bcda6462@gmail.com> <CAJZ5v0inSq27Zpq=K4df=wypnSdyk5u1P-06wXiVG_vE2ZvDCQ@mail.gmail.com> <d3758b6a-7661-03b7-5a67-1fcb82253fb7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, December 10, 2020 5:07:56 PM CET Daniel Scally wrote:
> 
> On 10/12/2020 16:05, Rafael J. Wysocki wrote:
> > All the adevs with matching _ADR also have both _STA and _HID
> > unfortunately. Sorry; let me stop half-arsing this and show you
> > something useful:
> >
> > [    0.219953] acpi_find_child_device(PNP0A08:00, 0x00, false)
> > [    0.220818] INT3472:00: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> > [    0.220821] INT3472:01: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> > [    0.220870] INT3472:02: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> > [    0.220892] INT3472:03: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> > [    0.220916] INT3472:04: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> > [    0.220941] INT3472:05: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> > [    0.220965] INT3472:06: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> > [    0.220990] INT3472:07: _STA 0x00, _ADR=0x00000000, _HID=INT3472
> > These will be ignored with -ENODEV.
> >
> >> [    0.221038] INT3472:08: _STA 0x0f, _ADR=0x00000000, _HID=INT3472
> > For this acpi_find_child_device() will return FIND_CHILD_MIN_SCORE if
> > I'm not mistaken.
> It does - this is the one that binds, being the first.
> >> [    0.221051] OVTI5648:00: _STA 0x0f, _ADR=0x00000000, _HID=OVTI5648
> >> [    0.221061] INT3472:09: _STA 0x0f, _ADR=0x00000000, _HID=INT3472
> >> [    0.221070] OVTI2680:00: _STA 0x0f, _ADR=0x00000000, _HID=OVTI2680
> > As well as for the three above.
> >
> >> [    0.221079] INT3471:00: _STA 0x00, _ADR=0x00000000, _HID=INT3471
> >> [    0.221105] INT33BE:00: _STA 0x00, _ADR=0x00000000, _HID=INT33BE
> >> [    0.221130] INT3471:01: _STA 0x00, _ADR=0x00000000, _HID=INT3471
> >> [    0.221156] INT33BE:01: _STA 0x00, _ADR=0x00000000, _HID=INT33BE
> > And the rest will be ignored.
> >
> >> That's the debug output I included for each adev that's assessed as a
> >> child of PNP0A08:00. _STA, _ADR and _HID present for all, _ADR 0x00 for
> >> all, _STA 0x0f for the 2 sensors and their PMIC's and 0x00 for the rest.
> >> The same situation holds on both of my devices.
> > So in fact we don't want to have an ACPI companion for (PNP0A08:00,
> > 0x00, false).
> Yeah, I think that's right
> > This is a hostbridge special case and let me think about this for a while.
> Sure - thanks very much for your help.

I've come up with the following patch.

Please let me know if it works for you.

---
Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -1162,14 +1162,32 @@ void acpi_pci_remove_bus(struct pci_bus
 static struct acpi_device *acpi_pci_find_companion(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct acpi_device *adev;
 	bool check_children;
 	u64 addr;
 
 	check_children = pci_is_bridge(pci_dev);
 	/* Please ref to ACPI spec for the syntax of _ADR */
 	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
-	return acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
+	adev = acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
 				      check_children);
+	/*
+	 * There may be ACPI device objects in the ACPI namesoace that are
+	 * children of the device object representing the host bridge, but don't
+	 * represent PCI devices.  Both _HID and _ADR may be present for them,
+	 * even though that is against the specification (for example, see
+	 * Section 6.1 of ACPI 6.3), but in many cases the _ADR returns 0 which
+	 * appears to indicate that they should not be taken into consideration
+	 * as potential companions of PCI devices on the root bus.
+	 *
+	 * To catch this special case, disregard the returned device object if
+	 * it has a valid _HID, addr is 0 and the PCI device at hand is on the
+	 * root bus.
+	 */
+	if (adev->pnp.type.platform_id && !addr && !pci_dev->bus->parent)
+		return NULL;
+
+	return adev;
 }
 
 /**



