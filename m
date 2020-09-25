Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C7B278CA8
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 17:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgIYP3G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 11:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbgIYP3G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Sep 2020 11:29:06 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2B10235F9;
        Fri, 25 Sep 2020 15:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601047745;
        bh=rOVcj/V35cyfMa0Vlg8hucdK+66n/l/bpxjyII5KeJ0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=twt0N8Abp9/Po1t9micl7QeynkbSKIgF9pG47HY5rYmOCvHWpfcRB8LlA0LlSnx9V
         g+4xPB19lcoxmjeyuhvrwqjDXjp5yJ++pbQ6b/b92WxI4prVpFXhmQze82tVUECRxY
         cC5FYO6TCIx4vwuYHKIuzmxdED0g6N13t8dQuh9M=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 98E1035207C1; Fri, 25 Sep 2020 08:29:05 -0700 (PDT)
Date:   Fri, 25 Sep 2020 08:29:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        bp@alien8.de, x86@kernel.org, tony.luck@intel.com, lenb@kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, tglx@linutronix.de,
        naresh.kamboju@linaro.org
Subject: Re: [RFC][PATCH 4/4] acpi: Take over RCU-idle for C3-BM idle
Message-ID: <20200925152905.GE29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200915103157.345404192@infradead.org>
 <20200915103806.479637218@infradead.org>
 <20200925152000.GA171076@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925152000.GA171076@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 25, 2020 at 08:20:00AM -0700, Guenter Roeck wrote:
> On Tue, Sep 15, 2020 at 12:32:01PM +0200, Peter Zijlstra wrote:
> > The C3 BusMaster idle code takes lock in a number of places, some deep
> > inside the ACPI code. Instead of wrapping it all in RCU_NONIDLE, have
> > the driver take over RCU-idle duty and avoid flipping RCU state back
> > and forth a lot.
> > 
> > ( by marking 'C3 && bm_check' as RCU_IDLE, we _must_ call enter_bm() for
> >   that combination, otherwise we'll loose RCU-idle, this requires
> >   shuffling some code around )
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> ia64:defconfig:
> 
> ERROR: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!
> ERROR: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!
> 
> I realize that this has already been reported more than a week ago, with
> no visible reaction. Another problem introduced in the same file, resulting
> in
> 
> drivers/acpi/processor_idle.c: In function 'lapic_timer_needs_broadcast':
> drivers/acpi/processor_idle.c:179:1: warning:
> 	no return statement in function returning non-void
> 
> may cause ia64 boot problems since a non-zero return value will trigger
> a function call. AFAICS that is not supposed to happen on ia64.
> 
> This makes me wonder - if no one cares about buiding (much less running)
> ia64 images with the upstream kernel, is it possibly time to remove it ?

Rafael is taking a fix up his cpuidle tree:

https://lkml.kernel.org/lkml/CAJZ5v0jVerU92WxL4qCoU6NC0KCyszmRNhpL3tu5LYtMqALd9A@mail.gmail.com/

							Thanx, Paul
