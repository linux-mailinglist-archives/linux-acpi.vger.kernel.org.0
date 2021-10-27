Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EB043D1AD
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 21:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbhJ0Tbh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 15:31:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:64749 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240781AbhJ0Tbh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Oct 2021 15:31:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="230196703"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="230196703"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 12:29:11 -0700
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="665119687"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 12:29:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mfobR-001ZD1-Vv;
        Wed, 27 Oct 2021 22:28:49 +0300
Date:   Wed, 27 Oct 2021 22:28:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 0/2] ACPI: scan: Honor certain device identification
 rules
Message-ID: <YXmocZ21lNKC54EI@smile.fi.intel.com>
References: <11860508.O9o76ZdvQC@kreacher>
 <YXhX/cTjH/H9UOnQ@smile.fi.intel.com>
 <YXmNuKIXjnhOx/Gi@smile.fi.intel.com>
 <CAJZ5v0hwA0sEUafiTUQL_BaKnxdiBD_ASMh_5MkWT_pjr6f1zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hwA0sEUafiTUQL_BaKnxdiBD_ASMh_5MkWT_pjr6f1zA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 27, 2021 at 08:12:20PM +0200, Rafael J. Wysocki wrote:
> On Wed, Oct 27, 2021 at 7:35 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Oct 26, 2021 at 10:33:17PM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 26, 2021 at 08:51:49PM +0200, Rafael J. Wysocki wrote:

...

> > > From the practice I would wait for some tests. I will try to find any new
> > > information about latest firmware tables on Elkhart Lake machines.
> >
> > So, what I see in Elkhart Lake
> >
> > Case 1 - Sound Wire devices (2 times):
> >
> >     Name (_ADR, 0x40000000)  // _ADR: Address
> 
> No _HID, so the IDs returned by the _CID below won't be used.
> 
> >     Name (_CID, Package (0x02)  // _CID: Compatible ID
> >     {
> >         "PRP00001",
> 
> The above device ID is invalid (one 0 too many).

Probably we have to communicate this to EHL program owners internally...
I dunno what this means in case of Sound Wire.

> >         "PNP0A05" /* Generic Container Device */
> 
> Without the change this causes a container device to be created, but
> the only purpose of it may be offline/online (if the child devices
> support offline/online).
> 
> This change should not be functionally relevant.
> 
> >     })
> >
> > Case 2 - GP DMA devices (3 times):
> >
> >     Name (_ADR, 0x001D0003)  // _ADR: Address
> 
> _ADR will be ignored which may not be expected.  Is this a PCI device?

It depends on the BIOS decision at boot time. No idea if it's only one
possibility (what I have heard is that device is PCI enumerated, that's
why they chose PCI ID in the CSRT, to avoid allocating new IDs for truly
ACPI-enumerated device).

But seems another point to discuss internally.

> >     Name (_HID, "80864BB4")  // _HID: Hardware ID
> >
> > Case 3 - Camera PMIC devices (5 x 2 (CLPn/DSCn) + 1 (PMIC) times = 11x):
> >
> >     Name (_ADR, Zero)  // _ADR: Address
> 
> _ADR will be ignored, which shouldn't matter.
> 
> >     Name (_HID, "INT3472")  // _HID: Hardware ID
> >     Name (_CID, "INT3472")  // _CID: Compatible ID
> >
> > Case 4 - LNK devices (6 times):
> >
> >     Name (_ADR, Zero)  // _ADR: Address
> 
> Same here.
> 
> >     ...
> >
> >     Name (_UID, One)  // _UID: Unique ID
> >     Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
> >     {
> >         Return (HCID (One))
> >     }
> >
> > Case 5 - Camera sensors (2 times):
> >
> >     Name (_ADR, Zero)  // _ADR: Address
> 
> And same here.
> 
> >     Name (_HID, "INT34xx")  // _HID: Hardware ID
> >     Name (_CID, "INT34xx")  // _CID: Compatible ID
> >
> > I have no idea about cameras or audio devices, but what I'm worrying about
> > is GP DMA. This kind of devices are PCI, but due to Microsoft hack, called
> > CSRT, we have to have a possibility to match DSDT with CSRT ot retrieve
> > the crucial information from the latter while being enumerated by the former.
> >
> > While it may be against the specification, there is no other way to achieve
> > that as far as I understand (without either breaking things in Linux or
> > getting yellow bang in Windows).
> 
> I'm not really sure why _HID is needed for this.  The PCI device ID
> could be used for CRST matching just fine.
> 
> > Can you confirm that your change won't modify behaviour for these devices?
> 
> Well, the GP DMA thing may be broken by patch [2/2], but does Windows
> actually use _ADR if _HID is provided?

No idea. Let's discuss internally.

P.S. The issue here is that some BIOS versions are floating around and
we never know who is using what... :-(

-- 
With Best Regards,
Andy Shevchenko


