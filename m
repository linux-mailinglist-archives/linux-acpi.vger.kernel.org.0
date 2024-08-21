Return-Path: <linux-acpi+bounces-7744-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732C69591D3
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 02:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0245B21EDD
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 00:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E7CD2FA;
	Wed, 21 Aug 2024 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh/Ekhqc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC5F1C01;
	Wed, 21 Aug 2024 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724200403; cv=none; b=f/CwQpfPVXtjw/P1BPqGPd7+ktmv0fu88rqJzZdZyP52GAjaWQCb5jt3wuwd5h2AJ5KCNmgxXaX3eSWiL+ITZlPdY/o3LQDfHP4MTZ17dzG2Ab+gXA7KV56s9Ccnh+WOAazv9HNPRRLUFcZJC9V+Da8gh6bkSVuJL3pv7lvPDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724200403; c=relaxed/simple;
	bh=2WZVtYSriNEGjwYLbCDt8+szQRWC2FjOcJJ8a9CeCxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHxWcivlHvefUxz2vcjvTmgOH5Q6SOWO1V9rlKX+fvadMMG1qNbcBD3Oxsr5NbS+z4NxGiDjKjGt/xj6jMdBsrPqsOhgpy09Jutvz4/yiL77uVxS+I1ZK3grsvUoUYbnKdDnzLHjr9ihvgopWYp0F6dRmXsDkeylGPo+xuPiWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh/Ekhqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2D7C4AF0E;
	Wed, 21 Aug 2024 00:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724200402;
	bh=2WZVtYSriNEGjwYLbCDt8+szQRWC2FjOcJJ8a9CeCxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nh/Ekhqcv+/tSPLKyozG7C0DMo9SpKtffaid72hpJAkYrBRV8Fn6pNrjIg7GfuCv9
	 z7nAMbuVwatHZCEqnvyycdySjC+XOJNvjbxwT3uXsTNlQIJozKymcxjdsjNS3F94AH
	 b5b5z9QgM17ETONKWlhsLcZQveW8y1qSaRDuo1q6mvKCMOs0OHnlbHCwoU/Keyjjb/
	 rECdlrZHYIG/Gs3E0i8gXRhV2Zelwf+M9o9EPIDh6HHqLsek4VpcnrZzvlIJvHHryo
	 65nZr5kgOUuOqwvN5wUPvtxDYsJPorfBNscNVSdC2o3lc5rv4J0TZ2eEbiQepxiF4q
	 7yDVCgq6gUt/g==
Date: Tue, 20 Aug 2024 19:33:20 -0500
From: Rob Herring <robh@kernel.org>
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
	Robert Foss <rfoss@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
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
Subject: Re: [PATCH v3 11/17] dt-bindings: usb-switch: Extract endpoints to
 defs
Message-ID: <20240821003320.GA2341371-robh@kernel.org>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-12-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819223834.2049862-12-swboyd@chromium.org>

On Mon, Aug 19, 2024 at 03:38:25PM -0700, Stephen Boyd wrote:
> Move the usb-switch endpoint bindings to defs so that they can be reused
> by other bindings. Future users of this binding will have more than one
> type-c output node when they're muxing a single DP signal to more than
> one usb-c-connector. Add an example to show how this binding can be used
> and accelerate binding checks.
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
>  .../devicetree/bindings/usb/usb-switch.yaml   | 74 ++++++++++++++++---
>  1 file changed, 62 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-switch.yaml b/Documentation/devicetree/bindings/usb/usb-switch.yaml
> index da76118e73a5..5fc031b56fad 100644
> --- a/Documentation/devicetree/bindings/usb/usb-switch.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb-switch.yaml
> @@ -35,9 +35,13 @@ properties:
>      $ref: /schemas/graph.yaml#/properties/ports
>      properties:
>        port@0:
> -        $ref: /schemas/graph.yaml#/properties/port
> -        description:
> -          Super Speed (SS) Output endpoint to the Type-C connector
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +
> +        properties:
> +          endpoint:
> +            $ref: '#/$defs/usbc-out-endpoint'
> +            unevaluatedProperties: false

You can drop this unevaluatedProperties since the $ref contains one. 
Same elsewhere. Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

