Return-Path: <linux-acpi+bounces-8159-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F76496C9AF
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 23:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34EE1F22896
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 21:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74BC158DD9;
	Wed,  4 Sep 2024 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CaPpySJo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADAE14F102
	for <linux-acpi@vger.kernel.org>; Wed,  4 Sep 2024 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486340; cv=none; b=NV4Z3gT6cLPAleDtF5jC8Mw/gWBoha4+LzjDFVMtceC+4uh+Uhc4hVnSTQj3bznBTEiwGI3RwI/kmhPZnuCHioXGCY9NqW3Wa7fiR1AlZLtsQeTlXkMbtofkYBfH0Bz/aUeogJ/yxOnzETuV7Pm3QATaVzDSlH+jM6qL8xCHl9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486340; c=relaxed/simple;
	bh=R6UUe3TKwZrNrftTEihL/R7hIMY02P3GHWSniiD2wQk=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9nh5oZsZbC9T0i5BDS3Ed//GEZMk4JVvKxa31yAA53Tl6zidCNrkTzlaYHZsp1EfjTglYOePU9REh/ubdS+Z12ITRZpiNEJDHVKJV01iZEf3fRqonFRtscmOkfb7amyA0zx4RxpLy4GxEoHO1ay+e7311YqwVW//twl90rWotI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CaPpySJo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a802deea39so5919585a.2
        for <linux-acpi@vger.kernel.org>; Wed, 04 Sep 2024 14:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725486338; x=1726091138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4gRtmbeYp5evTSGdV4aMzXH03sVn24oEBxx8YLA2ew=;
        b=CaPpySJoRER0VJrJrn7ls5OedaSsBwRwCjo3cLjtFsUTpeXnR2ZmZfpCs1rqFgRcLu
         LfKpJXGbjcO7GkmJYrO/vWwP9xl1kAlyrlvvrdSeirVdO2U61yFtf2tT6yCIiLVOtpnr
         aEY+1O5kGC2JNm1hYSpM6JciS3VRbihft1FiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486338; x=1726091138;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4gRtmbeYp5evTSGdV4aMzXH03sVn24oEBxx8YLA2ew=;
        b=uP0tpRKLZazgdIj+URK9blQYtf5w6qHKdgTc1ROvtsLAFeExV8c6L2IomXnxn2raes
         MCf6cB75rah8b+CBB0gP/dmyYBpVRaAXx/60ZOpkElAEpbgrvjiicvFAbu3KYEwLyddd
         p8q1u+ILRMjepaELKUQewz2d1aQICL85huBlxa7Oi4i11PvCnvmk+zlaF2nmAhYDHJkA
         USSw6eirMuBXER190BMgpsbASBWlLL7pXLNpCFfYRQkqQ9paGvo4XR4eGzaICoJqGKsl
         LdDpnJNOYLDbkhmifpJuLBqFkEu9jER4gDphLCvgiWua/M2Z35WkwsgNslVnh/+BuXYd
         qTnA==
X-Forwarded-Encrypted: i=1; AJvYcCXW2Rm6vnuBTvabSECJDqVCfLIuLxj3P+f9pfu9PX5NOm1EyimL/3gzVzvhYc9Udz8WdryOaBhgBF8b@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMKPXcq1OgKdd6bSm581QqGIE/kU5Nu6KzSlROHxH7CFVDBdb
	I2QkKsAxc/IedU+WVLldtJYsujjU60uEik7rjVdGwad5dcE9sgq9d4HfzwRpQuVdPNAdLv78boY
	4n0TCdYWlyS9rov/vYp6Ehvklyo0INpe1rN6D
X-Google-Smtp-Source: AGHT+IE3j/hFyhOgq6UHD/BuDzpg0SIVGw+m/kAN1oVv8xhNaZUR6LUlzSWku14uLG7tUpAnX8c5Trg6ijcjDc3jYq8=
X-Received: by 2002:a05:620a:19a6:b0:79d:569a:699f with SMTP id
 af79cd13be357-7a8041da30cmr2373807985a.39.1725486337639; Wed, 04 Sep 2024
 14:45:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Sep 2024 14:45:36 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZtgqLZXbJbpG65vD@google.com>
References: <20240901040658.157425-1-swboyd@chromium.org> <20240901040658.157425-19-swboyd@chromium.org>
 <ZtgqLZXbJbpG65vD@google.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 4 Sep 2024 14:45:36 -0700
Message-ID: <CAE-0n51w3AAtLPq5M-i8F6z2jSOT3xFw3g8HM1h48xXBSeoZnA@mail.gmail.com>
Subject: Re: [PATCH v4 18/18] platform/chrome: cros_ec_typec: Handle lack of
 HPD information
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Benson Leung <bleung@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, 
	Guenter Roeck <groeck@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Tzung-Bi Shih (2024-09-04 02:36:45)
> On Sat, Aug 31, 2024 at 09:06:56PM -0700, Stephen Boyd wrote:
> > +static void cros_typec_inject_hpd(struct cros_typec_data *typec,
> > +                               struct ec_response_usb_pd_mux_info *resp,
> > +                               struct cros_typec_port *port)
> > +{
> [...]
> > +     /*
> > +      * Only read the mux GPIO setting if we need to change the active port.
> > +      * Otherwise, an active port is already set and HPD going high or low
> > +      * doesn't change the muxed port until DP mode is exited.
> > +      */
> > +     if (!typec->active_dp_port) {
>
> Given that cros_typec_inject_hpd() is called before `typec->active_dp_port`
> would be set (from previous patch "platform/chrome: ...  Support DP muxing"),
> would it possibly wrongly fall into here at the beginning?  (E.g.:
> cros_typec_probe() -> cros_typec_port_update() -> cros_typec_configure_mux()
> -> cros_typec_inject_hpd().)

We wouldn't get here if 'hpd_asserted' is false though. We want to fall
into this case in the beginning, i.e. 'active_dp_port' is NULL, so that
we can read the mux and figure out which port is actually selected.

If we don't have a mux gpio we assume that we aren't muxing and that
there's only one port to begin with. I'll add a comment after the if
(mux_gpio) condition with this info.

>
> > [...]
> > +     /* Inject HPD from the GPIO state if EC firmware is broken. */
> > +     if (typec->hpd_asserted)
> > +             resp->flags |= USB_PD_MUX_HPD_LVL;
>
> `typec->hpd_asserted` is shared between all typec->ports[...].  Would it be
> possible that a HPD is asserted for another port but not current `port`?
> E.g.: cros_typec_inject_hpd() for port 2 and cros_typec_dp_bridge_hpd_notify()
> gets called due to port 1 at the same time?

I'd like to avoid synchronizing the hpd notify and this injection code,
if that's what you're asking. Thinking about this though, I've realized
that it's broken even when HPD is working on the EC. Consider this
scenario with two type-c ports C0 and C1:

	Plug in C1
	EC notifies AP
	AP queues cros_typec_port_work()
	HPD asserted
	EC picks C1 for DP // First to have hpd asserted
	EC notifies AP
	AP tries to queue cros_typec_port_work() but it's pending. Skip.
	Plug in C0
	EC notifies AP
	AP tries to queue cros_typec_port_work() but it's pending. Skip.
	HPD asserted
	EC notifies AP
	AP tries to queue cros_typec_port_work() but it's pending. Skip.
	Finally cros_typec_port_work() runs!
	 for (i = 0; i < typec->num_ports; i++) // typec->num_ports = 2
	  cros_typec_port_update(port_num=0)
	   cros_ec_cmd(EC_CMD_USB_PD_CONTROL.port=0) // In DP mode
	   cros_typec_configure_mux(port_num=0)
	    cros_ec_cmd(EC_CMD_USB_PD_MUX_INFO.port=0) // hpd asserted
	    if (!active_dp_port)
	     active_dp_port = port0

This is bad. The worker could be significantly delayed, although it's
really unlikely in practice. It would be better if the EC pushed a
message to AP about what happened, instead of having to query the EC
about the state of USB. Or the EC could have a sequence number or
something so AP could ask for the history of events. We can't fix all
the EC firmwares though, so we get what we get.

I think one solution would be to read the mux all the time and ignore
tracking the active port based on hpd state. If we do that then we don't
get tripped up by a delayed work iterating over both typec ports. The
logic will be a bit more complicated though, because we'll have to
consider all the ports when entering and exiting DP mode on one port so
that we don't assign DP to the wrong port.

Also, when hpd is broken on the EC I see an error message when I unplug
the DP cable. It's the "No valid DP mode provided." error from
cros_typec_enable_dp(). When I inject hpd that error goes away. I'll
need to look closer to understand why, but I suspect I'll need to keep
injecting hpd to avoid it.

