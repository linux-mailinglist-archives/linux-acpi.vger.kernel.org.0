Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF09DAB55
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 13:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409177AbfJQLiu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 07:38:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:28418 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406040AbfJQLiu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Oct 2019 07:38:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 04:38:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,307,1566889200"; 
   d="scan'208";a="186463726"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2019 04:38:48 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iL47D-0003er-Ji; Thu, 17 Oct 2019 14:38:47 +0300
Date:   Thu, 17 Oct 2019 14:38:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J . Wysocki " <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Ferry Toth <fntoth@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1] ACPI / platform: Unregister stale platform devices
Message-ID: <20191017113847.GM32742@smile.fi.intel.com>
References: <20190830143432.21695-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190830143432.21695-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 30, 2019 at 05:34:32PM +0300, Andy Shevchenko wrote:
> When the commit 68bdb6773289
> 
>   ("ACPI: add support for ACPI reconfiguration notifiers")
> 
> introduced reconfiguration notifiers it misses the point that the ACPI table,
> which may be loaded and then unloaded via ConfigFS, can contain devices that are
> not enumerated by their parents.
> 
> In such case the stale platform device is dangling in the system while the rest
> of the devices from the same table are already gone.
> 
> Introduce acpi_platform_device_remove_notify() notifier that, in similar way to
> I²C or SPI buses, unregisters the platform devices on table removal event.
> 

Rafael, all dependencies now in v5.4-rc1.
Can this be applied, or I need to do more work?

> Depends-on: 00500147cbd3 ("drivers: Introduce device lookup variants by ACPI_COMPANION device")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/acpi_platform.c | 43 ++++++++++++++++++++++++++++++++++++
>  drivers/acpi/scan.c          |  1 +
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 00ec4f2bf015..dfcd6210828e 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -31,6 +31,44 @@ static const struct acpi_device_id forbidden_id_list[] = {
>  	{"", 0},
>  };
>  
> +static struct platform_device *acpi_platform_device_find_by_adev(struct acpi_device *adev)
> +{
> +	struct device *dev;
> +
> +	dev = bus_find_device_by_acpi_dev(&platform_bus_type, adev);
> +	return dev ? to_platform_device(dev) : NULL;
> +}
> +
> +static int acpi_platform_device_remove_notify(struct notifier_block *nb,
> +					      unsigned long value, void *arg)
> +{
> +	struct acpi_device *adev = arg;
> +	struct platform_device *pdev;
> +
> +	switch (value) {
> +	case ACPI_RECONFIG_DEVICE_ADD:
> +		/* Nothing to do here */
> +		break;
> +	case ACPI_RECONFIG_DEVICE_REMOVE:
> +		if (!acpi_device_enumerated(adev))
> +			break;
> +
> +		pdev = acpi_platform_device_find_by_adev(adev);
> +		if (!pdev)
> +			break;
> +
> +		platform_device_unregister(pdev);
> +		put_device(&pdev->dev);
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block acpi_platform_notifier = {
> +	.notifier_call = acpi_platform_device_remove_notify,
> +};
> +
>  static void acpi_platform_fill_resource(struct acpi_device *adev,
>  	const struct resource *src, struct resource *dest)
>  {
> @@ -130,3 +168,8 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
>  	return pdev;
>  }
>  EXPORT_SYMBOL_GPL(acpi_create_platform_device);
> +
> +void __init acpi_platform_init(void)
> +{
> +	acpi_reconfig_notifier_register(&acpi_platform_notifier);
> +}
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index aad6be5c0af0..915650bf519f 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2174,6 +2174,7 @@ int __init acpi_scan_init(void)
>  	acpi_pci_root_init();
>  	acpi_pci_link_init();
>  	acpi_processor_init();
> +	acpi_platform_init();
>  	acpi_lpss_init();
>  	acpi_apd_init();
>  	acpi_cmos_rtc_init();
> -- 
> 2.23.0.rc1
> 

-- 
With Best Regards,
Andy Shevchenko


