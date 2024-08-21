Return-Path: <linux-acpi+bounces-7745-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD20B9591D8
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 02:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22BB3B22062
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 00:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6F9F9F5;
	Wed, 21 Aug 2024 00:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rov6nQfb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39419EAF9;
	Wed, 21 Aug 2024 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724200427; cv=none; b=ppcUT+JXldskqrXE1Ilozl6yzb1l5hkd6FykdpwJsZZjhIWdwG/l9dQLNGBP6oEymCfkN1DG0Sp0S39R8mSbKas/NL5y2rXdnfiBnMqjFPKbxJ8suQ2D4rR2fdo0x3ssiDILNPvJRCqHji2j4iBEeQMGs7Kd0PWkr/ZitZcL2Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724200427; c=relaxed/simple;
	bh=zWCuK9SsJzIebhNp3AT58vM+nnP6FK2Gi81BotfnDWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9pdosOScTMzToMiu/cmzDdfSvEJXfp7kxmfBfFOoY7SyaNWUq/hAtuZIQAvjanfpABD0GdvY0VAnYTmU0GNc5WncM92Xe0kvXaBwAloAakPiQMSaP8+5ojRSYApOBuY+pEJS3Aeo+PJjN65yPJd2eKah8TYpfRjcytMq7rntrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rov6nQfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F65EC4AF0E;
	Wed, 21 Aug 2024 00:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724200426;
	bh=zWCuK9SsJzIebhNp3AT58vM+nnP6FK2Gi81BotfnDWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rov6nQfbQU53Wr2JjhNv6fwpgR1qxSGv0Pu3YFfK6wAUzdqTtK0U/K5I8264wnU25
	 Tcj6rVSp1T6zkOSj9HOXZvroLYJrPMgx2MhS9oPqKe4+c1AneO8gOeLx4FG3b5ZIDB
	 oM99/zjvfR5j34tBMZ7rXhdCSJWYh3VE/aqgX9DvxoLsork0ZzQOytUz7ZMDNxeaHB
	 0lm6PLeJ7folbRr6c7e58uqip5/mhrNGGYbU336WXG0UDSoHvDfeynFV4XN3BEBGct
	 7cO1k1lcJnQa5mCB2FCa3v8s67f3qQF1l0uXv9lQaVpCozIbdijOkyrn36qxDUkVQr
	 2Z/PHZdYpxzYw==
Date: Tue, 20 Aug 2024 19:33:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: David Airlie <airlied@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Benson Leung <bleung@chromium.org>, devicetree@vger.kernel.org,
	Guenter Roeck <groeck@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	linux-kernel@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, patches@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	chrome-platform@lists.linux.dev,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
	linux-acpi@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Tzung-Bi Shih <tzungbi@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>
Subject: Re: [PATCH v3 12/17] dt-bindings: usb-switch: Extend for DisplayPort
 altmode
Message-ID: <172420042344.2347039.3833700071555618217.robh@kernel.org>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-13-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819223834.2049862-13-swboyd@chromium.org>


On Mon, 19 Aug 2024 15:38:26 -0700, Stephen Boyd wrote:
> Extend the usb-switch binding to support DisplayPort (DP) alternate
> modes. A third port for the DP signal is necessary when a mode-switch is
> muxing USB and DP together onto a usb type-c connector. Add data-lanes
> to the usbc output node to allow a device using this binding to remap
> the data lanes on the output. Add an example to show how this new port
> can be used.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../devicetree/bindings/usb/usb-switch.yaml   | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


