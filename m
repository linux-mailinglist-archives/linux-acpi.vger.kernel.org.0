Return-Path: <linux-acpi+bounces-14835-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15552AECF47
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Jun 2025 19:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769D37A2705
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Jun 2025 17:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA8C234984;
	Sun, 29 Jun 2025 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fukdewk9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E08192D68;
	Sun, 29 Jun 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751219035; cv=none; b=hGby95nAzngdds8O9iehjwC6hCtoAS1HX3eRwkf7c1TQxr1T2/rY92OW8yjmqJ//g0IP3ot9LmbKNPubA7OCc+j0y/LRaaET6EzcWyzY/oQBxoVJlRQnijxN6APtlBrohz5+8HPmnoLSe45BR7iQK4iNcjO9ue1uY7C6SCLH58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751219035; c=relaxed/simple;
	bh=xSQXOzw0KrGLCt71mbgRzdYN++PQkK/u+7a+D0SNjR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zpbwf/rBVlnQ8Egl058SzGlsFHyeMntdhqSRWBUa+31UBraV7jrGjqmEPCX+8/61oaL70jR1D5ZInHRNxYqo3Ml7RgBe9/jUBPQocrRLpgx/CELwCfk5+eAuFHKU2oDQoU/E0LJrU1fzHUjDz8wMSp+LWFWeYGoKq3k/lZR2Sjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fukdewk9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 9E65C16D7;
	Sun, 29 Jun 2025 19:43:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1751219011;
	bh=xSQXOzw0KrGLCt71mbgRzdYN++PQkK/u+7a+D0SNjR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fukdewk9cya8gxOCPi4IW/tawmuYk4r7jhmY1+iqyo7Ml2bzIbsjAazdqU5DTlkZY
	 ZdgAYWMC4rwqU8IO6+NNZkmwd9qq4ILZgQCmF5kbtVZ+cD/vOI6R+aqg01PnjoTvKi
	 oknIqcwyv0MF8QQqje2CJmJLtp4ILdzd9leA9bHU=
Date: Sun, 29 Jun 2025 20:43:29 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 07/12] media: uvcvideo: Make uvc_alloc_entity non
 static
Message-ID: <20250629174329.GB6260@pendragon.ideasonboard.com>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-7-5710f9d030aa@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250605-uvc-orientation-v2-7-5710f9d030aa@chromium.org>

On Thu, Jun 05, 2025 at 05:53:00PM +0000, Ricardo Ribalda wrote:
> The function is useful for other compilation units.
> 
> This is just a refactor patch, no new functionality is added.

I think you can squash it with patch 08/12 where the function is used.
The change is small enough.

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

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

-- 
Regards,

Laurent Pinchart

