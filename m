Return-Path: <linux-acpi+bounces-17890-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38069BEB44B
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 20:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE051AE2AB7
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A409F330317;
	Fri, 17 Oct 2025 18:51:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E426730F53E;
	Fri, 17 Oct 2025 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727076; cv=none; b=gmpYk/eusV86JOphgc2WHROH5pwhlaywAtYxdh7dH4JTP7ZtuYU/t+nCrlDGn/VyLE73SZRai1SzafOfATp/dZstgdwyHvXN4rUL9m3+T/mfIVs9XiWBEzxJd1eTnkOTOPKkaLQvWeElaXsN6Ar8KIihSgOC5W29HJq//moQRpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727076; c=relaxed/simple;
	bh=o5/HVElju20I7NpqGHs5UCcOuFs/E+uAw+ix8NmnB9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmrIU3mhZd6HjUQG3nCKMRsHFleFZXYQZYpUOGxAxVHYaSmNOXbiGH0Nl6Cd7IPI3U97dTlM/1+dCcNE5VqAkMigwvxAALWDDcP665RETQuRxIXwS076SmehXbfwOeR5x6MWr0fYFb7hxrCmFffYJueofH+d5lifEUEKZqZm/mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 562E91515;
	Fri, 17 Oct 2025 11:51:06 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D2E33F6A8;
	Fri, 17 Oct 2025 11:51:08 -0700 (PDT)
Message-ID: <c91fb7cd-13d5-4280-b2b6-c6ed37512ebd@arm.com>
Date: Fri, 17 Oct 2025 19:51:03 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/29] ACPI / MPAM: Parse the MPAM table
To: Gavin Shan <gshan@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-7-james.morse@arm.com>
 <64105db5-01e3-44ba-bfb0-6524de471ccb@redhat.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <64105db5-01e3-44ba-bfb0-6524de471ccb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gavin,

On 03/10/2025 01:58, Gavin Shan wrote:
> On 9/11/25 6:42 AM, James Morse wrote:
>> Add code to parse the arm64 specific MPAM table, looking up the cache
>> level from the PPTT and feeding the end result into the MPAM driver.
>>
>> For now the MPAM hook mpam_ris_create() is stubbed out, but will update
>> the MPAM driver with optional discovered data.

>> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
>> new file mode 100644
>> index 000000000000..fd9cfa143676
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/mpam.c

>> +static bool acpi_mpam_register_irq(struct platform_device *pdev, int intid,
>> +                   u32 flags, int *irq,
>> +                   u32 processor_container_uid)
>> +{
>> +    int sense;
>> +
>> +    if (!intid)
>> +        return false;
>> +
>> +    if (FIELD_GET(ACPI_MPAM_MSC_IRQ_TYPE_MASK, flags) !=
>> +        ACPI_MPAM_MSC_IRQ_TYPE_WIRED)
>> +        return false;
>> +
>> +    sense = FIELD_GET(ACPI_MPAM_MSC_IRQ_MODE_MASK, flags);
>> +
>> +    if (16 <= intid && intid < 32 && processor_container_uid != GLOBAL_AFFINITY) {
>> +        pr_err_once("Partitioned interrupts not supported\n");
>> +        return false;
>> +    }
>> +
>> +    *irq = acpi_register_gsi(&pdev->dev, intid, sense, ACPI_ACTIVE_HIGH);
>> +    if (*irq <= 0) {
>> +        pr_err_once("Failed to register interrupt 0x%x with ACPI\n",
>> +                intid);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
> 
> 0 is allowed by acpi_register_gsi().
> 
>     if (*irq < 0) {
>         pr_err_once(...);
>         return false;
>     }

Really? I thought irq-zero was nonsense.
acpi_register_gsi() does this:
|        irq = irq_create_fwspec_mapping(&fwspec);
|        if (!irq)
|                return -EINVAL;
|
|        return irq;


>> +static int acpi_mpam_parse_resource(struct mpam_msc *msc,
>> +                    struct acpi_mpam_resource_node *res)
>> +{
>> +    int level, nid;
>> +    u32 cache_id;
>> +
>> +    switch (res->locator_type) {
>> +    case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
>> +        cache_id = res->locator.cache_locator.cache_reference;
>> +        level = find_acpi_cache_level_from_id(cache_id);
>> +        if (level <= 0) {
>> +            pr_err_once("Bad level (%u) for cache with id %u\n", level, cache_id);
>> +            return -EINVAL;
>> +        }
>> +        return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_CACHE,
>> +                       level, cache_id);
>> +    case ACPI_MPAM_LOCATION_TYPE_MEMORY:
>> +        nid = pxm_to_node(res->locator.memory_locator.proximity_domain);
>> +        if (nid == NUMA_NO_NODE)
>> +            nid = 0;
>> +        return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
>> +                       255, nid);
> 
> It's perhaps worthy a warning message when @nid is explicitly set to zero due to
> the bad proximity domain, something like below.
> 
>         if (nid == NUMA_NO_NODE) {
>             nid = 0;
>             if (num_possible_nodes() > 1) {
>                 pr_warn("Bad proximity domain %d, mapped to node 0\n",
>                     res->locator.memory_locator.proximity_domain);
>             }
>         }

This was to catch the case where you build the kernel without NUMA support - which
wouldn't be an error. But that returns 0 instead of NUMA_NO_NODE, so NUMA_NO_NODE only
occurs when there is a bug. I'l add this - but it'll be a pr_debug() as the message is
only of use to about 4 people!


>> +    default:
>> +        /* These get discovered later and treated as unknown */
>> +        return 0;
>> +    }
>> +}

>> +int acpi_mpam_count_msc(void)
>> +{
>> +    struct acpi_table_header *table __free(acpi_table) =
>> acpi_get_table_ret(ACPI_SIG_MPAM, 0);
>> +    char *table_end, *table_offset = (char *)(table + 1);
>> +    struct acpi_mpam_msc_node *tbl_msc;
>> +    int count = 0;
>> +
>> +    if (IS_ERR(table))
>> +        return 0;
>> +
>> +    if (table->revision < 1)
>> +        return 0;
>> +
>> +    table_end = (char *)table + table->length;
>> +
>> +    while (table_offset < table_end) {
>> +        tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
>> +        if (!tbl_msc->mmio_size)
>> +            continue;
>> +
>> +        if (tbl_msc->length < sizeof(*tbl_msc))
>> +            return -EINVAL;
>> +        if (tbl_msc->length > table_end - table_offset)
>> +            return -EINVAL;
>> +        table_offset += tbl_msc->length;
>> +
>> +        count++;
>> +    }
>> +
>> +    return count;
>> +}

> acpi_mpam_count_msc() iterates the existing MSC node, which is part of acpi_mpam_parse().
> So the question is why we can't drop acpi_mpam_count_msc() and maintain a variable to
> count the existing MSC nodes in acpi_mpam_parse() ?

Once the platform device has been created, the driver's probe call can be called, and that
needs to know how many MSC there are going to be. Doing it like this means we don't depend
on the driver probe function not being called until we got to the end of the list.
(the comments about the initcall dependencies are already annoying - I prefer not to add
any that are specific to MPAM).

This also lets us catch non-backward compatible ACPI table changes, which has already
happened with PCC. acpi_mpam_parse() skips MSC with reserved fields set,
acpi_mpam_count_msc() does not - this means we are guaranteed the values will mismatch
if any of those reserved fields are set, and the driver will never try to touch the hardware.


Thanks,

James


