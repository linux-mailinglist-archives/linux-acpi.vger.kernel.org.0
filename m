Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255383A9DA3
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 16:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhFPOg0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 10:36:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:47891 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232825AbhFPOgZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 10:36:25 -0400
IronPort-SDR: QF86eVTRlR+06DYgw6YoctSOscaWH3qRbqE47NyXA6rGPVOHn1MEV37ITt0a2dU6Rvz85FKXVC
 zuLivUuMsdig==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="270035446"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="270035446"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 07:34:19 -0700
IronPort-SDR: GTtrZgJgvbiVg4EqJwYZTzTTck0akPpC367r27Lc4oQXA4MtunggWz8FBL31n0mAEaul4HE4ju
 7kDi/AQiGKpw==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="554823750"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 07:34:17 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ltWcR-002q9O-5r; Wed, 16 Jun 2021 17:34:15 +0300
Date:   Wed, 16 Jun 2021 17:34:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: scan: Define acpi_bus_put_acpi_device() as static
 inline
Message-ID: <YMoL5y1DHtGHoeuU@smile.fi.intel.com>
References: <2086739.irdbgypaU6@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2086739.irdbgypaU6@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 16, 2021 at 04:06:52PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since acpi_bus_put_acpi_device() is a synonym for acpi_dev_put(),
> define it as static inline in analogy with the latter.
> 
> No functional impact.

No objections, thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/scan.c     |    5 -----
>  include/acpi/acpi_bus.h |    9 +++++++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -608,11 +608,6 @@ struct acpi_device *acpi_bus_get_acpi_de
>  	return handle_to_device(handle, get_acpi_device);
>  }
>  
> -void acpi_bus_put_acpi_device(struct acpi_device *adev)
> -{
> -	acpi_dev_put(adev);
> -}
> -
>  static struct acpi_device_bus_id *acpi_device_bus_id_match(const char *dev_id)
>  {
>  	struct acpi_device_bus_id *acpi_device_bus_id;
> Index: linux-pm/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -504,8 +504,6 @@ extern int unregister_acpi_notifier(stru
>   */
>  
>  int acpi_bus_get_device(acpi_handle handle, struct acpi_device **device);
> -struct acpi_device *acpi_bus_get_acpi_device(acpi_handle handle);
> -void acpi_bus_put_acpi_device(struct acpi_device *adev);
>  acpi_status acpi_bus_get_status_handle(acpi_handle handle,
>  				       unsigned long long *sta);
>  int acpi_bus_get_status(struct acpi_device *device);
> @@ -726,6 +724,13 @@ static inline void acpi_dev_put(struct a
>  {
>  	put_device(&adev->dev);
>  }
> +
> +struct acpi_device *acpi_bus_get_acpi_device(acpi_handle handle);
> +
> +static inline void acpi_bus_put_acpi_device(struct acpi_device *adev)
> +{
> +	acpi_dev_put(adev);
> +}
>  #else	/* CONFIG_ACPI */
>  
>  static inline int register_acpi_bus_type(void *bus) { return 0; }
> 
> 
> 

-- 
With Best Regards,
Andy Shevchenko


