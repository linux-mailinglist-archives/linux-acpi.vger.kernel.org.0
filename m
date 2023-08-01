Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A9B76BC9B
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Aug 2023 20:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjHASjU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Aug 2023 14:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjHASjQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2023 14:39:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AD526A4
        for <linux-acpi@vger.kernel.org>; Tue,  1 Aug 2023 11:39:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31757edd9edso5358946f8f.2
        for <linux-acpi@vger.kernel.org>; Tue, 01 Aug 2023 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690915149; x=1691519949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EFUJZW17T5kR5LxeUj/wsPffO8rw8SB5CP4M13sEbA=;
        b=nIDdrHwHHJSSZFT4EgZKRFPLGEaASm09NRdE8gzz78gej767WFTlvsJT7biZJvFRGP
         QnDAX4oyUAmzjyOYGm92j/snTZM/0cSx3xEl2Ksw1Im2uP6sm8RgVarCZ97ButDC8bry
         b08CRx/IKluU2ShZhUB3U7GZFkDYbl8OgArfBHn3Bm1dOtAbADZtQ4AEX4e7G66/7HqF
         dcQ2RDGNuWcI6xmQ6CM6zpH2DODt/8xMi6IazZPpee4uAxNhWsTWfRoLn8zl9dntictx
         MVdBZrlHIHOoyssnGA3naW48L+GCvPUsRPbFx7onUv05o1KWjQ8H6VlUmIcBu0jhJ61I
         7afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915149; x=1691519949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EFUJZW17T5kR5LxeUj/wsPffO8rw8SB5CP4M13sEbA=;
        b=LGQif5hVJQGhsUfrVCYun68GrkAF2l2JurPOBgrySkkNYSZ5mpfqGWWALhxaW1z5RI
         hIis0RitKQXqwisxjpDv4QEK6m8jpzE7dUDRaHZq0t+v3cbI3YUOKLsQNG6pvbtOm5iY
         hreCh5vDodxFdU2la43CQzWoxbcLF6vy7aPXIg5zFklf/C/FQtam/wpY9z9jHYNryMy1
         aPD9zfX6hyOuPrOLlEcVWLdSZz6wWl79b5T7CpxfO7d4wOcyBEK3U4fRWaJmkSTbdHMw
         stgeohqfKFEw243mvzg1vwnl9VOtKtXGunuJa2j+N6GKOCs6+77bJQshR5QEYjwDrR2W
         sZzQ==
X-Gm-Message-State: ABy/qLanYfDEZGMPXWCiqfeHkN08pgslkQ1rEhPS4KgcZTaLpAShxH5H
        yxy6+kKJ3Pt1SREKlBcCgJNehg==
X-Google-Smtp-Source: APBJJlGoXOK6T9ffOYXg6zcKFD+rEOM9ac7VCXjHLS2lYi4qWcVAesZsI5YXpRSR90jCU3rLLNxG1Q==
X-Received: by 2002:a5d:5589:0:b0:317:70cb:4f58 with SMTP id i9-20020a5d5589000000b0031770cb4f58mr2858210wrv.63.1690915149541;
        Tue, 01 Aug 2023 11:39:09 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l18-20020a1c7912000000b003fe2bea77ccsm1435499wme.5.2023.08.01.11.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 11:39:08 -0700 (PDT)
Message-ID: <cc972aec-dd21-e025-8984-e48b7c1df4bc@linaro.org>
Date:   Tue, 1 Aug 2023 20:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/8] ACPI: thermal: Hold thermal zone lock around trip
 updates
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <7552439.EvYhyI6sBW@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <7552439.EvYhyI6sBW@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Hi Rafael,

On 25/07/2023 14:16, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is a race condition between acpi_thermal_trips_update() and
> acpi_thermal_check_fn(), because the trip points may get updated while
> the latter is running which in theory may lead to inconsistent results.
> For example, if two trips are updated together, using the temperature
> value of one of them from before the update and the temperature value
> of the other one from after the update may not lead to the expected
> outcome.
> 
> To address this, make acpi_thermal_trips_update() hold the thermal zone
> lock across the entire update of trip points.

As commented in patch 3/8, having a driver locking a thermal core 
structure is not right and goes to the opposite direction of the recent 
cleanups.

Don't we have 2 race conditions:

acpi_thermal_trips_update() + thermal_zone_device_check()

acpi_thermal_trips_update() + acpi_thermal_trips_update()

For the former, we can disable the thermal zone, update and then enable

For the latter use a driver lock ?


> While at it, change the acpi_thermal_trips_update() return data type
> to void as that function always returns 0 anyway.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: No changes.
> 
> v1 -> v2:
>     * Hold the thermal zone lock instead of thermal_check_lock around trip
>       point updates (this also helps to protect thermal_get_trend() from using
>       stale trip temperatures).
>     * Add a comment documenting the purpose of the locking.
>     * Make acpi_thermal_trips_update() void.
> 
> ---
>   drivers/acpi/thermal.c |   21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -190,7 +190,7 @@ static int acpi_thermal_get_polling_freq
>   	return 0;
>   }
>   
> -static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
> +static void __acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>   {
>   	acpi_status status;
>   	unsigned long long tmp;
> @@ -398,17 +398,28 @@ static int acpi_thermal_trips_update(str
>   			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
>   		}
>   	}
> +}
>   
> -	return 0;
> +static void acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
> +{
> +	/*
> +	 * The locking is needed here to protect thermal_get_trend() from using
> +	 * a stale passive trip temperature and to synchronize with the trip
> +	 * temperature updates in acpi_thermal_check_fn().
> +	 */
> +	thermal_zone_device_lock(tz->thermal_zone);
> +
> +	__acpi_thermal_trips_update(tz, flag);
> +
> +	thermal_zone_device_unlock(tz->thermal_zone);
>   }
>   
>   static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
>   {
> -	int i, ret = acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
>   	bool valid;
> +	int i;
>   
> -	if (ret)
> -		return ret;
> +	__acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
>   
>   	valid = tz->trips.critical.valid |
>   		tz->trips.hot.valid |
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

