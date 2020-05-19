Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9482C1D9E43
	for <lists+linux-acpi@lfdr.de>; Tue, 19 May 2020 19:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgESRyJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 19 May 2020 13:54:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39216 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESRyJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2020 13:54:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id s198so515183oie.6
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2020 10:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oLkdDiI5HFWL8C7O6W36h9N6UH3412FNuY/4J1ySuKI=;
        b=BIxbhrzNLd98yodnnR2h8w+FvaTDdJtBN9sB6cQamRDo5XKWqvledas++CSeLvGdlp
         pGeHjBoydD6emDPG65uTfOQfZg557Q5ySQpbYY3MSG8PdTTLA1yPxKx9ReATDfF9JdiF
         2qbKpLWwqPw+m1rfth3yMWpbMQ2wRcTAs58HPPVXiWyJoamq5WOOeksf82H94raRSa+R
         Z4FUouzbFGK+N2tqs/j5rPkPAfVc/kTMe0Qo99HxdW/0Y6IupJn9yaNCtT/77MALseM3
         djxfNio0+VtgD7RVAGZjsx75f2vVbuvM3+gLyfTwIXaHTci10ajVp6sfrdYpsWu1avoH
         zFUw==
X-Gm-Message-State: AOAM533sGt0CI3Tcham02cYsBubz4v4Tvv6PL+htT1zXuau2Z0e29pf5
        CViZMZaq3Dpzd6wMZdAlVcmSed6Nt0M++PBhcHM=
X-Google-Smtp-Source: ABdhPJyQZS1Xr8gnb53yM7SiKuoBHfAVWDm0sXFCpKkYsNKzAITxSaP4lvBa4TN4o5V50bKrrF/ZMaRIevhXPrGZPZs=
X-Received: by 2002:aca:4254:: with SMTP id p81mr454025oia.68.1589910847813;
 Tue, 19 May 2020 10:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200501164543.24423-1-james.morse@arm.com> <20200501164543.24423-2-james.morse@arm.com>
 <49686237.p6yG9EJavU@kreacher> <20200518125828.e4e3973c743556e976c5ee65@linux-foundation.org>
 <20200519031511.GA31023@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20200519031511.GA31023@hori.linux.bs1.fc.nec.co.jp>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 May 2020 19:53:56 +0200
Message-ID: <CAJZ5v0g0295WMiNUzwnJE+SuCrEt2FOCor5QNdUFEyfv3pTpcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm/memory-failure: Add memory_failure_queue_kick()
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, James Morse <james.morse@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tyler Baicar <tyler@amperecomputing.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 19, 2020 at 5:15 AM HORIGUCHI NAOYA(堀口　直也)
<naoya.horiguchi@nec.com> wrote:
>
> On Mon, May 18, 2020 at 12:58:28PM -0700, Andrew Morton wrote:
> > On Mon, 18 May 2020 14:45:05 +0200 "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> >
> > > On Friday, May 1, 2020 6:45:41 PM CEST James Morse wrote:
> > > > The GHES code calls memory_failure_queue() from IRQ context to schedule
> > > > work on the current CPU so that memory_failure() can sleep.
> > > >
> > > > For synchronous memory errors the arch code needs to know any signals
> > > > that memory_failure() will trigger are pending before it returns to
> > > > user-space, possibly when exiting from the IRQ.
> > > >
> > > > Add a helper to kick the memory failure queue, to ensure the scheduled
> > > > work has happened. This has to be called from process context, so may
> > > > have been migrated from the original cpu. Pass the cpu the work was
> > > > queued on.
> > > >
> > > > Change memory_failure_work_func() to permit being called on the 'wrong'
> > > > cpu.
> > > >
> > > > --- a/include/linux/mm.h
> > > > +++ b/include/linux/mm.h
> > > > @@ -3012,6 +3012,7 @@ enum mf_flags {
> > > >  };
> > > >  extern int memory_failure(unsigned long pfn, int flags);
> > > >  extern void memory_failure_queue(unsigned long pfn, int flags);
> > > > +extern void memory_failure_queue_kick(int cpu);
> > > >  extern int unpoison_memory(unsigned long pfn);
> > > >  extern int get_hwpoison_page(struct page *page);
> > > >  #define put_hwpoison_page(page)  put_page(page)
> > > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > > index a96364be8ab4..c4afb407bf0f 100644
> > > > --- a/mm/memory-failure.c
> > > > +++ b/mm/memory-failure.c
> > > > @@ -1493,7 +1493,7 @@ static void memory_failure_work_func(struct work_struct *work)
> > > >   unsigned long proc_flags;
> > > >   int gotten;
> > > >
> > > > - mf_cpu = this_cpu_ptr(&memory_failure_cpu);
> > > > + mf_cpu = container_of(work, struct memory_failure_cpu, work);
> > > >   for (;;) {
> > > >           spin_lock_irqsave(&mf_cpu->lock, proc_flags);
> > > >           gotten = kfifo_get(&mf_cpu->fifo, &entry);
> > > > @@ -1507,6 +1507,19 @@ static void memory_failure_work_func(struct work_struct *work)
> > > >   }
> > > >  }
> > > >
> > > > +/*
> > > > + * Process memory_failure work queued on the specified CPU.
> > > > + * Used to avoid return-to-userspace racing with the memory_failure workqueue.
> > > > + */
> > > > +void memory_failure_queue_kick(int cpu)
> > > > +{
> > > > + struct memory_failure_cpu *mf_cpu;
> > > > +
> > > > + mf_cpu = &per_cpu(memory_failure_cpu, cpu);
> > > > + cancel_work_sync(&mf_cpu->work);
> > > > + memory_failure_work_func(&mf_cpu->work);
> > > > +}
> > > > +
> > > >  static int __init memory_failure_init(void)
> > > >  {
> > > >   struct memory_failure_cpu *mf_cpu;
> > > >
> > >
> > > I could apply this provided an ACK from the mm people.
> > >
> >
> > Naoya Horiguchi is the memory-failure.c person.  A review would be
> > appreciated please?
> >
> > I'm struggling with it a bit.  memory_failure_queue_kick() should be
> > called on the cpu which is identified by arg `cpu', yes?
> > memory_failure_work_func() appears to assume this.
> >
> > If that's right then a) why bother passing in the `cpu' arg?  and b)
> > what keeps this thread pinned to that CPU?  cancel_work_sync() can
> > schedule.
>
> If I read correctly, memory_failure work is queue on the CPU on which the
> user process ran when it touched the corrupted memory, and the process can
> be scheduled on another CPU when the kernel returned back to userspace after
> handling the GHES event.  So we need to remember where the memory_failure
> event is queued to flush proper work queue.  So I feel that this properly
> implements it.
>
> Considering the effect to the other caller, currently memory_failure_queue()
> has 2 callers, ghes_handle_memory_failure() and cec_add_elem(). The former
> is what we try to change now.  And the latter is to execute soft offline
> (which is related to corrected non-fatal errors), so that's not affected by
> the reported issue.  So I don't think that this change breaks the other
> caller.
>
> So I'm fine with the suggested change.
>
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

OK, thanks!

So because patch [1/3] has been ACKed already, I'm applying this
series as 5.8 material.

Thanks everyone!
