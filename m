Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B392DCC7B
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Dec 2020 07:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgLQG3d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 01:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgLQG3a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 01:29:30 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A22C0617B0
        for <linux-acpi@vger.kernel.org>; Wed, 16 Dec 2020 22:28:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d26so12163854wrb.12
        for <linux-acpi@vger.kernel.org>; Wed, 16 Dec 2020 22:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uw0qn01yEipuE4KQo4q/I//7O4Z5qhvsoEs4F9itwqk=;
        b=VJEC/6EOmgFyFKHDv7NxjcSOxbitydIzcOYkIbzqE+DlWxlizfKe5e4ZWTxitA4pjT
         mhyCgnuIZY28r45HXehI6gk/xqbL/nLipe38jbK+hHwshuM6wGD6doQ23fitAES7Y5Mg
         +uicIE+cJAxcIMPlsG5WUAJ03mL780xvp1pTP6Q33zNwdrx77qbWEU0He2TjGA7gKTVw
         /HMert+f/4zgGvMT69ibNddye0lPOzhef285rGCmDr8cs4DUsHPuQPbar0T6fdME2unT
         AIssadyUx9iBEXc/LO7rTLciI+N6En2ddm7nw8LX1UYM/hPBLjdftjzfZDmkAKX0F3G7
         qu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uw0qn01yEipuE4KQo4q/I//7O4Z5qhvsoEs4F9itwqk=;
        b=nHMzQC6Bd24nOv16W+d/AFLyFtVUXJuubFavElRpxUjUrvpMQ0JrfHO+4Sw8TtZ66i
         K92g4C1Ig8PO9e6zHJbWVLpJ2c0b9aLMCTdT+sL7yEWoxivoLbBXiKvU4dAJNIKgPdSx
         JrwfUBHJq+nWHNaxudN9J9xLdD+4w9X2/RstmJ+A5zajNrR8lvWjoxeHmFMVZY/ZIwzl
         vM2gCcTEpVb9eBk08cvMNeEjn7WsI95dxSaGTvwA1VhNnMLNixXVENoN98mUFbS1tI93
         sJeEhbDDjHot5tbIXrn6dHuUX58dt/7UVUKsggf3/ATPXh1zxeL4hGVbZRh6SC4JfXrp
         q8Eg==
X-Gm-Message-State: AOAM531prmIb0ijs0Z3mGyOs1253zdPkh+yO/8W/TTvdPP/KZMvpn/kZ
        dLbHy+lt3AXyrRVtpPu8UGd5iO+fzW117Q==
X-Google-Smtp-Source: ABdhPJyunrsUCrTcQ8XdR1MnBNLU7dkhvUJngbHOgEo/eLy44Cv0qPXsVg4Nn9LpC9RRWGWk25BnHg==
X-Received: by 2002:a5d:4683:: with SMTP id u3mr42264872wrq.19.1608186528506;
        Wed, 16 Dec 2020 22:28:48 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:601a:58a2:ee98:f8a1? ([2a01:e34:ed2f:f020:601a:58a2:ee98:f8a1])
        by smtp.googlemail.com with ESMTPSA id w3sm6634432wma.3.2020.12.16.22.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 22:28:47 -0800 (PST)
Subject: Re: [PATCH 3/5] thermal/drivers/acpi: Use hot and critical ops
To:     rui.zhang@intel.com
Cc:     kai.heng.feng@canonical.com, lukasz.luba@arm.com,
        srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI THERMAL DRIVER" <linux-acpi@vger.kernel.org>
References: <20201210121514.25760-1-daniel.lezcano@linaro.org>
 <20201210121514.25760-3-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c20d9077-66e8-f947-6422-c48e2f679cc5@linaro.org>
Date:   Thu, 17 Dec 2020 07:28:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210121514.25760-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/12/2020 13:15, Daniel Lezcano wrote:
> The acpi driver wants to do a netlink notification in case of a hot or
> critical trip point. Implement the corresponding ops to be used for
> the thermal zone and use them instead of the notify ops.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Is there any comment on this patch ?

> ---
>  drivers/acpi/thermal.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 12c0ece746f0..b5e4bc9e3282 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -677,27 +677,24 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
>  	return 0;
>  }
>  
> -
> -static int thermal_notify(struct thermal_zone_device *thermal, int trip,
> -			   enum thermal_trip_type trip_type)
> +static void acpi_thermal_zone_device_hot(struct thermal_zone_device *thermal)
>  {
> -	u8 type = 0;
>  	struct acpi_thermal *tz = thermal->devdata;
>  
> -	if (trip_type == THERMAL_TRIP_CRITICAL)
> -		type = ACPI_THERMAL_NOTIFY_CRITICAL;
> -	else if (trip_type == THERMAL_TRIP_HOT)
> -		type = ACPI_THERMAL_NOTIFY_HOT;
> -	else
> -		return 0;
> -
>  	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
> -					dev_name(&tz->device->dev), type, 1);
> +					dev_name(&tz->device->dev),
> +					ACPI_THERMAL_NOTIFY_HOT, 1);
> +}
>  
> -	if (trip_type == THERMAL_TRIP_CRITICAL && nocrt)
> -		return 1;
> +static void acpi_thermal_zone_device_critical(struct thermal_zone_device *thermal)
> +{
> +	struct acpi_thermal *tz = thermal->devdata;
>  
> -	return 0;
> +	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
> +					dev_name(&tz->device->dev),
> +					ACPI_THERMAL_NOTIFY_CRITICAL, 1);
> +
> +	thermal_zone_device_critical(thermal);
>  }
>  
>  static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
> @@ -812,7 +809,8 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
>  	.get_trip_temp = thermal_get_trip_temp,
>  	.get_crit_temp = thermal_get_crit_temp,
>  	.get_trend = thermal_get_trend,
> -	.notify = thermal_notify,
> +	.hot = acpi_thermal_zone_device_hot,
> +	.critical = acpi_thermal_zone_device_critical,
>  };
>  
>  static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
