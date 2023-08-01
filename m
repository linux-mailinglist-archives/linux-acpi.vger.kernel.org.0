Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9685B76BC7D
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Aug 2023 20:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjHAS33 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Aug 2023 14:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjHAS30 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2023 14:29:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15432722
        for <linux-acpi@vger.kernel.org>; Tue,  1 Aug 2023 11:29:15 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so37199185e9.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Aug 2023 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690914554; x=1691519354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+B3GhLUuo6j85dPd0XORC2K/eb836TEWIRsdzlNEcs=;
        b=q49iGdf073NKi9K2cVOsDH+KrOfN8IyffLIghqBklMryjLZ9/sCNioTukl5CoPqLoA
         FErUbS2nyD4MAAa22vi8oRHOUtKS02pbQOu3Y222hLL1OxDAaHx7EklpeQ66cVqjFHu9
         G6QL9GA6pYNLwt8jcpkYD/mA2GrbWJLIN8VzP0BMfBvM5akf/8M34rQUtT7MSX6PSw+8
         4f4cd0DSMAtuCVrpQ2mZZKW5T+bVdIJ/PYrpAOooZ7p8tYeEwheaZdHuKg0A3YBCWzCg
         fWC1K5MLPp9Ztc4wS1MBrz4yUPmjsRPiAQDHBzMZPgwu6InFNoBgB2TdKq/utugkbx3u
         RHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690914554; x=1691519354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+B3GhLUuo6j85dPd0XORC2K/eb836TEWIRsdzlNEcs=;
        b=c0d8+3kcAgpOzmWXQ7EQ1so/yjHfOz+dCUDaYXl61tu5L1m6QeqGuMBL2Dy/rEVV1g
         oY0nv0N0PEjEphs9NcYEFEx4RXtdhaZRlAQxgkmaC0IQiFIVvmhN6b14GkPpgz5Rf7Xq
         f8NFM5NifbPeU5yzKpuiRV6Xf8MvWwuLRMsiKj1oj/7OJ98I96M+qIjGZvaZsKa8qkLC
         n8V0nOs+cfuBIjZCk/M8Y+4YyF19dAKzjGMOKdfSaxpj+gc2Wl8tp4mU2BG+NxBIKEvr
         h970aPxmac+shELMV06LTP94FUu5YGhMWNFlCr0i5KwE8k82jw1p+CYGQeKUq+XHLivq
         6lxA==
X-Gm-Message-State: ABy/qLZe8DeUejCPSnyJr+0FgB+yfKg8a1SL8/Rn/IPyOEMSavmhcdTV
        Jqjf1KQRtNtlLZ/F6u2n36z28A==
X-Google-Smtp-Source: APBJJlFn9nJJXAZeF6cMEas372GlH2Ac34hYmzz2ylUqvJlq9ebyhR5j2PvQlPfTvO8am7WFNSz6EA==
X-Received: by 2002:adf:e105:0:b0:314:11f3:ca94 with SMTP id t5-20020adfe105000000b0031411f3ca94mr3085119wrz.41.1690914553757;
        Tue, 01 Aug 2023 11:29:13 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f11-20020adff58b000000b003143aa0ca8asm16679857wro.13.2023.08.01.11.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 11:29:13 -0700 (PDT)
Message-ID: <2d0315d4-35b4-84db-4dcb-c9528abad825@linaro.org>
Date:   Tue, 1 Aug 2023 20:29:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/8] thermal: core: Add mechanism for connecting trips
 with driver data
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <4501957.LvFx2qVVIh@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4501957.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 25/07/2023 14:04, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some drivers need to update trip point data (temperature and/or
> hysteresis) upon notifications from the platform firmware or they
> may need to reprogram hardware when trip point parameters are changed
> via sysfs.  For those purposes, they need to connect struct thermal_trip
> to a private data set associated with the trip or the other way around
> and using a trip point index for that may not always work, because the
> core may need to reorder the trips during thermal zone registration (in
> particular, they may need to be sorted).
> 
> To allow that to be done without using a trip point index, introduce
> a new field in struct thermal_trip that can be pointed by the driver
> to its own data structure containing a trip pointer to be initialized
> by the core during thermal zone registration.  That pointer will then
> have to be updated by the core every time the location of the given
> trip point object in memory changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: No changes.
> 
> v1 -> v2: No changes.
> 
> ---
>   drivers/thermal/thermal_core.c |   20 +++++++++++++++++---
>   include/linux/thermal.h        |   13 +++++++++++++
>   2 files changed, 30 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -76,16 +76,29 @@ struct thermal_zone_device_ops {
>   	void (*critical)(struct thermal_zone_device *);
>   };
>   
> +struct thermal_trip_ref {
> +	struct thermal_trip *trip;
> +};

That introduces a circular dependency. That should be avoided.

>   /**
>    * struct thermal_trip - representation of a point in temperature domain
>    * @temperature: temperature value in miliCelsius
>    * @hysteresis: relative hysteresis in miliCelsius
>    * @type: trip point type
> + * @driver_ref: driver's reference to this trip point
> + *
> + * If @driver_ref is not NULL, the trip pointer in the object pointed to by it
> + * will be initialized by the core during thermal zone registration and updated
> + * whenever the location of the given trip object changes.  This allows the
> + * driver to access the trip point data without knowing the relative ordering
> + * of trips within the trip table used by the core and, given a trip pointer,
> + * to get back to its private data associated with the given trip.
>    */
>   struct thermal_trip {
>   	int temperature;
>   	int hysteresis;
>   	enum thermal_trip_type type;
> +	struct thermal_trip_ref *driver_ref;
>   };

Why not use void *priv ?

AFAICT, the ACPI driver is the only one where when we reorder the trip 
points, the trip id is no longer matching the definition provided by the 
ACPI description.

It is possible to have the driver *specific* code to define its own 
structure with the id and use it instead of the trip_id.

So we end up with the ACPI driver registering the trip points with a 
data structure containing a private trip id.

The thermal framework is not supposed to have to deal with this kind of 
driver issues and from a higher perspective, any driver specific thing 
must stay in the driver.

eg.

struct acpi_thermal_trip_data {
	int id;
	... other info
};

struct acpi_thermal_trip_data attd[NRTRIPS] = { .id = 0 }, { .id = 1 }, ...

struct thermal_trip trips[NRTRIPS];

trips[i].priv = &attd[i];


The drivers with another kind of specific trip data can use this field.


>   struct thermal_cooling_device_ops {
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1306,14 +1306,28 @@ thermal_zone_device_register_with_trips(
>   	if (result)
>   		goto release_device;
>   
> +	mutex_lock(&tz->lock);
> +
>   	for (count = 0; count < num_trips; count++) {
> -		struct thermal_trip trip;
> +		int temperature = 0;
> +
> +		if (trips) {
> +			temperature = trips[count].temperature;
> +			if (trips[count].driver_ref)
> +				trips[count].driver_ref->trip = &trips[count];
> +		} else {
> +			struct thermal_trip trip;

As mentioned above, that should not appear in the thermal core code.


> -		result = thermal_zone_get_trip(tz, count, &trip);
> -		if (result || !trip.temperature)
> +			result = __thermal_zone_get_trip(tz, count, &trip);
> +			if (!result)
> +				temperature = trip.temperature;
> +		}
> +		if (!temperature)
>   			set_bit(count, &tz->trips_disabled);
>   	}
>   
> +	mutex_unlock(&tz->lock);
> +
>   	/* Update 'this' zone's governor information */
>   	mutex_lock(&thermal_governor_lock);
>   
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

