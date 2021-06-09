Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04DF3A0E32
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 09:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbhFIIAa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 04:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237387AbhFIIAa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 04:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623225515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TeCNph8OZtZG4opgIbk0YAJ4mqWUbs74XBxGnIpMlLE=;
        b=e2jaTBW7edBABneLloU0wWTCsr5eJs4xBuI0XFRFIMN7fIxIVliaRFuJicRwL9IgnMbLb9
        oLLfI5u8/pcV+dKRexBBhhDOj2cXotMt0qz1SSahEQWNDoZtAg3ojq2jxRgDqO+XexdLey
        LHmeuHiC8SjwJp05/Z0lxt5PmDBw/V4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-5A3T3w-lP4KNXJw-I0MZ7Q-1; Wed, 09 Jun 2021 03:58:34 -0400
X-MC-Unique: 5A3T3w-lP4KNXJw-I0MZ7Q-1
Received: by mail-ej1-f71.google.com with SMTP id p5-20020a17090653c5b02903db1cfa514dso7670504ejo.13
        for <linux-acpi@vger.kernel.org>; Wed, 09 Jun 2021 00:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TeCNph8OZtZG4opgIbk0YAJ4mqWUbs74XBxGnIpMlLE=;
        b=ZhXlO4KBF4GPcLV4+nO6FKoRY3is5OlxfKVx+HsdYJipDrgFXtuk4FgdYPJsY+gP5L
         WNB7JOYG7HGm43D8Cx64g556i/9AGbYBHHOeQaO6WbtWL4pJLKx1GQ7lK+ogewzkTqkv
         axv7gBXrU0ciBaiqce6ROWd7v+SBJMBwDeOANTVD0RP/WShT8v9K9utc7SpxJQfHRVWC
         r+8Zm82NZGfhNLyk1qf9CArasuSI2jWvxDmUaArjbPK+VbJXIYAMT8kMiqBmWcGFkGgt
         0PMf+gXoUiKqA/cjgKs3d2XTE9Dam8TbRhZ2XvjQ1i2vqXuiyAHm5njVfHs/Ndh8ftKo
         YCHw==
X-Gm-Message-State: AOAM533yfZMOrfl6PNZnVGbY5xJmJ/AX2mcAnFk5EEwfJvVFFePKKuxf
        YouEEQdimN0pPcIlXUyuQgid4O2ctiDe1ngR9TT/H80i8dRH/BmJ7rf5ggFXrmMP1vgVDfAjRzz
        WRUnK8JmxF2WKT8a5CUm0j5eubwApmLzZhuLMj9suK3UnUQZEiGKJ3EvJK3/KwSl+OgaWbXM3QQ
        ==
X-Received: by 2002:aa7:cd9a:: with SMTP id x26mr10197871edv.185.1623225513011;
        Wed, 09 Jun 2021 00:58:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8PsWg81Bn2XplgChMgGeXuO6Ais/jzroU6Rdmqavgs8ssyQgDLjicd7T2Yj4i6/62fDB8HQ==
X-Received: by 2002:aa7:cd9a:: with SMTP id x26mr10197850edv.185.1623225512712;
        Wed, 09 Jun 2021 00:58:32 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r2sm731337ejc.78.2021.06.09.00.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 00:58:32 -0700 (PDT)
Subject: Re: [PATCH] ACPI: Pass the same capabilities to the _OSC regardless
 of the query flag
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mario Limonciello <mario.limonciello@outlook.com>,
        linux-acpi@vger.kernel.org
References: <YL+Gqh9dT06SBLCx@lahna.fi.intel.com>
 <20210608163810.18071-1-mika.westerberg@linux.intel.com>
 <d0bdb868-95c9-8908-06e1-01f1364f12a0@redhat.com>
Message-ID: <3b58902f-fda3-d957-2e9c-204e82b2f570@redhat.com>
Date:   Wed, 9 Jun 2021 09:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d0bdb868-95c9-8908-06e1-01f1364f12a0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/8/21 7:10 PM, Hans de Goede wrote:
> Hi,
> 
> On 6/8/21 6:38 PM, Mika Westerberg wrote:
>> Commit 719e1f561afb ("ACPI: Execute platform _OSC also with query bit
>> clear") makes acpi_bus_osc_negotiate_platform_control() not only query
>> the platforms capabilities but it also commits the result back to the
>> firmware to report which capabilities are supported by the OS back to
>> the firmware
>>
>> On certain systems the BIOS loads SSDT tables dynamically based on the
>> capabilities the OS claims to support. However, on these systems the
>> _OSC actually clears some of the bits (under certain conditions) so what
>> happens is that now when we call the _OSC twice the second time we pass
>> the cleared values and that results errors like below to appear on the
>> system log:
>>
>>   ACPI BIOS Error (bug): Could not resolve symbol [\_PR.PR00._CPC], AE_NOT_FOUND (20210105/psargs-330)
>>   ACPI Error: Aborting method \_PR.PR01._CPC due to previous error (AE_NOT_FOUND) (20210105/psparse-529)
>>
>> In addition the ACPI 6.4 spec says following [1]:
>>
>>   If the OS declares support of a feature in the Support Field in one
>>   call to _OSC, then it must preserve the set state of that bit
>>   (declaring support for that feature) in all subsequent calls.
>>
>> Based on the above we can fix the issue by passing the same set of
>> capabilities to the platform wide _OSC in both calls regardless of the
>> query flag.
>>
>> While there drop the context.ret.length check which was wrong to begin
>> with (as the length is number of bytes not elements). This is already
>> checked in acpi_run_osc() that also returns an error in that case.
>>
>> [1] https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#sequence-of-osc-calls
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213023
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1963717
>> Fixes: 719e1f561afb ("ACPI: Execute platform _OSC also with query bit clear")
>> Cc: Mario Limonciello <mario.limonciello@outlook.com>
>> cc: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> ---
>>  drivers/acpi/bus.c | 21 +++++++--------------
>>  1 file changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index be7da23fad76..61e8c02595ac 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -336,26 +336,19 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>>  		return;
>>  	}
>>  
>> -	/*
>> -	 * Now run _OSC again with query flag clear and with the caps
>> -	 * supported by both the OS and the platform.
>> -	 */
>> +	/* Now run _OSC again with query flag clear */
>>  	capbuf[OSC_QUERY_DWORD] = 0;
>> -	capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
>> -	kfree(context.ret.pointer);
> 
> This kfree needs to be moved up, rather then be completely removed
> and you are still leaving 1 of the unnecessary length checks in place.
> 
> I've added this fixup on top, to fix both these issues:
> 
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -330,11 +330,7 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>  	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
>  		return;
>  
> -	capbuf_ret = context.ret.pointer;
> -	if (context.ret.length <= OSC_SUPPORT_DWORD) {
> -		kfree(context.ret.pointer);
> -		return;
> -	}
> +	kfree(context.ret.pointer);
>  
>  	/* Now run _OSC again with query flag clear */
>  	capbuf[OSC_QUERY_DWORD] = 0;
> 
> I'll ask the reporters of:
> https://bugzilla.kernel.org/show_bug.cgi?id=213023
> https://bugzilla.redhat.com/show_bug.cgi?id=1963717
> 
> To test the (fixed-up) patch, so that they can confirm if this indeed
> fixes things.

I've received confirmation from 2 users that this patch (with the fixup)
fixes this. Can send a v2 with the fixup squashed in for Rafael to pick up?

Regards,

Hans



>>  
>>  	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
>>  		return;
>>  
>>  	capbuf_ret = context.ret.pointer;
>> -	if (context.ret.length > OSC_SUPPORT_DWORD) {
>> -		osc_sb_apei_support_acked =
>> -			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
>> -		osc_pc_lpi_support_confirmed =
>> -			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
>> -		osc_sb_native_usb4_support_confirmed =
>> -			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
>> -	}
>> +	osc_sb_apei_support_acked =
>> +		capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
>> +	osc_pc_lpi_support_confirmed =
>> +		capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
>> +	osc_sb_native_usb4_support_confirmed =
>> +		capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
>>  
>>  	kfree(context.ret.pointer);
>>  }
>>

