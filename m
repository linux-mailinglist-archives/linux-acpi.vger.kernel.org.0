Return-Path: <linux-acpi+bounces-1636-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6E77F1E0F
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 21:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346352813EA
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 20:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6C530334
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HojFHuvG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3E7C7;
	Mon, 20 Nov 2023 12:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700510631; x=1732046631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=t6Dv6YDHJcRv2aKl2S442OlbO9EGY0J3t7fr7FBbj60=;
  b=HojFHuvGKUnB6xUYc+sWWojvRdX0WB/i5ga3wuGkjpthVbygPhamx4p4
   X/yKdfb4OvAT0LwD0C+aJQX8qZQ0mEeALrzoXpsd854TZSL1L1/PmR0B/
   lBg+uFXPmAesnvWNKUKTZ8tpqWaZvpAW8/cm5mfJhQL/+VdDYl/1EFUhd
   +4K0bCMHtgVgWJ9d9CgcSbOYsX4ao+0zRxxCL9whlnIoycrYe/b7vFa74
   GbNmtI/kJHs+TIecxv0OtPZxHZKKcCkWHII6bbccUVXip3MhMFjK3Kb8E
   PVzcu2vu1MJEF5AzRoPKFbCk+9NTQ3rGsxhEJrjrf7q3NmtUwWp1ZYt0p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="390553412"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="390553412"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 12:03:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="766410842"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="766410842"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 12:03:23 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 2521F11FAE8;
	Mon, 20 Nov 2023 22:03:20 +0200 (EET)
Date: Mon, 20 Nov 2023 20:03:20 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH v2 3/7] ACPI: Documentation: Document acpi_dev_state_d0()
Message-ID: <ZVu7iMimov2c5QFM@kekkonen.localdomain>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-4-sakari.ailus@linux.intel.com>
 <20231118185049.GH20846@pendragon.ideasonboard.com>
 <ZVsnYjjWAiNPdHPG@kekkonen.localdomain>
 <CAJZ5v0h+tP1=PW4C44LCfyJcDXhcUQ4+BHPP9vBM19rtfqukWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h+tP1=PW4C44LCfyJcDXhcUQ4+BHPP9vBM19rtfqukWA@mail.gmail.com>

Hi Rafael,

On Mon, Nov 20, 2023 at 01:52:39PM +0100, Rafael J. Wysocki wrote:
> On Mon, Nov 20, 2023 at 10:31 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Laurent,
> >
> > On Sat, Nov 18, 2023 at 08:50:49PM +0200, Laurent Pinchart wrote:
> > > Hi Sakari,
> > >
> > > Thank you for the patch.
> > >
> > > On Fri, Nov 17, 2023 at 01:14:29PM +0200, Sakari Ailus wrote:
> > > > Document that acpi_dev_state_d0() can be used to tell if the device was
> > > > powered on for probe.
> > > >
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > ---
> > > >  Documentation/firmware-guide/acpi/non-d0-probe.rst | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/Documentation/firmware-guide/acpi/non-d0-probe.rst b/Documentation/firmware-guide/acpi/non-d0-probe.rst
> > > > index 7afd16701a02..815bcc8db69f 100644
> > > > --- a/Documentation/firmware-guide/acpi/non-d0-probe.rst
> > > > +++ b/Documentation/firmware-guide/acpi/non-d0-probe.rst
> > > > @@ -24,6 +24,14 @@ there's a problem with the device, the driver likely probes just fine but the
> > > >  first user will find out the device doesn't work, instead of a failure at probe
> > > >  time. This feature should thus be used sparingly.
> > > >
> > > > +ACPI framework
> > > > +--------------
> > > > +
> > > > +Use the Linux ACPI framework function :c:func:`acpi_dev_state_d0()` to tell
> > > > +whether the device was powered on for probe. :c:func:`acpi_dev_state_d0()`
> > > > +returns true if the device is powered on, false otherwise. For non-ACPI backed
> > > > +devices it returns true always.
> > > > +
> > >
> > > While this is true, I don't want to see drivers having to call
> > > ACPI-specific functions, the same way you dislike OF-specific functions
> > > in drivers. Please find a better way to handle this.
> >
> > The functionality is only available on ACPI and the function does the right
> > thing on non-ACPI platforms. I don't see an issue here.
> 
> The issue would be calling an ACPI-specific function from code that's
> otherwise firmware-agnostic, AFAICS.
> 
> It would be good to have a more generic way of checking whether or not
> a device is operational.

In DT case it's up to the driver to do that, so the device is powered off.

> 
> > Feel free to post DT binding patches on suggested device power state during
> > probe. :-) I think DT would benefit from this as well: the at24 driver is
> > widely used and suddenly making probe() not talk to the chip (or even power
> > it up) at all would probably be seen as a regression.
> 
> In the DT case it is more complicated, though, at least in general,
> because there may be multiple clocks and regulators the device depends
> on and you may need to toggle a GPIO line too.

I don't think it is as what's missing is the desired power state during
probe, i.e. whether or not the device will be powered on. It wasn't there
in ACPI either before it was added.

The problem is slightly lesser on DT though as it's up to the driver
whether or not to power on the device. In the example I gave above,
however, e.g. the at24 driver can't be modified to keep the device powered
off and at the same time expected people would remain content with it. So
this information should come from firmware.

-- 
Regards,

Sakari Ailus

