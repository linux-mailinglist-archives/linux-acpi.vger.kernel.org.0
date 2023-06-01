Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C115719ED8
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjFANvs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjFANvj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:51:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFFC197;
        Thu,  1 Jun 2023 06:51:35 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d3578c25bso1067818b3a.3;
        Thu, 01 Jun 2023 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685627495; x=1688219495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5jMlTHIdSzT1qHFmYrYEOipGUgc8N7tk1p1zj3iJJuU=;
        b=YUnHNfrM4yqhbSu6m2T1seVjYGiyGDd/mwKCFN+87reF7g4e7Ku+js8Vk5GmmsezDW
         8Y6K5bpkkuHvH8lvs/sc3dP0jqGZ2SeddG6jmzy1Ar6ZeBzga6a/Rm07wSjQH0nTogqv
         UunI+OuHy412GMRejDvLBxVRIdqcFZfV+EnBYdIkJZF6d2AXNxvKpZOaHwH1O5TRcvmg
         f3ccufbTgNxMjooCBIfiGpEvdg60Q5JZf9xEcmiHMBKeFuio0lGq1y9ivObNbcLtGw5N
         5xFAr+Sp8oyl08F6EUysMx2JnC1cVx1hDDhNabpzEF+K4PyGwv200gHxzgMTeAsJrFFr
         s51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685627495; x=1688219495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jMlTHIdSzT1qHFmYrYEOipGUgc8N7tk1p1zj3iJJuU=;
        b=XELM5seHy8+t8WHuUdYWfE3HexkAqBBqZIkFwyJOHhmeRSPh9rcbbp6HQKXAwbQNTN
         jOFzq7twWhdldb0IAlMk6QPpFZrsFg2FLk0WweLukLkh95/TbEadSRIGJH5bQhN25UY4
         nDPhlUgQT5z9RAxU7h2G4/cp9MZJdVGMIdqBeN1DbBbfl8mgHk7pR2sPPf5E9rOZzW/O
         jplBZSqELbDki0c9tyol+p+DllJsnVTVDaoxshpUtEX6xkO5/syeH9+fW1XKUBrTHe0g
         pHXq/8Wj6MUoxrgIwBha8tNkT5d7fo7CKqrdu3x+brFp5CrSx7i2OUr+9xg2tcjBw6WL
         uNvQ==
X-Gm-Message-State: AC+VfDxqDEaq5lCdb8u7EIftSUjFRpOthWXULrtOOnyf20Qi61YV7KgW
        9WF88pjb0PwiXtRqNBBUUlgzeFxEv1k=
X-Google-Smtp-Source: ACHHUZ4QKOxYaMlDunH+ugZFmVNlAzT5+SOsZ9SpfiwlHQ3qRLuFea/aevg9M82lHikvKmQY3w7usg==
X-Received: by 2002:a05:6a20:914b:b0:10b:b762:7694 with SMTP id x11-20020a056a20914b00b0010bb7627694mr11047944pzc.17.1685627495132;
        Thu, 01 Jun 2023 06:51:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001b00dae8771sm3502512plb.201.2023.06.01.06.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 06:51:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1391159f-880d-f81e-7246-8bfb1747e3e9@roeck-us.net>
Date:   Thu, 1 Jun 2023 06:51:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 10/35] hwmon/acpi_power_meter: Move handler installing
 logic to driver
Content-Language: en-US
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, rafael@kernel.org
References: <20230601131739.300760-3-michal.wilczynski@intel.com>
 <20230601131739.300760-11-michal.wilczynski@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230601131739.300760-11-michal.wilczynski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 6/1/23 06:17, Michal Wilczynski wrote:
> Currently logic for installing notifications from ACPI devices is
> implemented using notify callback in struct acpi_driver. Preparations
> are being made to replace acpi_driver with more generic struct
> platform_driver, which doesn't contain notify callback. Furthermore
> as of now handlers are being called indirectly through
> acpi_notify_device(), which decreases performance.
> 
> Call acpi_device_install_event_handler() at the end of .add() callback.
> Call acpi_device_remove_event_handler() at the beginning of .remove()
> callback. Change arguments passed to the notify callback to match with
> what's required by acpi_device_install_event_handler().
> 
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/acpi_power_meter.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index fa28d447f0df..7410ee8693ba 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -817,9 +817,10 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
>   }
>   
>   /* Handle ACPI event notifications */
> -static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
> +static void acpi_power_meter_notify(acpi_handle handle, u32 event, void *data)
>   {
>   	struct acpi_power_meter_resource *resource;
> +	struct acpi_device *device = data;
>   	int res;
>   
>   	if (!device || !acpi_driver_data(device))
> @@ -897,8 +898,12 @@ static int acpi_power_meter_add(struct acpi_device *device)
>   		goto exit_remove;
>   	}
>   
> -	res = 0;
> -	goto exit;
> +	res = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
> +						acpi_power_meter_notify);
> +	if (res)
> +		goto exit_remove;
> +
> +	return 0;
>   
>   exit_remove:
>   	remove_attrs(resource);
> @@ -906,7 +911,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
>   	free_capabilities(resource);
>   exit_free:
>   	kfree(resource);
> -exit:
> +
>   	return res;
>   }
>   
> @@ -917,6 +922,7 @@ static void acpi_power_meter_remove(struct acpi_device *device)
>   	if (!device || !acpi_driver_data(device))
>   		return;
>   
> +	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_power_meter_notify);
>   	resource = acpi_driver_data(device);
>   	hwmon_device_unregister(resource->hwmon_dev);
>   
> @@ -953,7 +959,6 @@ static struct acpi_driver acpi_power_meter_driver = {
>   	.ops = {
>   		.add = acpi_power_meter_add,
>   		.remove = acpi_power_meter_remove,
> -		.notify = acpi_power_meter_notify,
>   		},
>   	.drv.pm = pm_sleep_ptr(&acpi_power_meter_pm),
>   };

