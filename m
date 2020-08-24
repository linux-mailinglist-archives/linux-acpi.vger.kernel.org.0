Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984F0250653
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Aug 2020 19:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgHXRbN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Aug 2020 13:31:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52580 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgHXRbF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2020 13:31:05 -0400
Received: from 89-64-88-199.dynamic.chello.pl (89.64.88.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id 9706e1a0a736e6e0; Mon, 24 Aug 2020 19:31:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PM: sleep: core: Fix the handling of pending runtime resume requests
Date:   Mon, 24 Aug 2020 19:31:01 +0200
Message-ID: <3393548.q2lFjJrsnI@kreacher>
In-Reply-To: <20200824150421.GD329866@rowland.harvard.edu>
References: <7969920.MVx1BpXlEM@kreacher> <4922509.6NPD9QEisq@kreacher> <20200824150421.GD329866@rowland.harvard.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, August 24, 2020 5:04:21 PM CEST Alan Stern wrote:
> On Mon, Aug 24, 2020 at 03:36:36PM +0200, Rafael J. Wysocki wrote:
> > > Furthermore, by the logic used in this patch, the call to 
> > > pm_wakeup_event() in the original code is also redundant: Any required 
> > > wakeup event should have been generated when the runtime resume inside 
> > > pm_runtime_barrer() was carried out.
> > 
> > It should be redundant in the real wakeup event cases, but it may cause
> > spurious suspend aborts to occur when there are no real system wakeup
> > events.
> > 
> > Actually, the original code is racy with respect to system wakeup events,
> > because it depends on the exact time when the runtime-resume starts.  Namely,
> > if it manages to start before the freezing of pm_wq, the wakeup will be lost
> > unless the driver takes care of reporting it, which means that drivers really
> > need to do that anyway.  And if they do that (which hopefully is the case), the
> > pm_wakeup_event() call in the core may be dropped.
> 
> In other words, wakeup events are supposed to be reported at the time 
> the wakeup request is first noticed, right?

That's correct.

> We don't want to wait until 
> a resume or runtime_resume callback runs; thanks to this race the 
> callback might not run at all if the event isn't reported first.

The callback will run, either through the wq or by the pm_runtime_barrier(),
but if it runs through the wq, pm_runtime_barrier() will return 0 and
pm_wakeup_event() will not called by the core, so it must be called from
elsewhere anyway.

> Therefore the reasoning behind the original code appears to have been 
> highly suspect.

Indeed.

> If there already was a queued runtime-resume request 
> for the device and the device was wakeup-enabled, the wakeup event 
> should _already_ have been reported at the time the request was queued.  
> And we shouldn't rely on it being reported by the runtime-resume 
> callback routine.

Right.

> > > This means that the code could be simplified to just:
> > > 
> > > 	pm_runtime_barrier(dev);
> > 
> > Yes, it could, so I'm going to re-spin the patch with this code simplification
> > and updated changelog.
> > 
> > > Will this fix the reported bug?
> > 
> > I think so.
> 
> Okay, we'll see!

Fair enough!




