Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C5031D7AA
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Feb 2021 11:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhBQKqc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Feb 2021 05:46:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:46838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhBQKqc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Feb 2021 05:46:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 30B35B256;
        Wed, 17 Feb 2021 10:45:50 +0000 (UTC)
Message-ID: <1613558749.2373.55.camel@suse.cz>
Subject: Re: [RFT][PATCH v1] cpufreq: ACPI: Set cpuinfo.max_freq directly if
 max boost is known
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michael Larabel <Michael@phoronix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 17 Feb 2021 11:45:49 +0100
In-Reply-To: <1974978.nRy8TqEeLZ@kreacher>
References: <1974978.nRy8TqEeLZ@kreacher>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2021-02-15 at 20:24 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover
> boost frequencies") attempted to address a performance issue involving
> acpi-cpufreq, the schedutil governor and scale-invariance on x86 by
> extending the frequency tables created by acpi-cpufreq to cover the
> entire range of "turbo" (or "boost") frequencies, but that caused
> frequencies reported via /proc/cpuinfo and the scaling_cur_freq
> attribute in sysfs to change which may confuse users and monitoring
> tools.
> 
> For this reason, revert the part of commit 3c55e94c0ade adding the
> extra entry to the frequency table and use the observation that
> in principle cpuinfo.max_freq need not be equal to the maximum
> frequency listed in the frequency table for the given policy.
> 
> Namely, modify cpufreq_frequency_table_cpuinfo() to allow cpufreq
> drivers to set their own cpuinfo.max_freq above that frequency and
> change  acpi-cpufreq to set cpuinfo.max_freq to the maximum boost
> frequency found via CPPC.
> 
> This should be sufficient to let all of the cpufreq subsystem know
> the real maximum frequency of the CPU without changing frequency
> reporting.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=211305
> Fixes: 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover boost frequencies")
> Reported-by: Matt McDonald <gardotd426@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Michael, Giovanni,
> 
> The fix for the EPYC performance regression that was merged into 5.11 introduced
> an undesirable side-effect by distorting the CPU frequency reporting via
> /proc/cpuinfo and scaling_cur_freq (see the BZ link above for details).
> 
> The patch below is reported to address this problem and it should still allow
> schedutil to achieve desirable performance, because it simply sets
> cpuinfo.max_freq without extending the frequency table of the CPU.
> 
> Please test this one and let me know if it adversely affects performance.
> 
> Thanks!

Hello Rafael,

more extended testing confirms the initial feeling; performance with this
patch is mostly identical to vanilla v5.11. Tbench shows an improvement.

Thanks for the fix!

Tested-by: Giovanni Gherdovich <ggherdovich@suse.cz>

Results follow. The machine has two sockets with an AMD EPYC 7742 each.
The governor is always schedutil.


Ratios of time, lower is better:
					    v5.11     v5.11
					   vanilla    patch
    - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    NASA Parallel Benchmarks w/ MPI         1.00      0.96
    NASA Parallel Benchmarks w/ OpenMP      1.00      ~
    dbench on XFS                           1.00      ~
    Linux kernel compilation                1.00      ~
    git unit test suite                     1.00      ~


Ratio of throughput, higher is better:
					    v5.11     v5.11
					   vanilla    patch
    - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    tbench on localhost                     1.00      1.09


Tilde (~): no change wrt baseline.


Giovanni
