Return-Path: <linux-acpi+bounces-21270-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE7XFtIfo2mC9wQAu9opvQ
	(envelope-from <linux-acpi+bounces-21270-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 18:03:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E33D71C4A32
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 18:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 358C6306ED07
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0635314A65;
	Sat, 28 Feb 2026 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r8XegJz+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BC02DCF7D
	for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772298187; cv=none; b=hT45F/iJ7yIAcisqXDGvTsffUWy7+LeihA988CBqVKvRuBTHOhowe+CytZuDhE2OYO6o3mkboE/0S3bUSBXkV/O9u74WeYiceiS/LmkBCscP1eLQ1XBqHBUWgE4OD9tzMabCwxgOf9X63mbYxAGPWeEKNerRXu35Y5vZIiT67es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772298187; c=relaxed/simple;
	bh=W2ivtqgSvYl6O9GC8jcQpYr/C35vTtsZVV84fjMlNrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8zkutE3DJI6sx7V1RhsohpaYuF3uq9/aTuh4vVq4r8BaqjHnHmYVuuxukkIJpo8XVz6DxA3yOF2aOdfQAAT2yEoa3u5Li6NpHwskqmkoO/8VpFvFnWSlObqyIXjJ7KdMQDxUl7AoPBMftSUvT04j1/FOzZZRrkFnGFLssCsN8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r8XegJz+; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3a0b70c-20cb-4c7a-837a-79a5f756d017@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772298183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVa8oI26MsMths2jZ1djxGZ3vD/49tlmAMnTSAipkLU=;
	b=r8XegJz+OLP9je6uX7PG3WJYYU8LsBo+930nsGYD6p4m4ZW9TdYWd+6MoRVusRCBFq58k/
	SkEHcsojgQL/QrZIZgwxMsko8l+N/Ubv1F2w1uHL/R3HDP+mA2VOHUMvRqh4C/s6jq4K9J
	FgocOPwX6egJx92NWrfW77eiR2ZKpMg=
Date: Sat, 28 Feb 2026 18:02:46 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 4/4] platform/x86: asus-wireless: Convert ACPI driver
 to a platform one
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
References: <5971620.DvuYhMxLoT@rafael.j.wysocki>
 <13959361.uLZWGnKmhe@rafael.j.wysocki>
Content-Language: en-US, it-IT, en-US-large
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <13959361.uLZWGnKmhe@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,ljones.dev];
	TAGGED_FROM(0.00)[bounces-21270-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[denis.benato@linux.dev,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: E33D71C4A32
X-Rspamd-Action: no action


On 2/28/26 16:12, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
>
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the Asus wireless ACPI driver to a platform
> one.
>
> After this change, the subordinate input and LED devices will be
> registered under the platform device used for driver binding instead of
> its ACPI companion.
>
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
>
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/platform/x86/asus-wireless.c | 39 +++++++++++++++-------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
> index 45d41875c515..2b494bf3cba8 100644
> --- a/drivers/platform/x86/asus-wireless.c
> +++ b/drivers/platform/x86/asus-wireless.c
> @@ -12,6 +12,7 @@
>  #include <linux/acpi.h>
>  #include <linux/input.h>
>  #include <linux/pci_ids.h>
> +#include <linux/platform_device.h>
>  #include <linux/leds.h>
>  
>  struct hswc_params {
> @@ -124,19 +125,22 @@ static void asus_wireless_notify(acpi_handle handle, u32 event, void *context)
>  	input_sync(data->idev);
>  }
>  
> -static int asus_wireless_add(struct acpi_device *adev)
> +static int asus_wireless_probe(struct platform_device *pdev)
>  {
> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>  	struct asus_wireless_data *data;
>  	const struct acpi_device_id *id;
>  	int err;
>  
> -	data = devm_kzalloc(&adev->dev, sizeof(*data), GFP_KERNEL);
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> -	adev->driver_data = data;
> +
> +	platform_set_drvdata(pdev, data);
> +
>  	data->adev = adev;
>  
> -	data->idev = devm_input_allocate_device(&adev->dev);
> +	data->idev = devm_input_allocate_device(&pdev->dev);
>  	if (!data->idev)
>  		return -ENOMEM;
>  	data->idev->name = "Asus Wireless Radio Control";
> @@ -165,14 +169,14 @@ static int asus_wireless_add(struct acpi_device *adev)
>  	data->led.flags = LED_CORE_SUSPENDRESUME;
>  	data->led.max_brightness = 1;
>  	data->led.default_trigger = "rfkill-none";
> -	err = devm_led_classdev_register(&adev->dev, &data->led);
> +	err = devm_led_classdev_register(&pdev->dev, &data->led);
>  	if (err)
>  		goto err;
>  
>  	err = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
>  					      asus_wireless_notify, data);
>  	if (err) {
> -		devm_led_classdev_unregister(&adev->dev, &data->led);
> +		devm_led_classdev_unregister(&pdev->dev, &data->led);
>  		goto err;
>  	}
>  	return 0;
> @@ -182,28 +186,27 @@ static int asus_wireless_add(struct acpi_device *adev)
>  	return err;
>  }
>  
> -static void asus_wireless_remove(struct acpi_device *adev)
> +static void asus_wireless_remove(struct platform_device *pdev)
>  {
> -	struct asus_wireless_data *data = acpi_driver_data(adev);
> +	struct asus_wireless_data *data = platform_get_drvdata(pdev);
>  
> -	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
> +	acpi_dev_remove_notify_handler(data->adev, ACPI_DEVICE_NOTIFY,
>  				       asus_wireless_notify);
>  	if (data->wq) {
> -		devm_led_classdev_unregister(&adev->dev, &data->led);
> +		devm_led_classdev_unregister(&pdev->dev, &data->led);
>  		destroy_workqueue(data->wq);
>  	}
>  }
>  
> -static struct acpi_driver asus_wireless_driver = {
> -	.name = "Asus Wireless Radio Control Driver",
> -	.class = "hotkey",
> -	.ids = device_ids,
> -	.ops = {
> -		.add = asus_wireless_add,
> -		.remove = asus_wireless_remove,
> +static struct platform_driver asus_wireless_driver = {
> +	.probe = asus_wireless_probe,
> +	.remove = asus_wireless_remove,
> +	.driver = {
> +		.name = "Asus Wireless Radio Control Driver",
> +		.acpi_match_table = device_ids,
>  	},
>  };
> -module_acpi_driver(asus_wireless_driver);
> +module_platform_driver(asus_wireless_driver);
>  
>  MODULE_DESCRIPTION("Asus Wireless Radio Control Driver");
>  MODULE_AUTHOR("João Paulo Rechi Vita <jprvita@gmail.com>");

