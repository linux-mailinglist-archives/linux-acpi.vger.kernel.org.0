Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2EB30EF7E
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 10:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhBDJTz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 04:19:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233799AbhBDJTy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2021 04:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612430307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qF2RHRLJSzWg3l+Fnd4fPAG6Xy9PgbFqFuHn4ZaX+3k=;
        b=aHk64ldtFS9Q99HBE+/SdNDohPtPnVKO3boxHt9GeUZ9bTJ8gr/rrfhSo3jW2OXgUFziGe
        O4g5EMz9ALctI5mSXz7MIIFE1KHlo9H50KWdSFXJRO5lJtjBtDQm//THfKQp3OM2BCVZ4u
        1TG5Y0Vy1eF1CPp8cxqfuOkxeaDQ8W8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-10xLVROpMnC4_FDtwEHy1A-1; Thu, 04 Feb 2021 04:18:26 -0500
X-MC-Unique: 10xLVROpMnC4_FDtwEHy1A-1
Received: by mail-ej1-f71.google.com with SMTP id yd11so2170618ejb.9
        for <linux-acpi@vger.kernel.org>; Thu, 04 Feb 2021 01:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qF2RHRLJSzWg3l+Fnd4fPAG6Xy9PgbFqFuHn4ZaX+3k=;
        b=SVAjKnNLLH+QYOGPKdMWqZuyasfGF7qmxZaWCuNj4ckwI3OQwHbLdWUXQfajSj86PS
         4bvMT2uE80Ft1VoymHvwKWNG/w0uS/iOhgxn7jOdP+rUpKAMS0hxZFyD8tu81BMbHw+3
         +BeYSpcnTxfrlt2Koem+f0cAHvP+l1cG+uijlMC9QFY9A7vs6Bsd6d3VFOOLU7NyYlDH
         4DHR3SyUfi22Z+5KTrKiTiswHT5zzMb0pzR6ZPOMig4FfQ74ueI30Bt/AP75wORqGFHY
         tOVT9YjHfiZjqk3iuGgQ1SgAJAFWrWCTdck+iJoKqzQBu5jnkDRLB2UdeG6N5IXdu3DN
         upCg==
X-Gm-Message-State: AOAM531EK+TzNcYRv4VAYc5KOOPR2IdNPxsagFv+XqiyYYuSawGX+RZL
        caEMzNKB47z62Ngn7zxFcmttCYW5RUr3x6/ULgnANuWMv7ggkHrRARnDaeMf7UOg23pyEaadFl9
        6ndUo1kNIhSsGqB1nzrbwmw==
X-Received: by 2002:a05:6402:34c1:: with SMTP id w1mr7152489edc.147.1612430305033;
        Thu, 04 Feb 2021 01:18:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyykVXT9oSm72NonBeZE72TJTdnE4L4pjtbYCQx0vFl9j2nHIYKkpyJEipTP5nihZ9Mx6OYng==
X-Received: by 2002:a05:6402:34c1:: with SMTP id w1mr7152473edc.147.1612430304827;
        Thu, 04 Feb 2021 01:18:24 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id z22sm2134416edb.88.2021.02.04.01.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 01:18:24 -0800 (PST)
Subject: Re: [External] Re: [PATCH v9] platform/x86: thinkpad_acpi: Add
 platform profile support
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     mgross@linux.intel.com, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hadess@hadess.net, njoshi1@lenovo.com
References: <markpearson@lenovo.com>
 <20210111162237.3469-1-markpearson@lenovo.com>
 <39c453b5-c6f2-7e45-ee82-64344e800711@redhat.com>
 <ab6d9113-2bc6-3c02-bc08-65a0aa217325@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <48752174-26c3-fb83-ddf6-01bf2cafd1ab@redhat.com>
Date:   Thu, 4 Feb 2021 10:18:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <ab6d9113-2bc6-3c02-bc08-65a0aa217325@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/3/21 3:46 PM, Mark Pearson wrote:
> On 02/02/2021 09:49, Hans de Goede wrote:
>> Hi,
>>
>> On 1/11/21 5:22 PM, Mark Pearson wrote:
>>> Add support to thinkpad_acpi for Lenovo platforms that have DYTC
>>> version 5 support or newer to use the platform profile feature.
>>>
>>> This will allow users to determine and control the platform modes
>>> between low-power, balanced operation and performance modes.
>>>
>>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
>>
>> Now that the acpi/platform_profile changes have landed I have
>> merged this patch (solving a trivial conflict caused by the
>> keyboard_lang changes).
>>
>> Thank you for your patch, I've applied this patch to my review-hans 
>> branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>>
>> Note it will show up in my review-hans branch once I've pushed my
>> local branch there, which might take a while.
>>
>> Once I've run some tests on this branch the patches there will be
>> added to the platform-drivers-x86/for-next branch and eventually
>> will be included in the pdx86 pull-request to Linus for the next
>> merge-window.
>>
> Thanks Hans - sounds great.
> Let me know if you find any issues or need any extra tests running.

So the build-bots have found 2 issues:

1. Some symbols which are not exported need to be marked static (I will fix this myself,
that is the easiest / fastest):

drivers/platform/x86/thinkpad_acpi.c:10081:5: warning: no previous prototype for 'dytc_profile_get' [-Wmissing-prototypes]
drivers/platform/x86/thinkpad_acpi.c:10095:5: warning: no previous prototype for 'dytc_cql_command' [-Wmissing-prototypes]
drivers/platform/x86/thinkpad_acpi.c:10133:5: warning: no previous prototype for 'dytc_profile_set' [-Wmissing-prototypes]

2. This is a bigger problem, this is the result of a random-config test-build and I'm
pretty sure that the issue is that acpi_platform was build as a module while
thinkpad_acpi was builtin and builtin code cannot rely on modules.

drivers/platform/x86/thinkpad_acpi.c:10186: undefined reference to `platform_profile_notify'
drivers/platform/x86/thinkpad_acpi.c:10226: undefined reference to `platform_profile_register'
drivers/platform/x86/thinkpad_acpi.c:10246: undefined reference to `platform_profile_remove'

There are 2 ways to solve this:

1. Change

#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)

to:

#if IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE)

Which will disable the platform-profile support in acpi_thinkpad in the above scenario.

or.

2. Drop the #if IS_ENABLED(...) and add a

        depends on ACPI_PLATFORM_PROFILE

To the THINKPAD_ACPI Kconfig symbol.


I personally think 2. would be slightly better as it ensures that platform-profile
support is always available when thinkpad_acpi is build, hopefully leading to less
confusing bug-reports about it sometimes not working.

If you can let me know what you want, then I can fix this locally too and get
the fix in place before the merge-window opens.

Regards,

Hans

