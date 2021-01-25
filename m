Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9746130237F
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 11:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbhAYKKb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 05:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbhAYKIH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 05:08:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE00AC06178B;
        Mon, 25 Jan 2021 02:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GtW+rqjBxkqPAgL+lYKMDvLoZJFjuWlfCcBAqCEjP5s=; b=WJyw0nG2FuUQR4LFIN4hKSNWnv
        CtcoSv8B8UtYxJHi5AKG1FYYZNVorPAQ6nXBtosCtNuF62XaAMoRda/QWD7slH2EZA+wsT++O4H4Q
        dYbn8ohRzsYbDseZb0piXlX6IdhjnxsxM1a0sziELEA14GdW5zIH91RwEQyV/ATy2Tnsq8XwPsLYT
        yI9U083MD98OAwroK9WLJoKNcwaTDr15rP/83+dcj9Sc4uPEQOaZR3xYlEz3eqlQLt7ZI4AIihVNK
        AJfgltRW7BifG+3DPWv9ppPlklIHMthgGqWWr3LbHrhWU8OrdMpDRvY+PcccMIqC3nC86VtJLEU3x
        FzfvsCjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l3yl8-0005Gq-L3; Mon, 25 Jan 2021 10:06:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB4003010C8;
        Mon, 25 Jan 2021 11:06:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA1AD28B66D18; Mon, 25 Jan 2021 11:06:08 +0100 (CET)
Date:   Mon, 25 Jan 2021 11:06:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Larabel <Michael@phoronix.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86,sched: On AMD EPYC set freq_max = max_boost
 in schedutil invariant formula
Message-ID: <YA6YEK4/rjtPLdkG@hirez.programming.kicks-ass.net>
References: <20210122204038.3238-1-ggherdovich@suse.cz>
 <20210122204038.3238-2-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122204038.3238-2-ggherdovich@suse.cz>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 22, 2021 at 09:40:38PM +0100, Giovanni Gherdovich wrote:
> 1. PROBLEM DESCRIPTION (over-utilization and schedutil)
> 
> The problem happens on CPU-bound workloads spanning a large number of cores.
> In this case schedutil won't select the maximum P-State. Actually, it's
> likely that it will select the minimum one.
> 
> A CPU-bound workload puts the machine in a state generally called
> "over-utilization": an increase in CPU speed doesn't result in an increase of
> capacity. The fraction of time tasks spend on CPU becomes constant regardless
> of clock frequency (the tasks eat whatever we throw at them), and the PELT
> invariant util goes up and down with the frequency (i.e. it's not invariant
> anymore).

>                                       v5.10          v5.11-rc4
>                                       ~~~~~~~~~~~~~~~~~~~~~~~~
> CPU activity (mpstat)                 80-90%         80-90%
> schedutil requests (tracepoint)       always P0      mostly P2
> CPU frequency (HW feedback)           ~2.2 GHz       ~1.5 GHz
> PELT root rq util (tracepoint)        ~825           ~450
> 
> mpstat shows that the workload is CPU-bound and usage doesn't change with

So I'm having trouble with calling a 80%-90% workload CPU bound, because
clearly there's a ton of idle time.


