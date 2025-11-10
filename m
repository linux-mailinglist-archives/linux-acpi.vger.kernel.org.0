Return-Path: <linux-acpi+bounces-18743-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A096C47F68
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 17:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E5A54F41C6
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 16:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45558280A56;
	Mon, 10 Nov 2025 16:28:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FF927A442;
	Mon, 10 Nov 2025 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792099; cv=none; b=X7uZvJLb4rMTgv+h+RCjOm5USRbTu8twcLDDvaDgn3HYV1eSRpCt9uLKMQ4LL5FW7bt8oTwKhXlCgtadiSBIQCt0Yg32cNoFnGmc8ajck2bmDAnLSf2I5NZ1fDM69PxorPWhF6rM9GOuaX8bxii63WXE5pD+IYfj+0ClMu9bkJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792099; c=relaxed/simple;
	bh=HeioBUljwwONtU7NFw7bhqlAdCXsdAmH39LdDfy+92M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDPsYReqXT7e0XtMgmpqLeu7Ki2sC5Z/yFu02/rBiyga2PhWhaHkR4JRITWrI5OykdDxwwy/rb7GoCPadoiHIPG4On54Xzs1Emkpz8AbeVxx+i8W3hA7GhoI9iOEEAMhxbVshj19gagtlgf1n6QVBH+hRb62UC46MBJnP+lK/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AEA82B;
	Mon, 10 Nov 2025 08:28:08 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C5463F66E;
	Mon, 10 Nov 2025 08:28:11 -0800 (PST)
Message-ID: <17caf75c-a00f-41d8-bacc-af5ba6c485d9@arm.com>
Date: Mon, 10 Nov 2025 16:28:10 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] ACPI / PPTT: Add acpi_pptt_cache_v1_full to use
 pptt cache as one structure
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: james.morse@arm.com, amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com,
 guohanjun@huawei.com, jeremy.linton@arm.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-4-ben.horgan@arm.com>
 <20251110154610.00002247@huawei.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251110154610.00002247@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 11/10/25 15:46, Jonathan Cameron wrote:
> On Fri, 7 Nov 2025 12:34:20 +0000
> Ben Horgan <ben.horgan@arm.com> wrote:
> 
>> In actbl2.h, struct acpi_pptt_cache describes the fields in the original
>> cache type structure. In PPTT table version 3 a new field was added at the
>> end, cache_id. This is described in struct acpi_pptt_cache_v1. Introduce
>> the new, acpi_pptt_cache_v1_full to contain both these structures. Update
>> the existing code to use this new struct. This simplifies the code, removes
>> a non-standard use of ACPI_ADD_PTR and allows using the length in the
>> header to check if the cache_id is valid.
>>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> 
> Whilst I wish the ACPICA stuff did structures like this, I'm not sure
> if the ACPI maintainers will feel it is appropriate to work around it
> with generic sounding structures like this one.
> 
> I'd also say that we should only cast it to your _full structure
> if we know we have rev 3 of PPTT.  Otherwise we should continue manipulating
> it as a struct acpi_pptt_cache

Fair enough. My thinking was that you had to check the valid flag anyway
to use cache_id but it's less robust. I'll delay the casting to later
which IIUC is what Jeremy Linton suggested offline.

> 
>> ---
>> Changes since v3:
>> New patch
>> ---
>>  drivers/acpi/pptt.c | 104 ++++++++++++++++++++++++--------------------
>>  1 file changed, 58 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 1027ca3566b1..1ed2099c0d1a 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -21,6 +21,11 @@
>>  #include <linux/cacheinfo.h>
>>  #include <acpi/processor.h>
>>  
>> +struct acpi_pptt_cache_v1_full {
>> +	struct acpi_pptt_cache		f;
>> +	struct acpi_pptt_cache_v1	extra;
>> +} __packed;
> 
>> +#define ACPI_PPTT_CACHE_V1_LEN sizeof(struct acpi_pptt_cache_v1_full)
>> +
>> +/*
>> + * From PPTT table version 3, a new field cache_id was added at the end of
>> + * the cache type structure.  We now use struct acpi_pptt_cache_v1_full,
>> + * containing the cache_id, everywhere but must check validity before accessing
>> + * the cache_id.
>> + */
>> +static bool acpi_pptt_cache_id_is_valid(struct acpi_pptt_cache_v1_full *cache)
>> +{
>> +	return (cache->f.header.length >= ACPI_PPTT_CACHE_V1_LEN &&
> 
> Although I later say I don't think you should pass a v1_full structure in here (as
> we don't know it is at least that large until after this check) if you do keep this
> why not use sizeof(*cache) and get rid of the V1_LEN definition as providing no obvious
> value here?

Yes, the define was never needed.

> 
>> +		cache->f.flags & ACPI_PPTT_CACHE_ID_VALID);
>>  }
> 
>> @@ -355,7 +374,6 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>>   * @this_leaf: Kernel cache info structure being updated
>>   * @found_cache: The PPTT node describing this cache instance
>>   * @cpu_node: A unique reference to describe this cache instance
>> - * @revision: The revision of the PPTT table
>>   *
>>   * The ACPI spec implies that the fields in the cache structures are used to
>>   * extend and correct the information probed from the hardware. Lets only
>> @@ -364,23 +382,20 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
>>   * Return: nothing. Side effect of updating the global cacheinfo
>>   */
>>  static void update_cache_properties(struct cacheinfo *this_leaf,
>> -				    struct acpi_pptt_cache *found_cache,
>> -				    struct acpi_pptt_processor *cpu_node,
>> -				    u8 revision)
>> +				    struct acpi_pptt_cache_v1_full *found_cache,
>> +				    struct acpi_pptt_processor *cpu_node)
>>  {
>> -	struct acpi_pptt_cache_v1* found_cache_v1;
>> -
>>  	this_leaf->fw_token = cpu_node;
>> -	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
>> -		this_leaf->size = found_cache->size;
>> -	if (found_cache->flags & ACPI_PPTT_LINE_SIZE_VALID)
>> -		this_leaf->coherency_line_size = found_cache->line_size;
>> -	if (found_cache->flags & ACPI_PPTT_NUMBER_OF_SETS_VALID)
>> -		this_leaf->number_of_sets = found_cache->number_of_sets;
>> -	if (found_cache->flags & ACPI_PPTT_ASSOCIATIVITY_VALID)
>> -		this_leaf->ways_of_associativity = found_cache->associativity;
>> -	if (found_cache->flags & ACPI_PPTT_WRITE_POLICY_VALID) {
>> -		switch (found_cache->attributes & ACPI_PPTT_MASK_WRITE_POLICY) {
>> +	if (found_cache->f.flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
>> +		this_leaf->size = found_cache->f.size;
>> +	if (found_cache->f.flags & ACPI_PPTT_LINE_SIZE_VALID)
>> +		this_leaf->coherency_line_size = found_cache->f.line_size;
>> +	if (found_cache->f.flags & ACPI_PPTT_NUMBER_OF_SETS_VALID)
>> +		this_leaf->number_of_sets = found_cache->f.number_of_sets;
>> +	if (found_cache->f.flags & ACPI_PPTT_ASSOCIATIVITY_VALID)
>> +		this_leaf->ways_of_associativity = found_cache->f.associativity;
>> +	if (found_cache->f.flags & ACPI_PPTT_WRITE_POLICY_VALID) {
>> +		switch (found_cache->f.attributes & ACPI_PPTT_MASK_WRITE_POLICY) {
>>  		case ACPI_PPTT_CACHE_POLICY_WT:
>>  			this_leaf->attributes = CACHE_WRITE_THROUGH;
>>  			break;
>> @@ -389,8 +404,8 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>>  			break;
>>  		}
>>  	}
>> -	if (found_cache->flags & ACPI_PPTT_ALLOCATION_TYPE_VALID) {
>> -		switch (found_cache->attributes & ACPI_PPTT_MASK_ALLOCATION_TYPE) {
>> +	if (found_cache->f.flags & ACPI_PPTT_ALLOCATION_TYPE_VALID) {
>> +		switch (found_cache->f.attributes & ACPI_PPTT_MASK_ALLOCATION_TYPE) {
>>  		case ACPI_PPTT_CACHE_READ_ALLOCATE:
>>  			this_leaf->attributes |= CACHE_READ_ALLOCATE;
>>  			break;
>> @@ -415,13 +430,11 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>>  	 * specified in PPTT.
>>  	 */
>>  	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
>> -	    found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
>> +	    found_cache->f.flags & ACPI_PPTT_CACHE_TYPE_VALID)
>>  		this_leaf->type = CACHE_TYPE_UNIFIED;
>>  
>> -	if (revision >= 3 && (found_cache->flags & ACPI_PPTT_CACHE_ID_VALID)) {
>> -		found_cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
>> -	                                      found_cache, sizeof(struct acpi_pptt_cache));
>> -		this_leaf->id = found_cache_v1->cache_id;
>> +	if (acpi_pptt_cache_id_is_valid(found_cache)) {
> 
> Only here do we know that found_cache is the _full type. 
> 
>> +		this_leaf->id = found_cache->extra.cache_id;
>>  		this_leaf->attributes |= CACHE_ID;
>>  	}
>>  }
>> @@ -429,7 +442,7 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>>  static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>>  				 unsigned int cpu)
>>  {
>> -	struct acpi_pptt_cache *found_cache;
>> +	struct acpi_pptt_cache_v1_full *found_cache;
> 
> This isn't necessarily valid. Until deep in update_cache_properties() we don't care about the ID
> so this structure may be smaller than this implies.
> 
>>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>>  	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>>  	struct cacheinfo *this_leaf;
>> @@ -445,8 +458,7 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>>  		pr_debug("found = %p %p\n", found_cache, cpu_node);
>>  		if (found_cache)
>>  			update_cache_properties(this_leaf, found_cache,
>> -						ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)),
>> -						table->revision);
>> +						ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)));
>>  
>>  		index++;
>>  	}
> 

Thanks,

Ben


