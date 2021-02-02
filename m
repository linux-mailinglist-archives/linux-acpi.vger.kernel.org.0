Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCD630C208
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 15:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhBBOht (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 09:37:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:49700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231524AbhBBORt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Feb 2021 09:17:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D77EBABD5;
        Tue,  2 Feb 2021 14:17:06 +0000 (UTC)
Message-ID: <1612275425.27785.70.camel@suse.cz>
Subject: Re: [PATCH v2 1/1] x86,sched: On AMD EPYC set freq_max = max_boost
 in schedutil invariant formula
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Date:   Tue, 02 Feb 2021 15:17:05 +0100
In-Reply-To: <1611933781.15858.48.camel@suse.cz>
References: <20210122204038.3238-1-ggherdovich@suse.cz>
         <20210122204038.3238-2-ggherdovich@suse.cz>
         <YA6YEK4/rjtPLdkG@hirez.programming.kicks-ass.net>
         <1611652167.11983.65.camel@suse.cz>
         <20210126093140.GB3592@techsingularity.net>
         <YA/pYrvvjf8AxPEv@hirez.programming.kicks-ass.net>
         <1611933781.15858.48.camel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2021-01-29 at 16:23 +0100, Giovanni Gherdovich wrote:
> On Tue, 2021-01-26 at 11:05 +0100, Peter Zijlstra wrote:
> > On Tue, Jan 26, 2021 at 09:31:40AM +0000, Mel Gorman wrote:
> > 
> > > So, should this patch be merged for 5.11 as a stopgap, fix up
> > > schedutil/cpufreq and then test both AMD and Intel chips reporting the
> > > correct max non-turbo and max-turbo frequencies? That would give time to
> > > give some testing in linux-next before merging to reduce the chance
> > > something else falls out.
> > 
> > Yeah, we should probably do this now. Rafael, you want this or should I
> > take it?
> 
> Hello Rafael,
> 
> did you have a chance to check this patch?
> 
> It fixes a performance regression from 5.11-rc1, I hoped it could be included
> before v5.11 is released.

Hello Rafael,

you haven't replied to this patch, which was written aiming at v5.11.

Do you see any problem with it?
Frequency-invariant schedutil needs the driver to advertise a high max_freq to
work properly; the patch addresses this for AMD EPYC.


Thanks,
Giovanni
