Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D4044AD67
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Nov 2021 13:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbhKIMWW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Nov 2021 07:22:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:10331 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235119AbhKIMWT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Nov 2021 07:22:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="232380380"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="232380380"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 04:19:32 -0800
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="669381656"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 04:19:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mkQ5q-0054vX-2U;
        Tue, 09 Nov 2021 14:19:14 +0200
Date:   Tue, 9 Nov 2021 14:19:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/2] ACPI: Get acpi_device's parent from the parent field
Message-ID: <YYpnQaZ7u9Zqr0Qb@smile.fi.intel.com>
References: <20211109111935.1627406-1-sakari.ailus@linux.intel.com>
 <20211109111935.1627406-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109111935.1627406-2-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 09, 2021 at 01:19:34PM +0200, Sakari Ailus wrote:
> Printk modifier %pfw is used to print the full path of the device name.
> This is obtained device by device until a device no longer has a parent.
> 
> On ACPI getting the parent fwnode is done by calling acpi_get_parent()
> which tries to down() a semaphore. But local IRQs are now disabled in
> vprintk_store() before the mutex is acquired. This is obviously a problem.
> 
> Luckily struct device, embedded in struct acpi_device, has a parent field
> already. Use that field to get the parent instead of relying on
> acpi_get_parent().

Thanks, with the below addressed
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 3bd32d6a2ee6 ("lib/vsprintf: Add %pfw conversion specifier for printing fwnode names")
> Cc: stable@vger.kernel.org # v5.5+
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index e312ebaed8db4..dc97711ba8081 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1089,16 +1089,14 @@ struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode)
>  	if (is_acpi_data_node(fwnode)) {
>  		/* All data nodes have parent pointer so just return that */
>  		return to_acpi_data_node(fwnode)->parent;

...

> -	} else if (is_acpi_device_node(fwnode)) {
> +	}

> +	if (is_acpi_device_node(fwnode)) {

Unneeded change. Yes I know that 'else' here can be skipped. But in such cases
it's a trade-off between changes, code readability and maintenance. Since here
it's a fix, backporting concerns are also play role.

> +		struct device *dev =
> +			to_acpi_device_node(fwnode)->dev.parent;

We are not so strict in terms of line length, code will be better
if this is located on one line.

> -			if (!acpi_bus_get_device(parent_handle, &adev))
> -				return acpi_fwnode_handle(adev);
> -		}
> +		if (dev)
> +			return acpi_fwnode_handle(to_acpi_device(dev));
>  	}
>  
>  	return NULL;
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


