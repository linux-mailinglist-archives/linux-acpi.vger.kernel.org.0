Return-Path: <linux-acpi+bounces-15053-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 306E5AFBDCC
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 23:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E711AA701F
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 21:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7B928980E;
	Mon,  7 Jul 2025 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k528TRLa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D5D1C6FE1;
	Mon,  7 Jul 2025 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924702; cv=none; b=gq3AgvRuhARGnt5et6WcBMPSvWtleVvX8mW/Z75CKtk2O8bPVstWwFLMPmF+QDo/6rCZT+2ytCJnQDahKkMQiybVoDpjEz5F3wKdWQgy3kXVwGuG0Spi/5RwzjbD8o478CA7+pqLI0iR6+7JTXf/2n2SwBXyUEMaQeAUC3IcsbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924702; c=relaxed/simple;
	bh=0tUdt6DB/neRCcNzGewSHU8P2x8r0GshuAng71UKIZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwdE1vTThXGIJSGmPCQAJmz89b9GF4pVrwMhLm18qLflP+yfoJGDpHDUjRDI6vwPlRVEuQSE2tcufvq4mJ8rHLWUE8vMF7MmVqfL8CjzGVet18JVI3YDxi6t99PDxVM3aj4EKHiJfeWE2dp7UsPEGAAe4ejLZXaESQMKlxWCIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k528TRLa; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751924701; x=1783460701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0tUdt6DB/neRCcNzGewSHU8P2x8r0GshuAng71UKIZo=;
  b=k528TRLaLawefhOLLqFFzhRf0E4jgH8enb44bfClyEy6B2CC1zgMsmRo
   Rr+mHTuAlZeFpeMsDYYVOhKOx6ed0vW7MOp2LNauqFLDaTuZX9qnTwTAL
   rdrGxUjpKkjubl8Ih9roxCaBRQdAtGTrlniOnljmx9/Fj654pzWBDglYh
   Sm7WjT8m5YzjKAQnQw7bdANOYvNmF9byEb+VwjTmPJoiSez2N79kX1BT4
   hxMgxy4/zsjivhlXi0ElDLdln0J8fnUkcvns7/XdeNH5KdnPGPjJQOLV/
   IUYgPLz4P05IM1v4lxoEe9gvyFurWrFLTCXusYkELJfQboqsk2AW0S3SJ
   A==;
X-CSE-ConnectionGUID: yLjwkDkXT9effGiZrIyx4g==
X-CSE-MsgGUID: PqTjcx6GSZiSvLY5ZmHWfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65506076"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="65506076"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 14:45:00 -0700
X-CSE-ConnectionGUID: 4oRYXnwDTbCQvHvzk/H1kg==
X-CSE-MsgGUID: 5b2sbxx1QpeewBLwqhQTag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="160870545"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.166])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 14:44:55 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 2720711F94F;
	Tue,  8 Jul 2025 00:44:53 +0300 (EEST)
Date: Mon, 7 Jul 2025 21:44:53 +0000
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
Subject: Re: [PATCH v2 05/12] media: ipu-bridge: Use v4l2_fwnode for unknown
 rotations
Message-ID: <aGw_1T_Edm8--gXW@kekkonen.localdomain>
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-5-5710f9d030aa@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250605-uvc-orientation-v2-5-5710f9d030aa@chromium.org>

Hi Ricardo,

On Thu, Jun 05, 2025 at 05:52:58PM +0000, Ricardo Ribalda wrote:
> The v4l2_fwnode_device_properties contains information about the
> rotation. Use it if the ssdb data is inconclusive.

As SSDB and _PLD provide the same information, are they always aligned? Do
you have any experience on how is this actually in firmware?

_PLD is standardised so it would seem reasonable to stick to that -- if it
exists. Another approach could be to pick the one that doesn't translate to
a sane default (0°).

> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/pci/intel/ipu-bridge.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> index 020aa52f590d66b6d333adc56ebfb9ab0561db51..6f436a8b4d23373af8a6668530333a827eca467a 100644
> --- a/drivers/media/pci/intel/ipu-bridge.c
> +++ b/drivers/media/pci/intel/ipu-bridge.c
> @@ -236,37 +236,41 @@ static int ipu_bridge_read_acpi_buffer(struct acpi_device *adev, char *id,
>  }
>  
>  static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
> -				     struct ipu_sensor_ssdb *ssdb)
> +				     struct ipu_sensor_ssdb *ssdb,
> +				     struct v4l2_fwnode_device_properties *props)
>  {
>  	switch (ssdb->degree) {
>  	case IPU_SENSOR_ROTATION_NORMAL:
>  		return 0;
>  	case IPU_SENSOR_ROTATION_INVERTED:
>  		return 180;
> -	default:
> +	}
> +
> +	if (props->rotation == V4L2_FWNODE_PROPERTY_UNSET) {
>  		dev_warn(ADEV_DEV(adev),
>  			 "Unknown rotation %d. Assume 0 degree rotation\n",
>  			 ssdb->degree);
>  		return 0;
>  	}
> +
> +	return props->rotation;
>  }
>  
> -static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_device *adev)
> +static enum v4l2_fwnode_orientation
> +ipu_bridge_parse_orientation(struct acpi_device *adev,
> +			     struct v4l2_fwnode_device_properties *props)
>  {
> -	struct v4l2_fwnode_device_properties props;
> -	int ret;
> -
> -	ret = v4l2_fwnode_device_parse(ADEV_DEV(adev), &props);
> -	if (!ret || props.rotation == V4L2_FWNODE_PROPERTY_UNSET) {
> +	if (props->orientation == V4L2_FWNODE_PROPERTY_UNSET) {
>  		dev_warn(ADEV_DEV(adev), "Using default orientation\n");
>  		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
>  	}
>  
> -	return props.orientation;
> +	return props->orientation;
>  }
>  
>  int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor)
>  {
> +	struct v4l2_fwnode_device_properties props;
>  	struct ipu_sensor_ssdb ssdb = {};
>  	int ret;
>  
> @@ -274,6 +278,10 @@ int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor)
>  	if (ret)
>  		return ret;
>  
> +	ret = v4l2_fwnode_device_parse(ADEV_DEV(adev), &props);
> +	if (ret)
> +		return ret;
> +
>  	if (ssdb.vcmtype > ARRAY_SIZE(ipu_vcm_types)) {
>  		dev_warn(ADEV_DEV(adev), "Unknown VCM type %d\n", ssdb.vcmtype);
>  		ssdb.vcmtype = 0;
> @@ -287,8 +295,8 @@ int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor)
>  	sensor->link = ssdb.link;
>  	sensor->lanes = ssdb.lanes;
>  	sensor->mclkspeed = ssdb.mclkspeed;
> -	sensor->rotation = ipu_bridge_parse_rotation(adev, &ssdb);
> -	sensor->orientation = ipu_bridge_parse_orientation(adev);
> +	sensor->rotation = ipu_bridge_parse_rotation(adev, &ssdb, &props);
> +	sensor->orientation = ipu_bridge_parse_orientation(adev, &props);
>  
>  	if (ssdb.vcmtype)
>  		sensor->vcm_type = ipu_vcm_types[ssdb.vcmtype - 1];
> 

-- 
Regards,

Sakari Ailus

