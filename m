Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7414422000
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 09:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhJEIBN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 04:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhJEIBK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Oct 2021 04:01:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CFBC061745;
        Tue,  5 Oct 2021 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7EzurNN/Tm91UcQ5AvIBpW7bZ+3LoENuHqBSaoQV8xk=; b=kpE4xAz5cHRNxaJRt9xou4YnE9
        sHA5LVGxO2nDtRHM/japysN1LQgV5/KzQj+6+mDG9UzVK0DBjVpGNIDIX1N+czWMcV/YppHqT7/JP
        5oQX4nxacrhS2eBq6QYE1BZ/vhXeBjjOoh/ywK4TlsF1z65lPt1llQxwvMY2dmAegRdLdlpWfz1sp
        sWTHmueJQHTvByDorT3dm1byf8OLHBPg0h+ibh5d5ifUziEb8dZGNYTCBvSzQhOPEFE9MsySf6SdH
        pjWPH8ZAkSD3zofGkdOqz+h5hT3aFYMCPNQYFts8XvIScd8CTtayjvct99ZHU4/gVn6/YRgX4Hsu5
        HeElfO+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXfHC-0006jY-RR; Tue, 05 Oct 2021 07:54:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AFED898631C; Tue,  5 Oct 2021 09:54:13 +0200 (CEST)
Date:   Tue, 5 Oct 2021 09:54:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Barry Song <21cnbao@gmail.com>,
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
Subject: Re: [PATCH RESEND 0/3] Represent cluster topology and enable load
 balance between clusters
Message-ID: <20211005075413.GK4323@worktop.programming.kicks-ass.net>
References: <20210924085104.44806-1-21cnbao@gmail.com>
 <CAGsJ_4yW72mktbWjRfE9ngXoq9oXBXyAd_TPjKBNdGiRSoh9LA@mail.gmail.com>
 <CAKfTPtAtfJRFBbo+kBCYf42hxcc2iP8kkmg3Wcr5aW7Rnf=rfw@mail.gmail.com>
 <YVch0/R9PHzUwqea@hirez.programming.kicks-ass.net>
 <ece8838d112840bf26adbb09f653babcf298eb28.camel@linux.intel.com>
 <CAGsJ_4wvLw=US1ddJr=Jrim1vs-F2hpcQ29LQyqDENd7Fk=ssA@mail.gmail.com>
 <3a0f95cf5602e11fde0e21032e52aad6e137d940.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0f95cf5602e11fde0e21032e52aad6e137d940.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 04, 2021 at 03:54:50PM -0700, Tim Chen wrote:
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 2548d824f103..cc164777e661 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -109,12 +109,12 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
>  #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
>  #define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
>  #define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
> -#define topology_cluster_id(cpu)		(per_cpu(cpu_l2c_id, cpu))
>  #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
>  
>  extern unsigned int __max_die_per_package;
>  
>  #ifdef CONFIG_SMP
> +#define topology_cluster_id(cpu)		(per_cpu(cpu_l2c_id, cpu))
>  #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
>  #define topology_cluster_cpumask(cpu)		(cpu_clustergroup_mask(cpu))
>  #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
> 

Fixed.
