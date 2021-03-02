Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B829E32A4D4
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Mar 2021 16:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446547AbhCBLSO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 06:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349609AbhCBKmx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2021 05:42:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AFBC061756;
        Tue,  2 Mar 2021 02:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F6qthdef1oL7Dk4r+O4vHCgwbdrKqGXK0mSoEWD6Tpc=; b=W+9iyS0S3xZXDQMTKv9qOoTbzq
        DETq9J4HXqzXK/klgSYLlMOK2j/kdfZWBrB0fBGtlt1q0w/obZsTjvoAYpZE8HF31nrd7XN5Gn76t
        r9xbdsXrADg4IHbklIeF6IcDi21Lj8Y3Fw+mdQ4Vi6fHd3hpybYHZ6QrOXUBRlC+V9226IaJYmO1s
        ndNDO1/3QW3UMM9Gv1WjOzViE6jNTqtkbzO0QByeIGWVrC22/q7n68glVpLDE7M04N/2KoDEAuf1C
        DApoVmodqrRISvRz07oIbtIwkYDWnj1ZyMz4QhWp1A6IHJ0Vlr+sTJGdc837OAp0zKLJMHYtMK5kA
        z0kSNvmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lH2If-00Gwg8-TI; Tue, 02 Mar 2021 10:30:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26904306BCA;
        Tue,  2 Mar 2021 11:30:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 173262027C1AA; Tue,  2 Mar 2021 11:30:43 +0100 (CET)
Date:   Tue, 2 Mar 2021 11:30:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     tim.c.chen@linux.intel.com, catalin.marinas@arm.com,
        will@kernel.org, rjw@rjwysocki.net, vincent.guittot@linaro.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        lenb@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, msys.mizuma@gmail.com,
        valentin.schneider@arm.com, gregkh@linuxfoundation.org,
        jonathan.cameron@huawei.com, juri.lelli@redhat.com,
        mark.rutland@arm.com, sudeep.holla@arm.com,
        aubrey.li@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, xuwei5@huawei.com, prime.zeng@hisilicon.com,
        guodong.xu@linaro.org, yangyicong@huawei.com,
        liguozhu@hisilicon.com, linuxarm@openeuler.org, hpa@zytor.com
Subject: Re: [RFC PATCH v4 3/3] scheduler: Add cluster scheduler level for x86
Message-ID: <YD4T0qBBgR6fPbQb@hirez.programming.kicks-ass.net>
References: <20210301225940.16728-1-song.bao.hua@hisilicon.com>
 <20210301225940.16728-4-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301225940.16728-4-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 02, 2021 at 11:59:40AM +1300, Barry Song wrote:
> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> There are x86 CPU architectures (e.g. Jacobsville) where L2 cahce
> is shared among a cluster of cores instead of being exclusive
> to one single core.

Isn't that most atoms one way or another? Tremont seems to have it per 4
cores, but earlier it was per 2 cores.
