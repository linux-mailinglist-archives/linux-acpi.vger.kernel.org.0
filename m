Return-Path: <linux-acpi+bounces-9204-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5ED9B82B8
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 19:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB5D283136
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 18:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC511C9DFB;
	Thu, 31 Oct 2024 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5wbCmJr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4C1C9DCD
	for <linux-acpi@vger.kernel.org>; Thu, 31 Oct 2024 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400168; cv=none; b=LIlEuFGzrsEqbzWYbeSC3Z79pSIv5PbqIstTseV7UlLPujgg9e/P10HAf4oNihGf0Me5ZXEabZxH9ybqIuiHSS3opFMsSFXpKX/WZwHrKoXFosnXhSYdgeTbieFKCs75pLxMFftMGwxywzJyi3pNxNXlCwgTxj0UZlvDGF4ZJEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400168; c=relaxed/simple;
	bh=iyC1K+aHZj50hiN8zKRt95gU+Gy82SLqZJPwNQDOQnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJNvCZtnHOiRfjLr8l4r2wM12tIyKe1sTiiorHSyJ2f+xAqfWpMAmEn4X2FFhI++kePderZQjR4UZw7t9Geb3uELZ/1ayraO4uoBoXWZwDY6ZibC+fTb2ejIlV7+pqKzdiuViEto0gEYTCBpoulIOY+jFCAqVFfNK30BX/CX0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c5wbCmJr; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so11909751fa.1
        for <linux-acpi@vger.kernel.org>; Thu, 31 Oct 2024 11:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730400164; x=1731004964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9mbgmHLn4hkidzibtmbgVdxuSze2Xy6FGjf01Pt2smo=;
        b=c5wbCmJrg3kzKPLbmtNIrZK8ikK0wUDWdZT99y1cs/YdUHWW8U5A0NoLHsR0Cjl77E
         IslL8StEa1NNr5BINyyQU73BzltOiNIa5jfYHcmEqgcrD+yqItsWV0BbhLDwjY232DMO
         bHuvHJwX8UOdrWywfDntHBXYjdniHr7EL7uEaKDcvz6/tHCdO5K7Ff/cYUxhPofvxj8e
         INJ+XIGgH2GCLdQYTnt4GDmCrayMxXO/SGASpJ896pZRg0y+1h68j5jjGH101pQ085dQ
         VIbhTdS5sVA06esQktlpL9PI/wWiE8yio2LQSpwWvI3Tor2kcVQhwYgcEzsk4SQ2Jxrs
         PWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730400164; x=1731004964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mbgmHLn4hkidzibtmbgVdxuSze2Xy6FGjf01Pt2smo=;
        b=g6J1SF657VjPovA8teqRWkVR3rx6bzIa61MhdfUg1BeSoJBnfNCrH1AXSjFAOWmA2o
         ec3Rqloi7VSSaVZ4/0L2W2vBAjkKjpqm+TtBorDFmeL5K7r5RrRNt+TadgEfdP+jMEU0
         JfIWccKq4aFsirNmTieSVU4y392tUgPxi6iZcplB98XhTAJT4tbKFpLzSY6aerm7bmGi
         RG17OmNvXjwGZBHfPErdThV6l5fCzlyVJ/bSiZJ2XtUrr59Xfpgx6LzWWg6m4DPdB6aM
         dhfv6Ody467fv2e0kWilJslz6KbtH+YFgM0fTHtM6Z0rbCojkldUwqHhUYHeVOPTRAWW
         5fZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6hwheGje0frDS5iChwZWteQ9mff6nffNdTigU5qYCe76qt7WdEG0s58Onvn+Ji9ZQPf6J0nKs87fg@vger.kernel.org
X-Gm-Message-State: AOJu0YxUrQ1FIiUjJuBzHEH8SuJbL4cVo3xUNFvI3Rt2P9aneemz898g
	U4Wegb13XMlBfaTM7R1gvNafHzbiXQ5JwuzqA8jHLc7e/w01UA9W4uWGp+rtlTc=
X-Google-Smtp-Source: AGHT+IGWhda+crxSXmmfomPzg+L773MkY6bHphixow0At3+T7amJS9Ed/gUMhUaDKwBOL563vJN1wQ==
X-Received: by 2002:a2e:b8c8:0:b0:2fb:4b0d:9092 with SMTP id 38308e7fff4ca-2fcbdf69fbemr100872501fa.1.1730400163522;
        Thu, 31 Oct 2024 11:42:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8a6013sm2915101fa.82.2024.10.31.11.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 11:42:40 -0700 (PDT)
Date: Thu, 31 Oct 2024 20:42:36 +0200
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
Message-ID: <yk3xidaisbd56yndaucax7otijjauqmm7lqm6q4q633kdawlqo@qaq27lwxmvwd>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-16-swboyd@chromium.org>
 <phdcjgqqpjpruxp7v2mw446q73xr3eg4wfgfbjw5tasgr2pgg2@77swbk47b2tg>
 <CAE-0n514QMaQC2yjKP8bZqyfbv6B3AQm=+NJ87vxo6NdYiL03A@mail.gmail.com>
 <lf7y7wpuca6kzqcglgs5d443iusf7xjocum4adi7t3npfavccx@zgsp37oyztme>
 <CAE-0n53-KmOS3zXmJPvOOZ7xxkek9-S=oBExgaY0PDnt_HjdNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53-KmOS3zXmJPvOOZ7xxkek9-S=oBExgaY0PDnt_HjdNw@mail.gmail.com>

On Tue, Oct 29, 2024 at 01:15:51PM -0700, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2024-10-25 03:49:36)
> > On Tue, Oct 22, 2024 at 06:15:47PM -0700, Stephen Boyd wrote:
> > > Quoting Dmitry Baryshkov (2024-09-20 02:38:53)
> > > > On Sat, Aug 31, 2024 at 09:06:53PM GMT, Stephen Boyd wrote:
> >
> > >
> > > Either way the problem seems to be that I need to associate one
> > > drm_bridge with two displayport altmode drivers and pass some fwnode
> > > handle to drm_connector_oob_hotplug_event() in a way that we can map
> > > that back to the right output endpoint in the DP bridge graph. That
> > > seems to imply that we need to pass the fwnode for the usb-c-connector
> > > in addition to the fwnode for the drm_bridge, so that the drm_bridge
> > > code can look at its DT graph and find the remote node connected.
> > > Basically something like this:
> > >
> > >   void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
> > >                                        struct fwnode_handle
> > > *usb_connector_fwnode,
> > >                                        enum drm_connector_status status)
> > >
> > > (We might as well also pass the number of lanes here)
> >
> > I think this is a bit of an overkill.
> >
> > The drm_connector_oob_hotplug_event() is fine as it is, it gets
> > "fwnode_handle to report the event on".
> 
> Ok. I understand that drm_*() shouldn't know about USB or type-c in
> general.
> 
> >
> > What needs to be changed (in my humble opinion) is the
> > drm_connector_find_by_fwnode() function (or likely a new function is to
> > be added): if it can not find drm_connector for the passed fwnode, it
> > should look it up on the parent, then on parent's parent, etc, until we
> > actually find the drm_connector (good) or we reach the root (sad).
> >
> > And finally after getting the drm_connector, the oob_hotplug_event()
> > callback should also receive the fwnode argument. This way the connector
> > (or the bridge) can identify the fwnode (aka usb-c-connector in our
> > case) that caused the event.
> >
> > WDYT?
> 
> Ok I think I'm following along. The dp->connector_fwnode in
> displayport.c will always be the usb-c-connector node in your example?
> And that will search for the connector or bridge associated with that
> usb-c-connector node. Then when it comes time to call
> drm_connector_oob_hotplug_event() it will take the usb-c-connector
> fwnode as 'connector_fwnode' and in that function we'll make
> drm_connector_find_by_fwnode() implement the parent walk? The
> cros-ec-typec compatible node will register a drm_bridge in all cases,
> and that is the parent of the usb-c-connector node, so the walk will end
> there.
> 
> Then you want to pass the usb-c-connector fwnode to
> connector->funcs->oob_hotplug_event()? So
> drm_bridge_connector_oob_hotplug_event() changes to also get the
> usb-c-connector fwnode. This plan should work.

Yes, that was my proposal. This way we know the origin device (bridge /
connector) and let it take care of any details on its own.

> At this point we need to tell the DP bridge, like IT6505, that it's one
> or the other output endpoints that it should use, but we haven't
> directly connected the usb-c-connector to the output ports of IT6505
> because drm_of_find_panel_or_bridge() can't find the parent of the
> usb-c-connector if we connect the DP bridge to the usb-c-connector
> graphs. We'll need a way for the bridge to know which output port is
> connected to a usb-c-connector fwnode. Some sort of API like

I think that the final bridge should be the IT6505. It can save you from
some troubles, like the inter-bridge lane negotiation. Please remember
that using lanes 2-3 as primary lanes doesn't seem to fall into the
standard DisplayPort usage. It is documented by USB-C and only because
of the orientation switching.

Maybe that's just it? Register DP_bridge (or QMP PHY) as
orientation-switch? Then you don't need any extra API for the lane
mapping? The cross-ec-typec can provide orientation information and the
USB-C-aware controller will follow the lane mapping.

> 
>  fwnode_graph_get_endpoint_connected_to_fwnode(bridge_fwnode, usb_c_fwnode)
> 
> that takes the bridge fwnode and traverses the graph to find the
> endpoint in that's connected to 'usb_c_fwnode'. That traversal API will
> need help from the intermediate node, cros-ec-typec, so maybe it is
> better as a drm_bridge API that uses some new drm_bridge_funcs callback.
> This way IT6505 can ask the bridge chain which output DP endpoint is
> actually associated with the connector fwnode it gets from the
> oob_hotplug_event() callback.
> 
> Here's the two DT snippets that I've ended up with:
> 
> typec {
>         compatible = "google,cros-ec-typec";
> 
>         ports {
>                 port@0 {
>                         reg = <0>;
>                         typec_dp_in: endpoint {
>                                  remote-endpoint = <&usb_1_qmp_phy_out_dp>;
>                         };
>                 };
> 
>                 port@1 {
>                         reg = <1>;
>                         typec_usb0_in: endpoint@0 {
>                                  reg = <0>;
>                                  remote-endpoint = <&usb_hub_dfp1_ss>;
>                         };
>                         typec_usb1_in: endpoint@1 {
>                                  reg = <1>;
>                                  remote-endpoint = <&usb_hub_dfp2_ss>;
>                         };
>                 }
> 
>                 // This port is not really needed because we know the
> 		// mapping from input ports to usb-c-connectors
>                 port@2 {
>                         reg = <2>;
>                         typec0_out: endpoint@0 {
>                                  reg = <0>;
>                                  remote-endpoint = <&usb_c0_ss_in>;
>                         };
>                         typec1_out: endpoint@1 {
>                                  reg = <1>;
>                                  remote-endpoint = <&usb_c1_ss_in>;
>                         };
>                 }

Why do we need these two ports? Can't &usb_hub_dfpN_ss be connected
directly to the usb_cN_ss_in? I understand that you probably want to
express the internal structure of the lane switching, but I think that's
a bit of the overkill. Leaving this to the other commenters / DT
maintainers.

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
>                                         remote-endpoint = <&typec0_out>;
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
>                                         remote-endpoint = <&typec1_out>;
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
> 
> typec {
>         ports {
>                 port@0 {
>                         reg = <0>;
>                         typec_dp0_in: endpoint@0 {
>                                  reg = <0>;
>                                  remote-endpoint = <&dp_bridge_out_0>;
>                         };
>                         typec_dp1_in: endpoint@1 {
>                                  reg = <1>;
>                                  remote-endpoint = <&dp_bridge_out_1>;
>                         };
>                 };
> 
>                 port@1 {
>                         reg = <1>;
>                         typec_usb0_in: endpoint@0 {
>                                  reg = <0>;
>                                  remote-endpoint = <&usb_hub_0_ss>;
>                         };
>                         typec_usb1_in: endpoint@1 {
>                                  reg = <1>;
>                                  remote-endpoint = <&usb_hub_1_ss>;
>                         };
>                 }
>         };
> 
>         connector@0 {
>                 port@1 {
>                         endpoint@0 {
>                                 remote-endpoint = <&usb_hub_0_hs>;

port@1 is for SS lanes, so something is wrong here.

>                         };
>                 };
>         };
> 
>         connector@1 {
>                 port@1 {
>                         endpoint@0 {
>                                 remote-endpoint = <&usb_hub_1_hs>;
>                         };
>                 };
>         };
> };
> 
> dp_bridge {
>         ports {
>                 port@1 {
>                         dp_bridge_out_0: endpoint@0 {
>                                 remote-endpoint = <&typec_dp0_in>;
>                                 data-lanes = <0 1>;
>                         };
> 
>                         dp_bridge_out_1: endpoint@1 {
>                                 remote-endpoint = <&typec_dp1_in>;
>                                 data-lanes = <2 3>;
>                         };
>                 };
>         };
> };
> 
> -------
> 
> I wonder about a case where we may take two lanes and connect them to a
> usb-c-connector and then take the other two lanes and send them through
> a mux to two more usb-c-connectors. I think we'll need another property
> in that case that indicates which input DP endpoints correspond to the
> usb-c-connector nodes.
> 
> typec {
>         ports {
>                 port@0 {
>                         reg = <0>;
>                         typec_dp0_in: endpoint@0 {
>                                  reg = <0>;
>                                  remote-endpoint = <&dp_bridge_out_0>;
>                         };
>                         typec_dp1_in: endpoint@1 {
>                                  reg = <1>;
>                                  remote-endpoint = <&dp_bridge_out_1>;
>                         };
>                 };
> 
>                 port@1 {
>                         reg = <1>;
>                         typec_usb0_in: endpoint@0 {
>                                  reg = <0>;
>                                  remote-endpoint = <&usb_hub_0_ss>;
>                         };
>                         typec_usb1_in: endpoint@1 {
>                                  reg = <1>;
>                                  remote-endpoint = <&usb_hub_1_ss>;
>                         };
>                         typec_usb2_in: endpoint@2 {
>                                  reg = <2>;
>                                  remote-endpoint = <&usb_hub_2_ss>;
>                         };
>                 }
>         };
> 
> 	dp-2-usb-mapping = <0 0>, <1 1>, <1 2>;

dp-to-typec-mapping?

> };
> 
> This property would indicate dp endpoint 0 goes to usb-c-connector 0
> while dp endpoint 1 goes to usb-c-connector 1 and 2. I don't have this
> hardware but I could see how someone might do this by adding another mux
> that the EC controls. I don't want to design a binding and have to
> rework it in the future to handle this new case. I hope adding a new
> property, or getting more information from the EC firmware, will be
> sufficient to describe the linkage between the DP endpoint and the
> connectors managed by the cros-ec-typec device.

Does it change anything from the DP point of view? It is still either
lanes 0-1 or lanes 2-3? I'd really like to inject the hotplug OOB event
to the dp_bridge letting it get one of the endpoints as a HPD even
source.

> > > Corsola could work with this design, but we'll need to teach
> > > dp_altmode_probe() to look for the drm_bridge elsewhere besides as the
> > > parent of the usb-c-connector node. That implies using the 'displayport'
> > > property in the cros-ec-typec node or teaching dp_altmode_probe() to
> > > look for the port@1/endpoint@1 remote-endpoint handle in the
> > > usb-c-connector graph.
> > >
> > > Assuming the bindings you've presented here are fine and good and I got
> > > over the differences between Trogdor and Corsola, then I can make mostly
> > > everything work with the drm_connector_oob_hotplug_event() signature
> > > change from above and some tweaks to dp_altmode_probe() to look for
> > > port@1/endpoint@1 first because that's the "logical" DP input endpoint
> > > in the usb-c-connector binding's graph. Great! The final roadblock I'm
> > > at is that HPD doesn't work on Trogdor, so I can't signal HPD through
> > > the typec framework.
> >
> > Hmm, I thought that a normal DP's HPD GPIO works on the trogdor. Was I
> > misunderstanding it? But then we don't know, which USB-C connector
> > triggered the HPD...
> 
> By HPD not working on Trogdor I mean that the EC doesn't tell the kernel
> about the state of HPD for a usb-c-connector in software. Instead, HPD
> is signaled directly to the DP controller in hardware via a GPIO. It is
> as you suspect, we don't know which USB-C connector has HPD unless we
> read the mux controlled by the EC and combine that with what the DP
> driver knows about the state of the HPD pin.

I see. So the HPD event gets delivered to the DP controller, but we
really need some API to read the port? If it's not the
orientation-switch, of course.

> 
> >
> > > This series fixes that problem by "capturing" HPD state from the
> > > upstream drm_bridge, e.g. msm_dp, by hooking the struct
> > > drm_bridge_funcs::hpd_notify() path and injecting HPD into the typec
> > > messages received from the EC. That's a workaround to make the typec
> > > framework see HPD state changes that are otherwise invisible to the
> > > kernel. Newer firmwares actually tell us the state of HPD properly, but
> > > even then we have to read a gpio mux controlled by the EC to figure out
> > > which usb-c-connector is actually muxing DP when HPD changes on either
> > > typec_port. Having a drm_bridge in cros-ec-typec helped here because we
> > > could hook this path and signal HPD if we knew the firmware was fixed.
> > > If we don't have the drm_bridge anymore, I'm lost how to do this.
> >
> > It's probably okay to add one, but let me think if we can work without
> > it. Can we make EC driver listen for that single HPD GPIO (by making it
> > an actual GPIO rather than "dp_hot") and then react to it?
> 
> I don't know how we handle the attention message, HPD_IRQ, because
> that's a short pulse that the kernel may miss when this is a GPIO that
> has to be triggered when both falling and rising. When the pin goes
> directly to the DP controller this is fine because the hardware can
> detect that. Similarly, when the EC sends the message about an HPD_IRQ
> we can replay that into the type-c framework and signal attention
> through drm_connector_oob_hotplug_event()/hpd_notify() paths.

Ack.

> 
> >
> > >
> > > Maybe the right answer here is to introduce a drm_connector_dp_typec
> > > structure that is created by the TCPM (cros-ec-typec) that sets a new
> > > DRM_BRIDGE_OP_DP_TYPEC bridge op flag? And then teach
> > > drm_bridge_connector about this new flag, similar to the HDMI one. The
> > > drm_bridge could implement some function that maps the typec_port
> > > (usb-c-connector) to the upstream drm_bridge (ANX7625) graph port,
> > > possibly all in drm_bridge_connector_oob_hotplug_event() so that nothing
> > > else really changes. It could also let us keep hooking the hpd_notify()
> > > path for the workaround needed on Trogdor. And finally it may let us
> > > harmonize the two DT bindings so that we only have one port@1/endpoint
> > > node in the usb-c-connector.
> >
> > I think we have lightly discussed adding drm_connector_displayport, so
> > that part is okay. But my gut feeling is that there should be no _typec
> > part in thart picture. The DRM framework shouldn't need to know all the
> > Type-C details.
> >
> 
> Alright, got it.

-- 
With best wishes
Dmitry

