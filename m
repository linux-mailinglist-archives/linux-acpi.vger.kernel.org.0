Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF20B3FC6BA
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Aug 2021 14:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhHaLmB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Aug 2021 07:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhHaLmB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Aug 2021 07:42:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D0C061575;
        Tue, 31 Aug 2021 04:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l//iG72UQUgu2Sgam8e4jXFgahV9t6yqfjss357Zl/I=; b=UGQNARUjmU0UNrllsXfAZ/+m1u
        ke4UgWNCQFKzrWa8HwEqXRnENub5IcaTf3Rj7I6DfFq0wgy3RrhOYTffJ+S4mmSZ0fc6F8+iF1+13
        PM9mY5u0NoBzyo/7S1cNU9MNrLY+8DNeinkLVQ1bzpfLsvfv9IE45Fz7lWLJs9+mvCzBiDRcySvMv
        wv+Yia6qSQqaq8RLI8whUARE/jOEh7s+puisO99TWfuFfke1LaCDfbkA2x4D4i2NhlfaLU+crDxTd
        Rc61oJN7dnd+6EvV5PKvzomk1Z4Qlb1Il9w6vi1tiHdNcdf4+VqOun8wRhWydc0tbmwB9l99eWLwV
        d5gmoqLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL28C-00EgZk-Kl; Tue, 31 Aug 2021 11:40:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 870F4300109;
        Tue, 31 Aug 2021 13:40:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F60F2C83EADB; Tue, 31 Aug 2021 13:40:43 +0200 (CEST)
Date:   Tue, 31 Aug 2021 13:40:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, wangle6@huawei.com, xiaoqian9@huawei.com,
        shaolexi@huawei.com, linux-acpi@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] semaphore: Add might_sleep() to down_*() family
Message-ID: <YS4VO7iz73jXR9nN@hirez.programming.kicks-ass.net>
References: <20210809021215.19991-1-nixiaoming@huawei.com>
 <20210831111322.GA1687117@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831111322.GA1687117@roeck-us.net>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 31, 2021 at 04:13:22AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Mon, Aug 09, 2021 at 10:12:15AM +0800, Xiaoming Ni wrote:
> > Semaphore is sleeping lock. Add might_sleep() to down*() family
> > (with exception of down_trylock()) to detect atomic context sleep.
> > 
> > Previously discussed with Peter Zijlstra, see link:
> >  https://lore.kernel.org/lkml/20210806082320.GD22037@worktop.programming.kicks-ass.net
> > 
> > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > Acked-by: Will Deacon <will@kernel.org>
> 
> This patch results in the following traceback on all arm64 boots with
> EFI BIOS.
> 
> The problem is only seen with CONFIG_ACPI_PPTT=y, and thus only on arm64.
> 
> Guenter
> 
> ---
> [   14.048540] BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:163
> [   14.048700] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 14, name: cpuhp/0
> [   14.048865] 2 locks held by cpuhp/0/14:
> [   14.048943]  #0: ffff8000125799b0 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x38/0x254
> [   14.049320]  #1: ffff8000125799d8 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x38/0x254
> [   14.049523] irq event stamp: 62
> [   14.049580] hardirqs last  enabled at (61): [<ffff800010269690>] finish_task_switch.isra.0+0xd0/0x2f0
> [   14.049689] hardirqs last disabled at (62): [<ffff800010313ce8>] generic_exec_single+0x138/0x190
> [   14.049785] softirqs last  enabled at (0): [<ffff8000102245d4>] copy_process+0x634/0x1af4
> [   14.049876] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   14.050299] CPU: 0 PID: 14 Comm: cpuhp/0 Not tainted 5.14.0-01100-gb91db6a0b52e #1
> [   14.050452] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> [   14.050694] Call trace:
> [   14.050753]  dump_backtrace+0x0/0x19c
> [   14.050839]  show_stack+0x1c/0x30
> [   14.050892]  dump_stack_lvl+0x9c/0xd8
> [   14.050949]  dump_stack+0x1c/0x38
> [   14.050999]  ___might_sleep+0x154/0x200
> [   14.051053]  __might_sleep+0x54/0x90
> [   14.051106]  down_timeout+0x34/0x90
> [   14.051159]  acpi_os_wait_semaphore+0x68/0x9c
> [   14.051218]  acpi_ut_acquire_mutex+0x50/0xbc
> [   14.051277]  acpi_get_table+0x3c/0xc0
> [   14.051330]  acpi_find_last_cache_level+0x44/0x12c
> [   14.051391]  _init_cache_level+0xd8/0xe4
> [   14.051446]  generic_exec_single+0xf8/0x190
> [   14.051502]  smp_call_function_single+0x174/0x1e0

This is the patch working as intended.. You simply cannot schedule with
interrupts disabled as per the callchain.
