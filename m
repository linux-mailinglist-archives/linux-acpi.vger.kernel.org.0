Return-Path: <linux-acpi+bounces-14839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2A4AECF71
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Jun 2025 20:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8ECB3B2EB5
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Jun 2025 18:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CA3238C0A;
	Sun, 29 Jun 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kkPQfXy6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC051FBEA2;
	Sun, 29 Jun 2025 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751220793; cv=none; b=JwpXRCUDQesoj1aoJCds/LJOMgIGTfgiCNhaFL+ZJaV6D+Coa3wOs4ylrF1VfxwQ6E9ULY7slHHj9GD734nKEr9Z/eDK+mA6zhGYRjFSmfWFrekgkugyHBzlLFESOwLA3gJyh0qc7mH0nwHJEXwCdVJmLMWB+qrOJ5zyQhCDVGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751220793; c=relaxed/simple;
	bh=Yj/BVhKh2ISdKb0hqkpxRkSF140a3z/27stRT9wv4yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTZAONCRv5J000Qf/64xYe6/NNuvSUI+NSVxYN5iXuEsinFQc0YWQMoefp9doXJj+efEPWUagG7KSzCihz3Z0vzf71AOcH9Ir0H7mW7FvaE52MV8pBTAo7PY2pULwV3ynonfcNiXyLkF62cNSFnS1z63F7m/ffLxjC8DgsDQjX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kkPQfXy6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 0AE7BC67;
	Sun, 29 Jun 2025 20:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1751220769;
	bh=Yj/BVhKh2ISdKb0hqkpxRkSF140a3z/27stRT9wv4yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkPQfXy6WgqHhbyOSw6c4BbI8jAULNNn7sTykSCEqAUhuE9SDVysxg11jktXPapUq
	 IPf4TPqi2ihqFLLNpDnuS9Ov8N7tKW6799X/a7C6HvRsvRnUBKyFh4MlkEY1khbiiT
	 FF5ehEhyp6JP68MZ2sGmSzmqcgKtl/FS5MLqKpQ0=
Date: Sun, 29 Jun 2025 21:12:46 +0300
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
Subject: Re: [PATCH v2 10/12] media: uvcvideo: Add get_* functions to
 uvc_entity
Message-ID: <20250629181246.GE6260@pendragon.ideasonboard.com>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-10-5710f9d030aa@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250605-uvc-orientation-v2-10-5710f9d030aa@chromium.org>

Hi Ricardo,

Thank you for the patch.

On Thu, Jun 05, 2025 at 05:53:03PM +0000, Ricardo Ribalda wrote:
> Virtual entities need to provide more values than get_cur and get_cur

I think you meant "get_info and get_cur".

> for their controls. Add support for get_def, get_min, get_max and
> get_res.

Do they ? The UVC specification defines controls that don't list
GET_DEF, GET_MIN, GET_MAX and GET_RES as mandatory requests. Can't we do
the same for the software controls ? This patch is meant to support the
UVC_SWENTITY_ORIENTATION and UVC_SWENTITY_ROTATION control in the next
patch, and those are read-only controls. Aren't GET_INFO and GET_CUR
enough ?

> 
> This is a preparation patch.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 12 ++++++++++++
>  drivers/media/usb/uvc/uvcvideo.h |  8 ++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 21ec7b978bc7aca21db7cb8fd5d135d876f3330c..59be62ae24a4219fa9d7aacf2ae7382c95362178 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -596,6 +596,18 @@ static int uvc_ctrl_query_entity(struct uvc_device *dev,
>  	if (query == UVC_GET_CUR && ctrl->entity->get_cur)
>  		return ctrl->entity->get_cur(dev, ctrl->entity,
>  					     ctrl->info.selector, data, len);
> +	if (query == UVC_GET_DEF && ctrl->entity->get_def)
> +		return ctrl->entity->get_def(dev, ctrl->entity,
> +					     ctrl->info.selector, data, len);
> +	if (query == UVC_GET_MIN && ctrl->entity->get_min)
> +		return ctrl->entity->get_min(dev, ctrl->entity,
> +					     ctrl->info.selector, data, len);
> +	if (query == UVC_GET_MAX && ctrl->entity->get_max)
> +		return ctrl->entity->get_max(dev, ctrl->entity,
> +					     ctrl->info.selector, data, len);
> +	if (query == UVC_GET_RES && ctrl->entity->get_res)
> +		return ctrl->entity->get_res(dev, ctrl->entity,
> +					     ctrl->info.selector, data, len);
>  	if (query == UVC_GET_INFO && ctrl->entity->get_info)
>  		return ctrl->entity->get_info(dev, ctrl->entity,
>  					      ctrl->info.selector, data);
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index a931750bdea25b9062dcc7644bf5f2ed89c1cb4c..d6da8ed3ad4cf3377df49923e051fe04d83d2e38 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -261,6 +261,14 @@ struct uvc_entity {
>  			u8 cs, u8 *caps);
>  	int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
>  		       u8 cs, void *data, u16 size);
> +	int (*get_def)(struct uvc_device *dev, struct uvc_entity *entity,
> +		       u8 cs, void *data, u16 size);
> +	int (*get_min)(struct uvc_device *dev, struct uvc_entity *entity,
> +		       u8 cs, void *data, u16 size);
> +	int (*get_max)(struct uvc_device *dev, struct uvc_entity *entity,
> +		       u8 cs, void *data, u16 size);
> +	int (*get_res)(struct uvc_device *dev, struct uvc_entity *entity,
> +		       u8 cs, void *data, u16 size);
>  
>  	unsigned int ncontrols;
>  	struct uvc_control *controls;

-- 
Regards,

Laurent Pinchart

