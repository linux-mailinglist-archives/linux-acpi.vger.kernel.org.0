Return-Path: <linux-acpi+bounces-7783-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D11E95B893
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 16:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409CA1F219E8
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 14:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EF71CC15C;
	Thu, 22 Aug 2024 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oggBKWKC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2784C1CBEB0;
	Thu, 22 Aug 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337323; cv=none; b=sVKbPernnjO2DvkulZxtE685TrbroOYWDVhUVUz/yeNZYv2RsIAG/GuWLOv4tAUtrpMfGV/6yuiFrkfxTZMyOPnH8I7Q08Q/cG4Q0IBqFdbAb6Nh6jFZBu1GgiE8JvPQCNa0EOmI0vsgecjf7wX1DPenJ207teJN5+hl6ZRRS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337323; c=relaxed/simple;
	bh=Y+k+ZeSnySUlvXeIpIB978BSbObVC7BsdVZXFENjDJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQcqf2dEnQXSDC1SpslqjIQn+rqY89PpbANYQ0VF2JW3e1eivRJ/6pphPNhzyCfYsMLCvjv3xb7ImDQn20weRXYOdKM3x8fKuQtPWijjw/S0TJqRp+G8LmNTb+Gck+Ko2It3tdQoEOo/9g2Q0U+E9AGwvkhfCfDqJhkm255S/p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oggBKWKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F2CC4AF11;
	Thu, 22 Aug 2024 14:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724337322;
	bh=Y+k+ZeSnySUlvXeIpIB978BSbObVC7BsdVZXFENjDJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oggBKWKCnwj/ZBDyPl3ydL03TtQ8w7ICv3O3Bq2vzYDm5i3Sh+Fp4B1xOwUJndSRO
	 bsldW5ZjBrO3iYqTAD6yhlUKJNEFG2uVO9WSsIP/BMbZvWlmqYbi+OTJXFvURlkaJE
	 0cXff0KY8O3HzyFpLWCHtzcStqRdOBBaAIHki3hWy/822v3kaQt018aeqnig39Ai1h
	 kepfkvgJDxBCn+AjYvnjYBoh/O6LIi93KP6YCfbGwFP77J/kxUiv8KhbeLty8xoVB9
	 4b7UOJvS4a3mRc8Peylwth4W1WtoNWdmzeqQ7NF6cuCTju3DkmNAwBxQXYd/4hMSIG
	 PQAz44TrnEK7w==
Date: Thu, 22 Aug 2024 22:35:13 +0800
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
Subject: Re: [PATCH v3 15/17] platform/chrome: cros_ec_typec: Add support for
 signaling DP HPD via drm_bridge
Message-ID: <ZsdMoRpwv5twOwqx@tzungbi-laptop>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-16-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819223834.2049862-16-swboyd@chromium.org>

On Mon, Aug 19, 2024 at 03:38:29PM -0700, Stephen Boyd wrote:
> +struct cros_typec_dp_bridge {
> +	struct cros_typec_data *typec_data;
> +	struct drm_dp_typec_bridge_dev *dev;
> +};

It looks like structs are all defined in cros_ec_typec.h.  I think this struct
definition can be also moved there.

> diff --git a/drivers/platform/chrome/cros_ec_typec.h b/drivers/platform/chrome/cros_ec_typec.h
> index deda180a646f..73d300427140 100644
> --- a/drivers/platform/chrome/cros_ec_typec.h
> +++ b/drivers/platform/chrome/cros_ec_typec.h
> @@ -27,6 +27,8 @@ struct cros_typec_altmode_node {
>  	struct list_head list;
>  };
>  
> +struct cros_typec_dp_bridge;

If the struct definition moves here, it doesn't need to declare forward.

