Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7266C4223C6
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 12:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhJEKqW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 06:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhJEKqU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Oct 2021 06:46:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8323C06161C;
        Tue,  5 Oct 2021 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cJD/+MY9O8PHjOJeBQShvY15RDowrj3eSl2/eSskHLA=; b=rT4wKb6l2b2KWtpvqqlmr7CJHE
        kLGA9UWh3rkdNMx3WCU5Lr8XcmcfZO41p+3Qqd1gDraI1mMY8dE6VgZnqF+4ep6IbegxcdZMM83QR
        E18KMtQA9l0o6LccN078woxgNDWtEDxTsCQCN0vjaN6ognriXh1nj7d6ptLL/maP9RVL0a0ta5SXI
        FUMvZx2J7rtU0zDuOW7z6eBW8v3BMf/sW5BFPH4nXfTM69r7HORC0jOncrJwo4O62iwbtsx3nMpgD
        EeX0ueiROd7+3o49zo2rR+by1nRZ1+qVxbfRowon/1ALXf26EC4ltPfTKek4Rc3jBIH1Iiad4ZTp3
        7QgXfq9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXhs8-000EnA-Jq; Tue, 05 Oct 2021 10:40:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DEBA13002DE;
        Tue,  5 Oct 2021 12:40:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B864A203BF5E8; Tue,  5 Oct 2021 12:40:30 +0200 (CEST)
Date:   Tue, 5 Oct 2021 12:40:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
        Valentin Schneider <valentin.schneider@arm.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        yangyicong <yangyicong@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH RESEND 2/3] scheduler: Add cluster scheduler level in
 core and related Kconfig for ARM64
Message-ID: <YVwrnv+81+KQF+cS@hirez.programming.kicks-ass.net>
References: <20210924085104.44806-1-21cnbao@gmail.com>
 <20210924085104.44806-3-21cnbao@gmail.com>
 <20211005073544.GI4323@worktop.programming.kicks-ass.net>
 <CAGsJ_4zCCKmyV7SpwCjwqiMj5Cch=CMd_np71uSXdqeGhZjRRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zCCKmyV7SpwCjwqiMj5Cch=CMd_np71uSXdqeGhZjRRg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 05, 2021 at 10:01:09PM +1300, Barry Song wrote:
> On Tue, Oct 5, 2021 at 8:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Sep 24, 2021 at 08:51:03PM +1200, Barry Song wrote:
> > > From: Barry Song <song.bao.hua@hisilicon.com>
> > >
> >
> > >
> > > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> >
> > That is not a valid SoB pattern. The first SoB should be the author, the
> > last SoB should be the one sending the patch, in this case both are
> > Barry. What's Yicong's contribution in all this?
> 
> Yicong made the benchmarks of SPECrate and collected the result data which
> is in the commit log. I am not quite sure what is the best tag for
> him. Is Tested-by
> appropriate in this case?

Yeah, that works for me, changed it.
