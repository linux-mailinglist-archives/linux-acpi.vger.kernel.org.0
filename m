Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82833D24E0
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jul 2021 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhGVNLR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jul 2021 09:11:17 -0400
Received: from foss.arm.com ([217.140.110.172]:53920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231925AbhGVNLR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Jul 2021 09:11:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21E55113E;
        Thu, 22 Jul 2021 06:51:52 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAB6B3F694;
        Thu, 22 Jul 2021 06:51:48 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e13=2e0?=
 =?UTF-8?Q?-rc7_=28arm-next=2c_8ab9b1a9=29?=
To:     Veronika Kabatova <vkabatov@redhat.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Memory Management <mm-qe@redhat.com>,
        skt-results-master@redhat.com, Jeff Bastian <jbastian@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>, lv.zheng@intel.com,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>
References: <20210629144415.GA28457@lpieralisi>
 <14ca6f72-9b0f-ebd7-9cf8-a5d6190c8e5d@arm.com>
 <20210629163543.GA12361@arm.com> <20210630103715.GA12089@lpieralisi>
 <e548e72c-83a4-2366-dd57-3e746040fea9@arm.com>
 <CAMj1kXH=Q+WNgGsbApiq94z5OpJOnNLcFk_dyoVm_-VQunv3MA@mail.gmail.com>
 <20210630154923.GA16215@lpieralisi>
 <CAMj1kXHgPmJV6sPO8OWYj84Ncts00fzn+gJ=+xzcXYhCxvm-aA@mail.gmail.com>
 <20210705161715.GA19877@lpieralisi>
 <CAMj1kXHQKKnzJUEXMMzt3D1NUodeik8FZN1OTpD9zf8ZWrp6Lw@mail.gmail.com>
 <20210716162617.GA1403@lpieralisi>
 <CA+tGwnmu-uL1v3vWO1yzH1i1ru6+EbVdEKnGOifoS6fLuTTGoQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3422218f-73cc-ed3d-025a-ccf809075968@arm.com>
Date:   Thu, 22 Jul 2021 14:51:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CA+tGwnmu-uL1v3vWO1yzH1i1ru6+EbVdEKnGOifoS6fLuTTGoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-07-22 13:38, Veronika Kabatova wrote:
> On Fri, Jul 16, 2021 at 6:26 PM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>>
>> On Fri, Jul 16, 2021 at 06:16:01PM +0200, Ard Biesheuvel wrote:
>>> On Mon, 5 Jul 2021 at 18:17, Lorenzo Pieralisi
>>> <lorenzo.pieralisi@arm.com> wrote:
>>>>
>>>> On Wed, Jun 30, 2021 at 08:18:22PM +0200, Ard Biesheuvel wrote:
>>>>
>>>> [...]
>>>>
>>>>>> In current code, even if the BERT were mapped with acpi_os_map_iomem()
>>>>>> this would change nothing since it's acpi_os_ioremap() that runs the
>>>>>> rule (backed up by EFI memory map region info).
>>>>>>
>>>>>
>>>>> Indeed. So the fact that acpi_os_map_memory() is backed by
>>>>> acpi_os_ioremap() is something we should fix. So they should both
>>>>> consult the EFI memory map, but have different fallback defaults if
>>>>> the region is not annotated correctly.
>>>>
>>>> Put together patch below even though I am not really satisfied, a tad
>>>> intrusive and duplicate code in generic/arch backends, compile tested
>>>> only; overall this IO vs memory mapping distinction is a bit too fuzzy
>>>> for my taste - there is legacy unfortunately to consider though.
>>>>
>>>
>>> I'd say that this does not look unreasonable at all. Is there any way
>>> we could get this tested on actual hw?
>>
>> Sure, I was meant to follow-up and was caught up in something else,
>> sorry.
>>
>> I will clean up the log, push it out in a branch on Monday, CKI
>> should pick it up. I will also think about other possible testing
>> options.
>>
> 
> Hi,
> 
> thanks for the patience with the testing, the stress-ng test couldn't
> deal with a new glibc version and had to be fixed and this week
> has just been crazy.
> 
> I managed to do 2 runs of the updated tree with the stress-ng test
> and it didn't hit the problem. Given how unreliably it reproduces it
> doesn't mean all that much. I still have one more run pending and
> can submit more if needed.
> 
> However, we ran into a panic with this tree on a completely
> different machine:
> 
> https://gitlab.com/-/snippets/2152899/raw/main/snippetfile1.txt

All the warnings from arch_setup_dma_ops() there are (unfortunately) 
pretty much legitimate for that platform, and should be gone again since 
rc2 with commit c1132702c71f.

> The machine also hit a hardware error during LTP:
> 
> https://gitlab.com/-/snippets/2152899/raw/main/snippetfile2.txt

Hmm, if "access mode: secure" in that fault report implies that the 
firmnware itself has done something dodgy to raise an SError, I'm not 
sure there's much we can do about that...

Robin.
