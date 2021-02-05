Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD0831056E
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Feb 2021 08:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhBEHHM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Feb 2021 02:07:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:41348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231230AbhBEHHI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Feb 2021 02:07:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48858B038;
        Fri,  5 Feb 2021 07:06:26 +0000 (UTC)
Message-ID: <1612508785.19825.6.camel@suse.cz>
Subject: Re: [PATCH v1 1/2] cpufreq: ACPI: Extend frequency tables to cover
 boost frequencies
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Larabel <Michael@phoronix.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 05 Feb 2021 08:06:25 +0100
In-Reply-To: <8467867.3EdU9UaQ17@kreacher>
References: <13690581.X0sz4iL7V8@kreacher> <8467867.3EdU9UaQ17@kreacher>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2021-02-04 at 18:25 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> A severe performance regression on AMD EPYC processors when using
> the schedutil scaling governor was discovered by Phoronix.com and
> attributed to the following commits:
> 
>     41ea667227ba ("x86, sched: Calculate frequency invariance for
>     AMD systems")
> 
>     976df7e5730e ("x86, sched: Use midpoint of max_boost and max_P
>     for frequency invariance on AMD EPYC")
> 
> [snip]
> 
> Fixes: 41ea667227ba ("x86, sched: Calculate frequency invariance for AMD systems")
> Fixes: 976df7e5730e ("x86, sched: Use midpoint of max_boost and max_P for frequency invariance on AMD EPYC")
> Fixes: db865272d9c4 ("cpufreq: Avoid configuring old governors as default with intel_pstate")
> Link: https://www.phoronix.com/scan.php?page=article&item=linux511-amd-schedutil&num=1
> Link: https://lore.kernel.org/linux-pm/20210203135321.12253-2-ggherdovich@suse.cz/
> Reported-by: Michael Larabel <Michael@phoronix.com>
> Diagnosed-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c |  107 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 95 insertions(+), 12 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
> +++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
> [...]

Tested-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Reviewed-by: Giovanni Gherdovich <ggherdovich@suse.cz>

Note there is also the Tested-by: Michael, from the other thread
https://lore.kernel.org/lkml/5ea06dbe-255c-3d22-b9bd-6e627c5f94af@phoronix.com/

I tested this patch with the "NASA Parallel Benchmarks" from [link below], the
results confirms that the 5.10 performance is recovered:


Ratios of completion times, lower is better (5.10 is the baseline)

                              5.10     5.11-rc6 5.11-rc6-ggherdov 5.11-rc6-rafael
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Integer Sort              1.00        1.21        0.91           0.93
    Embarrassingly Parallel   1.00        1.60        1.00           1.00
    Discrete FFT              1.00        1.68        0.67           0.67


    CPU     : MODEL            : 2x AMD EPYC 7742
              FREQUENCY TABLE  : P2: 1.50 GHz
                                 P1: 2.00 GHz
                                 P0: 2.25 GHz
              MAX BOOST        :     3.40 GHz

[link] https://www.nas.nasa.gov/publications/npb.html

Thanks,
Giovanni
