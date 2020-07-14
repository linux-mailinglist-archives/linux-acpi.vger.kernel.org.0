Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EDA21F6CA
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jul 2020 18:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgGNQKZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Jul 2020 12:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgGNQKZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jul 2020 12:10:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16722C061755;
        Tue, 14 Jul 2020 09:10:25 -0700 (PDT)
Date:   Tue, 14 Jul 2020 18:10:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594743023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jgJUiW6S/kN6tTcBjma7MrcZFC3DmxgiA9URsv4EsU8=;
        b=oO2la2kywcvt42f81gP0SRIMfcB10xBaqzb3G8NYdaxajM1PirdTtr1sgaFnCQ4yQerr4A
        DMixhPZIJUfVMXN8eSm6dJkChdbexabni2TfuM0wmmfx7iSQz4qm2hMGy4Vz9aJuP19cK6
        25/SGE8E1Lvd6Pgn1zCRNF8nWH80H7kWtAdcNtUs0wWJiyJF/sZuvogogqKSNzuWSdkkF4
        AQITdg3hEGgWg4ImZer5SKsMvDBLu/L6+WT/YJQSLwG4tmNt8KV6+Z6yErKUIZfwR9kCis
        Y+smOjikRPufY2NkTKXk4NnZBfcSL74f5S9LYnuLHurKsl3k/GPvpFIuMHUPDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594743023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jgJUiW6S/kN6tTcBjma7MrcZFC3DmxgiA9URsv4EsU8=;
        b=ki+w0yJT5ysLcMWCjlIS9M+NOkrfL9G7d2hAo0F3fcb905dnNgUaV0k8ftcKtxl7PxGrwP
        AJ1xzUr8xDGKvgAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Stephen Berman <stephen.berman@gmx.net>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200714161021.5rh2hjiucrwot7em@linutronix.de>
References: <20200616155501.psduxnisltitodme@linutronix.de>
 <871rmesqkk.fsf@gmx.net>
 <20200617142734.mxwfoblufmo6li5e@linutronix.de>
 <87ftatqu07.fsf@gmx.net>
 <20200624201156.xu6hel3drnhno6c3@linutronix.de>
 <87ftak2kxr.fsf@rub.de>
 <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
 <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com>
 <20200714141135.47adndrsdgpiqfy4@linutronix.de>
 <CAJZ5v0iogereapmhcFi=iXHsjnzmC26mewUSTY3+5O3ei5kfDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iogereapmhcFi=iXHsjnzmC26mewUSTY3+5O3ei5kfDQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-07-14 17:53:15 [+0200], Rafael J. Wysocki wrote:
> > shows the pattern and we nailed it down that it comes from
> > thermal_get_temp().
> 
> acpi_evaluate_integer() doesn't show up in the trace, though, AFAICS.

I deducted it. acpi_thermal_get_temperature() -> acpi_evaluate_integer()
and the dmesg showed
| ACPI: Invalid passive threshold
| thermal LNXTHERM:00: registered as thermal_zone0
| ACPI: Thermal Zone [TZ10] (17 C)
| thermal LNXTHERM:01: registered as thermal_zone1
| ACPI: Thermal Zone [TZ00] (28 C)

and overriding thermal.tzp to a higher value made the issue go away.
There is a complete dmesg
     https://lore.kernel.org/lkml/87v9l65d2y.fsf@gmx.net/

> > I assumed acpi_ex_opcode_2A_0T_0R() since the other
> > candidate was acpi_ev_asynch_execute_gpe_method().
> 
> Which probably is the case.  Specifically
> 
> acpi_ev_asynch_execute_gpe_method: Evaluate _L66
> 
> is likely to cause the Notify() to be dispatched.

Okay. I hope Stephen replies later with a backtrace.

> > Stephen, the patch attached adds a WARN_ON() statement which will
> > produce a stack trace (4 or so). Could please run 'dmesg' after a while
> > and send it back. There should be a
> >     "WARNING in drivers/acpi/acpica/evmisc.c"
> >
> > statement or something along the lines.
> >
> > Rafael, are you also interested in an ACPI dump?
> 
> That might help a bit.
> 
> So what probably happens is that poking at the TZ causes a GPE to
> trigger and a Notify() to be dispatched which then goes into the
> workqueue for execution.
> 
> Now, I'm not sure what happens to those Notify() items, though.  They
> each should cause a handler (in the thermal driver) to be executed,
> but does that happen?

Are you asking for a trace point in acpi_ev_notify_dispatch() to see
what it actually calls as in info->notify.global->handler /
handler_obj->notify.handler ?
There is no handler in the thermal driver or do I just not recognize it?

Sebastian
