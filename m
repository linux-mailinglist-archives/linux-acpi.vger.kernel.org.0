Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4D11A367
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2019 05:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfLKE1q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Dec 2019 23:27:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:42090 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfLKE1p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Dec 2019 23:27:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 20:27:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="210642007"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.152]) ([10.239.196.152])
  by fmsmga008.fm.intel.com with ESMTP; 10 Dec 2019 20:27:42 -0800
Subject: Re: [PATCH] ACPI/HMAT: Fix the parsing of Cache Associativity and
 Write Policy
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191202070348.32148-1-tao3.xu@intel.com>
 <CAJZ5v0hqjR5EdrxcdkLUpxseFiizqNjtA3nYdDtZiSt85JiywQ@mail.gmail.com>
 <6dbcdaff-feae-68b9-006d-dd8aec032553@intel.com>
 <CAJZ5v0jYb7XQC7u0rmxF-XVMAsEoOfmD11-FYDvMrZuOuzgyiA@mail.gmail.com>
 <0e4219c3-943a-e416-e5eb-723bed8c9383@intel.com>
 <CAJZ5v0h6_7AoYW5Syk=BUR656eW11A3GjA7uvmTA6ayByOaqBg@mail.gmail.com>
 <82e7361e-256e-002c-6b30-601cec1fad07@intel.com>
 <0f8084fd-86a9-081c-e32a-20c756c9daf6@intel.com>
 <CAPcyv4gq690oQgjD53qF_v7YPT2shR0pw5ubtXbOcYMQfH1wxg@mail.gmail.com>
From:   Tao Xu <tao3.xu@intel.com>
Message-ID: <abb6f080-4523-7af3-d900-e1d500b35032@intel.com>
Date:   Wed, 11 Dec 2019 12:27:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gq690oQgjD53qF_v7YPT2shR0pw5ubtXbOcYMQfH1wxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/11/2019 11:37 AM, Dan Williams wrote:
> On Tue, Dec 10, 2019 at 7:05 PM Tao Xu <tao3.xu@intel.com> wrote:
>>
>>
>> On 12/10/19 9:18 PM, Tao Xu wrote:
>>> On 12/10/2019 4:27 PM, Rafael J. Wysocki wrote:
>>>> On Tue, Dec 10, 2019 at 9:19 AM Tao Xu <tao3.xu@intel.com> wrote:
>>>>>
>>>>> On 12/10/2019 4:06 PM, Rafael J. Wysocki wrote:
>>>>>> On Tue, Dec 10, 2019 at 2:04 AM Tao Xu <tao3.xu@intel.com> wrote:
>>>>>>>
>>>>>>> On 12/9/2019 6:01 PM, Rafael J. Wysocki wrote:
>>>>>>>> On Mon, Dec 2, 2019 at 8:03 AM Tao Xu <tao3.xu@intel.com> wrote:
>>>>>>>>>
>>>>>>>>> In chapter 5.2.27.5, Table 5-147: Field "Cache Attributes" of
>>>>>>>>> ACPI 6.3 spec: 0 is "None", 1 is "Direct Mapped", 2 is "Complex
>>>>>>>>> Cache
>>>>>>>>> Indexing" for Cache Associativity; 0 is "None", 1 is "Write Back",
>>>>>>>>> 2 is "Write Through" for Write Policy.
>>>>>>>>
>>>>>>>> Well, I'm not sure what the connection between the above statement,
>>>>>>>> which is correct AFAICS, and the changes made by the patch is.
>>>>>>>>
>>>>>>>> Is that the *_OTHER symbol names are confusing or something deeper?
>>>>>>>>
>>>>>>>
>>>>>>> Because in include/acpi/actbl1.h:
>>>>>>>
>>>>>>> #define ACPI_HMAT_CA_NONE                     (0)
>>>>>>>
>>>>>>> ACPI_HMAT_CA_NONE is 0, but in include/linux/node.h:
>>>>>>>
>>>>>>>        enum cache_indexing {
>>>>>>>               NODE_CACHE_DIRECT_MAP,
>>>>>>>               NODE_CACHE_INDEXED,
>>>>>>>               NODE_CACHE_OTHER,
>>>>>>>        };
>>>>>>> NODE_CACHE_OTHER is 2, and for otner enum:
>>>>>>>
>>>>>>>              case ACPI_HMAT_CA_DIRECT_MAPPED:
>>>>>>>                      tcache->cache_attrs.indexing =
>>>>>>> NODE_CACHE_DIRECT_MAP;
>>>>>>>                      break;
>>>>>>>              case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
>>>>>>>                      tcache->cache_attrs.indexing = NODE_CACHE_INDEXED;
>>>>>>>                      break;
>>>>>>> in include/acpi/actbl1.h:
>>>>>>>
>>>>>>>      #define ACPI_HMAT_CA_DIRECT_MAPPED            (1)
>>>>>>>      #define ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING   (2)
>>>>>>>
>>>>>>> but in include/linux/node.h:
>>>>>>>
>>>>>>> NODE_CACHE_DIRECT_MAP is 0, NODE_CACHE_INDEXED is 1. This is
>>>>>>> incorrect.
>>>>>>
>>>>>> Why is it incorrect?
>>>>>
>>>>> Sorry I paste the wrong pre-define.
>>>>>
>>>>> This is the incorrect line:
>>>>>
>>>>> case ACPI_HMAT_CA_DIRECT_MAPPED:
>>>>> tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
>>>>>
>>>>> ACPI_HMAT_CA_DIRECT_MAPPED is 1, NODE_CACHE_DIRECT_MAP is 0. That means
>>>>> if HMAT table input 1 for cache_attrs.indexing, kernel store 0 in
>>>>> cache_attrs.indexing. But in ACPI 6.3, 0 means "None". So for the whole
>>>>> switch codes:
>>>>
>>>> This is a mapping between the ACPI-defined values and the generic ones
>>>> defined in the kernel.  There is not rule I know of by which they must
>>>> be the same numbers.  Or is there such a rule which I'm missing?
>>>>
>>>> As long as cache_attrs.indexing is used consistently going forward,
>>>> the difference between the ACPI-defined numbers and its values
>>>> shouldn't matter, should it?
>>>>
>>> Yes, it will not influence the ACPI HMAT tables. Only influence is the
>>> sysfs, as in
>>> https://www.kernel.org/doc/html/latest/admin-guide/mm/numaperf.html:
>>>
>>> # tree sys/devices/system/node/node0/memory_side_cache/
>>> /sys/devices/system/node/node0/memory_side_cache/
>>> |-- index1
>>> |   |-- indexing
>>> |   |-- line_size
>>> |   |-- size
>>> |   `-- write_policy
>>>
>>> indexing is parsed in this file, so it can be read by user-space.
>>> Although now there is no user-space tool use this information to do some
>>> thing. But I am wondering if it is used in the future, someone use it to
>>> show the memory side cache information to user or use it to do
>>> performance turning.
>>
>> I finish a test using emulated ACPI HMAT from QEMU
>> (branch:hmat https://github.com/taoxu916/qemu.git)
>>
>> And I get the kernel log and sysfs output:
>> [    0.954288] HMAT: Cache: Domain:0 Size:20480 Attrs:00081111 SMBIOS
>> Handles:0
>> [    0.954835] HMAT: Cache: Domain:1 Size:15360 Attrs:00081111 SMBIOS
>> Handles:0
>>
>> /sys/devices/system/node/node0/memory_side_cache/index1 # cat indexing
>> 0
>> /sys/devices/system/node/node0/memory_side_cache/index1 # cat write_policy
>> 0
>>
>> Note that 'Attrs' is printed using %x, so we can get:
>> (attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8 = 1,
>> (attrs & ACPI_HMAT_WRITE_POLICY) >> 12       = 1
>>
>> but we get 0 in sysfs, so if user or software read this information and
>> read the ACPI 6.3 spec, will think there is 'none' for Cache
>> Associativity or Write Policy.
> 
> The sysfs interface is not meant to reflect the ACPI values. This
> sysfs information may be populated by another platform firmware
> (non-ACPI). I would have preferred that these files use text values
> rather than numbers. However, at least the ABI documentation gives the
> expected translation:
> 
> What:           /sys/devices/system/node/nodeX/memory_side_cache/indexY/indexing
> Date:           December 2018
> Contact:        Keith Busch <keith.busch@intel.com>
> Description:
>                  The caches associativity indexing: 0 for direct mapped,
>                  non-zero if indexed.
> 
> What:
> /sys/devices/system/node/nodeX/memory_side_cache/indexY/write_policy
> Date:           December 2018
> Contact:        Keith Busch <keith.busch@intel.com>
> Description:
>                  The cache write policy: 0 for write-back, 1 for write-through,
>                  other or unknown.
> 

I understand. Thank you for your explanation.
