Return-Path: <linux-acpi+bounces-15061-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C30AFC2B2
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 08:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC34C7B2C86
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 06:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76163220F38;
	Tue,  8 Jul 2025 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XMjuwgUB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894A645
	for <linux-acpi@vger.kernel.org>; Tue,  8 Jul 2025 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956118; cv=none; b=F91lVgAP1omqegCGTap/BLZztt+MJTr6mOC6fv0bR887iJxYSgDrmN5AHIiAfNMYS5iks6eYYCg36YKw3Ps37iP+hY7iP6q6swjOXLfD7MIIQ8eEBNAPSr1w0pyE0OHsv7NA7sqEv8KSYoyjyn21ijVQWbmzjOZz2lDPiL9N3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956118; c=relaxed/simple;
	bh=I0rAk6mb7yKobFsz49sdDHTtScf9ylS26QbCpacwhZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwfXdGJdXpry8byfBSQQ6y913yKB/k4h1/G5VNrbXv5CB3faV7plgxoXHyesMYFlzWbeDN82fVbWye+qhxSFF9jfWxcQTZtpZUYoQI8szCD+hhcb7G2tfKwDBFA+co6Y5Sv6WaVqC6OPHMrbDLTaWpyuqj+WeAKsNyFruGofqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XMjuwgUB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-556373661aaso3573771e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jul 2025 23:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751956115; x=1752560915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=epMO4JAtFgFxLvmQB+DGKVfgOj+pDHGWO9fLU9qAUo4=;
        b=XMjuwgUBQcmhe9QAxCtbjipNmaLNn3s4R6fCSFid261yeTZ9uQ/WFR4SMZbGu+4aQ7
         DIlwmKe0VKYJsbGFX2UUUFGMJGpgNndNR6kJzByGVTI5vYpQSx8QvrQeiA0syns8ua85
         JiM97OwxFoqpkMSL5LermenGFWF7Ncl2ZolRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956115; x=1752560915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epMO4JAtFgFxLvmQB+DGKVfgOj+pDHGWO9fLU9qAUo4=;
        b=b3/LJZrFkvtfyPpLdWX2U7kkdmyr0J6ldm9nfY1LPDPh96uYfbQbnPYcI4o+NlthmE
         I+sALu7h7dZkEaF8yzeKnzw3hnRAS34kfe6O8z3tBskJby8954GVGMf6NpgJ92rfqs3K
         b10hqpdssKCguSxwZNSsjyrAWAGet0fY2xPiUoigpC+2bwZGXKQxuBR0itARwrk2IeWJ
         mRviym81rVKMEo1mpA2tUsntvfzlJtxTkLbjmjNHLMcchuWz34c2BV6SH5xHbNsORNze
         nSpW80SCd6RJ55NOQlAjrCQm2MKZL4tsdaAdKzDwpfXTXuO4eNncMo9VX3eWFJt30XId
         u9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUTBHCnCuN2Zvz70wddK2VEj0BbksTVUuOnl9oaXB/TifXTggI8ze4Q75oS7NChSxgwbJb1kRHbgKhN@vger.kernel.org
X-Gm-Message-State: AOJu0YwIWcdVPTLmKDNMRNuXnQGl48EN0wG7CKH0HyReNSoffhp2SNl+
	EbS15Scl+jXN3wzfq1jEB2Wa4jWoudPly/mslbyDhnvNKdEitgwaJw66HzRzptNdqOd4nO/LF1y
	J0yo=
X-Gm-Gg: ASbGncs0oTjje9AtdgeaMyWdjMEBDrtlA7oeLMJfHGiTyHFsTBP1xJuYS6ocMjWQIeB
	cX2vsDw7otmXNvqWgkYi1hXbLNi0hYzAzHc0N9zvl4gDM1ajzxEj1tVA8uy1k+4bV3kztcsvRE6
	AEfIRbE7GmYaI+XfJM8I5omdPknRaT5TPC1aA6et/6QSunrYe7y4I1sODdb52W8C2bS+K9obGCm
	1tIL1m6ilMOymvyuUcFhiNkmAfw6GbZJfKqDWKLGQd/QbzLhwHrBmYnm04zt0ABsz3e0a0PgKo0
	+z9ww5HboXk+P8d10QyBWOxGx8EpLKUA7mZpDo7WAhq8TGvKuASZ9s5NIN39140P0Wsq77jhdAV
	+h3a+D8i5TIg63FYkWsp8LKW0
X-Google-Smtp-Source: AGHT+IF7B2ciXrjrnyHMMmprkxRY96LfBHHXVMOrhjGILMrLrFEZxn3Fi7JTBBJrawGiSeTNix1eaA==
X-Received: by 2002:a05:6512:4005:b0:553:65eb:3197 with SMTP id 2adb3069b0e04-557f831848bmr578292e87.22.1751956114671;
        Mon, 07 Jul 2025 23:28:34 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32e1b144c24sm14927731fa.91.2025.07.07.23.28.34
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 23:28:34 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-556373661aaso3573762e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jul 2025 23:28:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9nR00KdRNhOK9/9WzwDJcBD741YLRkDcX5aEbaPJ8RRu74mxIRMlGqeeD+0CV5B0HYF2S13thLNHw@vger.kernel.org
X-Received: by 2002:a05:651c:3254:20b0:32b:78ce:be8e with SMTP id
 38308e7fff4ca-32f39b48b77mr3774321fa.32.1751956114000; Mon, 07 Jul 2025
 23:28:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-12-5710f9d030aa@chromium.org>
 <20250629180534.GN24912@pendragon.ideasonboard.com> <CANiDSCvcQ9MA+WBMQTpUzSxDLNiKpvaHsb-pDHTuiUQekgXvQA@mail.gmail.com>
In-Reply-To: <CANiDSCvcQ9MA+WBMQTpUzSxDLNiKpvaHsb-pDHTuiUQekgXvQA@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 8 Jul 2025 08:28:21 +0200
X-Gmail-Original-Message-ID: <CANiDSCtq0cr1LgFCgvdBtWcE3z1MWZEjc0e1wTH_BYPETC+s4Q@mail.gmail.com>
X-Gm-Features: Ac12FXyYQKv3E7HlyxyFaWCzaarpcfNGMVTbadH4TCiFfkv-rgAm8ijV2sCYmI0
Message-ID: <CANiDSCtq0cr1LgFCgvdBtWcE3z1MWZEjc0e1wTH_BYPETC+s4Q@mail.gmail.com>
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

Hi Laurent

On Tue, 1 Jul 2025 at 13:20, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Laurent and Hans
>
>
> On Sun, 29 Jun 2025 at 20:06, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Ricardo,
> >
> > Thank you for the patch.
> >
> > I would use "software entities" and not "virtual entities" in the
> > subject line and everywhere else, as those entities are not virtual.
> >
> > On Thu, Jun 05, 2025 at 05:53:05PM +0000, Ricardo Ribalda wrote:
> > > Neither the GPIO nor the SWENTITY entities form part of the device
> > > pipeline. We just create them to hold emulated uvc controls.
> > >
> > > When the device initializes, a warning is thrown by the v4l2 core:
> > > uvcvideo 1-1:1.0: Entity type for entity SWENTITY was not initialized!
> > >
> > > There are no entity function that matches what we are doing here, and
> > > it does not make to much sense to create a function for entities that
> > > do not really exist.
> >
> > I don't agree with this. The purpose of reporting entities to userspace
> > through the MC API is to let application enumerate what entities a
> > device contains. Being able to enumerate software entities seems as
> > useful as being able to enumerate hardware entities.
>
> What function shall we use in this case? Nothing here seems to match a
> software entity
> https://www.kernel.org/doc/html/latest/userspace-api/media/mediactl/media-types.html
>
> Any suggestion for name?
> Shall we just live with the warning in dmesg?

 I just realised that if/when we move to the control framework, the
software entity will be gone.... So to avoid introducing a uAPI change
that will be reverted later I think that we should keep this patch.

Regards
>
> >
> > > Do not create MC entities for them and pretend nothing happened here.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_entity.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
> > > index d1a652ef35ec34801bd39a5124b834edf838a79e..2dbeb4ab0c4c8cc763ff2dcd2d836a50f3c6a040 100644
> > > --- a/drivers/media/usb/uvc/uvc_entity.c
> > > +++ b/drivers/media/usb/uvc/uvc_entity.c
> > > @@ -72,6 +72,16 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
> > >  {
> > >       int ret;
> > >
> > > +     /*
> > > +      * Do not initialize virtual entities, they do not really exist
> > > +      * and are not connected to any other entities.
> > > +      */
> > > +     switch (UVC_ENTITY_TYPE(entity)) {
> > > +     case UVC_EXT_GPIO_UNIT:
> > > +     case UVC_SWENTITY_UNIT:
> > > +             return 0;
> > > +     }
> > > +
> > >       if (UVC_ENTITY_TYPE(entity) != UVC_TT_STREAMING) {
> > >               u32 function;
> > >
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
>
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda

