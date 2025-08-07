Return-Path: <linux-acpi+bounces-15558-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9DBB1D38C
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 09:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004CB7B2D86
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EA323C4F1;
	Thu,  7 Aug 2025 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GbQe1VFa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556F242D8C
	for <linux-acpi@vger.kernel.org>; Thu,  7 Aug 2025 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552538; cv=none; b=A5yp9fdhk7g58ijfai5CD3apf4AEOA4mbzeH6RJ161JxXXmVNySiFRNfPCnTiZmhAbhx4jJF04i0PwRoRAZ6gBUuxhu6XI9tGc2qMmSZEwFiTa5F6tQRlhSuF9zXpufweSByl2wJH0SVp3xUfP77J2rZxNJdo6QBJ/bUCjFzeCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552538; c=relaxed/simple;
	bh=FiZl7dBM01nTpHTio21jd/nJKd4QC3gAoTSrHH1QJgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8kcaA6WafGrJUoWJLNoCI+i4BY0IVXgw0ri88qpt50bkwWAZP90K4vDODoTcqMh8spRXdSXUrsjlWibmXoabKjS0EEbG17ZhN5dGomvnx0/na6GuJUJ//xz/qe+ASKqpKaXlKEi3tCbgh6QNbfIgt1ZiwVBsXt6J7Dst653/dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GbQe1VFa; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-617b36cc489so1344739a12.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 Aug 2025 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754552533; x=1755157333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vRngVDSFiad8P3vLgxpfrf7smMW2bm5yBF8353hqHug=;
        b=GbQe1VFabzM1zOtpBS4n1C6QKuwIme+70LlAF3G6AVLZ5C+7aM3SgyeVJD7KErnc0c
         z+Ip9tVXK4C8zn3OtEdmsPV7TAsx1tOV1ArYYc+tPaxLhC27pbewsTS1tt0DaMUk1ya7
         ybz7CH4d8rrkndpX+5ssqWlXsniWtNrTWZC8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754552533; x=1755157333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRngVDSFiad8P3vLgxpfrf7smMW2bm5yBF8353hqHug=;
        b=mZTvHNxZL5B1ZbC6ut0k7cgwFaSXlgwOyQUtHRhHIyVD9IJdhuy8UWRP7F1O/FcrXU
         hXAPhZqmJDqY8KgRcUmOnW6j79INOXCfh1dEWLY5rumCgoXY+x/FaP8MQ3S32b75E5MT
         7XRF7j01Z8zfWcj8lJgfTqVbHOiXei10lKYOSuuO5gB7dstKbjgiOKdayheCJ54e6efb
         HEWVKJrZUyme/9eVgNt0tcr4Lrmx6scR8NnsVQSTmSCLGekYniqRYHxngSSpGxt7U6gv
         c11472ALw80Nnsj6kA4Z/y7UrnYqQl/aZQX/R3+P2fbHZzQnLWLbxaoHjQbGREmWIbqe
         9xSw==
X-Forwarded-Encrypted: i=1; AJvYcCX8uXVhqjh9K3g1c33vJYwVibDL39Do8iuLMQfuSfFZBO2JxUVwqIq8v6J4udFqQ+UiDnQv32MgycXF@vger.kernel.org
X-Gm-Message-State: AOJu0YzX2bqkFdGP0W6pzkbdpEsVnYuR8Ew2Dx6+LUJ2CGQlKAXWXYyE
	Z7ilS8IZCYx8k7TSDUt+xf5JcfsypacYScxQu0iTBjmrcYdZSgY1nvBxg31//MYBmmB+uPSqO5q
	51KyIdw==
X-Gm-Gg: ASbGncv/fPkN+P9CsYPVBzrDELQKSs3wxzkMMqYqJjYl1HG54SsCFC2+9OMj5sYtalB
	omSg8oaU/M0ho7FvYRLgGyj+O8dLpNSBzUWMLw73OcEf6ltPtmwEKW8Kd3P6tPDh3wNNCQ4Wyk6
	tbi8qvhTyg0xjHMUk/LjxWODAEiCkCUwoiJ8mDtLUXuNHz0dOKEDXRehpXbf7ncol8skr+V69TA
	bdYAm8nctbb2PJ9xXy06kph4TLJGylBTlCDJPLrqB/hRoNJz9j+YEqbos6cgzmsnIYnllNd15eF
	wrCsw39CeSIj62D20MiCFWLXku4xEZlpIcL8ukWlwtKYTOnyofRI4VED/fytKRy2va3GZFTQ8VD
	0kTjWhh5tqxBCd0yMwvaNZPc8vpD4kUsIGPTF17fnYlbY9lLMCukWNN+58gtM
X-Google-Smtp-Source: AGHT+IFOgFynnk7m+HLv+ASss4gueXSrSwN1u6rQ4nojI5307bOs/k6ftD7YSp8cdfTKWoSPyUcXog==
X-Received: by 2002:a17:907:6d1b:b0:af9:88a2:b7a7 with SMTP id a640c23a62f3a-af99048b9a1mr554913066b.48.1754552532598;
        Thu, 07 Aug 2025 00:42:12 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c081sm1243346666b.97.2025.08.07.00.42.12
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 00:42:12 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6157ed5dc51so1088436a12.1
        for <linux-acpi@vger.kernel.org>; Thu, 07 Aug 2025 00:42:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVURD6mBmQKKQYUcOwwgnLIhkps5FBV2qouSoThK3URI0HVj1d+0xMF2kpbXY7HHO9MsQ006fLr7SCV@vger.kernel.org
X-Received: by 2002:a2e:b54b:0:b0:332:2a32:2856 with SMTP id
 38308e7fff4ca-333813c4660mr13208821fa.29.1754552127402; Thu, 07 Aug 2025
 00:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-10-5710f9d030aa@chromium.org>
 <20250629181246.GE6260@pendragon.ideasonboard.com> <CANiDSCsu0RT4dcGyBJRutP=9HTe+niUoohxTZE=qJ8O_9ez=+A@mail.gmail.com>
 <20250714142926.GI8243@pendragon.ideasonboard.com> <CANiDSCvFe23xmrJ0-qbWWa6+vKGb+QdDFV8VSLkmWdAnfsFtzw@mail.gmail.com>
 <20250715193505.GB19299@pendragon.ideasonboard.com> <CANiDSCtvt6qnROQ0_-0iG5hqkU_uHZABujZPN7xuh7pUASSGyw@mail.gmail.com>
In-Reply-To: <CANiDSCtvt6qnROQ0_-0iG5hqkU_uHZABujZPN7xuh7pUASSGyw@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 7 Aug 2025 09:35:14 +0200
X-Gmail-Original-Message-ID: <CANiDSCsNjBEWR5HA9bhFNnXB7Cazj7o0wBnn53gzpoBBcYFkFw@mail.gmail.com>
X-Gm-Features: Ac12FXyjct6ihC0OshwY5F1qdouFOZPK3DFRcqPyUc52eVa5roZ1nWwW2xk9ZpI
Message-ID: <CANiDSCsNjBEWR5HA9bhFNnXB7Cazj7o0wBnn53gzpoBBcYFkFw@mail.gmail.com>
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

On Wed, 16 Jul 2025 at 12:32, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> On Tue, 15 Jul 2025 at 21:35, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > On Mon, Jul 14, 2025 at 05:46:40PM +0200, Ricardo Ribalda wrote:
> > > On Mon, 14 Jul 2025 at 16:30, Laurent Pinchart wrote:
> > > > On Tue, Jul 01, 2025 at 01:13:10PM +0200, Ricardo Ribalda wrote:
> > > > > On Sun, 29 Jun 2025 at 20:13, Laurent Pinchart wrote:
> > > > > > On Thu, Jun 05, 2025 at 05:53:03PM +0000, Ricardo Ribalda wrote:
> > > > > > > Virtual entities need to provide more values than get_cur and get_cur
> > > > > >
> > > > > > I think you meant "get_info and get_cur".
> > > > > >
> > > > > > > for their controls. Add support for get_def, get_min, get_max and
> > > > > > > get_res.
> > > > > >
> > > > > > Do they ? The UVC specification defines controls that don't list
> > > > > > GET_DEF, GET_MIN, GET_MAX and GET_RES as mandatory requests. Can't we do
> > > > > > the same for the software controls ? This patch is meant to support the
> > > > > > UVC_SWENTITY_ORIENTATION and UVC_SWENTITY_ROTATION control in the next
> > > > > > patch, and those are read-only controls. Aren't GET_INFO and GET_CUR
> > > > > > enough ?
> > > > >
> > > > > V4L2_CID_CAMERA_ROTATION has the type UVC_CTRL_DATA_TYPE_UNSIGNED,
> > > > > that time requires get_min and get_max.
> > > >
> > > > Where does that requirement come from ? Is it because how the
> > > > corresponding V4L2 type (V4L2_CTRL_TYPE_INTEGER) is handled in
> > > > uvc_ctrl_clamp() ? uvc_ctrl_clamp() is only called when setting a
> > > > control, from uvc_ctrl_set(), and V4L2_CID_CAMERA_ROTATION should be
> > > > read-only.
> > >
> > > It its for VIDIOC_QUERY_EXT_CTRL
> > >
> > > uvc_query_v4l2_ctrl -> __uvc_query_v4l2_ctrl -> __uvc_queryctrl_boundaries
> > >
> > > We need to list the min, max, def and step for every control. They are
> > > fetched with uvc_ctrl_populate_cache()
> >
> > Ah, I see, thanks.
> >
> > For GET_RES, I think we can leave it unimplemented.
> > __uvc_queryctrl_boundaries() will set v4l2_ctrl->step = 0 which seems to
> > be the right behaviour for a read-only control whose value never
> > changes.
>
> That will break v4l2-compatiblity. Step needs to be != 0
> https://git.linuxtv.org/v4l-utils.git/tree/utils/v4l2-compliance/v4l2-test-controls.cpp#n77
>
> Control ioctls (Input 0):
>                 fail: v4l2-test-controls.cpp(77): step == 0
>                 fail: v4l2-test-controls.cpp(201): invalid control 009a0923
>
> >
> > As for the minimum and maximum, they are currently set to 0 if the
> > corresponding operations are not supported. I wonder if we should set
> > them to the current value instead for read-only controls (as in controls
> > whose flags report support for GET_CUR only)..
>
> I am not sure that I like that approach IMO the code looks worse...
> but if you prefer that, we can go that way

I am almost ready to send a new version.

What approach do you prefer?

Regards!

>
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index ec472e111248..47224437018b 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -35,6 +35,8 @@
>  /* ------------------------------------------------------------------------
>   * Controls
>   */
> +static int __uvc_ctrl_load_cur(struct uvc_video_chain *chain,
> +                              struct uvc_control *ctrl);
>
>  static const struct uvc_control_info uvc_ctrls[] = {
>         {
> @@ -1272,6 +1274,13 @@ static int uvc_ctrl_populate_cache(struct
> uvc_video_chain *chain,
>                                         uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
>                 if (ret < 0)
>                         return ret;
> +       } else if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR)) {
> +               ret = __uvc_ctrl_load_cur(chain, ctrl);
> +               if (!ret) {
> +                       memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF),
> +                              uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
> +                              ctrl->info.size);
> +               }
>         }
>
>         if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) {
> @@ -1279,14 +1288,31 @@ static int uvc_ctrl_populate_cache(struct
> uvc_video_chain *chain,
>                                         uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
>                 if (ret < 0)
>                         return ret;
> +       } else if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR)) {
> +               ret = __uvc_ctrl_load_cur(chain, ctrl);
> +               if (!ret) {
> +                       memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN),
> +                              uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
> +                              ctrl->info.size);
> +               }
>         }
> +
>         if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX) {
>                 ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_MAX,
>                                         uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
>                 if (ret < 0)
>                         return ret;
> +       } else if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR)) {
> +               ret = __uvc_ctrl_load_cur(chain, ctrl);
> +               if (!ret) {
> +                       memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX),
> +                              uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
> +                              ctrl->info.size);
> +               }
>         }
> +
>         if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES) {
> +               u8 *res;
>                 ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_RES,
>                                         uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
>                 if (ret < 0) {
> @@ -1304,7 +1330,13 @@ static int uvc_ctrl_populate_cache(struct
> uvc_video_chain *chain,
>                                       "an XU control. Enabling workaround.\n");
>                         memset(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES), 0,
>                                ctrl->info.size);
> +                       res = uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES);
> +                       *res = 1
>                 }
> +       } else {
> +               memset(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES), 0,
> ctrl->info.size);
> +               res = uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES);
> +               *res = 1;
>         }
>
>         ctrl->cached = 1;
> @@ -1541,11 +1573,8 @@ static int __uvc_queryctrl_boundaries(struct
> uvc_video_chain *chain,
>                         return ret;
>         }
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF)
>                 v4l2_ctrl->default_value = uvc_mapping_get_s32(mapping,
>                                 UVC_GET_DEF, uvc_ctrl_data(ctrl,
> UVC_CTRL_DATA_DEF));
> -       else
> -               v4l2_ctrl->default_value = 0;
>
>         switch (mapping->v4l2_type) {
>         case V4L2_CTRL_TYPE_MENU:
> @@ -1576,23 +1605,14 @@ static int __uvc_queryctrl_boundaries(struct
> uvc_video_chain *chain,
>                 break;
>         }
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
> -               v4l2_ctrl->minimum = uvc_mapping_get_s32(mapping, UVC_GET_MIN,
> -                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
> -       else
> -               v4l2_ctrl->minimum = 0;
> +       v4l2_ctrl->minimum = uvc_mapping_get_s32(mapping, UVC_GET_MIN,
> +                                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
> -               v4l2_ctrl->maximum = uvc_mapping_get_s32(mapping, UVC_GET_MAX,
> -                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> -       else
> -               v4l2_ctrl->maximum = 0;
> +       v4l2_ctrl->maximum = uvc_mapping_get_s32(mapping, UVC_GET_MAX,
> +                                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
> -               v4l2_ctrl->step = uvc_mapping_get_s32(mapping, UVC_GET_RES,
> -                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> -       else
> -               v4l2_ctrl->step = 0;
> +       v4l2_ctrl->step = uvc_mapping_get_s32(mapping, UVC_GET_RES,
> +                                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
>
>         return 0;
>  }
>
> >
> > > > > We can create a new type UVC_CTRL_DATA_TYPE_UNSIGNED_READ_ONLY that
> > > > > fakes min, max and res, but I think that it is cleaner this approach.
> > > > >
> > > > > > > This is a preparation patch.
> > > > > > >
> > > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > > ---
> > > > > > >  drivers/media/usb/uvc/uvc_ctrl.c | 12 ++++++++++++
> > > > > > >  drivers/media/usb/uvc/uvcvideo.h |  8 ++++++++
> > > > > > >  2 files changed, 20 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > > > > index 21ec7b978bc7aca21db7cb8fd5d135d876f3330c..59be62ae24a4219fa9d7aacf2ae7382c95362178 100644
> > > > > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > > > > @@ -596,6 +596,18 @@ static int uvc_ctrl_query_entity(struct uvc_device *dev,
> > > > > > >       if (query == UVC_GET_CUR && ctrl->entity->get_cur)
> > > > > > >               return ctrl->entity->get_cur(dev, ctrl->entity,
> > > > > > >                                            ctrl->info.selector, data, len);
> > > > > > > +     if (query == UVC_GET_DEF && ctrl->entity->get_def)
> > > > > > > +             return ctrl->entity->get_def(dev, ctrl->entity,
> > > > > > > +                                          ctrl->info.selector, data, len);
> > > > > > > +     if (query == UVC_GET_MIN && ctrl->entity->get_min)
> > > > > > > +             return ctrl->entity->get_min(dev, ctrl->entity,
> > > > > > > +                                          ctrl->info.selector, data, len);
> > > > > > > +     if (query == UVC_GET_MAX && ctrl->entity->get_max)
> > > > > > > +             return ctrl->entity->get_max(dev, ctrl->entity,
> > > > > > > +                                          ctrl->info.selector, data, len);
> > > > > > > +     if (query == UVC_GET_RES && ctrl->entity->get_res)
> > > > > > > +             return ctrl->entity->get_res(dev, ctrl->entity,
> > > > > > > +                                          ctrl->info.selector, data, len);
> > > > > > >       if (query == UVC_GET_INFO && ctrl->entity->get_info)
> > > > > > >               return ctrl->entity->get_info(dev, ctrl->entity,
> > > > > > >                                             ctrl->info.selector, data);
> > > > > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > > > > index a931750bdea25b9062dcc7644bf5f2ed89c1cb4c..d6da8ed3ad4cf3377df49923e051fe04d83d2e38 100644
> > > > > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > > > > @@ -261,6 +261,14 @@ struct uvc_entity {
> > > > > > >                       u8 cs, u8 *caps);
> > > > > > >       int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > >                      u8 cs, void *data, u16 size);
> > > > > > > +     int (*get_def)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > > +                    u8 cs, void *data, u16 size);
> > > > > > > +     int (*get_min)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > > +                    u8 cs, void *data, u16 size);
> > > > > > > +     int (*get_max)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > > +                    u8 cs, void *data, u16 size);
> > > > > > > +     int (*get_res)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > > +                    u8 cs, void *data, u16 size);
> > > > > > >
> > > > > > >       unsigned int ncontrols;
> > > > > > >       struct uvc_control *controls;
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

