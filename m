Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB264B9F8
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2019 15:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFSNb1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Jun 2019 09:31:27 -0400
Received: from foss.arm.com ([217.140.110.172]:39850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfFSNb1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Jun 2019 09:31:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3B60344;
        Wed, 19 Jun 2019 06:31:26 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D7953F738;
        Wed, 19 Jun 2019 06:31:24 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] ACPI / PPTT: cacheinfo: Label caches based on
 fw_token
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Vijaya Kumar K <vkilari@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Tomasz Nowicki <Tomasz.Nowicki@cavium.com>,
        Richard Ruigrok <rruigrok@qti.qualcomm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>
References: <20181005150235.13846-1-james.morse@arm.com>
 <20181005150235.13846-3-james.morse@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83F295ABF@lhreml524-mbb.china.huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <4a8a2576-5a17-3897-ba5b-b81a172f1c82@arm.com>
Date:   Wed, 19 Jun 2019 14:31:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F295ABF@lhreml524-mbb.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Shameer,

On 17/06/2019 09:28, Shameerali Kolothum Thodi wrote:
>> -----Original Message-----

>> The resctrl ABI requires caches to have a unique id. This number must be
>> unique across all caches at this level, but doesn't need to be contiguous. (there
>> may be gaps, it may not start at 0).
>> See Documentation/x86/intel_rdt_ui.txt::Cache IDs
>>
>> We want a value that is the same over reboots, and should be the same on
>> identical hardware, even if the PPTT is generated in a different order. The
>> hardware doesn't give us any indication of which caches are shared, so this
>> information must come from firmware tables.
>>
>> Starting with a cacheinfo's fw_token, we walk the table to find all CPUs that
>> share this cpu_node (and thus cache), and take the lowest physical id to use as
>> the id for the cache. On arm64 this value corresponds to the MPIDR.
>>
>> This is only done for unified caches, as instruction/data caches would generate
>> the same id using this scheme.


>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c index
>> d1e26cb599bf..9478f8c28158 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -341,6 +341,84 @@ static struct acpi_pptt_cache
>> +/**
>> + * acpi_pptt_min_physid_from_cpu_node() - Recursivly find @min_physid
>> +for all
>> + * leaf CPUs below @cpu_node.
>> + * @table_hdr:	Pointer to the head of the PPTT table
>> + * @cpu_node:	The point in the toplogy to start the walk
>> + * @min_physid:	The min_physid to update with leaf CPUs.
>> + */
>> +void acpi_pptt_min_physid_from_cpu_node(struct acpi_table_header
>> *table_hdr,
>> +					struct acpi_pptt_processor *cpu_node,
>> +					phys_cpuid_t *min_physid)
>> +{
>> +	bool leaf = true;
>> +	u32 acpi_processor_id;
>> +	phys_cpuid_t cpu_node_phys_id;
>> +	struct acpi_subtable_header *iter;
>> +	struct acpi_pptt_processor *iter_node;
>> +	u32 target_node = ACPI_PTR_DIFF(cpu_node, table_hdr);
>> +	u32 proc_sz = sizeof(struct acpi_pptt_processor *);
>> +	unsigned long table_end = (unsigned long)table_hdr +
>> +table_hdr->length;
>> +
>> +	/*
>> +	 * Walk the PPTT, looking for nodes that reference cpu_node
>> +	 * as parent.
>> +	 */
>> +	iter = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
>> +			     sizeof(struct acpi_table_pptt));
>> +
>> +	while ((unsigned long)iter + proc_sz < table_end) {
>> +		iter_node = (struct acpi_pptt_processor *)iter;
>> +
>> +		if (iter->type == ACPI_PPTT_TYPE_PROCESSOR &&
>> +		    iter_node->parent == target_node) {
>> +			leaf = false;
>> +			acpi_pptt_min_physid_from_cpu_node(table_hdr, iter_node,
>> +							   min_physid);
>> +		}
>> +
>> +		if (iter->length == 0)
>> +			return;
>> +		iter = ACPI_ADD_PTR(struct acpi_subtable_header, iter,
>> +				    iter->length);
>> +	}
>> +
>> +	if (leaf && cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID) {
>> +		acpi_processor_id = cpu_node->acpi_processor_id;
>> +		cpu_node_phys_id = acpi_id_to_phys_cpuid(acpi_processor_id);
>> +		*min_physid = min(*min_physid, cpu_node_phys_id);
>> +	}
>> +}

> I was just trying out the latest public MPAM branch available here[1]

Great!


> and noted that
> on our HiSilicon platform all the L3 cache were labeled with the same Id. Debugging> revealed that the above leaf node check was removed in this branch[2] which makes
> the min_physid calculation going wrong.

Thanks for debugging this,

> Just wondering is there any particular reason
> for removing the check or the branch is not carrying the latest patch?

Nope, that's a bug.

Jeremy Linton's review feedback[0] was that that PROCESSOR_ID_VALID flag can't be relied
on. It looks like I over-zealously removed the whole if(), and this doesn't cause a
problem with my pptt so I didn't notice.

I've fixed it locally, I've also pushed a fix to those branches, but it will get folded in
next time I push a branch.


Thanks!

James

[0] lore.kernel.org/r/a68abfd2-1e28-d9e7-919a-8b3133db4d20@arm.com
