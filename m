Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C23516F8A
	for <lists+linux-acpi@lfdr.de>; Mon,  2 May 2022 14:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiEBM2B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 May 2022 08:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiEBM2A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 May 2022 08:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E2D7BC1E
        for <linux-acpi@vger.kernel.org>; Mon,  2 May 2022 05:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651494270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0PWb4JWsmuGJGKazGQUhn92eJLKgCumnf5HYFTKEj0Q=;
        b=FN4yl0PrMQawfvbcK3Zy/znPLaP3pQh3e9nLszRy5fgHyc+26+ZvnbnYTHiH0FQzbM9oVX
        Meb4bTogRMZIsZ0r9iY0ptmBdcTDfFEcqXnL124aj84jPySXnsJuhPm59sTtpm4cHXkiu5
        +Q5YopgcAP1pd9f21eHi8yaxgICFZyc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341--jpz5GmbOqKAwDA5g3sH_g-1; Mon, 02 May 2022 08:24:29 -0400
X-MC-Unique: -jpz5GmbOqKAwDA5g3sH_g-1
Received: by mail-ej1-f71.google.com with SMTP id qb36-20020a1709077ea400b006f45e182187so680366ejc.14
        for <linux-acpi@vger.kernel.org>; Mon, 02 May 2022 05:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0PWb4JWsmuGJGKazGQUhn92eJLKgCumnf5HYFTKEj0Q=;
        b=TSv6SLvEe4jzp3ZYFIuWMr8NZAh5v94RmEyGFsY5r+WGYy//xxrdb36a6vaoxYCdWI
         BtUii/q+B/uNkGOBPlxWkHaIjF30q1nAm2KnAExXVv0I5aKrOSdiyT5sd4XpVZZcJfUN
         TkZ+dUwxkWHJCI4EKBNwttAX0APalGTjgw3ZRSizXVUE1PjXaJlqSSY2Wz1msjLL1j5w
         0zdY6i1TXpOxyDDZIEuXlPxLPrKeOUv9MEb4RKOJAfjQ8RLbk8IBJQG/s1+ARXgjFG6Y
         fNdYNqHkk8dAuR/2J9ZfetIKEnusK0csy5xlgrH4bU7/aNENTWl/2COp+Fefckf55VeM
         X8vw==
X-Gm-Message-State: AOAM531T4vPoIa4rozmo6Ajd6zBmTngXkIPXdlVTzMVBuG32XhDIgSON
        gkeRejoJU/b0bqp58PaTkVqCVLLmRHT2bcsCTGiYKPfJppFp+QVdEBcqPpDSIkSRuJm301nTKAO
        Dsa1aWqI6EsZWOgACL4P9iQ==
X-Received: by 2002:a17:907:2d93:b0:6f3:8524:6f92 with SMTP id gt19-20020a1709072d9300b006f385246f92mr11143457ejc.556.1651494267907;
        Mon, 02 May 2022 05:24:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMW9CzlQ1mWVSORPBTlZIOJx0ICt1p3XiOTG1lGD/OnYJxBBIM7JMB0Hy5A+bQT4uoHzsPcg==
X-Received: by 2002:a17:907:2d93:b0:6f3:8524:6f92 with SMTP id gt19-20020a1709072d9300b006f385246f92mr11143438ejc.556.1651494267611;
        Mon, 02 May 2022 05:24:27 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id q8-20020aa7cc08000000b0042617ba637esm6575823edt.8.2022.05.02.05.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 05:24:27 -0700 (PDT)
Message-ID: <7bbd9205-aa35-4a27-0df4-8f2b22603831@redhat.com>
Date:   Mon, 2 May 2022 14:24:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/3] x86/PCI: Log E820 clipping
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220419164526.GA1204065@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220419164526.GA1204065@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Sorry for the late reply.

On 4/19/22 18:45, Bjorn Helgaas wrote:
> On Tue, Apr 19, 2022 at 05:16:44PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 4/19/22 17:03, Bjorn Helgaas wrote:
>>> On Tue, Apr 19, 2022 at 11:59:17AM +0200, Hans de Goede wrote:
>>>> On 1/1/70 01:00, Bjorn Helgaas wrote:
>>>>> This is still work-in-progress on the issue of PNP0A03 _CRS methods that
>>>>> are buggy or not interpreted correctly by Linux.
>>>>>
>>>>> The previous try at:
>>>>>   https://lore.kernel.org/r/20220304035110.988712-1-helgaas@kernel.org
>>>>> caused regressions on some Chromebooks:
>>>>>   https://lore.kernel.org/r/Yjyv03JsetIsTJxN@sirena.org.uk
>>>>>
>>>>> This v2 drops the commit that caused the Chromebook regression, so it also
>>>>> doesn't fix the issue we were *trying* to fix on Lenovo Yoga and Clevo
>>>>> Barebones.
>>>>>
>>>>> The point of this v2 update is to split the logging patch into (1) a pure
>>>>> logging addition and (2) the change to only clip PCI windows, which was
>>>>> previously hidden inside the logging patch and not well documented.
>>>>>
>>>>> Bjorn Helgaas (3):
>>>>>   x86/PCI: Eliminate remove_e820_regions() common subexpressions
>>>>>   x86: Log resource clipping for E820 regions
>>>>>   x86/PCI: Clip only host bridge windows for E820 regions
>>>>
>>>> Thanks, the entire series looks good to me:
>>>>
>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> Thank you!
>>>
>>>> So what is the plan to actually fix the issue seen on some Lenovo models
>>>> and Clevo Barebones ?   As I mentioned previously I think that since all
>>>> our efforts have failed so far that we should maybe reconsider just
>>>> using DMI quirks to ignore the E820 reservation windows for host bridges
>>>> on affected models ?
>>>
>>> I have been resisting DMI quirks but I'm afraid there's no other way.
>>
>> Well there is the first match adjacent windows returned by _CRS and
>> only then do the "covers whole region" exception check. I still
>> think that would work at least for the chromebook regression...
> 
> Without a crystal clear strategy, I think we're going to be tweaking
> the algorithm forever as the _CRS/E820 mix changes.  That's why I
> think that in the long term, a "use _CRS only, with quirks for
> exceptions" strategy will be simplest.

Looking at the amount of exception we already now about I'm
not sure if that will work well.


> 
>> So do you want me to give that a try; or shall I write a patch
>> using DMI quirks. And if we go the DMI quirks, what about
>> matching cmdline arguments?  If we add matching cmdline arguments,
>> which seems to be the sensible thing to do then to allow users
>> to test if they need the quirk, then we basically end up with my
>> first attempt at fixing this from 6 months ago:
>>
>> https://lore.kernel.org/linux-pci/20211005150956.303707-1-hdegoede@redhat.com/
> 
> So I think we should go ahead with DMI quirks instead of trying to
> make the algorithm smarter, and yes, I think we will need commandline
> arguments, probably one to force E820 clipping for future machines,
> and one to disable it for old machines.

So what you are suggesting is to go back to a bios-date based approach
(to determine old vs new machines) combined with DMI quirks to force
E820 clipping on new machines which turn out to need it despite them
being new ?

> 
>>> I think the web we've gotten into, where vendors have used E820 to
>>> interact with _CRS in incompatible and undocumented ways, is not
>>> sustainable.
>>>
>>> I'm not aware of any spec that says the OS should use E820 to clip
>>> things out of _CRS, so I think the long term plan should be to
>>> decouple them by default.
>>
>> Right and AFAICT the reason Windows is getting away with this is
>> the same as with the original Dell _CRS has overlap with
>> physical RAM issue (1), Linux assigns address to unassigneds BAR-s
>> starting with the lowest available address in the bridge window,
>> where as Windows assigns addresses from the highest available
>> address in the window.
> 
> Right, I agree.  I'm guessing Chromebooks don't get tested with
> Windows at all, so we don't even have that level of testing to help.
> 
>> So the real fix here might very well be
>> to rework the BAR assignment code to switch to fill the window
>> from the top rather then from the bottom. AFAICT all issues where
>> excluding _E820 reservations have helped are with _E820 - bridge
>> window overlaps at the bottom of the window.
>>
>> IOW these are really all bugs in the _CRS method for the bridge,
>> which Windows does not hit because it never actually uses
>> the lowest address(es) of the _CRS returned window.
> 
> Yes.  We actually did try this
> (https://git.kernel.org/linus/1af3c2e45e7a), but unfortunately we had
> to revert it.  Even more unfortunately, the revert
> (https://git.kernel.org/linus/5e52f1c5e85f) doesn't have any details
> about what went wrong.

When I first started working on this I did read the entire old
email thread and IIRC this approach was reverted because the
e820 based approach was deemed to be a cleaner fix. Also the
single resource_alloc_from_bottom flag influenced all types
of resource allocations, not just PCI host bridge window
allocations.

Note that the current kernel no longer has the resource_alloc_from_bottom
flag. Still I think it might be worthwhile to give switching to
top-down allocating for host bridge window allocs a try. Maybe we
can make the desired allocation strategy a flag in the resource ?

I have the feeling that if we switch to top-down allocating
that we can then switch to just using _CRS and that everything
will then just work, because we then match what Windows is doing...

Regards,

Hans







> 
>> 1) At least I read in either a bugzilla, or email thread about
>> this that Windows allocating bridge window space from the top
>> was assumed to be why Windows was not impacted.
>>
>>> Straw man:
>>>
>>>   - Disable E820 clipping by default.
>>>
>>>   - Add a quirk to enable E820 clipping for machines older than X,
>>>     e.g., 2023, to avoid breaking machines that currently work.
>>>
>>>   - Add quirks to disable E820 clipping for individual machines like
>>>     the Lenovo and Clevos that predate X, but E820 clipping breaks
>>>     them.
>>>
>>>   - Add quirks to enable E820 clipping for individual machines like
>>>     the Chromebooks (and probably machines we don't know about yet)
>>>     that have devices that consume part of _CRS but are not
>>>     enumerable.
>>>
>>>   - Communicate this to OEMs to try to prevent future machines that
>>>     need quirks.
>>>
>>> Bjorn
>>>
>>
> 

