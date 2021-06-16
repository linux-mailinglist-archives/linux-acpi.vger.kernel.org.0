Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F30B3A9E47
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 16:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhFPO5c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 10:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234087AbhFPO53 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 10:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623855323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zlo+TNdj69SIJA6wlpGth2ifR1IG7cTh+D4ZtGuLTsA=;
        b=hEK5v0kU/oPwFwfqL1eOMNW+61zQxkLFCNpzViEXAfxWfVNC/AC5eE7ZC0JAFVyyH0IV58
        4ASysHrgkFUVGA2IsvXbMt91lGxnfgNj1pxv4Xb5OO7uCcJYMM1fNHL+lp79BOX4/4HIvL
        OnbBnNUHsAyv6cqZiuaqbEuogb5eiy4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-H5--dbZpO0uDyEZ4G597vg-1; Wed, 16 Jun 2021 10:55:21 -0400
X-MC-Unique: H5--dbZpO0uDyEZ4G597vg-1
Received: by mail-ej1-f72.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso1062058ejn.10
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 07:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zlo+TNdj69SIJA6wlpGth2ifR1IG7cTh+D4ZtGuLTsA=;
        b=mvNLKRnigH4QxbjLttAYAKeS8ZP93M/lgHUvmVZ3sfrT10d7uq67AQeIJMwm67C3We
         OJMSItGkqQ3yh2EiJrRdjMWg1MnVFgSFw8yf69ui8gtVcirUrRLk5LRJwl+maYKXFHBu
         VOcdyY/YDdISTeFBhifo83buCPe45Lk+qDkS2IWW5d4OCryIPSzMQvVVoExVqJM8uvmL
         s2aNJaXUAY58fNWkXRSnAXRGKise8ILUg7cUNWX59/ffaSrvuvmH5ejYKJZOVg+GZw0H
         sLHqlBZDw484k2or1NkoffCiVbU94gqrrr4OYk0Srkm6DrNl6//h2YV6/c4NtbcH2F+b
         o2OQ==
X-Gm-Message-State: AOAM530aHI88cji67TDm3oRipkOxoTSB0SSCfIHCirP9qvA3X8GQPzeB
        PzYdfDYECSrXxe3ZQqEmfxY5128T7EjQCZGFLsN/0BzZ2JJSRLaJ5mU7a/dMQw7TItq3VMb3EIC
        d8FumgHbrlZo1enttSziGag==
X-Received: by 2002:a05:6402:48f:: with SMTP id k15mr4685552edv.262.1623855320841;
        Wed, 16 Jun 2021 07:55:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFPkgyX+2E0YKE9oXzAUphybXdPVCD0BPG5AO7x15ZALerSniwpZ3BfIQzJyhADVjVyMan7A==
X-Received: by 2002:a05:6402:48f:: with SMTP id k15mr4685542edv.262.1623855320720;
        Wed, 16 Jun 2021 07:55:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q16sm2037279edt.26.2021.06.16.07.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:55:20 -0700 (PDT)
Subject: Re: [PATCH 5/5] ACPI: scan: Fix race related to dropping dependencies
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <3140195.44csPzL39Z@kreacher> <3070024.5fSG56mABF@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a691eab8-51bb-0965-9d17-63d438c43490@redhat.com>
Date:   Wed, 16 Jun 2021 16:55:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <3070024.5fSG56mABF@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/16/21 4:25 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If acpi_add_single_object() runs concurrently with respect to
> acpi_scan_clear_dep() which deletes a dependencies list entry where
> the device being added is the consumer, the device's dep_unmet
> counter may not be updated to reflect that change.
> 
> Namely, if the dependencies list entry is deleted right after
> calling acpi_scan_dep_init() and before calling acpi_device_add(),
> acpi_scan_clear_dep() will not find the device object corresponding
> to the consumer device ACPI handle and it will not update its
> dep_unmet counter to reflect the deletion of the list entry.
> Consequently, the dep_unmet counter of the device will never
> become zero going forward which may prevent it from being
> completely enumerated.
> 
> To address this problem, modify acpi_add_single_object() to run
> acpi_tie_acpi_dev(), to attach the ACPI device object created by it
> to the corresponding ACPI namespace node, under acpi_dep_list_lock
> along with acpi_scan_dep_init() whenever the latter is called.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/scan.c |   46 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 13 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -657,16 +657,12 @@ static int acpi_tie_acpi_dev(struct acpi
>  	return 0;
>  }
>  
> -int acpi_device_add(struct acpi_device *device,
> -		    void (*release)(struct device *))
> +int __acpi_device_add(struct acpi_device *device,
> +		      void (*release)(struct device *))
>  {
>  	struct acpi_device_bus_id *acpi_device_bus_id;
>  	int result;
>  
> -	result = acpi_tie_acpi_dev(device);
> -	if (result)
> -		return result;
> -
>  	/*
>  	 * Linkage
>  	 * -------
> @@ -755,6 +751,17 @@ err_unlock:
>  	return result;
>  }
>  
> +int acpi_device_add(struct acpi_device *adev, void (*release)(struct device *))
> +{
> +	int ret;
> +
> +	ret = acpi_tie_acpi_dev(adev);
> +	if (ret)
> +		return ret;
> +
> +	return __acpi_device_add(adev, release);
> +}
> +
>  /* --------------------------------------------------------------------------
>                                   Device Enumeration
>     -------------------------------------------------------------------------- */
> @@ -1681,14 +1688,10 @@ static void acpi_scan_dep_init(struct ac
>  {
>  	struct acpi_dep_data *dep;
>  
> -	mutex_lock(&acpi_dep_list_lock);
> -
>  	list_for_each_entry(dep, &acpi_dep_list, node) {
>  		if (dep->consumer == adev->handle)
>  			adev->dep_unmet++;
>  	}
> -
> -	mutex_unlock(&acpi_dep_list_lock);
>  }
>  
>  void acpi_device_add_finalize(struct acpi_device *device)
> @@ -1707,6 +1710,7 @@ static int acpi_add_single_object(struct
>  				  acpi_handle handle, int type, bool dep_init)
>  {
>  	struct acpi_device *device;
> +	bool release_dep_lock = false;
>  	int result;
>  
>  	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
> @@ -1720,16 +1724,32 @@ static int acpi_add_single_object(struct
>  	 * this must be done before the get power-/wakeup_dev-flags calls.
>  	 */
>  	if (type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_PROCESSOR) {
> -		if (dep_init)
> +		if (dep_init) {
> +			mutex_lock(&acpi_dep_list_lock);
> +			/*
> +			 * Hold the lock until the acpi_tie_acpi_dev() call
> +			 * below to prevent concurrent acpi_scan_clear_dep()
> +			 * from deleting a dependency list entry without
> +			 * updating dep_unmet for the device.
> +			 */
> +			release_dep_lock = true;
>  			acpi_scan_dep_init(device);
> -
> +		}
>  		acpi_scan_init_status(device);
>  	}
>  
>  	acpi_bus_get_power_flags(device);
>  	acpi_bus_get_wakeup_device_flags(device);
>  
> -	result = acpi_device_add(device, acpi_device_release);
> +	result = acpi_tie_acpi_dev(device);
> +
> +	if (release_dep_lock)
> +		mutex_unlock(&acpi_dep_list_lock);
> +
> +	if (result)

AFAICT you are missing a "acpi_device_release(&device->dev);"
call in the error-exit path here, causing a mem-leak.

Otherwise this looks good, with the above fixed this is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> +		return result;
> +
> +	result = __acpi_device_add(device, acpi_device_release);
>  	if (result) {
>  		acpi_device_release(&device->dev);
>  		return result;
> 
> 
> 

