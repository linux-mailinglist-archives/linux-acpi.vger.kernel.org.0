Return-Path: <linux-acpi+bounces-2174-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39168072A4
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 15:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E8BB20C14
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 14:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40895182C3
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RenhSSUW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C7FD44
	for <linux-acpi@vger.kernel.org>; Wed,  6 Dec 2023 06:38:53 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3316a4bc37dso786491f8f.2
        for <linux-acpi@vger.kernel.org>; Wed, 06 Dec 2023 06:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701873532; x=1702478332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gy0xfaNC3TmuUx7S3psA+A+EQOiJknmpliCDJOGmCGs=;
        b=RenhSSUWfvBNUjxN5b2nV8o0NZ7vKK+axTC+Ik7JwyQzohJi256+FuosE0gGG26V2p
         pMHihYmNZs7+GQ33eBmxNOK7mWMBq7iF+kMjhCecLLIehmp8YqrkYYiR9XBn6GjU26jj
         45d4XGFYG50hJGlZQwOKaSSl7C9DN5XTlAfz4/afxFxQQed3z0T5N1TkMO85u9DT/w9J
         7uSqpDVEPtKX12tluI1BiIU+VKIJY8LTTLHBLXuLM+i8I/kGTMQ91vuq9y+j5SUZW2aK
         UddJwWP19Kn6NvstbJzOt2afA0hxdpNouJP0NPgWjGQGFHpXpQfvQr0VAJY/T9q/aMw6
         afvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701873532; x=1702478332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gy0xfaNC3TmuUx7S3psA+A+EQOiJknmpliCDJOGmCGs=;
        b=t5rjLUzpizNWIPEdgS0eRCfepYNiaImwsMMlYqMx8x4yK9aLc625sQdastFg5h5OUa
         HRMsDsjCk2PfHRqZQldZ8bS5Img34zI6wuUAYImq/bhsXbUVGngJfh53xvggLYR4EHmF
         bga4SbpcU8+nP4FJsg/VaoXn1cgvMTb8AA7nnF+9OvzeS5g9dR9vaul8UBNQeqwQb6D0
         hDujthNcsyyvaFfjkKM3LP/yp8Hu3QKBr8Ttsb1F+2fxbGz37Ur8oyNcjwjhVJSX5Qhb
         InLPAGBjxK+ry11GwsrWDS12YgaLjhFiwOWxblkjoPpRyuS9kTNWQTH361sAkcc3DtN7
         kmfg==
X-Gm-Message-State: AOJu0Yyy6fYqY8BQ2WFpiYATbQb0BvA/qD+K2lnp3DT/bTrzjsIGdeA9
	+OlFulNB5BndaEOyqC9YtBhrHq5BklWzTeSILsg=
X-Google-Smtp-Source: AGHT+IHm7G/pgyKDeywjonXsUi1DVYn8l75DnmHejkL/8m44kWNZG0s+vcDFJM1/BPBUwwRVGf8Ytw==
X-Received: by 2002:a05:600c:252:b0:40c:23c7:8cf7 with SMTP id 18-20020a05600c025200b0040c23c78cf7mr364518wmj.167.1701873531976;
        Wed, 06 Dec 2023 06:38:51 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id q3-20020adff783000000b003332febec90sm15062021wrp.7.2023.12.06.06.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 06:38:51 -0800 (PST)
Message-ID: <cf055d45-8970-4657-ab86-d28636645c81@linaro.org>
Date: Wed, 6 Dec 2023 15:38:50 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: trip: Send trip change notifications on all
 trip updates
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5737811.DvuYhMxLoT@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5737811.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

On 05/12/2023 20:18, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The _store callbacks of the trip point temperature and hysteresis sysfs
> attributes invoke thermal_notify_tz_trip_change() to send a notification
> regarding the trip point change, but when trip points are updated by the
> platform firmware, trip point change notifications are not sent.
> 
> To make the behavior after a trip point change more consistent,
> modify all of the 3 places where trip point temperature is updated
> to use a new function called thermal_zone_set_trip_temp() for this
> purpose and make that function call thermal_notify_tz_trip_change().
> 
> Note that trip point hysteresis can only be updated via sysfs and
> trip_point_hyst_store() calls thermal_notify_tz_trip_change() already,
> so this code path need not be changed.

Why the ACPI driver is not calling thermal_zone_device_update() after 
changing the trip point like the other drivers?

It would make sense to have the thermal framework to be notified about 
this change and check if there is a trip violation, no ?


> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Depends on https://lore.kernel.org/linux-pm/12337662.O9o76ZdvQC@kreacher/
> 
> ---
>   drivers/acpi/thermal.c                                       |    7 +++--
>   drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |    8 +++---
>   drivers/thermal/thermal_sysfs.c                              |    4 +--
>   drivers/thermal/thermal_trip.c                               |   14 ++++++++++-
>   include/linux/thermal.h                                      |    2 +
>   5 files changed, 27 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -146,9 +146,9 @@ trip_point_temp_store(struct device *dev
>   				goto unlock;
>   		}
>   
> -		trip->temperature = temp;
> +		thermal_zone_set_trip_temp(tz, trip, temp);
>   
> -		thermal_zone_trip_updated(tz, trip);
> +		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
>   	}
>   
>   unlock:
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -152,7 +152,6 @@ int thermal_zone_trip_id(struct thermal_
>   	 */
>   	return trip - tz->trips;
>   }
> -
>   void thermal_zone_trip_updated(struct thermal_zone_device *tz,
>   			       const struct thermal_trip *trip)
>   {
> @@ -161,3 +160,16 @@ void thermal_zone_trip_updated(struct th
>   				      trip->hysteresis);
>   	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
>   }
> +
> +void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
> +				struct thermal_trip *trip, int temp)
> +{
> +	if (trip->temperature == temp)
> +		return;
> +
> +	trip->temperature = temp;
> +	thermal_notify_tz_trip_change(tz->id, thermal_zone_trip_id(tz, trip),
> +				      trip->type, trip->temperature,
> +				      trip->hysteresis);
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -289,6 +289,8 @@ int thermal_zone_for_each_trip(struct th
>   			       int (*cb)(struct thermal_trip *, void *),
>   			       void *data);
>   int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
> +void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
> +				struct thermal_trip *trip, int temp);
>   
>   int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
>   
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -294,6 +294,7 @@ static int acpi_thermal_adjust_trip(stru
>   	struct acpi_thermal_trip *acpi_trip = trip->priv;
>   	struct adjust_trip_data *atd = data;
>   	struct acpi_thermal *tz = atd->tz;
> +	int temp;
>   
>   	if (!acpi_trip || !acpi_thermal_trip_valid(acpi_trip))
>   		return 0;
> @@ -304,9 +305,11 @@ static int acpi_thermal_adjust_trip(stru
>   		acpi_thermal_update_trip_devices(tz, trip);
>   
>   	if (acpi_thermal_trip_valid(acpi_trip))
> -		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
> +		temp = acpi_thermal_temp(tz, acpi_trip->temp_dk);
>   	else
> -		trip->temperature = THERMAL_TEMP_INVALID;
> +		temp = THERMAL_TEMP_INVALID;
> +
> +	thermal_zone_set_trip_temp(tz->thermal_zone, trip, temp);
>   
>   	return 0;
>   }
> Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -225,7 +225,8 @@ EXPORT_SYMBOL_GPL(int340x_thermal_zone_r
>   
>   static int int340x_update_one_trip(struct thermal_trip *trip, void *arg)
>   {
> -	struct acpi_device *zone_adev = arg;
> +	struct int34x_thermal_zone *int34x_zone = arg;
> +	struct acpi_device *zone_adev = int34x_zone->adev;
>   	int temp, err;
>   
>   	switch (trip->type) {
> @@ -249,14 +250,15 @@ static int int340x_update_one_trip(struc
>   	if (err)
>   		temp = THERMAL_TEMP_INVALID;
>   
> -	trip->temperature = temp;
> +	thermal_zone_set_trip_temp(int34x_zone->zone, trip, temp);
> +
>   	return 0;
>   }
>   
>   void int340x_thermal_update_trips(struct int34x_thermal_zone *int34x_zone)
>   {
>   	thermal_zone_for_each_trip(int34x_zone->zone, int340x_update_one_trip,
> -				   int34x_zone->adev);
> +				   int34x_zone);
>   }
>   EXPORT_SYMBOL_GPL(int340x_thermal_update_trips);
>   
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


