Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9E431CC8D
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Feb 2021 16:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBPPCs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Feb 2021 10:02:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:53528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhBPPCs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Feb 2021 10:02:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A41FAC90;
        Tue, 16 Feb 2021 15:02:07 +0000 (UTC)
Message-ID: <1613487727.13456.210.camel@suse.cz>
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
Date:   Tue, 16 Feb 2021 16:02:07 +0100
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
> 
> ---
>  drivers/cpufreq/acpi-cpufreq.c |   62 ++++++++++-------------------------------
>  drivers/cpufreq/freq_table.c   |    8 ++++-
>  2 files changed, 23 insertions(+), 47 deletions(-)

Hello Rafael,

I've run the quick image processing test below and the performance is in line
with v5.11. I'll send some more results as longer tests complete.

TEST        : Intel Open Image Denoise, www.openimagedenoise.org
INVOCATION  : ./denoise -hdr memorial.pfm -out out.pfm -bench 200 -threads $NTHREADS
CPU         : MODEL            : 2x AMD EPYC 7742
              FREQUENCY TABLE  : P2: 1.50 GHz
                                 P1: 2.00 GHz
				 P0: 2.25 GHz
              MAX BOOST        :     3.40 GHz

Results: threads, msecs (ratio). Lower is better.

              v5.11          v5.11-patch
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      1   1071.43 (1.00)   1068.57 (1.00)
      2    541.50 (1.00)    542.26 (1.00)
      4    276.38 (1.00)    276.96 (1.00)
      8    149.51 (1.00)    149.24 (1.00)
     16     78.57 (1.00)     78.57 (1.00)
     24     57.59 (1.00)     57.67 (1.00)
     32     46.40 (1.00)     46.30 (1.00)
     48     37.48 (1.00)     38.28 (1.02)
     64     33.18 (1.00)     33.69 (1.02)
     80     30.73 (1.00)     31.24 (1.02)
     96     28.06 (1.00)     28.79 (1.03)
    112     27.82 (1.00)     28.14 (1.01)
    120     28.33 (1.00)     29.16 (1.03)
    128     28.44 (1.00)     28.35 (1.00)


Giovanni
