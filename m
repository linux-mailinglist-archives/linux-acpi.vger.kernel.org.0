Return-Path: <linux-acpi+bounces-7729-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751B6958D40
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 19:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00253B244EC
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34071C7B66;
	Tue, 20 Aug 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k7UAdq/0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F21C57B4
	for <linux-acpi@vger.kernel.org>; Tue, 20 Aug 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174691; cv=none; b=I9p9hpkU3rjpLg1JXs0RKq16Hy8TE2HnqNYpWn6DAVfX892FqsZx1HcaUEklYkd8hjy5sgFDUMvFU1zf9iJlXAYdTdUbUsyQMlt1ZHyhHOiI9zTOmO5+X7YCaiU3+0zhc4Rdgo2aG0Mtv+m0caBhNcCJGgk5HQgyO6vLxOct928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174691; c=relaxed/simple;
	bh=5jI+2p5tO5nOwZs3G8vuy7obODZwjARI/RidWxG+P/0=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNHEz5FVnO7ugPwmVQvEQjV1DwpOE9LnijWsLMQxQdv6K+R8Tp68hRoCdjtlxOW60TcaMmFRxnr4BCXNEJUbTpYEXPKhmILArt/8mt35tICsQ40o/xyQgm4XQS8+zpiQ0lsoMzcknj5Eckc3yhEVviZlXtJalENoceBJOA32xKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k7UAdq/0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a3375015f8so398267285a.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 Aug 2024 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724174688; x=1724779488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kivk6OVMCb2Ic/WQYTSiSJ7knOT9aLnIRhStn7/b1EY=;
        b=k7UAdq/0AOXuatYlkTYVPglCWbt1B8OSBoplCE6KJyj/wrrE68kTwxZFdIkgfVlZmM
         kS19G2FZpoLKMGfKKGkgpGV6shDKpcYOThTTZrugD0BVIHdjeRD1zgKDsZ1oWpRvAWgD
         RQYyvP7n89b5kWxcbU5iZh7a12vX9nZlMefDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724174688; x=1724779488;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kivk6OVMCb2Ic/WQYTSiSJ7knOT9aLnIRhStn7/b1EY=;
        b=cIqRZsM+13Sx85aolp+CZKsoyENuRHaPXkqgST6gIQenD4m7zSQtPj0hk/dy8CxZjz
         jgdDAoDByx3DNIPDU9tvGYW0wP3C8wD4CZkJd4o7o1kr6ICmLvlIQiAk45yqs5+dRsah
         o+6uga65PT6sYIMt10G3n93nOXKInlM6IupMHPGUAKq5iDjr9jLpgNOWGsiT84obGob2
         9UGRSWV9glvEcLgQt6mkAME/txxrmlhkOCoFHsJbpN6aQwXa2b5gAZLd+YKS9Z/l23To
         dHFgZZuyWrak5IAGJyCHqbgZeBtUCZlLB/wHx0oxWo2jYi6qv2wG3ZiCTHyNGnyZCFXo
         Rc/A==
X-Forwarded-Encrypted: i=1; AJvYcCUxN055CZlIda4HBZaJqiJCO2s1nvxnIY3+2nRw6WKiOrrufcd/GJd8GQWAFBbB3lrdaUJUYyesjRhWnRu98X1bmxNia7VpRCmbWg==
X-Gm-Message-State: AOJu0Yzb9bE1erVY/Op6LAoz+bW2BtWhNbi8rQu7/9rGHVTVPxBqKRW/
	nEkFvWbzTw2yL46qNGNy0V6Pjd5iWR3Uw4fwcuXCmys6GJ9V78kLh9CA+02a1w1TgeswdHf7yQe
	sdvUwyRybUG8yTxLx0FZNS8V1LdHX2OG6yAe+
X-Google-Smtp-Source: AGHT+IFPnbaIpKnJbRF0KVl+CpiSvIEMrBAyBLBBnH5HxEKdAtvNgsfFmldfo1C+7jIx6Rn++JaBGcZOF4ZPpQUlOKY=
X-Received: by 2002:a05:620a:319c:b0:7a3:6dd9:efbb with SMTP id
 af79cd13be357-7a50695402emr1528659285a.33.1724174688344; Tue, 20 Aug 2024
 10:24:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Aug 2024 10:24:47 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZsTPuvoTIFVFHw6o@smile.fi.intel.com>
References: <20240819223834.2049862-1-swboyd@chromium.org> <20240819223834.2049862-3-swboyd@chromium.org>
 <ZsRrWfoPPVGC4Dqy@smile.fi.intel.com> <CAE-0n536OWtoOoRSM=6u=wA75A+0WtBktiY=6Y6VjKKTQWPcNw@mail.gmail.com>
 <ZsTPuvoTIFVFHw6o@smile.fi.intel.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 20 Aug 2024 10:24:47 -0700
Message-ID: <CAE-0n50xcj21WiPHW9ATE7BfxKpOWvdV7of97G_U5ZrMV0zUUw@mail.gmail.com>
Subject: Re: [PATCH v3 02/17] drm/bridge: Verify lane assignment is going to
 work during atomic_check
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
	Thomas Zimmermann <tzimmermann@suse.de>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Daniel Scally <djrscally@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Andy Shevchenko (2024-08-20 10:17:46)
> On Tue, Aug 20, 2024 at 10:12:55AM -0700, Stephen Boyd wrote:
> > Quoting Andy Shevchenko (2024-08-20 03:09:29)
> > > On Mon, Aug 19, 2024 at 03:38:16PM -0700, Stephen Boyd wrote:
> > > > +     /*
> > > > +      * Ensure this bridge is aware that the next bridge wants to
> > > > +      * reassign lanes.
> > > > +      */
> > > > +     for (i = 0; i < num_input_lanes; i++)
> > > > +             if (i != input_lanes[i].logical && !num_output_lanes)
> > > > +                     return -ENOTSUPP;
> > >
> > > Besides missing {} this code is internal to the Linux kernel. Is it okay?
> >
> > ENOTSUPP is used by select_bus_fmt_recursive() so I simply followed that
> > style.
>
> Okay, just be aware of that side effect of that code, also checkpatch may
> complain (however it might be false positive).

Yes checkpatch complained but didn't enlighten me. Please tell me the
side effect as I'm unaware!

