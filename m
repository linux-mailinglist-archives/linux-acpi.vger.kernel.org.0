Return-Path: <linux-acpi+bounces-7732-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551DD958D77
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 19:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B7C0B2159C
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 17:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13281BE238;
	Tue, 20 Aug 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gFlzZOC8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDFD18C92C
	for <linux-acpi@vger.kernel.org>; Tue, 20 Aug 2024 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724175197; cv=none; b=C2/K5Quc5OcKrGqyhUTTU+2jN/3TwqsWOgHPvNZW5PCmu9DvC+v3vW3VZ32tA7R3T4hCLquJ4WP242yOpqPbIC3dkQCLFxLLUsgM8CElDyrkCOezDrtMQ8I+O9o4yqQhgNZF0kplSHMyZTPPsedA3TPVJmAYAUHoFr2y2tG06Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724175197; c=relaxed/simple;
	bh=bzaiqpN/nM0bLlfP1/91p4RwJaZVbs9cPvkMDsEy1DY=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFuYpaby/+dXD8Iqy8bE4ADf+/rXlzKFx3g3iGl5zsTpPOr10pd+lX11EVLHnAj4K9J1bUTWo7eFY6FVcSA2Bmn/OUd8RARmKNGcopTq7825ftPToKdomWY3PyItf0rvDyJBXyqow/49umIjUsJY3sxb4KUGxmI2hzFFDducU8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gFlzZOC8; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a5074ebb9aso286113285a.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 Aug 2024 10:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724175195; x=1724779995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vtSBBXJK5LCYoMXhK0wAXHgfrMBnfJ+I9BOwaqkeIw=;
        b=gFlzZOC8/COIyEBkYdwz08Xr8T3udl0ohGmhfnNmcHdU9mAPftU2xLmbXruLDcfCl5
         dqvDEJpJHen63kn8bBOyFQoaTRkGsDi2zMtbE/O3A3Hiz2LncvYoxE/MbX1UOXeyMO1D
         9Mfpjv7ldGOMxNFUXRvdNk/27mtUWT9A1Wthk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724175195; x=1724779995;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vtSBBXJK5LCYoMXhK0wAXHgfrMBnfJ+I9BOwaqkeIw=;
        b=s4/CAFnowq/fZ2vv/hf/ztTRrws6XlePHvA2SVtwD0y1iwzQH9xetwKaYg9TSYh2Nq
         7HqMbskJNgch+9posD+DpOxa1zjz24g71z2wOBiyMvKs8J8rDKCHiFJNLbpyY7EuRqSa
         Gry4W4KufR8128w0y2KpJR566qz1s2/u+eeCZA8aIGb5lyGGHPkJxBB56n4BdLvRsAkb
         nd9Oxig63VO0YW4yQ8Di1tCbmxEt0G20qguNOvQ/cSP2u2QzljM8nRkFd7Vr4TYLYuvo
         6mOgPy25egO5+0LM6TMkgOvTpwL4RUb+RW8Q7cJIKjU4t087byzkivhPaiaf8WyUngWi
         zDFA==
X-Forwarded-Encrypted: i=1; AJvYcCX7CwCA19SI7gf3uURHyf3hjVPwgUMBtAHe0eGnFFQtzQl4iwtPM8rr39QnhBNA6Yp58h8E3vS/eNYn@vger.kernel.org
X-Gm-Message-State: AOJu0YybgQILctRAJQSzLw3a1hHIhpclkfGk9mx3hBe0uJH5GG2lVkRp
	mKz26T9VckD3u/WFYfUM6jf3z0uLqfmbx5V9Le4T/Yc9CASOxxxPhOZN1o9aE/rZwUxA6k7JJwC
	QDnUwqbfgsmw4AzaLSjdOouhgR5aD3t0lwUdb
X-Google-Smtp-Source: AGHT+IGYOhjKEQmlHtrugQt34padsEOCiU22JleS9UeHG8yLwrBPBBWRxbXoU9frSSi4wQBqFivZBoMrIwRgXX1QdHI=
X-Received: by 2002:a05:620a:269a:b0:7a1:d9a6:a9af with SMTP id
 af79cd13be357-7a5069f1f8dmr1864595885a.68.1724175194965; Tue, 20 Aug 2024
 10:33:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Aug 2024 10:33:14 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZsTShZnD-NbZqGio@smile.fi.intel.com>
References: <20240819223834.2049862-1-swboyd@chromium.org> <20240819223834.2049862-3-swboyd@chromium.org>
 <ZsRrWfoPPVGC4Dqy@smile.fi.intel.com> <CAE-0n536OWtoOoRSM=6u=wA75A+0WtBktiY=6Y6VjKKTQWPcNw@mail.gmail.com>
 <ZsTPuvoTIFVFHw6o@smile.fi.intel.com> <CAE-0n50xcj21WiPHW9ATE7BfxKpOWvdV7of97G_U5ZrMV0zUUw@mail.gmail.com>
 <ZsTShZnD-NbZqGio@smile.fi.intel.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 20 Aug 2024 10:33:14 -0700
Message-ID: <CAE-0n53JBtB0YAZxMhLVJhbsUNZo4JPyXUiHu=9EQT4Bx+tHPA@mail.gmail.com>
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

Quoting Andy Shevchenko (2024-08-20 10:29:41)
> On Tue, Aug 20, 2024 at 10:24:47AM -0700, Stephen Boyd wrote:
> > Quoting Andy Shevchenko (2024-08-20 10:17:46)
> > > On Tue, Aug 20, 2024 at 10:12:55AM -0700, Stephen Boyd wrote:
> > > > Quoting Andy Shevchenko (2024-08-20 03:09:29)
> > > > > On Mon, Aug 19, 2024 at 03:38:16PM -0700, Stephen Boyd wrote:
>
> ...
>
> > > > > > +     /*
> > > > > > +      * Ensure this bridge is aware that the next bridge wants to
> > > > > > +      * reassign lanes.
> > > > > > +      */
> > > > > > +     for (i = 0; i < num_input_lanes; i++)
> > > > > > +             if (i != input_lanes[i].logical && !num_output_lanes)
> > > > > > +                     return -ENOTSUPP;
> > > > >
> > > > > Besides missing {} this code is internal to the Linux kernel. Is it okay?
> > > >
> > > > ENOTSUPP is used by select_bus_fmt_recursive() so I simply followed that
> > > > style.
> > >
> > > Okay, just be aware of that side effect of that code, also checkpatch may
> > > complain (however it might be false positive).
> >
> > Yes checkpatch complained but didn't enlighten me. Please tell me the
> > side effect as I'm unaware!
>
> I already told you above, if this code ever appears in user space it will be
> printed as a number and very much confuse the user!
>
> That's why usage of this code either has to be documented or be subsystem
> _known_ practice (GPIO library comes to my mind as it uses it internally,\
> but filters for user space).
>

Ok, got it. Thanks!

