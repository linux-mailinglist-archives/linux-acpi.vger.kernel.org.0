Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEFA30CB2E
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 20:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbhBBTPY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 14:15:24 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:42498 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbhBBTL5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 14:11:57 -0500
Received: by mail-oo1-f49.google.com with SMTP id g46so5392268ooi.9;
        Tue, 02 Feb 2021 11:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+JeHbdnuibuIZ2G2YzY3S3qg4y03usyq52pjaAExoU=;
        b=ZRXcLPcgRJJuTU7VZ8dNQ+a7S0N3HnD/QoSoQ87p1iwT6yzRGceiuBwd3Pgota3z/F
         wkxq8AXwE4Oht4lTY8dykFd2/KMzqefI+YVbG3OmTjtdUoTyszB3uET8Ns/b8UXFIo39
         v0pIbbtO0CeHz2iCmcRzC0WLnZwSRA3372aBgOx6j5ku0NLrdFdKIcRMFLJbkTyiJ+/r
         n06PmQ7XtZmp1jc+YM+z7vIFHJJohA42pF5xoJ6vPaFeh10bCNI9ltKtYjfYkoBy9KBu
         Gr6LWlhT3o5fgMwaUQZLsx/pIzRhUM0hBfgJOGuNRHLutwhG7FVTy01gXF4WbM9p6pkS
         flVw==
X-Gm-Message-State: AOAM531IrhGSqg4A4RxwaOsnDGL+4I9WfWJ0KbGT58zp7ngXMCoM3f3o
        H2QzOC9saIP3BIqoFuIT9GwOk3qoks3ANKfHjZU=
X-Google-Smtp-Source: ABdhPJyLaZZRwY28907pmLAm8002cpnYdYQvPuZutHipRCL1iyD+TzWwEHBGjYKf5+Zhu3Rd7G5GusMhYX/l9cSSUSw=
X-Received: by 2002:a4a:9873:: with SMTP id z48mr16639097ooi.44.1612293075062;
 Tue, 02 Feb 2021 11:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20210122204038.3238-1-ggherdovich@suse.cz> <20210122204038.3238-2-ggherdovich@suse.cz>
 <YA6XmO2nuivdpE8M@hirez.programming.kicks-ass.net> <1611653310.11983.66.camel@suse.cz>
 <CAJZ5v0jbw2X_Wk6We-uYOh9rMCrTTSSb32NFcYaFrtK+bMXMJQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jbw2X_Wk6We-uYOh9rMCrTTSSb32NFcYaFrtK+bMXMJQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Feb 2021 20:11:04 +0100
Message-ID: <CAJZ5v0icG4V5o8p1fAQY1Ne2vCe0CBq2YfSajSxkCE3VbuY_Ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86,sched: On AMD EPYC set freq_max = max_boost in
 schedutil invariant formula
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
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Larabel <Michael@phoronix.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 2, 2021 at 7:45 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jan 26, 2021 at 5:19 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
> >
> > On Mon, 2021-01-25 at 11:04 +0100, Peter Zijlstra wrote:
> > > On Fri, Jan 22, 2021 at 09:40:38PM +0100, Giovanni Gherdovich wrote:
> > > > This workload is constant in time, so instead of using the PELT sum we can
> > > > pretend that scale invariance is obtained with
> > > >
> > > >     util_inv = util_raw * freq_curr / freq_max1        [formula-1]
> > > >
> > > > where util_raw is the PELT util from v5.10 (which is to say, not invariant),
> > > > and util_inv is the PELT util from v5.11-rc4. freq_max1 comes from
> > > > commit 976df7e5730e ("x86, sched: Use midpoint of max_boost and max_P for
> > > > frequency invariance on AMD EPYC") and is (P0+max_boost)/2 = (2.25+3.4)/2 =
> > > > 2.825 GHz.  Then we have the schedutil formula
> > > >
> > > >     freq_next = 1.25 * freq_max2 * util_inv            [formula-2]
> > > >
> > > > Here v5.11-rc4 uses freq_max2 = P0 = 2.25 GHz (and this patch changes it to
> > > > 3.4 GHz).
> > > >
> > > > Since all cores are busy, there is no boost available. Let's be generous and say
> > > > the tasks initially get P0, i.e. freq_curr = 2.25 GHz. Combining the formulas
> > > > above and taking util_raw = 825/1024 = 0.8, freq_next is:
> > > >
> > > >     freq_next = 1.25 * 2.25 * 0.8 * 2.25 / 2.825 = 1.79 GHz
> > >
> > > Right, so here's a 'problem' between schedutil and cpufreq, they don't
> > > use the same f_max at all times.
> > >
> > > And this is also an inconsistency between acpi_cpufreq and intel_pstate
> > > (passive). IIRC the intel_pstate cpufreq drivers uses 4C/1C/P0 resp,
> > > while ACPI seems to stick to P0 f_max.
> >
> > That's correct. A different f_max is used depending on the occasion. Let me
> > rephrase with:
>
> OK, I confused the terminology, sorry about that.
>
> > cpufreq core asks the driver what's the f_max. What's the answer?
> >
> > intel_pstate says: 1C
>
> Yes, unless turbo is disabled, in which case it is P0.

BTW, and that actually is quite important, the max_freq reported by
intel_pstate doesn't matter for schedutil after the new ->adjust_perf
callback has been added, because that doesn't even use the frequency.

So, as a long-term remedy, it may just be better to implement
->adjust_perf in acpi_cpufreq().

Again, I'm terribly sorry for missing this thread and the patch.

> > acpi_cpufreq says: P0
>
> This is P0+1, isn't it?
>
> > scheduler asks the freq-invariance machinery what's f_max, because it needs to
> > compute f_curr/f_max. What's the answer?
> >
> > Intel CPUs: 4C in most cases, 1C on Atom, something else on Xeon Phi.
> > AMD CPUs: (P0 + 1C) / 2.
> >
> >
> > Legend:
> > 1C = 1-core boost
> > 4C = 4-cores boost
> > P0 = max non-boost P-States
