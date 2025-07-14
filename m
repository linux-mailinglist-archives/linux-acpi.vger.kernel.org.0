Return-Path: <linux-acpi+bounces-15134-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D994FB04194
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 16:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2504A5A75
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C474256C60;
	Mon, 14 Jul 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9eUJDtC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2919ABC6;
	Mon, 14 Jul 2025 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503080; cv=none; b=oQy0SHIR3Fh3Wxg7cC8q/Yu4ds673SbgHrTFV7pbo7SX1RfdmSqbeEc+z8XW2nRlOJBEP2NIFmdUHfqLxA5GYkR/SQ7MGHPG+ixakpi4u9meKl+odQ8OhaUv0JcIp//I7zeQbX/BE0s21gBHgHbXrCAaAaGK9QHzet5XCUh2TKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503080; c=relaxed/simple;
	bh=6VoKxzA38OaFQTk9RyCTeiLiQrhyEWeycwBS3+3rAOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXBmOF5y/DDFVF7vFx+DOY5IBeDtk89FuuoCU1poSln5wsqxOousap0ZmZ8OiUoxLnmUJWV9fuM1IGlUUCdvbkceJuUpEvtUApDF92nqC1uUyG0tiX4D8oSI3MERtUaEAIpDQ7henrz01rqMPmye1vJqyHNHM/j+2iR/iEBbmJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9eUJDtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC603C4CEED;
	Mon, 14 Jul 2025 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752503079;
	bh=6VoKxzA38OaFQTk9RyCTeiLiQrhyEWeycwBS3+3rAOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t9eUJDtCn/UGjWsbyBcjY/Ab+R4W9jMQRB5D8H7YleXBIIiiGlL3dE5LEELjsQY5B
	 uPhKZo2fMgNUY7OTTNqcet0OA+fzs3f1kDcfBWvfRL639jEeE+Tfe/FpxxzVYipEQ+
	 AmHGewXlfJ5cmyz0ERm0gc3b/IRAytqGs9Ja8V1+cHOsWEZI2mRjlGCa9RxnLYgfIx
	 9pPVvTZLuVI/ntQgzRd23/mA58OBrHBtCzztBH4W424g+9wwl8GT3oYCIWEk3Tmqbc
	 ICnx3fqsSx3/+zujBYhN0ntORwFi44r21F5R+Si1iuT4RhBSglU05575G3OeeaaA8Y
	 uvkX+myYrZI0Q==
Message-ID: <e573334d-da02-4d67-95ad-d372aa7f4a67@kernel.org>
Date: Mon, 14 Jul 2025 16:24:32 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] media: uvcvideo: Add uvc_ctrl_query_entity
 helper
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hdegoede@redhat.com>,
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
 <20250605-uvc-orientation-v2-9-5710f9d030aa@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250605-uvc-orientation-v2-9-5710f9d030aa@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 5-Jun-25 19:53, Ricardo Ribalda wrote:
> Create a helper function to query a control. The new function reduces
> the number of arguments, calculates the length of the operation and
> redirects the operation to the hardware or to the entity private
> functions.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, this looks like a nice cleanup.

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

Maybe:

	if (query == UVC_GET_CUR && ctrl->entity->get_cur)
		return ctrl->entity->get_cur(dev, ctrl->entity,
					     ctrl->info.selector, data, len);
	else if (query == UVC_GET_INFO && ctrl->entity->get_info)
		return ctrl->entity->get_info(dev, ctrl->entity,
					      ctrl->info.selector, data);
	else
		return uvc_query_ctrl(dev, query, ctrl->entity->id, dev->intfnum,
				      ctrl->info.selector, data, len);

?

That + Laurent's well observed remark about info->selector vs
ctrl->info.selector which I would probably have missed...

About Laurent's remark about one case of this pre-existing,
please fix this in a separate patch (I guess you would have done so
anyways, but just to be sure).

Regards,

Hans





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
>  	if (ret < 0) {
>  		uvc_dbg(dev, CONTROL,
>  			"GET_LEN failed on control %pUl/%u (%d)\n",
> 


