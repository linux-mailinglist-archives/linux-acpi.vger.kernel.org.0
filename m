Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08DA3AB39A
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 14:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhFQMfB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 08:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhFQMfB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 08:35:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C696C061574;
        Thu, 17 Jun 2021 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=igLdM5gAj1GNrpSUNqrKYdGwdRX8s5YgHkDIgpNMiug=; b=St2bcCZpEwPZfBBz5+xnUjm4Sz
        fjFTY6VO1NGT233XchAtHKwxXAsj1jEGDnQZ9AwAs3nNkSywP54dlmAndmyK+nriEMPgNR2mefIK/
        28VZlBFj7Y+OSXYiAUcP7JIcPTCRQj15zDA4U1XaLkt6VAQUsHMs8WAahtZDVEAUIXd7U5YA6bNfr
        u+yi8D0S3xpBmYv6Foa5xDHytmOmSkzoOJdK0FVqEVU64G84dLxPIyx95FFsF7HTnkw8n8LtfOfb7
        Io/bTjJ9Dx8PBSIDGAf0WciOxRlzKJTSckOPx8Cbh2IeQDBLPtD/cTsWzfJ9BaFKngJ2sh5vegAZD
        3Gjwq+rQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltrC4-008dKI-6D; Thu, 17 Jun 2021 12:32:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B84E300204;
        Thu, 17 Jun 2021 14:22:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62C292C885E37; Thu, 17 Jun 2021 14:22:28 +0200 (CEST)
Date:   Thu, 17 Jun 2021 14:22:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-pm@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] cpufreq: CPPC: Add support for frequency
 invariance
Message-ID: <YMs+hOKafJMu7Sfu@hirez.programming.kicks-ass.net>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <e7e653ede3ef54acc906d2bde47a3b9a41533404.1623825725.git.viresh.kumar@linaro.org>
 <20210616124806.GA6495@arm.com>
 <20210617032416.r2gfp25xxvhc5t4x@vireshk-i7>
 <20210617103415.GA29877@arm.com>
 <20210617111936.cfjzoh6g5zvolaf5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617111936.cfjzoh6g5zvolaf5@vireshk-i7>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 17, 2021 at 04:49:36PM +0530, Viresh Kumar wrote:
> Peter: Can you help here on this ? Lemme try to explain a bit here:
> 
> We are starting an irq-work (in cppc cpufreq driver) from
> scheduler_tick()->arch_scale_freq_tick(). What will happen if the driver doesn't
> take care of CPU hotplug explicitly and make sure this work isn't queued again
> from the next tick.
> 
> Is it important for user to make sure it gets rid of the irq-work during hotplug
> here ?

irq-work is flushed on hotplug, see smpcfd_dying_cpu().
