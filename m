Return-Path: <linux-acpi+bounces-15135-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F73FB041A6
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 16:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084DB4A7906
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 14:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822BB255F56;
	Mon, 14 Jul 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjPOQ6sF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE222129F;
	Mon, 14 Jul 2025 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503330; cv=none; b=low50mDb8yMXY6acczdz6UWBqHQsAsZ9L62xMC79K5skXQEMAjAL9BfTSPe8Xqx4e1ZCXC3+HcIM/bcS1Y0O7XaOKkRAkdyXnTTsn7GtfzQ+T8W8rbHAOzhnLPnmH/Za2sIICri3ypSGCxmCRf2Gn56cHoaD3YrVRbQ2ROOEvKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503330; c=relaxed/simple;
	bh=/P5aV1LHkhzKUZr0ZcTRFRiNCSIXBZhwy8QEEM9Ppms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+tbBTsapncUL4Neo1WiE9ey3OayHtxs+ZFIKSOEEZ2SXXGFD3VtnCtZoxjtnqq8UV+2+DXkEP+uIB3SfYXt5p5A8BFYtvZmlhKHyCMsEy33kmzpoF6LQw0VPBoO4EBsht74PWnKNP1E9jmgPx8fYJ2bpYbXj+TGbx7xwijXJdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjPOQ6sF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4FBC4CEED;
	Mon, 14 Jul 2025 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752503329;
	bh=/P5aV1LHkhzKUZr0ZcTRFRiNCSIXBZhwy8QEEM9Ppms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YjPOQ6sFAV7RywsgYZQy98VtWBWzwu49z5lGcVdDNfsGeDwWhtlgDuXyUK5DV9kkk
	 N/9f9az7L/auquAPKX+3HvjrFSkHra4lgNuaqIBvcJBTmTU0bCu/drKMDId0nhnB2n
	 HVPYJnVr+3feqChmDrt72v+bckxvFhcsxtM9rezu6jaPKZJHHlyDc56IEhqsEJgwQ9
	 i4Uf4b2YDyEbNICCtIZ8JVP5Kh8mJYQbz3M6EwDvr/NEkH0NY80x/Oue/H4E2pip3B
	 wbFdp2ZwiPinw58pLRZrMzt0+NHwqmaW9Tqp9VlEns32xuPTLZJeoluUJ0/PThsMGz
	 fN27fntIQiNzQ==
Message-ID: <7c9306c4-1897-41be-b2c1-cb98166ba51a@kernel.org>
Date: Mon, 14 Jul 2025 16:28:43 +0200
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
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <CANiDSCsu0RT4dcGyBJRutP=9HTe+niUoohxTZE=qJ8O_9ez=+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo, Laurent,

On 1-Jul-25 13:13, Ricardo Ribalda wrote:
> Hi Laurent
> 
> On Sun, 29 Jun 2025 at 20:13, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>>
>> Hi Ricardo,
>>
>> Thank you for the patch.
>>
>> On Thu, Jun 05, 2025 at 05:53:03PM +0000, Ricardo Ribalda wrote:
>>> Virtual entities need to provide more values than get_cur and get_cur
>>
>> I think you meant "get_info and get_cur".
>>
>>> for their controls. Add support for get_def, get_min, get_max and
>>> get_res.
>>
>> Do they ? The UVC specification defines controls that don't list
>> GET_DEF, GET_MIN, GET_MAX and GET_RES as mandatory requests. Can't we do
>> the same for the software controls ? This patch is meant to support the
>> UVC_SWENTITY_ORIENTATION and UVC_SWENTITY_ROTATION control in the next
>> patch, and those are read-only controls. Aren't GET_INFO and GET_CUR
>> enough ?
> 
> V4L2_CID_CAMERA_ROTATION has the type UVC_CTRL_DATA_TYPE_UNSIGNED,
> that time requires get_min and get_max.
> We can create a new type UVC_CTRL_DATA_TYPE_UNSIGNED_READ_ONLY that
> fakes min, max and res, but I think that it is cleaner this approach.

If I read this right, then we could at least drop adding get_def and
get_res callbacks from this patch, right?

Can you do that for the next version please?

Regards,

Hans




>>> This is a preparation patch.
>>>
>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>> ---
>>>  drivers/media/usb/uvc/uvc_ctrl.c | 12 ++++++++++++
>>>  drivers/media/usb/uvc/uvcvideo.h |  8 ++++++++
>>>  2 files changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
>>> index 21ec7b978bc7aca21db7cb8fd5d135d876f3330c..59be62ae24a4219fa9d7aacf2ae7382c95362178 100644
>>> --- a/drivers/media/usb/uvc/uvc_ctrl.c
>>> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
>>> @@ -596,6 +596,18 @@ static int uvc_ctrl_query_entity(struct uvc_device *dev,
>>>       if (query == UVC_GET_CUR && ctrl->entity->get_cur)
>>>               return ctrl->entity->get_cur(dev, ctrl->entity,
>>>                                            ctrl->info.selector, data, len);
>>> +     if (query == UVC_GET_DEF && ctrl->entity->get_def)
>>> +             return ctrl->entity->get_def(dev, ctrl->entity,
>>> +                                          ctrl->info.selector, data, len);
>>> +     if (query == UVC_GET_MIN && ctrl->entity->get_min)
>>> +             return ctrl->entity->get_min(dev, ctrl->entity,
>>> +                                          ctrl->info.selector, data, len);
>>> +     if (query == UVC_GET_MAX && ctrl->entity->get_max)
>>> +             return ctrl->entity->get_max(dev, ctrl->entity,
>>> +                                          ctrl->info.selector, data, len);
>>> +     if (query == UVC_GET_RES && ctrl->entity->get_res)
>>> +             return ctrl->entity->get_res(dev, ctrl->entity,
>>> +                                          ctrl->info.selector, data, len);
>>>       if (query == UVC_GET_INFO && ctrl->entity->get_info)
>>>               return ctrl->entity->get_info(dev, ctrl->entity,
>>>                                             ctrl->info.selector, data);
>>> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
>>> index a931750bdea25b9062dcc7644bf5f2ed89c1cb4c..d6da8ed3ad4cf3377df49923e051fe04d83d2e38 100644
>>> --- a/drivers/media/usb/uvc/uvcvideo.h
>>> +++ b/drivers/media/usb/uvc/uvcvideo.h
>>> @@ -261,6 +261,14 @@ struct uvc_entity {
>>>                       u8 cs, u8 *caps);
>>>       int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
>>>                      u8 cs, void *data, u16 size);
>>> +     int (*get_def)(struct uvc_device *dev, struct uvc_entity *entity,
>>> +                    u8 cs, void *data, u16 size);
>>> +     int (*get_min)(struct uvc_device *dev, struct uvc_entity *entity,
>>> +                    u8 cs, void *data, u16 size);
>>> +     int (*get_max)(struct uvc_device *dev, struct uvc_entity *entity,
>>> +                    u8 cs, void *data, u16 size);
>>> +     int (*get_res)(struct uvc_device *dev, struct uvc_entity *entity,
>>> +                    u8 cs, void *data, u16 size);
>>>
>>>       unsigned int ncontrols;
>>>       struct uvc_control *controls;
>>
>> --
>> Regards,
>>
>> Laurent Pinchart
> 
> 
> 


