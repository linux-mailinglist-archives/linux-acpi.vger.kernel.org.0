Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF2742281E
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 15:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhJENoU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 09:44:20 -0400
Received: from foss.arm.com ([217.140.110.172]:43428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233077AbhJENoT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Oct 2021 09:44:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC89E1FB;
        Tue,  5 Oct 2021 06:42:28 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6D8F3F70D;
        Tue,  5 Oct 2021 06:42:24 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Barry Song <21cnbao@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Cc\: Len Brown" <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, msys.mizuma@gmail.com,
        "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        yangyicong <yangyicong@huawei.com>
Subject: Re: [PATCH RESEND 0/3] Represent cluster topology and enable load balance between clusters
In-Reply-To: <20211005075001.GJ4323@worktop.programming.kicks-ass.net>
References: <20210924085104.44806-1-21cnbao@gmail.com> <CAGsJ_4yW72mktbWjRfE9ngXoq9oXBXyAd_TPjKBNdGiRSoh9LA@mail.gmail.com> <CAKfTPtAtfJRFBbo+kBCYf42hxcc2iP8kkmg3Wcr5aW7Rnf=rfw@mail.gmail.com> <YVch0/R9PHzUwqea@hirez.programming.kicks-ass.net> <ece8838d112840bf26adbb09f653babcf298eb28.camel@linux.intel.com> <20211005075001.GJ4323@worktop.programming.kicks-ass.net>
Date:   Tue, 05 Oct 2021 14:42:17 +0100
Message-ID: <87tuhvlhae.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 05/10/21 09:50, Peter Zijlstra wrote:
> On Fri, Oct 01, 2021 at 04:22:46PM -0700, Tim Chen wrote:
>> On Fri, 2021-10-01 at 16:57 +0200, Peter Zijlstra wrote:
>
>> > The one questino I have is, do we want default y?
>>
>> I also agree that default y is preferable.
>
> I'll change at least the x86 one to:
>
>       default y
>       depends on SMP
>

Huh, so the arm64 SCHED_{SMT,MC} configs are defaultless (I added SCHED_SMT
to arm64's defconfig not so long ago), but x86 has them default y, which
I'm thinking is a tad better, and would be nice to harmonize. Unfortunately
different architectures have their own dependency requirements - arm has
ARM_CPU_TOPOLOGY, parisc has PARISC_CPU_TOPOLOGY...

Would you hate making SCHED_* a "generic" config, with a common default and
help text, and punt the arch specific stuff to an ARCH_SUPPORTS_* knob?

Something like:

arch/arm/Kconfig:
  select ARCH_SUPPORTS_SCHED_MC if ARM_CPU_TOPOLOGY

init/Kconfig:
  config SCHED_MC
    def_bool y
    depends on ARCH_SUPPORTS_SCHED_MC && SMP
