Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FA430F410
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 14:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbhBDNmn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 08:42:43 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:38469 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbhBDNlY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2021 08:41:24 -0500
Received: by mail-oi1-f174.google.com with SMTP id h6so3726847oie.5;
        Thu, 04 Feb 2021 05:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0rPFw1h6YFddKGACdjtDmU63njD588yrFe74MomORc=;
        b=k97M7S+vde8+8YaFotBh2RdNhOYR6zvRBQBe9o+pThy6H4mr5gGVBqt00TPWEgHLvj
         GVXQe2hPS+HzZoUMvwhpTYiasqayBX6DougXOtVUVzp+IwOLlp1lk+OMMmj3zzcF4CVW
         4fDZUI40ZP2ykLbu9qlqq0TI2uMuyXkLOd7vS0wbSe4lUunK2iQgcNZGWmgAKY98r9Lt
         PPlN3368B6u2wFtMi2dbw3te8Zg0mMLp9I15BQ6OdRvsmql2XZZ4pFiLp7P00RyMCXfd
         FaNTDZkTdCGtjmVr+nTrVH9tzoumuOw/8P8VtDBivLWSWJSa3tjvoJ+OjUZAffHTLxc6
         wmUg==
X-Gm-Message-State: AOAM5329nLn/5TjWHt5TOhkAVYMgFND9gvQYVes/uV7f7xx/sERjUMeJ
        L27tLlya4GjxUhl0Arv4dKT9+K6l90rw3oy0XSY=
X-Google-Smtp-Source: ABdhPJyhIhNKNYvZ2kTLhrRl8CqI8Pq4XuQrF06ZKm8ZdpfMgxS4PQpd5SAIyT5DYVNQ1PeWUJsRE96BPP6mn/mRYO4=
X-Received: by 2002:aca:d14:: with SMTP id 20mr5312384oin.157.1612446042645;
 Thu, 04 Feb 2021 05:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20210203135321.12253-1-ggherdovich@suse.cz> <20210203135321.12253-2-ggherdovich@suse.cz>
 <CAJZ5v0g1SWRnV1QfZG3o+hvBg9akakhDMomGCFjwERyG2ENKww@mail.gmail.com>
 <5470319.60Xv9dOaFs@kreacher> <563fec57-6417-e875-1788-3773cbfb34be@phoronix.com>
In-Reply-To: <563fec57-6417-e875-1788-3773cbfb34be@phoronix.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Feb 2021 14:40:30 +0100
Message-ID: <CAJZ5v0jzhVJ-8iVfhkFHBdJf1pYAMtC=1JhuTn14vWtZUwJoAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] x86,sched: On AMD EPYC set freq_max = max_boost in
 schedutil invariant formula
To:     Michael Larabel <Michael@phoronix.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Thu, Feb 4, 2021 at 12:36 AM Michael Larabel <Michael@phoronix.com> wrote:
>
> On 2/3/21 12:25 PM, Rafael J. Wysocki wrote:
> > On Wednesday, February 3, 2021 3:11:37 PM CET Rafael J. Wysocki wrote:
> >> On Wed, Feb 3, 2021 at 2:53 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
> >> [cut]
> >>
> >>> Fixes: 41ea667227ba ("x86, sched: Calculate frequency invariance for AMD systems")
> >>> Fixes: 976df7e5730e ("x86, sched: Use midpoint of max_boost and max_P for frequency invariance on AMD EPYC")
> >>> Reported-by: Michael Larabel <Michael@phoronix.com>
> >>> Tested-by: Michael Larabel <Michael@phoronix.com>
> >>> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> >>> ---
> >>>   drivers/cpufreq/acpi-cpufreq.c   | 61 ++++++++++++++++++++++++++++++--
> >>>   drivers/cpufreq/cpufreq.c        |  3 ++
> >>>   include/linux/cpufreq.h          |  5 +++
> >>>   kernel/sched/cpufreq_schedutil.c |  8 +++--
> >> I don't really think that it is necessary to modify schedutil to
> >> address this issue.
> > So below is a prototype of an alternative fix for the issue at hand.
> >
> > I can't really test it here, because there's no _CPC in the ACPI tables of my
> > test machines, so testing it would be appreciated.  However, AFAICS these
> > machines are affected by the performance issue related to the scale-invariance
> > when they are running acpi-cpufreq, so what we are doing here is not entirely
> > sufficient.
>
>
> I have benchmarks running on several Ryzen and EPYC systems with this
> patch. The full batch of tests won't be done until tomorrow, but in
> looking at the data so far from an AMD EPYC 7F72 2P server over the past
> few hours, this patch does provide fairly comparable numbers to
> Giovanni's patch. There were a few outliers so far but waiting to see
> with the complete set of results. At the very least it's clear enough
> already this new patch is at least an improvement over the current 5.11
> upstream state with schedutil on AMD.

Thanks for the feedback, much appreciated!

Let me submit the patch properly, then.
