Return-Path: <linux-acpi+bounces-218-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0467B7B0A28
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 83521281587
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7BC38F88
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:31:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7A7347CF
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 15:00:26 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766AF192
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 08:00:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so9390745e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 08:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695826823; x=1696431623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NewR8mz3IDKSzbhyhEdNVdjJ713zwUsUtm4gHKiLJro=;
        b=oimuB8CgT98N8oKbqJao/E4cuj5pR1VCQXqSdVjbugHUbApUvSCJFbR2BKOOW5jR1v
         uNOfLNIfxx/t9gLU3u6WrctHo9/KxbJ2+sCMWLYgoyG9cFkeHkhFDvarbOHDkddokYBi
         q7rCfdg5G34/NDlJ8IZyy1mx3bxQv+0HQzbXatQS5hcPku8S+6jGWFR+iny/ZxfjCwD5
         tt99vIspuB2/bWrjPwXtM7qP/tU5hrMibMf1YKtio7tN15kTxUVy8tuUzz9OlDM2w2iF
         zWm+NCeijAkl0mT2WJlnwSOx6XlRcQU4DLE+oo5oYHSMD/GynBQRteZ3dvpozBzCzDU7
         t/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695826823; x=1696431623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NewR8mz3IDKSzbhyhEdNVdjJ713zwUsUtm4gHKiLJro=;
        b=iHg8rsIGUs8L4gO1q69b2rVF3WorBtTHtipaysELoibzdvnLkB4WuQiW+vUyZVYaAe
         PmRvnSxYijuL/f0yVeRl3HM919wf7W5mrAe5auckmUI2MRxGzVPb/ER+JyGsVTsQXYsX
         BqEJ84w9LSi++X1sMyK0jecCXRWRp1Fsn/6YxocIQKTU8wuyjbGRL7u5y1i6Y6ZluHzX
         9r+osFl6J2WkGCTOg+l18FzWCoDXlirv/Ux+QDGKjrpHet8+bbFCIwkGXqbob/NoXpY6
         ISH6MaiLUbHTK+SaByJjAe6GNf7L4T+rhviIiPeSSZPFgENCl+g/NSLV5LeXg9lzkmet
         fcsA==
X-Gm-Message-State: AOJu0YwY7LeFZzpw56XCa8FspToafNMVMX1ZX2DwglWF6dv5OJlUv2qx
	/GseCLmQVVDKng7OB/JfORiV9A==
X-Google-Smtp-Source: AGHT+IETTSPE9U+FYpjyRNTB+9sCf6QDVtfDMiQViMJoD01LWgrGCZjwBY+nkwnsQw5TGzj7/1jgUA==
X-Received: by 2002:a7b:c409:0:b0:3ff:ca80:eda3 with SMTP id k9-20020a7bc409000000b003ffca80eda3mr2253169wmi.10.1695826822830;
        Wed, 27 Sep 2023 08:00:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id j13-20020adfd20d000000b003232c2109cbsm7453676wrh.7.2023.09.27.08.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 08:00:20 -0700 (PDT)
Message-ID: <3c9f7b7d-a9ca-79ae-4e64-367a82f953bc@linaro.org>
Date: Wed, 27 Sep 2023 17:00:19 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 06/13] thermal: gov_fair_share: Rearrange
 get_trip_level()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <1882755.CQOukoFCf9@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1882755.CQOukoFCf9@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/09/2023 19:54, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make get_trip_level() access the thermal zone's trip table directly
> instead of using __thermal_zone_get_trip() which adds overhead related
> to the unnecessary bounds checking and copying the trip point data.
> 
> Also rearrange the code in it to make it somewhat easier to follow.
> 
> The general functionality is not expected to be changed.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_fair_share.c |   22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_fair_share.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_fair_share.c
> +++ linux-pm/drivers/thermal/gov_fair_share.c
> @@ -21,23 +21,21 @@
>    */
>   static int get_trip_level(struct thermal_zone_device *tz)
>   {
> -	struct thermal_trip trip;
> -	int count;
> +	const struct thermal_trip *trip = tz->trips;
> +	int i;
>   
> -	for (count = 0; count < tz->num_trips; count++) {
> -		__thermal_zone_get_trip(tz, count, &trip);
> -		if (tz->temperature < trip.temperature)
> +	if (tz->temperature < trip->temperature)
> +		return 0;
> +
> +	for (i = 0; i < tz->num_trips - 1; i++) {
> +		trip++;
> +		if (tz->temperature < trip->temperature)
>   			break;
>   	}

Is it possible to use for_each_thermal_trip() instead ? That would make 
the code more self-encapsulate

> -	/*
> -	 * count > 0 only if temperature is greater than first trip
> -	 * point, in which case, trip_point = count - 1
> -	 */
> -	if (count > 0)
> -		trace_thermal_zone_trip(tz, count - 1, trip.type);
> +	trace_thermal_zone_trip(tz, i, tz->trips[i].type);
>   
> -	return count;
> +	return i;
>   }
>   
>   static long get_target_state(struct thermal_zone_device *tz,
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


