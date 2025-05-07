Return-Path: <linux-acpi+bounces-13608-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A5AAAE84C
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 19:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A94F520043
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A2528DB59;
	Wed,  7 May 2025 17:59:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CEB28A40A;
	Wed,  7 May 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640777; cv=none; b=hpDCalbHNJebB53IsMSv/ZQga4TQfSbJsed2mQXYBNcyolGiZfK5xDub1Vrt8ToaD/zrtF0cuxXDX8lH5Gxc7Vhc+ssPb0nY4Rq2FWAhz7CkSJ+XkTX1jOOWoCwlUohjGZuDfaFxrg6qK5Vr9lwl9oX1G485hlgrVFjA3EA+/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640777; c=relaxed/simple;
	bh=wX6INNBRrr2KfnOIS/teo1Q4349z3OUlylBu9eFj/iE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ll/N9iEgbXLl2Kil8i0z0oQ0oKDDm2LMOOl4XQttPNgniM4VL3guEyPE+7XUBZsVjxBy2DYLGpo8O8HPAce7Gt+MuCtgSvX3LifNn1gdvrVNFT0fw7CbAQ0PGtmauhdvSBl2KFXvzdXc2UzER+wp91cZ642r18FM3Re+4cMCtnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36EFD16F2;
	Wed,  7 May 2025 10:59:24 -0700 (PDT)
Received: from [192.168.20.57] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86CA83F5A1;
	Wed,  7 May 2025 10:59:32 -0700 (PDT)
Message-ID: <89d1df2f-29d7-4442-9d92-9c29e7276b08@arm.com>
Date: Wed, 7 May 2025 12:59:30 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
From: Jeremy Linton <jeremy.linton@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Heyne, Maximilian" <mheyne@amazon.de>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Len Brown <lenb@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <214c2a2d-e0ea-4ec6-9925-05e39319e813@arm.com>
 <CAJZ5v0jvWXDQQ++4wmWJ+i=jds+MZ68bRB9+26WM4tAPHFxALw@mail.gmail.com>
 <1911d3b6-f328-40a6-aa03-cde3d79554de@arm.com>
 <CAJZ5v0ii9HLfqfgcp=1qRRX6M1yThf7ZPNkSLVc5GGFhv=N-Lg@mail.gmail.com>
 <ad04d07b-d610-4355-bd47-1d2fb49711f3@arm.com>
 <fb2e3c60-1171-4f5c-852d-a5bfdc4f9c2a@arm.com>
 <25aa77b9-0077-4021-b55c-e94327b7847b@arm.com>
 <CAJZ5v0hTiJSp9q4iWu_EHB47X3Bf9LFY+ZZoqm7aN0cD8Jnjvg@mail.gmail.com>
 <4d449d83-8b86-4933-8584-bdcbd4db88e8@arm.com>
Content-Language: en-US
In-Reply-To: <4d449d83-8b86-4933-8584-bdcbd4db88e8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/7/25 12:35 PM, Jeremy Linton wrote:
> Hi,
> 
> On 5/7/25 12:01 PM, Rafael J. Wysocki wrote:
>> On Wed, May 7, 2025 at 6:41 PM Jeremy Linton <jeremy.linton@arm.com> 
>> wrote:
>>>
>>> On 5/7/25 11:38 AM, Jeremy Linton wrote:
>>>> On 5/7/25 11:31 AM, Jeremy Linton wrote:
>>>>> On 5/7/25 11:12 AM, Rafael J. Wysocki wrote:
>>>>>> On Wed, May 7, 2025 at 5:51 PM Jeremy Linton <jeremy.linton@arm.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> On 5/7/25 10:42 AM, Rafael J. Wysocki wrote:
>>>>>>>> On Wed, May 7, 2025 at 5:25 PM Jeremy Linton
>>>>>>>> <jeremy.linton@arm.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On 5/6/25 8:13 AM, Heyne, Maximilian wrote:
>>>>>>>>>> Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a 
>>>>>>>>>> couple of
>>>>>>>>>> sizeof() calls") corrects the processer entry size but unmasked a
>>>>>>>>>> longer
>>>>>>>>>> standing bug where the last entry in the structure can get
>>>>>>>>>> skipped due
>>>>>>>>>> to an off-by-one mistake if the last entry ends exactly at the
>>>>>>>>>> end of
>>>>>>>>>> the ACPI subtable.
>>>>>>>>>>
>>>>>>>>>> The error manifests for instance on EC2 Graviton Metal instances
>>>>>>>>>> with
>>>>>>>>>>
>>>>>>>>>>       ACPI PPTT: PPTT table found, but unable to locate core 
>>>>>>>>>> 63 (63)
>>>>>>>>>>       [...]
>>>>>>>>>>       ACPI: SPE must be homogeneous
>>>>>>>>>>
>>>>>>>>>> Fixes: 2bd00bcd73e5 ("ACPI/PPTT: Add Processor Properties
>>>>>>>>>> Topology Table parsing")
>>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>>> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
>>>>>>>>>> ---
>>>>>>>>>>      drivers/acpi/pptt.c | 4 ++--
>>>>>>>>>>      1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>>>>>>>>>> index f73ce6e13065d..4364da90902e5 100644
>>>>>>>>>> --- a/drivers/acpi/pptt.c
>>>>>>>>>> +++ b/drivers/acpi/pptt.c
>>>>>>>>>> @@ -231,7 +231,7 @@ static int acpi_pptt_leaf_node(struct
>>>>>>>>>> acpi_table_header *table_hdr,
>>>>>>>>>>                               sizeof(struct acpi_table_pptt));
>>>>>>>>>>          proc_sz = sizeof(struct acpi_pptt_processor);
>>>>>>>>>
>>>>>>>>> This isn't really right, it should be struct acpi_subtable_header,
>>>>>>>>> then
>>>>>>>>> once the header is safe, pull the length from it.
>>>>>>>>>
>>>>>>>>> But then, really if we are trying to fix the original bug that the
>>>>>>>>> table
>>>>>>>>> could be shorter than the data in it suggests, the struct
>>>>>>>>> acpi_pptt_processor length plus its resources needs to be checked
>>>>>>>>> once
>>>>>>>>> the subtype is known to be a processor node.
>>>>>>>>>
>>>>>>>>> Otherwise the original sizeof * change isn't really fixing 
>>>>>>>>> anything.
>>>>>>>>
>>>>>>>> Sorry, what sense did it make to do
>>>>>>>>
>>>>>>>> proc_sz = sizeof(struct acpi_pptt_processor *);
>>>>>>>>
>>>>>>>> here?  As much as proc_sz = 0 I suppose?
>>>>>>>
>>>>>>> No, I agree, I think the original checks were simplified along 
>>>>>>> the way
>>>>>>> to that. It wasn't 'right' either.
>>>>>>>
>>>>>>> The problem is that there are three subtypes of which processor 
>>>>>>> is only
>>>>>>> one, and that struct acpi_pptt_processor doesn't necessarily reflect
>>>>>>> the
>>>>>>> actual size of the processor structure in the table because it has
>>>>>>> optional private resources tagged onto the end.
>>>>>>
>>>>>> Right.
>>>>>>
>>>>>>> So if the bug being fixed is that the length check is validating 
>>>>>>> that
>>>>>>> the table length is less than the data in the table, that's still a
>>>>>>> problem because its only validating the processor node without
>>>>>>> resources.
>>>>>>
>>>>>> Admittedly, it is not my code, but I understand this check as a
>>>>>> termination condition for the loop: If there's not enough space in 
>>>>>> the
>>>>>> table to hold a thing that I'm looking for, I may as well bail out.
>>>>>>
>>>>>>> AKA the return is still potentially returning a pointer to a 
>>>>>>> structure
>>>>>>> which may not be entirely contained in the table.
>>>>>>
>>>>>> Right, but this check should be made anyway before comparing
>>>>>> cpu_node->parent to node_entry, when it is known to be a CPU entry
>>>>>> because otherwise why bother.
>>>>>
>>>>> Right, but then there is a clarity because really its walking the
>>>>> table+subtypes looking for the cpu node. Exiting early because its not
>>>>> big enough for a cpu node makes sense but you still need the cpu node
>>>>> check to avoid a variation on the original bug.
>>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> Roughly something like this:
>>>>>>
>>>>>> proc_sz = sizeof(struct acpi_pptt_processor);
>>>>>>
>>>>>> while ((unsigned long)entry + entry->length <= table_end) {
>>>>>
>>>>> Here your reading the entry, without knowing its long enough. For the
>>>>> leaf check just using struct acpi_pptt_processor is fine, but for the
>>>>> acpi_find_processor_node():
>>>>>
>>>>> proc_sz = sizeof(struct acpi_subtable_type);
>>>>
>>>> Although, maybe I just wrote code that justifies using
>>>> acpi_pptt_processor here because the entry->num_of_priv_resources 
>>>> length
>>>> check isn't being made without it. So ok, use proc_sz = sizeof(struct
>>>> acpi_subtable_type) and assume that we don't care if the subtable type
>>>> is less than proc_sz.
>>>
>>> Sorry for the noise, scratch that, a better solution is just to swap the
>>> length checking in the 'if' statement. Then its clear its iterating
>>> subtable types not processor nodes.
>>
>> Do you mean something like this (modulo GMail-induced whitespace damage):
>>
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -231,16 +231,22 @@
>>                    sizeof(struct acpi_table_pptt));
>>       proc_sz = sizeof(struct acpi_pptt_processor);
>>
>> -    while ((unsigned long)entry + proc_sz < table_end) {
>> -        cpu_node = (struct acpi_pptt_processor *)entry;
>> -        if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
>> -            cpu_node->parent == node_entry)
>> -            return 0;
>> +    while ((unsigned long)entry + proc_sz <= table_end) {
>> +        if ((unsigned long)entry + entry->length <= table_end &&
>> +            entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
>> +            entry->length == proc_sz +
>> +                    entry->number_of_priv_resources * sizeof(u32)) {
>> +            cpu_node = (struct acpi_pptt_processor *)entry;
>> +
>> +            if (cpu_node->parent == node_entry)
>> +                return 0;
>> +        }
>> +
>>           if (entry->length == 0)
>>               return 0;
>> +
>>           entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
>>                        entry->length);
>> -
>>       }
>>       return 1;
>>   }
>>
> 
> 
> Right, I think we are largely on the same page, I flipflopped around 
> about using subtable vs processor but the processor size assumption does 
> remove an extra check. The version that compiles that I was about to 
> test (and this will take me hours) looks like:
> 
> 
> @@ -231,7 +231,8 @@ static int acpi_pptt_leaf_node(struct 
> acpi_table_header *table_hdr,
>                               sizeof(struct acpi_table_pptt));
>          proc_sz = sizeof(struct acpi_pptt_processor);
> 
> -       while ((unsigned long)entry + proc_sz < table_end) {
> +       /* ignore sub-table types that are smaller than a processor node */
> +       while ((unsigned long)entry + proc_sz <= table_end) {
>                  cpu_node = (struct acpi_pptt_processor *)entry;
>                  if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
>                      cpu_node->parent == node_entry)
> @@ -273,15 +274,18 @@ static struct acpi_pptt_processor 
> *acpi_find_processor_node(struct acpi_table_he
>          proc_sz = sizeof(struct acpi_pptt_processor);
> 
>          /* find the processor structure associated with this cpuid */
> -       while ((unsigned long)entry + proc_sz < table_end) {
> +       while ((unsigned long)entry + proc_sz <= table_end) {
>                  cpu_node = (struct acpi_pptt_processor *)entry;
> 
>                  if (entry->length == 0) {
>                          pr_warn("Invalid zero length subtable\n");
>                          break;
>                  }
> +               /* entry->length may not equal proc_sz, revalidate the 
> processor structure length */
>                  if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
>                      acpi_cpu_id == cpu_node->acpi_processor_id &&
> +                   (unsigned long)entry + entry->length <= table_end &&
> +                   entry->length == proc_sz + cpu_node- 
>  >acpi_processor_id * sizeof(u32) &&

s/acpi_processor_id/number_of_priv_resources.

>                       acpi_pptt_leaf_node(table_hdr, cpu_node)) {
>                          return (struct acpi_pptt_processor *)entry;
>                  }
> 
> 
> 


