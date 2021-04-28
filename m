Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E1236DD6A
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbhD1QsT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 12:48:19 -0400
Received: from foss.arm.com ([217.140.110.172]:47970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241219AbhD1QsS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Apr 2021 12:48:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E2BDED1;
        Wed, 28 Apr 2021 09:47:33 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA11F3F694;
        Wed, 28 Apr 2021 09:47:27 -0700 (PDT)
Subject: Re: [RFC PATCH v6 3/4] scheduler: scan idle cpu in cluster for tasks
 within one LLC
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8b5277d9-e367-566d-6bd1-44ac78d21d3f@arm.com>
Date:   Wed, 28 Apr 2021 18:47:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtC51eO2mAuW6mHQ-SdznAtfDL3D4UOs4HmnXaPOOCN_cA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 28/04/2021 15:04, Vincent Guittot wrote:
> On Wed, 28 Apr 2021 at 11:51, Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com> wrote:
>>
>>> -----Original Message-----
>>> From: Dietmar Eggemann [mailto:dietmar.eggemann@arm.com]

[...]

>>> On 20/04/2021 02:18, Barry Song wrote:

[...]

>> I am really confused. The whole code has only checked if wake_flags
>> has WF_TTWU, it has never checked if sd_domain has SD_BALANCE_WAKE flag.
> 
> look at :
> #define WF_TTWU     0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
> 
> so  when wake_wide return false, we use the wake_affine mecanism but
> if it's false then we fllback to default mode which looks for:
> if (tmp->flags & sd_flag)
> 
> This means looking for SD_BALANCE_WAKE which is never set
> 
> so sd will stay NULL and you will end up calling select_idle_sibling anyway
> 
>>
>> static int
>> select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>> {
>>         ...
>>
>>         if (wake_flags & WF_TTWU) {
>>                 record_wakee(p);
>>
>>                 if (sched_energy_enabled()) {
>>                         new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>>                         if (new_cpu >= 0)
>>                                 return new_cpu;
>>                         new_cpu = prev_cpu;
>>                 }
>>
>>                 want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
>>         }
>> }
>>
>> And try_to_wake_up() has always set WF_TTWU:
>> static int
>> try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>> {
>>         cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
>>         ...
>> }
>>
>> So the change in wake_wide will actually affect the value of want_affine.
>> And I did also see code entered slow path during my benchmark.

Yes, this is happening but IMHO not for wakeups. Check wake_flags for
the tasks which go through `slow path` on your machine. They should have
WF_EXEC or WF_FORK, not WF_TTWU (& WF_SYNC).

>> One issue I mentioned during linaro open discussion is that
>> since I have moved to use cluster size to decide the value
>> of wake_wide, relatively less tasks will make wake_wide()
>> decide to go to slow path, thus, tasks begin to spread to
>> other NUMA,  but actually llc_size might be able to contain
>> those tasks. So a possible model might be:
>> static int wake_wide(struct task_struct *p)
>> {
>>         tasksize < cluster : scan cluster
>>         tasksize > llc      : slow path
>>         tasksize > cluster && tasksize < llc: scan llc
>> }
>>
>> thoughts?

Like Vincent explained, the return value of wake_wide() doesn't matter.
For wakeups you always end up in sis().

[...]
