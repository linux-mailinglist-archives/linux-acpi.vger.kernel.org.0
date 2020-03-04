Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C96178DF9
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2020 11:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCDKEo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Mar 2020 05:04:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgCDKEo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2020 05:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=joc6mkpsAJhcX0YbSolxXtfYnAc+3nHjCaHtP4av6cA=; b=SJy5M/ffBE1p9hJhif0f8H62mq
        hEX2p1T7p2fmGz0zJQJ9bgotX/ie27/bPzy4ZJCya+QsQYcA/NGPslBJlpDuu6vodH+MwhcpHtoeO
        2OIX/ztQ/gj5RMwHNndjuRtPW37hpJwjphRsVknIRPL0MPH6snmxX3NaQLYoqucw37WVEO/MDQ+zb
        B72Zh6wpkL1i55feEvJSOZOfIxuelto44mvAjfgHREW57zd5/stIByD5PvGy3KvrOmym0opWWdzF6
        fGnrVFZSn3GPDp22KXP1pwYEuVB3PeUvNENlJjQve2/6BVzQolYNBjtIxWJmCIpfjkruLPPoSjBVj
        F4V3FnkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9QtL-0001om-Vx; Wed, 04 Mar 2020 10:04:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E35D3013A4;
        Wed,  4 Mar 2020 11:02:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12DBF20BCBDC5; Wed,  4 Mar 2020 11:04:38 +0100 (CET)
Date:   Wed, 4 Mar 2020 11:04:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     hpa@zytor.com
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, rjw@rjwysocki.net,
        lenb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, luto@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] x86/acpi: make "asmlinkage" part first thing in the
 function definition
Message-ID: <20200304100437.GM2596@hirez.programming.kicks-ass.net>
References: <20200303204144.GA9913@avx2>
 <9947D7CB-B9CD-47E0-BC5E-C7FC3A81FC7B@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9947D7CB-B9CD-47E0-BC5E-C7FC3A81FC7B@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 04, 2020 at 12:54:09AM -0800, hpa@zytor.com wrote:
> On March 3, 2020 12:41:44 PM PST, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >g++ insists that function declaration must start with extern "C"
> >(which asmlinkage expands to).
> >
> >gcc doesn't care.
> >
> >Signed-off-by: _Z6Alexeyv <adobriyan@gmail.com>
> >---
> >
> > arch/x86/kernel/acpi/sleep.c |    2 +-
> > arch/x86/kernel/acpi/sleep.h |    2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >
> >--- a/arch/x86/kernel/acpi/sleep.c
> >+++ b/arch/x86/kernel/acpi/sleep.c
> >@@ -43,7 +43,7 @@ unsigned long acpi_get_wakeup_address(void)
> >  *
> >  * Wrapper around acpi_enter_sleep_state() to be called by assmebly.
> >  */
> >-acpi_status asmlinkage __visible x86_acpi_enter_sleep_state(u8 state)
> >+asmlinkage acpi_status __visible x86_acpi_enter_sleep_state(u8 state)
> > {
> > 	return acpi_enter_sleep_state(state);
> > }
> >--- a/arch/x86/kernel/acpi/sleep.h
> >+++ b/arch/x86/kernel/acpi/sleep.h
> >@@ -19,4 +19,4 @@ extern void do_suspend_lowlevel(void);
> > 
> > extern int x86_acpi_suspend_lowlevel(void);
> > 
> >-acpi_status asmlinkage x86_acpi_enter_sleep_state(u8 state);
> >+asmlinkage acpi_status x86_acpi_enter_sleep_state(u8 state);
> 
> Are you building the kernel with C++?!

He is :-) IIRC he's got a whole bunch of patches that removes all the
C++ keywords from the kernel.
