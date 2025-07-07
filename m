Return-Path: <linux-acpi+bounces-15052-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B60AFBD27
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 23:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5B4188B49D
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 21:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CC22853E0;
	Mon,  7 Jul 2025 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wyh3TsFo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ADB219A6B;
	Mon,  7 Jul 2025 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751922328; cv=none; b=NW6ulX6ozLDNLO+YaaYlpoFjIuY5QIjeqYGAfYE934M+TasHZZvkb2rHtWyAMXooMXRu5CrswYHCFxEc/DfATfZrdi0irY+oUZQtez/6t2vfQgSiC7/FKlcs7PeBanVqIEb+xhRZ/5OFohbcBndXNPOJvPtmVQvzHNSEmifzMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751922328; c=relaxed/simple;
	bh=Msw1wwMIj6bBrU/TIW6lTu4STpQvmw8gNG14LUH91S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC1aFPbYJn8dFxD+spamMyVzgka2o4XASQqxtspCnrSeRXeftwKuBtR/3jMOQe5VtHdXDiW/Br98l/9GXu1rkdppTAsrJMQe5QL7K0q6Y+ROuseg9Urr5LBpfcqIypPAH7Bds45Yxxgo7DycYlWT2geWCWkTJbCMsCzmSQuUk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wyh3TsFo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751922327; x=1783458327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Msw1wwMIj6bBrU/TIW6lTu4STpQvmw8gNG14LUH91S4=;
  b=Wyh3TsFoqhK4tvmS3CFH9ORXH8XSnJSqZTzKlBPrCLsXGx8EcRmQWTly
   uH3Gv+wznesqEOck4QXJgyHFXj6YW5gGfUwGcivBdcOD2laxgqKe5lW3L
   oRYLa6js+Ln+9yEMgOQsm2dZEe2Uun6H2+XfB0Ks3BkYHTT37Ln0R+DfM
   oiOGjMGnHAwBNTLRV4MAzVJDOOOsVu4qMMR4ZfRoz5hiQVPKRxTNhUlms
   Q1nZo5Qu4yeFePUEJVNuBM88z9bfsjd7wO5o9KWnKA898tEQR/2Mzx/YR
   TFkMagwAgRCm9mq7sCTxQwDNdR+1CQp4kshRy6BzHRBgutt85rvAV1d7Y
   Q==;
X-CSE-ConnectionGUID: 9Ay4YK0mQX2tTVGnBveFOA==
X-CSE-MsgGUID: 8+n5R5XfRB+MmBunCOUlkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64400404"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="64400404"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 14:05:27 -0700
X-CSE-ConnectionGUID: Is9nNTIMT+aYqgs+4rTEkQ==
X-CSE-MsgGUID: djdgfGkZQPmGGO4uqQrFOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="192499157"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.166])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 14:05:22 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 707C911FC1A;
	Tue,  8 Jul 2025 00:05:19 +0300 (EEST)
Date: Mon, 7 Jul 2025 21:05:19 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
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
Subject: Re: [PATCH v2 03/12] ACPI: mipi-disco-img: Do not duplicate rotation
 info into swnodes
Message-ID: <aGw2j1iHD6POx3yF@kekkonen.localdomain>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-3-5710f9d030aa@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-uvc-orientation-v2-3-5710f9d030aa@chromium.org>

Hi Ricardo,

A few more comments.

On Thu, Jun 05, 2025 at 05:52:56PM +0000, Ricardo Ribalda wrote:
> The function v4l2_fwnode_device_parse() is not capable of parsint the

s/not/now/
s/parsin\Kt/g/

?

> _PLD method, there is no need to duplicate the rotation information in a
> swnode.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
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

-- 
Regards,

Sakari Ailus

