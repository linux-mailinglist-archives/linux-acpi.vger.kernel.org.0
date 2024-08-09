Return-Path: <linux-acpi+bounces-7478-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7306694D603
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 20:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4521F23101
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 18:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118E4145B25;
	Fri,  9 Aug 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jE+kpbf7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15251474C3;
	Fri,  9 Aug 2024 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226972; cv=none; b=Fy1O26kSs9bpc2ofMv61s5vVGR1zKdgwRY1LyS8bD3I4zILW19/1DG955Wkc3wngy16xNDjKeUjebYR1woTqA+UabuRdF7E+RhU/3kDOtTLjm6n3IpitbuKJlDrY4DdUsWW/I8OV1MDUoNqyW2vz9WuJBfTF2+diNi1di7KXaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226972; c=relaxed/simple;
	bh=ykiUf1PxnHs6YxmofX+mh9eDhxtaEeF/qwNn5EbiLZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOSLm6G5t22a/mUhUqo8jnOYaQQ11uETfjSJnL9S5tdyS1WfmhqbHsocWgf4i5konX6LKkx/p0oJ0dsU1RoZJd9wMQfQWoHwjbzig0xOvWfe6Jx09CwBQlQlQMf3K84Djw3wLZ6xqfZqoaNPIh9sIuELJSPuaqVjEpY2bhnEBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jE+kpbf7; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso25597791fa.2;
        Fri, 09 Aug 2024 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723226968; x=1723831768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edty/vt1lEMQBqXy3/wtR2anZVOUTO4i++fb5AkrA4o=;
        b=jE+kpbf7YISBueZ0sxBnrdXkRw41dfr08Aeh4lpuK6ADZel9LnrQYLFX3KsRNKeseA
         Sgm12gkklvltzkjA2bRKGB3LU+ZUYXCtGZmlxwWekLm5y4zPretDnGb3uSsoTYtS5BW7
         Yw3ir9HiyCzHiD+mL7pLGCrDBQvOsg5HMfVbaD7Xcffg52oa7CARGWDc0t3MRGfE4dn4
         5UavWc4abW/BFrZCY/DkiU0wc28YMCAjzEdUdseUSP66/NnqIFCw6wD4sYAILjlMyJHZ
         logNjchhZAjqjPYqGWE4qsVTj6s0xyIK8g7MvNEXDTadWvGjMFpgANhu9Yjv7vFkYkX0
         Grpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723226968; x=1723831768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edty/vt1lEMQBqXy3/wtR2anZVOUTO4i++fb5AkrA4o=;
        b=qIb1XHcPEiApzbdKE+A7riiH0VAYPxyVDCdDu/vAY0OUjPCR37imQkFgh1M5Iwm+GO
         Jp9VNb2lNqMjovx3dRYdJQznV6H3AhrTkopMC4xJOSKWDV4iPP8YB0Cbrig6+RlE0lmV
         2hk68d7PWwewAqRo2LfB01j6H5qgK2sZm8La0mJOduZjRw3GXqXPFgIrmnwtZswGHrjF
         QPTRl4LRAT8smv1ypwaYZt1fz8djNw9c6fqsFUEVr5pJNuRjFcUhUc+c+fyPGl1vMWlG
         HY6L6mqhl7wy/mcfQJAHRDsrtQoAn80NIFH8o1m2oR/KPpK85PEXNjU9gDqN2OfIXrXG
         4pLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiE49eEDzB7t9BePmhLEJ+nA6I9fCHBIYlNPn90IUNj0AOlimCmPbHLa7OScaLYL9yBf5sH9dCSMMIGgBcL9Bk7LJkHW+loE/QT73FZQdT60C+Y4eD6+kWiDslSj3dgwkMr4fhq+NjJCm6c4YjsnR0Zv+yiVy0g3OzAfhZBAsT2lxvQcwy2wcqC80lbnuc1nqf+9mWaV94KJ5pnBJHcf2mknvk27OWOO4Lc4IG+ZpLMLg7UPmhKxc/kFvN2Y3yiPxpvT80mlKB
X-Gm-Message-State: AOJu0YyHoAFU2VWL+8BakwSs0pEpeDRPZyaw3lQDPRsPM7mef55bDSy4
	3Kw2O112dCfNAqIxZm12v4qCkszg53uxoA4LOfHTjrfeCnVy8IES
X-Google-Smtp-Source: AGHT+IGeBBY1qxJ8vW1zWM+TzExXYz6hpifGtVGuWH2pzxGoajoGQie0lv6P/Db75ytIbc5bBGYKTA==
X-Received: by 2002:a2e:97d8:0:b0:2ef:3126:390d with SMTP id 38308e7fff4ca-2f1a6cf4c85mr18412051fa.42.1723226967194;
        Fri, 09 Aug 2024 11:09:27 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c775c509sm1453185e9.44.2024.08.09.11.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 11:09:26 -0700 (PDT)
Message-ID: <9ee8eb9d-1e1c-439f-a382-c003fbd7259c@gmail.com>
Date: Fri, 9 Aug 2024 20:09:23 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] platform/surface: Add OF support
To: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>
References: <20240809-topic-sam-v1-0-05bca1932614@quicinc.com>
 <20240809-topic-sam-v1-3-05bca1932614@quicinc.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20240809-topic-sam-v1-3-05bca1932614@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thanks for taking this up! A couple of comments below:

On 8/9/24 3:48 AM, Konrad Dybcio wrote:
> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
> 
> Add basic support for registering the aggregator module on Device Tree-
> based platforms. These include at least three generations of Qualcomm
> Snapdragon-based Surface devices:
> 
> - SC8180X / SQ1 / SQ2: Pro X,
> - SC8280XP / SQ3: Devkit 2023, Pro 9
> - X Elite: Laptop 7 / Pro11
> 
> Thankfully, the aggregators on these seem to be configured in an
> identical way, which allows for using these settings as defaults and
> no DT properties need to be introduced (until that changes, anyway).
> 
> Based on the work done by Maximilian Luz, largely rewritten.
> 
> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
> ---
>   drivers/acpi/scan.c                                |  3 +-
>   drivers/platform/surface/aggregator/bus.c          |  2 +
>   drivers/platform/surface/aggregator/controller.c   | 72 +++++++++++++++----
>   drivers/platform/surface/aggregator/core.c         | 80 ++++++++++++++++++----
>   .../platform/surface/surface_aggregator_registry.c | 44 ++++++++++--
>   5 files changed, 167 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 59771412686b..6c3cad894648 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2444,7 +2444,8 @@ static int acpi_walk_dep_device_list(acpi_handle handle,
>    */
>   void acpi_dev_clear_dependencies(struct acpi_device *supplier)
>   {
> -	acpi_walk_dep_device_list(supplier->handle, acpi_scan_clear_dep, NULL);
> +	if (supplier)
> +		acpi_walk_dep_device_list(supplier->handle, acpi_scan_clear_dep, NULL);
>   }
>   EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
>   
> diff --git a/drivers/platform/surface/aggregator/bus.c b/drivers/platform/surface/aggregator/bus.c
> index af8d573aae93..d68d231e716e 100644
> --- a/drivers/platform/surface/aggregator/bus.c
> +++ b/drivers/platform/surface/aggregator/bus.c
> @@ -6,6 +6,7 @@
>    */
>   
>   #include <linux/device.h>
> +#include <linux/of.h>
>   #include <linux/property.h>
>   #include <linux/slab.h>
>   
> @@ -441,6 +442,7 @@ static int ssam_add_client_device(struct device *parent, struct ssam_controller
>   
>   	sdev->dev.parent = parent;
>   	sdev->dev.fwnode = fwnode_handle_get(node);
> +	sdev->dev.of_node = to_of_node(node);
>   
>   	status = ssam_device_add(sdev);
>   	if (status)
> diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
> index 7fc602e01487..aea10e192140 100644
> --- a/drivers/platform/surface/aggregator/controller.c
> +++ b/drivers/platform/surface/aggregator/controller.c
> @@ -1104,13 +1104,6 @@ int ssam_controller_caps_load_from_acpi(acpi_handle handle,
>   	u64 funcs;
>   	int status;
>   
> -	/* Set defaults. */
> -	caps->ssh_power_profile = U32_MAX;
> -	caps->screen_on_sleep_idle_timeout = U32_MAX;
> -	caps->screen_off_sleep_idle_timeout = U32_MAX;
> -	caps->d3_closes_handle = false;
> -	caps->ssh_buffer_size = U32_MAX;
> -
>   	/* Pre-load supported DSM functions. */
>   	status = ssam_dsm_get_functions(handle, &funcs);
>   	if (status)
> @@ -1149,6 +1142,57 @@ int ssam_controller_caps_load_from_acpi(acpi_handle handle,
>   	return 0;
>   }
>   
> +/**
> + * ssam_controller_caps_load_from_of() - Load controller capabilities from OF/DT.
> + * @device: The device from which to load the capabilities from.
> + * @caps:   Where to store the capabilities in.
> + *
> + * Return: Returns zero on success, a negative error code on failure.
> + */
> +static int ssam_controller_caps_load_from_of(struct device *dev, struct ssam_controller_caps *caps)
> +{
> +	/*
> +	 * Every device starting with Surface Pro X through Laptop 7 uses these
> +	 * identical values, which makes them good defaults.
> +	 */
> +	caps->d3_closes_handle = true;
> +	caps->screen_on_sleep_idle_timeout = 5000;
> +	caps->screen_off_sleep_idle_timeout = 30;
> +	caps->ssh_buffer_size = 48;
> +	/* TODO: figure out power profile */
> +
> +	return 0;
> +}
> +
> +/**
> + * ssam_controller_caps_load_from_acpi() - Load controller capabilities from
> + * ACPI _DSM.
> + * @handle: The handle of the ACPI controller/SSH device.
> + * @caps:   Where to store the capabilities in.
> + *
> + * Initializes the given controller capabilities with default values, then
> + * checks and, if the respective _DSM functions are available, loads the
> + * actual capabilities from the _DSM.
> + *
> + * Return: Returns zero on success, a negative error code on failure.
> + */

Doc needs updating, this is just the one copied from
ssam_controller_caps_load_acpi().

> +static int ssam_controller_caps_load(struct device *dev, struct ssam_controller_caps *caps)
> +{
> +	acpi_handle handle = ACPI_HANDLE(dev);
> +
> +	/* Set defaults. */
> +	caps->ssh_power_profile = U32_MAX;
> +	caps->screen_on_sleep_idle_timeout = U32_MAX;
> +	caps->screen_off_sleep_idle_timeout = U32_MAX;
> +	caps->d3_closes_handle = false;
> +	caps->ssh_buffer_size = U32_MAX;
> +
> +	if (handle)
> +		return ssam_controller_caps_load_from_acpi(handle, caps);
> +	else
> +		return ssam_controller_caps_load_from_of(dev, caps);
> +}
> +
>   /**
>    * ssam_controller_init() - Initialize SSAM controller.
>    * @ctrl:   The controller to initialize.
> @@ -1165,13 +1209,12 @@ int ssam_controller_caps_load_from_acpi(acpi_handle handle,
>   int ssam_controller_init(struct ssam_controller *ctrl,
>   			 struct serdev_device *serdev)
>   {
> -	acpi_handle handle = ACPI_HANDLE(&serdev->dev);
>   	int status;
>   
>   	init_rwsem(&ctrl->lock);
>   	kref_init(&ctrl->kref);
>   
> -	status = ssam_controller_caps_load_from_acpi(handle, &ctrl->caps);
> +	status = ssam_controller_caps_load(&serdev->dev, &ctrl->caps);
>   	if (status)
>   		return status;
>   
> @@ -2715,11 +2758,12 @@ int ssam_irq_setup(struct ssam_controller *ctrl)
>   	const int irqf = IRQF_ONESHOT | IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN;
>   
>   	gpiod = gpiod_get(dev, "ssam_wakeup-int", GPIOD_ASIS);
> -	if (IS_ERR(gpiod))
> -		return PTR_ERR(gpiod);
> -
> -	irq = gpiod_to_irq(gpiod);
> -	gpiod_put(gpiod);
> +	if (IS_ERR(gpiod)) {
> +		irq = fwnode_irq_get(dev_fwnode(dev), 0);
> +	} else {
> +		irq = gpiod_to_irq(gpiod);
> +		gpiod_put(gpiod);
> +	}
>   
>   	if (irq < 0)
>   		return irq;
> diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
> index 797d0645bd77..d39e0d7ce92b 100644
> --- a/drivers/platform/surface/aggregator/core.c
> +++ b/drivers/platform/surface/aggregator/core.c
> @@ -17,9 +17,12 @@
>   #include <linux/kernel.h>
>   #include <linux/kref.h>
>   #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>   #include <linux/pm.h>
>   #include <linux/serdev.h>
>   #include <linux/sysfs.h>
> +#include <linux/units.h>
>   
>   #include <linux/surface_aggregator/controller.h>
>   #include <linux/surface_aggregator/device.h>
> @@ -299,7 +302,7 @@ static const struct attribute_group ssam_sam_group = {
>   };
>   
>   
> -/* -- ACPI based device setup. ---------------------------------------------- */
> +/* -- Serial device setup. ---------------------------------------------- */

Nitpick, but could we maybe keep that at 80 columns please? :)

>   
>   static acpi_status ssam_serdev_setup_via_acpi_crs(struct acpi_resource *rsc,
>   						  void *ctx)
> @@ -352,13 +355,28 @@ static acpi_status ssam_serdev_setup_via_acpi_crs(struct acpi_resource *rsc,
>   	return AE_CTRL_TERMINATE;
>   }
>   
> -static acpi_status ssam_serdev_setup_via_acpi(acpi_handle handle,
> -					      struct serdev_device *serdev)
> +static int ssam_serdev_setup_via_acpi(struct serdev_device *serdev, acpi_handle handle)
>   {
> -	return acpi_walk_resources(handle, METHOD_NAME__CRS,
> -				   ssam_serdev_setup_via_acpi_crs, serdev);
> +	acpi_status status;
> +
> +	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> +				     ssam_serdev_setup_via_acpi_crs, serdev);
> +
> +	return status ? -ENXIO : 0;
>   }
>   
> +static int ssam_serdev_setup(struct acpi_device *ssh, struct serdev_device *serdev)
> +{
> +	if (ssh)
> +		return ssam_serdev_setup_via_acpi(serdev, ssh->handle);
> +
> +	/* TODO: these values may differ per board/implementation */
> +	serdev_device_set_baudrate(serdev, 4 * HZ_PER_MHZ);

Isn't this defined in the DT spec that you're adding as "current-speed"
in patch 2? Why not load it from there?

> +	serdev_device_set_flow_control(serdev, true);
> +	serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +
> +	return 0;
> +}
>   
>   /* -- Power management. ----------------------------------------------------- */
>   
> @@ -624,13 +642,15 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
>   	acpi_status astatus;

This can be removed, see below.

>   	int status;
>   
> -	status = gpiod_count(dev, NULL);
> -	if (status < 0)
> -		return dev_err_probe(dev, status, "no GPIO found\n");
> +	if (ssh) {
> +		status = gpiod_count(dev, NULL);
> +		if (status < 0)
> +			return dev_err_probe(dev, status, "no GPIO found\n");
>   
> -	status = devm_acpi_dev_add_driver_gpios(dev, ssam_acpi_gpios);
> -	if (status)
> -		return status;
> +		status = devm_acpi_dev_add_driver_gpios(dev, ssam_acpi_gpios);
> +		if (status)
> +			return status;
> +	}
>   
>   	/* Allocate controller. */
>   	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
> @@ -655,7 +675,7 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
>   		goto err_devopen;
>   	}
>   
> -	astatus = ssam_serdev_setup_via_acpi(ssh->handle, serdev);
> +	astatus = ssam_serdev_setup(ssh, serdev);>   	if (ACPI_FAILURE(astatus)) {

ssam_serdev_setup() returns an int, so this should now just use
"status".

>   		status = dev_err_probe(dev, -ENXIO, "failed to setup serdev\n");
>   		goto err_devinit;
> @@ -717,10 +737,31 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
>   	 *       For now let's thus default power/wakeup to false.
>   	 */
>   	device_set_wakeup_capable(dev, true);
> +
> +	/*
> +	 * When using DT, we have to register the platform hub driver manually,
> +	 * as it can't be matched based on top-level board compatible (like it
> +	 * does the ACPI case).
> +	 */
> +	if (!ssh) {
> +		struct platform_device *ph_pdev =
> +			platform_device_register_simple("surface_aggregator_platform_hub",
> +							0, NULL, 0);
> +		if (IS_ERR(ph_pdev))
> +			return dev_err_probe(dev, PTR_ERR(ph_pdev),
> +					     "Failed to register the platform hub driver\n");
> +	}
> +
> +	status = ssam_register_clients(&serdev->dev, ctrl);
> +	if (status)
> +		goto err_clients;

Is the ssam_register_clients() call required or is it a remnant from a
previous version? We're now not adding any children to the controller
itself but model ACPI and do all of that with the platform hub. So
unless I'm missing something, I think this should not be necessary.

> +
>   	acpi_dev_clear_dependencies(ssh);
>   
>   	return 0;
>   
> +err_clients:
> +	ssam_clear_controller();
>   err_mainref:
>   	ssam_irq_free(ctrl);
>   err_irq:
> @@ -782,18 +823,27 @@ static void ssam_serial_hub_remove(struct serdev_device *serdev)
>   	device_set_wakeup_capable(&serdev->dev, false);
>   }
>   
> -static const struct acpi_device_id ssam_serial_hub_match[] = {
> +static const struct acpi_device_id ssam_serial_hub_acpi_match[] = {
>   	{ "MSHW0084", 0 },
>   	{ },
>   };
> -MODULE_DEVICE_TABLE(acpi, ssam_serial_hub_match);
> +MODULE_DEVICE_TABLE(acpi, ssam_serial_hub_acpi_match);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id ssam_serial_hub_of_match[] = {
> +	{ .compatible = "microsoft,surface-sam", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ssam_serial_hub_of_match);
> +#endif
>   
>   static struct serdev_device_driver ssam_serial_hub = {
>   	.probe = ssam_serial_hub_probe,
>   	.remove = ssam_serial_hub_remove,
>   	.driver = {
>   		.name = "surface_serial_hub",
> -		.acpi_match_table = ssam_serial_hub_match,
> +		.acpi_match_table = ACPI_PTR(ssam_serial_hub_acpi_match),
> +		.of_match_table = of_match_ptr(ssam_serial_hub_of_match),
>   		.pm = &ssam_serial_hub_pm_ops,
>   		.shutdown = ssam_serial_hub_shutdown,
>   		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
> index 1c4d74db08c9..57787f2ff38b 100644
> --- a/drivers/platform/surface/surface_aggregator_registry.c
> +++ b/drivers/platform/surface/surface_aggregator_registry.c
> @@ -12,6 +12,7 @@
>   #include <linux/acpi.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> +#include <linux/of.h>
>   #include <linux/platform_device.h>
>   #include <linux/property.h>
>   #include <linux/types.h>
> @@ -273,6 +274,18 @@ static const struct software_node *ssam_node_group_sl5[] = {
>   	NULL,
>   };
>   
> +/* Devices for Surface Laptop 7. */
> +static const struct software_node *ssam_node_group_sl7[] = {
> +	&ssam_node_root,
> +	&ssam_node_bat_ac,
> +	&ssam_node_bat_main,
> +	&ssam_node_tmp_perf_profile_with_fan,
> +	&ssam_node_fan_speed,
> +	&ssam_node_hid_sam_keyboard,

Did you check if there are any other HID devices connected? In the past,
keyboard and touchpad have been split into two separate devices, so is
it a combo keyboard + touchpad device this time? Some models also had
HID-based sensor and other devices.

Would just be good to know if this can be assumed to be complete or if
we're maybe missing something here.

> +	/* TODO: evaluate thermal sensors devices when we get a driver for that */

FYI I've posted the driver at [1]. It needs a small Kbuild dependency
fix but apart from that I think it should be final, if you want to give
that a try.

[1]: https://lore.kernel.org/lkml/20240804230832.247852-1-luzmaximilian@gmail.com/T/

The rest looks fine. I'll try to find some time to update my SPX branch
this weekend and give it a spin.

Regards,
Max

> +	NULL,
> +};
> +
>   /* Devices for Surface Laptop Studio. */
>   static const struct software_node *ssam_node_group_sls[] = {
>   	&ssam_node_root,
> @@ -346,7 +359,7 @@ static const struct software_node *ssam_node_group_sp9[] = {
>   
>   /* -- SSAM platform/meta-hub driver. ---------------------------------------- */
>   
> -static const struct acpi_device_id ssam_platform_hub_match[] = {
> +static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
>   	/* Surface Pro 4, 5, and 6 (OMBR < 0x10) */
>   	{ "MSHW0081", (unsigned long)ssam_node_group_gen5 },
>   
> @@ -402,16 +415,39 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
>   };
>   MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_match);
>   
> +#ifdef CONFIG_OF
> +static const struct of_device_id ssam_platform_hub_of_match[] = {
> +	/* Surface Laptop 7 */
> +	{ .compatible = "microsoft,romulus13", (void *)ssam_node_group_sl7 },
> +	{ .compatible = "microsoft,romulus15", (void *)ssam_node_group_sl7 },
> +	{ },
> +};
> +#endif
> +
>   static int ssam_platform_hub_probe(struct platform_device *pdev)
>   {
>   	const struct software_node **nodes;
> +	const struct of_device_id *match;
> +	struct device_node *fdt_root;
>   	struct ssam_controller *ctrl;
>   	struct fwnode_handle *root;
>   	int status;
>   
>   	nodes = (const struct software_node **)acpi_device_get_match_data(&pdev->dev);
> -	if (!nodes)
> -		return -ENODEV;
> +	if (!nodes) {
> +		fdt_root = of_find_node_by_path("/");
> +		if (!fdt_root)
> +			return -ENODEV;
> +
> +		match = of_match_node(ssam_platform_hub_of_match, fdt_root);
> +		of_node_put(fdt_root);
> +		if (!match)
> +			return -ENODEV;
> +
> +		nodes = (const struct software_node **)match->data;
> +		if (!nodes)
> +			return -ENODEV;
> +	}
>   
>   	/*
>   	 * As we're adding the SSAM client devices as children under this device
> @@ -460,7 +496,7 @@ static struct platform_driver ssam_platform_hub_driver = {
>   	.remove_new = ssam_platform_hub_remove,
>   	.driver = {
>   		.name = "surface_aggregator_platform_hub",
> -		.acpi_match_table = ssam_platform_hub_match,
> +		.acpi_match_table = ssam_platform_hub_acpi_match,
>   		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>   	},
>   };
> 

