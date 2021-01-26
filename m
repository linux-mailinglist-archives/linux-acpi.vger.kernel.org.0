Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1853039CF
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 11:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391901AbhAZKGx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 05:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391307AbhAZKGk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2021 05:06:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88CEC06174A;
        Tue, 26 Jan 2021 02:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+kPzGNU12fuOGcg8WL76MmT72as1QhBaLqRMdjDE51Y=; b=pvezCzoH/WtrAlLIICs0RpSpiD
        3GvaMlQdberOS3T537LcfBj+Kx/F0aAzYm1A7eD0bSnLoP+q8FAZNLreZyzgpc5xdoaDW3+VVpR/R
        xd5pxE/iMaoqcVwWLqTUEMlv+ShJuvynxy2g57RCqc3Uj03pFYRtIYlHdgB/zifVZAgN6faDwqE7I
        Vsot7u6rUQzhqTpyO4GAwTdzEB3v7469gtQRxoUSY9FdmLY3w00ixx7CvhyLt0fSXC5WW8gRSsNHI
        AxmlzYeJJTvuOL3S9vTQqY7fBIXlGY497Y+1tSWn9o+DJXuAqPVQwox+ACM1DLvxMKGwNFM29XOZ7
        +phTkUng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4LBP-005P2b-59; Tue, 26 Jan 2021 10:03:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B1C0E3010C8;
        Tue, 26 Jan 2021 11:02:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EC79209C50F3; Tue, 26 Jan 2021 11:02:45 +0100 (CET)
Date:   Tue, 26 Jan 2021 11:02:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
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
Subject: Re: [PATCH v2 1/1] x86,sched: On AMD EPYC set freq_max = max_boost
 in schedutil invariant formula
Message-ID: <YA/oxTTLVohtCBzk@hirez.programming.kicks-ass.net>
References: <20210122204038.3238-1-ggherdovich@suse.cz>
 <20210122204038.3238-2-ggherdovich@suse.cz>
 <YA6XmO2nuivdpE8M@hirez.programming.kicks-ass.net>
 <1611653310.11983.66.camel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611653310.11983.66.camel@suse.cz>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 10:28:30AM +0100, Giovanni Gherdovich wrote:
> On Mon, 2021-01-25 at 11:04 +0100, Peter Zijlstra wrote:
> > On Fri, Jan 22, 2021 at 09:40:38PM +0100, Giovanni Gherdovich wrote:
> > > This workload is constant in time, so instead of using the PELT sum we can
> > > pretend that scale invariance is obtained with
> > > 
> > >     util_inv = util_raw * freq_curr / freq_max1        [formula-1]
> > > 
> > > where util_raw is the PELT util from v5.10 (which is to say, not invariant),
> > > and util_inv is the PELT util from v5.11-rc4. freq_max1 comes from
> > > commit 976df7e5730e ("x86, sched: Use midpoint of max_boost and max_P for
> > > frequency invariance on AMD EPYC") and is (P0+max_boost)/2 = (2.25+3.4)/2 =
> > > 2.825 GHz.  Then we have the schedutil formula
> > > 
> > >     freq_next = 1.25 * freq_max2 * util_inv            [formula-2]
> > > 
> > > Here v5.11-rc4 uses freq_max2 = P0 = 2.25 GHz (and this patch changes it to
> > > 3.4 GHz).
> > > 
> > > Since all cores are busy, there is no boost available. Let's be generous and say
> > > the tasks initially get P0, i.e. freq_curr = 2.25 GHz. Combining the formulas
> > > above and taking util_raw = 825/1024 = 0.8, freq_next is:
> > > 
> > >     freq_next = 1.25 * 2.25 * 0.8 * 2.25 / 2.825 = 1.79 GHz
> > 
> > Right, so here's a 'problem' between schedutil and cpufreq, they don't
> > use the same f_max at all times.
> > 
> > And this is also an inconsistency between acpi_cpufreq and intel_pstate
> > (passive). IIRC the intel_pstate cpufreq drivers uses 4C/1C/P0 resp,
> > while ACPI seems to stick to P0 f_max.
> 
> That's correct. A different f_max is used depending on the occasion. Let me
> rephrase with:
> 
> cpufreq core asks the driver what's the f_max. What's the answer?
> 
> intel_pstate says: 1C

Oh indeed it does...

> acpi_cpufreq says: P0
> 
> scheduler asks the freq-invariance machinery what's f_max, because it needs to
> compute f_curr/f_max. What's the answer?
> 
> Intel CPUs: 4C in most cases, 1C on Atom, something else on Xeon Phi.
> AMD CPUs: (P0 + 1C) / 2.

Right, and thwn freq-invariance uses larger f_max than cpufreq uses for
frequency selection, we under select exactly like you found.
