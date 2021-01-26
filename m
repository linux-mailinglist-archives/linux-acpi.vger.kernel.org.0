Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B4C30439A
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 17:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391230AbhAZQSh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 11:18:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:38434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391034AbhAZJ3N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 04:29:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 44A9EB2D0;
        Tue, 26 Jan 2021 09:28:31 +0000 (UTC)
Message-ID: <1611653310.11983.66.camel@suse.cz>
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
Date:   Tue, 26 Jan 2021 10:28:30 +0100
In-Reply-To: <YA6XmO2nuivdpE8M@hirez.programming.kicks-ass.net>
References: <20210122204038.3238-1-ggherdovich@suse.cz>
         <20210122204038.3238-2-ggherdovich@suse.cz>
         <YA6XmO2nuivdpE8M@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2021-01-25 at 11:04 +0100, Peter Zijlstra wrote:
> On Fri, Jan 22, 2021 at 09:40:38PM +0100, Giovanni Gherdovich wrote:
> > This workload is constant in time, so instead of using the PELT sum we can
> > pretend that scale invariance is obtained with
> > 
> >     util_inv = util_raw * freq_curr / freq_max1        [formula-1]
> > 
> > where util_raw is the PELT util from v5.10 (which is to say, not invariant),
> > and util_inv is the PELT util from v5.11-rc4. freq_max1 comes from
> > commit 976df7e5730e ("x86, sched: Use midpoint of max_boost and max_P for
> > frequency invariance on AMD EPYC") and is (P0+max_boost)/2 = (2.25+3.4)/2 =
> > 2.825 GHz.  Then we have the schedutil formula
> > 
> >     freq_next = 1.25 * freq_max2 * util_inv            [formula-2]
> > 
> > Here v5.11-rc4 uses freq_max2 = P0 = 2.25 GHz (and this patch changes it to
> > 3.4 GHz).
> > 
> > Since all cores are busy, there is no boost available. Let's be generous and say
> > the tasks initially get P0, i.e. freq_curr = 2.25 GHz. Combining the formulas
> > above and taking util_raw = 825/1024 = 0.8, freq_next is:
> > 
> >     freq_next = 1.25 * 2.25 * 0.8 * 2.25 / 2.825 = 1.79 GHz
> 
> Right, so here's a 'problem' between schedutil and cpufreq, they don't
> use the same f_max at all times.
> 
> And this is also an inconsistency between acpi_cpufreq and intel_pstate
> (passive). IIRC the intel_pstate cpufreq drivers uses 4C/1C/P0 resp,
> while ACPI seems to stick to P0 f_max.

That's correct. A different f_max is used depending on the occasion. Let me
rephrase with:

cpufreq core asks the driver what's the f_max. What's the answer?

intel_pstate says: 1C
acpi_cpufreq says: P0

scheduler asks the freq-invariance machinery what's f_max, because it needs to
compute f_curr/f_max. What's the answer?

Intel CPUs: 4C in most cases, 1C on Atom, something else on Xeon Phi.
AMD CPUs: (P0 + 1C) / 2.


Legend:
1C = 1-core boost
4C = 4-cores boost
P0 = max non-boost P-States

> 
> Rafael; should ACPI change that behaviour rather than adding yet another
> magic variable?
