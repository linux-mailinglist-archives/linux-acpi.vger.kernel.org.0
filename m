Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2511C177A
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 16:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgEAONs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 May 2020 10:13:48 -0400
Received: from foss.arm.com ([217.140.110.172]:41440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728886AbgEAONs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 10:13:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A3261FB;
        Fri,  1 May 2020 07:13:47 -0700 (PDT)
Received: from [10.57.39.240] (unknown [10.57.39.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1F193F68F;
        Fri,  1 May 2020 07:13:45 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] ACPI/IORT: work around num_ids ambiguity
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e4ae3f3d-4cd7-646b-ebc4-52d52f247380@arm.com>
Date:   Fri, 1 May 2020 15:13:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHsXEmaLuVBo7cgdzHju22WKksu7s3B3-hBE4mYhnuJ=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-05-01 2:10 pm, Ard Biesheuvel wrote:
> On Fri, 1 May 2020 at 14:31, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2020-05-01 12:41 pm, Ard Biesheuvel wrote:
>>> On Fri, 1 May 2020 at 12:55, Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> On 2020-05-01 10:58 am, Ard Biesheuvel wrote:
>>>>> The ID mapping table structure of the IORT table describes the size of
>>>>> a range using a num_ids field carrying the number of IDs in the region
>>>>> minus one. This has been misinterpreted in the past in the parsing code,
>>>>> and firmware is known to have shipped where this results in an ambiguity,
>>>>> where regions that should be adjacent have an overlap of one value.
>>>>>
>>>>> So let's work around this by detecting this case specifically: when
>>>>> resolving an ID translation, allow one that matches right at the end of
>>>>> a multi-ID region to be superseded by a subsequent one.
>>>>>
>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>> ---
>>>>>     drivers/acpi/arm64/iort.c | 23 +++++++++++++++-----
>>>>>     1 file changed, 18 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>>>> index 98be18266a73..d826dd9dc4c5 100644
>>>>> --- a/drivers/acpi/arm64/iort.c
>>>>> +++ b/drivers/acpi/arm64/iort.c
>>>>> @@ -316,10 +316,19 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
>>>>>         }
>>>>>
>>>>>         if (rid_in < map->input_base ||
>>>>> -         (rid_in >= map->input_base + map->id_count))
>>>>> +         (rid_in > map->input_base + map->id_count))
>>>>>                 return -ENXIO;
>>>>>
>>>>>         *rid_out = map->output_base + (rid_in - map->input_base);
>>>>> +
>>>>> +     /*
>>>>> +      * Due to confusion regarding the meaning of the id_count field (which
>>>>> +      * carries the number of IDs *minus 1*), we may have to disregard this
>>>>> +      * match if it is at the end of the range, and overlaps with the start
>>>>> +      * of another one.
>>>>> +      */
>>>>> +     if (map->id_count > 0 && rid_in == map->input_base + map->id_count)
>>>>> +             return -EAGAIN;
>>>>>         return 0;
>>>>>     }
>>>>>
>>>>> @@ -404,7 +413,8 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>>>>>         /* Parse the ID mapping tree to find specified node type */
>>>>>         while (node) {
>>>>>                 struct acpi_iort_id_mapping *map;
>>>>> -             int i, index;
>>>>> +             int i, index, rc = 0;
>>>>> +             u32 out_ref = 0, map_id = id;
>>>>>
>>>>>                 if (IORT_TYPE_MASK(node->type) & type_mask) {
>>>>>                         if (id_out)
>>>>> @@ -438,15 +448,18 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>>>>>                         if (i == index)
>>>>>                                 continue;
>>>>>
>>>>> -                     if (!iort_id_map(map, node->type, id, &id))
>>>>> +                     rc = iort_id_map(map, node->type, map_id, &id);
>>>>> +                     if (!rc)
>>>>>                                 break;
>>>>
>>>> This needs a big FW_BUG splat in the case where it did find an overlap.
>>>
>>> Sure, although we did help create the problem in the first place.
>>>
>>>> Ideally we'd also enforce that the other half of must be the first entry
>>>> of another range, but perhaps we're into diminishing returns by that point.
>>>>
>>>
>>> That would mean the regions overlap regardless of whether you
>>> interpret num_ids correctly or not, which means we'll be doing
>>> validation of general well-formedness of the table rather than
>>> providing a workaround for this particular issue.
>>
>> The point was to limit any change in behaviour to the specific case that
>> we need to work around. Otherwise a table that was entirely malformed
>> rather than just off-by-one on the sizes might go from happening-to-work
>> to not working, or vice versa; the diminishing return is in how much we
>> care about that.
>>
> 
> I see. I think it is quite unlikely that a working system with
> overlapping ID ranges would work, and suddenly fail horribly when the
> exact point of overlap is shifted by 1. But yeah, I see your point.

Say that due to a copy-paste error or some other development artefact, 
the same correctly-sized input range is described twice, but the second 
copy has the wrong output base. Unless the IORT implementation is wacky 
enough to process mappings in reverse order it will have worked out OK, 
until suddenly the highest input ID starts falling through to the 
spurious broken mapping instead.

The match quirk implicitly encodes the exact nature of the ambiguity 
known to be present in the given table, so can be confident in fixing it 
up quietly. The heuristic doesn't have that luxury, so is wise to keep 
its scope as narrow as possible, and warn the user when it does choose 
to second-guess something on the off-chance that doing so actually makes 
the situation worse.

Robin.
