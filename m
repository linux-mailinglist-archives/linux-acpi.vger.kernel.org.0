Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B945E19567C
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 12:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgC0Lis (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Mar 2020 07:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgC0Lis (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 07:38:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80F5E2072F;
        Fri, 27 Mar 2020 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585309125;
        bh=6j55oUEyG0KDLPPko2WYFMIs7IohgRyPrjnEzjPUQqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=luMimkNm/33xIz9Nd5ZEnm1mQX7meVYegqnwltskpch0XTALbQ6n0VPbFzzckAJ0C
         KiykhnkIdLdvJvCTRu6+NxBEwzKzmZAI6bYA6RVdLH+lD+O3kB01aiiYEwNFNFHqbL
         YpZadT3XOyCwTng4JsC0gpEJd3DdzIp8EN+cXC7Q=
Date:   Fri, 27 Mar 2020 12:38:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chester Lin <clin@suse.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org, jlee@suse.com,
        mhocko@suse.com
Subject: Re: [RFC PATCH 1/3] ACPI: scan: add userland notification while
 handling eject events
Message-ID: <20200327113842.GA1736848@kroah.com>
References: <20200327112247.17691-1-clin@suse.com>
 <20200327112247.17691-2-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327112247.17691-2-clin@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 27, 2020 at 07:22:45PM +0800, Chester Lin wrote:
> Add a request_offline attribute in order to tell the kernel if it's
> required to send notifications to userland first while handling an eject
> event. Userland will have to put the target device offline when this
> attribute is set.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-acpi | 16 ++++++++++
>  drivers/acpi/device_sysfs.c              | 40 +++++++++++++++++++++++-
>  drivers/acpi/scan.c                      | 39 +++++++++++++++++++----
>  include/acpi/acpi_bus.h                  |  1 +
>  4 files changed, 89 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
> index e7898cfe5fb1..b9c467704889 100644
> --- a/Documentation/ABI/testing/sysfs-bus-acpi
> +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> @@ -93,3 +93,19 @@ Description:
>  		hardware, if the _HRV control method is present.  It is mostly
>  		useful for non-PCI devices because lspci can list the hardware
>  		version for PCI devices.
> +
> +What:		/sys/bus/acpi/devices/.../request_offline
> +Date:		Mar, 2020
> +Contact:	Chester Lin <clin@suse.com>
> +Description:
> +		(RW) Allows the userland to receive offline requests when
> +		devices are planning to be ejected.
> +
> +		If bit [0] is clear, the kernel will automatically try putting
> +		the target offline before the target can be ejected.
> +
> +		If bit [0] is set, a uevent will be sent to userland as an
> +		offline request and userland is responsible for handling offline
> +		operations before the target can be ejected. This approach
> +		provides flexibility while some applications could need more
> +		time to release resources.

Don't use "bit", use 1/0/y/n/Y/N as the kernel will parse all of that
for you with the kstrtobool() which was created just for this type of
sysfs file.

> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 96869f1538b9..453bd1b9edf5 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -506,6 +506,37 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(status);
>  
> +static ssize_t request_offline_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> +
> +	return sprintf(buf, "%u\n", acpi_dev->request_offline?1:0);
> +}
> +
> +static ssize_t request_offline_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> +
> +	if (!count)
> +		return -EINVAL;
> +
> +	switch (buf[0]) {
> +	case '0':
> +		acpi_dev->request_offline = false;
> +		break;
> +	case '1':
> +		acpi_dev->request_offline = true;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(request_offline);
> +
>  /**
>   * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
>   * @dev: ACPI device object.
> @@ -580,6 +611,11 @@ int acpi_device_setup_files(struct acpi_device *dev)
>  		result = device_create_file(&dev->dev, &dev_attr_eject);
>  		if (result)
>  			return result;
> +
> +		result = device_create_file(&dev->dev,
> +					    &dev_attr_request_offline);
> +		if (result)
> +			return result;
>  	}
>  
>  	if (dev->flags.power_manageable) {
> @@ -623,8 +659,10 @@ void acpi_device_remove_files(struct acpi_device *dev)
>  	/*
>  	 * If device has _EJ0, remove 'eject' file.
>  	 */
> -	if (acpi_has_method(dev->handle, "_EJ0"))
> +	if (acpi_has_method(dev->handle, "_EJ0")) {
>  		device_remove_file(&dev->dev, &dev_attr_eject);
> +		device_remove_file(&dev->dev, &dev_attr_request_offline);

You all really should be using an attribute group and the is_visible()
callback to handle all of this for you automatically.

But that's a separate issue than this specific patch.

> +	}
>  
>  	if (acpi_has_method(dev->handle, "_SUN"))
>  		device_remove_file(&dev->dev, &dev_attr_sun);
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 6d3448895382..1cb39c5360cf 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -145,6 +145,7 @@ static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
>  	struct acpi_device_physical_node *pn;
>  	bool second_pass = (bool)data;
>  	acpi_status status = AE_OK;
> +	char *envp[] = { "EVENT=offline", NULL };
>  
>  	if (acpi_bus_get_device(handle, &device))
>  		return AE_OK;
> @@ -166,7 +167,18 @@ static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
>  		} else {
>  			pn->put_online = false;
>  		}
> -		ret = device_offline(pn->dev);
> +
> +		/* Don't offline directly but need to notify userland first */
> +		if (device->request_offline) {
> +			if (pn->dev->offline)
> +				ret = 0;
> +			else
> +				ret = kobject_uevent_env(&pn->dev->kobj,
> +							KOBJ_CHANGE, envp);

So this is a userspace visable change with regards to kobject events?

Are you sure that is ok?


