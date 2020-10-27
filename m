Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D978229AD96
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 14:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbgJ0Nlo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 09:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752396AbgJ0Nlo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Oct 2020 09:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603806102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzKh67CGDqlmQiChsULC21q1/xzSpmaEoByq3hUf6PQ=;
        b=cGAw4xLJRvmhW4lMvJ/0gcmHkuPWXUSyBe9KVzEcmE9lqfAIC1JntZc+LPsXbYbvSeaGbZ
        DL5uHha7igEhS8iktBKZeJUa3yAEeP2wA+g6molpt4gu3G58GD4JttKCFfJYd1blmlP8UK
        v8gNGqdsCUesqx2jYZJ83fneONSzkEU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-fHhrjrUBN6-6AoxxMol3bA-1; Tue, 27 Oct 2020 09:41:40 -0400
X-MC-Unique: fHhrjrUBN6-6AoxxMol3bA-1
Received: by mail-ed1-f69.google.com with SMTP id i9so693334edx.10
        for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2020 06:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VzKh67CGDqlmQiChsULC21q1/xzSpmaEoByq3hUf6PQ=;
        b=Uxv+VaGNneyEwrgpDtSFYH9UJBrjKuqyVyMSRP/su8hs0XnDpJ0/ZapSUfB+z3VpP3
         fFdyUOTsSlyo7LBcYWMiNO5fm10Q3o1jzr+yceAO8UTRvkt55KYadXiZY98Mw3UcDA6R
         +Qv5UZzQptHrLcrEHP7Fm6RIDkpkNyAki0lj8OyCrZgLVzjs53Rg0vD6SkOz7bg96hLo
         ed7Vny0X+pdYg+TusuM6pBPRZ3yq/PJ/n7V/3Mithv+zLgMWW3WgLAdUkF2ZvqFCKQqE
         OXTvp5RUf4/8hauFPGh0hgYAL6TnJS9P57NmVpagbH7eJ7ol6GJ1ulpPJyIrg5J4eQNS
         H46A==
X-Gm-Message-State: AOAM530InEGjrPhKEgen5njqcApTrvhMJkgQh05QZkrMjiwrVl7dyfyn
        GHFzb/jOFmsRNnjSWShuA1AM6n/0i/obZp8RRD6KNzCayJ1bFP85zr8Z4W94TIdEJfXnfqEJ8Ne
        EApBYymmMSL6sW6An8oZxtw==
X-Received: by 2002:a17:906:b043:: with SMTP id bj3mr2383943ejb.543.1603806099004;
        Tue, 27 Oct 2020 06:41:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuJmx7cxSclH5pvc3p629ROttHvzOtbZ3ALCynmA+xS4vMoaJyrvN5PofKlZyeWha9skm0sA==
X-Received: by 2002:a17:906:b043:: with SMTP id bj3mr2383916ejb.543.1603806098668;
        Tue, 27 Oct 2020 06:41:38 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id m1sm1077215ejj.117.2020.10.27.06.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 06:41:37 -0700 (PDT)
Subject: Re: [External] Re: [PATCH] [RFC] Documentation: Add documentation for
 new platform_profile sysfs attribute
To:     Mark Pearson <markpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>
Cc:     dvhart@infradead.org, mgross@linux.intel.com,
        mario.limonciello@dell.com, hadess@hadess.net, bberg@redhat.com,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <markpearson@lenovo.com>
 <ef9b93a0-636f-9b96-9d5b-fee1e5738af7@lenovo.com>
 <1fbaf1fa-47c6-afe7-ca9e-41b3ad6a4556@redhat.com> <12633630.uLZWGnKmhe@pce>
 <1bddcede-5e12-6089-8920-26dd5f534b44@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <255af791-e456-7299-d355-fe4f3cea7d63@redhat.com>
Date:   Tue, 27 Oct 2020 14:41:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1bddcede-5e12-6089-8920-26dd5f534b44@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mark,

On 10/27/20 1:28 PM, Mark Pearson wrote:
> Hi Elia
> 
> On 27/10/2020 05:19, Elia Devito wrote:
>> Hi to all,
>>
>> In data martedì 27 ottobre 2020 08:54:44 CET, Hans de Goede ha scritto:
>>> Hi,
>>>
>>> On 10/26/20 8:55 PM, Mark Pearson wrote:
>>>> Thanks Hans
>>>>
>>>> On 26/10/2020 14:33, Hans de Goede wrote:
>>>>> Hi Mark,
>>>>>
>>>>> Thank you for this new version.
>>>>>
>>>>> On 10/26/20 6:44 PM, Mark Pearson wrote:
>>>>>> From: Hans de Goede <hdegoede@redhat.com>
>>>>
>>>> <snip>
>>>>
>>>>>> +
>>>>>> +If for some reason there is no good match when mapping then a new
>>>>>> profile-name +may be added. Drivers which wish to introduce new
>>>>>> profile-names must: +1. Have very good reasons to do so.
>>>>>> +2. Add the new profile-name to this document, so that future drivers
>>>>>> which also +   have a similar problem can use the same new.
>>>>>
>>>>> s/same new/same name/
>>>>
>>>> I've read this document so many times...I'm not sure how I missed that
>>>> one. Thanks.>
>>>>>> + Usually new profile-names will
>>>>>> +   be added to the "extra profile-names" section of this document. But
>>>>>> in some +   cases the set of standard profile-names may be extended.
>>>>>
>>>>> With the change from a more generic API to this new one more targeted
>>>>> towards DPTF I would drop this part.
>>>>
>>>> OK - I have some questions then related to this change, below
>>>>
>>>>>> +
>>>>>> +What:        /sys/firmware/acpi/platform_profile_choices
>>>>>> +Date:        October 2020
>>>>>> +Contact:    Hans de Goede <hdegoede@redhat.com>
>>>>>> +Description:
>>>>>> +        Reading this file gives a space separated list of profiles
>>>>>> +        supported for this device.
>>>>>> +
>>>>>> +        Drivers must use the following standard profile-names whenever
>>>>>> +        possible:
>>>>>> +
>>>>>> +        low-power:        Emphasises low power consumption
>>>>>> +        quiet:            Offers quieter operation (lower fan
>>>>>> +                    speed but with higher performance and
>>>>>> +                    temperatures then seen in low-power
>>>>>
>>>>> I think the description here is a bit too specific, this may cause
>>>>> userspace to have expectations which are not necessary true. I would
>>>>> describe this as just:
>>>>>
>>>>>          quiet:            Emphasises quieter operation
>>>>
>>>> Agreed. I'll update
>>>>
>>>>>> +        balanced:        Balance between low power consumption
>>>>>> +                    and performance
>>>>>> +        performance:        Emphasises performance (and may lead to
>>>>>> +                    higher temperatures and fan speeds)
>>>>>> +
>>>>>> +        Userspace may expect drivers to offer at least several of these
>>>>>> +        standard profile-names! If none of the above are a good match
>>>>>> +        for some of the drivers profiles, then drivers may use one of
>>>>>> +        these extra profile-names:
>>>>>> +        <reserved for future use>
>>>>>> +
>>>>
>>>> If we remove the extra profile-names section above then I think it should
>>>> be removed here too. If someone wants to add a new 'mode' then it would
>>>> be added to the list of 'standard names', and becomes a new option.
>>>> Wanted to check I'm not missing something important.
>>> You are completely right, any references to an extra profile-names section
>>> should be removed here too. I did intend to add that it should be removed
>>> here too, but I forgot.
>>>
>>>>>> +What:        /sys/firmware/acpi/platform_profile
>>>>>> +Date:        October 2020
>>>>>> +Contact:    Hans de Goede <hdegoede@redhat.com>
>>>>>> +Description:
>>>>>> +        Reading this file gives the current selected profile for this
>>>>>> +        device. Writing this file with one of the strings from
>>>>>> +        available_profiles changes the profile to the new value.
>>>>>
>>>>> The part about custom profiles below may be dropped. That was intended
>>>>> for use with e.g. GPUs but since this now strictly is a system-level
>>>>> profile API, the part below can be dropped now.
>>>>
>>>> Agreed
>>>>
>>>>>> +
>>>>>> +        Reading this file may also return "custom". This is intended
>>>>>> for
>>>>>> +        drivers which have and export multiple knobs. Such drivers may
>>>>>> +        very well still want to offer a set of profiles for easy of use
>>>>>> +        and to be able to offer a consistent standard API (this API) to
>>>>>> +        userspace for configuring their performance. The "custom" value
>>>>>> +        is intended for when ai user has directly configured the knobs
>>>>>> +        (through e.g. some advanced control-panel for a GPU) and the
>>>>>> +        knob values do not match any of the presets represented by the
>>>>>> +        platform-profiles. In this case writing this file will
>>>>>> +        override the modifications and restore the selected presets.
>>>>>> +
>>>>>
>>>>> Regards,
>>>>>
>>>>> Hans
>>>>
>>>> Thanks!
>>>> mark
>>>
>>> Regards,
>>>
>>> Hans
>>
>> This look good,
>> only thing is that hp-wmi driver need a cool profile (Emphasises the computer
>> cool to touch), if you can add it would be perfect.
>>
>> Regards
>> Elia
>>
>>
>>
> Is low-power is different to cool? I figured low-power was going to be cool so combined them.
> I could call it low-power-cool if that helps? It seems a little clunky but not too bad. I'm sure the user space folks can put sunglasses on it or something ;)

IIRC we already had this discussion, cool means cool-to-touch, so could be done by
e.g. extra aggressive ramping up of the fans, so this is not necessarily the same
as low-power.

Yes this is all somewhat confusing. Luckily (for us kernel folks) we have already
sorta decided to just use the profile-names from the vendors more or less as is and
leave figuring this out further to userspace.

The reason to use the enum + try to have a fixed list of choices is to try and
limit the proliferation of profile-names to keep things somewhat manageable.

But as I discussed previously with Elia (*) we really need all 3 of low-power
cool and quiet.

Regards,

Hans



*) I was coming at this discussion from the same angle you (Mark) are

