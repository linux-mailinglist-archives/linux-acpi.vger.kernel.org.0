Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B66127259D
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Sep 2020 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgIUNcm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Sep 2020 09:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgIUNcm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Sep 2020 09:32:42 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8F62207C3;
        Mon, 21 Sep 2020 13:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600695161;
        bh=QNhlBi6lTl9xfjIdbg7JvRCpeE5h4ZjLWJuKLQlH/GE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wicSCh3ti1lEJiKfhwM/KyC5vBSp+hnNEp/ZdjauWZqEC7xSJNMmoh5Ug1DmBtXsJ
         2org7picp45q5FxUzyuWOlJNbFoC5mocge2bzQv4X8Uy7fVl6wEnBnNbz3rMtruWUr
         OgzHmLO5//z0YiCwV6YWfuybB+qbXGSZwZ4mESw4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8B60E35227BD; Mon, 21 Sep 2020 06:32:41 -0700 (PDT)
Date:   Mon, 21 Sep 2020 06:32:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sven Joachim <svenjoac@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        x86@kernel.org, tony.luck@intel.com, lenb@kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, tglx@linutronix.de,
        naresh.kamboju@linaro.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Export rcu_idle_{enter,exit} to module
Message-ID: <20200921133241.GB29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200915103157.345404192@infradead.org>
 <20200915103806.479637218@infradead.org>
 <87wo0npk72.fsf@turtle.gmx.de>
 <20200921103741.GC5901@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921103741.GC5901@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 21, 2020 at 12:37:41PM +0200, Borislav Petkov wrote:
> Lemme add whatever get_maintainer spits, to Cc.
> 
> On Mon, Sep 21, 2020 at 11:12:33AM +0200, Sven Joachim wrote:
> > On 2020-09-15 12:32 +0200, Peter Zijlstra wrote:
> > 
> > > The C3 BusMaster idle code takes lock in a number of places, some deep
> > > inside the ACPI code. Instead of wrapping it all in RCU_NONIDLE, have
> > > the driver take over RCU-idle duty and avoid flipping RCU state back
> > > and forth a lot.
> > >
> > > ( by marking 'C3 && bm_check' as RCU_IDLE, we _must_ call enter_bm() for
> > >   that combination, otherwise we'll loose RCU-idle, this requires
> > >   shuffling some code around )
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > I got modpost errors in 5.9-rc6 after this patch:
> > 
> > ERROR: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!
> > ERROR: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!
> > 
> > Reverting commit 1fecfdbb7acc made them go away.  Notably my
> > configuration had CONFIG_ACPI_PROCESSOR=m,  changing that
> > to CONFIG_ACPI_PROCESSOR=y let the build succeed as well.
> 
> I guess this. Running randconfigs on it for a while, to see what else
> breaks.
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Mon, 21 Sep 2020 12:31:36 +0200
> 
> Fix this link error:
> 
>   ERROR: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!
>   ERROR: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!
> 
> when CONFIG_ACPI_PROCESSOR is built as module. PeterZ says that in light
> of ARM needing those soon too, they should simply be exported.
> 
> Fixes: 1fecfdbb7acc ("ACPI: processor: Take over RCU-idle for C3-BM idle")
> Reported-by: Sven Joachim <svenjoac@gmx.de>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Paul E. McKenney <paulmckrcu@kernel.org>

> ---
>  kernel/rcu/tree.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8ce77d9ac716..f78ee759af9c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -673,6 +673,7 @@ void rcu_idle_enter(void)
>  	lockdep_assert_irqs_disabled();
>  	rcu_eqs_enter(false);
>  }
> +EXPORT_SYMBOL_GPL(rcu_idle_enter);
>  
>  #ifdef CONFIG_NO_HZ_FULL
>  /**
> @@ -886,6 +887,7 @@ void rcu_idle_exit(void)
>  	rcu_eqs_exit(false);
>  	local_irq_restore(flags);
>  }
> +EXPORT_SYMBOL_GPL(rcu_idle_exit);
>  
>  #ifdef CONFIG_NO_HZ_FULL
>  /**
> -- 
> 2.21.0
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
