Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F961C18D2
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgEAO6A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 May 2020 10:58:00 -0400
Received: from foss.arm.com ([217.140.110.172]:42200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbgEAO6A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 10:58:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E5EB30E;
        Fri,  1 May 2020 07:57:59 -0700 (PDT)
Received: from [10.57.39.240] (unknown [10.57.39.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62C83F68F;
        Fri,  1 May 2020 07:57:57 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] ACPI/IORT: work around num_ids ambiguity
To:     Ard Biesheuvel <ardb@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20200501095843.25401-1-ardb@kernel.org>
 <20200501095843.25401-3-ardb@kernel.org>
 <e3c7bdab-a2b0-d7c9-5c7b-eee680509338@arm.com>
 <CAMj1kXH0mcK3N94=uOuiL2_iy=eWhsnoXhvfiXv_kQ_j=F2a_Q@mail.gmail.com>
 <18e01ac7-974e-8308-c18c-67aa3fd7ad4e@arm.com>
 <CAMj1kXHsXEmaLuVBo7cgdzHju22WKksu7s3B3-hBE4mYhnuJ=Q@mail.gmail.com>
 <20200501134956.GA7240@e121166-lin.cambridge.arm.com>
 <CAMj1kXGL-P_jNprTZSpLyEMMmHCcPq5-LcZeaRj5NtCeUKaJUA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7800f454-d630-e718-b187-d36f21a14ee9@arm.com>
Date:   Fri, 1 May 2020 15:57:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGL-P_jNprTZSpLyEMMmHCcPq5-LcZeaRj5NtCeUKaJUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-05-01 3:35 pm, Ard Biesheuvel wrote:
> On Fri, 1 May 2020 at 15:50, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>>
>> On Fri, May 01, 2020 at 03:10:59PM +0200, Ard Biesheuvel wrote:
>>
>> [...]
>>
>>>>>> If we silently fix things up, then people will continue to write broken
>>>>>> tables without even realising, new OSes will have to implement the same
>>>>>> mechanism because vendors will have little interest in changing things
>>>>>> that have worked "correctly" with Linux for years, and we've effectively
>>>>>> achieved a de-facto redefinition of the spec. Making our end of the
>>>>>> interface robust is obviously desirable, but there still needs to be
>>>>>> *some* incentive for the folks on the other end to get it right.
>>>>>>
>>>>>
>>>>> Agreed. But at least we'll be able to detect it and flag it in the
>>>>> general case, rather than having a special case for D05/06 only
>>>>> (although I suppose splitting the output ranges like those platforms
>>>>> do is rather unusual)
>>>>
>>>> Yup, in principle the fixed quirk list gives a nice reassuring sense of
>>>> "we'll work around these early platforms and everyone from now on will
>>>> get it right", but whether reality plays out that way is another matter
>>>> entirely...
>>>
>>> The reason I am looking into this is that I think the fix should go to
>>> stable, given that the current situation makes it impossible to write
>>> firmware that works with older and newer kernels.
>>
>> Yes. If we do remove the quirk the sooner we do it the better to
>> reduce the stable patches.
>>
>>> Lorenzo said he wouldn't mind taking the current version with ACPI OEM
>>> ID matching back to -stable, but it's another quirk list to manage,
>>> which I would prefer to avoid.
>>>
>>> But I don't care deeply either way, to be honest, as long as we can
>>> get something backported so compliant firmware is not being penalized
>>> anymore.
>>
>> Question: if we remove the iort_workaround_oem_info stuff but we *do*
>> keep the existing apply_id_count_workaround flag and we set it by going
>> through all the mappings at boot time and detect if any of these
>> off-by-one conditions apply - would the resulting code be any simpler ?
>>
>> The global flag would apply (as it does now) to _all_ mappings but it is
>> very likely that if the off-by-one firmware bug is present it applies to
>> the IORT table as a whole rather than a single mapping entry.
>>
> 
> This particular issue is based on a misinterpretation, so I agree that
> it makes sense to have a global flag, as long as we only set it if the
> mappings are fully consistent in every other respect, or we'll run the
> risk of hitting issues like the one Robin describes, where things
> happen to work, but will fail once we apply the heuristic. Such an
> issue could exist on one end of the table, while we could spot the
> off-by-one issue somewhere else.
> 
> Which brings us back to a point I made earlier: do we really want to
> validate the table and ensure that it is fully internally consistent?
> Or do we want to be robust in the face of a single known issue that we
> helped create?
> 
> So in my opinion, just fixing it up when we run into it is fine. I can
> add the extra sanity check to reduce the potential fallout for other
> broken systems, but beyond that, I think we shouldn't do too much.

Agreed - AFAICS the extra robustness I'm asking for should only amount 
to a handful more lines on top of the proposed patch (maybe a couple of 
positive return values for "by the way this came from the start/end of a 
mapping range" instead of -EAGAIN). I think a separate scanning pass is 
likely to add up to more complexity and similar-but-not-quite-reusable 
code than simply detecting and handling potential off-by-one edges in-line.

Robin.
