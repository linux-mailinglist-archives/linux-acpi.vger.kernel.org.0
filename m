Return-Path: <linux-acpi+bounces-14879-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA11AEF657
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 13:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D1D4A209E
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 11:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A526D4C1;
	Tue,  1 Jul 2025 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KvcE3hiJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678625A2A4
	for <linux-acpi@vger.kernel.org>; Tue,  1 Jul 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368796; cv=none; b=j3uq/Qw6njOLNFnnBcqv8SsE1zyGSr4ut4yqqiiUkfI73WISP1dqnOqONkqbVOJ9sN9eVjT/7DRTQNARwY2tTzBgYXlpq9MRShCvdiQXZtL/EjPUXytBKpCCQdeDRg0av9cMKsscKfsKScfymBqtxq1f9c9eR8nA1mg6mTiuUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368796; c=relaxed/simple;
	bh=FeqVp2yCUZ3ij1peE3WeZz1cWGh+QgySUCT2N/2Xbjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqeAdCxWJWURzXeH8tONxvk18t1MI0EQVgFZZH42ZqAwGgziJFWwFuicjMy15OtlljZNJEbLRjQpboCBUB7X3R8VLyaXh02NsFmP1BOe3FsAA0DnLLj5+ykAAEAGGDz4olWzZbeaBMw8CkZOzLTn0jHpVaKn6YfNYGFWjCR2bnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KvcE3hiJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so6544925a12.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 04:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751368792; x=1751973592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bGjQ61S1++mVkf3/jYVKvuXkIa1IOFszhbgMmRDC9tQ=;
        b=KvcE3hiJEeaZhWlUYMdg/Az5G8+zFauJvF+pZnzPpCvexezPa1pYhES0apTrXePJI0
         X8BZDV7KIqsq4+foX5qxMjjejvHHoCiOZq46cFq5US/O3KGLW4OPvXdAjyYMlc2f8bmw
         rhe37unhsOONKPiMnLWZMmraY3RrNG7Wp8PF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751368792; x=1751973592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGjQ61S1++mVkf3/jYVKvuXkIa1IOFszhbgMmRDC9tQ=;
        b=mOl4CNU9mFFLuLqHcj6chPia0lSL3RFh1+LbqIBabmVwf03JhHnQLVmO4PVxEbGk0v
         qC+rYWJ95N8+6Ep76it7U57hDQ6zgiOYzURwSI+FjRjtBYXEL9A+1Len94sXZ5MqwiVM
         TENYPFBEzBcdvdjPLI1cChZkCGC9MU8MS8Xkt+cMBCRyUGAkbWd/734fU9fkLEElia0p
         HyP7vC0idoq8oJOV/ArdJps/nZnxGtKyWwOUDXstWJe5ElQ1FvD3f/CNROM9V032GpKv
         d0cqV9Paol550IY/mXGo4XHq9mHGk2SsBhM47aQbKP10vmLlWEgeQVgohxB+vtuc2pUO
         56cg==
X-Forwarded-Encrypted: i=1; AJvYcCXL9tpAjlgG3J5xrefG7WUvsnQFEk3qax+PtSO1NI88nTC04oAziSkPPqY8OE8fihZirJAi312iuJ19@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvbd4qQVPZhXl+JObudyOAY7nrYXJ9bxrE/53L8oXYcqMEQWvd
	ptJ9RfCqnrGCXaaeuvAqFDXWrPxyybj6D58vB4ONKHlGYGCDw0jJkU2r1a0yzaUwtpi8ISTMVhU
	vHIcmsw==
X-Gm-Gg: ASbGncs/P/D1oQCLM810FG5QXfHb/UbdDhPwU5VMASgy1N58Wfem9C0UXNktRnJekw9
	TvBsM2dKgPwgs08aO+sPPAag85Z7PD9XTrI7X6vVQfTZbntckmZ/1T/YDPkxXmKGSUl0zWM26Bg
	4/Ph41ItWHN+6BswaZZsnoRDvf8GyQREaDXpuIDlN6GdC2sVbyXZGcsYS1t6b5sHwMmzxk/cSL/
	Nle8YhF3lfHECB4mABFGnvw6yDZvonq+PDrjm2AHZlOp1P22zlAp96xXyD1lKDJyHxa96Ri/zFP
	wqWvE1VN7YOPgfJxEv8AHiPRQf4y5i9SRAf1RMla1L+oNg8crZrl2tayT4I6D09bq8EDr9tNsfn
	hUbT6jvYfFtHJjAHEINeX/uzT
X-Google-Smtp-Source: AGHT+IE7NFoQDQG0a4Y4+JoLj4P/TajBGC0TMo/t2CtKZC8EWE4ZU4d00GI4uvrc8kocPlWIQOsHCw==
X-Received: by 2002:a17:907:1ca3:b0:ae1:771d:aea4 with SMTP id a640c23a62f3a-ae3500c9236mr1736707166b.36.1751368792318;
        Tue, 01 Jul 2025 04:19:52 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3a23ba50bsm243630566b.116.2025.07.01.04.19.52
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 04:19:52 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae3b336e936so75111866b.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 04:19:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXi8+e8y15o2FzYrSMie/QyKHwVeRYeTrfbaMZMfgVdxmpj0LzQlhmMoEexc40pu2wjyVbvJgPD32Fr@vger.kernel.org
X-Received: by 2002:a05:6512:224b:b0:553:cf38:5ea1 with SMTP id
 2adb3069b0e04-5550b87b62cmr5806214e87.15.1751368403239; Tue, 01 Jul 2025
 04:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-10-5710f9d030aa@chromium.org> <20250629181246.GE6260@pendragon.ideasonboard.com>
In-Reply-To: <20250629181246.GE6260@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 1 Jul 2025 13:13:10 +0200
X-Gmail-Original-Message-ID: <CANiDSCsu0RT4dcGyBJRutP=9HTe+niUoohxTZE=qJ8O_9ez=+A@mail.gmail.com>
X-Gm-Features: Ac12FXyUB7J2CzeHXupatytT-Rncr6S6tZS3kWRK4b67_iOG9R3ef-6_Er_0YxQ
Message-ID: <CANiDSCsu0RT4dcGyBJRutP=9HTe+niUoohxTZE=qJ8O_9ez=+A@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] media: uvcvideo: Add get_* functions to uvc_entity
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Sun, 29 Jun 2025 at 20:13, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Thu, Jun 05, 2025 at 05:53:03PM +0000, Ricardo Ribalda wrote:
> > Virtual entities need to provide more values than get_cur and get_cur
>
> I think you meant "get_info and get_cur".
>
> > for their controls. Add support for get_def, get_min, get_max and
> > get_res.
>
> Do they ? The UVC specification defines controls that don't list
> GET_DEF, GET_MIN, GET_MAX and GET_RES as mandatory requests. Can't we do
> the same for the software controls ? This patch is meant to support the
> UVC_SWENTITY_ORIENTATION and UVC_SWENTITY_ROTATION control in the next
> patch, and those are read-only controls. Aren't GET_INFO and GET_CUR
> enough ?

V4L2_CID_CAMERA_ROTATION has the type UVC_CTRL_DATA_TYPE_UNSIGNED,
that time requires get_min and get_max.
We can create a new type UVC_CTRL_DATA_TYPE_UNSIGNED_READ_ONLY that
fakes min, max and res, but I think that it is cleaner this approach.

>
> >
> > This is a preparation patch.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 12 ++++++++++++
> >  drivers/media/usb/uvc/uvcvideo.h |  8 ++++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 21ec7b978bc7aca21db7cb8fd5d135d876f3330c..59be62ae24a4219fa9d7aacf2ae7382c95362178 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -596,6 +596,18 @@ static int uvc_ctrl_query_entity(struct uvc_device *dev,
> >       if (query == UVC_GET_CUR && ctrl->entity->get_cur)
> >               return ctrl->entity->get_cur(dev, ctrl->entity,
> >                                            ctrl->info.selector, data, len);
> > +     if (query == UVC_GET_DEF && ctrl->entity->get_def)
> > +             return ctrl->entity->get_def(dev, ctrl->entity,
> > +                                          ctrl->info.selector, data, len);
> > +     if (query == UVC_GET_MIN && ctrl->entity->get_min)
> > +             return ctrl->entity->get_min(dev, ctrl->entity,
> > +                                          ctrl->info.selector, data, len);
> > +     if (query == UVC_GET_MAX && ctrl->entity->get_max)
> > +             return ctrl->entity->get_max(dev, ctrl->entity,
> > +                                          ctrl->info.selector, data, len);
> > +     if (query == UVC_GET_RES && ctrl->entity->get_res)
> > +             return ctrl->entity->get_res(dev, ctrl->entity,
> > +                                          ctrl->info.selector, data, len);
> >       if (query == UVC_GET_INFO && ctrl->entity->get_info)
> >               return ctrl->entity->get_info(dev, ctrl->entity,
> >                                             ctrl->info.selector, data);
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index a931750bdea25b9062dcc7644bf5f2ed89c1cb4c..d6da8ed3ad4cf3377df49923e051fe04d83d2e38 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -261,6 +261,14 @@ struct uvc_entity {
> >                       u8 cs, u8 *caps);
> >       int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
> >                      u8 cs, void *data, u16 size);
> > +     int (*get_def)(struct uvc_device *dev, struct uvc_entity *entity,
> > +                    u8 cs, void *data, u16 size);
> > +     int (*get_min)(struct uvc_device *dev, struct uvc_entity *entity,
> > +                    u8 cs, void *data, u16 size);
> > +     int (*get_max)(struct uvc_device *dev, struct uvc_entity *entity,
> > +                    u8 cs, void *data, u16 size);
> > +     int (*get_res)(struct uvc_device *dev, struct uvc_entity *entity,
> > +                    u8 cs, void *data, u16 size);
> >
> >       unsigned int ncontrols;
> >       struct uvc_control *controls;
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

