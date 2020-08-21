Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635A524E0AE
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Aug 2020 21:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgHUTeo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Aug 2020 15:34:44 -0400
Received: from netrider.rowland.org ([192.131.102.5]:37845 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725992AbgHUTeo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Aug 2020 15:34:44 -0400
Received: (qmail 266418 invoked by uid 1000); 21 Aug 2020 15:34:42 -0400
Date:   Fri, 21 Aug 2020 15:34:42 -0400
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
Message-ID: <20200821193442.GA264863@rowland.harvard.edu>
References: <7969920.MVx1BpXlEM@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7969920.MVx1BpXlEM@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 21, 2020 at 07:41:02PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It has been reported that system-wide suspend may be aborted in the
> absence of any wakeup events due to unforseen interactions of it with
> the runtume PM framework.
> 
> One failing scenario is when there are multiple devices sharing an
> ACPI power resource and runtime-resume needs to be carried out for
> one of them during system-wide suspend (for example, because it needs
> to be reconfigured before the whole system goes to sleep).  In that
> case, the runtime-resume of that device involves turning the ACPI
> power resource "on" which in turn causes runtime resume requests
> to be queued up for all of the other devices sharing it.  Those
> requests go to the runtime PM workqueue which is frozen during
> system-wide suspend, so they are not actually taken care of until
> the resume of the whole system, but the pm_runtime_barrier()
> call in __device_suspend() sees them and triggers system wakeup
> events for them which then cause the system-wide suspend to be
> aborted if wakeup source objects are in active use.
> 
> Of course, the logic that leads to triggering those wakeup events is
> questionable in the first place, because clearly there are cases in
> which a pending runtime resume request for a device is not connected
> to any real wakeup events in any way (like the one above).  Moreover,
> if there is a pending runtime resume request for a device while
> __device_suspend() is running for it, the physical state of the
> device may not be in agreement with the "suspended" runtime PM status
> of it (which may be the very reason for queuing up the runtime resume
> request for it).
> 
> For these reasons, rework __device_suspend() to carry out synchronous
> runtime-resume for devices with pending runtime resume requests before
> attempting to invoke system-wide suspend callbacks for them with the
> expectation that their drivers will trigger system-wide wakeup events
> in the process of handling the runtime resume, if necessary.
> 
> Fixes: 1e2ef05bb8cf8 ("PM: Limit race conditions between runtime PM and system sleep (v2)")
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1606,13 +1606,13 @@ static int __device_suspend(struct devic
>  	}
>  
>  	/*
> -	 * If a device configured to wake up the system from sleep states
> -	 * has been suspended at run time and there's a resume request pending
> -	 * for it, this is equivalent to the device signaling wakeup, so the
> -	 * system suspend operation should be aborted.
> +	 * If there's a runtime resume request pending for the device, resume
> +	 * it before proceeding with invoking the system-wide suspend callbacks
> +	 * for it, because the physical state of the device may not reflect the
> +	 * "suspended" runtime PM status already in that case.
>  	 */
> -	if (pm_runtime_barrier(dev) && device_may_wakeup(dev))
> -		pm_wakeup_event(dev, 0);
> +	if (pm_runtime_barrier(dev))
> +		pm_runtime_resume(dev);

Is this really right?  Note that whenever pm_runtime_barrier() returns a 
nonzero value, it already calls rpm_resume(dev, 0).  So the 
pm_runtime_resume() call added here is redundant.

Furthermore, by the logic used in this patch, the call to 
pm_wakeup_event() in the original code is also redundant: Any required 
wakeup event should have been generated when the runtime resume inside 
pm_runtime_barrer() was carried out.  Removing a redundant function call 
can't fix a bug!

This means that the code could be simplified to just:

	pm_runtime_barrier(dev);

Will this fix the reported bug?  It seems likely to me that the actual 
problem with the failure scenario in the patch description was that 
turning on an ACPI power resource causes runtime-resume requests to be 
queued for all devices sharing that resource.  Wouldn't it make more 
sense to resume only the device that requested it and leave the others 
in runtime suspend?

Alan Stern
