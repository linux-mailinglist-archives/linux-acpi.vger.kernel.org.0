Return-Path: <linux-acpi+bounces-18733-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BA3C47F20
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 17:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0212F4A28D8
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9E627AC48;
	Mon, 10 Nov 2025 15:52:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DF5274FC1;
	Mon, 10 Nov 2025 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789926; cv=none; b=qrBLFGuXEffYnJrfm5oasZ5tKXPMgM9EDOsBN2BiuaKnTMTRHbhxYQsgqmIEiQy1v37LWC9fTCJcQV/zwSghOVtmjEN64KSwm8yxDp9NufJcWfWXtfOrrOygqTde2ueP7ktiejJhbQBSsA1EQ+uuHjnhaHrfpPvfK2E3OXc9e0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789926; c=relaxed/simple;
	bh=xdEbNKFWPSwfwj0BOf5/HLomw0fzTbpFjodjnfrwQwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwhQ9rXOLe6mTfqgnXrwUvHPoru6q0Bg1EXpznnz20bJIIGWlWAP7/oU+lcF2pZAQxmTcsy1HD5D2f+4lepExTDL5QguCyuI3/u1EXS4NuICRGFTPcPLS00tkrQAUlITCruZ6HZAUmX0n18vfV4qqSx1LW/l51HQ3XmsrsQNHF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65B902F;
	Mon, 10 Nov 2025 07:51:55 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 812F73F66E;
	Mon, 10 Nov 2025 07:51:58 -0800 (PST)
Message-ID: <374f53a9-6ff5-4c37-bd41-9e746eaec1da@arm.com>
Date: Mon, 10 Nov 2025 15:51:57 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] ACPI / PPTT: Add acpi_pptt_cache_v1_full to use
 pptt cache as one structure
To: Gavin Shan <gshan@redhat.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-4-ben.horgan@arm.com>
 <04f4c2f6-19ff-413f-96fb-86432d53830e@redhat.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <04f4c2f6-19ff-413f-96fb-86432d53830e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gavin,

On 11/8/25 04:54, Gavin Shan wrote:
> Hi Ben,
> 
> On 11/7/25 10:34 PM, Ben Horgan wrote:
>> In actbl2.h, struct acpi_pptt_cache describes the fields in the original
>> cache type structure. In PPTT table version 3 a new field was added at
>> the
>> end, cache_id. This is described in struct acpi_pptt_cache_v1. Introduce
>> the new, acpi_pptt_cache_v1_full to contain both these structures. Update
>> the existing code to use this new struct. This simplifies the code,
>> removes
>> a non-standard use of ACPI_ADD_PTR and allows using the length in the
>> header to check if the cache_id is valid.
>>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
>> ---
>> Changes since v3:
>> New patch
>> ---
>>   drivers/acpi/pptt.c | 104 ++++++++++++++++++++++++--------------------
>>   1 file changed, 58 insertions(+), 46 deletions(-)
>>
> 
> Two nitpicks below. LGTM in either way.
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> 
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 1027ca3566b1..1ed2099c0d1a 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -21,6 +21,11 @@
>>   #include <linux/cacheinfo.h>
>>   #include <acpi/processor.h>
>>   +struct acpi_pptt_cache_v1_full {
>> +    struct acpi_pptt_cache        f;
>> +    struct acpi_pptt_cache_v1    extra;
>> +} __packed;
>> +
>>   static struct acpi_subtable_header *fetch_pptt_subtable(struct
>> acpi_table_header *table_hdr,
>>                               u32 pptt_ref)
>>   {
>> @@ -50,10 +55,24 @@ static struct acpi_pptt_processor
>> *fetch_pptt_node(struct acpi_table_header *tab
>>       return (struct acpi_pptt_processor
>> *)fetch_pptt_subtable(table_hdr, pptt_ref);
>>   }
>>   -static struct acpi_pptt_cache *fetch_pptt_cache(struct
>> acpi_table_header *table_hdr,
>> -                        u32 pptt_ref)
>> +static struct acpi_pptt_cache_v1_full *fetch_pptt_cache(struct
>> acpi_table_header *table_hdr,
>> +                            u32 pptt_ref)
>>   {
>> -    return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr,
>> pptt_ref);
>> +    return (struct acpi_pptt_cache_v1_full
>> *)fetch_pptt_subtable(table_hdr, pptt_ref);
>> +}
>> +
>> +#define ACPI_PPTT_CACHE_V1_LEN sizeof(struct acpi_pptt_cache_v1_full)
>> +
>> +/*
>> + * From PPTT table version 3, a new field cache_id was added at the
>> end of
>> + * the cache type structure.  We now use struct acpi_pptt_cache_v1_full,
>> + * containing the cache_id, everywhere but must check validity before
>> accessing
>> + * the cache_id.
>> + */
>> +static bool acpi_pptt_cache_id_is_valid(struct
>> acpi_pptt_cache_v1_full *cache)
>> +{
>> +    return (cache->f.header.length >= ACPI_PPTT_CACHE_V1_LEN &&
>> +        cache->f.flags & ACPI_PPTT_CACHE_ID_VALID);
>>   }
>>   
> 
> This function is nice fit to 'inline'. Besides, I'm not sure if we can just
> use sizeof(*cache) instead of ACPI_PPTT_CACHE_V1_LEN, which is used for
> once
> in pptt.c

Yes, the define is unnecessary and the function can be inlined. Thanks
for pointing it out. I'm likely to rework this patch though.

Thanks,

Ben


