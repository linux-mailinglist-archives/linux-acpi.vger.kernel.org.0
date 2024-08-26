Return-Path: <linux-acpi+bounces-7823-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 734D495EDDA
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 11:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67B81C21596
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274C7146A69;
	Mon, 26 Aug 2024 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcoDXMO1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46C14659C;
	Mon, 26 Aug 2024 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666325; cv=none; b=IcQBsGrRWpA97cef2SbWUD5QVCeyOkZqjsdkHRsZQhhFZ17aCqA+tPw0wZ3HRp1spYDOFhENLSAC0QwFL9BoJQ75atYDpmSHo2SaJEFoykyHJwDd2ZbsGHvStRSQJukj7RX9/dGiJQPuUK8kKrF/mzDaC/0rdMdcJEYTU+dYcKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666325; c=relaxed/simple;
	bh=cfs1NTC0kOCerLyAMnm5595shMi+Z7RzTsRvt3/2wYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVItPb5nqvgMjyY9kyevOtt8AgKTnWUjmyOzAQFW3NJhpyxvoutdM1Fc1qnN5EVRAPyo+hTbyc/WHwbQiX8SMBKl9V58PRuSz6Ur/uGLrYsHW/3cCVOeVR4vIkkILO78CLXp0a+4kNnCDnGg/jc59DoeOuKvo6FYYqXErcoRk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcoDXMO1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724666324; x=1756202324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cfs1NTC0kOCerLyAMnm5595shMi+Z7RzTsRvt3/2wYY=;
  b=lcoDXMO13XbaCnJ/zdoKasV+YPCv+UMs6qeIqbsz2XjuDCCm2VxAtmCb
   S9+/TzGHJrlutLu4lkdTPDyxc+DidWz/7GEiwVxrfwZaGGblHoAy2WnId
   m/J3AYxJs5pvJHUFWybBO8tnUm5/7CkbxWgeaUyCVbP4At8dgQkZTgkAq
   +toASiY4cVJVVO1liTQPsQ0w29B5UFdYdx3BmbhvOKqfcMZmL/k/JJSQF
   UlUWPZrFwRUZ3vsoTfTDulaus24Jxky/dxPLG6eaXSQRZd6WBPdcLKTbX
   JrqdAMgRNI+V9X2jA23z4TFwG6OyjUU93irRagx3cLOWth7QAGF3mjIKo
   g==;
X-CSE-ConnectionGUID: dSnPZ6aKSS2Nk2/euVlvKw==
X-CSE-MsgGUID: xQjeMdg8R1eV9bNAV+S7WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="33644754"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="33644754"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:58:43 -0700
X-CSE-ConnectionGUID: 7CMsBR3YQ3+eOksdL8fgFw==
X-CSE-MsgGUID: c0vrIWrCTyecNL9XlIOepg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62979148"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:58:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1siWUY-00000001p9k-3ljv;
	Mon, 26 Aug 2024 12:58:30 +0300
Date: Mon, 26 Aug 2024 12:58:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Benson Leung <bleung@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Guenter Roeck <groeck@chromium.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Lee Jones <lee@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Daniel Scally <djrscally@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>, linux-acpi@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 16/17] platform/chrome: cros_ec_typec: Support DP
 muxing
Message-ID: <ZsxRxpyqsslvQFO2@smile.fi.intel.com>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-17-swboyd@chromium.org>
 <ZsdNEWX-eeLiokZl@tzungbi-laptop>
 <CAE-0n50Tuxp0WjFoTx+_i1L4cSOajSNHWPh32PPoXvskJByJJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n50Tuxp0WjFoTx+_i1L4cSOajSNHWPh32PPoXvskJByJJg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 23, 2024 at 01:44:41PM -0700, Stephen Boyd wrote:
> Quoting Tzung-Bi Shih (2024-08-22 07:37:05)
> > On Mon, Aug 19, 2024 at 03:38:30PM -0700, Stephen Boyd wrote:

...

> > > +     /*
> > > +      * Assume the first port to have HPD asserted is the one muxed to DP
> > > +      * (i.e. active_port). When there's only one port this delays setting
> > > +      * the active_port until HPD is asserted, but before that the
> > > +      * drm_connector looks disconnected so active_port doesn't need to be
> > > +      * set.
> > > +      */
> > > +     if (dp_bridge && hpd_asserted && !dp_bridge->active_port)
> > > +             dp_bridge->active_port = port;
> > > +
> > > +     is_active_port = !dp_bridge || dp_bridge->active_port == port;
> >
> > Why `!dp_bridge`?  When will `dp_bridge` be NULL?
> 
> I'll add a comment.
> 
> 'dp_bridge' is NULL when this driver is running on non-DT platforms,
> i.e. ACPI, or there isn't a graph/ports node for this device. The latter
> could happen if there's some AP controlled piece of hardware that is a
> typec switch, connected directly to a usb-c-connector. This is the case
> on Kukui where we send the DP lanes directly to the usb-c-connector.

Thanks!

-- 
With Best Regards,
Andy Shevchenko



