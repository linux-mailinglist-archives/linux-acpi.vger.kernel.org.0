Return-Path: <linux-acpi+bounces-15126-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 409AFB03F42
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 15:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C1216F818
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 13:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF8224DFF3;
	Mon, 14 Jul 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kESir9BF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C7224DCE2;
	Mon, 14 Jul 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498508; cv=none; b=F3BRpwBifBBGPPJuLu0dAMcGLRwH5LdKfF97Nrm6n+yPHziMOrjcKFpPy+ySsZYZvo4NBGg0x9jLyaR2bzrGW211Tpu7HPDSO2+CmVWarbECFlPbm9Z5Z8NqzJkuR54VdtQWBDhhAww0vFt/5VEYi3UkVKTDaOxSvMICoVQRy8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498508; c=relaxed/simple;
	bh=LYypQ4vxOLwqTrqcgG0q2wlxoW2Is3r5NQ/pgJZs9Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEN7GLy9OZzHLpQvhjvO1OzLAqqeVkG7Sdrtn7XD7rUJ8ufTc24y4v1h2eMh7TSZ36LQAJTwuINOqjfDa4IlsKiI0FKHfph7Jno9YcHoL3mq/Gb/b3JYwdew3OgJDImCmpIWfZFu1QSFp7BtC/PNbwALE7r1kOij7RDpktK84Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kESir9BF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DCEC4CEF6;
	Mon, 14 Jul 2025 13:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752498507;
	bh=LYypQ4vxOLwqTrqcgG0q2wlxoW2Is3r5NQ/pgJZs9Lg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kESir9BFcDEVmbbHGoCj/Qd0hihAZwO/ciB75VXsgrI7YB9Eyzv78WK2Nu/0G1Wh+
	 9K5YSdgat2KTvACGGR3WbM1+sfv4XfPqmfwj5xJJwcHB8pqJN/ad36wV11ZoTSlk7h
	 xt8oIFrT/XkupS9hMB3xc0dDpzkTvQpi3MDJzwLpp5gsw47vhyHScQrm4gHC6yA8PC
	 cWccidaRyhUI5PuOPbltVM4j1s3BeJDZZO++cSjOz8Fu7yuybR41gjRpO4pnWXNZHn
	 g31J9K5cJt0N41AZJ3HZz2tI2zc1hezuBSyWTdsC5n3etBNuEiphynOFPInBNzP9gu
	 ywDV3xIlVqtWA==
Message-ID: <bbf76d81-fc5c-4234-951a-29b2e54b6603@kernel.org>
Date: Mon, 14 Jul 2025 15:08:21 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] ACPI: mipi-disco-img: Do not duplicate rotation
 info into swnodes
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
 <20250605-uvc-orientation-v2-3-5710f9d030aa@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250605-uvc-orientation-v2-3-5710f9d030aa@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5-Jun-25 19:52, Ricardo Ribalda wrote:
> The function v4l2_fwnode_device_parse() is not capable of parsint the
> _PLD method, there is no need to duplicate the rotation information in a
> swnode.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

with Sakari's review remarks addressed.

Regards,

Hans


> ---
>  drivers/acpi/mipi-disco-img.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
> index 5b85989f96beeb726f59ac9e12e965a215fb38f6..b58b5ba22a47a4afc5212998074d322f0b7586dc 100644
> --- a/drivers/acpi/mipi-disco-img.c
> +++ b/drivers/acpi/mipi-disco-img.c
> @@ -617,21 +617,6 @@ static void init_crs_csi2_swnodes(struct crs_csi2 *csi2)
>  
>  	adev_fwnode = acpi_fwnode_handle(adev);
>  
> -	/*
> -	 * If the "rotation" property is not present, but _PLD is there,
> -	 * evaluate it to get the "rotation" value.
> -	 */
> -	if (!fwnode_property_present(adev_fwnode, "rotation")) {
> -		struct acpi_pld_info *pld;
> -
> -		if (acpi_get_physical_device_location(handle, &pld)) {
> -			swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_ROTATION)] =
> -					PROPERTY_ENTRY_U32("rotation",
> -							   pld->rotation * 45U);
> -			kfree(pld);
> -		}
> -	}
> -
>  	if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-clock-frequency", &val))
>  		swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_CLOCK_FREQUENCY)] =
>  			PROPERTY_ENTRY_U32("clock-frequency", val);
> 


