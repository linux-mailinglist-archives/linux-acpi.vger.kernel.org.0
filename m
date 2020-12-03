Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0642CD2E0
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Dec 2020 10:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgLCJt7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Dec 2020 04:49:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:53356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbgLCJt7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Dec 2020 04:49:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69351AC55;
        Thu,  3 Dec 2020 09:49:17 +0000 (UTC)
Date:   Thu, 3 Dec 2020 09:49:14 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linuxarm@huawei.com, xuwei5@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
Message-ID: <20201203094914.GE3306@suse.de>
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
 <20201201025944.18260-3-song.bao.hua@hisilicon.com>
 <jhj1rg9v7gr.mognet@arm.com>
 <20201203092831.GH2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201203092831.GH2414@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 03, 2020 at 10:28:31AM +0100, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 04:04:04PM +0000, Valentin Schneider wrote:
> > 
> > Gating this behind this new config only leveraged by arm64 doesn't make it
> > very generic. Note that powerpc also has this newish "CACHE" level which
> > seems to overlap in function with your "CLUSTER" one (both are arch
> > specific, though).
> > 
> > I think what you are after here is an SD_SHARE_PKG_RESOURCES domain walk,
> > i.e. scan CPUs by increasing cache "distance". We already have it in some
> > form, as we scan SMT & LLC domains; AFAICT LLC always maps to MC, except
> > for said powerpc's CACHE thingie.
> 
> There's some intel chips with a smaller L2, but I don't think we ever
> bothered.
> 
> There's also the extended topology stuff from Intel: SMT, Core, Module,
> Tile, Die, of which we've only partially used Die I think.
> 
> Whatever we do, it might make sense to not all use different names.
> 
> Also, I think Mel said he was cooking something for
> select_idle_balance().
> 
> Also, I've previously posted patches that fold all the iterations into
> one, so it might make sense to revisit some of that if Mel also already
> didn.t

I didn't. The NUMA/lb reconcilation took most of my attention and right
now I'm looking at select_idle_sibling again in preparation for tracking
the idle cpumask in a sensible fashion. The main idea I had in mind was
special casing EPYC as it has multiple small L3 caches that may benefit
from select_idle_sibling looking slightly beyond the LLC as a search
domain but it has not even started yet.

-- 
Mel Gorman
SUSE Labs
