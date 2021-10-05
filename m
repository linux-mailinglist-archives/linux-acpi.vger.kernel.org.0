Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B370422022
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 10:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhJEIJV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 04:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhJEIJU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Oct 2021 04:09:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BEEC061745;
        Tue,  5 Oct 2021 01:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fTYy+JsPp0Luxwf+jQWWHB2bXvTIbDSFNvdErOAVSfU=; b=TFueyENHYRQaO/5AkXnMZFErfu
        dCo/57hrVzgG6W8MQiffUDe+6QbULCs0oQlPQ+Swhf359Yk5CiAGmxs3w6wgx5HeCMN/jgPgmzVne
        wERlayxLdLN4zfJwbHoB72Klc3r0fCHHRGLmRErQHON7MNY6JrtT3btE3ZLydYLBYzErPW6xzea5t
        IXrppEwU4ltBFfMK6NsboV+UizetAnojTdwFX9g5xRCyNiDtht9g8ShhWiXkplzntmZ6cnov8kCNS
        9xJiak0SeGLOS4W6feosLerqZVIPyaMoXL4UpVPrwWn2rY0tO1FZ8edyaHr/BG2BVZ8omonD5kP/6
        4gnVLzDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXfQr-0007BD-SM; Tue, 05 Oct 2021 08:04:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AAA198631C; Tue,  5 Oct 2021 10:04:13 +0200 (CEST)
Date:   Tue, 5 Oct 2021 10:04:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
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
Message-ID: <20211005080413.GL4323@worktop.programming.kicks-ass.net>
References: <20210924085104.44806-1-21cnbao@gmail.com>
 <CAGsJ_4yW72mktbWjRfE9ngXoq9oXBXyAd_TPjKBNdGiRSoh9LA@mail.gmail.com>
 <CAKfTPtAtfJRFBbo+kBCYf42hxcc2iP8kkmg3Wcr5aW7Rnf=rfw@mail.gmail.com>
 <YVch0/R9PHzUwqea@hirez.programming.kicks-ass.net>
 <ece8838d112840bf26adbb09f653babcf298eb28.camel@linux.intel.com>
 <CAGsJ_4wvLw=US1ddJr=Jrim1vs-F2hpcQ29LQyqDENd7Fk=ssA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4wvLw=US1ddJr=Jrim1vs-F2hpcQ29LQyqDENd7Fk=ssA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Oct 02, 2021 at 08:09:58PM +1300, Barry Song wrote:

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7e4651a1aaf4..86821e83b935 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -993,8 +993,13 @@ config SCHED_CLUSTER
>         bool "Cluster scheduler support"
>         help
>           Cluster scheduler support improves the CPU scheduler's decision
> +         making when dealing with machines that have clusters of CPUs.
> +         Cluster usually means a couple of CPUs which are placed closely
> +         by sharing mid-level caches, last-level cache tags or internal
> +         busses. For example, on Hisilicon Kunpeng920, each 4 CPUs share
> +         LLC cache tags. This feature isn't a universal win because it
> +         can bring a cost of slightly increased overhead in some places.
> +         If unsure say N here.
> 
>  config SCHED_SMT
>         bool "SMT scheduler support"
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index bd27b1cdac34..940eb1fe0abb 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1002,12 +1002,17 @@ config NR_CPUS
>           to the kernel image.
> 
>  config SCHED_CLUSTER
> +       def_bool y
> +       prompt "Cluster scheduler support"
>         help
>          Cluster scheduler support improves the CPU scheduler's decision
> +        making when dealing with machines that have clusters of CPUs.
> +        Cluster usually means a couple of CPUs which are placed closely
> +        by sharing mid-level caches, last-level cache tags or internal
> +        busses. For example, on x86 Jacobsville, each 4 CPUs share one
> +        L2 cache. 

			This feature isn't a universal win because it can bring
> +        a cost of slightly increased overhead in some places. If unsure
> +        say N here.

That is a really odd addition to a default-y feature.

How about I make both:

	help
	  Cluster scheduler support improves the CPU scheduler's decision
	  making when dealing with machines that have clusters of CPUs.
	  Cluster usually means a couple of CPUs which are placed closely
	  by sharing mid-level caches, last-level cache tags or internal
	  busses.

