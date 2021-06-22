Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FEC3B00BD
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jun 2021 11:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFVJvE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Jun 2021 05:51:04 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39658 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFVJvD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jun 2021 05:51:03 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 05F24AD6;
        Tue, 22 Jun 2021 11:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1624355327;
        bh=ewP/hv/i+hCXkzO1ohg5IBEdxB9lVGxK41dXRaUGVn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AKQNM6RRnhQpseB9zFwHtDpEq35I2ZbAIp1e4t4MRMQsM35snOJbGpu1kPY2l3AZW
         7Au2Lr1OSTJY7U1pdzDv5g6T1ysJ5Q5179EqbSKyxMa0TMa9SuIXfFykUCugzFqadj
         0mjzyKTveunuIpWh25iZaP0cSftr/2mLwObJh/xI=
Date:   Tue, 22 Jun 2021 12:48:18 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
Message-ID: <YNGx4u79P8LXSkMk@pendragon.ideasonboard.com>
References: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net>
 <CAHp75Vd1gvsxFZamwp5FJDHVZsvq1S3eMBiJdu+ZD7StDoeGBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd1gvsxFZamwp5FJDHVZsvq1S3eMBiJdu+ZD7StDoeGBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Tue, Jun 22, 2021 at 12:35:46PM +0300, Andy Shevchenko wrote:
> -Lee, Hekki
> +Hans de Goede, Rafael, Laurent, Sakari
> 
> Below bug report again reminds me about the "interesting" design of
> some ACPI tables in the wild. See below for more.
> 
> On Sun, Jun 20, 2021 at 11:36 AM Dominik Brodowski wrote:
> >
> > Over a month ago, Andy Shevchenko reported and fixed a NULL pointer
> > dereference issue introduced by commit
> >         42e59982917a ("mfd: core: Add support for software nodes")
> > in v5.13-rc1:
> >         https://lore.kernel.org/lkml/20210510141552.57045-1-andriy.shevchenko@linux.intel.com/
> >
> > A bisect shows that it is indeed commit 42e59982917a which causes boot to
> > fail due to a NULL pointer dereference on my work laptop, where "intel-lpss"
> > is bound to
> >         00:15.0 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 (rev 21)
> > and fails to bind to INT3446:
> >
> > [    6.048087] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
> > [    6.050625] idma64 idma64.0: Found Intel integrated DMA 64-bit
> > [    6.109112] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
> > [    6.111348] idma64 idma64.1: Found Intel integrated DMA 64-bit
> > [    6.172229] intel-lpss 0000:00:15.2: enabling device (0000 -> 0002)
> > [    6.174353] idma64 idma64.2: Found Intel integrated DMA 64-bit
> > [    6.231865] intel-lpss 0000:00:15.3: enabling device (0000 -> 0002)
> > [    6.233845] idma64 idma64.3: Found Intel integrated DMA 64-bit
> 
> > [    6.287492] ACPI Warning: SystemMemory range 0x00000000FE028000-0x00000000FE0281FF conflicts with OpRegion 0x00000000FE028000-0x00000000FE028207 (\_SB.PCI0.GEXP.BAR0) (20210331/utaddress-204)
> > [    6.287704] ACPI: OSL: Resource conflict; ACPI support missing from driver?
> > [    6.289760] intel-lpss: probe of INT3446:00 failed with error -16

For the people who haven't followed this, https://lore.kernel.org/linux-acpi/20210112113538.GF4077@smile.fi.intel.com/

> Above lines appear due to the following:
> 1. In hardware we have an I²C bus with GPIO I/O expander (PCA953x
> compatible in all cases I saw so far).
> 2. The ACPI table has a "real" driver for that expander written in ASL (sic!).
> 3. Due to the above we have I²C controller resources and that driver
> in a conflict, because the driver uses I²C controller registers
> directly (sic!).
> 
> The questions for brainstorming the ideas here are:
> 1. Is it possible to blacklist the Device Node from being evaluated /
> parsed based on the ACPI DSDT path (the "real driver", of course,
> doesn't have any other means to be enumerated properly)?
> 2. Can we create the ACPI driver in the OS which will take the ACPI
> path as ID for enumeration / instantiation?
> 3. Is it possible to hook up on the methods, so we will know what to
> do when a certain method is called (like setting pin direction or so)?
> 4. Does above make any sense or we simply mark that hardware as broken
> (i.e. Windoze-only bad desing) and that's it?

The first question we need to answer is whether there's an actual
hardware conflict or not. Can the PCA953x be accessed by the ASL driver
at any point, or do those accesses only occur at early boot time or at
reboot time for instance ? If there's an actual risk of conflict at
runtime, we need to find out how this was designed to work on Windows.

> > Unfortunately, the patch by Andy Shevchenko (applied on top of Linus' tree)
> > does not fix the issue. A complete revert, however, does fix the issue, and
> > allows my laptop to boot again.
> >
> > In my opinion, it is unfortunate that although it has been known for over a
> > month that commit 42e59982917a is broken, the bugfix (though probably not
> > far-reaching enough) has not yet progressed upstream.

-- 
Regards,

Laurent Pinchart
