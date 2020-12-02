Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDF82CC6DA
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 20:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgLBTlT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 14:41:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729217AbgLBTlT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 14:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606937991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+MlYaPu0tcrioewBeYmSv8stsq5qmpy7jCZRCMUFydU=;
        b=I36OvULwH1lqpvc/BEHKByUDMflsScrwKtOf9caXYtdLFKacFjcIsVGuCRgOAwEfy2JIGx
        hXQtd783ru67APbjau9YSAH5Bj6km/lwaiMdRCr77T8MGZOb2R1ZVDW7klaZY2eFtf0qLa
        yBbKbEMogD1RQNXBpkfT/9yN/RJ/NrM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-mizV-r3hO1GvKC504hMIpw-1; Wed, 02 Dec 2020 14:39:48 -0500
X-MC-Unique: mizV-r3hO1GvKC504hMIpw-1
Received: by mail-ed1-f69.google.com with SMTP id y11so3653925edv.6
        for <linux-acpi@vger.kernel.org>; Wed, 02 Dec 2020 11:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+MlYaPu0tcrioewBeYmSv8stsq5qmpy7jCZRCMUFydU=;
        b=UUFHSzXIruVpSbFHEBCAukf4fWmvVEX8Etme+2oOvC4tvxwJdDhvbV2N+27Q3r5Dko
         tfcgubgsWQeb5M0JXl9wub29m09QC1+5YpBjTpsg2Wp91wK28HSpCG5pRhoR8f2Aya3s
         Z1ULn1n8gr3EkjJM7Y4Hm0lMwN018F1rbhmx+KTEqRCMZhvGLRmrMPffGxgDjqc2uQif
         IXJsoet8HnjBZ9+0kScwnLQiYVgl/BICa8zd2zQqh/m7RF9v1XZ7lxP87+Y5uhkSjtLO
         z6dCHr/YCVjqtK3CJk7POfyAoxpayLsVDKJBFCCf0TSsvwKOTqscjkEeRU4SkQ8d/Gx7
         iaww==
X-Gm-Message-State: AOAM530df6yL1OfSVr0dCKe8aY1cK1juOiESMsuYo2Do02n+u8ZqliKD
        iDHVqqzE8XfcgKACqFVodBhLnF6KJag9fN3SBLqepq5OPNqQHZX6Ly/h3mdW5DSWBM1KXJ4Ty6N
        OT8MpV3CobGY7CHIRG8jf2JKlIVu7HyC+lwaia/0V1x1UtUI+mRKOGCnN492dlQZeLsUC+wEYiQ
        ==
X-Received: by 2002:a17:906:2e55:: with SMTP id r21mr1393000eji.46.1606937986565;
        Wed, 02 Dec 2020 11:39:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzr5SEKz5TQCx5MX4E/rdOJDejpaOKr9rwMP6gICRrpzeZvE3pGpgqCXtptVjtsKjwdgkwAZA==
X-Received: by 2002:a17:906:2e55:: with SMTP id r21mr1392979eji.46.1606937986220;
        Wed, 02 Dec 2020 11:39:46 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id e14sm533116ejh.62.2020.12.02.11.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 11:39:45 -0800 (PST)
Subject: Re: [PATCH 0/7] ACPI: scan: Split root scanning into 2 steps
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20201121203040.146252-1-hdegoede@redhat.com>
 <CAJZ5v0joWwOqaBkEXOsi3oT__j8JMJt68TPuRAY7f5WY6w=KrA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1e07f2b7-b699-b475-79c0-e411ae772851@redhat.com>
Date:   Wed, 2 Dec 2020 20:39:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0joWwOqaBkEXOsi3oT__j8JMJt68TPuRAY7f5WY6w=KrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/2/20 2:49 PM, Rafael J. Wysocki wrote:
> On Sat, Nov 21, 2020 at 9:30 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael,
>>
>> A while ago (almost 2 years ago) I discussed an issue with you about
>> some devices, where some of the methods used during device-addition
>> (such as _HID) may rely on OpRegions of other devices:
>>
>> https://www.spinics.net/lists/linux-acpi/msg86303.html
>>
>> An example of this is the Acer Switch 10E SW3-016 model. The _HID method
>> of the ACPI node for the UART attached Bluetooth, reads GPIOs to detect
>> the installed wifi chip and update the _HID for the Bluetooth's ACPI node
>> accordingly. The current ACPI scan code calls _HID before the GPIO
>> controller's OpRegions are available, leading to the wrong _HID being
>> used and Bluetooth not working.
>>
>> Last week I bought a second hand Acer device, not knowing it was this
>> exact model. Since I now have access to affected hardware I decided to
>> take a shot at fixing this.
>>
>> In the discussion you suggested to split the acpi_bus_scan of the root
>> into 2 steps, first scan devices with an empty _DEP, putting other
>> acpi_handle-s on a list of deferred devices and then in step 2 scan the
>> rest.
>>
>> I'm happy to report that, at least on the affected device, this works
>> nicely. While working on this I came up with a less drastic way to
>> deal with this. As you will see in patch 4 of this series, I decided
>> to first add a more KISS method of deciding which devices to defer
>> to the second scan step by matching by HID. This has the disadvantage
>> of not being a generic solution. But it has the advantage of being a
>> solution which does not potentially regress other devices.
>>
>> Then in patch 5 I actually do add the option to defer or not based on
>> _DEP being empty. I've put this behind a kernel commandline option as
>> I'm not sure we should do this everywhere by default. At least no without
>> a lot more testing.
>>
>> Patch 6 fixes an issue with patch 5 which causes battery devices to stop
>> working.
>>
>> And patch 7 adds some extra HIDs to the list of HIDs which should be
>> ignored when checking if the _DEP list is empty from Linux' pov, iow
>> some extra HIDs which Linux does not bind to.
>>
>> Please let me know what you think about this patch-set. I would be happy
>> to see just patches 1-4 merged.
> 
> I took patches 1 and 2, because IMO they are generally useful (I
> rewrote the changelogs to avoid mentioning the rest of the series
> though),

That is fine. Thanks for taking those.

> but I have some reservations regarding the rest.
> 
> First off, I'm not really sure if failing acpi_add_single_object() for
> devices with missing dependencies is a good idea.  IIRC there is
> nothing in there that should depend on any opregions supplied by the
> other devices, so it should be safe to allow it to complete.

Actually acpi_add_single_object() does depend on ACPI methods
which may depend on opregions, that is the whole reason why
this series is necessary. Otherwise we could just delay the
binding of the driver based in dep_unmet which would be easier.

Here are 2 actual examples of acpi_add_single_object() calling
ACPI methods which may depend on opregions:

1. acpi_add_single_object() calls acpi_init_device_object() which 
calls acpi_set_pnp_ids() which fills a bunch if fields of
struct acpi_device with info returned by the acpi_get_object_info()
call.

Specifically it stores the value returned by the _HID method in
the acpi_device_pnp array for the device and that _HID method is
actually the problem in the example device which started this
series. The _HID method of the bluetooth device reads 2 GPIOs
to get a hw-id (0-3) and then translates the hwid to a _HID
string. If the GPIO opregion's handlers have not registered yet
then the reading of the GPIOs is correctly skipped, and hwid
0 is assumed, which is wrong in this case.

2. I've also seen examples where _STA depends on GPIOs in a similar
manner; and acpi_add_single_object() calls acpi_bus_get_power_flags()
which calls acpi_bus_init_power() which calls acpi_device_is_present()
which depends on _STA results.

> That, in
> turn, will allow the flags in struct acpi_device to be used to mark
> the "deferred" devices without allocating more memory.

See above, we would need to either redo a bunch of the device
addition; and/or potentially even undo it in the case of _STA
changing from present -> not present once the OpRegions have
registered.

> Next, in theory, devices with dependencies may also appear during
> hotplug, so it would be prudent to handle that on every invocation of
> acpi_bus_scan() and not just when it runs for the root object.
> 
> So my approach would be to allow the first namespace walk in
> acpi_bus_scan() to complete, change acpi_bus_attach() to optionally
> skip the devices with missing dependencies and return a result
> indicating whether or not it has set flags.visited for any devices and
> run it in a loop on the "root" device object until it says that no new
> devices have been "attached".
> 
> Let me cut a prototype patch for that and get back to you.

See above for why the prototype patch will not work. By the time
acpi_bus_attach() runs, the wrong HID has already been stored by
acpi_set_pnp_ids().

Note I'm not saying that your approach cannot work, we could
e.g. re-fetch the HID before running bus_attach.

But once we start doing extra work, replacing fields in the
earlier instantiated acpi_device, then there is not that much
difference between the 2 approaches and then the question becomes
which way is cleaner ?

I still favor my own approach because that simply delays the
entire instantiation, rather then doing it when we don't have
all the _DEPs yet and then "patching up" the acpi_device
later. Note I did consider the "patching up" approach, but
I rejected it (*).

The patching-up approach feels fragile / more error-prone to
me, which is why I chose to simply defer the entire
instantiation.

Regards,

Hans


*) In hindsight I should have probably written that down somewhere,
but the whole though process behind my choices it is not something
which I could quickly describe in 1 or 2 paragraphs in the
commit message.

Some other notes about this:

1. I considered the patching-up approach, but I did not implement it.

2. Another reason for delaying the entire instantiation is that we
have some quirk handling in various places which relies on _HID /
on the pnp-ids and since those are still in flux when the deps have
not been met yet, some of that quirk handling could (theoretically)
also go wonky if we instantiate the device too soon.

