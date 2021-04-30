Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DF036F89B
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Apr 2021 12:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhD3Kn6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Apr 2021 06:43:58 -0400
Received: from foss.arm.com ([217.140.110.172]:45010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhD3Kn5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Apr 2021 06:43:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BBFA31B;
        Fri, 30 Apr 2021 03:43:09 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 468CD3F73B;
        Fri, 30 Apr 2021 03:42:58 -0700 (PDT)
Subject: Re: [RFC PATCH v6 3/4] scheduler: scan idle cpu in cluster for tasks
 within one LLC
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
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
References: <20210420001844.9116-1-song.bao.hua@hisilicon.com>
 <20210420001844.9116-4-song.bao.hua@hisilicon.com>
 <80f489f9-8c88-95d8-8241-f0cfd2c2ac66@arm.com>
 <b42c762a287b4360bfa3179a5c7c3e8c@hisilicon.com>
 <CAKfTPtC51eO2mAuW6mHQ-SdznAtfDL3D4UOs4HmnXaPOOCN_cA@mail.gmail.com>
 <8b5277d9-e367-566d-6bd1-44ac78d21d3f@arm.com>
 <185746c4d02a485ca8f3509439328b26@hisilicon.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d31a65af-d1d5-5fd1-276c-d2318cdba078@arm.com>
Date:   Fri, 30 Apr 2021 12:42:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <185746c4d02a485ca8f3509439328b26@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 29/04/2021 00:41, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: Dietmar Eggemann [mailto:dietmar.eggemann@arm.com]

[...]

>>>>> From: Dietmar Eggemann [mailto:dietmar.eggemann@arm.com]
>>
>> [...]
>>
>>>>> On 20/04/2021 02:18, Barry Song wrote:

[...]

> Though we will never go to slow path, wake_wide() will affect want_affine,
> so eventually affect the "new_cpu"?

yes.

> 
> 	for_each_domain(cpu, tmp) {
> 		/*
> 		 * If both 'cpu' and 'prev_cpu' are part of this domain,
> 		 * cpu is a valid SD_WAKE_AFFINE target.
> 		 */
> 		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
> 		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
> 			if (cpu != prev_cpu)
> 				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
> 
> 			sd = NULL; /* Prefer wake_affine over balance flags */
> 			break;
> 		}
> 
> 		if (tmp->flags & sd_flag)
> 			sd = tmp;
> 		else if (!want_affine)
> 			break;
> 	}
> 
> If wake_affine is false, the above won't execute, new_cpu(target) will
> always be "prev_cpu"? so when task size > cluster size in wake_wide(),
> this means we won't pull the wakee to the cluster of waker? It seems
> sensible.

What is `task size` here?

The criterion is `!(slave < factor || master < slave * factor)` or
`slave >= factor && master >= slave * factor` to wake wide.

I see that since you effectively change the sched domain size from LLC
to CLUSTER (e.g. 24->6) for wakeups with cpu and prev_cpu sharing LLC
(hence the `numactl -N 0` in your workload), wake_wide() has to take
CLUSTER size into consideration.

I was wondering if you saw wake_wide() returning 1 with your use cases:

numactl -N 0 /usr/lib/lmbench/bin/stream -P [6,12] -M 1024M -N 5
