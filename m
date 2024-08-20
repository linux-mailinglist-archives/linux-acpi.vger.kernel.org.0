Return-Path: <linux-acpi+bounces-7709-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458139583DB
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 12:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0222C285ED6
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3318CC08;
	Tue, 20 Aug 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7jftXz6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6618CBE2;
	Tue, 20 Aug 2024 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148890; cv=none; b=IwbCEK/nDoefNIHGOUAy1ou+wFFjnKEXevjw9nx+U2Sfgi2R+4g120LuZGfNmqWEfy8swaNqR5tVYUOzTehqMdMG2iNS+evNxPRg+B9EC9lyDA9224IC6msyXTnY0JMy7TFpWhYFuF2U1iESLeBBfWxvU05RpGgILxmZemveK2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148890; c=relaxed/simple;
	bh=1E1wWLNgbFlbQn0FQcNz4VO9i1PXCs1SyYJirR9y25U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wsxix5bKHq8wkAPYRwIZGj4Qc9BMfziPLf7pyhS7FGWOHX80J0Uu3q1r9RDmyOdt2/SR0plAhmbBD0VkHDcjv3humYXcG338GsqpqXLhkJ9bXMSWE4qDij660CPVk7wiLJvTvZF7+KtXsRZFEBUIRNaE/if/9EXIR2hXRFvWK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7jftXz6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724148889; x=1755684889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1E1wWLNgbFlbQn0FQcNz4VO9i1PXCs1SyYJirR9y25U=;
  b=F7jftXz6SSwZktN+LpAbOJonU1GaFttAeK2pZBG555eue2auQw9sIFoN
   vfbMD2lZ1a6QpRYUBYnGN12w2yviLTyJiBPocF7gx6xlxtsBnUVLu/6lk
   yjJxIkMtmBZWsC2H1S9EWs4ilQjpKG0GM/jG5thtMaAwUOUu/QbhCtfJY
   U8aokB+d+RNoLPhqILN817xE48uU0B3E/rhx25sVLAQV8XQVDBenDcfnS
   O0Hpd845+8C2r0JmgHLWlqABVrMa6TG8k7f3PWU/JjF5+DJBETkVTniNm
   Wwaj0iVWTLmTzLUvIPr6IM2cxDJ7bQEygEWFJdonw470kFb7mWJYYcqXB
   w==;
X-CSE-ConnectionGUID: vPBdjXmtRXmJnGaarc07fQ==
X-CSE-MsgGUID: SjA8/EQTRnCQgfagKcLp5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22574591"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22574591"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:14:48 -0700
X-CSE-ConnectionGUID: WVSUDWhsQh27s29v8SXEbQ==
X-CSE-MsgGUID: yY7H00bUQRa7ybSXTdMr2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60661938"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:14:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgLsq-0000000HG9s-2zFi;
	Tue, 20 Aug 2024 13:14:36 +0300
Date: Tue, 20 Aug 2024 13:14:36 +0300
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
Subject: Re: [PATCH v3 04/17] usb: typec: Add device managed
 typec_mux_register()
Message-ID: <ZsRsjPwNQYWWGIXg@smile.fi.intel.com>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-5-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819223834.2049862-5-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 19, 2024 at 03:38:18PM -0700, Stephen Boyd wrote:
> Simplify driver error paths by adding devm_typec_mux_register() which
> will unregister the typec mux when the parent device is unbound.

> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: <linux-usb@vger.kernel.org>
> Cc: Pin-yen Lin <treapking@chromium.org>

As per previous comment, move these after --- line
(hint: You may have it in your Git commit with --- line,
 it will be removed on the receiver side by `git am`)

...

> +/** devm_typec_mux_register - resource managed typec_mux_register()

Wrong comment style.

> + * @parent: Parent device
> + * @desc: Multiplexer description
> + *
> + * Register a typec mux and automatically unregister the typec mux
> + * when @parent is unbound from its driver.
> + *
> + * The arguments to this function are identical to typec_mux_register().
> + *
> + * Return: the typec_mux_dev structure on success, else an error pointer.
> + */
> +struct typec_mux_dev *
> +devm_typec_mux_register(struct device *parent, const struct typec_mux_desc *desc)
> +{
> +	struct typec_mux_dev **ptr, *mux_dev;
> +
> +	ptr = devres_alloc(devm_typec_mux_unregister, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mux_dev = typec_mux_register(parent ,desc);
> +	if (!IS_ERR(mux_dev)) {
> +		*ptr = mux_dev;
> +		devres_add(parent, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}

What does prevent you from using devm_add_action_or_reset()?

> +	return mux_dev;
> +}

-- 
With Best Regards,
Andy Shevchenko



