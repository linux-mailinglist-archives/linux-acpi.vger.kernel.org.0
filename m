Return-Path: <linux-acpi+bounces-9496-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C34A9C4C78
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 03:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2551F23751
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 02:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16DB204F97;
	Tue, 12 Nov 2024 02:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X2K2hn+S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC2820495B
	for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2024 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731377791; cv=none; b=E5qtDhZkao5dA/UQQ1qdL+gpuPO7sEJgBB18pNDck78Yzm6Zlil7fBaGuDFRFhj+aLO/IZymKQV3MA4pKOUwH/3q7qnnsh9fXdhaHc/Y3SI8F5efDVdfi+37OAM9B+Uv+eanuI/abQw6h1VV7fnBXcQOkxxJYI05T+8i83ZBwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731377791; c=relaxed/simple;
	bh=NxRKeUzGQNckc94jdll6DwNIvw1FmonhQhpVuy4egzI=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/bVtwZ+lFnjPz4bzn05YF61evOq9DeTx6VHdXMF3wXw6IST3UKbQQz74LK9ktxR1tzbwfwaHmGBq72yXeZP9DqpG7M4vqD9qAeqxz4b0Yx7F1pbN0d7Z9D1ToGR686O0scnKi0eJc9vGszZsOvECuxFdWHteA4wVrru5sIKJu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X2K2hn+S; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-51432ac4082so624579e0c.0
        for <linux-acpi@vger.kernel.org>; Mon, 11 Nov 2024 18:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731377788; x=1731982588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxRKeUzGQNckc94jdll6DwNIvw1FmonhQhpVuy4egzI=;
        b=X2K2hn+S/nI9Jp6Mbaa6ZzyNxBGkDv6KAr8AQwellNoAfTqMQ8oFJzFSmgO4mrBMyn
         z96gblR+kymGpX3P2qRA1/XIAXutB8tnYgy9TpttIbc1M8myEG9PP6B7kt43wAhg5Tm1
         E8uK6fwoQUp8R9JxcGLV1ZuvW8TbamsZqCyXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731377788; x=1731982588;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxRKeUzGQNckc94jdll6DwNIvw1FmonhQhpVuy4egzI=;
        b=GqHX/R7Ys3HH9g6IVxW64L2+q9zWLktLIq7zsY3V3X1bgi45lD2jOCXS9XtPpEmjbw
         gd8wbdJfUxcS69nCDbX8vtfsPH31vGUNHlkpBGsVQ32jVYmlvISrNxrbtsLU8WMRQqoQ
         e2XafrSkGJopqJIf7+zULImSBKzyK5nTeoMHtTIAAxU2n3bATyuda8xlKTbezJFZ1x3M
         UPtXUjgZyMC0VBhaoWtvNnLXiEbb1845CF39PqJGcDv0cnf5L0N+9NerPCTpW/MMwojA
         v/58LCWcqLaSin8ziEZy6jRGA4wu5df1ePIZPO7v2KcaQBMUlZmXxbUK9/TbN+GZp8f+
         TOrA==
X-Forwarded-Encrypted: i=1; AJvYcCXJiFZLQp45xCqvmRy1PWDYU1tukfw8YzqK7NuiNXthmvQyuW5Xc5toDRsbeiqANb6wSN9V+1lsYvJQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwN3sxwgXfjrCs4nPFz9bFrGEp1yjtCn0HEi7+Nvnq6kVSZ5yex
	Ohs8eyDutZrTEAVOjRHP0kq9RvdwS+LRhNt0oRBIS68jUuGf+NQqiUkry78XSVleiqzJCTEya6u
	GQZGe6ZOwePEte18a3vnclBa8k8qy78xIWgsm
X-Google-Smtp-Source: AGHT+IFhUIXP7ugxUy7Dy8ell04Jmp5igMqxBklJN6VB90eF5BUKVkmxt6TVApQ3QciA6G8tm/1mdhhf0qwz2BvQ98Y=
X-Received: by 2002:a05:6122:3d13:b0:50d:35d9:ad60 with SMTP id
 71dfb90a1353d-51401ba6e0emr14533759e0c.5.1731377788451; Mon, 11 Nov 2024
 18:16:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Nov 2024 18:16:28 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <hqmx7jtkvrwvb27n56hw7rpefhp37lhr3a5fawz7gsl76uuj5s@h7m6wpdhibkk>
References: <20240901040658.157425-1-swboyd@chromium.org> <phdcjgqqpjpruxp7v2mw446q73xr3eg4wfgfbjw5tasgr2pgg2@77swbk47b2tg>
 <CAE-0n514QMaQC2yjKP8bZqyfbv6B3AQm=+NJ87vxo6NdYiL03A@mail.gmail.com>
 <lf7y7wpuca6kzqcglgs5d443iusf7xjocum4adi7t3npfavccx@zgsp37oyztme>
 <CAE-0n53-KmOS3zXmJPvOOZ7xxkek9-S=oBExgaY0PDnt_HjdNw@mail.gmail.com>
 <yk3xidaisbd56yndaucax7otijjauqmm7lqm6q4q633kdawlqo@qaq27lwxmvwd>
 <CAE-0n501j+8bMnMKabFyZjn+MLUy3Z68Hiv1PsfW0APy5ggN8g@mail.gmail.com>
 <gstohhcdnmnkszk4l2ikd5xiewtotgo5okia62paauj6zpaw7y@4wchyvoynm2p>
 <CAE-0n50z6MNa7WOsg-NU7k8BpFeJJyYfHX3ov6DsthLWauSNpA@mail.gmail.com> <hqmx7jtkvrwvb27n56hw7rpefhp37lhr3a5fawz7gsl76uuj5s@h7m6wpdhibkk>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Mon, 11 Nov 2024 18:16:27 -0800
Message-ID: <CAE-0n50y1O2C47zOGJPmMjKXK_m6a=jhpEAP4nW+RymZbo2xyg@mail.gmail.com>
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

Quoting Dmitry Baryshkov (2024-11-08 23:05:18)
> On Thu, Nov 07, 2024 at 04:28:24PM -0800, Stephen Boyd wrote:
> > Quoting Dmitry Baryshkov (2024-10-31 15:54:49)
> > > On Thu, Oct 31, 2024 at 02:45:29PM -0700, Stephen Boyd wrote:
> > > > Quoting Dmitry Baryshkov (2024-10-31 11:42:36)
> > > > > On Tue, Oct 29, 2024 at 01:15:51PM -0700, Stephen Boyd wrote:
> > Long story short, I don't see how we can avoid _any_ lane assignment
> > logic in drm_bridge. The logic shouldn't walk the entire bridge chain,
> > but it should at least act on the bridge that is a DP bridge. I think
> > you're saying pretty much the same thing here, but you want the lane
> > remapping to be done via the typec layer whereas I want it to be done in
> > the drm_bridge layer. To me it looks out of place to add a
> > typec_switch_desc inside each DP drm_bridge because we duplicate the
> > logic about USB type-c DP altmode lane assignment to each DP bridge. A
> > DP bridge should just think about DP and not know or care about USB
> > type-c.
> >
> > This is what's leading me to think we need some sort of lane assignment
> > capability at the DP connector. How that assignment flows from the DP
> > connector created in drm_bridge_connector.c to the hardware is where it
> > is less clear to me. Should that be implemented as a typec_switch_desc,
> > essentially out of band with drm_bridge, or as some drm_bridge_funcs
> > function similar to struct drm_bridge_funcs::hdmi_*()? If you look at
> > IT6505 in it6505_get_extcon_property() it actually wants to pull the
> > orientation of the type-c port with extcon_get_property(EXTCON_DISP_DP,
> > EXTCON_PROP_USB_TYPEC_POLARITY). Maybe pushing the orientation to the DP
> > bridge is backwards and we should be exposing this as some sort of
> > connector API that the drm_bridge can query whenever it wants.
>
> And it6505_get_extcon_property() / EXTCON_PROP_USB_TYPEC_POLARITY is a
> Type-C code, isn't it?
>

Sort of? It's combining DP and USB_TYPEC enums there so it's not very
clear if it's one or the other instead of just both.

> > and then a drm_bridge is created in cros-ec to terminate the bridge
> > chain. The displayport altmode driver will find the drm_bridge and the
> > drm_connector from the cros-ec node. When DP altmode is entered the
> > displayport altmode driver will set the drm_connector orientation based
> > on the presence of the dp-reverse-orientation property. We'll be able to
> > hook the hpd_notify() path in cros-ec by adding code to the drm_bridge
> > made there to do the HPD workaround. I'm not sure we need to use an
> > auxiliary device in this case, because it's a one-off solution for
> > cros-ec. And we don't even need to signal HPD from the cros-ec
> > drm_bridge because the oob_hotplug event will do it for us. If anything,
> > we need that displayport.c code to skip sending the hotplug event when
> > "no-hpd" is present in the cros-ec node. Note, this works for any number
> > of usb-c-connector nodes. And finally, DP bridges like IT6505 don't need
> > to implement a typec_switch_desc, they can simply support flipping the
> > orientation by querying the drm_connector for the bridge chain when they
> > see fit. ANX7625 can support that as well when it doesn't see the
> > 'orientation-switch' property.
> >
> > Did I miss anything? I suspect a drm_connector having an orientation is
> > the most controversial part of this proposal.
>
> Yes... I understand that having orientation-switch handling in the DRM
> driver sounds strange, but this is what we do in the QMP PHY driver. It
> makes the code easier, as it keeps lane remapping local to the place
> where it belongs - to the Type-C handlers.
>

The QMP PHY is a type-c PHY, similar to ANX7625. It sits on the output
of the DP and USB PHYs and handles the type-c orientation and lane
merging for different USB type-c alternate modes. It's not a great
example of a plain DP bridge because it combines USB and USB type-c
features.

Either way, doing this through Type-C handlers is weird because the port
orientation in the Type-C framework is for the connector and there is an
orientation control hardware that handles the orientation already. For
example, with the IT6505 part on Corsola, the orientation is controlled
by a redriver part that the EC controls. It takes the DP and USB signals
and routes them to the correct pins on the usb-c-connector depending on
the cable orientation. The input side pinout is basically 2 or 4 lanes
DP and 2 lanes USB and the output side pinout is the USB type-c pinout
SSTXRX1 and SSTXRX2.

This redriver is equivalent to the QMP PHY type-c part. Maybe to bring
this example closer to QMP we can imagine if the QMP PHY was split into
two pairs of lanes, and the USB functionality wasn't used. The
orientation control for a usb-c-connector would be on a redriver that
takes 2 DP lanes from the QMP PHY as input. Saying that this QMP PHY is
the "orientation-switch" with that property in DT is confusing, because
it isn't controlling the orientation of the type-c port. The orientation
is handled by the redriver. That redriver may even be controlled by the
kernel as an orientation-switch.

I understand that the QMP PHY driver has implemented the lane control
for orientation with a typec_switch_desc, but the QMP PHY is a plain DP
PHY in this scenario. How would the type-c handlers work here? We
couldn't call them through the type-c framework as far as I can tell.

This is why I'm thinking the end of the bridge chain needs to have some
sort of orientation. If we had that then the place where the chain ends
and becomes muxed onto the usb-c-connector, i.e. the redriver, would be
where the DP bridge is told that it needs to flip the lanes. In the
cases I have, the redriver is the EC, and so we've combined them all
together in one node, cros-ec-typec. In the QMP PHY case the redriver is
the QMP PHY type-c part that sits on the DP and USB PHYs and sends their
signals out of the SoC.

Maybe the DT property in the ANX7625 or IT6505 node should be something
like "dp-orientation-switch" and then we have the type-c framework find
this property? Then we would need to add support for that property in
IT6505 using a typec_switch_desc, which is weird. I guess it all feels
like a hack because it's not always the case that the DP PHY is glued to
a USB type-c PHY.

