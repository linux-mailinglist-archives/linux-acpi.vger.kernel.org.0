Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB94310B0D
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Feb 2021 13:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhBEM0c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Feb 2021 07:26:32 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:39121 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhBEMYD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Feb 2021 07:24:03 -0500
Received: by mail-ot1-f44.google.com with SMTP id d7so4421176otq.6;
        Fri, 05 Feb 2021 04:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zbYJU7/7wruMhCCGProhaCLIU7PuY0G0RxvpsB363c=;
        b=cP15nKYKNG9EXDemnLPQak7q4EJUuGr84OCuaNlTVQQzqJ0buBEx8+UXmrLCgY9gGh
         ETMfyQlJKtz8eokPP2Iw5KnjptUr+qvTI9m/C6DnDeMnVzZG+RQpFhVnA1TRq7HidRr1
         JkAVPRALRy655bZlNKT58u5u4IYiuc7UalRVVcdJNqv1xQfWG00t7k0/07Dvnbl7R19z
         0wVZIAX3ZYip9zoVTFbONDfFuv1sq35VkKFGAH1d4lnG52bzAsIlw6vOYFfB1H1mhxhz
         T0G2Ufnlu0hKuSpow5BqHcTCdr8aYf7DPu/IxbAPCdhWrEx8tabGnuegGIbzfWy4fpKt
         NDmg==
X-Gm-Message-State: AOAM531FxdE7X0xbfvadi55h+fGA7SnhIAkKLUltHMtzYKxFFrBXoYVM
        ytuZPs6iHmqz+ufUly5rdvwAsuHsM0vgofhHp4s=
X-Google-Smtp-Source: ABdhPJw4F8pFpU+jx5TAWNsID8WdOi1o6JhMIb8S5CjAvdnRX8CSDeoL3wu2eU1ot2znQdryTEIcUrewtJT361/YrvU=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr3300736otm.206.1612527802672;
 Fri, 05 Feb 2021 04:23:22 -0800 (PST)
MIME-Version: 1.0
References: <13690581.X0sz4iL7V8@kreacher> <9510730.kuOQ4KzHjt@kreacher> <YB0yYQl6T2fIQ+hw@hirez.programming.kicks-ass.net>
In-Reply-To: <YB0yYQl6T2fIQ+hw@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Feb 2021 13:23:08 +0100
Message-ID: <CAJZ5v0iY17AYbgfPoxKn27MiRZ_KR2iMZZVk6UNV38geec84sQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cpufreq: ACPI: Update arch scale-invariance max
 perf ratio if CPPC is not there
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Larabel <Michael@phoronix.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 5, 2021 at 12:59 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 04, 2021 at 06:34:32PM +0100, Rafael J. Wysocki wrote:
>
> >  arch/x86/kernel/smpboot.c      |    1 +
> >  drivers/cpufreq/acpi-cpufreq.c |    8 ++++++++
> >  2 files changed, 9 insertions(+)
> >
> > Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
> > +++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
> > @@ -806,6 +806,14 @@ static int acpi_cpufreq_cpu_init(struct
> >               state_count++;
> >               valid_states++;
> >               data->first_perf_state = valid_states;
> > +     } else {
> > +             /*
> > +              * If the maximum "boost" frequency is unknown, ask the arch
> > +              * scale-invariance code to use the "nominal" performance for
> > +              * CPU utilization scaling so as to prevent the schedutil
> > +              * governor from selecting inadequate CPU frequencies.
> > +              */
> > +             arch_set_max_freq_ratio(true);
> >       }
> >
> >       freq_table = kcalloc(state_count, sizeof(*freq_table), GFP_KERNEL);
> > Index: linux-pm/arch/x86/kernel/smpboot.c
> > ===================================================================
> > --- linux-pm.orig/arch/x86/kernel/smpboot.c
> > +++ linux-pm/arch/x86/kernel/smpboot.c
> > @@ -1833,6 +1833,7 @@ void arch_set_max_freq_ratio(bool turbo_
> >       arch_max_freq_ratio = turbo_disabled ? SCHED_CAPACITY_SCALE :
> >                                       arch_turbo_freq_ratio;
> >  }
> > +EXPORT_SYMBOL_GPL(arch_set_max_freq_ratio);
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks, I'm queuing up this lot for a post-rc7 late push.
