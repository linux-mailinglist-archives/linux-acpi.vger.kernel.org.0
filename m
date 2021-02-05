Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E24310AC8
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Feb 2021 12:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhBEL7U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Feb 2021 06:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhBEL5P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Feb 2021 06:57:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F219EC06178B;
        Fri,  5 Feb 2021 03:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T6X8m6tExz2BAB8hOAwlfjoL5BesmPO9nKskxQcI52o=; b=wzxCL02EEa0zsOWUzhou1nULwc
        YO23mQuIXkjYvTqvJA5WOkt5x8QzrSHJt9Zn4sjEIbNNIhIydN4q8LFnPcTQ5ufEFTYBfbcsDOc9f
        YEB7kUwp4sQ+Dj5D7EH6w9oz/EED/+8IowQT1D9uL+8zYfanVT3+86WEtofphXC2Xdd/uhRo359DA
        CN1NhQyUm7K8BmCSNmskfrDxmsEfOSsm/m8sH1LN4KduC0VUTfLfLAA2ZPl6bYUMw2K/fYCrbPtNF
        bjC4ePqAwUHVVT5DtD4JU0OMjimiD21TLCOHTfusGnsINSjauBzTvQStF0GCjz8spKXYjDceCm1Y1
        21UHRHjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7zik-0001wh-Uz; Fri, 05 Feb 2021 11:56:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 324493013E5;
        Fri,  5 Feb 2021 12:56:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17FD62BBE1CB2; Fri,  5 Feb 2021 12:56:17 +0100 (CET)
Date:   Fri, 5 Feb 2021 12:56:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Larabel <Michael@phoronix.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v1 2/2] cpufreq: ACPI: Update arch scale-invariance max
 perf ratio if CPPC is not there
Message-ID: <YB0yYQl6T2fIQ+hw@hirez.programming.kicks-ass.net>
References: <13690581.X0sz4iL7V8@kreacher>
 <9510730.kuOQ4KzHjt@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9510730.kuOQ4KzHjt@kreacher>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 04, 2021 at 06:34:32PM +0100, Rafael J. Wysocki wrote:

>  arch/x86/kernel/smpboot.c      |    1 +
>  drivers/cpufreq/acpi-cpufreq.c |    8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
> +++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
> @@ -806,6 +806,14 @@ static int acpi_cpufreq_cpu_init(struct
>  		state_count++;
>  		valid_states++;
>  		data->first_perf_state = valid_states;
> +	} else {
> +		/*
> +		 * If the maximum "boost" frequency is unknown, ask the arch
> +		 * scale-invariance code to use the "nominal" performance for
> +		 * CPU utilization scaling so as to prevent the schedutil
> +		 * governor from selecting inadequate CPU frequencies.
> +		 */
> +		arch_set_max_freq_ratio(true);
>  	}
>  
>  	freq_table = kcalloc(state_count, sizeof(*freq_table), GFP_KERNEL);
> Index: linux-pm/arch/x86/kernel/smpboot.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/smpboot.c
> +++ linux-pm/arch/x86/kernel/smpboot.c
> @@ -1833,6 +1833,7 @@ void arch_set_max_freq_ratio(bool turbo_
>  	arch_max_freq_ratio = turbo_disabled ? SCHED_CAPACITY_SCALE :
>  					arch_turbo_freq_ratio;
>  }
> +EXPORT_SYMBOL_GPL(arch_set_max_freq_ratio);

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
