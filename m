Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB118310A8B
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Feb 2021 12:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhBELp5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Feb 2021 06:45:57 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:45047 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhBELnv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Feb 2021 06:43:51 -0500
Received: by mail-ot1-f51.google.com with SMTP id e70so6547132ote.11;
        Fri, 05 Feb 2021 03:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JK9EvzwCGVkhzGsBky37d3E67X7MSmxNhi8zC0kctg=;
        b=EqwA+bQVfbQ1Vjy2xv1BKIkq+4Um+UKqYgVjdqNRmxC3f5hrW7G75qUuJoJ8XEPYy+
         Ft0k2jDfZgNshf+ITRWe2B/0z2fZQ2TDecLtb3Pg9yUf0pjq2T/5tsJYm2LqjXCAgcZA
         1d5hgfOnmveGtnerdEMn3Fvr7ukQmoYA2WbgMDWjtgonMbszXnOehSLX+T+d0mLLmsNT
         4lI0XEIl8t1zQYyWjBRpEMaTGzXWWkIjgNC5JVuZnoCPgj83vsHRBnzbPArO1+6/UnNA
         vl5kOmEjP7ex1zmpX7mYjne7glbh8TwVbPGGpBfb4L8tVtkn9mkgna4Q/hpBR2Mv3m5X
         jZmQ==
X-Gm-Message-State: AOAM532Ovgp3lqoXWEeUoEG9/N4B5bBcM87iOJ/5PMKOTRhChgFYH/i0
        8EHLz7dWOEyL9Ha7rCvXR1gkTW00ADKUX9m4/PTVKLfc
X-Google-Smtp-Source: ABdhPJzxU4fb4+bXZOBixLBr5XidttCHwnfqElpywxHt2jb2tJoOaszmTB8MJmCPSpz2kg57Opgr7Zdojuid3/rxZtI=
X-Received: by 2002:a9d:6acf:: with SMTP id m15mr3080068otq.260.1612525389212;
 Fri, 05 Feb 2021 03:43:09 -0800 (PST)
MIME-Version: 1.0
References: <20210203135321.12253-1-ggherdovich@suse.cz> <20210203135321.12253-2-ggherdovich@suse.cz>
 <CAJZ5v0g1SWRnV1QfZG3o+hvBg9akakhDMomGCFjwERyG2ENKww@mail.gmail.com>
 <5470319.60Xv9dOaFs@kreacher> <563fec57-6417-e875-1788-3773cbfb34be@phoronix.com>
 <CAJZ5v0jzhVJ-8iVfhkFHBdJf1pYAMtC=1JhuTn14vWtZUwJoAg@mail.gmail.com> <5ea06dbe-255c-3d22-b9bd-6e627c5f94af@phoronix.com>
In-Reply-To: <5ea06dbe-255c-3d22-b9bd-6e627c5f94af@phoronix.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Feb 2021 12:42:54 +0100
Message-ID: <CAJZ5v0gM3mUigM+e9YuAPbQiPYP-UkhKfc0otsxWKQhYVf4Vdw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] x86,sched: On AMD EPYC set freq_max = max_boost in
 schedutil invariant formula
To:     Michael Larabel <Michael@phoronix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 5, 2021 at 12:04 AM Michael Larabel <Michael@phoronix.com> wrote:
>
> On 2/4/21 7:40 AM, Rafael J. Wysocki wrote:
> > On Thu, Feb 4, 2021 at 12:36 AM Michael Larabel <Michael@phoronix.com> wrote:
> >> On 2/3/21 12:25 PM, Rafael J. Wysocki wrote:
> >>> On Wednesday, February 3, 2021 3:11:37 PM CET Rafael J. Wysocki wrote:
> >>>> On Wed, Feb 3, 2021 at 2:53 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
> >>>> [cut]
> >>>>
> >>>>> Fixes: 41ea667227ba ("x86, sched: Calculate frequency invariance for AMD systems")
> >>>>> Fixes: 976df7e5730e ("x86, sched: Use midpoint of max_boost and max_P for frequency invariance on AMD EPYC")
> >>>>> Reported-by: Michael Larabel <Michael@phoronix.com>
> >>>>> Tested-by: Michael Larabel <Michael@phoronix.com>
> >>>>> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> >>>>> ---
> >>>>>    drivers/cpufreq/acpi-cpufreq.c   | 61 ++++++++++++++++++++++++++++++--
> >>>>>    drivers/cpufreq/cpufreq.c        |  3 ++
> >>>>>    include/linux/cpufreq.h          |  5 +++
> >>>>>    kernel/sched/cpufreq_schedutil.c |  8 +++--
> >>>> I don't really think that it is necessary to modify schedutil to
> >>>> address this issue.
> >>> So below is a prototype of an alternative fix for the issue at hand.
> >>>
> >>> I can't really test it here, because there's no _CPC in the ACPI tables of my
> >>> test machines, so testing it would be appreciated.  However, AFAICS these
> >>> machines are affected by the performance issue related to the scale-invariance
> >>> when they are running acpi-cpufreq, so what we are doing here is not entirely
> >>> sufficient.
> >>
> >> I have benchmarks running on several Ryzen and EPYC systems with this
> >> patch. The full batch of tests won't be done until tomorrow, but in
> >> looking at the data so far from an AMD EPYC 7F72 2P server over the past
> >> few hours, this patch does provide fairly comparable numbers to
> >> Giovanni's patch. There were a few outliers so far but waiting to see
> >> with the complete set of results. At the very least it's clear enough
> >> already this new patch is at least an improvement over the current 5.11
> >> upstream state with schedutil on AMD.
> > Thanks for the feedback, much appreciated!
> >
> > Let me submit the patch properly, then.
>
>
> Everything continues looking good in running this patch on a variety of
> AMD Zen2/Zen3 systems.
>
> As Giovanni has been focusing on EPYC testing, I have been running
> several Ryzen laptops/desktop for more exposure and there it's looking
> very good. On a Ryzen 9 5900X[1] when looking at this latest patch
> against current 5.11 Git and 5.10, the performance is recovered and in
> some cases better off now than 5.10 with Schedutil. No anomalies there
> and with other Zen 2/3 desktops and Zen 2 notebook the performance
> relative to 5.10 is comparable or in some cases better while all
> indications point to the 5.11 regression being addressed. Some of the
> slower systems still finishing up but no unexpected results yet and
> likely just redundant testing at this point.
>
> Tests on EPYC hardware has also been looking good. With some 44 tests on
> an EPYC 7F72 2P setup[2] when taking the geometric mean of all the data
> finding it rightly in line with the prior patch from Giovanni. EPYC 7702
> and EPYC 7F52 1P performance similarly showing no regression any longer
> with the patched kernel. This patch also seemed to help CPUFreq ondemand
> performance improve as well in some cases.
>
> Will advise if hitting anything unexpected with the remainder of the
> testing but all is looking solid at this point and a definite
> improvement over the current 5.11 Git state.
>
> Tested-by: Michael Larabel <Michael@phoronix.com>

Thank you for all of the verification work, much appreciated!

> [1] https://openbenchmarking.org/result/2102048-PTS-RYZEN95920 (5.10
> stable vs. 5.11 Git vs. patched.)
> [2] https://openbenchmarking.org/result/2102048-HA-AMDEPYC7F37
> (Giovanni's earlier patch against this new patch, compared to unpatched
> Linux 5.11 Git and then Linux 5.11 with CPUfreq performance governor.)
