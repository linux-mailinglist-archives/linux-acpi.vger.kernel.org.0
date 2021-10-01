Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81DC41F01F
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Oct 2021 16:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhJAO7v (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Oct 2021 10:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhJAO7v (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2021 10:59:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291B1C061775;
        Fri,  1 Oct 2021 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cAWxL3kxMyky/ALcvxBRTl/qlVsp3X+zi1jV2TnUcZY=; b=L8YWA7K9qHLJC/inWvwTS/qXgm
        9YpTsKs7ovmD9nmpOtQK0AfwCa27mMlTsC7dcymqZAGOExmps8qArfcN1jWooapBZWdlrqK7lk9F1
        s8lEiIMY44GqWQfICclrQwW4XZXacwEljWlHsoSw4iFaN3joqrzPzYkcZhQRe7IkBs1JouTMa94IY
        fcPDZi1nDcBrfZFJSGlJhLKk6/aj82BM64nGbDujdPJlgJt80Jo7MdRY5Op1+gLQJb5C8jn0YrB38
        VE/q3TdXSh4O80AV1QBlUkZEnNQu/n7p7iCmQu5e+UI7zJbMd9CxZJAuZGjqa7YIAu0o0AJ+uIhzC
        rMShDpQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWJyZ-007BaB-BH; Fri, 01 Oct 2021 14:57:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 446DB30214E;
        Fri,  1 Oct 2021 16:57:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33A10265BC20A; Fri,  1 Oct 2021 16:57:23 +0200 (CEST)
Date:   Fri, 1 Oct 2021 16:57:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Barry Song <21cnbao@gmail.com>,
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
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        yangyicong <yangyicong@huawei.com>
Subject: Re: [PATCH RESEND 0/3] Represent cluster topology and enable load
 balance between clusters
Message-ID: <YVch0/R9PHzUwqea@hirez.programming.kicks-ass.net>
References: <20210924085104.44806-1-21cnbao@gmail.com>
 <CAGsJ_4yW72mktbWjRfE9ngXoq9oXBXyAd_TPjKBNdGiRSoh9LA@mail.gmail.com>
 <CAKfTPtAtfJRFBbo+kBCYf42hxcc2iP8kkmg3Wcr5aW7Rnf=rfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAtfJRFBbo+kBCYf42hxcc2iP8kkmg3Wcr5aW7Rnf=rfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 01, 2021 at 12:39:56PM +0200, Vincent Guittot wrote:
> Hi Barry,
> 
> On Fri, 1 Oct 2021 at 12:32, Barry Song <21cnbao@gmail.com> wrote:
> >
> > Hi Vincent, Dietmar, Peter, Ingo,
> > Do you have any comment on this first series which exposes cluster topology
> > of ARM64 kunpeng 920 & x86 Jacobsville and supports load balance only for
> > the 1st stage?
> > I will be very grateful for your comments so that things can move forward in the
> > right direction. I think Tim also looks forward to bringing up cluster
> > support in
> > Jacobsville.
> 
> This patchset makes sense to me and the addition of a new scheduling
> level to better reflect the HW topology goes in the right direction.

So I had a look, dreading the selecti-idle-sibling changes, and was
pleasantly surprised they're gone :-)

As is, this does indeed look like something mergable without too much
hassle.

The one questino I have is, do we want default y?

The one nit I have is the Kconfig text, I'm not really sure that's
clarifying what a cluster is.
