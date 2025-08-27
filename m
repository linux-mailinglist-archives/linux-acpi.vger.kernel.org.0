Return-Path: <linux-acpi+bounces-16120-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A10B38853
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 19:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3111B61EEE
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3A730BB80;
	Wed, 27 Aug 2025 17:11:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FE8223710;
	Wed, 27 Aug 2025 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314712; cv=none; b=R3c1VcOozZSrac/FQHLtjyiJAcZ57m0KcuHhIqcI01+yjam3fM2esPeIdpwhuqoMt5je38O3nnR4Vp8sk1njVRk4mlUqA9GrJe7zQLq6C8hw5s7q6uIBTXVuX3fAlqQHW76mLwgiXdFX11QiIJDDI3O1f4eClmN9wJWkcKoaXv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314712; c=relaxed/simple;
	bh=3aUjH47u8cHdPsl1BdlKxTzAA50pWkY6dUI3rJzJI2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EftWHftbpJSOq0fzZVSQE1wNY9310WmufV8yvzfdlfbP9AWFb9lldjhzMTFgx2Dhlqw1hOaL0tmtRHomZocZQhh+fVnD6aLI22MzXZryaKpyD7JAlL9SDBdod8X2rhGZLymHwZgiw7jtuUJQH0fGz+5PQXqGUmXZSId2TpjuwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88CCE15A1;
	Wed, 27 Aug 2025 10:11:41 -0700 (PDT)
Received: from [10.1.196.42] (eglon.cambridge.arm.com [10.1.196.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4A633F694;
	Wed, 27 Aug 2025 10:11:44 -0700 (PDT)
Message-ID: <2ac66605-ee6a-495b-a0fb-910926abd8b0@arm.com>
Date: Wed, 27 Aug 2025 18:11:43 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/33] drivers: base: cacheinfo: Add helper to find the
 cache size from cpu+level
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com,
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
 <20250822153048.2287-3-james.morse@arm.com>
 <aK7iDey7LATOXIUb@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aK7iDey7LATOXIUb@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 27/08/2025 11:46, Dave Martin wrote:
> Hi,
> 
> On Fri, Aug 22, 2025 at 03:29:43PM +0000, James Morse wrote:
>> MPAM needs to know the size of a cache associated with a particular CPU.
>> The DT/ACPI agnostic way of doing this is to ask cacheinfo.
>>
>> Add a helper to do this.

>> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
>> index 2dcbb69139e9..e12d6f2c6a57 100644
>> --- a/include/linux/cacheinfo.h
>> +++ b/include/linux/cacheinfo.h
>> @@ -148,6 +148,21 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
>>  	return ci ? ci->id : -1;
>>  }
>>  
>> +/**
>> + * get_cpu_cacheinfo_size() - Get the size of the cache.
>> + * @cpu:      The cpu that is associated with the cache.
>> + * @level:    The level of the cache as seen by @cpu.
>> + *
>> + * Callers must hold the cpuhp lock.
>> + * Returns the cache-size on success, or 0 for an error.
>> + */
> 
> Nit: Maybe use the wording
> 
> 	cpuhp lock must be held.
> 
> in the kerneldoc here, to match the other helpers it sits alongside.
> 
> Otherwise, looks reasonable.

Sure,


>> +static inline unsigned int get_cpu_cacheinfo_size(int cpu, int level)
>> +{
>> +	struct cacheinfo *ci = get_cpu_cacheinfo_level(cpu, level);
>> +
>> +	return ci ? ci->size : 0;
>> +}
>> +
> 
> Orphaned function?
> 
> Can fs/resctrl/rdtgroup.c:rdtgroup_cbm_to_size() be ported to use this?
> If so, this wouldn't just be dead code in this series.

Ah - I thought the MPAM driver was pulling this value in, but its the resctrl glue code.
I was trying to reduce the number of trees this touches - its probably best to kick this
into the next series that adds the resctrl code as its pretty trivial.


Thanks,

James

