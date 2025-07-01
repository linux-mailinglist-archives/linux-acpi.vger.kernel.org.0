Return-Path: <linux-acpi+bounces-14876-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0E5AEF26F
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 11:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B258B4A171E
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 09:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB06E26D4C2;
	Tue,  1 Jul 2025 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jaTUDFx/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B4526E17F
	for <linux-acpi@vger.kernel.org>; Tue,  1 Jul 2025 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360685; cv=none; b=PCpHMJGr6ax7dY+AAPHPllsgymUqEULyYaK40v4+inUpI+/bVx4mbXo2BdmZpvxIvh9GqmYzbjs+syjcW2PveTotGrrY3uHOTu0F7SWs7GWNUMLH8QfOrygC413jk3n+FgnsnnAlEgnV7lsJzPiwkDt8UhhZEO5hSEhCE3qVM/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360685; c=relaxed/simple;
	bh=o28C31JrBgAZEzAB1O4WLZDzarIKJHFMpSuZuTBwEc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugx7q8aZ3IPlts0HglCC3ar/4ngs8jcxKh6RhEWMj0VnoHqfGEFGUQ/zMeWVm3/bZRPh30YEGTffxW2I88zDvW0yjXFbFCWT3ACWZl10ffXoRvPkomPg1T+tsKjSKJPrLJyCBEMbNxFLBaWe0yxSLsXZmYgWnArqnJjKhpOBjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jaTUDFx/; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32cd499007aso38452831fa.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751360682; x=1751965482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xkMPKxlbdTBTKL3fl2oC7mwIlMxs96dPn8+iiFtM8yw=;
        b=jaTUDFx/oTp+FJe/p73lMqfdEqWb813yfeGsCkp6Ld8rc5Uk+fgDxqy8u67Vrksspj
         ksQwzOXQuZb/8iDTd+ENNz5Jkv95VscbiAD46SujnWOxP8GrTd6NvBzFSuXAYOI2C0jo
         AadRiK3SYAWi48fPmpQCi1f/F7CAR8yB/LpKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751360682; x=1751965482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkMPKxlbdTBTKL3fl2oC7mwIlMxs96dPn8+iiFtM8yw=;
        b=rioiFFxqaONM6J/6DXbIUDrJ8ewoJN62Bo07438YLXwcGUYKiexChsXRMjA34ENI+t
         /8VVBBjYyeHZpqU1bclBqeIinF+y8o7V8sxhxiyxyaW+pcjco8n+m9v72pg3Vgy330KN
         rHcjigkcgt7bXf0Ouja+6WlGkca1YXdmZvJhZ/k5Qc965jrOiixePb3ORUkvDZHlaZCT
         1blmXC+EDEam1/R7Yct9nD/0J/ZySw6Bm9DPrsMKNkAxAGe8gYAnZz+WpCMhdvCGuOgw
         oFhs70krr4SRQejyChcDVQn19utXZ9YZMM8UWdlHZjN8EaGXAQenPkHZs9lBg161XR8x
         hLTg==
X-Forwarded-Encrypted: i=1; AJvYcCVUF30aXwgtuo0qYH5RX9r7rP6CP3WKkdZQz+osz8mckFyZpz1fPczPUIv88ORlWgvh+4G2vPgqOD8e@vger.kernel.org
X-Gm-Message-State: AOJu0YyFMGGXi2nyIQIRWJsjALqqfnIdQoXKGJxat5H7ddPGPbFPrppT
	0JYcaf+ap9rf0HCMyV7Ge6KFEWYYqCjwo1HSbpCJPB2R0/2RF+lD+xZMiysmreZOr515uv+g3jF
	Zdf4=
X-Gm-Gg: ASbGncsr3m3/rycA22/hqts/Z7vIHJUmX/vy4AtZXsAtDHu2+66FucTD2YvasHXIIDU
	JHUqDwgxi4khZ7UFBo0V+xTt4OzNLQx+gVzgc6/hEgOnXoOE1/7kOqO0EJH4xSL3TtrL9x0S7op
	FETC5dCC6lTENO6Raf1VvsH2npSqcUoCPzDre9GofEWhBLWoxc6slRPgRNeDVFUL3Lcqk5UybOk
	9oK94k2FmjT/7NqsPkd4YlgEFSyAxXkcGqUUrqRrFDiSdfzck2SPAQ7q7FOMQG03m2LY0R+qcAz
	ztgALhsvKVzthnKsMYhzEMPPSxE5qpid5J5bQOG/UrVzCy2CAtjm+jw/1LT0Sq3XUuG+y7j00sA
	dst4r73IFnyYcd+eSbprcn01z
X-Google-Smtp-Source: AGHT+IGsSGyhI9Jr1oqBKHqr6XND5s8bGt6x6nMbQqKmGI75FpisJTrO7maINQIc6ojtJu/IZK2XhQ==
X-Received: by 2002:a05:651c:169b:b0:32b:905b:7417 with SMTP id 38308e7fff4ca-32cdc51e545mr39883421fa.35.1751360681567;
        Tue, 01 Jul 2025 02:04:41 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32cd2f17550sm15813451fa.110.2025.07.01.02.04.38
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:04:40 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553b51f5218so5495565e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 02:04:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYwTklI6IngHQRYg+Zntd1rXnmjlXCjt18doJo35YS0Onhj381tYg+arNyORphoHB1498uBLddNoaJ@vger.kernel.org
X-Received: by 2002:a05:6512:6c6:b0:553:cf7d:7283 with SMTP id
 2adb3069b0e04-5550b9ee0bemr5279219e87.33.1751360678000; Tue, 01 Jul 2025
 02:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-2-5710f9d030aa@chromium.org> <1ac49bd3-1b65-4611-8c90-92fb2c2ffd4a@linux.intel.com>
In-Reply-To: <1ac49bd3-1b65-4611-8c90-92fb2c2ffd4a@linux.intel.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 1 Jul 2025 11:04:25 +0200
X-Gmail-Original-Message-ID: <CANiDSCuRLVtT54ZxxAh6031OLg422VApsocvOTCOnavQgifTaA@mail.gmail.com>
X-Gm-Features: Ac12FXx3IMpNO_E1OyIfv6p5Mqhpq1vAIqrVG416DGyoC75C25dyBDZ2PZqW7zo
Message-ID: <CANiDSCuRLVtT54ZxxAh6031OLg422VApsocvOTCOnavQgifTaA@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] media: v4l: fwnode: Support ACPI's _PLD for v4l2_fwnode_device_parse
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sakari

Thanks for your review!

On Mon, 30 Jun 2025 at 09:06, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> Thanks for the update.
>
> On 6/5/25 20:52, Ricardo Ribalda wrote:
> > Currently v4l2_fwnode_device_parse() obtains the orientation and
> > rotation via fwnode properties.
> >
> > Extend the function to support as well ACPI devices with _PLD info.
> >
> > We give a higher priority to fwnode, because it might contain quirks
> > injected via swnodes.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >   drivers/media/v4l2-core/v4l2-fwnode.c | 85 ++++++++++++++++++++++++++++++++---
> >   1 file changed, 79 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> > index cb153ce42c45d69600a3ec4e59a5584d7e791a2a..379290ab3cfde74c8f663d61837a9a95011b5ae0 100644
> > --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> > +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> > @@ -15,6 +15,7 @@
> >    * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >    */
> >   #include <linux/acpi.h>
> > +#include <acpi/acpi_bus.h>
> >   #include <linux/kernel.h>
> >   #include <linux/mm.h>
> >   #include <linux/module.h>
> > @@ -807,16 +808,65 @@ int v4l2_fwnode_connector_add_link(struct fwnode_handle *fwnode,
> >   }
> >   EXPORT_SYMBOL_GPL(v4l2_fwnode_connector_add_link);
> >
> > -int v4l2_fwnode_device_parse(struct device *dev,
> > -                          struct v4l2_fwnode_device_properties *props)
> > +static int v4l2_fwnode_device_parse_acpi(struct device *dev,
> > +                                      struct v4l2_fwnode_device_properties *props)
> > +{
> > +     struct acpi_pld_info *pld;
> > +     int ret = 0;
> > +
> > +     if (!is_acpi_device_node(dev_fwnode(dev)))
> > +             return 0;
> > +
> > +     if (!acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld)) {
> > +             dev_dbg(dev, "acpi _PLD call failed\n");
>
> I'd do:
>
> acpi_handle_debug(ACPI_HANDLE(dev), "cannot obtain _PLD\n");
ack
>
> > +             return 0;
> > +     }
> > +
> > +     if (props->orientation != V4L2_FWNODE_PROPERTY_UNSET) {
> > +             switch (pld->panel) {
> > +             case ACPI_PLD_PANEL_FRONT:
> > +                     props->orientation = V4L2_FWNODE_ORIENTATION_FRONT;
> > +                     break;
> > +             case ACPI_PLD_PANEL_BACK:
> > +                     props->orientation = V4L2_FWNODE_ORIENTATION_BACK;
> > +                     break;
> > +             case ACPI_PLD_PANEL_TOP:
> > +             case ACPI_PLD_PANEL_LEFT:
> > +             case ACPI_PLD_PANEL_RIGHT:
> > +             case ACPI_PLD_PANEL_UNKNOWN:
> > +                     props->orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
> > +                     break;
> > +             default:
> > +                     dev_dbg(dev, "Unknown _PLD panel val %d\n", pld->panel);
>
> Similarly:
>
> acpi_handle_debug(ACPI_HANDLE(dev), "invalid panel %u in _PLD\n",
>                   pld->panel);
>
> > +                     ret = -EINVAL;
>
> Should this be an error or should we simply ignore it here (and maybe
> use acpi_handle_warn())?

v4l2_fwnode_device_parse_of() returns -EINVAL for a similar situation,
so I think it is better to be consistent and return -EINVAL here.
But I agree that acpi_handle_warn() better suits here than _dbg.

>
> > +                     goto done;
> > +             }
> > +     }
> > +
> > +     if (props->rotation != V4L2_FWNODE_PROPERTY_UNSET) {
> > +             switch (pld->rotation) {
> > +             case 0 ... 7:
> > +                     props->rotation = pld->rotation * 45;
> > +                     break;
> > +             default:
> > +                     dev_dbg(dev, "Unknown _PLD rotation val %d\n", pld->panel);
>
> acpi_handle_debug(ACPI_HANDLE(dev), "invalid rotation %u in _PLD\n",
>                   pld->rotation);
>
> > +                     ret = -EINVAL;
> > +                     goto done;
> > +             }
> > +     }
> > +
> > +done:
> > +     ACPI_FREE(pld);
> > +     return ret;
> > +}
> > +
> > +static int v4l2_fwnode_device_parse_dt(struct device *dev,
>
> I'd call this v4l2_fwnode_device_parse_of() as we're parsing OF nodes
> and properties here.
ack
>
> > +                                    struct v4l2_fwnode_device_properties *props)
> >   {
> >       struct fwnode_handle *fwnode = dev_fwnode(dev);
> >       u32 val;
> >       int ret;
> >
> > -     memset(props, 0, sizeof(*props));
> > -
> > -     props->orientation = V4L2_FWNODE_PROPERTY_UNSET;
> >       ret = fwnode_property_read_u32(fwnode, "orientation", &val);
> >       if (!ret) {
> >               switch (val) {
> > @@ -833,7 +883,6 @@ int v4l2_fwnode_device_parse(struct device *dev,
> >               dev_dbg(dev, "device orientation: %u\n", val);
> >       }
> >
> > -     props->rotation = V4L2_FWNODE_PROPERTY_UNSET;
> >       ret = fwnode_property_read_u32(fwnode, "rotation", &val);
> >       if (!ret) {
> >               if (val >= 360) {
> > @@ -847,6 +896,30 @@ int v4l2_fwnode_device_parse(struct device *dev,
> >
> >       return 0;
> >   }
> > +
> > +int v4l2_fwnode_device_parse(struct device *dev,
> > +                          struct v4l2_fwnode_device_properties *props)
> > +{
> > +     int ret;
> > +
> > +     memset(props, 0, sizeof(*props));
> > +
> > +     props->orientation = V4L2_FWNODE_PROPERTY_UNSET;
> > +     props->rotation = V4L2_FWNODE_PROPERTY_UNSET;
> > +
> > +     /* Start by looking into swnodes and dt. */
> > +     ret =  v4l2_fwnode_device_parse_dt(dev, props);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Orientation and rotation found!, we are ready. */
> > +     if (props->orientation != V4L2_FWNODE_PROPERTY_UNSET &&
> > +         props->rotation != V4L2_FWNODE_PROPERTY_UNSET)
> > +             return 0;
>
> I think you can remove this check without affecting the functionality.
I want to avoid calling an acpi method unless it is strictly
necessary. The check is not that ugly... if it is ok with you i'd
rather keep it.

>
> > +
> > +     /* Let's check the acpi table. */
> > +     return v4l2_fwnode_device_parse_acpi(dev, props);
> > +}
> >   EXPORT_SYMBOL_GPL(v4l2_fwnode_device_parse);
> >
> >   /*
> >
>
> --
> Regards,
>
> Sakari Ailus

Thanks!

-- 
Ricardo Ribalda

