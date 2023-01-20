Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA7E675CBB
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jan 2023 19:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjATS14 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Jan 2023 13:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjATS1z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2023 13:27:55 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2DE4E530
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jan 2023 10:27:53 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k16so4747711wms.2
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jan 2023 10:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nuasAerLyMAB7lmncOQjek4k4Iwh+6TryNOLU8S7QOw=;
        b=K2yEleRIORu15GkMOtwomVOmNAMQq3NeZZi5OWs1VRC38jr8Nk8Ylq6S/gSJS9XPUB
         iQoIKC6UdZNJEa5dOcg8SegDACg2bktFWiGEZRC3xlc9GdZlhBTOpLu3msIqnHJwX6v1
         nzgGGjy7IQz2cIXa0ig74RtgQDvcL0yZ42bqKuZ6x7m4yJ9BfHCtaBBFsBU4doeMoOCk
         RAVX5TEt0H9nGJ1/aLWTuo8yLSAxtT320ra3tPpQRw9taQM/8PbPy6vdH++hcK0DWQ4a
         bF74tEWMUHhOIqS6/ULL9jLthvip21G1MBhwgLBs70ilfocu8rlJ0aL4BuQjFeuzaSET
         GeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuasAerLyMAB7lmncOQjek4k4Iwh+6TryNOLU8S7QOw=;
        b=6Rn3R2zTKPPHBD2KAYRP6YoC7jAVI9Bu3WkMUfUy/ULBIKkU0WS1pvafYeCOVeqGdv
         +ZhPbO3TvZ7z0fGNiKreRkGZhCxzW4xI3jKdENHaP+Wx2jrzkf5CcaN/+yQfrWx0ERVL
         pWsd5EhSMw2O+kaCjoRrfLQcwIrkgytWmEk7zkzfF2unFX1s4SIDBJfgiFhQP1V+VgZn
         xTrpsmZqLmecy4Bxv9oEo1m4Q2Kcs3x5gUizpaOOa9XtLavvyJoh1VkTM0Chcu9Ze5aM
         dOL8owMkQRxkeFzEWFH+iOQ/6uJ27F/tP/ALbw9uxoFYqQ9ZAo4efjsrsYinUkrnTJDJ
         pEyQ==
X-Gm-Message-State: AFqh2kqA3JlhZrfa4NU/Qq0ob7yJYfMCHFjZ2flXl3gXQntDdIBI4wcc
        Gs3sYbrC7/ZZmozsvY28G1kWWg==
X-Google-Smtp-Source: AMrXdXtuITw2Yy3q7EhwhALjZYxPQDDhv3O6srb9jjnlbjuKQ0BiUYcn0Fp3/pg4hq/b6VeOFtUHiQ==
X-Received: by 2002:a05:600c:ccf:b0:3db:f34:e9e0 with SMTP id fk15-20020a05600c0ccf00b003db0f34e9e0mr11936402wmb.35.1674239272427;
        Fri, 20 Jan 2023 10:27:52 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l15-20020a05600c4f0f00b003d9df9e59c4sm3300334wmq.37.2023.01.20.10.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 10:27:51 -0800 (PST)
Message-ID: <b007d54e-737f-b0cc-2fb3-45a06d5fa044@linaro.org>
Date:   Fri, 20 Jan 2023 19:27:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 1/3] thermal/acpi: Add ACPI trip point routines
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
 <20230113180235.1604526-2-daniel.lezcano@linaro.org>
 <CAJZ5v0jDF9qrQAQM1AhT-Q4A3Nzyht9XxZoZyS1afoAPt1h_=A@mail.gmail.com>
 <e4468710-1336-847e-89e4-51c745a0a79b@linaro.org>
 <CAJZ5v0gdXJuNr9jUm6rPdPCuBjc8jwgcZQwtyxurd-jr50btLw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gdXJuNr9jUm6rPdPCuBjc8jwgcZQwtyxurd-jr50btLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 20/01/2023 19:15, Rafael J. Wysocki wrote:
> On Fri, Jan 20, 2023 at 7:08 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Rafael,
>>
>>
>> On 19/01/2023 14:15, Rafael J. Wysocki wrote:
>>
>> [ ... ]
>>
>>>> +static int thermal_acpi_get_temperature_object(struct acpi_device *adev,
>>>> +                                              char *object, int *temperature)
>>>
>>> So this would become thermal_acpi_get_temp_object(). or even
>>> thermal_acpi_get_temp() because it really returns the temperature
>>> value.
>>>
>>> I also don't particularly like returning values via pointers, which is
>>> entirely avoidable here, because the temperature value obtained from
>>> the ACPI control methods must be a positive number.
>>>
>>> So I would make it
>>>
>>> static int thermal_acpi_get_temp(struct acpi_device *adev, char *object_name)
>>> {
>>
>> We are converting decikelvin -> millicelsius. Even it is very unlikely,
>> the result could be less than zero (eg. -1°C). We won't be able to
>> differentiate -ENODATA with a negative value, no ?
>>
>> In the future, it is possible we will have to deal with cold trip points
>> in order to warm a board. May be we should don't care for now ?
> 
> My point is that the ACPI specification mandates that the return
> values be in deciK and so always non-negative.

I understand that but the code does:

static int thermal_acpi_get_temp(struct acpi_device *adev, char 
*object_name)
{
	...

	return deci_kelvin_to_millicelsius(temp);
}

All the callers do:

...

         ret = thermal_acpi_get_temp(adev, name);
         if (ret < 0)
		return ret;
	/* This could be an error
	 * or negative millicelsius temperature
	 */

	/* here we already have millicelsius */
         trip->temperature = ret;
...

So I guess we want to do:

...

         ret = thermal_acpi_get_temp(adev, name);
         if (ret < 0)
		return ret;

	/* we convert here instead in thermal_acpi_get_temp() */
         trip->temperature = deci_kelvin_to_millicelsius(ret);
...

Sounds good ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

