Return-Path: <linux-acpi+bounces-9213-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EFF9B8662
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 23:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1556C1C21635
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 22:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768A61DBB36;
	Thu, 31 Oct 2024 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vkGovc4W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EDD1D0E0D
	for <linux-acpi@vger.kernel.org>; Thu, 31 Oct 2024 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415300; cv=none; b=HRqCP4KN64b7kGl0v77BAGKizs9sIRN0H54Gc/QBOtVEKOeebpgcc2dhpk4r72KUR6TMl7ZCJnmQq7B2i4F3YXgSKvgypJEU3dPzzErDWTcgFzBeZvTMz6IB9eA38ZtfYwioQhPGsFldvVMdUUrPFt8Y8pZL7r8VZxQhWOKBYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415300; c=relaxed/simple;
	bh=0XtiuL8HzPVUIcbQmp4W/ObpOQuqBuHvLMZmD4Hqmmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVH+9UXcxMksC93FsyvSOMPxAsbJa24i28B+JRQ0vYQ0o5qDR8d9cLYWvmYLFHjxe0R/zcQyiG/j2hNWeP0FiT58xl3ZXDGvahm7UuxJsp1VyVkaRSARK5A05veO8A/DDZTl9AIsdox7u2qC100alpT7Fv+G7TlKOFAmfy8WdCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vkGovc4W; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e3f35268so1870946e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 31 Oct 2024 15:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730415291; x=1731020091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2xfjHXyb5eaHTGVlXfFi968g4q6zA2j3OKWo/NXVyLM=;
        b=vkGovc4W9Go1HJMVBpaUJY4Z2+2IG68D8NOn+bmMThuipl+LNEo7VYpo5douwz1bA8
         bWqmlN0Xkd+LdLS7sCdARYQJzZrIILm+vTf/dtVlh6ctpWB+9BDbFQZZu4+pf0cPBaVr
         jFwY8wPEJb84eYK+pn5ZmLCzDNK2+mB1iq4l5WWfqb8k9Vphmb+VnV7P0xGXiGY4DwFU
         O2pUAD2Ztnws2R2WGGaS+imLX8wPCHuxcW+Jh7hmAEhA+3MtE3f1btOhVXaNVHCl+3lp
         B9IzU2P3lc/kFAsnceteVgcR4Ph9UMyfCfn+sXjxlD8vgZ2RU6QpACvYNsc3dw9epjwL
         nBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730415291; x=1731020091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xfjHXyb5eaHTGVlXfFi968g4q6zA2j3OKWo/NXVyLM=;
        b=fTckH5TWYpGDQwEbHug6m2FLh3+LsNxPcS5tJ0WvWL5/jZDhu6Csp40dA2RTO84TWE
         McLd3cnVWlZrqQOwQtYB8H6vwm1RX/WYvZlJSZE+ivYLvRPqbgBX0+8feJQKARgPABe0
         ohPv2BCJmC7ch1eF3orJt5gOd8JjYHjoV2Wtd+ocWEGAvdRhQUy0fSXHf5y7n+B0t4EK
         2tSqzzoka8Z9Zg0jljI7zG8faj+1iG/A8k6gQ9D+BnFAd1sOTcm09yOHzth4gKYgP5m9
         oIZ02hTzS2Ja5cJU40+Culk3oHx02dKuy2xWB5CibrKRPQqPUzPMUCZaSuoooSPKh0/Q
         mKYA==
X-Forwarded-Encrypted: i=1; AJvYcCV+3WhU9Pfr6K66oZ/sUV6XPxK56pJljjpyfPB6ykRUGb3evPDmInV74O0wu37PFZSlEmAPmf31B46n@vger.kernel.org
X-Gm-Message-State: AOJu0YzwgPxmBlKOZ/OCyWXFqstklR36xfQj/dD/MANUP7QZleHQobbi
	lhjESNPWJ2/wchnxVcT+yXgacDbXfMc0pInjz/V9V23dqcspI/nyXlY/9dv5l10=
X-Google-Smtp-Source: AGHT+IFPpRVk+mVtirKf0Jlz98/n7f35BC4uMgBDb7CL//fsMETaxYe+5vZzwJgBgkvRqyECZwvNrA==
X-Received: by 2002:ac2:4c46:0:b0:52b:de5b:1b30 with SMTP id 2adb3069b0e04-53d65e1a5e7mr872060e87.44.1730415291364;
        Thu, 31 Oct 2024 15:54:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9bee0sm354438e87.79.2024.10.31.15.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:54:50 -0700 (PDT)
Date: Fri, 1 Nov 2024 00:54:49 +0200
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
Message-ID: <gstohhcdnmnkszk4l2ikd5xiewtotgo5okia62paauj6zpaw7y@4wchyvoynm2p>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-16-swboyd@chromium.org>
 <phdcjgqqpjpruxp7v2mw446q73xr3eg4wfgfbjw5tasgr2pgg2@77swbk47b2tg>
 <CAE-0n514QMaQC2yjKP8bZqyfbv6B3AQm=+NJ87vxo6NdYiL03A@mail.gmail.com>
 <lf7y7wpuca6kzqcglgs5d443iusf7xjocum4adi7t3npfavccx@zgsp37oyztme>
 <CAE-0n53-KmOS3zXmJPvOOZ7xxkek9-S=oBExgaY0PDnt_HjdNw@mail.gmail.com>
 <yk3xidaisbd56yndaucax7otijjauqmm7lqm6q4q633kdawlqo@qaq27lwxmvwd>
 <CAE-0n501j+8bMnMKabFyZjn+MLUy3Z68Hiv1PsfW0APy5ggN8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n501j+8bMnMKabFyZjn+MLUy3Z68Hiv1PsfW0APy5ggN8g@mail.gmail.com>

On Thu, Oct 31, 2024 at 02:45:29PM -0700, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2024-10-31 11:42:36)
> > On Tue, Oct 29, 2024 at 01:15:51PM -0700, Stephen Boyd wrote:
> > > At this point we need to tell the DP bridge, like IT6505, that it's one
> > > or the other output endpoints that it should use, but we haven't
> > > directly connected the usb-c-connector to the output ports of IT6505
> > > because drm_of_find_panel_or_bridge() can't find the parent of the
> > > usb-c-connector if we connect the DP bridge to the usb-c-connector
> > > graphs. We'll need a way for the bridge to know which output port is
> > > connected to a usb-c-connector fwnode. Some sort of API like
> >
> > I think that the final bridge should be the IT6505. It can save you from
> > some troubles, like the inter-bridge lane negotiation. Please remember
> > that using lanes 2-3 as primary lanes doesn't seem to fall into the
> > standard DisplayPort usage. It is documented by USB-C and only because
> > of the orientation switching.
> 
> If the final bridge is IT6505 then drm_of_find_panel_or_bridge() isn't
> called and I think we're OK. But then we have to traverse the
> remote-endpoint of the usb-c-connector to IT6505 in displayport.c in the
> Corsola case while knowing to look at the parent of the usb-c-connector
> node and traversing the remote-endpoint to the QMP phy in the Trogdor
> case. The logic in dp_altmode_probe() is like
> 
>   if (port@1/endpoint@1 exists in usb-c-connector)
>     connector_fwnode = port@1/endpoint@1/remote-endpoint
>   else if (cros-ec-typec/port exists)
>     connector_fwnode = cros-ec-typec/port@0/endpoint/remote-endpoint
>   else
>     original stuff

I'd say, definitely ugh. Maybe we can add the swnode with the
"displayport" property pointing back to the DP bridge / endpoint.

But... read below.

> If we have the crazy three usb-c-connector design it can still work
> because we'd have something like
> 
>   cros-ec-typec {
>     port {
>       dp_endpoint: endpoint {
>         remote-endpoint = <&dp_ml0_ml1>;
>       };
>     };
> 
>     usb-c-connector@0 {
>       port@1 {
>         endpoint {
>           remote-endpoint = <&hub_ss0>;
>        };
>        // Implicitly dp_ml0_ml1
>       };
>     };
>     usb-c-connector@1 {
>       port@1 {
>         endpoint@0 {
>           remote-endpoint = <&hub_ss1>;
>         };
>         endpoint@1 {
>           remote-endpoint = <&dp_ml2_ml3>;
>         };
>       };
>     };
>     usb-c-connector@2 {
>       port@1 {
>         endpoint {
>           remote-endpoint = <&hub_ss2>;
>         };
>        // Implicitly dp_ml0_ml1
>       };
>     };
>   };
> 
> (I like thinking about this 3 connector case because it combines both
> Trogdor and Corsola designs so I can talk about both cases at the same
> time)
> 
> I don't know what happens when we have 4 connectors though, with 2 going
> to one pair of lanes and 2 going to the other 2 lanes. Maybe it's better
> to always have a DP input port in cros-ec-typec to avoid this problem
> and map back to the endpoint explicitly.
> 
>   cros-ec-typec {
>     port {
>       dp_endpoint0: endpoint@0 {
>         remote-endpoint = <&dp_ml0_ml1>;
>       };
>       dp_endpoint1: endpoint@1 {
>         remote-endpoint = <&dp_ml2_ml3>;
>       };
>     };
> 
>     usb-c-connector@0 {
>       port@1 {
>         endpoint@0 {
>           remote-endpoint = <&hub_ss0>;
>        };
>        endpoint@1 {
>          remote-endpoint = <&dp_endpoint0>;
>        };
>       };
>     };
>     usb-c-connector@1 {
>       port@1 {
>         endpoint@0 {
>           remote-endpoint = <&hub_ss1>;
>         };
>         endpoint@1 {
>           remote-endpoint = <&dp_endpoint1>;
>         };
>       };
>     };
>     usb-c-connector@2 {
>       port@1 {
>         endpoint@0 {
>           remote-endpoint = <&hub_ss2>;
>         };
>         endpoint@1 {
>           remote-endpoint = <&dp_endpoint1>;
>         };
>       };
>     };
>   };
> 
> Or use a displayport property that goes to connector node itself so that
> we don't extend the graph binding of the usb-c-connector.
> 
>   cros-ec-typec {
>     usb-c-connector@0 {
>       altmodes {
>         displayport {
>           connector = <&dp_ml0_ml1>;

I think this has been frowned upon. Not exactly this, but adding the
displayport = <&foo>.

Thus it can only go to the swnode that is generated in software by the
cros-ec driver.

>         };
>       };
>       port@1 {
>         endpoint@0 {
>           remote-endpoint = <&hub_ss0>;
>        };
>       };
>     };
>     usb-c-connector@1 {
>       altmodes {
>         displayport {
>           connector = <&dp_ml2_ml3>;
>         };
>       };
>       port@1 {
>         endpoint {
>           remote-endpoint = <&hub_ss1>;
>         };
>       };
>     };
>     usb-c-connector@2 {
>       altmodes {
>         displayport {
>           connector = <&dp_ml2_ml3>;
>         };
>       };
>       port@1 {
>         endpoint {
>           remote-endpoint = <&hub_ss2>;
>         };
>       };
>     };
>   };
> 
>   it6505 {
>     ports {
>       port@1 {
>         dp_ml0_ml1: endpoint@0 {
>           remote-endpoint = <??>;
>         };
>         dp_ml2_ml3: endpoint@1 {
>           remote-endpoint = <??>;
>         };
>       };
>     };
>   };
> 
> The logic could look at a node like usb-c-connector@2, find
> altmodes/display node, and look for a 'connector' property that points
> at the endpoint of the last bridge. If we don't use the OF graph binding
> it makes it easier to point at the same endpoint in the QMP phy or the
> IT6505 graph from more than one usb-c-connector. This also makes it very
> clear that we intend to pass that fwnode as the 'connector_fwnode' to
> oob_hotplug_event().
> 
> If we want to actually populate the 'remote-endpoint' property of IT6505
> we will need to make a graph in cros-ec-typec.
> 
>   cros-ec-typec {
>     port {
>       dp_endpoint0: endpoint@0 {
>         remote-endpoint = <&dp_ml0_ml1>;
>       };
>       dp_endpoint1: endpoint@1 {
>         remote-endpoint = <&dp_ml2_ml3>;
>       };
>     };
>     usb-c-connector@0 {
>       altmodes {
>         displayport {
>           connector = <&dp_endpoint0>;
>         };
>       };
>       port@1 {
>         endpoint@0 {
>           remote-endpoint = <&hub_ss0>;
>        };
>       };
>     };
>     usb-c-connector@1 {
>       altmodes {
>         displayport {
>           connector = <&dp_endpoint1>;
>         };
>       };
>       port@1 {
>         endpoint {
>           remote-endpoint = <&hub_ss1>;
>         };
>       };
>     };
>     usb-c-connector@2 {
>       altmodes {
>         displayport {
>           connector = <&dp_endpoint1>;
>         };
>       };
>       port@1 {
>         endpoint {
>           remote-endpoint = <&hub_ss2>;
>         };
>       };
>     };
>   };
> 
>   it6505 {
>     ports {
>       port@1 {
>         dp_ml0_ml1: endpoint@0 {
>           remote-endpoint = <dp_endpoint0>;
>         };
>         dp_ml2_ml3: endpoint@1 {
>           remote-endpoint = <dp_endpoint1>;
>         };
>       };
>     };
>   };
> 
> and then the logic in displayport.c will have to check if the
> 'connector' property points at a graph endpoint, traverse that to the
> remote-endpoint, and consider that the connector_fwnode.
> 
> >
> > Maybe that's just it? Register DP_bridge (or QMP PHY) as
> > orientation-switch? Then you don't need any extra API for the lane
> > mapping? The cross-ec-typec can provide orientation information and the
> > USB-C-aware controller will follow the lane mapping.
> 
> I'm not really following but I don't think the DT binding discussed here
> prevents that.

I'm thinking about:

it6505 {
  orientation-switch;

  ports {
    port@1 {
      it6505_dp_out: remote-endpoint = <&cros_ec_dp>;
      data-lanes = <0 1>;
    };
  };
};

cros-ec {
  port {
    cross_ec_dp: remote-endpoint = <&it6505_dp_out>;
  };

  connector@0 {
    reg = <0>;
    cros,dp-orientation = "normal";

    ports {
      // all USB HS and SS ports as usual;
    };
  };

  connector@1 {
    reg = <1>;
    cros,dp-orientation = "reverse";

    ports {
      // all USB HS and SS ports as usual;
    };
  };

  connector@2 {
    reg = <2>;
    cros,dp-orientation = "reverse";

    ports {
      // all USB HS and SS ports as usual;
    };
  };

  connector@3 {
    reg = <3>;
    cros,dp-orientation = "normal";

    ports {
      // all USB HS and SS ports as usual;
    };
  };
};

The cros-ec registers single drm bridge which will generate HPD events
except on Trogdor, etc. At the same time, cros-ec requests the
typec_switch_get(). When the cros-ec detects that the connector@N it
being used for DP, it just generates corresponding typec_switch_set()
call, setting the orientation of the it6505 (or QMP PHY). The rest can
be handled either by EC's HPD code or by DP's HPD handler, the
orientation should already be a correct one.

So, yes. It requires adding the typec_switch_desc implementation _in_
the it6505 (or in any other component which handles the 0-1 or 2-3
selection). On the other hand as I wrote previously, the 0-1 / 2-3 is
the USB-C functionality, not the DP one.

[...]

> 
> >
> > > > > Corsola could work with this design, but we'll need to teach
> > > > > dp_altmode_probe() to look for the drm_bridge elsewhere besides as the
> > > > > parent of the usb-c-connector node. That implies using the 'displayport'
> > > > > property in the cros-ec-typec node or teaching dp_altmode_probe() to
> > > > > look for the port@1/endpoint@1 remote-endpoint handle in the
> > > > > usb-c-connector graph.
> > > > >
> > > > > Assuming the bindings you've presented here are fine and good and I got
> > > > > over the differences between Trogdor and Corsola, then I can make mostly
> > > > > everything work with the drm_connector_oob_hotplug_event() signature
> > > > > change from above and some tweaks to dp_altmode_probe() to look for
> > > > > port@1/endpoint@1 first because that's the "logical" DP input endpoint
> > > > > in the usb-c-connector binding's graph. Great! The final roadblock I'm
> > > > > at is that HPD doesn't work on Trogdor, so I can't signal HPD through
> > > > > the typec framework.
> > > >
> > > > Hmm, I thought that a normal DP's HPD GPIO works on the trogdor. Was I
> > > > misunderstanding it? But then we don't know, which USB-C connector
> > > > triggered the HPD...
> > >
> > > By HPD not working on Trogdor I mean that the EC doesn't tell the kernel
> > > about the state of HPD for a usb-c-connector in software. Instead, HPD
> > > is signaled directly to the DP controller in hardware via a GPIO. It is
> > > as you suspect, we don't know which USB-C connector has HPD unless we
> > > read the mux controlled by the EC and combine that with what the DP
> > > driver knows about the state of the HPD pin.
> >
> > I see. So the HPD event gets delivered to the DP controller, but we
> > really need some API to read the port? If it's not the
> > orientation-switch, of course.
> 
> Yes. This is needed to understand what USB type-c connector the DP
> signals should go to. In the case of Corsola/IT6505 it's needed to know
> which two lanes should be sent if both type-c connectors/ports are
> capable of DP altmode. On Corsola, the EC could tell the kernel that
> both ports are in DP altmode but the EC is also controlling the AUX
> channel mux that decides which usb-c-connector type-c port is actually
> displaying DP.

-- 
With best wishes
Dmitry

