Return-Path: <linux-acpi+bounces-14846-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B1AED527
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 09:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225E13ADAF8
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9E221D3D2;
	Mon, 30 Jun 2025 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzuYIRxc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7DB215F72;
	Mon, 30 Jun 2025 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267197; cv=none; b=mmQ5QQ8XNPsxWhFFDOxchakGAvo5g5O01n8bIbQ6JMGlKoebR5pw1Sw0vdEjWELiV7enLx20sETgzqim9KVc65HJE4XetcIl6jGIvdwQs8JioYncmFmbNSV9c2TN0fXcmpuQkNE0330zYOma29aK6EM5LifKEyoHhcEdLsgYX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267197; c=relaxed/simple;
	bh=j733+QscBMRNMa4l7CcujmPxTXt/r1eIsNkfLH7J9wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKoS58C4dXi9vszyFAsslYabMj8zHp1lEVgKPfJG/d2Cj3qAfIW4m1DkJ/3cV3FHL+nv3dBCgh6axHghfeSj6c4iOvHYPNuc4GEbMcnwA9REAcPgdOv2xi82mI0a2bLKdoYU5aFRNYJ2JJemyrEh801diCawaECGyHH/682Qa/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzuYIRxc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751267196; x=1782803196;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j733+QscBMRNMa4l7CcujmPxTXt/r1eIsNkfLH7J9wY=;
  b=DzuYIRxc2bxkbRA1zs4SeS/DRTHgYEaHVz/OsiSD4vttU4Kp99HunYMB
   h2ml8pALX4bOdB8j66tPQq1wOmC8yzstqfGHfLZrfmiVq2WbMm3EDsuTV
   joUzEJmL3x1RYbn9K5i6aDgreNZaYDCkPFu74Z7IsOc43FwpKO19itV2M
   9m5ADuejTrGQSJL7Os2Yq1I1Rv0i+esqQ1V6QgLVlNuElICgCkfDqbRUp
   4ORwKnDB1C3xcst+KGXBOJHJYLGxsnzomqoHyFnNO6WnseO5V6xn4izll
   5ZdkEbLP0h0HkExmUqDx5olUBh1N4VMcqmUq3w61ZUarIVzrCVdhBQZxU
   Q==;
X-CSE-ConnectionGUID: awzTm6xTTsWNfMgH1NUnlA==
X-CSE-MsgGUID: CvTMaO/JTG+xrmQdfWddfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="52600156"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="52600156"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 00:06:35 -0700
X-CSE-ConnectionGUID: MiAxahvASw2z6GR28Ii+7w==
X-CSE-MsgGUID: acMQ7alxRX+NSTRPsuEwxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="177046704"
Received: from agladkov-desk.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.57])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 00:06:30 -0700
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id C72BE44366;
	Mon, 30 Jun 2025 10:06:28 +0300 (EEST)
Message-ID: <1ac49bd3-1b65-4611-8c90-92fb2c2ffd4a@linux.intel.com>
Date: Sun, 29 Jun 2025 12:21:47 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] media: v4l: fwnode: Support ACPI's _PLD for
 v4l2_fwnode_device_parse
Content-Language: en-US
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-2-5710f9d030aa@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
In-Reply-To: <20250605-uvc-orientation-v2-2-5710f9d030aa@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ricardo,

Thanks for the update.

On 6/5/25 20:52, Ricardo Ribalda wrote:
> Currently v4l2_fwnode_device_parse() obtains the orientation and
> rotation via fwnode properties.
> 
> Extend the function to support as well ACPI devices with _PLD info.
> 
> We give a higher priority to fwnode, because it might contain quirks
> injected via swnodes.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>   drivers/media/v4l2-core/v4l2-fwnode.c | 85 ++++++++++++++++++++++++++++++++---
>   1 file changed, 79 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> index cb153ce42c45d69600a3ec4e59a5584d7e791a2a..379290ab3cfde74c8f663d61837a9a95011b5ae0 100644
> --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> @@ -15,6 +15,7 @@
>    * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>    */
>   #include <linux/acpi.h>
> +#include <acpi/acpi_bus.h>
>   #include <linux/kernel.h>
>   #include <linux/mm.h>
>   #include <linux/module.h>
> @@ -807,16 +808,65 @@ int v4l2_fwnode_connector_add_link(struct fwnode_handle *fwnode,
>   }
>   EXPORT_SYMBOL_GPL(v4l2_fwnode_connector_add_link);
>   
> -int v4l2_fwnode_device_parse(struct device *dev,
> -			     struct v4l2_fwnode_device_properties *props)
> +static int v4l2_fwnode_device_parse_acpi(struct device *dev,
> +					 struct v4l2_fwnode_device_properties *props)
> +{
> +	struct acpi_pld_info *pld;
> +	int ret = 0;
> +
> +	if (!is_acpi_device_node(dev_fwnode(dev)))
> +		return 0;
> +
> +	if (!acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld)) {
> +		dev_dbg(dev, "acpi _PLD call failed\n");

I'd do:

acpi_handle_debug(ACPI_HANDLE(dev), "cannot obtain _PLD\n");

> +		return 0;
> +	}
> +
> +	if (props->orientation != V4L2_FWNODE_PROPERTY_UNSET) {
> +		switch (pld->panel) {
> +		case ACPI_PLD_PANEL_FRONT:
> +			props->orientation = V4L2_FWNODE_ORIENTATION_FRONT;
> +			break;
> +		case ACPI_PLD_PANEL_BACK:
> +			props->orientation = V4L2_FWNODE_ORIENTATION_BACK;
> +			break;
> +		case ACPI_PLD_PANEL_TOP:
> +		case ACPI_PLD_PANEL_LEFT:
> +		case ACPI_PLD_PANEL_RIGHT:
> +		case ACPI_PLD_PANEL_UNKNOWN:
> +			props->orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
> +			break;
> +		default:
> +			dev_dbg(dev, "Unknown _PLD panel val %d\n", pld->panel);

Similarly:

acpi_handle_debug(ACPI_HANDLE(dev), "invalid panel %u in _PLD\n",
		  pld->panel);

> +			ret = -EINVAL;

Should this be an error or should we simply ignore it here (and maybe 
use acpi_handle_warn())?

> +			goto done;
> +		}
> +	}
> +
> +	if (props->rotation != V4L2_FWNODE_PROPERTY_UNSET) {
> +		switch (pld->rotation) {
> +		case 0 ... 7:
> +			props->rotation = pld->rotation * 45;
> +			break;
> +		default:
> +			dev_dbg(dev, "Unknown _PLD rotation val %d\n", pld->panel);

acpi_handle_debug(ACPI_HANDLE(dev), "invalid rotation %u in _PLD\n",
		  pld->rotation);

> +			ret = -EINVAL;
> +			goto done;
> +		}
> +	}
> +
> +done:
> +	ACPI_FREE(pld);
> +	return ret;
> +}
> +
> +static int v4l2_fwnode_device_parse_dt(struct device *dev,

I'd call this v4l2_fwnode_device_parse_of() as we're parsing OF nodes 
and properties here.

> +				       struct v4l2_fwnode_device_properties *props)
>   {
>   	struct fwnode_handle *fwnode = dev_fwnode(dev);
>   	u32 val;
>   	int ret;
>   
> -	memset(props, 0, sizeof(*props));
> -
> -	props->orientation = V4L2_FWNODE_PROPERTY_UNSET;
>   	ret = fwnode_property_read_u32(fwnode, "orientation", &val);
>   	if (!ret) {
>   		switch (val) {
> @@ -833,7 +883,6 @@ int v4l2_fwnode_device_parse(struct device *dev,
>   		dev_dbg(dev, "device orientation: %u\n", val);
>   	}
>   
> -	props->rotation = V4L2_FWNODE_PROPERTY_UNSET;
>   	ret = fwnode_property_read_u32(fwnode, "rotation", &val);
>   	if (!ret) {
>   		if (val >= 360) {
> @@ -847,6 +896,30 @@ int v4l2_fwnode_device_parse(struct device *dev,
>   
>   	return 0;
>   }
> +
> +int v4l2_fwnode_device_parse(struct device *dev,
> +			     struct v4l2_fwnode_device_properties *props)
> +{
> +	int ret;
> +
> +	memset(props, 0, sizeof(*props));
> +
> +	props->orientation = V4L2_FWNODE_PROPERTY_UNSET;
> +	props->rotation = V4L2_FWNODE_PROPERTY_UNSET;
> +
> +	/* Start by looking into swnodes and dt. */
> +	ret =  v4l2_fwnode_device_parse_dt(dev, props);
> +	if (ret)
> +		return ret;
> +
> +	/* Orientation and rotation found!, we are ready. */
> +	if (props->orientation != V4L2_FWNODE_PROPERTY_UNSET &&
> +	    props->rotation != V4L2_FWNODE_PROPERTY_UNSET)
> +		return 0;

I think you can remove this check without affecting the functionality.

> +
> +	/* Let's check the acpi table. */
> +	return v4l2_fwnode_device_parse_acpi(dev, props);
> +}
>   EXPORT_SYMBOL_GPL(v4l2_fwnode_device_parse);
>   
>   /*
> 

-- 
Regards,

Sakari Ailus

