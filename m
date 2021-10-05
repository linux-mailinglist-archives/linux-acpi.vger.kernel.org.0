Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A45A421FB7
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 09:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhJEHy0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 03:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhJEHyZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Oct 2021 03:54:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE4EC061745;
        Tue,  5 Oct 2021 00:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mb1ebH9NpOSymYrwurOQhqV4b/SOhG5oKbLWs3+sfew=; b=eQ40yLk9ADR7QoIBFAGVtqfh1z
        yFBhjqJavAeCCAC2q1KmrTt8NGc5h4kV3Qt/oBP0X+HCCCdEeRosZIqJQHv9K8lU241tPMEt0G5gU
        yB8Bj3pmYv+iJApBI1FNtZHArI9U/f4Dl7i15fhMXq4WEvVhYP4VRXboYlyoub2/+O4AqZylpPdFu
        gxq2H4p9gNXQx70rS3sdPZWm0LEorWFMXpYrDnN2gQ28IM9G7Z4/48H2OEPf0KIUQ2304hHpWmJhv
        VF1R66f+sQwbJ5iLqyAg2Q/Pgt2T5qnaV96eHMAet5f/4Q8jCiuKCeooSlgkggp7FxjFDRQI7Eh3r
        nRo7wSyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXfD7-0006aO-Vb; Tue, 05 Oct 2021 07:50:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44E8F98631C; Tue,  5 Oct 2021 09:50:01 +0200 (CEST)
Date:   Tue, 5 Oct 2021 09:50:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Barry Song <21cnbao@gmail.com>,
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
Message-ID: <20211005075001.GJ4323@worktop.programming.kicks-ass.net>
References: <20210924085104.44806-1-21cnbao@gmail.com>
 <CAGsJ_4yW72mktbWjRfE9ngXoq9oXBXyAd_TPjKBNdGiRSoh9LA@mail.gmail.com>
 <CAKfTPtAtfJRFBbo+kBCYf42hxcc2iP8kkmg3Wcr5aW7Rnf=rfw@mail.gmail.com>
 <YVch0/R9PHzUwqea@hirez.programming.kicks-ass.net>
 <ece8838d112840bf26adbb09f653babcf298eb28.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ece8838d112840bf26adbb09f653babcf298eb28.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 01, 2021 at 04:22:46PM -0700, Tim Chen wrote:
> On Fri, 2021-10-01 at 16:57 +0200, Peter Zijlstra wrote:

> > The one questino I have is, do we want default y?
> 
> I also agree that default y is preferable.

I'll change at least the x86 one to:

	default y
	depends on SMP

> > The one nit I have is the Kconfig text, I'm not really sure that's
> > clarifying what a cluster is.
> 
> Do you have a preference of a different name other than cluster?
> Or simply better documentation on what a cluster is for ARM64
> and x86 in Kconfig?

Yes, better wording as to what a cluster is. Currently the x86 and arm64
ones actually differ:

x86:
	help
	 Cluster scheduler support improves the CPU scheduler's decision
	 making when dealing with machines that have clusters of CPUs
	 sharing L2 cache. If unsure say N here.

arm64:
	help
	  Cluster scheduler support improves the CPU scheduler's decision
	  making when dealing with machines that have clusters(sharing internal
	  bus or sharing LLC cache tag). If unsure say N here.


(also, all this stuff being replicated across arch/*/Kconfig seems
unfortunate)
