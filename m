Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5758373B37
	for <lists+linux-acpi@lfdr.de>; Wed,  5 May 2021 14:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhEEMbD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 May 2021 08:31:03 -0400
Received: from foss.arm.com ([217.140.110.172]:43808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231633AbhEEMbD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 May 2021 08:31:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE4D231B;
        Wed,  5 May 2021 05:30:06 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 394AA3F70D;
        Wed,  5 May 2021 05:30:00 -0700 (PDT)
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
 <d31a65af-d1d5-5fd1-276c-d2318cdba078@arm.com>
 <4d1f063504b1420c9f836d1f1a7f8e77@hisilicon.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <142c7192-cde8-6dbe-bb9d-f0fce21ec959@arm.com>
Date:   Wed, 5 May 2021 14:29:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4d1f063504b1420c9f836d1f1a7f8e77@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 03/05/2021 13:35, Song Bao Hua (Barry Song) wrote:

[...]

>> From: Song Bao Hua (Barry Song)

[...]

>>> From: Dietmar Eggemann [mailto:dietmar.eggemann@arm.com]

[...]

>>> On 29/04/2021 00:41, Song Bao Hua (Barry Song) wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Dietmar Eggemann [mailto:dietmar.eggemann@arm.com]
>>>
>>> [...]
>>>
>>>>>>>> From: Dietmar Eggemann [mailto:dietmar.eggemann@arm.com]
>>>>>
>>>>> [...]
>>>>>
>>>>>>>> On 20/04/2021 02:18, Barry Song wrote:

[...]

> 
> On the other hand, according to "sched: Implement smarter wake-affine logic"
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=62470419
> 
> Proper factor in wake_wide is mainly beneficial of 1:n tasks like postgresql/pgbench.
> So using the smaller cluster size as factor might help make wake_affine false so
> improve pgbench.
> 
> From the commit log, while clients =  2*cpus, the commit made the biggest
> improvement. In my case, It should be clients=48 for a machine whose LLC
> size is 24.
> 
> In Linux, I created a 240MB database and ran "pgbench -c 48 -S -T 20 pgbench"
> under two different scenarios:
> 1. page cache always hit, so no real I/O for database read
> 2. echo 3 > /proc/sys/vm/drop_caches
> 
> For case 1, using cluster_size and using llc_size will result in similar
> tps= ~108000, all of 24 cpus have 100% cpu utilization.
> 
> For case 2, using llc_size still shows better performance.
> 
> tps for each test round(cluster size as factor in wake_wide):
> 1398.450887 1275.020401 1632.542437 1412.241627 1611.095692 1381.354294 1539.877146
> avg tps = 1464
> 
> tps for each test round(llc size as factor in wake_wide):
> 1718.402983 1443.169823 1502.353823 1607.415861 1597.396924 1745.651814 1876.802168
> avg tps = 1641  (+12%)
> 
> so it seems using cluster_size as factor in "slave >= factor && master >= slave *
> factor" isn't a good choice for my machine at least.

So SD size = 4 (instead of 24) seems to be too small for `-c 48`.

Just curious, have you seen the benefit of using wake wide on SD size =
24 (LLC) compared to not using it at all?
