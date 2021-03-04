Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696FD32D186
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 12:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhCDLD1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 06:03:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30134 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239355AbhCDLDP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2021 06:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614855709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfdhuAvLC6NBQL+gULxY8Cmi6ZuNoIkOlN3h1b842EI=;
        b=RG+mYUxGoH+PlNnWk6TWbHOGtGNPSM3eVskwN0WDNZr4MvMgazq5Eafc37Z2ohGMyUizNH
        SKF3y/Mexs3XBGKmx0yitv+y+TpsCIscAdReTlz6ePQmkdb1TeXi5ncg1zh/8bo4RPJ4kQ
        Vd4cVA5jkWKW8XXoPv1kxT3koNeThP0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-3DINAQEcOi6iT5Lgcr58GA-1; Thu, 04 Mar 2021 06:01:46 -0500
X-MC-Unique: 3DINAQEcOi6iT5Lgcr58GA-1
Received: by mail-ed1-f70.google.com with SMTP id i19so11490648edy.18
        for <linux-acpi@vger.kernel.org>; Thu, 04 Mar 2021 03:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lfdhuAvLC6NBQL+gULxY8Cmi6ZuNoIkOlN3h1b842EI=;
        b=BeHupS0gSEp6+EA5QrdKl2AL0+wv8hSnkcJNL5ca7ZNQJW8JyBcb9AplGWSAKqr64Y
         rOg6w7l6SRCX3G6ObYWzt4mpfCApiVW9/Loit5NE1XRjHSwiZhQlFy54Kftz/IZI2xGm
         R2c5bltHn/FmykeB/2oilAFhIDJcyhRi8rpmTyEcvwFxm1G/t/GqXqOePHvmAbDF9pvs
         +hicJnX9RqjjtvchhInfk0CIH7OZBhr1XJg33p8WGTy55wrMtZCFjMwAgDi+en/lSWU2
         prYAOOEL20eGKVBonNycR5IcVghTqb5lbYfdRgBE/+Hv8qFyaPJOUQ5gEwjoj2fNI4z+
         eQTQ==
X-Gm-Message-State: AOAM532ZYQznbk51N/hwomLyCI1Unp8WXlf26NUCWyhHl0CS3F90lLjW
        Hy2TIY2tnHV0Ys96uRZtKvC7sTj0E8wL9VmHO1rS0hXwCbd03aXlxHRc0tbRX6FWs9eovN5jph3
        W5oi3IEUpRm0TNIBIzZl6fw==
X-Received: by 2002:a17:907:d0b:: with SMTP id gn11mr3594107ejc.463.1614855704679;
        Thu, 04 Mar 2021 03:01:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzm3UcJSCxHQa+zc/fqYBtX3TqcFpzTPvHN0CrZW1rGVOBXYhd7hRHpqf3awwi4s7s6y+Mm/w==
X-Received: by 2002:a17:907:d0b:: with SMTP id gn11mr3594075ejc.463.1614855704427;
        Thu, 04 Mar 2021 03:01:44 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g1sm20330650edh.31.2021.03.04.03.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 03:01:43 -0800 (PST)
Subject: Re: [PATCH v2 4/4] platform/surface: Add platform profile driver
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mark Gross <mgross@linux.intel.com>, Len Brown <lenb@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210211201703.658240-1-luzmaximilian@gmail.com>
 <20210211201703.658240-5-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b075f6f6-a947-2847-1488-762584ca3bb6@redhat.com>
Date:   Thu, 4 Mar 2021 12:01:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210211201703.658240-5-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/11/21 9:17 PM, Maximilian Luz wrote:
> Add a driver to provide platform profile support on 5th- and later
> generation Microsoft Surface devices with a Surface System Aggregator
> Module. On those devices, the platform profile can be used to influence
> cooling behavior and power consumption.
> 
> For example, the default 'quiet' profile limits fan noise and in turn
> sacrifices performance of the discrete GPU found on Surface Books. Its
> full performance can only be unlocked on the 'performance' profile.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

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
>  MAINTAINERS                                   |   6 +
>  drivers/platform/surface/Kconfig              |  22 ++
>  drivers/platform/surface/Makefile             |   1 +
>  .../surface/surface_platform_profile.c        | 190 ++++++++++++++++++
>  4 files changed, 219 insertions(+)
>  create mode 100644 drivers/platform/surface/surface_platform_profile.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 000a82f59c76..a08d65f8f0df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11811,6 +11811,12 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	drivers/platform/surface/surface_hotplug.c
>  
> +MICROSOFT SURFACE PLATFORM PROFILE DRIVER
> +M:	Maximilian Luz <luzmaximilian@gmail.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/surface/surface_platform_profile.c
> +
>  MICROSOFT SURFACE PRO 3 BUTTON DRIVER
>  M:	Chen Yu <yu.c.chen@intel.com>
>  L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
> index 179b8c93d7fd..a045425026ae 100644
> --- a/drivers/platform/surface/Kconfig
> +++ b/drivers/platform/surface/Kconfig
> @@ -132,6 +132,28 @@ config SURFACE_HOTPLUG
>  	  Select M or Y here, if you want to (fully) support hot-plugging of
>  	  dGPU devices on the Surface Book 2 and/or 3 during D3cold.
>  
> +config SURFACE_PLATFORM_PROFILE
> +	tristate "Surface Platform Profile Driver"
> +	depends on SURFACE_AGGREGATOR_REGISTRY
> +	select ACPI_PLATFORM_PROFILE
> +	help
> +	  Provides support for the ACPI platform profile on 5th- and later
> +	  generation Microsoft Surface devices.
> +
> +	  More specifically, this driver provides ACPI platform profile support
> +	  on Microsoft Surface devices with a Surface System Aggregator Module
> +	  (SSAM) connected via the Surface Serial Hub (SSH / SAM-over-SSH). In
> +	  other words, this driver provides platform profile support on the
> +	  Surface Pro 5, Surface Book 2, Surface Laptop, Surface Laptop Go and
> +	  later. On those devices, the platform profile can significantly
> +	  influence cooling behavior, e.g. setting it to 'quiet' (default) or
> +	  'low-power' can significantly limit performance of the discrete GPU on
> +	  Surface Books, while in turn leading to lower power consumption and/or
> +	  less fan noise.
> +
> +	  Select M or Y here, if you want to include ACPI platform profile
> +	  support on the above mentioned devices.
> +
>  config SURFACE_PRO3_BUTTON
>  	tristate "Power/home/volume buttons driver for Microsoft Surface Pro 3/4 tablet"
>  	depends on INPUT
> diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
> index 80035ee540bf..99372c427b73 100644
> --- a/drivers/platform/surface/Makefile
> +++ b/drivers/platform/surface/Makefile
> @@ -13,4 +13,5 @@ obj-$(CONFIG_SURFACE_AGGREGATOR_CDEV)	+= surface_aggregator_cdev.o
>  obj-$(CONFIG_SURFACE_AGGREGATOR_REGISTRY) += surface_aggregator_registry.o
>  obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
>  obj-$(CONFIG_SURFACE_HOTPLUG)		+= surface_hotplug.o
> +obj-$(CONFIG_SURFACE_PLATFORM_PROFILE)	+= surface_platform_profile.o
>  obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> new file mode 100644
> index 000000000000..0081b01a5b0f
> --- /dev/null
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Surface Platform Profile / Performance Mode driver for Surface System
> + * Aggregator Module (thermal subsystem).
> + *
> + * Copyright (C) 2021 Maximilian Luz <luzmaximilian@gmail.com>
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_profile.h>
> +#include <linux/types.h>
> +
> +#include <linux/surface_aggregator/device.h>
> +
> +enum ssam_tmp_profile {
> +	SSAM_TMP_PROFILE_NORMAL             = 1,
> +	SSAM_TMP_PROFILE_BATTERY_SAVER      = 2,
> +	SSAM_TMP_PROFILE_BETTER_PERFORMANCE = 3,
> +	SSAM_TMP_PROFILE_BEST_PERFORMANCE   = 4,
> +};
> +
> +struct ssam_tmp_profile_info {
> +	__le32 profile;
> +	__le16 unknown1;
> +	__le16 unknown2;
> +} __packed;
> +
> +struct ssam_tmp_profile_device {
> +	struct ssam_device *sdev;
> +	struct platform_profile_handler handler;
> +};
> +
> +static SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_tmp_profile_get, struct ssam_tmp_profile_info, {
> +	.target_category = SSAM_SSH_TC_TMP,
> +	.command_id      = 0x02,
> +});
> +
> +static SSAM_DEFINE_SYNC_REQUEST_CL_W(__ssam_tmp_profile_set, __le32, {
> +	.target_category = SSAM_SSH_TC_TMP,
> +	.command_id      = 0x03,
> +});
> +
> +static int ssam_tmp_profile_get(struct ssam_device *sdev, enum ssam_tmp_profile *p)
> +{
> +	struct ssam_tmp_profile_info info;
> +	int status;
> +
> +	status = ssam_retry(__ssam_tmp_profile_get, sdev, &info);
> +	if (status < 0)
> +		return status;
> +
> +	*p = le32_to_cpu(info.profile);
> +	return 0;
> +}
> +
> +static int ssam_tmp_profile_set(struct ssam_device *sdev, enum ssam_tmp_profile p)
> +{
> +	__le32 profile_le = cpu_to_le32(p);
> +
> +	return ssam_retry(__ssam_tmp_profile_set, sdev, &profile_le);
> +}
> +
> +static int convert_ssam_to_profile(struct ssam_device *sdev, enum ssam_tmp_profile p)
> +{
> +	switch (p) {
> +	case SSAM_TMP_PROFILE_NORMAL:
> +		return PLATFORM_PROFILE_BALANCED;
> +
> +	case SSAM_TMP_PROFILE_BATTERY_SAVER:
> +		return PLATFORM_PROFILE_LOW_POWER;
> +
> +	case SSAM_TMP_PROFILE_BETTER_PERFORMANCE:
> +		return PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> +
> +	case SSAM_TMP_PROFILE_BEST_PERFORMANCE:
> +		return PLATFORM_PROFILE_PERFORMANCE;
> +
> +	default:
> +		dev_err(&sdev->dev, "invalid performance profile: %d", p);
> +		return -EINVAL;
> +	}
> +}
> +
> +static int convert_profile_to_ssam(struct ssam_device *sdev, enum platform_profile_option p)
> +{
> +	switch (p) {
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		return SSAM_TMP_PROFILE_BATTERY_SAVER;
> +
> +	case PLATFORM_PROFILE_BALANCED:
> +		return SSAM_TMP_PROFILE_NORMAL;
> +
> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> +		return SSAM_TMP_PROFILE_BETTER_PERFORMANCE;
> +
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		return SSAM_TMP_PROFILE_BEST_PERFORMANCE;
> +
> +	default:
> +		/* This should have already been caught by platform_profile_store(). */
> +		WARN(true, "unsupported platform profile");
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
> +				     enum platform_profile_option *profile)
> +{
> +	struct ssam_tmp_profile_device *tpd;
> +	enum ssam_tmp_profile tp;
> +	int status;
> +
> +	tpd = container_of(pprof, struct ssam_tmp_profile_device, handler);
> +
> +	status = ssam_tmp_profile_get(tpd->sdev, &tp);
> +	if (status)
> +		return status;
> +
> +	status = convert_ssam_to_profile(tpd->sdev, tp);
> +	if (status < 0)
> +		return status;
> +
> +	*profile = status;
> +	return 0;
> +}
> +
> +static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
> +				     enum platform_profile_option profile)
> +{
> +	struct ssam_tmp_profile_device *tpd;
> +	int tp;
> +
> +	tpd = container_of(pprof, struct ssam_tmp_profile_device, handler);
> +
> +	tp = convert_profile_to_ssam(tpd->sdev, profile);
> +	if (tp < 0)
> +		return tp;
> +
> +	return ssam_tmp_profile_set(tpd->sdev, tp);
> +}
> +
> +static int surface_platform_profile_probe(struct ssam_device *sdev)
> +{
> +	struct ssam_tmp_profile_device *tpd;
> +
> +	tpd = devm_kzalloc(&sdev->dev, sizeof(*tpd), GFP_KERNEL);
> +	if (!tpd)
> +		return -ENOMEM;
> +
> +	tpd->sdev = sdev;
> +
> +	tpd->handler.profile_get = ssam_platform_profile_get;
> +	tpd->handler.profile_set = ssam_platform_profile_set;
> +
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, tpd->handler.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, tpd->handler.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
> +
> +	platform_profile_register(&tpd->handler);
> +	return 0;
> +}
> +
> +static void surface_platform_profile_remove(struct ssam_device *sdev)
> +{
> +	platform_profile_remove();
> +}
> +
> +static const struct ssam_device_id ssam_platform_profile_match[] = {
> +	{ SSAM_SDEV(TMP, 0x01, 0x00, 0x01) },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(ssam, ssam_platform_profile_match);
> +
> +static struct ssam_device_driver surface_platform_profile = {
> +	.probe = surface_platform_profile_probe,
> +	.remove = surface_platform_profile_remove,
> +	.match_table = ssam_platform_profile_match,
> +	.driver = {
> +		.name = "surface_platform_profile",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +module_ssam_device_driver(surface_platform_profile);
> +
> +MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
> +MODULE_DESCRIPTION("Platform Profile Support for Surface System Aggregator Module");
> +MODULE_LICENSE("GPL");
> 

