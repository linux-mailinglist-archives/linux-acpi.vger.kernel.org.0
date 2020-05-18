Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2641D78E1
	for <lists+linux-acpi@lfdr.de>; Mon, 18 May 2020 14:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgERMpJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 May 2020 08:45:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65032 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgERMpJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 May 2020 08:45:09 -0400
Received: from 89-64-86-21.dynamic.chello.pl (89.64.86.21) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 49b173e4072387ec; Mon, 18 May 2020 14:45:07 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     James Morse <james.morse@arm.com>
Cc:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tyler Baicar <tyler@amperecomputing.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
Subject: Re: [PATCH v2 1/3] mm/memory-failure: Add memory_failure_queue_kick()
Date:   Mon, 18 May 2020 14:45:05 +0200
Message-ID: <49686237.p6yG9EJavU@kreacher>
In-Reply-To: <20200501164543.24423-2-james.morse@arm.com>
References: <20200501164543.24423-1-james.morse@arm.com> <20200501164543.24423-2-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, May 1, 2020 6:45:41 PM CEST James Morse wrote:
> The GHES code calls memory_failure_queue() from IRQ context to schedule
> work on the current CPU so that memory_failure() can sleep.
> 
> For synchronous memory errors the arch code needs to know any signals
> that memory_failure() will trigger are pending before it returns to
> user-space, possibly when exiting from the IRQ.
> 
> Add a helper to kick the memory failure queue, to ensure the scheduled
> work has happened. This has to be called from process context, so may
> have been migrated from the original cpu. Pass the cpu the work was
> queued on.
> 
> Change memory_failure_work_func() to permit being called on the 'wrong'
> cpu.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Tyler Baicar <baicar@os.amperecomputing.com>
> ---
>  include/linux/mm.h  |  1 +
>  mm/memory-failure.c | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5a323422d783..c606dbbfa5e1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3012,6 +3012,7 @@ enum mf_flags {
>  };
>  extern int memory_failure(unsigned long pfn, int flags);
>  extern void memory_failure_queue(unsigned long pfn, int flags);
> +extern void memory_failure_queue_kick(int cpu);
>  extern int unpoison_memory(unsigned long pfn);
>  extern int get_hwpoison_page(struct page *page);
>  #define put_hwpoison_page(page)	put_page(page)
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a96364be8ab4..c4afb407bf0f 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1493,7 +1493,7 @@ static void memory_failure_work_func(struct work_struct *work)
>  	unsigned long proc_flags;
>  	int gotten;
>  
> -	mf_cpu = this_cpu_ptr(&memory_failure_cpu);
> +	mf_cpu = container_of(work, struct memory_failure_cpu, work);
>  	for (;;) {
>  		spin_lock_irqsave(&mf_cpu->lock, proc_flags);
>  		gotten = kfifo_get(&mf_cpu->fifo, &entry);
> @@ -1507,6 +1507,19 @@ static void memory_failure_work_func(struct work_struct *work)
>  	}
>  }
>  
> +/*
> + * Process memory_failure work queued on the specified CPU.
> + * Used to avoid return-to-userspace racing with the memory_failure workqueue.
> + */
> +void memory_failure_queue_kick(int cpu)
> +{
> +	struct memory_failure_cpu *mf_cpu;
> +
> +	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
> +	cancel_work_sync(&mf_cpu->work);
> +	memory_failure_work_func(&mf_cpu->work);
> +}
> +
>  static int __init memory_failure_init(void)
>  {
>  	struct memory_failure_cpu *mf_cpu;
> 

I could apply this provided an ACK from the mm people.

Thanks!



