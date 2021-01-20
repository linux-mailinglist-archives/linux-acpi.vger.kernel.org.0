Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317D92FDC95
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jan 2021 23:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbhATWZv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jan 2021 17:25:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388961AbhATVzD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Jan 2021 16:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611179617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qkj5MTn4PqAHlxRkP6Nm9pU0Bj533hacC35Vuu/cJN4=;
        b=KcHG3w07j0ScqoeXuZKudu7CqT3Utu9r2HB6yOn4A2k8dh+bshslfp7GWX0RKtT1lPyFGY
        oRJ0zrnkii8rwaB0aYvsSPUKW4iQbBLI+HotN5AsmDuul9GyOXvXiLNHgiugDiiM86uTjw
        VD9Tm1Et1jbY4kJVI9IHdwemMSzSq8o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-g8OH0cg5OwiPaRkCT-fZ9A-1; Wed, 20 Jan 2021 16:53:33 -0500
X-MC-Unique: g8OH0cg5OwiPaRkCT-fZ9A-1
Received: by mail-ej1-f72.google.com with SMTP id b18so14346ejz.6
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jan 2021 13:53:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qkj5MTn4PqAHlxRkP6Nm9pU0Bj533hacC35Vuu/cJN4=;
        b=UgepIgTK9jOk39WFkcIbCASxCVdXqGJDuj+ggVpZtU0P/aIE5XfdT3zWltNoZwnEg1
         Skgk2NShX/5Hu1axa1begUW1nlp3rz0u4PiFA5lyN3KFrmu3MQEAioozpCi1a7M77cMm
         hV61mY/XVRU0H/Md40TzhCcioS0+2uyNEvLsd63k5x6kh/Wn5Ztk0mgRtRWe+eP1KtZg
         3QDTZ1Pge8/1a5VpRJKB4WemROfH0XLCpXWDFFNpbxfSC+58tkKFZaGUC6efRGJmbjwW
         0qvhOoSo8zcd+rAlhUVlLNROjuF+yhhDCtx2bPlNYqMWXBBvpXwkG8YPi6OkRjop9JIE
         DfgQ==
X-Gm-Message-State: AOAM532QcT1ZSvpIVCZe0F36kNnZUTfNcPTC+OaeUlVHm03n5l19h1tG
        4ufzGan7H6Ip0f/7PK/8dbi0+P235LueCa1F41bQL5SN0u5aPAMwMeBgM/l0TOQuhH0+jdv/uxy
        LEZPNLUmx/wwRNbG9fGg5og==
X-Received: by 2002:a17:907:96a2:: with SMTP id hd34mr7649436ejc.494.1611179611844;
        Wed, 20 Jan 2021 13:53:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzI3lxgxiq/yVQUuFKTdqZdIG+IDBHyajT8lNqTn0fRfhXoFS1SjkyS+YoPp+jyqVVTfDye6w==
X-Received: by 2002:a17:907:96a2:: with SMTP id hd34mr7649432ejc.494.1611179611693;
        Wed, 20 Jan 2021 13:53:31 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id j18sm1410893ejv.18.2021.01.20.13.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 13:53:30 -0800 (PST)
Subject: Re: [PATCH] ACPI: scan: Rearrange code related to
 acpi_get_device_data()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <3445520.6OZ3MRzmT7@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d6dcb0cc-ff6a-3b71-55a2-d965cd8a290c@redhat.com>
Date:   Wed, 20 Jan 2021 22:53:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3445520.6OZ3MRzmT7@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/18/21 8:25 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are two callers of acpi_get_device_data(), acpi_bus_get_device()
> and acpi_bus_get_acpi_device(), but only one of them takes the int
> return value into account.  Moreover, the latter knows that it passes
> a valid return pointer to acpi_get_device_data() and it properly
> clears that pointer upfront, so it doesn't need acpi_get_device_data()
> to do that.
> 
> For this reason, rearrange acpi_get_device_data() to return a strct
> acpi_device pointer instead of an int and adapt its callers to that.
> 
> While at it, rename acpi_get_device_data() to handle_to_device(),
> because the old name does not really reflect the functionality
> provided by that function.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Nice cleanup, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> 
> On top of https://patchwork.kernel.org/project/linux-acpi/patch/20210115215752.389656-1-hdegoede@redhat.com/
> 
> ---
>  drivers/acpi/scan.c |   35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -578,29 +578,31 @@ static void acpi_scan_drop_device(acpi_h
>  	mutex_unlock(&acpi_device_del_lock);
>  }
>  
> -static int acpi_get_device_data(acpi_handle handle, struct acpi_device **device,
> -				void (*callback)(void *))
> +static struct acpi_device *handle_to_device(acpi_handle handle,
> +					    void (*callback)(void *))
>  {
> +	struct acpi_device *adev = NULL;
>  	acpi_status status;
>  
> -	if (!device)
> -		return -EINVAL;
> -
> -	*device = NULL;
> -
>  	status = acpi_get_data_full(handle, acpi_scan_drop_device,
> -				    (void **)device, callback);
> -	if (ACPI_FAILURE(status) || !*device) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No context for object [%p]\n",
> -				  handle));
> -		return -ENODEV;
> +				    (void **)&adev, callback);
> +	if (ACPI_FAILURE(status) || !adev) {
> +		acpi_handle_debug(handle, "No context!\n");
> +		return NULL;
>  	}
> -	return 0;
> +	return adev;
>  }
>  
>  int acpi_bus_get_device(acpi_handle handle, struct acpi_device **device)
>  {
> -	return acpi_get_device_data(handle, device, NULL);
> +	if (!device)
> +		return -EINVAL;
> +
> +	*device = handle_to_device(handle, NULL);
> +	if (!*device)
> +		return -ENODEV;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(acpi_bus_get_device);
>  
> @@ -612,10 +614,7 @@ static void get_acpi_device(void *dev)
>  
>  struct acpi_device *acpi_bus_get_acpi_device(acpi_handle handle)
>  {
> -	struct acpi_device *adev = NULL;
> -
> -	acpi_get_device_data(handle, &adev, get_acpi_device);
> -	return adev;
> +	return handle_to_device(handle, get_acpi_device);
>  }
>  
>  void acpi_bus_put_acpi_device(struct acpi_device *adev)
> 
> 
> 

