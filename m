Return-Path: <linux-acpi+bounces-1638-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1457F2072
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 23:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0DB1C20A02
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594013A28F
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMZjJkdE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1818FCF;
	Mon, 20 Nov 2023 12:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700513591; x=1732049591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UDP0bVzD9bCOj+XxHq64z11eSV98vr4id9q9PwdgYhE=;
  b=iMZjJkdEDuyYm1r0NGIR+H26ML4T82mRmfoWk6OuxIMGkwflhp5vckdr
   bUnedjx28wr17IEuf5LkC7EW3CzB0DepXV8k1QfKSHKaE7U9+pgwxXAua
   mR7XJDqQwSMhUYqk8hfRW9gIzl+z883IcfnIWonN+Eli0Qq0dNU04aLy3
   1XckGrNuj6aLqthih4hmGKbWxRoNpj/MlqOTXujo5R4ojryAO5M6fcaYm
   zup7ASf6ejayL77yShFYf9VzolYSTQUAWLaCma28LCNfqJsU9vF7i7PIL
   aIzgfLNw82xxI66HGs4Y3iItYTyDYDNzIINhj5K2BlNtSA9poO/6zLoXD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="456040996"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="456040996"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 12:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="832394115"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="832394115"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 12:53:08 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 4C4EF11FAC4;
	Mon, 20 Nov 2023 22:53:06 +0200 (EET)
Date: Mon, 20 Nov 2023 20:53:06 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	jacopo.mondi@ideasonboard.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/7] ACPI: Documentation: Document acpi_dev_state_d0()
Message-ID: <ZVvHMhAuV76GjNZE@kekkonen.localdomain>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
 <20231117111433.1561669-4-sakari.ailus@linux.intel.com>
 <20231118185049.GH20846@pendragon.ideasonboard.com>
 <ZVsnYjjWAiNPdHPG@kekkonen.localdomain>
 <CAJZ5v0h+tP1=PW4C44LCfyJcDXhcUQ4+BHPP9vBM19rtfqukWA@mail.gmail.com>
 <ZVu7iMimov2c5QFM@kekkonen.localdomain>
 <CAJZ5v0iB5cRbDJGxOQeFW_r_jbKv70OgFPpQ-_5c38FJwQGOpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iB5cRbDJGxOQeFW_r_jbKv70OgFPpQ-_5c38FJwQGOpw@mail.gmail.com>

Hi Rafael,

On Mon, Nov 20, 2023 at 09:22:53PM +0100, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Mon, Nov 20, 2023 at 9:03 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Mon, Nov 20, 2023 at 01:52:39PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Nov 20, 2023 at 10:31 AM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Hi Laurent,
> > > >
> > > > On Sat, Nov 18, 2023 at 08:50:49PM +0200, Laurent Pinchart wrote:
> > > > > Hi Sakari,
> > > > >
> > > > > Thank you for the patch.
> > > > >
> > > > > On Fri, Nov 17, 2023 at 01:14:29PM +0200, Sakari Ailus wrote:
> > > > > > Document that acpi_dev_state_d0() can be used to tell if the device was
> > > > > > powered on for probe.
> > > > > >
> > > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > > ---
> > > > > >  Documentation/firmware-guide/acpi/non-d0-probe.rst | 8 ++++++++
> > > > > >  1 file changed, 8 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/firmware-guide/acpi/non-d0-probe.rst b/Documentation/firmware-guide/acpi/non-d0-probe.rst
> > > > > > index 7afd16701a02..815bcc8db69f 100644
> > > > > > --- a/Documentation/firmware-guide/acpi/non-d0-probe.rst
> > > > > > +++ b/Documentation/firmware-guide/acpi/non-d0-probe.rst
> > > > > > @@ -24,6 +24,14 @@ there's a problem with the device, the driver likely probes just fine but the
> > > > > >  first user will find out the device doesn't work, instead of a failure at probe
> > > > > >  time. This feature should thus be used sparingly.
> > > > > >
> > > > > > +ACPI framework
> > > > > > +--------------
> > > > > > +
> > > > > > +Use the Linux ACPI framework function :c:func:`acpi_dev_state_d0()` to tell
> > > > > > +whether the device was powered on for probe. :c:func:`acpi_dev_state_d0()`
> > > > > > +returns true if the device is powered on, false otherwise. For non-ACPI backed
> > > > > > +devices it returns true always.
> > > > > > +
> > > > >
> > > > > While this is true, I don't want to see drivers having to call
> > > > > ACPI-specific functions, the same way you dislike OF-specific functions
> > > > > in drivers. Please find a better way to handle this.
> > > >
> > > > The functionality is only available on ACPI and the function does the right
> > > > thing on non-ACPI platforms. I don't see an issue here.
> > >
> > > The issue would be calling an ACPI-specific function from code that's
> > > otherwise firmware-agnostic, AFAICS.
> > >
> > > It would be good to have a more generic way of checking whether or not
> > > a device is operational.
> >
> > In DT case it's up to the driver to do that, so the device is powered off.
> 
> Unless the boot loader (or whatever happens to run before the kernel)
> turns it on for some reason (whatever that may be).

There are probably some exceptions but they should be quite rare.

If the boot loader already powered on the device, then it'd be no use
avoiding accessing it. That doesn't mean the rest of the device shouldn't
be accessed though.

> 
> I guess the original point has been that in the ACPI case the generic
> enumeration code may power up the device if not instructed otherwise
> by the platform firmware, whereas in the DT case this is entirely up
> to the driver, but I'm not sure if this really matters.
> 
> I would suggest adding a generic wrapper around acpi_dev_state_d0()
> that will just always return true in the DT case, something like
> device_is_accessible() or device_is_operational(), that can be invoked
> from generic code without any visible ACPI connotations.

The DT case may need a different API for that: telling whether the device
should be powered on for probe (by the driver) rather what
acpi_dev_state_d0() does.

And on ACPI we've only needed this for I²C but likely I3C will follow. It
appears to be lacking ACPI support at the moment.

-- 
Regards,

Sakari Ailus

