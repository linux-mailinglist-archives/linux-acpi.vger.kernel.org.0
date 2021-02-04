Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8381E30F430
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 14:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbhBDNvM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 08:51:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:32952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236393AbhBDNuc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Feb 2021 08:50:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65AF5AC97;
        Thu,  4 Feb 2021 13:49:49 +0000 (UTC)
Message-ID: <1612446586.7566.20.camel@suse.cz>
Subject: Re: [PATCH v3 1/1] x86,sched: On AMD EPYC set freq_max = max_boost
 in schedutil invariant formula
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
        Michael Larabel <Michael@phoronix.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Date:   Thu, 04 Feb 2021 14:49:46 +0100
In-Reply-To: <5470319.60Xv9dOaFs@kreacher>
References: <20210203135321.12253-1-ggherdovich@suse.cz>
         <20210203135321.12253-2-ggherdovich@suse.cz>
         <CAJZ5v0g1SWRnV1QfZG3o+hvBg9akakhDMomGCFjwERyG2ENKww@mail.gmail.com>
         <5470319.60Xv9dOaFs@kreacher>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2021-02-03 at 19:25 +0100, Rafael J. Wysocki wrote:
> [cut]
> 
> So below is a prototype of an alternative fix for the issue at hand.
> 
> I can't really test it here, because there's no _CPC in the ACPI tables of my
> test machines, so testing it would be appreciated.  However, AFAICS these
> machines are affected by the performance issue related to the scale-invariance
> when they are running acpi-cpufreq, so what we are doing here is not entirely
> sufficient.
> 
> It looks like the scale-invariance code should ask the cpufreq driver about
> the maximum frequency and note that cpufreq drivers may be changed on the
> fly.
> 
> What the patch below does is to add an extra entry to the frequency table for
> each CPU to represent the maximum "boost" frequency, so as to cause that
> frequency to be used as cpuinfo.max_freq.
> 
> The reason why I think it is better to extend the frequency tables instead
> of simply increasing the frequency for the "P0" entry is because the latter
> may cause "turbo" frequency to be asked for less often.
> 
> ---
>  drivers/cpufreq/acpi-cpufreq.c |  107 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 95 insertions(+), 12 deletions(-)

Hello Rafael,

thanks for looking at this. Your patch is indeed cleaner than the one I proposed.

Preliminary testing is favorable; more tests are running.

Results from your patch are in the fourth column below; the performance from
v5.10 looks restored.

I'll follow up once the tests I queued are completed.

Giovanni


TEST        : Intel Open Image Denoise, www.openimagedenoise.org
INVOCATION  : ./denoise -hdr memorial.pfm -out out.pfm -bench 200 -threads $NTHREADS
CPU         : MODEL            : 2x AMD EPYC 7742
              FREQUENCY TABLE  : P2: 1.50 GHz
                                 P1: 2.00 GHz
				 P0: 2.25 GHz
              MAX BOOST        :     3.40 GHz

Results: threads, msecs (ratio). Lower is better.

               v5.10          v5.11-rc4   v5.11-rc4-ggherdov v5.11-rc6-rafael
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      1   1069.85 (1.00)   1071.84 (1.00)   1070.42 (1.00)   1069.12 (1.00)
      2    542.24 (1.00)    544.40 (1.00)    544.48 (1.00)    540.81 (1.00)
      4    278.00 (1.00)    278.44 (1.00)    277.72 (1.00)    277.79 (1.00)
      8    149.81 (1.00)    149.61 (1.00)    149.87 (1.00)    149.51 (1.00)
     16     79.01 (1.00)     79.31 (1.00)     78.94 (1.00)     79.02 (1.00)
     24     58.01 (1.00)     58.51 (1.01)     58.15 (1.00)     57.84 (1.00)
     32     46.58 (1.00)     48.30 (1.04)     46.66 (1.00)     46.70 (1.00)
     48     37.29 (1.00)     51.29 (1.38)     37.27 (1.00)     38.10 (1.02)
     64     34.01 (1.00)     49.59 (1.46)     33.71 (0.99)     34.51 (1.01)
     80     31.09 (1.00)     44.27 (1.42)     31.33 (1.01)     31.11 (1.00)
     96     28.56 (1.00)     40.82 (1.43)     28.47 (1.00)     28.65 (1.00)
    112     28.09 (1.00)     40.06 (1.43)     28.63 (1.02)     28.38 (1.01)
    120     28.73 (1.00)     39.78 (1.38)     28.14 (0.98)     28.16 (0.98)
    128     28.93 (1.00)     39.60 (1.37)     29.38 (1.02)     28.55 (0.99)
