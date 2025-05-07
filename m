Return-Path: <linux-acpi+bounces-13597-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C80AAE596
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 17:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BB718897B8
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8E428BA99;
	Wed,  7 May 2025 15:51:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6421A28C2A2;
	Wed,  7 May 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633105; cv=none; b=mJ5wVxLBBiGcw4i9rX+FIE+JBhFMgnNHnCwATfoGV7hJD1MTTQpuvgjqYfPM8jOTSSt07RjvoPp3YYG0Z532FPLAwet6/jrdAY85FnuhPTnM0PWeXUeoVPqF/tm1g9+9HnYZJDwt+OMyewQ6ruxXfA5tJlcgVut2D3guRtGRnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633105; c=relaxed/simple;
	bh=GJtTcPXw7UlSwrjmMBiZBJnv4ziGu/CqEtxw+6R/cS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aR3FoEAfOc0W+aVhfk/OX2+t1jKfm8j2GFqJMVnSwgXyD7PMh3BzkD5g6I6Gq+HKBruda51JOaohG3unCJwb/sBO3KfqmOp+Qwn1EKMzjuKbvxl8g4Bl0wT+1kntGTb3Q0j/AcLiLK3BQxljzlEtu+EVkyvvVRTysZbDBortop4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7986816F2;
	Wed,  7 May 2025 08:51:32 -0700 (PDT)
Received: from [192.168.20.57] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D7103F58B;
	Wed,  7 May 2025 08:51:39 -0700 (PDT)
Message-ID: <1911d3b6-f328-40a6-aa03-cde3d79554de@arm.com>
Date: Wed, 7 May 2025 10:51:38 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
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
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <CAJZ5v0jvWXDQQ++4wmWJ+i=jds+MZ68bRB9+26WM4tAPHFxALw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/7/25 10:42 AM, Rafael J. Wysocki wrote:
> On Wed, May 7, 2025 at 5:25 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>>
>> Hi,
>>
>> On 5/6/25 8:13 AM, Heyne, Maximilian wrote:
>>> Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple of
>>> sizeof() calls") corrects the processer entry size but unmasked a longer
>>> standing bug where the last entry in the structure can get skipped due
>>> to an off-by-one mistake if the last entry ends exactly at the end of
>>> the ACPI subtable.
>>>
>>> The error manifests for instance on EC2 Graviton Metal instances with
>>>
>>>     ACPI PPTT: PPTT table found, but unable to locate core 63 (63)
>>>     [...]
>>>     ACPI: SPE must be homogeneous
>>>
>>> Fixes: 2bd00bcd73e5 ("ACPI/PPTT: Add Processor Properties Topology Table parsing")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
>>> ---
>>>    drivers/acpi/pptt.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>>> index f73ce6e13065d..4364da90902e5 100644
>>> --- a/drivers/acpi/pptt.c
>>> +++ b/drivers/acpi/pptt.c
>>> @@ -231,7 +231,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
>>>                             sizeof(struct acpi_table_pptt));
>>>        proc_sz = sizeof(struct acpi_pptt_processor);
>>
>> This isn't really right, it should be struct acpi_subtable_header, then
>> once the header is safe, pull the length from it.
>>
>> But then, really if we are trying to fix the original bug that the table
>> could be shorter than the data in it suggests, the struct
>> acpi_pptt_processor length plus its resources needs to be checked once
>> the subtype is known to be a processor node.
>>
>> Otherwise the original sizeof * change isn't really fixing anything.
> 
> Sorry, what sense did it make to do
> 
> proc_sz = sizeof(struct acpi_pptt_processor *);
> 
> here?  As much as proc_sz = 0 I suppose?

No, I agree, I think the original checks were simplified along the way 
to that. It wasn't 'right' either.

The problem is that there are three subtypes of which processor is only 
one, and that struct acpi_pptt_processor doesn't necessarily reflect the 
actual size of the processor structure in the table because it has 
optional private resources tagged onto the end.

So if the bug being fixed is that the length check is validating that 
the table length is less than the data in the table, that's still a 
problem because its only validating the processor node without resources.

AKA the return is still potentially returning a pointer to a structure 
which may not be entirely contained in the table.


> 
>>>
>>> -     while ((unsigned long)entry + proc_sz < table_end) {
>>> +     while ((unsigned long)entry + proc_sz <= table_end) {
>>>                cpu_node = (struct acpi_pptt_processor *)entry;
>>>                if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
> 
> And this checks if the current entry is a CPU one and goes to the next
> one otherwise, so it clearly looks for a CPU entry.
> 
> So the size check is logically correct now: It checks if there's
> enough space in the table to hold a CPU entry that's being looked for.
> The only problem with it is the assumption that the size of a CPU
> entry must be greater than sizeof(struct acpi_pptt_processor).
> 
> Previously, it didn't make sense at all.
> 
>>>                    cpu_node->parent == node_entry)
>>> @@ -273,7 +273,7 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
>>>        proc_sz = sizeof(struct acpi_pptt_processor);
>>>
>>>        /* find the processor structure associated with this cpuid */
>>> -     while ((unsigned long)entry + proc_sz < table_end) {
>>> +     while ((unsigned long)entry + proc_sz <= table_end) {
>>>                cpu_node = (struct acpi_pptt_processor *)entry;
>>>
>>>                if (entry->length == 0) {


