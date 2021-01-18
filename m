Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B402FA60D
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 17:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406467AbhARQYh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 11:24:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406637AbhARQYc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Jan 2021 11:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610986985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAafjWwP/FMvIs69/XHRDZQCwkkhgX8SYvl2MAL1ZpE=;
        b=IHfIljVBgNa39XOSmLosfns/7rnyydnck3BGPy5EDvv/jHywEIdzLSyD1xSdLw6BDVMzcX
        lmG/CbX4LOz9lbeU1IeYzUUhIDYAdXTa/w6tXf8jjdCtb/ZW+koYg62s7PIBwN1BOmW8PB
        mt3HyaRfM/R5lWj5HvPeXd+jmuqa/Iw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-N324X2z4Otms5RvwhLR8Bg-1; Mon, 18 Jan 2021 11:23:03 -0500
X-MC-Unique: N324X2z4Otms5RvwhLR8Bg-1
Received: by mail-ej1-f71.google.com with SMTP id b18so3344244ejz.6
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jan 2021 08:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KAafjWwP/FMvIs69/XHRDZQCwkkhgX8SYvl2MAL1ZpE=;
        b=hJFkwFgaDzLY+D2Plnfwz2XGo9RbPJWzIuFPrAY+V2i0vkXd/swmIjbjp1Sg1d16W5
         CNXtZeMk1jwBgeEQATsQCfHpKZZ19yETq/wgfDXnM6ZU18DXRdfhHcOg/iiYozT1qnxF
         jAuNcrNZ67cA/C4sQAePBFKOamOZUx9P0kW784hrQ7zEFYURvmtsEyZit4Gut9LVkz/2
         /F0O5g4lzUXFwVcyxEEhcxWs48jIFShGWAtQZU5pMCEUg5Vc2QeTUUxR6FzLNF7ffZI4
         fNC2DOSrCAZUsdvh39jssbbQpa4VFu/oZFd6vjDLHUHjGKXqekyHvYlzHGXVJMrFIrpQ
         xPZQ==
X-Gm-Message-State: AOAM5331nshcUOekFAyIKiM4jXJ8mX2KeJyVSJNTPmRHyGqPc4+/UWkq
        JdGp1H0oLiix1klGCpdt2XWVLw8KipjY0NKm0ZQT+kGKI77DwWBM4d7usWsgSxoHydJsy2+bwBX
        N03gOndObMwyq5xVL4PvT3445G8RBX0w955+itjRKo8aF+BZFtkEa4Gm6QGfnDbvgHUWPM7aFVg
        ==
X-Received: by 2002:a17:906:ce5b:: with SMTP id se27mr306662ejb.57.1610986981461;
        Mon, 18 Jan 2021 08:23:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwF4hJUaeHKJN1NyYbefVZJvtlbseNmxyDfPzG7VRbV9araYEJK+yeTqZN4pQjq3P6P5Es/uQ==
X-Received: by 2002:a17:906:ce5b:: with SMTP id se27mr306645ejb.57.1610986981253;
        Mon, 18 Jan 2021 08:23:01 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id p21sm4231882edx.90.2021.01.18.08.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 08:23:00 -0800 (PST)
Subject: Re: [PATCH] ACPI: scan: Make acpi_bus_get_device() clear the adev ptr
 on error
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20210115215752.389656-1-hdegoede@redhat.com>
 <CAJZ5v0gk0ninRntm508SAgzSrRe5gjZ+-e5ac1h-Cx2reVOSfg@mail.gmail.com>
 <9e548c41-fdb0-4b4b-ccc3-81dba39d4904@redhat.com>
 <CAJZ5v0jHpTHRdneq2+bYa69bpJduzH8nomQM9VbytYaE4t7Ymw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3aab1b8f-1a36-eece-6962-d8d95e8b0126@redhat.com>
Date:   Mon, 18 Jan 2021 17:23:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jHpTHRdneq2+bYa69bpJduzH8nomQM9VbytYaE4t7Ymw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/18/21 5:21 PM, Rafael J. Wysocki wrote:
> On Mon, Jan 18, 2021 at 5:09 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 1/18/21 2:58 PM, Rafael J. Wysocki wrote:
>>> On Fri, Jan 15, 2021 at 10:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Set the acpi_device pointer which acpi_bus_get_device()
>>>> returns-by-reference to NULL on error.
>>>>
>>>> We've recently had 2 cases where callers of acpi_bus_get_device()
>>>> did not properly error check the return value, using the
>>>> returned-by-reference acpi_device pointer blindly, set it to NULL
>>>> so that this will lead to an immediate oops, rather then following
>>>> a pointer to who knows what.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> This should fix the crash reported by Pierre-Louis,
>>
>> Ack, sounds good.
>>
>>> so let me apply it
>>> instead of the two debug changes posted by me
>>> (https://lore.kernel.org/linux-acpi/98e6ed8e-884e-adb4-a146-a66daefa94a7@redhat.com/T/#md5add2fe554a30e3a929d87a66b435f4cc8bf628).
>>
>> Note we should still fix the USB case, my patch will make failure
>> there more obvious, but the code can theoretically still dereference
>> a NULL pointer in drivers/usb/core/usb-acpi.c.
> 
> Because usb_acpi_find_port() checks the acpi_device pointer passed to
> it against NULL, we're safe here as well.

Ah, good :)

>> And we probably also want this change:
>>
>> --- linux-pm.orig/drivers/acpi/scan.c
>> +++ linux-pm/drivers/acpi/scan.c
>> @@ -1867,7 +1867,8 @@ static u32 acpi_scan_check_dep(acpi_hand
>>          * 2. ACPI nodes describing USB ports.
>>          * Still, checking for _HID catches more then just these cases ...
>>          */
>> -       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
>> +       if (!acpi_has_method(handle, "_DEP") || acpi_has_method(handle, "_ADR")
>> +           || !acpi_has_method(handle, "_HID"))
>>                 return 0;
>>
>>         status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
>>
>> To reduce the amount of work we do checking _DEP-s.
> 
> So I was thinking about that, but I'd leave it as is unless we have a
> use case in which looking for _ADR is really necessary.
> 
> In the majority of cases the device objects with both _ADR and _HID
> really are _HID devices and _ADR returns 0.  Of course, that could be
> treated as a special case, but unless it is necessary to add a check
> for this special case, I'd rather avoid doing that.

Ok, that works for me.

Regards,

Hans

