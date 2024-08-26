Return-Path: <linux-acpi+bounces-7835-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2896495FB06
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 22:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBBE1F23DEC
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 20:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5739D19B5A3;
	Mon, 26 Aug 2024 20:54:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BFE19B3F9
	for <linux-acpi@vger.kernel.org>; Mon, 26 Aug 2024 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705682; cv=none; b=IjV75LP1tOSKk+UrT12mniHU6x/L+ov9RwKx3hSrfchPpO5PxqVm5MMQ3Hz3IHuDipTnFejRFZpGIlVaoeR/T0oxu2kboGcY/wvyhhBWXEFb3vDaS5amwwHLjNOimia3yR3gs6yv29lZkyaSqDyo66na787YuY8p5u6XAZrIFfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705682; c=relaxed/simple;
	bh=RScS6JX1p2kQvmdylx0oNq4D8ts4lhGgewqBfc9VKAU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJUPOZEuwesWDyQSEAC40ba7j6BJwZrHAcCIiQ9UWp7aLzE1KiixHziUlylGeupN5uJ03QWS6jfNrI55gm3SyXFQLW/7IylLHPag34xgPFBfctFEMrpcGBE/itLEM27pD4nn14cwHjhk7pJgDlFbqtOfqagT+QFdkeaCsFlMlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 67e17af0-63ed-11ef-8ec2-005056bdf889;
	Mon, 26 Aug 2024 23:54:37 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Aug 2024 23:54:37 +0300
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>
Subject: Re: [PATCH v3 3/3] platform/surface: Add OF support
Message-ID: <ZszrjQChQ2aS5YjV@surfacebook.localdomain>
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
 <20240814-topic-sam-v3-3-a84588aad233@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-topic-sam-v3-3-a84588aad233@quicinc.com>

Wed, Aug 14, 2024 at 12:27:27PM +0200, Konrad Dybcio kirjoitti:
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

...

>  	sdev->dev.fwnode = fwnode_handle_get(node);
> +	sdev->dev.of_node = to_of_node(node);

Please, use device_set_node() instead of those two.

...

> +static int ssam_controller_caps_load(struct device *dev, struct ssam_controller_caps *caps)
> +{

> +	acpi_handle handle = ACPI_HANDLE(dev);

It's a bit non-standard way to check if we run on DT or ACPI. The others (most
of them?) do something like this:

	struct fwnode_handle *fwnode = dev_fwnode(...);

	if (is_of_node(fwnode))
		return X;
	if (is_acpi_node(fwnode)) // also more precise _device or _data variant
		return Y;

	return ERROR;

> +	/* Set defaults. */
> +	caps->ssh_power_profile = U32_MAX;
> +	caps->screen_on_sleep_idle_timeout = U32_MAX;
> +	caps->screen_off_sleep_idle_timeout = U32_MAX;
> +	caps->d3_closes_handle = false;
> +	caps->ssh_buffer_size = U32_MAX;
> +
> +	if (handle)
> +		return ssam_controller_caps_load_from_acpi(handle, caps);

Yeah, I see that you use handle here, that's why it's up to you how to proceed
with that. 

> +	else
> +		return ssam_controller_caps_load_from_of(dev, caps);

But just note that we have 4 options for fwnode type here and this covers 3 and
I don't know if you ever have an ACPI data node or software node and what you
want to do with that.

> +}

...

>  	gpiod = gpiod_get(dev, "ssam_wakeup-int", GPIOD_ASIS);
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

Can't you try fwnode_irq_get_byname() followed by fwnode_irq_get()? And why do
you need unnamed variant to begin with? As far as I understand it's pure DT and
names are there, no?

...

>  #include <linux/kernel.h>
>  #include <linux/kref.h>
>  #include <linux/module.h>
> +#include <linux/of.h>

I do not see how you use this. You probably missed mod_devicetable.h.

> +#include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/serdev.h>
>  #include <linux/sysfs.h>

...

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
> +	if (ssh)

Simply 'else' ? And making condition positive?

...

> -static const struct acpi_device_id ssam_serial_hub_match[] = {
> +static const struct acpi_device_id ssam_serial_hub_acpi_match[] = {
>  	{ "MSHW0084", 0 },
>  	{ },

At some point, please drop that 0 part above and the comma in the terminator
entry.

>  };
> -MODULE_DEVICE_TABLE(acpi, ssam_serial_hub_match);
> +MODULE_DEVICE_TABLE(acpi, ssam_serial_hub_acpi_match);

Do you really need this renaming?

...

> +#ifdef CONFIG_OF
> +static const struct of_device_id ssam_serial_hub_of_match[] = {
> +	{ .compatible = "microsoft,surface-sam", },

No inner comma.

> +	{ },

No comma for the terminator.

> +};
> +MODULE_DEVICE_TABLE(of, ssam_serial_hub_of_match);
> +#endif
>  
>  static struct serdev_device_driver ssam_serial_hub = {
>  	.probe = ssam_serial_hub_probe,
>  	.remove = ssam_serial_hub_remove,
>  	.driver = {
>  		.name = "surface_serial_hub",
> -		.acpi_match_table = ssam_serial_hub_match,
> +		.acpi_match_table = ACPI_PTR(ssam_serial_hub_acpi_match),

No, please do not use ACPI_PTR(), it's more harmful than helpful.

> +		.of_match_table = of_match_ptr(ssam_serial_hub_of_match),

There is ongoing task to drop of_match_ptr(), so for ACPI_PTR().

>  		.pm = &ssam_serial_hub_pm_ops,
>  		.shutdown = ssam_serial_hub_shutdown,
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,

...

> --- a/drivers/platform/surface/surface3_power.c
> +++ b/drivers/platform/surface/surface3_power.c
> @@ -479,6 +479,7 @@ static int mshw0011_install_space_handler(struct i2c_client *client)
>  	}
>  
>  	acpi_dev_clear_dependencies(adev);
> +
>  	return 0;
>  }

Stray change.

...

> +/* Devices for Surface Laptop 7. */
> +static const struct software_node *ssam_node_group_sl7[] = {
> +	&ssam_node_root,
> +	&ssam_node_bat_ac,
> +	&ssam_node_bat_main,
> +	&ssam_node_tmp_perf_profile_with_fan,
> +	&ssam_node_fan_speed,
> +	&ssam_node_hid_sam_keyboard,
> +	/* TODO: evaluate thermal sensors devices when we get a driver for that */
> +	NULL,

At some point please drop commas at the terminator entries. This will make code
more robust against quite unlikely but potential rebase-like mistakes (when a
new entry is added behind the terminator).

> +};

...

> -static const struct acpi_device_id ssam_platform_hub_match[] = {
> +static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
>  	/* Surface Pro 4, 5, and 6 (OMBR < 0x10) */
>  	{ "MSHW0081", (unsigned long)ssam_node_group_gen5 },
>  
> @@ -400,18 +413,41 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
>  
>  	{ },
>  };
> -MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_match);
> +MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_acpi_match);

If renaming is needed, it can be done in a separate patch.

> +#ifdef CONFIG_OF
> +static const struct of_device_id ssam_platform_hub_of_match[] = {
> +	/* Surface Laptop 7 */
> +	{ .compatible = "microsoft,romulus13", (void *)ssam_node_group_sl7 },
> +	{ .compatible = "microsoft,romulus15", (void *)ssam_node_group_sl7 },
> +	{ },
> +};
> +#endif

As per above.

...

>  static int ssam_platform_hub_probe(struct platform_device *pdev)
>  {
>  	const struct software_node **nodes;
> +	const struct of_device_id *match;
> +	struct device_node *fdt_root;
>  	struct ssam_controller *ctrl;
>  	struct fwnode_handle *root;
>  	int status;
>  
>  	nodes = (const struct software_node **)acpi_device_get_match_data(&pdev->dev);

Hmm... Why this doesn't use simple device_get_match_data()?

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

This is quite strange! Where are they being defined?

> +		if (!nodes)
> +			return -ENODEV;
> +	}

...

> +MODULE_ALIAS("platform:surface_aggregator_platform_hub");

Can it be platfrom device ID table instead? But do you really need it?

-- 
With Best Regards,
Andy Shevchenko



