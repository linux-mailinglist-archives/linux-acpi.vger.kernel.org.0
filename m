Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E2434D264
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 16:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhC2Oah (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 10:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229822AbhC2OaF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Mar 2021 10:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617028203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUPH6vfpOUO5prDXQMRqWfOCgrbs/AGWz/7DovN3cl0=;
        b=S1Wf9NDkOCN+DAKrtei/2dwnANOqHJmThPWkS0GRAUT6uNhtomC2cqW5hGKXrKVJk5ojaM
        JR3IqDRO8eoftMyo2OjxLgvZiUmgYWC2Jf0QNSMmTqrQGEUtobPaTB6T4Mp4CeIrT9ltxJ
        VVkROJXXYIMB89tvD8XEBKs8e7RjoVo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-KYte2EzUMx2hvWzGfBIerg-1; Mon, 29 Mar 2021 10:30:00 -0400
X-MC-Unique: KYte2EzUMx2hvWzGfBIerg-1
Received: by mail-ed1-f69.google.com with SMTP id v27so8672283edx.1
        for <linux-acpi@vger.kernel.org>; Mon, 29 Mar 2021 07:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZUPH6vfpOUO5prDXQMRqWfOCgrbs/AGWz/7DovN3cl0=;
        b=egtz5d2SX/2WLcO3XG+YsfD0EPICPo4NpH69QkieiDVPuPLNc8gRo6R127OJQE4mp1
         ntszj2P6ia3YJelRc0SeEOdz6cJ/+3QwZVPv0ZA7r8LAg7TFGOVflMvYsEvV632mPd79
         gl+FPpunS4pRXhtI535tvSfd0SWdT4pkVvQyc5pl/WX1wEPRGCXv2+qKitFF95GA6Cj3
         DOSf0ae3I2BN4z4kBCmYEuaGBf/YIi+jiO81sxH+W1TTyT8XDpfWCvtVRChx9vfdPNR0
         zf/fLNevTqgbDIUYNiWCWgfO7N6/4LxOdyG/55oL2IxnU0z9AhdxLpuDHJ65BfpFPudv
         jUrA==
X-Gm-Message-State: AOAM531uCaoOaAWm+qczef7DcGkZmgI+6PDFHHH+B6MEicIBEz0Vhvz7
        1/ZGWWRbUeqHdIxv2M+A+7xkQQfybrSgIrQB8vPwkGJ6SFJYIfYr6X9/aodCIlud7T49MJGqxSU
        i2ZLYq3acshxMiZ95udiywTgCGJzSZtOdUOfT1+64RNw23jK3E036pZ9cu7GVmLLyUQv5I7CQhQ
        ==
X-Received: by 2002:a17:906:2818:: with SMTP id r24mr28692261ejc.502.1617028199360;
        Mon, 29 Mar 2021 07:29:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3ZtoDFKxTDTL56A6guKgAlO7mklUeEi2dV7ZCgqAiKIAs3rDXKCmFnB53x1F9OLzpLLy7aA==
X-Received: by 2002:a17:906:2818:: with SMTP id r24mr28692244ejc.502.1617028199145;
        Mon, 29 Mar 2021 07:29:59 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id sb4sm8417082ejb.71.2021.03.29.07.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 07:29:58 -0700 (PDT)
Subject: Re: [PATCH 1/2] ACPI: scan: Move acpi_scan_dep_init() higher up in
 scan.c
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20210328112000.12502-1-hdegoede@redhat.com>
 <CAJZ5v0inp8KejTtRnK0oOy2n+Ugsf99A7Ohj915JxhcTCN6vPg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <48fddb93-2bfd-8433-b0bc-e53c781dd986@redhat.com>
Date:   Mon, 29 Mar 2021 16:29:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0inp8KejTtRnK0oOy2n+Ugsf99A7Ohj915JxhcTCN6vPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/29/21 2:52 PM, Rafael J. Wysocki wrote:
> On Sun, Mar 28, 2021 at 1:20 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Move acpi_scan_dep_init() higher up in scan.c to avoid needing a forward
>> declaration in the next patch in this set.
>>
>> Fixes: 71da201f38df ("ACPI: scan: Defer enumeration of devices with _DEP lists")
> 
> Well, this doesn't seem applicable here, as the patch shouldn't make a
> practical difference.

Its a pre-req for the actual fix, hence the fixes tag so that it will get
cherry-pick into the same stable-series as the actual fix (assuming the
actual fix gets merged as is).

Regards,

Hans


> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/scan.c | 28 ++++++++++++++--------------
>>  1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 1584c9e463bd..19f8fd6ea17a 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -1655,6 +1655,20 @@ void acpi_device_add_finalize(struct acpi_device *device)
>>         kobject_uevent(&device->dev.kobj, KOBJ_ADD);
>>  }
>>
>> +static void acpi_scan_dep_init(struct acpi_device *adev)
>> +{
>> +       struct acpi_dep_data *dep;
>> +
>> +       mutex_lock(&acpi_dep_list_lock);
>> +
>> +       list_for_each_entry(dep, &acpi_dep_list, node) {
>> +               if (dep->consumer == adev->handle)
>> +                       adev->dep_unmet++;
>> +       }
>> +
>> +       mutex_unlock(&acpi_dep_list_lock);
>> +}
>> +
>>  static int acpi_add_single_object(struct acpi_device **child,
>>                                   acpi_handle handle, int type,
>>                                   unsigned long long sta)
>> @@ -1906,20 +1920,6 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
>>         return count;
>>  }
>>
>> -static void acpi_scan_dep_init(struct acpi_device *adev)
>> -{
>> -       struct acpi_dep_data *dep;
>> -
>> -       mutex_lock(&acpi_dep_list_lock);
>> -
>> -       list_for_each_entry(dep, &acpi_dep_list, node) {
>> -               if (dep->consumer == adev->handle)
>> -                       adev->dep_unmet++;
>> -       }
>> -
>> -       mutex_unlock(&acpi_dep_list_lock);
>> -}
>> -
>>  static bool acpi_bus_scan_second_pass;
>>
>>  static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
>> --
>> 2.30.2
>>
> 

