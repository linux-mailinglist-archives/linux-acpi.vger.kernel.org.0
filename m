Return-Path: <linux-acpi+bounces-354-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268FD7B6676
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 12:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C8F542816E4
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 10:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2555208AC
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 10:33:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5D46A8
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 08:39:38 +0000 (UTC)
X-Greylist: delayed 611 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 01:39:32 PDT
Received: from out-196.mta0.migadu.com (out-196.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBDDE1
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 01:39:31 -0700 (PDT)
Date: Tue, 3 Oct 2023 17:28:58 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696321756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SvHEdL127DkwY1o1/aHJZdaismZDLKyIFOf23kZMKII=;
	b=SnZnaakkCBrskHWe8xJL1L5kXJ04u9tThP9M8iKTR/CDUx+XLVjReoLcedlF6WCxvIyGD6
	OhdcyIniVLeOQ4Kzd3U+6O26XoRzrW7252N8bpgQy1lQ/Hvcody5jaKDq/8yQ6j4TdM4hz
	ijfc3ipmQGWFZBIAd/Eq8b9RfxVpS2E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
	mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
	naoya.horiguchi@nec.com, james.morse@arm.com,
	gregkh@linuxfoundation.org, will@kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-edac@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
	stable@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
	ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com, bp@alien8.de, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, jarkko@kernel.org,
	lenb@kernel.org, hpa@zytor.com, robert.moore@intel.com,
	lvying6@huawei.com, xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: Re: [RESEND PATCH v8 2/2] ACPI: APEI: handle synchronous exceptions
 in task work
Message-ID: <20231003082858.GA750796@ik1-406-35019.vs.sakura.ne.jp>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230919022127.69732-3-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919022127.69732-3-xueshuai@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 10:21:27AM +0800, Shuai Xue wrote:
> Hardware errors could be signaled by synchronous interrupt, e.g.  when an
> error is detected by a background scrubber, or signaled by synchronous
> exception, e.g. when an uncorrected error is consumed. Both synchronous and
> asynchronous error are queued and handled by a dedicated kthread in
> workqueue.
> 
> commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for
> synchronous errors") keep track of whether memory_failure() work was
> queued, and make task_work pending to flush out the workqueue so that the
> work for synchronous error is processed before returning to user-space.
> The trick ensures that the corrupted page is unmapped and poisoned. And
> after returning to user-space, the task starts at current instruction which
> triggering a page fault in which kernel will send SIGBUS to current process
> due to VM_FAULT_HWPOISON.
> 
> However, the memory failure recovery for hwpoison-aware mechanisms does not
> work as expected. For example, hwpoison-aware user-space processes like
> QEMU register their customized SIGBUS handler and enable early kill mode by
> seting PF_MCE_EARLY at initialization. Then the kernel will directy notify
> the process by sending a SIGBUS signal in memory failure with wrong
> si_code: the actual user-space process accessing the corrupt memory
> location, but its memory failure work is handled in a kthread context, so
> it will send SIGBUS with BUS_MCEERR_AO si_code to the actual user-space
> process instead of BUS_MCEERR_AR in kill_proc().
> 
> To this end, separate synchronous and asynchronous error handling into
> different paths like X86 platform does:
> 
> - valid synchronous errors: queue a task_work to synchronously send SIGBUS
>   before ret_to_user.
> - valid asynchronous errors: queue a work into workqueue to asynchronously
>   handle memory failure.
> - abnormal branches such as invalid PA, unexpected severity, no memory
>   failure config support, invalid GUID section, OOM, etc.
> 
> Then for valid synchronous errors, the current context in memory failure is
> exactly belongs to the task consuming poison data and it will send SIBBUS
> with proper si_code.
> 
> Fixes: 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for synchronous errors")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c |  9 +---
>  drivers/acpi/apei/ghes.c       | 84 +++++++++++++++++++++-------------
>  include/acpi/ghes.h            |  3 --
>  mm/memory-failure.c            | 17 ++-----
>  4 files changed, 56 insertions(+), 57 deletions(-)
> 
...

> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 4d6e43c88489..80e1ea1cc56d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2163,7 +2163,9 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>   *
>   * Return: 0 for successfully handled the memory error,
>   *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
> - *         < 0(except -EOPNOTSUPP) on failure.
> + *         -EHWPOISON for already sent SIGBUS to the current process with
> + *         the proper error info,

The meaning of this comment is understood, but the sentence seems to be
a little too long. Could you sort this out with bullet points (like below)?

 * Return values:
 *   0             - success
 *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event.
 *   -EHWPOISON    - sent SIGBUS to the current process with the proper
 *                   error info by kill_accessing_process().
 *   other negative values - failure

> + *         other negative error code on failure.
>   */
>  int memory_failure(unsigned long pfn, int flags)
>  {
> @@ -2445,19 +2447,6 @@ static void memory_failure_work_func(struct work_struct *work)
>  	}
>  }
>  
> -/*
> - * Process memory_failure work queued on the specified CPU.
> - * Used to avoid return-to-userspace racing with the memory_failure workqueue.
> - */
> -void memory_failure_queue_kick(int cpu)
> -{
> -	struct memory_failure_cpu *mf_cpu;
> -
> -	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
> -	cancel_work_sync(&mf_cpu->work);
> -	memory_failure_work_func(&mf_cpu->work);
> -}
> -

The declaration of memory_failure_queue_kick() still remains in include/linux/mm.h,
so you can remove it together.

Thanks,
Naoya Horiguchi

