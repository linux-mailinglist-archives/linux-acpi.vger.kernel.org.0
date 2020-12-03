Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B5D2CD2FE
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Dec 2020 10:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbgLCJzF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Dec 2020 04:55:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387531AbgLCJzE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2020 04:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606989217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eviMD/Gcbw1ZPX/eD66qG8VQj9H+dy1ekMBLi0bDXRY=;
        b=Oh9CRAC+UDPDBScluZMfsH5fAJ3RwbHlk6am5aonVQ8O9cZctn+xpUsQVsZKpkQqqxHQl7
        1k4p3rlYaGjCH2ZY1utUbOdddrkgQH7MvUthVMi3NhF9mLaJhZVhEVmIdO2Lbh05fuFdTF
        KQMflpSjL04Ex7I11qHtZEFfYT7XhAA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-teAJ4F_4NjafajIOiD-q4g-1; Thu, 03 Dec 2020 04:53:33 -0500
X-MC-Unique: teAJ4F_4NjafajIOiD-q4g-1
Received: by mail-ed1-f72.google.com with SMTP id i1so717868edt.19
        for <linux-acpi@vger.kernel.org>; Thu, 03 Dec 2020 01:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eviMD/Gcbw1ZPX/eD66qG8VQj9H+dy1ekMBLi0bDXRY=;
        b=bQN15ciqlWIrCCRVPvR6Tye3pN4jlSBCUjKLMT177WFwrfSMb4uQ6/Z13jZDdj/Uyn
         bvzpS3gS0fDmMorOEzQqoYtcWU4aKcVm/TmtKDe3lD7jKHAGx+cpw0E3/yc7rPR/hxq5
         3pg9i34rW7UJ53IPqBgTGM/XBII4+YOTHwjf9nwxrVj9+0DSR20+NFxJmyiHwwmesJ+3
         NYCHC+87OVSA2tAS6GIwH4j3C5VvWviHFEGyIhVaF9PIZ2Dvo70vfLVETX+oPj3Mye6G
         MChdS2gXfWi+KLvagqYquN8he3jxpj85bhi43Hkyn+gjjQHLvo/GYuBJ7+HLaUK5mbYa
         Hn3g==
X-Gm-Message-State: AOAM532kYITSKaj6Njw+rQJ6lRO1OI0sCZjyy9paX3PBDL0yee/ZULGW
        n3SexNVU8cRHOv5QZ3wYuPoscDFLj/Wv1oXBMXwZogcKLRKhUKeCBmswYzDe2dxGhPJAaSI+LTc
        Lbdjm8necYVf7gWok5WwoTUh/3Rw6+/VMl2QEr56c0wusmGbtzLOYoGWNf9qaHfeALgeccObJ3Q
        ==
X-Received: by 2002:a17:906:81ca:: with SMTP id e10mr1711760ejx.449.1606989211631;
        Thu, 03 Dec 2020 01:53:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyr7c0IUOXvUsPIskBKE4IVo5/UwuUbZFOs/6MfcwUJ8jbr+2Gqvcgd0n6FeGfB8N+Hpjz9Eg==
X-Received: by 2002:a17:906:81ca:: with SMTP id e10mr1711739ejx.449.1606989211351;
        Thu, 03 Dec 2020 01:53:31 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id g15sm783903edj.49.2020.12.03.01.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 01:53:30 -0800 (PST)
Subject: Re: [PATCH 0/7] ACPI: scan: Split root scanning into 2 steps
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20201121203040.146252-1-hdegoede@redhat.com>
 <CAJZ5v0joWwOqaBkEXOsi3oT__j8JMJt68TPuRAY7f5WY6w=KrA@mail.gmail.com>
 <1e07f2b7-b699-b475-79c0-e411ae772851@redhat.com>
 <CAJZ5v0hmso90JSKfGMU4ZEJqKhR4bgmDa68Q+XLHytNJmGU10Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <00a4b9c2-aca2-4842-3006-720515f262db@redhat.com>
Date:   Thu, 3 Dec 2020 10:53:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hmso90JSKfGMU4ZEJqKhR4bgmDa68Q+XLHytNJmGU10Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/2/20 8:57 PM, Rafael J. Wysocki wrote:
> On Wed, Dec 2, 2020 at 8:39 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 12/2/20 2:49 PM, Rafael J. Wysocki wrote:
>>> On Sat, Nov 21, 2020 at 9:30 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>> A while ago (almost 2 years ago) I discussed an issue with you about
>>>> some devices, where some of the methods used during device-addition
>>>> (such as _HID) may rely on OpRegions of other devices:
>>>>
>>>> https://www.spinics.net/lists/linux-acpi/msg86303.html
>>>>
>>>> An example of this is the Acer Switch 10E SW3-016 model. The _HID method
>>>> of the ACPI node for the UART attached Bluetooth, reads GPIOs to detect
>>>> the installed wifi chip and update the _HID for the Bluetooth's ACPI node
>>>> accordingly. The current ACPI scan code calls _HID before the GPIO
>>>> controller's OpRegions are available, leading to the wrong _HID being
>>>> used and Bluetooth not working.
>>>>
>>>> Last week I bought a second hand Acer device, not knowing it was this
>>>> exact model. Since I now have access to affected hardware I decided to
>>>> take a shot at fixing this.
>>>>
>>>> In the discussion you suggested to split the acpi_bus_scan of the root
>>>> into 2 steps, first scan devices with an empty _DEP, putting other
>>>> acpi_handle-s on a list of deferred devices and then in step 2 scan the
>>>> rest.
>>>>
>>>> I'm happy to report that, at least on the affected device, this works
>>>> nicely. While working on this I came up with a less drastic way to
>>>> deal with this. As you will see in patch 4 of this series, I decided
>>>> to first add a more KISS method of deciding which devices to defer
>>>> to the second scan step by matching by HID. This has the disadvantage
>>>> of not being a generic solution. But it has the advantage of being a
>>>> solution which does not potentially regress other devices.
>>>>
>>>> Then in patch 5 I actually do add the option to defer or not based on
>>>> _DEP being empty. I've put this behind a kernel commandline option as
>>>> I'm not sure we should do this everywhere by default. At least no without
>>>> a lot more testing.
>>>>
>>>> Patch 6 fixes an issue with patch 5 which causes battery devices to stop
>>>> working.
>>>>
>>>> And patch 7 adds some extra HIDs to the list of HIDs which should be
>>>> ignored when checking if the _DEP list is empty from Linux' pov, iow
>>>> some extra HIDs which Linux does not bind to.
>>>>
>>>> Please let me know what you think about this patch-set. I would be happy
>>>> to see just patches 1-4 merged.
>>>
>>> I took patches 1 and 2, because IMO they are generally useful (I
>>> rewrote the changelogs to avoid mentioning the rest of the series
>>> though),
>>
>> That is fine. Thanks for taking those.
>>
>>> but I have some reservations regarding the rest.
>>>
>>> First off, I'm not really sure if failing acpi_add_single_object() for
>>> devices with missing dependencies is a good idea.  IIRC there is
>>> nothing in there that should depend on any opregions supplied by the
>>> other devices, so it should be safe to allow it to complete.
>>
>> Actually acpi_add_single_object() does depend on ACPI methods
>> which may depend on opregions, that is the whole reason why
>> this series is necessary. Otherwise we could just delay the
>> binding of the driver based in dep_unmet which would be easier.
>>
>> Here are 2 actual examples of acpi_add_single_object() calling
>> ACPI methods which may depend on opregions:
>>
>> 1. acpi_add_single_object() calls acpi_init_device_object() which
>> calls acpi_set_pnp_ids() which fills a bunch if fields of
>> struct acpi_device with info returned by the acpi_get_object_info()
>> call.
>>
>> Specifically it stores the value returned by the _HID method in
>> the acpi_device_pnp array for the device and that _HID method is
>> actually the problem in the example device which started this
>> series. The _HID method of the bluetooth device reads 2 GPIOs
>> to get a hw-id (0-3) and then translates the hwid to a _HID
>> string. If the GPIO opregion's handlers have not registered yet
>> then the reading of the GPIOs is correctly skipped, and hwid
>> 0 is assumed, which is wrong in this case.
>>
>> 2. I've also seen examples where _STA depends on GPIOs in a similar
>> manner; and acpi_add_single_object() calls acpi_bus_get_power_flags()
>> which calls acpi_bus_init_power() which calls acpi_device_is_present()
>> which depends on _STA results.
> 
> Well, this means that there is a bug in acpi_bus_attach() which
> shouldn't call acpi_bus_init_power() which has been called already.

I'm afraid we have a bit of a misunderstanding here, the problem is
not that acpi_bus_attach() calls acpi_bus_init_power(), the problem is
that acpi_bus_init_power() (which is called from acpi_add_single_object())
depends on the value returned by _STA and that in turn may depend on
some OpRegions being available. IOW it is the same problem as the _HID
problem.

> And it all means that either deferring acpi_add_single_object() is
> needed and so there need to be 2 passes in acpi_bus_attach() overall,
> or acpi_add_single_object() needs to avoid calling methods that may
> depend on supplied opregions.  I guess the latter is rather
> unrealistic, so the only practical choice is the former.

I agree.

> However, I still don't think that the extra list of "dependent
> devices" is needed.

I'm not sure what you are trying to say here? Do you mean this list:

+/*
+ * List of HIDs for which we defer adding them to the second step of the
+ * scanning of the root, because some of their methods used during addition
+ * depend on OpRegions registered by the drivers for other ACPI devices.
+ */
+static const char * const acpi_defer_add_hids[] = {
+	"BCM2E5B", /* Acer SW3-016 bluetooth HID when GPIO OpRegs or not available yet */
+	NULL
+};
+

?

That indeed is not necessary if you take the entire set and always enable the
new behavior instead of using the module option. I guess we could go that route
for 5.12, and get it into next as soon as 5.11-rc1 is available for maximum
testing.

Do you want me to do a new version of the series which drops the acpi_defer_add_hids[]
thing and the module option and simply always uses the new behavior?

Regards,

Hans

