Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E30C250058
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Aug 2020 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgHXPE0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Aug 2020 11:04:26 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48593 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725947AbgHXPEW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2020 11:04:22 -0400
Received: (qmail 332615 invoked by uid 1000); 24 Aug 2020 11:04:21 -0400
Date:   Mon, 24 Aug 2020 11:04:21 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PM: sleep: core: Fix the handling of pending runtime
 resume requests
Message-ID: <20200824150421.GD329866@rowland.harvard.edu>
References: <7969920.MVx1BpXlEM@kreacher>
 <20200821193442.GA264863@rowland.harvard.edu>
 <4922509.6NPD9QEisq@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4922509.6NPD9QEisq@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 24, 2020 at 03:36:36PM +0200, Rafael J. Wysocki wrote:
> > Furthermore, by the logic used in this patch, the call to 
> > pm_wakeup_event() in the original code is also redundant: Any required 
> > wakeup event should have been generated when the runtime resume inside 
> > pm_runtime_barrer() was carried out.
> 
> It should be redundant in the real wakeup event cases, but it may cause
> spurious suspend aborts to occur when there are no real system wakeup
> events.
> 
> Actually, the original code is racy with respect to system wakeup events,
> because it depends on the exact time when the runtime-resume starts.  Namely,
> if it manages to start before the freezing of pm_wq, the wakeup will be lost
> unless the driver takes care of reporting it, which means that drivers really
> need to do that anyway.  And if they do that (which hopefully is the case), the
> pm_wakeup_event() call in the core may be dropped.

In other words, wakeup events are supposed to be reported at the time 
the wakeup request is first noticed, right?  We don't want to wait until 
a resume or runtime_resume callback runs; thanks to this race the 
callback might not run at all if the event isn't reported first.

Therefore the reasoning behind the original code appears to have been 
highly suspect.  If there already was a queued runtime-resume request 
for the device and the device was wakeup-enabled, the wakeup event 
should _already_ have been reported at the time the request was queued.  
And we shouldn't rely on it being reported by the runtime-resume 
callback routine.

> > This means that the code could be simplified to just:
> > 
> > 	pm_runtime_barrier(dev);
> 
> Yes, it could, so I'm going to re-spin the patch with this code simplification
> and updated changelog.
> 
> > Will this fix the reported bug?
> 
> I think so.

Okay, we'll see!

Alan Stern
