Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C45423F99
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Oct 2021 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbhJFNwK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Oct 2021 09:52:10 -0400
Received: from foss.arm.com ([217.140.110.172]:51672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231600AbhJFNwH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 Oct 2021 09:52:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FE691FB;
        Wed,  6 Oct 2021 06:50:14 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39F0B3F66F;
        Wed,  6 Oct 2021 06:50:10 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
        Tim Chen <tim.c.chen@linux.intel.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        yangyicong <yangyicong@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH RESEND 1/3] topology: Represent clusters of CPUs within a die
In-Reply-To: <CAGsJ_4zCYjha8E6km9fDO8gFR-_vO1Nr0=a7V-b9yLRZGGAC9g@mail.gmail.com>
References: <20210924085104.44806-1-21cnbao@gmail.com> <20210924085104.44806-2-21cnbao@gmail.com> <87o883l9c8.mognet@arm.com> <CAGsJ_4zCYjha8E6km9fDO8gFR-_vO1Nr0=a7V-b9yLRZGGAC9g@mail.gmail.com>
Date:   Wed, 06 Oct 2021 14:49:49 +0100
Message-ID: <87lf36l0ua.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 06/10/21 09:43, Barry Song wrote:
>
> Hi Valentin,
> Yep, this is a very good question. I'd like change the code to:
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 7cb31d959f33..fc0836f460fb 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -622,7 +622,8 @@ void update_siblings_masks(unsigned int cpuid)
>                 if (cpuid_topo->package_id != cpu_topo->package_id)
>                         continue;
>
> -               if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
> +               if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
> +                   cpuid_topo->cluster_id != -1) {
>                         cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
>                         cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
>                 }
>
> This should be consistent with Tim's patch3/3 for x86 in case
> id is BAD_APICID:
> static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
> {
>         ...
>         /* Do not match if we do not have a valid APICID for cpu: */
>         if (per_cpu(cpu_l2c_id, cpu1) == BAD_APICID)
>                 return false;
>         ...
> }
>

LGTM.
