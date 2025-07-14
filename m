Return-Path: <linux-acpi+bounces-15143-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 148A0B04510
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 18:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6322E1A63B17
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154F25F797;
	Mon, 14 Jul 2025 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WH6gFbaJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191725CC73
	for <linux-acpi@vger.kernel.org>; Mon, 14 Jul 2025 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509108; cv=none; b=qOkb8Xx8zyaVJvggCrzbdGrU01duGLBF/3eXIvGBiVrWjSE1dpDLIs74KMAJuACpAaSj+1JlxevbVqMxSvPf5HS8MemslCKepvDoiUyh1RaipM8MyaQO0cmUCyEOol8FGWg5xvVx3xS6icAmzhqoYZmoRKbJ6CNK4IsKgon8moY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509108; c=relaxed/simple;
	bh=JxBVcWXOzrC+pQuiz7DoBffwFHlGca0wC939BUa4mlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YofmCkfB7+XjXjcftO+VzI4diwmVNhbrmGmCEN8NoEsxcC8KR+PiqcrflFjBrmTnNqmfQjdlTOEXdj6XvRYuPN0j4E02/16Y0hx5wp66kf2oIuzrSgImSi+1+Z8omWfLCl2AecR1lc51TPZ02gxxVWX7nIpA9DjGoazmziWJ7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WH6gFbaJ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553d52cb80dso4085022e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 14 Jul 2025 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752509105; x=1753113905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CDahj8/rNyyq5vqGI+SiuXe8oo3E19xokCP/r0ki8Vk=;
        b=WH6gFbaJvIoQTtthRH12ic6ENiZAFohuQZJaV3HJoQ9wh4nR0HxYS7bTzCTZDPiKn0
         REjMwghjboXL4QSmyJc3VgeARbwc81NtelJMkxIkHNQ/hNXEYc3al61oyqCC1uaHLBT/
         Pro5kbJPdS4Ql7S7xWhZs/RlC5Pg3geymgKEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509105; x=1753113905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDahj8/rNyyq5vqGI+SiuXe8oo3E19xokCP/r0ki8Vk=;
        b=AyTwR557L3V587QCkwzKFL1Rz3XXwtDvoW2A7QhVtiwNnQ55kqr+7FLYZDs+yWQe03
         T8/IfwtXe2ipEU48yQRRqmb3hfovIZ5aiU4YmZSkD2bl8fdR6fFDyJbOP6+r2MxSLznQ
         iW4ZbyK7RxCDmIEqMLsbxeshnkuOrKRXLw4X7XySag4RlqU9doRirIwDjvpv7QPrztF+
         r7cM+P++h1VdG71eiFDOhCAbKCbzr0/TlJ4Sutl3DGH9a9ZXlfqybQvj1Zj5UQAYrLcR
         LB2GnPQOdcpAGv5pBfgeU3I00wcr4yTvNfPjdiaUnm9pXH8ysrOfeDqwr/Dn2A8iVeY+
         ufjg==
X-Forwarded-Encrypted: i=1; AJvYcCW4B/bNq0yQHuZyFB6+BpeVLSYvCYfBkqb/S91kh3wkIzl/AcgOoz2JZ6hFaSLXQLNSqZ0wKeC9mHEL@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUozZWo2YBIuOVZRZ0C+dhuOpOT34BRi6rVVF2BCqQyzWours
	Qt/snjkxQQTDDRlT4mSNATAwINkLTqH+GBIEBMhiID6lVameoZ1aT6N/OIkfP1rTmmQ2zq3OU0y
	3zo2EyQ==
X-Gm-Gg: ASbGncsXUttII8EJVvUQuqEij/IwEHfTHFl+o6blgmiUAp4igqzoq7QCz73tWEyLLFj
	1qno1v4JdL337aZFtZWXyAEo4reuEKW2VzfDcMO7IcaQqZDWAzP66IakN+TsksGQNbymnAF5GHa
	n0mSLyIc7ht0+Au71lHH2f+gJLxcEZOKS/glxy79c85CVXsJrD3FzjRBNH6tlrQG7vB6WaJwMqp
	wJBikcuIpG1gsCCsPep72gQL+wP8t2qcUHJwAsSaXfH6SsWmcR1bEZvxgJQmuJGqtuT4Em11e7X
	16nFKf2k8KwKjrhsFL5Vg6J+xAF7jVgL6o4VJtOlR31cmfldWLLr0SeBpThHeSUdDixIhRE29wv
	Vu//pQEU2OQ2vlyje7PHM7LajJLICBwK814u/NcAxtmy0YrSCTELaZ3IDGfvw
X-Google-Smtp-Source: AGHT+IGZWoQW/AEid2FB5bP3uWfgLglPGNQ2vnOJpVMvHmePKMroSVrN+f6ilOxOH+b6gDHJZcq7pw==
X-Received: by 2002:ac2:46c6:0:b0:554:f82f:181a with SMTP id 2adb3069b0e04-55a1c43ea8cmr50193e87.2.1752509104547;
        Mon, 14 Jul 2025 09:05:04 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b88e79sm2008183e87.252.2025.07.14.09.05.03
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 09:05:04 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so6031192e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 14 Jul 2025 09:05:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJiWn4QJY+opqvK/D6AGsZyV/V9EGul1OqGH7tAnYSxbMKTtH+AAFf5OYd3RzThiNVecMRGpk2FgZ2@vger.kernel.org
X-Received: by 2002:a05:6512:3b9e:b0:553:2884:5fb3 with SMTP id
 2adb3069b0e04-55a1c467663mr45477e87.12.1752509103021; Mon, 14 Jul 2025
 09:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-12-5710f9d030aa@chromium.org>
 <20250629180534.GN24912@pendragon.ideasonboard.com> <CANiDSCvcQ9MA+WBMQTpUzSxDLNiKpvaHsb-pDHTuiUQekgXvQA@mail.gmail.com>
 <CANiDSCtq0cr1LgFCgvdBtWcE3z1MWZEjc0e1wTH_BYPETC+s4Q@mail.gmail.com> <20250714143617.GK8243@pendragon.ideasonboard.com>
In-Reply-To: <20250714143617.GK8243@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Jul 2025 18:04:50 +0200
X-Gmail-Original-Message-ID: <CANiDSCud66tcaODuVA1TreEQ3k8u4k-6ghzRQedTPFcT3j+9VQ@mail.gmail.com>
X-Gm-Features: Ac12FXxJPvBJAM528bNZN02Nhk1iZCMcKXmyshIGKqYKQPEJihw9v-tpgzFvPcg
Message-ID: <CANiDSCud66tcaODuVA1TreEQ3k8u4k-6ghzRQedTPFcT3j+9VQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] media: uvcvideo: Do not create MC entities for
 virtual entities
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 16:36, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Tue, Jul 08, 2025 at 08:28:21AM +0200, Ricardo Ribalda wrote:
> > On Tue, 1 Jul 2025 at 13:20, Ricardo Ribalda wrote:
> > > On Sun, 29 Jun 2025 at 20:06, Laurent Pinchart wrote:
> > > > Hi Ricardo,
> > > >
> > > > Thank you for the patch.
> > > >
> > > > I would use "software entities" and not "virtual entities" in the
> > > > subject line and everywhere else, as those entities are not virtual.
> > > >
> > > > On Thu, Jun 05, 2025 at 05:53:05PM +0000, Ricardo Ribalda wrote:
> > > > > Neither the GPIO nor the SWENTITY entities form part of the device
> > > > > pipeline. We just create them to hold emulated uvc controls.
> > > > >
> > > > > When the device initializes, a warning is thrown by the v4l2 core:
> > > > > uvcvideo 1-1:1.0: Entity type for entity SWENTITY was not initialized!
> > > > >
> > > > > There are no entity function that matches what we are doing here, and
> > > > > it does not make to much sense to create a function for entities that
> > > > > do not really exist.
> > > >
> > > > I don't agree with this. The purpose of reporting entities to userspace
> > > > through the MC API is to let application enumerate what entities a
> > > > device contains. Being able to enumerate software entities seems as
> > > > useful as being able to enumerate hardware entities.
> > >
> > > What function shall we use in this case? Nothing here seems to match a
> > > software entity
> > > https://www.kernel.org/doc/html/latest/userspace-api/media/mediactl/media-types.html
> > >
> > > Any suggestion for name?
> > > Shall we just live with the warning in dmesg?
> >
> >  I just realised that if/when we move to the control framework, the
> > software entity will be gone.... So to avoid introducing a uAPI change
> > that will be reverted later I think that we should keep this patch.
>
> You know my opinion about moving to the control framework, so that's not
> a very compelling argument :-)

Correct me if I am wrong, your opinion is that it will take too much
work, not that it can't be done or that it is a bad idea.

Will send a patch using MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER, but
when/if we use the control framework, please let me drop the swentity.

Thanks!


>
> We could use MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER, as that's the
> function already used by XUs, and the SWENTITY fulfills the same role as
> XUs in some devices.
>
> > > > > Do not create MC entities for them and pretend nothing happened here.
> > > > >
> > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > ---
> > > > >  drivers/media/usb/uvc/uvc_entity.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >
> > > > > diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
> > > > > index d1a652ef35ec34801bd39a5124b834edf838a79e..2dbeb4ab0c4c8cc763ff2dcd2d836a50f3c6a040 100644
> > > > > --- a/drivers/media/usb/uvc/uvc_entity.c
> > > > > +++ b/drivers/media/usb/uvc/uvc_entity.c
> > > > > @@ -72,6 +72,16 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
> > > > >  {
> > > > >       int ret;
> > > > >
> > > > > +     /*
> > > > > +      * Do not initialize virtual entities, they do not really exist
> > > > > +      * and are not connected to any other entities.
> > > > > +      */
> > > > > +     switch (UVC_ENTITY_TYPE(entity)) {
> > > > > +     case UVC_EXT_GPIO_UNIT:
> > > > > +     case UVC_SWENTITY_UNIT:
> > > > > +             return 0;
> > > > > +     }
> > > > > +
> > > > >       if (UVC_ENTITY_TYPE(entity) != UVC_TT_STREAMING) {
> > > > >               u32 function;
> > > > >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

