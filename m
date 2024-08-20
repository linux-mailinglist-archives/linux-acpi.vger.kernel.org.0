Return-Path: <linux-acpi+bounces-7711-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3788F958435
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 12:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88C12848AA
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BF2189F32;
	Tue, 20 Aug 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUGm3zx8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A2518CBFF;
	Tue, 20 Aug 2024 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149258; cv=none; b=kf5FtuA6HO9VGjjiZ3FGPOm6x0H/EV2Vritf/eidIOscagf/OSMfHYBFYcYMLPiZ/T7QVPZFJ166aV5HLWVGCi6XWN6Mtsp6R3IGGBlg3H50priHVHcMuT9pAT8xDfXnNpEmzF9B6Ge2/wd06q9VIhx+HU1jR3kcBNlLlvWiNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149258; c=relaxed/simple;
	bh=BOgYZXPgFTNZVBz0pq3mlpmGRom2Ac7uoQ7SAmfv//c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSi5brmCJ11mQaMEcOZL4QRbeKM/3n0OBY7aFJmKTwwEdl4vOLgN1XDUeBO+7wTxXTlIRXxwZ4Zz7Sx0yJ3ligyWGJ9MtS1bIIYpFiXCxyyBRAit+aM3JSr8WvXh/om/wUc2EF8c2H1Rp0LGqDd5E/UvrB9Hspg4KDd8ORTJ2S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUGm3zx8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724149257; x=1755685257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BOgYZXPgFTNZVBz0pq3mlpmGRom2Ac7uoQ7SAmfv//c=;
  b=IUGm3zx8jAoPMo401qUiN6oLBBLtKN+DNwxrour8rvSLRibY0h87b0Ny
   L4ES3svkKdhoppWKtp90Ky5TWL9P3xjdSTJczZv9YQuYioaeXBFDNUJRH
   QmyP8gtnk1VeJQZpMnHiPgwadHVuHaXESiqUL54UkIdAoyFDXoMEK0h2O
   TFhX8TeJpC1euxJjkhU8vXw+h9k5dFjcqzdQ6l/WXCBNcip3yIfKKEwI5
   qmeBBanVjFsUMfbe1QIaVOkQwqfsBIKLs4tGumORt0qI2UDWECh6JFgrE
   Jl/cRBdumd/VryC3tfDyGcLIHKFPUvjO9kcSuQK0tfRsV0fSbFbwy1wEY
   g==;
X-CSE-ConnectionGUID: n+oS8VEjS4evZQg5jiEJ9Q==
X-CSE-MsgGUID: 25z4yIt7S8Sdy+7UU0iX8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="47833475"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="47833475"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:20:56 -0700
X-CSE-ConnectionGUID: gQPimq9BRqOlEJSAJG5ztg==
X-CSE-MsgGUID: Fzwy9pbeQXiig1dhKLRqdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60376547"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:20:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgLym-0000000HGHE-2yxO;
	Tue, 20 Aug 2024 13:20:44 +0300
Date: Tue, 20 Aug 2024 13:20:44 +0300
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
Subject: Re: [PATCH v3 10/17] device property: Add remote endpoint to devcon
 matcher
Message-ID: <ZsRt_I6y9MfWLawy@smile.fi.intel.com>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-11-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819223834.2049862-11-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 19, 2024 at 03:38:24PM -0700, Stephen Boyd wrote:
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

Move these after --- line below.

...

>  drivers/base/property.c     | 7 +++++--

The changes here are fine to me.

...

>  include/linux/property.h    | 5 +++--

> -typedef void *(*devcon_match_fn_t)(const struct fwnode_handle *fwnode, const char *id,
> -				   void *data);
> +typedef void *(*devcon_match_fn_t)(const struct fwnode_handle *fwnode,
> +				   const struct fwnode_handle *endpoint,
> +				   const char *id, void *data);

Seems there is no explanation of the parameters here, can we add a kernel-doc
to this typedef (may be a separate patch)?

-- 
With Best Regards,
Andy Shevchenko



