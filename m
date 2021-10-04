Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD55421A54
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 00:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbhJDW4l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Oct 2021 18:56:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:46069 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233501AbhJDW4k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Oct 2021 18:56:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="206423269"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="206423269"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 15:54:51 -0700
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="477402850"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.66.53])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 15:54:50 -0700
Message-ID: <3a0f95cf5602e11fde0e21032e52aad6e137d940.camel@linux.intel.com>
Subject: Re: [PATCH RESEND 0/3] Represent cluster topology and enable load
 balance between clusters
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
        "Cc: Len Brown" <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, msys.mizuma@gmail.com,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        yangyicong <yangyicong@huawei.com>
Date:   Mon, 04 Oct 2021 15:54:50 -0700
In-Reply-To: <CAGsJ_4wvLw=US1ddJr=Jrim1vs-F2hpcQ29LQyqDENd7Fk=ssA@mail.gmail.com>
References: <20210924085104.44806-1-21cnbao@gmail.com>
         <CAGsJ_4yW72mktbWjRfE9ngXoq9oXBXyAd_TPjKBNdGiRSoh9LA@mail.gmail.com>
         <CAKfTPtAtfJRFBbo+kBCYf42hxcc2iP8kkmg3Wcr5aW7Rnf=rfw@mail.gmail.com>
         <YVch0/R9PHzUwqea@hirez.programming.kicks-ass.net>
         <ece8838d112840bf26adbb09f653babcf298eb28.camel@linux.intel.com>
         <CAGsJ_4wvLw=US1ddJr=Jrim1vs-F2hpcQ29LQyqDENd7Fk=ssA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 2021-10-02 at 20:09 +1300, Barry Song wrote:
> 
> 
> Thanks, Tim, for your comments.
> I am ok to make it default "Y" for x86 after having a better doc as
> below:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index bd27b1cdac34..940eb1fe0abb 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1002,12 +1002,17 @@ config NR_CPUS
>           to the kernel image.
> 
>  config SCHED_CLUSTER
> -       bool "Cluster scheduler support"
> -       default n
> +       def_bool y
> +       prompt "Cluster scheduler support"
>         help
>          Cluster scheduler support improves the CPU scheduler's
> decision
> -        making when dealing with machines that have clusters of CPUs
> -        sharing L2 cache. If unsure say N here.
> +        making when dealing with machines that have clusters of
> CPUs.
> +        Cluster usually means a couple of CPUs which are placed
> closely
> +        by sharing mid-level caches, last-level cache tags or
> internal
> +        busses. For example, on x86 Jacobsville, each 4 CPUs share
> one
> +        L2 cache. This feature isn't a universal win because it can
> bring
> +        a cost of slightly increased overhead in some places. If
> unsure
> +        say N here.
> 
> This also aligns well with SCHED_MC and SCHED_SMT in
> arch/x86/kconfig:
> config SCHED_MC
>     def_bool y
>     prompt "Multi-core scheduler support"
> 
> config SCHED_SMT
>     def_bool y if SMP
> 
> But ARM64 is running in a different tradition, arch/arm64/Kconfig has
> SCHED_MC and SCHED_SMT as below:
>    config SCHED_MC
>    bool "Multi-core scheduler support"
>    help
>     ...
> 
> config SCHED_SMT
>   bool "SMT scheduler support"
>   help
>   ...
> 
> 

Barry,

Found one minor fix to the x86 patch to take care of compile error for
!CONFIG_SMP.

Thanks.

Tim

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 2548d824f103..cc164777e661 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -109,12 +109,12 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
-#define topology_cluster_id(cpu)		(per_cpu(cpu_l2c_id, cpu))
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
 extern unsigned int __max_die_per_package;
 
 #ifdef CONFIG_SMP
+#define topology_cluster_id(cpu)		(per_cpu(cpu_l2c_id, cpu))
 #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
 #define topology_cluster_cpumask(cpu)		(cpu_clustergroup_mask(cpu))
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))

