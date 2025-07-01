Return-Path: <linux-acpi+bounces-14881-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D707AEF69D
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 13:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8072B169D71
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1E2255E40;
	Tue,  1 Jul 2025 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PbXwByUD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A91DC994
	for <linux-acpi@vger.kernel.org>; Tue,  1 Jul 2025 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369624; cv=none; b=pOoF3eCig7yRbN4B6rEZkVY3KbQZaksKR5qUxpHskSas2y3Ecx/LoydBvwd+kA5XVYcPLli1pLEWvP5HUEm2Bq0iGFtH9daA3aB3XI/4xKD39jVV0IsLhCtsr4nIRZyqdMpVfJVK9LD/SaALwkU+m3xTSgGuDZUl0iMgqSFrZPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369624; c=relaxed/simple;
	bh=ESXaDOI0ClJQb3/rnUaSslnZdyZvIXDxHVvhpQGw5jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9Cm1PxFOc+nl9Q9qBUe/pRtIGPJgelx1pVbaH2z/F73ORhJ2YMr1cQdSPoFZJOXFh80WosoLTInM1Uucr1fYaK6XocbVVpK+o8L8f5Sar0QTR0pKGLwCIycLP+3XS+074/L8nKZkPxSd7KpcAkSe2GFrmREXTdEIbY0tDhe5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PbXwByUD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso979750866b.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 04:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751369620; x=1751974420; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AOpbhHFXTgJjd1mQ2k57iBzGNrGLgGW/xPskwW5clgI=;
        b=PbXwByUD2bFd+Jde3FT2Td9+UEaZqeqBlip4ZLWRVatPa3nv6hk5hJcBBrbLUuYCjr
         tv2Jewm8ZJ1HDUnxngH1zxoTlOE7N37/MJDRv7GowN/q/YJ1mgrCNMvRq5IZgvYOErK0
         kEAP4azKufHZWLsvvksKN/AZa42eY6uH6ggTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751369620; x=1751974420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOpbhHFXTgJjd1mQ2k57iBzGNrGLgGW/xPskwW5clgI=;
        b=omHewEItA6DyJ/dTzC4EbE0GGaLUy2gBWVYKTW8ebcmTQ/tZL0RPF5w49ifc5voGg2
         kCN0GePsOGTVKf5WG1lV/NDbgyo/qaAhS+lkczyHNdMjm75TfbHNlHJXFIA1Zkzdooxa
         /N/RZGPOSufrgbf2t6tBbKPrsXMzzcNwNB5Hrc0bdN2CW+lVY0FFtMbs37cTqtd5U70d
         dyYKFUa+Mndm0Pk4GE/NgzQmkneWAdp2yaOsM8bs8EylT3aeR9SPnVNJ9lGu8UO6tkNS
         ZCQps154J+1GAt+DnKAe4seZFwozi8TH+u1OnhEglQQ11+57F/mgOdPksptqcEDy05pI
         d0ww==
X-Forwarded-Encrypted: i=1; AJvYcCXOUZcIvCOi1pKLIaYyz2vw5YPodevd8F1eeXjb9nZL7Q1PD7m8vgcej6MiFO0JFL+9Sszd/5enlq0b@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+qtgoMD/o2iNNIQwwOwgm8UOUa3ss+Qqm6C0VN0ZeEhw7ijA
	cZertWaTQ/BWRPsyGyuCkHhnw3ZbzXTehY3FqTq9pNn7SoZgcoab5SJcg2bQg79Z2pxnfG9wfQQ
	gTwcF6g==
X-Gm-Gg: ASbGncsc62Ayvztotk5eNhnhONV+jBNLTvC7919v0BQeZUWFJXTPg90j3PT1RrJIm8B
	byMM/34htIx2xT1/HDPH03kd5HcUKkwSjYUaPy+mZUPANbQwfKC2M9ZbNlc92yp4qy+AuWQy/TE
	2LLvOXtMzsRps+EAYE37Ix6xQm2ArFmGKzOuRtolJlBaHNhUUgNa96fV8Bq3LGz4aAI7Jdjoch3
	rV3zGxejrJUVxhdkGPA2XuvyyMg/TlTjyJKwjvbCfQflaCBGGgz+YWAHgPbDgGjJFlGd4DbNIMX
	ZDs2fWkWFVSTIdzKIpizYqoe4jU7+kkqvpeG8opdghUxbf+wM181lYZCAXoFoUWWkKi+/OBaQRX
	Ii8LQVrCpXePo/V+5PhUooNQf65+sBM4t+vE=
X-Google-Smtp-Source: AGHT+IH9/XqtMHYJIlD+kf04vgrKUd0VW05T+7UVW6ICct/h1CJYdM/2VG/UC8dSYIosQjWsdKa40Q==
X-Received: by 2002:a17:907:3e94:b0:adb:2f9b:e16f with SMTP id a640c23a62f3a-ae3b0aea905mr175352266b.16.1751369620215;
        Tue, 01 Jul 2025 04:33:40 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c01620sm865591266b.103.2025.07.01.04.33.40
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 04:33:40 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso979747766b.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 04:33:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpQx48i7lgX9r0C7cFzK7A6bKoHAfjgqqaj6rPUPq8V2wHmr+HPxDnZUecbO/kRhJ+kN1ln2sWUcBd@vger.kernel.org
X-Received: by 2002:a05:6512:3996:b0:553:2a16:2503 with SMTP id
 2adb3069b0e04-5562351cd2bmr643670e87.22.1751369224941; Tue, 01 Jul 2025
 04:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-11-5710f9d030aa@chromium.org> <20250629181440.GO24912@pendragon.ideasonboard.com>
In-Reply-To: <20250629181440.GO24912@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 1 Jul 2025 13:26:51 +0200
X-Gmail-Original-Message-ID: <CANiDSCvSP-NXpefOiKnGf53eUWKVf7iJqtXPEPN9e-Gaxt0k7A@mail.gmail.com>
X-Gm-Features: Ac12FXzX2o2y2l8S2fLY5YNiZDeM3lsThn02nyBQ6azDUzOojOVrPSfT9VAdjyY
Message-ID: <CANiDSCvSP-NXpefOiKnGf53eUWKVf7iJqtXPEPN9e-Gaxt0k7A@mail.gmail.com>
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

On Sun, 29 Jun 2025 at 20:15, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thu, Jun 05, 2025 at 05:53:04PM +0000, Ricardo Ribalda wrote:
> > Fetch the rotation from the fwnode and map it into a control.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c     | 22 +++++++++++++--
> >  drivers/media/usb/uvc/uvc_swentity.c | 55 ++++++++++++++++++++++++++++++++----
> >  drivers/media/usb/uvc/uvcvideo.h     |  5 ++++
> >  3 files changed, 74 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 59be62ae24a4219fa9d7aacf2ae7382c95362178..5788f0c0f6604da06a7bca1b9999d0957817e75e 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -378,11 +378,18 @@ static const struct uvc_control_info uvc_ctrls[] = {
> >       },
> >       {
> >               .entity         = UVC_GUID_SWENTITY,
> > -             .selector       = 0,
> > -             .index          = 0,
> > +             .selector       = UVC_SWENTITY_ORIENTATION,
> > +             .index          = UVC_SWENTITY_ORIENTATION,
> >               .size           = 1,
> >               .flags          = UVC_CTRL_FLAG_GET_CUR,
> >       },
> > +     {
> > +             .entity         = UVC_GUID_SWENTITY,
> > +             .selector       = UVC_SWENTITY_ROTATION,
> > +             .index          = UVC_SWENTITY_ROTATION,
> > +             .size           = 2,
> > +             .flags          = UVC_CTRL_FLAG_GET_RANGE,
> > +     },
> >  };
> >
> >  static const u32 uvc_control_classes[] = {
> > @@ -1025,7 +1032,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
> >       {
> >               .id             = V4L2_CID_CAMERA_ORIENTATION,
> >               .entity         = UVC_GUID_SWENTITY,
> > -             .selector       = 0,
> > +             .selector       = UVC_SWENTITY_ORIENTATION,
> >               .size           = 8,
> >               .offset         = 0,
> >               .v4l2_type      = V4L2_CTRL_TYPE_MENU,
> > @@ -1033,6 +1040,15 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
> >               .menu_mask      = GENMASK(V4L2_CAMERA_ORIENTATION_EXTERNAL,
> >                                         V4L2_CAMERA_ORIENTATION_FRONT),
> >       },
> > +     {
> > +             .id             = V4L2_CID_CAMERA_SENSOR_ROTATION,
> > +             .entity         = UVC_GUID_SWENTITY,
> > +             .selector       = UVC_SWENTITY_ROTATION,
> > +             .size           = 16,
> > +             .offset         = 0,
> > +             .v4l2_type      = V4L2_CTRL_TYPE_INTEGER,
> > +             .data_type      = UVC_CTRL_DATA_TYPE_UNSIGNED,
> > +     },
> >  };
> >
> >  /* ------------------------------------------------------------------------
> > diff --git a/drivers/media/usb/uvc/uvc_swentity.c b/drivers/media/usb/uvc/uvc_swentity.c
> > index 702a2c26e029a0655dade177ed2a9b88d7a4136d..60f3166addbeb7d2e431d107b23034d2d11a1812 100644
> > --- a/drivers/media/usb/uvc/uvc_swentity.c
> > +++ b/drivers/media/usb/uvc/uvc_swentity.c
> > @@ -10,10 +10,11 @@
> >  #include <media/v4l2-fwnode.h>
> >  #include "uvcvideo.h"
> >
> > -static int uvc_swentity_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
> > -                             u8 cs, void *data, u16 size)
> > +static int uvc_swentity_get_orientation(struct uvc_device *dev,
> > +                                     struct uvc_entity *entity, u8 cs,
> > +                                     void *data, u16 size)
> >  {
> > -     if (size < 1)
> > +     if (cs != UVC_SWENTITY_ORIENTATION || size != 1)
> >               return -EINVAL;
> >
> >       switch (entity->swentity.props.orientation) {
> > @@ -30,6 +31,31 @@ static int uvc_swentity_get_cur(struct uvc_device *dev, struct uvc_entity *entit
> >       return 0;
> >  }
> >
> > +static int uvc_swentity_get_rotation(struct uvc_device *dev,
> > +                                  struct uvc_entity *entity, u8 cs, void *data,
> > +                                  u16 size)
> > +{
> > +     if (cs != UVC_SWENTITY_ROTATION || size != 2)
> > +             return -EINVAL;
> > +
> > +     ((u8 *)data)[0] = entity->swentity.props.rotation;
> > +     ((u8 *)data)[1] = entity->swentity.props.rotation >> 8;
> > +
> > +     return 0;
> > +}
> > +
> > +static int uvc_swentity_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
> > +                             u8 cs, void *data, u16 size)
> > +{
> > +     switch (cs) {
> > +     case UVC_SWENTITY_ORIENTATION:
> > +             return uvc_swentity_get_orientation(dev, entity, cs, data, size);
> > +     case UVC_SWENTITY_ROTATION:
> > +             return uvc_swentity_get_rotation(dev, entity, cs, data, size);
> > +     }
> > +     return -EINVAL;
> > +}
> > +
> >  static int uvc_swentity_get_info(struct uvc_device *dev,
> >                                struct uvc_entity *entity, u8 cs, u8 *caps)
> >  {
> > @@ -37,11 +63,22 @@ static int uvc_swentity_get_info(struct uvc_device *dev,
> >       return 0;
> >  }
> >
> > +static int uvc_swentity_get_res(struct uvc_device *dev, struct uvc_entity *entity,
> > +                             u8 cs, void *res, u16 size)
> > +{
> > +     if (size == 0)
> > +             return -EINVAL;
>
> The get_cur functions return an error if the size doesn't match the
> expected size. I think you can return -EINVAL if size != 1.
>
> > +     ((u8 *)res)[0] = 1;
> > +     memset(res + 1, 0, size - 1);
>
> And drop the memset.
>
> > +     return 0;
> > +}
> > +
> >  int uvc_swentity_init(struct uvc_device *dev)
> >  {
> >       static const u8 uvc_swentity_guid[] = UVC_GUID_SWENTITY;
> >       struct v4l2_fwnode_device_properties props;
> >       struct uvc_entity *unit;
> > +     u8 controls = 0;
> >       int ret;
> >
> >       ret = v4l2_fwnode_device_parse(&dev->udev->dev, &props);
> > @@ -49,7 +86,11 @@ int uvc_swentity_init(struct uvc_device *dev)
> >               return dev_err_probe(&dev->intf->dev, ret,
> >                                    "Can't parse fwnode\n");
> >
> > -     if (props.orientation == V4L2_FWNODE_PROPERTY_UNSET)
> > +     if (props.orientation != V4L2_FWNODE_PROPERTY_UNSET)
> > +             controls |= BIT(UVC_SWENTITY_ORIENTATION);
> > +     if (props.rotation != V4L2_FWNODE_PROPERTY_UNSET)
> > +             controls |= BIT(UVC_SWENTITY_ROTATION);
> > +     if (!controls)
> >               return 0;
> >
> >       unit = uvc_alloc_entity(UVC_SWENTITY_UNIT, UVC_SWENTITY_UNIT_ID, 0, 1);
> > @@ -60,9 +101,13 @@ int uvc_swentity_init(struct uvc_device *dev)
> >       unit->swentity.props = props;
> >       unit->swentity.bControlSize = 1;
> >       unit->swentity.bmControls = (u8 *)unit + sizeof(*unit);
> > -     unit->swentity.bmControls[0] = 1;
> > +     unit->swentity.bmControls[0] = controls;
> >       unit->get_cur = uvc_swentity_get_cur;
> >       unit->get_info = uvc_swentity_get_info;
> > +     unit->get_res = uvc_swentity_get_res;
> > +     unit->get_def = uvc_swentity_get_rotation;
> > +     unit->get_min = uvc_swentity_get_rotation;
> > +     unit->get_max = uvc_swentity_get_rotation;
>
> Why do you support GET_DEF, GET_MIN and GET_MAX for rotation only ?

Orientation has enum type. It does not require min or max.

For get_def I could use get_cur, but 0 is as good as any other value
within range.

>
> >       strscpy(unit->name, "SWENTITY", sizeof(unit->name));
> >
> >       list_add_tail(&unit->list, &dev->entities);
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index d6da8ed3ad4cf3377df49923e051fe04d83d2e38..7cca0dc75d11f6a13bc4f09676a5a00e80cb38f7 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -45,6 +45,11 @@
> >  #define UVC_SWENTITY_UNIT            0x7ffd
> >  #define UVC_SWENTITY_UNIT_ID         0x101
> >
> > +enum {
> > +     UVC_SWENTITY_ORIENTATION,
> > +     UVC_SWENTITY_ROTATION
> > +};
> > +
> >  /* ------------------------------------------------------------------------
> >   * Driver specific constants.
> >   */
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

