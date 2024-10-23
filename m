Return-Path: <linux-acpi+bounces-8926-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A69ABAE4
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 03:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06F5284AC6
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 01:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8D22318;
	Wed, 23 Oct 2024 01:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KFN4MKVp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9C18638
	for <linux-acpi@vger.kernel.org>; Wed, 23 Oct 2024 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729646151; cv=none; b=F7NYn4D2n0b9NlR36s0qz25hhT68V///nO0XfombrGqOd+BF6c72tO8zy9brhC/9rUy6e37PeGWZ5FmDwRnq0O4xEdSne8AgrLS0/FPqzZNoUhnHOBVHVDMY6cJvwBkTde/O5ET7WcS2Ctdp0/VVrPKrzhmE43CaoizGY94BtNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729646151; c=relaxed/simple;
	bh=RMT4HqsXGZ0fWm5AB8F9pHU2Q4eg0Jt9oN9/6KaBwp0=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BN/uExVv1egvatkt8wpwPX/1vjw9e71sKHCCC+609GMYEf9nnyyRFmFzP5FHpZeJ9oSwv3qwcthhKuS5eA0qsWu6Yz5ZSNIrSWF0gVeblDFPqIcqFTDG+C1Df7BpS08OBbFoPUR8OAaGZucNLeCeRA2NIflNa+uT2sjpTDYk4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KFN4MKVp; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b149ef910eso500859785a.3
        for <linux-acpi@vger.kernel.org>; Tue, 22 Oct 2024 18:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729646149; x=1730250949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDV7eJC3+oDJ66+nOuejsfUlqPbzueqG4aQIpJGm5jM=;
        b=KFN4MKVpmbPtNoSaK7p8p1XwimxG/TM1WnLLKYpqFMhgznIfYnczcXre5u1/Sicjpp
         kirBHFPt8R+yOiISIdYfkap2N9ccp5abjcsq8yA7SS2NyRvfEwKFWGmOYtoCEt+MeQns
         nc3qAVAEH4ocT2YAUWSlY9AWMjzFqc+kpgrDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729646149; x=1730250949;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDV7eJC3+oDJ66+nOuejsfUlqPbzueqG4aQIpJGm5jM=;
        b=OZ2p6EScnBv2IPkCs2FWbDnQv77OYO6RtcswIkHnvDsyiPNliXmMaJ2yv4DeOIU97p
         xc56SAvIINqwNGMLuuGmqm1/KdQif1fjvvBmGAEStjUSY120lZETvmJryiZ14T5dRP+o
         at+zkKBGl064yweF9PNKkUBoNXZRZhV8FkGZOKP2S64TgKlYSi63EpT53+2qDSyuAv22
         +bCiNqkmU0yMHaFzIXdLFyj32/4PSBTdbwiTTP+dIt6hvg+cCX8cjEWq6ltRbznBw4Zs
         peAs9TfiIrRy+KPdBJoFptKz1T07YVtIYTHNPr4d2iztmr/sps1Mv+neOBhdpAdDt5eD
         +Kbw==
X-Forwarded-Encrypted: i=1; AJvYcCWB4PeP50WNwPpgnluP4lLaAJJypFRqArtxZLT+egX3uTfMTWO1lUYcAHzbJ1X4N/9mFodclzU33Tch@vger.kernel.org
X-Gm-Message-State: AOJu0YzXoKwneIUMYkdMvcLnsZav4Ul9fARzXQwXVE54diDlSZNDdRfU
	76ph+ivOi+iQjAEPXMc+RhLq6baaumsy25EmCWJVe3iMyjOHeDTwY1Blonrv6RhcsvrCu1nDY3J
	K/rajgrQqKsKy40b2EeFnKtzIRVE8WrH0A74z
X-Google-Smtp-Source: AGHT+IFQcx+O120v4jMcosEsD7YDeJhO0LSJsSQbSB2xO/5x1KCa08838jsJtZu4dV5T3yuW9UjApkWi+Qx0emqLoqU=
X-Received: by 2002:ac8:7f54:0:b0:460:874f:f8bf with SMTP id
 d75a77b69052e-461146ce389mr10841271cf.34.1729646148785; Tue, 22 Oct 2024
 18:15:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Oct 2024 18:15:48 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <phdcjgqqpjpruxp7v2mw446q73xr3eg4wfgfbjw5tasgr2pgg2@77swbk47b2tg>
References: <20240901040658.157425-1-swboyd@chromium.org> <20240901040658.157425-16-swboyd@chromium.org>
 <phdcjgqqpjpruxp7v2mw446q73xr3eg4wfgfbjw5tasgr2pgg2@77swbk47b2tg>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 22 Oct 2024 18:15:47 -0700
Message-ID: <CAE-0n514QMaQC2yjKP8bZqyfbv6B3AQm=+NJ87vxo6NdYiL03A@mail.gmail.com>
Subject: Re: [PATCH v4 15/18] dt-bindings: usb: Add ports to
 google,cros-ec-typec for DP altmode
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Benson Leung <bleung@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	dri-devel@lists.freedesktop.org, Guenter Roeck <groeck@chromium.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-09-20 02:38:53)
> On Sat, Aug 31, 2024 at 09:06:53PM GMT, Stephen Boyd wrote:
>
> Based on our disccusions at LPC, here are several DT examples that seem
> sensible to implement this case and several related cases from other
> ChromeBooks.

(Apologies for getting back to this late. I've been brewing on this topic
for a month; only appropriate for Halloween.)

This is the Trogdor case, one DP controller with 2 lanes DP coming out
that is steered with an analog mux controlled by the EC:

>
> typec {
>         compatible = "google,cros-ec-typec";
>
>         port {
>                 typec_dp_in: endpoint {
>                         remote-endpoint = <&usb_1_qmp_phy_out_dp>;
>                 };
>         };
>
>         usb_c0: connector@0 {
>                 compatible = "usb-c-connector";
>                 reg = <0>;
>
>                 ports {
>                         port@0 {
>                                 reg = <0>;
>                                 usb_c0_hs_in: endpoint {
>                                         remote-endpoint = <&usb_hub_dfp1_hs>;
>                                 };
>                         };
>
>                         port@1 {
>                                 reg = <1>;
>                                 usb_c0_ss_in: endpoint {
>                                         remote-endpoint = <&usb_hub_dfp1_ss>;
>                                 };
>                         };
>                 };
>         };
>
>         usb_c1: connector@1 {
>                 compatible = "usb-c-connector";
>                 reg = <1>;
>
>                 ports {
>                         port@0 {
>                                 reg = <0>;
>                                 usb_c1_hs_in: endpoint {
>                                         remote-endpoint = <&usb_hub_dfp2_hs>;
>                                 };
>                         };
>
>                         port@1 {
>                                 reg = <1>;
>                                 usb_c1_ss_in: endpoint {
>                                         remote-endpoint = <&usb_hub_dfp2_ss>;
>                                 };
>                         };
>                 };
>         };
> };
>
> &usb_1_qmpphy {
>         ports {
>                 port@0 {
>                         endpoint@0 {
>                                 data-lanes = <0 1>;
>                                 // this might go to USB-3 hub
>                         };
>
>                         usb_1_qmp_phy_out_dp: endpoint@1 {
>                                 remote-endpoint = <&typec_dp_in>;
>                                 data-lanes = <2 3>;
>                         };
>                 }
>         };
> };
>
> -------

This is one Corsola case, one DP controller (IT6505) that's an external
bridge that has 4 lanes DP but only 2 lanes of DP are usable at a time
because 2 physical lanes are wired to one usb-c-connector while the
other 2 physical lanes are wired to the other usb-c-connector. I say
"one Corsola case" because there's also a DP bridge (ANX7625) on some
Corsola variants that only has two DP lanes with a crosspoint switch
that can send those DP lanes out of one of two pairs of lanes. The other
two lanes are for USB3 output data if the part is connected to USB3 on
the input side. I suspect this ANX7625 case can be described in the same
way as below with two output endpoints and data-lanes describing which
lanes are used for either DP endpoint.

>
> typec {
>         connector@0 {
>                 port@1 {
>                         endpoint@0 {
>                                 remtoe = <&usb_hub_0>;
>                         };
>
>                         endpoint@1 {
>                                 remote = <&dp_bridge_out_0>;
>                         };

(TL;DR: I think I have a plan with the last paragraph in this section, so
I'll hack on it for a bit to see what happens.)

I'm not thrilled about having two endpoints in the SuperSpeed port@1 to
hold both signals in the Corsola case but not the Trogdor case. The
problem is that there's only one DP endpoint on Trogdor and we can't
have two remote-endpoint properties in there pointing to either
usb-c-connector. But then on Corsola we have two DP endpoints and they
both can't go to one DP input node in the typec node's graph.

To harmonize this the typec graph can have one DP input endpoint on
Trogdor while the typec graph can have two DP input endpoints on
Corsola. In both cases, the typec graph would have two USB input
endpoints, and then we can connect output endpoints to each
usb-c-connector node. It would be similar to my existing binding in this
series, except now the typec DP port can have multiple input endpoints.

I understand from our discussions at LPC that I should use
drm_connector_oob_hotplug_event() from the displayport altmode driver
(drivers/usb/typec/altmodes/displayport.c) to tell the DP bridge like
ANX7625 or IT6505 which output endpoint should be displaying DP. I think
dp_altmode_probe() looks at the usb-c-connector node's parent, e.g.
typec in the examples above, for the drm_bridge. That means we'll need
to register a drm_bridge in the cros-ec-typec compatible node? Or we
need to use the 'displayport' property in cros-ec-typec to point at the
drm_bridge node?

Either way the problem seems to be that I need to associate one
drm_bridge with two displayport altmode drivers and pass some fwnode
handle to drm_connector_oob_hotplug_event() in a way that we can map
that back to the right output endpoint in the DP bridge graph. That
seems to imply that we need to pass the fwnode for the usb-c-connector
in addition to the fwnode for the drm_bridge, so that the drm_bridge
code can look at its DT graph and find the remote node connected.
Basically something like this:

  void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
                                       struct fwnode_handle
*usb_connector_fwnode,
                                       enum drm_connector_status status)

(We might as well also pass the number of lanes here)

Corsola could work with this design, but we'll need to teach
dp_altmode_probe() to look for the drm_bridge elsewhere besides as the
parent of the usb-c-connector node. That implies using the 'displayport'
property in the cros-ec-typec node or teaching dp_altmode_probe() to
look for the port@1/endpoint@1 remote-endpoint handle in the
usb-c-connector graph.

Assuming the bindings you've presented here are fine and good and I got
over the differences between Trogdor and Corsola, then I can make mostly
everything work with the drm_connector_oob_hotplug_event() signature
change from above and some tweaks to dp_altmode_probe() to look for
port@1/endpoint@1 first because that's the "logical" DP input endpoint
in the usb-c-connector binding's graph. Great! The final roadblock I'm
at is that HPD doesn't work on Trogdor, so I can't signal HPD through
the typec framework.

This series fixes that problem by "capturing" HPD state from the
upstream drm_bridge, e.g. msm_dp, by hooking the struct
drm_bridge_funcs::hpd_notify() path and injecting HPD into the typec
messages received from the EC. That's a workaround to make the typec
framework see HPD state changes that are otherwise invisible to the
kernel. Newer firmwares actually tell us the state of HPD properly, but
even then we have to read a gpio mux controlled by the EC to figure out
which usb-c-connector is actually muxing DP when HPD changes on either
typec_port. Having a drm_bridge in cros-ec-typec helped here because we
could hook this path and signal HPD if we knew the firmware was fixed.
If we don't have the drm_bridge anymore, I'm lost how to do this.

Maybe the right answer here is to introduce a drm_connector_dp_typec
structure that is created by the TCPM (cros-ec-typec) that sets a new
DRM_BRIDGE_OP_DP_TYPEC bridge op flag? And then teach
drm_bridge_connector about this new flag, similar to the HDMI one. The
drm_bridge could implement some function that maps the typec_port
(usb-c-connector) to the upstream drm_bridge (ANX7625) graph port,
possibly all in drm_bridge_connector_oob_hotplug_event() so that nothing
else really changes. It could also let us keep hooking the hpd_notify()
path for the workaround needed on Trogdor. And finally it may let us
harmonize the two DT bindings so that we only have one port@1/endpoint
node in the usb-c-connector.


>                 };
>         };
>
>         connector@1 {
>                 port@1 {
>                         endpoint@0 {
>                                 remtoe = <&usb_hub_1>;
>                         };
>
>                         endpoint@1 {
>                                 remote = <&dp_bridge_out_1>;
>                         };
>                 };
>         };
> };
>
> dp_bridge {
>         ports {
>                 port@1 {
>                         dp_bridge_out_0: endpoint@0 {
>                                 remote = <usb_c0_ss_dp>;
>                                 data-lanes = <0 1>;
>                         };
>
>                         dp_bridge_out_1: endpoint@1 {
>                                 remote = <usb_c1_ss_dp>;
>                                 data-lanes = <2 3>;
>                         };
>                 };
>         };
> };
>
> -------
>
> This one is really tough example, we didn't reach a conclusion here.
> If the EC doesn't handle lane remapping, dp_bridge has to get
> orientation-switch and mode-switch properties (as in the end it is the
> dp_bridge that handles reshuffling of the lanes for the Type-C). Per the
> DisplayPort standard the lanes are fixed (e.g. DPCD 101h explicitly
> names lane 0, lanes 0-1, lanes 0-1-2-3).

Are those logical or physical lanes?

I think we'll punt on this one anyway though. We don't have any plans to
do this orientation control mechanism so far. Previous attempts failed
and we put an extra orientation switch control on the board to do the
orientation flipping.

