Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78BEE1023A0
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 12:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfKSLwa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 06:52:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:30916 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfKSLwa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 06:52:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 03:52:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="215525967"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 19 Nov 2019 03:52:21 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 19 Nov 2019 13:52:20 +0200
Date:   Tue, 19 Nov 2019 13:52:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI / button: Add DMI quirk for Acer Switch 10 SW5-032
 lid-switch
Message-ID: <20191119115220.GH11621@lahna.fi.intel.com>
References: <20191118153556.28751-1-hdegoede@redhat.com>
 <20191119082642.GF11621@lahna.fi.intel.com>
 <7a2ac981-1c28-5abb-0599-68da44675bdc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a2ac981-1c28-5abb-0599-68da44675bdc@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 19, 2019 at 12:12:35PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 19-11-2019 09:26, Mika Westerberg wrote:
> > On Mon, Nov 18, 2019 at 04:35:56PM +0100, Hans de Goede wrote:
> > > The Acer Switch 10 SW5-032 _LID method is quite broken, it looks like this:
> > > 
> > >              Method (_LID, 0, NotSerialized)  // _LID: Lid Status
> > >              {
> > >                  If ((STAS & One))
> > >                  {
> > >                      Local0 = One
> > >                      PBCG |= 0x05000000
> > >                      HMCG |= 0x05000000
> > >                  }
> > >                  Else
> > >                  {
> > >                      Local0 = Zero
> > >                      PBCG &= 0xF0FFFFFF
> > >                      HMCG &= 0xF0FFFFFF
> > >                  }
> > > 
> > >                  ^^PCI0.GFX0.CLID = Local0
> > >                  Return (Local0)
> > >              }
> > > 
> > > The problem here is the accesses to the PBCG and HMCG, these are the
> > > pinconf0 registers for the power, resp. the home button GPIO,
> > > e.g. PBCG is declared as:
> > > 
> > >              OperationRegion (PWBT, SystemMemory, 0xFED0E080, 0x10)
> > >              Field (PWBT, DWordAcc, NoLock, Preserve)
> > >              {
> > >                  PBCG,   32,
> > >                  PBV1,   32,
> > >                  PBSA,   32,
> > >                  PBV2,   32
> > >              }
> > > 
> > > Where 0xFED0E000 is the base address of the GPO2 device and 0x80 is
> > > the offset for the pin used for the powerbutton.
> > > 
> > > The problem here is this line in _LID:
> > >                      PBCG |= 0x05000000
> > > 
> > > This changes the trigger flags of the GPIO, changing when it generates
> > > interrupts. Note it does not clear the original flags. Linux uses an
> > > edge triggered interrupt on both positive and negative edges. This |=
> > > adds the BYT_TRIG_LVL flag to this, so now it is turned into a level
> > > interrupt which fires both when low and high, iow it simply always
> > > fires leading to an interrupt storm, the tablet immediately waking up
> > > from suspend again, etc.
> > 
> > Hmm, does it work in Windows?
> 
> I bought this machine 2nd hand and the Windows install is broken
> (the eMMC is dead) so I do not know with 100% certainty.
> 
> I guess it does work in Windows, I would assume so at least. I suspect
> that the Windows driver for "PNP0C40" GPIO buttons devices uses level
> interrupts only listening for presses which would match the "5" in the
> mask.  Note that that would very much go against the ACPI description,
> which describes the 4 GPIOs for pwrbutton/home/vol+/vol- as follows:
> 
>     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>     {
>         Name (RBUF, ResourceTemplate ()
>         {
>             GpioInt (Edge, ActiveBoth, ExclusiveAndWake, PullDefault, 0x0000,
>                 "\\_SB.GPO2", 0x00, ResourceConsumer, ,
>                 )
>                 {   // Pin list
>                     0x0010
>                 }
>             GpioInt (Edge, ActiveBoth, ExclusiveAndWake, PullDefault, 0x0000,
>                 "\\_SB.GPO2", 0x00, ResourceConsumer, ,
>                 )
>                 {   // Pin list
>                     0x0015
>                 }
>             GpioInt (Edge, ActiveBoth, ExclusiveAndWake, PullDefault, 0x0000,
>                 "\\_SB.GPO0", 0x00, ResourceConsumer, ,
>                 )
>                 {   // Pin list
>                     0x0001
>                 }
>             GpioInt (Edge, ActiveBoth, ExclusiveAndWake, PullDefault, 0x0000,
>                 "\\_SB.GPO0", 0x00, ResourceConsumer, ,
>                 )
>                 {   // Pin list
>                     0x0000
>                 }
>         })
>         Return (RBUF) /* \_SB_.TBAD._CRS.RBUF */
>     }
> 
> Notice how all GPIOs are specified as GpioInt's which are active on
> both edges and this is what the linux gpio_keys driver uses.

OK thanks for the details.

> Working around this is not impossible, but it will be quite ugly and given
> the age of the machine IMHO not worth it.

I agree.

> I've also found out that I need a DSDT override to be able to control
> the LCD backlight, this is controlled by the 1st PWM controller in the
> SoC LPSS block, which is normally enumerated through ACPI but the
> entire Device (PWM1) {} block is missing from the DSDT :|  Adding it
> from similar hardware fixes things and makes the backlight
> controllable. TL;DR: it seems that this is one of the rare cased where
> people who want to run Linux will need to do a manual DSDT override :|
> 
> When they do that override they can also fix the _LID method and
> then re-enable LID functionality on the kernel commandline overriding
> this DMI quirk.
> 
> I will probably do a blog post on this (some people have asked me
> to do some blogposts about how to analyze DSDT-s, this will be a nice
> example) and add a link to the DSDT override to the blogpost, I believe
> that this is the best we can do for users of this device.
> 
> In the meantime this quirk at least avoids the interrupt storm making
> the device mostly usable even without the DSDT override.

Yup, makes sense.
