Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F8E4A8288
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Feb 2022 11:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiBCKkD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Feb 2022 05:40:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229946AbiBCKkD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Feb 2022 05:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643884802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwHzozB1NnnUlG3K+Rs3ixs2CDHUV67xhx8QDRDqiE0=;
        b=P5V1ifhE2/j9+12+p1veMnzeW/4liOxPZ4m5AWxVKwpMl4bHCNRvLc9bONAULTmx7xNUe/
        k2pqJTk0K24d/TuQUIBimIp52cVd+KpwxGS0xiESyZydXwAk47QUyvJeI9ufZdrEMhutQh
        OzOB2+ZJ1Ar+QjClU1E9n05WvyPGsnA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-_Y6q61vfNHS7PSvwBiUeVA-1; Thu, 03 Feb 2022 05:40:01 -0500
X-MC-Unique: _Y6q61vfNHS7PSvwBiUeVA-1
Received: by mail-ej1-f70.google.com with SMTP id lb14-20020a170907784e00b006aa178894fcso993043ejc.6
        for <linux-acpi@vger.kernel.org>; Thu, 03 Feb 2022 02:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cwHzozB1NnnUlG3K+Rs3ixs2CDHUV67xhx8QDRDqiE0=;
        b=csptujhPhwpWBr1uH+FLTOeQztbbkehq4qE6Z5N4s0ihvrhntW27Mvv93YMV3mBfNU
         tfyA6qBQZRxG6eXHLORsjvF8hPFrkGxAfranSoxSh+BSK3EprlbaNhoBfj1f8R3kEnCq
         kRJ+dVNdlPqQXJvwNzjdt0dmp/g+oTxpxHzwJXez4JjS1oqe8C7gXIfAWv/a8Gv7OeKI
         cLnNB6ZjT+Dc2wNkklRcSHBw7sLrdvUsdaUBPNgCJGrgIH/xXSg1PSZqoau2mOtMm188
         mm54wq3t8uBRAR8DNMcvOMPj/i6f0JrLrH/DBnQML8RbuCSCWWMfpofsxSDMdkDzD4HR
         uTcA==
X-Gm-Message-State: AOAM532CIoWSAFccoZCigeJvMfcOTxDJR7kIocozS74yvBpoV6BtL3ru
        /ihXzq/9cEX0tbaeFXsmhMdWxOWpcHz/33Ls2qTIJ5QjMQDpV1newgP/cqW9vnCLwjg6kZDkOMq
        cGMAobR7Za0yMfRLUaWmQPg==
X-Received: by 2002:a17:906:538d:: with SMTP id g13mr23496286ejo.276.1643884800218;
        Thu, 03 Feb 2022 02:40:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5tIb6LTSWF6doY2l2qSZQM9680Sau/5KeZQT0MzHt3FHeW9NEqCo5vOluSgvoZajKG8m4lg==
X-Received: by 2002:a17:906:538d:: with SMTP id g13mr23496273ejo.276.1643884800028;
        Thu, 03 Feb 2022 02:40:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id q5sm9025564ejc.115.2022.02.03.02.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 02:39:58 -0800 (PST)
Message-ID: <7350e94c-9df9-d195-193a-534a86ae3074@redhat.com>
Date:   Thu, 3 Feb 2022 11:39:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] platform: x86: Replace acpi_bus_get_device()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
References: <2631712.mvXUDI8C0e@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2631712.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/26/22 20:38, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/intel/hid.c              |    7 ++-----
>  drivers/platform/x86/intel/int3472/discrete.c |    5 ++---
>  drivers/platform/x86/intel/vbtn.c             |    7 ++-----
>  drivers/platform/x86/thinkpad_acpi.c          |   17 ++++++++---------
>  drivers/platform/x86/x86-android-tablets.c    |    2 +-
>  5 files changed, 15 insertions(+), 23 deletions(-)
> 
> Index: linux-pm/drivers/platform/x86/intel/vbtn.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/intel/vbtn.c
> +++ linux-pm/drivers/platform/x86/intel/vbtn.c
> @@ -384,12 +384,9 @@ static acpi_status __init
>  check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
>  {
>  	const struct acpi_device_id *ids = context;
> -	struct acpi_device *dev;
> +	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
>  
> -	if (acpi_bus_get_device(handle, &dev) != 0)
> -		return AE_OK;
> -
> -	if (acpi_match_device_ids(dev, ids) == 0)
> +	if (dev && acpi_match_device_ids(dev, ids) == 0)
>  		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
>  			dev_info(&dev->dev,
>  				 "intel-vbtn: created platform device\n");
> Index: linux-pm/drivers/platform/x86/intel/hid.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/intel/hid.c
> +++ linux-pm/drivers/platform/x86/intel/hid.c
> @@ -726,12 +726,9 @@ static acpi_status __init
>  check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
>  {
>  	const struct acpi_device_id *ids = context;
> -	struct acpi_device *dev;
> +	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
>  
> -	if (acpi_bus_get_device(handle, &dev) != 0)
> -		return AE_OK;
> -
> -	if (acpi_match_device_ids(dev, ids) == 0)
> +	if (dev && acpi_match_device_ids(dev, ids) == 0)
>  		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
>  			dev_info(&dev->dev,
>  				 "intel-hid: created platform device\n");
> Index: linux-pm/drivers/platform/x86/thinkpad_acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/thinkpad_acpi.c
> +++ linux-pm/drivers/platform/x86/thinkpad_acpi.c
> @@ -728,11 +728,10 @@ static void __init drv_acpi_handle_init(
>  static acpi_status __init tpacpi_acpi_handle_locate_callback(acpi_handle handle,
>  			u32 level, void *context, void **return_value)
>  {
> -	struct acpi_device *dev;
>  	if (!strcmp(context, "video")) {
> -		if (acpi_bus_get_device(handle, &dev))
> -			return AE_OK;
> -		if (strcmp(ACPI_VIDEO_HID, acpi_device_hid(dev)))
> +		struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
> +
> +		if (!dev || strcmp(ACPI_VIDEO_HID, acpi_device_hid(dev)))
>  			return AE_OK;
>  	}
>  
> @@ -786,7 +785,6 @@ static void dispatch_acpi_notify(acpi_ha
>  static int __init setup_acpi_notify(struct ibm_struct *ibm)
>  {
>  	acpi_status status;
> -	int rc;
>  
>  	BUG_ON(!ibm->acpi);
>  
> @@ -796,9 +794,9 @@ static int __init setup_acpi_notify(stru
>  	vdbg_printk(TPACPI_DBG_INIT,
>  		"setting up ACPI notify for %s\n", ibm->name);
>  
> -	rc = acpi_bus_get_device(*ibm->acpi->handle, &ibm->acpi->device);
> -	if (rc < 0) {
> -		pr_err("acpi_bus_get_device(%s) failed: %d\n", ibm->name, rc);
> +	ibm->acpi->device = acpi_fetch_acpi_dev(*ibm->acpi->handle);
> +	if (!ibm->acpi->device) {
> +		pr_err("acpi_fetch_acpi_dev(%s) failed\n", ibm->name);
>  		return -ENODEV;
>  	}
>  
> @@ -6723,7 +6721,8 @@ static int __init tpacpi_query_bcl_level
>  	struct acpi_device *device, *child;
>  	int rc;
>  
> -	if (acpi_bus_get_device(handle, &device))
> +	device = acpi_fetch_acpi_dev(handle);
> +	if (!device)
>  		return 0;
>  
>  	rc = 0;
> Index: linux-pm/drivers/platform/x86/intel/int3472/discrete.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/intel/int3472/discrete.c
> +++ linux-pm/drivers/platform/x86/intel/int3472/discrete.c
> @@ -112,7 +112,6 @@ static int skl_int3472_map_gpio_to_senso
>  	struct acpi_device *adev;
>  	acpi_handle handle;
>  	acpi_status status;
> -	int ret;
>  
>  	if (int3472->n_sensor_gpios >= INT3472_MAX_SENSOR_GPIOS) {
>  		dev_warn(int3472->dev, "Too many GPIOs mapped\n");
> @@ -139,8 +138,8 @@ static int skl_int3472_map_gpio_to_senso
>  	if (ACPI_FAILURE(status))
>  		return -EINVAL;
>  
> -	ret = acpi_bus_get_device(handle, &adev);
> -	if (ret)
> +	adev = acpi_fetch_acpi_dev(handle);
> +	if (!adev)
>  		return -ENODEV;
>  
>  	table_entry = &int3472->gpios.table[int3472->n_sensor_gpios];
> Index: linux-pm/drivers/platform/x86/x86-android-tablets.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/x86-android-tablets.c
> +++ linux-pm/drivers/platform/x86/x86-android-tablets.c
> @@ -104,7 +104,7 @@ static int x86_acpi_irq_helper_get(const
>  			return -ENODEV;
>  		}
>  
> -		acpi_bus_get_device(handle, &adev);
> +		adev = acpi_fetch_acpi_dev(handle);
>  		if (!adev) {
>  			pr_err("error could not get %s adev\n", data->chip);
>  			return -ENODEV;
> 
> 
> 

