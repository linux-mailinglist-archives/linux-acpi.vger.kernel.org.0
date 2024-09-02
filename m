Return-Path: <linux-acpi+bounces-8080-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0858E968600
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 13:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE9C28244A
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0863187332;
	Mon,  2 Sep 2024 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDZ85pGO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A0413AD33;
	Mon,  2 Sep 2024 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275845; cv=none; b=QGpFjZJdO3GnOh+V3d2mnqaegZzpnF3vEn9qY0yJF76M5BDqlMaI5lS9cqMarXVq77G+vKY7IR7rxMw4HU1iSw4V+rC8dCRU6FOGsHeih2hIzopLn0pQnf+BryV3LXdcmHaHpdpDWDmaKcOVUO6JPxAQhtUEIAthKZk8KsjQbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275845; c=relaxed/simple;
	bh=8DEefCqgBp4T3qc8isMYaNfkFHMDF7RpRIonm0LXhyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQwkKSImvvdLsxxK0Iqe27ffOxTTRmrPgf8P33+UesV3c/ZnQRQE6YSbSNGRq7EM1203nFL2EizXGoXHrVEQZKdS7gEm2M09lVAOpEooqEAFjkP0IbkG/jXv8AMxGpAtN6DtXi+zQWg33JoC33tRhaPTP7dDrKhpVsiL3kaCFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDZ85pGO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725275845; x=1756811845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8DEefCqgBp4T3qc8isMYaNfkFHMDF7RpRIonm0LXhyE=;
  b=SDZ85pGOLYcT8HuSVRqim9TsEns9m1vQ1tM4mJNoV7y6A2BdNZIG5RKL
   cmmb23fQx7d3YPUQ0MBqGzG52UP5txrGZ98AjsNCxxTnhKHFCBqF44AV7
   V3n1c5MDfYcFU/J/PUM819tqXSvVbUC1oGleyLhPr5VAybjoFTEQDC5u0
   nCgE585p6FckxaiE3/Y/7zRdPaak/WRb4drSkpOSfQPK3XyHCarPOtRpw
   e8RssKLNFSiyvcRtslUN4ujClsPBJ4YriPU219uqtJdxY+nGzDHOFoUZK
   BVDRnGzt02kjz/QyZVTqoxmgo8NKsm/FS/YZ4F++y/LiA58BV6uoZjzCv
   Q==;
X-CSE-ConnectionGUID: vJ2PFT1EQwa9X05xQbePMg==
X-CSE-MsgGUID: FrUfyi4KR9CtKY7OokBt3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23720746"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23720746"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:17:24 -0700
X-CSE-ConnectionGUID: 7fkqkPvKRZiRE6zcl8aVzA==
X-CSE-MsgGUID: 9vFS3yhCS5q9XrsIuL6u4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64260974"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:17:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl53Y-00000004L3B-2Uqd;
	Mon, 02 Sep 2024 14:17:12 +0300
Date: Mon, 2 Sep 2024 14:17:12 +0300
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
Subject: Re: [PATCH v4 10/18] devcon property: Document devcon_match_fn_t
Message-ID: <ZtWeuFUEgnF9e2S4@smile.fi.intel.com>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-11-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901040658.157425-11-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Aug 31, 2024 at 09:06:48PM -0700, Stephen Boyd wrote:
> The usage of this match function is hard to understand at a glance.
> Document the arguments and the return value so it is clear how to
> implement the function.

Thank you for the patch!

...

I believe we still use "device property:" in the subject for this header file changes.
$ git log --oneline --no-merges -- include/linux/property.h

...

> +/**
> + * devcon_match_fn_t - device connection match function
> + * @fwnode: Remote connection's device node
> + * @con_id: Identifier for the connection
> + * @data: Match function caller specific data
> + *
> + * Implement a callback with this function signature to search a fwnode's
> + * connections for a match with a function like device_connection_find_match().
> + * This function will be called possibly multiple times, once for each
> + * connection. The match function should inspect the @fwnode to look for a
> + * match. The @con_id and @data provided are the same as the @con_id and @data
> + * arguments passed to the functions that take a devcon_match_fn_t argument.

> + * Note: This function can be called multiple times.

As noted in the next patch, this would be nice to elaborate (at least to me
this sounds like declaration of idempotency which is unlikely what is
meant, or am I mistaken?).

> + * Return: Pointer to match or NULL if no match found.
> + */
> +typedef void *(*devcon_match_fn_t)(const struct fwnode_handle *fwnode,
> +				   const char *con_id, void *data);

-- 
With Best Regards,
Andy Shevchenko



