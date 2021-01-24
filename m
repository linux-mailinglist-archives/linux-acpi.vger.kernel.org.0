Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE868301F6A
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Jan 2021 23:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbhAXWtr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 24 Jan 2021 17:49:47 -0500
Received: from rome.phoronix.com ([192.211.48.82]:61956 "EHLO
        rome.phoronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbhAXWtp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Jan 2021 17:49:45 -0500
X-Greylist: delayed 1071 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jan 2021 17:49:44 EST
Received: from c-73-176-63-28.hsd1.il.comcast.net ([73.176.63.28]:52254 helo=[192.168.86.21])
        by rome.phoronix.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <Michael@phoronix.com>)
        id 1l3nuP-0002JK-MX; Sun, 24 Jan 2021 17:31:01 -0500
Subject: Re: [PATCH v2 0/1] AMD EPYC: fix schedutil perf regression
 (freq-invariance)
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20210122204038.3238-1-ggherdovich@suse.cz>
From:   Michael Larabel <Michael@phoronix.com>
Message-ID: <a5071cb5-6a5b-d2e4-ff06-fa7810b8127c@phoronix.com>
Date:   Sun, 24 Jan 2021 16:30:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122204038.3238-1-ggherdovich@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rome.phoronix.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - phoronix.com
X-Get-Message-Sender-Via: rome.phoronix.com: authenticated_id: michael@phoronix.com
X-Authenticated-Sender: rome.phoronix.com: michael@phoronix.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

 From ongoing tests of this patch, it still certainly shows to address 
most of the Linux 5.11 performance regression previously encountered 
when using Schedutil. Additionally, for a number of workloads where not 
seeing a regression from 5.10 to 5.11 Git is still showing even better 
performance with this patch. The power monitoring on the AMD EPYC server 
is showing higher power spikes but the average power consumption rate is 
roughly comparable to that of Linux 5.11 Git, which is higher than 5.10 
by just about 3%.

So this patch still seems to be working out well and indeed taking care 
of some wide losses seen otherwise on Linux 5.11 when using Schedutil on 
AMD Zen2/Zen3. Still have some other tests running but so far no 
unexpected results.

Michael


AMD EPYC 7F72 2P

On an EPYC 7F72 2P server[1] across 147 test cases I am finding the 
patched Linux 5.11 kernel to be just over 1% faster than 5.10 stable 
compared to the unpatched 5.11 Git being just behind 5.10. For the 
workloads on that server where Linux 5.11 is slower with Schedutil, the 
patch indeed is largely addressing that regression and also providing 
other improvements.

During that testing, the amd_energy interface was monitored. Linux 5.11 
with Schedutil AMD freq invariance did show on average 10 Watts (~3.7%) 
higher power consumption on average than Linux 5.10 with Schedutil. But 
with this patch, that average is still basically the same. The peak 
power consumption during any of the tests was higher at 530~549 Watts 
compared to 501 Watts with Linux 5.10. Overall the performance is 
looking good but given amd_energy still not working for consumer models, 
I don't have much power data to share at the moment.

Ryzen 9 5950X

Expanding on the prior testing with the 5950X, I ran some follow-up 
tests[2]. Of 221 test cases there, the current Linux 5.11 Git 
performance came around 2% slower on a geo mean basis than Linux 5.10 
while the patched performance pulls it to ~2.5% faster than 5.10. There 
still are some cases where Linux 5.10 is faster, but overall at least 
the patched Linux 5.11 performance doesn't show nearly as many 
regressions. In a number of test cases, the Linux 5.11 patched 
performance is outright better than Linux 5.10 even where 5.11 
(un-patched) hadn't regressed or by that much.

Ryzen 5 4500U

For something at the lower end of the spectrum I also ran a number of 
tests on a Ryzen 5 4500U notebook[3]. Linux 5.11 (unpatched) doesn't see 
as many regressions as on the larger systems but still the patched 
performance did help in a number of tests, particularly around 
graphics/gaming. In the heavier multi-core core tests are still a number 
of cases where Linux 5.10 is faster than patched/unpatched 5.11. The 
patched kernel in those 90 tests came out to being about 4% faster than 
5.10.

(Result highlights below, results with little change set to hidden by 
default.)
[1] 
https://openbenchmarking.org/result/2101248-HA-AMDEPYC7F52&grs&hlc=1&hnr=1&hlc=1
[2] https://openbenchmarking.org/result/2101242-HA-RYZEN959530&grs&hlc=1
[3] 
https://openbenchmarking.org/result/2101232-PTS-RENOIRLI89&grs&hnr=1&hlc=1


On 1/22/21 2:40 PM, Giovanni Gherdovich wrote:
> Michael Larabel from Phoronix.com graciously tested v1, see results at:
>
> AMD EPYC 7702 -
> https://openbenchmarking.org/result/2101210-PTS-LINUX51178
>
> AMD Ryzen 9 5950X -
> https://openbenchmarking.org/result/2101212-HA-RYZEN959566
>
> The reported regression is recovered, and some workloads even report an
> improvement over the v5.10 results.
>
> Thanks Michael for the feedback!
>
>
> v1 at https://lore.kernel.org/lkml/20210121003223.20257-1-ggherdovich@suse.cz/
>
> Changes wrt v1:
>
> - move code around so that it builds for non-x86 architectures too
>
> Giovanni Gherdovich (1):
>    x86,sched: On AMD EPYC set freq_max = max_boost in schedutil invariant
>      formula
>
>   drivers/cpufreq/acpi-cpufreq.c   | 64 +++++++++++++++++++++++++++++++-
>   drivers/cpufreq/cpufreq.c        |  3 ++
>   include/linux/cpufreq.h          |  5 +++
>   kernel/sched/cpufreq_schedutil.c |  8 +++-
>   4 files changed, 76 insertions(+), 4 deletions(-)
>
