Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245FB3FC72F
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Aug 2021 14:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbhHaMRI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Aug 2021 08:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241669AbhHaMQ7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Aug 2021 08:16:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8E7C02559A;
        Tue, 31 Aug 2021 05:13:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630411989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SmjNz3mhJ0BePJvvOp7xQW1xRXoh88iEuf6wgamwsMk=;
        b=hYO+DpL016+ezqsk4QCzP3VZhKw8e1usy0SRkOeZUN6eHOpGUiZnnFwkPC3HaQbsmj3MxL
        vvXKBKAFS0Yvxa2xHf8CjUhEHds09Xs8zJZJnCAeGIGys5AYmWzKGXowIGq4ccgu/W2IHL
        QTpk2LdcccX3kdHkPripb5gnf5YMJp9tQNpCQwoyYkC9kUwd7FYng9DA8/iP8uMenp5tFD
        sDNFV0awiRY791VYFd2C45PfFUh6TpkpRgUP7df0SavZnbN9xyFhzc1x07rH/crVaZUc2B
        0HJs/jFtkX5e01tKSqtlCvogiPwBNQ0JFyZoeTj+6yr4iF1uL4N57+YJsH39kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630411989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SmjNz3mhJ0BePJvvOp7xQW1xRXoh88iEuf6wgamwsMk=;
        b=4ZnA/q1td52wYvVQktzxACKLVnKy5m0UpBvadm/N2rv25B0KpAhwqtMko1L+c0YUNbV6Al
        H72RrE5KW0CD7JAA==
To:     Guenter Roeck <linux@roeck-us.net>,
        Xiaoming Ni <nixiaoming@huawei.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, wangle6@huawei.com, xiaoqian9@huawei.com,
        shaolexi@huawei.com, linux-acpi@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] semaphore: Add might_sleep() to down_*() family
In-Reply-To: <20210831111322.GA1687117@roeck-us.net>
References: <20210809021215.19991-1-nixiaoming@huawei.com>
 <20210831111322.GA1687117@roeck-us.net>
Date:   Tue, 31 Aug 2021 14:13:08 +0200
Message-ID: <871r69ersb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 31 2021 at 04:13, Guenter Roeck wrote:

> Hi,
>
> On Mon, Aug 09, 2021 at 10:12:15AM +0800, Xiaoming Ni wrote:
>> Semaphore is sleeping lock. Add might_sleep() to down*() family
>> (with exception of down_trylock()) to detect atomic context sleep.
>> 
>> Previously discussed with Peter Zijlstra, see link:
>>  https://lore.kernel.org/lkml/20210806082320.GD22037@worktop.programming.kicks-ass.net
>> 
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>> Acked-by: Will Deacon <will@kernel.org>
>
> This patch results in the following traceback on all arm64 boots with
> EFI BIOS.

That's what this change was supposed to catch :)

> The problem is only seen with CONFIG_ACPI_PPTT=y, and thus only on arm64.

The below should fix this.

Thanks,

        tglx
---
Subject: drivers: base: cacheinfo: Get rid of DEFINE_SMP_CALL_CACHE_FUNCTION()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 31 Aug 2021 13:48:34 +0200

DEFINE_SMP_CALL_CACHE_FUNCTION() was usefel before the CPU hotplug rework
to ensure that the cache related functions are called on the upcoming CPU
because the notifier itself could run on any online CPU.

The hotplug state machine guarantees that the callbacks are invoked on the
upcoming CPU. So there is no need to have this SMP function call
obfuscation. That indirection was missed when the hotplug notifiers were
converted.

This also solves the problem of ARM64 init_cache_level() invoking ACPI
functions which take a semaphore in that context. That's invalid as SMP
function calls run with interrupts disabled. Running it just from the
callback in context of the CPU hotplug thread solves this.
 
Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 8571890e1513 ("arm64: Add support for ACPI based firmware tables")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm64/kernel/cacheinfo.c   |    7 ++-----
 arch/mips/kernel/cacheinfo.c    |    7 ++-----
 arch/riscv/kernel/cacheinfo.c   |    7 ++-----
 arch/x86/kernel/cpu/cacheinfo.c |    7 ++-----
 include/linux/cacheinfo.h       |   18 ------------------
 5 files changed, 8 insertions(+), 38 deletions(-)

--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -43,7 +43,7 @@ static void ci_leaf_init(struct cacheinf
 	this_leaf->type = type;
 }
 
-static int __init_cache_level(unsigned int cpu)
+int init_cache_level(unsigned int cpu)
 {
 	unsigned int ctype, level, leaves, fw_level;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -78,7 +78,7 @@ static int __init_cache_level(unsigned i
 	return 0;
 }
 
-static int __populate_cache_leaves(unsigned int cpu)
+int populate_cache_leaves(unsigned int cpu)
 {
 	unsigned int level, idx;
 	enum cache_type type;
@@ -97,6 +97,3 @@ static int __populate_cache_leaves(unsig
 	}
 	return 0;
 }
-
-DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
-DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
--- a/arch/mips/kernel/cacheinfo.c
+++ b/arch/mips/kernel/cacheinfo.c
@@ -17,7 +17,7 @@ do {								\
 	leaf++;							\
 } while (0)
 
-static int __init_cache_level(unsigned int cpu)
+int init_cache_level(unsigned int cpu)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -74,7 +74,7 @@ static void fill_cpumask_cluster(int cpu
 			cpumask_set_cpu(cpu1, cpu_map);
 }
 
-static int __populate_cache_leaves(unsigned int cpu)
+int populate_cache_leaves(unsigned int cpu)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -114,6 +114,3 @@ static int __populate_cache_leaves(unsig
 
 	return 0;
 }
-
-DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
-DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -113,7 +113,7 @@ static void fill_cacheinfo(struct cachei
 	}
 }
 
-static int __init_cache_level(unsigned int cpu)
+int init_cache_level(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct device_node *np = of_cpu_device_node_get(cpu);
@@ -155,7 +155,7 @@ static int __init_cache_level(unsigned i
 	return 0;
 }
 
-static int __populate_cache_leaves(unsigned int cpu)
+int populate_cache_leaves(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
@@ -187,6 +187,3 @@ static int __populate_cache_leaves(unsig
 
 	return 0;
 }
-
-DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
-DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -985,7 +985,7 @@ static void ci_leaf_init(struct cacheinf
 	this_leaf->priv = base->nb;
 }
 
-static int __init_cache_level(unsigned int cpu)
+int init_cache_level(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 
@@ -1014,7 +1014,7 @@ static void get_cache_id(int cpu, struct
 	id4_regs->id = c->apicid >> index_msb;
 }
 
-static int __populate_cache_leaves(unsigned int cpu)
+int populate_cache_leaves(unsigned int cpu)
 {
 	unsigned int idx, ret;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -1033,6 +1033,3 @@ static int __populate_cache_leaves(unsig
 
 	return 0;
 }
-
-DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
-DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -79,24 +79,6 @@ struct cpu_cacheinfo {
 	bool cpu_map_populated;
 };
 
-/*
- * Helpers to make sure "func" is executed on the cpu whose cache
- * attributes are being detected
- */
-#define DEFINE_SMP_CALL_CACHE_FUNCTION(func)			\
-static inline void _##func(void *ret)				\
-{								\
-	int cpu = smp_processor_id();				\
-	*(int *)ret = __##func(cpu);				\
-}								\
-								\
-int func(unsigned int cpu)					\
-{								\
-	int ret;						\
-	smp_call_function_single(cpu, _##func, &ret, true);	\
-	return ret;						\
-}
-
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
