Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985AF3039D7
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 11:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403756AbhAZKII (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 05:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391896AbhAZKGd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2021 05:06:33 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439B9C061573;
        Tue, 26 Jan 2021 02:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KuCgcrnIdOEtxOBYgiCuEx/9JXpZ5oWiPodajfjA2qg=; b=0eI3kvqnsNNA/WqLoQzfA7VbCm
        Q6Jb6DK9DpFfuA19c/yxFDHE/TZxOY8gnbj1FlnRqq+Vu3UWznZjzulAQwJiSJ7EujwfnvbsM/Dmz
        7hbIT1vwt0Yr85M4Irn0Mw1CalND/XnAW/pIVfuG7I8//U391gu3Ydf98w84QEZc9XerAJej/Wt1k
        h2FYtm9TJaSYjxQWCTvk5NUfYzODVj32KYVa5Pj6FrPgwH+HqzDz0ucFnS5Lbo7MNjdLYKW8E39dt
        aVbt2is5B2hQzQwED+WPFrqGrS7mMpnSUQdVnrDK2C43Xwr9JI7Rj/U2hsYhLqwT1efdNI85CCZ1p
        J6vbqU+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4LDx-0003tn-0a; Tue, 26 Jan 2021 10:05:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26B7C305C22;
        Tue, 26 Jan 2021 11:05:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A1E6209C50F3; Tue, 26 Jan 2021 11:05:22 +0100 (CET)
Date:   Tue, 26 Jan 2021 11:05:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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
Message-ID: <YA/pYrvvjf8AxPEv@hirez.programming.kicks-ass.net>
References: <20210122204038.3238-1-ggherdovich@suse.cz>
 <20210122204038.3238-2-ggherdovich@suse.cz>
 <YA6YEK4/rjtPLdkG@hirez.programming.kicks-ass.net>
 <1611652167.11983.65.camel@suse.cz>
 <20210126093140.GB3592@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126093140.GB3592@techsingularity.net>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 09:31:40AM +0000, Mel Gorman wrote:

> So, should this patch be merged for 5.11 as a stopgap, fix up
> schedutil/cpufreq and then test both AMD and Intel chips reporting the
> correct max non-turbo and max-turbo frequencies? That would give time to
> give some testing in linux-next before merging to reduce the chance
> something else falls out.

Yeah, we should probably do this now. Rafael, you want this or should I
take it?
