Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E422942C915
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 20:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbhJMSwW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Oct 2021 14:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhJMSwU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Oct 2021 14:52:20 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58A6C061570;
        Wed, 13 Oct 2021 11:50:16 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id e63so5106495oif.8;
        Wed, 13 Oct 2021 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UX0pQd5EB9hBaMxcKbkdPZN6W778jFQOvy6XcoyXdmA=;
        b=CsZNfTS0H6bqaKt86EhVq5F8lwSdsQKpiAIWtZlpcWen1vh+0PtdR0uPFRncXop+oI
         wwLm1C2TrBp6QEhlZu6xINA4tYEHTvUnTm9PRLwWluiwzqTMiSC3vtywCROfky1Q615r
         A+9kVLXcBPwcwgk7VcfEV3bD4PKUqUHLBxHOZKrJ85LvoEbwbxYuIEBVSxVEN7PY/O0e
         Mh4XMbf4a0g6xFZ8JLOy68RJLlBcw1bnwqX1+dF5htTnKQBqxkkpclztj/Un12jX8y1M
         EnQjjFszPnmZULSv7+5xJ3UZfl2FbbX5Upadc0ssn/JC4yzetnW58ZjZIvCcgetZvNyF
         QOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UX0pQd5EB9hBaMxcKbkdPZN6W778jFQOvy6XcoyXdmA=;
        b=iSxiiDUbOG+AoSRDDv7oU0DS5io+qE5QCvcs98ImSHnpCwMHbxwN0WJZ5AaHqiFjmI
         fNqU5H5G+ERe/0fU1h3rbpuwJYcDn1zEPCSlbN4s9gvXbdryYSXybJw/QgZ2h2z7YHbS
         2/5PdFdUBfeMO+WXC36u3p28YE4KUUb0u+CqVoohiV1ZZlFeOvuMAic+3cTlRH34Pf1h
         2HyRgHMt8jhmZHV6TqPR3mh76ntcB7FGMhL3ohOAO+/3WJd9iVqe30h3BhL8sz05FrAk
         uwCicFK1EjYv3s3fznUAl0ci1tSN+/e9o1m3fM9nQqq5sBHiINuDVNT5I7ivko8qL/e+
         Gg3g==
X-Gm-Message-State: AOAM5309eGW7d22M0R0IyeEJwsiNF1vyUpgZ3D3i4VIHqTWp6P1rgHMH
        OfYENAH3Gnjb22PYMds8WgQ=
X-Google-Smtp-Source: ABdhPJzu6r85pn6XKHt5b0jAjLKH5NSurelcw1y2viMTEYGVbz4cTcKCyx1qk01BYHnRmmjZUobl3Q==
X-Received: by 2002:a54:4f1d:: with SMTP id e29mr9751963oiy.179.1634151016104;
        Wed, 13 Oct 2021 11:50:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e9sm73957otr.25.2021.10.13.11.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 11:50:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Oct 2021 11:50:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] hwmon: acpi_power_meter: Use
 acpi_bus_get_acpi_device()
Message-ID: <20211013185014.GA3336125@roeck-us.net>
References: <11864888.O9o76ZdvQC@kreacher>
 <11871063.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11871063.O9o76ZdvQC@kreacher>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 13, 2021 at 06:04:09PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.

Thanks,
Guenter

> ---
> 
> -> v2: Resend with a different From and S-o-b address and with R-by
>        from Andy.  No other changes.
> 
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
