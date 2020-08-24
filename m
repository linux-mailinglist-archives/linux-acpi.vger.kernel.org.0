Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D860824F84A
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Aug 2020 11:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgHXJ3M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Aug 2020 05:29:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:60120 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgHXIvC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Aug 2020 04:51:02 -0400
IronPort-SDR: vw7163l3gBejpmsPbYAHA1Hvsms0cy5vUs7WarctqQw1Isvqg+AT2z5Te0OWZzMxrYAmCSww6Y
 6kTRlOoqtFdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="156918464"
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="156918464"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 01:51:01 -0700
IronPort-SDR: Z/QlW50JtdUITuzynkBomeNe0c4gFDUznebeKbjj0IoTwNFJW5Tt9DqQKMyfwoTP3wgwM02tCd
 QoVhhZ+f5esg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="402253300"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 24 Aug 2020 01:50:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 24 Aug 2020 11:50:58 +0300
Date:   Mon, 24 Aug 2020 11:50:57 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: [PATCH] ACPI: OSL: Prevent acpi_release_memory() from returning
 too early
Message-ID: <20200824085057.GA189773@kuha.fi.intel.com>
References: <6142241.0H6QnnlUA7@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6142241.0H6QnnlUA7@kreacher>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 21, 2020 at 07:42:55PM +0200, Rafael J. Wysocki wrote:
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

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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

thanks,

-- 
heikki
