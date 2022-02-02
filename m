Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF8A4A7098
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Feb 2022 13:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbiBBMUK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Feb 2022 07:20:10 -0500
Received: from foss.arm.com ([217.140.110.172]:55498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235529AbiBBMUK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Feb 2022 07:20:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B526E1FB;
        Wed,  2 Feb 2022 04:20:09 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94EE83F718;
        Wed,  2 Feb 2022 04:20:08 -0800 (PST)
Message-ID: <679306f7-2e1a-ae8c-a0b6-64b464080cee@arm.com>
Date:   Wed, 2 Feb 2022 12:20:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] ACPI/IORT: Check node revision for PMCG resources
Content-Language: en-GB
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Petlan <mpetlan@redhat.com>
References: <a262d1122f493c83eb48fd643e1c51019ab93c67.1643641404.git.robin.murphy@arm.com>
 <20220202101307.GA16459@lpieralisi>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220202101307.GA16459@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-02-02 10:13, Lorenzo Pieralisi wrote:
> On Mon, Jan 31, 2022 at 03:03:24PM +0000, Robin Murphy wrote:
>> The original version of the IORT PMCG definition had an oversight
>> wherein there was no way to describe the second register page for an
>> implementation using the recommended RELOC_CTRS feature. Although the
>> spec was fixed, and the final patches merged to ACPICA and Linux written
>> against the new version, it seems that some old firmware based on the
>> original revision has survived and turned up in the wild.
>>
>> Add a check for the original PMCG definition, and avoid filling in the
>> second memory resource with nonsense if so. Otherwise it is likely that
>> something horrible will happen when the PMCG driver attempts to probe.
>>
>> Reported-by: Michael Petlan <mpetlan@redhat.com>
>> Fixes: 24e516049360 ("ACPI/IORT: Add support for PMCG")
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/acpi/arm64/iort.c | 17 ++++++++++-------
>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 3b23fb775ac4..aaa1f0411a5a 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -1344,16 +1344,17 @@ static int __init arm_smmu_v3_pmcg_count_resources(struct acpi_iort_node *node)
>>   	pmcg = (struct acpi_iort_pmcg *)node->node_data;
>>   
>>   	/*
>> -	 * There are always 2 memory resources.
>> -	 * If the overflow_gsiv is present then add that for a total of 3.
>> +	 * There should normally be 2 memory resources, but apparently the
>> +	 * oversight from IORT rev. C managed to escape into the wild.
>>   	 */
>> -	return pmcg->overflow_gsiv ? 3 : 2;
>> +	return 1 + (node->revision > 0) + (pmcg->overflow_gsiv != 0);
> 
> It is compact but (nit) I'd rather use a construct like:
> 
> if (node->revision > 0)
> 	res_cnt++;
> 
> with a comment explaining it so that we can remember why the node
> revision implies an additional resource.

Sure, I did actually start down that route, but then thought maybe the 
existing style gave an excuse to be clever :)

I'll respin it into the style of arm_smmu_v3_count_resources() for v2.

> Actually - I noticed that the logic in .dev_count_resources() and
> dev_init_resources() is somewhat duplicated - maybe we can add a
> resource_count param to dev_init_resources() but I am not sure
> it will improve things much.

Even if the resource allocation was factored out into every 
implementation, there's still some unavoidable overlap between knowing 
which resources you want to allocate beforehand and knowing which 
resources you need to initialise afterwards. Honestly I think the 
current shape of things is the best compromise already.

>>   }
>>   
>>   static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
>>   						   struct acpi_iort_node *node)
>>   {
>>   	struct acpi_iort_pmcg *pmcg;
>> +	int n = 1;
>>   
>>   	/* Retrieve PMCG specific data */
>>   	pmcg = (struct acpi_iort_pmcg *)node->node_data;
>> @@ -1361,13 +1362,15 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
>>   	res[0].start = pmcg->page0_base_address;
>>   	res[0].end = pmcg->page0_base_address + SZ_4K - 1;
>>   	res[0].flags = IORESOURCE_MEM;
>> -	res[1].start = pmcg->page1_base_address;
>> -	res[1].end = pmcg->page1_base_address + SZ_4K - 1;
>> -	res[1].flags = IORESOURCE_MEM;
>> +	if (node->revision > 0) {
>> +		res[n].start = pmcg->page1_base_address;
>> +		res[n].end = pmcg->page1_base_address + SZ_4K - 1;
>> +		res[n++].flags = IORESOURCE_MEM;
>> +	}
> 
> See above. If we knew the number of resource we could avoid repeating
> node->revision > 0 check but I don't think it would improve things
> anyway (ie we know how many resources we are allocating but we still
> need to check why a resource has to be added - eg node->revision > 0).

In this case, the price of not repeating "node->revision > 0" would be 
"res_cnt == 3 || (res_cnt == 2 && !pmcg->overflow_gsiv)" - definitely 
not an improvement to my eye.

Cheers,
Robin.

> 
> Thanks,
> Lorenzo
> 
>>   	if (pmcg->overflow_gsiv)
>>   		acpi_iort_register_irq(pmcg->overflow_gsiv, "overflow",
>> -				       ACPI_EDGE_SENSITIVE, &res[2]);
>> +				       ACPI_EDGE_SENSITIVE, &res[n]);
>>   }
>>   
>>   static struct acpi_platform_list pmcg_plat_info[] __initdata = {
>> -- 
>> 2.28.0.dirty
>>
