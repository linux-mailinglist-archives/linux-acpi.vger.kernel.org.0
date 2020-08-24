Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE3F2509DD
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Aug 2020 22:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHXUPZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Aug 2020 16:15:25 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49557 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725963AbgHXUPZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2020 16:15:25 -0400
Received: (qmail 345315 invoked by uid 1000); 24 Aug 2020 16:15:24 -0400
Date:   Mon, 24 Aug 2020 16:15:24 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] PM: sleep: core: Fix the handling of pending runtime
 resume requests
Message-ID: <20200824201524.GB344424@rowland.harvard.edu>
References: <1954100.8R8RjBe1nF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1954100.8R8RjBe1nF@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 24, 2020 at 07:35:31PM +0200, Rafael J. Wysocki wrote:
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
> power resource "on" which in turn causes runtime-resume requests
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
> it is racy, because the device may be resuming already by the time
> the pm_runtime_barrier() runs and so if the driver doesn't take care
> of signaling the wakeup event as appropriate, it will be lost.
> However, if the driver does take care of that, the extra
> pm_wakeup_event() call in the core is redundant.
> 
> Accordingly, drop the conditional pm_wakeup_event() call fron
> __device_suspend() and make the latter call pm_runtime_barrier()
> alone.  Also modify the comment next to that call to reflect the new
> code and extend it to mention the need to avoid unwanted interactions
> between runtime PM and system-wide device suspend callbacks.
> 
> Fixes: 1e2ef05bb8cf8 ("PM: Limit race conditions between runtime PM and system sleep (v2)")
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2:
>    * Do not call pm_runtime_resume() if pm_runtime_barrier() returns 1,
>      because the device have been resumed by it already.
>    * Extend the comment next to the pm_runtime_barrier() call.
>    * Update the changelog in accordance with the above.
> 
> ---
>  drivers/base/power/main.c |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1606,13 +1606,17 @@ static int __device_suspend(struct devic
>  	}
>  
>  	/*
> -	 * If a device configured to wake up the system from sleep states
> -	 * has been suspended at run time and there's a resume request pending
> -	 * for it, this is equivalent to the device signaling wakeup, so the
> -	 * system suspend operation should be aborted.
> +	 * Wait for possible runtime PM transitions of the device in progress
> +	 * to complete and if there's a runtime resume request pending for it,
> +	 * resume it before proceeding with invoking the system-wide suspend
> +	 * callbacks for it.
> +	 *
> +	 * If the system-wide suspend callbacks below change the configuration
> +	 * of the device, they must disable runtime PM for it or otherwise
> +	 * ensure that its runtime-resume callbacks will not be confused by that
> +	 * change in case they are invoked going forward.
>  	 */
> -	if (pm_runtime_barrier(dev) && device_may_wakeup(dev))
> -		pm_wakeup_event(dev, 0);
> +	pm_runtime_barrier(dev);
>  
>  	if (pm_wakeup_pending()) {
>  		dev->power.direct_complete = false;

Acked-by: Alan Stern <stern@rowland.harvard.edu>
