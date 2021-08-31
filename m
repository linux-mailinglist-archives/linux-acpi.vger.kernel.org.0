Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4C63FC74F
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Aug 2021 14:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhHaMfD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Aug 2021 08:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhHaMfC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 31 Aug 2021 08:35:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C0A16103E;
        Tue, 31 Aug 2021 12:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630413247;
        bh=6HDDhtpKaGXV78u18QgQGG/0ha5vhcD/0u5eUw6ZWMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ceysoIUny2eIi/1LE6OvTNQfsCmPBPsIZOo88PEitU1flHFqTGPI7/qkXyufVhD8K
         9sfcp9K5/sqD2J+cp7Y8Wt+ew8A4Bc01XCSM7sIUo5SRfw8I8jn/41rNHVW3wGge/5
         8mySGGELNnh27bHPxF3iUcnNByEq+eZFtFK+9qJhmK18fRQwUA/EhoJBxxtbmw7nB1
         cEWYvGS1vBweshujBnC/lN3TkMD0+Jv9SzCwCeh+lyKHTqt5T2a9qdLLEfyWqKGIJm
         y2IJE2dqxsHIST0CHtAUHzceXmwx8LQJovdvx0YSgkSozSQ/HBYIGMND2U5lFQWf+X
         HVMO4rVYtDibQ==
Date:   Tue, 31 Aug 2021 13:34:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        wangle6@huawei.com, xiaoqian9@huawei.com, shaolexi@huawei.com,
        linux-acpi@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] semaphore: Add might_sleep() to down_*() family
Message-ID: <20210831123401.GA31712@willie-the-truck>
References: <20210809021215.19991-1-nixiaoming@huawei.com>
 <20210831111322.GA1687117@roeck-us.net>
 <871r69ersb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r69ersb.ffs@tglx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 31, 2021 at 02:13:08PM +0200, Thomas Gleixner wrote:
> On Tue, Aug 31 2021 at 04:13, Guenter Roeck wrote:
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

typo: "usefel"

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

Glad to see the back of this:

Acked-by: Will Deacon <will@kernel.org>

Will
