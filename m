Return-Path: <linux-acpi+bounces-15130-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB461B04018
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 15:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946321887BC7
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 13:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0331F462D;
	Mon, 14 Jul 2025 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqTALYUi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5432E36E5;
	Mon, 14 Jul 2025 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499870; cv=none; b=Lf4myGrF10XM3zdv7ezv43MnBlrlmu8s7+TDjX6OebyXCD+Jm1XMOrLx/CMJh+VHWaI1FvqjRAiYTVJOfuiFGsGWNn6Yu5AflUAAcWIILMLBcWH0nHyQFr7aw0dkoqnYbZuj77+97qc296ml2QOQeFkW4YrczmH3EtPNW4M4YBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499870; c=relaxed/simple;
	bh=YkRnsX/tnvbZ3o3AEuquJmvgf1eoPe1aSLUVprvpuh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuX5C5ziwx4yXovXtj0yvx0vwGoCs8czuVab6kP7RRgO/Ynu9Ri2Bcb5J8mdIJCQrUp46r9hmRGWcMZe1PK5iPJOgttCTunBKLDzuY6xuOrNhrVIZGysNwidyR49xiOwPzXKck/YAyQLQg6nnqXhkID/FkCBWK5KVWlKl0K0tTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqTALYUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3133DC4CEED;
	Mon, 14 Jul 2025 13:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752499870;
	bh=YkRnsX/tnvbZ3o3AEuquJmvgf1eoPe1aSLUVprvpuh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BqTALYUi1bmxjRdcMoInbUbbODAaFAcMAMF05bc9xSg2bnN2DunFcAqP2YaITGlwQ
	 zuFqauoz8khrkj/sknJLqETl7VCJH0Lvrss29Sxaj2hTWZm2uubO2gFlR7QdEy79Id
	 7648ZvprDr6QEULxGzR28yCeoqOsRZir5pPgFvRlce4pyHmod5dGM07py1UDkiqZdV
	 3Ws/JIQPhW6eQHGz2s4tnea00/0Y5aj6RNDMKdmN+cVPmIJN5lddgtMD/EK9EGpQMM
	 Xw7A1bSyNcf95OhLMDXPjiY3oX5JP+ejOW35uCdfMikc74mnJC39AX6664vndNUFHb
	 u2V2WQeCdg1Qw==
Message-ID: <e9c2bec9-4320-480c-89c1-514c995cf387@kernel.org>
Date: Mon, 14 Jul 2025 15:31:04 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] media: uvcvideo: Make uvc_alloc_entity non
 static
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
 <20250605-uvc-orientation-v2-7-5710f9d030aa@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250605-uvc-orientation-v2-7-5710f9d030aa@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5-Jun-25 19:53, Ricardo Ribalda wrote:
> The function is useful for other compilation units.
> 
> This is just a refactor patch, no new functionality is added.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
>  drivers/media/usb/uvc/uvc_driver.c | 4 ++--
>  drivers/media/usb/uvc/uvcvideo.h   | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index da24a655ab68cc0957762f2b67387677c22224d1..bcc97f71fa1703aea1119469fb32659c17d9409a 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -792,8 +792,8 @@ static const u8 uvc_media_transport_input_guid[16] =
>  	UVC_GUID_UVC_MEDIA_TRANSPORT_INPUT;
>  static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
>  
> -static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
> -		unsigned int num_pads, unsigned int extra_size)
> +struct uvc_entity *uvc_alloc_entity(u16 type, u16 id, unsigned int num_pads,
> +				    unsigned int extra_size)
>  {
>  	struct uvc_entity *entity;
>  	unsigned int num_inputs;
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index b9f8eb62ba1d82ea7788cf6c10cc838a429dbc9e..dc23d8a97340dc4615d4182232d395106e6d9ed5 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -684,6 +684,8 @@ do {									\
>   */
>  
>  struct uvc_entity *uvc_entity_by_id(struct uvc_device *dev, int id);
> +struct uvc_entity *uvc_alloc_entity(u16 type, u16 id, unsigned int num_pads,
> +				    unsigned int extra_size);
>  
>  /* Video buffers queue management. */
>  int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type);
> 


