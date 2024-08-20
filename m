Return-Path: <linux-acpi+bounces-7710-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FAD9583E9
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 12:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D2D1F2524A
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4650C18C90E;
	Tue, 20 Aug 2024 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nvl2RVmV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593C158DC4;
	Tue, 20 Aug 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148984; cv=none; b=nVIZrroFlznyo1lw6uvwzFExjDbE9WOKfFLMY01zPZQyiyEa5xQV9xHcSgRP2wRmJOX+/U3LoFc67CMnUiUVr0DlzVXOha8+p5n14y+JcQyh8wC0r2OMnpw0OuyLVQYGV3RfbEL4VLxSrcpazv4DBplMiurUTqwl0QmTjC5lWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148984; c=relaxed/simple;
	bh=WT51twTaR9ldXwxgDFR3gWRncIayJMQMu6eY6+ge2zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osT2K+7liSVHgPtJLOTwPr10ojOazFnxsr4ZKxxGdOb8IjGhyoxakmOd7uj4tqYTdyodt/12VeT/aqJoqziHxGhrpRPHozded5srelqqYjHNZ3SFL43tsH+T+Eam07ogHA7sVQv7mnp4KGFtkRNugAeO5yP8tF0I5OV6RZGtSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nvl2RVmV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724148983; x=1755684983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WT51twTaR9ldXwxgDFR3gWRncIayJMQMu6eY6+ge2zQ=;
  b=Nvl2RVmVsn5N0kahmq96uNkx710bxmdoVh96NXurNwYEX+fg+lFcLPFE
   dFtJakC+UaJ58xSn/2k1RSuElJdt+A7q5fD0iMH3nXac7eeZxuSsuImqK
   7AbMRnaGmonNNErQecZ9HS76q+z38ci/9uebrqN9mugpM/46SLI60g2LH
   IOLKGYhjsg1KAbCRVMOGsWLjyoH2Wqa0kSkI8H3ZBH8BziEi8je+SAHsN
   imUG2I6IK8Ow34Op3Vb+1TIsxjcRupnCMPUmB6s0nF1Ap3h/gtUOTH+67
   VvapNzPvSbQeGLKOs4dRpfUB320sayia0QqJ7B+EKTZBMpuFdudMq1EbY
   g==;
X-CSE-ConnectionGUID: EsTXAV58TNm9P5c+4toUmg==
X-CSE-MsgGUID: HRuXbNlKQ7GJTZzWCdkytQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="47833056"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="47833056"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:16:22 -0700
X-CSE-ConnectionGUID: /kffWbRHSBaK1HncF991ag==
X-CSE-MsgGUID: mDUg9YbGQk+CBo7MXYrpGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="91402041"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:16:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgLuL-0000000HGD8-4AYP;
	Tue, 20 Aug 2024 13:16:09 +0300
Date: Tue, 20 Aug 2024 13:16:09 +0300
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
Subject: Re: [PATCH v3 05/17] usb: typec: Add device managed
 typec_switch_register()
Message-ID: <ZsRs6d6uOMb4DqQQ@smile.fi.intel.com>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-6-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819223834.2049862-6-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 19, 2024 at 03:38:19PM -0700, Stephen Boyd wrote:
> Simplify driver error paths by adding devm_typec_switch_register() which
> will unregister the typec switch when the parent device is unbound.

> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: <linux-usb@vger.kernel.org>
> Cc: Pin-yen Lin <treapking@chromium.org>

As per previous patches.

...

> +	ptr = devres_alloc(devm_typec_switch_unregister, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	switch_dev = typec_switch_register(parent ,desc);
> +	if (!IS_ERR(switch_dev)) {
> +		*ptr = switch_dev;
> +		devres_add(parent, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}

devm_add_action_or_reset() ?

-- 
With Best Regards,
Andy Shevchenko



