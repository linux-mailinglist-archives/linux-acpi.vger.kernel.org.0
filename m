Return-Path: <linux-acpi+bounces-10082-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B029EC6F5
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A07188C06C
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6E11D63E3;
	Wed, 11 Dec 2024 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuiLW79X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6692451C5;
	Wed, 11 Dec 2024 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905200; cv=none; b=o86JjrUL4hnVOG8QZpyCaqjxXCaZdzgVQ4RmgXRi6GTKRvzWFTfN/5XbZxjhaDkKq6XkEjxFmZv9fanDKwaE2tSzgluFZxOL5BnSU8AgjrOVLCFHRjY5FYAlrUbUzR4hZ16/mZ6+YIS1s3KbhhsHIAHpBG+kOAmbnfKMjjULNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905200; c=relaxed/simple;
	bh=r21WtUBRcZwcSHqLPko9GR/J8w+sSShlZLghGN9Gwuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7Em7mUVKoZOBuWF7SbFD6I/FgjMuP0U03cOVQLlK2GJR2BmFVKFdZjIq6Ft4TgcMZhdfiEUln1HfOrmb3WSSImRLgnzXci9rMU/RfKvgW3+kBjMBpfEdtWCe+0ZphfWTIqfA23QvQ9fwTtGWCeVaCDOqP86H86fEYPcJrjAfLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuiLW79X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650FEC4CED2;
	Wed, 11 Dec 2024 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733905200;
	bh=r21WtUBRcZwcSHqLPko9GR/J8w+sSShlZLghGN9Gwuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iuiLW79XfjJ2N1gQfWS3HXYLgct6Gc2ZnbSbN+JmB6aHayYd8NPo+W5Vz1pip0XlO
	 oD++IolMyu6nnxJeAies0r79HYPhH/tbIi5vo5DmKWb6mzflM4QK+fzl1g1FTl67+h
	 C8hG6M5E0Q8NrAyBK7CpuzIjbWpKklMfwAe2U875zdvUEuHXsFyECGOUoz8zVELUsi
	 1Nrmqxecw66DwkDxRBUGqJ2n5Ta8lGQjyQgmmDKfvJ4LMeF2sFvLp+TQ8M13VNNR8h
	 Wj/9mxczs1s1FsEQKHHPl8ZhDT6U5emuhgxcPNqCYDDzKHI6236d9DkNrMx7XXcRdv
	 MFl/Y4p/qPUow==
Date: Wed, 11 Dec 2024 09:19:54 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore
 <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional
 compilations
Message-ID: <20241211091954.42a5c778@foz.lan>
In-Reply-To: <20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
	<20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 10 Dec 2024 19:56:04 +0000
Ricardo Ribalda <ribalda@chromium.org> escreveu:

> The ACPI headers have introduced implementations for some of their
> functions when the kernel is not configured with ACPI.
> 
> Let's use them instead of our conditional compilation. It is easier to
> maintain and less prone to errors.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/pci/intel/ipu-bridge.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> index be82bc3e27d0..1db994338fdf 100644
> --- a/drivers/media/pci/intel/ipu-bridge.c
> +++ b/drivers/media/pci/intel/ipu-bridge.c
> @@ -2,6 +2,7 @@
>  /* Author: Dan Scally <djrscally@gmail.com> */
>  
>  #include <linux/acpi.h>
> +#include <acpi/acpi_bus.h>
>  #include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/i2c.h>
> @@ -107,7 +108,6 @@ static const char * const ipu_vcm_types[] = {
>  	"lc898212axb",
>  };
>  
> -#if IS_ENABLED(CONFIG_ACPI)
>  /*
>   * Used to figure out IVSC acpi device by ipu_bridge_get_ivsc_acpi_dev()
>   * instead of device and driver match to probe IVSC device.
> @@ -127,11 +127,11 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
>  		const struct acpi_device_id *acpi_id = &ivsc_acpi_ids[i];
>  		struct acpi_device *consumer, *ivsc_adev;
>  
> -		acpi_handle handle = acpi_device_handle(adev);
> +		acpi_handle handle = acpi_device_handle(ACPI_PTR(adev));
>  		for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
>  			/* camera sensor depends on IVSC in DSDT if exist */
>  			for_each_acpi_consumer_dev(ivsc_adev, consumer)
> -				if (consumer->handle == handle) {
> +				if (ACPI_PTR(consumer->handle) == handle) {
>  					acpi_dev_put(consumer);
>  					return ivsc_adev;
>  				}
> @@ -139,12 +139,6 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
>  
>  	return NULL;
>  }
> -#else
> -static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
> -{
> -	return NULL;
> -}
> -#endif
>  
>  static int ipu_bridge_match_ivsc_dev(struct device *dev, const void *adev)
>  {
> @@ -261,9 +255,8 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
>  	struct acpi_pld_info *pld = NULL;
>  	acpi_status status = AE_ERROR;
>  
> -#if IS_ENABLED(CONFIG_ACPI)
> -	status = acpi_get_physical_device_location(adev->handle, &pld);
> -#endif
> +	status = acpi_get_physical_device_location(ACPI_PTR(adev->handle),
> +						   &pld);
>  	if (ACPI_FAILURE(status)) {
>  		dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
>  		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
> @@ -498,9 +491,7 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
>  	if (sensor->csi_dev) {
>  		const char *device_hid = "";
>  
> -#if IS_ENABLED(CONFIG_ACPI)
>  		device_hid = acpi_device_hid(sensor->ivsc_adev);
> -#endif
>  
>  		snprintf(sensor->ivsc_name, sizeof(sensor->ivsc_name), "%s-%u",
>  			 device_hid, sensor->link);
> @@ -671,11 +662,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
>  	struct acpi_device *adev = NULL;
>  	int ret;
>  
> -#if IS_ENABLED(CONFIG_ACPI)
>  	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
> -#else
> -	while (true) {
> -#endif
>  		if (!ACPI_PTR(adev->status.enabled))
>  			continue;

Heh, that's what I pointed on patch 1: you don't need it there, as this
will be handled on patch 2.

>  
> @@ -768,15 +755,10 @@ static int ipu_bridge_ivsc_is_ready(void)
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
> -#if IS_ENABLED(CONFIG_ACPI)
>  		const struct ipu_sensor_config *cfg =
>  			&ipu_supported_sensors[i];
>  
>  		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> -#else
> -		while (false) {
> -			sensor_adev = NULL;
> -#endif
>  			if (!ACPI_PTR(sensor_adev->status.enabled))
>  				continue;
>  
> 

Considering that you drop patch 1, and keep the ACPI dependencies
at the header, as proposed by patches 2-6:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kerenel.org>

Thanks,
Mauro

