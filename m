Return-Path: <linux-acpi+bounces-9285-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 303EE9BBFDA
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 22:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DA75B20A60
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 21:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9144B1FA25C;
	Mon,  4 Nov 2024 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/9TlpmV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666671C57A5;
	Mon,  4 Nov 2024 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754891; cv=none; b=Ra0ODbo0TNNkyIAizdrPef3wZy67alHRTHvZJTQcsKQqOXKKJYNNDacg/9K78OG4oFD/MFWBnhZSz2eUIczvklA8J96A3Qv1i3HZZcgnPPnqI5zLnCn+KeAMUCDu+8OshFvPzLvjC45YLfCd/bCD+DD9+dFsC8wGpuaYrIsIS4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754891; c=relaxed/simple;
	bh=oNFW2dF1VkNCjCIXnbzm4F7p+aLAg6Iuh9+/LWfa//Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPw+8tQtkrykpXcIQHTDXHcLWuqKSrVvHCY55Re1FRf1oMm8oBXqHnu4S/3l4J5dTE+K7l4A/EVjlRiZ7eO50GwAPJiKCFuqIaCguC+k4WtPyY0yvPz8wwedJwyvVSgRssGl52GIZu/kl8L20NUBDFSgZ47q8umpD1qTfsDrKDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/9TlpmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D181EC4CECE;
	Mon,  4 Nov 2024 21:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730754890;
	bh=oNFW2dF1VkNCjCIXnbzm4F7p+aLAg6Iuh9+/LWfa//Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H/9TlpmVHWANaXvvBzJE6IYyjnWlxM6ca6v05P9tiVoEg6Vx6KUCuKgz9jjDXCGrv
	 yIUTRVxULhJjLcoPZjIxw7HI8sXII6WqvZyC046o/MxNUEbWUn1N2t+VP/oZE1vg2M
	 UZtYk14w74EPvtKSS0i3GO5MofnUTcGu8T2ve7hnMBGmIqXyI6QqWQoTja3k0lTZ9d
	 ezocIQoWuz0/Tw/MTywixfsqwtzt21VxA91WanqF/iOhEgZwnyYYrEU0wcnFAJzns2
	 FJ9N6Zev/Yzt+RuWzttwqNoosmkznik1iqZwwQnEtenvlrXpQ42h9gQrsG/sZQ24bE
	 6Zl89RlndjkVg==
Message-ID: <814adf82-99ec-44f8-83d0-6540f2cccbcb@kernel.org>
Date: Mon, 4 Nov 2024 15:14:48 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ACPI: processor: Move arch_init_invariance_cppc() call
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
References: <20241104205446.3874509-1-superm1@kernel.org>
 <CAJZ5v0jGTzRNgA7HM-r=TuhHyy0gvMuNEgz5wZ2hPkqwyFa6og@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0jGTzRNgA7HM-r=TuhHyy0gvMuNEgz5wZ2hPkqwyFa6og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/4/2024 15:10, Rafael J. Wysocki wrote:
> On Mon, Nov 4, 2024 at 9:54 PM Mario Limonciello <superm1@kernel.org> wrote:
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
>> To fix this problem, change arch_init_invariance_cppc() into a new weak
>> symbol that is called at the end of acpi_processor_driver_init().
>> Each architecture that supports it can declare the symbol to override
>> the weak one.
>>
>> Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()")
>> Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219431
>> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v3:
>>   * Weak symbol instead of macro to help riscv build failure
>>   * Update commit message
>>   * Add comment
>> ---
>>   arch/arm64/include/asm/topology.h | 2 +-
>>   arch/x86/include/asm/topology.h   | 2 +-
>>   drivers/acpi/cppc_acpi.c          | 6 ------
>>   drivers/acpi/processor_driver.c   | 9 +++++++++
>>   include/acpi/processor.h          | 2 ++
>>   5 files changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
>> index 5fc3af9f8f29b..8a1860877967e 100644
>> --- a/arch/arm64/include/asm/topology.h
>> +++ b/arch/arm64/include/asm/topology.h
>> @@ -27,7 +27,7 @@ void update_freq_counters_refs(void);
>>   #define arch_scale_freq_ref topology_get_freq_ref
>>
>>   #ifdef CONFIG_ACPI_CPPC_LIB
>> -#define arch_init_invariance_cppc topology_init_cpu_capacity_cppc
>> +#define acpi_processor_init_invariance_cppc topology_init_cpu_capacity_cppc
>>   #endif
>>
>>   /* Replace task scheduler's default cpu-invariant accounting */
>> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
>> index aef70336d6247..0fb705524aeaa 100644
>> --- a/arch/x86/include/asm/topology.h
>> +++ b/arch/x86/include/asm/topology.h
>> @@ -307,7 +307,7 @@ extern void arch_scale_freq_tick(void);
>>
>>   #ifdef CONFIG_ACPI_CPPC_LIB
>>   void init_freq_invariance_cppc(void);
>> -#define arch_init_invariance_cppc init_freq_invariance_cppc
>> +#define acpi_processor_init_invariance_cppc init_freq_invariance_cppc
>>   #endif
>>
>>   #endif /* _ASM_X86_TOPOLOGY_H */
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 1a40f0514eaa3..5c0cc7aae8726 100644
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
>> index cb52dd000b958..3b281bc1e73c3 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -237,6 +237,9 @@ static struct notifier_block acpi_processor_notifier_block = {
>>          .notifier_call = acpi_processor_notifier,
>>   };
>>
>> +void __weak acpi_processor_init_invariance_cppc(void)
>> +{ }
> 
> Does this actually work if acpi_processor_init_invariance_cppc is a
> macro?  How does the compiler know that it needs to use
> init_freq_invariance_cppc() instead of this?
> 
> It would work if a __weak definition of init_freq_invariance_cppc() was present.

I also wasn't sure, so I explicitly added some tracing in 
init_freq_invariance_cppc() to make sure it got called and checked it 
(GCC 13.2.0).

But I'll admit it's a confusing behavior.  If you think it's too 
confusing I'll swap it around to just axe the macros.

> 
>> +
>>   /*
>>    * We keep the driver loaded even when ACPI is not running.
>>    * This is needed for the powernow-k8 driver, that works even without
>> @@ -270,6 +273,12 @@ static int __init acpi_processor_driver_init(void)
>>                                    NULL, acpi_soft_cpu_dead);
>>
>>          acpi_processor_throttling_init();
>> +
>> +       /*
>> +        * Frequency invariance calculations on AMD platforms can't be run until
>> +        * after acpi_cppc_processor_probe() has been called for all online CPUs.
>> +        */
>> +       acpi_processor_init_invariance_cppc();
>>          return 0;
>>   err:
>>          driver_unregister(&acpi_processor_driver);
>> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>> index e6f6074eadbf3..a17e97e634a68 100644
>> --- a/include/acpi/processor.h
>> +++ b/include/acpi/processor.h
>> @@ -465,4 +465,6 @@ extern int acpi_processor_ffh_lpi_probe(unsigned int cpu);
>>   extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
>>   #endif
>>
>> +void acpi_processor_init_invariance_cppc(void);
>> +
>>   #endif
>>
>> base-commit: 6db936d4ac0fe281af48b4d1ebf69b1523bbac31
>> --
>> 2.43.0
>>


