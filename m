Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC69D46C108
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Dec 2021 17:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbhLGQ4Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Dec 2021 11:56:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235124AbhLGQ4Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Dec 2021 11:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638895965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/By6rEGwvSgdTNmnHjwJBI1A73Ah61h+c4ZNN/CLBc=;
        b=TfoF9i6tPDg2yBTn+yzFFtBcp/F/m6EzGQ9yGciUcAF78gW0J4b3Aoh9SYVv7AtJ2jRgDI
        VUR/SkESJPPFMiGodfjnh4OUnJ1t0PsvaMsXyuKLaXFOGZ+YXvBBsU4Hv6mGzG7gTSJ1lX
        gGu/5MjhTBjetoyfSH/IXsFGVZYuNEY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-Qg0qWra5M-Ke_SCC2L2hyg-1; Tue, 07 Dec 2021 11:52:44 -0500
X-MC-Unique: Qg0qWra5M-Ke_SCC2L2hyg-1
Received: by mail-ed1-f71.google.com with SMTP id c1-20020aa7c741000000b003e7bf1da4bcso11879691eds.21
        for <linux-acpi@vger.kernel.org>; Tue, 07 Dec 2021 08:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=H/By6rEGwvSgdTNmnHjwJBI1A73Ah61h+c4ZNN/CLBc=;
        b=xU1z4NBXhMYxOZo2PFTjL2aJa70bh7SwzqCs7MPYJdKqPu1dBNYQudqoUoYrRcFi8q
         kfe17kDf5e3KCLt9lkCnusxC0TMNFgL6ZQiFKXH9e673WUH9HwPz9AwIK8wAoHtgZaog
         4bME2M9oZJOal6kGeAGxo54poDrtkC1SPkmwPE9x2TfQ7YpYmwpeFf5V6PHf6QLa8K5v
         gWyK2YGpbZwHf9rg10WjSi7hY1scl3kzlQacwrtnaI5sBYgKUhtJp6HMSIjOjq0wobqs
         5qIThy/M0l9Cy7fI04KmY12z5ylxAQ/8LHsiUhpEi031h8Wxji9TvYP33YB/bS9i5Cuy
         NAfw==
X-Gm-Message-State: AOAM531id7hN46rrsH95P55GVLqOW7+fSfTJZMK3aQwEbwhoIrSFw7sD
        ZxmYFxktRZuWN27f+zE157wQN09LJlovq90owJqccF5x3i+nHTiRMblFINjGu/PQ6mr1Rvu3wqL
        6a+MBiZJ7otI1w5VdlONulQ==
X-Received: by 2002:a05:6402:1453:: with SMTP id d19mr10408049edx.388.1638895962380;
        Tue, 07 Dec 2021 08:52:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxrUxibvVrFv/wqPRHbXQWi2KSPBTy3VBrFTv8s7nEc6wN0OSbWXCi8u7l1kVQ6uY0pclBhQ==
X-Received: by 2002:a05:6402:1453:: with SMTP id d19mr10408008edx.388.1638895962106;
        Tue, 07 Dec 2021 08:52:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m16sm199733edd.61.2021.12.07.08.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:52:41 -0800 (PST)
Message-ID: <8cfab16c-5edc-dbff-b73e-65419a649ac2@redhat.com>
Date:   Tue, 7 Dec 2021 17:52:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v5 1/2] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
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
References: <20211109220717.GA1187103@bhelgaas>
 <70b63cc2-4d08-8468-1ca7-135492394773@redhat.com>
 <1a001812-1f18-1999-44b7-30fe3a19f460@redhat.com>
In-Reply-To: <1a001812-1f18-1999-44b7-30fe3a19f460@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Bjorn,

On 11/10/21 14:05, Hans de Goede wrote:
> Hi Bjorn,
> 
> On 11/10/21 09:45, Hans de Goede wrote:
>> Hi Bjorn,
>>
>> On 11/9/21 23:07, Bjorn Helgaas wrote:
>>> On Sat, Nov 06, 2021 at 11:15:07AM +0100, Hans de Goede wrote:
>>>> On 10/20/21 23:14, Bjorn Helgaas wrote:
>>>>> On Wed, Oct 20, 2021 at 12:23:26PM +0200, Hans de Goede wrote:
>>>>>> On 10/19/21 23:52, Bjorn Helgaas wrote:
>>>>>>> On Thu, Oct 14, 2021 at 08:39:42PM +0200, Hans de Goede wrote:
>>>>>>>> Some BIOS-es contain a bug where they add addresses which map to system
>>>>>>>> RAM in the PCI host bridge window returned by the ACPI _CRS method, see
>>>>>>>> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
>>>>>>>> space").
>>>>>>>>
>>>>>>>> To work around this bug Linux excludes E820 reserved addresses when
>>>>>>>> allocating addresses from the PCI host bridge window since 2010.
>>>>>>>> ...
>>>>>
>>>>>>> I haven't seen anybody else eager to merge this, so I guess I'll stick
>>>>>>> my neck out here.
>>>>>>>
>>>>>>> I applied this to my for-linus branch for v5.15.
>>>>>>
>>>>>> Thank you, and sorry about the build-errors which the lkp
>>>>>> kernel-test-robot found.
>>>>>>
>>>>>> I've just send out a patch which fixes these build-errors
>>>>>> (verified with both .config-s from the lkp reports).
>>>>>> Feel free to squash this into the original patch (or keep
>>>>>> them separate, whatever works for you).
>>>>>
>>>>> Thanks, I squashed the fix in.
>>>>>
>>>>> HOWEVER, I think it would be fairly risky to push this into v5.15.
>>>>> We would be relying on the assumption that current machines have all
>>>>> fixed the BIOS defect that 4dc2287c1805 addressed, and we have little
>>>>> evidence for that.
>>>>>
>>>>> I'm not sure there's significant benefit to having this in v5.15.
>>>>> Yes, the mainline v5.15 kernel would work on the affected machines,
>>>>> but I suspect most people with those machines are running distro
>>>>> kernels, not mainline kernels.
>>>>
>>>> I understand that you were reluctant to add this to 5.15 so close
>>>> near the end of the 5.15 cycle, but can we please get this into
>>>> 5.16 now ?
>>>>
>>>> I know you ultimately want to see if there is a better fix,
>>>> but this is hitting a *lot* of users right now and if we come up
>>>> with a better fix we can always use that to replace this one
>>>> later.
>>>
>>> I don't know whether there's a "better" fix, but I do know that if we
>>> merge what we have right now, nobody will be looking for a better
>>> one.
>>>
>>> We're in the middle of the merge window, so the v5.16 development
>>> cycle is over.  The v5.17 cycle is just starting, so we have time to
>>> hit that.  Obviously a fix can be backported to older kernels as
>>> needed.
>>>
>>>> So can we please just go with this fix now, so that we can
>>>> fix the issues a lot of users are seeing caused by the current
>>>> *wrong* behavior of taking the e820 reservations into account ?
>>>
>>> I think the fix on the table is "ignore E820 for BIOS date >= 2018"
>>> plus the obvious parameters to force it both ways.
>>
>> Correct.
>>
>>> The thing I don't like is that this isn't connected at all to the
>>> actual BIOS defect.  We have no indication that current BIOSes have
>>> fixed the defect,
>>
>> We also have no indication that that defect from 10 years ago, from
>> pre UEFI firmware is still present in modern day UEFI firmware which
>> is basically an entire different code-base.
>>
>> And even 10 years ago the problem was only happening to a single
>> family of laptop models (Dell Precision laptops) so this clearly
>> was a bug in that specific implementation and not some generic
>> issue which is likely to be carried forward.
>>
>>> and we have no assurance that future ones will not
>>> have the defect.  It would be better if we had some algorithmic way of
>>> figuring out what to do.
>>
>> You yourself have said that in hindsight taking E820 reservations
>> into account for PCI bridge host windows was a mistake. So what
>> the "ignore E820 for BIOS date >= 2018" is doing is letting the
>> past be the past (without regressing on older models) while fixing
>> that mistake on any hardware going forward.
>>
>> In the unlikely case that we hit that BIOS bug again on 1 or 2 models,
>> we can simply DMI quirk those models, as we do for countless other
>> BIOS issues.
>>
>>> Thank you very much for chasing down the dmesg log archive
>>> (https://github.com/linuxhw/Dmesg; see
>>> https://lore.kernel.org/r/82035130-d810-9f0b-259e-61280de1d81f@redhat.com).
>>> Unfortunately I haven't had time to look through it myself, and I
>>> haven't heard of anybody else doing it either.
>>
>> Right, I'm afraid that I already have spend way too much time on this
>> myself. Note that I've been working with users on this bug on and off
>> for over a year now.
>>
>> This is hitting many users and now that we have a viable fix, this
>> really needs to be fixed now.
>>
>> I believe that the "ignore E820 for BIOS date >= 2018" fix is good
>> enough and that you are letting perfect be the enemy of good here.
>>
>> As an upstream kernel maintainer myself, I'm sorry to say this,
>> but if we don't get some fix for this merged soon you are leaving
>> my no choice but to add my fix to the Fedora kernels as a downstream
>> patch (and to advise other distros to do the same).
>>
>> Note that if you are still afraid of regressions going the downstream
>> route is also an opportunity, Fedora will start testing moving users
>> to 5.15.y soon, so I could add the patch to Fedora's 5.15.y builds and
>> see how that goes ?
> 
> So I've discussed this with the Fedora kernel maintainers and they have
> agreed to add the patch to the Fedora 5.15 kernels, which we will ask
> our users to start testing soon (we first run some voluntary testing
> before eventually moving all users over).
> 
> This will provide us with valuable feedback wrt this patch causing
> regressions as you are worried about, or not.
> 
> Assuming no regressions show up I hope that this will give you
> some assurance that there the patch causes no regressions and that
> you will then be willing to pick this up later during the 5.16
> cycle so that Fedora only deviates from upstream for 1 cycle.

5.15.y kernels with this patch added have been in Fedora's
stable updates repo for a while now without any reports of the
regressions you feared this may cause.

Bjorn, I hope that you are willing to merge this patch now that it has
seen some more wide spread testing ?

Regards,

Hans


