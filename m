Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2392C2A151F
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Oct 2020 11:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgJaKVg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 31 Oct 2020 06:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726702AbgJaKVf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 31 Oct 2020 06:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604139693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dGSnhPkl0I7vSPYzYjDBbctn/wTQ7qKaQlUwoPQ5d7Q=;
        b=YD8/d0bwyJb+VyFUg2DOjQz6bSHKrIrnTFVvgxcIrHSHCkxqMi54/+nHu8FTkrFumgawMT
        b7zd9IBk6r1oY90xywy5k47bIETXDERBP/Tqra7DxD/hi6USFdZxy12aReM4qCos5E1FW0
        DKkDUIOY0C5CfNFuEuADd+rDFldnBhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-r2J-ZnybPsGTt8b1mWtArg-1; Sat, 31 Oct 2020 06:21:31 -0400
X-MC-Unique: r2J-ZnybPsGTt8b1mWtArg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AE0E805F08;
        Sat, 31 Oct 2020 10:21:29 +0000 (UTC)
Received: from [10.36.112.45] (ovpn-112-45.ams2.redhat.com [10.36.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 182FB19482;
        Sat, 31 Oct 2020 10:21:26 +0000 (UTC)
Subject: Re: Onlining CXL Type2 device coherent memory
To:     Dan Williams <dan.j.williams@intel.com>,
        Vikram Sethi <vsethi@nvidia.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
 <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <451b2571-c3e8-97d8-bfd0-f8054a1b75c5@redhat.com>
Date:   Sat, 31 Oct 2020 11:21:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 30.10.20 21:37, Dan Williams wrote:
> On Wed, Oct 28, 2020 at 4:06 PM Vikram Sethi <vsethi@nvidia.com> wrote:
>>
>> Hello,
>>
>> I wanted to kick off a discussion on how Linux onlining of CXL [1] type 2 device
>> Coherent memory aka Host managed device memory (HDM) will work for type 2 CXL
>> devices which are available/plugged in at boot. A type 2 CXL device can be simply
>> thought of as an accelerator with coherent device memory, that also has a
>> CXL.cache to cache system memory.
>>
>> One could envision that BIOS/UEFI could expose the HDM in EFI memory map
>> as conventional memory as well as in ACPI SRAT/SLIT/HMAT. However, at least
>> on some architectures (arm64) EFI conventional memory available at kernel boot
>> memory cannot be offlined, so this may not be suitable on all architectures.
> 
> That seems an odd restriction. Add David, linux-mm, and linux-acpi as
> they might be interested / have comments on this restriction as well.
> 

I am missing some important details.

a) What happens after offlining? Will the memory be remove_memory()'ed? 
Will the device get physically unplugged?

b) What's the general purpose of the memory and its intended usage when 
*not* exposed as system RAM? What's the main point of treating it like 
ordinary system RAM as default?

Also, can you be sure that you can offline that memory? If it's 
ZONE_NORMAL (as usually all system RAM in the initial map), there are no 
such guarantees, especially once the system ran for long enough, but 
also in other cases (e.g., shuffling), or if allocation policies change 
in the future.

So I *guess* you would already have to use kernel cmdline hacks like 
"movablecore" to make it work. In that case, you can directly specify 
what you *actually* want (which I am not sure yet I completely 
understood) - e.g., something like "memmap=16G!16G" ... or something 
similar.

I consider offlining+removing *boot* memory to not physically unplug it 
(e.g., a DIMM getting unplugged) abusing the memory hotunplug 
infrastructure. It's a different thing when manually adding memory like 
dax_kmem does via add_memory_driver_managed().


Now, back to your original question: arm64 does not support physically 
unplugging DIMMs that were part of the initial map. If you'd reboot 
after unplugging a DIMM, your system would crash. We achieve that by 
disallowing to offline boot memory - we could also try to handle it in 
ACPI code. But again, most uses of offlining+removing boot memory are 
abusing the memory hotunplug infrastructure and should rather be solved 
cleanly via a different mechanism (firmware, kernel cmdline, ...).

Just recently discussed in

https://lkml.kernel.org/r/de8388df2fbc5a6a33aab95831ba7db4@codeaurora.org

>> Further, the device driver associated with the type 2 device/accelerator may
>> want to save off a chunk of HDM for driver private use.
>> So it seems the more appropriate model may be something like dev dax model
>> where the device driver probe/open calls add_memory_driver_managed, and
>> the driver could choose how much of the HDM it wants to reserve and how
>> much to make generally available for application mmap/malloc.
> 
> Sure, it can always be driver managed. The trick will be getting the
> platform firmware to agree to not map it by default, but I suspect
> you'll have a hard time convincing platform-firmware to take that
> stance. The BIOS does not know, and should not care what OS is booting
> when it produces the memory map. So I think CXL memory unplug after
> the fact is more realistic than trying to get the BIOS not to map it.
> So, to me it looks like arm64 needs to reconsider its unplug stance.

My personal opinion is, if memory isn't just "ordinary system RAM", then 
let the system know early that memory is special (as we do with 
soft-reserved).

Ideally, you could configure the firmware (e.g., via BIOS setup) on what 
to do, that's the cleanest solution, but I can understand that's rather 
hard to achieve.

-- 
Thanks,

David / dhildenb

