Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB223046FA
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 19:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbhAZRRs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 12:17:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:48038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390906AbhAZJKO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 04:10:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57DE5B254;
        Tue, 26 Jan 2021 09:09:28 +0000 (UTC)
Message-ID: <1611652167.11983.65.camel@suse.cz>
Subject: Re: [PATCH v2 1/1] x86,sched: On AMD EPYC set freq_max = max_boost
 in schedutil invariant formula
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Larabel <Michael@phoronix.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Tue, 26 Jan 2021 10:09:27 +0100
In-Reply-To: <YA6YEK4/rjtPLdkG@hirez.programming.kicks-ass.net>
References: <20210122204038.3238-1-ggherdovich@suse.cz>
         <20210122204038.3238-2-ggherdovich@suse.cz>
         <YA6YEK4/rjtPLdkG@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2021-01-25 at 11:06 +0100, Peter Zijlstra wrote:
> On Fri, Jan 22, 2021 at 09:40:38PM +0100, Giovanni Gherdovich wrote:
> > 1. PROBLEM DESCRIPTION (over-utilization and schedutil)
> > 
> > The problem happens on CPU-bound workloads spanning a large number of cores.
> > In this case schedutil won't select the maximum P-State. Actually, it's
> > likely that it will select the minimum one.
> > 
> > A CPU-bound workload puts the machine in a state generally called
> > "over-utilization": an increase in CPU speed doesn't result in an increase of
> > capacity. The fraction of time tasks spend on CPU becomes constant regardless
> > of clock frequency (the tasks eat whatever we throw at them), and the PELT
> > invariant util goes up and down with the frequency (i.e. it's not invariant
> > anymore).
> >                                       v5.10          v5.11-rc4
> >                                       ~~~~~~~~~~~~~~~~~~~~~~~~
> > CPU activity (mpstat)                 80-90%         80-90%
> > schedutil requests (tracepoint)       always P0      mostly P2
> > CPU frequency (HW feedback)           ~2.2 GHz       ~1.5 GHz
> > PELT root rq util (tracepoint)        ~825           ~450
> > 
> > mpstat shows that the workload is CPU-bound and usage doesn't change with
> 
> So I'm having trouble with calling a 80%-90% workload CPU bound, because
> clearly there's a ton of idle time.

Yes you're right. There is considerable idle time and calling it CPU-bound is
a bit of a stretch.

Yet I don't think I'm completely off the mark. The busy time is the same with
the machine running at 1.5 GHz and at 2.2 GHz (it just takes longer to
finish). To me it seems like the CPU is the bottleneck, with some overhead on
top.

I will confirm what causes the idle time.


Giovanni
