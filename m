Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87412CD28D
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Dec 2020 10:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbgLCJ3q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Dec 2020 04:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387563AbgLCJ3q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2020 04:29:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0B1C061A4D;
        Thu,  3 Dec 2020 01:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nPpnyaz1GEljl9uGWL8SuA2DDESrqim+Vy6HGJodTj4=; b=XmupRTV7OXHj8VFbLDWnXPpvgb
        dPDdEIVY87RODwlYICw+qFu8hnscminzKjB30tkNhXXv3gg3WZN7+vJ0TLLqCE2YKszzSmh8yb2kR
        Teaxbn82e7S/yRylXlf/yTTvVCqGWwdCJAxcqtOemF/waiWJGz7xQARzLTSZNpE/wmcPrqqKIEDDD
        XOpRiauX/TD/Po3KOhaijVSUmSAIq3u94ubsLSsVcUVo6Ku6WTXRdJgygVoGmVseKSA9tdEdkSmvN
        p+LckFXqi6UdG/hxqCt6wv8NuPbBSFofqDpgxQNs+SjRiClRD+yj7rHNZLFpObm69w+m+46BZrKIb
        RCbjx6wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkkuf-0003ld-FU; Thu, 03 Dec 2020 09:28:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B87030018A;
        Thu,  3 Dec 2020 10:28:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 53C4E201BAA75; Thu,  3 Dec 2020 10:28:31 +0100 (CET)
Date:   Thu, 3 Dec 2020 10:28:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>, catalin.marinas@arm.com,
        will@kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linuxarm@huawei.com, xuwei5@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
Message-ID: <20201203092831.GH2414@hirez.programming.kicks-ass.net>
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
 <20201201025944.18260-3-song.bao.hua@hisilicon.com>
 <jhj1rg9v7gr.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj1rg9v7gr.mognet@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 01, 2020 at 04:04:04PM +0000, Valentin Schneider wrote:
> 
> Gating this behind this new config only leveraged by arm64 doesn't make it
> very generic. Note that powerpc also has this newish "CACHE" level which
> seems to overlap in function with your "CLUSTER" one (both are arch
> specific, though).
> 
> I think what you are after here is an SD_SHARE_PKG_RESOURCES domain walk,
> i.e. scan CPUs by increasing cache "distance". We already have it in some
> form, as we scan SMT & LLC domains; AFAICT LLC always maps to MC, except
> for said powerpc's CACHE thingie.

There's some intel chips with a smaller L2, but I don't think we ever
bothered.

There's also the extended topology stuff from Intel: SMT, Core, Module,
Tile, Die, of which we've only partially used Die I think.

Whatever we do, it might make sense to not all use different names.

Also, I think Mel said he was cooking something for
select_idle_balance().

Also, I've previously posted patches that fold all the iterations into
one, so it might make sense to revisit some of that if Mel also already
didn.t
