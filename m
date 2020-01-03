Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E41C012F58F
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jan 2020 09:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgACIhc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Jan 2020 03:37:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgACIhc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Jan 2020 03:37:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D30A21D7D;
        Fri,  3 Jan 2020 08:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578040650;
        bh=ZD8qOsqQa8ANN+XuR2aHEzJsTu7jUSmoOLSeAscuNxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lF2DC8bJI6QgcSSmhWYXcKAGSXiyBrrOM8J1mcf8CMpuoax/rsdnmdkedynk1Bq8Z
         GSYjGH5vQzpsVo5Hnk9tQxZjnR66IAQv8YNHPQmmwgDkoMKZlZR2NNHjoPY/8G8Dgw
         l/rVlE4PKYRXvR02l7FCXZZ0bhipq6SKVie/Tca0=
Date:   Fri, 3 Jan 2020 09:37:28 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Chester Lin <clin@suse.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joey Lee <JLee@suse.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>
Subject: Re: [RFC PATCH v2 3/3] ACPI / device_sysfs: Add eject_show and add a
 cancel option in eject_store
Message-ID: <20200103083728.GB831558@kroah.com>
References: <20200103043926.31507-1-clin@suse.com>
 <20200103043926.31507-4-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103043926.31507-4-clin@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 03, 2020 at 04:40:17AM +0000, Chester Lin wrote:
> Add an eject_show attribute for users to monitor current status because
> sometimes it could take time to finish an ejection so we need to know
> whether it is still in progress or not. For userspace who might need to
> cancel an onging ejection, we also offer an option in eject_store.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-acpi |  9 ++-
>  drivers/acpi/device_sysfs.c              | 94 +++++++++++++++++++++---
>  drivers/acpi/internal.h                  |  4 +-
>  drivers/acpi/scan.c                      | 38 +++++++++-
>  4 files changed, 129 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
> index e7898cfe5fb1..32fdf4af962e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-acpi
> +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> @@ -53,9 +53,12 @@ What:		/sys/bus/acpi/devices/.../eject
>  Date:		December 2006
>  Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
>  Description:
> -		Writing 1 to this attribute will trigger hot removal of
> -		this device object.  This file exists for every device
> -		object that has _EJ0 method.
> +		(R) Allows users to read eject status of the device object.
> +		(W) Writing 1 to this attribute will trigger hot removal of
> +		this device object. Writing 2 to this attribute will cancel hot
> +		removal work if it's still in offline process and the original
> +		state of this device object will be recovered. This file exists
> +		for every device object that has _EJ0 method.

Oh that's going to cause problems :)

Why not just have a new file, "cancel_eject" that you can write to, to
cancel the eject happening?

That way you don't have an odd "state" that this file needs to keep
track of.

And what happens if you write a '2' here when eject is not happening?
It didn't look like your code handled that state well.

>  
>  What:		/sys/bus/acpi/devices/.../status
>  Date:		Jan, 2014
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 96869f1538b9..6801b268fe9d 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -365,17 +365,13 @@ static ssize_t power_state_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(power_state);
>  
> -static ssize_t
> -acpi_eject_store(struct device *d, struct device_attribute *attr,
> -		const char *buf, size_t count)
> +static ssize_t eject_show(struct device *d,
> +				struct device_attribute *attr, char *buf)
>  {
>  	struct acpi_device *acpi_device = to_acpi_device(d);
>  	acpi_object_type not_used;
>  	acpi_status status;
>  
> -	if (!count || buf[0] != '1')
> -		return -EINVAL;
> -
>  	if ((!acpi_device->handler || !acpi_device->handler->hotplug.enabled)
>  	    && !acpi_device->driver)
>  		return -ENODEV;
> @@ -384,18 +380,96 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
>  	if (ACPI_FAILURE(status) || !acpi_device->flags.ejectable)
>  		return -ENODEV;
>  
> +	return sprintf(buf, "%s\n", acpi_eject_status_string(acpi_device));
> +}
> +
> +static ssize_t
> +eject_store(struct device *d, struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct acpi_device *acpi_device = to_acpi_device(d);
> +	struct eject_data *eject_node = NULL;
> +	acpi_object_type not_used;
> +	acpi_status status;
> +	bool cancel_eject = false;
> +	ssize_t ret;
> +
> +	if (!count)
> +		return -EINVAL;
> +
> +	switch (buf[0]) {
> +	case '1':
> +		break;
> +	case '2':
> +		acpi_scan_lock_acquire();
> +		eject_node = (struct eject_data *)acpi_device->eject_stat;
> +
> +		if (!eject_node) {
> +			acpi_scan_lock_release();
> +			ret = -EINVAL;
> +			goto eject_end;
> +		}
> +
> +		/*
> +		 * Find a root to start cancellation from the top
> +		 */
> +		if (eject_node->base.root_handle) {
> +			acpi_device = acpi_bus_get_acpi_device(
> +					eject_node->base.root_handle);
> +
> +			if (acpi_device)
> +				eject_node =
> +				   (struct eject_data *)acpi_device->eject_stat;
> +			else
> +				eject_node = NULL;
> +
> +		}
> +
> +		if (eject_node &&
> +		   (eject_node->status == ACPI_EJECT_STATUS_GOING_OFFLINE ||
> +		    eject_node->status == ACPI_EJECT_STATUS_READY_REMOVE)) {
> +			eject_node->status = ACPI_EJECT_STATUS_CANCEL;
> +			cancel_eject = true;
> +		}
> +
> +		acpi_scan_lock_release();
> +		if (cancel_eject)
> +			break;
> +	default:
> +		ret = -EINVAL;
> +		goto eject_end;
> +	};
> +
> +	if ((!acpi_device->handler || !acpi_device->handler->hotplug.enabled)
> +	    && !acpi_device->driver) {
> +		ret = -ENODEV;
> +		goto eject_end;
> +	}
> +
> +	status = acpi_get_type(acpi_device->handle, &not_used);
> +	if (ACPI_FAILURE(status) || !acpi_device->flags.ejectable) {
> +		ret = -ENODEV;
> +		goto eject_end;
> +	}
> +
>  	get_device(&acpi_device->dev);
>  	status = acpi_hotplug_schedule(acpi_device, ACPI_OST_EC_OSPM_EJECT);
> -	if (ACPI_SUCCESS(status))
> -		return count;
> +	if (ACPI_SUCCESS(status)) {
> +		ret = count;
> +		goto eject_end;
> +	}
>  
>  	put_device(&acpi_device->dev);
>  	acpi_evaluate_ost(acpi_device->handle, ACPI_OST_EC_OSPM_EJECT,
>  			  ACPI_OST_SC_NON_SPECIFIC_FAILURE, NULL);
> -	return status == AE_NO_MEMORY ? -ENOMEM : -EAGAIN;
> +	ret = (status == AE_NO_MEMORY) ? -ENOMEM : -EAGAIN;
> +
> +eject_end:
> +	return ret;
> +
>  }
>  
> -static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
> +static DEVICE_ATTR_RW(eject);
>  
>  static ssize_t
>  acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *buf)
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 8154690b872b..e5d526402188 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -265,7 +265,8 @@ enum acpi_eject_status {
>  	ACPI_EJECT_STATUS_NONE = 0,
>  	ACPI_EJECT_STATUS_GOING_OFFLINE,
>  	ACPI_EJECT_STATUS_READY_REMOVE,
> -	ACPI_EJECT_STATUS_FAIL
> +	ACPI_EJECT_STATUS_FAIL,
> +	ACPI_EJECT_STATUS_CANCEL
>  };
>  
>  enum acpi_eject_node_type {
> @@ -286,5 +287,6 @@ struct eject_data {
>  };
>  
>  void acpi_eject_retry(struct acpi_device *adev);
> +char *acpi_eject_status_string(struct acpi_device *adev);
>  
>  #endif /* _ACPI_INTERNAL_H_ */
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 13f16b6ad7a2..90983c067410 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -366,8 +366,9 @@ static int acpi_scan_offline_check(struct acpi_device *device)
>  			return -EBUSY;
>  		}
>  
> -		if (eject_obj->status == ACPI_EJECT_STATUS_FAIL) {
> -			dev_warn(&device->dev, "Eject failed. Recover all.\n");
> +		if (eject_obj->status == ACPI_EJECT_STATUS_FAIL ||
> +		    eject_obj->status == ACPI_EJECT_STATUS_CANCEL) {
> +			dev_warn(&device->dev, "Eject stopped. Recover all.\n");
>  			acpi_scan_notify_online(device);
>  			return -EAGAIN;
>  		}
> @@ -383,6 +384,39 @@ static int acpi_scan_offline_check(struct acpi_device *device)
>  	return ret;
>  }
>  
> +char *acpi_eject_status_string(struct acpi_device *adev)
> +{
> +	struct eject_data *eject_obj;
> +	char *status_string = "none";
> +
> +	mutex_lock(&acpi_scan_lock);
> +	eject_obj = (struct eject_data *) adev->eject_stat;

Always use checkpatch.pl so maintainers don't have to ask you to use
checkpatch.pl :)

> +
> +	if (eject_obj) {
> +		switch (eject_obj->status) {
> +		case ACPI_EJECT_STATUS_NONE:
> +			break;
> +		case ACPI_EJECT_STATUS_GOING_OFFLINE:
> +			status_string = "going offline";
> +			break;
> +		case ACPI_EJECT_STATUS_READY_REMOVE:
> +			status_string = "ready to remove";
> +			break;
> +		case ACPI_EJECT_STATUS_FAIL:
> +			status_string = "failure";
> +			break;
> +		case ACPI_EJECT_STATUS_CANCEL:
> +			status_string = "cancel";
> +			break;
> +		default:
> +			status_string = "(unknown)";
> +		}
> +	}
> +
> +	mutex_unlock(&acpi_scan_lock);
> +	return status_string;

So the state can change right after checking it and reporting it to
userspace?

If so, what good is the lock here at all?


thanks,

greg k-h
