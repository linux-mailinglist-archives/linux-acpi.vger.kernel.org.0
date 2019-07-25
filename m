Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 182807591D
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2019 22:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfGYUtk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jul 2019 16:49:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfGYUtj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Jul 2019 16:49:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17FFE308FBB4;
        Thu, 25 Jul 2019 20:49:39 +0000 (UTC)
Received: from [10.36.116.16] (ovpn-116-16.ams2.redhat.com [10.36.116.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EA6119C68;
        Thu, 25 Jul 2019 20:49:37 +0000 (UTC)
Subject: Re: [PATCH v1] ACPI / scan: Acquire device_hotplug_lock in
 acpi_scan_init()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20190724143017.12841-1-david@redhat.com>
 <20190725125636.GA3582@dhcp22.suse.cz>
 <6dc566c2-faf6-565d-4ef1-2ac3a366bc76@redhat.com>
 <20190725135747.GB3582@dhcp22.suse.cz>
 <447b74ca-f7c7-0835-fd50-a9f7191fe47c@redhat.com>
 <20190725191943.GA6142@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <e31882cf-3290-ea36-77d6-637eaf66fe77@redhat.com>
Date:   Thu, 25 Jul 2019 22:49:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725191943.GA6142@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 25 Jul 2019 20:49:39 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 25.07.19 21:19, Michal Hocko wrote:
> On Thu 25-07-19 16:35:07, David Hildenbrand wrote:
>> On 25.07.19 15:57, Michal Hocko wrote:
>>> On Thu 25-07-19 15:05:02, David Hildenbrand wrote:
>>>> On 25.07.19 14:56, Michal Hocko wrote:
>>>>> On Wed 24-07-19 16:30:17, David Hildenbrand wrote:
>>>>>> We end up calling __add_memory() without the device hotplug lock held.
>>>>>> (I used a local patch to assert in __add_memory() that the
>>>>>>  device_hotplug_lock is held - I might upstream that as well soon)
>>>>>>
>>>>>> [   26.771684]        create_memory_block_devices+0xa4/0x140
>>>>>> [   26.772952]        add_memory_resource+0xde/0x200
>>>>>> [   26.773987]        __add_memory+0x6e/0xa0
>>>>>> [   26.775161]        acpi_memory_device_add+0x149/0x2b0
>>>>>> [   26.776263]        acpi_bus_attach+0xf1/0x1f0
>>>>>> [   26.777247]        acpi_bus_attach+0x66/0x1f0
>>>>>> [   26.778268]        acpi_bus_attach+0x66/0x1f0
>>>>>> [   26.779073]        acpi_bus_attach+0x66/0x1f0
>>>>>> [   26.780143]        acpi_bus_scan+0x3e/0x90
>>>>>> [   26.780844]        acpi_scan_init+0x109/0x257
>>>>>> [   26.781638]        acpi_init+0x2ab/0x30d
>>>>>> [   26.782248]        do_one_initcall+0x58/0x2cf
>>>>>> [   26.783181]        kernel_init_freeable+0x1bd/0x247
>>>>>> [   26.784345]        kernel_init+0x5/0xf1
>>>>>> [   26.785314]        ret_from_fork+0x3a/0x50
>>>>>>
>>>>>> So perform the locking just like in acpi_device_hotplug().
>>>>>
>>>>> While playing with the device_hotplug_lock, can we actually document
>>>>> what it is protecting please? I have a bad feeling that we are adding
>>>>> this lock just because some other code path does rather than with a good
>>>>> idea why it is needed. This patch just confirms that. What exactly does
>>>>> the lock protect from here in an early boot stage.
>>>>
>>>> We have plenty of documentation already
>>>>
>>>> mm/memory_hotplug.c
>>>>
>>>> git grep -C5 device_hotplug mm/memory_hotplug.c
>>>>
>>>> Also see
>>>>
>>>> Documentation/core-api/memory-hotplug.rst
>>>
>>> OK, fair enough. I was more pointing to a documentation right there
>>> where the lock is declared because that is the place where people
>>> usually check for documentation. The core-api documentation looks quite
>>> nice. And based on that doc it seems that this patch is actually not
>>> needed because neither the online/offline or cpu hotplug should be
>>> possible that early unless I am missing something.
>>
>> I really prefer to stick to locking rules as outlined on the
>> interfaces if it doesn't hurt. Why it is not needed is not clear.
>>
>>>
>>>> Regarding the early stage: primarily lockdep as I mentioned.
>>>
>>> Could you add a lockdep splat that would be fixed by this patch to the
>>> changelog for reference?
>>>
>>
>> I have one where I enforce what's documented (but that's of course not
>> upstream and therefore not "real" yet)
> 
> Then I suppose to not add locking for something that is not a problem.
> Really, think about it. People will look at this code and follow the
> lead without really knowing why the locking is needed.
> device_hotplug_lock has its purpose and if the code in question doesn't
> need synchronization for the documented scenarios then the locking
> simply shouldn't be there. Adding the lock just because of a
> non-existing, and IMHO dubious, lockdep splats is just wrong.
> 
> We need to rationalize the locking here, not to add more hacks.

No, sorry. The real hack is calling a function that is *documented* to
be called under lock without it. That is an optimization for a special
case. That is the black magic in the code.

The only alternative I see to this patch is adding a comment like

/*
 * We end up calling __add_memory() without the device_hotplug_lock
 * held. This is fine as we cannot race with other hotplug activities
 * and userspace trying to online memory blocks.
 */

Personally, I don't think that's any better than just grabbing the lock
as we are told to. (honestly, I don't see how optimizing away the lock
here is of *any* help to optimize our overall memory hotplug locking)

@Rafael, what's your take? lock or comment?

-- 

Thanks,

David / dhildenb
