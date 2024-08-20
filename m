Return-Path: <linux-acpi+bounces-7706-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5279583B2
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 12:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B59C1C20D02
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 10:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA8618C917;
	Tue, 20 Aug 2024 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grkfMJ+n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9AB18A957;
	Tue, 20 Aug 2024 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148582; cv=none; b=a5Op2KS1JmbvaBM/9frz09kSIgIsLXXCqvYeDH5qM60u2fVXVV0xDM77sewQvyhyNdvPWs0gGM3hujw/+JWOMbvQW7iNrCdHQb5QswfhsbcbvrZ6W1LiMbEklxA+lbwswtqy3ivoKaYz059h0Ih2ke5HPRI2uEWu9j5fmEt+dhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148582; c=relaxed/simple;
	bh=3tVTMBl8GkEdITq3AfFty1yHWAX+Rf+21JgHphAFdlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz0HpEofvt6YgUw+9sbN23or69JosojFwzi98YL0/u5f7sLnsU4dsNF3TbArIGIJst0i1aD+lboSM5GK+4CSy9Ua4sGNK2UdW7zW13f2EBwrrFov5qOIJXsB8O6eF6OEpBZTjHrKEKwnw+USuGGJH1T80nqkYSF0DEsAb2CiXkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grkfMJ+n; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724148581; x=1755684581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3tVTMBl8GkEdITq3AfFty1yHWAX+Rf+21JgHphAFdlY=;
  b=grkfMJ+n6kEMEHJVyEhqiFYtMqXkMM9G+o/Nq+F7IOu/LILISKevyz4j
   NuEaS9Bo9IzfJroHXr2EDymnZeNHyD3hSjdCWDBaPMv/GYOPxFaenYBRc
   RvAjNdybh4/r4kYgZLUTTpYWDKVDF7rtnvCUwZzoe0ihwWB4eF6yqPkcI
   oFwNvdVYC+d4kbWu/XccT9/9kttSI9/Y/qlA47zlHYV5F+LpE1F7i0SKw
   97gr++Qjzz7da1bYNeT28hNw4pNW1mRMiBJr3SGNNXKXuKZvMFeIAE+ZV
   aOJ35Sb1DQB9seU1q4N2Fr5ltQpSHE4whvE2qnoTSW9yotpiQPbXmUnBa
   A==;
X-CSE-ConnectionGUID: dePjUSGKRR+D6WxrasWAtw==
X-CSE-MsgGUID: XaHSV8ijTP2VSgf0G7Frjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="39942824"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="39942824"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:09:40 -0700
X-CSE-ConnectionGUID: CmRgePgTRQ+WeEPu8CBnhw==
X-CSE-MsgGUID: vcfqOtI4S6mOAnzISwJg/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="83887188"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:09:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgLnt-0000000HG4x-1BmJ;
	Tue, 20 Aug 2024 13:09:29 +0300
Date: Tue, 20 Aug 2024 13:09:29 +0300
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
Message-ID: <ZsRrWfoPPVGC4Dqy@smile.fi.intel.com>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-3-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819223834.2049862-3-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 19, 2024 at 03:38:16PM -0700, Stephen Boyd wrote:
> Verify during drm_atomic_bridge_check() that the lane assignment set in
> a bridge's atomic_check() callback is going to be satisfied by the
> previous bridge. If the next bridge is requiring something besides the
> default 1:1 lane assignment on its input then there must be an output
> lane assignment on the previous bridge's output. Otherwise the next
> bridge won't get the lanes assigned that it needs.

> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: <dri-devel@lists.freedesktop.org>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Yeah, I really think that the appearance of this thousandth time in the Git
history has almost no value and just pollutes the commit message makes it not
very well readable. The only outcome is exercising the compression algo used
by Git.

...

> +	int i;

unsigned?

...

> +	/*
> +	 * Ensure this bridge is aware that the next bridge wants to
> +	 * reassign lanes.
> +	 */
> +	for (i = 0; i < num_input_lanes; i++)
> +		if (i != input_lanes[i].logical && !num_output_lanes)
> +			return -ENOTSUPP;

Besides missing {} this code is internal to the Linux kernel. Is it okay?

-- 
With Best Regards,
Andy Shevchenko



