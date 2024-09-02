Return-Path: <linux-acpi+bounces-8083-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A919696864D
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 13:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6115F284878
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 11:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E4E187353;
	Mon,  2 Sep 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RpVnQEAj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA313B59B;
	Mon,  2 Sep 2024 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276960; cv=none; b=WeVdR8c3C6iqcPZcrHlUM2CToYCYPi2ROMDadpOeeNslx2SZTijh7xMpvB7TlaNBVLiMlXSs49hzBy/M3mcU0Xr8s2cUns6mmANLz+ZVKcWqjg45U645SnNyJqHVyCCTZBDlVz6/fda2o5x7rW0k7ZGsGDAeTs9RVJ8tt5hTJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276960; c=relaxed/simple;
	bh=ijLYhyyOfFYUMsUXfR6J6D9+QxK+paVNZEW3dTYB+HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkDJhhlTncWb6FaUAh2Zb+fcVpSYz5Np6cicl8t3WotolUljQNZm+1GWnMF8jjf2O/9K3LlChh5cPqidpcRQh6tPNocqnMC+igKspAYSJe/PYQ/jVq2vj3jAJqDa9aIaiNFgVUY2pBrCNIEzkDV0sneW8P4EN2JjyXUNWFIeHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RpVnQEAj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725276959; x=1756812959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ijLYhyyOfFYUMsUXfR6J6D9+QxK+paVNZEW3dTYB+HQ=;
  b=RpVnQEAj4w5UJw1wGZkb5N9sJw+c5SRYB7bkS8VkEJmql6IPmtbTekyS
   gyRpSAx4c6663hiTWSJAs8t+JxmU865hL1k0XrBjiwRFoR6bLNONWKpiu
   2boMaRjkMYrnX4dZGOeOp0+J4ssJY1R0jvA7Alzwzxh0DJmMmRePegKr/
   AXOndQbgIbKvI7k/SSujr1DwMbDHXyuNNq6yOe9keTyqyB0GHKRYLUYh6
   fR0XQxhfD20zCbvZlMTkSI3VVvmtCWCPCjV8xCCai+JSNc9hV/Q0UMGFg
   QfyGVQhyCDgcCfUCoWX9xBknAL0Nb8fGKEGh7jRnTHMGAaCfU/oYX4VDJ
   w==;
X-CSE-ConnectionGUID: 4B/dOr4BTQKNjnaRrMm++w==
X-CSE-MsgGUID: uIHTK2r9RZ+OYCVaMpd0OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="13329088"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="13329088"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:35:58 -0700
X-CSE-ConnectionGUID: dYg4LNV0Tgayw6N9btAGjg==
X-CSE-MsgGUID: JiwWAzMER72Z6q3Er8BeYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69207807"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:35:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl5LW-00000004LMj-1ywK;
	Mon, 02 Sep 2024 14:35:46 +0300
Date: Mon, 2 Sep 2024 14:35:46 +0300
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
Subject: Re: [PATCH v4 06/18] drm/bridge: aux-hpd: Support USB Type-C DP
 altmodes via DRM lane assignment
Message-ID: <ZtWjEudmlR51zkU9@smile.fi.intel.com>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-7-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901040658.157425-7-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Aug 31, 2024 at 09:06:44PM -0700, Stephen Boyd wrote:
> Extend the aux-hpd bridge driver to support assigning DP lanes to USB
> type-c pins based on typec mux state entry. Existing users of this
> driver only need the HPD signaling support, so leave that in place and
> wrap the code with a variant that supports more features of USB type-c

Isn't the proper spelling "USB Type-C"?

> DP altmode, i.e. pin configurations. Prefix that code with
> 'drm_dp_typec_bridge' to differentiate it from the existing
> 'drm_aux_hpd_bridge' code.
> 
> Parse the struct typec_mux_state members to determine if DP altmode has
> been entered and if HPD is asserted or not. Signal HPD to the drm bridge
> chain when HPD is asserted. Similarly, parse the pin assignment and map
> the DP lanes to the usb-c output lanes, taking into account any lane
> remapping from the data-lanes endpoint property. Pass that lane mapping
> to the previous drm_bridge in the bridge chain during the atomic check
> phase.

...

> +static inline struct drm_dp_typec_bridge_data *
> +hpd_bridge_to_typec_bridge_data(struct drm_aux_hpd_bridge_data *hpd_data)
> +{
> +	return container_of(hpd_data, struct drm_dp_typec_bridge_data, hpd_bridge);

+ container_of.h ?

With that said, can the argument be const here?

> +}

...

Ditto for the two more helpers, added in this change.

...

> +static void drm_dp_typec_bridge_release(struct device *dev)
> +{
> +	struct drm_dp_typec_bridge_dev *typec_bridge_dev;
> +	struct auxiliary_device *adev;
> +
> +	typec_bridge_dev = to_drm_dp_typec_bridge_dev(dev);
> +	adev = &typec_bridge_dev->adev;
> +
> +	ida_free(&drm_aux_hpd_bridge_ida, adev->id);

> +	of_node_put(adev->dev.platform_data);
> +	of_node_put(adev->dev.of_node);

I'm wondering why it's not made fwnode to begin with...
From the file / function names it's not obvious that it's OF-only code. Neither
there is no explanations why this must be OF-only code (among all fwnode types
supported).

> +	kfree(typec_bridge_dev);
> +}

...

> +		return ERR_PTR(dev_err_probe(parent, -ENODEV, "Missing typec endpoint(s) port@0\n"));

We have a new helper for such cases.

...

> +	adev->dev.of_node = of_node_get(parent->of_node);

device_set_node() ?

...

> +	ret = auxiliary_device_init(adev);
> +	if (ret) {
> +		of_node_put(adev->dev.platform_data);
> +		of_node_put(adev->dev.of_node);
> +		ida_free(&drm_aux_hpd_bridge_ida, adev->id);
> +		kfree(adev);
> +		return ERR_PTR(ret);

Can cleanup.h be utilised here and in other error paths in this function?

> +	}

> +	ret = devm_add_action_or_reset(parent, drm_aux_hpd_bridge_free_adev, adev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return typec_bridge_dev;
> +}

...

> +static int dp_lane_to_typec_lane(enum dp_lane lane)
> +{
> +	switch (lane) {
> +	case DP_ML0:
> +		return USB_SSTX2;
> +	case DP_ML1:
> +		return USB_SSRX2;
> +	case DP_ML2:
> +		return USB_SSTX1;
> +	case DP_ML3:
> +		return USB_SSRX1;
> +	}

> +	return -EINVAL;

Hmm... This can be simply made as default case.

> +}
> +
> +static int typec_to_dp_lane(enum usb_ss_lane lane)
> +{
> +	switch (lane) {
> +	case USB_SSRX1:
> +		return DP_ML3;
> +	case USB_SSTX1:
> +		return DP_ML2;
> +	case USB_SSTX2:
> +		return DP_ML0;
> +	case USB_SSRX2:
> +		return DP_ML1;
> +	}
> +
> +	return -EINVAL;

Ditto.

> +}

...

> +	for (i = 0; i < num_lanes; i++) {
> +		/* Get physical type-c lane for DP lane */
> +		typec_lane = dp_lane_to_typec_lane(i);
> +		if (typec_lane < 0) {
> +			dev_err(&adev->dev, "Invalid type-c lane configuration at DP_ML%d\n", i);
> +			return -EINVAL;

Most likely typec_lane contains an error code here. If yes, it would be rather

			return typec_lane;

If no, why not make that happen?

> +		}
> +
> +		/* Map physical to logical type-c lane */
> +		typec_lane = lane_mapping[typec_lane];
> +
> +		/* Map logical type-c lane to logical DP lane */
> +		dp_lanes[i] = typec_to_dp_lane(typec_lane);
> +	}

...

> +static int drm_dp_typec_bridge_atomic_check(struct drm_bridge *bridge,
> +					   struct drm_bridge_state *bridge_state,
> +					   struct drm_crtc_state *crtc_state,
> +					   struct drm_connector_state *conn_state)
> +{
> +	struct drm_dp_typec_bridge_data *data;
> +	struct drm_lane_cfg *in_lanes;
> +	u8 *dp_lanes;
> +	size_t num_lanes;

> +	int i;

Does it need to be signed? Can it theoretically overflow as num_lanes defined
as size_t?

> +	data = to_drm_dp_typec_bridge_data(bridge);
> +	num_lanes = data->num_lanes;
> +	if (!num_lanes)
> +		return 0;
> +	dp_lanes = data->dp_lanes;
> +
> +	in_lanes = kcalloc(num_lanes, sizeof(*in_lanes), GFP_KERNEL);
> +	if (!in_lanes)
> +		return -ENOMEM;
> +
> +	bridge_state->input_bus_cfg.lanes = in_lanes;
> +	bridge_state->input_bus_cfg.num_lanes = num_lanes;
> +
> +	for (i = 0; i < num_lanes; i++)
> +		in_lanes[i].logical = dp_lanes[i];
> +
> +	return 0;
> +}

...

> +		port->typec_data = typec_data;
> +		if (of_property_read_u32_array(ep.local_node, "data-lanes",
> +					       port->lane_mapping,
> +					       ARRAY_SIZE(port->lane_mapping))) {

> +			memcpy(port->lane_mapping, mapping, sizeof(mapping));

Hmm... I'm wondering if direct assignment will save a few .text bytes

		port->lane_mapping = ...;
		of_property_read_u32_array(ep.local_node, "data-lanes",
					   port->lane_mapping,
					   ARRAY_SIZE(port->lane_mapping));

Also note that conditional is not needed in this case.

(And again, why OF-centric code?)

> +		}

-- 
With Best Regards,
Andy Shevchenko



