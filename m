Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7246A30C9A7
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 19:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbhBBSYU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 13:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238343AbhBBSWW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 13:22:22 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F2DC061573;
        Tue,  2 Feb 2021 10:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vJQck9cecnoSoCojZCPUMXo6OxMEgYGIIQPIgpbtvzM=; b=dIImtc+P/h3mcm9NDqxb8YSdZQ
        c2g0P6glS3/CaT+4ZRrshegHoxPsUVRVfd3wWFg859SU+13ZDr3vx9tRGbHZaQstSJzDbhZToecHQ
        VKkj3tQVDjH2KNOOyqaouT+qeVw7a9lAuWMOnVzPgYBs9S9zFqUJa6PDazctBF8EIRWIXmn5Ol00L
        AEUJ7Nd2H0qVJZICj48TvnwqKdGldWwSvhV5+0ZWltgbDt9Swpa1DiI65Sn/JAfh82wBbfpXLvJCJ
        zXns1uGPmQt9Trlj8YiVzB+0w7vzteZgX/vuIJqpySogTEkCNtC87xZEjZk920RlnDHp/WBn3KRpf
        ksX5m32A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l70Ic-0004la-3u; Tue, 02 Feb 2021 18:21:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21C3A306FFE;
        Tue,  2 Feb 2021 19:21:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BDCF203B8CC5; Tue,  2 Feb 2021 19:21:10 +0100 (CET)
Date:   Tue, 2 Feb 2021 19:21:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Larabel <Michael@phoronix.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86,sched: On AMD EPYC set freq_max = max_boost
 in schedutil invariant formula
Message-ID: <YBmYFnZuezAIlEhw@hirez.programming.kicks-ass.net>
References: <20210122204038.3238-1-ggherdovich@suse.cz>
 <20210122204038.3238-2-ggherdovich@suse.cz>
 <YA6YEK4/rjtPLdkG@hirez.programming.kicks-ass.net>
 <1611652167.11983.65.camel@suse.cz>
 <20210126093140.GB3592@techsingularity.net>
 <YA/pYrvvjf8AxPEv@hirez.programming.kicks-ass.net>
 <1611933781.15858.48.camel@suse.cz>
 <1612275425.27785.70.camel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612275425.27785.70.camel@suse.cz>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 02, 2021 at 03:17:05PM +0100, Giovanni Gherdovich wrote:
> Hello Rafael,
> 
> you haven't replied to this patch, which was written aiming at v5.11.

I've tentatively queued this for x86/urgent, but ideally this goes
through a cpufreq tree. Rafael, Viresh?


