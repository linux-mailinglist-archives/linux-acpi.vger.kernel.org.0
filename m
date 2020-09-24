Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F040D27784C
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 20:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgIXSNG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Sep 2020 14:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727753AbgIXSNF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Sep 2020 14:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600971182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=sJJIelKxFQ0hlEzUX0ZOk4cBsIBm5UuX7z7ihEK7veE=;
        b=LqHpZyMSUXpN5gHVPJLHAI9JrOUWA/CdMZzTD56k1RaxnhrZGLS5LsbKuY+VgAPTP3wFGt
        Vnq6Uj07l5N8dtBk3ah1QoHLQ3nRmbYOATtKY6YvMPZUic+eEr6rwYkYN0nbglYlFJMOiP
        RWpFSkOnkW7mEfqO+279a233nThWR8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-ppWqaBkVNzujINn6Dw1dzw-1; Thu, 24 Sep 2020 14:12:58 -0400
X-MC-Unique: ppWqaBkVNzujINn6Dw1dzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 013F056BE2;
        Thu, 24 Sep 2020 18:12:56 +0000 (UTC)
Received: from [10.36.114.4] (ovpn-114-4.ams2.redhat.com [10.36.114.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E85327881A;
        Thu, 24 Sep 2020 18:12:51 +0000 (UTC)
Subject: Re: [PATCH v4 11/23] device-dax: Kill dax_kmem_res
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159643100485.4062302.976628339798536960.stgit@dwillia2-desk3.amr.corp.intel.com>
 <a3ad70a2-77a8-d50e-f372-731a8e27c03b@redhat.com>
 <17686fcc-202e-0982-d0de-54d5349cfb5d@oracle.com>
 <9acc6148-72eb-7016-dba9-46fa87ded5a5@redhat.com>
 <CAPcyv4h5GGV3F-0rFY_pyv9Bj8LAkrwXruxGE=K2y9=dA8oDHw@mail.gmail.com>
 <d160c05b-9caa-1ffb-9c01-5bb261c744b5@redhat.com>
 <CAPcyv4jf9fK5oOcROMx=c-3q6aGFp89MNi-+GoZ-dy1gdNTrJw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <28ad3045-9238-2a77-d74d-9660a36aa4da@redhat.com>
Date:   Thu, 24 Sep 2020 20:12:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jf9fK5oOcROMx=c-3q6aGFp89MNi-+GoZ-dy1gdNTrJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 24.09.20 15:54, Dan Williams wrote:
> On Thu, Sep 24, 2020 at 12:26 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 23.09.20 23:41, Dan Williams wrote:
>>> On Wed, Sep 23, 2020 at 1:04 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 08.09.20 17:33, Joao Martins wrote:
>>>>> [Sorry for the late response]
>>>>>
>>>>> On 8/21/20 11:06 AM, David Hildenbrand wrote:
>>>>>> On 03.08.20 07:03, Dan Williams wrote:
>>>>>>> @@ -37,109 +45,94 @@ int dev_dax_kmem_probe(struct device *dev)
>>>>>>>      * could be mixed in a node with faster memory, causing
>>>>>>>      * unavoidable performance issues.
>>>>>>>      */
>>>>>>> -   numa_node = dev_dax->target_node;
>>>>>>>     if (numa_node < 0) {
>>>>>>>             dev_warn(dev, "rejecting DAX region with invalid node: %d\n",
>>>>>>>                             numa_node);
>>>>>>>             return -EINVAL;
>>>>>>>     }
>>>>>>>
>>>>>>> -   /* Hotplug starting at the beginning of the next block: */
>>>>>>> -   kmem_start = ALIGN(range->start, memory_block_size_bytes());
>>>>>>> -
>>>>>>> -   kmem_size = range_len(range);
>>>>>>> -   /* Adjust the size down to compensate for moving up kmem_start: */
>>>>>>> -   kmem_size -= kmem_start - range->start;
>>>>>>> -   /* Align the size down to cover only complete blocks: */
>>>>>>> -   kmem_size &= ~(memory_block_size_bytes() - 1);
>>>>>>> -   kmem_end = kmem_start + kmem_size;
>>>>>>> -
>>>>>>> -   new_res_name = kstrdup(dev_name(dev), GFP_KERNEL);
>>>>>>> -   if (!new_res_name)
>>>>>>> +   res_name = kstrdup(dev_name(dev), GFP_KERNEL);
>>>>>>> +   if (!res_name)
>>>>>>>             return -ENOMEM;
>>>>>>>
>>>>>>> -   /* Region is permanently reserved if hotremove fails. */
>>>>>>> -   new_res = request_mem_region(kmem_start, kmem_size, new_res_name);
>>>>>>> -   if (!new_res) {
>>>>>>> -           dev_warn(dev, "could not reserve region [%pa-%pa]\n",
>>>>>>> -                    &kmem_start, &kmem_end);
>>>>>>> -           kfree(new_res_name);
>>>>>>> +   res = request_mem_region(range.start, range_len(&range), res_name);
>>>>>>
>>>>>> I think our range could be empty after aligning. I assume
>>>>>> request_mem_region() would check that, but maybe we could report a
>>>>>> better error/warning in that case.
>>>>>>
>>>>> dax_kmem_range() already returns a memory-block-aligned @range but
>>>>> IIUC request_mem_region() isn't checking for that. Having said that
>>>>> the returned @res wouldn't be different from the passed range.start.
>>>>>
>>>>>>>     /*
>>>>>>>      * Ensure that future kexec'd kernels will not treat this as RAM
>>>>>>>      * automatically.
>>>>>>>      */
>>>>>>> -   rc = add_memory_driver_managed(numa_node, new_res->start,
>>>>>>> -                                  resource_size(new_res), kmem_name);
>>>>>>> +   rc = add_memory_driver_managed(numa_node, res->start,
>>>>>>> +                                  resource_size(res), kmem_name);
>>>>>>> +
>>>>>>> +   res->flags |= IORESOURCE_BUSY;
>>>>>>
>>>>>> Hm, I don't think that's correct. Any specific reason why to mark the
>>>>>> not-added, unaligned parts BUSY? E.g., walk_system_ram_range() could
>>>>>> suddenly stumble over it - and e.g., similarly kexec code when trying to
>>>>>> find memory for placing kexec images. I think we should leave this
>>>>>> !BUSY, just as it is right now.
>>>>>>
>>>>> Agreed.
>>>>>
>>>>>>>     if (rc) {
>>>>>>> -           release_resource(new_res);
>>>>>>> -           kfree(new_res);
>>>>>>> -           kfree(new_res_name);
>>>>>>> +           release_mem_region(range.start, range_len(&range));
>>>>>>> +           kfree(res_name);
>>>>>>>             return rc;
>>>>>>>     }
>>>>>>> -   dev_dax->dax_kmem_res = new_res;
>>>>>>> +
>>>>>>> +   dev_set_drvdata(dev, res_name);
>>>>>>>
>>>>>>>     return 0;
>>>>>>>  }
>>>>>>>
>>>>>>>  #ifdef CONFIG_MEMORY_HOTREMOVE
>>>>>>> -static int dev_dax_kmem_remove(struct device *dev)
>>>>>>> +static void dax_kmem_release(struct dev_dax *dev_dax)
>>>>>>>  {
>>>>>>> -   struct dev_dax *dev_dax = to_dev_dax(dev);
>>>>>>> -   struct resource *res = dev_dax->dax_kmem_res;
>>>>>>> -   resource_size_t kmem_start = res->start;
>>>>>>> -   resource_size_t kmem_size = resource_size(res);
>>>>>>> -   const char *res_name = res->name;
>>>>>>>     int rc;
>>>>>>> +   struct device *dev = &dev_dax->dev;
>>>>>>> +   const char *res_name = dev_get_drvdata(dev);
>>>>>>> +   struct range range = dax_kmem_range(dev_dax);
>>>>>>>
>>>>>>>     /*
>>>>>>>      * We have one shot for removing memory, if some memory blocks were not
>>>>>>>      * offline prior to calling this function remove_memory() will fail, and
>>>>>>>      * there is no way to hotremove this memory until reboot because device
>>>>>>> -    * unbind will succeed even if we return failure.
>>>>>>> +    * unbind will proceed regardless of the remove_memory result.
>>>>>>>      */
>>>>>>> -   rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
>>>>>>> -   if (rc) {
>>>>>>> -           any_hotremove_failed = true;
>>>>>>> -           dev_err(dev,
>>>>>>> -                   "DAX region %pR cannot be hotremoved until the next reboot\n",
>>>>>>> -                   res);
>>>>>>> -           return rc;
>>>>>>> +   rc = remove_memory(dev_dax->target_node, range.start, range_len(&range));
>>>>>>> +   if (rc == 0) {
>>>>>>
>>>>>> if (!rc) ?
>>>>>>
>>>>> Better off would be to keep the old order:
>>>>>
>>>>>       if (rc) {
>>>>>               any_hotremove_failed = true;
>>>>>               dev_err(dev, "%#llx-%#llx cannot be hotremoved until the next reboot\n",
>>>>>                               range.start, range.end);
>>>>>               return;
>>>>>       }
>>>>>
>>>>>       release_mem_region(range.start, range_len(&range));
>>>>>       dev_set_drvdata(dev, NULL);
>>>>>       kfree(res_name);
>>>>>       return;
>>>>>
>>>>>
>>>>>>> +           release_mem_region(range.start, range_len(&range));
>>>>>>
>>>>>> remove_memory() does a release_mem_region_adjustable(). Don't you
>>>>>> actually want to release the *unaligned* region you requested?
>>>>>>
>>>>> Isn't it what we're doing here?
>>>>> (The release_mem_region_adjustable() is using the same
>>>>> dax_kmem-aligned range and there's no split/adjust)
>>>>>
>>>>> Meaning right now (+ parent marked as !BUSY), and if I am understanding
>>>>> this correctly:
>>>>>
>>>>> request_mem_region(range.start, range_len)
>>>>>    __request_region(iomem_res, range.start, range_len) -> alloc @parent
>>>>> add_memory_driver_managed(parent.start, resource_size(parent))
>>>>>    __request_region(parent.start, resource_size(parent)) -> alloc @child
>>>>>
>>>>> [...]
>>>>>
>>>>> remove_memory(range.start, range_len)
>>>>>  request_mem_region_adjustable(range.start, range_len)
>>>>>   __release_region(range.start, range_len) -> remove @child
>>>>>
>>>>> release_mem_region(range.start, range_len)
>>>>>   __release_region(range.start, range_len) -> doesn't remove @parent because !BUSY?
>>>>>
>>>>> The add/removal of this relies on !BUSY. But now I am wondering if the parent remaining
>>>>> unreleased is deliberate even on CONFIG_MEMORY_HOTREMOVE=y.
>>>>>
>>>>>       Joao
>>>>>
>>>>
>>>> Thinking about it, if we don't set the parent resource BUSY (which is
>>>> what I think is the right way of doing things), and don't want to store
>>>> the parent resource pointer, we could add something like
>>>> lookup_resource() - e.g., lookup_mem_resource() - , however, searching
>>>> properly in the whole hierarchy (instead of only the first level), and
>>>> traversing down to the last hierarchy. Then it would be as simple as
>>>>
>>>> remove_memory(range.start, range_len)
>>>> res = lookup_mem_resource(range.start);
>>>> release_resource(res);
>>>
>>> Another thought... I notice that you've taught
>>> register_memory_resource() a IORESOURCE_MEM_DRIVER_MANAGED special
>>> case. Lets just make the assumption of add_memory_driver_managed()
>>> that it is the driver's responsibility to mark the range busy before
>>> calling, and the driver's responsibility to release the region. I.e.
>>> validate (rather than request) that the range is busy in
>>> register_memory_resource(), and teach release_memory_resource() to
>>> skip releasing the region when the memory is marked driver managed.
>>> That would let dax_kmem drop its manipulation of the 'busy' flag which
>>> is a layering violation no matter how many comments we put around it.
>>
>> IIUC, that won't work for virtio-mem, whereby the parent resource spans
>> multiple possible (future) add_memory_driver_managed() calls and is
>> (just like for kmem) a pure indication to which device memory ranges belong.
>>
>> For example, when exposing 2GB via a virtio-mem device with max 4GB:
>>
>> (/proc/iomem)
>> 240000000-33fffffff : virtio0
>>   240000000-2bfffffff : System RAM (virtio_mem)
>>
>> And after hotplugging additional 2GB:
>>
>> 240000000-33fffffff : virtio0
>>   240000000-33fffffff : System RAM (virtio_mem)
>>
>> So marking "virtio0" always BUSY (especially right from the start) would
>> be wrong.
> 
> I'm not suggesting to busy the whole "virtio" range, just the portion
> that's about to be passed to add_memory_driver_managed().

I'm afraid I don't get your point. For virtio-mem:

Before:

1. Create virtio0 container resource

2. (somewhen in the future) add_memory_driver_managed()
 - Create resource (System RAM (virtio_mem)), marking it busy/driver
   managed

After:

1. Create virtio0 container resource

2. (somewhen in the future) Create resource (System RAM (virtio_mem)),
   marking it busy/driver managed
3. add_memory_driver_managed()

Not helpful or simpler IMHO.

> 
>> The assumption is that anything that's IORESOURCE_SYSTEM_RAM
>> and IORESOUCE_BUSY is currently added to the system as system RAM (e.g.,
>> after add_memory() and friends, or during boot).
>>
>> I do agree that manually clearing the busy flag is ugly. What we most
>> probably want is request_mem_region() that performs similar checks (no
>> overlaps with existing BUSY resources), but doesn't set the region busy.
>>
> 
> I can't see that working without some way to export and hold the
> resource lock until some agent can atomically claim the range.

I don't think we have to care about races here. The "BUSY" checks is
really just a check for leftovers, e.g., after kexec or after driver
reloading. If somebody else would try to concurrently add System RAM
/something else within the range of your device, something else, very
weird, would be going on (let's call it a BUG, just like if somebody
would be removing system RAM in your device range ...).

For example, in case of virtio-mem, when you unload the driver, it
cannot remove the "virtio0" resource in case some system ram in the
range is still plugged (busy).

So when reloading the driver, it would try to re-create the virtio0
resource, detect that some system ram in the range is still BUSY, and
fail gracefully. This is how it works and how it's expected to work - at
least for virtio-mem.

I assume something similar can be observed with kmem, when trying to
reload the driver or similar - but races shouldn't be relevant here.

-- 
Thanks,

David / dhildenb

