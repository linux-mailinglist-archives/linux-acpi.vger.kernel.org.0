Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996493A9DD8
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 16:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhFPOni (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 10:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234064AbhFPOni (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 10:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623854491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bfIrh+PtaBgYpVTZkV0P8aItcFgfK/vLpnJFRGQ1gH8=;
        b=Usozt17A2h0cQGlRMmOE80v1SDHa3aS7JAhjgGTQyKtKUJ8JJQtdBlZS5+MzWIhUgx2G9E
        w6zPoktYcNWzft6DQiBPxlJdh9RCqxqGqyhPQJ2Zw0lMSDw1GuhFdb4tCPmFhXGLrYvopH
        gFIiJ5FBHSeu7atWgggfhv35o49duik=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-CsvWuKUdPJqfNij4pGh7rA-1; Wed, 16 Jun 2021 10:41:30 -0400
X-MC-Unique: CsvWuKUdPJqfNij4pGh7rA-1
Received: by mail-ej1-f72.google.com with SMTP id nd10-20020a170907628ab02903a324b229bfso1058344ejc.7
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 07:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bfIrh+PtaBgYpVTZkV0P8aItcFgfK/vLpnJFRGQ1gH8=;
        b=db0ao29P6cO3FSRVMwSRbQMKk2ZIAua8CW39Uebi5DqPX3+5RGHqEg7O1TeSF6u07C
         yrXt+v9ZAPHKzE+eZIdO8muGXqTEVQgJufFUYzGVIHsee5rAA8EdlgHoHW+/XUOdCuu3
         /zIz6VuRTwEMYmP9oh3B1Fw8SLPhesHsoa16gQb3qf3mTnpEvWkxB9+lXfw2N2gCgMXz
         kf7n+JTpTfykvlLktr0qXsP1ttwlcwF1ZlLT6H111VOQlm13AYM46thjAdSakaYsEfvx
         JyOu1R27g02JBkkSf9+tK+W9yMsF/lDOcRoLm1ApGE6H6oYGga6Jeq9AHSQn01ELok9d
         z/dw==
X-Gm-Message-State: AOAM533CCfWqcSKXxnA31ap8ZUTLB9ILzgvv49YQKDD8AmlpVbXf1bNz
        D81GZhNE0ZIhW7ht+XeOlNofcGbyhZQucUfVLlLZmxQ8IgC51d8dNKGwTZJ7ly08rJ8KD1nDn6O
        YOdnnl+KV2/gi8DhPJDHl2g==
X-Received: by 2002:a05:6402:40c3:: with SMTP id z3mr4640199edb.187.1623854488945;
        Wed, 16 Jun 2021 07:41:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8Kh3kRiNq6WrTKPSmty8tDUn0KpO37cQYGaBM8Rz57QbWzUN1RpAiuEKdLx5kEV/hkxh9lQ==
X-Received: by 2002:a05:6402:40c3:: with SMTP id z3mr4640191edb.187.1623854488849;
        Wed, 16 Jun 2021 07:41:28 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id c23sm1774183eds.57.2021.06.16.07.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:41:28 -0700 (PDT)
Subject: Re: [PATCH 2/5] ACPI: scan: Make acpi_walk_dep_device_list()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <3140195.44csPzL39Z@kreacher> <1881350.PYKUYFuaPT@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f46533e2-1ebe-0130-9323-b045da6ea62d@redhat.com>
Date:   Wed, 16 Jun 2021 16:41:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1881350.PYKUYFuaPT@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/16/21 4:22 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because acpi_walk_dep_device_list() is only called by the code in the
> file in which it is defined, make it static, drop the export of it
> and drop its header from acpi.h.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Actually, acpi_walk_dep_device_list() was split out as a
helper function used to implement acpi_dev_clear_dependencies()
because it will be used outside of drivers/acpi.
Specifically it will be used in the new intel_skl_int3472 driver:
https://patchwork.kernel.org/project/platform-driver-x86/patch/20210603224007.120560-6-djrscally@gmail.com/

Which I plan to merge into pdx86/for-next today, I've just merged
your linux-pm/acpi-scan PULL-req which exports acpi_walk_dep_device_list()
as preparation for this.

Regards,

Hans


> ---
>  drivers/acpi/scan.c  |    7 +++----
>  include/linux/acpi.h |    3 ---
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -2145,9 +2145,9 @@ static int acpi_scan_clear_dep(struct ac
>   * negative value is returned by the callback then the loop is broken and that
>   * value is returned as the final error.
>   */
> -int acpi_walk_dep_device_list(acpi_handle handle,
> -			      int (*callback)(struct acpi_dep_data *, void *),
> -			      void *data)
> +static int acpi_walk_dep_device_list(acpi_handle handle,
> +				int (*callback)(struct acpi_dep_data *, void *),
> +				void *data)
>  {
>  	struct acpi_dep_data *dep, *tmp;
>  	int ret = 0;
> @@ -2164,7 +2164,6 @@ int acpi_walk_dep_device_list(acpi_handl
>  
>  	return ret > 0 ? 0 : ret;
>  }
> -EXPORT_SYMBOL_GPL(acpi_walk_dep_device_list);
>  
>  /**
>   * acpi_dev_clear_dependencies - Inform consumers that the device is now active
> Index: linux-pm/include/linux/acpi.h
> ===================================================================
> --- linux-pm.orig/include/linux/acpi.h
> +++ linux-pm/include/linux/acpi.h
> @@ -668,9 +668,6 @@ extern bool acpi_driver_match_device(str
>  				     const struct device_driver *drv);
>  int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
>  int acpi_device_modalias(struct device *, char *, int);
> -int acpi_walk_dep_device_list(acpi_handle handle,
> -			      int (*callback)(struct acpi_dep_data *, void *),
> -			      void *data);
>  
>  struct platform_device *acpi_create_platform_device(struct acpi_device *,
>  						    struct property_entry *);
> 
> 
> 

