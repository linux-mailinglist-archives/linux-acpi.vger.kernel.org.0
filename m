Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2CC42ACE2
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 21:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhJLTE3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 15:04:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:1838 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231756AbhJLTE2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Oct 2021 15:04:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="214189599"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="214189599"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 12:02:26 -0700
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="591882244"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 12:02:24 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1maN28-0003OA-BY;
        Tue, 12 Oct 2021 22:01:52 +0300
Date:   Tue, 12 Oct 2021 22:01:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: acpi_power_meter: Use acpi_bus_get_acpi_device()
Message-ID: <YWXboLaVc54MSQ8e@smile.fi.intel.com>
References: <11864888.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11864888.O9o76ZdvQC@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 12, 2021 at 07:30:40PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael@kernel.org>
> 
> In read_domain_devices(), acpi_bus_get_device() is called to obtain
> the ACPI device object attached to the given ACPI handle and
> subsequently that object is passed to get_device() for reference
> counting, but there is a window between the acpi_bus_get_device()
> and get_device() calls in which the ACPI device object in question
> may go away.
> 
> To address this issue, make read_domain_devices() use
> acpi_bus_get_acpi_device() to reference count and return the given
> ACPI device object in one go and export that function to modules.
> 
> While at it, also make read_domain_devices() and
> remove_domain_devices() use acpi_dev_put() instead of calling
> put_device() directly on the ACPI device objects returned by
> acpi_bus_get_acpi_device().

Good catch!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
> ---
>  drivers/acpi/scan.c              |    1 +
>  drivers/hwmon/acpi_power_meter.c |   13 +++++--------
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/hwmon/acpi_power_meter.c
> ===================================================================
> --- linux-pm.orig/drivers/hwmon/acpi_power_meter.c
> +++ linux-pm/drivers/hwmon/acpi_power_meter.c
> @@ -535,7 +535,7 @@ static void remove_domain_devices(struct
>  
>  		sysfs_remove_link(resource->holders_dir,
>  				  kobject_name(&obj->dev.kobj));
> -		put_device(&obj->dev);
> +		acpi_dev_put(obj);
>  	}
>  
>  	kfree(resource->domain_devices);
> @@ -597,18 +597,15 @@ static int read_domain_devices(struct ac
>  			continue;
>  
>  		/* Create a symlink to domain objects */
> -		resource->domain_devices[i] = NULL;
> -		if (acpi_bus_get_device(element->reference.handle,
> -					&resource->domain_devices[i]))
> +		obj = acpi_bus_get_acpi_device(element->reference.handle);
> +		resource->domain_devices[i] = obj;
> +		if (!obj)
>  			continue;
>  
> -		obj = resource->domain_devices[i];
> -		get_device(&obj->dev);
> -
>  		res = sysfs_create_link(resource->holders_dir, &obj->dev.kobj,
>  				      kobject_name(&obj->dev.kobj));
>  		if (res) {
> -			put_device(&obj->dev);
> +			acpi_dev_put(obj);
>  			resource->domain_devices[i] = NULL;
>  		}
>  	}
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -608,6 +608,7 @@ struct acpi_device *acpi_bus_get_acpi_de
>  {
>  	return handle_to_device(handle, get_acpi_device);
>  }
> +EXPORT_SYMBOL_GPL(acpi_bus_get_acpi_device);
>  
>  static struct acpi_device_bus_id *acpi_device_bus_id_match(const char *dev_id)
>  {
> 
> 
> 

-- 
With Best Regards,
Andy Shevchenko


