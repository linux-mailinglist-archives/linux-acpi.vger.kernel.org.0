Return-Path: <linux-acpi+bounces-14877-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA2AEF366
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 11:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 988CD7AF9A0
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 09:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7686426E146;
	Tue,  1 Jul 2025 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AHC35BHP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AA527145B
	for <linux-acpi@vger.kernel.org>; Tue,  1 Jul 2025 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362211; cv=none; b=djfMadICfvt1k5Hvetuwdwm/TXUER62/3Jfva2QjiO3eNJTfec7vu8duoeIJA8zJ/YbSzDQsKm58V1t+DIRwXOmzgcYmthLlCOYfzkx+GXFk2aE9X7zf7V45QA6qji3bm4jQxNe8LIk+B9ZMt89ZbT8xIUHiHg7NZzWWkz0d2b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362211; c=relaxed/simple;
	bh=j5wlMbPmUjf27ANZh10nnvtw/xfZ70MwhNN1zPJjxpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpXZQRdXdnlqyoHD3nVAkhP+smkVyYG+VnZn7KFGysnWPW0JZNupvJASryMYtlOE+k8quT4HNi8kvSmpl1m2b6Az6BIOne+QffYDGuCEpQIL4ok3ijg3Dxjdvh3/CwFQdELfDfIpASm+8g3YHqVrY5CQFutaH5LSu9aiK+uI++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AHC35BHP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60dffae17f3so3860529a12.1
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751362206; x=1751967006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9tMwKKV17TTvsTFK7dQXew3Cofw+lQuFXBbrD3s440=;
        b=AHC35BHPaGKmxBIoI60cLHCKjKp4/tGMmFS4rvjY7SMTvgtDVR3BOLa7PCsca+Y8oH
         DrIK70A1MQiEFgQxfYFj46nzFVQxIoDbQC21bxK6JJGDQoumY++M3bt/Yxe0p93ktiKg
         Rt/TNunQ8ssdnNTkgTgoSrkjkKhya2QGlvHNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751362206; x=1751967006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9tMwKKV17TTvsTFK7dQXew3Cofw+lQuFXBbrD3s440=;
        b=IjUZW4S75kFfQqaMC721UeLW3my8m+PWgs3QdkFxzKqJrkUP0KNEx3HyG9ed/nmTK6
         Tf5qFHw4DrWO0QgZEjY9qAq2fx4ODaKycsOyEdVUYBo/A9bL1WRaHmCllMHkXUwpSLvK
         MMFJFrXwv3ztjKDaqUMPJk2Lo3FcnpQ52WVNQn5cLyP/fFpnEFJeuMcdD2SMFTI6ehX3
         WyRp0JUBjxibn0dY4frUkXTJPa8pkZEZIi8PzgrbLxzW3TQZ6+quxZwKBrcvpAI+jp4Q
         lOyClWI2LQryizxQJE9BUqvIAE6I6ziK2ZbIjaiur1bjq4nagqKCgpM5XKWWHXEHoaD8
         Xk4w==
X-Forwarded-Encrypted: i=1; AJvYcCXJGDnfNKmDWUdjNRP0wrROFJO0QMo1o9vrJmkCvmO2LT1CiFvasIsioEWSg38n3B0rU3QX5sQJTPjY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1rZeafbnnxE7e66AJobMJzVrWTtu0clkDVjHURG+kIuLsZuO
	WjvlI10LNoxDWNwom1uGyJoNOx0VoPpaVrZaakjO/6s04iKHUkIoxdJ3OvwmjEdWol4Y7PoKCno
	rw4q6Dg==
X-Gm-Gg: ASbGncvL3nIptXpyXzqD5TKchYkw68aNAdg/IArP7dWv6VfFcMPWDsjFSW+W5UDznZ7
	oA0YddmY/HX/T/sA5HQN7K51dyI3PxcSrHEDheQVvTL4fb+XnSU2/DrwV6E2tJKu4xNON32W2aM
	fDd7N70p8scZ9+KB75LOxpD64411kdP/t8wlHbfm4wE1vO0BW0i8T9YgCarf6uHG7NyqAuw9N9t
	Yu7g5OZhOg5mZiDqvIfmWVdM0/A+A2xuj8fNihKaI++25M8kjiKSpcJOs1yqxkqa0VWiEWyNmPB
	ZOjrMQAmI4sZ3Z9CvrdO4+2g3EmNgvAmoe0BjdVxErQu7jUaa/VFg8+F3hScFWlI9xt1yQuQBln
	x9oUbE4DBbIJmoKIQRmGhIZ8c
X-Google-Smtp-Source: AGHT+IF5bmTjsMzViTS7qReOAVrwvMPF26KHqzza/yVn4j8Prg/EAYywf2scn9B43ZuRJzdt6BUJOw==
X-Received: by 2002:a05:6402:4314:b0:606:fef3:7c3e with SMTP id 4fb4d7f45d1cf-60c88d933e5mr15266374a12.3.1751362206020;
        Tue, 01 Jul 2025 02:30:06 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60ca83610a1sm5039369a12.12.2025.07.01.02.30.05
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:30:05 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso5096497a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 02:30:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2ZpA3+xMPhm3JokieuiFvg2b73Pjc4KUSiw7zOnYh7T+osmJ15FQcwIfSwsJiUhZ35gECBXK/yfGe@vger.kernel.org
X-Received: by 2002:a05:651c:3c6:b0:32b:590f:47cb with SMTP id
 38308e7fff4ca-32cdc49c942mr31566521fa.15.1751361742529; Tue, 01 Jul 2025
 02:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-8-5710f9d030aa@chromium.org> <20250629175045.GC6260@pendragon.ideasonboard.com>
In-Reply-To: <20250629175045.GC6260@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 1 Jul 2025 11:22:10 +0200
X-Gmail-Original-Message-ID: <CANiDSCuUFUtwenuefqf__=bpyNr0jxFML0hq5spktA+w441Jjw@mail.gmail.com>
X-Gm-Features: Ac12FXw-vWZDkC22fNJPHs7bYPytUF_2gtuqpU-8HcNvZI1K7oxyCe6dK0RwoJs
Message-ID: <CANiDSCuUFUtwenuefqf__=bpyNr0jxFML0hq5spktA+w441Jjw@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] media: uvcvideo: Add support for V4L2_CID_CAMERA_ORIENTATION
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

On Sun, 29 Jun 2025 at 19:51, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Thu, Jun 05, 2025 at 05:53:01PM +0000, Ricardo Ribalda wrote:
> > Fetch the orientation from the fwnode and map it into a control.
> >
> > The uvc driver does not use the media controller, so we need to create a
> > virtual entity, like we previously did with the external gpio.
> >
> > We do not re-purpose the external gpio entity because its is planned to
> > remove it.
>
> Comparing the GUIDs for the EXT_GPIO_CONTROLLER and SWENTITY, we have
>
> #define UVC_GUID_EXT_GPIO_CONTROLLER \
>         {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
>          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03}
> #define UVC_GUID_SWENTITY \
>         {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
>          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x04}
>
> The GUIDs don't carry any special meaning in their values. I agree with
> the plan to drop the existing features of the GPIO entity, but wouldn't
> it be easier to rename UVC_GUID_EXT_GPIO_CONTROLLER to UVC_GUID_SWENTITY
> and UVC_EXT_GPIO_UNIT* to UVC_SWENTITY_UNIT* (the macros are not exposed
> to userspace), and later drop the existing GPIO controls from the entity

It would make my life easier if we keep the naming as is, the final
result will be identical.

Maybe you want to take a look into
https://patchwork.linuxtv.org/project/linux-media/list/?series=14066 ?

Will it help if I rebase it to the current media-committers/next. It
has been hanging around since november.



> ?
>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/Makefile       |  3 +-
> >  drivers/media/usb/uvc/uvc_ctrl.c     | 21 +++++++++++
> >  drivers/media/usb/uvc/uvc_driver.c   | 14 +++++--
> >  drivers/media/usb/uvc/uvc_entity.c   |  1 +
> >  drivers/media/usb/uvc/uvc_swentity.c | 73 ++++++++++++++++++++++++++++++++++++
> >  drivers/media/usb/uvc/uvcvideo.h     | 14 +++++++
> >  include/linux/usb/uvc.h              |  3 ++
> >  7 files changed, 125 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/Makefile b/drivers/media/usb/uvc/Makefile
> > index 4f9eee4f81ab6436a8b90324a688a149b2c3bcd1..b4398177c4bb0a9bd49dfd4ca7f2e933b4a1d7df 100644
> > --- a/drivers/media/usb/uvc/Makefile
> > +++ b/drivers/media/usb/uvc/Makefile
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  uvcvideo-objs  := uvc_driver.o uvc_queue.o uvc_v4l2.o uvc_video.o uvc_ctrl.o \
> > -               uvc_status.o uvc_isight.o uvc_debugfs.o uvc_metadata.o
> > +               uvc_status.o uvc_isight.o uvc_debugfs.o uvc_metadata.o \
> > +               uvc_swentity.o
> >  ifeq ($(CONFIG_MEDIA_CONTROLLER),y)
> >  uvcvideo-objs  += uvc_entity.o
> >  endif
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 47e8ccc39234d1769384b55539a21df07f3d57c7..b2768080c08aafa85acb9b7f318672c043d84e55 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -376,6 +376,13 @@ static const struct uvc_control_info uvc_ctrls[] = {
> >                               | UVC_CTRL_FLAG_GET_DEF
> >                               | UVC_CTRL_FLAG_AUTO_UPDATE,
> >       },
> > +     {
> > +             .entity         = UVC_GUID_SWENTITY,
> > +             .selector       = 0,
> > +             .index          = 0,
> > +             .size           = 1,
> > +             .flags          = UVC_CTRL_FLAG_GET_CUR,
> > +     },
> >  };
> >
> >  static const u32 uvc_control_classes[] = {
> > @@ -975,6 +982,17 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
> >               .data_type      = UVC_CTRL_DATA_TYPE_BITMASK,
> >               .name           = "Region of Interest Auto Ctrls",
> >       },
> > +     {
> > +             .id             = V4L2_CID_CAMERA_ORIENTATION,
> > +             .entity         = UVC_GUID_SWENTITY,
> > +             .selector       = 0,
> > +             .size           = 8,
> > +             .offset         = 0,
> > +             .v4l2_type      = V4L2_CTRL_TYPE_MENU,
> > +             .data_type      = UVC_CTRL_DATA_TYPE_ENUM,
> > +             .menu_mask      = GENMASK(V4L2_CAMERA_ORIENTATION_EXTERNAL,
> > +                                       V4L2_CAMERA_ORIENTATION_FRONT),
> > +     },
> >  };
> >
> >  /* ------------------------------------------------------------------------
> > @@ -3210,6 +3228,9 @@ static int uvc_ctrl_init_chain(struct uvc_video_chain *chain)
> >               } else if (UVC_ENTITY_TYPE(entity) == UVC_EXT_GPIO_UNIT) {
> >                       bmControls = entity->gpio.bmControls;
> >                       bControlSize = entity->gpio.bControlSize;
> > +             } else if (UVC_ENTITY_TYPE(entity) == UVC_SWENTITY_UNIT) {
> > +                     bmControls = entity->swentity.bmControls;
> > +                     bControlSize = entity->swentity.bControlSize;
> >               }
> >
> >               /* Remove bogus/blacklisted controls */
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index bcc97f71fa1703aea1119469fb32659c17d9409a..96eeb3aee546487d15f3c30dfe1775189ddf7e47 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -1869,11 +1869,15 @@ static int uvc_scan_device(struct uvc_device *dev)
> >               return -1;
> >       }
> >
> > -     /* Add GPIO entity to the first chain. */
> > -     if (dev->gpio_unit) {
> > +     /* Add virtual entities to the first chain. */
> > +     if (dev->gpio_unit || dev->swentity_unit) {
> >               chain = list_first_entry(&dev->chains,
> >                                        struct uvc_video_chain, list);
> > -             list_add_tail(&dev->gpio_unit->chain, &chain->entities);
> > +             if (dev->gpio_unit)
> > +                     list_add_tail(&dev->gpio_unit->chain, &chain->entities);
> > +             if (dev->swentity_unit)
> > +                     list_add_tail(&dev->swentity_unit->chain,
> > +                                   &chain->entities);
> >       }
> >
> >       return 0;
> > @@ -2249,6 +2253,10 @@ static int uvc_probe(struct usb_interface *intf,
> >       if (ret < 0)
> >               goto error;
> >
> > +     ret = uvc_swentity_init(dev);
> > +     if (ret < 0)
> > +             goto error;
> > +
> >       dev_info(&dev->udev->dev, "Found UVC %u.%02x device %s (%04x:%04x)\n",
> >                dev->uvc_version >> 8, dev->uvc_version & 0xff,
> >                udev->product ? udev->product : "<unnamed>",
> > diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
> > index cc68dd24eb42dce5b2846ca52a8dfa499c8aed96..d1a652ef35ec34801bd39a5124b834edf838a79e 100644
> > --- a/drivers/media/usb/uvc/uvc_entity.c
> > +++ b/drivers/media/usb/uvc/uvc_entity.c
> > @@ -106,6 +106,7 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
> >               case UVC_OTT_MEDIA_TRANSPORT_OUTPUT:
> >               case UVC_EXTERNAL_VENDOR_SPECIFIC:
> >               case UVC_EXT_GPIO_UNIT:
> > +             case UVC_SWENTITY_UNIT:
> >               default:
> >                       function = MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN;
> >                       break;
> > diff --git a/drivers/media/usb/uvc/uvc_swentity.c b/drivers/media/usb/uvc/uvc_swentity.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..702a2c26e029a0655dade177ed2a9b88d7a4136d
> > --- /dev/null
> > +++ b/drivers/media/usb/uvc/uvc_swentity.c
> > @@ -0,0 +1,73 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + *      uvc_swentity.c  --  USB Video Class driver
> > + *
> > + *      Copyright 2025 Google LLC
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/usb/uvc.h>
> > +#include <media/v4l2-fwnode.h>
> > +#include "uvcvideo.h"
>
> Blank lines between header groups would be nice.
ack
>
> > +
> > +static int uvc_swentity_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
> > +                             u8 cs, void *data, u16 size)
> > +{
> > +     if (size < 1)
> > +             return -EINVAL;
> > +
> > +     switch (entity->swentity.props.orientation) {
> > +     case V4L2_FWNODE_ORIENTATION_FRONT:
> > +             *(u8 *)data = V4L2_CAMERA_ORIENTATION_FRONT;
> > +             break;
> > +     case V4L2_FWNODE_ORIENTATION_BACK:
> > +             *(u8 *)data = V4L2_CAMERA_ORIENTATION_BACK;
> > +             break;
> > +     default:
> > +             *(u8 *)data = V4L2_CAMERA_ORIENTATION_EXTERNAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int uvc_swentity_get_info(struct uvc_device *dev,
> > +                              struct uvc_entity *entity, u8 cs, u8 *caps)
> > +{
> > +     *caps = UVC_CONTROL_CAP_GET;
> > +     return 0;
> > +}
> > +
> > +int uvc_swentity_init(struct uvc_device *dev)
> > +{
> > +     static const u8 uvc_swentity_guid[] = UVC_GUID_SWENTITY;
> > +     struct v4l2_fwnode_device_properties props;
> > +     struct uvc_entity *unit;
> > +     int ret;
> > +
> > +     ret = v4l2_fwnode_device_parse(&dev->udev->dev, &props);
> > +     if (ret)
> > +             return dev_err_probe(&dev->intf->dev, ret,
> > +                                  "Can't parse fwnode\n");
> > +
> > +     if (props.orientation == V4L2_FWNODE_PROPERTY_UNSET)
> > +             return 0;
> > +
> > +     unit = uvc_alloc_entity(UVC_SWENTITY_UNIT, UVC_SWENTITY_UNIT_ID, 0, 1);
> > +     if (!unit)
> > +             return -ENOMEM;
> > +
> > +     memcpy(unit->guid, uvc_swentity_guid, sizeof(unit->guid));
> > +     unit->swentity.props = props;
> > +     unit->swentity.bControlSize = 1;
> > +     unit->swentity.bmControls = (u8 *)unit + sizeof(*unit);
> > +     unit->swentity.bmControls[0] = 1;
> > +     unit->get_cur = uvc_swentity_get_cur;
> > +     unit->get_info = uvc_swentity_get_info;
> > +     strscpy(unit->name, "SWENTITY", sizeof(unit->name));
> > +
> > +     list_add_tail(&unit->list, &dev->entities);
> > +
> > +     dev->swentity_unit = unit;
> > +
> > +     return 0;
> > +}
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index dc23d8a97340dc4615d4182232d395106e6d9ed5..a931750bdea25b9062dcc7644bf5f2ed89c1cb4c 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -19,6 +19,7 @@
> >  #include <media/v4l2-event.h>
> >  #include <media/v4l2-fh.h>
> >  #include <media/videobuf2-v4l2.h>
> > +#include <media/v4l2-fwnode.h>
>
> Alphabetical order.
>
> >
> >  /* --------------------------------------------------------------------------
> >   * UVC constants
> > @@ -41,6 +42,9 @@
> >  #define UVC_EXT_GPIO_UNIT            0x7ffe
> >  #define UVC_EXT_GPIO_UNIT_ID         0x100
> >
> > +#define UVC_SWENTITY_UNIT            0x7ffd
> > +#define UVC_SWENTITY_UNIT_ID         0x101
> > +
> >  /* ------------------------------------------------------------------------
> >   * Driver specific constants.
> >   */
> > @@ -242,6 +246,12 @@ struct uvc_entity {
> >                       int irq;
> >                       bool initialized;
> >               } gpio;
> > +
> > +             struct {
> > +                     u8  bControlSize;
> > +                     u8  *bmControls;
> > +                     struct v4l2_fwnode_device_properties props;
> > +             } swentity;
> >       };
> >
> >       u8 bNrInPins;
> > @@ -617,6 +627,7 @@ struct uvc_device {
> >       } async_ctrl;
> >
> >       struct uvc_entity *gpio_unit;
> > +     struct uvc_entity *swentity_unit;
> >  };
> >
> >  enum uvc_handle_state {
> > @@ -836,4 +847,7 @@ void uvc_debugfs_cleanup_stream(struct uvc_streaming *stream);
> >  size_t uvc_video_stats_dump(struct uvc_streaming *stream, char *buf,
> >                           size_t size);
> >
> > +/* swentity */
> > +int uvc_swentity_init(struct uvc_device *dev);
> > +
> >  #endif
> > diff --git a/include/linux/usb/uvc.h b/include/linux/usb/uvc.h
> > index bce95153e5a65613a710d7316fc17cf5462b5bce..88a23e8919d1294da4308e0e3ca0eccdc66a318f 100644
> > --- a/include/linux/usb/uvc.h
> > +++ b/include/linux/usb/uvc.h
> > @@ -29,6 +29,9 @@
> >  #define UVC_GUID_EXT_GPIO_CONTROLLER \
> >       {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
> >        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03}
> > +#define UVC_GUID_SWENTITY \
> > +     {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
> > +      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x04}
> >
> >  #define UVC_GUID_FORMAT_MJPEG \
> >       { 'M',  'J',  'P',  'G', 0x00, 0x00, 0x10, 0x00, \
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

