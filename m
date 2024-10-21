Return-Path: <linux-acpi+bounces-8884-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7CE9A7169
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 19:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D681F23268
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953DB1F4FA1;
	Mon, 21 Oct 2024 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/30VmtU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAC01F4713
	for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533146; cv=none; b=CQ/DUHR6RNsVWZcGRhE0Q0F3XNSa6LH9Q22XJdWhCFoI11K1ZqUrwVDHm79bTB6wiPBSra9UtBRXr4toJXXR77+AmUpeVLvCXKO5x6GIzMuM/epYJgtz4/uoWGbTw7Nkzg5cQ/s9iBSwQjTZsrpEVrmcC6Q5dOqodKsHvujloNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533146; c=relaxed/simple;
	bh=bwjoxKe/S8m9xoQ93oneRuC+Kz1dRhONXz+q9MJ/JS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYRIfic+oK6kn3Yx9ApaIwhddDgepr8XTKItLQ4bYDCm2+IklfISCwNa5VIe+kDjZUSq4FngOUVyd2MCfPDXCQAhAwlLzdwdZRfjTb1lneHeWseHnejos16I7A+xOKerxf6ktYKm8pBgWjJ3HpQeoLJwSTbUPTPu7fZQGOvtenI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/30VmtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78410C4CEC3;
	Mon, 21 Oct 2024 17:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729533146;
	bh=bwjoxKe/S8m9xoQ93oneRuC+Kz1dRhONXz+q9MJ/JS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N/30VmtUuORRplp7V2qnfdDlznasLsrnmgC0MczdO4fzJNK7/ReGsKBY+YShO3rjM
	 ARHuaWRHy8x9S1Ed3H1RlZl/shcZt/OMteBNlQsUQ9evqc5CAtTiwQ9a0bwrAXH48C
	 aOsF3FfQZrD9qQy5hGfVcs9VCPKYnWmhjFhBUi/lGPlfYiENQsJ3eMXZOZuLq5ej9J
	 hAX1f5Q4VXO8+nf10Pw9XQ/gtOdHPTdceWddwLIMu/yCrMfnxvqN/qnj90G1Xo0BwA
	 fpIy7P9eoFYLZlDJ/I+yIF3IYJ4XZG5sWKuDH0D/BIHyiKIQIN20NDVgt6w+Snsizs
	 OdvEKqRAhcsOA==
Message-ID: <4d38a718-6416-42ba-a2d5-985147382dda@kernel.org>
Date: Mon, 21 Oct 2024 12:52:24 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] CPPC: Use heterogeneous core topology for identifying
 boost numerator
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, x86@kernel.org,
 linux-acpi@vger.kernel.org, Perry Yuan <perry.yuan@amd.com>,
 gautham.shenoy@amd.com, Mario Limonciello <mario.limonciello@amd.com>
References: <20241003213759.3038862-1-superm1@kernel.org>
 <20241003213759.3038862-3-superm1@kernel.org>
 <20241021105803.GEZxYzu3hfAUp2Sblh@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20241021105803.GEZxYzu3hfAUp2Sblh@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/2024 05:58, Borislav Petkov wrote:
> On Thu, Oct 03, 2024 at 04:37:59PM -0500, Mario Limonciello wrote:
>> Subject: Re: [PATCH 2/2] CPPC: Use heterogeneous core topology for identifying boost numerator
> 
> The tip tree preferred format for patch subject prefixes is
> 'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
> 'genirq/core:'. Please do not use file names or complete file paths as
> prefix. 'git log path/to/file' should give you a reasonable hint in most
> cases.
> 
> The condensed patch description in the subject line should start with a
> uppercase letter and should be written in imperative tone.
> 
>> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
>> index 4a686f0e5dbf..d81a6efa81bb 100644
>> --- a/arch/x86/include/asm/processor.h
>> +++ b/arch/x86/include/asm/processor.h
>> @@ -691,6 +691,14 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
>>   	return per_cpu(cpu_info.topo.l2c_id, cpu);
>>   }
>>   
>> +/* defined by CPUID_Fn80000026_EBX BIT [31:28] */
>> +enum amd_core_type {
>> +	CPU_CORE_TYPE_NO_HETERO_SUP = -1,
> 
> Why?
> 
> Why isn't this the last value in the enum without explicitly enumerating them?
> 
>> +	CPU_CORE_TYPE_PERFORMANCE = 0,
>> +	CPU_CORE_TYPE_EFFICIENCY = 1,
>> +	CPU_CORE_TYPE_UNDEFINED = 2,
>> +};
> 
> That thing goes...
> 
>> +
>>   #ifdef CONFIG_CPU_SUP_AMD
> 
> ... in here.
> 
>>   /*
>>    * Issue a DIV 0/1 insn to clear any division data from previous DIV
> 
> ...
> 

Ack; will drop a series momentarily fixing this and your other above 
feedback.

Thx.

>> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
>> index 015971adadfc..8ad5f1385f0e 100644
>> --- a/arch/x86/kernel/cpu/amd.c
>> +++ b/arch/x86/kernel/cpu/amd.c
>> @@ -1204,3 +1204,32 @@ void amd_check_microcode(void)
>>   
>>   	on_each_cpu(zenbleed_check_cpu, NULL, 1);
>>   }
>> +
>> +/**
>> + * amd_get_core_type - Heterogeneous core type identification
>> + *
>> + * Returns the CPU type [31:28] (i.e., performance or efficient) of
>> + * a CPU in the processor.
>> + *
>> + * If the processor has no core type support, returns
>> + * CPU_CORE_TYPE_NO_HETERO_SUP.
>> + */
>> +enum amd_core_type amd_get_core_type(void)
>> +{
>> +	struct {
>> +		u32  num_processors             :16,
>> +		     power_efficiency_ranking   :8,
>> +		     native_model_id            :4,
>> +		     core_type                  :4;
>> +	} props;
> 
> So this thing wants to use this stuff here:
> 
> https://lore.kernel.org/r/20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com
> 
> and add the AMD part to the union. Instead of calling CPUID each time and
> adding an ugly export...

Due to the cross tree landing complexity I'll rip this and the symbol 
out after that one lands (probably next cycle).

> 
>> +
>> +	if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
>> +		return CPU_CORE_TYPE_NO_HETERO_SUP;
>> +
>> +	cpuid_leaf_reg(0x80000026, CPUID_EBX, &props);
>> +	if (props.core_type >= CPU_CORE_TYPE_UNDEFINED)
>> +		return CPU_CORE_TYPE_UNDEFINED;
>> +
>> +	return props.core_type;
>> +}
>> +EXPORT_SYMBOL_GPL(amd_get_core_type);
>> -- 
>> 2.43.0
>>
> 


