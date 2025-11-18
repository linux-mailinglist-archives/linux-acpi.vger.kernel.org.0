Return-Path: <linux-acpi+bounces-19012-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 084C8C68F34
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 12:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C48E234B084
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D1E34E760;
	Tue, 18 Nov 2025 10:57:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F6931D723;
	Tue, 18 Nov 2025 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763463448; cv=none; b=ZuD/TtDbuwW0lIFgm0haKFAxAb0CTXx+IKMoQethU7Ou2AznRNn4NS4cmXvJp06xraUpB6WDn2epLLS5R8tj/d2i0cRwD3oHOL3pLN+XvC2FeuYK1gAcB10i6iHwQ0tE+VVPQ/SdKsIgctRA/DNU8y6J5o4iKKDHj3x/9PD68gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763463448; c=relaxed/simple;
	bh=xPdnM3g9/GRjk40jJiD3pM1kWkMOjUcqL7ybP27f1y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEffUqHap6GYOJWAHdV95MUxTuUrZDZ/f1+WW3EJmSXIWXfZ1QU/rYtiBwlc6FgG0x13bUo19it0zX8qGfu4w5CP/SKe4ovj/4rmlsObYvOHtbPmvO38YwBwgf1rs6ApNCe8OPMOP1ZKwaPvhBNM3dMmgWMcGyywblubhJ3CiFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35F4FFEC;
	Tue, 18 Nov 2025 02:57:18 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32FCF3F66E;
	Tue, 18 Nov 2025 02:57:21 -0800 (PST)
Message-ID: <d31067ac-7400-4a0c-b1ed-5f1cc5ae9e1e@arm.com>
Date: Tue, 18 Nov 2025 10:57:19 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/34] ACPI / PPTT: Add acpi_pptt_cache_v1_full to use
 pptt cache as one structure
To: Fenghua Yu <fenghuay@nvidia.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-4-ben.horgan@arm.com>
 <88795f32-bfb7-4bec-b1fb-752b3e72ffbb@nvidia.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <88795f32-bfb7-4bec-b1fb-752b3e72ffbb@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 11/18/25 04:03, Fenghua Yu wrote:
> Hi, Ben,
> 
> On 11/17/25 08:59, Ben Horgan wrote:
>> In actbl2.h, acpi_pptt_cache describes the fields in the original
>> Cache Type Structure. In PPTT table version 3 a new field was added at
>> the
>> end, cache_id. This is described in acpi_pptt_cache_v1 but rather than
>> including all v1 fields it just includes this one.
>>
>> In lieu of this being fixed in acpica, introduce
>> acpi_pptt_cache_v1_full to
>> contain all the fields of the Cache Type Structure . Update the existing
>> code to use this new struct. This simplifies the code and removes a
>> non-standard use of ACPI_ADD_PTR.
>>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
>> ---
>> I have opened a pull request to acpica to update acpi_pptt_cache_v1 to
>> include all fields. https://github.com/acpica/acpica/pull/1059
>>
>> Change since v4:
>> Use fields directly in acpi_pptt_cache_v1_full
>> Delay the casting
>>
>> Changes since v3:
>> New patch
>> ---
>>   drivers/acpi/pptt.c | 47 +++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 37 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 2856254e29d7..53fde9bd8140 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -21,6 +21,25 @@
>>   #include <linux/cacheinfo.h>
>>   #include <acpi/processor.h>
>>   +/*
>> + * The acpi_pptt_cache_v1 in actbl2.h, which is imported from acpica,
>> + * only contains the cache_id field rather than all the fields of the
>> + * Cache Type Structure. Use this alternative structure until it is
>> + * resolved in acpica.
>> + */
>> +struct acpi_pptt_cache_v1_full {
>> +    struct acpi_subtable_header header;
>> +    u16 reserved;
>> +    u32 flags;
>> +    u32 next_level_of_cache;
>> +    u32 size;
>> +    u32 number_of_sets;
>> +    u8 associativity;
>> +    u8 attributes;
>> +    u16 line_size;
>> +    u32 cache_id;
>> +};
> 
> Should "__packed" be added to this table?

Yes, I missed that.

> 
> Should this table be defined in include/acpi/actbl2.h? Seems defining
> the two cache tables separately in two places are not natural?

Indeed. The dificulty is that include/acpi/actbl2.h is generated from
acpica. I propose a fix for this in the  pull request mentioned above:
https://github.com/acpica/acpica/pull/1059 This extends
acpi_pptt_cache_v1 to include all the fields in the new version of the
cache type structure (not just cache_id).

One thing I could do if it looks like the acpica change will be accepted
is to temporarily delete acpi_pptt_cache_v1 from include/acpi/actbl2.h
and rename acpi_pptt_cache_v1_full in drivers/acpi/pptt.c to
acpi_pptt_cache_v1. When include/acpi/actbl2.h is updated the conflict
should be evident and the version in drivers/acpi/pptt.c can be dropped.
 I'll keep it like it is for now though as this would be an api breaking
change for acpica and the maintainers may prefer to handle this a
different way.

> 
> Thanks.
> 
> -Fenghua

Thanks,

Ben


