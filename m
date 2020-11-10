Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCE82AD2D7
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 10:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbgKJJur (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 04:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730986AbgKJJui (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 04:50:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BDDC0613CF;
        Tue, 10 Nov 2020 01:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h/QuuhQzJIKNEshRV4JObUP9JnXT6hiQc+XRNbc6EKU=; b=L6ve+VJ8MIdpdfcTUjyU7ACwuQ
        62AHj6TjM9s5JBvhkB7HNmByOGo957l2xuEsNCNY+w+dyAL4s7VNEQ13Yp03/lhD00l6L4jQXfEnk
        927PF5PU+MA+kJwblYmD2gfpoMdUx1wev1cLvnbk0PXg+8Vg60V8LnrFruKmeF5NRZwUtSufnSh+3
        SDljBDkqniGl56ai4fJiW1wtaZ1TKa91b9uo53PXgqB4CN2LQO2l9ER5YDTCSUs7hPEpyBh6I+qIX
        l13DnBOwvyT2o+8641Hq0bzqt8/K7wHo7Hn+KUZgSvm7WTIlmgsjdZGZt5QDqUKW93+A5LeAJS/kf
        pUH8Eu+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcQHr-0003KR-32; Tue, 10 Nov 2020 09:50:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D47A0300238;
        Tue, 10 Nov 2020 10:49:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C13DC23268B86; Tue, 10 Nov 2020 10:49:56 +0100 (CET)
Date:   Tue, 10 Nov 2020 10:49:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/3] x86, sched: Calculate frequency invariance for AMD
 systems
Message-ID: <20201110094956.GZ2594@hirez.programming.kicks-ass.net>
References: <20201110083936.31994-1-ggherdovich@suse.cz>
 <20201110083936.31994-2-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110083936.31994-2-ggherdovich@suse.cz>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2020 at 09:39:34AM +0100, Giovanni Gherdovich wrote:

> +#ifdef CONFIG_ACPI
> +void init_freq_invariance_cppc(void)
> +{
> +	init_freq_invariance(false, true);
> +
> +	if (static_branch_likely(&arch_scale_freq_key))
> +		on_each_cpu(init_counter_refs, NULL, 0);
> +}
> +#endif
> +
>  static void disable_freq_invariance_workfn(struct work_struct *work)
>  {
>  	static_branch_disable(&arch_scale_freq_key);

> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7a99b19bb893..e1969ff876ff 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -39,6 +39,7 @@
>  #include <linux/ktime.h>
>  #include <linux/rwsem.h>
>  #include <linux/wait.h>
> +#include <linux/topology.h>
>  
>  #include <acpi/cppc_acpi.h>
>  
> @@ -850,6 +851,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  		goto out_free;
>  	}
>  
> +	/* Only needed once, so call on CPU0 */
> +	if (pr->id == 0)
> +		init_freq_invariance_cppc();
> +

This seems broken vs lovely things like booting with maxcpus= or
physical hotplug where you add logical CPUs.

Given the latter hunk limits it to one invocation (is phys_id 0
guaranteed to exist? Can a BIOS monkey screw us over?) only to then call
it on all CPUs, shouldn't this be changed to let
acpi_cppc_processor_probe() call it for every CPU that comes online?
