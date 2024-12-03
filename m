Return-Path: <linux-acpi+bounces-9908-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D799E3014
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 00:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 608A4B227B3
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 23:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6187209F38;
	Tue,  3 Dec 2024 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RDOBMIxV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5E1E0E16
	for <linux-acpi@vger.kernel.org>; Tue,  3 Dec 2024 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733269861; cv=none; b=lzSRXkQZkxkejCziLxVdQ8j6SYC6zWtqQyv6se9aF++C0+w8qt19dUVuWKz4mp57Xi9/+EHm97rxkovcwm0ZJZjIyimZ7ajhnEFaYvIYKrlqvv8JmVZ8QKIYOTMsZXIEqC7JoYDaReYDjkDC+dn/xUnhBUb3s54aCyT7vOxGCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733269861; c=relaxed/simple;
	bh=R45xxkijHNvo3KBLPSidEKjRiqPbaArVtuFKk4DrS9Y=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrJcfIDRmPaAgjGT4okZa641d0+/iQ6WNfePiUp4fd76s0eB21Z8QcF7df+6pYEdqPwvTTT7Yq+8XVJmzwpoVe6CEbR3vD57xaFVSl4sIaRrs/ElSC+Oteykyr8RgKZZewh0MkHzhJpLoVPuk0Vm+mptmIjjdOKvYwEyxKHMcZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RDOBMIxV; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d888c38841so36888376d6.3
        for <linux-acpi@vger.kernel.org>; Tue, 03 Dec 2024 15:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733269859; x=1733874659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnjgP+/pVl9iI2xT3/J2oBRnCck1VdgzOQo4g6wMy/Y=;
        b=RDOBMIxVRl0oMVWC0oFXwAUz5pK8kv+l9guJQGcjiTgsnnpPeNr5WM1vDRAxsYE1A7
         ktEOxVW9cWLA8rEolAtqDCcyagdjmJy1Nkr3JwKpfF/OiS9S5jk6gds9nKiBfDTL6wiD
         XYed4aOP/d4VVmblYx/wPcztTz5X7fsp9e374=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733269859; x=1733874659;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnjgP+/pVl9iI2xT3/J2oBRnCck1VdgzOQo4g6wMy/Y=;
        b=iWMy2vJhc0zg31w31qFpiYYWtfVz8OrPRdVik3KEQgyKrshq2xSOMp/MSxfk64RDao
         M1G9LXYBj4Nfn8FhDZcV+CAuBePO73YZMiy6Nuh7OWe5Na0Z54sePl8KpALNXRSdtDuj
         mB2R3spEzXC3ofLIIBnrhefn5nlENbZHJRIPg4dDD9r01Pi1p6QYWQfaW4AzoL09V5ke
         bxuhVwiHsMB3KxnYvfd6xNDuJc7y1g/Mv0QpaB49GY4wXQg06K4yxT3qZ+I/1CrZ5Ja0
         xTEmfik6zsMLgeUunLi3QIN3C3BYmp+DcvxlCB/Qhp7PUuQp49I2ilm9x+5HbQOQe557
         s5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfQxOETahGPZqQWfTwjDYul8B72CR99dFqei8yhC4t52OuG5Or3OdnXNvT7V0XW8CvCD0jdqGcthyV@vger.kernel.org
X-Gm-Message-State: AOJu0YxLCF8YYRiVKsvKvTy8gHDHPXP4Lg/zAiDpen9WoZhG0Wx2WRYb
	vJs2E2qiKAe/R/zxjSl285rSxJ3glkUYXPk5aG9q1TvCtXvrx0FTac6JMqS2kbdX32/y2G4FY/Q
	q4Yyo85e/uzzdozUPZYHAE4CQjW1CGOtowHML
X-Gm-Gg: ASbGncvxgivN8LA1+QIOVaG9RTmBb3SC3fKY/RLRtUa9kxsJS+wogQFYqAIyhkRVoLK
	4dEiGzVkXtWo3T1FjMc1lcluQ5kHd4m5p9YEQAj0mxz5mS8nvtTmi8A9ycS4=
X-Google-Smtp-Source: AGHT+IHEgBXWoi8BJHO3jSXOG7m1oHxpYBSZUKMhC1usrxD/ibe1QmfujCFJzYfILghK3QdcAVLyYpr9Sv5mqRngbJA=
X-Received: by 2002:a05:6214:2029:b0:6d3:7a47:2034 with SMTP id
 6a1803df08f44-6d8c443cefdmr40855326d6.3.1733269858918; Tue, 03 Dec 2024
 15:50:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 15:50:58 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cartdeijkv6z23dgm7uif4lti3lahfqmuyxcmruzqbefhsp6yk@m6ocjhncs2ko>
References: <lf7y7wpuca6kzqcglgs5d443iusf7xjocum4adi7t3npfavccx@zgsp37oyztme>
 <yk3xidaisbd56yndaucax7otijjauqmm7lqm6q4q633kdawlqo@qaq27lwxmvwd>
 <CAE-0n501j+8bMnMKabFyZjn+MLUy3Z68Hiv1PsfW0APy5ggN8g@mail.gmail.com>
 <gstohhcdnmnkszk4l2ikd5xiewtotgo5okia62paauj6zpaw7y@4wchyvoynm2p>
 <CAE-0n50z6MNa7WOsg-NU7k8BpFeJJyYfHX3ov6DsthLWauSNpA@mail.gmail.com>
 <hqmx7jtkvrwvb27n56hw7rpefhp37lhr3a5fawz7gsl76uuj5s@h7m6wpdhibkk>
 <CAE-0n50y1O2C47zOGJPmMjKXK_m6a=jhpEAP4nW+RymZbo2xyg@mail.gmail.com>
 <5kisfv22tgqwzjpxqrbx56ywr7l4r7pny3pl2r7crv4rijqbwk@azricdasttg7>
 <CAE-0n50Bxi2GfnxOmMwe-F+k5jMSiyAVPDb6K8pYm-i6hpJTOA@mail.gmail.com> <cartdeijkv6z23dgm7uif4lti3lahfqmuyxcmruzqbefhsp6yk@m6ocjhncs2ko>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Tue, 3 Dec 2024 15:50:58 -0800
Message-ID: <CAE-0n51-QLLje0f7T4p3xK6Q-FRk4K0NUrVVm4cxkKoevuzktw@mail.gmail.com>
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

Quoting Dmitry Baryshkov (2024-11-21 14:59:42)
> On Tue, Nov 19, 2024 at 08:09:31PM -0500, Stephen Boyd wrote:
> >
> > It sounds like we're debating how to handle lane assignment in the
> > kernel. Either way, the code is going to be implemented in the bridge
> > driver because it's the one that has to change what physical lane a
> > logical lane is assigned to. The question is if it should be some sort
> > of bridge_funcs callback, or should bridge drivers hook into the typec
> > framework to expose an orientation switch, or something else?
>
> I was assuming that orientation switch is such kind of a hook.
>
> >
> > I'm thinking we should introduce some sort of bridge_funcs callback that
> > can be called from the DP altmode driver, either parallel to the
> > drm_connector_oob_hotplug_event() function or from it directly. If we
> > can pass the fwnode for the usb-c-connector to the oob_hotplug_event
> > callback, maybe that's all we need to figure out which lanes go where.
> > And then in the 2 DP connector muxing world we can call
> > drm_connector_oob_hotplug_event() with one or the other DP connector
> > node, which will likely be children nodes of the "HPD redriver" device.
>
> If you call it from drm_bridge_connector's oob_hotplug_event handler,
> this should fly. Does it cover your 3-DP or 4-DP usecases?
>

I think it will work as long as we're able to add some sort of property
to the usb-c-connector node to indicate that the DP lanes are flipped.
It feels like that should be in the displayport altmode node to keep
things tidy because the SuperSpeed port is overloaded. Maybe the drm
framework can have some API that can take the fwnode from the
oob_hotplug_event handler and tell the bridge driver which way the
orientation is.

 connector {
   compatible = "usb-c-connector";

   altmodes {
     displayport {
       orientation-reversed;
     }
   };

   ports {
     ...
   };
 };


 int drm_dp_typec_orientation_flipped(struct fwnode_handle *fwnode)
 {
   struct fwnode_handle *altmodes;
   struct fwnode_handle *dp;

   altmodes = fwnode_get_named_child_node(fwnode, "altmodes");
   if (!altmodes)
     return -EINVAL;

   dp = fwnode_get_named_child_node(altmodes, "displayport");
   if (!dp)
     return -EINVAL;

   if (fwnode_property_read_bool(dp, "orientation-reversed"))
     return 1;

   return 0;
 }

There's another wrinkle on some Corsola devices where the EC says
there's a usb-c-connector on the board, but in reality the DP lanes are
connected to a DP-to-HDMI bridge that is controlled by the EC which goes
to an HDMI connector on the side of the laptop. The EC does the
arbitration as usual because there's only one DP source and one or two
usb type-c connectors physically on the laptop in addition to the HDMI
connector.

The easiest way to imagine this is that we took the usb-c-connector and
jammed an HDMI dongle in there with some glue so that it can never be
removed. There isn't any USB going there either because it can't be
used. I suppose we can continue to describe this with an
altmodes/displayport node but then add some compatible like
"usb-c-hdmi-connector" or another property to the altmodes/displayport
node like "type = hdmi" that signifies this is a connector that only
outputs HDMI.

