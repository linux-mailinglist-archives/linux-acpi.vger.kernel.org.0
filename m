Return-Path: <linux-acpi+bounces-15051-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76164AFBD09
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 23:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223291BC0EBC
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 21:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153A281520;
	Mon,  7 Jul 2025 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghZyrLLN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B37219300;
	Mon,  7 Jul 2025 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751922125; cv=none; b=O37Ktoy5jd4vz5dFxcqgxScMXg1X7EH7DdvEMH8+fTVx6KzqwpESRaSorGAqCswOsxwQE3Ek0X2gedC5KzL7/dIhXhIlH52P4jNH90BY+pX3IZKitNc6A/ookGJnLiTyrqkMkc3BS9DD7VbpSx8QVnfV3io9QFnJxJ/AafefNNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751922125; c=relaxed/simple;
	bh=/snNK1gcGR4AUFDaQtgHQLqOJK90XFRCeKSSseXe54g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8CebZ7//EtQ/TCoAvH+oxo1Pqw8dm4wRgC/sKjaNMnWtVaVoVHu5iPLHuhv7qdPiFFmO7qSyA2gyO4AhTstEyu9ja5ykEhSS7i8+SZSyRyUojevjpE2kjO6taFN3oUYxedjtQJ7d/QpQLTCbWWVJioXe1UMy+yoVGKRMlC06ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghZyrLLN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751922124; x=1783458124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/snNK1gcGR4AUFDaQtgHQLqOJK90XFRCeKSSseXe54g=;
  b=ghZyrLLNOXhWvURnB2CjpgooeOtg/nGaOmDtqj0iQDrc7BduNn7AcDcK
   8OuEBy6vKOw3mGdLHdKDd9BS2rtBz0uPEm8NTe6iU0AtJRCMe5aFXt8Ql
   xOwsTjpSnnvRwVhkCCljsHb82ia7Jm0YvHwL5e134932IckmaqmD5GmHx
   A/B+Tir/R/FHJ7knfY1Zh9zTyAyCt83tO4prneX+HbAOuTgARiFMAaZXu
   oGBVcq1j7wbdSiazV1NhREdu5Zytnr9rm84bQw2hyPxHSO6EL54L2yVTS
   EmcgxUnxHvjVVJNdrlRqbbRg/gkwXK5+MYR1A1ceZXbNFcRbE1Yxf5R61
   Q==;
X-CSE-ConnectionGUID: k5NHlYMoSgKAcHBAoZxsCQ==
X-CSE-MsgGUID: vd6lTJrrSli9eMbMhGa3sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65215279"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="65215279"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 14:02:02 -0700
X-CSE-ConnectionGUID: sAQ9d22YRBaRzIbrKBCasA==
X-CSE-MsgGUID: OzwtYBTaRoG6tjhUhOaR9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="154733864"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.166])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 14:01:57 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5AD1F11FC1A;
	Tue,  8 Jul 2025 00:01:54 +0300 (EEST)
Date: Mon, 7 Jul 2025 21:01:54 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 02/12] media: v4l: fwnode: Support ACPI's _PLD for
 v4l2_fwnode_device_parse
Message-ID: <aGw1wo3lUCJtzLiZ@kekkonen.localdomain>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-2-5710f9d030aa@chromium.org>
 <1ac49bd3-1b65-4611-8c90-92fb2c2ffd4a@linux.intel.com>
 <CANiDSCuRLVtT54ZxxAh6031OLg422VApsocvOTCOnavQgifTaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCuRLVtT54ZxxAh6031OLg422VApsocvOTCOnavQgifTaA@mail.gmail.com>

Hi Ricardo,

On Tue, Jul 01, 2025 at 11:04:25AM +0200, Ricardo Ribalda wrote:
> Hi Sakari
> 
> Thanks for your review!
> 
> On Mon, 30 Jun 2025 at 09:06, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Ricardo,
> >
> > Thanks for the update.
> >
> > On 6/5/25 20:52, Ricardo Ribalda wrote:
> > > Currently v4l2_fwnode_device_parse() obtains the orientation and
> > > rotation via fwnode properties.
> > >
> > > Extend the function to support as well ACPI devices with _PLD info.
> > >
> > > We give a higher priority to fwnode, because it might contain quirks
> > > injected via swnodes.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >   drivers/media/v4l2-core/v4l2-fwnode.c | 85 ++++++++++++++++++++++++++++++++---
> > >   1 file changed, 79 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> > > index cb153ce42c45d69600a3ec4e59a5584d7e791a2a..379290ab3cfde74c8f663d61837a9a95011b5ae0 100644
> > > --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> > > +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> > > @@ -15,6 +15,7 @@
> > >    * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > >    */
> > >   #include <linux/acpi.h>
> > > +#include <acpi/acpi_bus.h>
> > >   #include <linux/kernel.h>
> > >   #include <linux/mm.h>
> > >   #include <linux/module.h>
> > > @@ -807,16 +808,65 @@ int v4l2_fwnode_connector_add_link(struct fwnode_handle *fwnode,
> > >   }
> > >   EXPORT_SYMBOL_GPL(v4l2_fwnode_connector_add_link);
> > >
> > > -int v4l2_fwnode_device_parse(struct device *dev,
> > > -                          struct v4l2_fwnode_device_properties *props)
> > > +static int v4l2_fwnode_device_parse_acpi(struct device *dev,
> > > +                                      struct v4l2_fwnode_device_properties *props)
> > > +{
> > > +     struct acpi_pld_info *pld;
> > > +     int ret = 0;
> > > +
> > > +     if (!is_acpi_device_node(dev_fwnode(dev)))
> > > +             return 0;
> > > +
> > > +     if (!acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld)) {
> > > +             dev_dbg(dev, "acpi _PLD call failed\n");
> >
> > I'd do:
> >
> > acpi_handle_debug(ACPI_HANDLE(dev), "cannot obtain _PLD\n");
> ack
> >
> > > +             return 0;
> > > +     }
> > > +
> > > +     if (props->orientation != V4L2_FWNODE_PROPERTY_UNSET) {
> > > +             switch (pld->panel) {
> > > +             case ACPI_PLD_PANEL_FRONT:
> > > +                     props->orientation = V4L2_FWNODE_ORIENTATION_FRONT;
> > > +                     break;
> > > +             case ACPI_PLD_PANEL_BACK:
> > > +                     props->orientation = V4L2_FWNODE_ORIENTATION_BACK;
> > > +                     break;
> > > +             case ACPI_PLD_PANEL_TOP:
> > > +             case ACPI_PLD_PANEL_LEFT:
> > > +             case ACPI_PLD_PANEL_RIGHT:
> > > +             case ACPI_PLD_PANEL_UNKNOWN:
> > > +                     props->orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
> > > +                     break;
> > > +             default:
> > > +                     dev_dbg(dev, "Unknown _PLD panel val %d\n", pld->panel);
> >
> > Similarly:
> >
> > acpi_handle_debug(ACPI_HANDLE(dev), "invalid panel %u in _PLD\n",
> >                   pld->panel);
> >
> > > +                     ret = -EINVAL;
> >
> > Should this be an error or should we simply ignore it here (and maybe
> > use acpi_handle_warn())?
> 
> v4l2_fwnode_device_parse_of() returns -EINVAL for a similar situation,
> so I think it is better to be consistent and return -EINVAL here.
> But I agree that acpi_handle_warn() better suits here than _dbg.

Ack.

> 
> >
> > > +                     goto done;
> > > +             }
> > > +     }
> > > +
> > > +     if (props->rotation != V4L2_FWNODE_PROPERTY_UNSET) {
> > > +             switch (pld->rotation) {
> > > +             case 0 ... 7:
> > > +                     props->rotation = pld->rotation * 45;
> > > +                     break;
> > > +             default:
> > > +                     dev_dbg(dev, "Unknown _PLD rotation val %d\n", pld->panel);
> >
> > acpi_handle_debug(ACPI_HANDLE(dev), "invalid rotation %u in _PLD\n",
> >                   pld->rotation);
> >
> > > +                     ret = -EINVAL;
> > > +                     goto done;
> > > +             }
> > > +     }
> > > +
> > > +done:
> > > +     ACPI_FREE(pld);
> > > +     return ret;
> > > +}
> > > +
> > > +static int v4l2_fwnode_device_parse_dt(struct device *dev,
> >
> > I'd call this v4l2_fwnode_device_parse_of() as we're parsing OF nodes
> > and properties here.
> ack
> >
> > > +                                    struct v4l2_fwnode_device_properties *props)
> > >   {
> > >       struct fwnode_handle *fwnode = dev_fwnode(dev);
> > >       u32 val;
> > >       int ret;
> > >
> > > -     memset(props, 0, sizeof(*props));
> > > -
> > > -     props->orientation = V4L2_FWNODE_PROPERTY_UNSET;
> > >       ret = fwnode_property_read_u32(fwnode, "orientation", &val);
> > >       if (!ret) {
> > >               switch (val) {
> > > @@ -833,7 +883,6 @@ int v4l2_fwnode_device_parse(struct device *dev,
> > >               dev_dbg(dev, "device orientation: %u\n", val);
> > >       }
> > >
> > > -     props->rotation = V4L2_FWNODE_PROPERTY_UNSET;
> > >       ret = fwnode_property_read_u32(fwnode, "rotation", &val);
> > >       if (!ret) {
> > >               if (val >= 360) {
> > > @@ -847,6 +896,30 @@ int v4l2_fwnode_device_parse(struct device *dev,
> > >
> > >       return 0;
> > >   }
> > > +
> > > +int v4l2_fwnode_device_parse(struct device *dev,
> > > +                          struct v4l2_fwnode_device_properties *props)
> > > +{
> > > +     int ret;
> > > +
> > > +     memset(props, 0, sizeof(*props));
> > > +
> > > +     props->orientation = V4L2_FWNODE_PROPERTY_UNSET;
> > > +     props->rotation = V4L2_FWNODE_PROPERTY_UNSET;
> > > +
> > > +     /* Start by looking into swnodes and dt. */

s/dt/DT/

> > > +     ret =  v4l2_fwnode_device_parse_dt(dev, props);

		 ^

Extra space.

> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     /* Orientation and rotation found!, we are ready. */
> > > +     if (props->orientation != V4L2_FWNODE_PROPERTY_UNSET &&
> > > +         props->rotation != V4L2_FWNODE_PROPERTY_UNSET)
> > > +             return 0;
> >
> > I think you can remove this check without affecting the functionality.
> I want to avoid calling an acpi method unless it is strictly
> necessary. The check is not that ugly... if it is ok with you i'd
> rather keep it.

The function is already checking the node is an ACPI node and returns 0
otherwise. The above is simply redundant.

> 
> >
> > > +
> > > +     /* Let's check the acpi table. */

s/acpi/ACPI/

> > > +     return v4l2_fwnode_device_parse_acpi(dev, props);
> > > +}
> > >   EXPORT_SYMBOL_GPL(v4l2_fwnode_device_parse);
> > >
> > >   /*
> > >

-- 
Regards,

Sakari Ailus

