Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2119CBDC
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 10:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfHZIqk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 04:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfHZIqk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Aug 2019 04:46:40 -0400
Received: from localhost (unknown [89.205.128.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 520E120874;
        Mon, 26 Aug 2019 08:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566809199;
        bh=HxmClbvsYCNqRbRpBGqwgs6sbMI2A0rgaodbfhNOdQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eE3HhSEYNYj/XIF4XYVUaw+OkbajpcUw1q0yTT0myQSXr990d24jsNz7yoSRarwHP
         +MqgoYNf0ytFXKJLDcKS2G68znZYPD3pVzxTuIJq+b1lxJ+2owmITfdOPCRBYJIbsF
         yf2fm5KCKfVj3RzcAcEAwkRcKdn/0HBEunvhfBgQ=
Date:   Mon, 26 Aug 2019 10:46:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ACPI: Enable driver and firmware hints to control
 power at probe time
Message-ID: <20190826084634.GB1095@kroah.com>
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

As proof of the "only a bus-specific thing", why is probe_low_power even
needed?  Why not just always trigger off of this crazy device_property?
That makes the driver changes less.

Also, is this #ifdef really needed?

thanks,

greg k-h
