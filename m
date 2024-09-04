Return-Path: <linux-acpi+bounces-8142-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CC396B6DA
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 11:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0161D1C20D56
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747481CEEB3;
	Wed,  4 Sep 2024 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWkIiVbC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A41CDA18;
	Wed,  4 Sep 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442583; cv=none; b=WZFHoXFafE7BQxIUYy7k88tLNtA7qFXjnisHuSDrPFj834s3db6Fq0mNtNnV4QIA4qpgCC3YEysIuioeToG+BP5LO+Gh0lnbSGE+IZx55shVxEgpVr5C0dtwu9UBXefxjUHwios5eHeSIKtQNXsYwyHpqmZuhbMa4kYPS9EnXN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442583; c=relaxed/simple;
	bh=9bAhJ9CJLtRo5g7kUHeOsxrCvaYqEyomg7XrEVlcoI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCa+nysnq1FX+MKi7BV0KOw/H1hCkbXCTQTe/iVunWl6xVJmTneLnbTtmT4PJ+DZBKjHJ9w7YK0y/79D9XS1URPLICRbovCkcd2g6odlgQ3gqKQe6YwmO4EeMi+8q6zhQ8nUTtQ2/IhUk3mT7t68arL/bMSWpf3Kln+cD3afD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWkIiVbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EBDC4CEC9;
	Wed,  4 Sep 2024 09:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725442582;
	bh=9bAhJ9CJLtRo5g7kUHeOsxrCvaYqEyomg7XrEVlcoI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZWkIiVbCKmH2u8CfkCeJrYGIdpLJbYj6kBpbhH/s8NG1I5YWKI721mj7Lzt43ELUr
	 4Y/RWuEqQecX+uHlVulZn5bFL26l4g7DDrh/CsAUjWAD/gkxjxo5Gw8nKZgA1qUFKP
	 ddsnw1cBv9lkrSBYrj3fXi6N7cyMOaQBad+MHS0REatztT25RnzRjXgmy3fkdN4OYe
	 YE9QqbovUWfEnjcCfdZioSRwdtlvWWN9GveHaApRiw2JDeW47I2by+BAeP5y4eFp0+
	 nCxYUhP9VZeZHBJi5/yvUHifdUDcB7+hi+9ptjKGG8X2eL9sPITVHfDH+5PiTH+K7a
	 VUusR+s9t1Q4Q==
Date: Wed, 4 Sep 2024 09:36:15 +0000
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
Subject: Re: [PATCH v4 17/18] platform/chrome: cros_ec_typec: Support DP
 muxing
Message-ID: <ZtgqD3JaX2FmVWGu@google.com>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-18-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901040658.157425-18-swboyd@chromium.org>

On Sat, Aug 31, 2024 at 09:06:55PM -0700, Stephen Boyd wrote:
> Most ARM based chromebooks with two usb-c-connector nodes and one DP
> controller are muxing the DP lanes between the two USB ports. This is
> done so that the type-c ports are at least equal in capability if not
> functionality. Either an analog mux is used to steer the DP signal to
> one or the other port, or a DP bridge chip has two lanes (e.g. DP
> ML0/ML1) wired to one type-c port while the other two (e.g. DP ML2/ML3)
> are wired to another type-c port.
> 
> [...]
> 
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

