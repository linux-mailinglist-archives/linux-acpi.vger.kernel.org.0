Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B1B30393D
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 10:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbhAZJmX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 04:42:23 -0500
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:46137 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391392AbhAZJkT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 04:40:19 -0500
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jan 2021 04:40:17 EST
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id A619CFAC5D
        for <linux-acpi@vger.kernel.org>; Tue, 26 Jan 2021 09:31:42 +0000 (GMT)
Received: (qmail 27702 invoked from network); 26 Jan 2021 09:31:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Jan 2021 09:31:42 -0000
Date:   Tue, 26 Jan 2021 09:31:40 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Larabel <Michael@phoronix.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86,sched: On AMD EPYC set freq_max = max_boost
 in schedutil invariant formula
Message-ID: <20210126093140.GB3592@techsingularity.net>
References: <20210122204038.3238-1-ggherdovich@suse.cz>
 <20210122204038.3238-2-ggherdovich@suse.cz>
 <YA6YEK4/rjtPLdkG@hirez.programming.kicks-ass.net>
 <1611652167.11983.65.camel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1611652167.11983.65.camel@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 10:09:27AM +0100, Giovanni Gherdovich wrote:
> On Mon, 2021-01-25 at 11:06 +0100, Peter Zijlstra wrote:
> > On Fri, Jan 22, 2021 at 09:40:38PM +0100, Giovanni Gherdovich wrote:
> > > 1. PROBLEM DESCRIPTION (over-utilization and schedutil)
> > > 
> > > The problem happens on CPU-bound workloads spanning a large number of cores.
> > > In this case schedutil won't select the maximum P-State. Actually, it's
> > > likely that it will select the minimum one.
> > > 
> > > A CPU-bound workload puts the machine in a state generally called
> > > "over-utilization": an increase in CPU speed doesn't result in an increase of
> > > capacity. The fraction of time tasks spend on CPU becomes constant regardless
> > > of clock frequency (the tasks eat whatever we throw at them), and the PELT
> > > invariant util goes up and down with the frequency (i.e. it's not invariant
> > > anymore).
> > >                                       v5.10          v5.11-rc4
> > >                                       ~~~~~~~~~~~~~~~~~~~~~~~~
> > > CPU activity (mpstat)                 80-90%         80-90%
> > > schedutil requests (tracepoint)       always P0      mostly P2
> > > CPU frequency (HW feedback)           ~2.2 GHz       ~1.5 GHz
> > > PELT root rq util (tracepoint)        ~825           ~450
> > > 
> > > mpstat shows that the workload is CPU-bound and usage doesn't change with
> > 
> > So I'm having trouble with calling a 80%-90% workload CPU bound, because
> > clearly there's a ton of idle time.
> 
> Yes you're right. There is considerable idle time and calling it CPU-bound is
> a bit of a stretch.
> 
> Yet I don't think I'm completely off the mark. The busy time is the same with
> the machine running at 1.5 GHz and at 2.2 GHz (it just takes longer to
> finish). To me it seems like the CPU is the bottleneck, with some overhead on
> top.
> 

I think this is an important observation because while the load may not
be fully CPU-bound, it's still at the point where race-to-idle by running
at a higher frequency is relevant. During the busy time, the results
(and Michael's testing) indicate that the higher frequency may still be
justified. I agree that there is a "a 'problem' between schedutil and
cpufreq, they don't use the same f_max at all times", fixing that mid
-rc may not be appropriate because it's a big change in an rc window.

So, should this patch be merged for 5.11 as a stopgap, fix up
schedutil/cpufreq and then test both AMD and Intel chips reporting the
correct max non-turbo and max-turbo frequencies? That would give time to
give some testing in linux-next before merging to reduce the chance
something else falls out.

-- 
Mel Gorman
SUSE Labs
