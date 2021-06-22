Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1AE3B0149
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jun 2021 12:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFVKZt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Jun 2021 06:25:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:11298 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhFVKZt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 22 Jun 2021 06:25:49 -0400
IronPort-SDR: bMkX5VkizRV9g74zuz33dUtFFpdCKfVuGbTp93i8Oa4f+CfQ+okOwBvd1g0xTXpJVOnNRwJ+3O
 77WGRUlrdUvg==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="268165385"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="268165385"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 03:23:31 -0700
IronPort-SDR: 709lU/x2NTt0TjO1/SJJ63o9m64ZAdFu7xmuwjeHE2zxhkmq5R2/gjZhl0tKwRDhZoIxmRMfAs
 lii8wyTOZoJA==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="490231164"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 03:23:29 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1lvdZ0-004Rr3-5f; Tue, 22 Jun 2021 13:23:26 +0300
Date:   Tue, 22 Jun 2021 13:23:26 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
Message-ID: <YNG6HtrNJjK7Hkhf@smile.fi.intel.com>
References: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net>
 <CAHp75Vd1gvsxFZamwp5FJDHVZsvq1S3eMBiJdu+ZD7StDoeGBw@mail.gmail.com>
 <YNGx4u79P8LXSkMk@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNGx4u79P8LXSkMk@pendragon.ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 22, 2021 at 12:48:18PM +0300, Laurent Pinchart wrote:
> On Tue, Jun 22, 2021 at 12:35:46PM +0300, Andy Shevchenko wrote:

> > Below bug report again reminds me about the "interesting" design of
> > some ACPI tables in the wild. See below for more.
> > 
> > On Sun, Jun 20, 2021 at 11:36 AM Dominik Brodowski wrote:
> > >
> > > Over a month ago, Andy Shevchenko reported and fixed a NULL pointer
> > > dereference issue introduced by commit
> > >         42e59982917a ("mfd: core: Add support for software nodes")
> > > in v5.13-rc1:
> > >         https://lore.kernel.org/lkml/20210510141552.57045-1-andriy.shevchenko@linux.intel.com/
> > >
> > > A bisect shows that it is indeed commit 42e59982917a which causes boot to
> > > fail due to a NULL pointer dereference on my work laptop, where "intel-lpss"
> > > is bound to
> > >         00:15.0 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 (rev 21)
> > > and fails to bind to INT3446:
> > >
> > > [    6.048087] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
> > > [    6.050625] idma64 idma64.0: Found Intel integrated DMA 64-bit
> > > [    6.109112] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
> > > [    6.111348] idma64 idma64.1: Found Intel integrated DMA 64-bit
> > > [    6.172229] intel-lpss 0000:00:15.2: enabling device (0000 -> 0002)
> > > [    6.174353] idma64 idma64.2: Found Intel integrated DMA 64-bit
> > > [    6.231865] intel-lpss 0000:00:15.3: enabling device (0000 -> 0002)
> > > [    6.233845] idma64 idma64.3: Found Intel integrated DMA 64-bit
> > 
> > > [    6.287492] ACPI Warning: SystemMemory range 0x00000000FE028000-0x00000000FE0281FF conflicts with OpRegion 0x00000000FE028000-0x00000000FE028207 (\_SB.PCI0.GEXP.BAR0) (20210331/utaddress-204)
> > > [    6.287704] ACPI: OSL: Resource conflict; ACPI support missing from driver?
> > > [    6.289760] intel-lpss: probe of INT3446:00 failed with error -16
> 
> For the people who haven't followed this, https://lore.kernel.org/linux-acpi/20210112113538.GF4077@smile.fi.intel.com/

Thanks!

> > Above lines appear due to the following:
> > 1. In hardware we have an I²C bus with GPIO I/O expander (PCA953x
> > compatible in all cases I saw so far).
> > 2. The ACPI table has a "real" driver for that expander written in ASL (sic!).
> > 3. Due to the above we have I²C controller resources and that driver
> > in a conflict, because the driver uses I²C controller registers
> > directly (sic!).
> > 
> > The questions for brainstorming the ideas here are:
> > 1. Is it possible to blacklist the Device Node from being evaluated /
> > parsed based on the ACPI DSDT path (the "real driver", of course,
> > doesn't have any other means to be enumerated properly)?
> > 2. Can we create the ACPI driver in the OS which will take the ACPI
> > path as ID for enumeration / instantiation?
> > 3. Is it possible to hook up on the methods, so we will know what to
> > do when a certain method is called (like setting pin direction or so)?
> > 4. Does above make any sense or we simply mark that hardware as broken
> > (i.e. Windoze-only bad desing) and that's it?
> 
> The first question we need to answer is whether there's an actual
> hardware conflict or not. Can the PCA953x be accessed by the ASL driver
> at any point, or do those accesses only occur at early boot time or at
> reboot time for instance ? If there's an actual risk of conflict at
> runtime, we need to find out how this was designed to work on Windows.

As long as there the only I²C slave is connected (AFAIK not always the case),
there is no conflict and we simply may hide the entire controller from the OS.

Otherwise it is easy to answer, yes, and this is one of the ugliest conflicts,
because the driver in ASL touches I²C controller registers directly (messing up
completely with what OS thinks the state of the registers is at any point of
time of the certain I²C controller).

> > > Unfortunately, the patch by Andy Shevchenko (applied on top of Linus' tree)
> > > does not fix the issue. A complete revert, however, does fix the issue, and
> > > allows my laptop to boot again.
> > >
> > > In my opinion, it is unfortunate that although it has been known for over a
> > > month that commit 42e59982917a is broken, the bugfix (though probably not
> > > far-reaching enough) has not yet progressed upstream.

-- 
With Best Regards,
Andy Shevchenko


