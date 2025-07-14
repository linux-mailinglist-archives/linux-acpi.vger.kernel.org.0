Return-Path: <linux-acpi+bounces-15128-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77BAB03F5D
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 15:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3069C7A9E55
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B8024DCE6;
	Mon, 14 Jul 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVr8G+qD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50072E36F0;
	Mon, 14 Jul 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498723; cv=none; b=I7LJHJG+sXCyyVMCzhQx+hZzovsd2eL1MMbfS6dSnxDlEKqFUwM/8tUnLysHouY0sjbGtOIOY7UA7Qu26wRj1b8K2YHqiXJzSKvzf03WTt0w0AP5Btgo3w3FBc36I/mkQcZU2bTs3JEbz+lh6SpnRMljtYgD6c3Uz0oMHrQ6Bx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498723; c=relaxed/simple;
	bh=ec+Udmi4sR8vkrCaJiGlwkEUhKa728+eNuhwSHOmtz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TcINy01vQlcmzT94DnWuQrID4BeIFyXcHN0eeKKeMV656vO2mgeGVBhGIaGOYj6SMUmY+r7gdFhfJGFLpaWmNaE8WYXrZtEjbRWD50DAmjt1HuplglltefQwIQv7XMxmYhOCaYhQJtLHNMyMDBIxNAoUFeacuaRCmDIBzE0+alc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVr8G+qD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9EBC4CEED;
	Mon, 14 Jul 2025 13:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752498722;
	bh=ec+Udmi4sR8vkrCaJiGlwkEUhKa728+eNuhwSHOmtz8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VVr8G+qDqDdZUDyAuW3H1sLmJueWylzP37/u9WObNzf8RR85ZkKavXjnzGHFpb1tr
	 wkniPWcwzPwcECydeSqkmawQ/by0UH8EJaY1qbz73UU3CcXAPWz/KCTQ5EO9jDjzHD
	 Oa9FwT++n6gyYY46KsIzlmem0HbRaUC2p+BrCNgl8bZz+myC2f5j2QeGv2kR9a2hun
	 twr0EBhHlsW6M4WQOWGRtg67jN2H67grS0UanVngnV6/lkYumKTLVvGEPR1paz1viP
	 /tN5ug2V1u3NIbpb12UmZ6sxcdX7lMIxDFi7WjqcyRHxXGPUlEvJ9NlKXSREYpUYPW
	 318PhowFjSpww==
Message-ID: <ff8e5e11-6947-4d7e-98fa-26fdd4054a36@kernel.org>
Date: Mon, 14 Jul 2025 15:11:55 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] media: ipu-bridge: Use v4l2_fwnode for unknown
 rotations
To: Ricardo Ribalda <ribalda@chromium.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-5-5710f9d030aa@chromium.org>
 <aGw_1T_Edm8--gXW@kekkonen.localdomain>
 <CANiDSCup2iRx+0RcaijSmbn04nBY4Ui9=esCPFsQzOKe=up9Gg@mail.gmail.com>
 <aGzjTRSco39mKJcf@kekkonen.localdomain>
 <CANiDSCsqEHTnbvzLMoe_yxi8JRzp+2PQe3ksXhD=Y3+AqC_9hw@mail.gmail.com>
 <aG0NI2V0Tfh2HZ6O@kekkonen.localdomain>
 <CANiDSCu=wU_Oi7CLPcYTC3Xf_pGbDroaVitPAiAj7ND5pXy-6g@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <CANiDSCu=wU_Oi7CLPcYTC3Xf_pGbDroaVitPAiAj7ND5pXy-6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8-Jul-25 16:58, Ricardo Ribalda wrote:
> On Tue, 8 Jul 2025 at 14:21, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>>
>> Hi Ricardo,
>>
>> On Tue, Jul 08, 2025 at 02:09:28PM +0200, Ricardo Ribalda wrote:
>>> On Tue, 8 Jul 2025 at 11:22, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>>>>
>>>> Hi Ricardo,
>>>>
>>>> On Tue, Jul 08, 2025 at 11:16:25AM +0200, Ricardo Ribalda wrote:
>>>>> Hi Sakari
>>>>>
>>>>> Thanks for your review
>>>>>
>>>>> On Mon, 7 Jul 2025 at 23:45, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>>>>>>
>>>>>> Hi Ricardo,
>>>>>>
>>>>>> On Thu, Jun 05, 2025 at 05:52:58PM +0000, Ricardo Ribalda wrote:
>>>>>>> The v4l2_fwnode_device_properties contains information about the
>>>>>>> rotation. Use it if the ssdb data is inconclusive.
>>>>>>
>>>>>> As SSDB and _PLD provide the same information, are they always aligned? Do
>>>>>> you have any experience on how is this actually in firmware?
>>>>>
>>>>> Not really, in ChromeOS we are pretty lucky to control the firmware.
>>>>>
>>>>> @HdG Do you have some experience/opinion here?
>>>>>
>>>>>>
>>>>>> _PLD is standardised so it would seem reasonable to stick to that -- if it
>>>>>> exists. Another approach could be to pick the one that doesn't translate to
>>>>>> a sane default (0°).
>>>>>
>>>>> I'd rather stick to the current prioritization unless there is a
>>>>> strong argument against it. Otherwise there is a chance that we will
>>>>> have regressions (outside CrOS)
>>>>
>>>> My point was rather there are no such rules currently for rotation: only
>>>> SSDB was being used by the IPU bridge to obtain the rotation value,
>>>> similarly only _PLD is consulted when it comes to orientation.
>>>
>>> So something like this:?
>>>
>>> static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
>>>                                      struct ipu_sensor_ssdb *ssdb,
>>>                                      struct
>>> v4l2_fwnode_device_properties *props)
>>> {
>>>         if (props->rotation != V4L2_FWNODE_PROPERTY_UNSET)
>>>                 return props->rotation;
>>>
>>>         switch (ssdb->degree) {
>>>         case IPU_SENSOR_ROTATION_NORMAL:
>>>                 return 0;
>>>         case IPU_SENSOR_ROTATION_INVERTED:
>>>                 return 180;
>>>         }
>>>
>>>         dev_warn(ADEV_DEV(adev),
>>>                  "Unknown rotation %d. Assume 0 degree rotation\n",
>>>                  ssdb->degree);
>>
>> Maybe:
>>
>>         acpi_handle_warn(acpi_device_handle(adev), ...);
>>
>> ?
>>
>>>         return 0;
>>> }
>>
>> Looks good to me. Maybe something similar for orientation?
> 
> Do you mean using ssdb also for orientation or using acpi_handle_warn?
> 
> 
> I cannot find anything related to orientation for SSDB
> https://github.com/coreboot/coreboot/blob/main/src/drivers/intel/mipi_camera/chip.h#L150
> 
> Am I looking in the right place?

I believe that orientation is only available in the PLD,
so for orientation we can just use the value returned in
v4l2_fwnode_device_properties defaulting to front when
it is not set.

Otherwise I agree with what has been discussed in this
thread (for this patch) so far.

Regards,

Hans


