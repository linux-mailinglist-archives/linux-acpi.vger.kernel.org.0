Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFCB3B0243
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jun 2021 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhFVLGQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Jun 2021 07:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhFVLGQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jun 2021 07:06:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924FCC061574
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jun 2021 04:04:00 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F40ECA66;
        Tue, 22 Jun 2021 13:03:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1624359837;
        bh=Vt3SjINUJ43shdxxoEV9DCG43FF5144NW0rBS9Wz3FE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eNgucN3t9vVMs5a+DHva89T+i1+Se0l6il9PHsJAJ/b65sxlTiQbeeC973oHh1SSO
         Yl7hkFuWL4bg+zyeNSgqphDZvMGkDA8MVjkjRg3hLnNnEsXX3jV72WtAh13883seQu
         TJsjyHvVsXF8dEhq0CVYOInGe/SHLBuwiq0p9Bso=
Date:   Tue, 22 Jun 2021 14:03:27 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
Message-ID: <YNHDf3TJ0x/1qint@pendragon.ideasonboard.com>
References: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net>
 <CAHp75Vd1gvsxFZamwp5FJDHVZsvq1S3eMBiJdu+ZD7StDoeGBw@mail.gmail.com>
 <YNGx4u79P8LXSkMk@pendragon.ideasonboard.com>
 <YNG6HtrNJjK7Hkhf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNG6HtrNJjK7Hkhf@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 22, 2021 at 01:23:26PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 22, 2021 at 12:48:18PM +0300, Laurent Pinchart wrote:
> > On Tue, Jun 22, 2021 at 12:35:46PM +0300, Andy Shevchenko wrote:
> 
> > > Below bug report again reminds me about the "interesting" design of
> > > some ACPI tables in the wild. See below for more.
> > > 
> > > On Sun, Jun 20, 2021 at 11:36 AM Dominik Brodowski wrote:
> > > >
> > > > Over a month ago, Andy Shevchenko reported and fixed a NULL pointer
> > > > dereference issue introduced by commit
> > > >         42e59982917a ("mfd: core: Add support for software nodes")
> > > > in v5.13-rc1:
> > > >         https://lore.kernel.org/lkml/20210510141552.57045-1-andriy.shevchenko@linux.intel.com/
> > > >
> > > > A bisect shows that it is indeed commit 42e59982917a which causes boot to
> > > > fail due to a NULL pointer dereference on my work laptop, where "intel-lpss"
> > > > is bound to
> > > >         00:15.0 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 (rev 21)
> > > > and fails to bind to INT3446:
> > > >
> > > > [    6.048087] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
> > > > [    6.050625] idma64 idma64.0: Found Intel integrated DMA 64-bit
> > > > [    6.109112] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
> > > > [    6.111348] idma64 idma64.1: Found Intel integrated DMA 64-bit
> > > > [    6.172229] intel-lpss 0000:00:15.2: enabling device (0000 -> 0002)
> > > > [    6.174353] idma64 idma64.2: Found Intel integrated DMA 64-bit
> > > > [    6.231865] intel-lpss 0000:00:15.3: enabling device (0000 -> 0002)
> > > > [    6.233845] idma64 idma64.3: Found Intel integrated DMA 64-bit
> > > 
> > > > [    6.287492] ACPI Warning: SystemMemory range 0x00000000FE028000-0x00000000FE0281FF conflicts with OpRegion 0x00000000FE028000-0x00000000FE028207 (\_SB.PCI0.GEXP.BAR0) (20210331/utaddress-204)
> > > > [    6.287704] ACPI: OSL: Resource conflict; ACPI support missing from driver?
> > > > [    6.289760] intel-lpss: probe of INT3446:00 failed with error -16
> > 
> > For the people who haven't followed this, https://lore.kernel.org/linux-acpi/20210112113538.GF4077@smile.fi.intel.com/
> 
> Thanks!
> 
> > > Above lines appear due to the following:
> > > 1. In hardware we have an I²C bus with GPIO I/O expander (PCA953x
> > > compatible in all cases I saw so far).
> > > 2. The ACPI table has a "real" driver for that expander written in ASL (sic!).
> > > 3. Due to the above we have I²C controller resources and that driver
> > > in a conflict, because the driver uses I²C controller registers
> > > directly (sic!).
> > > 
> > > The questions for brainstorming the ideas here are:
> > > 1. Is it possible to blacklist the Device Node from being evaluated /
> > > parsed based on the ACPI DSDT path (the "real driver", of course,
> > > doesn't have any other means to be enumerated properly)?
> > > 2. Can we create the ACPI driver in the OS which will take the ACPI
> > > path as ID for enumeration / instantiation?
> > > 3. Is it possible to hook up on the methods, so we will know what to
> > > do when a certain method is called (like setting pin direction or so)?
> > > 4. Does above make any sense or we simply mark that hardware as broken
> > > (i.e. Windoze-only bad desing) and that's it?
> > 
> > The first question we need to answer is whether there's an actual
> > hardware conflict or not. Can the PCA953x be accessed by the ASL driver
> > at any point, or do those accesses only occur at early boot time or at
> > reboot time for instance ? If there's an actual risk of conflict at
> > runtime, we need to find out how this was designed to work on Windows.
> 
> As long as there the only I²C slave is connected (AFAIK not always the case),
> there is no conflict and we simply may hide the entire controller from the OS.

Many machines have other I2C devices on the same bus. This is the case
of the Skylake- and Kabylake-based machines with CSI-2 camera sensors
designed for Windows (The Surface Go 2 is an example). We need to ensure
there won't be a regression for users of those machines (they currently
set acpi_enforce_resources=lax).

> > > > Unfortunately, the patch by Andy Shevchenko (applied on top of Linus' tree)
> 
> Otherwise it is easy to answer, yes, and this is one of the ugliest conflicts,
> because the driver in ASL touches I²C controller registers directly (messing up
> completely with what OS thinks the state of the registers is at any point of
> time of the certain I²C controller).

Sure, but this depends on whether the conflict can actually occur in
practice. If the ASL I2C driver is only used at early boot time or
reboot time, at times when no I2C traffic can be initiated from Linux,
then we're safe.

If a conflict can actually occur, we have to figure out how this was
designed to work. One option I've been thinking about is to trap
accesses to the I2C controller by the ASL driver (by remapping the BAR
?) and emulate the I2C controller behaviour with proper arbitration.
It's ugly, will require lots of work, please feel free to blame whoever
designed thus at Intel :-)

> > > > does not fix the issue. A complete revert, however, does fix the issue, and
> > > > allows my laptop to boot again.
> > > >
> > > > In my opinion, it is unfortunate that although it has been known for over a
> > > > month that commit 42e59982917a is broken, the bugfix (though probably not
> > > > far-reaching enough) has not yet progressed upstream.

-- 
Regards,

Laurent Pinchart
