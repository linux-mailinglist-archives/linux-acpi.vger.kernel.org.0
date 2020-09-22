Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D86A2748D3
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Sep 2020 21:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIVTKA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Sep 2020 15:10:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54314 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVTKA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Sep 2020 15:10:00 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 15:09:58 EDT
Received: from 89-64-89-53.dynamic.chello.pl (89.64.89.53) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.468)
 id 1a302cbbceee2e3b; Tue, 22 Sep 2020 21:03:16 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, bp@alien8.de,
        x86@kernel.org, tony.luck@intel.com, lenb@kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, paulmck@kernel.org, tglx@linutronix.de,
        naresh.kamboju@linaro.org
Subject: Re: [RFC][PATCH 1/4] acpi: Use CPUIDLE_FLAG_TIMER_STOP
Date:   Tue, 22 Sep 2020 21:03:15 +0200
Message-ID: <5947336.4NNQoPcqAU@kreacher>
In-Reply-To: <20200922032651.GA222679@roeck-us.net>
References: <20200915103157.345404192@infradead.org> <20200915103806.280265587@infradead.org> <20200922032651.GA222679@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, September 22, 2020 5:26:51 AM CEST Guenter Roeck wrote:
> On Tue, Sep 15, 2020 at 12:31:58PM +0200, Peter Zijlstra wrote:
> > Make acpi_processor_idle use the common broadcast code, there's no
> > reason not to. This also removes some RCU usage after
> > rcu_idle_enter().
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reported-by: Borislav Petkov <bp@suse.de>
> > Tested-by: Borislav Petkov <bp@suse.de>
> > ---
> >  drivers/acpi/processor_idle.c |   49 +++++++++++++-----------------------------
> >  1 file changed, 16 insertions(+), 33 deletions(-)
> > 
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -161,18 +161,10 @@ static void lapic_timer_propagate_broadc
> >  }
> >  
> >  /* Power(C) State timer broadcast control */
> > -static void lapic_timer_state_broadcast(struct acpi_processor *pr,
> > -				       struct acpi_processor_cx *cx,
> > -				       int broadcast)
> > -{
> > -	int state = cx - pr->power.states;
> > -
> > -	if (state >= pr->power.timer_broadcast_on_state) {
> > -		if (broadcast)
> > -			tick_broadcast_enter();
> > -		else
> > -			tick_broadcast_exit();
> > -	}
> > +static bool lapic_timer_needs_broadcast(struct acpi_processor *pr,
> > +					struct acpi_processor_cx *cx)
> > +{
> > +	return cx - pr->power.states >= pr->power.timer_broadcast_on_state;
> >  }
> >  
> >  #else
> > @@ -180,9 +172,9 @@ static void lapic_timer_state_broadcast(
> >  static void lapic_timer_check_state(int state, struct acpi_processor *pr,
> >  				   struct acpi_processor_cx *cstate) { }
> >  static void lapic_timer_propagate_broadcast(struct acpi_processor *pr) { }
> > -static void lapic_timer_state_broadcast(struct acpi_processor *pr,
> > -				       struct acpi_processor_cx *cx,
> > -				       int broadcast)
> > +
> > +static bool lapic_timer_needs_broadcast(struct acpi_processor *pr,
> > +					struct acpi_processor_cx *cx)
> >  {
> >  }
> 
> drivers/acpi/processor_idle.c: In function 'lapic_timer_needs_broadcast':
> drivers/acpi/processor_idle.c:179:1: warning: no return statement in function returning non-void [-Wreturn-type]
> 
> Should this return true or false ?

false - if the lapic timer doesn't stop, it doesn't need broadcast.

FWIW, patch appended.

Cheers!

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] ACPI: processor: Fix build for ARCH_APICTIMER_STOPS_ON_C3 unset

Fix the lapic_timer_needs_broadcast() stub for
ARCH_APICTIMER_STOPS_ON_C3 unset to actually return
a value.

Fixes: aa6b43d57f99 ("ACPI: processor: Use CPUIDLE_FLAG_TIMER_STOP")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -176,6 +176,7 @@ static void lapic_timer_propagate_broadc
 static bool lapic_timer_needs_broadcast(struct acpi_processor *pr,
 					struct acpi_processor_cx *cx)
 {
+	return false;
 }
 
 #endif



