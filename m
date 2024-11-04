Return-Path: <linux-acpi+bounces-9278-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6729BBB4D
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 18:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE16281AB0
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8561C4A3C;
	Mon,  4 Nov 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F337prcy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3520F1C4A25;
	Mon,  4 Nov 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740628; cv=none; b=eEKCFY6aIBS6y16SFpQQKlbzDYz4SQiKTkAz2B4j0NnUD3PpQXVXiDtDi7zNzdZr3AKg0IWtV/I2qOZpxukBCqcffehKLJQEU8/MzUe3dcUaWNyM+EQysSpUqeuXtzzpZpS7IApczruN5Q5hDwUbydfMfuwCHYHfoWvRXrD0euM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740628; c=relaxed/simple;
	bh=xICU2lfpalo4u2NWwzN6EbIUM6yHFha/WhiEgSr88wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPnFglLaxC5McjYiFsdxurVsoxyPRFcyaXepR4oUrp+Y+PKlnkHUDBZfEO/Ycl/FRG55mtCvYO05S6kPt6eiprPBwlMxnW4gL0WHWzhPzxSk7lBvi/JST/70kC7DhA0K3rbxpafyyFpWRHtpY53MqMsOjnaG+HotXTBjiGj0RVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F337prcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A90C4CECE;
	Mon,  4 Nov 2024 17:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730740627;
	bh=xICU2lfpalo4u2NWwzN6EbIUM6yHFha/WhiEgSr88wM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F337prcyYIWgUsGtkZpHscVk6J98fkB/nyuHwOC4/lzSG9KQh6W6/2vyCibuhPcI/
	 ocobgKXxEntAb0cE4jHEJTF9nc1M6iM6wJLrc7wOQsJec4ZgI4LEIZP6XXvLlsvaRe
	 O+Sitb3gZ4j/fqpzC+jlFjEW6wkoJKGBN8LrfCTAlVCMdJ+Pa4t6Sn3LC9dftJDgAr
	 jPVTjHHuCBskDEkQIctwoCX5wWQIgIubwgjY6pH6Nec6fhRzL5ALhCfhtrCtAXgHPn
	 PZh3QEYfzaQ+FANbZ3pXxYmd5YylGZxDhMiItYjqcsMNE6NsqZuIodNGSUAjVw+rG1
	 eKkA42rPwDM8A==
Message-ID: <c72e23ee-4a53-4f3b-8387-bd9b77c0a3fe@kernel.org>
Date: Mon, 4 Nov 2024 11:17:05 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: processor: Move arch_init_invariance_cppc() call
 later
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>, Ivan Shapovalov <intelfx@intelfx.name>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20241102032353.2372544-1-superm1@kernel.org>
 <CAJZ5v0hVbJctHHMS4=c74Y1+qOw2VRfevkPi9W99nHHPejNw0w@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0hVbJctHHMS4=c74Y1+qOw2VRfevkPi9W99nHHPejNw0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/4/2024 10:55, Rafael J. Wysocki wrote:
> On Sat, Nov 2, 2024 at 4:24 AM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> arch_init_invariance_cppc() is called at the end of
>> acpi_cppc_processor_probe() in order to configure frequency invariance
>> based upon the values from _CPC.
>>
>> This however doesn't work on AMD CPPC shared memory designs that have
>> AMD preferred cores enabled because _CPC needs to be analyzed from all
>> cores to judge if preferred cores are enabled.
>>
>> This issue manifests to users as a warning since commit 21fb59ab4b97
>> ("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn"):
>> ```
>> Could not retrieve highest performance (-19)
>> ```
>>
>> However the warning isn't the cause of this, it was actually
>> commit 279f838a61f9 ("x86/amd: Detect preferred cores in
>> amd_get_boost_ratio_numerator()") which exposed the issue.
>>
>> To fix this problem, push the call to the arch_init_invariance_cppc()
>> macro to the end of acpi_processor_driver_init().
>>
>> Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()")
>> Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219431
>> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * Fix LKP robot issue when CONFIG_ACPI_CPPC_LIB not defined
>> ---
>>   arch/x86/include/asm/topology.h | 2 ++
>>   drivers/acpi/cppc_acpi.c        | 6 ------
>>   drivers/acpi/processor_driver.c | 1 +
>>   3 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
>> index abe3a8f22cbd..b04c5db7e945 100644
>> --- a/arch/x86/include/asm/topology.h
>> +++ b/arch/x86/include/asm/topology.h
>> @@ -295,6 +295,8 @@ extern void arch_scale_freq_tick(void);
>>   #ifdef CONFIG_ACPI_CPPC_LIB
>>   void init_freq_invariance_cppc(void);
>>   #define arch_init_invariance_cppc init_freq_invariance_cppc
>> +#else
>> +static inline void arch_init_invariance_cppc(void) { }
>>   #endif
>>
>>   #endif /* _ASM_X86_TOPOLOGY_H */
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index ed91dfd4fdca..9d48cd706659 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -671,10 +671,6 @@ static int pcc_data_alloc(int pcc_ss_id)
>>    *  )
>>    */
>>
>> -#ifndef arch_init_invariance_cppc
>> -static inline void arch_init_invariance_cppc(void) { }
>> -#endif
>> -
>>   /**
>>    * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
>>    * @pr: Ptr to acpi_processor containing this CPU's logical ID.
>> @@ -905,8 +901,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>>                  goto out_free;
>>          }
>>
>> -       arch_init_invariance_cppc();
>> -
>>          kfree(output.pointer);
>>          return 0;
>>
>> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
>> index cb52dd000b95..59620e7bc664 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -270,6 +270,7 @@ static int __init acpi_processor_driver_init(void)
>>                                    NULL, acpi_soft_cpu_dead);
>>
>>          acpi_processor_throttling_init();
>> +       arch_init_invariance_cppc();
>>          return 0;
>>   err:
>>          driver_unregister(&acpi_processor_driver);
>> --
> 
> Applied as a fix for 6.12-rc7.
> 
> However, it would be good to add a comment explaining why
> acpi_processor_driver_init() calls arch_init_invariance_cppc() at the
> end.  The ACPI processor driver and CPPC are not otherwise related I
> think?

Sure, I'm thinking a comment like this.

/*
  * Frequency invariance calculations on AMD platforms can't be run until
  * _CPC has been evaluated on all processors which will only happen
  * after probing is complete.
  */

If that sounds good do you want to squash it in?  Or if you would prefer 
another commit tacked on that's no problem I'll do that.

