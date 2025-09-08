Return-Path: <linux-acpi+bounces-16453-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D18EB48C38
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 13:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6FB7AE7F7
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 11:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA9B2EAB60;
	Mon,  8 Sep 2025 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjkAqspg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB51522FDE8;
	Mon,  8 Sep 2025 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331107; cv=none; b=WlZuS7NAXCLg9uP/Hk18OajY+r+S017j5j5Jt97OqTZ683IIpN1JlBLSkbS3H3Z1CVzXYUD5fUAzVABlWsCmt2I3YAk1m74srUmXAtJA5KBOfT27+Ai0y69raIdPMK8+NogFuFRMvGw7iVP76uVqUPZKdUqOwLtrB79i1RPSx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331107; c=relaxed/simple;
	bh=/2NMAx7CdEyJz+oFeKiwwNv2fjn4p93tWohQc2Rt3qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thD5pDP61vo4H6pim7315YJMeIHiewYBZ989ssp+7+aupYgjxpXcifJmhUXqebvEhQgHp3frfyVNeZKh2SZIF/UUUx4XrvEscg7pE4q7xIRLKxuDdwgnjY4lvit+tK3wMgime0Kcgjpas+Q/da16qOX4y3OnuU0qAYrKE5rGkxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjkAqspg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A102C4CEF8;
	Mon,  8 Sep 2025 11:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757331107;
	bh=/2NMAx7CdEyJz+oFeKiwwNv2fjn4p93tWohQc2Rt3qg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mjkAqspghZDLdaGIS6dJG7QjOCNVTbhkmGhOXT5Re5HymFcK4wCRi7hD587x1HebB
	 poX+aI3vVP4FVvvKfEflA0T7CAMbFfFl4MD8Z4v1hgKT2HkYRdcjl3fP3o6GVXpmdr
	 SsxzGMvkxQTancm35B8yjws8XA6ZlJLCA2FzZQ5EvoPfk7BYilYAr3a/IeBlgu4ZWi
	 /pZrij6pzAqwTcGXOqrnxoxHlUrDFNSoHpJytrOLyBQzjPhAe2QRlGWlzEpaeEulMo
	 B+lftDXpCzQZYcTdYpaPQuNKQmKNjViLsRbzYbIZlzT9UJlYlrggnVVRwFX8KNkDk5
	 VA9rsKVu+FQDg==
Message-ID: <fe7bc889-9ba3-4621-8257-e81ba02db9d4@kernel.org>
Date: Mon, 8 Sep 2025 13:31:41 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] media: uvcvideo: Add get_* functions to
 uvc_entity
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-10-5710f9d030aa@chromium.org>
 <20250629181246.GE6260@pendragon.ideasonboard.com>
 <CANiDSCsu0RT4dcGyBJRutP=9HTe+niUoohxTZE=qJ8O_9ez=+A@mail.gmail.com>
 <20250714142926.GI8243@pendragon.ideasonboard.com>
 <CANiDSCvFe23xmrJ0-qbWWa6+vKGb+QdDFV8VSLkmWdAnfsFtzw@mail.gmail.com>
 <20250715193505.GB19299@pendragon.ideasonboard.com>
 <CANiDSCtvt6qnROQ0_-0iG5hqkU_uHZABujZPN7xuh7pUASSGyw@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <CANiDSCtvt6qnROQ0_-0iG5hqkU_uHZABujZPN7xuh7pUASSGyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 16-Jul-25 12:32, Ricardo Ribalda wrote:
> On Tue, 15 Jul 2025 at 21:35, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:

...

>> As for the minimum and maximum, they are currently set to 0 if the
>> corresponding operations are not supported. I wonder if we should set
>> them to the current value instead for read-only controls (as in controls
>> whose flags report support for GET_CUR only)..
> 
> I am not sure that I like that approach IMO the code looks worse...
> but if you prefer that, we can go that way
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

Interesting change. Note you also need to check for
(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) being true,
__uvc_ctrl_load_cur() will return a 0 filled buffer
and success if that is not set.

I wonder why not do something like this instead though:

        if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR) &&
            (ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) &&
            __uvc_ctrl_load_cur(chain, ctrl) == 0) {
                /* Read-only control, set def / min / max to cur */
                memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF),
                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
                       ctrl->info.size);
                memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN),
                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
                       ctrl->info.size);
                memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX),
                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
                       ctrl->info.size);
        }

IOW why bother to make the GET_DEF, etc. calls at all for a
read-only control (even if they are supported) ?

Generally speaking making less calls into the hw seems better?

Although maybe replace the:

        if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR) &&
            (ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) &&

part of the check with a flag in ctrl->info indicating to do
this and do this for specific controls like the new
rotation and orientation controls ?

...

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

I agree with Laurent that thee changes are nice, but please split them into
a separate patch.

Regards,

Hans


