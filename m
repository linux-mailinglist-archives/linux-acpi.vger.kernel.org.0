Return-Path: <linux-acpi+bounces-107-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896907ADD3C
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3A794281E56
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C75A1D552
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC1D21A08
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 16:29:45 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89712EE
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 09:29:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so67449195e9.2
        for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695659382; x=1696264182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bu0HFFNzN+SYC+kqOmOQQYu7jnB/SohgqheBtlqneSw=;
        b=qc66hY+Lyfqg9pdBgbbXv36sD6myTZ12CQrz1PkvZLKbB5gQARWADGpbr4vBwU2SXK
         nrOKm0E53jjtqL+TlAPNJ+lKaPDHoJ6bKOy3aV+Bfya5kuRj1vJyXOuOTAD7Y5aOOxrE
         pVjJgEcNYr4WZzZaLyZDkF2BCLwIjUKv5ocHm+EA+8Grx0dsg4g/xl35Ekt9P2GeNwrI
         4st1vv9cdiLsc8zpG9dtc6GDNUqLg8KDoHjTKY0BIA9XfWLHp8+izq56OTILyu86vbo+
         eMBlrjFkDy08dwGNbf/Wnf5EZPk5PxqSHkzWZV+R18VVwFOMII6bbyPO2OZYYm4v8b0+
         bttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695659382; x=1696264182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu0HFFNzN+SYC+kqOmOQQYu7jnB/SohgqheBtlqneSw=;
        b=o0JfmxwIpWm2YXiNZykNI8FR2H10D3id/J2HIGgj9WP338YPcBMk30uYWM9xijnjlI
         lkMlknLd+8fq7iO53hMf3WsbIOFh2bEyVlRM1oMgnyjQWkkGJyc9G3wl7k1n7plC/SO/
         ta6zns9jlPo0XsmDBkUBgrlpa60xngNUIWCVLgITul2tnw5Ymvhw9vdeNfjt/W0UpquW
         BIGHaO89mceYQQ3YWmhHoZDURaP0sZWAfWvWJBU6nJRE4EmYhPvzMzQpBmj+WhGEqSpW
         mP2cO1l+N3T5s4Sq/WI4O2kTqtDPhHKMEqG+iSf5AQPhI33H3e04kttCNU2pABPKzRB+
         g8TA==
X-Gm-Message-State: AOJu0YyVSQCRfAGYWQLk3YBE/echQEhT3DMBFCqN3ITxM+clbP8zOUta
	Y6q6HNWYEbE1a/XxlmOr1kYhCg==
X-Google-Smtp-Source: AGHT+IHlIsqH28gzyMhBQAhqa8Y+rRKApkko3Bp4ExN76DEwJebGzw6bW9+evO8bQTkviUQFQgJE7A==
X-Received: by 2002:a05:600c:331c:b0:405:959e:dc6f with SMTP id q28-20020a05600c331c00b00405959edc6fmr1575140wmp.37.1695659381848;
        Mon, 25 Sep 2023 09:29:41 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c0e1:63ab:648b:6287? ([2a05:6e02:1041:c10:c0e1:63ab:648b:6287])
        by smtp.googlemail.com with ESMTPSA id v21-20020a7bcb55000000b00404719b05b5sm12708972wmj.27.2023.09.25.09.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 09:29:41 -0700 (PDT)
Message-ID: <52e946a9-cfc6-3411-68c5-827bdd762af3@linaro.org>
Date: Mon, 25 Sep 2023 18:29:40 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 4/9] ACPI: thermal: Create and populate trip points
 table earlier
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <13346091.uLZWGnKmhe@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <13346091.uLZWGnKmhe@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/09/2023 20:39, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Create and populate the driver's trip points table in acpi_thermal_add()
> so as to allow the its data structures to be simplified going forward.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/acpi/thermal.c |  105 ++++++++++++++++++++++++-------------------------
>   1 file changed, 52 insertions(+), 53 deletions(-)
> 
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -688,53 +688,10 @@ static void acpi_thermal_zone_sysfs_remo
>   }
>   
>   static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz,
> -					      unsigned int trip_count)
> +					      unsigned int trip_count,
> +					      int passive_delay)
>   {
> -	struct acpi_thermal_trip *acpi_trip;
> -	struct thermal_trip *trip;
> -	int passive_delay = 0;
>   	int result;
> -	int i;
> -
> -	trip = kcalloc(trip_count, sizeof(*trip), GFP_KERNEL);
> -	if (!trip)
> -		return -ENOMEM;
> -
> -	tz->trip_table = trip;
> -
> -	if (tz->trips.critical.valid) {
> -		trip->type = THERMAL_TRIP_CRITICAL;
> -		trip->temperature = acpi_thermal_temp(tz, tz->trips.critical.temperature);
> -		trip++;
> -	}
> -
> -	if (tz->trips.hot.valid) {
> -		trip->type = THERMAL_TRIP_HOT;
> -		trip->temperature = acpi_thermal_temp(tz, tz->trips.hot.temperature);
> -		trip++;
> -	}
> -
> -	acpi_trip = &tz->trips.passive.trip;
> -	if (acpi_trip->valid) {
> -		passive_delay = tz->trips.passive.tsp * 100;
> -
> -		trip->type = THERMAL_TRIP_PASSIVE;
> -		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temperature);
> -		trip->priv = acpi_trip;
> -		trip++;
> -	}
> -
> -	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
> -		acpi_trip = &tz->trips.active[i].trip;
> -
> -		if (!acpi_trip->valid)
> -			break;
> -
> -		trip->type = THERMAL_TRIP_ACTIVE;
> -		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temperature);
> -		trip->priv = acpi_trip;
> -		trip++;
> -	}
>   
>   	tz->thermal_zone = thermal_zone_device_register_with_trips("acpitz",
>   								   tz->trip_table,
> @@ -744,10 +701,8 @@ static int acpi_thermal_register_thermal
>   								   NULL,
>   								   passive_delay,
>   								   tz->polling_frequency * 100);
> -	if (IS_ERR(tz->thermal_zone)) {
> -		result = PTR_ERR(tz->thermal_zone);
> -		goto free_trip_table;
> -	}
> +	if (IS_ERR(tz->thermal_zone))
> +		return PTR_ERR(tz->thermal_zone);
>   
>   	result = acpi_thermal_zone_sysfs_add(tz);
>   	if (result)
> @@ -766,8 +721,6 @@ remove_links:
>   	acpi_thermal_zone_sysfs_remove(tz);
>   unregister_tzd:
>   	thermal_zone_device_unregister(tz->thermal_zone);
> -free_trip_table:
> -	kfree(tz->trip_table);
>   
>   	return result;
>   }
> @@ -886,9 +839,13 @@ static void acpi_thermal_check_fn(struct
>   
>   static int acpi_thermal_add(struct acpi_device *device)
>   {
> +	struct acpi_thermal_trip *acpi_trip;
> +	struct thermal_trip *trip;
>   	struct acpi_thermal *tz;
>   	unsigned int trip_count;
> +	int passive_delay = 0;
>   	int result;
> +	int i;
>   
>   	if (!device)
>   		return -EINVAL;
> @@ -930,9 +887,49 @@ static int acpi_thermal_add(struct acpi_
>   
>   	acpi_thermal_guess_offset(tz);
>   
> -	result = acpi_thermal_register_thermal_zone(tz, trip_count);
> +	trip = kcalloc(trip_count, sizeof(*trip), GFP_KERNEL);
> +	if (!trip)
> +		return -ENOMEM;
> +
> +	tz->trip_table = trip;
> +
> +	if (tz->trips.critical.valid) {
> +		trip->type = THERMAL_TRIP_CRITICAL;
> +		trip->temperature = acpi_thermal_temp(tz, tz->trips.critical.temperature);
> +		trip++;
> +	}
> +
> +	if (tz->trips.hot.valid) {
> +		trip->type = THERMAL_TRIP_HOT;
> +		trip->temperature = acpi_thermal_temp(tz, tz->trips.hot.temperature);
> +		trip++;
> +	}
> +
> +	acpi_trip = &tz->trips.passive.trip;
> +	if (acpi_trip->valid) {
> +		passive_delay = tz->trips.passive.tsp * 100;
> +
> +		trip->type = THERMAL_TRIP_PASSIVE;
> +		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temperature);
> +		trip->priv = acpi_trip;
> +		trip++;
> +	}
> +
> +	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
> +		acpi_trip =  &tz->trips.active[i].trip;
> +
> +		if (!acpi_trip->valid)
> +			break;
> +
> +		trip->type = THERMAL_TRIP_ACTIVE;
> +		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temperature);
> +		trip->priv = acpi_trip;
> +		trip++;
> +	}
> +
> +	result = acpi_thermal_register_thermal_zone(tz, trip_count, passive_delay);
>   	if (result)
> -		goto free_memory;
> +		goto free_trips;
>   
>   	refcount_set(&tz->thermal_check_count, 3);
>   	mutex_init(&tz->thermal_check_lock);
> @@ -951,6 +948,8 @@ static int acpi_thermal_add(struct acpi_
>   flush_wq:
>   	flush_workqueue(acpi_thermal_pm_queue);
>   	acpi_thermal_unregister_thermal_zone(tz);
> +free_trips:
> +	kfree(tz->trip_table);
>   free_memory:
>   	kfree(tz);
>   
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


