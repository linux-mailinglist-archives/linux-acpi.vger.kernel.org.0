Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB01B167987
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2020 10:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgBUJg2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 21 Feb 2020 04:36:28 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:61518 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727840AbgBUJg2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Feb 2020 04:36:28 -0500
X-Greylist: delayed 989 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Feb 2020 04:36:27 EST
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20298788-1500050 
        for multiple; Fri, 21 Feb 2020 09:19:51 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <4974198.mf5Me8BlfX@kreacher>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <158197497594.2449.9692451182044632969@skylake-alporthouse-com>
 <10791544.HYfhKnFLvn@kreacher> <4974198.mf5Me8BlfX@kreacher>
Message-ID: <158227678951.3099.15076882205129643027@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: Linux 5.6-rc2
Date:   Fri, 21 Feb 2020 09:19:49 +0000
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Quoting Rafael J. Wysocki (2020-02-21 00:46:18)
> On Thursday, February 20, 2020 11:41:22 PM CET Rafael J. Wysocki wrote:
> > On Monday, February 17, 2020 10:29:35 PM CET Chris Wilson wrote:
> > > Quoting Linus Torvalds (2020-02-17 21:20:27)
> > > > On Mon, Feb 17, 2020 at 8:22 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > > > >
> > > > > Quoting Linus Torvalds (2020-02-16 21:32:32)
> > > > > > Rafael J. Wysocki (4):
> > > > > >       ACPI: EC: Fix flushing of pending work
> > > > > >       ACPI: PM: s2idle: Avoid possible race related to the EC GPE
> > > > > >       ACPICA: Introduce acpi_any_gpe_status_set()
> > > > > >       ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system
> > > > >
> > > > > Our S0 testing broke on all platforms, so we've reverted
> > > > > e3728b50cd9b ("ACPI: PM: s2idle: Avoid possible race related to the EC GPE")
> > > > > fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system")
> > > > >
> > > > > There wasn't much in the logs, for example,
> > > > > https://intel-gfx-ci.01.org/tree/drm-tip/IGT_5445/fi-kbl-7500u/igt@gem_exec_suspend@basic-s0.html
> > > > 
> > > > So the machine suspends, but never comes back?
> > > > 
> > > > Do you need to revert both for it to work for you? Or is the revert of
> > > > fdde0ff8590b just to avoid the conflict?
> > > 
> > > fdde0ff85 was just to avoid conflicts.
> > >  
> > > > I'm assuming you bisected this, and the bisect indicated e3728b50cd9b,
> > > > and then to revert it you reverted the other commit too..
> > > 
> > > Lucky guess based on diff rc1..rc2. Bisect was going to be painful, but
> > > could be done if this is not enough clue for Rafael.
> > 
> > Sorry for the delayed response, was away.
> > 
> > I'm guessing that you are using rtcwake for wakeup, in which case reverting
> > fdde0ff85 alone should unbreak it.
> > 
> > Can you please double check that?
> 
> And below is a patch that should fix it if I'm not mistaken (verified on my
> system where I was able to reproduce the issue), so it would suffice to test
> this one on top of the -rc2.

Correct on both accounts. Reverting fdde0ff85 alone was enough, and
replacing the reverts with the suggested patch works.

> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] ACPI: PM: s2idle: Check fixed wakeup events in acpi_s2idle_wake()
> 
> Commit fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from
> waking up the system") overlooked the fact that fixed events can wake
> up the system too and broke RTC wakeup from suspend-to-idle as a
> result.
> 
> Fix this issue by checking the fixed events in acpi_s2idle_wake() in
> addition to checking wakeup GPEs and break out of the suspend-to-idle
> loop if the status bits of any enabled fixed events are set then.
> 
> Fixes: fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system")
> Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
