Return-Path: <linux-acpi+bounces-8125-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D920096AC80
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 00:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0631C2474A
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 22:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA681D58AC;
	Tue,  3 Sep 2024 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GGtoiBTa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665EA18733B
	for <linux-acpi@vger.kernel.org>; Tue,  3 Sep 2024 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403766; cv=none; b=eX91VgF21BNtFI2e8GizvqjT71k90Mdz5el3hPe1vRrSUdIF1uHmckhQsFOhG8b0C2WekNbh/8a/0iezBtqSRz1h+EF2ncLM+hpOUCD4fP+J9mMxQOesvVY8KlRcnrbE5UTMOJz9SqKjlvF3xa3baD/wI3dlFDK3COWdQJmTvBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403766; c=relaxed/simple;
	bh=TtyX2gK5m3nn23OtYeDlMe0JllQ4/PmVqk0mkdxmM0g=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7zbuZ8rqUAfIiTsPQXiRbk1pDlLj8H4H2AsiCm3XZY/KE73WDtbdWfGTTuaNUTbmt3ngdpGs0J310WV/bCV2smUcMoqXB+97WOL7eVXM2lih9mxnhk6d8zxfpPv3rdUXwHkVOh6c6g+6n9R13oSta1SvgPXaYC0EsfYT/esl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GGtoiBTa; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c3552ce7faso1227096d6.1
        for <linux-acpi@vger.kernel.org>; Tue, 03 Sep 2024 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725403763; x=1726008563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhkZOEeJ95CcasGDNkmg/phbGBaUk1oIC37JjrClemw=;
        b=GGtoiBTa2PTnMt5qsv43WUG9RdNGUP9XPM1q8sr9xgQRol07+bG+QW2+Ri8SBjndyE
         39rIBUWhWiH9auxXqu2QyaNOdimkqZaQmRoTBgJWO+P25alTBOOa+lPq9hg8qblXMGci
         cR+MBD57s0alrU9EjH6ewGjBGpk8wPv8MJP1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725403763; x=1726008563;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhkZOEeJ95CcasGDNkmg/phbGBaUk1oIC37JjrClemw=;
        b=d7T3a0hLZE4QquYft+BX646LC3wwGw5u3Pm/3lnSPv7R2tbi4r4nzQVB9M7bqoYYKq
         lSkddmnQE6bQMSgLkAnzm2dJ9ztC2Y2z6S+SoxNol85BcIf9+VL28mFEKQSTjS5BhUf5
         Hp5os+hzCYMphHywKGeXYMR6Lc2YKR7A529+daFofGik0fbZwdeoLTyZFh0j5F50+7I5
         /h/WTDOIgG4Pkah96xMJHUNfP2KOdr4ztBQAHIHm76g+kM/qC9XWeG2FAPAJBFkDG1Xw
         utLhmzLjJwG6bGPPr/CtxfRmtigbwXlk7ij8Py2dfiDutBYUDxtkTIxo0I1osblUMwFS
         2zBA==
X-Forwarded-Encrypted: i=1; AJvYcCW0zVWgKl00K9ps/Ie7zneQhIDZHZ8avFnYUwJhr365ZPRW6HFjvVbFvBNYxdTAMhJxjtI7nhYef97j@vger.kernel.org
X-Gm-Message-State: AOJu0YwhmxhGpv/ocrSXsSclYITQlpnCf7ycKwrFdhVWs+hQYDbzxI8y
	M5hF3tNRFM4cSIBEGA54boBKXBx4taje6K93rBAbbtXhRtg6HtE84EwQYn8HpYmG5Th3v7KCI/r
	nHTZ66xKCuTGX5YUGO4d1iN08TYb+T90CK6FN
X-Google-Smtp-Source: AGHT+IF34ocTupB91QqHAUN7muZ3pQu7SJrIS8QiPpHwQnzTFwdvCLem6xytcCmScWzLqSwtal0se6zIR4RyUsc0prs=
X-Received: by 2002:a05:6214:1c44:b0:6c4:d2f9:644e with SMTP id
 6a1803df08f44-6c518e03025mr2177666d6.12.1725403763196; Tue, 03 Sep 2024
 15:49:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Sep 2024 18:49:22 -0400
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZtWdsZrFxfjYLgaG@smile.fi.intel.com>
References: <20240901040658.157425-1-swboyd@chromium.org> <20240901040658.157425-12-swboyd@chromium.org>
 <ZtWdsZrFxfjYLgaG@smile.fi.intel.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 3 Sep 2024 18:49:22 -0400
Message-ID: <CAE-0n52Hupp-ANE2ggeGCRZSM+xmrJt-Q5+5Cb7=C-mxykbz0g@mail.gmail.com>
Subject: Re: [PATCH v4 11/18] device property: Add remote endpoint to devcon matcher
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

Quoting Andy Shevchenko (2024-09-02 04:12:49)
> On Sat, Aug 31, 2024 at 09:06:49PM -0700, Stephen Boyd wrote:
>
> Is it possible to move these Cc:s after --- line below?

Ok.

>
> >  /**
> >   * devcon_match_fn_t - device connection match function
> >   * @fwnode: Remote connection's device node
> > + * @endpoint: Remote connection's endpoint node
> >   * @con_id: Identifier for the connection
> >   * @data: Match function caller specific data
> >   *
> >   * Implement a callback with this function signature to search a fwnode's
> >   * connections for a match with a function like device_connection_find_match().
> >   * This function will be called possibly multiple times, once for each
> > - * connection. The match function should inspect the @fwnode to look for a
> > - * match. The @con_id and @data provided are the same as the @con_id and @data
> > - * arguments passed to the functions that take a devcon_match_fn_t argument.
> > + * connection. The match function should inspect the connection's @fwnode
> > + * and/or @endpoint to look for a match. The @con_id and @data provided are the
> > + * same as the @con_id and @data arguments passed to the functions that take a
> > + * devcon_match_fn_t argument.
>
> So, struct fwnode_handle is a single-linked list. Can we utilise that instead
> of adding a new parameter? I.o.w. do those objects (@fwnode and @endpoint) have
> anything in common and can be chained?

No, we can't use that. We need to know which endpoint in the remote
fwnode is connected to the fwnode we're searching from. This is how we
know which typec mux structure is associated with which type-c port so
we can drive DP there. We might have two endpoints connected to the same
fwnode and then we wouldn't be able to differentiate the endpoint and
the typec mux to configure.

>
> >   * Note: This function can be called multiple times.
>
> What does this mean? Is it idempotent? Or what is the effect of being called
> multiple times?

I've removed this note now.

