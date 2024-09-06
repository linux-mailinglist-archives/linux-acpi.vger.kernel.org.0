Return-Path: <linux-acpi+bounces-8188-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB39096ED9B
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2024 10:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1802865F8
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2024 08:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9DD157476;
	Fri,  6 Sep 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db5hdR/o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDE156C40;
	Fri,  6 Sep 2024 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610709; cv=none; b=L675XjJKkgTxUXe3UKAe/QcrZHeYNJ6q5A+Lq15HkPUbxD+OYP3mGVBiu3q729zpRFzb4tVSJwatBAwnWiwb0KpmCNOrHaeivdUytScVzZB2+y8zdv88CnNJ25KHvl1SFm0hGIbWLGQ0/SKxzv/q5c1llxffVKSYkwhXidjS6wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610709; c=relaxed/simple;
	bh=P9ijqIiAgO/MrBm843x3Xs7+rP6/2wpXmDlmyoVM9dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+NFdUKE8qB26SqynCbYrV+bo/R3X4Pdxkut8qFUZ1X3RYmtflouT4C34QRMUjsypjHyqwfnWN3NgAYc5dHUNbgY7QOCmnmUgamBYk1mr1iUo3nPIruL+FSA+Ooy2G7eUbQZ965H78vCKstdXrk57g8zqfQDJNCLyaKPIV9e5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db5hdR/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2301EC4CEC4;
	Fri,  6 Sep 2024 08:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725610708;
	bh=P9ijqIiAgO/MrBm843x3Xs7+rP6/2wpXmDlmyoVM9dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=db5hdR/o5UoYbI2b7BscGrpbq9xRl/AdUrPSlA/8fOZxDBR1QdSNxnkUtd9QrwnYQ
	 6pQtPdpljx4ztREQGI0fUOu7ElhyluT3ouzQDIDl7B4k1JJA3nLP2WF6yw2VnRse+4
	 WbQ7KdTqpR80IKFv3Ktw1YT/pOxcAID/Sbkj9+6IaVE9GZRxTFPxCwgqPXfRrmzMvF
	 CUXEEoKFKUvVt3XayK9lBqBdEbRKeOOLa33STCZCrXjw1r/joD50JkYuCVKMXSwwjf
	 kekuTfnzGTCIsKf4wyU4EcQvvHRVXT0de/rhtGwZorbh485sthvIKXxw1T+vNc7jzH
	 O0Vg4PR9q+y/Q==
Date: Fri, 6 Sep 2024 08:18:21 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
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
	Lee Jones <lee@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
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
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v4 18/18] platform/chrome: cros_ec_typec: Handle lack of
 HPD information
Message-ID: <Ztq6zf8n09ZcJNjT@google.com>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-19-swboyd@chromium.org>
 <ZtgqLZXbJbpG65vD@google.com>
 <CAE-0n51w3AAtLPq5M-i8F6z2jSOT3xFw3g8HM1h48xXBSeoZnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n51w3AAtLPq5M-i8F6z2jSOT3xFw3g8HM1h48xXBSeoZnA@mail.gmail.com>

On Wed, Sep 04, 2024 at 02:45:36PM -0700, Stephen Boyd wrote:
> Quoting Tzung-Bi Shih (2024-09-04 02:36:45)
> > On Sat, Aug 31, 2024 at 09:06:56PM -0700, Stephen Boyd wrote:
> > > +static void cros_typec_inject_hpd(struct cros_typec_data *typec,
> > > +                               struct ec_response_usb_pd_mux_info *resp,
> > > +                               struct cros_typec_port *port)
> > > +{
> > [...]
> > > +     /*
> > > +      * Only read the mux GPIO setting if we need to change the active port.
> > > +      * Otherwise, an active port is already set and HPD going high or low
> > > +      * doesn't change the muxed port until DP mode is exited.
> > > +      */
> > > +     if (!typec->active_dp_port) {
> >
> > Given that cros_typec_inject_hpd() is called before `typec->active_dp_port`
> > would be set (from previous patch "platform/chrome: ...  Support DP muxing"),
> > would it possibly wrongly fall into here at the beginning?  (E.g.:
> > cros_typec_probe() -> cros_typec_port_update() -> cros_typec_configure_mux()
> > -> cros_typec_inject_hpd().)
> 
> We wouldn't get here if 'hpd_asserted' is false though. We want to fall

Ack, I overlooked that.

> > > [...]
> > > +     /* Inject HPD from the GPIO state if EC firmware is broken. */
> > > +     if (typec->hpd_asserted)
> > > +             resp->flags |= USB_PD_MUX_HPD_LVL;
> >
> > `typec->hpd_asserted` is shared between all typec->ports[...].  Would it be
> > possible that a HPD is asserted for another port but not current `port`?
> > E.g.: cros_typec_inject_hpd() for port 2 and cros_typec_dp_bridge_hpd_notify()
> > gets called due to port 1 at the same time?
> 
> I'd like to avoid synchronizing the hpd notify and this injection code,
> if that's what you're asking. Thinking about this though, I've realized
> that it's broken even when HPD is working on the EC. Consider this
> scenario with two type-c ports C0 and C1:
>
> [...]

I understood it more: originally, I was wondering if it needs an array
`typec->hpd_asserted[...]` for storing HPD for each port.  But, no.

What cros_typec_dp_bridge_hpd_notify() get is just a connected/disconnected
signal.  It kicks off cros_typec_port_work() for finding which port is
supposed to trigger the event (with some logic with `active_dp_port`,
`mux_gpio`, and `hpd_asserted`).


Curious about one more scenario, is it possible:

Initially, no DP port and no mux is using:
  active_dp_port = NULL
  hpd_asserted = false
  mux_gpio = NULL

CPU A                                        CPU B
------------------------------------------------------------------------------
cros_typec_port_work()
  cros_typec_port_update(port_num=0)
                                             [C0 connected]
                                             cros_typec_dp_bridge_hpd_notify()
                                               hpd_asserted = true
  cros_typec_port_update(port_num=1)
    cros_typec_configure_mux(port_num=1)
      cros_typec_inject_hpd()
      active_dp_port = C1

