Return-Path: <linux-acpi+bounces-16604-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E04B520F4
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E5F583886
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18DB2D594F;
	Wed, 10 Sep 2025 19:29:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D302D5C6C;
	Wed, 10 Sep 2025 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532586; cv=none; b=XJnxSW/T/+2iYMaukjqNNoA6P4ZrTmH5o1Wgi3JmYwCWjfjZ7hWbB5tfvoiGZosEchf2jAJ3/btiqeoARfI4ni0n8vD8JJ6Clya5y0QY254FnQZIXQGdHhtUXtKyWVmFYPyikwRExLn6pIGTXV7ykhjgLAfI83V66brKgcwnCx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532586; c=relaxed/simple;
	bh=EQm5aGR2whywPdCZN9K5yf3IzyzjLm+QR4mWwFUORhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hb5lYKcdzL5/OObyoQLCnxKShxxsk9tBW6tWBsyGnNYHGAw1nExQK+2DxTSMINwhS+HQGflNIPsZ7+YjJJ92KfJCkREy5nKs0i5FdOmZctP653/KgeoaqdMHSCqjicIkO/8kbCCEvq+1DttU+eiw8o975nmvR4w61RfFUfwhxF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2577731DB;
	Wed, 10 Sep 2025 12:29:36 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 028F03F694;
	Wed, 10 Sep 2025 12:29:37 -0700 (PDT)
Message-ID: <ff91d387-7fe6-4461-a95c-a46b73e4ec73@arm.com>
Date: Wed, 10 Sep 2025 20:29:36 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] ACPI / PPTT: Add a helper to fill a cpumask from a
 processor container
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-4-james.morse@arm.com>
 <aK7id14+Spr2VIqR@e133380.arm.com>
 <29d0a34d-71d3-42ac-ba66-b5536f576f3a@arm.com>
 <aLsOt5Tr+ThuHmSS@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aLsOt5Tr+ThuHmSS@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 05/09/2025 17:24, Dave Martin wrote:
> On Thu, Aug 28, 2025 at 04:57:06PM +0100, James Morse wrote:
>> On 27/08/2025 11:48, Dave Martin wrote:
>>> On Fri, Aug 22, 2025 at 03:29:44PM +0000, James Morse wrote:
>>>> The PPTT describes CPUs and caches, as well as processor containers.
>>>> The ACPI table for MPAM describes the set of CPUs that can access an MSC
>>>> with the UID of a processor container.

>>>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>>>> @@ -298,6 +298,92 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he

>>>>  +void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
>>>>  +{

>>>> +		cpu_node = (struct acpi_pptt_processor *)entry;
>>>> +		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
>>>> +		    cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID) {
>>>> +			leaf_flag = acpi_pptt_leaf_node(table_hdr, cpu_node);
>>>> +			if (!leaf_flag) {
>>>> +				if (cpu_node->acpi_processor_id == acpi_cpu_id)
>>
>>
>>> Is there any need to distinguish processor containers from (leaf) CPU
>>> nodes, here?  If not, dropping the distinction might simplify the code
>>> here (even if callers do not care).
>>
>> In the namespace the object types are different, so I assumed they have their own UID
>> space. The PPTT holds both - hence the check for which kind of thing it is. The risk is
>> looking for processor-container-4 and finding CPU-4 instead...
>>
>> The relevant ACPI bit is "8.4.2.1 Processor Container Device", its says:
>> | A processor container declaration must supply a _UID method returning an ID that is
>> | unique in the processor container hierarchy.
>>
>> Which doesn't quite let me combine them here.
> 
> I was going by the PPTT spec, where the types are not distinct --
> you're probably right, though.

This way round is at least robust to this happening.


> According to that, isn't it the "ACPI Processor ID valid" flag, not the
> "Node is a Leaf" flag, that says whether this field is meaningful?

ACPI_PPTT_ACPI_PROCESSOR_ID_VALID was checked a few lines earlier. We're looking for
processors, hence also checking the leaf.


> It's reasonable not to bother to try to enumerate the children of a
> node that claims to be a leaf (even if there actually are children),
> but I wonder what happens if acpi_processor_id is not declared to be
> valid and matches by accident.  That's probably not a valid table (?)
> but does anything bad happen on the kernel side?

The type and flag are both checked earlier, so this can't happen.
You could certainly but junk nodes in the table that would be skipped over, and those
could point to a parent that is a leaf - I can't spot anything in the table parsing code
that would care about that.


>>> Otherwise, maybe eliminate leaf_flag and collapse these into a single
>>> if(), as suggested by Ben [1].
>>>
>>>> +					acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
>>>
>>> Can there ever be multiple matches?
>>>
>>> The possibility of duplicate processor IDs in the PPTT sounds weird to
>>> me, but then I'm not an ACPI expert.
>>
>> Multiple processor-containers with the same ID? That would be a corrupt table.
>> acpi_pptt_get_child_cpus() then walks the tree again to find the CPUs below this
>> processor-container - those have a different kind of id.

> Does anything bad happen if we encounter duplicates?
> 
> (Other then the MPAM driver never getting enabled, or not working as
> advertised, that is.)
> 
> I haven't tried to think through all the implications, here.

It would be unpredictable which node linux finds when it goes looking for CPUs. I don't
think anything would notice. Messing up the cache hierarchy is a different story!


Thanks,

James

