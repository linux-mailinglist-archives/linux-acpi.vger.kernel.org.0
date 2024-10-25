Return-Path: <linux-acpi+bounces-8957-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09FF9B0076
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 12:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201671C2155D
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 10:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E89A1F131D;
	Fri, 25 Oct 2024 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UO4WOclT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EEC1CC8AB
	for <linux-acpi@vger.kernel.org>; Fri, 25 Oct 2024 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853383; cv=none; b=V2oFENDrOXFZPeRK0iazsynOfiV+L8yA37CYwqniTyVTXw4We0U1Y0zANtXXyTCul9VY/sa/f6etQTMcShXPLjB/vTonb3kDdXMUqRAbhlaARjoWm1Y4+lIBP6mMBBSXMimZvr9/tZHbw7v/k1kWyj15mEYDYeVgFdKT4fSSXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853383; c=relaxed/simple;
	bh=aCNAiagby3VBg8WVJeXCrYPX9K57S5WDB9gDJXTj/qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvrbLoYKQ6DI/P1GqOuyiDvynUJwfLhL+gcK1uZEa6tdYHAJtk4lMoCXRjYfKYTJTe3qAbu+A0+RV3/etKBjxWz8+TVS/GZ5dmQzY1K4fUlMhMs+G8rCxdu5dSK8EFUjvma1Y9w/9mwkar+TAvlEeq1e0cUiLmblr+y34+VSddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UO4WOclT; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e59dadebso2487275e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 25 Oct 2024 03:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729853379; x=1730458179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tyqVh/eFIyYHOhM+diCDUXlgQP3U/MFtE2DeLsQCTPY=;
        b=UO4WOclTbmHNjEpB2aPCOL++opnWaSONTq8hyfPEwqCrXJNQ9StmLWo2DRvJf6aelk
         mZ3ojr+bg1G4igOnNym978x0gxLC6EwRX9KBOQRH6tnuZ9Fyyi114X7woWdvYJHn+zEK
         Fz8BKK4Yqh/ec1Zx36dEQQdCOmiJyElq5jqZqWKVF5tFyASB30pa5kHFdGUXIOf19cAe
         3NIvzl/8DLfdpcN/gb198JmJTthsGSJhpEY80hAX7KMqVWYC9GsV4nOFuoYF3Jw8L26m
         vfk1gHcg0XyQOyWLrdoVzaN/vgNUzaUheeKvQHTeE17ge0bGVjElrNS7ZhF+VsRkLtJT
         E4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729853379; x=1730458179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyqVh/eFIyYHOhM+diCDUXlgQP3U/MFtE2DeLsQCTPY=;
        b=fQkIARIHbeXyUGZZsQXPhOhOp6iDPIYnMcx7GU6bNGzdimWxdX7c7ZPQGnvai+SqVC
         hnBs4VyU87/rtD70Qj3hblHkwkLqrzTMsvMVsFtW/Y9LgGm9VMvStHJFDRuqRKB3gqW9
         Q3Kg4YhxUwhLkKZ36JCe8xJoY6t1Q0ryGG704gcesN9RLVGEea8RdsvhIjWmnvpuQYbI
         TPqXxTh8/2yBbeHcrWpfVYsWuuHI4+b8SedK7rox/JrYFeez2e3EeRLiwscIzZaviaM5
         yHoGYngJ15dCtOBHTWuX7DoBOOeHz9NaQkFK5AkHzLCmC9e10uRDoo5DVtQfOIaL9Tas
         y3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSqN2KQ2tH5sl0wqEcFTuvAtCF91PYcR2E6kszu+k+//79+Zh/2wL4pgSud4qCsoj67m63TOv+UqNt@vger.kernel.org
X-Gm-Message-State: AOJu0YzYPd47lPlxzSAOcJm+NGNJ6BEEt5Pqh4QfM+QrOVH+FV/xOhNE
	+dMht/RcPdNKj7734nbJTrMEf/6Gqm8UOVbcdKqPM2QuULAKnMOvuNw1WbBB980=
X-Google-Smtp-Source: AGHT+IFd1s7XTf4EM8FOBisHkPGBM0CWX4Fva+d6WyJooHaUEk5EZV4vJ/wT+wZU4sf3FN36wyTG/g==
X-Received: by 2002:a05:6512:3ba5:b0:539:fb56:7790 with SMTP id 2adb3069b0e04-53b23ddcfb2mr3231326e87.6.1729853378788;
        Fri, 25 Oct 2024 03:49:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1dcb89sm132429e87.237.2024.10.25.03.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:49:38 -0700 (PDT)
Date: Fri, 25 Oct 2024 13:49:36 +0300
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
	Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 15/18] dt-bindings: usb: Add ports to
 google,cros-ec-typec for DP altmode
Message-ID: <lf7y7wpuca6kzqcglgs5d443iusf7xjocum4adi7t3npfavccx@zgsp37oyztme>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-16-swboyd@chromium.org>
 <phdcjgqqpjpruxp7v2mw446q73xr3eg4wfgfbjw5tasgr2pgg2@77swbk47b2tg>
 <CAE-0n514QMaQC2yjKP8bZqyfbv6B3AQm=+NJ87vxo6NdYiL03A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n514QMaQC2yjKP8bZqyfbv6B3AQm=+NJ87vxo6NdYiL03A@mail.gmail.com>

On Tue, Oct 22, 2024 at 06:15:47PM -0700, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2024-09-20 02:38:53)
> > On Sat, Aug 31, 2024 at 09:06:53PM GMT, Stephen Boyd wrote:

> 
> Either way the problem seems to be that I need to associate one
> drm_bridge with two displayport altmode drivers and pass some fwnode
> handle to drm_connector_oob_hotplug_event() in a way that we can map
> that back to the right output endpoint in the DP bridge graph. That
> seems to imply that we need to pass the fwnode for the usb-c-connector
> in addition to the fwnode for the drm_bridge, so that the drm_bridge
> code can look at its DT graph and find the remote node connected.
> Basically something like this:
> 
>   void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
>                                        struct fwnode_handle
> *usb_connector_fwnode,
>                                        enum drm_connector_status status)
> 
> (We might as well also pass the number of lanes here)

I think this is a bit of an overkill.

The drm_connector_oob_hotplug_event() is fine as it is, it gets
"fwnode_handle to report the event on".

What needs to be changed (in my humble opinion) is the
drm_connector_find_by_fwnode() function (or likely a new function is to
be added): if it can not find drm_connector for the passed fwnode, it
should look it up on the parent, then on parent's parent, etc, until we
actually find the drm_connector (good) or we reach the root (sad).

And finally after getting the drm_connector, the oob_hotplug_event()
callback should also receive the fwnode argument. This way the connector
(or the bridge) can identify the fwnode (aka usb-c-connector in our
case) that caused the event.

WDYT?

> Corsola could work with this design, but we'll need to teach
> dp_altmode_probe() to look for the drm_bridge elsewhere besides as the
> parent of the usb-c-connector node. That implies using the 'displayport'
> property in the cros-ec-typec node or teaching dp_altmode_probe() to
> look for the port@1/endpoint@1 remote-endpoint handle in the
> usb-c-connector graph.
> 
> Assuming the bindings you've presented here are fine and good and I got
> over the differences between Trogdor and Corsola, then I can make mostly
> everything work with the drm_connector_oob_hotplug_event() signature
> change from above and some tweaks to dp_altmode_probe() to look for
> port@1/endpoint@1 first because that's the "logical" DP input endpoint
> in the usb-c-connector binding's graph. Great! The final roadblock I'm
> at is that HPD doesn't work on Trogdor, so I can't signal HPD through
> the typec framework.

Hmm, I thought that a normal DP's HPD GPIO works on the trogdor. Was I
misunderstanding it? But then we don't know, which USB-C connector
triggered the HPD...

> This series fixes that problem by "capturing" HPD state from the
> upstream drm_bridge, e.g. msm_dp, by hooking the struct
> drm_bridge_funcs::hpd_notify() path and injecting HPD into the typec
> messages received from the EC. That's a workaround to make the typec
> framework see HPD state changes that are otherwise invisible to the
> kernel. Newer firmwares actually tell us the state of HPD properly, but
> even then we have to read a gpio mux controlled by the EC to figure out
> which usb-c-connector is actually muxing DP when HPD changes on either
> typec_port. Having a drm_bridge in cros-ec-typec helped here because we
> could hook this path and signal HPD if we knew the firmware was fixed.
> If we don't have the drm_bridge anymore, I'm lost how to do this.

It's probably okay to add one, but let me think if we can work without
it. Can we make EC driver listen for that single HPD GPIO (by making it
an actual GPIO rather than "dp_hot") and then react to it?

> 
> Maybe the right answer here is to introduce a drm_connector_dp_typec
> structure that is created by the TCPM (cros-ec-typec) that sets a new
> DRM_BRIDGE_OP_DP_TYPEC bridge op flag? And then teach
> drm_bridge_connector about this new flag, similar to the HDMI one. The
> drm_bridge could implement some function that maps the typec_port
> (usb-c-connector) to the upstream drm_bridge (ANX7625) graph port,
> possibly all in drm_bridge_connector_oob_hotplug_event() so that nothing
> else really changes. It could also let us keep hooking the hpd_notify()
> path for the workaround needed on Trogdor. And finally it may let us
> harmonize the two DT bindings so that we only have one port@1/endpoint
> node in the usb-c-connector.

I think we have lightly discussed adding drm_connector_displayport, so
that part is okay. But my gut feeling is that there should be no _typec
part in thart picture. The DRM framework shouldn't need to know all the
Type-C details.

> 
> 
> >                 };
> >         };
> >
> >         connector@1 {
> >                 port@1 {
> >                         endpoint@0 {
> >                                 remtoe = <&usb_hub_1>;
> >                         };
> >
> >                         endpoint@1 {
> >                                 remote = <&dp_bridge_out_1>;
> >                         };
> >                 };
> >         };
> > };
> >
> > dp_bridge {
> >         ports {
> >                 port@1 {
> >                         dp_bridge_out_0: endpoint@0 {
> >                                 remote = <usb_c0_ss_dp>;
> >                                 data-lanes = <0 1>;
> >                         };
> >
> >                         dp_bridge_out_1: endpoint@1 {
> >                                 remote = <usb_c1_ss_dp>;
> >                                 data-lanes = <2 3>;
> >                         };
> >                 };
> >         };
> > };
> >
> > -------
> >
> > This one is really tough example, we didn't reach a conclusion here.
> > If the EC doesn't handle lane remapping, dp_bridge has to get
> > orientation-switch and mode-switch properties (as in the end it is the
> > dp_bridge that handles reshuffling of the lanes for the Type-C). Per the
> > DisplayPort standard the lanes are fixed (e.g. DPCD 101h explicitly
> > names lane 0, lanes 0-1, lanes 0-1-2-3).
> 
> Are those logical or physical lanes?

Physical lanes as far as I understand.

> 
> I think we'll punt on this one anyway though. We don't have any plans to
> do this orientation control mechanism so far. Previous attempts failed
> and we put an extra orientation switch control on the board to do the
> orientation flipping.

Okay, it's definitely easier this way.

-- 
With best wishes
Dmitry

