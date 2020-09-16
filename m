Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD0326CD17
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 22:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgIPUxl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Sep 2020 16:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgIPQyL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Sep 2020 12:54:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9A3C02C2B1;
        Wed, 16 Sep 2020 08:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CwFFF72PkRXOfn/Nz6ud0X1OPtJVEVOQmrEtxSDPsHI=; b=Zo0GEMiB5cgG3KX5mFc9Jv6DYI
        mtnIJgJ+tQupUj2w/gxjNzLZtGrUy8/YPiqFdXDbUU6ipl10lHkmkRnLKU1OBAf+yYzD0qlIHzBsa
        n2fckjiG5Nk28qW81ODeFw7mECxTk8WzhR1KPiO2/yiP787/6cZ0petv2kxqprPQKouDu5GY3Gm/o
        AtCZd6foovLBIxHFOUEYloxMQMpybn//uSuD8BpwNHeQJVFoTe3rL1KaQNJg/goddC3itz/tWc+en
        YLPOMp6P7kTLI5RClDCQ3rkjy5KQo3p6b38sM/h7+9wB1C2z57FBECj52XYMJQe2Qp2A2mX85Jlrq
        JDRkx/Dg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIZZV-0008Gk-6q; Wed, 16 Sep 2020 15:42:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9305F3019CE;
        Wed, 16 Sep 2020 17:42:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B8642B76FF92; Wed, 16 Sep 2020 17:42:12 +0200 (CEST)
Date:   Wed, 16 Sep 2020 17:42:12 +0200
From:   peterz@infradead.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [RFC][PATCH 1/4] acpi: Use CPUIDLE_FLAG_TIMER_STOP
Message-ID: <20200916154212.GE1362448@hirez.programming.kicks-ass.net>
References: <20200915103157.345404192@infradead.org>
 <20200915103806.280265587@infradead.org>
 <CAJZ5v0jD-Lv5WAKHd9KN8sPozN4DeA-sQ4pXZTHNSZ4XS=as3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jD-Lv5WAKHd9KN8sPozN4DeA-sQ4pXZTHNSZ4XS=as3A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 15, 2020 at 06:26:52PM +0200, Rafael J. Wysocki wrote:
> On Tue, Sep 15, 2020 at 12:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Make acpi_processor_idle use the common broadcast code, there's no
> > reason not to. This also removes some RCU usage after
> > rcu_idle_enter().
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> The whole series looks good to me, so please feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to all of the four patches.
> 
> Alternatively, please let me know if you want me to take the patches.

Feel free to take them. All the prerequisite borkage is in linus' tree
already.
