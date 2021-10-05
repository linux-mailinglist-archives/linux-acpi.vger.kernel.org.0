Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4BD422480
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 13:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhJELFq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 07:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbhJELFq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Oct 2021 07:05:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0686FC06161C;
        Tue,  5 Oct 2021 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5RXETHUeK0IoWDd8SaOUu8GrGBoYdj45miweofV1tqI=; b=KupXzRHIt3+Y/Pzu29D8sWyaiV
        Xww0f73lBH9/jQ1W6k5CN0T8+6XGrOEE0VowKEnf82Ymy1v+pzvl69mhpp95GqSwAgZRkqAIWwTOU
        eVaXoG9lTXX+Dd6eG+JH6CKCmxwfpcVVVxdyMjZf4tCqSKvkExxEGACjV2k2y6aLv9zqz9VIvb2P6
        faUolqJPjdESdCk4G5yDrJBb/08d6RMMGlr6xHY1bDVGzovCBnYhU//mmwo3eymZBO6nsABlzQ5AM
        QPo4IbwrzlGzTKyuzLWYLcAcfy6eX28dn08pSpPEeNkXGOMasPdqdIEoTv+jhpojLHDcig1tWM89V
        aF03Nfxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXi9O-000FQG-II; Tue, 05 Oct 2021 10:59:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2305B30019C;
        Tue,  5 Oct 2021 12:58:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F544201A0530; Tue,  5 Oct 2021 12:58:21 +0200 (CEST)
Date:   Tue, 5 Oct 2021 12:58:21 +0200
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
Message-ID: <YVwvzchbP5qbogjq@hirez.programming.kicks-ass.net>
References: <20210924085104.44806-1-21cnbao@gmail.com>
 <CAGsJ_4yW72mktbWjRfE9ngXoq9oXBXyAd_TPjKBNdGiRSoh9LA@mail.gmail.com>
 <CAKfTPtAtfJRFBbo+kBCYf42hxcc2iP8kkmg3Wcr5aW7Rnf=rfw@mail.gmail.com>
 <YVch0/R9PHzUwqea@hirez.programming.kicks-ass.net>
 <ece8838d112840bf26adbb09f653babcf298eb28.camel@linux.intel.com>
 <20211005075001.GJ4323@worktop.programming.kicks-ass.net>
 <CAGsJ_4xZD0sG0Df666f0bvHOzuPMjnw0dN_mArER5k1pJ6LPLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xZD0sG0Df666f0bvHOzuPMjnw0dN_mArER5k1pJ6LPLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 05, 2021 at 10:15:39PM +1300, Barry Song wrote:

> > (also, all this stuff being replicated across arch/*/Kconfig seems
> > unfortunate)
> 
> perhaps worth a separate patchset to do some cleanup so that SCHED_MC,
> SCHED_SMT etc
> won't be replicated in different architectures. Right now, this kind
> of Kconfig option is copied
> everywhere. I am seeing SCHED_SMT in all of
> arch/arm/Kconfig
> arch/arm64/Kconfig
> arch/ia64/Kconfig
> arch/mips/Kconfig
> arch/powerpc/Kconfig
> arch/s390/Kconfig
> arch/sparc/Kconfig
> arch/x86/Kconfig
> ...
> 
> Is it a better way to move them to a common Kconfig and let the architectures to
> declare things like ARCH_HAVE_SMT?

Dunno, it's all a bit of a mess :/ I can't quickly see a sane
pattern there.

