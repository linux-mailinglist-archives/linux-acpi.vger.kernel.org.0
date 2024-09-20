Return-Path: <linux-acpi+bounces-8360-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0B597D656
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Sep 2024 15:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904352831A8
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Sep 2024 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFC817BB01;
	Fri, 20 Sep 2024 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0I+Fkbz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FECA17839C
	for <linux-acpi@vger.kernel.org>; Fri, 20 Sep 2024 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839696; cv=none; b=LTMSN1POsuTJKksuIqSlYU/e+bjnapEuE292kVun6YsfPPLTmYLfM95G5bQu7yhH2KHxNUINgzVbfFn6ahyFvMEI2xlI/9mHcOaLq7k3HdSEC4YI2BqMriJac6Dz8hO6XG/449aJ2lBCj+zltS8shrE+ZYauivkuiypFVzcEko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839696; c=relaxed/simple;
	bh=F6XBYwiicyA+nj26vjDbYS6rMplMwRTiMlA0bkAHKZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/7WLZtaBxfdOgCllzIJI8s1a/y8u2i+7oV+Or/GVmTJOCmH6SwHJzCQin+YK5GNV2AE9TqWUs+/hbRebGR0f9WErGGXSwR+SkJYVGRR3563F5lO5LQGRC9RXMhjcdGChLmg54gX0IdVCv7S/XXXD0/fMyWdcHhFp/lP7e7WX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C0I+Fkbz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-535be093a43so2708498e87.3
        for <linux-acpi@vger.kernel.org>; Fri, 20 Sep 2024 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726839692; x=1727444492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cy8eJSiB/nOK0MNLeFOudgQDV58ne9sCKlAuyt+d5bs=;
        b=C0I+FkbzsZvOVkfMU2Lj4XR3G2Ua3mxq8P7bxTz72yY9lA004DHCGgdJUWqH3oP/Yy
         s9q2+ePIHiPZNLH5gVkmhwBE3KX6vENrdrfehmJE+GPmDokVAyj7mexOUFL+eIJ1dG73
         dnZIEtpgpurPfqs1N6oyBhLNCQgNKBSMgJhPTpRRx4oeP2LDMdBsI9OQUu2DBeND7eZZ
         J/jza7sF0lawK5rcHlq692e8mlY6OH71nN/K3MQas3QFzHr/hsE1nOt5ZPFYLY3xtRzL
         EY/maDFa+YAo8ZoWuzUFlBIvvE4tYQjtK0vpydBBNZC4t48DczQaetK4FfnCsFxYphpS
         SnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726839692; x=1727444492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy8eJSiB/nOK0MNLeFOudgQDV58ne9sCKlAuyt+d5bs=;
        b=IIB061Ora+FkD598KLzVC+fg1xFcj6lh6bab/r5A2NsKokVGSelojPUsFh7JaOy4s7
         TsqPaGwLJ3Jmg08FtBVL+LQfoJaW+Stmcu7fvz8nXokFs5cL34MAVyqjy1vGmohUjpX/
         rkiXGGZrRSCsB5sAfheLMpPNiKGk6rf9ozsPF1rWj5zcoMnh7p+wLkv5br3qNtQHOPU0
         bgvozGD5pH5oruX+KtmQsNcR4p71Nz7jq9IrKgYyWuAJUokOfivXrSpAKYelo9ijBjk/
         GSG+9kbwhhS9TC7shoTUbfpy3WDWfDephn3D28h4A3e+hAZRMoIFiYoWLDZqK+OA/jL3
         VHIw==
X-Forwarded-Encrypted: i=1; AJvYcCWY7d37tKs5kSBe7V7yXDjBL5FxLcbJ4sqsvbEBWiJOdrUs7AvfXm3q0xq9OjWKgaw8h1u+KNl5vdlt@vger.kernel.org
X-Gm-Message-State: AOJu0YwhEqyPBqw46wK8Qpv9bJeEwUx1MUw9snZNkD6cLGKReY5y8xBv
	LvvD6vq5I1nbFM8aXA6h3RcteBoUcDkcX2MMrIjXy7RmHgp29PPQM3uzCOslVFI=
X-Google-Smtp-Source: AGHT+IE3spKxFlKow+XZEn/pdnVcnC7xAb2KymB9nWls7Ajtm+SQAP7jVkeioCLRLwIL4VXLIlrZbQ==
X-Received: by 2002:a05:6512:3192:b0:52e:7656:a0f4 with SMTP id 2adb3069b0e04-536ac32012emr1856875e87.41.1726839692396;
        Fri, 20 Sep 2024 06:41:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704dbc8sm2166041e87.101.2024.09.20.06.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 06:41:31 -0700 (PDT)
Date: Fri, 20 Sep 2024 16:41:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Benson Leung <bleung@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	Guenter Roeck <groeck@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v4 01/18] drm/atomic-helper: Introduce lane remapping
 support to bridges
Message-ID: <vbb7uo3xszign2mjkciclrsbajf53btfguwhixueohqpvfiouu@mmk4qdskqjoa>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-2-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901040658.157425-2-swboyd@chromium.org>

On Sat, Aug 31, 2024 at 09:06:39PM GMT, Stephen Boyd wrote:
> Add support to the DRM atomic logic to support lane remapping between
> bridges, encoders and connectors. Typically lane mapping is handled
> statically in firmware, e.g. on DT we use the data-lanes property to
> assign lanes when connecting display bridges. Lane assignment is dynamic
> with USB-C DisplayPort altmodes, e.g. pin conf D assigns 2 lanes of DP
> to pins on the USB-C connector while pin conf C assigns 4 lanes of DP to
> pins on the USB-C connector. The lane assignment can't be set statically
> because the DP altmode repurposes USB-C pins for the DP lanes while also
> limiting the number of DP lanes or their pin assignment at runtime.
> 
> Bridge drivers should point their 'struct drm_bus_cfg::lanes' pointer to
> an allocated array of 'struct drm_lane_cfg' structures and indicate the
> size of this allocated array with 'struct drm_bus_cfg::num_lanes' in
> their atomic_check() callback. The previous bridge in the bridge chain
> can look at this information by calling
> drm_bridge_next_bridge_lane_cfg() in their atomic_check() callback to
> figure out what lanes need to be logically assigned to the physical
> output lanes to satisfy the next bridge's lane assignment.
> 
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: <dri-devel@lists.freedesktop.org>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c |  2 ++
>  drivers/gpu/drm/drm_bridge.c              | 34 +++++++++++++++++++++++
>  include/drm/drm_atomic.h                  | 31 +++++++++++++++++++++
>  include/drm/drm_bridge.h                  |  4 +++
>  4 files changed, 71 insertions(+)

I have given this a lot of thought in the last several days, thanks for
the interesting problem.

Basically, as I said during LPC, I feel that this is an overkill to be
handled in the drm_bridge layer. In most other usecases the lane
configuration is static and doesn't change. MIPI DSI standard, for
example, explicitly disallows that: "The number of Lanes used shall be a
static parameter.  It shall be fixed at the time of system design or
initial configuration and may not change dynamically." (MIPI DSI 1.3,
section 6.1).

Following the struct drm_connector_hdmi introduction I think we are
getting closer and closer to the struct drm_connector_dp, which should
record all DP-related data to be used by DisplayPort connectors. An
example of a field in this struct-to-be might be `u8 num_lanes`. In the
normal DP / uDP cases it will be static, in case of USB-C AltMode it
will be dynamic and change depending on pinconf being configured.

-- 
With best wishes
Dmitry

