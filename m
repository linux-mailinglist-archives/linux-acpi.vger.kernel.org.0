Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B862D1854
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 19:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgLGSR1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 13:17:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45155 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbgLGSR0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 13:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607364958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxsOSIymzXVlQ39QrVBpX5I7YBAMJPQTr5ibLnSG5cE=;
        b=GzFLbTMGtQMnrzMnwlDa7oBxN2553efRVIuxVfxxDld+290AmZVhCM7kINxdcHDi8i6ywb
        mtpDOnuoJl9IlQsRX2a0V1Zabj7sghaDAJjA0umCSIVLUUvArJn/Gh7jrmns2cb2KLED+j
        E1JbDvsgILmeBRDTPkukjucvlxVXg+o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203--hx36YesP7ylJqKC7y38xg-1; Mon, 07 Dec 2020 13:15:57 -0500
X-MC-Unique: -hx36YesP7ylJqKC7y38xg-1
Received: by mail-ed1-f69.google.com with SMTP id g25so3837630edu.4
        for <linux-acpi@vger.kernel.org>; Mon, 07 Dec 2020 10:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZxsOSIymzXVlQ39QrVBpX5I7YBAMJPQTr5ibLnSG5cE=;
        b=kn7TAAfKDwtoU9D1rWoLoYthmNUlMJhg4ZlhqIkyw4tnWes6GFoPL0gqJK5j7rXiaP
         qNal6xnnA4TLPkbHQhB8x1Dsg4VERmCUdeApsAbYESrOP0zmfuX3pKO9Wg6LMaXZsowt
         PtKRK+ynn0HuythalMXfRyyzz0k4uYbIB7+4u+C8/Ee9B0mSFxV/mrtICQWrfPQeWe9A
         wpEZHeSHsn7VPt2hTwcHbvxJSxODczg7QsujsvtlcVufHmFAZdSG+pzpJThRs4zTRirZ
         XHZJ0q0MMnEQfVzlJ9RM4O4IGxMQiNCexI2bcDTKd6tjqnN2gul3Vm5f9vRnlxYR71gj
         a5QQ==
X-Gm-Message-State: AOAM532gBnoJv5KVqICy8VE+XuE8p0m1yN0Nk4HhNDic0baOfyTUVs8g
        Fzj9orIBqm1noV5qqbUDpi2QwfDR4uqvbROwqEDOSWas/FbYAHdR+91gX9rqBdqhYQalflfvra2
        dCh317n0KESDhhMfjzGLxqW4C19G5IbOMqK8fOFRfpCq6mSNMdxIVS/DM1m2g+s2NXWEam1KJiA
        ==
X-Received: by 2002:a17:906:33c4:: with SMTP id w4mr19156345eja.380.1607364955863;
        Mon, 07 Dec 2020 10:15:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzi5ybwn8LJld9pJBmkPcngP6s3kLaLkyWcFqtztFLC5cj6rU8/KVx34lbbiopnODvghmkTpg==
X-Received: by 2002:a17:906:33c4:: with SMTP id w4mr19156319eja.380.1607364955470;
        Mon, 07 Dec 2020 10:15:55 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id x15sm14255968edj.91.2020.12.07.10.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 10:15:54 -0800 (PST)
Subject: Re: [PATCH 0/7] ACPI: scan: Split root scanning into 2 steps
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20201121203040.146252-1-hdegoede@redhat.com>
 <00a4b9c2-aca2-4842-3006-720515f262db@redhat.com>
 <CAJZ5v0iP4a_6sSjO2sAgQUZ7T9BWvaV+s_JvYnD4NwdcCY9DMw@mail.gmail.com>
 <10746938.kh9KKrt31x@kreacher>
 <e2bcbee4-78cb-a4f1-41d9-ccb4d3ae0af0@redhat.com>
 <CAJZ5v0hjxo8Osg7pSVeBPe6bdDNAcxHfHFBeMGdLOmhVq-GLzQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <86e2b752-2edd-c6bb-4a16-56d0d1f4d9bd@redhat.com>
Date:   Mon, 7 Dec 2020 19:15:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hjxo8Osg7pSVeBPe6bdDNAcxHfHFBeMGdLOmhVq-GLzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/7/20 6:27 PM, Rafael J. Wysocki wrote:
> On Sat, Dec 5, 2020 at 6:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 12/5/20 4:44 PM, Rafael J. Wysocki wrote:
>>> On Thursday, December 3, 2020 3:27:27 PM CET Rafael J. Wysocki wrote:
>>>> On Thu, Dec 3, 2020 at 10:53 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> [cut]
>>>
>>>>> That indeed is not necessary if you take the entire set and always enable the
>>>>> new behavior instead of using the module option. I guess we could go that route
>>>>> for 5.12, and get it into next as soon as 5.11-rc1 is available for maximum
>>>>> testing.
>>>
>>> I'd prefer to do the whole thing in 5.11-rc and possibly revert something if it
>>> causes problems to occur.
>>
>> Ok, that is you call to make, so that is fine with me.
>>
>>>>> Do you want me to do a new version of the series which drops the acpi_defer_add_hids[]
>>>>> thing and the module option and simply always uses the new behavior?
>>>>
>>>> No, something else.  Stay tuned.
>>>
>>> The patch below illustrates what I'd like to do.  It at least doesn't kill my
>>> test-bed system, but also it doesn't cause the enumeration ordering to change
>>> on that system.
>>>
>>> It really is three patches in one and (again) I borrowed some code from your
>>> patches in the $subject series.
>>
>> Borrowing some of my code is fine, no worries about that. I'm happy as some
>> fix for this gets upstream in some form :)
>>
>>>  [It is on top of the "ACPI: scan: Add PNP0D80
>>> to the _DEP exceptions list" patch I've just posted.]
>>>
>>>
>>> Please let me know what you think.
>>
>> I think this should work fine. I've 2 small remarks inline below, but nothing
>> big / important.
>>
>> My list of kernel things to look into is longer then my available time
>> (something which I assume you are familiar with), so for now I've only taken
>> a good look at your proposed solution and not actually tested it.
>>
>> Let me know if you want me to give this a spin on the device with the _HID
>> issue as is, or if you have something closer to a final version ready
>> which you want me to test.
> 
> I will, thanks!
> 
>>> ---
>>>  drivers/acpi/scan.c |  141 ++++++++++++++++++++++++++++++++++++++++++++--------
>>>  1 file changed, 120 insertions(+), 21 deletions(-)
>>>
>>> Index: linux-pm/drivers/acpi/scan.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/acpi/scan.c
>>> +++ linux-pm/drivers/acpi/scan.c
>>> @@ -1646,17 +1646,77 @@ void acpi_device_add_finalize(struct acp
>>>       kobject_uevent(&device->dev.kobj, KOBJ_ADD);
>>>  }
>>>
>>> -static int acpi_add_single_object(struct acpi_device **child,
>>> -                               acpi_handle handle, int type,
>>> -                               unsigned long long sta)
>>> +/*
>>> + * List of IDs for which we defer enumeration them to the second pass, because
>>> + * some of their methods used during addition depend on OpRegions registered by
>>> + * the drivers for other ACPI devices.
>>> + */
>>> +static const char * const acpi_defer_enumeration_ids[] = {
>>> +     "BCM2E5B", /* Acer SW3-016 bluetooth HID vs GPIO OpRegs */
>>> +     NULL
>>> +};
>>
>> Note that since you defer if there are unmet _DEP-s, this won't be necessary:
>>
>> This list was purely there as a safer way to select devices which to defer,
>> the kernel cmdline option in my patch-set would switch between either using
>> this list, or checking _DEP. Since we are going to fully go for using _DEP
>> now, this can be dropped.
> 
> OK
> 
> If that is the case, I'd prefer to check the _DEP list even earlier,
> possibly in acpi_bus_check_add(), so as to avoid having to evaluate
> _HID or _CID for devices with non-trivial _DEP lists (after taking
> acpi_ignore_dep_ids[] into account) in the first pass.

That is fine by me.

Note that in my non scientific measurement the slowdown of my patch
(with the cmdline option set to using _DEP as base of the decision
to defer or not) was almost non measurable (seemed to be about 10ms)
on a low-power Cherry Trail system. So I don't think that we need
to worry about optimizing this too much.

We currently do evaluate _HID and _CID of all the deps repeatedly,
typically only a few devices are used as deps for most other
devices. So a possible future optimization would be an acpi_device_info
cache (mapping handle-s to device_info) for devices listed as _DEP.
But again, I don't think we need to worry too much about performance
here.

>>> +
>>> +static bool acpi_should_defer_enumeration(acpi_handle handle,
>>> +                                       struct acpi_device_info *info)
>>> +{
>>> +     struct acpi_handle_list dep_devices;
>>> +     acpi_status status;
>>> +     int i;
>>> +
>>> +     if (acpi_info_matches_ids(info, acpi_defer_enumeration_ids))
>>> +             return true;
>>> +
>>> +     /*
>>> +      * We check for _HID here to avoid deferring the enumeration of:
>>> +      * 1. PCI devices
>>> +      * 2. ACPI nodes describing USB ports
>>> +      * However, checking for _HID catches more then just these cases ...
>>> +      */
>>> +     if (!(info->valid & ACPI_VALID_HID))
>>> +             return false;
>>
>> Interesting approach (using _HID), I went with _ADR since _ADR indicates
>> (more or less) that the ACPI fwnode is a companion node for a device
>> which will be enumerated through other means (such as PCI devices), rather
>> then one where the ACPI code will instantiate a platform_device, or
>> i2c_client (etc) for it.
>>
>> Maybe if we want to play it safe check both, and if there either is no
>> HID, or there is an ADR do not defer ?  Note just thinking out loud here,
>> I'm fine with either approach.
> 
> By the spec checking _HID should be equivalent to checking _ADR
> (Section 6.1 of ACPI 6.3 says "A device object must contain either an
> _HID object or an _ADR,  but should not contain both"), but the
> presence of _HID indicates that the device is expected to be
> enumerated via ACPI and so _DEP is more likely to really matter IMV.

Ah, I see I did not know about the either a HID or an ADR rule. I just
needed something available in acpi_device_info with which I could
skip PCI devices. So I ended up picking ADR, if you prefer HID that
works for me.

Regards,

Hans

