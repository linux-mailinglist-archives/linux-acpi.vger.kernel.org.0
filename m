Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80372C0BCB
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 14:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgKWNbH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 08:31:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389285AbgKWNbC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Nov 2020 08:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606138260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjCIGmT30UO7uPtIFc7YccL/BA4NYEGEdAE+WDts9Io=;
        b=UC0LQm2XXE1L8RFgDcTybrskUYRDc9bUUsrEzqJamdibb9HwUX+2KkqnWc5ZUwuRULc7Ni
        GeLbKJB1ywtaqezLt0EVapwSIfWP3QOpEFGHCn1y+utTeEeCJOUKvnxUKJjTLNyRnbZg3c
        sT/GX6ngwyLWVd6Jlp4pIZX0zJOdfug=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-MhBBR7-5OrCowq11p2NtqQ-1; Mon, 23 Nov 2020 08:30:57 -0500
X-MC-Unique: MhBBR7-5OrCowq11p2NtqQ-1
Received: by mail-ed1-f70.google.com with SMTP id g1so6662306edk.0
        for <linux-acpi@vger.kernel.org>; Mon, 23 Nov 2020 05:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UjCIGmT30UO7uPtIFc7YccL/BA4NYEGEdAE+WDts9Io=;
        b=HDHhvxlvy0/XrcNwRj59hYMEL4eygNIAfJksyAwIObjrGCnvEp+eN6DYFRum+5OI16
         Zjl2rkhiN94QHdkejR02cVnH6YwwpF5FVf1uoNSosLRVvF7NTgRxkE8i4Q7NrtidLayz
         8qxR2d0DVMrvHbty1NO/BVThv1XkR4DHA2Lnkm0YEoVD1hr/KMZNu3l4ChzeBh+UsjVc
         4ExuoX0ZaHKKHZdMZNUWX2gJwmr+y9B8BW6vhNnt1G+aQP6MUbRkuWHR0STgPbaQ5aIt
         Xs/JCDHWOBTLWw8ODi79NSyl6GI7iyT3+J6+QlrD7YIhaT4n80ETJyXXqoqar/T1LCCx
         iBbw==
X-Gm-Message-State: AOAM532NJFWjYp6naTjwSI8VV1FsCTFuDTbGXeBk4W9xEjP3/6x/4aFp
        /s0QolrjOWl47A1TwyNU5+nZ/0TUhx0TB9o2uXYHncf/ITTPYedkESY6cx+NXT0GOXNhVEXniQu
        SmE0ZZ4sdW5E8oOp2Ftt6wSBvU2qFzcX/0Ac/EOUIJaZ+D8cCvN0CJY4OqqzDPcXvn4HwECH8nw
        ==
X-Received: by 2002:a17:906:3187:: with SMTP id 7mr44885252ejy.225.1606138256317;
        Mon, 23 Nov 2020 05:30:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4u6vJz9DcxutreTT8EEr5Uri6f3SElBr71H7VYDGESgxNPwdbOKM/kyC8//e0tDIv1KtHHQ==
X-Received: by 2002:a17:906:3187:: with SMTP id 7mr44885232ejy.225.1606138256009;
        Mon, 23 Nov 2020 05:30:56 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id b15sm5019275edv.85.2020.11.23.05.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 05:30:55 -0800 (PST)
Subject: Re: [PATCH 5/7] ACPI: scan: Add support for deferring adding devices
 to the second scan phase based on the _DEP list
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20201121203040.146252-1-hdegoede@redhat.com>
 <20201121203040.146252-6-hdegoede@redhat.com>
 <CAJZ5v0i+Oz4meRo+YQw_LRZXReo9APh4kpqAP4Nby8_HExrrJg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f43be417-8919-6b4b-f554-32d71d81f8c0@redhat.com>
Date:   Mon, 23 Nov 2020 14:30:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i+Oz4meRo+YQw_LRZXReo9APh4kpqAP4Nby8_HExrrJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/23/20 1:17 PM, Rafael J. Wysocki wrote:
> On Sat, Nov 21, 2020 at 9:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The current solution, of deferring adding of some devices because they
>> need access during the OpRegions of other devices while they are added,
>> is not very generic.
>>
>> And support for making the decision to defer adding a device based on
>> its _DEP list, instead of the device's HID being in a fixed list of HIDs
>> to defer, which should be a more generic way to deal with this.
> 
> Thanks a lot for working on this!

You're welcome.

> I'll have a more thorough look at the series later this week, stay tuned.

Ok.

>> Since this is likely to cause issues on some hardware, this new method will
>> only be used if the new acpi.defer_scan_based_on_dep kernel commandline
>> option is set to 1.
> 
> However, I already can say that I don't like the new command line option.

You don't like the name, or you don't like having a commandline option for this?

Anyways I'll wait till you have taken a closer look.

Regards,

Hans


> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/scan.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 407c8536568b..9927036bfe77 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -31,6 +31,11 @@ extern struct acpi_device *acpi_root;
>>
>>  #define INVALID_ACPI_HANDLE    ((acpi_handle)empty_zero_page)
>>
>> +static int defer_scan_based_on_dep = -1;
>> +module_param(defer_scan_based_on_dep, int, 0444);
>> +MODULE_PARM_DESC(defer_scan_based_on_dep,
>> +       "Use new scan-scheme deferring addition of devices with non empty _DEP list (-1=auto, 0=no, 1=yes)");
>> +
>>  static const char *dummy_hid = "device";
>>
>>  static LIST_HEAD(acpi_dep_list);
>> @@ -1657,11 +1662,45 @@ void acpi_device_add_finalize(struct acpi_device *device)
>>
>>  static bool acpi_should_defer_add(acpi_handle handle, struct acpi_device_info *info)
>>  {
>> +       struct acpi_handle_list dep_devices;
>> +       acpi_status status;
>> +       int i;
>> +
>>         if (!acpi_check_defer_add || !info)
>>                 return false;
>>
>> -       if (acpi_info_matches_hids(info, acpi_defer_add_hids))
>> +       if (!defer_scan_based_on_dep)
>> +               return acpi_info_matches_hids(info, acpi_defer_add_hids);
>> +
>> +       /*
>> +        * We check for _ADR here to avoid deferring the adding of the following:
>> +        * 1. PCI devices
>> +        * 2. ACPI nodes describing USB ports
>> +        * Note checking for _ADR catches more then just these cases...
> 
> s/then/than/
> 
>> +        */
>> +       if (info->valid & ACPI_VALID_ADR)
>> +               return false;
>> +
>> +       status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
>> +       if (ACPI_FAILURE(status))
>> +               return false;
>> +
>> +       for (i = 0; i < dep_devices.count; i++) {
>> +               struct acpi_device_info *dep_info;
>> +               bool ignore;
>> +
>> +               status = acpi_get_object_info(dep_devices.handles[i], &dep_info);
>> +               if (ACPI_FAILURE(status))
>> +                       continue;
>> +
>> +               ignore = acpi_info_matches_hids(dep_info, acpi_ignore_dep_hids);
>> +               kfree(dep_info);
>> +
>> +               if (ignore)
>> +                       continue;
>> +
>>                 return true;
>> +       }
>>
>>         return false;
>>  }
>> @@ -2251,6 +2290,10 @@ int __init acpi_scan_init(void)
>>         struct acpi_table_stao *stao_ptr;
>>         struct acpi_deferred_dev *deferred_dev, *tmp;
>>
>> +       /* Currently no devices are known which need _dep based scan deferral */
>> +       if (defer_scan_based_on_dep == -1)
>> +               defer_scan_based_on_dep = 0;
>> +
>>         acpi_pci_root_init();
>>         acpi_pci_link_init();
>>         acpi_processor_init();
>> --
>> 2.28.0
>>
> 

