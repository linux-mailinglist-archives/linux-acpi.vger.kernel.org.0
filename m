Return-Path: <linux-acpi+bounces-8079-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58A79685EE
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 13:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B23B219DD
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 11:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E2C181CE1;
	Mon,  2 Sep 2024 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nU0mvZjj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B435175A5;
	Mon,  2 Sep 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275584; cv=none; b=gREDnDXN9gc8L70xtDrEW6L8nTnIauMo9w1QVYuVv0OnsaCdLt+7dSimHdTpaNOcV5Vm5DpybhQ8NvaPi3AG+d70VtRkfjmsbGmovpil3DoHb5v47Uyc2/etX8HPjjKA35I/6S8JPT93l7XvaxrgWUfvSt40lE0ab4dLcJ2iCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275584; c=relaxed/simple;
	bh=+uulfcVXT6YjoKghtTgzQhPkoYdQXxqT7443vnr5b58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUwiH3sDWQDBBx/iEvGGARbgauUZ7VyeEF0Wympj5pCZz6T4/lesNSqoCsZJec7p8M0wf55SGWlWiOjmt2Ypi2k1seaFsyqWV5hZxvsLH9yfMdFWrNG2W26FprP/CAOYs6uN7ENJG8yxSOAZqDC90YQOBE+0Vhce7XzCtA/Iw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nU0mvZjj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725275583; x=1756811583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+uulfcVXT6YjoKghtTgzQhPkoYdQXxqT7443vnr5b58=;
  b=nU0mvZjjBdUpc63/RyqeEOYDOia6NVzSyGn9+ZGe9C1I0z+1T6TUXoF4
   3084XQTdqQqY8KzAtAvIIvZ7Glz0CEzh229DgL1bPg4L/yKAhnaxLmkFX
   WLjYrKRmM3uiu///xzbuEqz0FYn8lvYF0YMeZyG2Gqcc4Lt2TGi8HD3Yw
   Z+GunjyjjS8WOGDHdeY+NzAybdR9oartpI441u6t+hbP0GJbhUWfMrXJG
   RK/3A9ZLRgMdEeCh2sK4ouRqL/WlsZ/jKOIRyvyi6VSPG1+4P8LyjvzDu
   JPNKZ+N+A+RyA5c5mPy70qAMhOCOynWgD5K2qgdwq+52W6YL0XK5FUmAJ
   Q==;
X-CSE-ConnectionGUID: 8kP6ifzkSUSLVpg2X1vS5Q==
X-CSE-MsgGUID: CiWX05+aQp6MBUaD76TB0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="41352606"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="41352606"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:13:02 -0700
X-CSE-ConnectionGUID: ltWCpk/5SMKI28+OWW8xEg==
X-CSE-MsgGUID: 9PxBVm5wQcWh8LoEG16rjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="68716707"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:12:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl4zK-00000004Kz6-11Uq;
	Mon, 02 Sep 2024 14:12:50 +0300
Date: Mon, 2 Sep 2024 14:12:49 +0300
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
Subject: Re: [PATCH v4 11/18] device property: Add remote endpoint to devcon
 matcher
Message-ID: <ZtWdsZrFxfjYLgaG@smile.fi.intel.com>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-12-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901040658.157425-12-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Aug 31, 2024 at 09:06:49PM -0700, Stephen Boyd wrote:
> When a single DT node has a graph connected to more than one
> usb-c-connector node we can't differentiate which typec switch
> registered for the device is associated with the USB connector because
> the devcon matcher code assumes a 1:1 relationship between remote node
> and typec switch. Furthermore, we don't have a #typec-switch-cells
> property so there can only be one node per typec switch.
> 
> Support multiple USB typec switches exposed by one node by passing the
> remote endpoint node in addition to the remote node to the devcon
> matcher function (devcon_match_fn_t). With this change, typec switch
> drivers can register switches with the device node pointer for a graph
> endpoint so that they can support more than one typec switch if
> necessary. Either way, a DT property like 'mode-switch' is always in the
> graph's parent node and not in the endpoint node.

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Daniel Scally <djrscally@gmail.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <linux-usb@vger.kernel.org>
> Cc: <linux-acpi@vger.kernel.org>
> Cc: Pin-yen Lin <treapking@chromium.org>

Is it possible to move these Cc:s after --- line below?

> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

...

>  /**
>   * devcon_match_fn_t - device connection match function
>   * @fwnode: Remote connection's device node
> + * @endpoint: Remote connection's endpoint node
>   * @con_id: Identifier for the connection
>   * @data: Match function caller specific data
>   *
>   * Implement a callback with this function signature to search a fwnode's
>   * connections for a match with a function like device_connection_find_match().
>   * This function will be called possibly multiple times, once for each
> - * connection. The match function should inspect the @fwnode to look for a
> - * match. The @con_id and @data provided are the same as the @con_id and @data
> - * arguments passed to the functions that take a devcon_match_fn_t argument.
> + * connection. The match function should inspect the connection's @fwnode
> + * and/or @endpoint to look for a match. The @con_id and @data provided are the
> + * same as the @con_id and @data arguments passed to the functions that take a
> + * devcon_match_fn_t argument.

So, struct fwnode_handle is a single-linked list. Can we utilise that instead
of adding a new parameter? I.o.w. do those objects (@fwnode and @endpoint) have
anything in common and can be chained?

>   * Note: This function can be called multiple times.

What does this mean? Is it idempotent? Or what is the effect of being called
multiple times?

>   *
>   * Return: Pointer to match or NULL if no match found.
>   */

-- 
With Best Regards,
Andy Shevchenko



