Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A520724DFE2
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Aug 2020 20:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgHUSpK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Aug 2020 14:45:10 -0400
Received: from l2mail1.panix.com ([166.84.1.75]:56142 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgHUSpJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Aug 2020 14:45:09 -0400
X-Greylist: delayed 970 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2020 14:45:09 EDT
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4BY95W0HJszDdc;
        Fri, 21 Aug 2020 14:29:02 -0400 (EDT)
Received: from xps-7390 (cpe-23-242-39-94.socal.res.rr.com [23.242.39.94])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4BY95Q1Z1Lz1XCR;
        Fri, 21 Aug 2020 14:28:58 -0400 (EDT)
Date:   Fri, 21 Aug 2020 11:28:57 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] ACPI: OSL: Prevent acpi_release_memory() from returning
 too early
In-Reply-To: <6142241.0H6QnnlUA7@kreacher>
Message-ID: <alpine.DEB.2.23.453.2008211126550.3596@xps-7390>
References: <6142241.0H6QnnlUA7@kreacher>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Works here for me:

----
$ l /sys/class/typec
total 0
10012 0 drwxr-xr-x  2 root root 0 Aug 21 11:25 ./
   10 0 drwxr-xr-x 67 root root 0 Aug 21 11:25 ../
27771 0 lrwxrwxrwx  1 root root 0 Aug 21 11:25 port0 -> ../../devices/platform/USBC000:00/typec/port0/
35601 0 lrwxrwxrwx  1 root root 0 Aug 21 11:25 port0-partner -> ../../devices/platform/USBC000:00/typec/port0/port0-partner/
36686 0 lrwxrwxrwx  1 root root 0 Aug 21 11:25 port1 -> ../../devices/platform/USBC000:00/typec/port1/
$
----

On Fri, 21 Aug 2020, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After commit 1757659d022b ("ACPI: OSL: Implement deferred unmapping
> of ACPI memory") in some cases acpi_release_memory() may return
> before the target memory mappings actually go away, because they
> are released asynchronously now.
>
> Prevent it from returning prematurely by making it wait for the next
> RCU grace period to elapse, for all of the RCU callbacks to complete
> and for all of the scheduled work items to be flushed before
> returning.
>
> Fixes: 1757659d022b ("ACPI: OSL: Implement deferred unmapping of ACPI memory")
> Reported-by: Kenneth R. Crudup <kenny@panix.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/osl.c |   19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/acpi/osl.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/osl.c
> +++ linux-pm/drivers/acpi/osl.c
> @@ -1575,11 +1575,26 @@ static acpi_status acpi_deactivate_mem_r
>  acpi_status acpi_release_memory(acpi_handle handle, struct resource *res,
>  				u32 level)
>  {
> +	acpi_status status;
> +
>  	if (!(res->flags & IORESOURCE_MEM))
>  		return AE_TYPE;
>
> -	return acpi_walk_namespace(ACPI_TYPE_REGION, handle, level,
> -				   acpi_deactivate_mem_region, NULL, res, NULL);
> +	status = acpi_walk_namespace(ACPI_TYPE_REGION, handle, level,
> +				     acpi_deactivate_mem_region, NULL,
> +				     res, NULL);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	/*
> +	 * Wait for all of the mappings queued up for removal by
> +	 * acpi_deactivate_mem_region() to actually go away.
> +	 */
> +	synchronize_rcu();
> +	rcu_barrier();
> +	flush_scheduled_work();
> +
> +	return AE_OK;
>  }
>  EXPORT_SYMBOL_GPL(acpi_release_memory);
>
>
>
>
>

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA
