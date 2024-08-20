Return-Path: <linux-acpi+bounces-7731-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FD1958D66
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 19:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37330B25065
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E01BDA9A;
	Tue, 20 Aug 2024 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fP7ZExoU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DDE4085D;
	Tue, 20 Aug 2024 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174999; cv=none; b=hqLqIIT/452//+nD2t0UuUzivUfkI3e7z4WhdByyh9dSPIlzfQb8Sb8aepitjstSxw4FrjT4/BEuK9m++CKGiF7jKh/Nk+eQo10muJ6K0hp7NfYbAZi9WK2ujM8ellDiOZhqS4DNeT608y0T0MptqW9XCA0Bgv1lOXxXeKFol1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174999; c=relaxed/simple;
	bh=68ac7DKsySDSgzwlWvjjo7DcbuWc1QcmM244nl8RMHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMGfQGzWWVp4582Y56cpv/Jv1ZRamdyvsEfwHxxpl4/DPvb9sHAELGGXJzqBRd73sCREu0am/2kaVw04SULTBXK8kUEIduXR9dg6IfZs8+t59vTf1f8TEgVK77q/N0l6AjxpjClSwv2XIn9I+cOb37yc4qGTqDm0fNlqUkIO9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fP7ZExoU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724174998; x=1755710998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=68ac7DKsySDSgzwlWvjjo7DcbuWc1QcmM244nl8RMHI=;
  b=fP7ZExoU4NM9wNEFx8SlEzHFwR9PiyTlwv8d52jM4oboH4y81+vUndbx
   GMt0/7M/PXofXPV5Q+4ghX6qajBkNQ47CMuEE9loPFE5vBl6aikKa/WHa
   cF+Xd6gW2HUIJmQ+Aw6xIL0byos4knquImObCU0GIW+ZPn6JfvJGdMPV0
   7pgfdJIKMgTjT1LMleBDQrkTGQ4Ptu6sUnRs2H7wKCZm0iW6G/+s73P75
   zw1VEP3qzJwV1BTL0JtEIckPwBZv0ZFXvYDp23r4VHkLpZ/ANDa3i4zBY
   wchgDR/zytQLr3cFBBqXAC50g8clxbzo5YHhglOHywKi9QyAC5GHaW30e
   Q==;
X-CSE-ConnectionGUID: Z/8JxYtJTJSuOWevOWOOjQ==
X-CSE-MsgGUID: 8bXQAYRxQ7SRQx9iHKexPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22659874"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22659874"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 10:29:53 -0700
X-CSE-ConnectionGUID: 3e5GmarEQFm3vY766fVtDA==
X-CSE-MsgGUID: ZExBMhs5Sp2n9ruAFUwKYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="83996247"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 10:29:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgSft-0000000HOIY-3G5R;
	Tue, 20 Aug 2024 20:29:41 +0300
Date: Tue, 20 Aug 2024 20:29:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, devicetree@vger.kernel.org,
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
	Tzung-Bi Shih <tzungbi@kernel.org>,
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
Subject: Re: [PATCH v3 02/17] drm/bridge: Verify lane assignment is going to
 work during atomic_check
Message-ID: <ZsTShZnD-NbZqGio@smile.fi.intel.com>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-3-swboyd@chromium.org>
 <ZsRrWfoPPVGC4Dqy@smile.fi.intel.com>
 <CAE-0n536OWtoOoRSM=6u=wA75A+0WtBktiY=6Y6VjKKTQWPcNw@mail.gmail.com>
 <ZsTPuvoTIFVFHw6o@smile.fi.intel.com>
 <CAE-0n50xcj21WiPHW9ATE7BfxKpOWvdV7of97G_U5ZrMV0zUUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n50xcj21WiPHW9ATE7BfxKpOWvdV7of97G_U5ZrMV0zUUw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 20, 2024 at 10:24:47AM -0700, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2024-08-20 10:17:46)
> > On Tue, Aug 20, 2024 at 10:12:55AM -0700, Stephen Boyd wrote:
> > > Quoting Andy Shevchenko (2024-08-20 03:09:29)
> > > > On Mon, Aug 19, 2024 at 03:38:16PM -0700, Stephen Boyd wrote:

...

> > > > > +     /*
> > > > > +      * Ensure this bridge is aware that the next bridge wants to
> > > > > +      * reassign lanes.
> > > > > +      */
> > > > > +     for (i = 0; i < num_input_lanes; i++)
> > > > > +             if (i != input_lanes[i].logical && !num_output_lanes)
> > > > > +                     return -ENOTSUPP;
> > > >
> > > > Besides missing {} this code is internal to the Linux kernel. Is it okay?
> > >
> > > ENOTSUPP is used by select_bus_fmt_recursive() so I simply followed that
> > > style.
> >
> > Okay, just be aware of that side effect of that code, also checkpatch may
> > complain (however it might be false positive).
> 
> Yes checkpatch complained but didn't enlighten me. Please tell me the
> side effect as I'm unaware!

I already told you above, if this code ever appears in user space it will be
printed as a number and very much confuse the user!

That's why usage of this code either has to be documented or be subsystem
_known_ practice (GPIO library comes to my mind as it uses it internally,\
but filters for user space).

-- 
With Best Regards,
Andy Shevchenko



