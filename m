Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28062F8D57
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Jan 2021 13:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbhAPMh7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Jan 2021 07:37:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbhAPMh6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 16 Jan 2021 07:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610800592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/hW3UDH3Mt+qMjiOhDxhyq+alcWmdFGAsYWy1szuU8=;
        b=iiyxwgUG9gKPwwifcizIRYziLkHqAC7jZJBC6VqU3huMb4jMzQP++WCKy9I4msimSfz3DI
        gJngZFOpkkMSEkV+dRmQYXyEgAJX8NC0TC0PIpBW5xmH1lA8jDpE8doqO0H6NcAC1iXnUj
        o0zMbEHCnGSX1uZ5H6CQEPAmXvktQcI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-Ac3TUgxhNQ6JBYh8-kzoTg-1; Sat, 16 Jan 2021 07:36:30 -0500
X-MC-Unique: Ac3TUgxhNQ6JBYh8-kzoTg-1
Received: by mail-ej1-f69.google.com with SMTP id q11so4346993ejd.0
        for <linux-acpi@vger.kernel.org>; Sat, 16 Jan 2021 04:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p/hW3UDH3Mt+qMjiOhDxhyq+alcWmdFGAsYWy1szuU8=;
        b=jioYi5uHaNpLL1YkReWEQ4VZxxFGvvpWt0uH4LmeBIwQyzW7zfLALIcUOaK1IeSX+/
         m5zNrj1X14T3ot1qaLTGlxG+X/fHL/EHu4ySXKsxHbqTatxscaoFp4m6ldC/e3raxmQT
         hMufbolZFWULhXqDfK0gwcw7e/xKfYy4r58x8klSTgSdYd/ir2qSh+2fJFiXy8gdmje7
         KHPEXpa4JTOfbKjf/xBkJvxZ/+fGlMW9mlmTR3sQIVPGIVtmcPW+OMzIqWLOh/zvbtk1
         JUuXeDXjwml/EWh9KhkY7+8RwSx8JHRe9YzKnfkW3YQ8mGp6OAjdYS2Tn/5l16tJivy8
         GsRg==
X-Gm-Message-State: AOAM532x4uGprc4LVB5YRu2KJaxW119McZfDpe7cw2/N/b/C5QVcZk17
        rxCiZTv2WDDhFjluc3BaTMRDpXMgU9Mk5bPhJQUrTYHg9Xszt0eMZF9Df2pXJdS3Z7RseUW/b2f
        JV70B37pRXhRtqEZnbkxt8g==
X-Received: by 2002:aa7:cd44:: with SMTP id v4mr13245287edw.156.1610800588967;
        Sat, 16 Jan 2021 04:36:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6sfd3skgtXMX3K0NcltTHfd1eDkWSBYRb5dIgmFvrNR1iPf56gxLl6J4bo+5TtlNTkGD6JQ==
X-Received: by 2002:aa7:cd44:: with SMTP id v4mr13245283edw.156.1610800588844;
        Sat, 16 Jan 2021 04:36:28 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id s4sm830187ejc.14.2021.01.16.04.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 04:36:28 -0800 (PST)
Subject: Re: [PATCH v1 2/2] ACPI: scan: Adjust white space in
 acpi_device_add()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <3494203.VBaj39JGmp@kreacher> <8659794.ROA1lt5W1e@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <42424760-6c02-7480-e38a-f1d66b447742@redhat.com>
Date:   Sat, 16 Jan 2021 13:36:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8659794.ROA1lt5W1e@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/14/21 7:47 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add empty lines in some places in acpi_device_add() to help
> readability and drop leading spaces before the labels in there.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/scan.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -692,10 +692,12 @@ int acpi_device_add(struct acpi_device *
>  
>  	if (device->wakeup.flags.valid)
>  		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
> +
>  	mutex_unlock(&acpi_device_lock);
>  
>  	if (device->parent)
>  		device->dev.parent = &device->parent->dev;
> +
>  	device->dev.bus = &acpi_bus_type;
>  	device->dev.release = release;
>  	result = device_add(&device->dev);
> @@ -711,16 +713,19 @@ int acpi_device_add(struct acpi_device *
>  
>  	return 0;
>  
> - err:
> +err:
>  	mutex_lock(&acpi_device_lock);
> +
>  	if (device->parent)
>  		list_del(&device->node);
> +
>  	list_del(&device->wakeup_list);
>  
> - err_unlock:
> +err_unlock:
>  	mutex_unlock(&acpi_device_lock);
>  
>  	acpi_detach_data(device->handle, acpi_scan_drop_device);
> +
>  	return result;
>  }
>  
> 
> 
> 

