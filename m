Return-Path: <linux-acpi+bounces-14880-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97FAEF65D
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 13:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAFC4A210D
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E50D2727E5;
	Tue,  1 Jul 2025 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oyzbiamn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6194825A2A4
	for <linux-acpi@vger.kernel.org>; Tue,  1 Jul 2025 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368832; cv=none; b=iSLfH8QV5HGaweSDifmm1NGOBrx6W5NuyfK8AxyIog1tcdq6AGvp408Pkuu1/ZFhKDc6exs+rIb4dk57HAmiOoHrXagw/BuB23OEMuVmox5IL+/JH16UgBUBsh0nb33p4rdFQsTWsZbV9vyaNYsK96N+m2Iw4gp7maijfCuyy8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368832; c=relaxed/simple;
	bh=9ksikN0iTD/GCWHlwVzlhstVFQF+DnzhexLRXUKHtb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nS5bUZLiMS26wNDZjlMsHY1ym/jzDex+MSIRO8sHRahRfWXpE4CsCaCHOy6lAIPeLiJWV6IGyybsRVwZ8kHRZdoSDlQfnBmB55YY+jxcid6e60kxB8Q2qH8cbcxSQqcxnR8yY48lP82WZt9hAc4dibPw/42stMdqDeijuYgqqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Oyzbiamn; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so54416341fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751368828; x=1751973628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zZwGCtkc+w6FZ7pTS+qyfMjlhro6+usoRehWf2lDots=;
        b=OyzbiamnPPi/OypcGtpyCkrJemCWJSWnwwUJL2fZyu/NUQG+qgqFX93XXUAae/cLhZ
         C3rTKCBvX7p5Qso2gIZrfJu86RNsBpuqvlmkimeUe7uhqiCbfdjfPL+h9SSOFRQO1wi2
         OxXrC8Yuk2iJ+d1UVhgAB91k7W/mI41d4QyCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751368828; x=1751973628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZwGCtkc+w6FZ7pTS+qyfMjlhro6+usoRehWf2lDots=;
        b=EDIduMjoZ27z38gnV9z3LQh7osEjZft9ZeG5wEoQXnDT27liaZsZlW60+B8YCGUDg+
         d6ZPKI6Spz5E+jC8UZbQ7EvDGQGC0afoPdZW36+hmOPrgdOTWja+z1bx6Xhd1tTxlf+Y
         wa/g/vVMjxqpSTBZTmhAMfBp83UGMih6i01ZSPdx0m5NBFuc+9QnLWslVLQn4ElyrqZS
         7C8vi7DeLuGiBOzIt0N2XO54FwSmJwR3iYvnYlqAnvI2PQBUh+jks0Yx/jF+4Wlywm05
         VfaMPjEUPLDyqUhFYoogLfr5+PoOVf5dS/dCtYV/eFfauF5hfhDITdZ2MLOF3xASdoCg
         dGIw==
X-Forwarded-Encrypted: i=1; AJvYcCXgPdf7UcX2pOPJQURhSDBBBLBTfYdzokn13OXwKaZ/NfqogbsvyewLVC47FDqdb0FO/0GaTbyGkTG8@vger.kernel.org
X-Gm-Message-State: AOJu0YyZiyWTks4sWy/q24vE/LmAv5i6NrpsuUKpH2UGpR+rqRFD7LR2
	m7xZl2rgOqCjb55f5MJMhcICSFJzgx1mABjOOMY7+F/diy7oGI1Uh98XhsJ9I2+pcx70qaovXyY
	2dnACHg==
X-Gm-Gg: ASbGncsZqzpyzE0fqds4AB5o5GYmz+xGsTmvfceO3LI3EdDPphleFLrNa+k8mtiD68+
	d44zaa5GJ6aWgHSMdM2dkN4WwYls3fjavpt+Yic7Tm9/fi4iRZOWEIq3E2hVh32KIevbhLZfpwu
	lHPZOM6kW4cwuN0mJt3PuVEyv3C3wZviZ9NWQd+cdsIJoVdSGspkjLf74MdPabgJFlrNvb1at+n
	P5+psRn/Z8iSM5lRXoWkjuKM2rrT3ZLFWHFozoagI7oO64Wx8OIMlKzKeQ7xLoRQDOigdFv8P4O
	u+LyTIE0FUnAKjQNKaW7NBBrNMn7cUNoLYPJr2gJtAbcRFcC1BIUgu/LYpBCfccaSDyYrL8NuGB
	6aCjKPEP50l+W6dcAnEMywYOR
X-Google-Smtp-Source: AGHT+IHHdsR5QKbZUXDCbJ/LdzYHvsJx+AVKKsz69CzCx+QlT+HRws0O6cLbr76ve/ELOLHwVxjtwQ==
X-Received: by 2002:a2e:aa94:0:b0:32b:968d:1fe4 with SMTP id 38308e7fff4ca-32df3620d24mr7873411fa.14.1751368828287;
        Tue, 01 Jul 2025 04:20:28 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32cd2ec5ef3sm15052181fa.60.2025.07.01.04.20.27
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 04:20:27 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553d52cb80dso5821511e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 04:20:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXX5/LShNmAQHSsznU24OF+wD4lwH81JoP9f2jZ3w0cMunATHj/Dc9Ri5PTyX+E0IfmqOTORcHXrcJW@vger.kernel.org
X-Received: by 2002:a05:6512:3f24:b0:553:2159:8716 with SMTP id
 2adb3069b0e04-556235309fdmr606439e87.26.1751368826374; Tue, 01 Jul 2025
 04:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-12-5710f9d030aa@chromium.org> <20250629180534.GN24912@pendragon.ideasonboard.com>
In-Reply-To: <20250629180534.GN24912@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 1 Jul 2025 13:20:13 +0200
X-Gmail-Original-Message-ID: <CANiDSCvcQ9MA+WBMQTpUzSxDLNiKpvaHsb-pDHTuiUQekgXvQA@mail.gmail.com>
X-Gm-Features: Ac12FXzZWFSV19mV0XJRYxH4cTBUxCR__A0Z2BgypZ23AIk9o_remHKEgYijnOg
Message-ID: <CANiDSCvcQ9MA+WBMQTpUzSxDLNiKpvaHsb-pDHTuiUQekgXvQA@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] media: uvcvideo: Do not create MC entities for
 virtual entities
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent and Hans


On Sun, 29 Jun 2025 at 20:06, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> I would use "software entities" and not "virtual entities" in the
> subject line and everywhere else, as those entities are not virtual.
>
> On Thu, Jun 05, 2025 at 05:53:05PM +0000, Ricardo Ribalda wrote:
> > Neither the GPIO nor the SWENTITY entities form part of the device
> > pipeline. We just create them to hold emulated uvc controls.
> >
> > When the device initializes, a warning is thrown by the v4l2 core:
> > uvcvideo 1-1:1.0: Entity type for entity SWENTITY was not initialized!
> >
> > There are no entity function that matches what we are doing here, and
> > it does not make to much sense to create a function for entities that
> > do not really exist.
>
> I don't agree with this. The purpose of reporting entities to userspace
> through the MC API is to let application enumerate what entities a
> device contains. Being able to enumerate software entities seems as
> useful as being able to enumerate hardware entities.

What function shall we use in this case? Nothing here seems to match a
software entity
https://www.kernel.org/doc/html/latest/userspace-api/media/mediactl/media-types.html

Any suggestion for name?
Shall we just live with the warning in dmesg?

>
> > Do not create MC entities for them and pretend nothing happened here.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_entity.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
> > index d1a652ef35ec34801bd39a5124b834edf838a79e..2dbeb4ab0c4c8cc763ff2dcd2d836a50f3c6a040 100644
> > --- a/drivers/media/usb/uvc/uvc_entity.c
> > +++ b/drivers/media/usb/uvc/uvc_entity.c
> > @@ -72,6 +72,16 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
> >  {
> >       int ret;
> >
> > +     /*
> > +      * Do not initialize virtual entities, they do not really exist
> > +      * and are not connected to any other entities.
> > +      */
> > +     switch (UVC_ENTITY_TYPE(entity)) {
> > +     case UVC_EXT_GPIO_UNIT:
> > +     case UVC_SWENTITY_UNIT:
> > +             return 0;
> > +     }
> > +
> >       if (UVC_ENTITY_TYPE(entity) != UVC_TT_STREAMING) {
> >               u32 function;
> >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

