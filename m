Return-Path: <linux-acpi+bounces-8081-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2EA968613
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 13:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C74281DB1
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 11:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FA8184540;
	Mon,  2 Sep 2024 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="euV7kv3z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D3D183CB7;
	Mon,  2 Sep 2024 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276137; cv=none; b=nc66hIGT+WnjAIR8LTXGMVJj28TD1UAcH6N2DoiKL6Bfo+yJY6dCTpKoNZ/PRn7auMllHMjfdO++wRg2x/1pdumyozLkd6wfKyvTfdZWHnQASe3LkFfEaWGqA21datBYfX5kEfcvbNTgGF83ZiRqju1g3RqBwnN1GDv+/ffcYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276137; c=relaxed/simple;
	bh=fehs2+E64I0ZFEnYzghltUagaBJu6yND9Ki/e2rbcLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKHgqQ/1kUxepOP0UHKEM4ZMaEUXgntMDO4osFIQYBIjqC2b0CheFYvpYxa+yM4wFNMDU64gtPFwfKsNEQLQyqMiGUHgNxbPA/U3+yG1CiyVhYoLEsbSW/kYC+7KhDSowqk2RCWNUG0kTc8Vi15WSCz2V6rw9Sve58zi9ea4Xgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=euV7kv3z; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725276136; x=1756812136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fehs2+E64I0ZFEnYzghltUagaBJu6yND9Ki/e2rbcLA=;
  b=euV7kv3zWoc06+7n+5WlQrWoaKuQXKDorUV3fa34d2LsSlIX9JvQhOHx
   sdXsCNUByspR+fsZtWVA93pD+VGUiTlS5jIDZ7vCR9W8ULogiR0rhSTZm
   h49XBP8X01dW8Z5HidHWHUdR2w5iurvrI+upmPOxtKAOGIFBjXWcrdq3d
   YDGfHrCYpK24FOulZL2ulh8Xptedkr6SMEkMUG9ETcJ/D/jg8FwOvxJEk
   rVY00k0bDCD1QOLhglC+brXMus6MpN9226ZqK1J94+9hYTbUTE1A7eWnP
   zApT9JTweD5Hggaem97r2lXDeCfNVYuTYt2dwKmXsjj+aNzKtbp4gwXQu
   A==;
X-CSE-ConnectionGUID: 20+IiVlvRcqRaHoJgYeJYA==
X-CSE-MsgGUID: hGuwVpa+StiTgF2beXCetg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="41353281"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="41353281"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:22:15 -0700
X-CSE-ConnectionGUID: r9dZ1SjQR7mt8hDhn4QGFQ==
X-CSE-MsgGUID: HvRqsXktRSmLSzJ4FQaJ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="68718584"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:22:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl58G-00000004L8V-0vHk;
	Mon, 02 Sep 2024 14:22:04 +0300
Date: Mon, 2 Sep 2024 14:22:03 +0300
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
Subject: Re: [PATCH v4 05/18] usb: typec: Add device managed
 typec_switch_register()
Message-ID: <ZtWf2y8vGJyerSXs@smile.fi.intel.com>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-6-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901040658.157425-6-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Aug 31, 2024 at 09:06:43PM -0700, Stephen Boyd wrote:
> Simplify driver error paths by adding devm_typec_switch_register() which
> will unregister the typec switch when the parent device is unbound.

...

> +struct typec_switch_dev *
> +devm_typec_switch_register(struct device *parent,
> +			   const struct typec_switch_desc *desc)
> +{
> +	int ret;
> +	struct typec_switch_dev *switch_dev;
> +
> +	switch_dev = typec_switch_register(parent ,desc);

Slipped typo, i.e. wrong location of the white space character.

> +	if (IS_ERR(switch_dev))
> +		return switch_dev;
> +
> +	ret = devm_add_action_or_reset(parent, devm_typec_switch_unregister, switch_dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return switch_dev;
> +}

-- 
With Best Regards,
Andy Shevchenko



