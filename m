Return-Path: <linux-acpi+bounces-15140-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2D0B04490
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 17:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5BB7A9E3E
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584E725BEF3;
	Mon, 14 Jul 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TO3Iq7Qe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A217258CF1
	for <linux-acpi@vger.kernel.org>; Mon, 14 Jul 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508020; cv=none; b=mEVvOHk8Evc/Cl6Z1HV/VR9NQ9Cj997GISZGgyNuvGAcQyGYULnWlhsdUJMh3EaW3CdbovzUF0fhfvgJTMlbPVkUZ7Avg4B3B+bimMmfEfnrWD0KitVTiBqV4UnCp4ZmpwgP0Hbf4SG4f9RJyhZa8FvIFs/wQKpyGnO2aIo8MKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508020; c=relaxed/simple;
	bh=5LlMEN4J3o3aD6YDXjwZ5zCkBWXWLqScnxci+wtPW0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUN0tb2760e+3I6PUaTSCQpJQr4NMpXns+vhkAa5gQ//jYBW9LRErjXu35U9sJfIpCjQXO1aVfwjST7owGDF+qdl8X1wXUikvecbSkFrww18KwUcGIhgNTINi9JXmIaVckQLlS5K1Q/ACs7fJRNCQVAWmi5t4FfEx/pRQyM1qqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TO3Iq7Qe; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553b6a349ccso5532481e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 14 Jul 2025 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752508016; x=1753112816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9h6RiMEbdSPWHXVsj9OLxwFBmTJFmqoquTZg92Kpnmk=;
        b=TO3Iq7QeVk002ueq3Qx/vgiIdEEyI7LQfxkhURcouoXe4MOrNKo+tGUbHirZ++TWyf
         Phcwg3ctQpb9YeTAzrIjYk3WOhf1KeiN0NaOkkg24Jkqq/MLe1ni1bxlRj8OJzwb2ESX
         SMoThRskLQ3+cO1SdpObAgNnPg+xxrCUx5zhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752508016; x=1753112816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9h6RiMEbdSPWHXVsj9OLxwFBmTJFmqoquTZg92Kpnmk=;
        b=I41nsKYX8wb5AgXaKuyGTyTo/yxvifK/2fvm+ey3Jdncaf8uQZwtO29nbyKHRSH1OV
         1aiJftdkh5yjW8qynlSgkxqPH8+zkMUGoTsZbxQNPlqQSrrvFg/6ycGGqdkzI80nt9w2
         gcYC5EgLqr65F91LV9GOu8HvQnS9eo8qGSK3JHmTVQlLJns/LBHMpRSEhbO4bJkliJqZ
         nwKWkMP6t8GtixYzAlnYRm9qMrgcO6Gsia/bIhI4CmJ1wpNpS+Th3CINN5SpsymtuUIp
         /a3ESh8GuFvWtAmJBFvyg1SyLbnraxDfLwfsp27DgRidRbqvzm+vrvl+v4qdHGx4QDJf
         1mFg==
X-Forwarded-Encrypted: i=1; AJvYcCWvyRjCQgE8q9Ae4RiRTYPUIZg2EuiaOZm3+3mZhvnCUsOweDNIulo/8YnD4LmPyHExaonnAjjnVsUP@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrJ4N1KEWrRLE7fVGM/qGKPQw/eZ4+OqBaA3BfqzXGfR2hO3j
	0Ga5cRC89bzFTLwc3ALJsKboIlPtUJ/Wp8MtKxguKDziviuM2hxckupAaC9TX5WJ7MLY7qM9wgI
	bFaqy+g==
X-Gm-Gg: ASbGnctFmJbQyQOBYnlXpoZKThOUbHMQJMg50rTaDi8+57h5L6qSqNRHfePQG4ucJwI
	fymvn/SNMZk/MPjLITcUZuOMfXfOslB3awEVqEyOTpcOaYVJav36q43u5cGD/Pe1tSmZGKuJsK2
	ySncgZVti0z2HL6XMK06L9JqCRypeq6j+ZuvRbAHqjXqn39Z1swRUa8nDtOL407Z3MBB9774psL
	8KTW92Sz4mLnPR35qNx0SINypFPwnZfbt1+OHa7UbD1foTpaDzGiih8M4inAzPvFDYDAphpFeIO
	G5c8RPRyPN/rO/ZMray4HNfTgYTT2UyDvkbSPTX7Gm9+JnLWsdUVCbFKoNoSMkfZyXqcIC3LT2Y
	LVkej+ahhzT9BCtgbKSQIc1s21iiJJuVmEPUKwswN6m/O4FEqyZU2glSgispU
X-Google-Smtp-Source: AGHT+IGusZB/BRsAgr/nqTtKIvmPlhCspK0gKnrDAiok2hp+zws/2wbCdK2aX8orWoIwsqVq3ZSwsw==
X-Received: by 2002:a05:6512:4026:b0:550:e527:886f with SMTP id 2adb3069b0e04-55a046264ebmr3902920e87.51.1752508016420;
        Mon, 14 Jul 2025 08:46:56 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbb5dsm1989823e87.18.2025.07.14.08.46.53
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:46:53 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553b6a349ccso5532377e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 14 Jul 2025 08:46:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLT7rautGd1gDi2YiHPkoQJl72OjMFWNbh15RD6gd71dvmpmFxnDtSbdCudPv7EnwsttIiEsL9nAgG@vger.kernel.org
X-Received: by 2002:a05:6512:b10:b0:553:3492:b708 with SMTP id
 2adb3069b0e04-55a046250abmr3344250e87.49.1752508013248; Mon, 14 Jul 2025
 08:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-10-5710f9d030aa@chromium.org>
 <20250629181246.GE6260@pendragon.ideasonboard.com> <CANiDSCsu0RT4dcGyBJRutP=9HTe+niUoohxTZE=qJ8O_9ez=+A@mail.gmail.com>
 <20250714142926.GI8243@pendragon.ideasonboard.com>
In-Reply-To: <20250714142926.GI8243@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Jul 2025 17:46:40 +0200
X-Gmail-Original-Message-ID: <CANiDSCvFe23xmrJ0-qbWWa6+vKGb+QdDFV8VSLkmWdAnfsFtzw@mail.gmail.com>
X-Gm-Features: Ac12FXzUtyaVLj7tKhzc2QjlgMNdUTCkm86hTg8iZ2lfMiulh_fOCFYDlXtaIQQ
Message-ID: <CANiDSCvFe23xmrJ0-qbWWa6+vKGb+QdDFV8VSLkmWdAnfsFtzw@mail.gmail.com>
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

On Mon, 14 Jul 2025 at 16:30, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Tue, Jul 01, 2025 at 01:13:10PM +0200, Ricardo Ribalda wrote:
> > On Sun, 29 Jun 2025 at 20:13, Laurent Pinchart wrote:
> > > On Thu, Jun 05, 2025 at 05:53:03PM +0000, Ricardo Ribalda wrote:
> > > > Virtual entities need to provide more values than get_cur and get_cur
> > >
> > > I think you meant "get_info and get_cur".
> > >
> > > > for their controls. Add support for get_def, get_min, get_max and
> > > > get_res.
> > >
> > > Do they ? The UVC specification defines controls that don't list
> > > GET_DEF, GET_MIN, GET_MAX and GET_RES as mandatory requests. Can't we do
> > > the same for the software controls ? This patch is meant to support the
> > > UVC_SWENTITY_ORIENTATION and UVC_SWENTITY_ROTATION control in the next
> > > patch, and those are read-only controls. Aren't GET_INFO and GET_CUR
> > > enough ?
> >
> > V4L2_CID_CAMERA_ROTATION has the type UVC_CTRL_DATA_TYPE_UNSIGNED,
> > that time requires get_min and get_max.
>
> Where does that requirement come from ? Is it because how the
> corresponding V4L2 type (V4L2_CTRL_TYPE_INTEGER) is handled in
> uvc_ctrl_clamp() ? uvc_ctrl_clamp() is only called when setting a
> control, from uvc_ctrl_set(), and V4L2_CID_CAMERA_ROTATION should be
> read-only.

It its for VIDIOC_QUERY_EXT_CTRL

uvc_query_v4l2_ctrl -> __uvc_query_v4l2_ctrl -> __uvc_queryctrl_boundaries

We need to list the min, max, def and step for every control. They are
fetched with uvc_ctrl_populate_cache()



>
> > We can create a new type UVC_CTRL_DATA_TYPE_UNSIGNED_READ_ONLY that
> > fakes min, max and res, but I think that it is cleaner this approach.
> >
> > > > This is a preparation patch.
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_ctrl.c | 12 ++++++++++++
> > > >  drivers/media/usb/uvc/uvcvideo.h |  8 ++++++++
> > > >  2 files changed, 20 insertions(+)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > index 21ec7b978bc7aca21db7cb8fd5d135d876f3330c..59be62ae24a4219fa9d7aacf2ae7382c95362178 100644
> > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > @@ -596,6 +596,18 @@ static int uvc_ctrl_query_entity(struct uvc_device *dev,
> > > >       if (query == UVC_GET_CUR && ctrl->entity->get_cur)
> > > >               return ctrl->entity->get_cur(dev, ctrl->entity,
> > > >                                            ctrl->info.selector, data, len);
> > > > +     if (query == UVC_GET_DEF && ctrl->entity->get_def)
> > > > +             return ctrl->entity->get_def(dev, ctrl->entity,
> > > > +                                          ctrl->info.selector, data, len);
> > > > +     if (query == UVC_GET_MIN && ctrl->entity->get_min)
> > > > +             return ctrl->entity->get_min(dev, ctrl->entity,
> > > > +                                          ctrl->info.selector, data, len);
> > > > +     if (query == UVC_GET_MAX && ctrl->entity->get_max)
> > > > +             return ctrl->entity->get_max(dev, ctrl->entity,
> > > > +                                          ctrl->info.selector, data, len);
> > > > +     if (query == UVC_GET_RES && ctrl->entity->get_res)
> > > > +             return ctrl->entity->get_res(dev, ctrl->entity,
> > > > +                                          ctrl->info.selector, data, len);
> > > >       if (query == UVC_GET_INFO && ctrl->entity->get_info)
> > > >               return ctrl->entity->get_info(dev, ctrl->entity,
> > > >                                             ctrl->info.selector, data);
> > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > index a931750bdea25b9062dcc7644bf5f2ed89c1cb4c..d6da8ed3ad4cf3377df49923e051fe04d83d2e38 100644
> > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > @@ -261,6 +261,14 @@ struct uvc_entity {
> > > >                       u8 cs, u8 *caps);
> > > >       int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
> > > >                      u8 cs, void *data, u16 size);
> > > > +     int (*get_def)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > +                    u8 cs, void *data, u16 size);
> > > > +     int (*get_min)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > +                    u8 cs, void *data, u16 size);
> > > > +     int (*get_max)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > +                    u8 cs, void *data, u16 size);
> > > > +     int (*get_res)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > +                    u8 cs, void *data, u16 size);
> > > >
> > > >       unsigned int ncontrols;
> > > >       struct uvc_control *controls;
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda

