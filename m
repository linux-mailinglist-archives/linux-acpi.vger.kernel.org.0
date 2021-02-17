Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434E231DB4D
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Feb 2021 15:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhBQOTP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Feb 2021 09:19:15 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:34513 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbhBQOTO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2021 09:19:14 -0500
Received: by mail-oi1-f177.google.com with SMTP id j5so2850100oie.1;
        Wed, 17 Feb 2021 06:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsxA0/UMZkWVAuhoOzLnhRZ4hWdYEg6eUXHOKWQmu2s=;
        b=BSKjF3wLOs+y+UOiRwuFTRlg85iBdwD4JQqOPAcVfgaBkKEfkLK2KEFReaGDw3/kEG
         FIk1BUA/US7XfukeRDO67vWYBZdbBjWULAiMiQxgcmBNyjwU98/dNORpwKh0JpVU1934
         6AuC46IzxyUwxE+IsaGDQNz/4VZsQ0MwQgkrqCmIGV0UMUndkb+pRd3R79nzSWK4y4tI
         bkBff2e7niKkuIjiOoKp0m/mhGmmU1vSHycKY/YjVcm9mdJxrmG6RVMXwbRuvuiZr3ok
         37g7e84PcW4bvms4trfpY/YgpWCORL/efLM+2krV5MLSuajiTt/kPZfqka9n8JS+Xwyt
         zpjQ==
X-Gm-Message-State: AOAM531+WEEoSbx8jnsCEftpfsI6IKkHaj29WXVZW6QXSd7sf5s6JCRq
        LMAuIrSKinSUf1Dn1ZoX0xZNLpoGwfQWhWSxHIfVgbWk
X-Google-Smtp-Source: ABdhPJwye/1M50cGEfgKGs0AAZcZAOe6ZZ7AelM6gzs8QYWO/HXIzyqiYrRkV1uGM61diyUAmuMy3LtZphrg3L7goWg=
X-Received: by 2002:a54:400b:: with SMTP id x11mr5818289oie.71.1613571513496;
 Wed, 17 Feb 2021 06:18:33 -0800 (PST)
MIME-Version: 1.0
References: <1974978.nRy8TqEeLZ@kreacher> <1613558749.2373.55.camel@suse.cz>
In-Reply-To: <1613558749.2373.55.camel@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Feb 2021 15:18:20 +0100
Message-ID: <CAJZ5v0iv22rCJ5uw-sguk6hgMhYn8EdXooHiMaD1pkR_d+zNnA@mail.gmail.com>
Subject: Re: [RFT][PATCH v1] cpufreq: ACPI: Set cpuinfo.max_freq directly if
 max boost is known
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michael Larabel <Michael@phoronix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 17, 2021 at 11:46 AM Giovanni Gherdovich
<ggherdovich@suse.cz> wrote:
>
> On Mon, 2021-02-15 at 20:24 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover
> > boost frequencies") attempted to address a performance issue involving
> > acpi-cpufreq, the schedutil governor and scale-invariance on x86 by
> > extending the frequency tables created by acpi-cpufreq to cover the
> > entire range of "turbo" (or "boost") frequencies, but that caused
> > frequencies reported via /proc/cpuinfo and the scaling_cur_freq
> > attribute in sysfs to change which may confuse users and monitoring
> > tools.
> >
> > For this reason, revert the part of commit 3c55e94c0ade adding the
> > extra entry to the frequency table and use the observation that
> > in principle cpuinfo.max_freq need not be equal to the maximum
> > frequency listed in the frequency table for the given policy.
> >
> > Namely, modify cpufreq_frequency_table_cpuinfo() to allow cpufreq
> > drivers to set their own cpuinfo.max_freq above that frequency and
> > change  acpi-cpufreq to set cpuinfo.max_freq to the maximum boost
> > frequency found via CPPC.
> >
> > This should be sufficient to let all of the cpufreq subsystem know
> > the real maximum frequency of the CPU without changing frequency
> > reporting.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=211305
> > Fixes: 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover boost frequencies")
> > Reported-by: Matt McDonald <gardotd426@gmail.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Michael, Giovanni,
> >
> > The fix for the EPYC performance regression that was merged into 5.11 introduced
> > an undesirable side-effect by distorting the CPU frequency reporting via
> > /proc/cpuinfo and scaling_cur_freq (see the BZ link above for details).
> >
> > The patch below is reported to address this problem and it should still allow
> > schedutil to achieve desirable performance, because it simply sets
> > cpuinfo.max_freq without extending the frequency table of the CPU.
> >
> > Please test this one and let me know if it adversely affects performance.
> >
> > Thanks!
>
> Hello Rafael,
>
> more extended testing confirms the initial feeling; performance with this
> patch is mostly identical to vanilla v5.11.

Thank you!

> Tbench shows an improvement.

Interesting.

> Thanks for the fix!

YW

> Tested-by: Giovanni Gherdovich <ggherdovich@suse.cz>
>
> Results follow. The machine has two sockets with an AMD EPYC 7742 each.
> The governor is always schedutil.
>
>
> Ratios of time, lower is better:
>                                             v5.11     v5.11
>                                            vanilla    patch
>     - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>     NASA Parallel Benchmarks w/ MPI         1.00      0.96
>     NASA Parallel Benchmarks w/ OpenMP      1.00      ~
>     dbench on XFS                           1.00      ~
>     Linux kernel compilation                1.00      ~
>     git unit test suite                     1.00      ~
>
>
> Ratio of throughput, higher is better:
>                                             v5.11     v5.11
>                                            vanilla    patch
>     - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>     tbench on localhost                     1.00      1.09
>
>
> Tilde (~): no change wrt baseline.

Thanks again!

It would be good to hear from Michael too, but this is already
sufficient for me to queue up the patch for 5.12-rc.

Cheers!
