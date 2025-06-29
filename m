Return-Path: <linux-acpi+bounces-14837-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D8AECF5F
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Jun 2025 20:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3170D169C7D
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Jun 2025 18:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE118787A;
	Sun, 29 Jun 2025 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NKuYfKRg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7C4A3C;
	Sun, 29 Jun 2025 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751220108; cv=none; b=MbJh3/AR6WdtXEz1oggEpGqLhIWbIXXXDJyQDAGMVqBrCcPbQWzKC47ayMOT+GBMYcGgSw9B8Shny6tJRrMjzW/KqRV1B5khcrlaLmYDzWCRbo6jIVnODUCWupqOSz67G6B418TeiucRo29NT4j2tf5IBxoZmRrzS0VNqGKTz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751220108; c=relaxed/simple;
	bh=VVIZcmw3kGEOhZxUnEIWRa2PjCOG8sqv0cjaVfxJixE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srXi4sC2Ebxx78ck/sJ/NngDvLYok/vmgzdcK/TxOgrYPBqLJOIC2IMoCN8DHLl3fISCmCuuyemOtkIYqO0N8wb3hYQb5h8uMDMIE7/6N2dhq+noRCPgNV8GuIq6SH/J0brgfEABrJLMMoKg60IQvHLJK4qIPkVfe009fzTl7ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NKuYfKRg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 1EB9A16D7;
	Sun, 29 Jun 2025 20:01:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1751220082;
	bh=VVIZcmw3kGEOhZxUnEIWRa2PjCOG8sqv0cjaVfxJixE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKuYfKRg7s6e2TtlWzHZyBD0lJlnl0zulGimGGfx3FsfYTnMNTnCBjirQkRg0ujz3
	 i2lhPdVCzZb5bTuKY438MLuKOAwIBqobYJmd4U15iBs2LauyEXb9ofOmh/97hhazoo
	 R2owP5LXUk2yarMPR0rk6mMt9pzM/CEe7uORAh9o=
Date: Sun, 29 Jun 2025 21:01:19 +0300
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
Subject: Re: [PATCH v2 09/12] media: uvcvideo: Add uvc_ctrl_query_entity
 helper
Message-ID: <20250629180119.GD6260@pendragon.ideasonboard.com>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-9-5710f9d030aa@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250605-uvc-orientation-v2-9-5710f9d030aa@chromium.org>

Hi Ricardo,

On Thu, Jun 05, 2025 at 05:53:02PM +0000, Ricardo Ribalda wrote:
> Create a helper function to query a control. The new function reduces
> the number of arguments, calculates the length of the operation and
> redirects the operation to the hardware or to the entity private
> functions.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 81 ++++++++++++++++++++--------------------
>  1 file changed, 41 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index b2768080c08aafa85acb9b7f318672c043d84e55..21ec7b978bc7aca21db7cb8fd5d135d876f3330c 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -576,6 +576,34 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc15 = {
>  				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
>  };
>  
> +static int uvc_ctrl_query_entity(struct uvc_device *dev,
> +				 const struct uvc_control *ctrl, u8 query,
> +				 void *data)
> +{
> +	u16 len;
> +
> +	switch (query) {
> +	case UVC_GET_INFO:
> +		len = 1;
> +		break;
> +	case UVC_GET_LEN:
> +		len = 2;
> +		break;
> +	default:
> +		len = ctrl->info.size;

		break;

> +	}
> +
> +	if (query == UVC_GET_CUR && ctrl->entity->get_cur)
> +		return ctrl->entity->get_cur(dev, ctrl->entity,
> +					     ctrl->info.selector, data, len);
> +	if (query == UVC_GET_INFO && ctrl->entity->get_info)
> +		return ctrl->entity->get_info(dev, ctrl->entity,
> +					      ctrl->info.selector, data);
> +
> +	return uvc_query_ctrl(dev, query, ctrl->entity->id, dev->intfnum,
> +			      ctrl->info.selector, data, len);
> +}
> +
>  static const struct uvc_control_mapping *uvc_ctrl_filter_plf_mapping(
>  	struct uvc_video_chain *chain, struct uvc_control *ctrl)
>  {
> @@ -1222,35 +1250,27 @@ static int uvc_ctrl_populate_cache(struct uvc_video_chain *chain,
>  	int ret;
>  
>  	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF) {
> -		ret = uvc_query_ctrl(chain->dev, UVC_GET_DEF, ctrl->entity->id,
> -				     chain->dev->intfnum, ctrl->info.selector,
> -				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF),
> -				     ctrl->info.size);
> +		ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_DEF,
> +					uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
>  		if (ret < 0)
>  			return ret;
>  	}
>  
>  	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) {
> -		ret = uvc_query_ctrl(chain->dev, UVC_GET_MIN, ctrl->entity->id,
> -				     chain->dev->intfnum, ctrl->info.selector,
> -				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN),
> -				     ctrl->info.size);
> +		ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_MIN,
> +					uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
>  		if (ret < 0)
>  			return ret;
>  	}
>  	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX) {
> -		ret = uvc_query_ctrl(chain->dev, UVC_GET_MAX, ctrl->entity->id,
> -				     chain->dev->intfnum, ctrl->info.selector,
> -				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX),
> -				     ctrl->info.size);
> +		ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_MAX,
> +					uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
>  		if (ret < 0)
>  			return ret;
>  	}
>  	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES) {
> -		ret = uvc_query_ctrl(chain->dev, UVC_GET_RES, ctrl->entity->id,
> -				     chain->dev->intfnum, ctrl->info.selector,
> -				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES),
> -				     ctrl->info.size);
> +		ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_RES,
> +					uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
>  		if (ret < 0) {
>  			if (UVC_ENTITY_TYPE(ctrl->entity) !=
>  			    UVC_VC_EXTENSION_UNIT)
> @@ -1291,16 +1311,7 @@ static int __uvc_ctrl_load_cur(struct uvc_video_chain *chain,
>  		return 0;
>  	}
>  
> -	if (ctrl->entity->get_cur)
> -		ret = ctrl->entity->get_cur(chain->dev, ctrl->entity,
> -					    ctrl->info.selector, data,
> -					    ctrl->info.size);
> -	else
> -		ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR,
> -				     ctrl->entity->id, chain->dev->intfnum,
> -				     ctrl->info.selector, data,
> -				     ctrl->info.size);
> -
> +	ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_CUR, data);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -2164,11 +2175,8 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
>  			continue;
>  
>  		if (!rollback)
> -			ret = uvc_query_ctrl(dev, UVC_SET_CUR, ctrl->entity->id,
> -				dev->intfnum, ctrl->info.selector,
> -				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
> -				ctrl->info.size);
> -
> +			ret = uvc_ctrl_query_entity(dev, ctrl, UVC_SET_CUR,
> +				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
>  		if (!ret)
>  			processed_ctrls++;
>  
> @@ -2570,13 +2578,7 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
>  	if (data == NULL)
>  		return -ENOMEM;
>  
> -	if (ctrl->entity->get_info)
> -		ret = ctrl->entity->get_info(dev, ctrl->entity,
> -					     ctrl->info.selector, data);
> -	else
> -		ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id,
> -				     dev->intfnum, info->selector, data, 1);

Here ctrl->info isn't filled yet, so replacing info->selector with
ctrl->info.selector won't work. Usage of ctrl->info.selector in the
->get_info() branch looks like a bug.

> -
> +	ret = uvc_ctrl_query_entity(dev, ctrl, UVC_GET_INFO, data);
>  	if (!ret) {
>  		info->flags &= ~(UVC_CTRL_FLAG_GET_CUR |
>  				 UVC_CTRL_FLAG_SET_CUR |
> @@ -2654,8 +2656,7 @@ static int uvc_ctrl_fill_xu_info(struct uvc_device *dev,
>  	info->selector = ctrl->index + 1;
>  
>  	/* Query and verify the control length (GET_LEN) */
> -	ret = uvc_query_ctrl(dev, UVC_GET_LEN, ctrl->entity->id, dev->intfnum,
> -			     info->selector, data, 2);
> +	ret = uvc_ctrl_query_entity(dev, ctrl, UVC_GET_LEN, data);

Same here.

>  	if (ret < 0) {
>  		uvc_dbg(dev, CONTROL,
>  			"GET_LEN failed on control %pUl/%u (%d)\n",

-- 
Regards,

Laurent Pinchart

