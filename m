Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D17E59CBD5
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 10:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfHZIns (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 04:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbfHZIns (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Aug 2019 04:43:48 -0400
Received: from localhost (unknown [89.205.128.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8116420874;
        Mon, 26 Aug 2019 08:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566809027;
        bh=SoiCkhhy2BGTuClWuO0Uof9RYEZj6b5kuPpkfAIcEvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4tmtlxmrs8D7VYSFvh5o/EBRUMgQ5zi3opE78smeRO1cQJXr+j+scwLjoduZodLa
         N3JjlG021XGeSdN4zIBZOQeBl73gX026ElPOtCSevkZjWH+oHztsihEM5RJZkReH79
         vIoO3EurUERF9mMN6qRggOTofkbSl4UdBMd5kE6I=
Date:   Mon, 26 Aug 2019 10:43:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ACPI: Enable driver and firmware hints to control
 power at probe time
Message-ID: <20190826084343.GA1095@kroah.com>
References: <20190826083112.8888-1-sakari.ailus@linux.intel.com>
 <20190826083112.8888-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826083112.8888-2-sakari.ailus@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 26, 2019 at 11:31:08AM +0300, Sakari Ailus wrote:
> Allow drivers and firmware tell ACPI that there's no need to power on a
> device for probe. This requires both a hint from the firmware as well as
> an indication from a driver to leave the device off.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/device_pm.c | 15 +++++++++++++--
>  include/linux/device.h   |  7 +++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index f616b16c1f0be..adcdf78ce4de8 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1276,7 +1276,12 @@ static void acpi_dev_pm_detach(struct device *dev, bool power_off)
>  	if (adev && dev->pm_domain == &acpi_general_pm_domain) {
>  		dev_pm_domain_set(dev, NULL);
>  		acpi_remove_pm_notifier(adev);
> -		if (power_off) {
> +		if (power_off
> +#ifdef CONFIG_PM
> +		    && !(dev->driver->probe_low_power &&
> +			 device_property_present(dev, "probe-low-power"))
> +#endif
> +			) {
>  			/*
>  			 * If the device's PM QoS resume latency limit or flags
>  			 * have been exposed to user space, they have to be
> @@ -1324,7 +1329,13 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  
>  	acpi_add_pm_notifier(adev, dev, acpi_pm_notify_work_func);
>  	dev_pm_domain_set(dev, &acpi_general_pm_domain);
> -	if (power_on) {
> +
> +	if (power_on
> +#ifdef CONFIG_PM
> +	    && !(dev->driver->probe_low_power &&
> +		 device_property_present(dev, "probe-low-power"))
> +#endif
> +		) {
>  		acpi_dev_pm_full_power(adev);
>  		acpi_device_wakeup_disable(adev);
>  	}
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 6717adee33f01..4bc0ea4a3201a 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -248,6 +248,12 @@ enum probe_type {
>   * @owner:	The module owner.
>   * @mod_name:	Used for built-in modules.
>   * @suppress_bind_attrs: Disables bind/unbind via sysfs.
> + * @probe_low_power: The driver supports its probe function being called while
> + *		     the device is in a low power state, independently of the
> + *		     expected behaviour on combination of a given bus and
> + *		     firmware interface etc. The driver is responsible for
> + *		     powering the device on using runtime PM in such case.
> + *		     This configuration has no effect if CONFIG_PM is disabled.
>   * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
>   * @of_match_table: The open firmware table.
>   * @acpi_match_table: The ACPI match table.
> @@ -285,6 +291,7 @@ struct device_driver {
>  	const char		*mod_name;	/* used for built-in modules */
>  
>  	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
> +	bool probe_low_power;

Ick, no, this should be a bus-specific thing to handle such messed up
hardware.  Why polute this in the driver core?

thanks,

greg k-h
