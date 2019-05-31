Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C2A30EF8
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 15:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfEaNjB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 09:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfEaNjA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 May 2019 09:39:00 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF37C2133D;
        Fri, 31 May 2019 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559309940;
        bh=QejsJpJ1Xnpne98lLX4jJknIWWCbhoxePOTvB7gNbik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2DpJfcg9pfYTbU/2GXZr+pVR6QrKcy/SxJT9K74RqSRcrUqiy0DouKcIURLcqTko1
         7fuV4O9/u3a7R+tuQ+pocFsSHlNfHxWXThM8iAh6BxQ33YmqzQu0W7z0WcxZ1LPIB+
         LG8OeYRqgUIOEDZwYU5HWB/R53uXTa0o3tq7Z++U=
Date:   Fri, 31 May 2019 06:38:59 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chester Lin <clin@suse.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, jlee@suse.com, mhocko@suse.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ACPI / device_sysfs: Add eject show attr to monitor
 eject status
Message-ID: <20190531133859.GA18231@kroah.com>
References: <20190531065642.13254-1-clin@suse.com>
 <20190531065642.13254-4-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531065642.13254-4-clin@suse.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 31, 2019 at 02:56:42PM +0800, Chester Lin wrote:
> An acpi_eject_show attribute for users to monitor current status because
> sometimes it might take time to finish an ejection so we need to know
> whether it is still in progress or not.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  drivers/acpi/device_sysfs.c | 20 +++++++++++++++++++-
>  drivers/acpi/internal.h     |  1 +
>  drivers/acpi/scan.c         | 27 +++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 78c2653bf020..70b22eec6bbc 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -403,7 +403,25 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
>  	return status == AE_NO_MEMORY ? -ENOMEM : -EAGAIN;
>  }
>  
> -static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
> +static ssize_t acpi_eject_show(struct device *d,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct acpi_device *acpi_device = to_acpi_device(d);
> +	acpi_object_type not_used;
> +	acpi_status status;
> +
> +	if ((!acpi_device->handler || !acpi_device->handler->hotplug.enabled)
> +	    && !acpi_device->driver)
> +		return -ENODEV;
> +
> +	status = acpi_get_type(acpi_device->handle, &not_used);
> +	if (ACPI_FAILURE(status) || !acpi_device->flags.ejectable)
> +		return -ENODEV;
> +
> +	return sprintf(buf, "%s\n", acpi_eject_status_string(acpi_device));
> +}
> +
> +static DEVICE_ATTR(eject, 0644, acpi_eject_show, acpi_eject_store);

DEVICE_ATTR_RW()?

And you need to document the new sysfs file in Documentation/ABI/

thanks,

greg k-h
