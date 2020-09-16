Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD6E26C99D
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 21:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgIPRkN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Sep 2020 13:40:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38225 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgIPRiw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Sep 2020 13:38:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id y6so9034005oie.5;
        Wed, 16 Sep 2020 10:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uo+bA2t+v8v9rdUgKJFXxm1RCRKONpBn25AFgkBx9ik=;
        b=pohnJdV4dyKaApvk4rEKGR4wJT7PxXalx1PCqc5tT7GWTJmYBSvqqCcap0nPnmG+sy
         41ebR4T+d7EiV0oLS1Uu8riH4emmcU1bmkX3TtSt4TPuU+qvcJ9o5C229F032l244kRX
         5xLO4F5Wfve1+eC4UU3ee1dODWcLg/7oBOcJkyKMXKssC+5sis+QFcgaYoNFbsEba/t0
         jO19W772QQxWEjq+vQx99zQwsAVpAGL0Al4rBoev3ugC8ekTnyTbRl1V+7fQVLegHgyT
         2F202oacD/zzrqR4R0D6EAMOcHSwnFzR0vEWhT2XIHQZIC+KLePv458UMf5kb3N32XG2
         k5Rw==
X-Gm-Message-State: AOAM5324t5Q6AsDNUq+Ek45t3tuKYPYgoVY11BH7mChdNzXObVxm+EaP
        evba/dvTKL+SGnWSvAXM2fRtoTjiNCnZRyKBUxw=
X-Google-Smtp-Source: ABdhPJxKiT1YuF0AdZqj480R8CGXOdyh+gY1WMAgZYKGUe42WAoaznb7Rgjd8TkTrpfN6bfgY2Y++/jCvW4nXWM2fEo=
X-Received: by 2002:aca:5b09:: with SMTP id p9mr3309069oib.68.1600277927809;
 Wed, 16 Sep 2020 10:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200915103157.345404192@infradead.org> <20200915103806.280265587@infradead.org>
 <CAJZ5v0jD-Lv5WAKHd9KN8sPozN4DeA-sQ4pXZTHNSZ4XS=as3A@mail.gmail.com>
 <20200916154212.GE1362448@hirez.programming.kicks-ass.net> <20200916160103.GL2643@zn.tnic>
In-Reply-To: <20200916160103.GL2643@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Sep 2020 19:38:36 +0200
Message-ID: <CAJZ5v0hrfhUm+nF0ARnpNEH85EkpsjYZSqfjhh0a5KjUEpjdjA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/4] acpi: Use CPUIDLE_FLAG_TIMER_STOP
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 16, 2020 at 6:01 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 16, 2020 at 05:42:12PM +0200, peterz@infradead.org wrote:
> > On Tue, Sep 15, 2020 at 06:26:52PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Sep 15, 2020 at 12:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > Make acpi_processor_idle use the common broadcast code, there's no
> > > > reason not to. This also removes some RCU usage after
> > > > rcu_idle_enter().
> > > >
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > >
> > > The whole series looks good to me, so please feel free to add
> > >
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > to all of the four patches.
> > >
> > > Alternatively, please let me know if you want me to take the patches.
> >
> > Feel free to take them. All the prerequisite borkage is in linus' tree
> > already.
>
> You can add:
>
> Reported-by: Borislav Petkov <bp@suse.de>
>
> for this one and for this whole series:
>
> Tested-by: Borislav Petkov <bp@suse.de>

Done.
