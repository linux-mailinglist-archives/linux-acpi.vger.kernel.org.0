Return-Path: <linux-acpi+bounces-15142-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C33B044E4
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 17:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF16188984B
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51AA25DB0B;
	Mon, 14 Jul 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HRD+xeik"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD7E25B305
	for <linux-acpi@vger.kernel.org>; Mon, 14 Jul 2025 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508784; cv=none; b=LKzk9/+NLzoM/B1IOksLGnjiBtKQu/62FUMiJ36WPampidS3rxRZBlhR4PWEi1l0Thnb6ogmGHk3wgUanyPEPR0M4Pzjrs0Jwv3WZGsXOMEHMEo/TKn/inU1zY3l4O2EaQ/Aw08VqW1tviPQrgc1G9RDahwEmZiy/FSNLF7VvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508784; c=relaxed/simple;
	bh=jkfpbBDz6fsZzySxLlb7hy7jGu+rjZvw977kguTtv3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDeNdOlFMYqmaYzHKRdwjXjHIOxrxHRWpSXXKXyReZ7yHFGkEc8k80KAmvzuoNll91QCC6FIJYDjc3FfxvElbCRRs7LFieFgftPWUKdTWBhyXvr/cYtRTSHSq1/bqZYo9WatdLxPbpmGqPth7e8z03fOPXJ1lhkFzQmXYw9Mreg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HRD+xeik; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55628eaec6cso3822255e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 14 Jul 2025 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752508780; x=1753113580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hof50iYCL5T7/Bkgw5ZGSrfNWjcSfleM91HbwvcCRsY=;
        b=HRD+xeikeD6vQVifHUplqWFmZ3tniT2lPed1upbz7Ny3g0rr+9Nl12XBtGmdbI5bMX
         YPHoa3tejbWxZXCdU8XqEvgA4n7WuawI1hBv6c+Tzihvnh8D+DBx+++SdAJ9bvr8zQuh
         LHKZJDrohZTlHZA20MUBOj4z+8I30jwikDcMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752508780; x=1753113580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hof50iYCL5T7/Bkgw5ZGSrfNWjcSfleM91HbwvcCRsY=;
        b=Ju6eF5vjauURfPWCro5Hqp8wzqYLKCpbR4K2V8GyotDeJxbwMg5JCvMyRU10S892xR
         lyVwH+X3aUiDagpBIYOtCy8rLO0Rf62xJJ8wuVCAYnvGRbEWj6dP2ljxuQTYnUOlmApl
         vJGcenFQ3rlk/Q8u0bOopN4S4xZ5dw2OIqmiiSijTpF7FW28V58vwPMY3YedxelgttHo
         FMKQAN4CQ6+LdigeftZ0TZtUXptgwrr4zX9+ewz+l7G8E8a0zdRDU2B3T6bsl3ezNDjF
         FlCzQiCVuDzgjUEdRnkAbVft5QWvVl844lciV/Awf17NejrVBnMvGvBXtLPCyNt2lqV6
         KMuA==
X-Forwarded-Encrypted: i=1; AJvYcCXSjy3yg8WK0oSCplXpOT+7aRGM7VDw9RPHoZZqm+FZcNUesPU1T8UsbnF+6K7sMRQM1zwkPkgm8Y2N@vger.kernel.org
X-Gm-Message-State: AOJu0YyQuwJTfbSsdKlDbBeAtuC5IERFks/t+BvPx2rr8PqJwkSlf34g
	vk69+yI7OzoVVoId5u3mhT2vi74O00p7m/y27JUXmnUbqS+YbK6JgrQGCWCseW/Hcpb5FMYTDy5
	+wm7HLg==
X-Gm-Gg: ASbGncsqK/6VVdF4c88ruRJkVzJZqtQajNmEG4UHqkDeSjTdpsBqvueEaSxDm3fsTwo
	PfPMqeD6GhlxmuyH+EtyB1SddStZjRUiJESr1SDo1Cpw4qGsGnKGxbGO+0thlmv9b+MNYC4DJiY
	wgWR+rqsW3IDS7OJUyflVCSm/nfK0QUv1SGMNjAxp3goCKENSiymfGg2dEOiYzjs1/ongFqZv21
	0xOCSAIqUb5FQ7DSSqzPlmfJnu4LvZY8W0v1T55+f2GXmwhA4NYv5DfgONqFI3u12Tu4OYiJ6ha
	GBdkby7g1T3vxO+M37jjDOXXeBU2OkJuiCxVm0xPiR9v/stomjnbrPwQs9va8BXGfPY8AUBXe+Q
	HHA0Bfmktvg+OZM/ROLgSqr5F5htrhtjuCZaOR5AQtzY7S5g0MvCXnU67/T4RRQyG
X-Google-Smtp-Source: AGHT+IEFImIpZX22jprh8z+jrKc5Yc1MzsnAwX7d+xN9gFzymNTOo6LYrslo/PL+/JTTlyTuiEwShw==
X-Received: by 2002:a05:6512:12c3:b0:553:a339:2c34 with SMTP id 2adb3069b0e04-55a0464adf3mr4193930e87.44.1752508780334;
        Mon, 14 Jul 2025 08:59:40 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b78e3csm1998804e87.222.2025.07.14.08.59.39
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:59:40 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b3b250621so39032721fa.2
        for <linux-acpi@vger.kernel.org>; Mon, 14 Jul 2025 08:59:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOpvTU1HJ33uvp/V8fR2I3K2oDj61gkESFRhD+J7As1jxtO7GvXIUWyqeuE9VsD0/oDn9IaCR3wlKl@vger.kernel.org
X-Received: by 2002:a2e:b5af:0:b0:32c:de97:6ff7 with SMTP id
 38308e7fff4ca-330535f6a83mr36141461fa.29.1752508778131; Mon, 14 Jul 2025
 08:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-11-5710f9d030aa@chromium.org>
 <20250629181440.GO24912@pendragon.ideasonboard.com> <CANiDSCvSP-NXpefOiKnGf53eUWKVf7iJqtXPEPN9e-Gaxt0k7A@mail.gmail.com>
 <20250714143120.GJ8243@pendragon.ideasonboard.com>
In-Reply-To: <20250714143120.GJ8243@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Jul 2025 17:59:24 +0200
X-Gmail-Original-Message-ID: <CANiDSCt6Xy_5bj6H7qFvG+g=FMfW7GWXvPGa5T+gdKPDqCa5BQ@mail.gmail.com>
X-Gm-Features: Ac12FXx_F9n-LUsxRwoh8ZmPOJZUgV6UwgyllEtyANUua67LvfGkioCuWb8sCms
Message-ID: <CANiDSCt6Xy_5bj6H7qFvG+g=FMfW7GWXvPGa5T+gdKPDqCa5BQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] media: uvcvideo: Add support for V4L2_CID_CAMERA_ROTATION
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

On Mon, 14 Jul 2025 at 16:31, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Jul 01, 2025 at 01:26:51PM +0200, Ricardo Ribalda wrote:
> > On Sun, 29 Jun 2025 at 20:15, Laurent Pinchart wrote:
> > > On Thu, Jun 05, 2025 at 05:53:04PM +0000, Ricardo Ribalda wrote:
> > > > Fetch the rotation from the fwnode and map it into a control.
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_ctrl.c     | 22 +++++++++++++--
> > > >  drivers/media/usb/uvc/uvc_swentity.c | 55 ++++++++++++++++++++++++++++++++----
> > > >  drivers/media/usb/uvc/uvcvideo.h     |  5 ++++
> > > >  3 files changed, 74 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > index 59be62ae24a4219fa9d7aacf2ae7382c95362178..5788f0c0f6604da06a7bca1b9999d0957817e75e 100644
> > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > @@ -378,11 +378,18 @@ static const struct uvc_control_info uvc_ctrls[] = {
> > > >       },
> > > >       {
> > > >               .entity         = UVC_GUID_SWENTITY,
> > > > -             .selector       = 0,
> > > > -             .index          = 0,
> > > > +             .selector       = UVC_SWENTITY_ORIENTATION,
> > > > +             .index          = UVC_SWENTITY_ORIENTATION,
> > > >               .size           = 1,
> > > >               .flags          = UVC_CTRL_FLAG_GET_CUR,
> > > >       },
> > > > +     {
> > > > +             .entity         = UVC_GUID_SWENTITY,
> > > > +             .selector       = UVC_SWENTITY_ROTATION,
> > > > +             .index          = UVC_SWENTITY_ROTATION,
> > > > +             .size           = 2,
> > > > +             .flags          = UVC_CTRL_FLAG_GET_RANGE,
> > > > +     },
> > > >  };
> > > >
> > > >  static const u32 uvc_control_classes[] = {
> > > > @@ -1025,7 +1032,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
> > > >       {
> > > >               .id             = V4L2_CID_CAMERA_ORIENTATION,
> > > >               .entity         = UVC_GUID_SWENTITY,
> > > > -             .selector       = 0,
> > > > +             .selector       = UVC_SWENTITY_ORIENTATION,
> > > >               .size           = 8,
> > > >               .offset         = 0,
> > > >               .v4l2_type      = V4L2_CTRL_TYPE_MENU,
> > > > @@ -1033,6 +1040,15 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
> > > >               .menu_mask      = GENMASK(V4L2_CAMERA_ORIENTATION_EXTERNAL,
> > > >                                         V4L2_CAMERA_ORIENTATION_FRONT),
> > > >       },
> > > > +     {
> > > > +             .id             = V4L2_CID_CAMERA_SENSOR_ROTATION,
> > > > +             .entity         = UVC_GUID_SWENTITY,
> > > > +             .selector       = UVC_SWENTITY_ROTATION,
> > > > +             .size           = 16,
> > > > +             .offset         = 0,
> > > > +             .v4l2_type      = V4L2_CTRL_TYPE_INTEGER,
> > > > +             .data_type      = UVC_CTRL_DATA_TYPE_UNSIGNED,
> > > > +     },
> > > >  };
> > > >
> > > >  /* ------------------------------------------------------------------------
> > > > diff --git a/drivers/media/usb/uvc/uvc_swentity.c b/drivers/media/usb/uvc/uvc_swentity.c
> > > > index 702a2c26e029a0655dade177ed2a9b88d7a4136d..60f3166addbeb7d2e431d107b23034d2d11a1812 100644
> > > > --- a/drivers/media/usb/uvc/uvc_swentity.c
> > > > +++ b/drivers/media/usb/uvc/uvc_swentity.c
> > > > @@ -10,10 +10,11 @@
> > > >  #include <media/v4l2-fwnode.h>
> > > >  #include "uvcvideo.h"
> > > >
> > > > -static int uvc_swentity_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
> > > > -                             u8 cs, void *data, u16 size)
> > > > +static int uvc_swentity_get_orientation(struct uvc_device *dev,
> > > > +                                     struct uvc_entity *entity, u8 cs,
> > > > +                                     void *data, u16 size)
> > > >  {
> > > > -     if (size < 1)
> > > > +     if (cs != UVC_SWENTITY_ORIENTATION || size != 1)
> > > >               return -EINVAL;
> > > >
> > > >       switch (entity->swentity.props.orientation) {
> > > > @@ -30,6 +31,31 @@ static int uvc_swentity_get_cur(struct uvc_device *dev, struct uvc_entity *entit
> > > >       return 0;
> > > >  }
> > > >
> > > > +static int uvc_swentity_get_rotation(struct uvc_device *dev,
> > > > +                                  struct uvc_entity *entity, u8 cs, void *data,
> > > > +                                  u16 size)
> > > > +{
> > > > +     if (cs != UVC_SWENTITY_ROTATION || size != 2)
> > > > +             return -EINVAL;
> > > > +
> > > > +     ((u8 *)data)[0] = entity->swentity.props.rotation;
> > > > +     ((u8 *)data)[1] = entity->swentity.props.rotation >> 8;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int uvc_swentity_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
> > > > +                             u8 cs, void *data, u16 size)
> > > > +{
> > > > +     switch (cs) {
> > > > +     case UVC_SWENTITY_ORIENTATION:
> > > > +             return uvc_swentity_get_orientation(dev, entity, cs, data, size);
> > > > +     case UVC_SWENTITY_ROTATION:
> > > > +             return uvc_swentity_get_rotation(dev, entity, cs, data, size);
> > > > +     }
> > > > +     return -EINVAL;
> > > > +}
> > > > +
> > > >  static int uvc_swentity_get_info(struct uvc_device *dev,
> > > >                                struct uvc_entity *entity, u8 cs, u8 *caps)
> > > >  {
> > > > @@ -37,11 +63,22 @@ static int uvc_swentity_get_info(struct uvc_device *dev,
> > > >       return 0;
> > > >  }
> > > >
> > > > +static int uvc_swentity_get_res(struct uvc_device *dev, struct uvc_entity *entity,
> > > > +                             u8 cs, void *res, u16 size)
> > > > +{
> > > > +     if (size == 0)
> > > > +             return -EINVAL;
> > >
> > > The get_cur functions return an error if the size doesn't match the
> > > expected size. I think you can return -EINVAL if size != 1.
> > >
> > > > +     ((u8 *)res)[0] = 1;
> > > > +     memset(res + 1, 0, size - 1);
> > >
> > > And drop the memset.
> > >
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  int uvc_swentity_init(struct uvc_device *dev)
> > > >  {
> > > >       static const u8 uvc_swentity_guid[] = UVC_GUID_SWENTITY;
> > > >       struct v4l2_fwnode_device_properties props;
> > > >       struct uvc_entity *unit;
> > > > +     u8 controls = 0;
> > > >       int ret;
> > > >
> > > >       ret = v4l2_fwnode_device_parse(&dev->udev->dev, &props);
> > > > @@ -49,7 +86,11 @@ int uvc_swentity_init(struct uvc_device *dev)
> > > >               return dev_err_probe(&dev->intf->dev, ret,
> > > >                                    "Can't parse fwnode\n");
> > > >
> > > > -     if (props.orientation == V4L2_FWNODE_PROPERTY_UNSET)
> > > > +     if (props.orientation != V4L2_FWNODE_PROPERTY_UNSET)
> > > > +             controls |= BIT(UVC_SWENTITY_ORIENTATION);
> > > > +     if (props.rotation != V4L2_FWNODE_PROPERTY_UNSET)
> > > > +             controls |= BIT(UVC_SWENTITY_ROTATION);
> > > > +     if (!controls)
> > > >               return 0;
> > > >
> > > >       unit = uvc_alloc_entity(UVC_SWENTITY_UNIT, UVC_SWENTITY_UNIT_ID, 0, 1);
> > > > @@ -60,9 +101,13 @@ int uvc_swentity_init(struct uvc_device *dev)
> > > >       unit->swentity.props = props;
> > > >       unit->swentity.bControlSize = 1;
> > > >       unit->swentity.bmControls = (u8 *)unit + sizeof(*unit);
> > > > -     unit->swentity.bmControls[0] = 1;
> > > > +     unit->swentity.bmControls[0] = controls;
> > > >       unit->get_cur = uvc_swentity_get_cur;
> > > >       unit->get_info = uvc_swentity_get_info;
> > > > +     unit->get_res = uvc_swentity_get_res;
> > > > +     unit->get_def = uvc_swentity_get_rotation;
> > > > +     unit->get_min = uvc_swentity_get_rotation;
> > > > +     unit->get_max = uvc_swentity_get_rotation;
> > >
> > > Why do you support GET_DEF, GET_MIN and GET_MAX for rotation only ?
> >
> > Orientation has enum type. It does not require min or max.
> >
> > For get_def I could use get_cur, but 0 is as good as any other value
> > within range.
>
> Both the orientation and rotation are read-only, and should report min
> == max == def == cur. What am I missing ?

V4L2_CID_CAMERA_ORIENTATION has type V4L2_CTRL_TYPE_MENU
In _uvc_queryctrl_boundaries(), min and max are auto calculated, they
are not based on information from the device.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/usb/uvc/uvc_ctrl.c#n1504

I can change  unit->get_(def|min|max)=uvc_swentity_get_cur if you
think that it is cleaner...

Regards!

>
> > > >       strscpy(unit->name, "SWENTITY", sizeof(unit->name));
> > > >
> > > >       list_add_tail(&unit->list, &dev->entities);
> > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > index d6da8ed3ad4cf3377df49923e051fe04d83d2e38..7cca0dc75d11f6a13bc4f09676a5a00e80cb38f7 100644
> > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > @@ -45,6 +45,11 @@
> > > >  #define UVC_SWENTITY_UNIT            0x7ffd
> > > >  #define UVC_SWENTITY_UNIT_ID         0x101
> > > >
> > > > +enum {
> > > > +     UVC_SWENTITY_ORIENTATION,
> > > > +     UVC_SWENTITY_ROTATION
> > > > +};
> > > > +
> > > >  /* ------------------------------------------------------------------------
> > > >   * Driver specific constants.
> > > >   */
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda

