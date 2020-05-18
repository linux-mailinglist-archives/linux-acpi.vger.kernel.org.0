Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD84B1D889D
	for <lists+linux-acpi@lfdr.de>; Mon, 18 May 2020 21:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgERT63 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 May 2020 15:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgERT63 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 May 2020 15:58:29 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E7D920758;
        Mon, 18 May 2020 19:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589831909;
        bh=nxo2uyrHnJi5DnLmPJ4mv9Kr35HEpbx7CmvMdiP/OH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gtLLQynTEahJo7NSEd9NHZR7KvmuyM4/0lzVMvnb0+zt8LVUBHow/82N1pU3WpL9P
         4bmTcYRRamBsfRU6+Bnh3o5MHVvMwPojnNIwrvXKv0GCleeS5OswE6zI1zvVftD+4a
         FOaEiwJ0K89WE617Heq5rB2zjU1P0qd/KRsz1bSs=
Date:   Mon, 18 May 2020 12:58:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     James Morse <james.morse@arm.com>, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tyler Baicar <tyler@amperecomputing.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
Subject: Re: [PATCH v2 1/3] mm/memory-failure: Add
 memory_failure_queue_kick()
Message-Id: <20200518125828.e4e3973c743556e976c5ee65@linux-foundation.org>
In-Reply-To: <49686237.p6yG9EJavU@kreacher>
References: <20200501164543.24423-1-james.morse@arm.com>
        <20200501164543.24423-2-james.morse@arm.com>
        <49686237.p6yG9EJavU@kreacher>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 18 May 2020 14:45:05 +0200 "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Friday, May 1, 2020 6:45:41 PM CEST James Morse wrote:
> > The GHES code calls memory_failure_queue() from IRQ context to schedule
> > work on the current CPU so that memory_failure() can sleep.
> > 
> > For synchronous memory errors the arch code needs to know any signals
> > that memory_failure() will trigger are pending before it returns to
> > user-space, possibly when exiting from the IRQ.
> > 
> > Add a helper to kick the memory failure queue, to ensure the scheduled
> > work has happened. This has to be called from process context, so may
> > have been migrated from the original cpu. Pass the cpu the work was
> > queued on.
> > 
> > Change memory_failure_work_func() to permit being called on the 'wrong'
> > cpu.
> > 
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3012,6 +3012,7 @@ enum mf_flags {
> >  };
> >  extern int memory_failure(unsigned long pfn, int flags);
> >  extern void memory_failure_queue(unsigned long pfn, int flags);
> > +extern void memory_failure_queue_kick(int cpu);
> >  extern int unpoison_memory(unsigned long pfn);
> >  extern int get_hwpoison_page(struct page *page);
> >  #define put_hwpoison_page(page)	put_page(page)
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index a96364be8ab4..c4afb407bf0f 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1493,7 +1493,7 @@ static void memory_failure_work_func(struct work_struct *work)
> >  	unsigned long proc_flags;
> >  	int gotten;
> >  
> > -	mf_cpu = this_cpu_ptr(&memory_failure_cpu);
> > +	mf_cpu = container_of(work, struct memory_failure_cpu, work);
> >  	for (;;) {
> >  		spin_lock_irqsave(&mf_cpu->lock, proc_flags);
> >  		gotten = kfifo_get(&mf_cpu->fifo, &entry);
> > @@ -1507,6 +1507,19 @@ static void memory_failure_work_func(struct work_struct *work)
> >  	}
> >  }
> >  
> > +/*
> > + * Process memory_failure work queued on the specified CPU.
> > + * Used to avoid return-to-userspace racing with the memory_failure workqueue.
> > + */
> > +void memory_failure_queue_kick(int cpu)
> > +{
> > +	struct memory_failure_cpu *mf_cpu;
> > +
> > +	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
> > +	cancel_work_sync(&mf_cpu->work);
> > +	memory_failure_work_func(&mf_cpu->work);
> > +}
> > +
> >  static int __init memory_failure_init(void)
> >  {
> >  	struct memory_failure_cpu *mf_cpu;
> > 
> 
> I could apply this provided an ACK from the mm people.
> 

Naoya Horiguchi is the memory-failure.c person.  A review would be
appreciated please?

I'm struggling with it a bit.  memory_failure_queue_kick() should be
called on the cpu which is identified by arg `cpu', yes? 
memory_failure_work_func() appears to assume this.

If that's right then a) why bother passing in the `cpu' arg?  and b)
what keeps this thread pinned to that CPU?  cancel_work_sync() can
schedule.

