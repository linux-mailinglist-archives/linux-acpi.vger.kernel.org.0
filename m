Return-Path: <linux-acpi+bounces-8143-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93E396B70B
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 11:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78DEEB2879A
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8981D1CF5E0;
	Wed,  4 Sep 2024 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBmejodC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546441CCB29;
	Wed,  4 Sep 2024 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442613; cv=none; b=A26zIk4NVI/x2h2pS/14WEBKJJgn73jh38SSlHXANgQSx/98YIpm76KXJDjYPqWILktYrTBqKAdP6MUi1jHD9OhE8gcOJ47j5ngol69DP5HeaeWFVdPylbDPke8i2t39CXuVXl6rtCcVR2CYxtHF6NRpEklCYtC6Sio/FbYdxCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442613; c=relaxed/simple;
	bh=MBwBMik3WdpeSRwdosVELrhielfxG8FEjRiwld/tWvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUyhOWiip4ab0MhSRYAdesFLyKlKn/5DxyVrA/LkF6B6uMb+BC70ipIRwn9zj3rl7mg20Frci9WRpTs9BQtiT7yoOLlgeRF0AvYUM30gDND5jc+GoVQAjolqj7wKvEi1GBhqK9uT+RcJG7BRD1UEoAEDZlh86hQPVB6bOgNT1n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBmejodC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08A4C4CEC6;
	Wed,  4 Sep 2024 09:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725442613;
	bh=MBwBMik3WdpeSRwdosVELrhielfxG8FEjRiwld/tWvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBmejodC5PZ/bZIdUTxfbws8t13TO0dZx2NADVSzFiCdFZFONf/s5E9sIcxpk+JCj
	 ATqP3UeW/yxC5clX1Ak7Yaw2th9C9qYdbNGKyDsxM5YEGWfx+CHKOTG10nyO9Z8kj8
	 gAVqGaS7J/ed/cn3a4aQdjgY3JhaMrYopF5etv5xjpGUOGtHnV0hhCOF88BwO95epj
	 +pv2ovc++y4PXoo4NLK7icGN2N9DDHJP/SUyAnmZR6d6OwnZBZhFaWyrsQKQRMjpzP
	 c01rOWAS9ey3OIMv8vl1KhcWAyqBb2jWn7vPC8mvVlGCYQ+fLTEALKKSot5K9t+K2B
	 JkDEuYjxYbDSQ==
Date: Wed, 4 Sep 2024 09:36:45 +0000
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
Message-ID: <ZtgqLZXbJbpG65vD@google.com>
References: <20240901040658.157425-1-swboyd@chromium.org>
 <20240901040658.157425-19-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901040658.157425-19-swboyd@chromium.org>

On Sat, Aug 31, 2024 at 09:06:56PM -0700, Stephen Boyd wrote:
> +static void cros_typec_inject_hpd(struct cros_typec_data *typec,
> +				  struct ec_response_usb_pd_mux_info *resp,
> +				  struct cros_typec_port *port)
> +{
[...]
> +	/*
> +	 * Only read the mux GPIO setting if we need to change the active port.
> +	 * Otherwise, an active port is already set and HPD going high or low
> +	 * doesn't change the muxed port until DP mode is exited.
> +	 */
> +	if (!typec->active_dp_port) {

Given that cros_typec_inject_hpd() is called before `typec->active_dp_port`
would be set (from previous patch "platform/chrome: ...  Support DP muxing"),
would it possibly wrongly fall into here at the beginning?  (E.g.:
cros_typec_probe() -> cros_typec_port_update() -> cros_typec_configure_mux()
-> cros_typec_inject_hpd().)

> [...]
> +	/* Inject HPD from the GPIO state if EC firmware is broken. */
> +	if (typec->hpd_asserted)
> +		resp->flags |= USB_PD_MUX_HPD_LVL;

`typec->hpd_asserted` is shared between all typec->ports[...].  Would it be
possible that a HPD is asserted for another port but not current `port`?
E.g.: cros_typec_inject_hpd() for port 2 and cros_typec_dp_bridge_hpd_notify()
gets called due to port 1 at the same time?

