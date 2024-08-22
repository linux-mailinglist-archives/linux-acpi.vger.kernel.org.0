Return-Path: <linux-acpi+bounces-7784-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABBA95B8A2
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 16:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51869283F6A
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 14:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A841CBEB0;
	Thu, 22 Aug 2024 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctOmC7Y9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA21CBEB8;
	Thu, 22 Aug 2024 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337434; cv=none; b=YkbbjtZ3cyemqz5Hse/+rpKP2ddrm5PekYgvbzwo7IvDa3ugAizzJUf/g2AmckbK4bGWPTN7rCXRRXU9gDY6VFdX1DQvg233m+F2rZBCztNYA2OBEGYBo/nK3g6QkRUobs6LlrBOolXnZLEzCvmrxkWmt8S5b4laM+HEu8HF+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337434; c=relaxed/simple;
	bh=ZkpJaD0BSKB4PQoNUPxvvmFUzWqr/hvDqpY1MhGCy+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faJyZ6h31GaFoU1CAN6zSc0d5iG1n6wvNw+lknGLsQINBDQOo53wMr8tcmhOiIO8VAmEAkZYbzB98mNeCzLbAufvezXLpTg9H2Ornq0hv2hLDqazOePbBMa0EYxVGnt9X7CuMAM397GCaiJWoJw4JHOGO50vNkhhgcNGmrcIeKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctOmC7Y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AA8C32782;
	Thu, 22 Aug 2024 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724337434;
	bh=ZkpJaD0BSKB4PQoNUPxvvmFUzWqr/hvDqpY1MhGCy+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctOmC7Y9I5pctjwa+bfvcuJQnPKxeiOldkSiZey7L8AQjTgSHSocZlA+zCq72uwB3
	 LWVTnaND1yi3ccNgiiz9wrc3Cals3TBSy4p7BVwYX94vzhmWuOJzOP3jmenujcCNcS
	 bW5GDiO9y7HxNnxU5wTD9Dn/akgxr6wDJaGfWz0YZ3L12Hl+VyO7DwR2FVy+V8+pLs
	 9P4wbYXFM3++q8YqIGml3T1hkx8NQfayBQw3YkMI4GniXfzrHxowf/b6Lci3uYP1Mh
	 dw+8t2cS+cRA4FyWfmgXtOO3RiS5Gfx7MvRajOXarKVShQF4RViDrSa5HuO1tMNfId
	 i19liD/cvcqFg==
Date: Thu, 22 Aug 2024 22:37:05 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
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
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <ZsdNEWX-eeLiokZl@tzungbi-laptop>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-17-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819223834.2049862-17-swboyd@chromium.org>

On Mon, Aug 19, 2024 at 03:38:30PM -0700, Stephen Boyd wrote:
> @@ -671,6 +674,20 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>  	if (port->mux_flags == resp.flags && port->role == pd_ctrl->role)
>  		return 0;
>  
> +	dp_enabled = resp.flags & USB_PD_MUX_DP_ENABLED;
> +	hpd_asserted = resp.flags & USB_PD_MUX_HPD_LVL;
> +	/*
> +	 * Assume the first port to have HPD asserted is the one muxed to DP
> +	 * (i.e. active_port). When there's only one port this delays setting
> +	 * the active_port until HPD is asserted, but before that the
> +	 * drm_connector looks disconnected so active_port doesn't need to be
> +	 * set.
> +	 */
> +	if (dp_bridge && hpd_asserted && !dp_bridge->active_port)
> +		dp_bridge->active_port = port;
> +
> +	is_active_port = !dp_bridge || dp_bridge->active_port == port;

Why `!dp_bridge`?  When will `dp_bridge` be NULL?

