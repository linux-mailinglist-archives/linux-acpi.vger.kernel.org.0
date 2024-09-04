Return-Path: <linux-acpi+bounces-8141-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB296B6D0
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 11:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57821F25C93
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAC71CCB55;
	Wed,  4 Sep 2024 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fjiksoh/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF8136657;
	Wed,  4 Sep 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442567; cv=none; b=MjDc+95ImwhCnf+r5iJy4g+XKoj6IiCezvDYzXhxPV7bc4cruIx+HEPCLlUQJz28Vl8EK+3fvP7oh+L/X3NSBLSHwvB5UftsTeM8iZcT/UaUEavTxB4U8vRSnFjRtWUOx0yJ8vKsCh+LFeff9JCB/JOBmxVfWDek4vlxMYXPQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442567; c=relaxed/simple;
	bh=LxkNSYAofDOvfm/1x55QP/ob58WB2jeme7PmvxzQTxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnT2pEZn7c4yFJJdVil/z8QjWmdgKww4xf0q5ddA0k94u7BAvMnf39pXhDG8VANHTgExLoTTLY4tgV2B6uw4e0Y3AgIckymhNHW1vFT1LeG6iUjFbvJwdqFtxK14Iw8DaamOWhsjiroFXUnzzKaPDzrJjnoVkEJ+v4GW7oIkbYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fjiksoh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45089C4CEC2;
	Wed,  4 Sep 2024 09:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725442566;
	bh=LxkNSYAofDOvfm/1x55QP/ob58WB2jeme7PmvxzQTxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fjiksoh/7cDs5GAQtGkF7NbvnZvYCQXencrq4xsA3j8WLlB5ZuhafJ9Vxjm3ZDbwH
	 GUh0CvwTi2GHEpHVM44sRvCEWC8sT0VAKXN7l89dwztEdpArFDCkp2KCHsS0vTHPPC
	 r8l3OrP+06WDLdb0jQSBqTOD7W64qAA4kqkYkjE9vYnrYowoV7xu79/GHYQnmyywC4
	 XW3WHlGlZFOWro4shc+uMwsp5VeFQTizl6UasNkYoMWfRuDxWFL26r2MHgOvsfLEx1
	 8dKjtp7Va87ug3+24UIMvgmCZXw3juGcUHKjHsfADBFfQ9L70JyVtTPGydZclGRGzn
	 +ZZ0F9aF6JDIw==
Date: Wed, 4 Sep 2024 09:35:59 +0000
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
Subject: Re: [PATCH v4 16/18] platform/chrome: cros_ec_typec: Add support for
 signaling DP HPD via drm_bridge
Message-ID: <Ztgp_8UxEgBCiEMz@google.com>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-17-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901040658.157425-17-swboyd@chromium.org>

On Sat, Aug 31, 2024 at 09:06:54PM -0700, Stephen Boyd wrote:
> We can imagine that logically the EC is a device that has some number of
> DisplayPort (DP) connector inputs, some number of USB3 connector inputs,
> and some number of USB type-c connector outputs. If you squint enough it
> looks like a USB type-c dock. Logically there's a crossbar pin
> assignment capability within the EC that can assign USB and DP lanes to
> USB type-c lanes in the connector (i.e. USB type-c pin configurations).
> In reality, the EC is a microcontroller that has some TCPCs and
> redrivers connected to it over something like i2c and DP/USB from the AP
> is wired directly to those ICs, not the EC.
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

