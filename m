Return-Path: <linux-acpi+bounces-15185-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F4FB0737B
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 12:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817FE1C2531B
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 10:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806BA2EE980;
	Wed, 16 Jul 2025 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g8H+rJCC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E822E3F0
	for <linux-acpi@vger.kernel.org>; Wed, 16 Jul 2025 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661950; cv=none; b=tyPxsIpeLgOi2PIrzvlfawm5ySMRESZs0AiZhdUCZWuLIdfI6ec9XiOTAnmEt6ilotRsfEquy9Mz8NNWMx3EGDowMBdej1EV2IBY5fssKGPjnwVpVxEmdExDpPKrXg5HnZenZr3c7IgWzfC3eKb6blYDPnVhiU/1hWi72W1r/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661950; c=relaxed/simple;
	bh=lQBsia0sYbc3ZhTi0JAkaaWjrbsoT4HfjHir1/c3JVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xzx/Lto/kohLdM40rYpH4CtCkHdNzOEfzl2zyz/pbgsUaHHj2CYt5ECw6hZY5EUulYIUT5qC2KLIGgKogdopOrwQwJkuDmeJm2RI2COcKyQKPLxsmeXVKrj4Ye3MLalWewPv/6e+9mHZiWB92c4m8HeWP+t94dYdqQKFmapiE+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g8H+rJCC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b3b250621so56353581fa.2
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jul 2025 03:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752661946; x=1753266746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XO0Fx40qXcc6y2Q85UzZUUK6JgaXB0+V8kATrQASoZ0=;
        b=g8H+rJCCCKmATPsQZ3CUpbwHD2R3ZDj+hvkCo7WzDorWsx9E5LuMYRAtNo43NTRh4M
         nIFlrUVo1kC0uwi6kuB+cl5aUIaA8zjeHHZB92/0A7xtr+H5V39Ki+Bm2kSUPPKxPuIV
         5eiXF32js0WyTseCnMNk/JJWOMC7PUm+XTkWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752661946; x=1753266746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO0Fx40qXcc6y2Q85UzZUUK6JgaXB0+V8kATrQASoZ0=;
        b=hsL0rl6WoW6PzNt44FvVNhLPpcJBy/C9vldDESK5mDG47ZKXvgIdt5DtCCYAYD/6Y0
         ifBtfl8NqgYLCXhhCPP1ld4IPVWLw7hkp5hbAGwtfS3U2g7AEtOejERyiVmfpTQxygra
         0Lxpnd3ju1MquQVqIUALgbp55bhcVGvPtZuGtxtuP4X4Jbj0ybmfw32Z6155DKqsrAvo
         TF1yf/YWMM2K0p+3FWs9LbDgbGHVPGKBVaIuLdeLX1hTWF8dqiiVpVvBMQpJ1UClZ8D+
         P6kMyVZaLq1EOw8JGXVCHhVBBjXk5q3fsqQ8HhBhUz7odtJPvYHxJmJ6X2MYbAVsmi+p
         wScw==
X-Forwarded-Encrypted: i=1; AJvYcCU7dGtc/atR5g45A6CxKX1U/D0LK6UkDv8+2Axox9AaZMwkGBLIxXlvaeuR+tt4RsI04eFQOTg5C7Lv@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZAvIvRVldQiDSENhwfZmqMqWKbBSvSKJusoyxaLq4yZBx2Dy
	5/Stuge5JwR8DXVLbL32KCdDlK3ZGe6Qnyy9398EKdlf+lUxqmr3p/Rvy9VyMHp3ijkOEqE21fP
	iRkc=
X-Gm-Gg: ASbGnctKg1f7sZUbEgP+BOAidOXgXNoptu+76k9DQHeeiDUsV+onU3DzoZkosRlJkXK
	6Nzvi/o1R3L7VFl439Jm57ehuce1avf6Q8sO5x+3PMyRKbcyof7yGiyOjW6XBrF/bLz1i2FrBIL
	+xD0Ee9K8qHqJWPdltbX7d1B1JTFWKkoQ+19hS76SpBXsWY7noRgrFKBLLYT/ldksgkrqLFlSzc
	dLe7+ESyiHO5HBX/JunEMqEIQTooiYF7IziLMr/FmVxu2cVDZEb9fYuHld2ALZFoK57Dq97Q8/S
	6rYGOZfpcd3hxnV2ncn3ZkDVJD42Od8P1LNjb+D/fqCmY8uUW4kzMZkG3GSH3U4KmoW8bNP5Fei
	wlGtE7OPCOvckp1Sd6gvXTqI/J82/Mja+d0LsUBjFe924e0Ntk/jXOLNl0RjOVl5E
X-Google-Smtp-Source: AGHT+IG2arY3YaK3Gyo9QeFmtL4aEt5jbZMQmLheQMUGt87SElfbVQbkcbMoAwYIqvsx/uJYnt7fIA==
X-Received: by 2002:a2e:be9e:0:b0:32a:ec98:e15a with SMTP id 38308e7fff4ca-3308e5311e4mr8854961fa.36.1752661945847;
        Wed, 16 Jul 2025 03:32:25 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29134f1sm19547471fa.6.2025.07.16.03.32.25
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:32:25 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32f3ef6178bso54951011fa.1
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jul 2025 03:32:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVYE3WN1zHNpL2QZd+ADCLqLptv/ecIjaEolFfLKxBs98/2h8qtKWsN2x4/IjZDzC2H6anV96WgitL@vger.kernel.org
X-Received: by 2002:a05:651c:20cc:20b0:32b:7123:ec4c with SMTP id
 38308e7fff4ca-3308e534766mr5343651fa.38.1752661944634; Wed, 16 Jul 2025
 03:32:24 -0700 (PDT)
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
 <20250715193505.GB19299@pendragon.ideasonboard.com>
In-Reply-To: <20250715193505.GB19299@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 16 Jul 2025 12:32:12 +0200
X-Gmail-Original-Message-ID: <CANiDSCtvt6qnROQ0_-0iG5hqkU_uHZABujZPN7xuh7pUASSGyw@mail.gmail.com>
X-Gm-Features: Ac12FXxTxa1OMnAHd5xkxGC40dZgahlVF2ufC7vQULE72HOrmtGjhNO81HxFS-Q
Message-ID: <CANiDSCtvt6qnROQ0_-0iG5hqkU_uHZABujZPN7xuh7pUASSGyw@mail.gmail.com>
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

On Tue, 15 Jul 2025 at 21:35, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Jul 14, 2025 at 05:46:40PM +0200, Ricardo Ribalda wrote:
> > On Mon, 14 Jul 2025 at 16:30, Laurent Pinchart wrote:
> > > On Tue, Jul 01, 2025 at 01:13:10PM +0200, Ricardo Ribalda wrote:
> > > > On Sun, 29 Jun 2025 at 20:13, Laurent Pinchart wrote:
> > > > > On Thu, Jun 05, 2025 at 05:53:03PM +0000, Ricardo Ribalda wrote:
> > > > > > Virtual entities need to provide more values than get_cur and get_cur
> > > > >
> > > > > I think you meant "get_info and get_cur".
> > > > >
> > > > > > for their controls. Add support for get_def, get_min, get_max and
> > > > > > get_res.
> > > > >
> > > > > Do they ? The UVC specification defines controls that don't list
> > > > > GET_DEF, GET_MIN, GET_MAX and GET_RES as mandatory requests. Can't we do
> > > > > the same for the software controls ? This patch is meant to support the
> > > > > UVC_SWENTITY_ORIENTATION and UVC_SWENTITY_ROTATION control in the next
> > > > > patch, and those are read-only controls. Aren't GET_INFO and GET_CUR
> > > > > enough ?
> > > >
> > > > V4L2_CID_CAMERA_ROTATION has the type UVC_CTRL_DATA_TYPE_UNSIGNED,
> > > > that time requires get_min and get_max.
> > >
> > > Where does that requirement come from ? Is it because how the
> > > corresponding V4L2 type (V4L2_CTRL_TYPE_INTEGER) is handled in
> > > uvc_ctrl_clamp() ? uvc_ctrl_clamp() is only called when setting a
> > > control, from uvc_ctrl_set(), and V4L2_CID_CAMERA_ROTATION should be
> > > read-only.
> >
> > It its for VIDIOC_QUERY_EXT_CTRL
> >
> > uvc_query_v4l2_ctrl -> __uvc_query_v4l2_ctrl -> __uvc_queryctrl_boundaries
> >
> > We need to list the min, max, def and step for every control. They are
> > fetched with uvc_ctrl_populate_cache()
>
> Ah, I see, thanks.
>
> For GET_RES, I think we can leave it unimplemented.
> __uvc_queryctrl_boundaries() will set v4l2_ctrl->step = 0 which seems to
> be the right behaviour for a read-only control whose value never
> changes.

That will break v4l2-compatiblity. Step needs to be != 0
https://git.linuxtv.org/v4l-utils.git/tree/utils/v4l2-compliance/v4l2-test-controls.cpp#n77

Control ioctls (Input 0):
                fail: v4l2-test-controls.cpp(77): step == 0
                fail: v4l2-test-controls.cpp(201): invalid control 009a0923

>
> As for the minimum and maximum, they are currently set to 0 if the
> corresponding operations are not supported. I wonder if we should set
> them to the current value instead for read-only controls (as in controls
> whose flags report support for GET_CUR only)..

I am not sure that I like that approach IMO the code looks worse...
but if you prefer that, we can go that way


diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index ec472e111248..47224437018b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -35,6 +35,8 @@
 /* ------------------------------------------------------------------------
  * Controls
  */
+static int __uvc_ctrl_load_cur(struct uvc_video_chain *chain,
+                              struct uvc_control *ctrl);

 static const struct uvc_control_info uvc_ctrls[] = {
        {
@@ -1272,6 +1274,13 @@ static int uvc_ctrl_populate_cache(struct
uvc_video_chain *chain,
                                        uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
                if (ret < 0)
                        return ret;
+       } else if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR)) {
+               ret = __uvc_ctrl_load_cur(chain, ctrl);
+               if (!ret) {
+                       memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF),
+                              uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
+                              ctrl->info.size);
+               }
        }

        if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) {
@@ -1279,14 +1288,31 @@ static int uvc_ctrl_populate_cache(struct
uvc_video_chain *chain,
                                        uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
                if (ret < 0)
                        return ret;
+       } else if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR)) {
+               ret = __uvc_ctrl_load_cur(chain, ctrl);
+               if (!ret) {
+                       memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN),
+                              uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
+                              ctrl->info.size);
+               }
        }
+
        if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX) {
                ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_MAX,
                                        uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
                if (ret < 0)
                        return ret;
+       } else if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR)) {
+               ret = __uvc_ctrl_load_cur(chain, ctrl);
+               if (!ret) {
+                       memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX),
+                              uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
+                              ctrl->info.size);
+               }
        }
+
        if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES) {
+               u8 *res;
                ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_RES,
                                        uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
                if (ret < 0) {
@@ -1304,7 +1330,13 @@ static int uvc_ctrl_populate_cache(struct
uvc_video_chain *chain,
                                      "an XU control. Enabling workaround.\n");
                        memset(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES), 0,
                               ctrl->info.size);
+                       res = uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES);
+                       *res = 1
                }
+       } else {
+               memset(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES), 0,
ctrl->info.size);
+               res = uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES);
+               *res = 1;
        }

        ctrl->cached = 1;
@@ -1541,11 +1573,8 @@ static int __uvc_queryctrl_boundaries(struct
uvc_video_chain *chain,
                        return ret;
        }

-       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF)
                v4l2_ctrl->default_value = uvc_mapping_get_s32(mapping,
                                UVC_GET_DEF, uvc_ctrl_data(ctrl,
UVC_CTRL_DATA_DEF));
-       else
-               v4l2_ctrl->default_value = 0;

        switch (mapping->v4l2_type) {
        case V4L2_CTRL_TYPE_MENU:
@@ -1576,23 +1605,14 @@ static int __uvc_queryctrl_boundaries(struct
uvc_video_chain *chain,
                break;
        }

-       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
-               v4l2_ctrl->minimum = uvc_mapping_get_s32(mapping, UVC_GET_MIN,
-                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
-       else
-               v4l2_ctrl->minimum = 0;
+       v4l2_ctrl->minimum = uvc_mapping_get_s32(mapping, UVC_GET_MIN,
+                                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));

-       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
-               v4l2_ctrl->maximum = uvc_mapping_get_s32(mapping, UVC_GET_MAX,
-                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
-       else
-               v4l2_ctrl->maximum = 0;
+       v4l2_ctrl->maximum = uvc_mapping_get_s32(mapping, UVC_GET_MAX,
+                                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));

-       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
-               v4l2_ctrl->step = uvc_mapping_get_s32(mapping, UVC_GET_RES,
-                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
-       else
-               v4l2_ctrl->step = 0;
+       v4l2_ctrl->step = uvc_mapping_get_s32(mapping, UVC_GET_RES,
+                                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));

        return 0;
 }

>
> > > > We can create a new type UVC_CTRL_DATA_TYPE_UNSIGNED_READ_ONLY that
> > > > fakes min, max and res, but I think that it is cleaner this approach.
> > > >
> > > > > > This is a preparation patch.
> > > > > >
> > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > ---
> > > > > >  drivers/media/usb/uvc/uvc_ctrl.c | 12 ++++++++++++
> > > > > >  drivers/media/usb/uvc/uvcvideo.h |  8 ++++++++
> > > > > >  2 files changed, 20 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > > > index 21ec7b978bc7aca21db7cb8fd5d135d876f3330c..59be62ae24a4219fa9d7aacf2ae7382c95362178 100644
> > > > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > > > @@ -596,6 +596,18 @@ static int uvc_ctrl_query_entity(struct uvc_device *dev,
> > > > > >       if (query == UVC_GET_CUR && ctrl->entity->get_cur)
> > > > > >               return ctrl->entity->get_cur(dev, ctrl->entity,
> > > > > >                                            ctrl->info.selector, data, len);
> > > > > > +     if (query == UVC_GET_DEF && ctrl->entity->get_def)
> > > > > > +             return ctrl->entity->get_def(dev, ctrl->entity,
> > > > > > +                                          ctrl->info.selector, data, len);
> > > > > > +     if (query == UVC_GET_MIN && ctrl->entity->get_min)
> > > > > > +             return ctrl->entity->get_min(dev, ctrl->entity,
> > > > > > +                                          ctrl->info.selector, data, len);
> > > > > > +     if (query == UVC_GET_MAX && ctrl->entity->get_max)
> > > > > > +             return ctrl->entity->get_max(dev, ctrl->entity,
> > > > > > +                                          ctrl->info.selector, data, len);
> > > > > > +     if (query == UVC_GET_RES && ctrl->entity->get_res)
> > > > > > +             return ctrl->entity->get_res(dev, ctrl->entity,
> > > > > > +                                          ctrl->info.selector, data, len);
> > > > > >       if (query == UVC_GET_INFO && ctrl->entity->get_info)
> > > > > >               return ctrl->entity->get_info(dev, ctrl->entity,
> > > > > >                                             ctrl->info.selector, data);
> > > > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > > > index a931750bdea25b9062dcc7644bf5f2ed89c1cb4c..d6da8ed3ad4cf3377df49923e051fe04d83d2e38 100644
> > > > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > > > @@ -261,6 +261,14 @@ struct uvc_entity {
> > > > > >                       u8 cs, u8 *caps);
> > > > > >       int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > >                      u8 cs, void *data, u16 size);
> > > > > > +     int (*get_def)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > +                    u8 cs, void *data, u16 size);
> > > > > > +     int (*get_min)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > +                    u8 cs, void *data, u16 size);
> > > > > > +     int (*get_max)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > +                    u8 cs, void *data, u16 size);
> > > > > > +     int (*get_res)(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > +                    u8 cs, void *data, u16 size);
> > > > > >
> > > > > >       unsigned int ncontrols;
> > > > > >       struct uvc_control *controls;
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

