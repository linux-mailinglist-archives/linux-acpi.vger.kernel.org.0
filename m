Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FA66D4200
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Apr 2023 12:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjDCK23 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Apr 2023 06:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjDCK21 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2023 06:28:27 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9746849DE
        for <linux-acpi@vger.kernel.org>; Mon,  3 Apr 2023 03:28:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v1so28787671wrv.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Apr 2023 03:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680517700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbYw3BcOTVr2vYhRZ5kcfhDg4Aj2okCKbHzUaqITdJ0=;
        b=vpYIu8vv5RQlDe51YqL4pyLVV9yKIOxRirsKGqXxk5UruYtnK55UbCTVHd9uhkNnKs
         7f00qU2pMymYbYzq1SEzJ+LMXKexScBaD1pZrVf3zR/PCQsgX1jEU84J0BjeosKgQPuo
         jJeb+1ow+Z/FL3Kqp7m9lA2vOme1fol+d2+kuX3PNEqtNKF8v5fqxciotbzzNMIUeiIQ
         XI/vievUtO8vwPtbSe/Z8k0ide950seKi6YqxqnD78adxydbXdW8fwNbxqi8KV07JDcN
         cnQj7u2Yh91TnKvinPz88XNLVgIkZ0yIHPNy3lOzTYZHgyY29NaoxoG6vifxrgTKvN1X
         pXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680517700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbYw3BcOTVr2vYhRZ5kcfhDg4Aj2okCKbHzUaqITdJ0=;
        b=Kw8BtKD+8rM8AeA8J5UVZEcLCF+3REQqwBbw1RhJIXCOtEXJkd+lw29esME38LWVUS
         vY7f1eMJpMVpmejJGNqoSXAH+Gq1R9JuWPWzRWX140dEUcfhtiEeinH3CTyr0Styvt8i
         wapH3XBOyJ9YgcpWH9G+s/cyz7TDtAZvDwWjvTWdyY36ReQrKkXVy2MgkNGbO++gMBEG
         f4Q+C4Q/eonEBkXBHlTMQo3fD0klh7HMBgWPb7NRGZOuES57y+e/qiyO1euabIhxuN8U
         IBJrDzskXxwOIWUA880fQ731IgVhbjhBVkezxQ3binHu+T5E0EZWHOpjC1u9AE231aFi
         eHyA==
X-Gm-Message-State: AAQBX9fVp2QJgZ31wUO7cHbQ4vu0Yeq6Gb/UMYSuthqxH/NbqbUT2wgJ
        GnHsQJ6q65KkypknsmTRc+1HBLAE5wqgZVMhDhM=
X-Google-Smtp-Source: AKy350Ym8q6iCQz7IACYnjf8nMBRh3FCcRF5gQHC6QtL5ZQW0E5F3j1CcmyZ2hA/rIzNr5GHxnwESw==
X-Received: by 2002:adf:e7c2:0:b0:2cf:ea5f:6de with SMTP id e2-20020adfe7c2000000b002cfea5f06demr3426533wrn.14.1680517699957;
        Mon, 03 Apr 2023 03:28:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8052:c9eb:6b69:e69a? ([2a05:6e02:1041:c10:8052:c9eb:6b69:e69a])
        by smtp.googlemail.com with ESMTPSA id c13-20020adffb0d000000b002e5e7ee11besm8922298wrr.94.2023.04.03.03.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:28:19 -0700 (PDT)
Message-ID: <38a5a6e0-2af8-8365-b20e-8494a4efcb0c@linaro.org>
Date:   Mon, 3 Apr 2023 12:28:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 00/11] Generic trip points for ACPI
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
 <CAJZ5v0gkOfbWZWzsTKLBD9C8TaAp0qmTv0L0X7E3fBSLyMUEcQ@mail.gmail.com>
 <a4da1cb6-80a5-a3a9-72e6-62e5ad810509@linaro.org>
 <CAJZ5v0hWE_gRHj7_zZmu=firwTOnF1X4j59hrV_iy045R8GeeQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hWE_gRHj7_zZmu=firwTOnF1X4j59hrV_iy045R8GeeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Hi Rafael,

thanks for taking the time to go through the series.

On 31/03/2023 18:04, Rafael J. Wysocki wrote:
> On Fri, Feb 3, 2023 at 10:47 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 03/02/2023 19:46, Rafael J. Wysocki wrote:
>>> On Fri, Feb 3, 2023 at 6:34 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> This series introduces the generic trip points usage in the thermal ACPI
>>>> driver. It provides a step by step changes to move the current code the
>>>> generic trip points.
>>>>
>>>> I don't have an ACPI platform, the code is not tested.
>>>
>>> What's the purpose of sending this now, then?  Should it be an RFC?
>>> I'm certainly going to treat it this way.
>>
>> I did basic testing on a x86 laptop having critical trip points but
>> nothing else.
>>
>> I understand it can be treated as RFC.
> 
> So I've gone through this series now and I'm not entirely convinced.
> 
> While I agree with the general direction (using a generically-defined
> trip point representation instead of a home-grown one is definitely an
> improvement IMV and I understand the idea of putting all trip points
> into an array which then will allow the overhead in the core to be
> reduced), I don't quite like the way the change is carried out in the
> series.  In particular, I'd prefer to avoid introducing "temporary"
> structures that get removed entirely by subsequent patches in the
> series - this makes the intermediate steps sort of pointless and
> doesn't really help to understand what's going on (quite on the
> contrary even, AFAIAC).

I'm surprised it is less understandable. The ACPI trip points structure 
have nested and duplicated descriptions. The resulting code goes through 
these structures depending on the type.

In order to convert the code to deal with the same structure, the first 
patches are moving the structures into a single one, so can more easily 
replace one by another.

Before doing a full conversion to the trip point changes, they co-exist.

> I also don't quite like changes like the
> temperature unit conversion in patch 9.

Is it the conversion itself or how the changes are done?

> Personally, I would do it differently.  I would start with changing
> the ACPI thermal driver to use the generic trip point definition (with
> possible extensions) 

Do you mean the adding a 'private' field in the trip point structure:

struct thermal_trip {
         int temperature;
         int hysteresis;
         enum thermal_trip_type type;
	void *data;
};

?

> instead of the home-grown one and continue from
> there.  I think that this would be more straightforward, but I guess I
> just need to try it out myself.
> 
> Beyond that, there is a question regarding the desired behavior of the
> whole framework in some cases, like when the trip points get modified
> by firmware and the kernel gets a notification to re-enumerate them.

Yes, I think we should introduce a new function:

thermal_zone_device_trips_update(struct thermal_zone_device *tz,
	struct thermal_trip *trips, int nr_trips);

> This may happen in ACPI-enabled systems in general, so the ACPI
> thermal driver needs to be prepared for it, but not just the driver -
> the thermal core needs to be prepared for it too.  So the question is
> how it all should work in principle.

I recently sent a patch when passing the thermal zone parameters where 
the structure is kmemdup'ed and stored in the thermal zone device 
structure [1].

[1] 
https://lore.kernel.org/all/20230307133735.90772-11-daniel.lezcano@linaro.org/

That allows to initialize the thermal zone device and let the core code 
thermal framework to do stuff with it.

The caller does not have to keep the thermal zone device parameter 
structure, it can create it on the stack and the forget it.

IMO, we should do the same for the thermal trip array. So the thermal 
framework kmemdups it, reorders it if needed. The thermal trip array is 
then just an initialization array and once it is passed to 
thermal_zone_device_register_with_trips(), the driver should not use it 
anymore but use the thermal framework API.

Having the private data in the thermal trip structure will allow the 
ACPI to store the trip id, so the trip array can be reordered.

>  AFAICS, not only the trip
> temperature can change, but the ordering of them can change as well
> such that the passive trip point lies between the active ones, for
> example.  So when this happens, is the core going to tear down all of
> the trip point representation in sysfs and re-create it from scratch,
> even if it may be used by user space (that may not be prepared for the
> re-enumeration) at that point, or is it sufficient to simply make the
> trip point attributes return different values when the corresponding
> trip points change?

IMO, the function thermal_zone_device_trips_update() can take care of:
  - delete the sysfs entries
  - reorder the trip points,
  - create the sysfs entries
  - notify THERMAL_ZONE_TRIP_CHANGED
  - update the thermal zone

Probably we can move part of the code from 
thermal_zone_device_register() into this function

The userspace should be aware of the THERMAL_ZONE_TRIP_CHANGED event.

However, I'm not sure there is an trip update leading to a change of the 
number of trip points as well as changing the order.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

