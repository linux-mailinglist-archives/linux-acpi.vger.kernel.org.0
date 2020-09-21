Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5E82725B6
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Sep 2020 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgIUNih (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Sep 2020 09:38:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36662 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIUNih (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2020 09:38:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id v20so16970658oiv.3;
        Mon, 21 Sep 2020 06:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSWQnEKiuYpWFuL0GlqNB3rWT28drzm44fyf6QaZ998=;
        b=UDWUQi+v9J2mqEJHdkQSANpE88miRRG+LICnUd4HW2VedBcyOroECR0ktPujcOpTkR
         LxidJaaLvVeTx/eJRBJcF7Bf5n1v91dEw96dT1mQz9iiqo007iOZY1scAPFzS4m2JV6p
         We4Y1w5Okg1XWlbedrgJyEhLA2vN1ALxFVnq75Pu/ykX+s5DQucgOkD9pNIMba/GjyZs
         z0qfC/AnUC27lWuCkVJ8x+8b3EwRAmSNm+9K6fnCpthCkN8IhBfQb3UZMHZ/bV/lAES9
         UWtGIGF7UvzepTCxkHhqb+IwUZPCvl51GVq4o8895PTEHqENnGgvciLVSe7XR5wo0dRl
         X2lg==
X-Gm-Message-State: AOAM531IyY7Crj+MEnWUTEMxZGP3NmLWR+rGZnf33U4XedR6Zp669ESx
        BpMygxMM5UZB6MoBmeeec1BwtN7QsdJnQ556gC8=
X-Google-Smtp-Source: ABdhPJzs5UDYgSMy4tnWujzK/549Voo/vAlxwsHSm01113gE4DORwVsmLSBZGA8MZib8+DoFXni+j5LqTsOGwV++BXM=
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr18361312oid.110.1600695516463;
 Mon, 21 Sep 2020 06:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200915103157.345404192@infradead.org> <20200915103806.479637218@infradead.org>
 <87wo0npk72.fsf@turtle.gmx.de> <20200921103741.GC5901@zn.tnic> <20200921133241.GB29330@paulmck-ThinkPad-P72>
In-Reply-To: <20200921133241.GB29330@paulmck-ThinkPad-P72>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Sep 2020 15:38:21 +0200
Message-ID: <CAJZ5v0jVerU92WxL4qCoU6NC0KCyszmRNhpL3tu5LYtMqALd9A@mail.gmail.com>
Subject: Re: [PATCH] rcu/tree: Export rcu_idle_{enter,exit} to module
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Sven Joachim <svenjoac@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 21, 2020 at 3:32 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Sep 21, 2020 at 12:37:41PM +0200, Borislav Petkov wrote:
> > Lemme add whatever get_maintainer spits, to Cc.
> >
> > On Mon, Sep 21, 2020 at 11:12:33AM +0200, Sven Joachim wrote:
> > > On 2020-09-15 12:32 +0200, Peter Zijlstra wrote:
> > >
> > > > The C3 BusMaster idle code takes lock in a number of places, some deep
> > > > inside the ACPI code. Instead of wrapping it all in RCU_NONIDLE, have
> > > > the driver take over RCU-idle duty and avoid flipping RCU state back
> > > > and forth a lot.
> > > >
> > > > ( by marking 'C3 && bm_check' as RCU_IDLE, we _must_ call enter_bm() for
> > > >   that combination, otherwise we'll loose RCU-idle, this requires
> > > >   shuffling some code around )
> > > >
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > >
> > > I got modpost errors in 5.9-rc6 after this patch:
> > >
> > > ERROR: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!
> > > ERROR: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!
> > >
> > > Reverting commit 1fecfdbb7acc made them go away.  Notably my
> > > configuration had CONFIG_ACPI_PROCESSOR=m,  changing that
> > > to CONFIG_ACPI_PROCESSOR=y let the build succeed as well.
> >
> > I guess this. Running randconfigs on it for a while, to see what else
> > breaks.
> >
> > ---
> > From: Borislav Petkov <bp@suse.de>
> > Date: Mon, 21 Sep 2020 12:31:36 +0200
> >
> > Fix this link error:
> >
> >   ERROR: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!
> >   ERROR: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!
> >
> > when CONFIG_ACPI_PROCESSOR is built as module. PeterZ says that in light
> > of ARM needing those soon too, they should simply be exported.
> >
> > Fixes: 1fecfdbb7acc ("ACPI: processor: Take over RCU-idle for C3-BM idle")
> > Reported-by: Sven Joachim <svenjoac@gmx.de>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Borislav Petkov <bp@suse.de>
>
> Reviewed-by: Paul E. McKenney <paulmckrcu@kernel.org>

OK

Applied as 5.9-rc7 material, thanks!

> > ---
> >  kernel/rcu/tree.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 8ce77d9ac716..f78ee759af9c 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -673,6 +673,7 @@ void rcu_idle_enter(void)
> >       lockdep_assert_irqs_disabled();
> >       rcu_eqs_enter(false);
> >  }
> > +EXPORT_SYMBOL_GPL(rcu_idle_enter);
> >
> >  #ifdef CONFIG_NO_HZ_FULL
> >  /**
> > @@ -886,6 +887,7 @@ void rcu_idle_exit(void)
> >       rcu_eqs_exit(false);
> >       local_irq_restore(flags);
> >  }
> > +EXPORT_SYMBOL_GPL(rcu_idle_exit);
> >
> >  #ifdef CONFIG_NO_HZ_FULL
> >  /**
> > --
> > 2.21.0
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > https://people.kernel.org/tglx/notes-about-netiquette
