Return-Path: <linux-acpi+bounces-15124-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D059B03F26
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 15:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D18189DCC8
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 13:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D945924DD11;
	Mon, 14 Jul 2025 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNdgVl1D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9988424DCEF;
	Mon, 14 Jul 2025 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498056; cv=none; b=s5xWL64R2TrAiNCm3gobj2mr3yBckUOX2jjH7vyTzlkgqbiany0k2aq2ly7VvCUgC9ZAS8r9ufXERG07wdbrbKOlIAwdIwCqx9uQxRUGRkexWMzQmBxhIn6XqtvfTdv7w4omeubsf2EsR8+ySnzPx16BE3OcG4lL0YgL1YGMW24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498056; c=relaxed/simple;
	bh=3fFhHtDAfgbxPP8AUkNDxHi1qI9xVRX1525H3vua2/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/Ov1OuRyL0L2z/8k2XVYaDCGNoPFMZP4nqVROLpmarFDkCBg0uv2DG3L6PgOCPjLzrNLbwypy6Md0x+Ph7oYYC/XBxiDFFTd1f0l/KKC+GHBagMF22aPV2Q9uPlRnXQWk9q1XQuRxmxBfuQWIZHpzdQyif+Cg2GuVNYdYDdgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNdgVl1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9FBC4CEED;
	Mon, 14 Jul 2025 13:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752498055;
	bh=3fFhHtDAfgbxPP8AUkNDxHi1qI9xVRX1525H3vua2/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VNdgVl1DAstjWQEzWPvoLL79v/Z1u7vah+UeNYRAcqfB9d+nuxOwDelMwgRkLqFdw
	 lvQN4Iyjr6Z+JMM/vhHONsIcslzWpr/xTvkxeLAYHJHK73eaOP5fwT+oeE4IwvFiuj
	 xoBhfNUzgoh028SGZFb4fX1powEPvcCRavNvf4ZEuoa1x1wBOb7fZyakWWdsfjDhI7
	 1Y3MR6hVMREgnFrfEJd7lnhYy5WY+R+fGg7OrCjGg5Jw1MDCatPz3MQsaJmTUcmdUZ
	 PO0lJ3CSX3HKroDOomdMT5GDq0dUcz2F+M+sIcS4sjRvs5gXoiKe/du2rOKE2DM2Ww
	 z5eUshw1SeKXg==
Message-ID: <6459daf0-ed7f-476f-8503-aaa3a8fb309a@kernel.org>
Date: Mon, 14 Jul 2025 15:00:49 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] media: uvcvideo: Always set default_value
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-1-5710f9d030aa@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250605-uvc-orientation-v2-1-5710f9d030aa@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5-Jun-25 19:52, Ricardo Ribalda wrote:
> If the control does not support GET_DEF, the field default_value will be
> left uninitialized during queryctrl.
> 
> Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me,

Reviewed-by: Hans de Goede <hansg@kernel.org>

with Laurent's remarks addressed.

Regards,

Hans

> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 44b6513c526421943bb9841fb53dc5f8e9f93f02..47e8ccc39234d1769384b55539a21df07f3d57c7 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1497,6 +1497,8 @@ static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
>  	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF) {
>  		v4l2_ctrl->default_value = uvc_mapping_get_s32(mapping,
>  				UVC_GET_DEF, uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
> +	} else {
> +		v4l2_ctrl->default_value = 0;
>  	}
>  
>  	switch (mapping->v4l2_type) {
> 


