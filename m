Return-Path: <linux-acpi+bounces-14847-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545EBAED528
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 09:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B316168619
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 07:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0732821FF48;
	Mon, 30 Jun 2025 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mypwy5m2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF5721A43D;
	Mon, 30 Jun 2025 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267197; cv=none; b=bIgGV8oTuWn+pDpaI+BlxfSq2hC71tPfSLfsYjUhxEW/hoDfwxNhr3PKBv+DERAIUKuwZNnXlQG/iXISOUCf23rUAtFszV1APEvm984VZA29Ou/L98yp9tT03WaFmYGysrpLIsh68LyFfeR/Y17YAyS1hElVkWduPWvxB6ypEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267197; c=relaxed/simple;
	bh=0ArGKK/lkY6jJnv1t6+jlB9HHmUv7yTPBu8XsLA9hUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/hjOzMt9ujm6Iz2QD3zy3SbXsIRbbKrxBAwaCwdnVZibLGj6GSTQx1aH3DfqaQ5l3r5Y/W2DKJn2wo62D4TeXpkCpz5Wmr3sHDwjwoe44ycH5bcg3TYPWwlrzcrS0Z72xPyfYpi+C2aXgFA7/fZsVP1lo7jJBMDHlyahAnhnJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mypwy5m2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751267196; x=1782803196;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0ArGKK/lkY6jJnv1t6+jlB9HHmUv7yTPBu8XsLA9hUg=;
  b=Mypwy5m26F16DOVuRjTzhagpyTGQkTGqtsPqO0YE2+iyunQAjyo6Ieuz
   leA8R0Ssq2DsGiBErPNPm0jDlbnMjjtRy/Pt17bjuW+N/qu3lszZ7965o
   7MJrdNytz/IqOmtilQz1cXxckHpMdfx6rWXKQeiPOe/PfIh46fxwlH+jg
   ZXGK4j0/inpwd6ojAr7JYLGAHqf87+2HnwhgkuuFQ7RmLojfRInWw6kDA
   5HplSnILUmGyF0Ghun9cdfI+Ij+VoqcqqnA9uzYk4g+YwVg6WKB13Bt+g
   7mlV0yKJD/iQ3TgrIuri1gjxJ0zQh48UEUSsTxIB0/Sz0N6ltA1APdiks
   Q==;
X-CSE-ConnectionGUID: E9b7NcTJRD+BRfxLFipZXw==
X-CSE-MsgGUID: gIGuLEklRLaqGCpk/lBWyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="52600166"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="52600166"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 00:06:36 -0700
X-CSE-ConnectionGUID: n+rhYOdUQraQUgje9WuR5g==
X-CSE-MsgGUID: Nb5t3SU+QjKU8jB4pmu9vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="177046708"
Received: from agladkov-desk.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.57])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 00:06:31 -0700
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 8A86644409;
	Mon, 30 Jun 2025 10:06:29 +0300 (EEST)
Message-ID: <b6d9b737-3cd1-4407-a08a-4346ba001ffb@linux.intel.com>
Date: Sun, 29 Jun 2025 12:24:41 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] ACPI: mipi-disco-img: Do not duplicate rotation
 info into swnodes
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
 <20250605-uvc-orientation-v2-3-5710f9d030aa@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
In-Reply-To: <20250605-uvc-orientation-v2-3-5710f9d030aa@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 6/5/25 20:52, Ricardo Ribalda wrote:
> The function v4l2_fwnode_device_parse() is not capable of parsint the
> _PLD method, there is no need to duplicate the rotation information in a
> swnode.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>   drivers/acpi/mipi-disco-img.c | 15 ---------------
>   1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
> index 5b85989f96beeb726f59ac9e12e965a215fb38f6..b58b5ba22a47a4afc5212998074d322f0b7586dc 100644
> --- a/drivers/acpi/mipi-disco-img.c
> +++ b/drivers/acpi/mipi-disco-img.c
> @@ -617,21 +617,6 @@ static void init_crs_csi2_swnodes(struct crs_csi2 *csi2)
>   
>   	adev_fwnode = acpi_fwnode_handle(adev);
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

As "rotation" property won't come via software nodes anymore in DisCo 
for Imaging, please remove ACPI_DEVICE_SWNODE_DEV_ROTATION from struct 
acpi_device_swnode_dev_props as well.

> -			kfree(pld);
> -		}
> -	}
> -
>   	if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-clock-frequency", &val))
>   		swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_CLOCK_FREQUENCY)] =
>   			PROPERTY_ENTRY_U32("clock-frequency", val);
> 

-- 
Regards,

Sakari Ailus

