Return-Path: <linux-acpi+bounces-15127-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DCEB03F57
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 15:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146D53B0FF8
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 13:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFDB24C692;
	Mon, 14 Jul 2025 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb06c7hb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688392E36F0;
	Mon, 14 Jul 2025 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498710; cv=none; b=L8taKF4uG2yontq+xgQIAC0DMDXTRjnRFsE+LGFtV1pq+cqS4BI3vfJImucCGuC5/PFvht8gygku9AW3gqpGWCZWjzKdbD0ix75QdXtB8a9Ia0SMVYEz/oWXyvBNftIHHFrOmOu1OGt8o8jjUeQKF1GpeIGFZ7A5neYkmoZe/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498710; c=relaxed/simple;
	bh=KoPIBYxCDRt+wj0haf0ET1qOMy5vh0KrC7gb2yW4fVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z20BNrt/7g1kaQ1NSj5nVoNBm9uUyAF6vQPDeqADlghEDz3sFaw2tABPPQ4LpxEOhv5QqOR017MAvgGzVU3xrgUzFJNf5D01mpDSH/irNWBbwSug4YXHv0/Wa1Vn0lBCh9C/XLNX2d9QkEl4+9uOjCw0F0u4BSR6ulzYIU+JNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb06c7hb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD835C4CEED;
	Mon, 14 Jul 2025 13:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752498709;
	bh=KoPIBYxCDRt+wj0haf0ET1qOMy5vh0KrC7gb2yW4fVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yb06c7hbpWEWE/3ag6aHgq9FZEs9UmIKOyHOm1gbSriCnj4Ii8XrIbr4l+DOld/fm
	 YqqmqNc3YikHQb7RnjyAEip+Ty7f9ypLJW0ReDriE7K+lSr5uFqH6c1QFB6Fv67fBw
	 MRfJ1M5V5klJQPjjxOThKeWWHCvpBL16CzOZZi41GWo7XOMdh0JWieTsPjAKSYi7BK
	 +dZIAF57n+Tcx5wPfb3Ef0+G3zOxIzthP7EwDc3rk0cjUYuUHDlYwezt7CGkDklNTX
	 4FzkASsXmjClvAzCtPclU11YUsKyF3qzI60XgV1UvOIgnNN0ZzfJT4kEOv4Sv8bGmD
	 ZyMtCg5RF1/5w==
Message-ID: <ecdac806-364e-42db-a238-a71b1b2d8624@kernel.org>
Date: Mon, 14 Jul 2025 15:11:44 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] media: ipu-bridge: Use v4l2_fwnode_device_parse
 helper
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
 <20250605-uvc-orientation-v2-4-5710f9d030aa@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250605-uvc-orientation-v2-4-5710f9d030aa@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5-Jun-25 19:52, Ricardo Ribalda wrote:
> v4l2_fwnode_device_parse now supports acpi devices as well. Use the
> helper instead of re-implement the logic.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/pci/intel/ipu-bridge.c | 32 ++++++--------------------------
>  1 file changed, 6 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> index 83e682e1a4b77d9d97b2988750732d0b7c9087b3..020aa52f590d66b6d333adc56ebfb9ab0561db51 100644
> --- a/drivers/media/pci/intel/ipu-bridge.c
> +++ b/drivers/media/pci/intel/ipu-bridge.c
> @@ -253,36 +253,16 @@ static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
>  
>  static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_device *adev)
>  {

In patch 5/12 you add a "struct v4l2_fwnode_device_properties *props" parameter
to this function and move the calling of v4l2_fwnode_device_parse() to
ipu_bridge_parse_ssdb().

You might just as well do this here so that there is a bit less churn in
the series.

Regards,

Hans


> -	enum v4l2_fwnode_orientation orientation;
> -	struct acpi_pld_info *pld = NULL;
> +	struct v4l2_fwnode_device_properties props;
> +	int ret;
>  
> -	if (!acpi_get_physical_device_location(ACPI_PTR(adev->handle), &pld)) {
> -		dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
> +	ret = v4l2_fwnode_device_parse(ADEV_DEV(adev), &props);
> +	if (!ret || props.rotation == V4L2_FWNODE_PROPERTY_UNSET) {
> +		dev_warn(ADEV_DEV(adev), "Using default orientation\n");
>  		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
>  	}
>  
> -	switch (pld->panel) {
> -	case ACPI_PLD_PANEL_FRONT:
> -		orientation = V4L2_FWNODE_ORIENTATION_FRONT;
> -		break;
> -	case ACPI_PLD_PANEL_BACK:
> -		orientation = V4L2_FWNODE_ORIENTATION_BACK;
> -		break;
> -	case ACPI_PLD_PANEL_TOP:
> -	case ACPI_PLD_PANEL_LEFT:
> -	case ACPI_PLD_PANEL_RIGHT:
> -	case ACPI_PLD_PANEL_UNKNOWN:
> -		orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
> -		break;
> -	default:
> -		dev_warn(ADEV_DEV(adev), "Unknown _PLD panel val %d\n",
> -			 pld->panel);
> -		orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
> -		break;
> -	}
> -
> -	ACPI_FREE(pld);
> -	return orientation;
> +	return props.orientation;
>  }
>  
>  int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor)
> 


