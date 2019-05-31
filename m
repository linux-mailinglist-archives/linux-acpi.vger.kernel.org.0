Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6315D30B38
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 11:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEaJRO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 05:17:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62375 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfEaJRO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 May 2019 05:17:14 -0400
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 737bcbf278445b37; Fri, 31 May 2019 11:17:10 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rajmohan.mani@intel.com,
        linux-media@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/5] ACPI: Enable driver and firmware hints to control power at probe time
Date:   Fri, 31 May 2019 11:17:10 +0200
Message-ID: <9700088.HJ6KcFTmRF@kreacher>
In-Reply-To: <20190510100930.14641-2-sakari.ailus@linux.intel.com>
References: <20190510100930.14641-1-sakari.ailus@linux.intel.com> <20190510100930.14641-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, May 10, 2019 12:09:26 PM CEST Sakari Ailus wrote:
> Allow drivers and firmware tell ACPI that there's no need to power on a
> device for probe. This requires both a hint from the firmware as well as
> an indication from a driver to leave the device off.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/device_pm.c | 9 +++++++--
>  include/linux/device.h   | 6 ++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index b859d75eaf9f6..ca2409a30d26d 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1225,7 +1225,9 @@ static void acpi_dev_pm_detach(struct device *dev, bool power_off)
>  	if (adev && dev->pm_domain == &acpi_general_pm_domain) {
>  		dev_pm_domain_set(dev, NULL);
>  		acpi_remove_pm_notifier(adev);
> -		if (power_off) {
> +		if (power_off &&
> +		    !(dev->driver->probe_powered_off &&
> +		      device_property_present(dev, "avoid-power-probe"))) {
>  			/*
>  			 * If the device's PM QoS resume latency limit or flags
>  			 * have been exposed to user space, they have to be
> @@ -1273,7 +1275,10 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  
>  	acpi_add_pm_notifier(adev, dev, acpi_pm_notify_work_func);
>  	dev_pm_domain_set(dev, &acpi_general_pm_domain);
> -	if (power_on) {
> +
> +	if (power_on &&
> +	    !(dev->driver->probe_powered_off &&
> +	      device_property_present(dev, "avoid-power-probe"))) {
>  		acpi_dev_pm_full_power(adev);
>  		acpi_device_wakeup_disable(adev);
>  	}
> diff --git a/include/linux/device.h b/include/linux/device.h
> index e85264fb66161..2a459fd5b954a 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -245,6 +245,11 @@ enum probe_type {
>   * @owner:	The module owner.
>   * @mod_name:	Used for built-in modules.
>   * @suppress_bind_attrs: Disables bind/unbind via sysfs.
> + * @probe_powered_off: The driver supports its probe function being called while
> + *		       the device is powered off, independently of the expected
> + *		       behaviour on combination of a given bus and firmware
> + *		       interface etc. The driver is responsible for powering the
> + *		       device on using runtime PM in such case.
>   * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
>   * @of_match_table: The open firmware table.
>   * @acpi_match_table: The ACPI match table.
> @@ -282,6 +287,7 @@ struct device_driver {
>  	const char		*mod_name;	/* used for built-in modules */
>  
>  	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
> +	bool probe_powered_off;

This is a bit of a misnomer IMO, because it is not just about devices that are completely off.
From the ACPI perspective that is about all devices not in D0, which may mean gated clocks
etc.

I would call it probe_low_power or similar and analogously in patch [2/5], and apart from this
I have no objections against this series, but I would suggest to CC the next iteration of it
to Greg K-H and the LKML as it touches the driver core.

>  	enum probe_type probe_type;
>  
>  	const struct of_device_id	*of_match_table;
> 




