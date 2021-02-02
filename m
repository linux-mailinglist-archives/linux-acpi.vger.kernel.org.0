Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC3F30CA35
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 19:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbhBBSmI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 13:42:08 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:39669 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbhBBSlS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 13:41:18 -0500
Received: by mail-oi1-f170.google.com with SMTP id w124so23848954oia.6;
        Tue, 02 Feb 2021 10:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/AvfXPMYMjAkT7JzfZH4VPl/sWjVELm+etlTJV5+nw=;
        b=ZyYitEKU36bTmVn+ADZ+CwI0XEftSPiC3fr4dscoV6W2QdQVnvuBzIr2JH3K0SD4J5
         afVURBKd5nwnYm08YaoGKn067t3xeczUsOp3xkBmpH59DEf3t+1ZL/FeJSUMYI2zO/0y
         oAyiDDqjISSM+xXd0tqpiOTca/x2e2aGxYBWHr463IRoETPRqzPisteNYTcrgp2m2AFR
         WUqvT3ZXJjZq1bH7r/P0kX4hjOseobIkP14fFqx+NXx/INUBoOc0WJj5M2UCTp54IVaD
         tWGli9nqIgTtoGB4rZVuVCN+FAKEyUGPr1r64lCgWA1UEpi9b+cmVvhRycD8dQchlXYc
         WOvw==
X-Gm-Message-State: AOAM530MkFLOAbLiG6ibFdBQzVsMDOLat3brZggEveCDzSBTZh+4KQzD
        YSZMWceX00Wdf1DnDpTIW4+Dc6tddKu1L2R1Sco=
X-Google-Smtp-Source: ABdhPJyG+ciiQbZFkna1Y36UeVhcYp6LH9SYbrLzFsthA2QLc7V3RLwEhpQ266/80I0LEZYa12Qc7U5S+NO6hHMe8Js=
X-Received: by 2002:aca:308a:: with SMTP id w132mr3555948oiw.69.1612291237566;
 Tue, 02 Feb 2021 10:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20210122204038.3238-1-ggherdovich@suse.cz> <20210122204038.3238-2-ggherdovich@suse.cz>
 <YA6XmO2nuivdpE8M@hirez.programming.kicks-ass.net>
In-Reply-To: <YA6XmO2nuivdpE8M@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Feb 2021 19:40:26 +0100
Message-ID: <CAJZ5v0iu9eqhwM58NNfkG5k=d4mQsA9SiRAnajpd7e0+Ub7k1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86,sched: On AMD EPYC set freq_max = max_boost in
 schedutil invariant formula
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
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

On Mon, Jan 25, 2021 at 11:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
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

The only place where 4C is used is the scale invariance code AFAICS.

intel_pstate uses P0 as the f_max unless turbo is disabled.

The difference between intel_pstate and acpi_cpufreq is that (a) the
latter uses a frequency table and the former doesn't and (b) the
latter uses the P0 entry of the frequency table to represent the
entire turbo range,

> Rafael; should ACPI change that behaviour rather than adding yet another
> magic variable?

I'm not sure.  That may change the behavior from what is expected by some users.
