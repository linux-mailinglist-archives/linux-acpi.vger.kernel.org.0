Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ADE423DAF
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Oct 2021 14:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhJFMYy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Oct 2021 08:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbhJFMYy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Oct 2021 08:24:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9C5C061749;
        Wed,  6 Oct 2021 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jGRGjTwTIkRqG9rPpRJmFYnotEHM8b7eyzqywKaCxzU=; b=e4FNKRxyiGEAXwkdgHz8fve8RK
        pTXJgmqkKrRVo77srt1xypzk6uJzHyGsIa7O50LwzUHJX5AxIvDU5j59EcU84NTur6tFr/1YOo7+l
        1Zi9ezn1g7so5+alZ8Lceq+yUBE3csRU0KgRwz5VBvo4NzopRiICWJLIOgRNp8OAwiqMnHHA2Oo1u
        yiieYHiQY9eQR81IyVVLyq5jIMk1CU3aj/TARdgToQOcf/uUi6nTWM+a9UFdB9d+dENK9VkKctC1f
        9sRmYEFuP9tld8135eG7crvMrhnu0JCodWDIKpLOxjm/EPoPNYjpp9OEeVYkKVKBAW4Kr5kVyYNIr
        DrlzLxwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mY5sw-000rWW-2l; Wed, 06 Oct 2021 12:19:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F97298623A; Wed,  6 Oct 2021 14:18:58 +0200 (CEST)
Date:   Wed, 6 Oct 2021 14:18:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        Tim Chen <tim.c.chen@linux.intel.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        yangyicong <yangyicong@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH RESEND 1/3] topology: Represent clusters of CPUs within a
 die
Message-ID: <20211006121858.GI174703@worktop.programming.kicks-ass.net>
References: <20210924085104.44806-1-21cnbao@gmail.com>
 <20210924085104.44806-2-21cnbao@gmail.com>
 <87o883l9c8.mognet@arm.com>
 <CAGsJ_4zCYjha8E6km9fDO8gFR-_vO1Nr0=a7V-b9yLRZGGAC9g@mail.gmail.com>
 <CAGsJ_4ycKDfFY+LoaUBJ5huH8+kUsGGsC1po4DDQQPU5-ikf8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4ycKDfFY+LoaUBJ5huH8+kUsGGsC1po4DDQQPU5-ikf8A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 06, 2021 at 11:50:35PM +1300, Barry Song wrote:

> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 7cb31d959f33..fc0836f460fb 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -622,7 +622,8 @@ void update_siblings_masks(unsigned int cpuid)
> >                 if (cpuid_topo->package_id != cpu_topo->package_id)
> >                         continue;
> >
> > -               if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
> > +               if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
> > +                   cpuid_topo->cluster_id != -1) {
> >                         cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
> >                         cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
> >                 }
> >
> 
> Hi Peter,
> Would you like to change this line in your tree?

Can you please double check:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/next


