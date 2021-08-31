Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C167A3FCC76
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Aug 2021 19:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhHaRnW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Aug 2021 13:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhHaRnV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Aug 2021 13:43:21 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98C3C061575;
        Tue, 31 Aug 2021 10:42:25 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so72526otf.6;
        Tue, 31 Aug 2021 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B1LHGphPEba5NZOfpvC5Fu547UHq90yEuXN6wYUtUOg=;
        b=Nsh9Rqlg49JA5gem8AN3KCBjJiL9JEbsmZLcVZJZMwy4WD4SO+7OD6DHji7n6AExtF
         i9k5+0mmfwJQ+gpNK8KheEPwsbIjXlj7xHIwj7xWR0pTl6uPDl9pcCQJVfTm3y0my4z6
         sfDCiDv6EKVwpIYdNLfGvjZV8IR4+cIeM1tMUPmZPmkwyxtPNFZyoK8rZ/fufsjTHKS5
         +WRni/XSFdM90RZhSuagCfcwoxNJPvIOLx61n88D8ztQL1kfSi7AJkl3sqnyOWHSYUm8
         uAziYoc+Kp/GOPUwqg0XZL69yDo+nONmBThvfGffAFzngp9Fmc12kKT//Ot1yYoIzuQC
         CZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=B1LHGphPEba5NZOfpvC5Fu547UHq90yEuXN6wYUtUOg=;
        b=ULi/wj16d6By3x0T1dtA+BLDy889GWXptNWoQT0CiF99hCyiAQzwhpZv9fG61zX/jr
         48BQ1ciwoweL6wXSggVVAQz1ESyj1B40CAHhRjeuvBmlAaSCl9HxKjLipjCpM1TkfSO2
         MRvF1P/NWVkYVbzRtUa5RY4wKJmAE5DkF/nrU1v5Bq6AzEYj3/RK9Go1GEPaiO5NXsS4
         aZX9HlEb3kFtAuvuIOCxbX/afz2cNtcJJ21jgJQDMLYbeecxMHjmokfnKqezjoOiNxgh
         nQgRKr2sa9hHL0yDYJTyFV07ji6UTmNwvesenPamphOdInqglSr/CZ5T3CCSt767UcaE
         c1ng==
X-Gm-Message-State: AOAM533e1K37v9YviF2nDqJs8ipxR5Uff7QtSlee+N47rEAhdDxQpWJW
        L18bG171GoCNxCstz1zDwec=
X-Google-Smtp-Source: ABdhPJyiiKrDu2x9L8n348OCFziR086Je5juU3I11U3OIknbwQSGanqioLjYclbdKtNBEB2YhmUaYg==
X-Received: by 2002:a9d:17c5:: with SMTP id j63mr25026360otj.208.1630431745119;
        Tue, 31 Aug 2021 10:42:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t1sm3987511otp.9.2021.08.31.10.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 10:42:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Aug 2021 10:42:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, wangle6@huawei.com,
        xiaoqian9@huawei.com, shaolexi@huawei.com,
        linux-acpi@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] semaphore: Add might_sleep() to down_*() family
Message-ID: <20210831174222.GA1040808@roeck-us.net>
References: <20210809021215.19991-1-nixiaoming@huawei.com>
 <20210831111322.GA1687117@roeck-us.net>
 <871r69ersb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r69ersb.ffs@tglx>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 31, 2021 at 02:13:08PM +0200, Thomas Gleixner wrote:
> On Tue, Aug 31 2021 at 04:13, Guenter Roeck wrote:
> 
> > Hi,
> >
> > On Mon, Aug 09, 2021 at 10:12:15AM +0800, Xiaoming Ni wrote:
> >> Semaphore is sleeping lock. Add might_sleep() to down*() family
> >> (with exception of down_trylock()) to detect atomic context sleep.
> >> 
> >> Previously discussed with Peter Zijlstra, see link:
> >>  https://lore.kernel.org/lkml/20210806082320.GD22037@worktop.programming.kicks-ass.net
> >> 
> >> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> >> Acked-by: Will Deacon <will@kernel.org>
> >
> > This patch results in the following traceback on all arm64 boots with
> > EFI BIOS.
> 
> That's what this change was supposed to catch :)
> 
> > The problem is only seen with CONFIG_ACPI_PPTT=y, and thus only on arm64.
> 
> The below should fix this.
> 
> Thanks,
> 
>         tglx
> ---
> Subject: drivers: base: cacheinfo: Get rid of DEFINE_SMP_CALL_CACHE_FUNCTION()
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Tue, 31 Aug 2021 13:48:34 +0200
> 
> DEFINE_SMP_CALL_CACHE_FUNCTION() was usefel before the CPU hotplug rework
> to ensure that the cache related functions are called on the upcoming CPU
> because the notifier itself could run on any online CPU.
> 
> The hotplug state machine guarantees that the callbacks are invoked on the
> upcoming CPU. So there is no need to have this SMP function call
> obfuscation. That indirection was missed when the hotplug notifiers were
> converted.
> 
> This also solves the problem of ARM64 init_cache_level() invoking ACPI
> functions which take a semaphore in that context. That's invalid as SMP
> function calls run with interrupts disabled. Running it just from the
> callback in context of the CPU hotplug thread solves this.
>  
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 8571890e1513 ("arm64: Add support for ACPI based firmware tables")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

The warning is no longer seen with this patch applied on top of
v5.14-1100-gb91db6a0b52e, and I don't see any new problems on riscv,
x86/x86_64, or mips.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
>  arch/arm64/kernel/cacheinfo.c   |    7 ++-----
>  arch/mips/kernel/cacheinfo.c    |    7 ++-----
>  arch/riscv/kernel/cacheinfo.c   |    7 ++-----
>  arch/x86/kernel/cpu/cacheinfo.c |    7 ++-----
>  include/linux/cacheinfo.h       |   18 ------------------
>  5 files changed, 8 insertions(+), 38 deletions(-)
> 
> --- a/arch/arm64/kernel/cacheinfo.c
> +++ b/arch/arm64/kernel/cacheinfo.c
> @@ -43,7 +43,7 @@ static void ci_leaf_init(struct cacheinf
>  	this_leaf->type = type;
>  }
>  
> -static int __init_cache_level(unsigned int cpu)
> +int init_cache_level(unsigned int cpu)
>  {
>  	unsigned int ctype, level, leaves, fw_level;
>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> @@ -78,7 +78,7 @@ static int __init_cache_level(unsigned i
>  	return 0;
>  }
>  
> -static int __populate_cache_leaves(unsigned int cpu)
> +int populate_cache_leaves(unsigned int cpu)
>  {
>  	unsigned int level, idx;
>  	enum cache_type type;
> @@ -97,6 +97,3 @@ static int __populate_cache_leaves(unsig
>  	}
>  	return 0;
>  }
> -
> -DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
> -DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
> --- a/arch/mips/kernel/cacheinfo.c
> +++ b/arch/mips/kernel/cacheinfo.c
> @@ -17,7 +17,7 @@ do {								\
>  	leaf++;							\
>  } while (0)
>  
> -static int __init_cache_level(unsigned int cpu)
> +int init_cache_level(unsigned int cpu)
>  {
>  	struct cpuinfo_mips *c = &current_cpu_data;
>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> @@ -74,7 +74,7 @@ static void fill_cpumask_cluster(int cpu
>  			cpumask_set_cpu(cpu1, cpu_map);
>  }
>  
> -static int __populate_cache_leaves(unsigned int cpu)
> +int populate_cache_leaves(unsigned int cpu)
>  {
>  	struct cpuinfo_mips *c = &current_cpu_data;
>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> @@ -114,6 +114,3 @@ static int __populate_cache_leaves(unsig
>  
>  	return 0;
>  }
> -
> -DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
> -DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -113,7 +113,7 @@ static void fill_cacheinfo(struct cachei
>  	}
>  }
>  
> -static int __init_cache_level(unsigned int cpu)
> +int init_cache_level(unsigned int cpu)
>  {
>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>  	struct device_node *np = of_cpu_device_node_get(cpu);
> @@ -155,7 +155,7 @@ static int __init_cache_level(unsigned i
>  	return 0;
>  }
>  
> -static int __populate_cache_leaves(unsigned int cpu)
> +int populate_cache_leaves(unsigned int cpu)
>  {
>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>  	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
> @@ -187,6 +187,3 @@ static int __populate_cache_leaves(unsig
>  
>  	return 0;
>  }
> -
> -DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
> -DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -985,7 +985,7 @@ static void ci_leaf_init(struct cacheinf
>  	this_leaf->priv = base->nb;
>  }
>  
> -static int __init_cache_level(unsigned int cpu)
> +int init_cache_level(unsigned int cpu)
>  {
>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>  
> @@ -1014,7 +1014,7 @@ static void get_cache_id(int cpu, struct
>  	id4_regs->id = c->apicid >> index_msb;
>  }
>  
> -static int __populate_cache_leaves(unsigned int cpu)
> +int populate_cache_leaves(unsigned int cpu)
>  {
>  	unsigned int idx, ret;
>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> @@ -1033,6 +1033,3 @@ static int __populate_cache_leaves(unsig
>  
>  	return 0;
>  }
> -
> -DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
> -DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -79,24 +79,6 @@ struct cpu_cacheinfo {
>  	bool cpu_map_populated;
>  };
>  
> -/*
> - * Helpers to make sure "func" is executed on the cpu whose cache
> - * attributes are being detected
> - */
> -#define DEFINE_SMP_CALL_CACHE_FUNCTION(func)			\
> -static inline void _##func(void *ret)				\
> -{								\
> -	int cpu = smp_processor_id();				\
> -	*(int *)ret = __##func(cpu);				\
> -}								\
> -								\
> -int func(unsigned int cpu)					\
> -{								\
> -	int ret;						\
> -	smp_call_function_single(cpu, _##func, &ret, true);	\
> -	return ret;						\
> -}
> -
>  struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
>  int init_cache_level(unsigned int cpu);
>  int populate_cache_leaves(unsigned int cpu);
