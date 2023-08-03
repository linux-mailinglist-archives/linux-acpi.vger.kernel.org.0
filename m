Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180D676EF46
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Aug 2023 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbjHCQUS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Aug 2023 12:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbjHCQUQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2023 12:20:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADE830C7
        for <linux-acpi@vger.kernel.org>; Thu,  3 Aug 2023 09:20:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso12110945e9.0
        for <linux-acpi@vger.kernel.org>; Thu, 03 Aug 2023 09:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691079607; x=1691684407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRKQYTjj0CFOrgdAwpq3qfe246RqaR7qimHx7YtH0AI=;
        b=rfU25oyJ5QoiyIrcdinKTQcvapOerJX5BqnFjnQpVQHbkp3MM4MocxKjaFxAxHzI2N
         qZZ/RixXllNlks7AaOLxXBdezK0/7du/QVkuaOsWnh0FtMl1tip5G912x8oPSt3kpxSk
         HKypbYZDeVjvCX8RAAsQzuBG/LdLK62Kkil+PhiL9DiZBdHhXbYGlIb+d2eZBjKUsmSJ
         Z6WeeTGLI+Ggd3E/EL/fDv7tcBz7bS/ELiZOS+XrAAQK8IRUFV6/finvC69IKtZME/2n
         QHB82cSDsv9ywMtOZddwOJU/5NNn32bB1wIk45FyjeNKRjPu4VSsnaohe9bL3Q51pzHZ
         m6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691079607; x=1691684407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRKQYTjj0CFOrgdAwpq3qfe246RqaR7qimHx7YtH0AI=;
        b=gdubeD0TQ8cbWFiZ1C+mYEAJnh8B0ozszqWqgdws2plLdiOpb2mfgZwRbBA4qwgEVw
         7qoJeoCP2xlq8yYPx7At26DErhZI37S9vqTVGoauKNotpCm8zxWMZQ8C4ZGB1j65RZOX
         G1ENfTF++aHSqQEpMWq/8L9L+O4DEFryeXc9UUgOnKUETYKK/mkRf0J93McNl5sOjwtQ
         EFxWzrpkqp5y/HH+Ge3IMkises5DC7FwF2gS5y8++UBuJ+5t/R5DXi8D5QyCkficcxF3
         kC6A/QBFfDlCi11egCXwJjgBFqyMGeI1cdqTSc9z4S7bgXN5frptpekyRGhnVeysH+zE
         8mdg==
X-Gm-Message-State: ABy/qLZyBHrRJ8IGFKbBZaTofdQPD3/WWy7jrStA/QYej4TWjHJihNHK
        SDByKB73Lm4x9+Y8XTTOvCKmsdppqpk6YFSx6UU=
X-Google-Smtp-Source: APBJJlFuSIMsUxPfUpP2Xh3pzAoQZtkbLuQoXlzV0OaC7q2hZAp49HqZGKoHQA2B8Jnvwc6gANb07w==
X-Received: by 2002:a5d:457c:0:b0:314:385d:6099 with SMTP id a28-20020a5d457c000000b00314385d6099mr8174596wrc.35.1691079607325;
        Thu, 03 Aug 2023 09:20:07 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w14-20020adfec4e000000b003141e629cb6sm214343wrn.101.2023.08.03.09.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 09:20:06 -0700 (PDT)
Message-ID: <b4e474f9-79e8-534b-509e-12eb5995fa0c@linaro.org>
Date:   Thu, 3 Aug 2023 18:20:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/8] thermal: core: Add mechanism for connecting trips
 with driver data
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <4501957.LvFx2qVVIh@kreacher>
 <2d0315d4-35b4-84db-4dcb-c9528abad825@linaro.org>
 <CAJZ5v0iQDOsTOqWFvbf5nom-b3-pbHPRzJQC-1DM9eoh=0AKjg@mail.gmail.com>
 <eb279cf1-0605-3b87-5cb6-241a91977455@linaro.org>
 <CAJZ5v0i48=oawDJHoaHhiZRaO_CJokKsOHyNvu2v4PUbS6CH_Q@mail.gmail.com>
 <f8029547-6851-7e0c-00e6-4963ccbc2702@linaro.org>
 <CAJZ5v0gDQMNSeEU1J7ooJk4Ec=Hw_JuZAtL5k215v7Lf67iTgg@mail.gmail.com>
 <5c93d78d-835e-c740-280b-9d76456aaeda@linaro.org>
 <CAJZ5v0gtkZTwt-qP0uwvTJNx8cpO1o1esmW9BfVxB67X3Yt++w@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gtkZTwt-qP0uwvTJNx8cpO1o1esmW9BfVxB67X3Yt++w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 03/08/2023 16:15, Rafael J. Wysocki wrote:
> On Thu, Aug 3, 2023 at 3:06 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 02/08/2023 18:48, Rafael J. Wysocki wrote:
>>
>> [ ... ]
>>
>>>> Let me check if I can do something on top of your series to move it in
>>>> the ACPI driver.
>>>
>>> It doesn't need to be on top of my series, so if you have an idea,
>>> please just let me know what it is.
>>>
>>> It can't be entirely in the ACPI driver AFAICS, though, because
>>> trips[i] need to be modified on updates and they belong to the core.
>>> Hence, the driver needs some help from the core to get to them.  It
>>> can be something like "this is my trip tag and please give me the
>>> address of the trip matching it" or similar, but it is needed, because
>>> the driver has to assume that the trip indices used by it initially
>>> may change.
>>
>> May be I'm missing something but driver_ref does not seems to be used
>> except when assigning it, no?
> 
> It is used on the other side.  That is, the value assigned to the trip
> field in it is accessed via trip_ref in the driver.
> 
> The idea is that the driver puts a pointer to its local struct
> thermal_trip_ref into a struct thermal_trip and the core stores the
> address of that struct thermal_trip in there, which allows the driver
> to access the struct thermal_trip via its local struct
> thermal_trip_ref going forward.
> 
> Admittedly, this is somewhat convoluted.
> 
> I have an alternative approach in the works, just for illustration
> purposes if nothing else, but I have encountered a problem that I
> would like to ask you about.
> 
> Namely, zone disabling is not particularly useful for preventing the
> zone from being used while the trips are updated, because it has side
> effects.  First, it triggers __thermal_zone_device_update() and a
> netlink message every time the mode changes, which can be kind of
> overcome. 

Right

> But second, if the mode is "disabled", it does not actually
> prevent things like __thermal_zone_get_trip() from running and the
> zone lock is the only thing that can be used for that AFAICS.
 >
> So by "disabling" a thermal zone, did you mean changing its mode to
> "disabled" or something else?

Yes, that is what I meant.

May be the initial proposal by updating the thermal trips pointer can 
solve that [1]

IMO we can assume the trip point changes are very rare (if any), so 
rebuilding a new trip array and update the thermal zone with the pointer 
may solve the situation.

The routine does a copy of the trips array, so it can reorder it without 
impacting the array passed as a parameter. And it can take the lock.

We just have to constraint the update function to invalidate arrays with 
a number of trip points different from the one initially passed when 
creating the thermal zone.

Alternatively, we can be smarter in the ACPI driver and update the 
corresponding temperature+hysteresis trip point by using the 
thermal_zone_set_trip() function.

[1] 
https://lore.kernel.org/all/20230525140135.3589917-5-daniel.lezcano@linaro.org/


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

