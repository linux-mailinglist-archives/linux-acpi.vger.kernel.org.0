Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AF136D7F1
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 15:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbhD1NFP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 09:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbhD1NFO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Apr 2021 09:05:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4483FC061574
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2021 06:04:29 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a25so58833271ljm.11
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2021 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qShvs1kD6+QPIiHc1KiJImSSlzqxmF+Fov19AgqB3Uo=;
        b=COtPNeIbxICpTEWNszBu60eHVQY8hxmegldUYOkor4Zh3AiSkyOG5D4aoXtzgFaCjZ
         T1OhEj3UOJmpIVD9N+PL002daRjJU5X2qQNnWEIaNeZVflbs+rM45eWHHwGmKmWvgS+l
         5Uefbyrtui0Ww7/fc2aMCC1oclbZE57snBtI/RkzGVT5qXR4dPuCL7f2aB76eUN2vTkf
         flspyXtZQRAn8wQjqAIwTUsG3R9OWN/QklxIjQsloUSXSY/OLGK8GDS2RYfbwLLs41m3
         U26y1769brEr4VsvYs4ZSCgZzCH/ZoG/S9em1wNWHEI7mgAw8pZub10ntBVBjXYlJbl7
         cAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qShvs1kD6+QPIiHc1KiJImSSlzqxmF+Fov19AgqB3Uo=;
        b=mbKnNBuWJusElpD6yGyWphWBkfJBolPv21OYBG5V21pKYU1rB9WWjlLimfV1AKyH3/
         dVgW0IcZSPWaM7JGAGubB2MLPnwaQAArscvXG93XK5cqrpHCwkpxZ9FXAPrFtIC2ptlK
         II3KKiAkwg5euemob88paNJbAYHg1mZrG2sE06yHzgyDv7esLcXROP0gzcg8pS1ReLXI
         lyNrCY5Rvsiv2Bqel90RaYfH4Sx8mGsEdxX8d1paF1yjF+YCIBs7IhozkFKuWIS6WO/6
         CP5YAibGPnaX+0GF0iErX3LwjK6iP6wYSW/Pc+ZTMkco3/vRKAXX6ipyPeGM9XQ5Z6xi
         7GRg==
X-Gm-Message-State: AOAM530wcgYf/2LmQMk5O7hOnbRsF5ZqT59gJavk26YncUdYHsrua+uG
        A0yi2FQtUyuZbXD0tcvfyhff0IYA5op2yUMcw+08HA==
X-Google-Smtp-Source: ABdhPJwAy7ZFDxw6bJ3zZwNozxNo7A41VN+cjifIBrfQIOQJfk/bbriNS7UYASAR4GOZY8YDgx4Md2LH6dv4CZz9ia8=
X-Received: by 2002:a05:651c:612:: with SMTP id k18mr20503096lje.445.1619615067105;
 Wed, 28 Apr 2021 06:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210420001844.9116-1-song.bao.hua@hisilicon.com>
 <20210420001844.9116-4-song.bao.hua@hisilicon.com> <80f489f9-8c88-95d8-8241-f0cfd2c2ac66@arm.com>
 <b42c762a287b4360bfa3179a5c7c3e8c@hisilicon.com>
In-Reply-To: <b42c762a287b4360bfa3179a5c7c3e8c@hisilicon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 28 Apr 2021 15:04:16 +0200
Message-ID: <CAKfTPtC51eO2mAuW6mHQ-SdznAtfDL3D4UOs4HmnXaPOOCN_cA@mail.gmail.com>
Subject: Re: [RFC PATCH v6 3/4] scheduler: scan idle cpu in cluster for tasks
 within one LLC
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 28 Apr 2021 at 11:51, Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Dietmar Eggemann [mailto:dietmar.eggemann@arm.com]
> > Sent: Tuesday, April 27, 2021 11:36 PM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> > tim.c.chen@linux.intel.com; catalin.marinas@arm.com; will@kernel.org;
> > rjw@rjwysocki.net; vincent.guittot@linaro.org; bp@alien8.de;
> > tglx@linutronix.de; mingo@redhat.com; lenb@kernel.org; peterz@infradead.org;
> > rostedt@goodmis.org; bsegall@google.com; mgorman@suse.de
> > Cc: msys.mizuma@gmail.com; valentin.schneider@arm.com;
> > gregkh@linuxfoundation.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
> > juri.lelli@redhat.com; mark.rutland@arm.com; sudeep.holla@arm.com;
> > aubrey.li@linux.intel.com; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; x86@kernel.org;
> > xuwei (O) <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> > guodong.xu@linaro.org; yangyicong <yangyicong@huawei.com>; Liguozhu (Kenneth)
> > <liguozhu@hisilicon.com>; linuxarm@openeuler.org; hpa@zytor.com
> > Subject: Re: [RFC PATCH v6 3/4] scheduler: scan idle cpu in cluster for tasks
> > within one LLC
> >
> > On 20/04/2021 02:18, Barry Song wrote:
> >
> > [...]
> >
> > > @@ -5786,11 +5786,12 @@ static void record_wakee(struct task_struct *p)
> > >   * whatever is irrelevant, spread criteria is apparent partner count exceeds
> > >   * socket size.
> > >   */
> > > -static int wake_wide(struct task_struct *p)
> > > +static int wake_wide(struct task_struct *p, int cluster)
> > >  {
> > >     unsigned int master = current->wakee_flips;
> > >     unsigned int slave = p->wakee_flips;
> > > -   int factor = __this_cpu_read(sd_llc_size);
> > > +   int factor = cluster ? __this_cpu_read(sd_cluster_size) :
> > > +           __this_cpu_read(sd_llc_size);
> >
> > I don't see that the wake_wide() change has any effect here. None of the
> > sched domains has SD_BALANCE_WAKE set so a wakeup (WF_TTWU) can never
> > end up in the slow path.
>
> I am really confused. The whole code has only checked if wake_flags
> has WF_TTWU, it has never checked if sd_domain has SD_BALANCE_WAKE flag.

look at :
#define WF_TTWU     0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */

so  when wake_wide return false, we use the wake_affine mecanism but
if it's false then we fllback to default mode which looks for:
if (tmp->flags & sd_flag)

This means looking for SD_BALANCE_WAKE which is never set

so sd will stay NULL and you will end up calling select_idle_sibling anyway

>
> static int
> select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> {
>         ...
>
>         if (wake_flags & WF_TTWU) {
>                 record_wakee(p);
>
>                 if (sched_energy_enabled()) {
>                         new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>                         if (new_cpu >= 0)
>                                 return new_cpu;
>                         new_cpu = prev_cpu;
>                 }
>
>                 want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
>         }
> }
>
> And try_to_wake_up() has always set WF_TTWU:
> static int
> try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> {
>         cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
>         ...
> }
>
> So the change in wake_wide will actually affect the value of want_affine.
> And I did also see code entered slow path during my benchmark.
>
> One issue I mentioned during linaro open discussion is that
> since I have moved to use cluster size to decide the value
> of wake_wide, relatively less tasks will make wake_wide()
> decide to go to slow path, thus, tasks begin to spread to
> other NUMA,  but actually llc_size might be able to contain
> those tasks. So a possible model might be:
> static int wake_wide(struct task_struct *p)
> {
>         tasksize < cluster : scan cluster
>         tasksize > llc      : slow path
>         tasksize > cluster && tasksize < llc: scan llc
> }
>
> thoughts?
>
> > Have you seen a diff when running your `lmbench stream` workload in what
> > wake_wide() returns when you use `sd cluster size` instead of `sd llc
> > size` as factor?
> >
> > I guess for you,  wakeups are now subdivided into faster (cluster = 4
> > CPUs) and fast (llc = 24 CPUs) via sis(), not into fast (sis()) and slow
> > (find_idlest_cpu()).
> >
> > >
> > >     if (master < slave)
> > >             swap(master, slave);
> >
> > [...]
> >
> > > @@ -6745,6 +6748,12 @@ static int find_energy_efficient_cpu(struct
> > task_struct *p, int prev_cpu)
> > >     int want_affine = 0;
> > >     /* SD_flags and WF_flags share the first nibble */
> > >     int sd_flag = wake_flags & 0xF;
> > > +   /*
> > > +    * if cpu and prev_cpu share LLC, consider cluster sibling rather
> > > +    * than llc. this is typically true while tasks are bound within
> > > +    * one numa
> > > +    */
> > > +   int cluster = sched_cluster_active() && cpus_share_cache(cpu, prev_cpu, 0);
> >
> > So you changed from scanning cluster before LLC to scan either cluster
> > or LLC.
>
> Yes, I have seen two ugly things for scanning cluster before scanning LLC
> in select_idle_cpu.
> 1. avg_scan_cost is actually measuring the scanning time. But if we scan
> cluster before scanning LLC, during the gap of these two different
> domains, we need a huge bit operation and this bit operation is not
> a scanning operation at all. This makes the scan_cost quite
> untrustworthy particularly "nr" can sometimes be < cluster size, sometimes
> > cluster size.
>
> 2. select_idle_cpu() is actually the last step of wake_affine, before
> that, wake_affine code has been totally depending on cpus_share_cache()
> to decide the target to scan from. When waker and wakee have been already
> in one LLC, if we only change select_idle_cpu(), at that time, decision
> has been made. we may lose some chance to choose the right target to scan
> from. So it should be more sensible to let cpus_share_cache() check cluster
> when related tasks have been in one same LLC.
>
> >
> > And this is based on whether `this_cpu` and `prev_cpu` are sharing LLC
> > or not. So you only see an effect when running the workload with
> > `numactl -N X ...`.
>
> Ideally, I'd expect this can also positively affect tasks located in
> different LLCs.
> For example, if taskA and taskB are in different NUMAs(also LLC for both
> kunpeng920 and Tim's hardware) at the first beginning, a two-stage packing
> might make them take the advantage of cluster:
> For the first wake-up, taskA and taskB will be put in one LLC by scanning
> LLC;
> For the second wake-up, they might be put in one cluster by scanning
> cluster.
> So ideally, scanning LLC and scanning cluster can work in two stages
> for related tasks and pack them step by step. Practically, this
> could happen. But LB between NUMA might take the opposite way. Actually,
> for a kernel completely *without* cluster patch, I have seen some
> serious ping-pong of tasks in two numa nodes due to the conflict
> of wake_affine and LB. this kind of ping-pong could seriously affect
> the performance.
> For example, for g=6,12,18,24,28,32, I have found running same workload
> on 2numa shows so much worse latency than doing that on single one
> numa(each numa has 24 cpus).
> 1numa command: numactl -N 0 hackbench -p -T -l 1000000 -f 1 -g $1
> 2numa command: numactl -N 0-1 hackbench -p -T -l 1000000 -f 1 -g $1
>
> Measured the average latency of 20 times for each command.
>
> *)without cluster scheduler, 2numa vs 1numa:
> g      =     6     12     18    24      28     32
> 1numa      1.2474 1.5635 1.5133 1.4796 1.6177 1.7898
> 2numa      4.1997 5.8172 6.0159 7.2343 6.8264 6.5419
>
> BTW, my cluster patch actually also improves 2numa:
> *)with cluster scheduler 2numa vs 1numa:
> g      =     6     12     18    24      28     32
> 1numa      0.9500 1.0728 1.1756 1.2201 1.4166 1.5464
> 2numa      3.5404 4.3744 4.3988 4.6994 5.3117 5.4908
>
> *) 2numa  w/ and w/o cluster:
> g          =     6     12     18    24      28     32
> 2numa w/o      4.1997 5.8172 6.0159 7.2343 6.8264 6.5419
> 2numa w/       3.5404 4.3744 4.3988 4.6994 5.3117 5.4908
>
> Ideally, load balance should try to pull unmarried tasks rather than
> married tasks. I mean, if we have
> groupA: task1+task2 as couple, task3 as bachelor
> groupB: task4.
> groupB should try to pull task3. But I feel it is extremely hard to let
> LB understand who is married and who is unmarried.
>
> I assume 2numa worse than 1numa should be a different topic
> which might be worth more investigation.
>
> On the other hand, use cases I'm now targeting at are really using
> "numactl -N x" to bind processes in one NUMA. If we ignore other NUMA
> (also other LLCs) and think one NUMA as a whole system, cluster would
> be the last-level topology scheduler can use. And the code could be
> quite clean to directly leverage the existing select_sibling code for
> LLC by simply changing cpus_share_cache() to cluster level.
>
> >
> > >
> > >     if (wake_flags & WF_TTWU) {
> > >             record_wakee(p);
> > > @@ -6756,7 +6765,7 @@ static int find_energy_efficient_cpu(struct task_struct
> > *p, int prev_cpu)
> > >                     new_cpu = prev_cpu;
> > >             }
> > >
> > > -           want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
> > > +           want_affine = !wake_wide(p, cluster) && cpumask_test_cpu(cpu,
> > p->cpus_ptr);
> > >     }
> > >
> > >     rcu_read_lock();
> > > @@ -6768,7 +6777,7 @@ static int find_energy_efficient_cpu(struct task_struct
> > *p, int prev_cpu)
> > >             if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
> > >                 cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
> > >                     if (cpu != prev_cpu)
> > > -                           new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
> > > +                           new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync, cluster);
> > >
> > >                     sd = NULL; /* Prefer wake_affine over balance flags */
> > >                     break;
> > > @@ -6785,7 +6794,7 @@ static int find_energy_efficient_cpu(struct task_struct
> > *p, int prev_cpu)
> > >             new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
> > >     } else if (wake_flags & WF_TTWU) { /* XXX always ? */
> > >             /* Fast path */
> > > -           new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> > > +           new_cpu = select_idle_sibling(p, prev_cpu, new_cpu, cluster);
> > >
> > >             if (want_affine)
> > >                     current->recent_used_cpu = cpu;
> >
> > [...]
>
> Thanks
> Barry
>
