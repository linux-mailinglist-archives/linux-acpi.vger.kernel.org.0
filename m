Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88180772A5B
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Aug 2023 18:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjHGQSF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Aug 2023 12:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjHGQR7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2023 12:17:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84B310FC
        for <linux-acpi@vger.kernel.org>; Mon,  7 Aug 2023 09:17:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so39873945e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 07 Aug 2023 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691425074; x=1692029874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIlIjbKDgaIkXBvvVymBj3ZKl60d9D23Kc9LmoR65Aw=;
        b=xVVmmsRGOYQ+2FYP9Btd0rH4ipKU9RFh4BoJQ2pnAMwfnmVsKYQYhYLHZ0HgBXTYVc
         OFTjAvJwbYuSzepjhO+zUEkqcTkQ7PiVGEozx3immf8pASdOmoLe07HBWyuHBCiRwPXM
         sRHnD2FLy1hb7GZZsoMkZtYCdXcFjVwz8ZvBoTBXxY8n+WZJAvEZ6PVNxIbhwVmRaa01
         X1XUO0QeG8JwzVbil2uscnaiC6saJeaSjOeFfivZ4SJeE8c6mNMth0N1djcilQSkKd1k
         jzG7DYmltb7Eiggv+kzXq88caUQtTFn1MdM2Ba/vDt17DI5BnLuW/iLWyrz5vDp2NmLg
         t+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425074; x=1692029874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIlIjbKDgaIkXBvvVymBj3ZKl60d9D23Kc9LmoR65Aw=;
        b=Ts4j9TGQb4HPwtr9xp1Gt6vxYSmIgSDPFfCdaReSmG1krkQeHMwwrmAxEKZqGzIlSV
         PaHkdWXAGuBw1/pUX8A1d4MfAC9zZEOAITQgph6s749ocp14GCt3//SIb86GTL2CHDGu
         9xGyO07/OasHdwjSHhHKT4mATIaVJc0U8L8dATb0BpPeSnf9szivF1/KI9p3PgZZdb/f
         jhK6wM+e8io3jZTBP/RzJAIjJoDE5bMOlAsEvhp1kZXG02a93lB5XORpA6p7w/T7lbY5
         SE74BZ70m1Iu7xqwxOGeW3nAqgAV6O3S2zvt3wb2Cn8fNXBByh9GBTgFH/N1if+GZ17l
         RNmw==
X-Gm-Message-State: AOJu0Yz4dgRDRD/sQB/kDMQT7X3qkSB9UQ8dZsd+o8JPJZfY4NdX6I7K
        KUHH5+Iom19raH86ur5wjY5XRw==
X-Google-Smtp-Source: AGHT+IEqnS0WrTpKPU3i8gGLFEeRUSszxMtBlM4KNrLLBcc1OUyDQq5/H21/hkuDhAR/d+6KCzYfBg==
X-Received: by 2002:adf:f608:0:b0:316:ff0e:81b6 with SMTP id t8-20020adff608000000b00316ff0e81b6mr6056372wrp.32.1691425074215;
        Mon, 07 Aug 2023 09:17:54 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id j6-20020adfff86000000b003175f00e555sm10952018wrr.97.2023.08.07.09.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 09:17:53 -0700 (PDT)
Message-ID: <4bfabfce-574b-ed52-2956-d0d2b9502e60@linaro.org>
Date:   Mon, 7 Aug 2023 18:17:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 04/10] thermal: core: Add
 thermal_zone_update_trip_temp() helper routine
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <4878513.31r3eYUQgx@kreacher>
 <1967710.PYKUYFuaPT@kreacher>
 <f47b7e17-7ec6-4c19-9db1-c1a2e1ad66b6@linaro.org>
 <CAJZ5v0iNOD9FW0deZYvfjmB8Us+7KjTNnB8Fkm=nnVJ6a82EZQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iNOD9FW0deZYvfjmB8Us+7KjTNnB8Fkm=nnVJ6a82EZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 07/08/2023 17:40, Rafael J. Wysocki wrote:
> On Mon, Aug 7, 2023 at 1:34 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 04/08/2023 23:05, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Introduce a helper routine called thermal_zone_update_trip_temp() that
>>> can be used to update a trip point's temperature with the help of a
>>> pointer to local data associated with that trip point provided by
>>> the thermal driver that created it.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> New patch in v4.
>>>
>>> ---
>>>    drivers/thermal/thermal_trip.c |   37 +++++++++++++++++++++++++++++++++++++
>>>    include/linux/thermal.h        |    4 ++++
>>>    2 files changed, 41 insertions(+)
>>>
>>> Index: linux-pm/drivers/thermal/thermal_trip.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_trip.c
>>> +++ linux-pm/drivers/thermal/thermal_trip.c
>>> @@ -180,3 +180,40 @@ int thermal_zone_set_trip(struct thermal
>>>
>>>        return 0;
>>>    }
>>> +
>>> +/**
>>> + * thermal_zone_update_trip_temp - Update the trip point temperature.
>>> + * @tz: Thermal zone.
>>> + * @trip_priv: Trip tag.
>>> + * @temp: New trip temperature.
>>> + *
>>> + * This only works for thermal zones using trip tables and its caller must
>>> + * ensure that the zone lock is held before using it.
>>> + *
>>> + * @trip_priv is expected to be the value that has been stored by the driver
>>> + * in the struct thermal_trip representing the trip point in question, so it
>>> + * can be matched against the value of the priv field in that structure.
>>> + *
>>> + * If @trip_priv does not match any trip point in the trip table of @tz,
>>> + * nothing happens.
>>> + */
>>> +void thermal_zone_update_trip_temp(struct thermal_zone_device *tz,
>>> +                                void *trip_priv, int temperature)
>>> +{
>>> +     int i;
>>> +
>>> +     lockdep_assert_held(&tz->lock);
>>> +
>>> +     if (!tz->trips || !trip_priv)
>>> +             return;
>>> +
>>> +     for (i = 0; i < tz->num_trips; i++) {
>>> +             struct thermal_trip *trip = &tz->trips[i];
>>> +
>>> +             if (trip->priv == trip_priv) {
>>> +                     trip->temperature = temperature;
>>> +                     return;
>>> +             }
>>> +     }
>>> +}
>>> +EXPORT_SYMBOL_GPL(thermal_zone_update_trip_temp);
>>
>> This function would imply the comparator is always trip->priv but if we
>> want another comparison eg. trip->priv->id, that won't be possible.
>>
>> Actually, I think you can reuse an existing function with a simple
>> change, for_each_thermal_trip() located in thermal_core.h.
> 
> for_each_thermal_trip() is only defined in tools/lib/thermal/thermal.c
> AFAICS, but this one could actually work, so I can copy that
> definition to somewhere else.
> 
> But I suppose that you mean __for_each_thermal_trip() which won't
> work, because it makes a copy of the trip and passes that to the
> callback, but the callback would need to update the temperature of the
> original trip.
> 
> It would work if it passed the original trip to the caller, so I can
> add something like that.

As there is no user of this function yet, I think you can change that to 
use the trip array instead of the __thermal_zone_get_trip(). This one 
was used to have a compatibility with thermal zones using get_trip_* ops 
but that is not really needed and with your series only one driver will 
remain before dropping these ops.

>> The changes would be renaming it without the '__' prefix and moving it
>> in include/linux/thermal.h.
>>
>> Then the comparison function and the temperature change can be an ACPI
>> driver specific callback passed as parameter to for_each_thermal_zone
> 
> I guess you mean for_each_thermal_trip().

Yes, __for_each_thermal_trip()

> As per the above, not really, but I can do something along these lines.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

