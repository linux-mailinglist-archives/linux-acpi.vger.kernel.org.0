Return-Path: <linux-acpi+bounces-14838-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2852FAECF65
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Jun 2025 20:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA573B029F
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Jun 2025 18:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9401DFE22;
	Sun, 29 Jun 2025 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YuTicQfr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256D288A8;
	Sun, 29 Jun 2025 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751220361; cv=none; b=A7ZySk+Id606Q1RekTRG2DAGr3VJofTKs0sbBJdCWSydtLB+d4kpWcUF6mM/Am7zljtXiCajIZxzl3BA5Glhuq38smZWbw0KFaqdzYZxm5aY8GKK1HaiyE3SreTKQTl4Ev1Kysa6gISOyxAlfFKkvHDtrRo6bVhiavg6e/HjYZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751220361; c=relaxed/simple;
	bh=NFO9fezxtmyRyOB05VEoArPZF9fdeB6VZM7M3FD/zbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR/iK2t4aS3H9g0NIc//Z614lpqfukWKml8gQpYfn4iecoPdPlefMBtc6nIWi0jZlZk9ZZorXa5mpZRDE+C87QZq9JT53PWMLBHiFxfvydGU+RA+FNGr9k4BSxLr90M7fZNulMSoj+J6kdiznM0N5qcTR9Ww8erwyWVikjZ9n8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=YuTicQfr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id C0D34C67;
	Sun, 29 Jun 2025 20:05:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1751220337;
	bh=NFO9fezxtmyRyOB05VEoArPZF9fdeB6VZM7M3FD/zbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YuTicQfr+WvuK+9COShPhV95lq22rBf6xhjtiln3DYbqXcqh0jO4G7RVoccu2tRgZ
	 dcvJ3QAzn69uo9LEa+e6CApWuQceGH3YMmEhdiTAxsmJHHOjhGBWcvU4YtJzynvF5S
	 2694307pKqRlotKdVfVMvL+aImENKdcGrdOvxkgU=
Date: Sun, 29 Jun 2025 21:05:34 +0300
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
Subject: Re: [PATCH v2 12/12] media: uvcvideo: Do not create MC entities for
 virtual entities
Message-ID: <20250629180534.GN24912@pendragon.ideasonboard.com>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-12-5710f9d030aa@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250605-uvc-orientation-v2-12-5710f9d030aa@chromium.org>

Hi Ricardo,

Thank you for the patch.

I would use "software entities" and not "virtual entities" in the
subject line and everywhere else, as those entities are not virtual.

On Thu, Jun 05, 2025 at 05:53:05PM +0000, Ricardo Ribalda wrote:
> Neither the GPIO nor the SWENTITY entities form part of the device
> pipeline. We just create them to hold emulated uvc controls.
> 
> When the device initializes, a warning is thrown by the v4l2 core:
> uvcvideo 1-1:1.0: Entity type for entity SWENTITY was not initialized!
> 
> There are no entity function that matches what we are doing here, and
> it does not make to much sense to create a function for entities that
> do not really exist.

I don't agree with this. The purpose of reporting entities to userspace
through the MC API is to let application enumerate what entities a
device contains. Being able to enumerate software entities seems as
useful as being able to enumerate hardware entities.

> Do not create MC entities for them and pretend nothing happened here.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_entity.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
> index d1a652ef35ec34801bd39a5124b834edf838a79e..2dbeb4ab0c4c8cc763ff2dcd2d836a50f3c6a040 100644
> --- a/drivers/media/usb/uvc/uvc_entity.c
> +++ b/drivers/media/usb/uvc/uvc_entity.c
> @@ -72,6 +72,16 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
>  {
>  	int ret;
>  
> +	/*
> +	 * Do not initialize virtual entities, they do not really exist
> +	 * and are not connected to any other entities.
> +	 */
> +	switch (UVC_ENTITY_TYPE(entity)) {
> +	case UVC_EXT_GPIO_UNIT:
> +	case UVC_SWENTITY_UNIT:
> +		return 0;
> +	}
> +
>  	if (UVC_ENTITY_TYPE(entity) != UVC_TT_STREAMING) {
>  		u32 function;
>  

-- 
Regards,

Laurent Pinchart

