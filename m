Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CF230CA6D
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 19:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhBBSsY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 13:48:24 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:35423 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbhBBSqY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 13:46:24 -0500
Received: by mail-ot1-f44.google.com with SMTP id 36so20841214otp.2;
        Tue, 02 Feb 2021 10:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDHKtoa2dINjq91DEdtqJMKEb/4RkQwFTAJadkfEl8c=;
        b=CSAYRo7rCHIc/QIaziQD5x4HirGINdooEaSSrvGk8bGVBZ0avpIL8GrXutc2CggzLk
         foqGTUCwJatUNAwrPOJkVYrtA24sZtnb4Exqw5wCMX/W3ITF9W4RMMp5PJ2cN3vM8iFN
         sY4SqaYKbCo5NPVsoaWR9XJLpznKSatPczMsbdc6QS2Wwp7uU6Q/L49zOd8QRYsTXmGj
         Fthqo/hJli+OJNK9Fw1qTlT3zsqtPFUNBRGVh08KqVmODJ265S6zbbH/WUxF/2A7NGWj
         871PBB7XTjkhCD1FROVtGwtJvpdRt5FUuTAXFDsvfhfXn/iIXx6R5T5xQfssXIYpuskC
         uIBQ==
X-Gm-Message-State: AOAM533qhWSCPRbXUaxTaKIZWEIgox8vWct7iPy7iNkEDbKdeiJJdDuQ
        PQ5biDfZPZMOpPQNxpIVS/cfMgv6yFqzwKftDuI=
X-Google-Smtp-Source: ABdhPJztG9TXX3UAOYTzxJ26ZDs075GiZsbyJMDwBhUdtSuipaQSWuCAle8teE+JM162PHVqUIU9cmb/Z5L1xwldtmo=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr16935376otm.206.1612291542781;
 Tue, 02 Feb 2021 10:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20210122204038.3238-1-ggherdovich@suse.cz> <20210122204038.3238-2-ggherdovich@suse.cz>
 <YA6XmO2nuivdpE8M@hirez.programming.kicks-ass.net> <1611653310.11983.66.camel@suse.cz>
In-Reply-To: <1611653310.11983.66.camel@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Feb 2021 19:45:31 +0100
Message-ID: <CAJZ5v0jbw2X_Wk6We-uYOh9rMCrTTSSb32NFcYaFrtK+bMXMJQ@mail.gmail.com>
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

On Tue, Jan 26, 2021 at 5:19 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
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

OK, I confused the terminology, sorry about that.

> cpufreq core asks the driver what's the f_max. What's the answer?
>
> intel_pstate says: 1C

Yes, unless turbo is disabled, in which case it is P0.

> acpi_cpufreq says: P0

This is P0+1, isn't it?

> scheduler asks the freq-invariance machinery what's f_max, because it needs to
> compute f_curr/f_max. What's the answer?
>
> Intel CPUs: 4C in most cases, 1C on Atom, something else on Xeon Phi.
> AMD CPUs: (P0 + 1C) / 2.
>
>
> Legend:
> 1C = 1-core boost
> 4C = 4-cores boost
> P0 = max non-boost P-States
