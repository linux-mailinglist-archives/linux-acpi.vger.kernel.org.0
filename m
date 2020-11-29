Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F862C78F5
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Nov 2020 12:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgK2Lpw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 29 Nov 2020 06:45:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387475AbgK2Lpw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 29 Nov 2020 06:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606650265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slJJEEbmDh3vvjhZs0GJlf8EjXfcfYNdcj8ThLPhrpM=;
        b=aY2Ye2RiZpNkM0iNvKhY+htgWUcO/mjFlo+Emnakg0uA6za96t7NVyPO6D8b/RbMLrZGzo
        hmXvT7v78nFO3WoolZ0o1KIEo6KkctMAapYWlGxCBN5vxOTMyp5WQ31HNxfa6GI8s95Ky1
        aOzt6kAne2hQ7ZCz565DzgOeQsvzD5A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-jSvl2bdlMQStnMKwIb9SeQ-1; Sun, 29 Nov 2020 06:44:23 -0500
X-MC-Unique: jSvl2bdlMQStnMKwIb9SeQ-1
Received: by mail-ed1-f71.google.com with SMTP id g1so5026319edk.0
        for <linux-acpi@vger.kernel.org>; Sun, 29 Nov 2020 03:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=slJJEEbmDh3vvjhZs0GJlf8EjXfcfYNdcj8ThLPhrpM=;
        b=S70CMQmN+fKZzmsCYGn0POvGHvjhjoTJrTcncvGaAoR8jVqxQEIfWZjfEm7T/DP8oY
         9PL8CHikgOvO3CXX5yJMNl6Ag8IWCeyFmS/mwHJKcZtmPH42EYH0+iTlGKByuqsdLbCZ
         sCTMOYQH7nLt3RXZbn7lfY6txvHwdmoMgzCz6H+5/Zf4ZHlMHUFYYeWbreB40AO4sMMW
         IjbYcjUjyBbVg1eTRsyrCe2NC7f0qseAIaTaEse9U0Psad7lGkxJh97F0U5whJycAHPA
         WQdxPnct3jqYkkp2Czl6/SZuD/m490DSUMar3Vh+qipn751PONeaRVuRS9cUgIeWeCAH
         Qvqw==
X-Gm-Message-State: AOAM5307mnMD9OLRv/139MYQLKeHXqgttU2qdbpjvhn4YndFf18mvYR1
        OvbfyRq2gSm+xSw+D8j5yv0BP1wkqC5NaAynTjRRQStU7uz21qNrHj6tZ6aB3o0FD0duc9HLZER
        the7qgIPcO/NaOtbSvmRvzQ==
X-Received: by 2002:aa7:d1c2:: with SMTP id g2mr10856804edp.8.1606650261727;
        Sun, 29 Nov 2020 03:44:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4KtJojlIH0/0TCr6HjwxcXOivaK5Cki1hLs05N74t191TPt9ITv2JDmg4uMuCQKyskWYssQ==
X-Received: by 2002:aa7:d1c2:: with SMTP id g2mr10856792edp.8.1606650261614;
        Sun, 29 Nov 2020 03:44:21 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id dk14sm7199855ejb.97.2020.11.29.03.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 03:44:20 -0800 (PST)
Subject: Re: [External] Re: [PATCH v4 2/3] ACPI: platform-profile: Add
 platform profile support
To:     Mark Pearson <markpearson@lenovo.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "mario.limnociello@dell.com" <mario.limnociello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201126165143.32776-1-markpearson@lenovo.com>
 <20201126165143.32776-2-markpearson@lenovo.com>
 <faa32924-f53f-b3fd-3f24-3848f45b67e1@redhat.com>
 <tvhsHrDOOP32PZfdoiajK4HUiE7pV3yfxAjHkied_GvQd3tPUQXxfPAI0P84ovCJjmNYib68twP2_ESRc-fyoUzUAJkTvWsobXdWfJGW74s=@protonmail.com>
 <79f67d13-0422-d9f0-3014-a6339f591a25@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <093d1d21-ddf7-20d4-7031-5252c60db1ef@redhat.com>
Date:   Sun, 29 Nov 2020 12:44:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <79f67d13-0422-d9f0-3014-a6339f591a25@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/29/20 2:19 AM, Mark Pearson wrote:
> 
> 
> On 2020-11-28 10:37 a.m., Barnabás Pőcze wrote:
>> Hi
>>
>>
>> 2020. november 28., szombat 15:08 keltezéssel, Hans de Goede írta:
>>
>>> [...]
>>>> +static_assert(ARRAY_SIZE(profile_names) == platform_profile_perform+1);
>>>
>>> It would be better to add an extra member/entry at the end of the enum
>>> named platform_profile_no_profiles; and then use that instead of
>>> platform_profile_perform+1. Also see below where I use this too.
>>>
>>
>> I'm not sure if it's just me, but when I read "no_profiles", then "number of probiles"
>> is not the first thing that comes to mind, maybe _end, _last, _max, etc.
>> would be harder to mistake for something else? What do you think?
>>
> FWIW - my vote would be platform_profile_last, it just seems to fit well when reading the code.

I'm fine with platform_profile_last, or iow please feel free to paint this
bikeshed in any color you like :)

Regards,

Hans

