Return-Path: <linux-acpi+bounces-7747-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 600C39591E1
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 02:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C90B21E80
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 00:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7085C134AC;
	Wed, 21 Aug 2024 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9RNHwUR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C233F4EB;
	Wed, 21 Aug 2024 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724200490; cv=none; b=C245Pgp40CY0m5bA3KeGr9Dd4K5v9hzmj1vFvYoNy7PVOPmjvS3N4IIY1il7xVsdI9nZAWpgGYQvkJxLHoc5o3+ykP4tmxUzKLMy128BfnmfY0FWz0Z1pKt9IY8OJa1rQED843yqlU37BKojCXI+FSxOC4mvKWce/6lwo0efQKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724200490; c=relaxed/simple;
	bh=fUJI4jZmft/izpLYURRjAmm97Z8N86Ii30QM5siTy/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adiXtWmmmboRA23r3hsMHxVFpP4Ah+w9ew9LCxvl5N4l1dNHjKR7Fw5aG+gx+T1kCQ/MXZBYVcjb1W04SwjcgkPqgegP8cVkNJrwdkF1mLoDoA47DU+UDtKJ5sljKRoK7HGi9cf7Y3yGrF1AA4l+9t55uFTC4C32PiQhVNWLKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9RNHwUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B451C4AF0E;
	Wed, 21 Aug 2024 00:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724200490;
	bh=fUJI4jZmft/izpLYURRjAmm97Z8N86Ii30QM5siTy/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9RNHwURn4F9TVrLMI9zpvovJ5R8Jqn2JPWT2QB8WbMbJn11pD1vZJUtenhL+zZdg
	 B4AvbIJuWjmRPb53zH1Kp0qAU7g9g1GheQ7KhEOYHniT9sQONL+3/AKnSmo91RF9aq
	 zV5Al3qjDXo2bPR9Ob4+lCxNfXIXdExtSLWhuOiIqzBGmKPLtxgOvFgcB635gLgMvo
	 DovglIz4Y5Q96tT78/Xr8f64uBtfRGVI95ylLCIivF228NRw1Er85sboSfcZgKA+8D
	 GHFDh5MGS1oCHhmFOm+G9NgU5bsFQa5wAOd+4BJxbB0AR0/POi0G5Q3BaIPBOLd0tl
	 CnjvPwsQNvhVA==
Date: Tue, 20 Aug 2024 19:34:47 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Daniel Scally <djrscally@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonas Karlman <jonas@kwiboo.se>, Robert Foss <rfoss@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Douglas Anderson <dianders@chromium.org>,
	Vinod Koul <vkoul@kernel.org>, Benson Leung <bleung@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	patches@lists.linux.dev,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Pin-yen Lin <treapking@chromium.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Ripard <mripard@kernel.org>, Lee Jones <lee@kernel.org>,
	devicetree@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3 14/17] dt-bindings: usb: Add ports to
 google,cros-ec-typec for DP altmode
Message-ID: <172420048648.2348348.16719987576551800332.robh@kernel.org>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-15-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819223834.2049862-15-swboyd@chromium.org>


On Mon, 19 Aug 2024 15:38:28 -0700, Stephen Boyd wrote:
> Add a DT graph binding to google,cros-ec-typec so that it can combine
> DisplayPort (DP) and USB SuperSpeed (SS) data into a USB type-c endpoint
> that is connected to the usb-c-connector node's SS endpoint. This also
> allows us to connect the DP and USB nodes in the graph to the USB type-c
> connectors, providing the full picture of the USB type-c data flows in
> the system.
> 
> Allow there to be multiple typec nodes underneath the EC node so that
> one DT graph exists per DP bridge. The EC is actually controlling TCPCs
> and redrivers that combine the DP and USB signals together so this more
> accurately reflects the hardware design without introducing yet another
> DT node underneath the EC for USB type-c.
> 
> If the type-c ports are being shared between a single DP controller then
> the ports need to know about each other and determine a policy to drive
> DP to one type-c port. If the type-c ports each have their own dedicated
> DP controller then they're able to operate independently and enter/exit
> DP altmode independently as well. We can't connect the DP controller's
> endpoint to one usb-c-connector port@1 endpoint and the USB controller's
> endpoint to another usb-c-connector port@1 endpoint either because the
> DP muxing case would have DP connected to two usb-c-connector endpoints
> which the graph binding doesn't support.
> 
> Therefore, one typec node is required per the capabilities of the type-c
> port(s) being managed. This also lets us indicate which type-c ports the
> DP controller is wired to. For example, if DP was connected to ports 0
> and 2, while port 1 was connected to another DP controller we wouldn't
> be able to implement that without having some other DT property to
> indicate which output ports are connected to the DP endpoint.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/mfd/google,cros-ec.yaml          |   7 +-
>  .../bindings/usb/google,cros-ec-typec.yaml    | 229 ++++++++++++++++++
>  2 files changed, 233 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


