Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161F22F8D56
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Jan 2021 13:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbhAPMh3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Jan 2021 07:37:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725979AbhAPMh1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 16 Jan 2021 07:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610800561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6CL2f9NEp42ITJ/vSqH/ItpzX3C+nG1NBVBUcbazFA=;
        b=Th2Rs4SkfxOLFG3FI+X0J72pDOH31vTmRBJrPAzXy7zoRS8wJAfG5XgNqkZvd03bdyZ1Fl
        40M9yW6QAXd9Lbr0uvw1vx7b6TxrhjkwdTXDoE+6gMbVoHO9sEGJQdOVpHooj/AaDujB0b
        vY9FvH7doEgXG2EAUOSpp293Go0qpTo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-Xi4H2ZrjPSmR3wSI_8TNOQ-1; Sat, 16 Jan 2021 07:35:59 -0500
X-MC-Unique: Xi4H2ZrjPSmR3wSI_8TNOQ-1
Received: by mail-ed1-f69.google.com with SMTP id n8so3327225edo.19
        for <linux-acpi@vger.kernel.org>; Sat, 16 Jan 2021 04:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k6CL2f9NEp42ITJ/vSqH/ItpzX3C+nG1NBVBUcbazFA=;
        b=lBwram1sLoJ8OUev5/UjPqliFSoqHuYoCAJBcO/k/2L47aEh615PuwyOZH9VfCvYQf
         38liaVQnYis63ffv/Ui67ed0lgVoviQspuahvkSFr5y9YoFz5xEkpb1Z3nECeYB8nZYr
         8GGl+/UaZDWB+Xm1PQD/C9VSlMA82zgQJSW20uYWnmaj9iM7noDZLYvS3HqFl7EJupqj
         QunZZLeO1grn9uGfEyFbPuf9LN7HNMq/3UPpTqnIVBCWhsJicx5cyLXLxTgSvfrV0VwB
         +Qsiy3JECUX7H3cv+c2gK+V7ZWxxr3RvVLc4tTjhuJYoIUfFkXvCH19FlNe1DG9+CXRW
         YNoA==
X-Gm-Message-State: AOAM533nt+4miMM4JR1uxf2MIZhnqPbA9lwQ8s0f9+jrL3j15woUVXID
        972U5s46Df9harLWts2H5t6piGp8+x1NNsiOSirZIguhH8G91ejEZy+/G4eUnrSL0UacHrwxfVT
        A0D2zydmwZrIEFSccIWRQbg==
X-Received: by 2002:a05:6402:268a:: with SMTP id w10mr12184830edd.331.1610800558266;
        Sat, 16 Jan 2021 04:35:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1rAzkYCc0m/oPD849C4KUDaWs0NHV3q0G6N3HCd/IhJ0pVO9PUsRwRfRxyRyYAqlg0pcMuQ==
X-Received: by 2002:a05:6402:268a:: with SMTP id w10mr12184824edd.331.1610800558090;
        Sat, 16 Jan 2021 04:35:58 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id j3sm6341773eja.2.2021.01.16.04.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 04:35:57 -0800 (PST)
Subject: Re: [PATCH v1 1/2] ACPI: scan: Rearrange memory allocation in
 acpi_device_add()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <3494203.VBaj39JGmp@kreacher> <2999734.9HhbEeWEHR@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8218eff4-6629-ac20-ec3f-a66aad445bb6@redhat.com>
Date:   Sat, 16 Jan 2021 13:35:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <2999734.9HhbEeWEHR@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/14/21 7:46 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The upfront allocation of new_bus_id is done to avoid allocating
> memory under acpi_device_lock, but it doesn't really help,
> because (1) it leads to many unnecessary memory allocations for
> _ADR devices, (2) kstrdup_const() is run under that lock anyway and
> (3) it complicates the code.
> 
> Rearrange acpi_device_add() to allocate memory for a new struct
> acpi_device_bus_id instance only when necessary, eliminate a redundant
> local variable from it and reduce the number of labels in there.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/scan.c |   57 +++++++++++++++++++++++-----------------------------
>  1 file changed, 26 insertions(+), 31 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -621,12 +621,23 @@ void acpi_bus_put_acpi_device(struct acp
>  	put_device(&adev->dev);
>  }
>  
> +static struct acpi_device_bus_id *acpi_device_bus_id_match(const char *dev_id)
> +{
> +	struct acpi_device_bus_id *acpi_device_bus_id;
> +
> +	/* Find suitable bus_id and instance number in acpi_bus_id_list. */
> +	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node) {
> +		if (!strcmp(acpi_device_bus_id->bus_id, dev_id))
> +			return acpi_device_bus_id;
> +	}
> +	return NULL;
> +}
> +
>  int acpi_device_add(struct acpi_device *device,
>  		    void (*release)(struct device *))
>  {
> +	struct acpi_device_bus_id *acpi_device_bus_id;
>  	int result;
> -	struct acpi_device_bus_id *acpi_device_bus_id, *new_bus_id;
> -	int found = 0;
>  
>  	if (device->handle) {
>  		acpi_status status;
> @@ -652,38 +663,26 @@ int acpi_device_add(struct acpi_device *
>  	INIT_LIST_HEAD(&device->del_list);
>  	mutex_init(&device->physical_node_lock);
>  
> -	new_bus_id = kzalloc(sizeof(struct acpi_device_bus_id), GFP_KERNEL);
> -	if (!new_bus_id) {
> -		pr_err(PREFIX "Memory allocation error\n");
> -		result = -ENOMEM;
> -		goto err_detach;
> -	}
> -
>  	mutex_lock(&acpi_device_lock);
> -	/*
> -	 * Find suitable bus_id and instance number in acpi_bus_id_list
> -	 * If failed, create one and link it into acpi_bus_id_list
> -	 */
> -	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node) {
> -		if (!strcmp(acpi_device_bus_id->bus_id,
> -			    acpi_device_hid(device))) {
> -			acpi_device_bus_id->instance_no++;
> -			found = 1;
> -			kfree(new_bus_id);
> -			break;
> +
> +	acpi_device_bus_id = acpi_device_bus_id_match(acpi_device_hid(device));
> +	if (acpi_device_bus_id) {
> +		acpi_device_bus_id->instance_no++;
> +	} else {
> +		acpi_device_bus_id = kzalloc(sizeof(*acpi_device_bus_id),
> +					     GFP_KERNEL);
> +		if (!acpi_device_bus_id) {
> +			result = -ENOMEM;
> +			goto err_unlock;
>  		}
> -	}
> -	if (!found) {
> -		acpi_device_bus_id = new_bus_id;
>  		acpi_device_bus_id->bus_id =
>  			kstrdup_const(acpi_device_hid(device), GFP_KERNEL);
>  		if (!acpi_device_bus_id->bus_id) {
> -			pr_err(PREFIX "Memory allocation error for bus id\n");
> +			kfree(acpi_device_bus_id);
>  			result = -ENOMEM;
> -			goto err_free_new_bus_id;
> +			goto err_unlock;
>  		}

When I have cases like this, where 2 mallocs are necessary I typically do it like this:

	const char *bus_id;

	...

	} else {
		acpi_device_bus_id = kzalloc(sizeof(*acpi_device_bus_id),
					     GFP_KERNEL);
		bus_id = kstrdup_const(acpi_device_hid(device), GFP_KERNEL);
		if (!acpi_device_bus_id || !bus_id) {
			kfree(acpi_device_bus_id);
			kfree(bus_id);
			result = -ENOMEM;
			goto err_unlock;
		}
		acpi_device_bus_id->bus_id = bus_id;
		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
	}

	...

So that there is only one if / 1 error-handling path for both mallocs.
I personally find this a bit cleaner.

Either way, with or without this change, the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

		
>  
> -		acpi_device_bus_id->instance_no = 0;
>  		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
>  	}
>  	dev_set_name(&device->dev, "%s:%02x", acpi_device_bus_id->bus_id, acpi_device_bus_id->instance_no);
> @@ -718,13 +717,9 @@ int acpi_device_add(struct acpi_device *
>  		list_del(&device->node);
>  	list_del(&device->wakeup_list);
>  
> - err_free_new_bus_id:
> -	if (!found)
> -		kfree(new_bus_id);
> -
> + err_unlock:
>  	mutex_unlock(&acpi_device_lock);
>  
> - err_detach:
>  	acpi_detach_data(device->handle, acpi_scan_drop_device);
>  	return result;
>  }
> 
> 
> 

