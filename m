Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456BE44468E
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 18:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhKCRGp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 13:06:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:4580 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232969AbhKCRGp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Nov 2021 13:06:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="231500240"
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="231500240"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:01:51 -0700
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="489639049"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:01:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1miJdl-003K0F-Lr;
        Wed, 03 Nov 2021 19:01:33 +0200
Date:   Wed, 3 Nov 2021 19:01:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH 2/3] ACPI: Get acpi_device's parent from the parent field
Message-ID: <YYLAbVNARsDeJm61@smile.fi.intel.com>
References: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
 <20211103133406.659542-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103133406.659542-3-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 03, 2021 at 03:34:05PM +0200, Sakari Ailus wrote:
> Printk modifier %pfw is used to print the full path of the device name.
> This is obtained device by device until a device no longer has a parent.
> 
> On ACPI getting the parent fwnode is done by calling acpi_get_parent()
> which tries to down() a semaphore. But local IRQs are now disabled in
> vprintk_store() before the mutex is acquired. This is obviously a problem.
> 
> Luckily struct acpi_device has a parent field already. Use that field to
> get the parent instead of relying on acpi_get_parent().

I think the best if Rafael can confirm that we may use it like this.
If he approved, nothing would stop me to give you
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Fixes: 002eb6ad0751 ("printk: track/limit recursion")
> Cc: stable@vger.kernel.org # v5.15 and up
> Depends-on: ("ACPI: Make acpi_fwnode_handle safer")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index e312ebaed8db4..7403ee2816eb8 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1089,16 +1089,12 @@ struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode)
>  	if (is_acpi_data_node(fwnode)) {
>  		/* All data nodes have parent pointer so just return that */
>  		return to_acpi_data_node(fwnode)->parent;
> -	} else if (is_acpi_device_node(fwnode)) {
> -		acpi_handle handle, parent_handle;
> +	}
>  
> -		handle = to_acpi_device_node(fwnode)->handle;
> -		if (ACPI_SUCCESS(acpi_get_parent(handle, &parent_handle))) {
> -			struct acpi_device *adev;
> +	if (is_acpi_device_node(fwnode)) {
> +		struct acpi_device *device = to_acpi_device_node(fwnode);
>  
> -			if (!acpi_bus_get_device(parent_handle, &adev))
> -				return acpi_fwnode_handle(adev);
> -		}
> +		return acpi_fwnode_handle(device->parent);
>  	}
>  
>  	return NULL;
> -- 
> 2.30.2
> 
> 

-- 
With Best Regards,
Andy Shevchenko


