Return-Path: <linux-acpi+bounces-7733-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D27C958D7C
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 19:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E084CB238B6
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C18D1BE238;
	Tue, 20 Aug 2024 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tw+r2aP5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98F1B8EAE
	for <linux-acpi@vger.kernel.org>; Tue, 20 Aug 2024 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724175258; cv=none; b=sdRbmToOHQYcK24Hp1bINrYFD99nIWo/o8aIfDq4yAIY8075ZMaPw5OKz8bHJLSk7+UK5w7NeF99PNGeViY56E4k74K0eanIpuyZ4n9AHTLO1wtr7fM56gDjx8vV6YoletxZifmZmwLow8MJxS5Pv+CsZ+iARNwL1zR+Qvb3Ag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724175258; c=relaxed/simple;
	bh=+BGxKuXy5yuaKLKpL+P0IynbzYCeuLCHjDjm+SqrANU=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKpCdbxIGeNRq5Mc7MVmzijm8BmuYkKuEqmfrxZck/U6TqzYmh8Vl0E3WU8yK6FLa73gs/NSYZl0e2s3ZFOTeu661iC/uws+4zTu2hlLUEbfWcal82vb/zWwGg9dZcSMdhqWFz8EeRakq/PCE7o+0N8RGm9js5tp4lEqPtjE0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Tw+r2aP5; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a66b813781so56367885a.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 Aug 2024 10:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724175255; x=1724780055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sT8btaeVFgKiZIC2/bVrNe0cKcp239nORrve01JKc1Q=;
        b=Tw+r2aP5Is3Q5BhQPCydq9CjO5c28xMllX9kfpVhR+1HF5YYMDz6pRW70CTOxTUKP9
         DcX5hXwR6yLupgjoB9kmgpk/SJg6uXsCxRtcj28jx648XF4JlBT6Ppxq/jQG19l+6S8j
         c8LuewxPQS7R/+B+mWnZPd3gJevWHjEd+a4Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724175255; x=1724780055;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sT8btaeVFgKiZIC2/bVrNe0cKcp239nORrve01JKc1Q=;
        b=NeFqLwjg3p2CRTs16IYqj8c5yg8rSIway300ueBvlf+LWP4UoPlmqsH8P53isuG7GS
         afPahKHYP3/mrRFloUgkMeHxWzxqbzynKJi2vpUfHXTl6BPo5tiALdcTB6gEbSWhRc38
         oHYRrflekShSYipjUH6JD2iV/HjMWxHBX8CuYVS1lozoT2tOb0IagWWBLEPyQqLy6pxY
         pETxi6DujK/y4OL+ijgutJO7IeWhLo9kK94OeUKE943/QolKEgMR1r4tPj3doX15f6aS
         FTu3jMTbSKf9dJaQ4EKgfR47e3YwfWB94ngUqCPc1yUDd0S++JoBK505V496Wm32uh7A
         TQzw==
X-Forwarded-Encrypted: i=1; AJvYcCXL6sYfddibCn2EL/nte1CZqtWrm9VaVswbr1KsAaq21e5nSfbhHZTO8ulzjutcMyavvUMGNLCuSZQU4C1mB/pQc/4lpLZv1n+9Qg==
X-Gm-Message-State: AOJu0YwS8Gn2nz5smIo4YV3IiwyzsfppT4YDPS9y21qKFrEsncnhye5G
	FFUw4DWiJL74n0/dxhI+Ece2i3Ty0ql0KBjbvRy12njP3PpbEgBvC8wSsjTUPAnochmcqTfTzt6
	VqbWPp9xDF8WOxPwnRybRZ8lFxNBSpPcfO/Ld
X-Google-Smtp-Source: AGHT+IGGJj/BEL1gcz7E4TOfNemZPl2ZAZ1e0Im3r9+oB7B/patnof4GuWnoFzCxo19sTL6oKp0QcBKMjKB8KkoFPP4=
X-Received: by 2002:a05:620a:2453:b0:79f:8f3:6ad4 with SMTP id
 af79cd13be357-7a6740028d4mr2801085a.1.1724175254910; Tue, 20 Aug 2024
 10:34:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Aug 2024 10:34:13 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZsRt_I6y9MfWLawy@smile.fi.intel.com>
References: <20240819223834.2049862-1-swboyd@chromium.org> <20240819223834.2049862-11-swboyd@chromium.org>
 <ZsRt_I6y9MfWLawy@smile.fi.intel.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 20 Aug 2024 10:34:13 -0700
Message-ID: <CAE-0n516QBSg-ODNjaM-q52UtU17DJ45VC-pov+1oSfm2E_9Sg@mail.gmail.com>
Subject: Re: [PATCH v3 10/17] device property: Add remote endpoint to devcon matcher
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

Quoting Andy Shevchenko (2024-08-20 03:20:44)
> On Mon, Aug 19, 2024 at 03:38:24PM -0700, Stephen Boyd wrote:
> >  include/linux/property.h    | 5 +++--
>
> > -typedef void *(*devcon_match_fn_t)(const struct fwnode_handle *fwnode, const char *id,
> > -                                void *data);
> > +typedef void *(*devcon_match_fn_t)(const struct fwnode_handle *fwnode,
> > +                                const struct fwnode_handle *endpoint,
> > +                                const char *id, void *data);
>
> Seems there is no explanation of the parameters here, can we add a kernel-doc
> to this typedef (may be a separate patch)?

Sure. I'll throw in another patch.

