Return-Path: <linux-acpi+bounces-8103-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A496A2E4
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 17:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9672850D2
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 15:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE39187550;
	Tue,  3 Sep 2024 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYQ0vpG7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91E812B94;
	Tue,  3 Sep 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377736; cv=none; b=syeMUOL912vhaKs8yqH0nOW8Nu9daVCTcp7Vm0+RJ9sHBdYvjbELSieWJnWW7XUVAgBN7fKBA75OxGzlPAYAoIFZPwryR6Y7ojx3e6zNKC601vUdkIsUI7cRstpLeDN/lu6rc3BqdjMlO2Mct1xtvJb90Ku7H+b8c6Jz6H2A8jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377736; c=relaxed/simple;
	bh=t6e3G7q3f5emkzw8EoVbd6PITMUf/pOi2Q6k8ITflpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj7JKTm5J7K1mabqGV48GIYryvM9t+rCfnnHFWpd4LXG7LWoBN9uVLBJs5n4dcd/zqhuGqaW2vYOirbfDIXwfjcFYS//1QbvfZmiHN8g3S8rWUJXqQAuIZvnKArEkmTNQsR2iuACr7e43weOR9SHMAYT4TO0v7UnCvBhbmVcuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYQ0vpG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE50C4CEC4;
	Tue,  3 Sep 2024 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725377736;
	bh=t6e3G7q3f5emkzw8EoVbd6PITMUf/pOi2Q6k8ITflpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYQ0vpG7jRDFlWoikaPdbcFzrRbCnv2PbH5rQHxFbvKcnOxhBNAK+rOPKKXtezdwQ
	 I5WqCJChbeZx3fc+P5yoEjoGJMBiNfup4Uqw1l3P9hvrjV7BrAZff5OChcp9LiPs+6
	 Fpz8EULJGifu7rnmXsGZi1T33dZr85Nx8+Rb/bHiVxVZ/TH07rDFT4szi2Y5CSYS/C
	 38E75nDJu1TFYB+7jxKYcgB/NwU1XJeUwV/rpTQqjeiwm2iYNTEQG7NK4YDbOaVLbx
	 DAhQ20gAcW2E2kQI2EDS86aHnGrHLV7lLI/oxosVRXuSuFwcaKvaVG/OrweDLwecOx
	 ncvVjHAoa76Bw==
Date: Tue, 3 Sep 2024 16:35:26 +0100
From: Lee Jones <lee@kernel.org>
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
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
	Vinod Koul <vkoul@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: Re: [PATCH v4 15/18] dt-bindings: usb: Add ports to
 google,cros-ec-typec for DP altmode
Message-ID: <20240903153526.GA6858@google.com>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-16-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240901040658.157425-16-swboyd@chromium.org>

On Sat, 31 Aug 2024, Stephen Boyd wrote:

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
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Acked-by: Lee Jones <lee@kernel.org>
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

Acked-by: Lee Jones <lee@kernel.org>

>  .../bindings/usb/google,cros-ec-typec.yaml    | 229 ++++++++++++++++++
>  2 files changed, 233 insertions(+), 3 deletions(-)

-- 
Lee Jones [李琼斯]

