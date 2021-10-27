Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC0C43CFD4
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 19:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbhJ0Rhg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 13:37:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:53607 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238472AbhJ0Rhf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Oct 2021 13:37:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="293682176"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="293682176"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 10:35:10 -0700
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="665079854"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 10:35:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mfmp7-001WyC-73;
        Wed, 27 Oct 2021 20:34:49 +0300
Date:   Wed, 27 Oct 2021 20:34:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 0/2] ACPI: scan: Honor certain device identification
 rules
Message-ID: <YXmNuKIXjnhOx/Gi@smile.fi.intel.com>
References: <11860508.O9o76ZdvQC@kreacher>
 <YXhX/cTjH/H9UOnQ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXhX/cTjH/H9UOnQ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 26, 2021 at 10:33:17PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 26, 2021 at 08:51:49PM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > There are some rules in the ACPI spec regarding which device identification
> > objects can be used together etc., but they are not followed by the kernel
> > code.
> > 
> > This series modifies the code to follow the spec more closely (see patch
> > changelogs for details).
> 
> I understand the motivation, but afraid about consequences on the OEM cheap
> devices that are not always follow letter of the specification.
> 
> As per Intel platforms I would look into Baytrail / Cherrytrail devices for
> the past (I think Hans may help here a lot) and into Elkhart Lake in the
> present (for the letter I mostly refer to CSRT + DSDT cooperation to get
> GP DMA devices enumerated, so I _hope_ DSDT shouldn't have _ADR and _HID
> together).
> 
> Hence, from the code perspective
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> From the practice I would wait for some tests. I will try to find any new
> information about latest firmware tables on Elkhart Lake machines.

So, what I see in Elkhart Lake

Case 1 - Sound Wire devices (2 times):

    Name (_ADR, 0x40000000)  // _ADR: Address
    Name (_CID, Package (0x02)  // _CID: Compatible ID
    {
        "PRP00001",
        "PNP0A05" /* Generic Container Device */
    })

Case 2 - GP DMA devices (3 times):

    Name (_ADR, 0x001D0003)  // _ADR: Address
    Name (_HID, "80864BB4")  // _HID: Hardware ID

Case 3 - Camera PMIC devices (5 x 2 (CLPn/DSCn) + 1 (PMIC) times = 11x):

    Name (_ADR, Zero)  // _ADR: Address
    Name (_HID, "INT3472")  // _HID: Hardware ID
    Name (_CID, "INT3472")  // _CID: Compatible ID

Case 4 - LNK devices (6 times):

    Name (_ADR, Zero)  // _ADR: Address
    ...

    Name (_UID, One)  // _UID: Unique ID
    Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
    {
        Return (HCID (One))
    }

Case 5 - Camera sensors (2 times):

    Name (_ADR, Zero)  // _ADR: Address
    Name (_HID, "INT34xx")  // _HID: Hardware ID
    Name (_CID, "INT34xx")  // _CID: Compatible ID


I have no idea about cameras or audio devices, but what I'm worrying about
is GP DMA. This kind of devices are PCI, but due to Microsoft hack, called
CSRT, we have to have a possibility to match DSDT with CSRT ot retrieve
the crucial information from the latter while being enumerated by the former.

While it may be against the specification, there is no other way to achieve
that as far as I understand (without either breaking things in Linux or
getting yellow bang in Windows).

Can you confirm that your change won't modify behaviour for these devices?

-- 
With Best Regards,
Andy Shevchenko


