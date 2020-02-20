Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C870166A78
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Feb 2020 23:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgBTWlZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Feb 2020 17:41:25 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48513 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgBTWlZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Feb 2020 17:41:25 -0500
Received: from 79.184.254.252.ipv4.supernova.orange.pl (79.184.254.252) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id e4bb8ae86d8915f1; Thu, 20 Feb 2020 23:41:22 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: Linux 5.6-rc2
Date:   Thu, 20 Feb 2020 23:41:22 +0100
Message-ID: <10791544.HYfhKnFLvn@kreacher>
In-Reply-To: <158197497594.2449.9692451182044632969@skylake-alporthouse-com>
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com> <CAHk-=wik6C7uCyPZ_qwv0M29uVUdgrpOdubfaVHF8FVBAsCivA@mail.gmail.com> <158197497594.2449.9692451182044632969@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, February 17, 2020 10:29:35 PM CET Chris Wilson wrote:
> Quoting Linus Torvalds (2020-02-17 21:20:27)
> > On Mon, Feb 17, 2020 at 8:22 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > >
> > > Quoting Linus Torvalds (2020-02-16 21:32:32)
> > > > Rafael J. Wysocki (4):
> > > >       ACPI: EC: Fix flushing of pending work
> > > >       ACPI: PM: s2idle: Avoid possible race related to the EC GPE
> > > >       ACPICA: Introduce acpi_any_gpe_status_set()
> > > >       ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system
> > >
> > > Our S0 testing broke on all platforms, so we've reverted
> > > e3728b50cd9b ("ACPI: PM: s2idle: Avoid possible race related to the EC GPE")
> > > fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system")
> > >
> > > There wasn't much in the logs, for example,
> > > https://intel-gfx-ci.01.org/tree/drm-tip/IGT_5445/fi-kbl-7500u/igt@gem_exec_suspend@basic-s0.html
> > 
> > So the machine suspends, but never comes back?
> > 
> > Do you need to revert both for it to work for you? Or is the revert of
> > fdde0ff8590b just to avoid the conflict?
> 
> fdde0ff85 was just to avoid conflicts.
>  
> > I'm assuming you bisected this, and the bisect indicated e3728b50cd9b,
> > and then to revert it you reverted the other commit too..
> 
> Lucky guess based on diff rc1..rc2. Bisect was going to be painful, but
> could be done if this is not enough clue for Rafael.

Sorry for the delayed response, was away.

I'm guessing that you are using rtcwake for wakeup, in which case reverting
fdde0ff85 alone should unbreak it.

Can you please double check that?



