Return-Path: <linux-acpi+bounces-228-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4E17B0A33
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8D919280EBA
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7546B3C69C
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C660450DF
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 15:39:11 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E00A3AB9
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 08:37:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3231dff4343so5037946f8f.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 08:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695829065; x=1696433865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+c41Z29h1pZ9sFJu8iZns80gRGUweaCHUdE5sjhlKV0=;
        b=KtQF4pW03iIWPv5xPYwQV3QLNvnjhueUvM2vS3aE6Yd5En5CgQX13jRnb3pSKx201y
         DPfHcA8wXaSaFh/O8bD7sj58+RyOyrbypD+h2/BJnwZF5ssJS4EswYWdLE/6HmOZPR55
         M2jDaO+2z2zYHzyI7nJM0o4mjFE5YSm8XKtiDbEbbiFYuYErsZxIcYYZE+mtSLMp0L2K
         KhiNzgKH+QRzdb/aCaBuBetesVDsSfgdiKT+3ectSM91o5pcVTaGHrLH3QPfFnTlshZ1
         cPANNNTUO48O89Ftu+2dVshtV/8V+qz+t6VghlKzFtybjM1DG859irxtwMTd8XoBAWfd
         a7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695829065; x=1696433865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+c41Z29h1pZ9sFJu8iZns80gRGUweaCHUdE5sjhlKV0=;
        b=adhC8t9cL3Sp+CJbF05O+Kgy1lSfMLYYr/entRa37HrMxJx+3pzNHqCWxsC5ILHLyI
         6KZf68ZTEF0SYA8LTthdjtdU3v85mC3LneYuaXF18KAJCOQjT+HUUoBBJTs3+fF0zzEN
         zQm0+Uck+FD8wfmBwjlXr2NeQ7jOwHa/b5wwxRd0wtQpCG53Lr+ZEc2tMf1Z3IOfrDzj
         weNL2ZJkxNyxgfn7K0PK/eBZV9ItyD23AXSgnSMSXtQDG3dGgvmsJXQrF7euxEjQgaJq
         VRnJlvZ31RbcGFiNNs8GM7iUyxlALSziFMcNFyvFdhHLXv7yI7MPwRYL8PzuKlxj1c5w
         zwxQ==
X-Gm-Message-State: AOJu0Yy6rNWpVHEYyPpfN0EYNajA3jAwOWC9RatYHuctQgcczdcf8ClB
	w6oXFzOkL2ZmvmJh9YPcXdyAyQ==
X-Google-Smtp-Source: AGHT+IFBJnn51g+Nws/rADxL0hMPtAm9b/lnLL6DtiDmGTQrfdC3KSFioHmMnuI5UekqIq4rYxqbaw==
X-Received: by 2002:adf:f50f:0:b0:319:5234:5c92 with SMTP id q15-20020adff50f000000b0031952345c92mr1737140wro.35.1695829065420;
        Wed, 27 Sep 2023 08:37:45 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id x17-20020a5d6511000000b0031fd849e797sm17354482wru.105.2023.09.27.08.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 08:37:45 -0700 (PDT)
Message-ID: <d4bdea97-1e92-6422-01c4-bf7caca4ea45@linaro.org>
Date: Wed, 27 Sep 2023 17:37:44 +0200
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
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
References: <1957441.PYKUYFuaPT@kreacher> <1882755.CQOukoFCf9@kreacher>
 <3c9f7b7d-a9ca-79ae-4e64-367a82f953bc@linaro.org>
 <CAJZ5v0ifXSWd4QL+j-=8OBr1aQr0WAeMBGYtis_gkHJDBLeWMg@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0ifXSWd4QL+j-=8OBr1aQr0WAeMBGYtis_gkHJDBLeWMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 27/09/2023 17:06, Rafael J. Wysocki wrote:
> On Wed, Sep 27, 2023 at 5:00 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 21/09/2023 19:54, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Make get_trip_level() access the thermal zone's trip table directly
>>> instead of using __thermal_zone_get_trip() which adds overhead related
>>> to the unnecessary bounds checking and copying the trip point data.
>>>
>>> Also rearrange the code in it to make it somewhat easier to follow.
>>>
>>> The general functionality is not expected to be changed.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>    drivers/thermal/gov_fair_share.c |   22 ++++++++++------------
>>>    1 file changed, 10 insertions(+), 12 deletions(-)
>>>
>>> Index: linux-pm/drivers/thermal/gov_fair_share.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/gov_fair_share.c
>>> +++ linux-pm/drivers/thermal/gov_fair_share.c
>>> @@ -21,23 +21,21 @@
>>>     */
>>>    static int get_trip_level(struct thermal_zone_device *tz)
>>>    {
>>> -     struct thermal_trip trip;
>>> -     int count;
>>> +     const struct thermal_trip *trip = tz->trips;
>>> +     int i;
>>>
>>> -     for (count = 0; count < tz->num_trips; count++) {
>>> -             __thermal_zone_get_trip(tz, count, &trip);
>>> -             if (tz->temperature < trip.temperature)
>>> +     if (tz->temperature < trip->temperature)
>>> +             return 0;
>>> +
>>> +     for (i = 0; i < tz->num_trips - 1; i++) {
>>> +             trip++;
>>> +             if (tz->temperature < trip->temperature)
>>>                        break;
>>>        }
>>
>> Is it possible to use for_each_thermal_trip() instead ? That would make
>> the code more self-encapsulate
> 
> It is possible in principle, but this is a governor which is regarded
> as part of the core, isn't it?
> 
> So is an extra overhead related to using a callback (which may be
> subject to retpolines and such) really justified in this case?

 From my POV, all trip points browsing should be replaced by 
for_each_thermal_trip() so any change in the future in how we go through 
the existing thermal trips will impact one place.

If the routine needs to be optimized, that is something we can do also 
(may be an inline the callback?)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


