Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E9E763A4
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2019 12:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGZKhO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jul 2019 06:37:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfGZKhN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Jul 2019 06:37:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A82E5AFE3;
        Fri, 26 Jul 2019 10:37:13 +0000 (UTC)
Received: from [10.36.116.244] (ovpn-116-244.ams2.redhat.com [10.36.116.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD75D608D0;
        Fri, 26 Jul 2019 10:37:11 +0000 (UTC)
Subject: Re: [PATCH v1] ACPI / scan: Acquire device_hotplug_lock in
 acpi_scan_init()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20190725135747.GB3582@dhcp22.suse.cz>
 <447b74ca-f7c7-0835-fd50-a9f7191fe47c@redhat.com>
 <20190725191943.GA6142@dhcp22.suse.cz>
 <e31882cf-3290-ea36-77d6-637eaf66fe77@redhat.com>
 <20190726075729.GG6142@dhcp22.suse.cz>
 <fd9e8495-1a93-ac47-442f-081d392ed09b@redhat.com>
 <20190726083117.GJ6142@dhcp22.suse.cz>
 <38d76051-504e-c81a-293a-0b0839e829d3@redhat.com>
 <20190726084408.GK6142@dhcp22.suse.cz>
 <45c9f942-fe67-fa60-b62f-31867f9c6e53@redhat.com>
 <20190726103112.GL6142@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <7dcfb097-0090-e60f-7d14-9a60dae9a474@redhat.com>
Date:   Fri, 26 Jul 2019 12:37:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190726103112.GL6142@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 26 Jul 2019 10:37:13 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 26.07.19 12:31, Michal Hocko wrote:
> On Fri 26-07-19 10:57:52, David Hildenbrand wrote:
>> On 26.07.19 10:44, Michal Hocko wrote:
>>> On Fri 26-07-19 10:36:42, David Hildenbrand wrote:
>>>> On 26.07.19 10:31, Michal Hocko wrote:
>>> [...]
>>>>> Anyway, my dislike of the device_hotplug_lock persists. I would really
>>>>> love to see it go rather than grow even more to the hotplug code. We
>>>>> should be really striving for mem hotplug internal and ideally range
>>>>> defined locking longterm. 
>>>>
>>>> Yes, and that is a different story, because it will require major
>>>> changes to all add_memory() users. (esp, due to the documented race
>>>> conditions). Having that said, memory hotplug locking is not ideal yet.
>>>
>>> I am really happy to hear that we are on the same page here. Do we have
>>> any document (I am sorry but I am lacking behind recent development in
>>> this area) that describes roadblocks to remove device_hotplug_lock?
>>
>> Only the core-api document I mentioned (I documented there quite some
>> current conditions I identified back then).
> 
> That document doesn't describe which _data structures_ are protected by
> the lock though. It documents only the current state of locking.

Yeah, I also thing we should find out more and document it.
Unfortunately, optimize the locking is not very high on my priority list
(there are more critical things to figure out than optimizing locking
that at least seems to work :) ). It is on my list, though.

> 
>> I am not sure if we can remove it completely from
>> add_memory()/remove_memory(): We actually create/delete devices which
>> can otherwise create races with user space.
> 
> More details would be really appreciated.
> 
>> Besides that:
>> - try_offline_node() needs the lock to synchronize against cpu hotplug
>> - I *assume* try_online_node() needs it as well
> 
> more details on why would be great.
> 
>> Then, there is the possible race condition with user space onlining
>> memory avoided by the lock. Also, currently the lock protects the
>> "online_type" when onlining memory.
> 
> I do not see the race, if the user API triggered online/offline takes a
> range lock on the affected physical memory range

Yeah, and that's still future work. Another item on the list.

> 
>> Then, there might be other global variables (eventually
>> zone/node/section related) that might need this lock right now - no
>> details known.
> 
> zones/nodes have their own locking for spans. Sections should be using
> a low level locking but I am not really sure this is needed if there is
> a mem hotplug lock in place (range or global)
> 
>> IOW, we have to be very carefully and it is more involved than it might
>> seem.
> 
> I am not questioning that. And that is why I am asking about a todo list
> for that transition.

I think somebody will have to invest quite some effort to create that
todo list first :) (I'd love to provide more information right now, but
I don't really have more)

> 
>> Locking is definitely better (and more reliably!) than one year ago, but
>> there is definitely a lot to do. (unfortunately, just like in many areas
>> in memory hotplug code :( - say zone handling when offlining/failing to
>> online memory).
> 
> Yeah, the code is shaping up. And I am happy to see that happening. But
> please try to understand that I really do not like to see some ad-hoc
> locking enforcement without a clear locking model in place. This patch
> is an example of it. Whoever would like to rationalize locking further
> will have to stumble over this and scratch head why the hack the locking
> is there and my experience tells me that people usually go along with
> existing code and make further assumptions based on that so we are
> unlikely to get rid of the locking...

I do understand, but we really have to rethink locking in a more broad
sense and document it. Here, I am going to add a comment as requested by
Rafael.

-- 

Thanks,

David / dhildenb
