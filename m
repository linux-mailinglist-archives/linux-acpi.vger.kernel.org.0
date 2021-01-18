Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C276B2FA4BB
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 16:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405828AbhARP1o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 10:27:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405821AbhARP1k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Jan 2021 10:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610983572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dMzXjiQjEPYFOo6AtaVtJ1kcDh5p275fQW5WvHPO2L0=;
        b=f7ZfV3h4MiVEefdtvAVTBx2+xzNLOdKMvjaBuNS1qB4rBiHC44tIxywMdDxMgtx0e8VS9J
        PWN7rwmg7waSvWCiA2zxukG9VwyOXBepJZEf3bBo8y7A4oAjSAmtPkcYvmoLOXrz61flTM
        uJneaFIE7U3I8lCF89PlMKZh8OiyC50=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-Uvxpx5AeOQaM-HwgJ_8WtQ-1; Mon, 18 Jan 2021 10:26:09 -0500
X-MC-Unique: Uvxpx5AeOQaM-HwgJ_8WtQ-1
Received: by mail-ed1-f72.google.com with SMTP id g14so8039131edt.12
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jan 2021 07:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dMzXjiQjEPYFOo6AtaVtJ1kcDh5p275fQW5WvHPO2L0=;
        b=VomKip6s7B4O2Wk6OaWjYJqELndwR/aQGjnLL6q9SyiYBn/dUcTX4loYf8/ERaMI7j
         ujC/yQ14juItZuKSPLJIyMdLfIQwE64Tn0/EyAIIC7BD7J+9kdKkdrnKCqPD8pL6PjSA
         WOem3DjFFXKdD03prT//T6wBmKDRTEIXPbUjPCq0M07WJCX52byIArq2vG/jl0BAGiQw
         S+dSH+5tE7L0xmFditxA6+ARzP/dO1SMQUOuwFbufsknEDMkMH6p5K8umTajqnY+JnCu
         DfIWYWgG4/4NXkbEtdb+kapXc9/gB0V33v8aq19zA+GUuLPrBtbvEohv4nNOXkdDPuQI
         JGuw==
X-Gm-Message-State: AOAM530MvSP5YHPbUpNbgxwDRk54W5o7gbDRiJPCqucrzsuuDFbdRA8H
        M5MkhHRCN/DVj4l2w/ImZV7lHGb8yclDbokRujqoc0XkzCum6hE+LPDf92Z1pJz7hN29eOFyD2g
        6HDmPcnThMpbqyJYne8zHFQ==
X-Received: by 2002:a05:6402:134b:: with SMTP id y11mr27154edw.88.1610983567982;
        Mon, 18 Jan 2021 07:26:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwF49o+cmHwf7i/a7bjhOMU/XdEU5zICm4lAbBHNnk8POocRIVlXS+Kxss5+2xBcHEXFtlGdg==
X-Received: by 2002:a05:6402:134b:: with SMTP id y11mr27143edw.88.1610983567834;
        Mon, 18 Jan 2021 07:26:07 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id p3sm10680297edh.50.2021.01.18.07.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 07:26:06 -0800 (PST)
Subject: Re: [PATCH v1 1/2] ACPI: scan: Rearrange memory allocation in
 acpi_device_add()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <3494203.VBaj39JGmp@kreacher> <2999734.9HhbEeWEHR@kreacher>
 <8218eff4-6629-ac20-ec3f-a66aad445bb6@redhat.com>
 <CAJZ5v0hv2FX2wtuwu9Jd1zZiGut9kUzQvCH5vXLMyFpqvvYOkA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bbcf5658-0097-9641-a790-ba65fcdaffe7@redhat.com>
Date:   Mon, 18 Jan 2021 16:26:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hv2FX2wtuwu9Jd1zZiGut9kUzQvCH5vXLMyFpqvvYOkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/18/21 4:16 PM, Rafael J. Wysocki wrote:
> On Sat, Jan 16, 2021 at 1:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 1/14/21 7:46 PM, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> The upfront allocation of new_bus_id is done to avoid allocating
>>> memory under acpi_device_lock, but it doesn't really help,
>>> because (1) it leads to many unnecessary memory allocations for
>>> _ADR devices, (2) kstrdup_const() is run under that lock anyway and
>>> (3) it complicates the code.
>>>
>>> Rearrange acpi_device_add() to allocate memory for a new struct
>>> acpi_device_bus_id instance only when necessary, eliminate a redundant
>>> local variable from it and reduce the number of labels in there.
>>>
>>> No intentional functional impact.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>  drivers/acpi/scan.c |   57 +++++++++++++++++++++++-----------------------------
>>>  1 file changed, 26 insertions(+), 31 deletions(-)
>>>
>>> Index: linux-pm/drivers/acpi/scan.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/acpi/scan.c
>>> +++ linux-pm/drivers/acpi/scan.c
>>> @@ -621,12 +621,23 @@ void acpi_bus_put_acpi_device(struct acp
>>>       put_device(&adev->dev);
>>>  }
>>>
>>> +static struct acpi_device_bus_id *acpi_device_bus_id_match(const char *dev_id)
>>> +{
>>> +     struct acpi_device_bus_id *acpi_device_bus_id;
>>> +
>>> +     /* Find suitable bus_id and instance number in acpi_bus_id_list. */
>>> +     list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node) {
>>> +             if (!strcmp(acpi_device_bus_id->bus_id, dev_id))
>>> +                     return acpi_device_bus_id;
>>> +     }
>>> +     return NULL;
>>> +}
>>> +
>>>  int acpi_device_add(struct acpi_device *device,
>>>                   void (*release)(struct device *))
>>>  {
>>> +     struct acpi_device_bus_id *acpi_device_bus_id;
>>>       int result;
>>> -     struct acpi_device_bus_id *acpi_device_bus_id, *new_bus_id;
>>> -     int found = 0;
>>>
>>>       if (device->handle) {
>>>               acpi_status status;
>>> @@ -652,38 +663,26 @@ int acpi_device_add(struct acpi_device *
>>>       INIT_LIST_HEAD(&device->del_list);
>>>       mutex_init(&device->physical_node_lock);
>>>
>>> -     new_bus_id = kzalloc(sizeof(struct acpi_device_bus_id), GFP_KERNEL);
>>> -     if (!new_bus_id) {
>>> -             pr_err(PREFIX "Memory allocation error\n");
>>> -             result = -ENOMEM;
>>> -             goto err_detach;
>>> -     }
>>> -
>>>       mutex_lock(&acpi_device_lock);
>>> -     /*
>>> -      * Find suitable bus_id and instance number in acpi_bus_id_list
>>> -      * If failed, create one and link it into acpi_bus_id_list
>>> -      */
>>> -     list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node) {
>>> -             if (!strcmp(acpi_device_bus_id->bus_id,
>>> -                         acpi_device_hid(device))) {
>>> -                     acpi_device_bus_id->instance_no++;
>>> -                     found = 1;
>>> -                     kfree(new_bus_id);
>>> -                     break;
>>> +
>>> +     acpi_device_bus_id = acpi_device_bus_id_match(acpi_device_hid(device));
>>> +     if (acpi_device_bus_id) {
>>> +             acpi_device_bus_id->instance_no++;
>>> +     } else {
>>> +             acpi_device_bus_id = kzalloc(sizeof(*acpi_device_bus_id),
>>> +                                          GFP_KERNEL);
>>> +             if (!acpi_device_bus_id) {
>>> +                     result = -ENOMEM;
>>> +                     goto err_unlock;
>>>               }
>>> -     }
>>> -     if (!found) {
>>> -             acpi_device_bus_id = new_bus_id;
>>>               acpi_device_bus_id->bus_id =
>>>                       kstrdup_const(acpi_device_hid(device), GFP_KERNEL);
>>>               if (!acpi_device_bus_id->bus_id) {
>>> -                     pr_err(PREFIX "Memory allocation error for bus id\n");
>>> +                     kfree(acpi_device_bus_id);
>>>                       result = -ENOMEM;
>>> -                     goto err_free_new_bus_id;
>>> +                     goto err_unlock;
>>>               }
>>
>> When I have cases like this, where 2 mallocs are necessary I typically do it like this:
>>
>>         const char *bus_id;
>>
>>         ...
>>
>>         } else {
>>                 acpi_device_bus_id = kzalloc(sizeof(*acpi_device_bus_id),
>>                                              GFP_KERNEL);
>>                 bus_id = kstrdup_const(acpi_device_hid(device), GFP_KERNEL);
>>                 if (!acpi_device_bus_id || !bus_id) {
>>                         kfree(acpi_device_bus_id);
>>                         kfree(bus_id);
>>                         result = -ENOMEM;
>>                         goto err_unlock;
>>                 }
>>                 acpi_device_bus_id->bus_id = bus_id;
>>                 list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
>>         }
>>
>>         ...
>>
>> So that there is only one if / 1 error-handling path for both mallocs.
>> I personally find this a bit cleaner.
> 
> Yes, that looks better.
> 
> Let me do it this way, but I won't resend the patch if you don't mind.

Not resending is fine.

Regards,

Hans





> 
>> Either way, with or without this change, the patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Thanks!
> 

