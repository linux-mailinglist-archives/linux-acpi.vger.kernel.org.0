Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C672E2925EA
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 12:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgJSKfk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Oct 2020 06:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgJSKfk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Oct 2020 06:35:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52CCC0613CE;
        Mon, 19 Oct 2020 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QTqxinLDqhGWunrGo2Vey4FANtKxhB0DhE5GYNhdIW4=; b=ZoZkBMcdjYDk9LBlotaR87jlZI
        ULT1kDWsXnPuHoHbU5L4aN+aeV1NoBV8TvUqibfsdJlfaxDw6Ui7NzgWfiVAFYa7u0R3UT/rONj6+
        XSj53jV3QqRcoiMw4lbRORN2Bl6VqWUWcTiBSzzLfOXDLv1xtKdnO26+WxeySnLhLJsqPE35LONhF
        SwV8iiieIwCLKT8C79ok4f2TyEH6ss36vWT2hF8ls5raovK8eCTy5iatJi1E4/aSIPTo/vT1Z+Q4N
        CkXDECbNHgXC4Jl1Kll4FsMdhg4IcmADmY4CRANwhXsrIzJB/1KPtKke65Y64jTe7FEyoDGAWci3A
        0IxQyVSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUSVi-0001Du-QW; Mon, 19 Oct 2020 10:35:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 200BC30411F;
        Mon, 19 Oct 2020 12:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0DED32214E421; Mon, 19 Oct 2020 12:35:22 +0200 (CEST)
Date:   Mon, 19 Oct 2020 12:35:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>, guohanjun@huawei.com,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Brice Goglin <Brice.Goglin@inria.fr>,
        valentin.schneider@arm.com
Subject: Re: [RFC PATCH] topology: Represent clusters of CPUs within a die.
Message-ID: <20201019103522.GK2628@hirez.programming.kicks-ass.net>
References: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 16, 2020 at 11:27:02PM +0800, Jonathan Cameron wrote:
> Both ACPI and DT provide the ability to describe additional layers of
> topology between that of individual cores and higher level constructs
> such as the level at which the last level cache is shared.
> In ACPI this can be represented in PPTT as a Processor Hierarchy
> Node Structure [1] that is the parent of the CPU cores and in turn
> has a parent Processor Hierarchy Nodes Structure representing
> a higher level of topology.
> 
> For example Kunpeng 920 has clusters of 4 CPUs.  These do not share
> any cache resources, but the interconnect topology is such that
> the cost to transfer ownership of a cacheline between CPUs within
> a cluster is lower than between CPUs in different clusters on the same
> die.   Hence, it can make sense to deliberately schedule threads
> sharing data to a single cluster.
> 
> This patch simply exposes this information to userspace libraries
> like hwloc by providing cluster_cpus and related sysfs attributes.
> PoC of HWLOC support at [2].
> 
> Note this patch only handle the ACPI case.
> 
> Special consideration is needed for SMT processors, where it is
> necessary to move 2 levels up the hierarchy from the leaf nodes
> (thus skipping the processor core level).

I'm confused by all of this. The core level is exactly what you seem to
want.
