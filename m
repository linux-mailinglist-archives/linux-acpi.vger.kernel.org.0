Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835E843751A
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 11:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhJVJ4U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 05:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232548AbhJVJ4U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Oct 2021 05:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634896442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2USPoZV9NF2EPdox749qvpVM6uWVZWDUstJXDc1hYo=;
        b=bkBaev6rk+UH2fCvyUqovx8w1tQGhAxf9TCUPcEzmnJ+6K+mnF6iaaJTOaw+k38HAppaLA
        WxfpBlkrNC9pjC+DPZR1VjQ/HPYmccSYKnN3i9k7IKyLgzGBR9ay8ZpRxp4HjYCFfitwjr
        gIyUhUecPY7MCKXAY+tHqxznLz9VrA8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-T7MqJskHPVunRxy74_H7Fg-1; Fri, 22 Oct 2021 05:54:01 -0400
X-MC-Unique: T7MqJskHPVunRxy74_H7Fg-1
Received: by mail-ed1-f69.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso2456018edn.4
        for <linux-acpi@vger.kernel.org>; Fri, 22 Oct 2021 02:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C2USPoZV9NF2EPdox749qvpVM6uWVZWDUstJXDc1hYo=;
        b=UmZl48EeW5CdUYJSJjt9MTmeVbyOrlW2ywT/D1KGHkM/3Y7mUacUqSzjsUX9bhBDC2
         hXj4lnczrPBY5oGj26lNB0P7MH2e+aBiAEooteumbaHr6bDyzzV1mhMYm+Mc7wyvhbj/
         zOjdNdVrpKWUkD4Qk9w5bvNK4Udh2B0NW4u2YPTVIaau7+9KN3DkVOUB1RGii7tQq+bx
         r+1M0XGaF8K4+DclYdvdL1rBvhMyoZysa2bumh6Ds6G64d9vJeEJiAQceocFNt/PI6YH
         VxvTfkV9azsm58/SuurmKU5CfWdPlUFQLij4FyLrkiW9PKIiwrMiVXCM8F4quvTtG303
         QN5w==
X-Gm-Message-State: AOAM533n/gM0cVh9BIz0RtpjaWGmwDdUMH3xJ6ta2TdxwQXo5++JYxvP
        AyOIy8QRKMkGiJa7/7va3f2aTvi3ytFsEURoYVsjx2T2skyzz+187apkEuQXNlQNYifn/FnzAgJ
        vOITqYuM78ERSY5y7P/K7HA==
X-Received: by 2002:a17:907:7ba8:: with SMTP id ne40mr13458329ejc.335.1634896440146;
        Fri, 22 Oct 2021 02:54:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0nUmU/VPs5uTk8uPXNcnpHQqhf+vy6uuNxUCzfKX2Cbmu75sxkovfEIFnj/aIzo9jXxpgkA==
X-Received: by 2002:a17:907:7ba8:: with SMTP id ne40mr13458295ejc.335.1634896439860;
        Fri, 22 Oct 2021 02:53:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b20sm1218540edd.50.2021.10.22.02.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 02:53:59 -0700 (PDT)
Message-ID: <75d1ef5a-13d9-9a67-0139-90b27b084c84@redhat.com>
Date:   Fri, 22 Oct 2021 11:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 1/2] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, stable@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20211022012034.GA2703195@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211022012034.GA2703195@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Bjorn,

On 10/22/21 03:20, Bjorn Helgaas wrote:
> On Thu, Oct 21, 2021 at 07:15:57PM +0200, Hans de Goede wrote:
>> On 10/20/21 23:14, Bjorn Helgaas wrote:
>>> On Wed, Oct 20, 2021 at 12:23:26PM +0200, Hans de Goede wrote:
>>>> On 10/19/21 23:52, Bjorn Helgaas wrote:
>>>>> On Thu, Oct 14, 2021 at 08:39:42PM +0200, Hans de Goede wrote:
>>>>>> Some BIOS-es contain a bug where they add addresses which map to system
>>>>>> RAM in the PCI host bridge window returned by the ACPI _CRS method, see
>>>>>> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
>>>>>> space").
>>>>>>
>>>>>> To work around this bug Linux excludes E820 reserved addresses when
>>>>>> allocating addresses from the PCI host bridge window since 2010.
>>>>>> ...
>>>
>>>>> I haven't seen anybody else eager to merge this, so I guess I'll stick
>>>>> my neck out here.
>>>>>
>>>>> I applied this to my for-linus branch for v5.15.
>>>>
>>>> Thank you, and sorry about the build-errors which the lkp
>>>> kernel-test-robot found.
>>>>
>>>> I've just send out a patch which fixes these build-errors
>>>> (verified with both .config-s from the lkp reports).
>>>> Feel free to squash this into the original patch (or keep
>>>> them separate, whatever works for you).
>>>
>>> Thanks, I squashed the fix in.
>>>
>>> HOWEVER, I think it would be fairly risky to push this into v5.15.
>>> We would be relying on the assumption that current machines have all
>>> fixed the BIOS defect that 4dc2287c1805 addressed, and we have little
>>> evidence for that.
>>
>> It is a 10 year old BIOS defect, so hopefully anything from 2018
>> or later will not have it.
> 
> We can hope.  AFAIK, Windows allocates space top-down, while Linux
> allocates bottom-up, so I think it's quite possible these defects
> would never be discovered or fixed.  In any event, I don't think we
> have much evidence either way.

Ack.

>>> I'm not sure there's significant benefit to having this in v5.15.
>>> Yes, the mainline v5.15 kernel would work on the affected machines,
>>> but I suspect most people with those machines are running distro
>>> kernels, not mainline kernels.
>>
>> Fedora and Arch do follow mainline pretty closely and a lot of
>> users are affected by this (see the large number of BugLinks in
>> the commit).
>>
>> I completely understand why you are reluctant to push this out, but
>> your argument about most distros not running mainline kernels also
>> applies to chances of people where this may cause a regression
>> running mainline kernels also being quite small.
> 
> True.
> 
>>> This issue has been around a long time, so it's not like a regression
>>> that we just introduced.  If we fixed these machines and regressed
>>> *other* machines, we'd be worse off than we are now.
>>
>> If we break one machine model and fix a whole bunch of other machines
>> then in my book that is a win. Ideally we would not break anything,
>> but we can only find out if we actually break anything if we ship
>> the change.
> 
> I'm definitely not going to try the "fix many, break one" argument on
> Linus.  Of course we want to fix systems, but IMO it's far better to
> leave a system broken than it is to break one that used to work.

Right, what I meant to say with "a win" is a step in the right direction,
we definitely must address any regressions coming from this change as
soon as we learn about them.

>>> In the meantime, here's another possibility for working around this.
>>> What if we discarded remove_e820_regions() completely, but aligned the
>>> problem _CRS windows a little more?  The 4dc2287c1805 case was this:
>>>
>>>   BIOS-e820: 00000000bfe4dc00 - 00000000c0000000 (reserved)
>>>   pci_root PNP0A03:00: host bridge window [mem 0xbff00000-0xdfffffff]
>>>
>>> where the _CRS window was of size 0x20100000, i.e., 512M + 1M.  At
>>> least in this particular case, we could avoid the problem by throwing
>>> away that first 1M and aligning the window to a nice 3G boundary.
>>> Maybe it would be worth giving up a small fraction (less than 0.2% in
>>> this case) of questionable windows like this?
>>
>> The PCI BAR allocation code tries to fall back to the BIOS assigned
>> resource if the allocation fails. That BIOS assigned resource might
>> fall outside of the host bridge window after we round the address.
>>
>> My initial gut instinct here is that this has a bigger chance
>> of breaking things then my change.
>>
>> In the beginning of the thread you said that ideally we would
>> completely stop using the E820 reservations for PCI host bridge
>> windows. Because in hindsight messing with the windows on all
>> machines just to work around a clear BIOS bug in some was not a
>> good idea.
>>
>> This address-rounding/-aligning you now suggest, is again
>> messing with the windows on all machines just to work around
>> a clear BIOS bug in some. At least that is how I see this.
> 
> That's true.  I assume Red Hat has a bunch of machines and hopefully
> an archive of dmesg logs from them.  Those logs should contain good
> E820 and _CRS information, so with a little scripting, maybe we could
> get some idea of what's out there.

We do have a (large-ish) test-lab, but that contains almost exclusively
servers, where as the original problem was on Dell Precision laptops.

Also I'm not sure if I can get aggregate data from the lab's machines.
I can reserve time on any model we have to debug specific problems,
but that is targeting one specific model. I'll ask around about this.

Regards,

Hans

