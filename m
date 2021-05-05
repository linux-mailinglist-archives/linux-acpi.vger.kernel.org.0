Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BB4373C1D
	for <lists+linux-acpi@lfdr.de>; Wed,  5 May 2021 15:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhEENPq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 May 2021 09:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231459AbhEENPp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 May 2021 09:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620220488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+rdX2/xU7dnWzBcR/NeP2uhRQgGwc4z1b9NGYO9W/M=;
        b=Khl2RHNl45uLWnAKrymEzftvmKKJXXdACiorThvLDBGepnALV4p+PSYPywhdB6h6bKp8Kb
        k6CNw2jopvjjF0XyK2ix8LN3MBXn38k/VPSJoJklvUiqTBmHNfYKDzSYMxmdcUXrQkQ5d8
        h/CUvp4rKueXFbIOH9Th5096unX+XIs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-_SYsoiJVPQm7QiUuqSGcTQ-1; Wed, 05 May 2021 09:14:46 -0400
X-MC-Unique: _SYsoiJVPQm7QiUuqSGcTQ-1
Received: by mail-ej1-f71.google.com with SMTP id w23-20020a1709061857b029039ea04b02fdso427697eje.22
        for <linux-acpi@vger.kernel.org>; Wed, 05 May 2021 06:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h+rdX2/xU7dnWzBcR/NeP2uhRQgGwc4z1b9NGYO9W/M=;
        b=T3VHGnOFwXZFiwUX8Y66oRYtINfuASZEfSpx+vibzYrH63o6iD2QFACBywn0k+B+49
         8fxbFd0qqOyMjgGVVzP//4IcVTvLgu16YMCc4oboqGiQtrzqDyFBKm7K74vAFPNrCFIa
         bPVE2SLs4JwHF8ixVkY5LL+WIh148n1H4N0/IKzsdSvUx+X4UkYEfRd0JAcPod9u8JSc
         t+8uuEcs+KAoVe/4IlEArI2q+SFdUu2FQORxJKkmkvAzLHCuEb7srt0ZAGrSWNmSt117
         vqPwXdDekooTKpuG9iIHKO2+ODWOJ65rZUvSHyXzCeioFWT2Vw/K5cYnvQb/J3x59P/J
         jHBw==
X-Gm-Message-State: AOAM531vyA54W7CuZIBThwTtYQLtQWItbv/cc6+o5iR4S+1hmF+EQ0Z9
        muU7GUkY+delU/CvomOYBzK1DVLo/L0phi5nW+DceYllBPJU75bGb+GlsUDMOHMnA13UKywMVDA
        wz1yh9Mfxf63PaNcR5tPyoQ==
X-Received: by 2002:a05:6402:17ef:: with SMTP id t15mr29679362edy.385.1620220485236;
        Wed, 05 May 2021 06:14:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqxaMLu3mF+WTG3/w2rO8MD1gl+pQhUaqHGEI0vpeY8MpQYl2jtRmuYDstSH5gqmadI9tQbQ==
X-Received: by 2002:a05:6402:17ef:: with SMTP id t15mr29679347edy.385.1620220485037;
        Wed, 05 May 2021 06:14:45 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bu26sm2950854ejb.30.2021.05.05.06.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 06:14:44 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: Add missing LPS0 functions for AMD
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Liang, Prike" <Prike.Liang@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Marcin Bachry <hegel666@gmail.com>
References: <20210504221140.593002-1-alexander.deucher@amd.com>
 <BYAPR12MB2693F7109BC8E7EF9F672A16E25A9@BYAPR12MB2693.namprd12.prod.outlook.com>
 <22c1b9a9-8167-5e4f-6ff7-278c386cc423@redhat.com>
 <CADnq5_POX7j1_BDh24uQ=gFfJU43TQW49Q32LUoisqg3hW8t+A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <949c563d-abbd-a777-db02-93778c09e547@redhat.com>
Date:   Wed, 5 May 2021 15:14:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CADnq5_POX7j1_BDh24uQ=gFfJU43TQW49Q32LUoisqg3hW8t+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/5/21 3:11 PM, Alex Deucher wrote:
> On Wed, May 5, 2021 at 9:10 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 5/5/21 12:33 AM, Limonciello, Mario wrote:
>>> [AMD Public Use]
>>>
>>>> Subject: [PATCH] platform/x86: Add missing LPS0 functions for AMD
>>>
>>> Rafael might be willing to fix it up on commit, but if you end up needing to re-spin
>>> I think technically this subsystem prefix to match other stuff committed to this file
>>> should be:
>>>
>>> "ACPI: PM: s2idle:"
>>
>> Ack, please get the subject next right time. I was about the put this in a folder
>> with patches to apply to the pdx86 kernel tree once 5.13-rc1 is out, but this
>> should not go upstream through the pdx86 tree at all.
> 
> Do you want me to resend with the corrected subject?  What tree does
> this need to go through?

That might be helpful, I think that like how to subject made me
think "Oh I need to pick this one up" it will probably to the
opposite for Rafael.

It should go through Rafael's ACPI/PM tree:

[hans@x1 linux]$ scripts/get_maintainer.pl -f drivers/acpi/x86/s2idle.c
"Rafael J. Wysocki" <rjw@rjwysocki.net> (supporter:ACPI)
Len Brown <lenb@kernel.org> (supporter:ACPI)
linux-acpi@vger.kernel.org (open list:ACPI)
linux-kernel@vger.kernel.org (open list)

Regards,

Hans



>>>> These are supposedly not required for AMD platforms,
>>>> but at least some HP laptops seem to require it to
>>>> properly turn off the keyboard backlight.
>>>>
>>>> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
>>>>
>>>> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Marcin Bachry <hegel666@gmail.com>
>>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>
>>>> Dropping patch 2/2 for now.  This patch fixes several
>>>> systems and doesn't appear to cause any issues.
>>>>
>>>>  drivers/acpi/x86/s2idle.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>>>> index 2b69536cdccb..2d7ddb8a8cb6 100644
>>>> --- a/drivers/acpi/x86/s2idle.c
>>>> +++ b/drivers/acpi/x86/s2idle.c
>>>> @@ -42,6 +42,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
>>>>
>>>>  /* AMD */
>>>>  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-
>>>> 932122d37721"
>>>> +#define ACPI_LPS0_ENTRY_AMD         2
>>>> +#define ACPI_LPS0_EXIT_AMD          3
>>>>  #define ACPI_LPS0_SCREEN_OFF_AMD    4
>>>>  #define ACPI_LPS0_SCREEN_ON_AMD     5
>>>>
>>>> @@ -408,6 +410,7 @@ int acpi_s2idle_prepare_late(void)
>>>>
>>>>      if (acpi_s2idle_vendor_amd()) {
>>>>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
>>>> +            acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
>>>>      } else {
>>>>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
>>>>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
>>>> @@ -422,6 +425,7 @@ void acpi_s2idle_restore_early(void)
>>>>              return;
>>>>
>>>>      if (acpi_s2idle_vendor_amd()) {
>>>> +            acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
>>>>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
>>>>      } else {
>>>>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
>>>> --
>>>> 2.30.2
>>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> 

