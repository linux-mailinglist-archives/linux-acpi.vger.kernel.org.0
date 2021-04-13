Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AC535DCD7
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Apr 2021 12:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbhDMKxW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Apr 2021 06:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236800AbhDMKxV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Apr 2021 06:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618311181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kj7lvzFyv6+soUbGmIPaXzHpGiYRP68pXRKg78qGEEw=;
        b=GgAa4ERPCE49CrhEqI9ESiuEpl6QGcMvt19Q4QQEz7tBk3rzS1yQDWQBGHnfpwpcqylS3Y
        U23wAEhqasHa/7Hyy1XiXNJiIAEcfOb0phrK9tcMSbokxxICQtvu2Qwu+oxwxaJ6YuIYsk
        I+2hozX8rEXHbzWWw4jztIecxK1Cpfc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-FGXPauZsPPeMXtduRniL1w-1; Tue, 13 Apr 2021 06:52:57 -0400
X-MC-Unique: FGXPauZsPPeMXtduRniL1w-1
Received: by mail-ej1-f70.google.com with SMTP id lb4so2693263ejb.21
        for <linux-acpi@vger.kernel.org>; Tue, 13 Apr 2021 03:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kj7lvzFyv6+soUbGmIPaXzHpGiYRP68pXRKg78qGEEw=;
        b=EfAx4UOimJN66JfTfHj9yFKYRIUEcKqwce75J/quwD/nh0CYFreSjbavWLFybCGltQ
         KuMgEEc8xn4JUZ4t3WhmCAObKN8fioWWPb7XrMKEP/TI1tL8oDR1M8czXfTVlv9jM5Yb
         /nPw/HbMlLRv443jr1nZEuq2RUkIUfrWE+pnwpduG9z6kJ1sXcj8Ks2En4GjvbLkI4kB
         NPU1EaK35DDKjnVLVRDPcb2JlGUEYL0t3a7w/GJEuf5MJrlxyfHYgxOrtOEt/9lWiCg0
         qeNiMlMqg1JlyU0eUoEoScDIPLKCcYd4t3+XcbxNcZNjT8CScumITXzlqMMdYDBRqJSG
         /W2w==
X-Gm-Message-State: AOAM531REMAftQIC17VMRJ01/QpmoDaJtqpcSu6JRa4d7vk3EkATT5+C
        ywOu/rJqLlTbrAX43eY4kExJ3LMEnIYli2/0wOReyBH9a4Xy/jWamlslrA/qHEZNegY3Wuc0ODk
        sfp3DJeHk+0F8zx1LBZlz722PaJKi4R1bSvVVs5IcpCha4q9qmiFvuF1auvL5G8zqvjZIkzgwsw
        ==
X-Received: by 2002:a17:907:d15:: with SMTP id gn21mr30671544ejc.337.1618311176484;
        Tue, 13 Apr 2021 03:52:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNgvMicoZwqFfctctsUgvWv1qrXZ9w6grGt7AZCf6oiKZRqE352pQAWsR+He7lXCt9mNITWQ==
X-Received: by 2002:a17:907:d15:: with SMTP id gn21mr30671524ejc.337.1618311176213;
        Tue, 13 Apr 2021 03:52:56 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id w5sm387284ejc.84.2021.04.13.03.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 03:52:55 -0700 (PDT)
Subject: Re: [5.12 regression] DSDT overriding from initrd no longer works
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
References: <7d941a3c-bced-09cf-27a1-b61f0d20ef4c@redhat.com>
 <CAJZ5v0iLSbfRH9A3EMUTrY5=vPdp=uVOF2XQnWkAbko9NjPqJg@mail.gmail.com>
 <CAJZ5v0gOMZbyD5r+bCL9vD6_NrFz0nAq+eY2QDtxOY4DfsXG6w@mail.gmail.com>
 <273d3ea7-aa74-6556-7fef-fb65b620bc95@redhat.com>
 <CAJZ5v0i=Ahxjnx_K1M+BPDdR-3_v8aBTPVFRg3s+bG9OeaEiwQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <73e67801-0e76-ae64-4e7e-cdb142b5a37a@redhat.com>
Date:   Tue, 13 Apr 2021 12:52:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i=Ahxjnx_K1M+BPDdR-3_v8aBTPVFRg3s+bG9OeaEiwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 4/13/21 11:35 AM, Rafael J. Wysocki wrote:
> On Mon, Apr 12, 2021 at 8:53 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 4/12/21 8:11 PM, Rafael J. Wysocki wrote:
>>> On Mon, Apr 12, 2021 at 8:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>
>>>> On Mon, Apr 12, 2021 at 7:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>
>>>>> Hi Rafael,
>>>>>
>>>>> Sorry about the timing of reporting this regression.
>>>>
>>>> Oh well.
>>>>
>>>>> I just noticed that overriding the DSDT (*) from the initrd will not work in 5.12,
>>>>> this is caused by:
>>>>>
>>>>> commit 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by ACPI tables")
>>>>>
>>>>> This makes the initial acpi_locate_initial_tables() call happen earlier
>>>>> then before, but the acpi_table_upgrade) call in arch/x86/kernel/setup.c is
>>>>> not moved up, so the tables in the initrd are now only parsed and saved
>>>>> after the initial ACPI table scanning has already been done.
>>>>>
>>>>> I guess fixing this might be as easy as moving the acpi_table_upgrade) call
>>>>> higher in arch/x86/kernel/setup.c but I'm not sure if that is save to do.
>>>>
>>>> Why do you think it may not be safe?
>>>
>>> OK, so it won't work in some cases, because acpi_table_upgrade() needs
>>> to be called after reserve_initrd(),
>>
>> Right I notice it was sitting right after reserve_initrd() which made me think
>> that it probably needed to be after that. Sorry I should have mentioned that
>> in my original email.
>>
>>> so I guess the commit above will
>>> need to be reverted.
>>
>> One possible solution which I was wondering about is to modify
>> acpi_table_initrd_scan() to have it call acpi_tb_override_table()
>> instead of acpi_install_table() for existing tables using the matching
>> logic from acpi_table_initrd_override(). But I'm not sure when the
>> parsing of the DSDT is done. If acpi_table_initrd_scan() runs before
>> the first parsing of the DSDT is done then I think that that should work.
>>
>> This might be more 5.13 material though and for 5.12 a revert is
>> probably best.
> 
> The attached change should make it work again, though.  Can you please verify?

I can confirm that the attached change fixes things, thank you.

>> I also just remembered that at least the Intel audio folks rely on
>> DSDT overrides to get some (prototype) boards in their CI to work.
> 
> But they haven't complained so far.

Weird, I'll drop them an email with you in the Cc.

Regards,

Hans

